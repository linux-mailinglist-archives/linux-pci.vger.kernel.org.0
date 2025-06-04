Return-Path: <linux-pci+bounces-28975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D229ACDED6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 15:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9683A6D8F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CCE28F521;
	Wed,  4 Jun 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPftu2LN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1B28ECC9
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043167; cv=none; b=ZUbqRcZYhm70Tmkq8ESB3N7f1bHVGqJgoa1LQ+Y0vF9CuFJloI/k71r1aKvcqIHP/ANN1MY1p/5FSesa3NVAS5T3b2R7AIBqGbcG2BwJoXiY7vLuecgWV6+t5QHbhNGzT8KU/MWUfmyS6L1Cv72YV9yRnmkLidi2XGm5Qy/pM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043167; c=relaxed/simple;
	bh=wTGQA2MQdl24nKqbtgv4fmUZIT+gcMlYHT8VuLVGmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMeru2pVeNkNFlpKGgPQWdgbOPKYjDHlaCllVRYTOiGW8dysQrYCSehORCgcGpju0U24Uli/bH8jvGdR9KriUs2VN0sCxjbcpJgOGxMEplD/vOVO6CgTr9jCX/TG1jmSFBCyOY9+sEhywRHbG+urjnQ/QpXq5y5L/2bB4AyGW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPftu2LN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548PbKR006413
	for <linux-pci@vger.kernel.org>; Wed, 4 Jun 2025 13:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AswgeJqCiwnzTJPIuOWk5TVVklGP7eakncy9+WM5WK0=; b=hPftu2LNVjzuOYgD
	QJLJSz8nBlytT11l5owXfIWEpJNojejLBK84ukSOs7+9yh9+q39+jmsjdLxKwIBC
	Kt0J1UDIZva9G+acYtDQ9+B0hHlop22mmQAI7kmJbYJCsfufLORoce9gNAlR8h8E
	6uIxS4p11HlvdiUNplzVqllCuOmlU4SHjWcxM23fxZe9xxvx+IK+QXNL3Lwg1i69
	YPTjTai975aW/25RBnkjnpE/CzmEQT3BVC1tRP2q/ea6ex7JsGndZDfXcDeVRkNZ
	+woW3yYpJKV9MZqdtNR2BxPpQ+gDCqGu8nfi+K9pmQtTTnn1TI8r+hiXkI+4OEDp
	b+u03g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8sx532-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 13:19:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a58bbd1848so55886481cf.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043164; x=1749647964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AswgeJqCiwnzTJPIuOWk5TVVklGP7eakncy9+WM5WK0=;
        b=B21YMWxBQ/6cpBMAtHKNCeClhsmSAA9FcZDve4qfPgQbbNXitNE2Syj1trfSVcDAxG
         jAprC6lyAD0dufSDIB4R+hqzl7hC8ECd+Dz8k5Lby2ovlGQUR5sMG5XnZe0wZkw9DFOz
         KWIe+7Xn07um46s4W52WzIoy3vet13nu0gE4b7sWahHxQ+wzQ6TyVLFBNuYfgIYsKo7A
         B8V1Mb+dgJAqE5ACYZ8GGVlnkfG9lSPCJzRqM15nGCE1QjwRt+DoNKixLl73S3+4njgU
         6tAICr2pcZ3efquGEdgBSIvwxDttMUMWRp6L/GHuEOZCcQ21i2tfWF2v+z7aTFQBjMTP
         PgHA==
X-Forwarded-Encrypted: i=1; AJvYcCWPl3GGlEPCpmEAo9tdNQvHDraQv/jgi0ByYkjCfo2kHXvFsitjhDDMMduUc7HmVFOWntOibHGJAl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgpk78dJu8AgMTJQQT0OYQTbVfqvVFuYuSYprqoAeXoppVSK5
	JagjsOTUValrwgg8rcW4ZiePBYHhksV3FkXu+VBi7Ykq3lGXDNssY4TVAY3FFWJUX1AQvIJsL1o
	dMBb8HTYVYuuJfWk0GmEwWFZrSISI0KUUg4XIn8qRUEtHXsPGkHI3hWLO9H38YJM=
X-Gm-Gg: ASbGncuOtufBGqhtlsvjL+sVuHCwkJNzX3GWksNE/uXU9+KovkEiDL9reulXFiODGtd
	C3mGz//aAcDdykpP38OG6R3NM8FJUMtKZceu9gkkNwwc5M31fUr2jkUBxNko2xSZN7PKWH2NZmY
	GEfFKF4qNcdIj44cvpsc5T4sF8wmxaFqge19AFQT2vZSu3Ld7P9S3Ct3si9nZ356Q5HLwP9QTHJ
	HWJXiXtVNJwxfzvNbRolJaTwRagoU2pxyomLCc0FMLiHYWvsz/Hg7oDyZ4XO65hizvkEIEC5UIS
	gCHl9y1+tATeatYiCijWZ3Wmg5Yr1lx3w9IpCxB+NQCimy8+3O/C+Irre7/ok0FtADu05UskYzM
	=
X-Received: by 2002:a05:620a:17a8:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d21a680f7fmr325497185a.22.1749043163558;
        Wed, 04 Jun 2025 06:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxd2DF9ZZitPuPShjI9mgm9ONIB9V2QAlo0khxT5DcL/JlA3x9QRIZjM9V+8DeFW1VeyZ+ng==
X-Received: by 2002:a05:620a:17a8:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d21a680f7fmr325489785a.22.1749043162859;
        Wed, 04 Jun 2025 06:19:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85bd25cbsm23502601fa.89.2025.06.04.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:19:21 -0700 (PDT)
