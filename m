Return-Path: <linux-pci+bounces-22848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5AA4E243
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D3C421C4C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F525FA0D;
	Tue,  4 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLa0LQQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFA27D76A
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100099; cv=pass; b=XbjZeEVJdwMk9SfW1lkIiDsozuKpv2JQxfNgraJ7/M62qjWe+j1M0AYtB1ZAKjUBwtKJgmAGOv11Sirw7Awip5JhbP3hivOfR+Q0DQThgjirBBtMoAgtkoyIAt0Jnanl+k1tSZVOLJ7R6rf7+FgXYVuUcPeV57WG5+RwKEV1VTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100099; c=relaxed/simple;
	bh=VIYv7jOirceEsOX7KnRIYeYd32+TAY98cre+XbP4POE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=omg5Yv9BUscODiLxqIpguQwHVIdUEab2gS4wyYaO+cFA58VC26OqretDR9q6Qp5RofuAZ2ee5HKB1NdqiYKfyeLx47o4otOcktoNpmzWga8l5stf93mJBzeJ3Yp2eAzj9hE8k+Hkmbro5gPqcElpXWQGMteqAN4eXW45pgtOZJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLa0LQQp; arc=none smtp.client-ip=192.198.163.15; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 7FD7C40D4DFB
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:54:56 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QLa0LQQp
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dwL1KFpzFxlq
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:53:22 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7137041898; Tue,  4 Mar 2025 17:53:20 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLa0LQQp
X-Envelope-From: <linux-kernel+bounces-541425-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLa0LQQp
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3CBDD42F3B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:47:52 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id E57722DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:47:51 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25081716B8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547A1F3FEB;
	Mon,  3 Mar 2025 10:44:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A21F3D30;
	Mon,  3 Mar 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998676; cv=none; b=t+I66HMT6sc1WxHegxE+LeZ0n6f0yMvVrqKCzDeH0j3kf+K+ays+1o083SOhKOwOWiqj0QOaU34wMCB7XZSPuFDzd1+MCDA2hQXdOCWdskAX7MgbDGLZsxlD4JAHcjgs3r6tLGBqDTSLDXffZXhKKnDUPz0MH+66M7xD+91G+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998676; c=relaxed/simple;
	bh=VIYv7jOirceEsOX7KnRIYeYd32+TAY98cre+XbP4POE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CZJRJIj/T/u7jhGuccHx50zgbA+VY6HncpTW6PdDfOvy9R1dqFoUYZYIpII+AXYljsRJOHD8dJUW/Uo6llFRmbQ6t1wZHpyFkhnvbc09xdaBV1WuCDVjky5GdnzqTx5ObhpgsJM+K9ndtTZptSVhJag4MEK3/YZpkgytKje5vpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLa0LQQp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740998675; x=1772534675;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VIYv7jOirceEsOX7KnRIYeYd32+TAY98cre+XbP4POE=;
  b=QLa0LQQpxK96/v+/4rz6+RcWY+qzNsj7mX7GKvp9eB841z997yxgm8+O
   c52AgKs6oHFB3HXfl2duH4SdmkYeY4LpQb1S6hY4I4WhQScx1MhfYfeNc
   Rb5d25gyend3lXV1yRZc2DvUryHi7Ut5l71Hv7aa0J2pzB9eR5tLHUmXm
   yV0piWVNNQ9+etgCVo4rvGxxsBhtWwn92KN193jbDLCaYWhhcgItx5PXW
   OEqOeqClEQ4lOyruy5HkdQ4/52R+NHkfZJSdbkWLoT1eAje82GgVZhO/l
   F9OWrW5JnDuZQfWgLDFOmPP5eXr/MCMmZUyDwCfUgOEy0GlTcZCNAw1xy
   Q==;
X-CSE-ConnectionGUID: FH8EeKtqTwmQ4vQnMVNnng==
X-CSE-MsgGUID: Yq7/lWpOQvi1blQsgxsKqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41989334"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41989334"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:44:33 -0800
X-CSE-ConnectionGUID: 2/cLllESQp2mo305RhzW9g==
X-CSE-MsgGUID: LrJbmPnzQteH3dtF0gSE7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117963436"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:44:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Mar 2025 12:44:26 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during
 reset
In-Reply-To: <Z8F1z-gyXJDyR6d0@wunner.de>
Message-ID: <f8a99fca-62fc-4503-a553-597d87341674@linux.intel.com>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com> <Z7RL7ZXZ_vDUbncw@wunner.de> <14797a5a-6ded-bf8f-aa0c-128668ba608f@linux.intel.com> <Z7_4nMod6jWd-Bi1@wunner.de> <Z8F1z-gyXJDyR6d0@wunner.de>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dwL1KFpzFxlq
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704809.99582@2oHiu5jPkfKCIhFked0cCg
X-ITU-MailScanner-SpamCheck: not spam

On Fri, 28 Feb 2025, Lukas Wunner wrote:

> On Thu, Feb 27, 2025 at 06:31:08AM +0100, Lukas Wunner wrote:
> > pcie_bwnotif_irq() accesses the Link Status register without
> > acquiring a runtime PM reference on the PCIe port.  This feels
> > wrong and may also contribute to the issue reported here.
> > Acquiring a runtime PM ref may sleep, so I think you need to
> > change the driver to use a threaded IRQ handler.
> 
> I've realized we've had a discussion before why a threaded IRQ handler
> doesn't make sense...

Yes.
 
> https://lore.kernel.org/all/Z35qJ3H_8u5LQDJ6@wunner.de/
>
> ...but I'm still worried that a Downstream Port in a nested-switch
> configuration may be runtime suspended while the hardirq handler
> is running.  Is there anything preventing that from happening?

I don't think there is.

> To access config space of a port, it's sufficient if its upstream
> bridge is runtime active (i.e. in PCI D0).
> 
> So basically the below is what I have in mind.  This assumes that
> the upstream bridge is still in D0 when the interrupt handler runs
> because in atomic context we can't wait for it to be runtime resumed.
> Seems like a fair assumption to me but what do I know...

bwctrl doesn't even want to resume the port in the irqhandler. If the port
is suspended, why would it have LBMS/LABS, and we disabled notifications 
anyway in suspend handler anyway so we're not even expecting them to come 
during a period of suspend (which does not mean there couldn't be 
interrupts due to other sources).

So there should be no problem in not calling resume for it.

> -- >8 --
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 0a5e7efbce2c..fea8f7412266 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -28,6 +28,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/pci-bwctrl.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -235,9 +236,13 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>  	struct pcie_device *srv = context;
>  	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
>  	struct pci_dev *port = srv->port;
> +	struct device *parent __free(pm_runtime_put) = port->dev.parent;
>  	u16 link_status, events;
>  	int ret;
>  
> +	if (parent)
> +		pm_runtime_get_noresume(parent);
> +

Should this then check if its suspended and return early if it is 
suspended?

pm_runtime_suspended() has some caveats in the kerneldoc though so I'm a 
bit unsure if it can be called safely here, probably not.

>  	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
>  	if (ret != PCIBIOS_SUCCESSFUL)
>  		return IRQ_NONE;
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index d39dc863f612..038228de773d 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -448,6 +448,8 @@ static inline int pm_runtime_put(struct device *dev)
>  	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>  
> +DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
> +
>  /**
>   * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
>   * @dev: Target device.
> 

-- 
 i.



