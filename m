Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537B76EE05D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjDYKaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 06:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDYKaJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 06:30:09 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E4CC2A
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 03:30:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9B155100AF929;
        Tue, 25 Apr 2023 12:30:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6BBBCE2507; Tue, 25 Apr 2023 12:30:03 +0200 (CEST)
Date:   Tue, 25 Apr 2023 12:30:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus()
 wait time for slow links
Message-ID: <20230425103003.GA31913@wunner.de>
References: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425064751.24951-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 25, 2023 at 09:47:51AM +0300, Mika Westerberg wrote:
> With slow links (<= 5GT/s) active link reporting is not mandatory, so if
> a device is disconnected during system sleep we might end up waiting for
> it to respond for ~60s slowing down resume time. PCIe spec r6.0 sec
> 6.6.1 mandates that the system software must wait for at least 1s before
> it can determine the device as broken device so use the minimum
> requirement for slow links and bail out if we do not get reply within
> 1s. However, if the port supports active link reporting we can continue
> the wait following what we do with the fast links.
> 
> This should make system resume time faster for slow links as well while
> still following the PCIe spec.
> 
> While there move the PCI_RESET_WAIT constant into pci.c because it is
> not used outside of that file anymore.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

This completes the patches queued up on pci/reset for v6.4,
so would ideally be added to them (if at all possible at
this point in the cycle).

Thanks,

Lukas
