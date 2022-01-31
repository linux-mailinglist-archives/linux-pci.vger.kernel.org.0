Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA574A5164
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 22:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357892AbiAaVWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 16:22:44 -0500
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:33250
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358273AbiAaVWi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 16:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS4iDIGooxqRET5ENaVm4LUfVAYeFpRzN6V5nFw+Tgh04ZNs4KpufGmEIwKBMgWA6sAH/gT7csBvFG87T4DevtSLP5584JPt9RmcLN5jf7ynSLbUFJZX2wYUyFoAKrFCreokIe7u8fem8eH+DcgyH488TcwUMA88pft9hiyUbAI+4c7DY37FXQPuIuES7n1Y+8CNZSXtXfnvty9SJrRxFuOm2VYQwmVmk+LJlCXhkWQJRF8hTqfxI7e5eZDtSym2OPFdtyBPgj6Ssg2kPoAKNbBWBg1qj2yiRUB+KDi9AG0a6VuEPniKvDIWNT6ickHmxmYX6XPrf2uEA91ByoDqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVUF9Wf8FBzYAidlJKC7+C0Fgu2kWS6pORoU1HnKKsc=;
 b=NZ0frZGNJvMZUvtVT3wNyxtqzlp6G2n5DO2GWkR8SJwtmD28gAvQDhZFpW90UDDhOHogfhLd8Al00tJ5JOvpJAXFNE64oUCo8GHUnhTu4FZSp1im7xV5XCkaKhh/Zsee1cAFRyQnScxqd+Stg8JcAC97W6/YD1bkWeORtIgyEYollLHQKsMMqdFNDxooKYoWlfbeheXkuUNcbwkuu+R9FwpblRtZ21cG3DPIbmdhyxEC7G44cCqEw3tgPHLYck862VrXNKf2mpykXseFCravt0jVHHwzRFqmWjXu/f4dSvwDUR3PGZx5cBYG9g9P/eRoxl+hr8NSYa9W1ZrAfGiXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVUF9Wf8FBzYAidlJKC7+C0Fgu2kWS6pORoU1HnKKsc=;
 b=sbPnnlcQ3N4v2+zK0sWLYeKmqAxh5EarhxbhdUYAm6KeqKd+wM6UzUUIydfSh/nTW/7O/QdqlRu+TH/5uiboS1SHjdAWrnVKurlI2/EvnKw38GZi0HrJpNMC+5qNPtLlINuNN2/S8eENBj48+nm13oke+HFEiJ3LZTauMsJVluEHzVfadWb6lPJXBSD1n7+m6k8cVrnwTH9eJgzc7Zqa3lURSRtsqyP1leV0sY6fb9NV1jB/zOwVkyFLWrT6STSNtoM/JCbN7tlA+cxEIzJsMPQde0yPK1ZH883FDAXp2D10KSmg8S6tGvld+B24TnUv/A+UbUbMQsEJo1zzx7gNKw==
Received: from OL1P279CA0061.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::12)
 by VI1PR1001MB1117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 21:22:31 +0000
