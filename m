Return-Path: <linux-pci+bounces-41024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC557C5495C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 22:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80CCE4E05D7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8EA2BE02C;
	Wed, 12 Nov 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqFHfHRi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ks2m1cjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87828031D
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982158; cv=none; b=BLTWUrs+VZl5tv2qc3bNuL6DiVMFIOBsPQ5gBL0SaYoSPajeNjD8tUGmesgPc53t4rzsOYMIB0uMp5+vC2H39AO0nb7P6aWuwgqzG/nuXRWNjNHaEEDfnraMpQcHNimsMPh0Yh0VTN9trlv2RC8EVGNXVWeQGAT2WQ+xthlDl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982158; c=relaxed/simple;
	bh=OZzRji3FYjqR6KceTKkg3Y+UG3edG0Wk3BrnNYUZsrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXu7yP+bfQkBML9FPRG3BABhHEfu5erfaYXlHO6gva3iPeP1pUvZJzznwOkj1F3GGZ1ld5vIPvHIqMeuuvLUvQjIYCzTiKRGaQfM9B+pbOl8pix8DXK1Ys6X8xXr1odARSDy80cTJja22JzMxfa3IWXJT/n9zHUPWppbPUFYSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FqFHfHRi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ks2m1cjc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEJ6Ho1382149
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HGBWrs7DnHLfdEf2UIMKQOz4
	rRJ3a068v2CpxXJAmdU=; b=FqFHfHRiO1SI3v2yuxSfDK2ZL4TkYZ6invjXimWm
	AvP+g2SUor3kQCIbE7uLf7M/kstYiPI4umK0Ii3o0H5hin+63EOkIG9Uir80lpv/
	ky99GAGv0H1EuwiSbeADrbD5FflejhtgzCyE3YiIsmOwO8Op/R4SxnXXj7Pcp/Al
	v6B6miEaMdznNKFa0k9ELmM+gowFgFu0j13AY2WPjvvyBpWv1yo1gLNJAFBomJkx
	+2QsG6PiACDZ1EAtDIRepJ/Sq9YWn3vJd0cPXEtIsrRRnRuxE+Tag3oErr/WG1L8
	70WQbLc3F5PdlzJb+lb7raErXiGB3TIKU6AtJ5qj2O5tJg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw49ar0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:15:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed782d4c7dso2101491cf.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762982155; x=1763586955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGBWrs7DnHLfdEf2UIMKQOz4rRJ3a068v2CpxXJAmdU=;
        b=Ks2m1cjcrtCXb8q1eAONTCUPPB7N+INnl+ODmtyN7alTZBToXOFZhWENhq2jBoTV8g
         2CWSlOXGjGvC/4yvmGqSD8PwcIHkvLftREt/REsdR6qRFoL59G6MgMUE9lt/4i8Jbx0a
         JqJYdAkYW0NCR/jeSW4801uWxokENeLWmbrM0lfE5Aa2veSLsbzukLPtpdIFlEH0m24i
         xoKvLyH5KpzRxsDGtTz2gauPATIXdBmRR5OX4je46aA/6gQQrsHUyWgcu6Pr0gIf6Z57
         4EpnFetjaotu31DaKfiBaVsTGYkSHsq+YP+yXn2JvJ/Uq76GrCKEBKXc/NEznfG/2Uil
         Jupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982155; x=1763586955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGBWrs7DnHLfdEf2UIMKQOz4rRJ3a068v2CpxXJAmdU=;
        b=jL9KNF2EouYY6ZCebYapP9Qid6pI0xINv7nZYX7YYY+iORTtzC4tRKvVcubEYDzt1F
         KpcPdy11toD+QvVoQmzlryUibhlLJElvi91B8LPHbTsL5yY1NoLQB1tNxoYYpsrHCb5u
         axhV7eYdSTJPAG1eCvL7PAJxpX/0JwbZlo9cgqbdwmagfFE9oNmoir5r158v/aRy17m8
         mOKswgCR3+B6lHVK+uS29ZeUTi2hRFm0MYD4WEDV3v3rig2mtf+Ish77n8Dy7gNND+ck
         OgpJpLytQVNLpBoZMy0Ca8MY9Tft1HbCtU6Is34ndkX1hurpQ21x12K6hnId50ajcUWa
         ACrA==
