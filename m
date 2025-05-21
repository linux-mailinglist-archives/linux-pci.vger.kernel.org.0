Return-Path: <linux-pci+bounces-28206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E7ABF1E8
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 12:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D61BC28B0
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948425FA13;
	Wed, 21 May 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPGBn9/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65111185
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824276; cv=none; b=XbwwusTG5oV6iQeDzfi4xcKw/JGhRtjCJIGdEaXcYSD3MrKzppHerqejE4uNGLkW1oryna8SBZBu/+t9cxrA/CVrHHdGC6ahtUNibgoh2sDR0W7S8kxgy4hPzSDn6cpw81TdldYoaO6tYHcNaqurtTMte0HVS1EVIq+MA6HTyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824276; c=relaxed/simple;
	bh=iJq/LVNV6rpXxVga2DUS4f+9CrKcNp+T++0NRuH31DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7pErgtoPcHGt5XhsadaDuIM66CifMtRAZnuRLIrRA2AhlJp5DK2sFdu1UjGRYu+L0RP9W6yn9DAhWUts7zVNsIFmcXXAW9R/ZCJ7Yv3Cwl4RSc7bQE5osbNdKjQ4l7bRzD4X9hgvtznFd+ZpcAyVnC1aDNO4N56VJvD29ZSVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPGBn9/d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XIn6013417
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 10:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRdDXnMxczOb/t+TwIMeK6kFUpWigSK73W2qMnHFICE=; b=BPGBn9/dxcLKzsk5
	KdGFJQwBF24Pz2iveKm+wnugo9H2qOC/yQbonym12nwv4iKkjGHpGzy/NVh8fuVb
	+hyGDSkVTmpceaUBEOcqziRz9oFnekC2iuewugHLSE+PQYNmQAPIWskWzTt+4U6i
	fKfL/YsGgOWmjFr4JlPB216/7bfoaP0a1DPF1d7PinsZm+jzFZRRzhcaVOf0aKDR
	oXyxKErWcLwcohwmZLSPqysB5cddLbeshda7wVk/YUXSgvTzZZfk2JL2PbHuKvnx
	18DgD6WLvtnYCYLFUY+mfSrz/qBuV6p7fw4HUzzrF+xGRmvdQSBdthojLunu7SlF
	m98XAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwh5anaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 10:44:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso4270843b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 03:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824271; x=1748429071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRdDXnMxczOb/t+TwIMeK6kFUpWigSK73W2qMnHFICE=;
        b=mDsGhT1gGLHyQ2x2sJECLWWB+L2UHBrSj20Aqmcs5qf7xfgdNElWOQqrf7ST5ol/P7
         TTsgTSV7qrAio2SFySzT7jJ+i8Zui/gEUC9M++i1GimPBoGUhJfVw16OtZ+D/p9u3kg2
         sqCjO2VfMuOw8rIyQLC2f4eII1ZuZ0vhZzAIWSUZ5pukDqvdiPIW0IEuM7Z4vFAxEZe6
         //I27eeGESZzfOEkJ5HqhAX3KSAzrOxEkJdqmqPJilytXMINmfzY0aZk+yZtLNUKiKi4
         wgaKJ1VA6VNq4AzAIUBnWDxP5L3WYO8ojuhE3Y9xtFwZEB86J21ZvH0UgqUpmH6+d49Y
         w7AA==
X-Forwarded-Encrypted: i=1; AJvYcCXnDcy1Pkr2UHQHyE+BT1XeCNfojwkTUS9qOa99G0SFPu9sKGVWRX/DEFynLZ+c4tFgx3k8mDRBQzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAjMyP1pJIJ5kwwmTX6KKihIGuLGSL20YdfCPqqTQ7YWxjGKw
	QwYcgoia5vjPF65l/aSIGNlOqN5ZWCMLgyKja4pPgR4vEBJnPmgRB+kGsWPdDySmTlVyYlk6lyS
	rpLWpOiPXQksWPUDTFQ5oQM+WnOFOyIghFTd9mDty5G0ydSmoPg/OURT2WVbOgPc=
