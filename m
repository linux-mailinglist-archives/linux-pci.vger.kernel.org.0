Return-Path: <linux-pci+bounces-43500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A833CCD4D25
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D81D30084F6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8D23EAB8;
	Mon, 22 Dec 2025 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjYK7oAh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgWAYwsD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4F22E3E7
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766386122; cv=none; b=aMorKdGx3L9Sbyj2Iw76d+p4xwTcpkBKfjWTiOuv6YTXrl/ju1xF8dor3B2h85MqHCfGqIw56ex+hST7ylGhmPTAlZacIKRlkY6ztqqIG8aEujoPoe3IzmKUVSHml8n22Rgs6hitxi1gN+uo4GETg3lcTxNyOtrR9NfTQG0AJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766386122; c=relaxed/simple;
	bh=MUJIb1QANVg6aaoNCRZhc8OTCMpbw6TRjgxJvj/GcwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKa4DK1WBNTW9QS8wLHpUlQD5qq842rZiJu1jFNmis7OWIX7fzAfm/PirbGYQYiPUB71D0x5SCkWDH+dHQJkQlGlkBLT9cpNzdbBpLfDAvUKtn2wZYsVgOFsTZ/6sqXNItqAMwCp7rhBBOt2DIPYm3Ntk/N9TQ0MdlFX+XBgrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjYK7oAh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgWAYwsD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMicTr217829
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 06:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HDOad6MuIfoh8GwW/qBCsPRyT8IcmeViO2wjU57u8Jg=; b=VjYK7oAhDoLej8ba
	uFaoosu+zH9XMx9Ml8CeeEIq3wg8US6g5b/45Fs/Rek+R4XHhARiYaI1ZrlmiNWR
	A4nQVXyv46zxLdfYq+DYq/YRzGrLNfa/X8StdhpfahfvKTGuLC4f8tfAZIEvtgdr
	u1/acww/auUFtFwp5Si9Hb3Bd8PGtNRLem+xRvbDx0NBOnDwAGnyWWFJ5kSOQ16h
	qVj+x7ScYsrCHN1yGmUUPG0rrBp/XJflpARLovvFSE1SmYy6g7Zjadvt+ZIzy1hx
	EMJsgsJF32im/cfx4EfHjXJmu1dRLOjog7IzmZYqoFxgi+YOHFf3pXYhWz4YvVAp
	aEEz3g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mubkynt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 06:48:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29efd658fadso118437555ad.0
        for <linux-pci@vger.kernel.org>; Sun, 21 Dec 2025 22:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766386118; x=1766990918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDOad6MuIfoh8GwW/qBCsPRyT8IcmeViO2wjU57u8Jg=;
        b=BgWAYwsDQcr/9cfSxtLYmfphHfvgY5JLLLeDFbESZKDi6TsQuRKMshkC1tluUKD8rl
         AyQKJO243oHY76n7DNDHtX+x6yrcrna5jZugwGWzNqCXoS2RaV/fqJzR2Az0/raTu0vH
         DoFs1nhtolBDzpmha4f+jgd9C6amk3hXbpypVGAI403q43LrCsw+1Swa38FoM+cqs1qv
         jwuGfSOm6OLfPHfDvNEylM0sGFOjYBuG8webR/ckvgbUuIRTUv98Lvg1jzxeTflNLBVC
         27yBBd0xRVNVIBBMyHx0Ybn9ajv2GPsI0J7HYaqFCNxTxbCUo8L6BFaJCPDSZV6W/20W
         ELIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766386118; x=1766990918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDOad6MuIfoh8GwW/qBCsPRyT8IcmeViO2wjU57u8Jg=;
        b=tJE1q7aVUvYQtaJ4U2iaMVGGGHoInk3l9fOFQZIYO1mlavrsUnuNZMg/EZ7S4SecKw
         GXB3MdawOg7VpikYt5pggeX0OoYvmTjizIxT0t47kfOAJuTkw4uLOlYsjAyREEpYQaQN
         xZ4q8/OWi/IpBb627KKy8+D/iSj8tDUTizAldvwwla5d9zoizxTWqQwqzBxvPzCXkRSR
         p0nTRzeKjc4SEegm39Qdf2dmyfrXxF6UaHbueiInJ1zsUg0xYDBViYrVL/Et5WkqkPFw
         Zkp5Nezkz83QSkZRrHe6wxOAJXhPdOKBXXK6UWpnjC7WvVxrBSvGU4uw26CB9sOhBrRA
         14/w==
X-Forwarded-Encrypted: i=1; AJvYcCUp2Lip/IcF1mViSlA0SLsYSfGGDWHHtKZk2xyLmil82rSwYZHopjHnAof9YppWzDAPmo/hMLzapRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11IfS6lsrqoyr20/AJZnlP+tRkxFZKVmsf37rpPSsdOyWVYPC
	PKQL0pADVx32NGFwH8US8p56SLMtHnMxBCwTLhPtjlCly0aFkZJ6b9WlPjKoyVjfuI4gGhYp1XA
	v+7LMnbmA8QUkF95I+JG/SwHCaMN11O14zNnmj8sX3Pw6A1e5oMU088zF2TwM/Q0=
