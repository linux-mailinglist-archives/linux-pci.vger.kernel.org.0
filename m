Return-Path: <linux-pci+bounces-19098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9A9FE9CA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 19:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F977A194F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421681B041E;
	Mon, 30 Dec 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3JIZJ5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AD1ACECF
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582932; cv=none; b=UoleDJj/usnhIvS2JLHVQr6BvX7DajlbRh2QEyWl47OzRRlXPSmKgCVb4OrQ3VJH/n05xRYvBbvr8CWFLm8Yv3fLGDpBC6uC6Z8vC17rybuSAnS9ZMqqVNkyKp68aZ0lnB/lI6JZN5FMd28jKp/0RpeEWBAtgYlCzHKDOHy3+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582932; c=relaxed/simple;
	bh=ohF53bAlZOK876b57Tr3oe/521IXGf1Fjs/51DFutQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2w3cxrSwWKmBZljOHNWPLeaNikWymLxznJRWR7ghvhpdnBhPKVuR10oF1T+ItxF8ArsJMBMWU6aUeoVqN6n8V0O0ZDVBHNSUTpO9iONN10/fLSYZBvdTPq9tXjyvW2sPWt0gZqln1SZEx4wZ69IcG1DerRqwoC18R9628a6dRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3JIZJ5t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2156e078563so107646895ad.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735582930; x=1736187730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5whvZzYfxvB02wpstYeTdMUU94BDcz8zNaK1N90VIoo=;
        b=o3JIZJ5tj4Q4rthqLRFbX03w3iVVH4nzv+rERY0ULIXZ4gG/jiXrIRTeL1FsLOEoGu
         7VXZD4wPN2NNCFHmz0OkqifX7GjIMwtCgvn2cTdM7N1QmXHNd5/l+p0IqE5JT2CVMHFg
         ZviJEQIXeLeBj9eNzvf0O/K+K54rbjAM+Ob0TtBG75xEu8D8kwDIpC8i1etDULudTomU
         V93U01gOB43JylOdEXcr6T0O/7cu8ZvURVyooLJn4VheinRfiVMfN8BpNMqN7CcVI36v
         VGqbg3GkGt5xMkwKZ7ZeqpK0z8xTa8Lo2/RSnx7KICqi0qeTtqQ/jiDIk7A8ZQ/A3F5S
         OJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735582930; x=1736187730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5whvZzYfxvB02wpstYeTdMUU94BDcz8zNaK1N90VIoo=;
        b=EnkkpB8MWbDr6JEdtzx71DlrrS34oXGn8lTUZ94DfxL0d1ceJunEa6sNVSz4IHVcWJ
         C6tVz7bf6Rs27QezrlTesBusZAFvql2fwcfmM8HRDAEcgqTmZFrrgif34aZSt60RsEdt
         QCqtwneLVne7njG+lKOrzevr/OIqrzAH0grqDxFAgTcUNitZm8+Ndux4kMCyA/fILNmS
         B+gL+tUPeKZs+NSSbuaijLavcrFAHG5oPh5581TKyRRLXEQdvNyQvwFzryoKBW6yxPc5
         yK8SIMsTv7D+bfbnj3rQNWdKGy6VrDwJWdmqP5stwYLA+Vm/6jx+X/m7fqQuqU1cgmhW
         LJlA==
X-Forwarded-Encrypted: i=1; AJvYcCVT8QFKEcchkQ+gPCqKIIVM5keJ+z6FAAkOcGXx2JtHatwIAJYOvgclmH/ddI4hXy/10hrOD4yj3KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnWOCF2LmdCgKv/6VtN4YoEsOPr7sACI0GkdDmvHqa0CrErUx
	RbgodZmZavTc69mC073jVrb8V70jQQ0SNu2SzsC/mX/GbUjqqfK68MSr/sah+A==
X-Gm-Gg: ASbGnctNIZXEc8mPLe1eP4nWpziKKgKsYVYWP8N1AsjYc/x+Iqi8HXGyKUvpODIsvCw
	W/Kj5Mbpw1ZT1rtWvUeUf6x85Dk3M/hsYCQPc6+g6VnwFJcssjAZ/go69I9JFp0xdIK2m+WqZh1
	W4Gs/kwXTZnwqW6QUyPP5FideKs6CMzFAyGFUYp4tosplOtABqZN7QdurFNg2lWUOJ6DpU94a7z
	kMr8OkhCv21Ig8SBbWZomjcXJD5ZDaoxiC52mtVXK+nKFA42eWKORE6SmJqWSWwYg==
X-Google-Smtp-Source: AGHT+IGmAZQbul0x33kNY3z5xhEmDXlGSFKtrk3n8yKah2UX0yu94Zn1yQJJuIjjti5kcSEoiVFc5A==
X-Received: by 2002:a17:902:d48b:b0:216:7d22:f69 with SMTP id d9443c01a7336-219e6f262c4mr415053615ad.50.1735582929838;
        Mon, 30 Dec 2024 10:22:09 -0800 (PST)
Received: from thinkpad ([120.60.54.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc7edbadsm17723516a12.65.2024.12.30.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 10:22:09 -0800 (PST)
Date: Mon, 30 Dec 2024 23:52:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Rob Herring <robh@kernel.org>, andersson@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <20241230182201.4nem2dvg4lg5vdjv@thinkpad>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241115161848.GA2961450-robh@kernel.org>
 <74eaef67-18f2-c2a1-1b9c-ac97cefecc54@quicinc.com>
 <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kssmfrzgo7ljxveys4rh5wqyaottufhjsdjnro7k7h7e6fdgcl@i7tdpohtny2x>

On Mon, Dec 23, 2024 at 08:57:37PM +0200, Dmitry Baryshkov wrote:

[...]

> > This switch allows us to configure both upstream, downstream ports and
> > also embedded Ethernet port which is internal to the switch. These
> > properties are applicable for all of those.
> > > > +
> > > > +    allOf:
> > > > +      - $ref: /schemas/pci/pci-bus.yaml#
> > > 
> > > pci-pci-bridge.yaml is more specific and closer to what this device is.
> > > 
> > I tried this now, I was getting warning saying the compatible
> > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > pcie@0,0: compatible: ['pci1179,0623'] does not contain items matching the
> > given schema
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
> > /local/mnt/workspace/skales/kobj/Documentation/devicetree/bindings/pci/qcom,qps615.example.dtb:
> > pcie@0,0: Unevaluated properties are not allowed ('#address-cells',
> > '#size-cells', 'bus-range', 'device_type', 'ranges' were unexpected)
> > 
> > I think pci-pci-bridge is expecting the compatible string in this format
> > only "pciclass,0604".
> 
> I think the pci-pci-bridge schema requires to have "pciclass,0604" among
> other compatibles. So you should be able to do something like:
> 
> compatible = "pci1179,0623", "pciclass,0604";
> 

Even though a PCIe switch is supposed to be a network of PCI bridges, using
PCI bridge fallback for this switch is not technically correct IMO. Mostly
because, this switch requires other configurations which are not applicable to
PCI bridges. So the drivers matching against the bridge compatible won't be able
to use this switch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

