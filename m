Return-Path: <linux-pci+bounces-16298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C29C1356
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 01:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E58283F85
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839721C36;
	Fri,  8 Nov 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f6NiqIwC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A83D6D;
	Fri,  8 Nov 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027340; cv=none; b=OEty90KEKCZ3w0c0B2v118ueSvgRUmRiglseYk3T34/tXguYl+DIppxEbm20H4suWTskFPn66C7WCr5ZAHQVUEbJSwiOYm24mDYZ4BBIkQEOuCnzElffomIcUlMi0axL+tqLLJDv21Blpi2+3vbBFJDWYGs/gAftvcHtDrh/TBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027340; c=relaxed/simple;
	bh=d/cSsKdpzyzE8i3B7goXeV3v+k/Q8RWyYbwb/Jp/W8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g1qB/rCYjc2q4J4vhaWbibmZbtmEhunLNmLGgIJlcZaXl0Jc9ZZSf3w7b9aSVkJT9swl05bOr5URpqx0CuyBheeJRdUB99URiN70AG3tQ2JjxK3ToqStpj6712WbHXnnd2PDROFhpTesHJ5N1vflTd7Hj7X/4yKiyQZOV35FueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f6NiqIwC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MapiW028433;
	Fri, 8 Nov 2024 00:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+AgAXe7HI7Z3JRAKphADtSyAnCeKEOMJatxI16LkgBM=; b=f6NiqIwCPAYx4lbs
	YxmVRuTf5ItwHGSLwfGvKGRvXkoDd9DxxoxMM+LonXOKHXUPXRdVUBN4QJNiWS2Z
	1WjpMb2iSyVzIn0lpq1pGeEa1Ie9lCYL8CDh+1m1MZCNc/TFO0FyR/2DSa3lNF5P
	mptGTApeTjcKWeZrpHjE5ddoBOi5/mQwhylcG6Yq4+0m6YzZJf3ANp9yqa4RxR3Y
	+aG+T17t55xKJvqeaO5oNWlipWGJbmrtzwbXYfz/hak7ji42WlQESp1TgqaGryJt
	EhJf7xOQP915zqM8ckpENQ2ymJOMRzSEqhdeBQB8FZ4QFKsOzJB8fgpatDQvFLm5
	24EzKw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gd887p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 00:53:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A80rGNP006988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Nov 2024 00:53:16 GMT
Received: from [10.216.52.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 16:53:10 -0800
Message-ID: <ebc129b7-b671-475b-423a-f6545c18849b@quicinc.com>
Date: Fri, 8 Nov 2024 06:23:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/5] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <imx@lists.linux.dev>, Niklas Cassel <cassel@kernel.org>,
        <dlemoal@kernel.org>, <maz@kernel.org>, <tglx@linutronix.de>,
        <jdmason@kudzu.us>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <20241031-ep-msi-v4-2-717da2d99b28@nxp.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241031-ep-msi-v4-2-717da2d99b28@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gr0WTGzMy5s5fOImAND0WbJF3lruQN1H
X-Proofpoint-ORIG-GUID: gr0WTGzMy5s5fOImAND0WbJF3lruQN1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411080005



On 10/31/2024 9:57 PM, Frank Li wrote:
> Doorbell feature is implemented by mapping the EP's MSI interrupt
> controller message address to a dedicated BAR in the EPC core. It is the
> responsibility of the EPF driver to pass the actual message data to be
> written by the host to the doorbell BAR region through its own logic.
>
Hi Frank,

Currently you are using single doorbell callback for all MSI's
received from the host side.
Instead of that can we expose a API which will be used by EPF driver
to request for IRQ by passing there own irq handler. we can skip
request_irq in epc_alloc_doorbell expose a seperate API for the
EPF driver to request_IRQ or let the EPF driver do request_irq by
filling  epf->db_msg[i].virq

