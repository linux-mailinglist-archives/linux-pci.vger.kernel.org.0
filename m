Return-Path: <linux-pci+bounces-527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831D805E27
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC611F211E4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A465ECC;
	Tue,  5 Dec 2023 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUEWlaMu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1861BCA;
	Tue,  5 Dec 2023 10:53:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDsbhbs9+Ca4/xjBWasIiskP5l6mJeps5fvRQX+BPRYttnx4jFyVrmJhtyXcqeBl2GFuWBd15YfBWrdKIxMrDsZUKjW9eEqMSi7RL3XdINqbukzTYZpeVVcjw99RcnU/wRSW0iJ/3vnxv9a9hidYNxYdDBnrCsUuOoSlvhbIXBe6+bLEPcFeVrJ0Aj12BMr2TweHLlT4tIeoMnZHcspL4g4CBuDysRE89boIzAL58TTN+KFX3LrFUSFlUT3hoS3Glkcta+kC2VQlt/JpH2xmjRd/ZtlNq8Svq3AcF8UKyBI11wRgVnPEqtZZnm+McXpjn90dRm66RIzGjp8erwO5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/CzHMItTCPARyJCyDd4G8chxipuR3RmnjsiLeSi8Lk=;
 b=Rmon5d9WJs65ctbekn98xTYJN+ZEZ6F9pbj/nn95ljRmX4fUJ/qCQwi+CuezNBkaxGj/Mm4fOKrViKpmt+VmzVoAZVeZ1B7MrBy1mgdPfhbSXbUDs/FceAsDSd5K/xENMPeVhZJf8tEtBKLStgj6Q4XvK/xUB03v/13w76o/gE+/dJH0+8O5OOs3ICTzxDuOpL78pan11hWTKnbZUTBW9j2ymujr7m9AwiJ+dXuimeDCCbDxjyKUeyIENA/wbPxPtZJ2fq17PH8oY9utSWxAIsrJGtOe1V9mm40zZWfZgCxUBveTUArYeoUaqoINyJudHR8kR6J5/qKRomLwd60c5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/CzHMItTCPARyJCyDd4G8chxipuR3RmnjsiLeSi8Lk=;
 b=yUEWlaMui8R5RpC2lh6VXb6jg2GqaR29+rt2r/lymzCoaj3unmg9b2bB7i2jQDknn4hBqI5/2jgkRJPU1RRvPbHQkifAChQ9Kzs56qD5Drb0s6UZFyOW2Cp9Fj9rXXcMszpElY0VibWR8k2gay0JrrNSagMLa0hMflBEptxappc=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:53:50 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::14) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 18:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 18:53:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 12:53:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 10:53:49 -0800
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 12:53:47 -0600
Message-ID: <0cd5fe3b-8039-e534-03ac-aa6fd8f9c7c0@amd.com>
Date: Tue, 5 Dec 2023 10:53:47 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Max Zhen
	<max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
	<stefano.stabellini@xilinx.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, "Allan
 Nielsen" <allan.nielsen@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
 <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
 <20231204134335.3ded3d46@bootlin.com>
 <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
 <20231204163014.4da383f2@bootlin.com>
 <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8165f3c9-9886-44d9-3115-08dbf5c3850c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nCnRbcd+bc1jZynQl/N4vciCSfIO0qbHM6GchWrOxUequzvbF9lVlWBgpaXvfDjDfyHbKB4bMaO9zcudiqNdJyj4hPXrQUNMpbm1iN0FczhfJ9enH4fiCN076ikfk2vh9seXuoPIeGIbENS5C7xuYBIgWi2R7DDCAvFe09RiLVWvScjKGqWvaKros7+Qaypiw83z2OCy3aIyYdi875ZK97lyvClzpDAg0MARW4rl29T9lKUMeJ+yOyKe3VIu+tLQO7RXumDSwU1h0epH+mJ9sEa6tTQLwoVXr4ItGhDhN3XBQvsk8OfT7sFQqKPmQUJKqh4an5O8/pRSo8i2ada04pCWHy06gqQ5R6UBhHKjOahb5vSxJR3KhtxT1GZ2jEwpkw/swn2NQ3+sIsuUhr9Jyrh4I/TFA6Dxsvu+hZRC3OdkzWiqdRghgZx6qMj61qdWrwc9jjpI+SMBScMV2Aiy9k4cjdP5bp1VXTKsmo4I6qBRaE9yVWzjufBtM2oUGEllPJAYOhdLPL+ws0eNF88fhULZZCvDIn2em3x0c+5c9Pbt/MxgFvblOptWfYfxbb8C+Xbrbwgy8yesiyeGfinkIUlkeEj8BFg5xxDJPP3EXhtMfOdsA24CgmUcQr/CgPXGO57YXC0EHuFZJUL1jxbdjjXrhYdg8vjE4V7oz0tm8QTmvW9w8tgO8jULWTBf6thxN4sHD7THbtyVqLOCxjErL6uIDj4guFYo1DXj+BHGZJoI4YuMjxrE4DMYx4KdwnUMnkZvo1Y9pLhexVRGmteNmLf9aNWLAAUn3Od50UbUJwNY0GbdPKRRi8ofZNW+YT3jgHVcPyNhcABDuHNzpfBxRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(31696002)(40460700003)(44832011)(82740400003)(2906002)(5660300002)(7416002)(36756003)(86362001)(41300700001)(478600001)(966005)(40480700001)(53546011)(36860700001)(83380400001)(26005)(2616005)(47076005)(426003)(336012)(31686004)(8676002)(4326008)(8936002)(81166007)(70586007)(70206006)(356005)(110136005)(54906003)(16576012)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:53:50.0778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8165f3c9-9886-44d9-3115-08dbf5c3850c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067


