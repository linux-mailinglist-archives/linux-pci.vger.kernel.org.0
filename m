Return-Path: <linux-pci+bounces-28948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE721ACDAB6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B27B1745C0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8331DAC92;
	Wed,  4 Jun 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYQVe0Cs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BCA1804A
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028546; cv=none; b=onEe4dPQFBuTnkUbRUKkxprFTg/t2ebHBM4VGBBJJ/gTnWtiWCaexMGm6PnKHx/xl/jyWjyJNY1K/+n8grPbrRCY4RHcEZa2IOWPwLKoMeh9VV2toq34E54FzFxRb8LIycQujorHGek052skAC17AHs7zMIA7OVHmIc9DXCoSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028546; c=relaxed/simple;
	bh=wtbK/c960FCVkZdDZijesw0w08Lsk96bzznoaXRvUIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP1YNYAf77Zr00sWC64lCAP9UWuEiIxbsVLcAWK1xWV8K4hyg65KUDdvVgX8wbQSSiPpuDFGzFyX8VtWmPEW7UofePrikpHIigtAjH25ldXFPKwMrUX7cRJ1Zr+jd3AwaieeexZDHY2bNRIfjczZouFjo7I1ubaRqoAQU7/HcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYQVe0Cs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5540FTDb014030
	for <linux-pci@vger.kernel.org>; Wed, 4 Jun 2025 09:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPPFsiJy+20CJQxcYQxqsy1auSOoSM4WU5ICkQfU8Ik=; b=fYQVe0CsdVilowuY
	OtobuCzUw+CnRbC++SF4DuU9Va9Eu+OTxOXcS1buG/gbWuKVbWLUZNBDZpoRrG61
	VBbThzHVe4eMuCLToa1ss9SwSCZ6IPDpEsyT+oK5Y48SF6Uj8Y8NeAjj59IuzOyb
	1RDxtYkOnmC3Pz3blrt/1yJ94cQec+uH4OQT+kmwD4vXnKFzOULi8ySf5nFsh0L3
	IOuWN5w0wEoTFf9u2Bsk6QmHZZOnszQNkbjsthCIQkgF3aZpM7Zy14lukLAAQdhn
	mbThkmyZurTUl7r4Ce8lCbviLw7gnIFrn2DA0aCedQGL86UXsc2jOm7CS7d5sZUA
	Co5tIw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be817sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 09:15:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6face1d593bso110196026d6.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 02:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028543; x=1749633343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPPFsiJy+20CJQxcYQxqsy1auSOoSM4WU5ICkQfU8Ik=;
        b=NB1xCCpp2cryb0/4vLM003c0B4AyZmJvdH3UyrVG8nS69ClnxDz36MUDPFAqSqoiLq
         sP8h26tySk5lb0QMCo/NWLo8oOniPJmamSg+Ub8sQhrV5y1HlVP7s0rlNgM+rk1pwjtY
         EsLEPNvWWgndVvztp3tNDaCUoG/RlrLbW0V9IvAS+mBowEpkA7+F5eJ92xcT2AKDsJLT
         K0xLO6qND2IuTNgQ1BhNNDJFrurr30aI010vqqLqOdnrykO0a/enX2trk9hhKLHRCXbh
         sE8iT7kgIqn2BTwtQlbmQY+WYrQaH+yJYUBzljD3dR2/ueZulY2c00U2pAhESqlspjoh
         74sg==
X-Forwarded-Encrypted: i=1; AJvYcCXvhEI6nRuzPeZ+Bb/Tx/EFsC3STloOQqseHcB36gt/kVoRKYEXtjhIEopSjYy4XXYjhdY83MHDJ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VcRJfh7JN5ZWGQJ1Ol7SfpwoqwmbzEsKNyymm+SvTyzVI83l
	rKOhvgjyx1IJFrlSyARytrQgOgQjzV97c+sd+3UYmCHUzbrSWzajev7MB2n9T434kAtAeVWdhPY
	goxGcVT06Fko+Buo8q+7dMtVLtKkNc3a4hjt+hf4azxn/2340wWHhKxBo4ncXTSE=
X-Gm-Gg: ASbGncto0JYe6uMFLSbT6IK9WiRijLksvBBuhymUjGYDgLZxEpAZV99/zSPBbp/iS2w
	+qkcyBESyA4XKCeXufwyMlLtSlYT5e+XxhEKmVmoGIhC45PPiK6xrhN21FRWF3EY2HPSQYl47Ij
	Vn1rgD/eZBGGMR9IJ+vc7FQwESdwiLzDAwdRW7/h/PDDPAPfNLCMO+tu/ShAf+zDvApu++IZGqL
	bsyXH91c3rp6x6/TTqM2imfLoc2USCKfd2hNmSxQSNp40MyPzXCPFEEGAXAg1Cn+UeyTguKDh+E
	+4Eq6vZJNNUTsMeFXtxxxirzrHOKQQuTku2zl2+DbZdjpkY9xXRQdknN66bWWEFVE1cpPq9/Wnc
	=
