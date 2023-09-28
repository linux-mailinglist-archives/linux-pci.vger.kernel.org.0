Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7B7B2881
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 00:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjI1Wgg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjI1Wgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 18:36:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E291A4
        for <linux-pci@vger.kernel.org>; Thu, 28 Sep 2023 15:36:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F6AC433C8;
        Thu, 28 Sep 2023 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695940592;
        bh=m6FirDPaq4GOJZVG2QDbio8VPlYSf/V7MMCjFBho74o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=syYisFGBk5IfE5NsFFWUJzdSZoRWz3su8CMuLwgZAVFYR35+2ju6qcBap21VuTN5w
         HkylG/MqZipbnFRi3FenZm9pZr6thvdAVPS0HvvsGlFoJMx8UVuFw97uEhqLhpoKMy
         +2PXn60IilZlkziz7vQb7et4dElrcu5og2Hg1jNa7ujX2qXyTKCy6Xbyri4deMBVFk
         i6AdQVsE6wljOmyxHmkQa9tdlGH44Qk52i27l7v9y9X43+Sp9QMGeH4GI1J/9bxTtU
         6O2SHEZfRY548GXBsxtYOb/5AcUEqfBB2Z3q6PYYRVUv2H2jlJwdqfAnM+tMKwGwaT
         edGt0WMkBaNMw==
Date:   Thu, 28 Sep 2023 17:36:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Message-ID: <20230928223630.GA507660@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 02:48:01PM +0200, Lukas Wunner wrote:
> struct pci_dev contains two flags which govern whether the device may
> suspend to D3cold:
> 
> * no_d3cold provides an opt-out for drivers (e.g. if a device is known
>   to not wake from D3cold)
> 
> * d3cold_allowed provides an opt-out for user space (default is true,
>   user space may set to false)
> 
> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
> the user space setting overwrites the driver setting.  Essentially user
> space is trusted to know better than the driver whether D3cold is
> working.
> 
> That feels unsafe and wrong.  Assume that the change was introduced
> inadvertently and do not overwrite no_d3cold when d3cold_allowed is
> modified.  Instead, consider d3cold_allowed in addition to no_d3cold
> when choosing a suspend state for the device.
> 
> That way, user space may opt out of D3cold if the driver hasn't, but it
> may no longer force an opt in if the driver has opted out.
> 
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.8+
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Mika and Mario, you both commented on this, but I *think* you were
both OK with it as-is for now?  If so, can you give a Reviewed-by?
I don't want to go ahead if you have any concerns.

Since we're touching this area, is there anything we can do to clarify
the comments?

        unsigned int    no_d3cold:1;    /* D3cold is forbidden */
        unsigned int    bridge_d3:1;    /* Allow D3 for bridge */
        unsigned int    d3cold_allowed:1;       /* D3cold is allowed by user */

These all have to do with D3, but:

  - For no_d3cold, "D3cold is forbidden" doesn't capture the notion
    that "driver knows the device doesn't wake from D3cold"

  - It's not clear whether "bridge_d3" applies to D3hot, D3cold, or
    both.

  - The computation of "bridge_d3" is ... complicated.  It depends on
    all the device/platform behavior assumptions in
    pci_bridge_d3_possible().  And *also* (I think) the user-space
    "d3cold_allowed" knob, via pci_dev_check_d3cold() in
    pci_bridge_d3_update().

    So it's kind of a mix of hardware characteristics and
    administrative controls.

Any comment updates could be a separate patch so as not to complicate
this one.

> @@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	int acpi_state, d_max;
>  
> -	if (pdev->no_d3cold)
> +	if (pdev->no_d3cold || !pdev->d3cold_allowed)

Haha, looks good.  Too bad the senses are opposite ("no_d3cold" and
"!d3cold_allowed"), but that's for another day.

>  		d_max = ACPI_STATE_D3_HOT;
>  	else
>  		d_max = ACPI_STATE_D3_COLD;
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ba38fc4..e18ccd2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -530,10 +530,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>  		return -EINVAL;
>  
>  	pdev->d3cold_allowed = !!val;
> -	if (pdev->d3cold_allowed)
> -		pci_d3cold_enable(pdev);
> -	else
> -		pci_d3cold_disable(pdev);
> +	pci_bridge_d3_update(pdev);

This is great.  D3 is still a tangle, but this is a significant
improvement.

>  	pm_runtime_resume(dev);

Bjorn
