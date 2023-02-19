Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6969BE84
	for <lists+linux-pci@lfdr.de>; Sun, 19 Feb 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBSFM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Feb 2023 00:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSFM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Feb 2023 00:12:56 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF3CB762
        for <linux-pci@vger.kernel.org>; Sat, 18 Feb 2023 21:12:55 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5857C30008F0C;
        Sun, 19 Feb 2023 06:12:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4C98035CC5; Sun, 19 Feb 2023 06:12:54 +0100 (CET)
Date:   Sun, 19 Feb 2023 06:12:54 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Su <yang.su@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        shuo.tan@linux.alibaba.com
Subject: Re: [PATCH v2 3/3] PCI/DPC: Await readiness of secondary bus after
 reset
Message-ID: <20230219051254.GB12326@wunner.de>
References: <cover.1673769517.git.lukas@wunner.de>
 <9f5ff00e1593d8d9a4b452398b98aa14d23fca11.1673769517.git.lukas@wunner.de>
 <5d5ee171-18e5-f1b8-d08a-0d88f8eb3a3f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5ee171-18e5-f1b8-d08a-0d88f8eb3a3f@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 18, 2023 at 09:23:47PM +0800, Yang Su wrote:
> I do not understand why pci_bridge_wait_for_secondary_bus() can fix
> Intel's Ponte Vecchio HPC GPU after a DPC-induced Hot Reset.
> 
> The func pci_bridge_wait_for_secondary_bus() also use
> pcie_wait_for_link_delay() which time depends on the max device delay
> time of one bus, for the GPU which bus only one device, I think the
> time is 100ms as the input parater in pcie_wait_for_link_delay().
> 
> pcie_wait_for_link() also wait fixed 100ms and then wait the device data
> link is ready. So another wait time is pci_dev_wait() in your patch?
> pci_dev_wait() to receive the CRS from the device to check the device
> whether is ready.
> 
> Please help me understand which difference work.

The crucial difference is the invocation of pci_dev_wait(), which waits
up to 60 seconds for the device to come out of reset.

The spec allows 1 second but that may be extended via CRS.  Ponte Vecchio
has been witnessed to take more than 4 seconds in some cases, hence the
need to wait longer than 1 second.

Thanks,

Lukas
