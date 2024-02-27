Return-Path: <linux-pci+bounces-4081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A68689DC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90060286BC4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF85465C;
	Tue, 27 Feb 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsIiSInm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD8C54BC7
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019066; cv=none; b=ZZkC6dass4b1VfemmwVLbIkY6TLnbJ9F9b8F5puhRkZRN92dgqznY+i02o9HcPFKWSloB+pzKIpncbbbZobTcbgGRMX1K+wESRZ/91oo8MXOHdk2jIOtH1x87fah6iZxdwmaL9nR9SSG03RanekibXtTpsJlVSejPjhjIq/XKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019066; c=relaxed/simple;
	bh=8hTm1e4DO3B+HFmKMCy0K5Gm6U/GBdM1sitK6NR5BhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0SMX/fvfJ4K9g+C3mnA2OI10cErXCUdHlQQuQ125kSPM00E4PHGBBFHqEXxblXo8c+7uB0CQUZsmwqn0jxfV6B7MoiRyQ9DtghLxgqLX3bvMI2LDOH1KUgKhOCnD/cr3WsbUEYS/hsokvCaSSCq+OB4brkpnJoe2e/+b2qPzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsIiSInm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4e7e2594cso2137658b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 23:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709019064; x=1709623864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g+3fVWuCL3ljJ78bEEHq6LmM/Y1cfdKgtrCzN5F26e0=;
        b=dsIiSInm1eRYjRmE3R+cs6adJUxUQ5HhGlq2Ly3ihbyOXqjig7TaUkY0iyxubtHOLD
         6jFdp52M5IyQkOy2gipajJgsidpIoH3LI45/tI9ORH9SX+I9rSFN1wynvtG6tfEbGOZN
         EixeHUW0+vFT7BUMBL6gJHLUx0+O/PIbXwYzZ0uFH6VnYorYyMXCkyhurs3pidW+yYLc
         kckiQOnn2BobHc7YLpfrC6eZJdKFmuYbjXVbLkzVBVMh7uK/U8SgEkXGnDRDx8jpGpfJ
         u3pleacP8DZRlT8x3Z5hI7MFlfxGm5FpVCy4sXhXJsumlYh+pQxvO3AwWkKmKXpniunf
         zkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019064; x=1709623864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+3fVWuCL3ljJ78bEEHq6LmM/Y1cfdKgtrCzN5F26e0=;
        b=pfPoVCzdjLjpeO7BzGDCAuQxN82TZOySVp/cRIGj6Sb3GTy6f7GWXOSHjXFNuUJBzV
         yCTsvAsboHfGdbp4ARiSr7OoiokUI2MW51Uv5CchYpyJXtq9CzbXIr5hsBPq7Rz8CQKl
         dCxE1E9qcVgx2wdpV+drt7msB3qk7Xa9BMULEbhqAICNcGQAOD0/PhOgOLKasSi/x2BM
         +W1oXRxFxahGoxLSjOiRc+mu03lb3VzPv44DzY74B7lhw/vSzSCrxZszi/x18MsJx0ZH
         dn8QHqfyfLVFFaAzYnOb7cTtRvOZP9VrKZ/3dsVbKGdomw974jMHRGqIBlpCeoN7Z8N7
         aYcA==
X-Forwarded-Encrypted: i=1; AJvYcCXScfFBE1yWY7FqaNCO5KBDGrS3E5fOH4Njxq41XeBl3QrnSn/0E45mCEo1r7o2otZf+aC7SFR1ym9JCPPZ7d014ediAV3dvf0C
X-Gm-Message-State: AOJu0YxcbAw4ivAnOS+iSFZOpCMOdA67Dn4+Q+5iVvSd6f9xfGGnCh4y
	p+M6IRkaDysoqxAwHwJ/zFKu40Vq7X1zTsRHa0OchjBMh//OuFCgCRYyx02Iyg==
X-Google-Smtp-Source: AGHT+IGsiEj/LOmY9J+SHSBDy/ugJbIp1TEHoUhukzvmCy97nYqQmJjP0j05uKAyQJzUBlgHzrTfJQ==
X-Received: by 2002:a05:6a20:c6cb:b0:19e:a23d:b507 with SMTP id gw11-20020a056a20c6cb00b0019ea23db507mr1305173pzb.58.1709019064283;
        Mon, 26 Feb 2024 23:31:04 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id bx33-20020a056a02052100b005dc507e8d13sm4311175pgb.91.2024.02.26.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:31:03 -0800 (PST)
Date: Tue, 27 Feb 2024 13:00:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240227073057.GF2587@thinkpad>
References: <20240222040629.GB3374@thinkpad>
 <20240226233930.GA215487@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226233930.GA215487@bhelgaas>

