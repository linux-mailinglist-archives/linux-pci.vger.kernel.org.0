Return-Path: <linux-pci+bounces-24499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B006A6D5F5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79E1165A80
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12118B47E;
	Mon, 24 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKL/PpA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3F1459F6
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804126; cv=none; b=E0fM3e0/RoA4LwNMKKRZ15DSrJPsYGrmSOgCtnJs3nImj3GDDXvtvGnTC6z7cIIxvHjZyEm12kJMHbZvYSpy420Mk52HBzeNuQ3DuKZnHgkgGixA175dCKUukYYYtstU0I2xKZSiPqrEkNc1OgYzDDtJ1q3oLQvNyetmlMILZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804126; c=relaxed/simple;
	bh=6Sq9Ya4g+XAuEUhTZ3chq4k5xfM4TW/LWdcGJRvGSjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcP7uVsLJMDBb9/q+g8YsN5OJRidkXfF8Qp6QbKqo7QjiBpueomvfnQ6MNc83z568ufJ57qDWI2fK5KEYmraHx0ImtnhvLQeKB2cpId+1GiLHvXpuYurLo+kdSEX3hL7s1DZLkG9eBIsNMx6sDT59+fOiJl30g6EuhWdypPRhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKL/PpA2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2260c91576aso66721925ad.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742804124; x=1743408924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tLM1I/ZenOaskIZFzmfRGDkPKLZw4MZZ/dOcKKL4cKY=;
        b=QKL/PpA2KuSexWDEu2/l74v8kXcntSIT0B5nA/tW9dpirE70OzYyx/iWAUUfVtqf94
         bVQ4sRizF5qY4SVIJeqxkRoAXvNTOmsSdj7lANTD7JZ/TUKYhbaFWtryDq8UdYytb6MZ
         ZhqhTJUJ1Bpzb/8kNsHKsOhLaUaYsDIVSjiLHJNCWIlnCrATU8TllhYdbjCghU8GyYaN
         LFCtCcgJBB/S3+Sgs90GvV5scKTu2MZZe2s5iEF03fXIfSWNCsN1+fMddpSbabCUueeM
         Y1fxbtOlQtwdhK/VkJ2Fn6aTzghhf780HSVVMfjVoconz4Ahqy333c9OC4S1gNzbwIsr
         ywbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804124; x=1743408924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLM1I/ZenOaskIZFzmfRGDkPKLZw4MZZ/dOcKKL4cKY=;
        b=vuT5GYWZnauBY3h1daDB8/YdUha/Pw7vQatx7+sKnGmIySCu4HxiUbDR2nreFt4K0F
         BI9OA2HPYcG02lBm+mWfMSj0SWQ3dmGaIlJhZhUE4tP50TOx6s/F31hqomFFDmGX7U8T
         DxBX+CDWe0GUbOYrJ2JoNUxSMGMavopY8n6qRQxrUVPg/VHyC075fIU7IJH824LNMaTz
         vYVwsHIdTXMruMn6gvSEH/tdEIuELxptMo6Dq4cJ9iqXYhsOsbPAqGCiNmJ3fIYN1ey8
         H1T3I34vc+n7wV6QOurQVCeUpLqIzlLWdspNU1S9PECuP3ajEEaC3Rk6eyDxgC+9KMk7
         XO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwLBm+Z/H7BD5hpv3wQbuLnAQKUtqcZlfHxHLnzkWzWyBozlZBWR8ZBfvTwiko2lPuG8kvalr7LpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk45EdEwFP6omaL8wy9PMNfDvBr3lCvX+FbMOXXyzlZ9WHiq6m
	+8D5RoTEonojPHTKHyOzX+rhn2KmhAf67ATzfs4MX5h6LhbnKq9ir8hv83wBS9kwXbRy27ZYPyY
	=