Date: Wed, 4 Jun 2025 16:19:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, lpieralisi@kernel.org,
        kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <mzubbiwkfshplawugahzbtilibnq3wiy6bqetfarbv4kxw46rs@eranz4lm4bu5>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
 <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
 <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
 <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
 <43a6e141-adab-42e9-9966-ec54cb91a6de@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43a6e141-adab-42e9-9966-ec54cb91a6de@quicinc.com>
X-Proofpoint-ORIG-GUID: FZvvmeEjYSxT0rdwS4ekFqQeZmci_jKC
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=684047dd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8 a=COk6AnOGAAAA:8 a=b_c0941waCFHaVHBhDUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FZvvmeEjYSxT0rdwS4ekFqQeZmci_jKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMSBTYWx0ZWRfX1FmGuZQFkWMP
 zfvycZ3v0OtUrYhE67HDl4fAdo9LS3WzXAHtiPAIVMrV/5zVx6vDxk9cehoDe+lsFsNJcsEkub4
 jXhk3hCgO7P9D9k5D/pf9cIHuKOrEYZF40PD9lnBmBLQArP4DTQ76exSpPMmRqNGc5ZMpcEUgl9
 /fD8/OFeS5/dVEmVBqUhRrCdqcYf21+YCxqBUioc1LM5grIup97qwxYF2XXYiEvp/mVydnmu9O+
 yyNRquz7ZhohsMwYNVhwwXbSK0kSikn9adQMeB+AYpRwyR/b5VXimxm39fUQnR/SCOSOwKGow62
 gU+4sfOaYstEGJXwTLpvPebGujH7yLFTv2xywZGJ8jbOsniFeg4R9C+85jU4+gYpQ7cKa0wNyXh
 7kKTcoxaVvuz0/2AZrr81TXQWW/Nms2JjMEdGxOFlOOYje49sCzNjEoXOKw7VVyA9xcpb/HR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040101

On Wed, Jun 04, 2025 at 06:05:21PM +0800, Qiang Yu wrote:
> 
> On 6/4/2025 5:15 PM, Dmitry Baryshkov wrote:
> > On Wed, Jun 04, 2025 at 03:58:33PM +0800, Ziyue Zhang wrote:
> >> On 6/3/2025 9:11 PM, Dmitry Baryshkov wrote:
> >>> On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
> >>>> Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
> >>>> document it.
> >>> I don't think it's possible to "support" reset in hardware. Either it
> >>> exists and is routed, or it is not.
> >> Hi Dmitry,
> >>
> >> I will change the commit msg to
> >> 'Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
> >> document it.'
> >> "Supports" implies that the PCIe controller has an active role in enabling
> >> or managing the reset functionality—it suggests that the controller is designed
> >> to accommodate or facilitate this feature.
> >>  "Includes" simply states that the reset functionality is present in the
> >> hardware—it exists, whether or not it's actively managed or configurable.
> >> So I think change it to includes will be better.
> >>
> >> BRs
> >> Ziyue
> >>
> >>>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> >>>> ---
> >>>>   .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
> >>>>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> >>>> index e3fa232da2ca..805258cbcf2f 100644
> >>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> >>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> >>>> @@ -61,11 +61,14 @@ properties:
> >>>>         - const: global
> >>>>     resets:
> >>>> -    maxItems: 1
> >>>> +    minItems: 1
> >>>> +    maxItems: 2
> >>> Shouldn't we just update this to maxItems:2 / minItems:2 and drop
> >>> minItems:1 from the next clause?
> >> Hi Dmitry,
> >>
> >> link_down reset is optional. In many other platforms, like sm8550
> >> and x1e80100, link_down reset is documented as a optional reset.
> >> PCIe will works fine without link_down reset. So I think setting it
> >> as optional is better.
> > You are describing a hardware. How can a reset be optional in the
> > _hardware_? It's either routed or not.
> 
> I feel a bit confused. According to the theory above, everything seems to
> be non-optional when describing hardware, such as registers, clocks,
> resets, regulators, and interrupts—all of them either exist or do not.
> 
> Seems like I misunderstand the concept of 'optional'? Is 'optional' only
> used for compatibility across different platforms?
> 
> Additionally, we have documented the PCIe global interrupt as optional. I
> was taught that, in the PCIe driver, this interrupt is retrieved using the
> platform_get_irq_byname_optional API, so it can be documented as optional.
> However, this still seems to contradict the theory mentioned earlier.

I'd say, it should not be defined as optional.

> 
> >> BRs
> >> Ziyue
> >>
> >>>>     reset-names:
> >>>> +    minItems: 1
> >>>>       items:
> >>>> -      - const: pci
> >>>> +      - const: pci # PCIe core reset
> >>>> +      - const: link_down # PCIe link down reset
> >>>>   required:
> >>>>     - interconnects
> >>>> @@ -161,8 +164,10 @@ examples:
> >>>>               power-domains = <&gcc PCIE_0_GDSC>;
> >>>> -            resets = <&gcc GCC_PCIE_0_BCR>;
> >>>> -            reset-names = "pci";
> >>>> +            resets = <&gcc GCC_PCIE_0_BCR>,
> >>>> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
> >>>> +            reset-names = "pci",
> >>>> +                          "link_down";
> >>>>               perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> >>>>               wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> >>>> -- 
> >>>> 2.34.1
> >>>>
> >>>>
> >>>> -- 
> >>>> linux-phy mailing list
> >>>> linux-phy@lists.infradead.org
> >>>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 
> -- 
> With best wishes
> Qiang Yu
> 

-- 
With best wishes
Dmitry

