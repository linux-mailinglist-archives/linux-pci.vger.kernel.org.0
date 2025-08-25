Return-Path: <linux-pci+bounces-34631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA64B33505
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 06:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BDE188B65E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 04:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55F23D7FB;
	Mon, 25 Aug 2025 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W34SVOQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AEE571
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 04:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096011; cv=none; b=Syh0l5E3cbjc+RPpetzEO6qFupn6iQBO4ZEdoLSVeIY0HQU6hnDYdnq7TRxQVfzEXFbcpKJ1SnNOKbzGilAJLtsdjj9y0LbDCQkdFjF5ak55T5kiL4yy1XP5LkNhXI/GBHBLOhecuIakCwdcvEyeFa3bI44fvgr0tBJXE2+on2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096011; c=relaxed/simple;
	bh=a9n17Pp87nFPpPJ8hCwWLrrAUSmfPsMPJ5jQsLaAx2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwVVJCeeEQxsFPpfbR3wjZcAgSceOdVnSb5L59WEhyi1jPI4BuFMdIVQncPp9M2fawHNMNYDm69jwjCPYLx0DwRMyTHg7wFNcLQmy92XjfM2EonqBNDvpmUC2/HMrkQYbZAYKjBH2tKcgS4XS5fyFGd6pIpAVlj8fzt5p3Iv0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W34SVOQy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ON0d5O003654
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 04:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NlAwHntaMSF8ydAogxPU5Y3pfmmg9g4CHbeq5yhKSxE=; b=W34SVOQyeU6gWdO0
	zEyPXL3Wwmqhctsg5GjaWEuObLdC7WCfo6InEaRrjFs/1MS/NNMJhic0/9XJC8vb
	gSRa/YBTmUB4irDUIt2nxbCuEAn0jgQaE8h+bvOYCHjVAouwDJOLMI0HGlJF5jf5
	2QTM6CI5gtXWW8R5/ytKbGtGr+8pkce/VovYictTx/SA6h6nJ1igK73GMM7m0ykY
	v0h1vzl9a1+3WEYPODyFo/zKwefTLmiEX6741wYRNdXghaE/WHQiV6Cs15KZAYzx
	Dmjy9oQtMznH96Dbi+UX0L5UhEuKuLWQY+SpsYFBY3zpKvrCPdHb138Ggez7F/0X
	8krrZA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5bkjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 04:26:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-246736043cfso39574065ad.0
        for <linux-pci@vger.kernel.org>; Sun, 24 Aug 2025 21:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756096007; x=1756700807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlAwHntaMSF8ydAogxPU5Y3pfmmg9g4CHbeq5yhKSxE=;
        b=Zwn5d8l50tNvbIGL0kUWoVpmJno5+vyYJ1Qgg9qDpddDN4dyvePnyfPKjvW1nM91OK
         C/h4AjCMEKlN5PSNj0F+EdiQSpCTd0XTZS28NkHiU0ZEe985vU/07k2iXMT6TjiQ9HZO
         j4ZjXBFcUe/TU1OfeiS++/OFmc4jNXk0J5+iYlp0M1Fs0u84krcP86s1axDqcZ22+zx8
         pX96NSXYYyvYA+ep2bLbOQm5/t6vPSsMi1KyCKqiYPsiPMEGk6IUleYssb37L5fKP42u
         ti1mwCvwkgMtzDMf186DGftXr5OyCm50FLa4+4IuInzpnpNLuqN6an6GOqg9ekhrqkza
         Cg2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrMkqeGQY/Jc6B5jUb7ZVZSbbPLpH4qGTrNnklccgoB5OdTjT5F76Fb1F2G2kuU8ZMH5U7U9EecMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx86OveXZUe+cQ9TvkZpoHF+bfEVrUy0H3GoKsGsJMWqG8pHMh
	O4RCubH2OucZy/jtCncHgsEBpDDt2d3/YBz5tVMq7r3aF5pMtPFoBmDxZ7XIXFsE+a1ldHJaiVc
	ErgF/EOSYXJVLIRaKomKNaUZHoyAn6NjHGHGN8pVkw2Em2+VbB7ypyh8f0Ga2lR8=
