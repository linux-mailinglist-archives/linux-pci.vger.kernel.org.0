Return-Path: <linux-pci+bounces-4144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18571869DDB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B262893F9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32164E1D0;
	Tue, 27 Feb 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP6sQLXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843394E1BD;
	Tue, 27 Feb 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055427; cv=none; b=H4aAUVHU+wLCO2fwITlvFXrkApB9BlA5o3CGQMslztiW6PoItcd8a5QjHTzMVwOfw87/YxDb7peDCjInq5xBQtxbf1Hou+SLeUPbPEdiH991f0WUTVvbcmd2ZebWIkcDbnSLZDibyZfl3Ef0ILf67dwM2JbauPy97nS/Bgz/CMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055427; c=relaxed/simple;
	bh=kcCY13OTkGcMrsoVrg34boTcMN0rsdNg4ViQTr06L5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tIb0/fS3/VC46XRDV2Bc4h2NG0Ic6bGJHy39Sy24RMCuomSVMHWa/+uuk2lFSfhXmQ1Svg3dc0HTSMyDWwDoPZJhCetAgti4BAfUZHrq42QYNG6dBMBxGYCTaDCN+P6ERdofY9+xlaq4aHJwHgoW+OTXEU+A96eQnehtHiXTg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP6sQLXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FAEC433F1;
	Tue, 27 Feb 2024 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709055427;
	bh=kcCY13OTkGcMrsoVrg34boTcMN0rsdNg4ViQTr06L5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tP6sQLXiUAB6vXs63FdW15R7zXtYajub7uKs0w1bhnG5OICHxIBqsaYjeJEwkw7Lf
	 cOx5CO204kQ80zCHEse2L+dXHQ8UkxKEEfTwOizDYa+vHkooesGEgIgUbSLRo1tJIW
	 MNFDOpjp4YUd3Dd0HKDSIlH6Jm3wOn+h4ujerCiMNRD5Pp4T558/bQ12g197L2qmsQ
	 vAHZ4B3M15fYeIQNODUPhWwe1FtekWFwX+V85PtFM1p+6bCvtJWE99IwAwXfDC4kiv
	 v35fo086l5vid8yV9RkuuRFNXzLqXg2aI/6cU9PuBcXsZBCNdnTjCJXTfDeEQNQ7tV
	 y13ZQPJzrEB7g==
Date: Tue, 27 Feb 2024 11:37:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20240227173705.GA241732@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227170840.GR2587@thinkpad>

On Tue, Feb 27, 2024 at 10:38:40PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 10:25:35AM -0600, Bjorn Helgaas wrote:
> 
> [...]
> 
> > > Ok, I got the issue. TBH, I added the device tree property based on
> > > the existing quirks for the ACPI devices. But none of the DT based
> > > platforms I'm aware of (even the legacy Qcom MSM8996 chipset
> > > released in early 2016) doesn't have any issue with D3hot. But I'm
> > > just nervous to assume it is the case for all the DT based platforms
> > > in the wild.
> > > 
> > > But to proceed further, what is your preference? Should we ammend
> > > the DT property to make it explicit that the propery only focuses on
> > > the D3hot capability of the bridge and it works as per the spec
> > > (PMCSR) or bite the bullet and enable D3hot for all the non-ACPI
> > > platforms?
> > > 
> > > We can add quirks for the bridges later on if we happen to receive
> > > any bug report.
> > 
> > I would assume all devices support D3hot via PMCSR per spec.  We can
> > add quirks if we discover something that doesn't.
> 
> When you say "all devices", are you referring to bridges in DT
> platforms or the bridges across all platforms?

This patch is only concerned with DT, so that's what I'm commenting on
here.  I don't know how to untangle the question of ACPI systems.

This patch affects platform_pci_bridge_d3(), so just based on the
"platform" in the function name, I would expect it to be concerned
with the D3cold case and whether the platform supports controlling
main power.

It looks like this patch says "we can put devices in D3cold if DT has
'supports-d3'".  But I don't know how to make sense of that because
that requires (a) platform hardware to control main power and (b)
software that knows how to use that hardware.  Wouldn't this require a
little more DT description, like "regulator X controls main power for
this bridge"?  And then an OS would only be able to actually use
D3cold if it knows how to *operate* the regulator, and it doesn't seem
like DT could answer that.

> > If we add annotations that "this device works correctly", we're
> > digging a hole for ourselves because it's impossible to remove those
> > annotations and they complicate all future maintenance.
> > 
> > Bjorn
> 
> -- 
> மணிவண்ணன் சதாசிவம்

