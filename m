Return-Path: <linux-pci+bounces-13570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEED9876B3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7ED1F26AFC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788215383A;
	Thu, 26 Sep 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAxCWegF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13813777E
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365283; cv=none; b=uWVLmmhYD4PCQ+wz1ZKAR22Bg69ULgzm7u109aUMqzemQzKHsOzxfjnJYO8vcowmRgEHmM63x/3lvPY8w6ebjq60gnY8PtOtlWexpShKFIv/Y0UFCt8NcHX+IVtEysgmLCbneumBHNE6hbQnfn99oMErbv+l/MvtWHQaCGLBujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365283; c=relaxed/simple;
	bh=4Bzaot7MgVM1GFyOyZP487LqA1KMGY3+cz8zUOkgGRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0zc4oRySEtlMe/hVdtKEyx8RjvYmRHvvfETWZeRMFs5vCc4fVx3VSNxEk6nuMKpicklUVA5fLNvFoPduh0CghIjrbyRgULcYS+Yse61rcXxwhDINZRYUa2ea0InxG3zu4u2S/ZEflN6zw1eSh9By0rjqKIngBAfVYunTkpJmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAxCWegF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727365282; x=1758901282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4Bzaot7MgVM1GFyOyZP487LqA1KMGY3+cz8zUOkgGRk=;
  b=IAxCWegF5DrhkNXSaYzncIU2S8HNDGgufEPYq3FyljOoI4tEI36Qhmo8
   n5qZFCXxvONM9gs9z4xNggvdwA6j5ponozORhjw3lNsqmcmONFlEO2k/8
   ZS45gkOiSzbR/hUGLV3FX3RfRVSPv4sfeFg2M8VRAh8ItSaIKiFvbBMXH
   67eZwnvf33M46ULDK3mevWbH5TYmJZMhVyW4hF0Vov7gt62wRCs5bmKIz
   BPSg7a32SwZ/5A/DinknbVDeNw0sfOx8UUux5SOikf2LhOU31p2ZiDWZ0
   zCShciufvnngYg4vGETykscI9c3pnvyX6o+aS1ztvQLjuKYgkSyiOaABf
   g==;
X-CSE-ConnectionGUID: bU9xePgVS1KBfmByXuLNfQ==
X-CSE-MsgGUID: nhmI6OooRfq+EM/MAgTpWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26344186"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26344186"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:41:21 -0700
X-CSE-ConnectionGUID: O+z0j7AIQCevB83ZmZJyMQ==
X-CSE-MsgGUID: ujZh6rwvQROi0Nw6iwar2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72349958"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 26 Sep 2024 08:41:18 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 26 Sep 2024 18:41:17 +0300
Date: Thu, 26 Sep 2024 18:41:17 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/i915/pm: Hoist
 pci_save_state()+pci_set_power_state() to the end of pm _late() hook
Message-ID: <ZvWAndAvgfM6_eG1@intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
 <20240925144526.2482-3-ville.syrjala@linux.intel.com>
 <ZvVzCbkfUkDb_0Ch@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvVzCbkfUkDb_0Ch@intel.com>
X-Patchwork-Hint: comment

On Thu, Sep 26, 2024 at 10:43:21AM -0400, Rodrigo Vivi wrote:
> On Wed, Sep 25, 2024 at 05:45:22PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > driver/pci does the pci_save_state()+pci_set_power_state() from the
> > _noirq() pm hooks. Move our manual calls (needed for the hibernate+D3
> > workaround with buggy BIOSes) towards that same point. We currently
> > have no _noirq() hooks, so end of _late() hooks is the best we can
> > do right now.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_driver.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> > index 6dc0104a3e36..9d557ff8adf5 100644
> > --- a/drivers/gpu/drm/i915/i915_driver.c
> > +++ b/drivers/gpu/drm/i915/i915_driver.c
> > @@ -1015,7 +1015,6 @@ static int i915_drm_suspend(struct drm_device *dev)
> >  {
> >  	struct drm_i915_private *dev_priv = to_i915(dev);
> >  	struct intel_display *display = &dev_priv->display;
> > -	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
> >  	pci_power_t opregion_target_state;
> >  
> >  	disable_rpm_wakeref_asserts(&dev_priv->runtime_pm);
> > @@ -1029,8 +1028,6 @@ static int i915_drm_suspend(struct drm_device *dev)
> >  		intel_display_driver_disable_user_access(dev_priv);
> >  	}
> >  
> > -	pci_save_state(pdev);
> > -
> >  	intel_display_driver_suspend(dev_priv);
> >  
> >  	intel_dp_mst_suspend(dev_priv);
> > @@ -1090,10 +1087,16 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
> >  		drm_err(&dev_priv->drm, "Suspend complete failed: %d\n", ret);
> >  		intel_power_domains_resume(dev_priv);
> >  
> > -		goto out;
> > +		goto fail;
> >  	}
> >  
> > +	enable_rpm_wakeref_asserts(rpm);
> > +
> > +	if (!dev_priv->uncore.user_forcewake_count)
> > +		intel_runtime_pm_driver_release(rpm);
> > +
> 
> why do we need this?
> probably deserves a separate patch?

It was there already.

> 
> >  	pci_disable_device(pdev);
> > +
> >  	/*
> >  	 * During hibernation on some platforms the BIOS may try to access
> >  	 * the device even though it's already in D3 and hang the machine. So
> > @@ -1105,11 +1108,17 @@ static int i915_drm_suspend_late(struct drm_device *dev, bool hibernation)
> >  	 * Lenovo Thinkpad X301, X61s, X60, T60, X41
> >  	 * Fujitsu FSC S7110
> >  	 * Acer Aspire 1830T
> > +	 *
> > +	 * pci_save_state() is needed to prevent driver/pci from
> > +	 * automagically putting the device into D3.
> >  	 */
> 
> I'm still not convinced that this would automagically prevent the D3,
> specially in this part of the code.

You need to read pci_pm_poweroff_noirq()

> 
> I would prefer to simply remove this call, or keep it and move it
> here to be consistent with other drivers, but also add the restore
> portion of it for consistency and alignment...
> 
> > +	pci_save_state(pdev);
> >  	if (!(hibernation && GRAPHICS_VER(dev_priv) < 6))
> >  		pci_set_power_state(pdev, PCI_D3hot);
> >  
> > -out:
> > +	return 0;
> > +
> > +fail:
> >  	enable_rpm_wakeref_asserts(rpm);
> >  	if (!dev_priv->uncore.user_forcewake_count)
> >  		intel_runtime_pm_driver_release(rpm);
> > -- 
> > 2.44.2
> > 

-- 
Ville Syrjälä
Intel

