Return-Path: <linux-pci+bounces-42695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83107CA7B2C
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 14:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4433062BCC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4F32ED4A;
	Fri,  5 Dec 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnC9gLEw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MudkPAM8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88932A3D8
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939545; cv=none; b=Y3tCfWOgMv31Qs0HQFcFaDf1SDoU83+7G0JBDGC+99jZGn6pp49XqvOoBK6OSIXSDKsbAWYuDPf68l4ByI7hwHrQCLs2g5FfKvx9X8rRMXuBwBntF5uFgIt4foMrRj4FOw4Uq+e2D+25NmdqNYsLETUw5HoxAXdZK9p9Vt4vK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939545; c=relaxed/simple;
	bh=3nhPu7uGGAKvjMDa6wZEceEP4NWaf5SOIzC+ISjssto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSI2FltS/FS80b+RNPriGP1o6E+aVKANjMDi9lRdFqKEsqJg4xbmqQ5yOdQF2V0yjsIuy8uFDs2D2CardXfYgPsXZap1wBXC+CtRVxql8GVr9YR8zTMfLnIsKz4mdnNa70O2PaThfGv/LnLHsqBmuNwlG8qZpVoDtBu89/9GByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnC9gLEw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MudkPAM8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5AOjx23572474
	for <linux-pci@vger.kernel.org>; Fri, 5 Dec 2025 12:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wr0bffDeE2XKS7jveHkF95o8NukW1ng51i85fFXfXtY=; b=mnC9gLEwEBFJrwti
	SDlp5lPdk4XIoclOwT6bQqPsLchAJQwMffB5mdnFiUYU3I2ISrhynwILl7iuYWiZ
	fPm99PYZaVMgqn+oVk7mdN2geMf4PAwYr57bHsNSWKoLumGBU5oTQwnO5wMA1tG5
	2W01Ot2OfK1qFPmzaKJN55M2831PAdYsgFwIeMcT42uUPswVNf7cFFydeC9hPFba
	8zfwrhT9rSLEfuXPEPjPIueqL2HZsCxLOwWh2nZhrP+u8G7HteBzB+ONYEHk256d
	F4hZYrOh3BSwvkdD4isnjGAA6If2zNl6+YUNir1QGKXkmp/1it+eCBOfxZ/NCjq7
	Q4uk0g==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auwm58cfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 12:58:59 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4501fcc3affso1506335b6e.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764939538; x=1765544338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr0bffDeE2XKS7jveHkF95o8NukW1ng51i85fFXfXtY=;
        b=MudkPAM8qDtkavYPFiyF/560CGwwEq5FNsM4uHtCH72+ZPe1kBggBpuZep9dKfx/an
         JlAcg5iSAHg9woyzkL3+tolZ8i2UuRv8MAlrJe4TFg8EtzrhvWGoe2qOi8+SEoslDtIr
         EmcAHz8XYtPiZ8dU/8+EmVALLlM5aPnpkaAYM/T7qCjlcGh67RwkV+smfLNWel+IaGsw
         8x73Os6voww/hHJ6i4ZS7OLV2/ayacUS7RE5LJsa4gL1w56AzpH3ETJhwWfudMqaAtjr
         UohzhNCHwxs5WtM9jgsI2xbKLY86nk5mj+Wyfl2pVgWQayS6DeqL0juA4lboNzwOVbMZ
         wxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764939538; x=1765544338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr0bffDeE2XKS7jveHkF95o8NukW1ng51i85fFXfXtY=;
        b=HDKZSdsCYTnB2fy4pvvFN71xmlalU0AyuaMjINkRznSwTse7cSVE1xeE12UzgyuJen
         Hp6qfiG2v9ys5IhKjwLn3gTJJXX76IuLZDqpK/NeeGCsg6mRPtJAsTox2OtcHcKGfNJr
         RJCLoGjsKjxFyyBNe5OBWuaTvK7YdczgRIpoRYJScZpkYuykiduH8lIEYAg/yA6aHxRr
         C9JKy5Xe0IwIg7BusDZ/txWxpki12y7d5Um4Uzcak2dlah1sMi6xpU4pumDLUz+RXlNA
         mNeqt7kXI4tSoZXjugsgoWFT8RZ7vWk3UAw59UH9XfXLPLne9ZGxAzKNOMiGEEKiy7Rr
         F2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXmCd2hYW5GvGtYqygIXpKfoRlw466WkqWzHNajk+qF9z5x7+2nTAo2Fj3kr2PgZsvbY6C1upVa2Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bo3Pk3JhfRfkKKBeIWyOY0+bUjMQmCGPtE+1nvDYcLHqfPGV
	Tx6P6ay6t2YyZ7g2H8bsRIZWqjxUBOpCZSAjdCwRdakRjvXn/rKqLHORk+R9N/3Ytn980VM2qUK
	UzZ1M8MmjBssYe954/ksn+bZMT2Eb70ePmGDaJ9gRRofPBp8Z76J1QYrp4ZYuIOWN2BRbvNLZUd
	86+YAh9yfMvGpXm9Ec6ayxDKRZJHZiezYLae1Ofw==
X-Gm-Gg: ASbGncsOw/2XXKDAz0VExG6OAbe+bAyn3CgmXjJttguOz49fWXvsQmO2cqWIgdyMTQY
	PI5FBGLF17JqymRMC4PFM1gWkdJZdtGowtqSFEOX7fwCl2Hlaa4F66dU77t5xfk5ixJ6Xxwk4vN
	FPaU/Yvb2mdbXv3fLn3QCqrrrexDDCp4UAoC3Yf5O0zLLIgq3XmW8FU3GQ7mQipLHvS7pR
