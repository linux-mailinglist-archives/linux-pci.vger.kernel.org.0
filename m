Return-Path: <linux-pci+bounces-33114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA078B14E6B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4189A3BAA4D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065318DF89;
	Tue, 29 Jul 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpnWDldJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7715AF6
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795931; cv=none; b=UcRk5LYa+fOUYVpDGI7g55+Gmk/LB+Ppc/2VztYkhX7wx+GAGzXfXAG4QWF/HxAGeKiKMzxDh+CcGHDMznlO6HsXkwNjEB/v7BkepqBeUZWS59aGb/fgmdt5zmxexsI0lWiqNUJceOivg+qyrr+vphnfVumQpE1izCTPPvfmFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795931; c=relaxed/simple;
	bh=8Ft2D/+C4yivVVIIj7XXHB6bdiwQxNYGInng8jnYwyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJCcup1VZisB9++xfKfB7Hsc96gEbb+a4l0G785ruZTqI7kpHhJZPeq+EH1xGPmmB1AdcjT1jJ3M1uk9CqIjKqLK1ounRJa/ETF7wW9XBDAzZyfVny1Ldg2qWvhsAwTsAi/LpyysWDX9xhHTFPf5RQ9w55c6T8pkmX1b2BxvNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpnWDldJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9EPVq027028
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 13:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rxf3Nnt90oOV5L8CNTt+oQ9ToPCocW8enMiasd1MNto=; b=jpnWDldJ9rk8DHmw
	ADBKBxby2tR09BvFzV5peoYbLgDHaxu1NVUEEVdOAODl8IAqMUWC2G60HthJ6vYG
	/ShgPqyY0SRQrqoJR6iTJkSy5K6anl7cHdIY+ORJWlCLcbUMIdNs9lT3m3By5yus
	u47vk/XSzMKMbBaW40Kp67l5Ddt9no3/5HqKysSgsVFxTIVo6h5QhHjr35ZoURBR
	T/s9WgeCN6sArXuSaSlJkBWjlnp+VV9T45FvpHWJvuSYldnMb/JI5im96jwCtbro
	SAGkx6TbuYH+HHC2q/xV/ileXpfqBo2+FaMlVhJU5KeHaDniMB1dgpL3PyPz4Krb
	Q1vDMg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xr6jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 13:32:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3f357b7594so307111a12.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 06:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753795928; x=1754400728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxf3Nnt90oOV5L8CNTt+oQ9ToPCocW8enMiasd1MNto=;
        b=arjGVEnYn2HQ09xPTAlaDuoUoymxpxT3g/q2jVFG7W5gBiJr8mKvBmqQrOji90YgHR
         yrVfQfwh8csqi6CEULfzB+PfJjnMcy+/vHFgUJQUmC04Zs6/tTb5ANWnkJ8GaQnnKdBj
         TNitl9YiDE/Ofr9xhInN6/CBaaYnPJvwUm5ngN1MMM+d3UqLBac2E6YNVWHF9//Gds3h
         G4PYs9q+Tb/uF/aOZOc70k3krTR2k+4dWV7P45KviLUgoWkYgyDML+0V6yc08Lp7AniI
         NocDuT7RkDmi1C3gzwWAb1xhdMdMg0DpC41ouJOK767OsJphwZSQcB8tOYPUTOkKWizP
         K3gw==
X-Forwarded-Encrypted: i=1; AJvYcCVl/7CcPzJHRwz3DUaoHnbuE3NoUCxm1j6DckG8uExYRWgr7Yp5684iqF93gfefK+x5J6xEKimM5hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiaJ4lDI4T9CZH/fAenm0NhWiyOYfi2yGOJOku7zx42gKcDs73
	+rjD0LBHWwx+pEd5MhIXDVkY6+ZAbrwj5bIirfm5GYX4glDAftah5oZr4IdcCo7Uihys6QJjFhD
	CpzDKtjxW3NWh8JsBqwWUv0lAf7P7pk3I6I2K/v2piI2QBeETK9YkQE5XP+AqsM8=
