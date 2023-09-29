Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17207B3CBB
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjI2Wsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 18:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Wsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 18:48:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388261B4
        for <linux-pci@vger.kernel.org>; Fri, 29 Sep 2023 15:48:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04A5C433C8;
        Fri, 29 Sep 2023 22:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696027707;
        bh=LTdeKaEfByvbWI/bXUM/E65QTLw+Od1Li/G8s5MJgBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u21Z2Uiv0CTbVaqtVLJ9LgzGnVVQL09szyqbQqxrMUhkYEzYhFa3l3UCuWZbplSXL
         xV5m/OPSd550s0TY2jkjBtNWFLSTyy7XmcgXOhKmEsrg+3ElvprnXj80YuRmpRsMxB
         MRQ87dzxWX7h0HVAo6LlAA2t8jALF4Adj3JRoqSFpKZqen7K5ZZci7iilCe9CLixws
         LfEe/sW2hGXwNd1xdy3vP4ghdr12VOX+JPpjUPJqFl4sBfFnpE4v1TSV0jWdGYpJ04
         xMUOGNnEZytnSBZggF7Da6gTXJ/u4JxCIAyH3ItboF273MlMZtTWxYPakEyv+f3xdV
         Uczk/UKjDw00g==
Date:   Fri, 29 Sep 2023 17:48:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Message-ID: <20230929224825.GA559886@bhelgaas>
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

Applied with Reviewed-by from Mika and Mario to pci/pm for v6.7,
thanks!

> ---
>  drivers/pci/pci-acpi.c  | 2 +-
>  drivers/pci/pci-sysfs.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 7aa1c20..2f5eddf 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	int acpi_state, d_max;
>  
> -	if (pdev->no_d3cold)
> +	if (pdev->no_d3cold || !pdev->d3cold_allowed)
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
>  
>  	pm_runtime_resume(dev);
>  
> -- 
> 2.39.2
> 