X-Received: by 2002:a05:6808:1509:b0:441:cf96:934f with SMTP id 5614622812f47-4536e56bd71mr4967755b6e.47.1764939538559;
        Fri, 05 Dec 2025 04:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFobXPGDIAhxNEOvgOxaoua4CnGH+RHwN6g+zzfSEptfxMbnlM28+uGrHvQR3k+s8mHzqp7iBEBxHuR53atTFM=
X-Received: by 2002:a05:6808:1509:b0:441:cf96:934f with SMTP id
 5614622812f47-4536e56bd71mr4967727b6e.47.1764939538159; Fri, 05 Dec 2025
 04:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
 <20251203-firmware_managed_ep-v1-1-295977600fa5@oss.qualcomm.com> <20251205-majestic-guillemot-of-criticism-80c18b@quoll>
In-Reply-To: <20251205-majestic-guillemot-of-criticism-80c18b@quoll>
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 18:28:47 +0530
X-Gm-Features: AWmQ_bl-6LGnAWWBpQGplyvtMYtPJabWL3Qzt4TbuX3TbwJUmWa_VxNUCnCChDw
Message-ID: <CAMyL0qO2FPBe7N6Q=hW-ymeiGDhABsU+VCj25jzcoQRhBoWbDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: o4CCBYpFW4sO9-7l3E3LKGWKJN2ylkRY
X-Proofpoint-ORIG-GUID: o4CCBYpFW4sO9-7l3E3LKGWKJN2ylkRY
X-Authority-Analysis: v=2.4 cv=XeOEDY55 c=1 sm=1 tr=0 ts=6932d713 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Y2liBin7rq7SVpFgswsA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA5MiBTYWx0ZWRfXyOCffgfn9A9M
 Cw/4AY4Cu66d0mLYK+S1IwJZ3sRRtDCc+GQs1Pp7xeeixLmb1PMDeb/FYQ9HNboxQzMagcshlAT
 58JGY9aXqT9bdmHG4E6sLjhdJdpb5Bvs09cIIvBnAHsU3egtB6BOWRnW7bYRaYijnTAbukndE1c
 /dCFiGibw2E28uIbxepb080sBij87uJrpNCl5rDDyKL9PBILvoV3X5s/DyEI9r3UX8xK1dSJEGw
 dcROBKFiDT7+lsC84HgIrRuLxRDzigMdfw9dExrFvVsjH4LBgpNBVzF2WqfWiofTkVB9NYuFZ3+
 mol1CTqYSBu1mjz1Hu8hM9qf3Oy4Kjn9VGcMYJLOnbJ1f5vtjlYX4M0uv7jIUQSJT/tiRuLA1NT
 UxlzB7ukdsok2E6cAXbotyM8L95WIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050092

On Fri, Dec 5, 2025 at 2:40=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Dec 03, 2025 at 06:56:47PM +0530, Mrinmay Sarkar wrote:
> > Document the required configuration to enable the PCIe Endpoint control=
ler
> > on SA8255p which is managed by firmware using power-domain based handli=
ng.
> >
> > Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> > ---
> >  .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 114 +++++++++++++=
++++++++
>
> Filename must match the compatible. In your case, the filename is
> correct but you wanted old format for the compatible (so compatible
> should be rewritten to match filename).

Thanks Krzysztof for the review.
I will fix the compatible string to match the filename (`qcom,pcie-ep-sa825=
5p`).

>
> >  1 file changed, 114 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p=
.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..970f65d46c8e2fa4c44665c=
b7a346dea1dc9e06a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
> > @@ -0,0 +1,114 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/qcom,pcie-ep-sa8255p.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm firmware managed PCIe Endpoint Controller
> > +
> > +description:
> > +  Qualcomm SA8255p SoC PCIe endpoint controller is based on the Synops=
ys
> > +  DesignWare PCIe IP which is managed by firmware.
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <mani@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sa8255p-pcie-ep
> > +
> > +  reg:
> > +    minItems: 6
>
> Why is this flexible?

The reason for `minItems: 6` is that the DMA register space can be
skipped if DMA is not used.

>
> > +    items:
> > +      - description: Qualcomm-specific PARF configuration registers
> > +      - description: DesignWare PCIe registers
> > +      - description: External local bus interface registers
> > +      - description: Address Translation Unit (ATU) registers
> > +      - description: Memory region used to map remote RC address space
> > +      - description: BAR memory region
> > +      - description: DMA register space
> > +
> > +  reg-names:
> > +    minItems: 6
> > +    items:
> > +      - const: parf
> > +      - const: dbi
> > +      - const: elbi
> > +      - const: atu
> > +      - const: addr_space
> > +      - const: mmio
> > +      - const: dma
> > +
> > +  interrupts:
> > +    minItems: 2
>
> And this/

Similarly, DMA interrupt can be skipped if DMA is not used.

>
> > +    items:
> > +      - description: PCIe Global interrupt
> > +      - description: PCIe Doorbell interrupt
> > +      - description: DMA interrupt
> > +
> > +  interrupt-names:
> > +    minItems: 2
> > +    items:
> > +      - const: global
> > +      - const: doorbell
> > +      - const: dma
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: GPIO used as PERST# input signal
> > +    maxItems: 1
> > +
> > +  wake-gpios:
> > +    description: GPIO used as WAKE# output signal
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  dma-coherent: true
> > +
> > +  num-lanes:
> > +    default: 2
>
> Isn't this deducible from the compatible? Do you have have different
> PCIe controllers with different lanes?

SA8255p has 2 pcie controllers(pcie0 and pcie1).
pcie0 supports 2 lanes, and pcie1 supports 4 lanes.

-Mrinmay
>
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - reset-gpios
> > +  - power-domains
> > +
> > +additionalProperties: false
>
> Best regards,
> Krzysztof
>

