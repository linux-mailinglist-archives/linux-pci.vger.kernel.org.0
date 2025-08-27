Return-Path: <linux-pci+bounces-34929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA3B3885A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D4B16EE0D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE5278143;
	Wed, 27 Aug 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON7gbEl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D61494D9;
	Wed, 27 Aug 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314814; cv=none; b=YHKwzql0mdQ0WfjB+UH4S4uUloftInhfxXXQsQlkyieIuCiCyM+AYyqON+ZHaV3maVOhDv4avztMTdR5uVxRPasgCVC1J0VunJMiqqRSefPWFgSpaeHgIeNk/jfwnnF0/Uu4tstk4VpwJ5VbG0yOYq6ky3Ino9r7tuc7Ld0H0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314814; c=relaxed/simple;
	bh=CS1cdaFNhPaZQwHXNc84mleeDjpPMIaW8m/SBnQ/Teo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfBSjA/Rg+5AnZqcx3irEW/uRGATjyoe/6sS7i0KjZ0Hqk+6GwWy99KHy8dO0Xada5fhh8mEF8NolqT4m0H+xAaTZydZN3jLZHAb8r3FRXy1QmLeKk7HjdwBUVVtypsvOt7rvVhc6eW/9bEEYCoolosvduylkhDc5ovOOwN8NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON7gbEl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB2C4CEEB;
	Wed, 27 Aug 2025 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756314813;
	bh=CS1cdaFNhPaZQwHXNc84mleeDjpPMIaW8m/SBnQ/Teo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ON7gbEl8lizZ13ZlKTgLvor7Vyh9+2IDo4A1wzro5DAokPGESBvjFinppcURfWR4R
	 AZJnIzulnbxPGRf9VwtGBsM4vVZcqor9elE3ALOaLAV6/hid4iadWW2YVg8RabqKuM
	 LIwMzINqjOre358x4e40ar/aS9VSoiNWdgoRBUqbfuKtUx3i5hVibeiFI2tdy1Jv5e
	 q0t9NOMieA5qyXS9qm7Y5SiFTokChv8nvavPLvS8rIZacl4KnjHJS/vW2HkohHRT96
	 YI/vKThtmpn7/FvBjzffb9W87r0JSotxBKXc+v2aeEXM/UtjIPd7HTigY34FjLsTSG
	 a7GKfE9QnVfwA==
Date: Wed, 27 Aug 2025 22:43:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org
Subject: Re: [PATCH v3] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
Message-ID: <rxdibunhe34gpheegc674cqii4tv6eghh2qskk2uaige5szy3a@nuf6ho2vfbgn>
References: <20250825-qcom_aspm_fix-v3-1-02c8d414eefb@oss.qualcomm.com>
 <20250827154739.GA888232@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827154739.GA888232@bhelgaas>

On Wed, Aug 27, 2025 at 10:47:39AM GMT, Bjorn Helgaas wrote:
> On Mon, Aug 25, 2025 at 01:52:57PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> > ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> > enumerated at the time of the controller driver probe. It proved to be
> > useful for devices already powered on by the bootloader, as it allowed
> > devices to enter ASPM without user intervention.
> > 
> > However, it could not enable ASPM for the hotplug capable devices i.e.,
> > devices enumerated *after* the controller driver probe. This limitation
> > mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> > and also the bootloader has been enabling the PCI devices before Linux
> > Kernel boots (mostly on the Qcom compute platforms which users use on a
> > daily basis).
> > 
> > But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> > pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> > started to block the PCI device enumeration until it had been probed.
> > Though, the intention of the commit was to avoid race between the pwrctrl
> > driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> > devices may get probed after the controller driver and will no longer have
> > ASPM enabled. So users started noticing high runtime power consumption with
> > WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> > T14s, etc...
> > 
> > Obviously, it is the pwrctrl change that caused regression, but it
> > ultimately uncovered a flaw in the ASPM enablement logic of the controller
> > driver. So to address the actual issue, use the newly introduced
> > pci_host_set_default_pcie_link_state() API, which allows the controller
> > drivers to set the default ASPM state for *all* devices. This default state
> > will be honored by the ASPM driver while enabling ASPM for all the devices.
> 
> So I guess this fixes a power consumption regression that became
> visible with b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are
> probed before PCI client drivers").  Arguably we should have a Fixes:
> tag for that, and maybe even skip the tag for 9f4f3dfad8cf, since if
> you have 9f4f3dfad8cf but not b458ff7e8176, it doesn't sound like you
> would need to backport this change?
> 