X-Gm-Gg: ASbGncu4BQ3EXEXxJvB15nTI0T7Hyy8ulNCalxkjJYSrLMKfd/zpZ6EjHLJtVj7WcIU
	rPHG3+FUVJ+VO+n+uokPRVp4kRFhifbCZKhmNWtWXH2wdmig7+UuPMqJXXFVLCnmULJuxH7P+3G
	+A961kSCK7QojFtUNbX2pPrFt3g4yiP/3m4Mt36/txVVSO0/2EJUJMOiyc20FPjhnsz9pKfx5pe
	GfybQQCGE9WRfaaSaTybCGPBmuqzozhJRav656Ao2D7p5m2N+oDAVL4PTXNdDUIZF7CP490PDEz
	B+ArO+UL3iSZTj2nxm/ad+H8ux9fe9DgwtMLz+nY2g==
X-Received: by 2002:a05:6a00:23c8:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-742acc8da94mr26428621b3a.4.1747824271515;
        Wed, 21 May 2025 03:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHhpGAJJG6+/V9N7uDTJ4W9vuKvJImJrjV4G93F3t5Z8o2p5ZzaAD6O1NpT0A+p26F/FViqg==
X-Received: by 2002:a05:6a00:23c8:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-742acc8da94mr26428577b3a.4.1747824271077;
        Wed, 21 May 2025 03:44:31 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a0ca7sm9316886b3a.158.2025.05.21.03.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 03:44:30 -0700 (PDT)
Message-ID: <318cd991-4da0-4507-96fb-e9e6f2313b93@oss.qualcomm.com>
Date: Wed, 21 May 2025 16:14:24 +0530
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
To: Sherry Sun <sherry.sun@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "quic_vbadigan@quicinc.com" <quic_vbadigan@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>,
        "cros-qcom-dts-watchers@chromium.org" <cros-qcom-dts-watchers@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
 <20250419-wake_irq_support-v2-2-06baed9a87a1@oss.qualcomm.com>
 <a8e58612-c6f5-8b61-af35-2c2897ad7827@oss.qualcomm.com>
 <DB9PR04MB8429A141EB4E88CF53355D879290A@DB9PR04MB8429.eurprd04.prod.outlook.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <DB9PR04MB8429A141EB4E88CF53355D879290A@DB9PR04MB8429.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNiBTYWx0ZWRfXxNoZsalc9zLF
 uDMIIiZtCy4R8h1L9OYxldTCNN0Bo2sfq0RQmSd+vDgTBBQIx8tGhwUZxA5tjwiom31ZBdQObJo
 jcO2bIynOS1VDi1nq6P2jyI4pA/ymSI5Qt6WPbIB88Sv3h1iOLvwTvRX9NAul1jovliLVVK/Wr/
 ai0ErAW5sWAgYOJEakYQFeBhtf9VkFo+0YdPBtdoILBJGkZd/ezOoZgDDHTZyk/RTd/V8GdCxm0
 kVjrJNLyLGGL5b6fjDsKMbL6uV/mjR9u+qcrJ9QrXgspsxRTSRje2C9KxhDnRJL4oVHMgiEardM
 mxWxrU3yOsVNRfG/4SSskfFNY2pCvlljuThTVUY3q6lmGz5nny+PlfgKJ1FmafMH+aO/1vHQpfl
 eHbvdkSIN4oyG0fN26mvYOq+pBfh2NwYgak9sSHCz+GZEuSPBa0QH99t0FqNo4Bgtqh0iKmO
X-Authority-Analysis: v=2.4 cv=XeWJzJ55 c=1 sm=1 tr=0 ts=682dae90 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8 a=cm27Pg_UAAAA:8 a=8AirrxEcAAAA:8
 a=I6U8J7tEZnt2TS94Z6MA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: XzXblekglOpdO92hJZTYVrIRFc_jJDvz
X-Proofpoint-ORIG-GUID: XzXblekglOpdO92hJZTYVrIRFc_jJDvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210106



