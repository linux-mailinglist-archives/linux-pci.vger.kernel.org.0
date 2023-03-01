Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BC06A67A3
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 07:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCAGb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 01:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCAGbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 01:31:55 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFFC37557
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 22:31:54 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 33EED102E0EA3;
        Wed,  1 Mar 2023 07:31:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 062FA10A68; Wed,  1 Mar 2023 07:31:52 +0100 (CET)
Date:   Wed, 1 Mar 2023 07:31:51 +0100
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
Subject: Re: [PATCH v2 2/3] PCI: Unify delay handling for reset and resume
Message-ID: <20230301063151.GA20326@wunner.de>
References: <cover.1673769517.git.lukas@wunner.de>
 <da77c92796b99ec568bd070cbe4725074a117038.1673769517.git.lukas@wunner.de>
 <9aec1d26-60c2-e251-4e8d-ed15bdc0bc7d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aec1d26-60c2-e251-4e8d-ed15bdc0bc7d@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 23, 2023 at 07:01:21PM +0800, Yang Su wrote:
> But in your patch the pci_bridge_wait_for_secondary_bus() we only check
> the first subordinate device of the bridge whether ready via
> pci_dev_wait().
> 
> Why not wait all the downstream devices become ready? As Sheng Bi
> Introduce pci_bridge_secondary_bus_wait() to fix 6b2f1351af56
> ("PCI: Wait for device to become ready after secondary bus reset"),
> using list_for_each_entry.
> 
> https://lore.kernel.org/linux-pci/20220523171517.32407-1-windy.bi.enflame@gmail.com/

At least for PCIe it shouldn't matter as the other pci_devs below
the bridge can only be additional functions of a multifunction
device.  My expectation would be that if the first function
is accessible, all the others are as well.

Checking for accessibility of all pci_devs introduces additional
complexity and I think should only be done if there are actual
real-world use cases that need it.


> Last, I want to know if all the downstrem devices are ready, how can we
> ensure pci bridge is ready?
> 
> From now version_2 series patch, there is lack checking of the pci bridge.

I don't quite follow.  The PCI bridge is the one whose secondary bus
was reset, right?  The PCI bridge's accessibility is unaffected by it
issuing a the Secondary Bus Reset.

Thanks,

Lukas
