Return-Path: <linux-pci+bounces-33701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A448B2004F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 09:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9128217B1FA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B72DA767;
	Mon, 11 Aug 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VapAIphb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778582DA756
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897421; cv=none; b=p/Ux3eQh03Xw9HIGA9+lg+RxiY6sRmBclBDwqVvseBXDHBjaWI6F7pscXOUrzCfnEOB7v8PrGrz48Y0Wx33GIV/8sW/Gos4Zes2S5KfX3OTjB4qLNABCQ9vy4xDwiIcQlZKs5ar2IBJYzfur1hb7arJoPQRaeqhU838oZLtrSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897421; c=relaxed/simple;
	bh=lckde+jMQk66xn8OaUk0PP30d4mhLqwl/Duo1sMYROs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd+FEiGF1e9yb6PhLcZcWutlenUjmzyR/0DP0HqRgaZ1aaG7QbVVTYFUVD3bmbngO9mlAAUnncJeuY8sxIl6Tf4LTqCR+YKVE/Mukml9coxFlmUsdHor1Hu/TwJy+FNQBmv/hfBPjOYOZXQex7SDVHutnKjkBxh7/tNPWUbS/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VapAIphb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AGVlZt029976
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OcP8VyIXvYe2IEmI7Z5YRpFJhorfq3DAeG+V0H/cwMw=; b=VapAIphbd8bN8TYF
	KwQSuuSb3hiRYQTYuLISG6SZfskrWNw6Y2pgFpEbB6BBiDhnOzKFlZIXPQE7x91f
	yiCK8qaiHN4f7Z/ZBBc8IxtiMo0KpinwBS1Uj+uujrvhAuHJy2yJjmVN6m674Q7l
	fVm98d+K1AYJsop9feoQeqGixCsh7tYiVlHM/b04Oq3K6NS77sreOqYBjJg5mmTm
	WmrYuaB/3Zt88OHfrkMZFNL/u1tv49W9ugzONqGiVbYGe35EH4ugRmwRbZ2SemuR
	m6haRxxUuP8MPAa9zo7icgn36bIc/AhoamaKy2MA7R6VqbFEz1Y2k7A+OL9fzPdO
	T4jqXQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dym9kee9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:30:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76be85bfc0aso3209577b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 00:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897417; x=1755502217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcP8VyIXvYe2IEmI7Z5YRpFJhorfq3DAeG+V0H/cwMw=;
        b=uvP44lHpzmTEd/bj2fgkY1nNXOHLUGLe2YPAB1yVd02WfAwhvlMuw1kBnSIzfpsIUn
         mA6K8b0hfYeZRVKvr86szLgT4KTHYAnlPutMzUcrjyiawlGl/ZXsRBX60X8phpHkhh3H
         6iZHBPzzmCTwO0LlPbQFFKPdvnmqW3GNvv7HuHzGbCX8mDIpoAMpARPpvB41a30OUD4M
         6/aMUtC1yxQDFpHHwyckuzBrNd0EM9DglB4gGV8mDgqWSyul1mkTGGwnIHde1S4EeMZn
         SpIg3Vdxmgk0BV2JMYgsfs+28TRZLlCkJD6+B3fd76kG+ZKODQ3IqcYgXH/dyntG4rfo
         zryw==
X-Forwarded-Encrypted: i=1; AJvYcCVYjXjAgd4oWNCfx4J5Y5liQ9grIzxksl+xS2q0b2oSEul82DzKsYV5mN41Spk7Hp1ahgv9KuylYF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwx2oe6p9q6yVDQGRpSzgR7zBHsQA9MB5SHATGL+g5lbHvk2f
	FEs/Syfkwv1NBjYMB3G6Rw9SzGfCg2CYTCanhQptvyXeZt9chwxMKnxFgPkt+uV6A/w2Mb/BWVu
	sKpvlO9IYaND0ZYGfGMRhewKTtWXAlOuhhCvJPm5eOMX7oPHLXi7rlMP9/fuA364=
X-Gm-Gg: ASbGncu8XJZnqD3gOKs2KvUJlhN2gRNR6CR0Afx/Yb4Iqp1tfmDi1I82q78D9LhcBP4
	N40YrQlrgE7I+8SVG/9XR4N3JSKTl3i2Y0zNs08dwlk72rXh4s/2H/2sakkuEcRv/ZYF7TEeaQ8
	vmrj9NDDkp1w2D2ZB1mtTvejuJkfvrfSXNyunF//sreJgB4NolNQqvbpInp3ZUhveGYuszUvygu
	LFlyjP0Ry+yEL7Denc/EAbRF44kCBwE9SB6ffif65qQMBlbdcdTDTJUQUTAbEzZFbt7T+ip4/vJ
	UCTzlnFIK19NuJvpAJwHGemmVdS5d1ihsY8EBWH+oMbapXLE1CMLIlCT7aHilvFH3TWrfuNEQjO
	IUKniGOHbWfV5YEjdS/yVmF7Gg9Tz
