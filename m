Return-Path: <linux-pci+bounces-4228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2786C2D2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 08:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34041C213CC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84545BE0;
	Thu, 29 Feb 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf5XhxhY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CA374DE;
	Thu, 29 Feb 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192965; cv=none; b=Xxgt2NkX4njbZAbRxEObezw62zatRjaFGjrhg16LDQUvE1sNBSaPIevT6Kgz2KHAwx1z43B6r79KeaGlV+yBiNX4qaPbqvIepooBW/q/3xjbEMhbgyOxKMfPiuvk1N4sE70k1JwW6R6DOtx6klrcNwyYjoaWxofNZnpcP1Fo4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192965; c=relaxed/simple;
	bh=F8eU8cHhjsUAtRELm+mWX1heSH8PNdlNQAqErkovoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADKz/zDQK8ZJfHpqy26aRlcmuXgNQPT4edXznG/kULnWKugZbosUcLMkgntVte+MvRvdNz8otvnmn2ICf57VWxM8ILT2vctmRWRRAyC6D20BckBa+8KgE+sbOr0K33eYep5MX+nd/wOY/6RD12+mqLdEfUUgEZHMMcIH2zk/MRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf5XhxhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9DAC433C7;
	Thu, 29 Feb 2024 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709192965;
	bh=F8eU8cHhjsUAtRELm+mWX1heSH8PNdlNQAqErkovoHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vf5XhxhYz9YpFTrbU37IJdMaJ1xchdd4txf1f6hterOYD6AxGDTWo5lJrRfbkh9/x
	 rcaW19PqxI8fTvga+YvsVyTTP8sd8zn1pcGB0cQDsH48BXXLR/t67qQuPM+5rznLnE
	 kp4/ydnf4T8hqGIumaRJaKMjrVQy17osLwEIESCr/jxGCGaBPaLsWfdi3WA0Jha2jp
	 ixtI+aqyZx4FrF1z0bc1r+9viY9oohOJZGazVy9bhml3EooAF3ahEOK7JZusB3iOrh
	 Fs48NRZdhazI6kNdbBjrizWD131uf4JWJcMXHBgn1qLb4qU1lEQ1vuD2Iv9DLrX5KH
	 InZxas9djusiw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfbAb-000000000Hu-161H;
	Thu, 29 Feb 2024 08:49:33 +0100
Date: Thu, 29 Feb 2024 08:49:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeA3Dbyd9SPfwdPU@hovoldconsulting.com>
References: <20240228220843.GA309344@bhelgaas>
 <ada6c2ac-06ad-44bc-8d1e-e59ccf8ac551@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada6c2ac-06ad-44bc-8d1e-e59ccf8ac551@linaro.org>

On Thu, Feb 29, 2024 at 12:30:03AM +0100, Konrad Dybcio wrote:
> On 2/28/24 23:08, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2024 at 04:21:12PM +0100, Johan Hovold wrote:

> >> Johan Hovold (12):
> >>    dt-bindings: PCI: qcom: Allow 'required-opps'
> >>    dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
> >>    dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
> >>    PCI: qcom: Add support for disabling ASPM L0s in devicetree

> > What about the 'required-opps' and 'msi-map-mask' patches?  If they're
> > important, I can merge them for v6.8, too, but it's late in the cycle
> > and it's not clear from the commit logs why they shouldn't wait for
> > v6.9.
> 
> Either way, I believe they should go through the qcom tree, as it's
> a very hot one with lots of different changes to a given file.

I think Bjorn was just referring to the three binding patches listed
above and which should go through the PCI tree (unlike the later DT
fixes which will go through the Qualcomm SoC tree).

Johan

