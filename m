Return-Path: <linux-pci+bounces-28859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A13ACC766
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC45F18944F7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A02745E;
	Tue,  3 Jun 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rufqe/D8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155E2253EC
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956302; cv=none; b=CkWEOyuhdbHrbGDJfvQ/APWfKuEWvg/acQuBYL151i+qQvy+KsO1gN+16iq/kg9t7hznotVQP5ruGsmiJhe2LgxXZ+r6Dox4mFibyB6f5G9bQxPsUkgnj0yPTokeDhUB/xk/QIN9TKvCJIIbsdDbhc72HgSDnTkytMCPldmXxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956302; c=relaxed/simple;
	bh=DSxHBEJTE3+uuOMUX4IXmCl9C9IKgdtq7Yhg2vjoBWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfsL3uqXyrcWThU7MXQ/RCHcUWwOMLUKoGSIwjDWMww4V3Zk9qh+HaGGgvH2u42mhYRBfPyB2vkUBrMllpIwQDXrw6VqAigZyIjkxYo7oQaU+bHopeWBp13zA75eLTLmKM4HPbK8JXNsZd6vBqEtZD9SAiRrWHRaL0US5baAy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rufqe/D8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JFqT027453
	for <linux-pci@vger.kernel.org>; Tue, 3 Jun 2025 13:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hkowjwQkIBoerXsoTVXb43GI
	N60uMuMxhmK0iRDbVQQ=; b=Rufqe/D8kes8A+oWpf1AyhIj2j2I3Ay5OjESE69n
	aNjJpAklteOXnWpFTb4qravFc2D9X4A8JTG+kvPtG4Vx3XYwWDDCNX3lskS90cVU
	nWa3tuQPkQIq6gMLFJUIMTIFYyK8+r3Oz/GoaTJtKx/K8+8Se2IKn9nvVXX/sc89
	Wx9Vt0Zr/Of7fB7JOg1rDHi9mYE6d2/YeJoQSQqE++R7lSfW58iUcjT52QBX8ZjK
	p47geWL1PLqV4T9pSSOizefyYhOIHeqHjDh2JOy3tCJNGMNRdNJRNsyKpOjhnZno
	kO1gPlrEuIGAzKEG7aIkBlOydGNo5+I4i2mAd3peXdNhyg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t2ngx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 13:11:40 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-736f88d8e02so734726a34.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 06:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956299; x=1749561099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkowjwQkIBoerXsoTVXb43GIN60uMuMxhmK0iRDbVQQ=;
        b=cE7N4AdkXZzHlvin3Eu7kiHk2q4bBeAIbAPPOW8asVJGaxg7ENlUjYF8hAn8XIh8sD
         y1Fic8dGBuDr3loae0cvfZI1+6IPfK9wQfVHLOQo0hxzUCOhHaGKG5cFjuKAdnwxUlAR
         0yFMcduFrAYp3YiKxvBtzgzdHJilQOIycvbUQQS5CBAsoTXnJ9fAJE3xylXCc99IkEBP
         yetxxcdVH1zUmDLdcxzGFsBkqtGw/PJJmaHxsIiekpll1oA4m8rzguEFKfpkZzzbOsQ9
         3/JdO8B8wQREfVcvL11XoYrQfl/2h7Aqk2pfUXTOM5f2Rc988RDZCjfKLbFNPQ1lYI4a
         cbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEhkJfaWD/QwpkNhHPOdSSXTtjXeJqD0pVvlwV9G8epYKOckLrCqcN3RCANZMLC2hCnfAqJbx4gx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1t/rfi9FoWSvAksSwN2no9wfBZUf+Kyd2j8cgr4a1YHM3HzJH
	5+11i45Ryf0bF+TXnR2ZrG4acA9iqRohPzfVJIePHVyLo+DXrdf/GryiDm6I/36xjo24sc4hSh7
	kEr126Pwj6OX3nEOHpX075pqGBrzITmzzo96mVkS8yp1bUE1kML2fwC6beoSgw3w=
