Return-Path: <linux-pci+bounces-25963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC9A8AAA9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 00:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530E33B9AF4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677E2741BB;
	Tue, 15 Apr 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaVvA/gb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CD2741BA;
	Tue, 15 Apr 2025 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754421; cv=none; b=ffXlbTHrF87zDDKG0Exga5L8xLr7aNcUEwIg81nJ6n92IlOIM5sbdveKnNYNV7f3/YndsjTLNouyGu7pNh+kdvazk7Pir5Q/1AqfO1ycDR1kndKlhDBxLQW3ya3WuQOz+q2hwZay0jLPBvtbU+C8LbKJDWHl/YcXbcwL/66PWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754421; c=relaxed/simple;
	bh=daV67HKQogBs7ZdA8Rq6MMRQKj4oNdZ1uIGfugsJiwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFa58sDKhigGe7+bXMmaqmu/BtO3Pjk1GihK/4QhQCLMOG62TxY1i4rwkP0QJR2rJ4rJepTvprGBHQcxhbQTOl5Z2xYJVnbe2I8PT9NOL8kjkS3Xn/2Dh9BdL/h98HkAp2QdP8SbcpJ+G1U8EBQcLJuZ+nr3MPG25xfLRWTZmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaVvA/gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794D0C4CEE7;
	Tue, 15 Apr 2025 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744754417;
	bh=daV67HKQogBs7ZdA8Rq6MMRQKj4oNdZ1uIGfugsJiwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaVvA/gbI1uG0oD9RYALexMxPoA68JkoRyMpOEltdrHZUb5TmxA7Ws/XHrOqq7Wzs
	 DzQUOY5LM5BolQYZBFePnmJ88wEXUlSiGP8AxbcRcGtNr+dR2BY8xwIzIQ2nx5v7Aw
	 bb92SmSxM6DWqa8PbOo1P8pC5Ff0pw98akLBwS7Aec7/GlaKunwuiJ58tdj8qFVKrw
	 iqVvdq8K1an76WP9oO0r8eu4fY1RCpby87ETMdEHKdq/8QxBEuWEc5m4p2dqru3Dcf
	 DweeUhub94SXclwzx295Eb9UukARCyQkp+Vta/7HMoucfk90qrCuKgh0RHD7OQtYa/
	 cThQFsd1KaHoA==
Date: Tue, 15 Apr 2025 17:00:15 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: qcom: Move phy, wake & reset
 gpio's to root port
Message-ID: <20250415220015.GA897840-robh@kernel.org>
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
 <20250414-perst-v2-1-89247746d755@oss.qualcomm.com>
 <ody5tbmdcmxxzovubac4aeiuxvrjjmwujqmo6uz7kczktefcxz@b6i5bkwpvmzl>
 <6db146b9-ad63-42c7-9f33-83ecf64ed344@linaro.org>
 <tsnvoy2spr2dtqt3q2cnvl7rxobjgcgxntxb6rjtjdeej625i5@35je7sp3xqea>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tsnvoy2spr2dtqt3q2cnvl7rxobjgcgxntxb6rjtjdeej625i5@35je7sp3xqea>

On Tue, Apr 15, 2025 at 01:11:35PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 14, 2025 at 02:50:19PM +0200, Caleb Connolly wrote:
> > 
> > 
> > On 4/14/25 10:04, Dmitry Baryshkov wrote:
> > > On Mon, Apr 14, 2025 at 11:09:12AM +0530, Krishna Chaitanya Chundru wrote:
> > > > Move the phy, phy-names, wake-gpio's to the pcie root port node instead of
> > > > the bridge node, as agreed upon in multiple places one instance is[1].
> > > > 
> > > > Update the qcom,pcie-common.yaml to include the phy, phy-names, and
> > > > wake-gpios properties in the root port node. There is already reset-gpio
> > > > defined for PERST# in pci-bus-common.yaml, start using that property
> > > > instead of perst-gpio.
> > > > 
> > > > For backward compatibility, do not remove any existing properties in the
> > > > bridge node.
> > > > 
> > > > [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> > > > 
> > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > ---
> > > >   .../devicetree/bindings/pci/qcom,pcie-common.yaml      | 18 ++++++++++++++++++
> > > >   .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml      | 17 +++++++++++++----
> > > >   2 files changed, 31 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> > > > index 0480c58f7d998adbac4c6de20cdaec945b3bab21..16e9acba1559b457da8a8a9dda4a22b226808f86 100644
> > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
> > > > @@ -85,6 +85,24 @@ properties:
> > > >     opp-table:
> > > >       type: object
> > > > +patternProperties:
> > > > +  "^pcie@":
> > > > +    type: object
> > > > +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        maxItems: 1
> > > > +
> > > > +      phys:
> > > > +        maxItems: 1
> > > > +
> > > > +      wake-gpios:
> > > > +        description: GPIO controlled connection to WAKE# signal
> > > > +        maxItems: 1
> > > > +
> > > > +    unevaluatedProperties: false
> > > 
> > > Please mark old properties as deprecated.
> > 
> > Since this is a trivial change, just moving two properties, I don't see why
> > it makes sense to deprecate -- just remove the old properties, and move over
> > all the platforms at once.
> > 
> 
> This will be an ABI break. You should not remove properties all of a sudden
> without first deprecating them (even if you convert all upstream DTS at once).
> ABI is for older DTS also.

+1

Rob


