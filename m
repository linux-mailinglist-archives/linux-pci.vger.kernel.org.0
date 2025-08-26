Return-Path: <linux-pci+bounces-34719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE4B354FD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 09:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04A63AC12C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F1202976;
	Tue, 26 Aug 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGiTCyfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944D1F7586
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191907; cv=none; b=tIIxAPmKBFjCurM1s4yC6crk9/FEjk/DGKiM0AXT1oUde2WXQxMAAuytroHbzH9apEamKvmXfCy0c/qFVx20iKw6SWPICQhndghlqbDJhumEi5JcR1cmLdnWJZ5eGypER2W4uZX/FVThqd7Nw4sQfbyJhdOOpvI/rkGiQh+v9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191907; c=relaxed/simple;
	bh=pIGsbZP8+LJb3r6UYiQEBNaw1IMflnnPnzdSGZTZmas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkraVux8jFxF/xgQ9WviMKge+uL6LyBKeFuDfWXh5EWUTDMY9sN01oKYsW7WZrcITqM++yPz+rcvM1F7CeRHud2lKA+eXBepiNoXzRewD4y7Ol65s4yipGzkSTNZ2sq48EQwJgZeR1WcUNUGqSKTJYCHz8faCa8KH4hH0QhNCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGiTCyfI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMj6dc027740
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 07:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZP6RakllOefbuw5wdAwYWcIMwPBj8dV9yLeIRmtLs54=; b=ZGiTCyfINLhA+WtK
	TitNglwMsUaVMreVs7wCIlQ8VlIO/GVSja6zXxfnSW/2v19F5+0DzRL899dHdMIA
	fvNJ81+1M8KePZ5wkqIcMahTP1JLHkcSQuPAwB16fxvZwESWJHwmZHicPm6ns1EI
	DOUlGqvPTAKlQz9UYg9uenGtHQ1AqBTgJke5BfB70rv6nLOHn7QGZ5frejQ/Hdtf
	dInvN/dyLO4nwXsai1iVQkmMdB5Th5WzJWqRWlOgCqzePSOAN3ovL23WC2xAoxvO
	h990QD5jtG99R5CnvXufOSP1X/m2UlB8ewe1KzMjuFXuFIInUcM8Q7vanVkZKL/U
	DSGVjg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpet54f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 07:05:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-324fbd47789so4514206a91.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 00:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191903; x=1756796703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP6RakllOefbuw5wdAwYWcIMwPBj8dV9yLeIRmtLs54=;
        b=q80/ZT2tlr2+X2j0I+8uLiMp2iuhXbPiLf70KOanSS/vI6juUReYUNq2ySz4lg1Pya
         GVlK0yfMwdkj7aCUdCSsXqa1mrIkqet56bS20Tu3g2VmBZetYEGfJqi+yWwBzQxNx9Y8
         YlpCHlQzjAnTV3xOoP588niDDfo4xL+1GE84aCrWtSwJ5utW8CsAR2BUJFX7BVDAI/gK
         23hEeeuIanj35EM2n10QhGX0+DWFVnb4/CV5NDkF/1OPa+5bv5qc6Cm7ZfQaOcAIw8MA
         QSAsJfC2LToCCoN+ffOMYHrZ9IoZ7L1YH5U4fcigodL5eIsFFuNi80GRfoAPfGF37TPk
         jt8w==
X-Gm-Message-State: AOJu0Yybn/QINUzT9fv9vFHtbVh2mampps/fRQoijaCP12Y+2Xt6j5WP
	2+hZz4HIhjkFc6ESQL8oLHOtmLc56+WT7E6z9LrJnlBLT/wPc8ls3x2Obz/bfuKKYbZxsa5H9ro
	A6r+Mwnc8+Gr/OaMknIg+G+vzybLU8meyIyPvcDxzfYgb3XQ1aP9EM+WUeruFLlg=
X-Gm-Gg: ASbGncuWhEQuqoM8jbavIP7hEgixOsHnUdTDqUATstx6CTpsenVMMGxSe9QHyrjVJn3
	BBKksuZjgWc7sxGx1lsMH5a08ZOlN++USnqf0HeLRk1B5j6bfn9pn4CDC3xXBT0RpIVaan8zzAD
	tvwm71LcHVWmuSRV12uCShzOWaXi1iBUHE+eoMplnzMc9qYY0iCrSwbZRI5dIeOdWQiTjGrJ6Ds
	LNsJ/E2mJgHf+taZ6u/DOQYfI1Quu3dmCuxSGSUqduKTkVnhk5fT1s4iB2nyfs7nztf8KMM2yFV
	NhTiPkB5asZY42T83tKCfvB+t0nNNCVmPBQvCtS1UDImf7+tngNPPjhm8YpBg1qPDM+KmT4B
X-Received: by 2002:a17:902:db0c:b0:246:2703:87ae with SMTP id d9443c01a7336-2462ef08e1dmr171001345ad.30.1756191903371;
        Tue, 26 Aug 2025 00:05:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUyPD/rjDFlcpQQF8Stf9B8QfxG0Z2Enk+n4TmuTZC+3WBBw0IkY1NINY9tI45T06ZzM+1Dw==
X-Received: by 2002:a17:902:db0c:b0:246:2703:87ae with SMTP id d9443c01a7336-2462ef08e1dmr171001015ad.30.1756191902844;
        Tue, 26 Aug 2025 00:05:02 -0700 (PDT)
Received: from [10.92.199.10] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688804dcsm86328255ad.127.2025.08.26.00.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:05:02 -0700 (PDT)
Message-ID: <a6611c3f-79e7-4588-bdfd-5ccf5ab56c81@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 12:34:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
To: Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>,
        Oliver <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Lukas Wunner <lukas@wunner.de>
