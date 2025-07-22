Return-Path: <linux-pci+bounces-32700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC833B0D11C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 07:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5DB7B05DB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B428A723;
	Tue, 22 Jul 2025 05:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VnmMUUc9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968D28A71B
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161226; cv=none; b=PieEfi2KZ+wCnwKtCoTx2Hj1nv2KnV52qRVPt/CCWabef4+f73814wxFjU6UQCZ4+AkUZ6hyAwbrm7vOB1/kLru5Kc1h4iELWRStNLdx7scLqm1LOobqPpFzPoxO/TWt5KZlOfbbVMISzBPB1Q5Q9LVZLjlEn+2/wZHC/xdMK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161226; c=relaxed/simple;
	bh=SX0zAXf2tbGFxsz/BNSsiSjvj/tgQ5Vx0HisWjoxfC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sV1QxIwlPll0L4fb5VPEC1GxUkuogU13oWWb1UTYz7nqiYWS1uPSa0Gs/Fv6qHI3hZB3K2bgktF0f5WErdRn3m40BGgkEstl+3YYrYVyTsETm+GeODbWQ9cBTQQItchSMgjfUTy9YZIpv1FmorA0tFFxApM2ZCvD42p0Ita3MlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VnmMUUc9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIfxwB003605
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 05:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z34TxU6fYQCKQc+baHKHcHj+cYrndlzHUSD8HFvi1b4=; b=VnmMUUc9K5t8rfUV
	5HrKEcBgn0nu9plJ5pCimjapo8/XZeHHwcjwLwReZ+9JVUdxc0DVHz5EDYLsP0GW
	q+oRSmJ4B4nhBPh6cRU5NugIHjkh5GagJgV7IqVtTOhpRpymD7iOKMRAeJF2QA77
	1FWG1SRPvwL6kYwtiIoJ/O3xh0Cd4K2t+Jwud1PmBn686kdnFTb3ZgUsoGnEpAs8
	/yzowqMOmIZh8BqQX9IpP8SmcJIXqjUVoearaSMjgOH3GpKx46k13av4PtsMHBCv
	dH//q0zD7WV7NnlPX7SR3V5mTMY7sJaHewKbAjzDRtJBVpFLGLnuNHn4A5QEhz5S
	zVR7cw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v6fxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 05:13:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso4232426a91.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 22:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753161223; x=1753766023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z34TxU6fYQCKQc+baHKHcHj+cYrndlzHUSD8HFvi1b4=;
        b=MuGsGIQjjVP6tOUPgca+bb0v/Ld7tS7PLuNFlVzcVf9dcCfcsz3mMiceJdkzAj3hYX
         3eYnBoIZ7kkE3AGRtE1tZFsNdbSeE2pNpdxbjLmq4ionuPQA25o+zpBLMVL0NThJN1aT
         +4bbp7tGuylipl0sVOrv8YxDqk21vQsQJQTxXxZ1mrLbWfdZJUMPcb3ms00wI3A+341B
         aSq6Mk5LcnHIKk9xwQwL3lkTIyrdyrOKZfV09qIxF262Tq6b8S0njB5FfkPPfcFPIt7w
         buFF938sG+M3cSAV7w696hjG4OM8gwXR+XNVByk93qkrRVBR0j7K95nJ1yVHsTQI4Uq1
         /3eg==
X-Forwarded-Encrypted: i=1; AJvYcCVTzAYRQ99J1ng+sDkf6uqLvxkCPlr66MNUGfKp+W5jJR6Cy9OXGDSiVBHQrgHNxtXSsVZkPYg6H1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgGJi4nKu82j+0NWaYjFW+qF1dsLGqqP1DX3kPWdlo8z65fgz
	821zonpx6oV8Y3c3MIgZBDsS2t4En9vsPi8QICyUJWCMHMOPGnGP6pGrVAklC8kQlfOorRYXQZ0
	FB8WJV2+EKwvgA3CpQ1D7ddbiDKMntj1E9AiTz4Fhm0zqi/q2HouGjWNUxfF8zUQ=
