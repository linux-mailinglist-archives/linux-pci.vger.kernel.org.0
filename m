Return-Path: <linux-pci+bounces-27549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40197AB2530
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E38A1B67CD2
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3538235058;
	Sat, 10 May 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jdneS7fw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A0B660;
	Sat, 10 May 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746906692; cv=none; b=VYCjNTb8ZvP7YaaMvwo1G0nDWKe5SoK516IDnKG7sRp53n+fvVrqrYhEYKRdiHw/r6/y/w/whW2aNJauY8NY3hxUAZ44yym9h1thvOfj40myCzRVf1/dYt00vqaGERqKEZSuXUdJqmiVu49Q3Ab7EQxPHRABx/RAOru7gRnlCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746906692; c=relaxed/simple;
	bh=wRSxFUMncV4sK8MmPr2rqvlqW6o1u1kT0hrSd9CADyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gJbgGzKgOpm+kBRkZ1ficPXtV1KCHRAhJJDGids8mDW9nKh+5UKloZRAAA2cLayVUIvZfcv7+PRnLiDhaiJl9i5Y7Rn/QctYAQjRSrgg2ukbLXORKCskyHkXqgw82NgdPg9uX45v3uAgKWl01SUNCjlK3409UO0YOKqarJgqvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jdneS7fw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AJO0Ji021801;
	Sat, 10 May 2025 19:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WpiVX3FjHvSU+zGFtRReZ4AoerzAgurwn/wfTdHq+NU=; b=jdneS7fwVFxF1F+D
	S0iR1r4qOYDDj9rQkSaWr+z8F3G2NijdEzpWOvwZttyhjQe5VncHjeTvtBhNIsQ3
	0b5x4Zg9nDZV4436wSmHSKbkmVOENduABnJd2jXDD6sZkgv4rEj6o4d/b5NtFd5+
	XKAK4oX0j18fculBCROhDfOoY8JB665KT5Y5VUcEC1z4Ty7mUEDzJEiLADqGEMzB
	VhcpYQH13mB+XjMtN38VWxKIpNRb15kxdzuoo47xjv7/TsSY07uInznRpYVaRrBd
	bW6DUjiIFMIwz3p8vVP9Z88k5FqLjJTCznrmaLRQomDI4zRhjyYAg7ze2PMSTSiD
	ES36OQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hy68h24t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 May 2025 19:50:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54AJotRI008152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 May 2025 19:50:55 GMT
Received: from [10.110.70.93] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 10 May
 2025 12:50:54 -0700
Message-ID: <9e904c79-b023-4d9e-b675-a3114faa7198@quicinc.com>
Date: Sat, 10 May 2025 12:50:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Shawn Anastasio <sanastasio@raptorengineering.com>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        "Krishna
 Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.o>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        chaitanya chundru
	<quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicnic.com>, <amitk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <jorge.ramirez@oss.qualcomm.com>,
        "Dmitry
 Baryshkov" <lumag@kernel.org>,
        Timothy Pearson
	<tpearson@raptorengineering.com>
References: <20250509173833.2197248-1-sanastasio@raptorengineering.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20250509173833.2197248-1-sanastasio@raptorengineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDIwNSBTYWx0ZWRfX01JMpdNY58+v
 YATrdwJhwwV8qKEpFC14bgZ2zntRfo3G7LoEhHMVYsUWLJdvomG5LKGAN9DPPfEe80SN0OHaU+N
 3J+IghMMyL0vfI0gS8Eoeq8MyLhXFJK94I0hX3RPQE0x6SQ0LIEhuA3HRGdnBTsQJG3wPepN+WE
 oKo/HrUObySppH51bwE+rLS1QtlqKVbf+rhj2CTYRo24a2gJRiclIb6rts415AaG1IeyCH8TX45
 znlhGd71ODFgHBSHnrA9LfNtkCwo7hr+J+KRS1COpdCJXRmdu8mq4ePM2VeICDyGY2fvN/GP7hE
 IgLrvBBTpPrC07ApswCPIRvZ0bKFIYADWanAw3oPHfgJFdHEqjUqloeYJF1h5z8WDXrfnNZayDo
 FrxZoD2Xh43AoIKxEjbU0fhU/UbS9UprkrVNgMqgVmhe9N0lamCYhDgNlyaydE7ibGWAGr1P
X-Proofpoint-GUID: K9CamFTXNj3fXmpBDToZAU7fWqvz5Of-
X-Proofpoint-ORIG-GUID: K9CamFTXNj3fXmpBDToZAU7fWqvz5Of-
X-Authority-Analysis: v=2.4 cv=c5irQQ9l c=1 sm=1 tr=0 ts=681fae20 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_AprYWD3AAAA:8 a=YmvwPZGcNBAA2zSj3IgA:9 a=QEXdDO2ut3YA:10
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505100205

On 5/9/2025 10:38 AM, Shawn Anastasio wrote:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Date: Sat, 12 Apr 2025 07:19:56 +0530
> Subject: [PATCH v6] PCI: PCI: Add pcie_link_is_active() to determine if the
>  PCIe link is active

