Return-Path: <linux-pci+bounces-4257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1CA86C9D0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B31C20D58
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB77E0F3;
	Thu, 29 Feb 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHB+43P8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C37E0E7;
	Thu, 29 Feb 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212214; cv=none; b=eQ0rZmEbosWnOq9pNnNqHfR+9CfrfDD8gLPTf01jVHS3EipFcEOp3OYJzQkir5Ag9+xOg9UgGiVQbCgJKMTaMZooX2CDjlQ+kOW8C0q+VEJuYslpkYQIMYvxN85JrAmDs1Vpcb7mNh6Ip5r3mg11ZnAefJ/frCIpHerf2IGbcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212214; c=relaxed/simple;
	bh=Vk41IkkyBM5ve0CG9q29yRlZai/dCooOSBeD513BM9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H70nT//RFduMFxG4TDUk+bIVfN9vk9FDfrNlv1WLzqOPAEm8yzNRqYCmaP6pvY/2LD6VLYH0jpxxM0CeBV14xoiadne39YdNvBuncVpAVOcS4P5m/MvD2taxJsfnX9Cw+ziEmULCHEhRNLesJW3sUNVWGLAMerIC35erSXQzHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHB+43P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822B1C433F1;
	Thu, 29 Feb 2024 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709212213;
	bh=Vk41IkkyBM5ve0CG9q29yRlZai/dCooOSBeD513BM9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHB+43P814TAK3jEMSFuGvrrQ9mMbI1NTpKf1jUaSHWFxqcVRDRDXofkmExidYquS
	 Yc2PlHkxvyLm5QuwZRkqFpwmFueATLl5XrsOWSy4Oz2NnxEvCe/Qxe+eKi6NQ+9P1X
	 B3xRI0VVhMvG96/gFvTeun7UNl/z2TIB0J6qiT1JPhCUd96075FgHeJxRM3egIFyO7
	 kOwWxrNMNfUS6va2AZPVDOk9KGKZkOt8G6nJ/zJLeLmwmvFghT11VCqhj01Bbnfmtt
	 INic3qZlhIDARJ8v8wwB6d/DKsCey2FDZ2LUKFrWay+VoRdlvqXKW3Z8rq4PQBK5ln
	 kDoGELHB+qRWQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfgB3-000000003Mr-0AvT;
	Thu, 29 Feb 2024 14:10:21 +0100
Date: Thu, 29 Feb 2024 14:10:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
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
Message-ID: <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229122416.GD2999@thinkpad>

On Thu, Feb 29, 2024 at 05:54:16PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 29, 2024 at 11:25:48AM +0100, Johan Hovold wrote:

> > As I mentioned, the 'required-opps' binding update is needed to fix the
> > missing OPP vote so blocking the binding patch would block merging the
> > DT fix which could otherwise go into 6.8.

> I agree that the fix gets the priority. But some maintainers perfer to merge fix
> patches _only_ if they are fixing the issue introduced in the ongoing release.
> But if Bjorn has no issues in merging these for 6.8, then it is fine.

It also depends on the severity of the issue and to some extent the
complexity of the fix. These binding fixes are certainly low risk. :)

> > The 'msi-map-mask' is arguably a fix of the binding which should never
> > have had that property, but sure, it's strictly only needed for 6.9.
> > 
> > And Bjorn A has already checked with the Qualcomm PCI team regarding
> > ASPM. It's also been two weeks since you said you were going to check
> > with your contacts. Is it really worth waiting more for an answer from
> > that part of the team? We can always amend the ASPM fixes later when/if
> > we learn more.
> > 
> > Note that this is also a blocker for merging ITS support for 6.9.

> I got it, but we cannot just merge the patches without finding the rootcause. I
> heard from Qcom that this AER error could also be due to PHY init sequence as
> spotted on some other platforms, so if that is the case then the DT property is
> not correct.

I've verified the PHY sequences both against what the UEFI firmware (and
hence Windows) uses as well as against the internal Qualcomm
documentation (with the help of Bjorn A). And Qualcomm did say that such
errors are also seen under Windows on these platforms.

But the fact that the symptoms differ between the CRD and X13s, which
use the same Atheros Wi-Fi controller (and the same PHY initialisation)
also suggests that this may to some extent be due to some property of
the machine.

Notably, on the X13s there are lot of errors when pushing data
(e.g. using iperf3), whereas on the CRD the are no errors when running
such tests.

When leaving the CRD on for long periods of time with the Wi-Fi
disconnected, I do however see occasional correctable errors.

> Since this is not the hot target now (for Qcom), it takes time to
> check things.

I think that based on the available data it's reasonable to go ahead and
merge these patches. In the event that this turns out to be a
configuration issue, we can just drop the 'aspm-no-l0s' properties
again.

Johan

