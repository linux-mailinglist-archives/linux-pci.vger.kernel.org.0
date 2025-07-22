Return-Path: <linux-pci+bounces-32699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89782B0D0E9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 06:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97A354059F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 04:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28179136658;
	Tue, 22 Jul 2025 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFc8kYO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E828B7C7
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753159239; cv=none; b=agIwRoU4+JFNJ9gI8LBBZqMST+E/fll9JQ4CLU2Ki0A89q+ahZGCQYhpJQls9TeegCfRUfTzKiS1tED/D4BXdEl2TvfjZLAtW8imGRI7WfxhfDmw+rive/NFUXiBE93loIQHFvJDeqndQWcrovIEBH31Qkj2hT2kSDyyA6CCFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753159239; c=relaxed/simple;
	bh=DcWnCV5wiDFMtlUyE+DQhJbXPHzzcnoo0XyLl4KiE/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLBQYmRud2bJKr+JS0cyWgDkBttwAP5f0ECo5KP2sAdzU5+T/hi3G2T3jHuczBOKulr0C8U9Kf0mtIk95Siqizt5tVJzW1VZdVfYw9CnMcxn5LTkyUr2h5d8Dwq6lm/LgRebeKjHu8HxPywFrRChBHr4LN4NazWDYcpqgl4g0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFc8kYO+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIfs26003589
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 04:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QcTGOBXUA+STk52mHs0W4PauDtLBRWn0+OXc0q8RYuI=; b=IFc8kYO+nhkzRTcP
	awect8oHXP0U/GDih52NV7CPNIpPNbBkERPbpHB1s61G6FfD2ExRFdytmIh6Q71P
	cMXk28h6Mm4mg+miGb4f4OY9k6RPlw+0mS3zuEYivF5KbJ18HWuBIT5JwHpLw7dF
	07sR39aZLa6RpLhFkaVL+Nw8lYfuWR9BuA3gmlSWG9K4FC+BRHXDY9DMCvm1S580
	++eXtMmjupA7HPhNWcwPvN5ax9uHhudOpouwmbKubs0BI1AZKKYZhmHZPNQxoDiD
	CfTmQ0Vse1I2V/cL974KZXj1rIXm4ag9pKTDYpBJmCQmU9uzvlARyT+8JHLw+W4i
	hHMtQw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v6dk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 04:40:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74913a4f606so3671494b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 21:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753159236; x=1753764036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcTGOBXUA+STk52mHs0W4PauDtLBRWn0+OXc0q8RYuI=;
        b=agVAiun4VZk75RlXYO/o0/Z03Zt2ZPE3CE6W982XCxTUTIdhS5K6Ngcj7nA2Bi6Qgi
         k6+Fs+uhffceNnHaISS61oPcgWW2RsS1Uvz2OFgnwPZaUs7C4F0RJiibnGICLsgCnuXE
         bbwssyu7hk2wRbvNYdD1dXf5Btt41bJ5Q0u0rrg8f9DefBKKWNehJ/H8OG7FPAhmxrEN
         ZsQ8hL2cV+Fp8iyNgzO14BK4DJOXch6oUxTCktvDQndV/rBMroOPe265gDvJ7IRYwgEP
         EQoJaHQCgJA0LLFiVX70EE+JPslj3QoalKpnOydIZHSrPivd4097y9bYhZl6DW1KT2rd
         GP8g==
X-Forwarded-Encrypted: i=1; AJvYcCVWouVeiF1N0L3Q5RgQAE2ixWESWj8JRNzreBRBELHnjUDptbUjgNEb8DAmNOwLU5ybLXc3m+2Fs8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmQ+vD3Izw67CsVT5em6BtFpwN4mgvBbUVlhnvZZc20yLhWXj
	PCI3OdMw/M0DYQWNpNHwYoW6YOGk2VMQjkTQG7wV/y6DZZ3oRrWrvGUJasrqMySmIc0atH+2aCQ
	i1vo8bNByBumbkJTg31SuAyWbFZCkH1hbQc1xNPUslkTlg6NO9+ojUvCEA0BfreY=