X-Gm-Gg: ASbGncuqXdKMeXyMpcflG3nJoBtrdy1sYEBOP2w32A7Xe5YWXazs4C5C/PXy9df2XyF
	9qyVRSL3RcZImdv9wnAZeN8/FkWTRGLujvzXFr9yEpipF5aGGyrcjHTbxZpYbzfbR0iIOWhAftv
	77LfPvg3TtoYYzEvJB79hg/S/uZWw2ZvE7OXtJy1lYcA30QWFd7jDWvHTrJBttTIrxDAb44FTQ8
	MUpZ5soMSRmcuR5oxQ5tlxJOG/9dmweZ/iwDQerUzKvIWsm5rW5ofuGAiGUTdKycHEHFZszajEP
	u6Rya5edj/suPTUlwuLDNe65d0hA2b9wxdbgwVWgurRrODVHkM3Mmuqij+sEPUICkXekoInb/Il
	VTQsuksQjkKijE04+mg==
X-Received: by 2002:a05:6a21:4603:b0:235:6606:6840 with SMTP id adf61e73a8af0-23d701797efmr10497063637.6.1753795927884;
        Tue, 29 Jul 2025 06:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGppZH4tBm0B0ZjZxNPeIr5Ha36dgu+n0hmG3OmQx2BO7yLnrEJlDf1YuOvKQHgy5pzupLEDg==
X-Received: by 2002:a05:6a21:4603:b0:235:6606:6840 with SMTP id adf61e73a8af0-23d701797efmr10497026637.6.1753795927390;
        Tue, 29 Jul 2025 06:32:07 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af8f62b27a1sm19823066b.54.2025.07.29.06.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:32:05 -0700 (PDT)
Message-ID: <8dca591d-0a4e-43ee-903a-7a6dccff9250@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 15:32:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6888cd59 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=8Yr4R-HfXjpLVZqX0moA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: sfJeLWKNgI5cUVhuFElPbZ8-wzAcNYCb
X-Proofpoint-GUID: sfJeLWKNgI5cUVhuFElPbZ8-wzAcNYCb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNCBTYWx0ZWRfX40M0Mychj6h9
 /6iPR3SpD2nbfqme/smKoGMpOUVW7XtYyS8iN+yBunnWk536+JnvF3vuqfnw3n+Cy6nsgp9t1+x
 Kh3pD/qDepfJl7xVSBTMPll238U3HEkuam7rQniRVNKhnG0VmMCm4tURZdn8Ape5NpYlqKrC9wg
 80CId0fw8idAw7oygbB6fBcfWVczVRC6aBtv9m9WVGa21SK3ctnamJoNat/uj3U5E+tkrPmEY/q
 CuN/jIcgM13BAzEvpUL5aJeYFOSFvm9Q80O4s0kYF2hWOfp5Ncne+PjLK+f3xw7dxIMWx5ODW46
 WY/L33QTTaFTvRR75G1ZB5atJ6Sh5ILu4/2LbY948gfOhE+WJi8QEdan768IzskDXF/uIqNO3Q3
 F1XCW92uoQHEIB9g7VWSKRuAWNi2Pt+4JdGSO0e1p/xqpi+pQKWoNJ6TO1hqTEjXg8qm11AH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=973
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290104

On 7/25/25 12:22 PM, Ziyue Zhang wrote:
> The gcc_aux_clk is used by the PCIe Root Complex (RC) and is not required
> by the PHY. The correct clock for the PHY is gcc_phy_aux_clk, which this
> patch uses to replace the incorrect reference.
> 
> The distinction between AUX_CLK and PHY_AUX_CLK is important: AUX_CLK is
> typically used by the controller, while PHY_AUX_CLK is required by certain
> PHYs—particularly Gen4 QMP PHYs—for internal operations such as clock
> gating and power management. Some non-Gen4 Qualcomm PHYs also use
> PHY_AUX_CLK, but they do not require AUX_CLK.
> 
> This change ensures proper clock configuration and avoids unnecessary
> dependencies.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

