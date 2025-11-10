Return-Path: <linux-pci+bounces-40730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E47C4882D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E37B4E7990
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9652329E5D;
	Mon, 10 Nov 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFyXs1Td"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1D318146;
	Mon, 10 Nov 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798657; cv=none; b=lY2X0Ni0uJ7pJ+rk7L3ujkdaFDZEZS3mCfxoiEPBcSShtvy3RpU5s8F8E9lrbHJd1EeC8Kmkki6PTNCRvG+XsNvp2CzsEuz0u5Uqh/LbdQbtm1oJIUaw4UhJ5S3PTHiiH8fCZSNZ78iNurrP0bjYD3+SY0NVd/tIE9b+OPigZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798657; c=relaxed/simple;
	bh=TkDygIMReA0SstkB5OvgzehqDlcij0Z0ZMvUqL6Rj74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPjj1ow8gPDNhWW1+gryN0kezikFUae0DLBC4IRLFrtZulLPNTxtalhvaRl8s7xYP/ByqIPuwQOaYD+rpoS2dFrlcSLRhc36tIJVosomsJzCf1tVoqmTL57kZ4Zm0fKu8TesTCLakP8fsBr1VRgT31A0H1C/wHfZIeqbKV8DOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFyXs1Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0E5C4CEFB;
	Mon, 10 Nov 2025 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762798657;
	bh=TkDygIMReA0SstkB5OvgzehqDlcij0Z0ZMvUqL6Rj74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFyXs1Td95alAV9mBklla3aaLsx4v3Zb0tF2w/SldWPWrmvaZwljumavflQt/+pJS
	 /78H7RWWWx9eK3Y1Vr5qr3Pilt/9rVcdguILnUC3c5kAUqeANq/U6wfqWVRBRRYbaB
	 ksiKkzM88zCFbEoJtaDQUztIGco4nsjm0JGV5YLvg09vYCxntLJWnr1qz8/VhRg7iH
	 no31Y0kixnMoaHlZcfic5LQ1OCKI7vTH6tfFq9pM9SktkHcjlDMzkizEVqQkYQ3Qos
	 bW7YzVRByJuvxQbg8C77SYSe1V0gpcqk5biJUkJnMEY+kb9jQm4GyWaQa0ri1Afwpg
	 qYCdQmSeVbvjA==
Date: Mon, 10 Nov 2025 12:21:43 -0600
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
Message-ID: <zovd3p46jmyitqyr5obsvvmxj3sa3lcaczmnv4iskhos44klhk@gk6c55ndeklr>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <176160465177.73268.9869510926279916233.b4-ty@kernel.org>
 <e9306983-e2df-4235-a58b-e0b451380b52@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9306983-e2df-4235-a58b-e0b451380b52@oss.qualcomm.com>

On Tue, Oct 28, 2025 at 11:12:23PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 10/28/2025 4:07 AM, Bjorn Andersson wrote:
> > On Thu, 28 Aug 2025 13:04:21 +0530, Krishna Chaitanya Chundru wrote:
> > > The current implementation requires iATU for every configuration
> > > space access which increases latency & cpu utilization.
> > > 
> > > Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> > > which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> > > would be matched against the Base and Limit addresses) of the incoming
> > > CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> > > 
> > > [...]
> > Applied, thanks!
> > 
> > [1/5] arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
> >        commit: 03e928442d469f7d8dafc549638730647202d9ce
> 
> Hi Bjorn,
> 
> Can you revert this change, this is regression due to this series due to
> that we have change the logic,

How is that possible? This is patch 1 in the series, by definition it
doesn't have any outstanding dependencies.


I've reverted the change.

Regards,
Bjorn

> we need to update the dtsi accordingly, I will send a separate for all
> controllers to enable this ECAM feature.
> 
> - Krishna Chaitanya.
> 
> 
> > Best regards,