X-Gm-Gg: ASbGncvG/VdSEK91bjQXJqTLCa34e+Dwol0M0e7PT+vatPg0RbMHdUqzMCcw76jIIxD
	lva90UacDH9fiPJhwhqbwjJ2VfGOtfXMBdFOzXUVX/oKVBlqbeJe+S5CVtUFr9g+fJ8IVdTZ3Ve
	b5ZCYppci7imtMlVavs1znfBKX3/JqUBzeYgqawYKNQToRyAlKl5EsGwNycOraT0cumISH1ED3j
	jE2E/PXWJx4ZmSQIh72ewFQyaGxS0hTLMm8Lixz3XH/0rCyKtp+O2kOqB16jWJK7QTTgzjt3Jit
	77yrcYqHdw7KAr8VSSXVqpLhvMpgfzN4lGkjw/ZL7fqCdpVOqxyRFs4C
X-Google-Smtp-Source: AGHT+IEh/0ZVqQHJZcD6xGRRpLA+mZtGFd2BKMXsc7EMwXQgBWzXGKHMwAOPVxZS3WYXqn3s12CZ2g==
X-Received: by 2002:a17:903:228c:b0:220:e924:99dd with SMTP id d9443c01a7336-22780e07b00mr206514405ad.34.1742804123861;
        Mon, 24 Mar 2025 01:15:23 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45862sm64603755ad.70.2025.03.24.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:15:23 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:45:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: 
	"devnull+manivannan.sadhasivam.linaro.org@kernel.org" <devnull+manivannan.sadhasivam.linaro.org@kernel.org>, 
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"brgl@bgdev.pl" <brgl@bgdev.pl>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Message-ID: <yzhvxyjb75epv4mkkocjqsqkus44c55zwnxta6ac3aauvswv3x@knyhszmrgfc3>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
 <20250321025940.2103854-1-wei.fang@nxp.com>
 <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
 <PAXPR04MB85102429AE77159F8CAF914088DB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250322032344.uypqhi3kg6nqixay@thinkpad>
 <PAXPR04MB851005833B17C2B78CFB421388DA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB851005833B17C2B78CFB421388DA2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Sat, Mar 22, 2025 at 11:39:06AM +0000, Wei Fang wrote:
> > Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further if
> > pwrctrl device is created
> > 
> > On Fri, Mar 21, 2025 at 07:04:24AM +0000, Wei Fang wrote:
> > > > Hi,
> > > >
> > > > On March 21, 2025 8:29:40 AM GMT+05:30, Wei Fang
> > <wei.fang@nxp.com>
> > > > wrote:
> > > > >@@ -2487,7 +2487,14 @@ static struct pci_dev
> > > > >*pci_scan_device(struct
> > > > pci_bus *bus, int devfn)
> > > > > 	struct pci_dev *dev;
> > > > > 	u32 l;
> > > > >
> > > > >-	pci_pwrctrl_create_device(bus, devfn);
> > > > >+	/*
> > > > >+	 * Create pwrctrl device (if required) for the PCI device to handle the
> > > > >+	 * power state. If the pwrctrl device is created, then skip scanning
> > > > >+	 * further as the pwrctrl core will rescan the bus after powering on
> > > > >+	 * the device.
> > > > >+	 */
> > > > >+	if (pci_pwrctrl_create_device(bus, devfn))
> > > > >+		return NULL;
> > > > >
> > > > >Hi Manivannan,
> > > > >
> > > > >The current patch logic is that if the pcie device node is found to
> > > > >have the "xxx-supply" property, the scan will be skipped, and then
> > > > >the pwrctrl driver will rescan and enable the regulators. However,
> > > > >after merging this patch, there is a problem on our platform. The
> > > > >.probe() of our device driver will not be called. The reason is
> > > > >that CONFIG_PCI_PWRCTL_SLOT is not enabled at all in our
> > > > >configuration file, and the compatible string of the device is also not
> > added to the pwrctrl driver.
> > > >
> > > > Hmm. So I guess the controller driver itself is enabling the
> > > > supplies I believe (which I failed to spot). May I know what platforms are
> > affected?
> > >
> > > Yes, the affected device is an Ethernet controller on our i.MX95
> > > platform, it has a "phy-supply" property to control the power of the
> > > external Ethernet PHY chip in the device driver.
> > 
> > Ah, I was not aware of any devices using 'phy-supply' in the pcie device node.
> 
> It is not a standard property defined in ethernet-controller.yaml. Maybe
> for other vendors, it’s called "vdd-supply" or something else.
> 

