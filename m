Return-Path: <linux-pci+bounces-42749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39108CAC217
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 07:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3038D3011B1C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E222A7E4;
	Mon,  8 Dec 2025 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIslboMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BfEwh4wK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B417993
	for <linux-pci@vger.kernel.org>; Mon,  8 Dec 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765174837; cv=none; b=gnHIMoXrN2fmp8rb1jGiSYuLzIsICIhQMzJFJnelHX52AmwPCdQF42owrO2RWwXmKmjiFX9JPAbx+Ho2oyg0V4PoibrEUT/sNhKci1j7VYGr+K8Du+mAjSIOKdLHMMttQXqzZ5I6C1yQJW9lgVq5UvxzgEOCXJ6bpwemhs5m+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765174837; c=relaxed/simple;
	bh=+I7n1mzw/LYGVbDZpyUslhyvxiCcrXpQNBAGtIXfcr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf2HE5hM1UBlVCy5twMPw7v4OG7Y4nUF7j4PlO4bdXAh+wAgSdpgSLNz87GQ0QmvhRhYq9PNLbnNUpvZNLOzpHE17Nr4t1ycVjDKNOp3lZXQK4VV0weoapehItnsaTXse7usZC2L6JKXMTxj6xTy4JtmWDTNQcTX/rZt6c/dBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UIslboMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BfEwh4wK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7LF59w2732877
	for <linux-pci@vger.kernel.org>; Mon, 8 Dec 2025 06:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PVNMUR0GxvlD1qVASFOunZ8mW/sma1pHBMAGx/xAnnU=; b=UIslboMYz93LznaX
	2wZWiroIwiGxm4Yez7Y9Wl/3OK6OPojgQCMVu0GYCcTawVfLUKKF9OEPTP2v7vWg
	B2SsiCJpwWppZ4a910RFxb5K7QrD3loO5xNNJUeBTNkVPLIn25G7MVLRRljjOafw
	G4OKLnMd8FCGuieMmmAadBWieJoJwZTN72ca0zOYxJogwrdA+zPSCYYnLbqyk6aM
	pqaZ+SmPaVxZeal6b5l7hcozfqNTTwpAeAKNChv/tar9UT78IVD1x1k1ypXsRFa9
	cKGcYcZ/i8xOe7U+OfwxtVQdw1MPOh6y9jl23kfqPpwSO1mUhOTF9sXV8zBlLVOl
	vR0HUA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awhaqru1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 06:20:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so4195045a12.0
        for <linux-pci@vger.kernel.org>; Sun, 07 Dec 2025 22:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765174833; x=1765779633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVNMUR0GxvlD1qVASFOunZ8mW/sma1pHBMAGx/xAnnU=;
        b=BfEwh4wKVy/abyvsfVhqp/aR3//s+utLyBpgjlnd6OMQca/cxjRRel4Cr1SzipISDR
         JwDmZ++Gn2SzbXd3QHW5Hkn5AXKeksd/ZqcfZtDw5GUsGV/JbL9PRWVpQCoOeAmX6Ng1
         2vuFlT0AFnvPLqla0go2jnGJhM08mNYJn0l2RfJQ9noYAUGBjcsBz5DjSHcIMcQPTTNZ
         BGir5iPmkf/yshPs13C84Z2g+sFIhtfGpqIYCmmGNyKm2R4cn/Z10ggdfq0ribwoh3KH
         T1aIS+2cd4mxSXvZU0v7gDVjinep4+PAHFHxLcARkht8zyFb77+C9HvnCtCJg3GDFEr1
         G3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765174833; x=1765779633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVNMUR0GxvlD1qVASFOunZ8mW/sma1pHBMAGx/xAnnU=;
        b=VotQ3wAMEiBZKYz4GWyxIiU9iOWhagHbkog1ocRRD716D9WjDX4ixjNWvCBz1E9AZK
         71mqUPO5GiZIE8By8ZuI1DGJL+esA2EeMGEwsCHb9YjGa6+1jCIIXTW7zHAUL9TYQlHr
         7rKkx2LTKzJGrEyEZ3PG67ikFsjApxGc8ut1uv14i9eqVVXRnX5SEhj5k31lZfQ0HieR
         z/roGqQZulsh2GBv+80/kKINFtMJxO/546JscRE/Yg0t5bonCxORSDcITzcMqnqsSlUW
         kmuCw71+sP04hckhZ/9voVs61963sgMBXU4qxUfIIy1nE2iBCUwDXsORJCMAyxVbrVd/
         s39g==
