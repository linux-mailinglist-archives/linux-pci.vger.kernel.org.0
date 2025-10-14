Return-Path: <linux-pci+bounces-38002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0BBD7098
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C5404ED70E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AF3009C1;
	Tue, 14 Oct 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nq2ymSzx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88F3002C5
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407250; cv=none; b=hvG+TTll64s+VLyQyQ0N5aJyDoytMB4G4hDhqzIeGy8LZ5n/7esExtd2EVRWTsy9nOZ5jYnQSDv48Bt83PlDVXjANFE3BoTmUyS2KCYTSbY7tgdVLnfrx+5QEYtUf5gXkx40qtV89JWhb2DKjXMuGg3xoyfl+60quOW2jCb313E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407250; c=relaxed/simple;
	bh=I5yuLUogbuf/qT1pEerkxeA4bO738cmzner82eiqjeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9IyQ0q0vJmPrwiiSsE5ZbmLyo2n3phmkMjb6uzRCFzwyA30t5hg78aVkHXT7K1GmeywHysxKEC8FXblDT5OOIMtzXLiiP8wt+ASw0clgC9IpcSSTwRqH3gP+pc9gsVbL6SFVVnwmGPaNaZ51O68PTY7kTzFZkW7IjEz0W2cKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nq2ymSzx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDoPx003848
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 02:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLgxIENZ2R89bUot9QQ1S92TKgSyswfQZ1AW/g+iuO4=; b=nq2ymSzxKgLEUi5q
	Fmb7sea5GlWbiHtkJLiGw04wp9AYPZn/VgezGmAvCr5uHhLCyWW7AJd1plfdUNhc
	rbExRX+QSO+y2GC6DeMULYcAIkLcHQDIoZucYncE4oEB66yNlkv0MeU01E2Eak7u
	/ASKuJFhrCKeTDaDo3rSwKL6wZRTkQI2Kb6I9hP+B/4IvI8tKvFckyLT9q6gGCr7
	tAP8jugRv8aF/ZUJUFNY63UOB5uwer+CUq6FraKUj4PHX6F8HYhPjE+5nMw1/vVQ
	Q1Kx659iEqIcB4tc4sA9xlGf1r0B2oueSbpy8zie2on+5q9Ahq2YVYraUImpl1Ei
	MXuufQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhxsaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 02:00:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso513587b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 19:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760407244; x=1761012044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLgxIENZ2R89bUot9QQ1S92TKgSyswfQZ1AW/g+iuO4=;
        b=QAJuboia6gmk0EA8wkpG6oR4fykYcPs6e4++WWOZFXoFoggGqwJ+ix9m9irEN/b6E+
         zEV1RrNttPn2S8il7cyRoU9p9X1SxeB+Hj7lm5cT4cFUOKfDAR3Gwau1/fzpGPKhwwgA
         w9j4+kcRYM0KAjRkvosYTqQ24d1adWsoWDiqlMq0QfCuKCc6o0OG86Lle1zZSkk9R0Hw
         Kj3E/d+22fc1tpxFx/WF1Tm9wPErHdTQgPB9QVfLH2WI/FBjbOvr6OLIVNeONQiTPUB9
         WZDgbLXkqlncms3xXuE2cmAgBQl3bguHNkOqzq+2PwDYnmNjMD8EBpXt844dsHRYmoy3
         /l4w==
X-Forwarded-Encrypted: i=1; AJvYcCUpuSFaf1H3N/p1p1oLMr/ZKElqdFlM2VhffnbO7q+eMt8PWiDAB3Sa0LK23oy2VrtjCD6qQyJLH6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUT0Nc/6R3lkM3iKk0wu/GqtdvkCeBnlZgH80G5JHkfZNogByQ
	GpzMnnZhYP8Tg82I4ykNwDya/H0sdnLb4XEwDi2oC6Rq8lWrrFu7lMdkniH/wmF4qhxrcIymatc
	rapI0BFoJmr2CboV7UWR6Bzu8qP2i6/0nz2shrcT3OZUhxoTKvIbf0NnumTSpwHQ=
X-Gm-Gg: ASbGnctBncWsKGRmAHatQ4yrJlD+XVtOzF/0+30/BM3NmeDz6SIImQWrCLH5WD1leKc
	EG+lvBp/ZdnrG80MJHqqrfFa7oDvCDfTHZZsogDHUPaQqX8yLsJaJczh/yWMhcWRkjaPjVWacyO
	NTX7yHt9PQv0E9rFZS+fZPHJiEKTRWSQjr/eoUNfyDPqwTsTUQFqpgcZ4/98GAdY5oPPfkwMJ+8
	xTvUvhcbOWXeXLVilCGrZ+yP6MFN8dcTOgFdVne1ggt6s1M22OpQ7Z0KIi0wVW8k0HET51vGHxo
	t1sajfkgHdGKAYExWn0XegoZklpySz4SBfl4fxw/zXU6wdHPDGLZTrX/qlDR0AEtxQlMvvjO+RQ
	BsU2skxWT509WoLG0wscneC/ZrZc8yA==
