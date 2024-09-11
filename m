Return-Path: <linux-pci+bounces-13033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B99975498
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE04AB289FD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D5E194082;
	Wed, 11 Sep 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgekGbm2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917541C92;
	Wed, 11 Sep 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062668; cv=none; b=EwzNatdgTuR31bLVOErrkNTCtlfPuAq0Hc8YPODjYTa6CMOsDWmRGsz3hRv0yGOT4IN+BjJQJKtVMPX8vV1rKwvH9y/AXNd4kdS8T2ceFB8CBgBu2LJ1EcCby8JoXV5rOHipH1Wmlhd/zu5PocRKSoJLXbaO0Zeal7AebR05tlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062668; c=relaxed/simple;
	bh=sqiAFvJyvBydyX2PQqSGhbwmVyTlE6DwwppgmxO1SYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tyWDtTGjz4ErlzxirR/MrnAobIdrtVPrQQJlIa9+zAP7N769Vk3FlaTIOMcNhwrmCfGKDcGGK/LSuIFVuWFUAfwddcD/5OAGPDNr7q3eUGCaXrme4/UebNcHcmqXAeO6JZqvSMuE6laJwTkLXUytOwCsgSTBGbtGBi0lRkcpmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgekGbm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38210C4CEC0;
	Wed, 11 Sep 2024 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062668;
	bh=sqiAFvJyvBydyX2PQqSGhbwmVyTlE6DwwppgmxO1SYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TgekGbm2kRixRT5JRuTmWkxeg+wBT8vV8t4oVGXsLGJxHTrlm4vSE3/hxh0cMxnv4
	 ZUk27HfAVz9RoS7R4i5Htaj927Gnv9HYkUViPvqdeKX5QE4eEpUotXCbgQauSJcs2e
	 Ek0IJQiBaHWM3p4TXk2261NbuCeAmmLGFfStG047O5MwuONF5KO91TceXcriRus04F
	 9J4T2L4mZFyN04olpGALsh0Q60bGO8BLXB2TDiNnqVFduSkhJAzl1Ky2y+yZ7jvyOL
	 vBIRXQPOYAAxpXAoPgg021OSBEMyd5euk6DEOxnOtzXicq/ZD+RFHVHeQGR6NMSfVJ
	 eqAQTBRFMZPQA==
Date: Wed, 11 Sep 2024 08:51:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <20240911135106.GA629136@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsb_1YDo96J_AGkI@hovoldconsulting.com>

On Thu, Aug 22, 2024 at 11:07:33AM +0200, Johan Hovold wrote:
> On Tue, Jul 23, 2024 at 05:13:28PM +0200, Johan Hovold wrote:
> > Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> > dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> > bindings, which results in DT checker warnings like:
> > 
> > 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> > 
> > Note that this property has been part of the Qualcomm PCIe bindings
> > since 2018 and would need to be deprecated rather than simply removed if
> > there is a desire to replace it with 'vpcie3v3' which is used for some
> > non-Qualcomm controllers.
> > 
> > Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Can someone pick this one up for 6.11?

I applied this to pci/dt-bindings for v6.12.

v6.11 is possible but we'd need a bit of a story to justify it.
756485bfbb85 appeared in v6.9, and the commit log says it fixes a DT
checker warning, which don't make it sound like this is urgent.  Is
there more to it that would make this v6.11 material?

Bjorn

