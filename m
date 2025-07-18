Return-Path: <linux-pci+bounces-32484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A15B09A5E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 05:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7531A7BBE62
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 03:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9D1CEAB2;
	Fri, 18 Jul 2025 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzb3E4JE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C61C8632
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811098; cv=none; b=QFhy6w9yi1DYeSrxcN2M4Q4eqzYLYS+Dmp4ved4xNuyS2r79fhyZCAl0ZfEEZnuyO27bTaSBHQSMOmRvDZmsFHLt/Fean8jn0NyoE14u5g9LohCveEUsOlVxz5g/6TLewVbrBocVAiNa+Yq0j0/orRGZokGcDBIlIOHkKQV3w1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811098; c=relaxed/simple;
	bh=sm+jWDnfxeWgNRZKuAlyvmBE2WBzV4iscOdM0AwUrsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD4PV7IqMIlelCKpjApDZ3qUtHkYsXHYQEAuT+pVMHUoFePFfagFl/RMNNIEwgSB21aFThENjSmakFP1/TMwTDoSx5z53EzTGwZfIxhdPSwiklcEmrzeNMw/ZA1osEFDnPzAOP9Leg+gC7MNq4CerYcs+zqpsAzEmgJAjPkLApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzb3E4JE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I08bfW016111
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 03:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NcFADHJWzB581dh8lwli3gFNI4IvnV9oOCXkZgldaGM=; b=dzb3E4JEm2fSjErJ
	SDM/OAoLmVVepywEJLhoRxEWaQh8/wshfZmR6DBfTiD4rv9PX6yWmMTZ1pu4mxA2
	6h9GFaM4lszHT/Ynd7EeZxM3fv3FHW6thYKbpcD+lboRWolfGZvmQxwdi8TJqYdH
	pGPjKQ5wJWDOkEKFloViBha4ndDGidP/VqryASpHnPPtWRBGrqKOhqWl49NJ/Ryx
	1n9+3i/GhD8S88H1K4gfIDc9lXzuB28wtN27uJKaku23MWCcOSM4/Mw1/meg5XLj
	PDAQNcjLay1jjYViys+C2NQIuylm+CYrDJvEqj924rdXVCHqwHArQpmeVW9rymV6
	qyeGPA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc1wf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 03:58:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23824a9bc29so23935115ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 20:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752811094; x=1753415894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcFADHJWzB581dh8lwli3gFNI4IvnV9oOCXkZgldaGM=;
        b=UiN1jWPAgoxf76vahJt1y3B14C6RJKkRbeLUA/5/dDxssY77wf9V6aIEXxdjhwKmfs
         5K2/YOFTpOcUs6yoMrqH5uGUixGV9sW4d0JLvG+ecoYp9y/rCeXLeJviWEnzNBt9wPvy
         47nSe1sA9CE5urgrNC9eoyAw+jrxPokg6pnvqtaSXWKKi3Ak5L3QQ7az6X03cc6eVA4C
         rDUh0PleSdzElRFuxDvA89aSbpynNyPiWn+TQqXiG4vVBoSAjlmtF+Ag0BKi6WWMvYQy
         wCLU9Q7zH1YsvIlwV+IaTJZ/tA07R9QQ6+3SO5ZLKxRLUbcnEyAjEKA/7XfGoR5EkL5G
         eDLg==
X-Gm-Message-State: AOJu0Yz4RXyRsYFKcc/P/dW/gsPm0xozNQvpMRE6W0dGuAC1HodQz5yg
	Qkhc+yUotQZZWXl07El+s2KcW19dxgLDofbWpjvHc3ZgIS5zI8RErKxBQeC1Wa0lhZ4PfPZW3gq
	6KdYVET3OAawwxNkTLSWPkLOKkeEmylM8sM7ONg7O1P3AvqyWY90+yezsEYwHMms=
