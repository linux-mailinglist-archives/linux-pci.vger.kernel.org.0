Return-Path: <linux-pci+bounces-22450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C6A466F9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 17:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB38F441778
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC162221DAA;
	Wed, 26 Feb 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpQYUG5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9B22156D;
	Wed, 26 Feb 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587387; cv=none; b=jlohUgZZgIPlVjS092Fo1IF6xpdPEPOPDCSpWvw/Aqa9yib+MLCT0tK+xAFVUhqu6af9W5+IUOKOK59qEzoBBoDe/V/ayhkvrqB49NJpPwFQ1VXUlaSiWkwIKqsWqKTGiF1uAFmYMHXwPin30GzOZnWQrLzA0QACcP7baWexhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587387; c=relaxed/simple;
	bh=pY1PMMO1kQlJnU8fk1/fsbfXs23WgViBrJEo3FA87H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXxcpZORSvbis0OMOX/8j0pbchnshFltWgWxrjGFLwXbBD8RKdi+3Y/0f57h4FfFZ7aH4PIPTs4i6zJlNgMZVIaAM5fRSIBW1AfBY1C6l6A769ZDIECTGnBNxIjwkz5V3V+gJAaCkzHwiyI9QCnkVqAt1sQVovcz6txovSfYVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpQYUG5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC07C4CED6;
	Wed, 26 Feb 2025 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740587387;
	bh=pY1PMMO1kQlJnU8fk1/fsbfXs23WgViBrJEo3FA87H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpQYUG5OusJW/BeCsiZT2MR67N4+Vr9DOLUdhLRPLWVV1hQ4OA2zKuoiDco/8aGmK
	 T4YvmjXKaRf/EiW/z2lMYhu7LpZJ5UMTZJHi8lzRN09Ko0NGCgGc4D9jSBThgbStCe
	 rvwGSGI6upZyxdrusAb37j+BAdgEjV8BLYI7at1xMvxyhXUWlTKOY0AbgngxX7hVwV
	 Ui6iXVAYewRGI/nkMK2l40z33MXL1vvcNhRjqCUdfu4RMosJVIIqUIqB4qMAroDREv
	 snBUgRqPqgJDVmVJlqwNj56i8tqaIn9AISb/VI/qLnpn4AQoXmTor58t1aqVyU4O9W
	 opr/I1QbWuZxA==
Date: Wed, 26 Feb 2025 10:29:43 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chaitanya chundru <quic_krichai@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com, 
	amitk@kernel.org, dmitry.baryshkov@linaro.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 09/10] dt-bindings: PCI: qcom,pcie-sc7280: Add
 'global' interrupt
Message-ID: <t34rurxh5cb7hwzvt6ps3fgw4kh4ddwcieukskxxz5mo3pegst@jkapxm6izq7p>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-9-e08633a7bdf8@oss.qualcomm.com>
 <20250226-enlightened-chachalaca-of-artistry-2de5ea@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-enlightened-chachalaca-of-artistry-2de5ea@krzk-bin>

On Wed, Feb 26, 2025 at 08:32:42AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Feb 25, 2025 at 03:04:06PM +0530, Krishna Chaitanya Chundru wrote:
> > Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> > to the host CPU. This interrupt can be used by the device driver to handle
> > PCIe link specific events such as Link up and Link down, which give the
> > driver a chance to start bus enumeration on its own when link is up and
> > initiate link training if link goes to a bad state. The PCIe driver can
> > still work without this interrupt but it will provide a nice user
> > experience when device gets plugged and removed.
> > 
> > Hence, document it in the binding along with the existing MSI interrupts.
> > Global interrupt is parsed as optional in driver, so adding it in bindings
> > will not break the ABI.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> > index 76cb9fbfd476..7ae09ba8da60 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> > @@ -54,7 +54,7 @@ properties:
> >  
> >    interrupts:
> >      minItems: 8
> > -    maxItems: 8
> > +    maxItems: 9
> >  
> >    interrupt-names:
> >      items:
> > @@ -66,6 +66,7 @@ properties:
> >        - const: msi5
> >        - const: msi6
> >        - const: msi7
> > +      - const: global
> 
> Either context is missing or these are not synced with interrupts.
> 

I think the patch context ("properties") is confusing here, but it looks
to me that these are in sync: interrupts is defined to have 8 items, and
interrupt-names is a list of msi0 through msi7.

@Krishna, these two last patches (adding the global interrupt) doesn't
seem strongly connected to the switch patches. So, if Krzysztof agrees
with above assessment, please submit them separately (i.e. a new series,
2 patches, v5).

Regards,
Bjorn

> Best regards,
> Krzysztof
> 