On Mon, Feb 26, 2024 at 05:39:30PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 22, 2024 at 09:36:29AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Feb 21, 2024 at 10:49:58AM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Feb 20, 2024 at 04:02:40PM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> > > > > > Currently, PCI core will enable D3 support for PCI bridges only when the
> > > > > > following conditions are met:
> > > > > 
> > > > > Whenever I read "D3", I first have to figure out whether we're talking
> > > > > about D3hot or D3cold.  Please save me the effort :)
> > > > 
> > > > Both actually, that's why I used "D3" as in the spec. I should've explicitly
> > > > mentioned that in the commit message.
> > > > 
> > > > > > 1. Platform is ACPI based
> > > > > > 2. Thunderbolt controller is used
> > > > > > 3. pcie_port_pm=force passed in cmdline
> > > > > 
> > > > > Are these joined by "AND" or "OR"?  I guess probably "OR"?
> > > > > 
> > > > > "... all the following conditions are met" or "... one of the
> > > > > following conditions is met" would clarify this.
> > > > 
> > > > Will use "one of the..."
> > > > 
> > > > > > While options 1 and 2 do not apply to most of the DT based
> > > > > > platforms, option 3 will make the life harder for distro
> > > > > > maintainers. Due to this, runtime PM is also not getting enabled
> > > > > > for the bridges.
> > > > > > 
> > > > > > To fix this, let's make use of the "supports-d3" property [1] in
> > > > > > the bridge DT nodes to enable D3 support for the capable
> > > > > > bridges. This will also allow the capable bridges to support
> > > > > > runtime PM, thereby conserving power.
> > > > > 
> > > > > Looks like "supports-d3" was added by
> > > > > https://github.com/devicetree-org/dt-schema/commit/4548397d7522.
> > > > > The commit log mentions "platform specific ways", which suggests maybe
> > > > > this is D3cold, since D3hot should be supported via PMCSR without any
> > > > > help from the platform.
> > > > > 
> > > > > So I *guess* this really means "platform provides some non-architected
> > > > > way to put devices in D3cold and bring them back to D0"?
> > > > 
> > > > By reading the comments and git log of the pci_bridge_d3_possible()
> > > > function in drivers/pci/pci.c, we can understand that some of the
> > > > old bridges do not support both D3hot and D3cold. And to
> > > > differentiate such bridges, platforms have to notify the OS using
> > > > some ways.
> > > > 
> > > > ACPI has its own implementation [1] and DT uses "supports-d3"
> > > > property.
> > > > 
> > > > And yes, in an ideal world PMCSR should be sufficient for D3hot, but
> > > > you know the PCI vendors more than me ;)
> > > 
> > > So it sounds like this is supposed to cover two cases:
> > > 
> > >   1) D3hot doesn't work per spec.  This sounds like a hardware
> > >      defect in the device that should be a quirk based on
> > >      Vendor/Device ID, not something in DT.  I don't actually know if
> > >      this is common, although there are several existing quirks that
> > >      mention issues with D3.
> > > 
> > 
> > I'd love to use quirks if we started from that. But right now, quirks are not
> > used and there are multiple checks based on various factors [1], including
> > relying on ACPI. So that's the reason I went with DT based approach.
> > 
> > If quirks has to be used now, then it has to be used for both ACPI and DT based
> > platforms. For DT it won't be an issue since nobody bothered until now, but for
> > ACPI, we need to add quirks for all the bridges in the wild which is not
> > feasible.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c#n3116
> > 
> > >   2) The platform doesn't support putting the bridge in D3cold and
> > >      back to D0.  I don't understand this either because I assumed DT
> > >      would describe *hardware*, and "supports-d3" might imply the
> > >      presence of hardware power control, but doesn't tell us how to
> > >      operate it, and it must be up to a native driver to know how to
> > >      do it.
> > 
> > "supports-d3" implies that both D3hot and D3cold works as in the
> > spec and the OS can handle it appropriately. If this is absent, then
> > OS should not transition the bridge to any of the D3 states. I don't
> > understand what is the confusion here. This is similar to what we
> > already have for ACPI (whether or not it is correct is another
> > topic).
> 
> What does "the OS can handle it appropriately" mean?  Whatever it
> means, it sounds like a property of the OS, not a property of the
> device.
> 

"appropiately" means as per the PCIe spec.

