Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1344B068E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 07:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiBJGt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 01:49:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiBJGtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 01:49:55 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20042.outbound.protection.outlook.com [40.107.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098441007;
        Wed,  9 Feb 2022 22:49:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9RuHxCvoi5rBCAYcak4RmQHkqdbmJNC50LfTSiiGlP/pfDAavTB5CEuqfSd9hotvUZpQALYWNRYnSP7RR5DVKM3syPE6qAp+o0anAChavbITaCD6ahoR5jCAalx1fsr67yFixUZDUBIbv2Hd2S7DPIIk+bZWtnGgqUVTlvBjNC0Vj/43XsCADt3vyoV9EGufLdZu1jFc2xylELM+wj6Wz6oF+x7UnzLhtbC0/jPc+slAWlZPkhY8a2CDJbhDCVB39UwDsoEJrUEu4NC498byn0QuFhSMNh/S2aopLqr/8QjIH1JMlPDusvp18JhklMEW4ysl9XtvV06SeTZ21k7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba6TCWpFW0RKXtDYU90Q5TQlImfcx2Mvx07jDD5q94c=;
 b=RBrG5xH4hE7goLeRpALwHfrl17bmtWje37UvKasSsc3GKqUyN4Tu4MPDF+ALwnl6AaPIcOje1mBwWkwBB37B++07J/Whxizq9eNbyrfJ4znXBPLyZNgih1CSrjiF1bHTn6VNe1omaCpCvso88LLIAj6gtD/vw+js60k4Y5pBY/WvBk8wBG8U8LI4PsAjSKPtvFtp8nzvy9sTo+UkNWG98BTLbhlmBXO7aB9oPL18ogq9IZbssdNpyU9VAs9Xx+Ry93fLi48V6mIyLlQnW7IyKZ946ytvmv9i0R5PDjgbcUd/wWIBcPK/yvtdwcJ8LHD/YbxCaSnW8j71dcjNIJFtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba6TCWpFW0RKXtDYU90Q5TQlImfcx2Mvx07jDD5q94c=;
 b=vtCLRQ+L38AO9SQmJuG3prd2bb50b0nePzZK+SJ18p0cdFsvygdGdEu4CxYeEpxBYe0TeqefgfYIrQLFvkmRMbfqoRinDygRUhhbWr3bMbPJcqBweFLKOAEjrLMkJBPie3231oSVVwOn0V/NwIshT2uFnxx5BStaELdbW+eboITFSVNx76VY+O9slF4vfjeJItPwxvWVSbpx+UO+eGHkn2jsJOD3zlB82Zh/l35Zms9qC53ZJXWzHP3menc8s60K8v3UK8XiCYGjK6wQn230CHRoSgvUD2H7shAEJ8wYDc7+21Y/izX+kEXLUWFGB2rBfIzBCWzujZrmi8C/QBQkog==
Received: from SV0P279CA0034.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::21)
 by PAXPR10MB4782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 06:49:54 +0000