X-Gm-Gg: ASbGncuGx95cv5sifZcvLJSlDCB9c8QmWmar223mmZus6/GY3rqrXwVUsjJdLDU6d2L
	bxhYbr3Jw0eKmXPkHRA+a0RWJFKauPB6cAu+ZBk7PHQHmX24uFM/DjAehwPU0MUPu5JyWFPz8Q/
	9f4iiRdVpeK1wDaX86twJiDXdG2fELBFOSfayHvvEgT0cWBScu/BmYVY5UsdyeaLSfqH87/TH8f
	lkHw/RZF3YBKceLrNKktTbo3DUGFS9Mgxe/uQh6CJf1Np8/E//YD3oo16mkshG0cJM/YvgnjKn3
	vA7Y0C/ahA6ShNAQyI8IUbCUtzDbh374bJdN0eUNU16JexHkwnBAPCFaLEwRSseRa0ONj1npbA=
	=
X-Received: by 2002:a17:903:3805:b0:23f:e869:9a25 with SMTP id d9443c01a7336-2462ef6a8aemr135591405ad.44.1756096007445;
        Sun, 24 Aug 2025 21:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHixQBbnc0DdWGq6Af/ITt7Ss76QxVat1WmepXEy8SewWASn4eLQ0Rvbb4Y5+B07Zee/JGJZQ==
X-Received: by 2002:a17:903:3805:b0:23f:e869:9a25 with SMTP id d9443c01a7336-2462ef6a8aemr135591185ad.44.1756096006976;
        Sun, 24 Aug 2025 21:26:46 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880368sm54939105ad.109.2025.08.24.21.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 21:26:46 -0700 (PDT)
