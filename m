Return-Path: <linux-pci+bounces-13237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310EE97A525
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC5C286B1B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F8158862;
	Mon, 16 Sep 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwMtQmJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4262149C4D;
	Mon, 16 Sep 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500029; cv=none; b=tpJLdBz+Fp5PWvUGGCLdexWvwiSh5ClPV71Btvhd5jIPK9PoiL9o4tKIevAOoX2XI7iC5bgUPKwyGEfP9VmfArKluboJklOx/Jk44TDeM5vVJv87NxkrHZ/ZELRJP1vVgJF2P7Hw4fowInC+0Ifao6hpTYyzURAulLP/CcXURD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500029; c=relaxed/simple;
	bh=dI8QA7UEh9kQ4aiH5s1VwA/ah6vGvZinGPk/2zxpCWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1Z2axwzJ8MoWPtfwoUhG+DN32S27gE2j0lUlGTw6w1kWeS5jV22Mn2rPx1G3FIIZDSbltzwTsbK4m0FYLU0jp64Gq7xc3C/mA66uZS4tibTfOMOeDnAtAMYgzCdNFKgWaJu+ZczQPfdhGUiX9mabul8G4Y9iIhl+vDcMt6HCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwMtQmJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984C2C4CECE;
	Mon, 16 Sep 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500029;
	bh=dI8QA7UEh9kQ4aiH5s1VwA/ah6vGvZinGPk/2zxpCWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwMtQmJ9gaRprRQtCndPijrsfTrBfedlVjsFa2vL3ichPSWdEQ/7LmfE+RvhOdO1c
	 0PEoK4ACAi5iNCLycGMHDPuhb6iFUQSq1dXfkkg1EE02oBTkm/PNatMEVf1+ZdRchJ
	 XCxmwHvHifr157iq+xtAaBq7W7RI8x6kwtyAwbYNUpTuepMj/a1ciTLgvVb5e3moFm
	 AMfiFr80svPV9y2bD/injtAIfF28T0KFJpR45Ld4MlEjmKekE25oZfpTEOL6ki3h71
	 SUVuB8p/KeBhd+VTJBUgzR0N8K6TaEvmckyqEXBdOb4wCtvH15ykvi2SC0JexcaB+l
	 OgTUWSBiJKYqw==
Date: Mon, 16 Sep 2024 17:20:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com, 
	quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom: Add OPP table for X1E80100
Message-ID: <npm3szetf55hw6ghmscol2rl5jb5h3neywit2axea53vbgarvh@pgqq5j5y5pcb>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-3-quic_qianyu@quicinc.com>
 <tf4z475uqjenohdgqj4ltoty3j3gopxnbdhrrn6zo3ug5yuvyq@us2nysv2ggxh>
 <20240913133619.z7cc4whhpvs2uecb@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913133619.z7cc4whhpvs2uecb@thinkpad>

On Fri, Sep 13, 2024 at 07:06:19PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 13, 2024 at 03:30:59PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Sep 13, 2024 at 01:37:21AM GMT, Qiang Yu wrote:
> > > Add OPP table so that PCIe is able to adjust power domain performance
> > > state and ICC peak bw according to PCIe gen speed and link width.
> > > 
> > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > > index a9db0a231563..e2d6719ca54d 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > > @@ -70,6 +70,10 @@ properties:
> > >        - const: pci # PCIe core reset
> > >        - const: link_down # PCIe link down reset
> > >  
> > > +  operating-points-v2: true
> > > +  opp-table:
> > > +    type: object
> > 
> > I think these properties are generic enough and we might want to have
> > them for most if not all platforms. Maybe we should move them to
> > qcom,pcie-common.yaml?
> > 
> 
> Agree. It should be moved to qcom,pcie-common.yaml.

Yep, ack.

Best regards,
Krzysztof