On 5/15/2025 11:59 AM, Sherry Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Sent: Friday, May 9, 2025 3:59 PM
>> To: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-arm-msm@vger.kernel.org; Konrad Dybcio
>> <konradybcio@kernel.org>; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>> quic_vbadigan@quicinc.com; quic_mrana@quicinc.com; cros-qcom-dts-
>> watchers@chromium.org; Conor Dooley <conor+dt@kernel.org>; Rob Herring
>> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Bjorn
>> Andersson <andersson@kernel.org>
>> Subject: Re: [PATCH v2 2/2] PCI: Add support for PCIe wake interrupt
>>
>> A Gentle remainder.
>>
>> - Krishna Chaitanya.
>>
>> On 4/19/2025 11:13 AM, Krishna Chaitanya Chundru wrote:
>>> PCIe wake interrupt is needed for bringing back PCIe device state from
>>> D3cold to D0.
>>>
>>> Implement new functions, of_pci_setup_wake_irq() and
>>> of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
>>> using the Device Tree.
>>>
>>>   From the port bus driver call these functions to enable wake support
>>> for bridges.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru
>>> <krishna.chundru@oss.qualcomm.com>
> 
> Hi Krishna,
> 
> I have tested the patch set on i.MX platforms, it works.
> you can add my Tested-by: Sherry Sun <sherry.sun@nxp.com>.
> 
> BTW, as PEWAKE is a standard feature in PCIe bus specification,
> Suppose you may need to add wake-gpios property into the common
> PCI root port dt-schema.
> 
I raised a patch for this:
https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

