Return-Path: <linux-pci+bounces-20277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23275A19FE9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 09:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC7D3A038C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EF20C02A;
	Thu, 23 Jan 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4HSz4dd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5E320B;
	Thu, 23 Jan 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620873; cv=none; b=R7zP7tG0FyqpxQ2p32hhA3/xA0szYjEY8LnbWxlSq92Xf+VYM9u0tbbyGKrSmitEACgSIiBI1SK3BbAP7cQy2kkGtvIAR6hDU3OsaMU3C6azVt2+C4sSAJLxeJB8irO99qQ2gWK6bvqIJM1ge0/3kvd0rfO3wcuRbc55DwHeT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620873; c=relaxed/simple;
	bh=vofYtrvUAsVCwLeaIG0II6eDROdU24GRLHxAawTP16s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsUUl/sevgZgcSS2zU1/T+z+k8HojIwpmlhAe6LvzCidfghVO9FmJowuEyaSWxaKekoXwnVHT9BCCvGTZItYpD6sIv4WB09gQljr463a6/FqMR28XlAAXpPjqrPJJn9zMmk4X+KUOsITzr+HFura4mojdYl+7DSRPTgrp1P0crQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4HSz4dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DB0C4CED3;
	Thu, 23 Jan 2025 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737620872;
	bh=vofYtrvUAsVCwLeaIG0II6eDROdU24GRLHxAawTP16s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4HSz4ddizmKXlDfUpbexL5lqDvisjBwughjiTIiqpetYPrA0KTYHafRPjopFgPeq
	 Dnrt9LMSzVtO5AGqPoJK61sy3jGz7f9HXGBTIhqldeJi0CWcBBqSsWHtksjOk0Xn+0
	 25yghJlZrwZwtM5KzCjVaoiWTHpb8sgZdMEG1Dly2Ce3Ff7+dRWZV3v94hClNKnHUH
	 W80Ow9VoChYP3gCRnpynbeK6rHMXNDks0t1stCSJAUHVW7P+zBgagGM4UTUXqEcxCc
	 bcyvyzRSo93wrzlC+5/8N4+JF5GOEjea1o7f3jp9A8Ul0k0FWjL5QLTL38GjHyqrlG
	 QwUkQlo4449yw==
Date: Thu, 23 Jan 2025 09:27:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <20250123-stereotyped-chupacabra-of-mathematics-10d9ce@krzk-bin>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-6-quic_varada@quicinc.com>
 <20250123-red-unicorn-of-piety-3c7de5@krzk-bin>
 <Z5H4UPhRjKhbbP9/@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5H4UPhRjKhbbP9/@hu-varada-blr.qualcomm.com>

On Thu, Jan 23, 2025 at 01:35:36PM +0530, Varadarajan Narayanan wrote:
> On Thu, Jan 23, 2025 at 08:58:29AM +0100, Krzysztof Kozlowski wrote:
> > On Wed, Jan 22, 2025 at 12:04:09PM +0530, Varadarajan Narayanan wrote:
> > > Document the PCIe controller on IPQ5332 platform. IPQ5332 will
> > > use IPQ9574 as the fall back compatible.
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > > v7: Moved ipq9574 related changes to a separate patch
> > >     Add 'global' interrupt
> > >
> > > v6: Commit message update only. Add info regarding the moving of
> > >     ipq9574 from 5 "reg" definition to 5 or 6 reg definition.
> > >
> > > v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
> > >
> > > v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
> > >     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
> > >       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
> > >       and dt_binding_check flag errors.
> > > ---
> > >  .../devicetree/bindings/pci/qcom,pcie.yaml          | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > index 413c6b76c26c..ead97286fd41 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > > @@ -34,6 +34,10 @@ properties:
> > >        - items:
> > >            - const: qcom,pcie-msm8998
> > >            - const: qcom,pcie-msm8996
> > > +      - items:
> > > +          - enum:
> > > +              - qcom,pcie-ipq5332
> > > +          - const: qcom,pcie-ipq9574
> >
> > Repeated many times on reviews to qcom: don't add to the end of the
> > lists. In case of multiple items, these are ordered by fallback, so this
> > goes next to other ipq entry... wait, that's already qcom,pcie-ipq9574,
> > so why are you duplicating?
> >
> > On what tree are you working?
> 
> Looks like ipq5424 changes got merged between the time I cloned
> linux-next, tested and posted the patch. Will fix this and post
> a new one.

Yeah, that would explain. Please grow the enum instead.

Best regards,
Krzysztof


