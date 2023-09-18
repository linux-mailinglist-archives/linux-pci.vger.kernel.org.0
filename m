Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E87A3F15
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 03:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjIRBJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 21:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjIRBJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 21:09:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C0126
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 18:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJDzDUsMrC05yDSSB6IgwalT6ozdlxYZC63NCl7WU48E7si6dmTKuKUID9aam+/cdZAi1ibz+qtf8WSnzffr94QXjJjSzfXY8Ct5hQBfIQ3BhHVacxAx+982jyqSFuytC/N0VV43nM2zndjRH/6zIWw64ZlrGlbYS4by5HfkbQcX3L6135aQbbJ65mvDETj7inpkxnqSkT1mxfNIiO0tbsIF8c5kSjjB5ikSliuB5btLcj7AghOMpotMMeqYzbMY0N36inztQBY0X0ZZd6mYVo0hXxgdccUg9tW/vpmgqwBzHguEH//UvUM84wZHGRgi95JtHYKA5mUqm3xr62v1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxhDQj6OfZfP9WquLJLR8fXedfqVP7F7C1IBLPxroQY=;
 b=GJyDsBuUK9dYrajrMp2fJVHzBl5kbnokTk355+iZX7hBhMQf4mbfHEH985DSKwki6oC2N4MqKIfy+f03K0vTMWZUL6YI/jkydDUkMO73HpzmGdaeHN8tz/TTXKnXDgI+at+ceSAoq5o8v9A91YMUICa5Z/w3rIhFar0zPU1XmWPlH8brB72+pylnKHG2l326/KFKozqm3wlGeBTsQqH2SvdrL7o+IQF0sQwFs0aN+r9s+5dWZxU8p7i+SMXTqomyaOTqp1qkKzjLsFFxX18mHq91Cm0o4cTUuv9Dk29N0ZuUdlV7jjEAxmoATgjr7yaYUQxDreovNaUnfOBNocWtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxhDQj6OfZfP9WquLJLR8fXedfqVP7F7C1IBLPxroQY=;
 b=xyLV/aKr93llQL3obhlYnSsQtyIul/AU8p+KMfByiN16jXC8Ct+fg7B/Hx5jqkOKhK9cZ35oaY8OeoQRcgaPIF8fbOqS9LK/HioXjQeAEo3+s/bkmgQiRkHot+kgT1W9/JyEpgpfoBZ0kvtxGMwctD08+zLWAz5RNqlPmx1Uh9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 18 Sep
 2023 01:08:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5%2]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 01:08:58 +0000
