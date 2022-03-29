Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31F4EB6DB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiC2XjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2XjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 19:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A78255AA;
        Tue, 29 Mar 2022 16:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1181160B11;
        Tue, 29 Mar 2022 23:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E49C2BBE4;
        Tue, 29 Mar 2022 23:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648597049;
        bh=nbKoFYsdORxKEDXbZtBkDSPgXdRIgnQcO7J9w7uEC4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dMrtu4Jjdz1NUlx5+Pu63lc1J2w6RiZhAtaGgnYNYUm2LNcqW3UgfcgSdEUzxdOpo
         CC4KBEfQlAKHZnsXgzsG+IeQiZ2PudgGxpp8i2u/fdar2SUw9xxFmL0UtB2Z5mfSdg
         Al8JX5+g8ZhUIEtfSGQZvMj2UrG3JBeGjsjoBVeCzdLp49VAYpo7jOOXt0MHtmA5iw
         swCI4OFW6oZ/eV6Kl/sq4SFMLhP9OiNyO/ra4h3ctO5aE4oCI0t6xSW0MYsLOh32fG
         isI7cFhpLmX2wulTdb4+0r7He9pME08MkoWAVCiR3HJbesXapOolA1YJdz9F+Xohcm
         zyIqX08pTEr0g==
Date:   Tue, 29 Mar 2022 18:37:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ren Yu <renyu@nfschina.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        yuzhe@nfschina.com
Subject: Re: [PATCH] pci: check the function request_region return value
Message-ID: <20220329233727.GA1644157@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329065602.262316-1-renyu@nfschina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 02:56:02PM +0800, Ren Yu wrote:
> When the function request_region return NULL,add a waring message

Check previous subject lines and make yours use the same style.

s/waring/warning/

> Signed-off-by: Ren Yu <renyu@nfschina.com>
> ---
>  drivers/pci/quirks.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index da829274fc66..27f9eb459051 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -584,8 +584,13 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
>  {
>  	pci_info(dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
>  	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
> -	request_region(0x3b0, 0x0C, "RadeonIGP");
> -	request_region(0x3d3, 0x01, "RadeonIGP");
> +	if (!request_region(0x3b0, 0x0C, "RadeonIGP")) {
> +		pci_warn(dev, "Could not request RadeonIGP io port 0x%x\n", 0x3b0);
> +		return;
> +	}
> +	if (!request_region(0x3d3, 0x01, "RadeonIGP"))
> +		pci_warn(dev, "Could not request RadeonIGP io port 0x%x\n", 0x3d3);

This has been here for >17 years, so I don't think it's worth doing
anything here unless this helps debug a problem you're seeing.

> +
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
>  
> -- 
> 2.25.1
> 