X-Gm-Gg: ASbGncuHHWtfyxvtIYBdPCrfQWZ/+gwK97JsGu30HiRB2Z+3JtHWwNclOuV40zk0krF
	1hJtSa51r6EPPOUtZbxwFtqhSsAovLRLr03hDJROdZ3xPugAdF5zPT4EojUega0Wy+VpEe7Y/3H
	p48OXz9U1bL8yywsu2bbNtLnnhocRXH9MSBny8MBPFbd48VcCjNbjoFrlrvhQ/SS0vhNMYmWIw2
	RmBLU3nBXjSR+gnw11BeBWOeWfw6GHhVLSP36Y3XbPEdQku9Ym/U7Y/yC9KdAbLo+Byq/EJl0DM
	4nTDC2L4lctgxlo88/8rRNFSlaxKPkTyxjSA2SnskCQKbNh67wvcOpP8KmpvYI0lzqhdL7DmeP2
	H5sHoiCsw11oXu6wl+A==
X-Received: by 2002:a05:6a00:2189:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-75724876a95mr27257800b3a.16.1753159235227;
        Mon, 21 Jul 2025 21:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1twrNaoE58MjndE1bdJRlSy7dI5BpM3+Jd8iUPOsl/CmInJrgSot5/C3EE7tyMWUpjbzqFw==
X-Received: by 2002:a05:6a00:2189:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-75724876a95mr27257748b3a.16.1753159234693;
        Mon, 21 Jul 2025 21:40:34 -0700 (PDT)
Received: from [10.110.120.151] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e20b7sm6725618b3a.28.2025.07.21.21.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 21:40:34 -0700 (PDT)
Message-ID: <0b595166-d3b5-4b01-b8cd-ba9711c88f30@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 12:40:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Johan Hovold <johan@kernel.org>
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
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-4-ziyue.zhang@oss.qualcomm.com>
 <aHobmsHTjyJVUtFj@hovoldconsulting.com>
 <86e14d55-8e96-4a2d-a9e8-a52f0de9dffd@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <86e14d55-8e96-4a2d-a9e8-a52f0de9dffd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7JLUFdtIDb8Vp3c0417M7avxzYSJe12N
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687f1644 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_GfwqhGknvAR8v4wHWsA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDAzNSBTYWx0ZWRfX1/WD7qZ4h1S6
 45YrylJJvQSORDhmIII3Q1LeEUqobws6OP7q0Gm6EwG9ejx0uijmui7nVUyWKr2U2wHOMopjLEL
 LP2CtojWkURSPa4qa9hBKbxFMBoBH8ZsIDzRtDjFTSIiTSarXr9nTx3cELAn6EM0c+njw8qJ9x3
 XnsBPxDvD3p2v7+CeYmZyLtM6wrmcxWwGYSOYJWGFgNUdBWmcMatFJDeY68Dvp8jmiWgDY2GLep
 TZz1lSQLoREISr8ldW0fdD/4bO8Njs/vsAR7ctrcIN0qP1qYvXqVKgLQaeyhnXfQR7dj30KRCO8
 xS2TYEI6tsKKzFZLC168VS4TF0vpNxbK8iwyKZORmaq5RHxal0+9hbputIxAdgXvBhZWGZCcCMW
 YUcPDq53OF01HWYQHquNF3DepqpUjt50SFJCQE7TyCBA8IDw5bnHVERiyaZDhDI/KdQdnTFv
X-Proofpoint-ORIG-GUID: 7JLUFdtIDb8Vp3c0417M7avxzYSJe12N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220035


On 7/18/2025 6:53 PM, Konrad Dybcio wrote:
> On 7/18/25 12:02 PM, Johan Hovold wrote:
>> On Fri, Jul 18, 2025 at 04:17:17PM +0800, Ziyue Zhang wrote:
>>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
>>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
>>> replace it with gcc_phy_aux_clk.
>> Expanding on why this is a correct change would be good since this does
>> not yet seem to have been fully resolved:
>>
>> 	https://lore.kernel.org/lkml/98088092-1987-41cc-ab70-c9a5d3fdbb41@oss.qualcomm.com/
> I dug out some deep memories and recalled that _PHY_AUX_CLK was
> necessary on x1e for the Gen4 PHY to initialize properly. This
> can be easily reproduced:
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a9a7bb676c6f..d5ef6bef2b23 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3312,7 +3312,7 @@ pcie3_phy: phy@1be0000 {
>                          compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
>                          reg = <0 0x01be0000 0 0x10000>;
>   
> -                       clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
> +                       clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
>                                   <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>                                   <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
>                                   <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
>
> ==>
> [    6.967231] qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
> [    6.974462] phy phy-1be0000.phy.0: phy poweron failed --> -110
>
> And the (non-PHY_)AUX_CLK is necessary for at least one of them, as
> removing it causes a crash on boot
>
> Konrad

