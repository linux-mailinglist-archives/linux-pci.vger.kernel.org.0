Return-Path: <linux-pci+bounces-17787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D39E5BB0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FB818860FA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BA224AF2;
	Thu,  5 Dec 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ9NlRBF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6D224AEA;
	Thu,  5 Dec 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416946; cv=none; b=e7xNiH+ZUUeb90FTAaLgmkpwg0Tll4cT8CkfoiY6IxGLe8T6VBmqq6APioUQG7CD7IdANiq7vcjWdBWMitVY5JL+DkvRa8jiN8vEy8YZLZhIYH1EcAGzgB3YYJNEfzZjCvbD6rlRLvnb3HR0yUiStJc4eYxoCZKqo4gzFh8/sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416946; c=relaxed/simple;
	bh=3NmoaPvIrDB0ncn04/HRMQhptmQD3WeXhz+ArwPgL18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YM/v3xOCUkCr7Llbjn+tAYw2uzna5wNNR3j/UJDqaPXt80IOgsO6iPoQCNRUig1Q8UNz0Mo3uTuocwFgku3JKNcjGS1AZOPiiwx2jpUsLVnmi3QvFaY/1mT0Nx9IG451ne8LKzXEU1h8OcIYMUBVaPbDXqaFNLnM0bO6zKEYs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ9NlRBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73263C4CEE0;
	Thu,  5 Dec 2024 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416945;
	bh=3NmoaPvIrDB0ncn04/HRMQhptmQD3WeXhz+ArwPgL18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rJ9NlRBFD+k3Sv8L3SrP8OwEFnAz/NAqKvPZQ4QZwqshUMIa/87Psu7kdnzYZU725
	 NUmc9r0YzmPRfvQqptCE3yAxtJAxDGDcAc5OC55d4XLHbcaRBB0nNkLq/cnL2+VuvT
	 p7z5c2nPF/TmFSivX/Dhkb99JdUVUoUDh8X7LDx/DEu/huvgirEI3MFTNIptO76QA7
	 wwZeSqKXpGPB6CCuOpWxp5Fx/YyRSvS8hmnrL/yxG60FzSlvXyeSx5NOnsmyGA73xB
	 3boR0x7YLSqfLjTYFNoEJDhx5S4ezxOA++D3vsx4ooeBa7i+lHUUGrdd38IrTM0UKm
	 NmdGKePQ+fwYw==
Date: Thu, 5 Dec 2024 10:42:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com, mmareddy@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Message-ID: <20241205164224.GA3053577@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca10fa00-fa9f-4e37-a50a-813629f4a2b3@oss.qualcomm.com>

On Thu, Dec 05, 2024 at 05:11:25PM +0100, Konrad Dybcio wrote:
> On 16.11.2024 11:00 PM, Krishna chaitanya chundru wrote:
> > Increase the configuration size to 256MB as required by the ECAM feature.
> > And also move config space, DBI, ELBI, IATU to upper PCIe region and use
> > lower PCIe region entierly for BAR region.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 3d8410683402..a7e3d3e9d034 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -2196,10 +2196,10 @@ wifi: wifi@17a10040 {
> >  		pcie1: pcie@1c08000 {
> >  			compatible = "qcom,pcie-sc7280";
> >  			reg = <0 0x01c08000 0 0x3000>,
> > -			      <0 0x40000000 0 0xf1d>,
> > -			      <0 0x40000f20 0 0xa8>,
> > -			      <0 0x40001000 0 0x1000>,
> > -			      <0 0x40100000 0 0x100000>;
> > +			      <4 0x00000000 0 0xf1d>,
> > +			      <4 0x00000f20 0 0xa8>,
> > +			      <4 0x10000000 0 0x1000>,
> > +			      <4 0x00000000 0 0x10000000>;
> 
> So this region is far bigger, any reason to use 256MiB specifically?

I assume this is because ECAM takes 1MB/bus, and pcie1 has
bus-range = <0x00 0xff>.  If one wanted a smaller ECAM area,
I assume one would limit bus-range to match.

Bjorn

