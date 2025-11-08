Return-Path: <linux-pci+bounces-40643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED99C43414
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E54E6B44
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1027D77D;
	Sat,  8 Nov 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIEl9Zrd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DokuCfRp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E623D7CF
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631174; cv=none; b=UOzPxqQ0ZN06hpiNcLDc1wWuDo5DDnR3Sk6iQyrHUD9iwHac+DelTFWPeDfKl/vrWGKNbDTS38PFg4XninaRvl/hF5Kf1d+Vd6UskUuGwRdf2Ar7arOtsR47d76RuLIXWJKRmKsli0nzMMB+OVjeR46WGgQFgK9gu8h0r21cp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631174; c=relaxed/simple;
	bh=+Hoil888rGf7WfZpji4y4VNmOyUwaxNOhwYYWlexOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrQYhByL7/jl52z/43oMzU3dMCY1D6qyD0q3wrw0xamuxfSe6QWSdS4zzkiZhf4B0Zogd8jEoNOU3FHyZJqrT03BGcOsC9RQl5D0be7P4fDxgERO5GqAjaBBn9ENM41ZK4pchQ0stwnMCAOLA5TBePEBbyEsf2HmlwumUVjEshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIEl9Zrd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DokuCfRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8IXH3d2474203
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 19:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N5kLP8hDSeanKiERqglKodoR
	Cnx8rVn5yjp6JtXx5aQ=; b=pIEl9Zrd6spWFEWF0oEEF6TNGZQW0DzqEgEONpBZ
	0AhHTZBrEOrCanWbOIRRceZHDYSDpxUzTlMpU1tQ1nExMM83HVfkxCegwwjS8dh1
	1ArQelJGO6WJbYqvWVTWBd/AO4yniwG9LIQCdUet8a8luT8wwdq+6dTxRUtmXKRl
	3iWhjTZ/d0Zo+jbP8F61yRSJ2kEgP8TwNrva3LEKPfETvH7vYBt3HkVsTsmGil16
	HHKWeviIjiod0t5o54aWRjHJC8FiZnZ0FFm2LGMVPQY7SS45Pxgu1Q7V5/azEIX6
	4pZZNRnF/CkyG+Vyu8hV03U+YCo0EfzYMKhngr5xSB0Hkw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xw6h3d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 19:46:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed74e6c468so25147441cf.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 11:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762631170; x=1763235970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5kLP8hDSeanKiERqglKodoRCnx8rVn5yjp6JtXx5aQ=;
        b=DokuCfRplZI83PeUymA+yDI5Q7ALquN8kEtXcdFHD+uDEE46kD3Kkb8m4PYj0hDZLy
         K+4XqmQ3CxQpl7r4trF9yAfxTHQIumnvS/97OLpW3KM6PepfxkMyqNo3Ez/Tg3hy8DsK
         8cqp8mKm2dlzxzOKfl+pMsBDvBgsCwqm14nvTeKHHwGeFcU+UoaXOwdhxFHiO0OWVWG1
         J2J3bI14sBjspLVkCKGCU9nRNoSpN23ykIRl3ZYjRh7xyRQKuWzG8ArtWt6+pxZ1WBG3
         wALIfZwpMHeW8B3z1YSkg+sOWarlUBQkJei7nU+3D1jPWq7hepkSKroyDtqzJkoT/EQv
         DKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631170; x=1763235970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5kLP8hDSeanKiERqglKodoRCnx8rVn5yjp6JtXx5aQ=;
        b=vSAOJ50Nip17UuJAun0qeKY7SZ4W9X2GUwZeL8JdNHHqY7Gohyupnm1QJYcbCQTqQz
         j+2HQC1mIcBlVaIrSWMxk1hiqtXkThZtgLg7ZNGA04V3UuRS3cEIrhyIVZ2+OW015Egr
         IcbtPxLc39nlDHcxcR0kUkzoX7YqinJoHxZ0+/9dN9+fo2OvATrv+z9HBHrUjh2o/LYJ
         YZd9NsbDuP3xidbJcUip2RNn1bNIZb02bQxJbsbOLEcBPDoOO7OBPXxQZxNjL1/kcutk
         uWkUUr9qsoyJNKntc7houPOM835eYovIODRXVY4StZWa6XucnhOtsGOG/B5Z4e4q/h0o
         atqw==