X-Gm-Gg: ASbGncuajftJkXFYGjL4VuSwiKOkpL3vEag3SQRzoP/0ALzJF7zzlMZ2dnM7Wy/Pwgj
	nT0lANmv06KRgBLpcwyi6Cv2U4auGAvcMUGNtXmpUzR/el3xA/1wtyg4tuX02C5arqvJHZOKukQ
	Yc9yHITGZ4YO5RmyZxwaXd5V3r3LUY2si7fqYsVunfwFmJ0ffc3bWYDwg9SFQr4obgeaxwE54aE
	TBB9ShP/+Vweeo5LZs9COjUdDw1Fex8BaG9Psq29OynY+R5st4jjqozbiFrnyzVYpfdSv/xH/Jc
	553iaVF5NPkoeBUF+4ANwdLKCE6FL+WOjO4KWJ5gvMYftDyHwYm2SqrbUfAji/3PLCDx4BL6F24
	=
X-Received: by 2002:a05:6830:3c8c:b0:72b:8297:e988 with SMTP id 46e09a7af769-736ecf38198mr9861964a34.25.1748956299386;
        Tue, 03 Jun 2025 06:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrv6xy9Z9gKos6U7bwZdGI8uQ9F+7hgkYBjMqaT3/DoXyQAJAhoI0Awytxg6+zEQ8YdBqDPw==
X-Received: by 2002:a05:6830:3c8c:b0:72b:8297:e988 with SMTP id 46e09a7af769-736ecf38198mr9861924a34.25.1748956298927;
        Tue, 03 Jun 2025 06:11:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55337910f91sm1920796e87.157.2025.06.03.06.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:11:38 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:11:36 +0300
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
Message-ID: <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=683ef48c cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8 a=COk6AnOGAAAA:8 a=MMspel2jwrA65jTUX34A:9
 a=CjuIK1q_8ugA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OC88g84ba0L-STfUpchg1HAjRjMllbxi
X-Proofpoint-GUID: OC88g84ba0L-STfUpchg1HAjRjMllbxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDExNCBTYWx0ZWRfX85BtLeHlPUU9
 nTMj+v7W/A4SggTjiB0anJC3HPUB60FQL1BLGVd6pWGAkbi9oQ8PgDu17vdfTYcAJ56sEIHdGOR
 +sultnQYm+XRU897o9VBwSOYlqLaUkfLkcTlWTckNCJxFe7huHyLcEdb5UMTj7rlMNwWSEmD4gn
 FR+01tyffybn0//8XvZiJdWPbLLmkAjJK/8FdGGItBVLwhWylxMiX3L5hJzXqOWb+x/ReJ8nh4T
 VyYoEh37mjltHrOvg7sxNbseh2zfbGI+1GUYa+GbfTLyn63doD7An9joufruOaEGj22nWoqyL+r
 4GDD12/LBS8NFwcY/vlbf2Ym/9J+ZBB7vbegC6Sfods9e4uGTVo2KI7McUKytUBKFvM8rVLPXBe
 rfCVkxUTyd8JpFvLedxCMDcKbUhNRdoKHrwscGINw+P/fH3adIWFZvQdrsaerPfLT+1PwRDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030114

On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
> Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
> document it.

I don't think it's possible to "support" reset in hardware. Either it
exists and is routed, or it is not.

> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> index e3fa232da2ca..805258cbcf2f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> @@ -61,11 +61,14 @@ properties:
>        - const: global
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

Shouldn't we just update this to maxItems:2 / minItems:2 and drop
minItems:1 from the next clause?

>  
>    reset-names:
> +    minItems: 1
>      items:
> -      - const: pci
> +      - const: pci # PCIe core reset
> +      - const: link_down # PCIe link down reset
>  
>  required:
>    - interconnects
> @@ -161,8 +164,10 @@ examples:
>  
>              power-domains = <&gcc PCIE_0_GDSC>;
>  
> -            resets = <&gcc GCC_PCIE_0_BCR>;
> -            reset-names = "pci";
> +            resets = <&gcc GCC_PCIE_0_BCR>,
> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
> +            reset-names = "pci",
> +                          "link_down";
>  
>              perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>              wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