X-Forwarded-Encrypted: i=1; AJvYcCW6CfZoHsb3q0gZXXE/UqHV8TYphpjZ5WMTW1Chy7DFku6jK1QqsX4bzwlUiJQJ3vSgCi39qCipDdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Du3z/k0C3WwMjtBDwryfkqhUZIkIRX58p9IUCSV70lTTC/eO
	RyIY6U81dRGDgtG+sF1DGMrMFNOBM+/4LRuMO8z0R/BnKmG5GWxryLtHS0PkNvk9EtYaHvYSk6/
	JgQG0JxKgIirmUQ+pi2hTo8eTK17dFjMEz/zVIRXDkLR0vQW6QMlRacVYVLGKXZw=
X-Gm-Gg: ASbGnctQPXL4Ywo6a2OWBmiNjTD6S84gqR4QYNf1t3txrOjqb0FoZZlGi+7qx57Goy6
	sk+XKEMXY1As0kVyy/PqnP0mJm3aKsrdVL7vMyvQf7IPUcsev75DnL/baCuXNg5mCvVW8ytg/W8
	AZUkegTNPNe5iSLU+3P9JYy1zHkY7kSL3TByzfavkJxXfw2IWGgBZ5Zw+U0GhA4Xt6tko1ZC0dq
	IdSBfQm3jePMgnO3vA+2sPVehYNyUlBPD1k60XhnFqAHM8U7HNEec3qWB+6qyeU6Gs/Y7+hRFD2
	+sORpbImWajJEzpnsUrFO3K8Y7GwBrHQLr38a40IQrI7TPlKNxFe2NyeG/JhHKLwAwMRyl+Y10A
	cHT7Uo+3hAKlJ3nE5Q1kpgaBVB3fSCRe4omRBSL87VQ==
X-Received: by 2002:a05:6a20:4326:b0:366:14af:9bcb with SMTP id adf61e73a8af0-366182a4fbcmr5869416637.65.1765174833230;
        Sun, 07 Dec 2025 22:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC/KRyVc4SjNhwjSMrHMqPEPx+ePM6/53uXBbl3Kr0SSEZ2u+nxhyoYoKRnFK92ZpgkG4/gQ==
X-Received: by 2002:a05:6a20:4326:b0:366:14af:9bcb with SMTP id adf61e73a8af0-366182a4fbcmr5869401637.65.1765174832684;
        Sun, 07 Dec 2025 22:20:32 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaab9f1sm112328275ad.72.2025.12.07.22.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 22:20:32 -0800 (PST)
Message-ID: <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 11:50:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20251201063634.4115762-2-cassel@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251201063634.4115762-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA1MiBTYWx0ZWRfX2KrmEjb7BXOE
 2ssKs+HNA+9ahacc7gMpKSD/McwvK3pW7ua2CwFwDE8AVrPK2BsZxvxHfldwk9cTjnTvd9AgHpQ
 Y/HOFvhkzgK6oFxzBsSoS58c8CnKBTniAh4JTP5B/GsYCOnJCz/KBR4o9d/75Qao0zU6z/uWfbf
 XEWQ1bE+0KBrCe0I/SJJho4ODbRwsM0LFX12ghDYIm0nJE+EkWABM08KWzwcQMARpPmYS2n1Z+2
 tX4YgO1KqMJNhIxrayO1sUH236gdAqOFPOZJObHiBksAMjparO5GWnOHxOooAJMO7Txb2m6bJJy
 lxQ3LWYffc+UCRCVASUWlFQg0bocT5YJwo56h9Ffg3nsaGUqTlC9La87eIk3f2JggW2zUUWV+Gw
 B4YMqgxSYEa5ukotHf4nwhyi8D8pNQ==