Received: from HE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::d3) by SV0P279CA0034.outlook.office365.com
 (2603:10a6:f10:12::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 06:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT032.mail.protection.outlook.com (10.152.0.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:49:54 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Feb 2022 07:49:53 +0100
Received: from [139.22.138.134] (139.22.138.134) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Feb 2022 07:49:53 +0100
Message-ID: <e6d05638-28d3-f0d7-3dfb-5d28be0e85a2@siemens.com>
Date:   Thu, 10 Feb 2022 07:49:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PCI/portdrv: Do not setup up IRQs if there are no
 users
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        David Spencer <dspencer577@gmail.com>,
        Joey Corleone <joey.corleone@mail.ru>,
        "Sergiu Deitsch" <sergiu.deitsch@gmail.com>
References: <20220208185658.GA489586@bhelgaas>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220208185658.GA489586@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.134]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a4a7a2e-729a-4517-df15-08d9ec618b69
X-MS-TrafficTypeDiagnostic: PAXPR10MB4782:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB478241686146BE7612EC4021952F9@PAXPR10MB4782.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEB5DtIiBu+XIdd5a3reA0oZvoQBlzvBgQA6KY3GJx0SMREWeqjG9oMhUZrD4JhpF9+NSlKRhXk1pd2AkJqMCD+fR1k7Ep58YWmyQ/TyQH5KzWu2LniIHO9s5TeA09Tv3opn0Sd6JO5WjBeGqsrXf/3NspRMtuJLXL1/vqDvQq7/Hs9WTuB2If0ozWS/vbCfMo7JWXZoZ9aywgPfvWdfF8wz0QXxiHIh5EMGLW7UKyFiwIkEEyqG21CkYE7HkNNixu6zTGmeZHzMpxRZ47SqoL3UqraKe6lQDzPPaqb0EbpQLvVC5V2jiMk6SuxkGtp4qhPv39WjLY5TaadbWZi6JJHKp0C8MPncWt0SbHew06uSOWkPJD//SWCEATyPTO0nL1ugy+tBgKxS/ohV42LG24TD61UEaxAvqvzZUYnKY/8uPx/6cr851I9AOGQ4+Y+eEZBu23Ctqoe3eDCyr9o1TBjerqTtvp8micCWiNovl9S2g2nObu+RF/goVGx7KhTUCPNRQKP29jeFgKo40UVgZzqtFlMRNlKOXtYvZzZyuwgyJwSnTsq/7LM19fXqS82Jx39W39Rxeo5vRwfASIIHchlUoopo/pLuKlJdbfB8b63S0wa64yIpCgBpW+bbG/uRi59l2Pb5N0xmoWj8vjmCbkwHt3WRXW5nlh48Uo8InZfRvZ1YIRRsW+iQBDh0UzIfXdUaSrpU4sd0FygRscm+DR+wTsTPIUu2lHBMmWUGuy1Zpa9cxwTMAI/7n+r++bsdlgKbfU/FSj1dNgpFrPWh/3kQ7BgqMMfTNO0O2vrvgOmBrpYqRMLyEgXxecNSchKaLOg6+GnOBTJQkwJQ/e9aQYZt8RPVNJt434lpO8EAzsKKrUqXx3sFlsoURs4e19OIY5QWFKj5wubHfbsTLs2ohFZ8ZJnsinkaTtSWrwmhjq0=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(54906003)(2616005)(508600001)(47076005)(16576012)(5660300002)(31696002)(8936002)(82960400001)(4326008)(356005)(81166007)(31686004)(956004)(83380400001)(44832011)(70206006)(40460700003)(36756003)(2906002)(8676002)(70586007)(82310400004)(6916009)(53546011)(36860700001)(6706004)(336012)(316002)(16526019)(186003)(86362001)(966005)(26730200005)(3940600001)(19860200003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:49:54.3751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4a7a2e-729a-4517-df15-08d9ec618b69
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08.02.22 19:56, Bjorn Helgaas wrote:
> [+cc David, Joey, Sergiu]
> 
> On Mon, Jan 31, 2022 at 10:22:28PM +0100, Jan Kiszka wrote:
>> On 30.08.21 10:08, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Avoid registering service IRQs if there is no service that offers them
>>> or no driver to register a handler against them. This saves IRQ vectors
>>> when they are limited (e.g. on x86) and also avoids that spurious events
>>> could hit a missing handler. Such spurious events need to be generated
>>> by the Jailhouse hypervisor for active MSI vectors when enabling or
>>> disabling itself.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Changes in v2:
>>>   - move initialization of irqs to address test bot finding
>>>
>>>   drivers/pci/pcie/portdrv_core.c | 47 +++++++++++++++++++++------------
>>>   1 file changed, 30 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>>> index e1fed6649c41..0e2556269429 100644
>>> --- a/drivers/pci/pcie/portdrv_core.c
>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>> @@ -166,9 +166,6 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>>>   {
>>>   	int ret, i;
>>> -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
>>> -		irqs[i] = -1;
>>> -
>>>   	/*
>>>   	 * If we support PME but can't use MSI/MSI-X for it, we have to
>>>   	 * fall back to INTx or other interrupts, e.g., a system shared
>>> @@ -312,8 +309,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>>>    */
>>>   int pcie_port_device_register(struct pci_dev *dev)
>>>   {
>>> -	int status, capabilities, i, nr_service;
>>> -	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
>>> +	int status, capabilities, irq_services, i, nr_service;
>>> +	int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
>>> +		[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
>>> +	};
>>>   	/* Enable PCI Express port device */
>>>   	status = pci_enable_device(dev);
>>> @@ -326,18 +325,32 @@ int pcie_port_device_register(struct pci_dev *dev)
>>>   		return 0;
>>>   	pci_set_master(dev);
>>> -	/*
>>> -	 * Initialize service irqs. Don't use service devices that
>>> -	 * require interrupts if there is no way to generate them.
>>> -	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
>>> -	 * that can be used in the absence of irqs.  Allow them to determine
>>> -	 * if that is to be used.
>>> -	 */
>>> -	status = pcie_init_service_irqs(dev, irqs, capabilities);
>>> -	if (status) {
>>> -		capabilities &= PCIE_PORT_SERVICE_HP;
>>> -		if (!capabilities)
>>> -			goto error_disable;
>>> +
>>> +	irq_services = 0;
>>> +	if (IS_ENABLED(CONFIG_PCIE_PME))
>>> +		irq_services |= PCIE_PORT_SERVICE_PME;
>>> +	if (IS_ENABLED(CONFIG_PCIEAER))
>>> +		irq_services |= PCIE_PORT_SERVICE_AER;
>>> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>>> +		irq_services |= PCIE_PORT_SERVICE_HP;
>>> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
>>> +		irq_services |= PCIE_PORT_SERVICE_DPC;
>>> +	irq_services &= capabilities;
>>> +
>>> +	if (irq_services) {
>>> +		/*
>>> +		 * Initialize service irqs. Don't use service devices that
>>> +		 * require interrupts if there is no way to generate them.
>>> +		 * However, some drivers may have a polling mode (e.g.
>>> +		 * pciehp_poll_mode) that can be used in the absence of irqs.
>>> +		 * Allow them to determine if that is to be used.
>>> +		 */
>>> +		status = pcie_init_service_irqs(dev, irqs, irq_services);
>>> +		if (status) {
>>> +			irq_services &= PCIE_PORT_SERVICE_HP;
>>> +			if (!irq_services)
>>> +				goto error_disable;
>>> +		}
>>>   	}
>>>   	/* Allocate child services if any */
>>
>> It turns out that this patch causes troubles on some machines, see [1].
>> That could be "resolved" by doing
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index bda630889f95..68b0013c3662 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -331,7 +331,7 @@ int pcie_port_device_register(struct pci_dev *dev)
>>  	pci_set_master(dev);
>> -	irq_services = 0;
>> +	irq_services = PCIE_PORT_SERVICE_BWNOTIF;
>>  	if (IS_ENABLED(CONFIG_PCIE_PME))
>>  		irq_services |= PCIE_PORT_SERVICE_PME;
>>  	if (IS_ENABLED(CONFIG_PCIEAER))
>>
>> thus considering bandwidth notification as an IRQ-providing service as
>> well. But as far as I can see, there is no driver for this port service,
>> thus no one should ever request or even handle that interrupt.
>>
>> I'm not yet seeing the key difference that could explain this effect.
>> What else happens via pcie_device_init() when called for
>> PCIE_PORT_SERVICE_BWNOTIF, although there will never be a driver?
>>
>> Jan
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215533
> 
> Comparing David's "pci=earlydump" logs from [2,3] I see these
> differences:
> 
>   - BIOS 1.12
>   + BIOS 1.14
>       00:1d.0 Root Port to [bus 04]
>   -     Status: INTx-
>   +     Status: INTx+
>   -       DevSta: CorrErr+
>   +       DevSta: CorrErr-
>   -       LnkCtl: CommClk+ AutWidDis+ BWInt- AutBWInt+
>   +       LnkCtl: CommClk- AutWidDis- BWInt+ AutBWInt-
>       04:00.0 NVMe SSD
>   -       LnkCtl: CommClk+ ClockPM-
>   +       LnkCtl: CommClk- ClockPM+
> 
> It looks like BIOS 1.14 leaves the BWInt bit (Link Bandwidth
> Management Interrupt Enable) *set*, while BIOS 1.12 left it cleared.
> 
> Joey's log [4] with BIOS 1.14 also shows BWInt set:
> 
>   + BIOS 1.14
>       00:1d.0 Root Port to [bus 04]
>   +     Status: INTx+
>   +       DevSta: CorrErr-
>   +       LnkCtl: CommClk- AutWidDis- BWInt+ AutBWInt-
>       04:00.0 NVMe SSD
>   +       LnkCtl: CommClk- ClockPM-
> 
> In my opinion this is a BIOS defect.  The BIOS should not leave an
> interrupt enabled unless it is prepared to handle the interrupt.
> 
> But Linux should be able to tolerate this.  Maybe we could clear
> PCI_EXP_LNKCTL_LBMIE and PCI_EXP_LNKCTL_LABIE somewhere like
> pci_configure_device().
> 
> Maybe we should also clear other PCIe interrupt enables like
> PCI_EXP_SLTCTL_CCIE, PCI_EXP_SLTCTL_HPIE, PCI_EXP_RTCTL_PMEIE.
> They should be enabled after installing an interrupt handler for them.
> 

So, we have firmware that leaves interrupts sources enabled in the
devices for the OS? What a mess. The reason why that "worked" was then
pure luck: interrupt sharing of that source with others, disabled ones +
unconditional handler registration for those. Makes sense now.

I agree that disabling all unused sources will then be needed to address
also broken firmware. Conceptually, the same problem could happen with
them when we stop registering handlers for unused sources.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