- Krishna Chaitanya.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - msi change to use msi_get_virq() avoid use msi_for_each_desc().
> - add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
> - move mutex lock to epc function
> - initialize variable at declear place.
> - passdown epf to epc*() function to simplify code.
> ---
>   drivers/pci/endpoint/Makefile     |   2 +-
>   drivers/pci/endpoint/pci-ep-msi.c | 128 ++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-ep-msi.h        |  15 +++++
>   include/linux/pci-epf.h           |  19 ++++++
>   4 files changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> index 95b2fe47e3b06..a1ccce440c2c5 100644
> --- a/drivers/pci/endpoint/Makefile
> +++ b/drivers/pci/endpoint/Makefile
> @@ -5,4 +5,4 @@
>   
>   obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
>   obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> -					   pci-epc-mem.o functions/
> +					   pci-epc-mem.o pci-ep-msi.o functions/
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> new file mode 100644
> index 0000000000000..91207fb66db32
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Endpoint *Controller* (EPC) MSI library
> + *
> + * Copyright (C) 2024 NXP
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +#include <linux/pci-ep-cfs.h>
> +#include <linux/pci-ep-msi.h>
> +
> +static irqreturn_t pci_epf_doorbell_handler(int irq, void *data)
> +{
> +	struct pci_epf *epf = data;
> +	struct msi_desc *desc = irq_get_msi_desc(irq);
> +
> +	if (desc && epf->event_ops && epf->event_ops->doorbell)
> +		epf->event_ops->doorbell(epf, desc->msi_index);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static bool pci_epc_match_parent(struct device *dev, void *param)
> +{
> +	return dev->parent == param;
> +}
> +
> +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc __free(pci_epc_put) = NULL;
> +	struct pci_epf *epf;
> +
> +	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
> +	if (!epc)
> +		return;
> +
> +	/* Only support one EPF for doorbell */
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +
> +	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
> +		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
> +}
> +
> +static void pci_epc_free_doorbell(struct pci_epc *epc, struct pci_epf *epf)
> +{
> +	int i;
> +
> +	guard(mutex)(&epc->lock);
> +
> +	for (i = 0; i < epf->num_db && epf->db_msg[i].virq; i++) {
> +		free_irq(epf->db_msg[i].virq, epf);
> +		epf->db_msg[i].virq = 0;
> +		kfree(epf->db_msg[i].name);
> +		epf->db_msg[i].name = NULL;
> +	}
> +
> +	platform_device_msi_free_irqs_all(epc->dev.parent);
> +}
> +
> +static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
> +{
> +	struct device *dev = epc->dev.parent;
> +	u16 num_db = epf->num_db;
> +	int i = 0;
> +	int ret;
> +
> +	guard(mutex)(&epc->lock);
> +
> +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate MSI\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < num_db; i++) {
> +		epf->db_msg[i].virq = msi_get_virq(dev, i);
> +		epf->db_msg[i].name = kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i);
> +		ret = request_irq(epf->db_msg[i].virq, pci_epf_doorbell_handler, 0,
> +				  epf->db_msg[i].name, epf);
> +		if (ret) {
> +			dev_err(dev, "Failed to request doorbell\n");
> +			pci_epc_free_doorbell(epc, epf);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +};
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +{
> +	struct pci_epc *epc = epf->epc;
> +	void *msg;
> +	int ret;
> +
> +	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	epf->num_db = num_db;
> +	epf->db_msg = msg;
> +
> +	ret = pci_epc_alloc_doorbell(epc, epf);
> +	if (ret)
> +		kfree(msg);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> +
> +void pci_epf_free_doorbell(struct pci_epf *epf)
> +{
> +	struct pci_epc *epc = epf->epc;
> +
> +	pci_epc_free_doorbell(epc, epf);
> +
> +	kfree(epf->db_msg);
> +	epf->db_msg = NULL;
> +	epf->num_db = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
> new file mode 100644
> index 0000000000000..f0cfecf491199
> --- /dev/null
> +++ b/include/linux/pci-ep-msi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Endpoint *Function* side MSI header file
> + *
> + * Copyright (C) 2024 NXP
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#ifndef __PCI_EP_MSI__
> +#define __PCI_EP_MSI__
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> +void pci_epf_free_doorbell(struct pci_epf *epf);
> +
> +#endif /* __PCI_EP_MSI__ */
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 18a3aeb62ae4e..50c0f877f2efb 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -12,6 +12,7 @@
>   #include <linux/configfs.h>
>   #include <linux/device.h>
>   #include <linux/mod_devicetable.h>
> +#include <linux/msi.h>
>   #include <linux/pci.h>
>   
>   struct pci_epf;
> @@ -75,6 +76,7 @@ struct pci_epf_ops {
>    * @link_up: Callback for the EPC link up event
>    * @link_down: Callback for the EPC link down event
>    * @bus_master_enable: Callback for the EPC Bus Master Enable event
> + * @doorbell: Callback for EPC receive MSI from RC side
>    */
>   struct pci_epc_event_ops {
>   	int (*epc_init)(struct pci_epf *epf);
> @@ -82,6 +84,7 @@ struct pci_epc_event_ops {
>   	int (*link_up)(struct pci_epf *epf);
>   	int (*link_down)(struct pci_epf *epf);
>   	int (*bus_master_enable)(struct pci_epf *epf);
> +	int (*doorbell)(struct pci_epf *epf, int index);
>   };
>   
>   /**
> @@ -125,6 +128,18 @@ struct pci_epf_bar {
>   	int		flags;
>   };
>   
> +/**
> + * struct pci_epf_doorbell_msg - represents doorbell message
> + * @msi_msg: MSI message
> + * @virq: irq number of this doorbell MSI message
> + * @name: irq name for doorbell interrupt
> + */
> +struct pci_epf_doorbell_msg {
> +	struct msi_msg msg;
> +	int virq;
> +	char *name;
> +};
> +
>   /**
>    * struct pci_epf - represents the PCI EPF device
>    * @dev: the PCI EPF device
> @@ -152,6 +167,8 @@ struct pci_epf_bar {
>    * @vfunction_num_map: bitmap to manage virtual function number
>    * @pci_vepf: list of virtual endpoint functions associated with this function
>    * @event_ops: Callbacks for capturing the EPC events
> + * @db_msg: data for MSI from RC side
> + * @num_db: number of doorbells
>    */
>   struct pci_epf {
>   	struct device		dev;
> @@ -182,6 +199,8 @@ struct pci_epf {
>   	unsigned long		vfunction_num_map;
>   	struct list_head	pci_vepf;
>   	const struct pci_epc_event_ops *event_ops;
> +	struct pci_epf_doorbell_msg *db_msg;
> +	u16 num_db;
>   };
>   
>   /**
> 