X-Received: by 2002:a05:6a00:b85:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-76c46088bc4mr19460943b3a.3.1754897417501;
        Mon, 11 Aug 2025 00:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcltBUJ0g3R1fj2EUKLW6qYXdOXJ4NHnBg4nb4hNe0riHVIhAk6EPyUknxW89lXsGXleL63A==
X-Received: by 2002:a05:6a00:b85:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-76c46088bc4mr19460907b3a.3.1754897417066;
        Mon, 11 Aug 2025 00:30:17 -0700 (PDT)
Received: from [10.133.33.12] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm26141096b3a.102.2025.08.11.00.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 00:30:16 -0700 (PDT)
Message-ID: <e9e77527-202c-411e-add2-2af9d82b8e8d@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 15:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] pci: qcom: Add QCS615 PCIe support
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250725112346.614316-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250725112346.614316-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ouT2p-wdCADjiAtA4lqnxsNAXY--Np0y
X-Proofpoint-ORIG-GUID: ouT2p-wdCADjiAtA4lqnxsNAXY--Np0y
X-Authority-Analysis: v=2.4 cv=YZ+95xRf c=1 sm=1 tr=0 ts=68999c0a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=0rveLjV9VWli9pvRdbwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNiBTYWx0ZWRfXwe2g0i/btKNw
 TjEClWxZNxUlZmar5oAxMkR9wsCMK1rJ1C84HTR5qpoGsBAgLWID0n+XyfsBWzdenY4gMQycKpJ
 x/sxuuXYaIXP8FvACkC2SLHNKpfghEjKctj71M3ESDQ8G05QeHDk0JPY6aBh4IE26eYlUUVYtev
 0xAy8/kEJqzXkFK5M41YvNvyyOFxpsrGKfQ16m4rjwFpNYE3/Q6El3cJB55dKc1vZR8YyaSewMt
 y1n7Lo6VT/jCw4LhpKuWRScQYb1fq2hnT++YVjvcw28eMw6xhU5LyldC1ArQHvzb8toEY24YAdL
 u5cSpR5Tlk3v3zdWAbxkaFOWSnf0NgLQpiB3h7wrUw35RSGQDGKjFBBw9hh9/ZEuXD2GwJFCrNZ
 aO93vwfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090036


On 7/25/2025 7:23 PM, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS615.
>
> This series depend on the dt-bindings change
> https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
> Have following changes:
> 	- Add a new Document the QCS615 PCIe Controller
> 	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.
>
> Changes in v9:
> - Patch rebased
> - Link to v8: https://lore.kernel.org/all/20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v8:
> - Fix scripts/checkpatch.pl error (Krzystof)
> - Link to v7: https://lore.kernel.org/all/20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v7:
> - Add Fixes tag to phy bindings patch (Johan)
> - QCS615 is Gen3 controller but Gen2 phy, so limited max link speed to Gen2.
> - Remove eq-presets-8gts and oppopp-8000000 for only support Gen2.
> - Link to v6: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/
>
> Changes in v6:
> - Change PCIe equalization setting to one lane
> - Add reviewed by tags
> - Link to v5: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/
>
> Changes in v5:
> - Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
>    version of sm8150, which can share the same yaml.
> - Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
> - Fix the DT format problem (Konrad)
> - Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v4:
> - Fixed compile error found by kernel test robot(Krzysztof)
> - Update DT format (Konrad & Krzysztof)
> - Remove QCS8550 compatible use QCS615 compatible only (Konrad)
> - Update phy dt bindings to fix the dtb check errors.
> - Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v3:
> - Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
> - Removed the driver patch and using fallback method (Mani)
> - Update DT format, keep it same with the x1e801000.dtsi (Konrad)
> - Update DT commit message (Bojor)
> - Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Update commit message for qcs615 phy
> - Update qcs615 phy, using lowercase hex
> - Removed redundant function
> - split the soc dtsi and the platform dts into two changes
> - Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/
>
>
> Krishna chaitanya chundru (2):
>    arm64: dts: qcom: qcs615: enable pcie
>    arm64: dts: qcom: qcs615-ride: Enable PCIe interface
>
>   arch/arm64/boot/dts/qcom/qcs615-ride.dts |  42 +++++++
>   arch/arm64/boot/dts/qcom/sm6150.dtsi     | 138 +++++++++++++++++++++++
>   2 files changed, 180 insertions(+)
>
>
> base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