On 12/4/23 15:03, Rob Herring wrote:
> On Mon, Dec 4, 2023 at 9:30 AM Herve Codina <herve.codina@bootlin.com> wrote:
>> Hi Rob,
>>
>> On Mon, 4 Dec 2023 07:59:09 -0600
>> Rob Herring <robh@kernel.org> wrote:
>>
>> [...]
>>
>>>>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>>>>> index 9c2137dae429..46b252bbe500 100644
>>>>> --- a/drivers/pci/bus.c
>>>>> +++ b/drivers/pci/bus.c
>>>>> @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>>>>>           */
>>>>>          pcibios_bus_add_device(dev);
>>>>>          pci_fixup_device(pci_fixup_final, dev);
>>>>> -       if (pci_is_bridge(dev))
>>>>> -               of_pci_make_dev_node(dev);
>>>>>          pci_create_sysfs_dev_files(dev);
>>>>>          pci_proc_attach_device(dev);
>>>>>          pci_bridge_d3_update(dev);
>>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>>>> index 51e3dd0ea5ab..e15eaf0127fc 100644
>>>>> --- a/drivers/pci/of.c
>>>>> +++ b/drivers/pci/of.c
>>>>> @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
>>>>>                  return 0;
>>>>>
>>>>>          node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
>>>>> +       if (!node && pci_is_bridge(dev))
>>>>> +               of_pci_make_dev_node(dev);
>>>>>          if (!node)
>>>>>                  return 0;
>>>> Maybe it is too early.
>>>> of_pci_make_dev_node() creates a node and fills some properties based on
>>>> some already set values available in the PCI device such as its struct resource
>>>> values.
>>>> We need to have some values set by the PCI infra in order to create our DT node
>>>> with correct values.
>>> Indeed, that's probably the issue I'm having. In that case,
>>> DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
>>> device_add().
>>>
>>> I think modifying sysfs after device_add() is going to race with
>>> userspace. Userspace is notified of a new device, and then the of_node
>>> link may or may not be there when it reads sysfs. Also, not sure if
>>> we'll need DT modaliases with PCI devices, but they won't work if the
>>> DT node is not set before device_add().
>> Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
>> On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_FIXUP_HEADER
>> fix your QEMU unittest ?
> No...
>
> And testing the bridge part crashes. That's because there's a
> dependency on the bridge->subordinate to write out bus-range and
> interrupt-map. I think the fix there is we should just not write those
> properties. The bus range isn't needed because the kernel does its own
> assignments. For interrupt-map, it is only needed if "interrupts" is
Without 'bus-range', dtc will output a warning while compiling the 
generated node.
> present in the child devices. If not present, then the standard PCI
> swizzling is used. Alternatively, I think the interrupt mapping could
> be simplified to just implement the standard swizzling at each level
> which isn't dependent on any of the devices on the bus. I gave that a
> go where each interrupt-map just points to the parent bridge, but ran
> into an issue that the bridge nodes don't have a phandle. That should
> be fixable, but I'd rather go with the first option. I suppose that

Do you mean it might be something similar with I posted in V12?

https://lore.kernel.org/lkml/97ae2eda-f712-0b83-dc90-0f29edd5db8b@amd.com/


Thanks,

Lizhi

> depends on how the interrupts downstream of the PCI device need to get
> resolved. It could be that the PCI device serves as the interrupt
> controller and can resolve the parent interrupt on its own (which may
> be needed for ACPI host anyways).
>
>> We have to note that between the pci_fixup_device(pci_fixup_header, dev) call
>> and the device_add() call, the call to pci_set_msi_domain() is present.
>> MSIs are not supported currently but in the future ...
> MSI's aren't ever described in PCI nodes. Only the host bridge. So I
> don't think we should have problems there.
>
>> Related to DT modaliases, I don't think they are needed.
>> All drivers related to PCI device should be declared as pci_driver.
>> Correct me if I am wrong but I think that the core PCI will load the correct
>> module without any DT modalias.
> Yes, you are probably right.
>
> Rob

