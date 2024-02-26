Return-Path: <linux-pci+bounces-4065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044A86848D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 00:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2B91C2214C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78B13541B;
	Mon, 26 Feb 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5A/gIhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40867133285;
	Mon, 26 Feb 2024 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989469; cv=none; b=CBWCDZMzLRmxxAOqmCay2wWHPZgg9Gzn2gfA1Pn6z6tX4uh0XTfWV4OjjPgs7J/h4vnu7/UlmNoBQFActfqMPqgKCDnDdUzSGbXEC4msKisEgls7MTixy1QbSXJPaNvi1rcR8wyezRXmjPvH/kSMmW53yfaEX+ID1uJXpO+HBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989469; c=relaxed/simple;
	bh=Hzq6apXKj5DIdTzjgbZTgXIDZA74qt6GSY3DsNCSG4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IJGohXGocfgqtaqvU+JAL+9d/HTHuK6XKyLjz1SicQvwmdGnOtfyP++GkoBhpfljmNVfilRTQGAJ9QYdIOijAeCfiREvJX2JeFB082r3/b0ehoPy412yR6Mg2+VRdwKyTb+6xOoMLMaiufVHRvfXH8HOASVXYZyqO5a5rkbYjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5A/gIhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B119C433C7;
	Mon, 26 Feb 2024 23:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708989468;
	bh=Hzq6apXKj5DIdTzjgbZTgXIDZA74qt6GSY3DsNCSG4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H5A/gIhMGfbmX3Fwq8YWujjG9/EfRXs3bSZiP7Rt/d2weRrEDE7CZQ5zJ68tehTJV
	 kATeVSAA6sYplIuNv7gDyYxbVgT7hTMspX8rMI8kAhItxb6FBMtP790CjKfN7m8na4
	 khdfHzNoAEWHd7K9NvifvaAPFQLoLMkVgowtHvAj4sl5MX5Gfofi2aqfRhBWQm6Lqi
	 fbt8zn7J/AQ91zE+dBsKnOV/uru/z1Nbvjg2R16TFP5ZOi2Z6qgy45VdM5SrNouyzv
	 BDmnRtQ3h5WWONdEcL6Dni+S3wpMEJafm2Rvoj+pvVtGZHRa0QXcDl7OE4VBLZyXAn
	 47WXN6pMeAEvg==
Date: Mon, 26 Feb 2024 17:17:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240226231747.GA215353@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222094052.GA25101@wunner.de>

On Thu, Feb 22, 2024 at 10:40:52AM +0100, Lukas Wunner wrote:
> On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
> >   1) D3hot doesn't work per spec.  This sounds like a hardware
> >      defect in the device that should be a quirk based on
> >      Vendor/Device ID, not something in DT.  I don't actually know if
> >      this is common, although there are several existing quirks that
> >      mention issues with D3.
> 
> My recollection is that putting Root Ports into D3hot on older x86
> systems would raise MCEs,

Color me dubious.  I don't know why an MCE should happen unless we
tried to access MMIO space on the Root Port or we tried to access
downstream devices, and the UR or whatever got turned into MCE.
Avoiding D3hot seems like papering over something that we don't fully
understand.

> which is why pci_bridge_d3_possible() only
> allows D3hot in cases which are known to work (e.g. Thunderbolt
> controllers, machines with a recent BIOS).  It was a conservative
> policy chosen to avoid regressions.
> 
> I don't know if similar issues exist on non-ACPI systems.  If they
> don't exist, platform_pci_bridge_d3() could just return true for
> all devicetree-based systems.  Might be worth testing if any systems
> can be found which exhibit issues with such a policy.  That would
> obviate the need to specify "supports-d3" in the devicetree.
> Quite the opposite, ports which are known not to work could be
> blacklisted.  Of course if it turns out that's the majority then
> whitelisting via "supports-d3" is a better option.
> 
> >   2) The platform doesn't support putting the bridge in D3cold and
> >      back to D0.  I don't understand this either because I assumed DT
> >      would describe *hardware*, and "supports-d3" might imply the
> >      presence of hardware power control, but doesn't tell us how to
> >      operate it, and it must be up to a native driver to know how to
> >      do it.
> 
> I think we're putting devices into D3hot first before cutting power
> (i.e. putting them into D3cold), so knowing that D3hot is safe is
> basically a prerequisite for D3cold.
> 
> Thanks,
> 
> Lukas

