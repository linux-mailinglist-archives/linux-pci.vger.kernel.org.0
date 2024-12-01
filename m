Return-Path: <linux-pci+bounces-17500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A27C9DF4FB
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5DC2811B2
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC87E111;
	Sun,  1 Dec 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsKDX1f2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543850285
	for <linux-pci@vger.kernel.org>; Sun,  1 Dec 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733041369; cv=none; b=mSg06IbKv/W7q3ZFh9Hvalgzf09a4R2iZT1Y7xDUYczbNySE/1oUMEc2ozDIk3NizzlBCZSPtX3Cl5aTpIU93/3yudrEn9inUkgo9lpWCSr5u3GZksTkO3gpULxFd42kYG2ASpleZzfvnAKp4oMJ6CLLV6LuTMolk5fpiadKpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733041369; c=relaxed/simple;
	bh=2S/rVLWEwIONh0D1Q8TMjbF1ysuLJhM1eL32ANC4cc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+rzacU2vgonkBqpQyM77KgSu49c3yj0nAok+xj1nNaGeakjYi5+vw1GRCW+cf+2GipYX+EEG4hDj0pa0RZ+4kVMmL5fyU8c0U6ElwftYBIvhRZPmTY/08j8m84UK9kU9AtvaR0/wFqLIiGrYzmLPglVPR4VWlNlaxIVLSPsegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HsKDX1f2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21577f65bdeso2050355ad.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Dec 2024 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733041366; x=1733646166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OXE8F87IXfgmPdHHoIKU4/adT6aGKEI1TLuvAyyPv84=;
        b=HsKDX1f2WylT4P7YN5VDTFknLgsvW69bwIwEHUpBu3/+DqbifdxtnuyhEufBuJnHXq
         owDU9TeLpxtoTym8Of59UZTl0AftDmm8dC3w18QMSkDrCwYfmSOJLRCPHtwaDdggtFs7
         XfBnWmysgGYv5TXfRS02RXzWVUZmp0ZeUrIKItriTkqCOHQzZgCejKGtQBiBluPYJ/tq
         d04sJY/h3dS1UqJ5u3/16EOlIKZ9ruqjrgumHNG28l54r7ZpvH5a37hnwj5wF9D3FyJ8
         H7qx9SVVvmsz7JSXwwcUHPXcJ+7TxjVA/FigBDDYcOfK3rrLI/Mv+n3FHAOPCjavTcfl
         ZimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733041366; x=1733646166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXE8F87IXfgmPdHHoIKU4/adT6aGKEI1TLuvAyyPv84=;
        b=sMJFrqSX2aDY5MK+Pc4/MKxcagOnqq8bFbMEL5loSa9amkID5e/rFFUvTV/y0/6rts
         vi1aKb9b0vKyNxWo6eaiM3kDgPkv52R4/tgYgg2uHsNhjiCXGcXcmSaSWqJBJ2QqGzc6
         4iJuRvXyCTAR9CZtdWu6BMzYa4fRlgZyMKaw4ZkpyLieqqnzzOQj8SNyVmvVjBArZvyO
         YykmxgAXLA0P0AkLexuN4HJ78sjcbuHucn2cnFmkGxB7dbkSSWiugFN4N6/H7/2Y9Q98
         C8HPFdNCDMjI7frpWhQApMAyaB4HAogKh5kodWM5EEJ+n05wO3BwkjjCsJTzh+dtumkZ
         yS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWtgy15uxzS/PpsNJCuMslhZMBAgiS6K9F+fqL/sHSr/2mfm/NEGrWvoBZj25yIzzzhnvVlxPM3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ySQDAZNj6t6QOqxbowuWrSjH80kPXuKjeivShwCf1q9RfMdJ
	/M7cR1vjKQr6gYuV/vsFRyfzQIrZnu7M7pDMyJRhgqHPaCc5WGG1MNG1kCmDlT5+02hRdz+HIdw
	=
X-Gm-Gg: ASbGncs2iqhRPS0pU/V58ItGdUKTjFTOWf6Ua6O04Lf91j8NkU99rqn4o5EoSGtFP5V
	Q0a2uWxYp2Pb0PGsTATelSN1yWp4drGGmk1IBTR24wY0dHyTa0iHOVE2fHwPLZ2U5eOwblS+Gui
	BYvYbAxnAfvEVJPvTWwY3Tuf0C+ePvCWOjMupblAiQfzF/eY5Vtk0Ds8eU2wlKKCbKgUtL2QWmc
	PMtnmNLvp5QrGR9EHIrqnWND70grfiHc4Y4e/SnCUiqa7Ta3lj8myP5ZruV