X-Forwarded-Encrypted: i=1; AJvYcCVdBI0RdSh8FLsv8JZq4bhvjMpkdu7aE/2SoJXFyeh6MPfpPgKcMT/nehF+2djXFAZIK1Tz8OzeQ0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVd2PUABfZtkbEWi81jkY0zS8iznDp2fFahFprAbfEdUvxNZnL
	RM+lW7yWK0wmonrgKrGXWU/ZfxKHgV1sV/EUUxJUHfdhpUXVDbz/F2xGRSc4W7luchgHGTBgiDZ
	EwjLGPcdQHJ9QXHMx6VyPozUiwzogMOWImOy8pS1JWPjBSCcUpKXiQdWGkY//AKE=
X-Gm-Gg: ASbGnctNo3sHJYFdqH3spY+JkTjicEiHzJHJ1HQ+0HgmyY+NI36H6OHTwQ1ebvehwod
	rTIj3gZDKfYXaymZ/0bUsWhdGgrg/O7dtB4orBfSk5touOqn9/3Zmv0jZRr1jTKQ7poLOIGRFbE
	Chu25ikQWNSN9nw6xo4nPukFNsB9SOrsK8gLSIJUCnFvewqxerZrqzP9unyddGdGozP/O+088mj
	TpYqmDGnUY3sPGFPwi+EfK6LGY9I7g+UOaNIFmBtACbTH+2q0lhx4I3t2UE7Kde6/5Ktymg7a2L
	h6x8ur7TqAhxS3++LcVtg3f7pLgKBxUpZcF8hPFH2sUbizb5pn/1RaPDfUkhBhlRaI1hxxGKETV
	QQs3gln2sVEWtKHamlJB/htMek3HJSN0nK86HE9KRpP+z60mbUPW5tN15ia6D9fvYPH0unYrF4n
	YLJmJh+mcInHD6
X-Received: by 2002:a05:622a:286:b0:4c0:5e82:86d3 with SMTP id d75a77b69052e-4eda4e6ec21mr42626741cf.1.1762631169997;
        Sat, 08 Nov 2025 11:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxWcQNlieXpFs0/FgNMHfMIB0ifmLg8ipoQ00ZlH0+sZ5XazDWrKkbEsLsyh7hlUoYpPIS3g==
X-Received: by 2002:a05:622a:286:b0:4c0:5e82:86d3 with SMTP id d75a77b69052e-4eda4e6ec21mr42626511cf.1.1762631169567;
        Sat, 08 Nov 2025 11:46:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a840e20sm2422937e87.60.2025.11.08.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:46:08 -0800 (PST)
Date: Sat, 8 Nov 2025 21:46:07 +0200
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
        quic_vbadigan@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v14 5/5] arm64: dts: qcom: qcs8300-ride: enable pcie1
 interface
Message-ID: <3ero2b5vzlyncubdbiknkimytvuelashqn62x5bg2x2kx66ml4@hmmzxt5eiip6>
References: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
 <20251024095609.48096-6-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024095609.48096-6-ziyue.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE2MSBTYWx0ZWRfX8a/neC6EMGsX
 svamfNLBLdMWbU0EnQSg85EQD5qLwScZVUEY3jmTMqcezEMHShQZRqaSKvCXSnszpIED4O2HAMK
 svBBGMfzyAqpeyXkTcHbCbUvDUkvAozHbbsa+LSPczlyPKSgc36tpyVFCp8iS2lhfzme86CcD0f
 K8PofF/+uJj+dsjRwiNvgO3Jt7rhSUAoA+2z0N8yFxK+9ep7KJnoIQSVuMhY8oMm3MLJrfSz84r
 fSgyv402PguOYKOwhp2e1x90yAyHFTh79dH4dSkRrlq5AJvnNJhluCxA/4krdCZRe6Mj0E0wy4S
 9qQ4XuWZn9iFGljblLDB6/fKyp11V6UeAnx/+eyg9mI9jGXHEtRHkQV29qDaRf/5EgqCskFnDQp
 FPQWt5wYtStOHdY2NNL4D0WE5TOIGw==
X-Proofpoint-ORIG-GUID: -5MXwABtPwfrfljXZT2d7hu10hXVpvr8
X-Authority-Analysis: v=2.4 cv=cpmWUl4i c=1 sm=1 tr=0 ts=690f9e03 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wKY8r5YjdiK6585sAzsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -5MXwABtPwfrfljXZT2d7hu10hXVpvr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080161

On Fri, Oct 24, 2025 at 05:56:09PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, board related gpios,
> PMIC regulators, etc for qcs8300-ride platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> +
> +   pcie1_default_state: pcie1-default-state {

Incorrect indentation. Otherwise, looks good to me.

With this fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