- Krishna Chaitanya.
> Best Regards
> Sherry
> 
>>> ---
>>>    drivers/pci/of.c           | 60
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>    drivers/pci/pci.h          |  6 +++++
>>>    drivers/pci/pcie/portdrv.c | 12 +++++++++-
>>>    3 files changed, 77 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c index
>>>
>> ab7a8252bf4137a17971c3eb8ab70ce78ca70969..13623797c88a03dfb9d90795
>> 18d8
>>> 7a5e1e68df38 100644
>>> --- a/drivers/pci/of.c
>>> +++ b/drivers/pci/of.c
>>> @@ -7,6 +7,7 @@
>>>    #define pr_fmt(fmt)	"PCI: OF: " fmt
>>>
>>>    #include <linux/cleanup.h>
>>> +#include <linux/gpio/consumer.h>
>>>    #include <linux/irqdomain.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/pci.h>
>>> @@ -15,6 +16,7 @@
>>>    #include <linux/of_address.h>
>>>    #include <linux/of_pci.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/pm_wakeirq.h>
>>>    #include "pci.h"
>>>
>>>    #ifdef CONFIG_PCI
>>> @@ -966,3 +968,61 @@ u32 of_pci_get_slot_power_limit(struct
>> device_node *node,
>>>    	return slot_power_limit_mw;
>>>    }
>>>    EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>>> +
>>> +/**
>>> + * of_pci_setup_wake_irq - Set up wake interrupt for PCI device
>>> + * @pdev: The PCI device structure
>>> + *
>>> + * This function sets up the wake interrupt for a PCI device by
>>> +getting the
>>> + * corresponding GPIO pin from the device tree, and configuring it as
>>> +a
>>> + * dedicated wake interrupt.
>>> + *
>>> + * Return: 0 if the wake gpio is not available or successfully parsed
>>> +else
>>> + * errno otherwise.
>>> + */
>>> +int of_pci_setup_wake_irq(struct pci_dev *pdev) {
>>> +	struct gpio_desc *wake;
>>> +	struct device_node *dn;
>>> +	int ret, wake_irq;
>>> +
>>> +	dn = pci_device_to_OF_node(pdev);
>>> +	if (!dn)
>>> +		return 0;
>>> +
>>> +	wake = devm_fwnode_gpiod_get(&pdev->dev,
>> of_fwnode_handle(dn),
>>> +				     "wake", GPIOD_IN, NULL);
>>> +	if (IS_ERR(wake)) {
>>> +		dev_warn(&pdev->dev, "Cannot get wake GPIO\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	wake_irq = gpiod_to_irq(wake);
>>> +	device_init_wakeup(&pdev->dev, true);
>>> +
>>> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
>>> +		device_init_wakeup(&pdev->dev, false);
>>> +		return ret;
>>> +	}
>>> +	irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
>>> +
>>> +/**
>>> + * of_pci_teardown_wake_irq - Teardown wake interrupt setup for PCI
>>> +device
>>> + *
>>> + * @pdev: The PCI device structure
>>> + *
>>> + * This function tears down the wake interrupt setup for a PCI
>>> +device,
>>> + * clearing the dedicated wake interrupt and disabling device wake-up.
>>> + */
>>> +void of_pci_teardown_wake_irq(struct pci_dev *pdev) {
>>> +	dev_pm_clear_wake_irq(&pdev->dev);
>>> +	device_init_wakeup(&pdev->dev, false); }
>>> +EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
>>>
>> b81e99cd4b62a3022c8b07a09f212f6888674487..b2f65289f4156fa1851c2d2f2
>> 0c4
>>> ca948f36258f 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -888,6 +888,9 @@ void pci_release_of_node(struct pci_dev *dev);
>>>    void pci_set_bus_of_node(struct pci_bus *bus);
>>>    void pci_release_bus_of_node(struct pci_bus *bus);
>>>
>>> +int of_pci_setup_wake_irq(struct pci_dev *pdev); void
>>> +of_pci_teardown_wake_irq(struct pci_dev *pdev);
>>> +
>>>    int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge
>> *bridge);
>>>    bool of_pci_supply_present(struct device_node *np);
>>>
>>> @@ -931,6 +934,9 @@ static inline int devm_of_pci_bridge_init(struct
>> device *dev, struct pci_host_br
>>>    	return 0;
>>>    }
>>>
>>> +static int of_pci_setup_wake_irq(struct pci_dev *pdev) { return 0; }
>>> +static void of_pci_teardown_wake_irq(struct pci_dev *pdev) { }
>>> +
>>>    static inline bool of_pci_supply_present(struct device_node *np)
>>>    {
>>>    	return false;
>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>> index
>>>
>> e8318fd5f6ed537a1b236a3a0f054161d5710abd..33220ecf821c348d49782855
>> eb5a
>>> a3f2fe5c335e 100644
>>> --- a/drivers/pci/pcie/portdrv.c
>>> +++ b/drivers/pci/pcie/portdrv.c
>>> @@ -694,12 +694,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>>>    	     (type != PCI_EXP_TYPE_RC_EC)))
>>>    		return -ENODEV;
>>>
>>> +	status = of_pci_setup_wake_irq(dev);
>>> +	if (status)
>>> +		return status;
>>> +
>>>    	if (type == PCI_EXP_TYPE_RC_EC)
>>>    		pcie_link_rcec(dev);
>>>
>>>    	status = pcie_port_device_register(dev);
>>> -	if (status)
>>> +	if (status) {
>>> +		of_pci_teardown_wake_irq(dev);
>>>    		return status;
>>> +	}
>>>
>>>    	pci_save_state(dev);
>>>
>>> @@ -732,6 +738,8 @@ static void pcie_portdrv_remove(struct pci_dev
>>> *dev)
>>>
>>>    	pcie_port_device_remove(dev);
>>>
>>> +	of_pci_teardown_wake_irq(dev);
>>> +
>>>    	pci_disable_device(dev);
>>>    }
>>>
>>> @@ -744,6 +752,8 @@ static void pcie_portdrv_shutdown(struct pci_dev
>> *dev)
>>>    	}
>>>
>>>    	pcie_port_device_remove(dev);
>>> +
>>> +	of_pci_teardown_wake_irq(dev);
>>>    }
>>>
>>>    static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev
>>> *dev,
>>>
> 

