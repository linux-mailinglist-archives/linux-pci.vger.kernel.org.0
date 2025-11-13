Return-Path: <linux-pci+bounces-41147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ABDC5933B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A04B334170D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9B12DDA1;
	Thu, 13 Nov 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP5N4lX/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5112F0C46;
	Thu, 13 Nov 2025 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054961; cv=none; b=Cd4eJLFrvcrJO2QcHYlJkkHwzARr4Ieo4vKiaHnzXPQcT15gAUBOliFU+pPhlUXvfUNIjK11BN252qwrssLvtEqWyHA7Exsr+RF5pABhlm5GHpjObezE9C+aJ/6IUXAcmLMYSLvMQMTgUbkf2oUGlFwqMXBynGm8WvvzJDe8/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054961; c=relaxed/simple;
	bh=yD3B+lsSCpLxr1JjizKv8OQ2Eubc5wN3S2xnJUgLluQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbfbCWwKtmwbfMiQatpECpfpFK12Vb8DiXy+OQswk0AIQrLIYyPAxolP7sE/Z5rXZVXCt9gKnmy2wRyunsiZoSpC7CFCYXIbghkdqTvQ6An74KiCYRDmrkzjzZzmTfQbCTB+/vCdMr9Tuvtnyr6wVlRP/PjhqI8gxu9jgs54tgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP5N4lX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC256C2BC86;
	Thu, 13 Nov 2025 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763054960;
	bh=yD3B+lsSCpLxr1JjizKv8OQ2Eubc5wN3S2xnJUgLluQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jP5N4lX/UypWUhrwR++c92hzNsnWptjOI/6tw/0Or7vHDnlsTYEy2wKDnhhqNVcfG
	 B1T8l388/Mf36FhhyDg20tdDbbtFHl8D4KRBD/+IkHwaM29S20em9uAqNl8SDB35Z1
	 SOPAimUIQ/nZjJSvj/oA7wjaG/MKAWmTg/ykszW1pSLTT3Hc7nG5XXoEIVElgixjtv
	 m75xFiRcz0XhO0tvTMKSyWLY2Hb2k78JIoaaNM6+d6rURg9M1o9xr6+6Xm2fecKckK
	 BVBl1I4qR6fk2zZLEVDD8s/+gPTdGTwfHKdCOWUVTLuRDznYCv7vbPZpwcRxCmIyZF
	 CPxRi/4+pCgjg==
Date: Thu, 13 Nov 2025 11:33:41 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com, mmareddy@quicinc.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/5] PCI: dwc: Add ECAM support with iATU
 configuration
Message-ID: <d5byixqmmka3wm5jo7stfmbydit5dnqpxcczgwc2zu7ge3dc4n@47ukwyvj4oqk>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <176160465177.73268.9869510926279916233.b4-ty@kernel.org>
 <e9306983-e2df-4235-a58b-e0b451380b52@oss.qualcomm.com>
 <zovd3p46jmyitqyr5obsvvmxj3sa3lcaczmnv4iskhos44klhk@gk6c55ndeklr>
 <d6a33801-d4fe-40fc-ae19-6a2ce83e5773@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a33801-d4fe-40fc-ae19-6a2ce83e5773@oss.qualcomm.com>

On Thu, Nov 13, 2025 at 09:27:36AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 11/10/2025 11:51 PM, Bjorn Andersson wrote:
> > On Tue, Oct 28, 2025 at 11:12:23PM +0530, Krishna Chaitanya Chundru wrote:
> > > On 10/28/2025 4:07 AM, Bjorn Andersson wrote:
> > > > On Thu, 28 Aug 2025 13:04:21 +0530, Krishna Chaitanya Chundru wrote:
> > > > > The current implementation requires iATU for every configuration
> > > > > space access which increases latency & cpu utilization.
> > > > > 
> > > > > Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> > > > > which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> > > > > would be matched against the Base and Limit addresses) of the incoming
> > > > > CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> > > > > 
> > > > > [...]
> > > > Applied, thanks!
> > > > 
> > > > [1/5] arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
> > > >         commit: 03e928442d469f7d8dafc549638730647202d9ce
> > > Hi Bjorn,
> > > 
> > > Can you revert this change, this is regression due to this series due to
> > > that we have change the logic,
> > How is that possible? This is patch 1 in the series, by definition it
> > doesn't have any outstanding dependencies.
> The regression is due to the drivers changes on non qcom platforms.
> 

Please be specific when you're answering, this way of saying "go fish"
isn't helpful.

By investing a little bit more time and writing a single sentence to
share what you know, you could have enlightened me and other readers of
this email list.

Regards,
Bjorn

> - Krishna Chaitanya.
> > I've reverted the change.
> > 
> > Regards,
> > Bjorn
> > 
> > > we need to update the dtsi accordingly, I will send a separate for all
> > > controllers to enable this ECAM feature.
> > > 
> > > - Krishna Chaitanya.
> > > 
> > > 
> > > > Best regards,

