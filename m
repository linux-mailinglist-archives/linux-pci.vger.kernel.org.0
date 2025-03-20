Return-Path: <linux-pci+bounces-24246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B4A6AC94
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90428982760
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F410226520;
	Thu, 20 Mar 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgdTDTb1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88901DE3A8
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493446; cv=none; b=PEro2QeNa9b3vRlQ8WB/CDMxPD3mZjOBBDT3I97xrwU2Ivrnil6wAzsbSlf8pWJtEPL6tLzEjdiybjUbyRuSjWHB0ZW4aJPkXcdZlH1y5gcA6D11efX8J4C6JoiwGYzsQvUdXiPsNwaeCkEOlPVKbFnQjzqKMCyY/BbpI0MUYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493446; c=relaxed/simple;
	bh=mO6ApbMHzxFMCtQxPMSGmJnnaUVaxpdYXWiMJjhdnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVV9uA0f1h5A647KyGdXebHKlnnb8ICE4+F+GkQGgBpUEjaZENwjptprRA7dpBm81vfxqsFPmqI3Uo3vEGGfKoBxgOmcVtcXxkyGGq1nyI3U8wOzzNTyVM61Vl20BiA7GIIk1Qtx22SZyVnX1DH0dPEtVJOKRQgAI0MHG0FDvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IgdTDTb1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so4940235a91.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742493444; x=1743098244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZBuAO/4lH4CVBlD86N+IBRXOKzZiRkJHD/4cEnzLg8=;
        b=IgdTDTb1X2qtQtOkDRsbcKFEP0YT598B/9Y24roSjP6k+N94B0usGnhtgNhRHvg0oA
         ug/vDzEqKyvbWyEoPZoWX7T1fP0ze0kP5URxeXtgHY3H1yKyh+FQBkONrq/sUv+v4HRb
         SAI/w/sQUA+DLKkcAVN5KHw+yH3qNxSmovIy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493444; x=1743098244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZBuAO/4lH4CVBlD86N+IBRXOKzZiRkJHD/4cEnzLg8=;
        b=VT7AXAaN2wj4gPe+isWuFn+yzfN59r7wrYEWjDabnxSyM0n2p4RpWInwnDzDkfce02
         d20WRnAmNYkVXipT0ALbQ8w0+FCALboW71iSaIwWdIS3XmRhEIJSSi7/laXHJbpAs9Hi
         lXsW/uPoAZa/pLuYFw0ytZ06yI19BxSMrzOL20QePbviGRoF7aowGYX9Mr1hXniEPJng
         Ya6I8a7u8PfDKRjBWKOLE74U6FvWos4MC2Wy75qY6CBgjxw61TpTECwbQTKwTteLegn2
         M0l/2icO4lvoZARKSVVLv9H/YkRGBID3lZCTrCGEPlojvUHivb3Rw7Pob6ezWZfqP8oI
         jV9w==
X-Forwarded-Encrypted: i=1; AJvYcCU7cgOkk+0jclnUDbEnZZKi3ZRquRkB0yc3TxXDHXven5WktgIkhQDUKoJp+k3702xdBYu0T3mUBn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1sNE7Fjd3sBsAFBTAJcy5wsIFi8kKcCtl/ZYI/2de+7BjPt4
	FN1dJP6y4kg2dcYqPrtseY7nphj+zQK4Kr0eKZXZg9R+9C5tPYH/0L9EIv1IsQ==
X-Gm-Gg: ASbGncvNKs0iWVFD/YkcrvJGD3q7vvKvLNtVHUh6mCkriR+4axh+9l1x/+cSNIUNurW
	lvzR67x0IOYM5L/WMX2R2gSvDhwtrBmq4vGNesS0iwgdi/1yzHB4pfZyfxd9Xc+P9IM8z4vxXeS
	C0upsYRNPOp1+QKfjBGktHcOXy9ewTOapt8ubVdwqUn/+KAtEmGR7CBCtPsiDuzT5m3+qj3wfn8
	ABecY8awIzP2x4+XII9R1b86sVKIK08uCCyrWzlcznXVRbMq7BgaetTfE0XJOmnzIiEiU2T0rwG
	kxoirFjkaSJLSRB5V2CdbdRsG8/4HiNmHeBxqySYnfC56GTTduNhSfT1nVzJQI/X6S+2XwW8uM7
	AmVEwUkc=
X-Google-Smtp-Source: AGHT+IE7xF5qbvgKRnHfx2I3KfMDgIwTK12qXs2qkhWYJrmEZMMPOAnefkb2h4CcUxPOX3VUqrZHNw==
X-Received: by 2002:a17:90b:54c7:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-3030ec2a985mr625654a91.7.1742493444134;
        Thu, 20 Mar 2025 10:57:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9e6b:24df:389d:f71b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301a5ea4e9asm2514396a91.1.2025.03.20.10.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 10:57:23 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:57:21 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <Z9xXAYA4KS5BabhE@google.com>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas>
 <Z8IC_WDmix3YjOkv@google.com>
 <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>
 <20250313052113.zk5yuz5e76uinbq5@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052113.zk5yuz5e76uinbq5@thinkpad>

Hi Rafael, Manivannan,

On Thu, Mar 13, 2025 at 10:51:13AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 05, 2025 at 02:41:26PM +0100, Rafael J. Wysocki wrote:
> > There were hardware issues related to PM on x86 platforms predating
> > the introduction of Connected Standby in Windows.  For instance,
> > programming a port into D3hot by writing to its PMCSR might cause the
> > PCIe link behind it to go down and the only way to revive it was to
> > power cycle the Root Complex.  And similar.
> > 
> > Also, PM has never really worked correctly on PCI (non-PCIe) bridges
> > and there is this case where the platform firmware handles hotplug and
> > doesn't want the OS to get in the way (the bridge->is_hotplug_bridge
> > && !pciehp_is_native(bridge) check in pci_bridge_d3_possible()).
> > 
> > The DMI check at the end of pci_bridge_d3_possible() is really
> > something to the effect of "there is no particular reason to prevent
> > this bridge from going into D3, but try to avoid platforms where it
> > may not work".
> > 
> 
> Thanks for sharing the background. This could go in the commit message IMO.

Yes, thanks Rafael. This adds a bit more than the guesswork I've done so
far.

> > Basically, as far as I'm concerned, this check can be changed into
> > something like
> > 
> > if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
> >         return true;

I suppose if this harms any non-x86 BIOS systems, we can just add to
bridge_d3_blacklist[]. This works for me too.

> > which also requires updating the comment above it accordingly.
> > 
> > This would have been better than the check added by the $subject patch IMV.
> 
> Looks good to me. Brian, could you please respin incorporating the comments?

Sure, will send shortly.

Brian

