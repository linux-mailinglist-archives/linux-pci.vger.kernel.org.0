Return-Path: <linux-pci+bounces-17499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75959DF4F8
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 09:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F8B281140
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AB50285;
	Sun,  1 Dec 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDqkyaNs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE922081
	for <linux-pci@vger.kernel.org>; Sun,  1 Dec 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733041283; cv=none; b=KpO2GmDR5kjIR8+bJG71tWkLvN+NQ7fXHIqgvRwCG1fIW5BCpQ56ElnUQFPC/Zs0vn4kgov5dTWpNFlxL/mKb435fuRQRVJ7RWibt9ky46osgUNiTPYkJnx1AUqmfJpbZuYM7BNhEpPBno4+Tmta1aSiCauKVkAbyDWr8i9sLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733041283; c=relaxed/simple;
	bh=/vEJQee77914nejWYiDnXDVsXt0QU+Nv3i+BEOa+1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKIeZmJDfOkj+7n0Grzi2+y0jGD9lV4gDznZWUEeXWyCPha/QmFgCz4JW9AN/P0EKbEGoAaDK8EAn4ysCmfGLPSkF5UQN2zRb0zRXqaZriKGPdMgqVTAcDcNGbTSzoFEopkdMfJ+ueqcM66ARpB/xeizwjVz30o+nrN0gs5AkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDqkyaNs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-214f6ed9f17so27853175ad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Dec 2024 00:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733041281; x=1733646081; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZhkSOhMr3kG9+pULDeS6OUw1OieDgWTOBNuSB8qmDA=;
        b=vDqkyaNs7rOfjybDZjGFJAqAPkV24o8nqxXvu2p4tSvvgOAkQPhoFFpbuntXlkXu+d
         ATu9Ip+TNAjxZzEowJEODhuDSH9uV2kgIALq4mN7oQSUujRj1BJ5GcymXP+uktTKbHY/
         2yMGAvsgGVYJ/hSd37RNryF38qhQo04wUgGbFCu0wjQ4AOHLg1dTfBk1ugmtiGyOEz5o
         nF+/71L1Be/fFyutgYU17NlvfHkiC16o2Kz2H95kethJ2gCi9z3Mt3E37w3WxWEHoeF0
         c+xsSn7xDvYomXjgqywJXC2gvH03NUN6/bO1NgYi55hAP6EJWIh018BEDxcHSWavL1Pq
         Fw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733041281; x=1733646081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZhkSOhMr3kG9+pULDeS6OUw1OieDgWTOBNuSB8qmDA=;
        b=lF5+smhAGyfP+gA+c3X/ct8ecq1RjSsIon6aPfes4t9WJGUKPQ4Y1fuAYFTtDoCLaY
         f1SUpUIA/DrThm0HbdqgKkplRlby1BMU/ogIetbpA1zMgClLP+MyaGuBHZaYtK9b5LRm
         mk0i3p30JitF586hqNAevmcJ9lO1YgP4cUhkm0/EsinR+0FThOUyOrQI61kjJ15xlDsr
         IInHGC/S0xmc/2VSgv9RhI9N50/l01gHxswUW5fvEYP804KQ+atxNS01yYuB77WPkhei
         K/1YUbk94ErF+PmPzf/qNBkp/OLpXEAOlrUNIbNvsswBo/UaVRVSx9dAb0+hoI1tlZkZ
         IWNg==
X-Forwarded-Encrypted: i=1; AJvYcCUNYBZt1Y+aSFnQ29zaPw5cHFmvpm9nRl32vZkQYgV8aaVHPlHfmjzpiu0oIQrn2v9OmFGPvQAKNCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLkzPnqXdmc0xXf2LODSPIL7FlAKeoWEeMM00AP5VVsUqTCn6
	sOVUIADgMCW0m3ObLGwQIcziw+EqkAORT9aVwF739s8/k9F99u81qWY//RPU2w==
X-Gm-Gg: ASbGnctNzUZA8rkAQlEHtItS0lRm/VkXxDxAlCBbZEdyBFkmZ+OsCADO+69TUGoRDeI
	GCeukJP2th1b2we/HwA8wpaRIXpGKBbq0OOvBHdBu8Jpyd/UB4H0t54RVTn9c0ciaBlXkI+Ogpw
	ichuKlS0zBU0grh7ARrZmqNh2/CECPRGPdM1T4oSJJlbCUasU/UCVJYU0gI/zU19I8wiy8045Zz
	55vwvBzQ9mnJwFVBjlYPex4RhFkkxNwTVosQCEKSMRJ2K7MR59gu3TlzCp3