I don't understand this patch and it doesn't have any subject in email. Please fix. 

> 
> Introduce a common API to check if the PCIe link is active, replacing
> duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
> This is an updated patch pulled from Krishna's v5 series:
> https://patchwork.kernel.org/project/linux-pci/list/?series=952665
> 
> The following changes to Krishna's v5 were made by me:
>   - Revert pcie_link_is_active return type back to int per Lukas' review
>     comments
>   - Handle non-zero error returns at call site of the new function in
>     pci.c/pci_bridge_wait_for_secondary_bus
> 
>  drivers/pci/hotplug/pciehp.h      |  1 -
>  drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c  | 33 +++----------------------------
>  drivers/pci/pci.c                 | 26 +++++++++++++++++++++---
>  include/linux/pci.h               |  4 ++++
>  5 files changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 273dd8c66f4e..acef728530e3 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
>  int pciehp_card_present(struct controller *ctrl);
>  int pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> -int pciehp_check_link_active(struct controller *ctrl);
>  void pciehp_release_ctrl(struct controller *ctrl);
> 
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index d603a7aa7483..4bb58ba1c766 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	/* Turn the slot on if it's occupied or link is up */
>  	mutex_lock(&ctrl->state_lock);
>  	present = pciehp_card_present(ctrl);
> -	link_active = pciehp_check_link_active(ctrl);
> +	link_active = pcie_link_is_active(ctrl->pcie->port);
>  	if (present <= 0 && link_active <= 0) {
>  		if (ctrl->state == BLINKINGON_STATE) {
>  			ctrl->state = OFF_STATE;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8a09fb6083e2..278bc21d531d 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>  	pcie_do_write_cmd(ctrl, cmd, mask, false);
>  }
> 
> -/**
> - * pciehp_check_link_active() - Is the link active
> - * @ctrl: PCIe hotplug controller
> - *
> - * Check whether the downstream link is currently active. Note it is
> - * possible that the card is removed immediately after this so the
> - * caller may need to take it into account.
> - *
> - * If the hotplug controller itself is not available anymore returns
> - * %-ENODEV.
> - */
> -int pciehp_check_link_active(struct controller *ctrl)
> -{
> -	struct pci_dev *pdev = ctrl_dev(ctrl);
> -	u16 lnk_status;
> -	int ret;
> -
> -	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> -		return -ENODEV;
> -
> -	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> -	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> -
> -	return ret;
> -}
> -
>  static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>  {
>  	u32 l;
> @@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
>  	if (ret)
>  		return ret;
> 
> -	return pciehp_check_link_active(ctrl);
> +	return pcie_link_is_active(ctrl_dev(ctrl));
>  }
> 
>  int pciehp_query_power_fault(struct controller *ctrl)
> @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>  	 * Synthesize it to ensure that it is acted on.
>  	 */
>  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -	if (!pciehp_check_link_active(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>  	up_read(&ctrl->reset_lock);
>  }
> @@ -884,7 +857,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
>  	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
>  				   PCI_EXP_SLTSTA_DLLSC);
> 
> -	if (!pciehp_check_link_active(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> 
>  	return 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0ce..3bb8354b14bf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4926,7 +4926,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		return 0;
> 
>  	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> -		u16 status;
> 
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
> @@ -4942,8 +4941,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		if (!dev->link_active_reporting)
>  			return -ENOTTY;
> 
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		if (pcie_link_is_active(dev) <= 0)
>  			return -ENOTTY;
> 
>  		return pci_dev_wait(child, reset_type,
> @@ -6247,6 +6245,28 @@ void pcie_print_link_status(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pcie_print_link_status);
> 
> +/**
> + * pcie_link_is_active() - Checks if the link is active or not
> + * @pdev: PCI device to query
> + *
> + * Check whether the link is active or not.
> + *
> + * Return: link state, or -ENODEV if the config read failes.
> + */
> +int pcie_link_is_active(struct pci_dev *pdev)
> +{
> +	u16 lnk_status;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> +		return -ENODEV;
> +
> +	pci_dbg(pdev, "lnk_status = %x\n", lnk_status);
> +	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +}
> +EXPORT_SYMBOL(pcie_link_is_active);
> +
>  /**
>   * pci_select_bars - Make BAR mask from the type of resource
>   * @dev: the PCI device for which BAR mask is made
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 51e2bd6405cd..a79a9919320c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
>  			    pci_select_bars(pdev, IORESOURCE_MEM));
>  }
> 
> +int pcie_link_is_active(struct pci_dev *dev);
>  #else /* CONFIG_PCI is not enabled */
> 
>  static inline void pci_set_flags(int flags) { }
> @@ -2093,6 +2094,9 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline bool pcie_link_is_active(struct pci_dev *dev)
> +{ return false; }
>  #endif /* CONFIG_PCI */
> 
>  /* Include architecture-dependent settings and functions */
> --
> 2.30.2
> 
> 


-- 
---Trilok Soni

