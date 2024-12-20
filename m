Return-Path: <linux-pci+bounces-18895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C59F900A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC38165FFE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E761C07CB;
	Fri, 20 Dec 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IHlnk6EH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906C1B415C
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689813; cv=none; b=plCVxZ8ICc9WuDLMgXDeelZZX7QSytV+Sz0Ctzi3WCBJUY+1TdAtycae64e1Glq583QehWxE4nIWeVKuKyyFZfjTxMPat1lmugleioZK3iE0EfPqqk9gNyKv92ZEgt4woQWSP4dF7WCFb/wgIh+yBHOJW7Ki8izijwppNXuIZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689813; c=relaxed/simple;
	bh=5R7CB7AFTdIVrbPPSKsfjLemVrbLO8eYcwPqosVDzUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+lEaw9b/OtGckhVz8i+ZVuuQRH0AGqa6vN3J39TghPA1A2mSVKOJZD+DXCN5ddChov40mxzc1s2qoAJUXsNcqLDxE95wcRzD+oLAQPINzogXkchn4K0ws6BoA1rowhYWJ6jhLzMYB7FaMgXuQS4GSOr6KEyOyY+NLqGSupX6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IHlnk6EH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK7Lh7D029442
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2plerijmrwjFfyc03fiI+ZOSqEAbdDcNmapb7eS9TvY=; b=IHlnk6EHMnrBcZ74
	IKAC2zADG9qYQgtXmozR0PEucoOftxMRiS9YvXMXIDmbLM4/UMAXuChrYmjqnURF
	TKT2UaBxJjHDrP/oh3PhyRNPbgd/zFJb4pt1iLe1Ij9AsZBAhLeVZxz7jKrn9fCl
	XOy5PssEaTOkYgkhwJHtaFtBoUk2JaIwx7ZvzDut3/teNLvfhvpD4WOJ4DHAdM+s
	dzIzTwtYvr+RPvc+AEeYL4J5BzTUyulRsKKaNGvquvrm0cND5UZQVyPIY8n4bIv1
	Aqyf2N7G/yWuQZu20YV4eUoyemF8abyU6/fq/swgfHpEwR9K8i+OZY0diiCXjOss
	Z452Jg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n44fggn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 10:16:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d880eea0a1so5138336d6.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 02:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734689810; x=1735294610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2plerijmrwjFfyc03fiI+ZOSqEAbdDcNmapb7eS9TvY=;
        b=qkTCkoZ2em/anQIUUfTHf7ogT7cSYUY7Io7tBMW2BAiiK1pBlQYd1iryWHX8pq/r82
         h5+CTHWgM5i6ULHx+Jat6gsrfRADQ5kdOhxP5Yg3e8DTgUBdcN/ddo/+MrGySqrk65RK
         uDwxtuYUlnlZP0JJ0EgFMFPzcoIUETwl9gvUjMUwmSScp4QjU8uFbcX6NOhxNoZpsePX
         JY79SLtBR+wvtg1wTiy2v+50T2fpu5nDRI8jU6V8OG2DoTY3oyJ8AOJuL/JIT6h5Qeuy
         +OCMGqXybwz1vvR35ISsKtsj97V8QQ6k7bz6UgMGeq44Z8IBBfIhp8sWl0N/bMsZyF7K
         hXeA==
X-Forwarded-Encrypted: i=1; AJvYcCUgRHT2X8lFNAdCuqsM6rLelL6H0GiOGFXgf9dfXmq/qY3/ngjFw+dk2wLJpYXfHt2uQvXQnPZ5aQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBrNQ4oeaZ6vMVIYjaeA61cqmjA3/KOnttwUjXtVMDn/w3JR+
	Hq6wahYld8hK4Uj9Qcd1FEJ3230EVVsDB3VXbzGJCq2STV/YontlYpnFWNc991uN8VdAvYFFMIB
	KXMwI1HLXCILeQZb9BUvBcDXt5bI5CFqXHlzRShvJS443frsuENXvAGntCNA=
X-Gm-Gg: ASbGncv/Y0IKPSJKFVoG5BCv9W/UoMXEDZlLyYHpiO+zX5itD5iGHtHvgDAqrfsU1aL
	sXNDmPSnIYXouXKGZ/pC1jJTMscPQiKTvTCxg/bg7DMbiMWMfqncbA1vdIDVhUmrd2D4s5VZYUw
	xK2rvb7EnGnonEK4GD5Ed10LVdNwMSrma/31NIxA6q+YUEYKHxgn62976kBWISyZt1ba1k88AsA
	tgZLMPl1oV3OawuBs8Yiv63bMTXYVvQ4z65Cb9VqFO8NAo2XKT6EZZ0T8t9QY0nRJoJnR3Biqx9
	jRSjS9azGLco8tMZedyKmTpPczQxkLnVpYc=
X-Received: by 2002:a05:622a:1183:b0:460:900d:6052 with SMTP id d75a77b69052e-46a4a9a34c7mr15453821cf.14.1734689810028;
        Fri, 20 Dec 2024 02:16:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbTjysDU3iJ2soFkGdUfDu2M048DzuQYp6VI5Z0UlAKsD+pGIOi2Js+UX7PhFTnlIclh6ePQ==
X-Received: by 2002:a05:622a:1183:b0:460:900d:6052 with SMTP id d75a77b69052e-46a4a9a34c7mr15453461cf.14.1734689809515;
        Fri, 20 Dec 2024 02:16:49 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f11dsm1569766a12.46.2024.12.20.02.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 02:16:49 -0800 (PST)
Message-ID: <19fa7f66-ab50-4cd0-8fb7-4f126736ebc3@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 11:16:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: qcs8300: enable pcie0 for
 qcs8300 soc
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20241220055239.2744024-1-quic_ziyuzhan@quicinc.com>
 <20241220055239.2744024-6-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220055239.2744024-6-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UHEeRdrzmBbqbMB3Xt7oAn1BOyxgEo64
X-Proofpoint-ORIG-GUID: UHEeRdrzmBbqbMB3Xt7oAn1BOyxgEo64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=583 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200085

On 20.12.2024 6:52 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