X-Proofpoint-GUID: Tdjx5-csl-dN_aDv5LOrgfCdlEBMsSBd
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=69366e32 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=ksxQWNrZAAAA:8
 a=3poIEOW00GjgDaQ-JtgA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: Tdjx5-csl-dN_aDv5LOrgfCdlEBMsSBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080052



On 12/1/2025 12:06 PM, Niklas Cassel wrote:
> The DWC glue drivers always call pci_host_probe() during probe(), which
> will allocate upstream bridge resources and enumerate the bus.
>
> For controllers without Link Up IRQ support, pci_host_probe() is called
> after dw_pcie_wait_for_link(), which will also wait the time required by
> the PCIe specification before performing PCI Configuration Space reads.
>
> For controllers with Link Up IRQ support, the pci_host_probe() call (which
> will perform PCI Configuration Space reads) is done without any of the
> delays mandated by the PCIe specification.
>
> For controllers with Link Up IRQ support, since the pci_host_probe() call
> is done without any delay (link training might still be ongoing), it is
> very unlikely that this scan will find any devices. Once the Link Up IRQ
> triggers, the Link Up IRQ handler will call pci_rescan_bus().
>
> This works fine for PCIe endpoints connected to the Root Port, since they
> don't extend the bus. However, if the pci_rescan_bus() call detects a PCIe
> switch, then there will be a problem when the downstream busses starts
> showing up, because the PCIe controller is not hotplug capable, so we are
> not allowed to extend the subordinate bus number after the initial scan,
> resulting in error messages such as:
>
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
> While we would like to set the is_hotplug_bridge flag
> (quirk_hotplug_bridge()), many embedded SoCs that use the DWC controller
> have synthesized the controller without hot-plug support.
> Thus, the Link Up IRQ logic is only mimicking hot-plug functionality, i.e.
> it is not compliant with the PCI Hot-Plug Specification, so we cannot make
> use of the is_hotplug_bridge flag.
>
> In order to let the Link Up IRQ logic handle PCIe switches that are already
> powered on (PCIe switches that not powered on already need to implement a
> pwrctrl driver), don't perform a pci_host_probe() call during probe()
> (which disregards the delays required by the PCIe specification).
>
> Instead let the first Link Up IRQ call pci_host_probe(). Any follow up
> Link Up IRQ will call pci_rescan_bus().
>
> The IRQ name in /proc/interrupts for the pcie-qcom driver is renamed in
> order to not dereference pp->bridge->bus before it has been assigned.
>
> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
> Fixes: 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ")
> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Closes: https://lore.kernel.org/linux-pci/1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Rename the IRQ on pcie-qcom to not depend on pp->bridge->bus (Mani)
> -Make sure that ret is initialized in dw_pcie_host_init() error path (Dan)
>
>   .../pci/controller/dwc/pcie-designware-host.c | 71 ++++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c |  5 +-
>   drivers/pci/controller/dwc/pcie-qcom.c        |  9 +--
>   4 files changed, 71 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda51..bed7b309f6d9e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -565,6 +565,59 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>   	return 0;
>   }
>   
> +static int dw_pcie_host_initial_scan(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct pci_host_bridge *bridge = pp->bridge;
> +	int ret;
> +
> +	ret = pci_host_probe(bridge);
> +	if (ret)
> +		return ret;
> +
> +	if (pp->ops->post_init)
> +		pp->ops->post_init(pp);
> +
> +	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> +
> +	return 0;
> +}
> +
> +void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
> +{
> +	if (!pp->initial_linkup_irq_done) {
> +		int ret;
> +
> +		ret = dw_pcie_host_initial_scan(pp);
> +		if (ret) {
> +			struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +			struct device *dev = pci->dev;
> +
> +			dev_err(dev, "Initial scan from IRQ failed: %d\n", ret);
> +
> +			dw_pcie_stop_link(pci);
> +
> +			dw_pcie_edma_remove(pci);
> +
> +			if (pp->has_msi_ctrl)
> +				dw_pcie_free_msi(pp);
> +
> +			if (pp->ops->deinit)
> +				pp->ops->deinit(pp);
> +
> +			if (pp->cfg)
> +				pci_ecam_free(pp->cfg);
> +		} else {
> +			pp->initial_linkup_irq_done = true;
> +		}
> +	} else {
> +		/* Rescan the bus to enumerate endpoint devices */
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pp->bridge->bus);
> +		pci_unlock_rescan_remove();
> +	}
> +}
> +
>   int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -669,18 +722,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	 * If there is no Link Up IRQ, we should not bypass the delay
>   	 * because that would require users to manually rescan for devices.
>   	 */
> -	if (!pp->use_linkup_irq)
> +	if (!pp->use_linkup_irq) {
>   		/* Ignore errors, the link may come up later */
>   		dw_pcie_wait_for_link(pci);
>   
> -	ret = pci_host_probe(bridge);
> -	if (ret)
> -		goto err_stop_link;
> -
> -	if (pp->ops->post_init)
> -		pp->ops->post_init(pp);
> -
> -	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> +		/*
> +		 * For platforms with Link Up IRQ, initial scan will be done
> +		 * on first Link Up IRQ.
> +		 */
> +		ret = dw_pcie_host_initial_scan(pp);
> +		if (ret)
> +			goto err_stop_link;
This will cause breakages in qcom platforms, qcom platforms use pwrctrl 
framework for
enabling power to the endpoints. And the pwrctrl drivers will be created 
as part of the initial scan.
As we skipping the initial scan here, pwrctrl driver will be never 
created and the power to the
endpoint will be never enabled. This will cause link to be never up.

- Krishna Chaitanya.
> +	}
>   
>   	return 0;
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ecd..a31bd93490dcd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -427,6 +427,7 @@ struct dw_pcie_rp {
>   	int			msg_atu_index;
>   	struct resource		*msg_res;
>   	bool			use_linkup_irq;
> +	bool			initial_linkup_irq_done;
>   	struct pci_eq_presets	presets;
>   	struct pci_config_window *cfg;
>   	bool			ecam_enabled;
> @@ -807,6 +808,7 @@ void dw_pcie_msi_init(struct dw_pcie_rp *pp);
>   int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
>   void dw_pcie_free_msi(struct dw_pcie_rp *pp);
>   int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> +void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp);
>   int dw_pcie_host_init(struct dw_pcie_rp *pp);
>   void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
>   int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
> @@ -844,6 +846,9 @@ static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	return 0;
>   }
>   
> +static inline void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
> +{ }
> +
>   static inline int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   {
>   	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd096..8f2cc1ef25e3d 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -466,10 +466,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>   		if (rockchip_pcie_link_up(pci)) {
>   			msleep(PCIE_RESET_CONFIG_WAIT_MS);
>   			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> -			/* Rescan the bus to enumerate endpoint devices */
> -			pci_lock_rescan_remove();
> -			pci_rescan_bus(pp->bridge->bus);
> -			pci_unlock_rescan_remove();
> +			dw_pcie_handle_link_up_irq(pp);
>   		}
>   	}
>   
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c48a20602d7fa..04f29cd8d8881 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1617,10 +1617,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>   	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>   		msleep(PCIE_RESET_CONFIG_WAIT_MS);
>   		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> -		/* Rescan the bus to enumerate endpoint devices */
> -		pci_lock_rescan_remove();
> -		pci_rescan_bus(pp->bridge->bus);
> -		pci_unlock_rescan_remove();
> +		dw_pcie_handle_link_up_irq(pp);
>   
>   		qcom_pcie_icc_opp_update(pcie);
>   	} else {
> @@ -1937,8 +1934,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		goto err_phy_exit;
>   	}
>   
> -	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
> -			      pci_domain_nr(pp->bridge->bus));
> +	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq_%pOFP",
> +			      dev->of_node);
>   	if (!name) {
>   		ret = -ENOMEM;
>   		goto err_host_deinit;


