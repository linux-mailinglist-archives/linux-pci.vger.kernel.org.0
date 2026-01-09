Return-Path: <linux-pci+bounces-44366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A47FFD0A675
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 14:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDB9E30C49CE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC735BDDA;
	Fri,  9 Jan 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pvZqVfkS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GRgZO6pr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B835B159
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964388; cv=none; b=Ga433HaGUpNVVc9ufOMIiD1EYWrUB1yV3yAmAbctI8HYpXqw3ulpGeGlIW2oDdOJIK9Kbb7zm2RavL5e93qzs4m5D2auBnlJlKj9AdlsKwn/Nf7hyu8Taw6CsLFm2ZW3+I54hsO6a00PGoL11nGGYorhcHaKgtYB2ap3l8SUczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964388; c=relaxed/simple;
	bh=n9p+o+jjlXVzSPYGgZ3/XXWIFJwb0MeEoAQo+gx9h4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ3kgsXvxKUlzyJjaM9/BrOPJtM+xElNaajKdm038SxEg3/uAxLHzSTYYz6wOLgP72VnDs4y3Bs5/6mAxChulPlP/AKp3gNKrV3drpxJ1WBHWkOQhjIq0/UYb1qXF+NOTYNEHM0MLxSaBP4Zvp2Wyn5Gno7v+zU4XWDuDrtlVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pvZqVfkS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GRgZO6pr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60975nwp1953455
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 13:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HAQ2jETUJIKRwTk2kBD82NUb
	fvuyEHAaaeAEsNEprpw=; b=pvZqVfkStM/zVnvtVZTSGYW8Lp4Z2Czo4LTEsu1j
	HYbNDoy+fnjhpkbcprnglJXzh05dZnBYuvkpAiR5bm4dL0XlqcAY9sWRW+a5hnwW
	hQ01WWV/hY9rSoTI7//f30+OO+REgit4T0O/Rr2mKnfYnCUzVqp8F5adtiDgCsXZ
	Q/1bIhoZ+kzu2KUUX6VARWhCP23+VUSSv8EDOUo8Nab0BkkA4iXf0IaTSloarI+8
	+M4MmutgVJlctIbPmzX/+MXmWud0c4ch+8i46YniXUKR5uaRz1M7U5wkfq850dhk
	RkpMYtuy6Frh0Uv38H7mRhGnr//jr1W4W3ZN9QQ+itXLNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdabd9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 13:13:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2217a9c60so952059885a.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 05:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767964385; x=1768569185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAQ2jETUJIKRwTk2kBD82NUbfvuyEHAaaeAEsNEprpw=;
        b=GRgZO6pr+SqIh3XWREcVDHHT9YlbDVO88VwYw78sCo5XprIB413vE+9xOAxmP04QPk
         puRwlsT+1lp/58LnJB8mXpZ7Cd3frjCTE38CZXpD/jbe8kwxyzPsFl3mi7qwrahiU9BG
         Dbh7eN1f4FUB5UMBCX8SBc7mceKfMGmyZNsKw9jUjerrYnN5BiuzKGFueSoaVfOGqsfC
         EblLjcPpXYqFIynTOaX8VEHxDUtaKX/i0X0M41WTN8aaEd/PRUPw38HFnVvs5cV408NI
         APjOs6tbfNx07IVeq168uY8fanSBUruw5c4LLAmDdgvb0ZvoMm9FFZ8VJOz5/st98q2B
         K8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964385; x=1768569185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAQ2jETUJIKRwTk2kBD82NUbfvuyEHAaaeAEsNEprpw=;
        b=qDvNivRiCZkEBvzF5Phpn8Wo9Kr/aRG5JbRSoSGB3kmOq2WNFWrjr66GmTLdQpGLGu
         OYAzLf+uyQLtlVQrEYQO7mDT8gdUI/+qBoX1ybJh6VtWaTxkeQo1tbMElMNdZ2J1uilc
         5cfv3+i9al5k28RniDHi6IPK5eGRO5EmVi2k8Wwb402UrUxUbXugIMKWuArDcFDrBFpf
         3efHtPYmlBFYb/c8MlzvQd+wAB0SZkSW10bmHEhFeWwuJXIjgIkw++crL8XnE2rz93Bf
         FV44DdlO7D01H0OStXb7PvoMLs8+ZEk5uKY1OTFIReKHgNvQFUmIWNN0IypjfK+RqOG/
         J37A==
X-Forwarded-Encrypted: i=1; AJvYcCUpfHos9HASE/sopfyrYbHv32dvF5wptyHMjmVvwCUCfb8x0SagspWsywM61JxhL9WMH01AgAUCbzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxDTeVPCp5TRsxKgbduYsFws6cTpnTeEezUqASHhG44KcqDBv
	msQaoezsdePvUO8Wj1HI9hqbjyCNaPSUjAp/pbgPLkjMCvRH05stp+5fW6fRZcGEh5JtUby4wcy
	Y1qEy37zH0xd7Zmz/wEuVjlalZgo7jywBDGuZxndm2lKeAozObnacdrPMRIjRG/k=
