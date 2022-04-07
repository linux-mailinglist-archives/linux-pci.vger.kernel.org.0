Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C2E4F840B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiDGPvP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbiDGPvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 11:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0ACC55B4;
        Thu,  7 Apr 2022 08:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C18B3B827BE;
        Thu,  7 Apr 2022 15:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30075C385A4;
        Thu,  7 Apr 2022 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346543;
        bh=e+alSzDzrc04Tz+Z+gKtvacXXhVH6XUBwWUSuj+9OLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Oc2N78jCjftJ6PIjmp5gY2ESvtysUuqCXzStvWEfEv1QqIpD74eYG+szMe/ayl6VV
         3inQ7HV6gKfAUY1Ws0V6gLvhykpmbviBaD0WVWtraPF0YJjlOY0eHNz8BtGINDzR9j
         VtjyrKIVb60+/UjKsW+J30OjL/NA63yXrs+ZuU6+Av+RrfuNPWhtxXZ1sj5sd48eME
         yp7TulI29pk7Lyhiq6ZjDV3Hsu//sFhYvGYR2puv91WWSEm4+52vFydk3XjtOeqvPG
         1YL7c4tQ7sHKzEISGYghvuuA7QC72CcCpor3BQWik6dics9aVNLxgkuzHCDQnUYfMk
         Nd+ecSrbzJM7w==
Date:   Thu, 7 Apr 2022 10:49:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: PM: Power up all devices during runtime resume
Message-ID: <20220407154901.GA239301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4412361.LvFx2qVVIh@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 06, 2022 at 09:00:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, endpoint devices may not be powered up entirely during
> runtime resume that follows a D3hot -> D0 transition of the parent
> bridge.
> 
> Namely, even if the power state of an endpoint device, as indicated
> by its PCI_PM_CTRL register, is D0 after powering up its parent
> bridge, it may be still necessary to bring its ACPI companion into
> D0 and that should be done before accessing it.  However, the current
> code assumes that reading the PCI_PM_CTRL register is sufficient to
> establish the endpoint device's power state, which may lead to
> problems.
> 
> Address that by forcing a power-up of all PCI devices, including the
> platform firmware part of it, during runtime resume.
> 
> Link: https://lore.kernel.org/linux-pm/11967527.O9o76ZdvQC@kreacher
> Fixes: 5775b843a619 ("PCI: Restore config space on runtime resume despite being unbound")
> Reported-by: Abhishek Sahu <abhsahu@nvidia.com>
> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied with Mika's reviewed-by to pci/pm for v5.19, thanks!

> ---
>  drivers/pci/pci-driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -1312,7 +1312,7 @@ static int pci_pm_runtime_resume(struct
>  	 * to a driver because although we left it in D0, it may have gone to
>  	 * D3cold when the bridge above it runtime suspended.
>  	 */
> -	pci_restore_standard_config(pci_dev);
> +	pci_pm_default_resume_early(pci_dev);
>  
>  	if (!pci_dev->driver)
>  		return 0;
> 
> 
> 
