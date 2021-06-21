Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0B3AF61D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhFUT3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhFUT3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 15:29:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58023C061574;
        Mon, 21 Jun 2021 12:27:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b3so10659432wrm.6;
        Mon, 21 Jun 2021 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gxumujtIMVGxQ8b8M0nDK3P3y9XhOyqbI7nZJJwR5rw=;
        b=MmZIKo5V6ouqp0RHYmcd/8iQwuWvtFVyPT2t7H29B4bicRInl1U8FmGjtA6AL9Bs57
         LNry3C1N8Al1iXfgOLVkpMqc7TqaCSQDZoi6UgLynVx/Ke3hDxRTonQBSSS8JOCec4dG
         P/7nmT6bPOUAQKwOxlj64iCcDtZva+LluaDWuYIzYqFX/pDuR13/Yur8D/2J6hsnrHRP
         a9I/2FllrIJnMVRewPDDGx8oFN5YhMDPSV4BV2pZjR8fQfCgx+STIN2FjFOUMVN+v7rk
         tPcwtuEY1lCYp/UqIWGuwDR/ZZIL83fyrr081OH0b4/eAgmA12v7TpPLDD5nHgP1jGm1
         Jq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gxumujtIMVGxQ8b8M0nDK3P3y9XhOyqbI7nZJJwR5rw=;
        b=asMSa+DJdBz/zGPnxuCd9jLZRc4jes6znGzgnRiC7RovxfdYi0k2xfHY9NAuMLZMHR
         +xBu7YgOr3UHQrtmXunXzu2fHVtn+1T7C5VHp8L1h4hF4vwyD4wNI7XoNMuP9kGAQvw+
         qzmQ2QfXE0ih/3RMisphzZsNtCd/z1Lo5ZW+gH1yjOaOv42I9tDRjN8Hc9WK/wUcfv1z
         3thfPx3uVKS/SG34NxaINd6hYIECVLubwmHzDJe238VarV+B1s4/A2Kir83uXF/yE5NW
         i7w4gaClyChijicCQzTfuvSIv+Gs3neCBZ+acqPx2+ivTOFBrEcaV/urSqAy2kr7ydHy
         sdVQ==
X-Gm-Message-State: AOAM532dOqQXHYAG4cJlDr3WOa9de+3ZESvyU5RwrizWMenzKgLmfs2d
        p+ug738Mf2KxJ1HmnVi3NrA=
X-Google-Smtp-Source: ABdhPJyE30954Rxl2Lp4oQ3wjRp4Zp2ztVG33AFvYWVTp2+UdHXUyIfZomjLj76SSmw9rLjyr5sLhw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr10918414wrr.11.1624303641972;
        Mon, 21 Jun 2021 12:27:21 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id m67sm9207wmm.17.2021.06.21.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:27:21 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 21 Jun 2021 21:27:20 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH] PCI: PM: Do not read power state in
 pci_enable_device_flags()
Message-ID: <YNDoGICcg0V8HhpQ@eldamar.lan>
References: <3219454.74lMxhSOWB@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3219454.74lMxhSOWB@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Mar 16, 2021 at 04:51:40PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It should not be necessary to update the current_state field of
> struct pci_dev in pci_enable_device_flags() before calling
> do_pci_enable_device() for the device, because none of the
> code between that point and the pci_set_power_state() call in
> do_pci_enable_device() invoked later depends on it.
> 
> Moreover, doing that is actively harmful in some cases.  For example,
> if the given PCI device depends on an ACPI power resource whose _STA
> method initially returns 0 ("off"), but the config space of the PCI
> device is accessible and the power state retrieved from the
> PCI_PM_CTRL register is D0, the current_state field in the struct
> pci_dev representing that device will get out of sync with the
> power.state of its ACPI companion object and that will lead to
> power management issues going forward.
> 
> To avoid such issues it is better to leave the current_state value
> as is until it is changed to PCI_D0 by do_pci_enable_device() as
> appropriate.  However, the power state of the device is not changed
> to PCI_D0 if it is already enabled when pci_enable_device_flags()
> gets called for it, so update its current_state in that case, but
> use pci_update_current_state() covering platform PM too for that.
> 
> Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Max, I've added a T-by from you even though the patch is slightly different
> from what you have tested, but the difference shouldn't matter for your case.
> 
> ---
>  drivers/pci/pci.c |   16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1870,20 +1870,10 @@ static int pci_enable_device_flags(struc
>  	int err;
>  	int i, bars = 0;
>  
> -	/*
> -	 * Power state could be unknown at this point, either due to a fresh
> -	 * boot or a device removal call.  So get the current power state
> -	 * so that things like MSI message writing will behave as expected
> -	 * (e.g. if the device really is in D0 at enable time).
> -	 */
> -	if (dev->pm_cap) {
> -		u16 pmcsr;
> -		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> -	}
> -
> -	if (atomic_inc_return(&dev->enable_cnt) > 1)
> +	if (atomic_inc_return(&dev->enable_cnt) > 1) {
> +		pci_update_current_state(dev, dev->current_state);
>  		return 0;		/* already enabled */
> +	}
>  
>  	bridge = pci_upstream_bridge(dev);
>  	if (bridge)

A user in Debian reported that this commit caused an issue, cf.
https://bugs.debian.org/990008#10 with the e1000e driver failing to
probe the device. It was reported as well to
https://bugzilla.kernel.org/show_bug.cgi?id=213481

According to the above and
https://bugzilla.kernel.org/show_bug.cgi?id=213481#c2 reverting
4514d991d992 ("PCI: PM: Do not read power state in
pci_enable_device_flags()") fixes the issue.

Any idea what is going on here?

Regards,
Salvatore