X-Received: by 2002:a05:6a00:3e25:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-79396e6902emr28455827b3a.1.1760407243574;
        Mon, 13 Oct 2025 19:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2lp7WYqpQQEvlMh5VIkBpxmzWMyfuY4bZZbU3xd5R2fAco236d4BOgMZcSwP2nYK88hnexQ==
X-Received: by 2002:a05:6a00:3e25:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-79396e6902emr28455772b3a.1.1760407243059;
        Mon, 13 Oct 2025 19:00:43 -0700 (PDT)
Received: from [10.133.33.141] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb116basm13161398b3a.30.2025.10.13.19.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 19:00:42 -0700 (PDT)
Message-ID: <c9cb2086-8826-40e4-989f-1bb1335ac4ef@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:00:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/5] pci: qcom: Add QCS8300 PCIe support
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7XFfdJGkvrYe
 gQdtx2llgredyisnVzpt9foId8ELfPuETFrWXWwh7rP8s5Y0ktqQ+0hxwW9CCPtv0Doqq66QxUm
 Xls2ErA7aWYW6m4ndcsvTJpLARmA+EEoPI5aSA+MCQ6cOQRRm6o4vXKuq4m9mEwoJWECVKOi6+/
 tJYWCh0PZZF3qmyUa09UcAir0sdwymjGN/BpswSbuANp0ME6KDktdELR0gRvcTzjZww4+aP/Vgy
 p/Ir8SHp5bWuwThL8lJnZVusFJHVBpgK/W9MaAI4/I+WJI8PEg6T4kUiY3AkhwVwpWMSFy62zo5
 pJ0G2QQ/CaikjAmCyu/yWUfalzCtHMo7Q0VwKE91WKGJJHz5Xjyv5mi073v1ljmHa51HaQkhwf2
 Zsn8v7rmSEGkp/lN4+Pezr9t8OEh4w==
X-Proofpoint-ORIG-GUID: HNzXwrB_8Y-fBRDhXeuRq_jOalz8QVxU
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68edaecc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=IHEL40AIkIxnPEiLsFYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: HNzXwrB_8Y-fBRDhXeuRq_jOalz8QVxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018


On 9/8/2025 3:38 PM, Ziyue Zhang wrote:
> This series depend on this patch
> https://lore.kernel.org/all/20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com/
>
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
>
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Changes in v13:
> - Fix dtb error
> - Link to v12: https://lore.kernel.org/all/20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v12:
> - rebased pcie phy bindings
> - Link to v11: https://lore.kernel.org/all/20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v11:
> - move phy/perst/wake to pcie bridge node (Mani)
> - Link to v10: https://lore.kernel.org/all/20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v10:
> - Update PHY max_items (Johan)
> - Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v9:
> - Fix DTB error (Vinod)
> - Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v8:
> - rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
> - Add Fixes tag to phy change (Johan)
> - Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v7:
> - rebase qcs8300-ride.dtsi change to solve conflicts.
> - Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v6:
> - move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
> - Update QCS8300 and sa8775p phy dt, remove aux clock.
> - Fixed compile error found by kernel test robot
> - Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v5:
> - Add QCOM PCIe controller version in commit msg (Mani)
> - Modify platform dts change subject (Dmitry)
> - Fixed compile error found by kernel test robot
> - Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v4:
> - Add received tag
> - Fixed compile error found by kernel test robot
> - Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7
>
> Changes in v3:
> - Add received tag(Rob & Dmitry)
> - Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
> - remove pcieprot0 node(Konrad & Mani)
> - Fix format comments(Konrad)
> - Update base-commit to tag: next-20241213(Bjorn)
> - Corrected of_device_id.data from 1.9.0 to 1.34.0.
> - Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Fix some format comments and match the style in x1e80100(Konrad)
> - Add global interrupt for PCIe0 and PCIe1(Konrad)
> - split the soc dtsi and the platform dts into two changes(Konrad)
> - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
>
> Ziyue Zhang (5):
>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>      for qcs8300
>    arm64: dts: qcom: qcs8300: enable pcie0
>    arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>    arm64: dts: qcom: qcs8300: enable pcie1
>    arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
>
>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  84 +++++
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 310 +++++++++++++++++-
>   3 files changed, 394 insertions(+), 17 deletions(-)
>
>
> base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c

Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue


