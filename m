Return-Path: <linux-pci+bounces-27494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF050AB0C77
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F253BB7D0
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D4926A1DA;
	Fri,  9 May 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFp8gQ8y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0046B5
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777572; cv=none; b=pBIpxHvdnk6oPZB37TyyHsWLfA40cbK13owL1kE7x0Ufjvp4AsoMoL2JB/s4HTOf6jitZ2+fUBxTzsMI6oYp4NcZlLrr1XLJJeiTluCk+9RAhc6CjpUhhr3VIEALwg8IMyD9PXawKv7BUrBcUaH8yPhq0fUUP2txootPP+Nmk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777572; c=relaxed/simple;
	bh=dtYlNuz9bYsbK1kUI+BHu2/Ma6v0vUgex7AyCmr0Ju4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7aSTlQFcILSxM4OVRfles9z4T+7lmKZgUaQN2pseKAgQT8b/aUA6c3VV5iHK8Hn3yDHne4l21Gtfum3blY8RmTA9+4UbQJlaz6U1LA5eIoDnuoYXBevEOfPLZcjcr83DwEYqsHN50c0199G4xNeyQDf+7s9S9IKzYVeTSvmwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFp8gQ8y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5493Xwxc031067
	for <linux-pci@vger.kernel.org>; Fri, 9 May 2025 07:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OCrKRQxy8YR3luuA5bA8ec5wbTqiTzkXKtXRBEV+qW8=; b=kFp8gQ8yJRDSeqxE
	Rzq9i9n5mXHYMvQa82NyTCg3Hl2XnmSJOkHmw3+QEwa2GfV2NnFJ0mJst1ZjVRlu
	1dAdf7n9lsmS9/zktfcGGGJTPVgMre2jonzSbeaP6mhQKhJEKTAJAhin+0k2JCVI
	IGOBpD8ZNXp481yyY/WXZFr9sXvGzVaarfW+KeOc8hJ0+ke66CHXd2W1WCxfacz6
	4LuQdAMw0ZbdVoZGOv8qJKhWFHpB/vewzvyCTh4E5D1cyR4O1c05nuGGvkABf4gD
	jd/KcDuNUhYJavJYcgJLZZ3XlE361rU7YIUCHrqREs1cJe2LLFYd0l/hbANrkVIw
	biqJUw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpgktt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 07:59:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30c50f130d9so195943a91.1
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 00:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777568; x=1747382368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCrKRQxy8YR3luuA5bA8ec5wbTqiTzkXKtXRBEV+qW8=;
        b=KMxRYoxI9QmuolDMefcFPmlNivdjHitJHwvNkCIv/TeOL55DoUtisCQPN7snTK/hDz
         ckxbckXdXhfXLbnGypoWOQKmDQ45PIzUufiLjyF57EYesKWbkWjF1Ta+EoLgtoHHvjg+
         uZNTcRw2Xe2I+DSXJMWrUV599VwokBtKdkaZ5psLgH0lSBXO50YDDH+tX4aui30xcJMC
         +wYwUilggoubs4PRr+RxsoqvU8ZmiiXksR5KK7NvERIJ7Kfz+PUMGPNMsg+A8eAGt7jX
         Z8YKKAPk3NTUbOuYpQwLexa3fLRoZdAieRsQUMfJYTFLM30p200d1dZY+WphfWZ9SEae
         qgIA==
X-Forwarded-Encrypted: i=1; AJvYcCXfvKcDVlmlTq1S77jjvh9QrqQmJvdCsBdlpFi5DCjkbk1N80aOnW4jty91wPkVGYEev7gL5rni8oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywL4fmcXzj1xbxfpEgFGsEpkfIp6fMRGeXII7YHS2ogmoFBEpe
	2hdQQ0U7a9n5AnCCJlWsZWZNk2ly38S1Xkf1coIZ3SrcAo5WXtT2v62AxtVfOGnL6pEojwEBCPn
	/joBD+bmVCC1GOLa/08Y4YgF69h37YsKtYg46jlvck+OQYxNKkMdRMdZfRz4=
X-Gm-Gg: ASbGncstqhRMek9NAc2DeQw/i6YRUzeDOjIHE83bWAUPwBmXtLIV1MaY+K+kHg9fXwo
	bb+AJSyGq/6FJMf8lzCUt1cBJ+pn5YQfVrfBV3i2/pPnQVxYv8EJAfMMFJXfOez47Z64QtjjFZg
	h+yOQ9LayjFpBMB9SMLLv7nPZ26MyFwVISGdwu8cogDas+I1Y4fVPtzcvOV3Jy1xYi9pzHiO+vH
	Inp4UP6ZGr2cnRXLfku34+45W+oSqvMEtV9FAE2r6PeOdpkvcNCC4Vh4mn873WU8JrKqFnqoWBZ
	YerpBim7/AP9LFHtbzTyA/IyuiOIvX0UpEIf69dX5g==
X-Received: by 2002:a17:90b:3d8b:b0:30a:214e:befc with SMTP id 98e67ed59e1d1-30c3d6441e9mr4228042a91.27.1746777567933;
        Fri, 09 May 2025 00:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM8flrCm/0zbyLoPgSTE1E9aY4pS1aZWZQVppKskWIFXLnJqaXfJUIpOvOGeAJF3WhJuq8uw==
X-Received: by 2002:a17:90b:3d8b:b0:30a:214e:befc with SMTP id 98e67ed59e1d1-30c3d6441e9mr4228005a91.27.1746777567437;
        Fri, 09 May 2025 00:59:27 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dd4334sm1274867a91.13.2025.05.09.00.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:59:27 -0700 (PDT)
Message-ID: <a8e58612-c6f5-8b61-af35-2c2897ad7827@oss.qualcomm.com>
Date: Fri, 9 May 2025 13:29:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] PCI: Add support for PCIe wake interrupt
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, cros-qcom-dts-watchers@chromium.org,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
 <20250419-wake_irq_support-v2-2-06baed9a87a1@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250419-wake_irq_support-v2-2-06baed9a87a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=681db5e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=UypG6ifEkSd7053-VuIA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA3NiBTYWx0ZWRfX7rEY80T4KGsa
 yEzmtvSnacFke93tKPly2mhoXXcMrVcF1ofIEACb+uCTljFpZ4ApMilLhTx9IC1E68qYZpBt6mR
 1BPgCLCPJFrC4ulDeOeQ7FEB72x85u4w9Fqk8UlPPJJaiVpvf+ubWf/UsaCKVGoELKnq2rkPpBa
 3lXu/+Pos6InIs/mYD9umFku7px6RTfwY9NCKIDaSNKG21F9tKHf1VD1axWHZr8E8NLV+Z3qKXC
 iP3RWGHkCsyOAvN+KVUTod5zqGfb8Ksn6miEvwHAGO3lNWBIyA1NHthbPX1IIEjFQEtR54BA3Zy
 kt2xKCamIKRreFyJYYjFXQPwmb4ePmlwHZkScQ2idhLNOuLQm5+FUBgxbxZJM96Lp8sRYJ1k0We
 OyvvQthatfU5OgmqpJz9wnQ1rKmuZK90GXhP0OEhBPPV2Vn43MHYoE1jAuOVmbPdRdBq+id4
X-Proofpoint-GUID: z1wn4K06PFoTXZyjY6lqMrDNRVzCQblu
X-Proofpoint-ORIG-GUID: z1wn4K06PFoTXZyjY6lqMrDNRVzCQblu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_03,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090076

A Gentle remainder.

- Krishna Chaitanya.

On 4/19/2025 11:13 AM, Krishna Chaitanya Chundru wrote:
> PCIe wake interrupt is needed for bringing back PCIe device state
> from D3cold to D0.
> 
> Implement new functions, of_pci_setup_wake_irq() and
> of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> using the Device Tree.
> 
>  From the port bus driver call these functions to enable wake support
> for bridges.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/of.c           | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h          |  6 +++++
>   drivers/pci/pcie/portdrv.c | 12 +++++++++-
>   3 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ab7a8252bf4137a17971c3eb8ab70ce78ca70969..13623797c88a03dfb9d9079518d87a5e1e68df38 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -7,6 +7,7 @@
>   #define pr_fmt(fmt)	"PCI: OF: " fmt
>   
>   #include <linux/cleanup.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/irqdomain.h>
>   #include <linux/kernel.h>
>   #include <linux/pci.h>
> @@ -15,6 +16,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_pci.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>   #include "pci.h"
>   
>   #ifdef CONFIG_PCI
> @@ -966,3 +968,61 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>   	return slot_power_limit_mw;
>   }
>   EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> +
> +/**
> + * of_pci_setup_wake_irq - Set up wake interrupt for PCI device
> + * @pdev: The PCI device structure
> + *
> + * This function sets up the wake interrupt for a PCI device by getting the
> + * corresponding GPIO pin from the device tree, and configuring it as a
> + * dedicated wake interrupt.
> + *
> + * Return: 0 if the wake gpio is not available or successfully parsed else
> + * errno otherwise.
> + */
> +int of_pci_setup_wake_irq(struct pci_dev *pdev)
> +{
> +	struct gpio_desc *wake;
> +	struct device_node *dn;
> +	int ret, wake_irq;
> +
> +	dn = pci_device_to_OF_node(pdev);
> +	if (!dn)
> +		return 0;
> +
> +	wake = devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(dn),
> +				     "wake", GPIOD_IN, NULL);
> +	if (IS_ERR(wake)) {
> +		dev_warn(&pdev->dev, "Cannot get wake GPIO\n");
> +		return 0;
> +	}
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
> +		device_init_wakeup(&pdev->dev, false);
> +		return ret;
> +	}
> +	irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
> +
> +/**
> + * of_pci_teardown_wake_irq - Teardown wake interrupt setup for PCI device
> + *
> + * @pdev: The PCI device structure
> + *
> + * This function tears down the wake interrupt setup for a PCI device,
> + * clearing the dedicated wake interrupt and disabling device wake-up.
> + */
> +void of_pci_teardown_wake_irq(struct pci_dev *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62a3022c8b07a09f212f6888674487..b2f65289f4156fa1851c2d2f20c4ca948f36258f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -888,6 +888,9 @@ void pci_release_of_node(struct pci_dev *dev);
>   void pci_set_bus_of_node(struct pci_bus *bus);
>   void pci_release_bus_of_node(struct pci_bus *bus);
>   
> +int of_pci_setup_wake_irq(struct pci_dev *pdev);
> +void of_pci_teardown_wake_irq(struct pci_dev *pdev);
> +
>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>   bool of_pci_supply_present(struct device_node *np);
>   
> @@ -931,6 +934,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>   	return 0;
>   }
>   
> +static int of_pci_setup_wake_irq(struct pci_dev *pdev) { return 0; }
> +static void of_pci_teardown_wake_irq(struct pci_dev *pdev) { }
> +
>   static inline bool of_pci_supply_present(struct device_node *np)
>   {
>   	return false;
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index e8318fd5f6ed537a1b236a3a0f054161d5710abd..33220ecf821c348d49782855eb5aa3f2fe5c335e 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -694,12 +694,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>   	     (type != PCI_EXP_TYPE_RC_EC)))
>   		return -ENODEV;
>   
> +	status = of_pci_setup_wake_irq(dev);
> +	if (status)
> +		return status;
> +
>   	if (type == PCI_EXP_TYPE_RC_EC)
>   		pcie_link_rcec(dev);
>   
>   	status = pcie_port_device_register(dev);
> -	if (status)
> +	if (status) {
> +		of_pci_teardown_wake_irq(dev);
>   		return status;
> +	}
>   
>   	pci_save_state(dev);
>   
> @@ -732,6 +738,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>   
>   	pcie_port_device_remove(dev);
>   
> +	of_pci_teardown_wake_irq(dev);
> +
>   	pci_disable_device(dev);
>   }
>   
> @@ -744,6 +752,8 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>   	}
>   
>   	pcie_port_device_remove(dev);
> +
> +	of_pci_teardown_wake_irq(dev);
>   }
>   
>   static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> 