> I don't know what "D3cold works as in the spec" means, either.  The
> spec says how D3cold affects internal device state, but it doesn't say
> anything about how to put devices in D3cold or back in D0.
> 
> > > These are two vastly different scenarios, and I would really like to
> > > untangle them so they aren't conflated.  I see that you're extending
> > > platform_pci_bridge_d3(), which apparently has that conflation baked
> > > into it already, but my personal experience is that this is really
> > > hard to maintain.
> > 
> > I do agree that it is not in a good shape, but there is no better
> > solution other than making use of the DT property. If you have any
> > better idea, please suggest.
> 
> The longer this goes on the worse shape we are in because we're always
> adding new special cases.
> 
> The fundamental problem I have is that "supports-d3" doesn't say
> anything specific other than "current Linux can put the device in
> D3hot or D3cold and get it back out again".  I think DT should tell us
> characteristics of the device or the platform, e.g., "PMCSR doesn't
> work to enter/leave D3hot on this device" or "regulator X controls
> main power to the device to enter/leave D3cold".
> 
> But right now it sounds like a mixture of "PMCSR works correctly to
> enter/leave D3hot" and "some unspecified software can control main
> power to this device".
> 
> Putting devices in D3cold and back in D0 needs some kind of platform
> support like ACPI methods or a native power management driver that
> knows how to control power on a specific platform.  That's completely
> different from D3hot, where the PCI spec tells us all we need to know.
> 

Ok, I got the issue. TBH, I added the device tree property based on the existing
quirks for the ACPI devices. But none of the DT based platforms I'm aware of
(even the legacy Qcom MSM8996 chipset released in early 2016) doesn't have any
issue with D3hot. But I'm just nervous to assume it is the case for all the DT
based platforms in the wild.

But to proceed further, what is your preference? Should we ammend the DT
property to make it explicit that the propery only focuses on the D3hot
capability of the bridge and it works as per the spec (PMCSR) or bite the bullet
and enable D3hot for all the non-ACPI platforms?

We can add quirks for the bridges later on if we happen to receive any bug
report.

- Mani

> > > > > > Ideally, D3 support should be enabled by default for the more recent PCI
> > > > > > bridges, but we do not have a sane way to detect them.
> > > > > > 
> > > > > > [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-pci-bridge.yaml#L31
> > > 
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-acpi.c#n976
> > > > 
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > > This patch is tested on Qcom SM8450 based development board with an out-of-tree
> > > > > > DT patch.
> > > > > > 
> > > > > > NOTE: I will submit the DT patches adding this property for applicable bridges
> > > > > > in Qcom SoCs separately.
> > > > > > 
> > > > > > Changes in v3:
> > > > > > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > > > > > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> > > > > > 
> > > > > > Changes in v2:
> > > > > > - Switched to DT based approach as suggested by Lukas.
> > > > > > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> > > > > > ---
> > > > > >  drivers/pci/of.c  | 12 ++++++++++++
> > > > > >  drivers/pci/pci.c |  3 +++
> > > > > >  drivers/pci/pci.h |  6 ++++++
> > > > > >  3 files changed, 21 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > > index 51e3dd0ea5ab..24b0107802af 100644
> > > > > > --- a/drivers/pci/of.c
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -786,3 +786,15 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > > > >  	return slot_power_limit_mw;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > > > > +
> > > > > > +/**
> > > > > > + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> > > > > > + *
> > > > > > + * @node: device tree node of the bridge
> > > > > > + *
> > > > > > + * Return: %true if the bridge is supporting D3 states, %false otherwise.
> > > > > > + */
> > > > > > +bool of_pci_bridge_d3(struct device_node *node)
> > > > > > +{
> > > > > > +	return of_property_present(node, "supports-d3");
> > > > > > +}
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index d8f11a078924..8678fba092bb 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > > > > >  	if (pci_use_mid_pm())
> > > > > >  		return false;
> > > > > >  
> > > > > > +	if (dev_of_node(&dev->dev))
> > > > > > +		return of_pci_bridge_d3(dev->dev.of_node);
> > > > > > +
> > > > > >  	return acpi_pci_bridge_d3(dev);
> > > > > >  }
> > > > > >  
> > > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > > index 2336a8d1edab..10387461b1fe 100644
> > > > > > --- a/drivers/pci/pci.h
> > > > > > +++ b/drivers/pci/pci.h
> > > > > > @@ -635,6 +635,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
> > > > > >  u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > > > >  				u8 *slot_power_limit_value,
> > > > > >  				u8 *slot_power_limit_scale);
> > > > > > +bool of_pci_bridge_d3(struct device_node *node);
> > > > > >  int pci_set_of_node(struct pci_dev *dev);
> > > > > >  void pci_release_of_node(struct pci_dev *dev);
> > > > > >  void pci_set_bus_of_node(struct pci_bus *bus);
> > > > > > @@ -673,6 +674,11 @@ of_pci_get_slot_power_limit(struct device_node *node,
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  
> > > > > > +static inline bool of_pci_bridge_d3(struct device_node *node)
> > > > > > +{
> > > > > > +	return false;
> > > > > > +}
> > > > > > +
> > > > > >  static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
> > > > > >  static inline void pci_release_of_node(struct pci_dev *dev) { }
> > > > > >  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> > > > > > 
> > > > > > ---
> > > > > > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > > > > > change-id: 20240131-pcie-qcom-bridge-b6802a9770a3
> > > > > > 
> > > > > > Best regards,
> > > > > > -- 
> > > > > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

