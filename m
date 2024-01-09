Return-Path: <linux-pci+bounces-1913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA88282CA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EDDB21814
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78462D045;
	Tue,  9 Jan 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NieHJ5VS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718729422;
	Tue,  9 Jan 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4097cKYY002074;
	Tue, 9 Jan 2024 09:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PsJ1I9UaFW5DwqDZzHA5Wn9XkYOI1Ppryp8afL5DQ0s=; b=Ni
	eHJ5VS+rAeBAbD8qIT3lxFv/JLZ6C7YJXyHX2sqyNlsqww/U37cv/+pzYf2Fm14g
	tJz0DtC+OVLuHhaHL1BaFn7lJ0SKxVjZLARDxbE+Em9y5wZcZH6+4BNb3Kjkk2fN
	HmlIkQxjbMGVXLp7LLpILcSZXgNgUykz+UvI+lpVbnJA1e+FrwAv19XiLgmHGXcL
	rtvCYtivyHMeolWzDevhE3K/JQ4iM10nSMSRFwh9wYdOT7bevAwTMVLtBEbmyT18
	LXBq/JRroBPFpUCd73YlH+3/6EmYi4pGQ0WS1WlhwfwHjezlV3l+w2odIwXLkvGL
	JSuVd1ONgfnkHmoWbUaA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vghkvj72w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:15:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4099F3a1028516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 09:15:03 GMT
Received: from [10.216.48.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 01:14:57 -0800
Message-ID: <bcc6f870-88b2-95a8-ab6d-f1bef6448524@quicinc.com>
Date: Tue, 9 Jan 2024 14:44:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 6/8] PCI/link: Re-add BW notification portdrv as PCIe
 BW controller
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lukas Wunner
	<lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
 <20240105112547.7301-7-ilpo.jarvinen@linux.intel.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240105112547.7301-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ICaZxxlQa2GzH0zDSIgy88VIg-o-0V8S
X-Proofpoint-GUID: ICaZxxlQa2GzH0zDSIgy88VIg-o-0V8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090073