X-Gm-Gg: ASbGnctvIalsTW0gJvqZQ3aL/XanjoyDHWX8TtZ2dzWvrwe3P+iCyQ5b3ciG46atcnk
	IIg/RsYTo5G9HL3RivUjSXFDt9+XrSStLUm2uErWVXNXqtOmFo2sUOET9QMwKmRO4v08abUXXyo
	yvBBzYDEybY6ZsSpMtw9TmmA06KaHX1aXrhL0P0iKV1pnYHqTuatRU/J2c4OXIkqOgOyfinuRxE
	jYGUOtlHjfw/cMf+e6mpf1Ul/bp5/5zgRQ3babS/HZ/GFCK8NqWUzOx22+Oa7Rte+/M1PTv/Vgf
	FOVhNdklVIr51Fq6w648ljwO6ZKMt83OB68Degxx292MB4DN8Duk9OXlm4getoQnWiyww0vmwnG
	7QF5+f2R8nJQoIMTxgQ==
X-Received: by 2002:a17:90b:514d:b0:311:b413:f5e1 with SMTP id 98e67ed59e1d1-31c9f45b1admr28828726a91.32.1753161223345;
        Mon, 21 Jul 2025 22:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYhGavDIomiy1NdWktoEpkCMViHWPVGYxxFEsASyjKD6sDrdiu2WKJkwtvY2LAXOjFjGQ2tQ==
X-Received: by 2002:a17:90b:514d:b0:311:b413:f5e1 with SMTP id 98e67ed59e1d1-31c9f45b1admr28828682a91.32.1753161222854;
        Mon, 21 Jul 2025 22:13:42 -0700 (PDT)
Received: from [10.110.120.151] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45083sm7115312a91.2.2025.07.21.22.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 22:13:42 -0700 (PDT)
Message-ID: <c7342ed4-5705-4206-8999-e11d13bea1f2@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 13:13:34 +0800
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EQYHBOgDjbB8su3T3URIaPf2VXyH9Et6
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687f1e08 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MOqbobo4jd3P9B9bkYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA0MCBTYWx0ZWRfX6EAkCgtev1Qm
 tY1127F+0geo+hGzrsQPGYp55LGVvfmyhfIzKWGuwu9i9NYgMkVWU7hUiYm2KalQLonmtQNyBBz
 NgVK9NCNiVP3wUAn65hB0CQex2fTVMutgI7zm3rybxkaxmPrQPYyjTP0Q1fmNk+hC1AEoDDxtya
 Dm9l3dU1w63oaE1Bb1uC+XXRM6P5ddeqJdmNuHeYa9MJvAaVdwXxEvL+DHgTWetdzhZgG5CsWiv
 wlWqMMKEOaq8vZWx+qaxHEAwungSdmQbiG9liTWPaYuvM9JDsDolTEc16nz8bD25+VOHAW6kW/b
 28puIA93LEX5ICglOcmXGI6i70BqjspTj9Sam/c4Wq9WEZDT3ArPiZhms2VIs4ZxyVxY8pmd1O/
 4l3g9ufxREh0ixAm7J/DTwKRJyZFPYgVhdhjeHx/K+K4o6zNZL4bZ7opw9lItloCHf2qZ0TY
X-Proofpoint-ORIG-GUID: EQYHBOgDjbB8su3T3URIaPf2VXyH9Et6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220040


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
Hi Konrad, Johan

I tried remove PHY_AUX_CLK in sa8775p platform like this, and
it will cause a crash on boot. And I checked the clock documentation
for sa8775p and found that the PHY_AUX_CLK  is also required.

The changes are as follows:
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7887,7 +7887,7 @@ pcie1_phy: phy@1c14000 {
                 compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
                 reg = <0x0 0x1c14000 0x0 0x4000>;

-               clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
+               clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
                          <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
                          <&gcc GCC_PCIE_CLKREF_EN>,
                          <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,

BRs
Ziyue