X-Gm-Gg: ASbGncs0O+Ewz3VTc2GM1B4ZQf+CXS3eN/FMf7rtU7ZhtVatsxrDUsQR+6kLiJMBX0h
	cGMVXP28Q6ZWttR/63DJ3e3Grpie4vlm5lYu0Wypj0huuceAhky4ZT56KnnSeHDZfCDW9Th9o9G
	SUEkG3OMDNSti0aNJht/d4n9yxc3DeLTLpDd180bhHvXlKKhMFnNahFFyg+R7rW9ThacsbSJrkx
	Aqkl1gAZyR5qCnDx2QxcKtlKLrVdcX9cJx1bOXozxG4lJsuw0hLrAOQoMF32oDgpoiJ1yik2j1L
	JwaDrTEFnp7z+WMBhnhjPxQlpoo4Lqdwg3pxVvw5nUgUPjPTRus5nOpB5T8cKI7oX3ZmHg==
X-Received: by 2002:a17:902:f68a:b0:234:ba75:836 with SMTP id d9443c01a7336-23e25693676mr111436155ad.7.1752811094394;
        Thu, 17 Jul 2025 20:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpJu0g9KYlPsWpo+xmLRTgKz+e8QQUO94ua3L9oR8C4BqJw408SODGzFFKZ0NCX4WD20R5fw==
X-Received: by 2002:a17:902:f68a:b0:234:ba75:836 with SMTP id d9443c01a7336-23e25693676mr111435915ad.7.1752811093906;
        Thu, 17 Jul 2025 20:58:13 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.226.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef9aesm4165815ad.211.2025.07.17.20.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 20:58:13 -0700 (PDT)
Message-ID: <b6883420-96aa-432b-9d33-5e7c0e4fb8a7@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 09:28:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in a
 platform specific way
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Niklas Cassel <cassel@kernel.org>,
        Wilfred Mallawa
 <wilfred.mallawa@wdc.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=6879c658 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=lM2dtDSGyl0QT0dfkTfTzg==:17
 a=lJ8DZ0MjVbnDIa4D:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ImqNvw3yTObJCdT6Mg8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cWoLU7QqEGmSaFSJ_QiGn6vL_zDSG5gR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAyOCBTYWx0ZWRfXx+FwDZeFWLTQ
 eFXc1E8xH0u8BDlzis/c5LWh3Grej3ObncjoQeAqP1mbGjdNoXv/0TYJ1sQBjxn1B6kFEACu7tV
 xtn9l+8JCAdRYYtBrokGE575+Hls9hQKSk8Y+m+rWiSQIwJ7rJmKfPSK0uBYCk5HF3iMGZN86Yd
 07Gn/BHHNrcdPyJg26E5RNmHPY3pRnlmJBhZlpsMjtUsV+KIxuiuxNhmIHrCKx1MqA59i+h0Swq
 /xhQhpLIICqwgq10j3QB0Odmj6SCKNTiSwTmOv/EhbcnKt2/gYXkEFSkU+UbSIOJ9TRlrampGdc
 frrff7XQB3lALIfVg+/nEhMD2ua1LX7rWByXJW9Aj3xHWy4ctBdfDqhZb/ilgsd0aKQx0bjB9C4
 /cUt44FngAQv7ENcXEQuhCRwn6SqBuMB5HCoZTlnEClnwtEowVe/ehtB5+U+zO4XaFQE7qaT
X-Proofpoint-GUID: cWoLU7QqEGmSaFSJ_QiGn6vL_zDSG5gR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180028