X-Google-Smtp-Source: AGHT+IGpOISreVT2GVR21hKojvk352+KFcfQQPctCKOweiZWEfiQTNtMCK3UHdPITFhyGga/ztTbIw==
X-Received: by 2002:a17:903:2449:b0:20c:c48a:efe4 with SMTP id d9443c01a7336-2151d2f0469mr184808475ad.4.1733041365792;
        Sun, 01 Dec 2024 00:22:45 -0800 (PST)
Received: from thinkpad ([120.60.48.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f47aasm55983375ad.20.2024.12.01.00.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 00:22:45 -0800 (PST)
Date: Sun, 1 Dec 2024 13:52:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Message-ID: <20241201082232.yfdtizjr535rmjbc@thinkpad>
References: <20241126210443.4052876-1-briannorris@chromium.org>
 <20241130182319.GA2804152@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241130182319.GA2804152@bhelgaas>

On Sat, Nov 30, 2024 at 12:23:19PM -0600, Bjorn Helgaas wrote:
> [+to Mani; +cc Jon, Saurabh]
> 
> On Tue, Nov 26, 2024 at 01:04:34PM -0800, Brian Norris wrote:
> > of_find_device_by_node() doesn't like a NULL pointer, and may end up
> > identifying an arbitrary device, which we then start tearing down. We
> > should check for NULL first.
> > 
> > Resolves issues seen when doing `echo 1 > /sys/bus/pci/devices/.../remove`:
> > 
> > [  222.952201] ------------[ cut here ]------------
> > [  222.952218] WARNING: CPU: 0 PID: 5095 at drivers/regulator/core.c:5885 regulator_unregister+0x140/0x160
> > ...
> > [  222.953490] CPU: 0 UID: 0 PID: 5095 Comm: bash Tainted: G         C         6.12.0-rc1 #3
> > ...
> > [  222.954134] Call trace:
> > [  222.954150]  regulator_unregister+0x140/0x160
> > [  222.954186]  devm_rdev_release+0x1c/0x30
> > [  222.954215]  release_nodes+0x68/0x100
> > [  222.954249]  devres_release_all+0x98/0xf8
> > [  222.954282]  device_unbind_cleanup+0x20/0x70
> > [  222.954306]  device_release_driver_internal+0x1f4/0x240
> > [  222.954333]  device_release_driver+0x20/0x40
> > [  222.954358]  bus_remove_device+0xd8/0x170
> > [  222.954393]  device_del+0x154/0x380
> > [  222.954422]  device_unregister+0x28/0x88
> > [  222.954451]  of_device_unregister+0x1c/0x30
> > [  222.954488]  pci_stop_bus_device+0x154/0x1b0
> > [  222.954521]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> > [  222.954553]  remove_store+0xa0/0xb8
> > [  222.954589]  dev_attr_store+0x20/0x40
> > [  222.954615]  sysfs_kf_write+0x4c/0x68
> > [  222.954644]  kernfs_fop_write_iter+0x128/0x200
> > [  222.954670]  do_iter_readv_writev+0xdc/0x1e0
> > [  222.954709]  vfs_writev+0x100/0x2a0
> > [  222.954742]  do_writev+0x84/0x130
> > [  222.954773]  __arm64_sys_writev+0x28/0x40
> > [  222.954808]  invoke_syscall+0x50/0x120
> > [  222.954845]  el0_svc_common.constprop.0+0x48/0xf0
> > [  222.954878]  do_el0_svc+0x24/0x38
> > [  222.954910]  el0_svc+0x34/0xe0
> > [  222.954945]  el0t_64_sync_handler+0x120/0x138
> > [  222.954978]  el0t_64_sync+0x190/0x198
> > [  222.955006] ---[ end trace 0000000000000000 ]---
> > [  222.965216] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
> > ...
> > [  223.107395] CPU: 3 UID: 0 PID: 5095 Comm: bash Tainted: G        WC         6.12.0-rc1 #3
> > ...
> > [  223.227750] Call trace:
> > [  223.230501]  pci_stop_bus_device+0x190/0x1b0
> > [  223.235314]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> > [  223.241672]  remove_store+0xa0/0xb8
> > [  223.245616]  dev_attr_store+0x20/0x40
> > [  223.249737]  sysfs_kf_write+0x4c/0x68
> > [  223.253859]  kernfs_fop_write_iter+0x128/0x200
> > [  223.253887]  do_iter_readv_writev+0xdc/0x1e0
> > [  223.263631]  vfs_writev+0x100/0x2a0
> > [  223.267550]  do_writev+0x84/0x130
> > [  223.271273]  __arm64_sys_writev+0x28/0x40
> > [  223.275774]  invoke_syscall+0x50/0x120
> > [  223.279988]  el0_svc_common.constprop.0+0x48/0xf0
> > [  223.285270]  do_el0_svc+0x24/0x38
> > [  223.288993]  el0_svc+0x34/0xe0
> > [  223.292426]  el0t_64_sync_handler+0x120/0x138
> > [  223.297311]  el0t_64_sync+0x190/0x198
> > [  223.301423] Code: 17fffff8 91030000 d2800101 f9800011 (c85f7c02)
> > [  223.308248] ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Applied to pci/for-linus; hopefully this can still make v6.13-rc1.
> 
> I added a Reported-by for Saurabh and tried to add some context around
> why we got in this fix in the first place, but I'm not confident that
> I got it all right.  Please comment:
> 
> commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if one actually exists")
> Author: Brian Norris <briannorris@chromium.org>
> Date:   Tue Nov 26 13:04:34 2024 -0800
> 
>   PCI/pwrctrl: Unregister platform device only if one actually exists
>   
>   If a PCI device has an associated device_node with power supplies,
>   pci_bus_add_device() creates platform devices for use by pwrctrl.  When the
>   PCI device is removed, pci_stop_dev() uses of_find_device_by_node() to
>   locate the related platform device, then unregisters it.
>   
>   But when we remove a PCI device with no associated device node,
>   dev_of_node(dev) is NULL, and of_find_device_by_node(NULL) returns the
>   first device with "dev->of_node == NULL".  The result is that we (a)
>   mistakenly unregister a completely unrelated platform device, leading to
>   issues like the first trace below, and (b) dereference the NULL pointer
>   from dev_of_node() when clearing OF_POPULATED, as in the second trace.
>   
>   Unregister a platform device only if there is one associated with this PCI
>   device.  This resolves issues seen when doing:
>   
>     # echo 1 > /sys/bus/pci/devices/.../remove
>   
>   Sample issue from unregistering the wrong platform device:
>   
>     WARNING: CPU: 0 PID: 5095 at drivers/regulator/core.c:5885 regulator_unregister+0x140/0x160
>     Call trace:
>      regulator_unregister+0x140/0x160
>      devm_rdev_release+0x1c/0x30
>      release_nodes+0x68/0x100
>      devres_release_all+0x98/0xf8
>      device_unbind_cleanup+0x20/0x70
>      device_release_driver_internal+0x1f4/0x240
>      device_release_driver+0x20/0x40
>      bus_remove_device+0xd8/0x170
>      device_del+0x154/0x380
>      device_unregister+0x28/0x88
>      of_device_unregister+0x1c/0x30
>      pci_stop_bus_device+0x154/0x1b0
>      pci_stop_and_remove_bus_device_locked+0x28/0x48
>      remove_store+0xa0/0xb8
>      dev_attr_store+0x20/0x40
>      sysfs_kf_write+0x4c/0x68
>   
>   Later NULL pointer dereference for of_node_clear_flag(NULL, OF_POPULATED):
>   
>     Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
>     Call trace:
>      pci_stop_bus_device+0x190/0x1b0
>      pci_stop_and_remove_bus_device_locked+0x28/0x48
>      remove_store+0xa0/0xb8
>      dev_attr_store+0x20/0x40
>      sysfs_kf_write+0x4c/0x68
>   

This looks good to me. Thanks for taking care!

- Mani

>   Link: https://lore.kernel.org/r/20241126210443.4052876-1-briannorris@chromium.org
>   Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
>   Reported-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>   Closes: https://lore.kernel.org/r/1732890621-19656-1-git-send-email-ssengar@linux.microsoft.com
>   Signed-off-by: Brian Norris <briannorris@chromium.org>
>   [bhelgaas: commit log]
>   Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> > 
> >  drivers/pci/remove.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index 963b8d2855c1..efc37fcb73e2 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -19,14 +19,19 @@ static void pci_free_resources(struct pci_dev *dev)
> >  
> >  static void pci_pwrctrl_unregister(struct device *dev)
> >  {
> > +	struct device_node *np;
> >  	struct platform_device *pdev;
> >  
> > -	pdev = of_find_device_by_node(dev_of_node(dev));
> > +	np = dev_of_node(dev);
> > +	if (!np)
> > +		return;
> > +
> > +	pdev = of_find_device_by_node(np);
> >  	if (!pdev)
> >  		return;
> >  
> >  	of_device_unregister(pdev);
> > -	of_node_clear_flag(dev_of_node(dev), OF_POPULATED);
> > +	of_node_clear_flag(np, OF_POPULATED);
> >  }
> >  
> >  static void pci_stop_dev(struct pci_dev *dev)
> > -- 
> > 2.47.0.338
> > 

-- 
மணிவண்ணன் சதாசிவம்

