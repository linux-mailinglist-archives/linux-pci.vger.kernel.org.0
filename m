Return-Path: <linux-pci+bounces-20450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A799A209AB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A060163E96
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E751A08A3;
	Tue, 28 Jan 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SP9Eta+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5C19EEC0
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063601; cv=none; b=PC3FntPsC5YepoVdDb71H7O0oSTKdQnBnUrP4W0mu6URkwrFKXxwRFroZMKbjyuCXBt6cAUr1Q+7W8+0o2LilZvbR7GSrhx4NZngARn832JII4dyrHPuBOh1+sivp1owYZdUlGo7tlKs7v9OslxLnuGY23XJt+o8fjGTz4oOuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063601; c=relaxed/simple;
	bh=dOoN1H6FsfncEe5JvH+mItBiiJZFYhO8jumBlOj6SLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC+Imr0gTyz/NJLU48VSgwmqfgYh8HAlisyWB7n34SnxvNl44IXZAoisZo/JfgPFf8nFriBFnb2SXkc8eryUWJxo5MfgJ7IGB4P6nJTFSCvcmgKMlrv1hIKIemNMtC/SihwqCAMUNC5hWVnbevpPvcq+nifSWuxJTB0UvOzSa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SP9Eta+n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RMrOgs032612
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+S/4n15YF+vLVuteKg1xzKfW19B0jPDHe/Ppx9S+E6g=; b=SP9Eta+nduAfb70T
	bkiYWR3DjAY/2PKn6/9bReWzakawRinrwcjojb19vlx59DhVqh4X5TeAdn/DZ3e9
	Li4WjwytudG2WpXi+kTvIO2Fqzn4ngrqKaYfcFJ4qjkA3IRi3XaCWVS37y2/SDCU
	jn/U2gYVMYByDJLA4y5NU4dGN+RGzUWYDS39H72TwLNra5GISyDyGSi7LPWM+xGd
	vjunKOrjI5R9GnZb/rxPi1r5MGA8l0u/m+qIxTfLDGmkzcUkSY/AcAdWFlAhPc7h
	sF2/aLDxXbiOxsgHnN30bh/8kvhWbSIzAXLucdZgMDM2rvAiCGW/0aUJHOdzz1XO
	mofd7Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ekb89af8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 11:26:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e43ed084so113294785a.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 03:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738063596; x=1738668396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S/4n15YF+vLVuteKg1xzKfW19B0jPDHe/Ppx9S+E6g=;
        b=ks/xFF2VfusvINt2QTH703XFdn8rus1xh8hKqAlqdF8t3fXZ8sX/5D2B5UfP3MDE+q
         Xyc8roh1y9meLiYKYwPFoGrpbIG2ajY05piKGa2i7r1vivXsm0k2nkzvn57Ly+cTQLU+
         28AJv7EiwtOklJfO2Ix/CVIM2RiCc8vgg4ZGiABynyhkda2P6mm9nc5LtSPH7MUtIkSp
         jn6spSNxA71cAu3h1foFSiXtU9sEQGpYcnFvBFjGDQtuz6JxaSxkC5hC5VQFo/j50VXe
         LRI/rn3B4w4B6ikApdShhfDQMQrOU69jPhVLrvEPrwEJLDETESYk+YQPYjHGmsAX+4VY
         ZUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYLWZPtNkMOSMo1qcEbpifRKfOutco2rnJpN1Gg/k2lHtH1ZC5ogZiVNt+LbK/4CdXljrTCZ/2Wh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRti9g4TwKRRAZVzXuTSrTNaZQeOW90HjrU9ykwZJTnOp8XGch
	+Ib382AaO5WVBgiqEg7Sl9I7UminyUx6s4OpQzF/Kxr0YVdQIPrLl1zGdKmg7f93km/0/gGQdW/
	CsYsjGieMVjJBKQfvzNdVACuEWDpL33uzZC+g/YCZr93RPR6ZWAXPAqkV6S4=
X-Gm-Gg: ASbGncs676WPYtjVYRZPMRdo03EYe5U6mmtQFokkl2hrnnO0XUs6tE9x1IStrb8j/jk
	cwkESKCOMfG87fHj1n3YbQrX8gg2j9bT4uOsFF7XeIUFgDnKjVG+gU026Gtvv+Dqy+e01fMlf8S
	KntdYhDfW066jPTK5LVvOQHR296UQwuOEvvq0yKhZOZldTSAUv11D5ctNfABhjcfhARluEVZN+d
	aiFX5DXL51dphJKcpwi/hH2Q4afaazNTneDw7QuC+y7ym4LbqRT3etyrQiOLvyeLOLncl4ryRvj
	93WlazZ1Uo93TMjq7IsOngeyRivejSr87DFDpfUOVSYXqxPLRCkViO2P1QA=
X-Received: by 2002:a05:620a:424f:b0:7b6:dc0f:406c with SMTP id af79cd13be357-7be631d330bmr2710921885a.2.1738063596548;
        Tue, 28 Jan 2025 03:26:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIC9noFjSJ2CvWjxQive9gz7MmGb2ik624YqYy8TWgSNgPIPR/3aCC0pmxzOUK4QB9uZbSKQ==
X-Received: by 2002:a05:620a:424f:b0:7b6:dc0f:406c with SMTP id af79cd13be357-7be631d330bmr2710919385a.2.1738063596173;
        Tue, 28 Jan 2025 03:26:36 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676116951sm752369466b.169.2025.01.28.03.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 03:26:35 -0800 (PST)
Message-ID: <56dfc864-9a7e-4954-a7f6-91ff6b6d05ec@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 12:26:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: update interconnect cells for
 ipq5424
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-3-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250125035920.2651972-3-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YDBIe-hMjW8prRzcS2ssj4wJERY47B7t
X-Proofpoint-ORIG-GUID: YDBIe-hMjW8prRzcS2ssj4wJERY47B7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280088

On 25.01.2025 4:59 AM, Manikanta Mylavarapu wrote:
> Interconnect cells differ between the IPQ5332 and IPQ5424.
> Therefore, update the interconnect cells according to the SoC.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,ipq5332-gcc.yaml       | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> index 1230183fc0a9..fac7922d2473 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> @@ -35,8 +35,6 @@ properties:
>        - description: PCIE 2-lane PHY3 pipe clock source
>  
>    '#power-domain-cells': false
> -  '#interconnect-cells':
> -    const: 1
>  
>  required:
>    - compatible
> @@ -54,6 +52,9 @@ allOf:
>          clocks:
>            maxItems: 5
>  
> +        '#interconnect-cells':
> +          const: 1
> +
>    - if:
>        properties:
>          compatible:
> @@ -65,6 +66,9 @@ allOf:
>            minItems: 7
>            maxItems: 7
>  
> +        '#interconnect-cells':
> +          const: 2

Please apply some criticism to the review comments you receive.. this only
makes sense for platforms using icc-rpm or icc-rpmh.

Since this driver registers an interconnect provider through icc_clk APIs,
it explicitly uses a simple, onecell translation function to .get the nodes

Please drop this patch

Konrad