Message-ID: <ff3fa36d-dcc9-43bb-9069-fa0939227a1e@amd.com>
Date:   Sun, 17 Sep 2023 20:08:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20230917215637.GA172139@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230917215637.GA172139@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:806:127::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: d721b12a-7dbe-4d76-575b-08dbb7e3d663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSxxQ5axz6cRWg/nUFrTOxaFn2jkdaGQoE4yESYjr7u/GmPmGNT0GNTsoNRVe8FgkuqZzZYBYapBI7/6WZbVi9O4SahK93Cmc8xKRL6/GFR33FP/ZuIuNWiFg+DpA98y6ipC16CEzCzew0ghR8ERlflvzS5xUppwMPOTXiDOZsWns5s0cUyB8S6F3og705Q3G117YzEMlMNvA6SY0rZmiDZCRwpXcDtWGWCNY1LPqsvwKmWC6BidD3cMj4Mad9Xnuv7UJXh7ZqVL6vk+K5lLLHy7WuyQtbKI/GQ1lyxWhxmtRA4EJ4Uf9xZJlEh8rQJH9Ea1wNY1K0AjU6QpJq3VzYBWq++ifA2KNGM1IXVPZjn8064xs45fhXG1lMPH7phx5eXVEL/4+ow7Gckpc8/DRCuEUWUNPzu0OvCXVGLIIzqPnfijxbhxvHjjADsgS/qqzCD88cW/VUGUlLTz5QdF/ChOKdXRtBAx+sE3SDTk1smn7Y+1+9DTlLSVKWNy4uYg2mvHZJnGNBwq6Bpi6rBIDq+d56Oc6Qn34MrGB82GEBzBKmyDA4X+hJsLJTybER7gojIGlDgdFOB6sATosKCS6BmecSKIML3pA3rBvHgVYUy22EDFT4PZnksxEFXlFkC+7yFr9cMij3xFQGUQQhCoTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(66476007)(66556008)(54906003)(36756003)(31686004)(5660300002)(2616005)(38100700002)(44832011)(26005)(2906002)(86362001)(31696002)(8676002)(4326008)(8936002)(6916009)(316002)(41300700001)(66946007)(6666004)(478600001)(966005)(83380400001)(53546011)(6486002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2drQkdnQm5nTmxtR203S00waHJmbGZZN0VVN3B6RGtZZHdQeiswVi94UGFJ?=
 =?utf-8?B?L3ZMRm5QT1pjdndudEhaMzdkRTcvZHcvYVZzYlU5WkRxQmc5cm1icXJqa0Vo?=
 =?utf-8?B?czNvdnhNZmNMUklVUVMzTHJ6cVNISWVyeTVXMWIvNmxYRE9nb3p3YmZOeXpr?=
 =?utf-8?B?ZTQ0L1NqMnI3RVBTV2dlNmFtSGVLSDZmRlRHUXpCWEU3K0hCSUdPQkFXV1NE?=
 =?utf-8?B?M1pjU2ZLNGhNQzJUT1RvMldwbXA2T1BtTHlGdXU3TW1leDdmUUhEUDNxWEYz?=
 =?utf-8?B?aFFFWHVzd0toTjNQY2pnRUZQYlU5YVpFdDdjbUpZSU40dXpuRWd3LytUaWRu?=
 =?utf-8?B?cjBXL1VLc0Y2eVNYMDgwdjV3dm9vTTg4Mkdrd3RqOHdxYmN0cEY5ckZocTZK?=
 =?utf-8?B?RHVhQ2tTVXBJUEw0NTRBc2RJYnJBTXl6Z2tCTEc0eGxlWEdKWTlFRDBPSkhD?=
 =?utf-8?B?c2lDY1J1a2hNSndvZC8vZ1dseUZhMUt2TmhSTzlVell2T2pNajlyeHhGRE5q?=
 =?utf-8?B?d3Jha0RJaHJSK0VLckNHV0J4azQwcllWbGszeDNpRlJyTUVJdzcrYjJMalZR?=
 =?utf-8?B?UVpxbEt5WGNPck9TQTBCY3MzY3ZwamdHcFhCVGhrV2E1ZXBPT04wU0ZrZkdQ?=
 =?utf-8?B?YVZqcXhMMm5rWm80dTlMVy9LY21TcGEyQ1RacHBSc1RtbnRoQ1ErL0U5eDlj?=
 =?utf-8?B?aFF3M3puVU1CSlVxc0EvcE0yWEc2NFVuTC9OMkNUSFlhdGFtOEFpWDVMUGVL?=
 =?utf-8?B?MUEwdFJrUzRyT2wxK2pRU1hoSXd5N29uTmdpTUlrUW8xUkt1VkZoSjJNcVlo?=
 =?utf-8?B?UmRyOWRzSlE3NjlHNFJWV3Y1UXFycUNFREg1cVdFRXRneHNyU3FrL2dDb1VO?=
 =?utf-8?B?eTdPb21xYVorR2FjNktwc3VLWkNDSUU5SHJQN1RBOGNGY0tmNmZVaFpQRFdj?=
 =?utf-8?B?dEFWNU5hZ1pnK3p0cXVkM3JLL2VrZ0FJb2ZabGZvbmNFdjAzTEswek5Fb2Uz?=
 =?utf-8?B?T0VoV2t1bXhLZ2VZTU1vWUpQMHdFMm16NDlzK1BDR2lMamIvNWZ2TWo2Ymov?=
 =?utf-8?B?NndyelJKK1k1c2tBblVUZ09hVnNiUWUrSUtOQzg5Z3NBbEtvTCt5cGVoaEcy?=
 =?utf-8?B?bnFCd1oxNzRCVDcxK0FxVXZLT0VzZXFDcy8zeG8ralp2enNva3Q4YjVRVkRB?=
 =?utf-8?B?S1BzbVFOOG05MmtWV2liK211aEJKQk00VlVJUkJWRWdvdk82amU1Wk9IaTlq?=
 =?utf-8?B?Y2c5R29MTlhabkYyNUhiYmd3U1B5UjRodW9mc2g1Mmlxc3p3MWV5bDMxTHBG?=
 =?utf-8?B?aHZVTXFNT01Uc01TV0loVXVkYmNYN0EwZ0x4VWdtbkZSc1dNZnlSdmFTRkNP?=
 =?utf-8?B?LytvTGJQSDlWN1Bnd1BKcUQ0cHI3enhsakJ5SnZIOERNNU1kNjJIaG1MS0Rt?=
 =?utf-8?B?eXFQWnhwUHd5WUZzU3gxWDJJOTJNN2pLVm96Ym1IaWlZbUtITTlUZ2x1UHFj?=
 =?utf-8?B?UUExRjZaaGhOd1J6Qm80NU1NWTRtRk9OWFN3Wk1SeG9rRnNEckZvWVZwUUR4?=
 =?utf-8?B?S3Rnb0J6dHVoTThwelNWUWx0Q1lDRDlkUXFDZVIyUldZNUg5dGd3SDhwUnZS?=
 =?utf-8?B?ZkZITmQrbENLRkJWMDJMWHJidXhobHdYT2hJck1rRU1VVnVNUm1VU2dmK1hs?=
 =?utf-8?B?K01ibFJmc3lYRUZheDFpZmROdlBTekZjRUg5ei82Z3NRdFJmb3hIV0ZNOVJX?=
 =?utf-8?B?RlMwaTN1N3RzM0Qyd0swQjZXVVhCQUlxUlJldFltMHpLMllaOU1QdGExemZD?=
 =?utf-8?B?ZllXcjBhSzBEcUdwaHdtOGcra2dLR0JaLy84Vk1rWUdXYXVJdGxjNmVtNTFZ?=
 =?utf-8?B?dEpzU2J5aFkxcVBKSVl1MFgzL3lpT2VaSU4zQzRlRVozSWVDVkdYVDhPdWVt?=
 =?utf-8?B?UWwvMlUxZzdvRk16bnZUaTc2Qk9EVlI4Tm4yRGxPNXcxRlA2Q1ltcXdXR2dX?=
 =?utf-8?B?a3JBdDlBNnQ0bm00TDVXNUdSd0lWYi9vT1RLZG1FbVJycGZUaC9ka1Jram5U?=
 =?utf-8?B?RVdaUEpsM3lKTzZ2cERHTXJkd2JSUzBSdUJmVXE1VTZQdThlY2RhWXY5UmNa?=
 =?utf-8?Q?fzBVPtvBhwxFXlDZIC5EPXRlC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d721b12a-7dbe-4d76-575b-08dbb7e3d663
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 01:08:58.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXU6DuA/tGh8Nfw4/BVZAAhH1DXpmXRwyVtGNZZdPro9KjyL4Q7KX8kx9UD/UfO7AT1C820IFp/i+W3XaQGiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/17/2023 16:56, Bjorn Helgaas wrote:
> On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>> from suspend. This problem occurs because the PCIe root port has been put
>> into D3hot and AMD's platform can't handle USB devices waking the platform
>> from a hardware sleep state in this case. The platform is put into
>> a hardware sleep state by the actions of the amd-pmc driver.
>>
>> Although the issue is initially reported on a single model it actually
>> affects all Yellow Carp (Rembrandt) and Pink Sardine (Phoenix) SoCs.
>> This problem only occurs on Linux specifically when attempting to
>> wake the platform from a hardware sleep state.
>> Comparing the behavior on Windows and Linux, Windows doesn't put
>> the root ports into D3 at this time.
>>
>> Linux decides the target state to put the device into at suspend by
>> this policy:
>> 1. If platform_pci_power_manageable():
>>     Use platform_pci_choose_state()
>> 2. If the device is armed for wakeup:
>>     Select the deepest D-state that supports a PME.
>> 3. Else:
>>     Use D3hot.
>>
>> Devices are considered power manageable by the platform when they have
>> one or more objects described in the table in section 7.3 of the ACPI 6.5
>> specification [1]. In this case the root ports are not power manageable.
>>
>> If devices are not considered power manageable; specs are ambiguous as
>> to what should happen.  In this situation Windows 11 puts PCIe ports
>> in D0 ostensibly due the policy from the "uPEP driver" which is a
>> complimentary driver the Linux "amd-pmc" driver.
>>
>> Linux chooses to allow D3 for these root ports due to the policy
>> introduced by commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
>> suspend").
>>
>> The Windows uPEP driver expresses the desired state that should be
>> selected for suspend but Linux doesn't, so introduce a quirk for the
>> problematic root ports.
>>
>> The quirk removes PME support for D3hot and D3cold at suspend time if the
>> system will be using s2idle. When the port is configured for wakeup this
>> will prevent these states from being selected in pci_target_state().
>>
>> After the system is resumes the PME support is re-read from the PM
>> capabilities register to allow opportunistic power savings at runtime by
>> letting the root port go into D3hot or D3cold.
> 
> There's a lot of text here, but I think the essential thing is:
> 
>    These Root Ports advertise D3hot and D3cold in the PME_Support
>    register, but PMEs do not work in those states when the amd-pmc
>    driver has put the platform in a sleep state.
> 

It's specific to the PMEs for root ports with USB4 controller connected, 
but yes otherwise correct.

I've confirmed that XHCI controllers connected to other root ports work 
fine.

>> Cc: stable@vger.kernel.org
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/quirks.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index eeec1d6f9023..ebc0afbc814e 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6188,3 +6188,64 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>> +
>> +/*
>> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
>> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system.
>> + * This manifests as a missing wakeup interrupt.
>> + *
>> + * Prevent the associated root port from using PME to wake from D3hot or
>> + * D3cold power states during s2idle.
>> + * This will effectively put the root port into D0 power state over s2idle.
>> + */
>> +static bool child_has_amd_usb4(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *child = NULL;
>> +
>> +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
>> +		if (child->vendor != PCI_VENDOR_ID_AMD)
>> +			continue;
>> +		if (pcie_find_root_port(child) != pdev)
>> +			continue;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void quirk_reenable_pme(struct pci_dev *dev)
>> +{
>> +	u16 pmc;
>> +
>> +	if (!dev->pm_cap)
>> +		return;
>> +
>> +	if (!child_has_amd_usb4(dev))
>> +		return;
>> +
>> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_PMC, &pmc);
>> +	pmc &= PCI_PM_CAP_PME_MASK;
>> +	dev->pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
>> +}
>> +
>> +static void quirk_disable_pme_suspend(struct pci_dev *dev)
>> +{
>> +	int mask;
>> +
>> +	if (pm_suspend_via_firmware())
>> +		return;
> 
> There's always something more to confuse me.  Why does
> pm_suspend_via_firmware() matter?  I can sort of see that Linux
> platform power management, which uses the PMC, is not the same
> as platform firmware being invoked at the end of a system-wide power
> management transition to a sleep state.
> 
> I guess this must have something to do with acpi_suspend_begin() and
> acpi_hibernation_begin() (the callers of
> pm_set_suspend_via_firmware())?
> 

The "why" has to do with the implementation details of how the platform 
enters and exits hardware sleep and what happens.
It's much different than how ACPI S3 works.

Most OEM platforms don't support S3, so if it distracts from the issue 
and quirk I'm fine to drop this check.

>> +	if (!child_has_amd_usb4(dev))
>> +		return;
>> +
>> +	mask = (PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >> PCI_PM_CAP_PME_SHIFT;
>> +	if (!(dev->pme_support & mask))
>> +		return;
>> +	dev->pme_support &= ~mask;
>> +	dev_info_once(&dev->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
>> +}
>> +
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
>> -- 
>> 2.34.1
>>

