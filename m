Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F22CF760
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 00:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLDXSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 18:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDXSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 18:18:45 -0500
Date:   Fri, 4 Dec 2020 17:18:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607123885;
        bh=g7wuX88Zhhxoge1jkZR8ojn4kv8t8SuxTncSSpCyyLE=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=qQ5eitA2y74ZA6Nbi9Lzhbwx33jqcDd/6GksB/4xh3xGbl14tn1jPndUdf1Pn2v7T
         iNwxyoE16emim1SbXxSD98HcoyyrdBxOIWDJ76jJ/QK7iQLInPfz9EVqlLSR7NhmZF
         K2si7bhKys3xYLR2Lf92sZVhOxlusVGpt5cAR4F0z9Nhs3FUCD55lnI3i4GwUm2xsE
         ICHPN/zszaiJHg1Ko6S/0LIDQ/16uYLrD6Hy0q6otmXluyfMGF8ZCqxAxswDi68fg9
         q37BowT3qHXbjUHleqGq7rIUfeITv4IbRgRBkiIEcCN+TXyy5Ma7f9ChKXVoris96y
         wgZ2DQ1wQNVOA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/PM: Do not generate wakeup event when runtime
 resuming bus
Message-ID: <20201204231803.GA1980572@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125090733.77782-1-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 12:07:32PM +0300, Mika Westerberg wrote:
> When a PCI bridge is runtime resumed from D3cold the underlying bus is
> walked and the attached devices are runtime resumed as well. However, in
> addition to that we also generate a wakeup event for these devices even
> though this actually is not a real wakeup event coming from the
> hardware.
> 
> Normally this does not cause problems but when combined with
> /sys/power/wakeup_count like using the steps below:
> 
>   # count=$(cat /sys/power/wakeup_count)
>   # echo $count > /sys/power/wakeup_count
>   # echo mem > /sys/power/state
> 
> The system suspend cycle might fail at this point if a PCI bridge that
> was runtime suspended (D3cold) was runtime resumed for any reason. The
> runtime resume calls pci_wakeup_bus() and that generates wakeup event
> increasing wakeup_count.
> 
> Since this is not a real wakeup event we can prevent the above from
> happening by removing the call to pci_wakeup_event() in
> pci_wakeup_bus().
> 
> Reported-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I reversed the order of these since I think it's more obvious that
pci_wakeup_event() doesn't fit in pci_resume_one() and applied both to
pci/pm for v5.11, thanks!

> ---
> Previous version can be found here:
> 
>   https://www.spinics.net/lists/linux-pci/msg101083.html
> 
> Changes from the previous version:
> 
>   - Split the patch in two. The second patch only does the rename.
>   - Tried to improve the commit message a bit
>   - Added Rafael's reviewed-by tag
> 
>  drivers/pci/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..6f7b33998fbe 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1181,7 +1181,6 @@ EXPORT_SYMBOL_GPL(pci_platform_power_transition);
>   */
>  static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
>  {
> -	pci_wakeup_event(pci_dev);
>  	pm_request_resume(&pci_dev->dev);
>  	return 0;
>  }
> -- 
> 2.29.2
> 