References: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CUQSZa7bwNUp5SCvR1qZxoACecrUQrvC
X-Proofpoint-ORIG-GUID: CUQSZa7bwNUp5SCvR1qZxoACecrUQrvC
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ad5ca0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_AprYWD3AAAA:8
 a=YmvwPZGcNBAA2zSj3IgA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX4MBSgy8pJwNf
 kpAn2R0WqrFtVuV+2KjJBRdaE+eLW3fkzhEjPxvVA/k1GWbKZ7ZiYqr3GyXf4UDtllKFa/VH1XA
 eyuzhqs8S0XtnEr8327qaPKIqOyYmScCFBINfuDN+JouPhfpyHisQ/ls9ocUZwO/FRNCFOhcI6B
 I0lyfth2Y1WTYQGIRDh41DM6MhLknMrrZcFNcktd8V+UPvkeSz1q2zU0wpVj0i04flXyNseE0U8
 mOLyKLmfmfaqYUikPDRZ2h5vtXxqNkXWtUmaTnWBD/pAuQu/54xWu8XrFAuNA1Gd+veuXg+rmyR
 HjXH+VSUUdAWpK1WL2Pxy/1hiOjwiE7qM+PndCO6/v5aNoHHUz8TYza+Sim1MDWI/GCTUgKuPb1
 /cYAPpoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142



On 6/17/2025 9:11 PM, Timothy Pearson wrote:
> Add pcie_link_is_active() function to check if the physical PCIe link is
> active, replacing duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
Hi Timothy,

Are you going to respin this patch.
If not I can take this patch in my series which I am going to post next
week.

- Krishna Chaitanya.
>   drivers/pci/hotplug/pciehp.h      |  1 -
>   drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
>   drivers/pci/hotplug/pciehp_hpc.c  | 33 +++----------------------------
>   drivers/pci/pci.c                 | 31 ++++++++++++++++++++++++++---
>   drivers/pci/pci.h                 |  1 +
>   5 files changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index debc79b0adfb..79df49cc9946 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
>   int pciehp_card_present(struct controller *ctrl);
>   int pciehp_card_present_or_link_active(struct controller *ctrl);
>   int pciehp_check_link_status(struct controller *ctrl);
> -int pciehp_check_link_active(struct controller *ctrl);
>   bool pciehp_device_replaced(struct controller *ctrl);
>   void pciehp_release_ctrl(struct controller *ctrl);
>   
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index bcc938d4420f..6cc1b27b3b11 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>   	/* Turn the slot on if it's occupied or link is up */
>   	mutex_lock(&ctrl->state_lock);
>   	present = pciehp_card_present(ctrl);
> -	link_active = pciehp_check_link_active(ctrl);
> +	link_active = pcie_link_is_active(ctrl->pcie->port);
>   	if (present <= 0 && link_active <= 0) {
>   		if (ctrl->state == BLINKINGON_STATE) {
>   			ctrl->state = OFF_STATE;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index ebd342bda235..d29ce3715a44 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>   	pcie_do_write_cmd(ctrl, cmd, mask, false);
>   }
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
>   static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>   {
>   	u32 l;
> @@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
>   	if (ret)
>   		return ret;
>   
> -	return pciehp_check_link_active(ctrl);
> +	return pcie_link_is_active(ctrl_dev(ctrl));
>   }
>   
>   int pciehp_query_power_fault(struct controller *ctrl)
> @@ -614,7 +587,7 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
>   	 * Synthesize it to ensure that it is acted on.
>   	 */
>   	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> -	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)) || pciehp_device_replaced(ctrl))
>   		pciehp_request(ctrl, ignored_events);
>   	up_read(&ctrl->reset_lock);
>   }
> @@ -921,7 +894,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
>   	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
>   				   PCI_EXP_SLTSTA_DLLSC);
>   
> -	if (!pciehp_check_link_active(ctrl))
> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>   		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>   
>   	return 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..4e96ff8ee5ec 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4908,7 +4908,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>   		return 0;
>   
>   	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> -		u16 status;
>   
>   		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>   		msleep(delay);
> @@ -4924,8 +4923,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>   		if (!dev->link_active_reporting)
>   			return -ENOTTY;
>   
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		if (pcie_link_is_active(dev) <= 0)
>   			return -ENOTTY;
>   
>   		return pci_dev_wait(child, reset_type,
> @@ -6230,6 +6228,33 @@ void pcie_print_link_status(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL(pcie_print_link_status);
>   
> +/**
> + * pcie_link_is_active() - Checks if the link is active or not
> + * @pdev: PCI device to query
> + *
> + * Check whether the physical link is active or not. Note it is
> + * possible that the card is removed immediately after this so the
> + * caller may need to take it into account.
> + *
> + * If the PCI device itself is not available anymore returns
> + * %-ENODEV.
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
> +	pci_dbg(pdev, "lnk_status = %#06x\n", lnk_status);
> +	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +}
> +EXPORT_SYMBOL(pcie_link_is_active);
> +
>   /**
>    * pci_select_bars - Make BAR mask from the type of resource
>    * @dev: the PCI device for which BAR mask is made
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..cf1afb718f8a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -231,6 +231,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
>   /* Functions for PCI Hotplug drivers to use */
>   int pci_hp_add_bridge(struct pci_dev *dev);
>   bool pci_hp_spurious_link_change(struct pci_dev *pdev);
> +int pcie_link_is_active(struct pci_dev *dev);
>   
>   #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
>   void pci_create_legacy_files(struct pci_bus *bus);

