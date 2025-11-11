Return-Path: <linux-pci+bounces-40837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96533C4C127
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41A5334F22F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD627B34C;
	Tue, 11 Nov 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyYjJ7kr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628C212FB9;
	Tue, 11 Nov 2025 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845567; cv=none; b=cG5rMlQQV2KY4TJgdqnqaYcymXfDwQEQmyD3RLJ0tDWWe3Tjm2HYL4V3Heg7TpMPhWY4AAC9h/Z4sOnc3jJytkyA+uFOcWuEZp/gi/RRvOzia2XVCAzu4ThsiqwxPhPoYnc++iprQMJhXHD4FAYX8WslRvZJi42wuFnijC5HiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845567; c=relaxed/simple;
	bh=bdpTphnNU0HMDNDK84DW5kZvy0Ho2bTylr3DZCZt89g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAsQc0wEFIF46V5ySi1q1Qn3rag5HLsEQLlIsn2AMGjwEPwAgD0j1QhR21CtmI4TDH+Y1HyTuFGIoPuIE+TImPiVLpeUN3xph58zfVkKtX/dY4VKfnkuIrIiCrTUm3dH9Q7dmyzZmva/Ig7lt8QPsV0LImUJjDRoBaVTgKk5kfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyYjJ7kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3628AC19423;
	Tue, 11 Nov 2025 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845567;
	bh=bdpTphnNU0HMDNDK84DW5kZvy0Ho2bTylr3DZCZt89g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyYjJ7krm6VyV+xoe/tXca8yY6dwJ2HTJKbbD/6WiOvPNEX093ZzFzxSjdUDyliLn
	 cH8qsRzsDX6o5oIhqX3uPqcJ4KYNYUtGIwDhDdRtaLvst3vqo6EjNrnjt5hSuEJA6x
	 DrUZLMPR0nuy9sX1kDtw3l1g0u7UPcznNUbb3w2QLeEONhqsTchQYsfYqbSQ9HHhRR
	 PNCAaE3GRbyV3cLT6XLZTAJTZeXsXAXL6jsMD2wN8ehJzPDoyRsogf5SKW+RvuiiCX
	 MMwmIFxF2vP5O+OuuqYdo/cweKXyHlW8T4x2vREs1zPUuUKJtBxz1PFQIhzu5T0tli
	 A9K7ROanhD9Cw==
Date: Tue, 11 Nov 2025 12:49:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Vignesh Raman <vignesh.raman@collabora.com>, Valentine Burley <valentine.burley@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Message-ID: <qy4cnuj2dfpfsorpke6vg3skjyj2hgts5hhrrn5c5rzlt6l6uv@b4npmattvfcm>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
 <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
 <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>

On Tue, Nov 11, 2025 at 03:51:03AM -0300, Val Packett wrote:
> 
> On 11/8/25 1:18 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 22, 2025 at 09:46:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > Hi,
> > > 
> > > This series is one of the 'let's bite the bullet' kind, where we have decided to
> > > enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
> > > reason why devicetree platforms were chosen because, it will be of minimal
> > > impact compared to the ACPI platforms. So seemed ideal to test the waters.
> > > 
> > > This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
> > > supported ASPM states are getting enabled for both the NVMe and WLAN devices by
> > > default.
> > > [..]
> > The series breaks the DRM CI on DB820C board (apq8096, PCIe network
> > card, NFS root). The board resets randomly after some time ([1]).
> 
> Is that reset.. due to the watchdog resetting a hard-frozen system?
> 
> Me and a bunch of other people in the #aarch64-laptops irc/matrix room have
> been experiencing these random hard freezes with ASPM enabled for the NVMe
> SSD, on Hamoa (and Purwa too I think) devices.
> 

Interesting! ASPM is tested and found to be working on Hamoa and other Qcom
chipsets also, except Makena based chipsets that doesn't support L0s due to
incorrect PHY settings. APQ8096 might be an exception since it is a really old
target and I'm digging up internally regarding the ASPM support.

> Totally unpredictable, could be after 4 minutes or 4 days of uptime.
> Panic-indicator LED not blinking, no reaction to magic SysRq, display image
> frozen, just a complete hang until the watchdog does the reset.
> 

I have KIOXIA SSD on my T14s. I do see some random hang, but I thought those
predate the ASPM enablement as I saw them earlier as well. But even before this
series, we had ASPM enabled for SSDs on Qcom targets (or devices that gets
enumerated during initial bus scan), so it might be that the SSD doesn't support
ASPM well enough.

But I'm clueless on why it results in a hang. What I know on ARM platforms is
that we get SError aborts and other crazy bus/NOC issues if the device doesn't
respond to the PCIe read request. So the hang could be due to one of those
issues.

> I have confirmed with a modified (to accept args) enable-aspm.sh script[1]
> that disabling ASPM *only* for the SSD, while keeping it *on* for the WiFi
> adapter, is enough to keep the system stable (got to about a month of uptime
> in that state).
> 

So this confirms that the controller supports it, and the device (SSD) might be
of fault here.

> If you have reproduced the same issue on an entirely different SoC, it's
> probably a general driver issue.
> 
> Please, please help us debug this using your internal secret debug equipment
> :)
> 

Starting from v6.18-rc3, we only enable L0s and L1 by default on all devicetree
platforms. Are you seeing the hangs post -rc3 also? If so, could you please
share the SSD model by doing 'lspci -nn'?

Apologies for the inconvenience!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

