Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3525A78A960
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 11:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjH1JzH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjH1Jyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 05:54:37 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDF91;
        Mon, 28 Aug 2023 02:54:32 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2789A2800B3E2;
        Mon, 28 Aug 2023 11:54:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 177F42F732C; Mon, 28 Aug 2023 11:54:29 +0200 (CEST)
Date:   Mon, 28 Aug 2023 11:54:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] PCI: Enable support for 10-bit Tag during device
 enumeration
Message-ID: <20230828095429.GA17864@wunner.de>
References: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230815212043.114913-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815212043.114913-3-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 09:20:42PM +0000, Smita Koralahalli wrote:
> +void pci_configure_ten_bit_tag(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge;
> +	u32 cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	bridge = dev->bus->self;
> +	if (!bridge)
> +		return;

I think you need to use bridge = pcie_find_root_port(dev) because
"dev" may be further down in the hierarchy with several switches
in-between it and the Root Port.

Note that pcie_find_root_port(dev) returns NULL if !pci_is_pcie(dev),
so the check above may become unnecessary.

If pcie_find_root_port(dev) == dev, then dev itself is a Root Port,
in which case you need to bail out.


> +	/*
> +	 * According to PCIe r6.0 sec 7.5.3.15, Requester Supported can only be
> +	 * set if 10-Bit Tag Completer Supported bit is set.
> +	 */
> +	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_COMP))
> +		goto out;
> +
> +	if (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ) {

Hm, if Requester Supported cannot be set unless Completer Supported is
also set, why check for Completer Supported at all?


> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2476,6 +2476,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_pm_init(dev);		/* Power Management */
>  	pci_vpd_init(dev);		/* Vital Product Data */
>  	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
> +	pci_configure_ten_bit_tag(dev); /* 10-bit Tag Requester */
>  	pci_iov_init(dev);		/* Single Root I/O Virtualization */
>  	pci_ats_init(dev);		/* Address Translation Services */
>  	pci_pri_init(dev);		/* Page Request Interface */

Hm, isn't this too late to disable 10-bit tags if a hot-plugged device
doesn't support it?  There are plenty of config space reads/writes
happening before pci_configure_ten_bit_tag() and if the Root Port
has 10-bit tags enabled by BIOS because a previously unplugged
device supported it, I assume the Root Port may use 10-bit tags for
those config space accesses, despite the newly hotplugged device not
supporting them?

If so, you may indeed have to unconditionally disable 10-bit tags
upon device removal and re-enable them once a 10-bit capable device
is hotplugged.

I'm wondering what happens if there are switches between the hotplugged
device and the Root Port.  In that case, there may be further devices
in the hierarchy below the Root Port.  I assume 10-bit tags can only be
enabled if *all* devices below the Root Port support them, is that correct?

The corollary would be that if there's an unoccupied hotplug port somewhere
in the hierarchy below a Root Port, 10-bit tags cannot be enabled at all
on the Root Port.  Maybe we can leave 10-bit tags enabled on hot-removal
and only disable them on hot-add?  That wouldn't work however if TLPs
are sent to the hot-added device without operating system involvement
prior to enumeration by the operating system.  Don't CXL devices
autonomously send PM messages upstream on hot-add?

There's another quagmire:  Endpoint devices may talk to each other via
p2pdma (see drivers/pci/p2pdma.c) and if either of them doesn't support
10-bit tags, we need to disable 10-bit tags on them upon commencing
p2pdma.  We may re-enable 10-bit tags once either of the devices is
hot-removed or p2pdma between them is stopped.

Finally, PCIe r6.0 added 14-bit tag support.  It may be worth adding
10-bit tag support in a way that 14-bit tag support can easily be added
later on (or is added together with 10-bit tag support).

Thanks,

Lukas