X-Gm-Gg: AY/fxX7JNbu9jeChSbSx9r42zi4BGBaHjq/YRhRwLNDlpiiwcxxCi1goFoolosvwH1v
	i6rXuVl1P6Wm7AHy3smOp25Yu+DUgXtzJizRahjW5D7xOAqkmLCLD6T3++rzLcmJ4OFu+c2LYdN
	mwILnXY68zZneXBrMLoh9WrLBjMEgGaL4d3wTjk/Z/atXtw0NdTw1+oTaV4hXz6/gK7PRp/ub/i
	wE4skpihifc6tFgzaJVRDbzh9v+DfC7acBZ52RHPWKy2UmxYl1DL4S70BVZEWgbm/eBf3YDor1l
	hJa7VUNNuihIClhuvJTXxU6hGyz92HX6G0PD9NjpNoiy6Gr1BgWuOtlS8cYK06CBl40fqBDQNFW
	rihc748WtQ2LHKeBMT0cmRHkC38YhQHaUpWRgL11iIA==
X-Received: by 2002:a17:903:2f87:b0:295:59ef:809e with SMTP id d9443c01a7336-2a2f232db53mr87703475ad.24.1766386118161;
        Sun, 21 Dec 2025 22:48:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+yPh0TRCzVgNlocVkZAvTiExIoCFpgpq1frE5QNcpnf6gdaRqn9azKGAeMp1HgMwgDrPrBw==
X-Received: by 2002:a17:903:2f87:b0:295:59ef:809e with SMTP id d9443c01a7336-2a2f232db53mr87703235ad.24.1766386117682;
        Sun, 21 Dec 2025 22:48:37 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d658sm85673125ad.78.2025.12.21.22.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 22:48:37 -0800 (PST)
Message-ID: <6f4eba26-86ba-4510-ac0d-b6e54fd5f51c@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 12:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] Revert "PCI: qcom: Enable MSI interrupts together
 with Link up if 'Global IRQ' is supported"
To: Niklas Cassel <cassel@kernel.org>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251222064207.3246632-8-cassel@kernel.org>
 <20251222064207.3246632-12-cassel@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251222064207.3246632-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA1OSBTYWx0ZWRfX/dkJj4454bgL
 XDmZySLVa4rlPenyxLPaU3zqqJJbkywMlgBx8taZGfDBI3B399PNvo3PeMJ8RpBnamYMy6jU/Qb
 c+0secs2XEPJZUYgF30ocUESpyosXoUi87YlUkhg781ztPwn9C2J+2JjSDPmnUkUY9lOO7S1lXn
 7gw5qxpETWG1Bx8fy04gXjtMYSiF6RhnE5zz4gGR+iduXkMDK9ggleVpG0oL/MMdyjo9T/UuAv2
 0VJCklNrjdYkj8g1IvAhJf8+gTwOaLZ5llPGNjw3nI6jXuMBLiBEwalAfG+qGRUOY6A5p9xcRv6
 zguW/GvMRQJiddYBhpXzt0I5V3DahvezidL1QT26fUoBGzzgpHsrj39AspeQJXPRQ1qTMozHyqU
 ag74onwIJGboAh6zylui95FGq6V9bk+eB/H9CAzb967G7fdHoZ9O0RPRz1BojtWx3c5VfGy//fy
 vOSSItR9+r9jgMsK8ww==
X-Proofpoint-GUID: Hq8qyslew-dJdZd0N-BcYfi1Vluy9e9x
X-Proofpoint-ORIG-GUID: Hq8qyslew-dJdZd0N-BcYfi1Vluy9e9x
X-Authority-Analysis: v=2.4 cv=KYbfcAYD c=1 sm=1 tr=0 ts=6948e9c7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=s8YR1HE3AAAA:8
 a=a8IibEu9Vj4pwpCw0c0A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220059



On 12/22/2025 12:12 PM, Niklas Cassel wrote:
> This reverts commit ba4a2e2317b9faeca9193ed6d3193ddc3cf2aba3.
>
> While this fake hotplugging was a nice idea, it has shown that this feature
> does not handle PCIe switches correctly:
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
>
> During the initial scan, PCI core doesn't see the switch and since the Root
> Port is not hot plug capable, the secondary bus number gets assigned as the
> subordinate bus number. This means, the PCI core assumes that only one bus
> will appear behind the Root Port since the Root Port is not hot plug
> capable.
>
> This works perfectly fine for PCIe endpoints connected to the Root Port,
> since they don't extend the bus. However, if a PCIe switch is connected,
> then there is a problem when the downstream busses starts showing up and
> the PCI core doesn't extend the subordinate bus number after initial scan
> during boot.
>
> The long term plan is to migrate this driver to the pwrctrl framework,
> once it adds proper support for powering up and enumerating PCIe switches.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e87ec6779d44..c5fcb87972e9 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -136,7 +136,6 @@
>   
>   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
>   #define PARF_INT_ALL_LINK_UP			BIT(13)
> -#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
>   
>   /* PARF_NO_SNOOP_OVERRIDE register fields */
>   #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
> @@ -1982,8 +1981,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   			goto err_host_deinit;
>   		}
>   
> -		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> -			       pcie->parf + PARF_INT_ALL_MASK);
MSI's needs to be enabled irrespective of this series as part of global 
IRQ otherwise
MSI's will not be triggered in few platforms.

Mani, exclude this patch while applying.

- Krishna Chaitanya
> +		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
>   	}
>   
>   	qcom_pcie_icc_opp_update(pcie);