Received: from HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::ec) by OL1P279CA0061.outlook.office365.com
 (2603:10a6:e10:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Mon, 31 Jan 2022 21:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT005.mail.protection.outlook.com (10.152.1.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 21:22:31 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 31 Jan 2022 22:22:30 +0100
Received: from [139.22.137.89] (139.22.137.89) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 22:22:29 +0100
Message-ID: <5f6bc890-3a49-3056-ccee-210de546688e@siemens.com>
Date:   Mon, 31 Jan 2022 22:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PCI/portdrv: Do not setup up IRQs if there are no
 users
Content-Language: en-US
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8f9a13ac-8ab1-15ac-06cb-c131b488a36f@siemens.com>
In-Reply-To: <8f9a13ac-8ab1-15ac-06cb-c131b488a36f@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.89]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1be38aa-4651-4d28-2690-08d9e4ffca45
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1117:EE_
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1117EC9326D9C1986ADCE61195259@VI1PR1001MB1117.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyfXxxONu0DDtWtIQtVf5Rz6GXkvHm3uCG+YQWNE48BnJg1zHU6QYNk51DNZm4f1EfmFUF0Ez2jisnr7EX2u68YA2jeRU50r5xGGlYQOsc38iYqWTRrNPs0RhYhk5DmVEJkPFFyGEZwL/gww62PgLZXt8WRP6AZgD8kI1xVOW++c7SkGkeYGEi4brvvQ/+yh3uDFUr3jPoAqy/4bf4Nar2ky1SX0hnw8itAfiiRcaZbnJjELF1Da2WWnp0xs2cz3bh0SZN6HeVJ1gHlKobUeWnd1yVCooWthaIKpV/7t2H6yewmvqU39Mx7PY+1DA7DAnX59hkKVl+rYEQ7VXwGbwZhPG2qsS0ZDZqQLx1Gccyk5+8XKWj5e2VozHIRLk3M+BXSAWuPX62hQkxy+E6yKozBOEyJArF+OmL3MN82RM9bi16/aBhgwYtgdLGAR1UZW80NWbmU8AhmEeKnxJ+NnxY4waTxpN/SG1/PtpEEgR4TLiG4fJVtIStvVqHT+r+9TtpEouDaIW6iiHFBPSHKP6PJqCNuoWDzI7HK++JNE2CMeIXeVRDohv4G/QxPWKZ7ypNMLem1WMbrefYBR/Ph56cJ+avjLXRlxc7aeidp015coNjCbmECktdg6RLJfRlIBXs+4eWi+fgByVAWk5IbZJf+27/rHIEVMNyD6PfRIqRPv2eEaCEmnShf/Ln/EOmuPX9qur7jQ2hFy9/RymCN5GOCTHIspsnxwIwdRkWulVtBvyQe3rXscWjUz8l0W9zDyiaZQ/2bBvE68HpHgUim33krggLAKlz1pbFqt3H1j8ROtb5LPC9K/1F237x+BeLHFVbBwbt72v4GU4297GYPAk7sZ4YFpvY9pvzXNldXpF1zF/K6n1+cxz13gIxnWKH8/kEPyub4kthOdhtoO1AXgYg==
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7596003)(86362001)(31696002)(356005)(7636003)(316002)(110136005)(6706004)(16576012)(82960400001)(47076005)(83380400001)(82310400004)(53546011)(336012)(956004)(2616005)(26005)(186003)(16526019)(966005)(508600001)(40460700003)(2906002)(36860700001)(70206006)(70586007)(5660300002)(4326008)(31686004)(44832011)(8936002)(36756003)(8676002)(26730200005)(3940600001)(19860200003)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 21:22:31.0177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1be38aa-4651-4d28-2690-08d9e4ffca45
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1117
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.08.21 10:08, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Avoid registering service IRQs if there is no service that offers them
> or no driver to register a handler against them. This saves IRQ vectors
> when they are limited (e.g. on x86) and also avoids that spurious events
> could hit a missing handler. Such spurious events need to be generated
> by the Jailhouse hypervisor for active MSI vectors when enabling or
> disabling itself.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>   - move initialization of irqs to address test bot finding
> 
>   drivers/pci/pcie/portdrv_core.c | 47 +++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed6649c41..0e2556269429 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -166,9 +166,6 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>   {
>   	int ret, i;
>   
> -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> -		irqs[i] = -1;
> -
>   	/*
>   	 * If we support PME but can't use MSI/MSI-X for it, we have to
>   	 * fall back to INTx or other interrupts, e.g., a system shared
> @@ -312,8 +309,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>    */
>   int pcie_port_device_register(struct pci_dev *dev)
>   {
> -	int status, capabilities, i, nr_service;
> -	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> +	int status, capabilities, irq_services, i, nr_service;
> +	int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
> +		[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
> +	};
>   
>   	/* Enable PCI Express port device */
>   	status = pci_enable_device(dev);
> @@ -326,18 +325,32 @@ int pcie_port_device_register(struct pci_dev *dev)
>   		return 0;
>   
>   	pci_set_master(dev);
> -	/*
> -	 * Initialize service irqs. Don't use service devices that
> -	 * require interrupts if there is no way to generate them.
> -	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
> -	 * that can be used in the absence of irqs.  Allow them to determine
> -	 * if that is to be used.
> -	 */
> -	status = pcie_init_service_irqs(dev, irqs, capabilities);
> -	if (status) {
> -		capabilities &= PCIE_PORT_SERVICE_HP;
> -		if (!capabilities)
> -			goto error_disable;
> +
> +	irq_services = 0;
> +	if (IS_ENABLED(CONFIG_PCIE_PME))
> +		irq_services |= PCIE_PORT_SERVICE_PME;
> +	if (IS_ENABLED(CONFIG_PCIEAER))
> +		irq_services |= PCIE_PORT_SERVICE_AER;
> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +		irq_services |= PCIE_PORT_SERVICE_HP;
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +		irq_services |= PCIE_PORT_SERVICE_DPC;
> +	irq_services &= capabilities;
> +
> +	if (irq_services) {
> +		/*
> +		 * Initialize service irqs. Don't use service devices that
> +		 * require interrupts if there is no way to generate them.
> +		 * However, some drivers may have a polling mode (e.g.
> +		 * pciehp_poll_mode) that can be used in the absence of irqs.
> +		 * Allow them to determine if that is to be used.
> +		 */
> +		status = pcie_init_service_irqs(dev, irqs, irq_services);
> +		if (status) {
> +			irq_services &= PCIE_PORT_SERVICE_HP;
> +			if (!irq_services)
> +				goto error_disable;
> +		}
>   	}
>   
>   	/* Allocate child services if any */

It turns out that this patch causes troubles on some machines, see [1].
That could be "resolved" by doing

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bda630889f95..68b0013c3662 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -331,7 +331,7 @@ int pcie_port_device_register(struct pci_dev *dev)
  
  	pci_set_master(dev);
  
-	irq_services = 0;
+	irq_services = PCIE_PORT_SERVICE_BWNOTIF;
  	if (IS_ENABLED(CONFIG_PCIE_PME))
  		irq_services |= PCIE_PORT_SERVICE_PME;
  	if (IS_ENABLED(CONFIG_PCIEAER))

thus considering bandwidth notification as an IRQ-providing service as
well. But as far as I can see, there is no driver for this port service,
thus no one should ever request or even handle that interrupt.

I'm not yet seeing the key difference that could explain this effect.
What else happens via pcie_device_init() when called for
PCIE_PORT_SERVICE_BWNOTIF, although there will never be a driver?

Jan

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215533

-- 
Siemens AG, Technology
Competence Center Embedded Linux