9f4f3dfad8cf is the culprit which added a half baked solution for enabling ASPM
and b458ff7e8176 made the issue more obvious since instead of requiring people
to connect a device after boot, it allowed the device to enumerate after the
probe of the controller driver, thereby making it more visible.

It would make sense to add a Fixes tag for b458ff7e8176 too, but 9f4f3dfad8cf
should also be present IMO.

For backport, I do not want the AI tools to do the job since they will fail
anyway because of the API dependency. I may send a separate backport patch later
once this patch gets merged into mainline.

> I *love* getting rid of the bus walk and solving the hotplug issue.
> 
> > So with this change, we can get rid of the controller driver specific
> > 'qcom_pcie_ops::host_post_init' callback.
> > 
> > Also with this change, ASPM is now enabled by default on all Qcom
> > platforms as I haven't heard of any reported issues (apart from the
> > unsupported L0s on some platorms, which is still handled separately).
> 
> If ASPM hasn't been enabled by default, how would you hear about
> issues?  Is ASPM commonly enabled in some other way?
> 

Mostly from the downstream drivers. They do enable ASPM by default and I haven't
heard of any issues with that. So I assumed that would mean it will be safe for
us to enable ASPM for all platforms in upstream as well.

> If you think the risk of ASPM issues is nil, I guess it's OK to do at
> the same time.  From a maintenance perspective it might be nice to
> separate that change so if there happened to be a regression, we could
> identify and revert that part by itself if necessary.  It looks like
> previously, ASPM was only enabled for one part:
> 
>   ops_2_7_0   # cfg_2_7_0 qcom,pcie-sdm845
> 

No. Previously ASPM was enabled for ops_1_9_0 and ops_1_21_0 based platforms.

> But after this patch, ASPM will be enabled for many more parts:
> 
>   ops_2_1_0   # cfg_2_1_0 qcom,pcie-apq8064 qcom,pcie-ipq8064 qcom,pcie-ipq8064-v2
>   ops_1_0_0   # cfg_1_0_0 qcom,pcie-apq8084
>   ops_2_3_2   # cfg_2_3_2 qcom,pcie-msm8996
>   ops_2_4_0   # cfg_2_4_0 qcom,pcie-ipq4019 qcom,pcie-qcs404
>   ops_2_3_3   # cfg_2_3_3 qcom,pcie-ipq8074
>   ops_1_9_0   # cfg_1_9_0 qcom,pcie-sc7280 qcom,pcie-sc8180x qcom,pcie-sdx55 qcom,pcie-sm8150 qcom,pcie-sm8250 qcom,pcie-sm8350 qcom,pcie-sm8450-pcie0 qcom,pcie-sm8450-pcie1 qcom,pcie-sm8550
> 	      # cfg_1_34_0 qcom,pcie-sa8775p
>   ops_1_21_0  # cfg_sc8280xp qcom,pcie-sa8540p qcom,pcie-sc8280xp qcom,pcie-x1e80100
>   ops_2_9_0   # cfg_2_9_0 qcom,pcie-ipq5018 qcom,pcie-ipq6018 qcom,pcie-ipq8074-gen3 qcom,pcie-ipq9574
> 

If you insist, I can do that by calling pci_host_set_default_pcie_link_state()
from qcom_pcie_init_2_7_0() and later move it to qcom_pcie_host_init() in a
separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

