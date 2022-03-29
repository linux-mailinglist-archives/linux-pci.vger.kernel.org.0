Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD924EB6EE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 01:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiC2XoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 19:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiC2XoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 19:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA411B9FF0;
        Tue, 29 Mar 2022 16:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3425E60B87;
        Tue, 29 Mar 2022 23:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6581DC2BBE4;
        Tue, 29 Mar 2022 23:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648597348;
        bh=MrHQhXwSYe7wuAHoXwri9dn/u2Jxc+Bw4MgcH442JPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t7nynPXr3AKbk+DCnktnM7nDlmDBbRTYkxFvRwyWZ+iVZHrse9TZionGhzih+r3DH
         PaSwYv/l8bMP3/3pKzkGeNpPiDQMy3pxqiX2QfoFKn0WF49Q1vq11tBXVfpNXa73GF
         D0J7vXLN0N3iH6Zob8WZ3qrXrxa8oCnWrjSvwlorsainfLQU34uEzOPK6HZViS8JmC
         Q82CYak5bw7dxLxeHzFTWK7/ilItDNFEVmVv4/FLNAtfLQx4m5GBCVPBzhSgMtg+KO
         1B/1i4E8PoH8RpodaUc4AmyUD58jjpvMDJGiHqJLYiKq1qiJRArOcdlOwm29N88oRB
         49bZ96tKeYggw==
Date:   Tue, 29 Mar 2022 18:42:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V3 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220329234226.GA1644397@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329104321.4712-2-shlomop@pliops.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please update the subject line to match the style of previous ones.

On Tue, Mar 29, 2022 at 01:43:21PM +0300, Shlomo Pongratz wrote:
> On commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")
> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> 
> The Intel devices 2030, 2031, 2032 and 2033 which are ports A, B, C and D,
> and if all exist they will occupy slots 0 till 3 in that order.
> 
> Now if for example device 2030 is missing then there will no device on slot 0, but
> other devices can reside on other slots according to there port.
> For this reason the test that insisted that the bridge should be on slot 0 was modified
> to support bridges that are not on slot 0.

I can't really parse the above, but "there port" is surely incorrect.

Wrap the commit log to fit in 80 columns like previous commits.

> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> ---
>  drivers/pci/p2pdma.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 30b1df3c9d2f..c088d4ab64f4 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -307,6 +307,7 @@ static const struct pci_p2pdma_whitelist_entry {
>  	unsigned short device;
>  	enum {
>  		REQ_SAME_HOST_BRIDGE	= 1 << 0,
> +		IS_ROOT_PORT		= 1 << 1,
>  	} flags;
>  } pci_p2pdma_whitelist[] = {
>  	/* Intel Xeon E5/Core i7 */
> @@ -316,15 +317,38 @@ static const struct pci_p2pdma_whitelist_entry {
>  	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
>  	/* Intel SkyLake-E */
> -	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
> -	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
> +	{PCI_VENDOR_ID_INTEL,	0x2030, IS_ROOT_PORT},
> +	{PCI_VENDOR_ID_INTEL,	0x2031, IS_ROOT_PORT},
> +	{PCI_VENDOR_ID_INTEL,	0x2032, IS_ROOT_PORT},
> +	{PCI_VENDOR_ID_INTEL,	0x2033, IS_ROOT_PORT},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
>  	{}
>  };
>  
> +/*
> + * The functionality of thisunction can be integrated into
> + * __host_bridge_whitelist function but this will make the code
> + * less readable
> + */

Comment seems probably unnecessary, but "thisunction" is wrong.

> +static bool pci_is_root_port(struct pci_dev *root)
> +{
> +	const struct pci_p2pdma_whitelist_entry *entry;
> +	unsigned short vendor, device;
> +
> +	vendor = root->vendor;
> +	device = root->device;
> +
> +	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
> +		if (vendor != entry->vendor || device != entry->device)
> +			continue;
> +
> +		if (entry->flags & IS_ROOT_PORT)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /*
>   * This lookup function tries to find the PCI device corresponding to a given
>   * host bridge.
> @@ -333,6 +357,11 @@ static const struct pci_p2pdma_whitelist_entry {
>   * bus->devices list and that the devfn is 00.0. These assumptions should hold
>   * for all the devices in the whitelist above.
>   *
> + * The method above will work in most cases but not for all.
> + * Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
> + * Consider on a bus X only port C has devices connected to it so in the PCI scan only
> + * device 8086:2032 on 0000:X:02.0 will be found as bridges with no children are ignored

Wrap to 80 columns.

Apparently there's something super special about Sky Lake?  Whatever
it is that's special needs to be explained somewhere.

> + *
>   * This function is equivalent to pci_get_slot(host->bus, 0), however it does
>   * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
>   * sleep.
> @@ -350,7 +379,9 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>  
>  	if (!root)
>  		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> +
> +	/* Intel Sky Lake-E host root ports can be on no zero slot */
> +	if (root->devfn != PCI_DEVFN(0, 0) && !pci_is_root_port(root))
>  		return NULL;
>  
>  	return root;
> @@ -372,6 +403,7 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>  		if (vendor != entry->vendor || device != entry->device)
>  			continue;
> +
>  		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
>  			return false;
>  
> -- 
> 2.17.1
> 
