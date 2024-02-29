Return-Path: <linux-pci+bounces-4227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7C86C2BC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 08:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283621F22E21
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8C481BF;
	Thu, 29 Feb 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsNxAJty"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318C481AC;
	Thu, 29 Feb 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192749; cv=none; b=hg+ZrQDSI3jwImj0uKoD+eCHLP0UsfrwRBVH3qAQvGLDCVUJEhGDeQ7wKdwmS4THdb2dl2GG28XceCGFMkmg7D16QGhRZov7+FcKhirdvjE/8YumjFekvJGsVStfIo6c+Au2XZm56rgrMX9s+rPDmidD9HnQtyZopfmvgP7mFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192749; c=relaxed/simple;
	bh=tGUb8YeZCicyaOmqG4cHZt1wx0OYpFDkswI/paIY66o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQwRWWnmC9BsU75Nw+Iu9kFmei1A4IUGj1l0DS5bZHfAHqfWD+exzc0TemXQAzEQ0J9ud97+fe8To7UCsajfTii3DZeymVFc19lcqzZ4fjWxcBEEoawATaBZEP9d9zL85Fe0fzYJD6rrzKt37Ef3MSc0MZHvNRRPR8B9lxwvCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsNxAJty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3BAC433C7;
	Thu, 29 Feb 2024 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709192749;
	bh=tGUb8YeZCicyaOmqG4cHZt1wx0OYpFDkswI/paIY66o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsNxAJtyH3ANwuXRI6Ki6gN5B2eIhKZ6ioHhtSKen9bmsuOyCK+oPtvTkb5Uoc+1Y
	 hivcJy3J817Egdcx9ZqZjVbStG2fDMvZel2wjK04czWv6BumVZjH9vOVMHocGlno//
	 /m3ADrT4kvyP8qVGe3NEFiYXGltmgMKyJvls2QXJVebUIBoq1SemtE2fNgAGPeTX56
	 wJ5ONbaXNKdbRxRXTnNQp0KwAQMHjVD+ONi4W6HJ3rS/dvKD7n70E26lwfSFqlIIwl
	 Q5aAtPbW+WsoAmEUEKjRIxRdk1XXpkOz+9Y2ztMP7TUSoGuAFZEYNiLSUV287MJQyZ
	 Im9lTOCuAd3qg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfb76-000000000Gz-2yaj;
	Thu, 29 Feb 2024 08:45:56 +0100
Date: Thu, 29 Feb 2024 08:45:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeA2NPsn3ncgW6KE@hovoldconsulting.com>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228220843.GA309344@bhelgaas>

On Wed, Feb 28, 2024 at 04:08:43PM -0600, Bjorn Helgaas wrote:
> [+to Mani]
> 
> On Fri, Feb 23, 2024 at 04:21:12PM +0100, Johan Hovold wrote:
> > This series addresses a few problems with the sc8280xp PCIe
> > implementation.
> > ...
> 
> > A recent commit enabling ASPM on certain Qualcomm platforms introduced
> > further errors when using the Wi-Fi on the X13s as well as when
> > accessing the NVMe on the CRD. The exact reason for this has not yet
> > been identified, but disabling ASPM L0s makes the errors go away. This
> > could suggest that either the current ASPM implementation is incomplete
> > or that L0s is not supported with these devices.
> > ...
> 
> > As this series fixes a regression in 6.7 (which enabled ASPM) and fixes
> > a user-reported problem with the Wi-Fi often not starting at boot, I
> > think we should merge this series for the 6.8 cycle. The final patch
> > enabling the GIC ITS should wait for 6.9.
> > 
> > The DT bindings and PCI patch are expected to go through the PCI tree,
> > while Bjorn A takes the devicetree updates through the Qualcomm tree.
> > ...
> 
> > Johan Hovold (12):
> >   dt-bindings: PCI: qcom: Allow 'required-opps'
> >   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
> >   dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
> >   PCI: qcom: Add support for disabling ASPM L0s in devicetree
> 
> The ASPM patches fix a v6.7 regression, so it would be good to fix
> that in v6.8.
> 
> Mani, if you are OK with them, I can add them to for-linus for v6.8.  
> 
> What about the 'required-opps' and 'msi-map-mask' patches?  If they're
> important, I can merge them for v6.8, too, but it's late in the cycle
> and it's not clear from the commit logs why they shouldn't wait for
> v6.9.

The 'required-opps' binding patch is a prerequisite for the
corresponding DT fix, which is tagged for stable and that should go in
6.8.

The 'msi-map-mask' binding update is strictly only needed for enabling
the ITS, which is 6.9 material, even if it's arguably also a fix for the
current binding. So this one could possibly wait for 6.9 even if it may
make sense to just take all three now for 6.8 to only have to deal with
the mentioned binding conflict once.

Johan