X-Google-Smtp-Source: AGHT+IFlWBK91YiWAcNDX4HqbzUCg/ndFA2kLrMHKeNUnc4z1sJTeIfjhoCZYA26Mcvq9S6ZGW42AQ==
X-Received: by 2002:a17:903:190:b0:20b:7a46:1071 with SMTP id d9443c01a7336-215010860fdmr203341025ad.4.1733041280785;
        Sun, 01 Dec 2024 00:21:20 -0800 (PST)
Received: from thinkpad ([120.60.48.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254e7685desm4398823b3a.90.2024.12.01.00.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 00:21:20 -0800 (PST)
Date: Sun, 1 Dec 2024 13:51:08 +0530
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
Message-ID: <20241201082108.qy2reqd56mvrd6ku@thinkpad>
References: <20241126210443.4052876-1-briannorris@chromium.org>
 <20241129192811.GA2768738@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241129192811.GA2768738@bhelgaas>

On Fri, Nov 29, 2024 at 01:28:11PM -0600, Bjorn Helgaas wrote:
> [+cc Jon, Saurabh]
> 
> On Tue, Nov 26, 2024 at 01:04:34PM -0800, Brian Norris wrote:
> > of_find_device_by_node() doesn't like a NULL pointer, and may end up
> > identifying an arbitrary device, which we then start tearing down. We
> > should check for NULL first.
> 
> I assume pci_pwrctrl_unregister() is unregistering something added by
> pci_pwrctrl_create_devices() in pci_bus_add_device()?
> 
> There are a couple things I don't like about this code (these are
> unrelated to this particular regression fix, but they make me worry
> that I'm misunderstanding how this all works):
> 

The internals of PCI pwrctl is not documented clearly in a single place.
Let me try to clarify below.

>   - pci_pwrctrl_create_devices() and pci_pwrctrl_unregister() are not
>     parallel names.
> 
>   - pci_pwrctrl_create_devices() has a loop and potentially creates
>     several pwrctrl devices, one for each child that has a "*-supply"
>     property, but there is no corresponding loop in
>     pci_pwrctrl_unregister().

So we create pwrctl devices starting from PCI bridges. This is because, in order
for the endpoints to be enumerated, the relevant pwrctl drivers need to be
probed first (i.e., pci_bus_add_device() will be called for the endpoints only
when they are detected on the bus, but that cannot happen until the relevant
pwrctl driver is probed). That's why we have the loop in
pci_pwrctrl_create_devices() to iterate over the children of PCI bridges defined
in devicetree.

When the pwrctl devices are created, they will be destroyed in
pci_pwrctrl_unregister(). Now we don't have loop here because, this function
is called from pci_stop_dev() which will be called for each added PCI devices.
So even when the bridge device gets removed, all of its child devices will be
removed first, so we don't need to iterate.

> 
> I see that 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without
> iterating over all children of pwrctl parent") is at least partly
> *about* removing without iterating, and the commit log has some
> explanation about how pwrctrl devices lying around will get removed,
> but the lack of parallelism is a hassle for readers.
> 
> The subject and commit log also refer to "*the* pwrctl device," which
> suggests there is only one, but that seems slightly misleading even
> though it goes on to mention "any pwrctl devices lying around."
> 

With 'lying around', the commit meant that if the pwrctl device is not
associated with the PCI device (it can happen if the relevant PCI client driver
is not probed), then those dormant pwrctl devices will be removed when their
parent (PCI bridge) gets removed. Because for those PCI devices, pci_stop_dev()
won't be called.

> If they get removed when the parent gets removed, why do we need to
> remove *any* of them?  Is the real point that we need to clear
> OF_POPULATED?
> 

The idea of pci_pwrctrl_unregister() is to remove the pwrctl device when the
associated PCI device gets removed. When this happens, the pwrctl driver will
turn off the power to the corresponding PCI device (in other words, it reverses
what it did in probe()). That's the primary reason why we are removing the
pwrctl device when the PCI device gets removed.

Clearing the OF_POPULATED should also be done separately because of the
shortcomings of the of_platform_depopulate() API. See: commit f1536585588b
("PCI: Don't rely on of_platform_depopulate() for reused OF-nodes").

- Mani

> Maybe I'm missing the whole point here?
> 
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

