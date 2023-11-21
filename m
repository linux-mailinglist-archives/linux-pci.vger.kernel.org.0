Return-Path: <linux-pci+bounces-17-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01D7F25FE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 07:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EC2281408
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 06:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31EB1CF9A;
	Tue, 21 Nov 2023 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIPNBoVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FA1BDFB;
	Tue, 21 Nov 2023 06:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7927CC433C8;
	Tue, 21 Nov 2023 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700549695;
	bh=RC5ZdYA1C0XmYYroKXT596EA+PosEEwbcr5BlUftzz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIPNBoVW+CIEuujkcy643EdBJLG/1c5e/LQ3JEe5jKWq4O2dwGcXb9SIuRKd4bdgH
	 MoFaA3SCR0YBWn8bjyWvEE8naeFCgWR/7vD0CiXeyQrPYV8eLs/qKpLcEiWMTi2jCS
	 HWgHAlVcR5dPQmnPzdF16zzataafTPMOTOkbo7wzgkvfNMKmQn9uKBOe24QIg26Eeg
	 V6r1uJ3TgInM9NHdeGAI8QVaFQFegEo/uMqI3W5GQd6be3BNvDbxeVVmoiW3Gb6G4V
	 G+r7n1wNayHQ4E7IjfmiaN/jE1OQlakHZXXGMF+jeGFMJPKNjMAHX+uIj5S3sLHeDA
	 NAUyS+7wwis1A==
Date: Tue, 21 Nov 2023 12:24:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: qcom: correct clocks for
 SC8180x and SM8150
Message-ID: <20231121065440.GB3315@thinkpad>
References: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
 <20231120070910.16697-2-krzysztof.kozlowski@linaro.org>
 <CAA8EJpq6YOYGvxFwreNSoTShrKryqeEy79CTb0dFO-Dv8RNxZA@mail.gmail.com>
 <d2e4d7b0-39c9-4443-b0d3-774bdf79404b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e4d7b0-39c9-4443-b0d3-774bdf79404b@linaro.org>

On Mon, Nov 20, 2023 at 11:48:25AM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2023 11:11, Dmitry Baryshkov wrote:
> >> +    then:
> >> +      oneOf:
> >> +        - properties:
> >> +            clocks:
> >> +              minItems: 7
> >> +              maxItems: 7
> >> +            clock-names:
> >> +              items:
> >> +                - const: pipe # PIPE clock
> >> +                - const: aux # Auxiliary clock
> >> +                - const: cfg # Configuration clock
> >> +                - const: bus_master # Master AXI clock
> >> +                - const: bus_slave # Slave AXI clock
> >> +                - const: slave_q2a # Slave Q2A clock
> > 
> > Mani promised to check whether we should use the 'ref' clock for the
> > PCIe hosts or not.
> > I'd ask to delay this patch until we finish that investigation.
> 
> Right. I thought that his Rb-tag solves it, but if not - let's wait.
> 

We discussed mostly offline, after I gave my R-b tag.

I checked with Qcom on the use of "ref" clock in both PCIe and PHY nodes.
It turned out that both nodes indeed need the "ref" clock, but not the
GCC.*CLKREF that comes out of GCC.

GCC.*CLKREF is only needed by the PHY node since PHY uses it for it's internal
logic. For PCIe node, RPMH_CXO_CLK should be used as "ref" clock since it is
used by the PCIe IP internally. This behavior applies to other peripherals like
UFS, USB as well with same inconsistency in DT.

So we need to fix this for those peripherals also. I can take up PCIe and UFS,
and someone needs to fix USB.

And for this patch, "ref" clock needs to be added to SM8150.

Thanks Dmitry for pointing this out mess!

- Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்