X-Gm-Gg: AY/fxX4BsJ4YOSUDylq75jMVtrGJo2DsOnRTjMXOWDD+sd0sQIeX5NcUclMLOA6OQxN
	09lX1FSZgiwD7pgb8iputPv8x4jKhuhCK59Ywimt7i+oAF+DJs0S3wPBBc8BVYkiDWkfCNVE9I3
	60waGaVXVucqkU0u+NVuUARWSYJJF4D/syHXmcF2R8ZfsdfZUtgT746EEKT1AGrpW5hSZD3q+4h
	N2nn6e5vT+RbEPpQFh+iI8RmZ9DLwj1eyah/L3cYXUmkWNiuRzhy8tFU2QrmX+G+Je5hfIgayO+
	jmZYwvSG9Vz+71jj9CGXSqhMtFlb4t6zQC05bZG7wBCdYBKptBjDxYWSdtTn7dGIzJOYekYipGd
	eY2Lcr1xlVqodAGqXHRMgVoBErVmt/abmrUqJFSSut4GreDzH+aeNfJaoyGfwnHLEN1H3faqwww
	+UFesUVzK4uO3YWhYJS6E6bho=
X-Received: by 2002:a05:620a:4089:b0:8b2:e15c:be60 with SMTP id af79cd13be357-8c389429edfmr1392059385a.88.1767964384758;
        Fri, 09 Jan 2026 05:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwjJitLy9yE1EF3Cff9LL6AgsYBdvt5wBqevXDELT0x/mrye2ZYfBbYvnaBJsQ/NCBbtfEeg==
X-Received: by 2002:a05:620a:4089:b0:8b2:e15c:be60 with SMTP id af79cd13be357-8c389429edfmr1392051785a.88.1767964384189;
        Fri, 09 Jan 2026 05:13:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea522sm2781417e87.3.2026.01.09.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:13:03 -0800 (PST)
Date: Fri, 9 Jan 2026 15:13:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: hamoa: Move PHY, PERST, and
 Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports
Message-ID: <xk2har5jvunwc5lhue5j7nunrcnecnljwxz2l7cnxu4sdeyixe@bcflvpgmugyi>
References: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
 <20260109104504.3147745-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109104504.3147745-2-ziyue.zhang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=6960fee1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hO0vvW4Z7aDYz2clpJ4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: KNbKKdeH75wm5wNUXv9R8qJyYoZkDMlI
X-Proofpoint-GUID: KNbKKdeH75wm5wNUXv9R8qJyYoZkDMlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OCBTYWx0ZWRfXx0rgVC3xzVie
 kDyo8qdmvhpUUSJbM5jYzRRBJrtfWLwH9pFE2FTuoTnJmIoJTE2RGjJAL7gPWYDh6bRsSxPcf+4
 yF13ZbJ+k4ncsJh6kCMgl5RwZXK/PFqIL+b85Crq8MRlunhu24MXxE2tSJ0XFG/t3CvNQWCLaRe
 1Ce+HHzffe0lBhTNWVGaHiOyU2vZQl4Uz+H/lrg+HfdjKAmnrgLHkR+d7/Gs9ef213ybWAt4YtD
 xa/TUmJwLwXfESjhpuFPA0l7Q/0C3H02aRRpJhbod2+kKjlfO+t2gstPhmu8NUuO5Rxz3l146ig
 Ej5Js5rTdbBoylBatbjxy0Q48PK32+h9eE1NkabUPDMkGGSQV0UpVPpqu/b9gF3w2WZlgPLX/XF
 Xb4QKPqP1oA10X7Plw4TjTnD3L3rZ2AU5eLKUvPB8VK8p6v9K7UUsEmpFqWaiVATfmXoLo2hNlY
 sYaTr1A+6YShIHeJOlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090098

On Fri, Jan 09, 2026 at 06:45:02PM +0800, Ziyue Zhang wrote:
> Since describing the PCIe PHY directly under the RC node is now
> deprecated, move the references to the respective PCIe port nodes,
> creating them where necessary.Also add port nodes for PCIe5 and PCIe6a
> with proper PHY references.
> 
> And also move the PCIe PERST and wake GPIOs from the controller nodes to
> the corresponding PCIe port nodes on Hamoa-based platforms:
> 
>  - x1e001de-devkit
>  - x1e78100-lenovo-thinkpad-t14s
>  - x1e80100-asus-vivobook-s15
>  - x1e80100-asus-zenbook-a14
>  - x1e80100-dell-xps13-9345
>  - x1e80100-lenovo-yoga-slim7x
>  - x1e80100-microsoft-romulus
>  - x1e80100-qcp
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa.dtsi           | 42 +++++++++++++------
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  | 24 +++++++----
>  .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 24 +++++++----
>  .../dts/qcom/x1e80100-asus-vivobook-s15.dts   | 14 ++++---
>  .../dts/qcom/x1e80100-asus-zenbook-a14.dts    |  3 ++
>  .../dts/qcom/x1e80100-dell-xps13-9345.dts     | 14 ++++---
>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  8 ++--
>  .../dts/qcom/x1e80100-microsoft-romulus.dtsi  | 19 ++++++---
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     | 21 ++++++----
>  9 files changed, 108 insertions(+), 61 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