On 1/5/2024 4:55 PM, Ilpo Järvinen wrote:
> This mostly reverts b4c7d2076b4e ("PCI/LINK: Remove bandwidth
> notification") and builds PCIe bandwidth controller on top of it.
>
> The PCIe bandwidth notification were first added in the commit
> e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> notification") but later had to be removed. The significant changes
> compared with the old bandwidth notification driver include:
>
> 1) Don't print the notifications into kernel log, just keep the Link
>     Speed cached into the struct pci_bus updated. While somewhat
>     unfortunate, the log spam was the source of complaints that
>     eventually lead to the removal of the bandwidth notifications driver
>     (see the links below for further information).
>
> 2) Besides the Link Bandwidth Management Interrupt, enable also Link
>     Autonomous Bandwidth Interrupt to cover the other source of
>     bandwidth changes.
>
> 3) Use threaded IRQ with IRQF_ONESHOT to handle Bandwidth Notification
>     Interrupts to address the problem fixed in the commit 3e82a7f9031f
>     ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked")).
>
> 4) Handle Link Speed updates robustly. Refresh the cached Link Speed
>     when enabling Bandwidth Notification Interrupts, and solve the race
>     between Link Speed read and LBMS/LABS update in
>     pcie_bandwidth_notification_irq_thread().
>
> 5) Use concurrency safe LNKCTL RMW operations.
>
> 6) The driver is now called PCIe bwctrl (bandwidth controller) instead
>     of just bandwidth notifications because of increased scope and
>     functionality within the driver.
>
> PCIe bandwidth controller introduces an in-kernel API to set PCIe Link
> Speed. This new API is intended to be used in an upcoming commit that
> adds a thermal cooling device to throttle PCIe bandwidth when thermal
> thresholds are reached. No users are introduced in this commit yet.
>
> The PCIe bandwidth control procedure is as follows. The highest speed
> supported by the Port and the PCIe device which is not higher than the
> requested speed is selected and written into the Target Link Speed in
> the Link Control 2 Register. Then bandwidth controller retrains the
> PCIe Link.
>
> Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
> to keep track PCIe Link Speed changes. While Bandwidth Notifications
> should also be generated when bandwidth controller alters the PCIe Link
> Speed, a few platforms do not deliver LMBS interrupt after Link
> Training as expected. Thus, after changing the Link Speed, bandwidth
> controller makes additional read for the Link Status Register to ensure
> cur_bus_speed is consistent with the new PCIe Link Speed.
>
> Link: https://lore.kernel.org/all/20190429185611.121751-1-helgaas@kernel.org/
> Link: https://lore.kernel.org/linux-pci/20190501142942.26972-1-keith.busch@intel.com/
> Link: https://lore.kernel.org/linux-pci/20200115221008.GA191037@google.com/
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   MAINTAINERS                |   7 +
>   drivers/pci/pcie/Kconfig   |  12 ++
>   drivers/pci/pcie/Makefile  |   1 +
>   drivers/pci/pcie/bwctrl.c  | 263 +++++++++++++++++++++++++++++++++++++
>   drivers/pci/pcie/portdrv.c |   9 +-
>   drivers/pci/pcie/portdrv.h |  10 +-
>   include/linux/pci-bwctrl.h |  17 +++
>   7 files changed, 313 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/pci/pcie/bwctrl.c
>   create mode 100644 include/linux/pci-bwctrl.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..ccc5d50bf340 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16766,6 +16766,13 @@ F:	include/linux/pci*
>   F:	include/uapi/linux/pci*
>   F:	lib/pci*
>   
> +PCIE BANDWIDTH CONTROLLER
> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	drivers/pci/pcie/bwctrl.c
> +F:	include/linux/pci-bwctrl.h
> +
>   PCIE DRIVER FOR AMAZON ANNAPURNA LABS
>   M:	Jonathan Chocron <jonnyc@amazon.com>
>   L:	linux-pci@vger.kernel.org
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 8999fcebde6a..f1ef6030d2c2 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -146,6 +146,18 @@ config PCIE_PTM
>   	  This is only useful if you have devices that support PTM, but it
>   	  is safe to enable even if you don't.
>   
> +config PCIE_BW
> +	bool "PCI Express Bandwidth Controller"
> +	depends on PCIEPORTBUS
> +	help
> +	  This enables PCI Express Bandwidth Controller. The Bandwidth
> +	  Controller allows controlling PCIe Link Speed and listens for Link
> +	  Bandwidth Change Notifications. The current Link Speed is available
> +	  through /sys/bus/pci/devices/.../current_link_speed.
> +
> +	  If you know Link Width or Speed changes occur (e.g., to correct
> +	  unreliable links), you may answer Y.
> +
>   config PCIE_EDR
>   	bool "PCI Express Error Disconnect Recover support"
>   	depends on PCIE_DPC && ACPI
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 8de4ed5f98f1..175065a495cf 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -12,4 +12,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>   obj-$(CONFIG_PCIE_PME)		+= pme.o
>   obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>   obj-$(CONFIG_PCIE_PTM)		+= ptm.o
> +obj-$(CONFIG_PCIE_BW)		+= bwctrl.o
>   obj-$(CONFIG_PCIE_EDR)		+= edr.o
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> new file mode 100644
> index 000000000000..e17c98c25f06
> --- /dev/null
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCIe bandwidth controller
> + *
> + * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> + *
> + * Copyright (C) 2019 Dell Inc
> + * Copyright (C) 2023 Intel Corporation
> + *
> + * The PCIe bandwidth controller provides a way to alter PCIe Link Speeds
> + * and notify the operating system when the Link Width or Speed changes. The
> + * notification capability is required for all Root Ports and Downstream
> + * Ports supporting Link Width wider than x1 and/or multiple Link Speeds.
> + *
> + * This service port driver hooks into the Bandwidth Notification interrupt
> + * watching for changes or links becoming degraded in operation. It updates
> + * the cached Current Link Speed that is exposed to user space through sysfs.
> + */
> +
> +#define dev_fmt(fmt) "bwctrl: " fmt
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci-bwctrl.h>
> +#include <linux/types.h>
> +
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +/**
> + * struct pcie_bwctrl_service_data - PCIe bandwidth controller
> + * @set_speed_mutex: serializes link speed changes
> + */
> +struct pcie_bwctrl_service_data {
> +	struct mutex set_speed_mutex;
> +};
> +
> +static bool pcie_valid_speed(enum pci_bus_speed speed)
> +{
> +	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
> +}
> +
> +static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> +{
> +	static const u8 speed_conv[] = {
> +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> +	};
> +
> +	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> +		return 0;
> +
> +	return speed_conv[speed];
> +}
> +
> +static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
> +{
> +	return __fls(supported_speeds);
> +}
> +
> +static void pcie_bwnotif_enable(struct pci_dev *dev)
> +{
> +	u16 link_status;
> +	int ret;
> +
> +	pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> +				 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> +	pcie_capability_write_word(dev, PCI_EXP_LNKSTA,
> +				   PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
> +
> +	/* Read after enabling notifications to ensure link speed is up to date */
> +	ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &link_status);
> +	if (ret == PCIBIOS_SUCCESSFUL)
> +		pcie_update_link_speed(dev->subordinate, link_status);
> +}
> +
> +static void pcie_bwnotif_disable(struct pci_dev *dev)
> +{
> +	pcie_capability_clear_word(dev, PCI_EXP_LNKCTL,
> +				   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> +}
> +
> +static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
> +{
> +	struct pcie_device *srv = context;
> +	struct pci_dev *port = srv->port;
> +	u16 link_status, events;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
> +	events = link_status & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
> +
> +	if (ret != PCIBIOS_SUCCESSFUL || !events)
> +		return IRQ_NONE;
> +
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> +
> +	/*
> +	 * The write to clear LBMS prevents getting interrupt from the
> +	 * latest link speed when the link speed changes between the above
> +	 * LNKSTA read and write. Therefore, re-read the speed before
> +	 * updating it.
> +	 */
> +	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return IRQ_HANDLED;
> +	pcie_update_link_speed(port->subordinate, link_status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * pcie_bwctrl_select_speed - Select Target Link Speed
> + * @srv:	PCIe Port
> + * @speed_req:	requested PCIe Link Speed
> + *
> + * Select Target Link Speed by take into account Supported Link Speeds of
> + * both the Root Port and the Endpoint.
> + *
> + * Return: Target Link Speed (1=2.5GT/s, 2=5GT/s, 3=8GT/s, etc.)
> + */
> +static u16 pcie_bwctrl_select_speed(struct pcie_device *srv, enum pci_bus_speed speed_req)
> +{
> +	struct pci_bus *bus = srv->port->subordinate;
> +	u8 desired_speeds;
> +
> +	if (WARN_ON_ONCE(!bus->supported_speeds))
> +		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> +
> +	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
> +				 __fls(PCI_EXP_LNKCAP2_SLS_2_5GB));
> +
> +	return pcie_supported_speeds2target_speed(bus->supported_speeds & desired_speeds);
> +}
> +
> +/**
> + * pcie_bwctrl_set_current_speed - Set downstream Link Speed for PCIe Port
> + * @srv:	PCIe Port
> + * @speed_req:	requested PCIe Link Speed
> + *
> + * Attempts to set PCIe Port Link Speed to @speed_req. @speed_req may be
> + * adjusted downwards to the best speed supported by both the Port and PCIe
> + * Device underneath it.
> + *
> + * Return:
> + * * 0 		- on success
> + * * -EINVAL 	- @speed_req is not a PCIe Link Speed
> + * * -ETIMEDOUT	- changing Link Speed took too long
> + * * -EAGAIN	- Link Speed was changed but @speed_req was not achieved
> + */
> +int pcie_bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed_req)

Hi Ilpo Järvinen,

we want to use this API from PCIe client driver, but can't use API as 
client driver is not aware of pcie_device structure,

can you please make changes in this API so that PCIe client drivers can 
also use it. And also can you please export this API.

Thanks & Regards,

Krishna Chaitanya.

> +{
> +	struct pcie_bwctrl_service_data *data = get_service_data(srv);
> +	struct pci_dev *port = srv->port;
> +	u16 target_speed, link_status;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
> +		return -EINVAL;
> +
> +	if (port->subordinate->cur_bus_speed == speed_req)
> +		return 0;
> +
> +	target_speed = pcie_bwctrl_select_speed(srv, speed_req);
> +
> +	mutex_lock(&data->set_speed_mutex);
> +	ret = pcie_capability_clear_and_set_word(port, PCI_EXP_LNKCTL2,
> +						 PCI_EXP_LNKCTL2_TLS, target_speed);
> +	if (ret != PCIBIOS_SUCCESSFUL) {
> +		ret = pcibios_err_to_errno(ret);
> +		goto unlock;
> +	}
> +
> +	ret = pcie_retrain_link(port, true);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	/*
> +	 * Ensure link speed updates also with platforms that have problems
> +	 * with notifications
> +	 */
> +	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
> +	if (ret == PCIBIOS_SUCCESSFUL)
> +		pcie_update_link_speed(port->subordinate, link_status);
> +
> +	if (port->subordinate->cur_bus_speed != speed_req)
> +		ret = -EAGAIN;
> +
> +unlock:
> +	mutex_unlock(&data->set_speed_mutex);
> +
> +	return ret;
> +}
> +
> +static int pcie_bwnotif_probe(struct pcie_device *srv)
> +{
> +	struct pcie_bwctrl_service_data *data;
> +	struct pci_dev *port = srv->port;
> +	int ret;
> +
> +	data = devm_kzalloc(&srv->device, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->set_speed_mutex);
> +	set_service_data(srv, data);
> +
> +	ret = devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> +					pcie_bwnotif_irq_thread,
> +					IRQF_SHARED | IRQF_ONESHOT,
> +					"PCIe BW ctrl", srv);
> +	if (ret)
> +		return ret;
> +
> +	pcie_bwnotif_enable(port);
> +	pci_info(port, "enabled with IRQ %d\n", srv->irq);
> +
> +	return 0;
> +}
> +
> +static void pcie_bwnotif_remove(struct pcie_device *srv)
> +{
> +	struct pcie_bwctrl_service_data *data = get_service_data(srv);
> +
> +	pcie_bwnotif_disable(srv->port);
> +	mutex_destroy(&data->set_speed_mutex);
> +}
> +
> +static int pcie_bwnotif_suspend(struct pcie_device *srv)
> +{
> +	pcie_bwnotif_disable(srv->port);
> +	return 0;
> +}
> +
> +static int pcie_bwnotif_resume(struct pcie_device *srv)
> +{
> +	pcie_bwnotif_enable(srv->port);
> +	return 0;
> +}
> +
> +static struct pcie_port_service_driver pcie_bwctrl_driver = {
> +	.name		= "pcie_bwctrl",
> +	.port_type	= PCIE_ANY_PORT,
> +	.service	= PCIE_PORT_SERVICE_BWCTRL,
> +	.probe		= pcie_bwnotif_probe,
> +	.suspend	= pcie_bwnotif_suspend,
> +	.resume		= pcie_bwnotif_resume,
> +	.remove		= pcie_bwnotif_remove,
> +};
> +
> +int __init pcie_bwctrl_init(void)
> +{
> +	return pcie_port_service_register(&pcie_bwctrl_driver);
> +}
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..e8a348949d70 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -68,7 +68,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>   	 */
>   
>   	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> -		    PCIE_PORT_SERVICE_BWNOTIF)) {
> +		    PCIE_PORT_SERVICE_BWCTRL)) {
>   		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
>   		*pme = FIELD_GET(PCI_EXP_FLAGS_IRQ, reg16);
>   		nvec = *pme + 1;
> @@ -150,11 +150,11 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>   
>   	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
>   	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> -		    PCIE_PORT_SERVICE_BWNOTIF)) {
> +		    PCIE_PORT_SERVICE_BWCTRL)) {
>   		pcie_irq = pci_irq_vector(dev, pme);
>   		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
>   		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
> -		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
> +		irqs[PCIE_PORT_SERVICE_BWCTRL_SHIFT] = pcie_irq;
>   	}
>   
>   	if (mask & PCIE_PORT_SERVICE_AER)
> @@ -271,7 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>   
>   		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
>   		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> -			services |= PCIE_PORT_SERVICE_BWNOTIF;
> +			services |= PCIE_PORT_SERVICE_BWCTRL;
>   	}
>   
>   	return services;
> @@ -829,6 +829,7 @@ static void __init pcie_init_services(void)
>   	pcie_pme_init();
>   	pcie_dpc_init();
>   	pcie_hp_init();
> +	pcie_bwctrl_init();
>   }
>   
>   static int __init pcie_portdrv_init(void)
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1f3803bde7ee..9628bb04a8ff 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -20,8 +20,8 @@
>   #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
>   #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
>   #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
> -#define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
> -#define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
> +#define PCIE_PORT_SERVICE_BWCTRL_SHIFT	4	/* Bandwidth Controller (notifications) */
> +#define PCIE_PORT_SERVICE_BWCTRL	(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
>   
>   #define PCIE_PORT_DEVICE_MAXSERVICES   5
>   
> @@ -51,6 +51,12 @@ int pcie_dpc_init(void);
>   static inline int pcie_dpc_init(void) { return 0; }
>   #endif
>   
> +#ifdef CONFIG_PCIE_BW
> +int pcie_bwctrl_init(void);
> +#else
> +static inline int pcie_bwctrl_init(void) { return 0; }
> +#endif
> +
>   /* Port Type */
>   #define PCIE_ANY_PORT			(~0)
>   
> diff --git a/include/linux/pci-bwctrl.h b/include/linux/pci-bwctrl.h
> new file mode 100644
> index 000000000000..be51f6f2b340
> --- /dev/null
> +++ b/include/linux/pci-bwctrl.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * PCIe bandwidth controller
> + *
> + * Copyright (C) 2023 Intel Corporation
> + */
> +
> +#ifndef LINUX_PCI_BWCTRL_H
> +#define LINUX_PCI_BWCTRL_H
> +
> +#include <linux/pci.h>
> +
> +struct pcie_device;
> +
> +int pcie_bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed_req);
> +
> +#endif