Ah, then why is it used at all in the first place (if not defined in the
binding)? This makes me wonder if I really have to fix anything since everything
we are talking about are out of tree.

> > 
> > > This part has not been
> > > pushed upstream yet. So for upstream tree, there is no need to fix our
> > > platform, but I am not sure whether other platforms are affected by
> > > this on the upstream tree.
> > >
> > 
> > Ok, this makes sense and proves that my grep skills are not bad :) I don't think
> > there is any platform in upstream that has the 'phy-supply' in the pcie node.
> > But I do not want to ignore this property since it is pretty valid for existing
> > ethernet drivers to control the ethernet device attached via PCIe.
> > 
> > > >
> > > > > I think other
> > > > >platforms should also have similar problems, which undoubtedly make
> > > > >these platforms be unstable. This patch has been applied, and I am
> > > > >not familiar with this. Can you fix this problem? I mean that those
> > > > >platforms that do not use pwrctrl can avoid skipping the scan.
> > > >
> > > > Sure. It makes sense to add a check to see if the pwrctrl driver is enabled or
> > not.
> > > > If it is not enabled, then the pwrctrl device creation could be
> > > > skipped. I'll send a patch once I'm infront of my computer.
> > > >
> > >
> > > I don't know whether check the pwrctrl driver is enabled is a good
> > > idea, for some devices it is more convenient to manage these
> > > regulators in their drivers, for some devices, we may want pwrctrl
> > > driver to manage the regulators. If both types of devices appear on
> > > the same platform, it is not enough to just check whether the pinctrl driver is
> > enabled.
> > >
> > 
> > Hmm. Now that I got the problem clearly, I think more elegant fix would be to
> > ignore the device nodes that has the 'phy-supply' property. I do not envision
> > device nodes to mix 'phy-supply' and other '-supply' properties though.
> > 
> 
> I think the below solution is not generic, "phy-supply" is just an example,
> the following modification is only for this case. In fact, there is also a
> "serdes-supply" on our platform, of course, this is not included in the
> upstream, because we haven't had time to complete these. So for the
> "serdes-supply" case, the below solution won't take effect.
> 

Does your platform have a serdes connected to the PCIe port? I doubt so. Again,
these are all non-standard properties, not available in upstream. So I'm not
going to worry about them.

> In addition, for some existing devices, the pwrctrl driver can indeed
> meet their needs for regulator management, but their compatible
> strings have not been added to pwrctrl, so they are currently
> unavailable. The below solution also not resolves this issue. For these
> devices, I think it's necessary to keep the previous approach (regulators
> are managed by the device driver) until the maintainers of these devices
> switch to using pwrctrl.
> 
> A generic solution I think of is to add a static compatible string table
> to core.c (pwrctrl) to indicate which devices currently use pwrctrl. If
> the compatible string of the current device matches the table, then
> skip the scan. Or add an property to the node to indicate the use of
> pwrctl, but this may be opposed by DT maintainers because this
> property is not used to describe hardware.
> 

Pwrctrl at the moment supports only the PCIe bus. And also, checking for the
compatible property in the pwtctrl core doesn't work/scale as the kernel has no
idea whether the pwtctrl driver is going to be available or not. That's the
reason why we ended up checking for the -supply property.

But I want to clarify that the intention of the pwrctrl framework is to control
the power to the device itself. Those supplies cannot be controlled by the
device driver themselves as the device first need to be available on the bus to
the driver to get loaded (if the device was powered on by the bootloader it is
not true, but kernel should not depend on the bootloader here). Traditionally,
such device power supplies were controlled by the PCIe controller drivers as of
now. This caused issues on multiple platforms/devices and that resulted in the
pwrctrl framework.

However, as I said earlier, pwrctrl can ignore several supplies like the
'phy-supply' that controls the supply to a sub-IP inside the PCIe device and
that could well be controlled by the device driver itself.

So I do think that the below patch is a valid one (once such devices start
appearing in the mainline). However, I'm not doing to post it for now as there
is nothing to fix in mainline afaik.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

