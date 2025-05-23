Return-Path: <linux-pci+bounces-28329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E582AC267F
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2987B3025
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A329552B;
	Fri, 23 May 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhK2/l12"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13781EF387
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014236; cv=none; b=ekTLJgHwHNoFMmAjCNfFzY/ggb0eU9i50LZgVlfkDqdTnTGyPvAVjSdIMk4A8fWEXeMzg5eeq32k+pOYNaW2i3BAcbIJSaKK4E9u3IhDZZg4Ra2uRHJAcsFjQn2aKHBoVQuLTWaToQGq9j90GPxPA72un4nrDh83TwoeBHiRrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014236; c=relaxed/simple;
	bh=1Nq8l8c8DVCAERRCZSjo9qlwbX14W75NAL/i97x4FBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAgQnCmfipSltEf3Z2FvxZy3Xr1AAmjRsDKxTnB48nLHBhDrXQ+C+8mexv6DRww/MwKTdHP6Ft9VKN8dZblHF1bkTGVoNzaiK3S9VBA08j2RcB8BHcNnh4sDtMX7NRDCOXLSOez2QvvuP0szXiINDT7osaLYTdsd2af1gd4Y9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yhK2/l12; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c7a52e97so90329b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748014234; x=1748619034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R3v+XCfDoXk4/HyqLMnQ9ik4ff0zAhngY11GJQQGwSU=;
        b=yhK2/l12KRvWRyQO42dmYeEI0El/AjOZtf/h15XjuZOkISW3Ufb3eFXY7ql7hsAl9u
         mITh2p6LYiUbFH6uHLTiWCZ7jpECwaXSN8UsnBKOV8Zew9+B+ymQ20XeY5UaZeT0uqyj
         sOsU89lYZtQCWrm+OiygSEDt95VVlDV3kw4zSjzVI50HVIHUyPZ4wLWGOwV5KcT6Tgqx
         ab5aF1vvFH4UJm0vaQk6+O7YQFNOiisPgBAZ6ap7MbKEXvx/T1RIGcszyTRTtYFRKUeF
         R2uSrdWwXxSEYCc+OIiCdAUNCNPx6ogGDb48bJbat3S7b3TsX16JyLcK6ttdxUb1ydXP
         VHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748014234; x=1748619034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3v+XCfDoXk4/HyqLMnQ9ik4ff0zAhngY11GJQQGwSU=;
        b=el+AraHwIvLW8d9r2O7nmzjyRD1LOfYJoRz4ikM7iVqQFj3EmoScHaQr1N3SfTqwsh
         W6Dhe+ipjWwiQgyylwjskH2Qhcdbm/Zvy9AV6g26OC2CmVmt/IZwVrTAREsOGlJQxbjM
         hzEyJJvCCr5ce/nlJn41XHvIva7uFBeBqfNjdYc4oFLVmDgxM3TSCdmxGJfi1T6Vl1Fh
         MSzlKFrm/jWBk+M9Xqj4A2W0LUNnnZOOU85fTJdbvWZShgvPNpjNO52gON7eHT3I3rgU
         bdNDPokhNXP0Agd3P+GOaq/xujmSq4OxNcTfXFRaWgNu9y+6EqVSegZbLsz1JNWS+0O0
         PRhg==
X-Forwarded-Encrypted: i=1; AJvYcCUBf/2cgnEZ1XjQ7GkqNeReOP46LBQdxABcfDRdRlDqHcET+4vwdfoklb3LHTQOvk7CAhpimhK1Yag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsc+J+Gx7A02XcKWCK+RvFliOzAUw4Qq2HHzdoQmLHwkFhXWJ
	J25MeIJlvoqsR69zA9J/O1PZlaQlIR0vQFWgGStM591KnUVK8sbW9u+7Ydd1avXN0g==
X-Gm-Gg: ASbGncvIONIrdZvHLU2+B2JFlWue60oBmOtJKLm13bD7F/JiUZl265hpI0P/zcRW4iw
	3dES3qdZBB4PecjpUUOKV28utSpGmufrVnAGg6p5mH4ZjtnMm6bmLojdq2Zvc8iXBbcBEQziJkk
	pKkFWX/f29gVr8AhNAAPgYNbZ6jq4LzsTghfJ+Po5Lb4WLbZf/zyDVAqL0FNCMUjtsMDrqG7yU/
	7UxCzpvtTqFiayTMF008WfvG6jRsFK7lVrbkunL8srYpJBgZj7IHrb/f0ZdoPTJTHSz6ut7L4EL
	izmCrHg//uA+2l6xhFVSgPutyrfsiBdgquk1MqOVdOJ/ByRmcKly+DLYLlW9X1U=
X-Google-Smtp-Source: AGHT+IGtbPoyqKXHEqhTL/sLWrgso+St11Ic5vEk6nXTs1cxOkEVfyLgBBGRyRYVbwS3SNEuUcKAFQ==
X-Received: by 2002:a05:6a00:9182:b0:740:6f86:a0e6 with SMTP id d2e1a72fcca58-742accc48a2mr35605429b3a.6.1748014233492;
        Fri, 23 May 2025 08:30:33 -0700 (PDT)