Message-ID: <7deae6e0-44ad-4b2c-9657-e83ffc77b4f7@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 09:56:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org
References: <20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX7z+oKgp3w2Qq
 5cJiw9cjqBPUmUHrhPNwJfpyB8eWb68b5/Fn3JIV3pM2aZNDX1iCu/3kPs/LlklNwQwvpf1dA8J
 QHcP1MKJVaOyTn/fNBE4MQvQMoM7y91ogymfW+VmCdfdiB8AbTpKLSagye2/hVCWeCrJegdT6pV
 i/PQs5xtsvpPNMmCZvEflI/d2UPyKsxWLksnB5eg00w92UF4v1L94iuLua/UFGgDdSdTv2xQMNz
 Ky4Fz/GufyiZi57vL7otGZES9dJY9o14GqZG/PqExIrV/cu0LwkoZU5GWVA6q+YfE7n5nyWfef7
 AuOR8Qf7lSyNJPhE41lUbkYDpQAnFg9H89R48EG46afNmmgLv4F/8qIMtWycffMs0xOB67TcqmU
 TkqrJM6L
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68abe608 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=dzoEsyrRel7NccpsXiUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: l6A9eol7g-wWNO-6QxL5LHABtP3OxQMO
X-Proofpoint-ORIG-GUID: l6A9eol7g-wWNO-6QxL5LHABtP3OxQMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/23/2025 11:14 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> enumerated at the time of the controller driver probe. It proved to be
> useful for devices already powered on by the bootloader, as it allowed
> devices to enter ASPM without user intervention.
> 
> However, it could not enable ASPM for the hotplug capable devices i.e.,
> devices enumerated *after* the controller driver probe. This limitation
> mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> and also the bootloader has been enabling the PCI devices before Linux
> Kernel boots (mostly on the Qcom compute platforms which users use on a
> daily basis).
> 
> But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> started to block the PCI device enumeration until it had been probed.
> Though, the intention of the commit was to avoid race between the pwrctrl
> driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> devices may get probed after the controller driver and will no longer have
> ASPM enabled. So users started noticing high runtime power consumption with
> WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> T14s, etc...
> 
> Obviously, it is the pwrctrl change that caused regression, but it
> ultimately uncovered a flaw in the ASPM enablement logic of the controller
> driver. So to address the actual issue, use the newly introduced
> pci_host_set_default_pcie_link_state() API, which allows the controller
> drivers to set the default ASPM state for *all* devices. This default state
> will be honored by the ASPM driver while enabling ASPM for all the devices.
> 
> So with this change, we can get rid of the controller driver specific
> 'qcom_pcie_ops::host_post_init' callback.
> 
> Also with this change, ASPM is now enabled by default on all Qcom
> platforms as I haven't heard of any reported issues (apart from the
> unsupported L0s on some platorms, which is still handled separately).
> 
> Cc: stable+noautosel@kernel.org # API dependency
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
> 
> * Used the new API introduced in this patch instead of bus notifier:
> https://lore.kernel.org/linux-pci/20250822031159.4005529-1-david.e.box@linux.intel.com/
> 
> * Enabled ASPM on all platforms as there is no specific reason to limit it to a
> few.
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 34 ++--------------------------------
>   1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..71f14bc3a06ade1da1374e88b0ebef8c4e266064 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -247,7 +247,6 @@ struct qcom_pcie_ops {
>   	int (*get_resources)(struct qcom_pcie *pcie);
>   	int (*init)(struct qcom_pcie *pcie);
>   	int (*post_init)(struct qcom_pcie *pcie);
> -	void (*host_post_init)(struct qcom_pcie *pcie);
>   	void (*deinit)(struct qcom_pcie *pcie);
>   	void (*ltssm_enable)(struct qcom_pcie *pcie);
>   	int (*config_sid)(struct qcom_pcie *pcie);
> @@ -1040,25 +1039,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>   	return 0;
>   }
>   
> -static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> -{
> -	/*
> -	 * Downstream devices need to be in D0 state before enabling PCI PM
> -	 * substates.
> -	 */
> -	pci_set_power_state_locked(pdev, PCI_D0);
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> -
> -	return 0;
> -}
> -
> -static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct dw_pcie_rp *pp = &pcie->pci->pp;
> -
> -	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
> -}
> -
>   static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>   {
>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> @@ -1358,19 +1338,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>   	pcie->cfg->ops->deinit(pcie);
>   }
>   
> -static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> -
> -	if (pcie->cfg->ops->host_post_init)
> -		pcie->cfg->ops->host_post_init(pcie);
> -}
> -
>   static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>   	.init		= qcom_pcie_host_init,
>   	.deinit		= qcom_pcie_host_deinit,
> -	.post_init	= qcom_pcie_host_post_init,
>   };
>   
>   /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> @@ -1432,7 +1402,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_7_0,
>   	.init = qcom_pcie_init_2_7_0,
>   	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>   	.deinit = qcom_pcie_deinit_2_7_0,
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   	.config_sid = qcom_pcie_config_sid_1_9_0,
> @@ -1443,7 +1412,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
>   	.get_resources = qcom_pcie_get_resources_2_7_0,
>   	.init = qcom_pcie_init_2_7_0,
>   	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>   	.deinit = qcom_pcie_deinit_2_7_0,
>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>   };
> @@ -1979,6 +1947,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	if (pcie->mhi)
>   		qcom_pcie_init_debugfs(pcie);
>   
> +	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
> +
It is better to call this before starting link training, if the endpoint
is already powered on by the time execution comes here link enumeration
and ASPM init might be already done. This might not have any impact.

- Krishna Chaitanya.
>   	return 0;
>   
>   err_host_deinit:
> 
> ---
> base-commit: 681accdad91923ef4938b96ff3eea62e29af74c3
> change-id: 20250823-qcom_aspm_fix-3264926b5b14
> 
> Best regards,