X-Received: by 2002:a05:6214:2a48:b0:6f4:b876:5fb8 with SMTP id 6a1803df08f44-6faf6fd1defmr26946296d6.1.1749028542955;
        Wed, 04 Jun 2025 02:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAy3lVFCTyFps38PYh4Cu1wvRMN2LoHwLW+6LfbUHP84/5730hlAgclrnqK6LGU+oqn6V+sA==
X-Received: by 2002:a05:6214:2a48:b0:6f4:b876:5fb8 with SMTP id 6a1803df08f44-6faf6fd1defmr26945926d6.1.1749028542461;
        Wed, 04 Jun 2025 02:15:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b55f88sm21033831fa.55.2025.06.04.02.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:15:41 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:15:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
 <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
 <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=68400ec0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8 a=COk6AnOGAAAA:8 a=nH4wTwwcQCLCZoaC2lgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qKw03B--OWR3-hUxl0vQdFrzO5ZqX3pW
X-Proofpoint-ORIG-GUID: qKw03B--OWR3-hUxl0vQdFrzO5ZqX3pW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2OCBTYWx0ZWRfX782QNWkh4nmI
 GBSStoLS3Z7NQbdnh04P7l7tqr7dRnnOgt350+9uDtB5GUC7I3jN43FtqsxfPvq9bugisfpYflr
 xYA5LCNUBPw21QpiMRtOb6liSVc4O0Cz/Q5ilDpaKAk1yOUhtcTHs5u9iMAVm7IWcrcWAyZcDu4
 9nS0jnfZftyWTrUvbJoFkUvUWGpXGDa6PBoDU4v/YMplWZA1mtc0Y3syBc0gJAaDgm/UyjYbV3b
 gGpw+of1l5djVDYWoo9okT/FRbkVhJu8Upd0apZyYlx0f9GkbNAFVTEv71OWgsXhwCFYBsHmjRi
 VyaW42wbQ0exwXe4wvpqpFvUGFhmViNPmbyg65sAzugf+4okCZabnciH/yqOvOX69Yl3WjfhoBk
 70Iw7wj5khA8+Wn8KbxosbTKmZ73Ni46YRHDUjdQVYVJLKeXNdC/YHJ5hhT59GxHVWQSRT4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040068

On Wed, Jun 04, 2025 at 03:58:33PM +0800, Ziyue Zhang wrote:
> 
> On 6/3/2025 9:11 PM, Dmitry Baryshkov wrote:
> > On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
> > > Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
> > > document it.
> > I don't think it's possible to "support" reset in hardware. Either it
> > exists and is routed, or it is not.
> 
> Hi Dmitry,
> 
> I will change the commit msg to
> 'Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
> document it.'
> "Supports" implies that the PCIe controller has an active role in enabling
> or managing the reset functionality—it suggests that the controller is designed
> to accommodate or facilitate this feature.
>  "Includes" simply states that the reset functionality is present in the
> hardware—it exists, whether or not it's actively managed or configurable.
> So I think change it to includes will be better.
> 
> BRs
> Ziyue
> 
> > > Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> > > ---
> > >   .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
> > >   1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> > > index e3fa232da2ca..805258cbcf2f 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> > > @@ -61,11 +61,14 @@ properties:
> > >         - const: global
> > >     resets:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > Shouldn't we just update this to maxItems:2 / minItems:2 and drop
> > minItems:1 from the next clause?
> 
> Hi Dmitry,
> 
> link_down reset is optional. In many other platforms, like sm8550
> and x1e80100, link_down reset is documented as a optional reset.
> PCIe will works fine without link_down reset. So I think setting it
> as optional is better.

You are describing a hardware. How can a reset be optional in the
_hardware_? It's either routed or not.

> 
> BRs
> Ziyue
> 
> > >     reset-names:
> > > +    minItems: 1
> > >       items:
> > > -      - const: pci
> > > +      - const: pci # PCIe core reset
> > > +      - const: link_down # PCIe link down reset
> > >   required:
> > >     - interconnects
> > > @@ -161,8 +164,10 @@ examples:
> > >               power-domains = <&gcc PCIE_0_GDSC>;
> > > -            resets = <&gcc GCC_PCIE_0_BCR>;
> > > -            reset-names = "pci";
> > > +            resets = <&gcc GCC_PCIE_0_BCR>,
> > > +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
> > > +            reset-names = "pci",
> > > +                          "link_down";
> > >               perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > >               wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > > -- 
> > > linux-phy mailing list
> > > linux-phy@lists.infradead.org
> > > https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