Received: from thinkpad ([120.56.203.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770eesm12819059b3a.154.2025.05.23.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:30:32 -0700 (PDT)
Date: Fri, 23 May 2025 21:00:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <6jslic5nfxz3ywllriiw7uw6jwc6iz362nwuane6xam66kbv6a@x6krddl53mkg>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
 <hqdp64mksr6whmncm5dhrjima32v5oyng4ov6hdklcamqtm4ib@prsatdutb5oj>
 <aDCLYl3y-4ktQrjH@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDCLYl3y-4ktQrjH@wunner.de>

On Fri, May 23, 2025 at 04:51:14PM +0200, Lukas Wunner wrote:
> On Fri, May 23, 2025 at 12:09:06PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, May 23, 2025 at 07:33:16AM +0200, Lukas Wunner wrote:
> > > On Thu, May 22, 2025 at 06:19:56PM +0200, Niklas Cassel wrote:
> > > > As you know the reset_slot() callback patches were merged recently.
> > > > 
> > > > Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
> > > > reset_slot() callback has been invoked. The issue is reproduced when MPS
> > > > configuration is set to performance, but might be applicable for other
> > > > MPS configurations as well. The problem appears to be that reset_slot()
> > > > feature does not respect/restore the MPS configuration.
> > > 
> > > The Device Control register (and thus the MPS setting) is saved via:
> > > 
> > >   pci_save_state()
> > >     pci_save_pcie_state()
> > > 
> > > So either you're missing a call to pci_restore_state() after reset,
> > > or you're missing a call to pci_save_state() after changing MPS,
> > > or MPS is somehow overwritten after pci_restore_state().
> > 
> > I think the issue is that the PCI bridge is getting reset while trying
> > to reset the PCI device. And in the reset path, we only save the config
> > space of the *device*, not the bridge.
> > 
> > As seen from the lspci output shared by Niklas, the content of the PCI
> > bridge seem to be diverged. Since the reset_slot() callback resets the
> > whole Root Complex (if there is a single Root port), then the config
> > space of the Root port/bridge needs to be saved and restored as well.
> > 
> > I believe pcibios_reset_secondary_bus() is not supposed to change the
> > config space of the root port. As per the definition of the "Secondary
> > Bus Reset" field in the Bridge Control Register, r3.0, sec 7.5.3.6:
> > 
> > "Port configuration registers must not be changed, except as required
> > to update Port status."
> > 
> > So pci_reset_secondary_bus() is not changing the config space,
> > but reset_slot() does. Are we plugging reset_slot() at the wrong place?
> 
> On ACPI-based platforms (x86 etc), I'm not aware that it's possible
> to reset the Root Complex.  If it is, I don't think we've exposed
> that feature and hence we don't really have a better place to hook
> into.
> 
> There's the pci_reset_fn_methods[] array and conceivably, an entry
> could be added there to reset the Root Port on capable platforms.
> However that array is meant to reset a single PCI function,
> whereas the ->reset_slot() also resets the entire hierarchy below
> the Root Port (IIUC).  So that's not really what the array is
> meant to be used for.
> 
> You wanted to use ->reset_slot() for aer_root_reset().  It performs
> a Secondary Bus Reset via:
> 
>   pci_bus_error_reset()
>     pci_bus_reset()
>       pci_bridge_secondary_bus_reset()
> 
> or:
> 
>   pci_bus_error_reset()
>     pci_slot_reset()
>       pci_reset_hotplug_slot()
>         hotplug->ops->reset_slot()
> 	  pciehp_reset_slot()      # or other hotplug driver
> 	    pci_bridge_secondary_bus_reset()
> 
> ...and that's the reason I suggested to plumb ->reset_slot()
> into pcibios_reset_secondary_bus().  I don't think we have
> a better place.
> 
> If all host bridge drivers reset the Root Complex as part of
> ->reset_slot(), then it should be fine to just call
> pci_save_state(dev) before and pci_restore_state(dev) after
> invoking host->reset_slot() in pcibios_reset_secondary_bus().
> 
> If however this behavior is specific only to certain host
> bridge drivers, then you want to call pci_save_state() and
> pci_restore_state() directly in their ->reset_slot()
> implementations.
> 

The callback is supposed to reset the specific PCI slots through platform
specific means. But I've worked only with single root port/slot devices so far,
so I'm not sure if the controller driver can reset individual root ports on a
multi port setup or not. I thought that it *might* be possible to reset
individual ports, so that's why I passed the root port 'pci_dev' to the callback
in a hope that the controller drivers could use it to identify the root port
they are resetting.

But since both of the controller drivers implementing the slot_reset() callback
are single root port implementations, I guess it is fine to do save/restore
state for the root port in pcibios_reset_secondary_bus() itself.

> I note that if you have a deeper hierarchy with PCIe switches
> below the host bridge, you'll reset the Root Complex even if
> the error was reported further down in the hierarchy by some
> Switch Downstream Port.  I think in that case you may not
> want to reset the Root Complex, but only perform a Secondary
> Bus Reset at that Downstream Port.  In other words,
> I'm wondering if pcibios_reset_secondary_bus() should invoke
> host->reset_slot() only if dev is a Root Port / is sitting
> on the root bus.
> 

You are right. We should check if the parent bus of the bridge is a root bus or
not.

> I'm also wondering if ->reset_slot() should be renamed to
> something like ->reset_root_complex() or ->reset_root_port()
> or somesuch to more aptly describe what it does.
> I guess the name ->reset_slot() came about because these
> Root Complexes typically consist of a single Root Port with
> a single slot.
> 

Yes, pretty much so. I could rename it to reset_root_port(), since I still
believe that multi root port setups may be able to reset them separately.

Will submit patches for the above changes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