On 7/15/2025 7:51 PM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
> Port) and its subordinate devices by invoking bridge control reset and FLR. But
> in some cases like AER Fatal error, it might be necessary to reset the Root
> Ports using the PCI host bridge drivers in a platform specific way (as indicated
> by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
> Otherwise, the PCI link won't be recovered successfully.
> 
> So this series adds a new callback 'pci_host_bridge::reset_root_port' for the
> host bridge drivers to reset the Root Port when a fatal error happens.
> 
> Also, this series allows the host bridge drivers to handle PCI link down event
> by resetting the Root Ports and recovering the bus. This is accomplished by the
> help of the new 'pci_host_handle_link_down()' API. Host bridge drivers are
> expected to call this API (preferrably from a threaded IRQ handler) with
> relevant Root Port 'pci_dev' when a link down event is detected for the port.
> The API will reuse the pcie_do_recovery() function to recover the link if AER
> support is enabled, otherwise it will directly call the reset_root_port()
> callback of the host bridge driver (if exists).
> 
> For reference, I've modified the pcie-qcom driver to call
> pci_host_handle_link_down() API with Root Port 'pci_dev' after receiving the
> LINK_DOWN global_irq event and populated 'pci_host_bridge::reset_root_port()'
> callback to reset the Root Port. Since the Qcom PCIe controllers support only
> a single Root Port (slot) per controller instance, the API is going to be
> invoked only once. For multi Root Port controllers, the controller driver is
> expected to detect the Root Port that received the link down event and call
> the pci_host_handle_link_down() API with 'pci_dev' of that Root Port.
> 
> Testing
> -------
> 
> I've lost access to my test setup now. So Krishna (Cced) will help with testing
> on the Qcom platform and Wilfred or Niklas should be able to test it on Rockchip
> platform. For the moment, this series is compile tested only.
Tested on QCOM platform rb3gen2.
> 
> Changes in v6:
> - Incorporated the patch: https://lore.kernel.org/all/20250524185304.26698-2-manivannan.sadhasivam@linaro.org/
> - Link to v5: https://lore.kernel.org/r/20250715-pci-port-reset-v5-0-26a5d278db40@oss.qualcomm.com
> 
> Changes in v5:
> * Reworked the pci_host_handle_link_down() to accept Root Port instead of
>    resetting all Root Ports in the event of link down.
> * Renamed 'reset_slot' to 'reset_root_port' to avoid confusion as both terms
>    were used interchangibly and the series is intended to reset Root Port only.
> * Added the Rockchip driver change to this series.
> * Dropped the applied patches and review/tested tags due to rework.
> * Rebased on top of v6.16-rc1.
> 
> Changes in v4:
> - Handled link down first in the irq handler
> - Updated ICC & OPP bandwidth after link up in reset_slot() callback
> - Link to v3: https://lore.kernel.org/r/20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org
> 
> Changes in v3:
> - Made the pci-host-common driver as a common library for host controller
>    drivers
> - Moved the reset slot code to pci-host-common library
> - Link to v2: https://lore.kernel.org/r/20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org
> 
> Changes in v2:
> - Moved calling reset_slot() callback from pcie_do_recovery() to pcibios_reset_secondary_bus()
> - Link to v1: https://lore.kernel.org/r/20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> ---
> Manivannan Sadhasivam (3):
>        PCI/ERR: Add support for resetting the Root Ports in a platform specific way
>        PCI: host-common: Add link down handling for Root Ports
>        PCI: qcom: Add support for resetting the Root Port due to link down event
> 
> Wilfred Mallawa (1):
>        PCI: dw-rockchip: Add support to reset Root Port upon link down event
> 
>   drivers/pci/controller/dwc/Kconfig            |   2 +
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c |  91 ++++++++++++++++++-
>   drivers/pci/controller/dwc/pcie-qcom.c        | 120 ++++++++++++++++++++++++--
>   drivers/pci/controller/pci-host-common.c      |  33 +++++++
>   drivers/pci/controller/pci-host-common.h      |   1 +
>   drivers/pci/pci.c                             |  21 +++++
>   drivers/pci/pcie/err.c                        |   6 +-
>   include/linux/pci.h                           |   1 +
>   8 files changed, 260 insertions(+), 15 deletions(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250715-pci-port-reset-4d9519570123
> 
> Best regards,

