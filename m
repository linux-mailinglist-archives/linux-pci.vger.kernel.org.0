Return-Path: <linux-pci+bounces-4130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40057869A62
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5FB24DCF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAFA14534C;
	Tue, 27 Feb 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLuKolCh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927B145321;
	Tue, 27 Feb 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047753; cv=none; b=S6Tx3Sxi+fBuJRBrA8VkvKSLAhM4bbe91k4n4Ck+ZXPjsy0Y6YWfiQgE87wkzPrxrqsdsIQN95JQQmgLLo24CZN+apRSzuK1jX+OFOzGTGZWny48JOHtjP3XrPw4QcXEqHNVwkWb46x+i1R5+G2pu53SnqlDbEoxa5MLhlvpIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047753; c=relaxed/simple;
	bh=E0gTt77Arvd3jGeuhDVnF4mo9Sz+d/Hd/YFtqg7PMYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYCpj1J65jqbx/ORIA2LWWxIKvsm1Ksvvpnlmy9v286y9rB/P4Sr46ZOITaeufOrf0NfCOjsEYscROdnruxQO94R/Y/9AUfH+aDyCTveTJtSxkeU/BFDd50TouOPcs4rFSc5FeRqXEYz95x0J2F4tdoaidRHvlGEIBMFAVyFP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLuKolCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B8FC433F1;
	Tue, 27 Feb 2024 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709047753;
	bh=E0gTt77Arvd3jGeuhDVnF4mo9Sz+d/Hd/YFtqg7PMYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLuKolChPI4nvOdUEe8ZTYiQUSBG+vISHe3Q181dvF8yuKLFcRxfHG4RnuxFIyola
	 Xk7Yja/mkLyAOQBaextUP3MmYrRzLhedBsf13ZBeBfJU28L5JSdzt+2zY2PvYd2S5a
	 5KfHLallGnjJ/tJb0iV52agyyQnhEpDzE80D5nX2fUVA3wgutQfCkcmGgOYs8Sc9KN
	 bU+Ag0sqguTYF+NmCxPzW3Bh5xmB+uivuWqlLbfwucwlJAJav0HloKzoXrff3k924U
	 8ewgO34jWB2UYov7tH0BAGp5+23p0bg7mB6+3CrXuIqJA3pyWlIoBr2Z2OWlP/mC9t
	 skQ2I5L+GBOlg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rezON-000000000wZ-0kHB;
	Tue, 27 Feb 2024 16:29:15 +0100
Date: Tue, 27 Feb 2024 16:29:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/12] PCI: qcom: Add support for disabling ASPM L0s
 in devicetree
Message-ID: <Zd3_y_jbY8Ic2F0Y@hovoldconsulting.com>
References: <20240223152124.20042-5-johan+linaro@kernel.org>
 <20240223221000.GA118088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223221000.GA118088@bhelgaas>

On Fri, Feb 23, 2024 at 04:10:00PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2024 at 04:21:16PM +0100, Johan Hovold wrote:
> > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting
> > 1.9.0 ops") started enabling ASPM unconditionally when the hardware
> > claims to support it. This triggers Correctable Errors for some PCIe
> > devices on machines like the Lenovo ThinkPad X13s, which could indicate
> > an incomplete driver ASPM implementation or that the hardware does in
> > fact not support L0s.
> 
> Are there any more details about this?  Do the errors occur around
> suspend/resume, a power state transition, or some other event?  Might
> other DWC-based devices be susceptible?  Is there a specific driver
> you suspect might be incomplete?

I see these errors when the devices in question are active as well as
idle (not during suspend/resume). For example, when running iperf3 or
fio to test the wifi and nvme, but I also see this occasionally for a
wifi device which is (supposedly) not active (e.g. a handful errors over
night).

I skimmed Qualcomm's driver and noted that there are some registers
related to ASPM which that driver updates, while the mainline driver
leaves them at their default settings, but I essentially only mentioned
that the ASPM implementation may be incomplete as a theoretical
possibility. The somewhat erratic ASPM behaviour for one of the modems
also suggests that some further tweak/quirk may be needed, and I was
hoping to catch Mani's interest by reporting it.

But based on what I've since heard from Qualcomm, it seems like these
correctable error may be a known issue with the hardware (e.g. seen
also with Windows), which is also why we decided to disable it for all
controllers on these two platforms where I've seen this in v2.
 
> Do you want the DT approach because the problem is believed to be
> platform-specific?  Otherwise, maybe we should consider reverting
> 9f4f3dfad8cf until the problem is understood?

Enabling ASPM gave a very significant improvement in battery life on the
Lenovo ThinkPad X13s, from 10.5 h to 15 h, so reverting is not really an
option there.

And with L0s disabled, the AER error reports about correctable errors
(that prevent enabling the GIC ITS and possibly degrades performance
somewhat) are gone.

I don't know for sure if there are further Qualcomm platform that are
affected by this so I also don't want to use a too big of a hammer. The
devicetree property allows us to disable L0s only after confirming that
it's needed, and we can always extend this to broader classes of device
when/if we learn more.

> Could this be done via a quirk like quirk_disable_aspm_l0s()?  That
> currently uses pci_disable_link_state(), which I don't think is
> completely safe because it leaves the possibility that drivers or
> users could re-enable L0s, e.g., via sysfs.

That was my first approach, thinking that it was the endpoint devices
which did not really support L0s. But initially it seemed like the wifi
controller on the CRD was not affected by this, while the same
controller on the X13s was. That made me conclude that this is not just
a property of the device but (also) of the controller and/or machine.

I then noticed that we already had some controller drivers implementing
'aspm-no-l0s' and decided to go with that.

> This patch is nice because IIUC it directly changes PCI_EXP_LNKCAP,
> which avoids that issue, but quirk_disable_aspm_l0s() could
> conceivably be reimplemented to cache PCI_EXP_LNKCAP in struct pci_dev
> so quirks could override it, as we do with struct pci_dev.devcap.

Johan