X-Forwarded-Encrypted: i=1; AJvYcCWd4WVvAg4QNaQQggU7ELkNhwFlgEzZFAeMtptBF0yZWS5qVAoIj0N0LiyXUkciaZJAtnDnbFKPjMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycugMu+YaLe2qx85of8SGk2L5DGmVySWkK51AWUf2mK5jBmeOP
	vufiftfFs01R9Mqs1cWOhJ4o9XEaUGnpRigEpbM104K2qMtV2SjjsDU/ZGBzGcXaha0xCGwHCcy
	9EwXpqEpmJoUn4i4WSpew5y0aC8Xmb77/Z8kpWHezWIsiHQLUTZUforjQt3F7o8w=
X-Gm-Gg: ASbGncuovKiValcmNyBoxPcar7aCb/hSJAkEwgX42TjtfCdrU5Z/oi1GOfp6F4RGyn5
	Rh+AJ5J3sLpr1u3ONh4035owRssFaZ+DQPWEyTHPFpKLNvwJ8E6NrKLKYBcjyBPbk0MB0FWAo3f
	XAh9tcIG+6krQwVprIsbWItApDLRSEg6nfxSKObQLRBHwn7lxCeRj87reewNtd+lWNnvjVz/SbN
	LQE5gKB8sPJQbp4e+hKGWmzzMlIrA6k4WzfHAmp2aiUyle23xg/gbIu5CZMpO8iG1OIV41QEuLi
	CLgFozYiHzDSHJ266kDTD7/qc13h7w15YxRGLBvmniDRHo12s0qkzgVBSnYYXlmiOmQ63nUu+Bl
	Xz60fP3of+H0VC3j8omdDbyEY7C1J80sKLawMNpdrdPRRJbeUsT3P+4WgVB6MJdzt/E3xBmmU+I
	1GAe+td///R2uM
X-Received: by 2002:ac8:5815:0:b0:4ed:b2da:9662 with SMTP id d75a77b69052e-4eddbe56a76mr66415041cf.70.1762982155539;
        Wed, 12 Nov 2025 13:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWqFy2kLgPWPVS/huXKoUFZ5R57hNEieCYdk97d1qbnfNL5pgKF8pzTG5alOHRPxvUi3yPcg==
X-Received: by 2002:ac8:5815:0:b0:4ed:b2da:9662 with SMTP id d75a77b69052e-4eddbe56a76mr66414771cf.70.1762982155063;
        Wed, 12 Nov 2025 13:15:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5957c50f627sm668161e87.26.2025.11.12.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:15:54 -0800 (PST)
Date: Wed, 12 Nov 2025 23:15:52 +0200
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
        qiang.yu@oss.qualcomm.com, krishna.chundru@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: Add PCIe3 and PCIe5 support for
 HAMOA-IOT-SOM platform
Message-ID: <q6ztnuiouxvg7kpy6knrnwugusi72xfye6wf2pgfltugjwlbep@mxtt3vm7vx4i>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: U4xdxQmpHnx00cLnYr-QwM3L6BCNkzbg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MSBTYWx0ZWRfX0lUufwaOjpSZ
 3jq3jm683cVog/i0sCbD6j8v6xeDFZ4fvZN87vOJiXUnFpBkOPFg91wdyJH1jqyfO8temkifj9P
 CzFoQvF8r5sz/fnCq1LAC/rthPkqsbtFxHG4LwpHoMJROP4+9hb28xyVRsZT3kNvxj+l7CZU8kP
 hsHJ84XoXhhpQgNMp0gje991qJRlaZHtDRBSh7s6MPORlHWOLWgqNQV6TBj3nXwoj+OQ6XmeSMv
 EYbDGqsavhvz5LRuhK5qH6i8Q3+ZFU3KbzjpCk40q8NCtJWdupHs07RSZB12wIf1k/ep9ToleUR
 QNyetjD98sf938/E8S83zU7zpFFcUfXuOPwPO+2Xq2jFrx3dtUIu23kjnBTdqzDvkAnusj6tCqb
 1wy2V8/pPuBdPBdkezhKwexpEPkQHQ==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=6914f90c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EhQ9wbuxbXqUBhoRm5MA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: U4xdxQmpHnx00cLnYr-QwM3L6BCNkzbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120171

On Wed, Nov 12, 2025 at 05:03:15PM +0800, Ziyue Zhang wrote:
> HAMOA IoT SOM requires PCIe3 and PCIe5 connectivity for SATA controller
> and SDX65.
> Add the required sideband signals (PERST#, WAKE#, CLKREQ#), pinctrl states
> and power supply properties in the device tree, which PCIe3 and PCIe5
> require.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 79 +++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

