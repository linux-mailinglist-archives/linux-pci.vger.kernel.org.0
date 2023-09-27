Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A517B0C0F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjI0SlC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SlB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 14:41:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D78F
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 11:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpt0U139kDm6/C+KGVItN4bj97YWAXdGX3MgYwtzM/hSrAKcqqsMoe/hWUIOENpz3gkhRBiG+/lJcgHodOKS65G663YVEF9apwwx92axuF/bghbK7jrhP0lPOq0/FKZv9rKaD7Mss7LEOHMOar7O0Q9GD1a3petg+5nvj8vOhDzrQ6vLhYdrf8NTWIjo0R1+qExjyO6H44aM/GI3bxxpaP8Rycy/P1r2Eqvl/6kHtnhDbfrdLsGKD42QROLCI8ccLynMmn/D+LAMp0RgYrpWhCS55XbVefsbuLvTSF9ABxPCKWE904MRxHV3hIx1B7tFXPwf4eBW2C93ZhLVlgwoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DURQckPMOHekdB3WhlEHLB0RFfr+NWBd6cc8WlY2qE=;
 b=eUQdPMNjVYfSJHEtaC1hxVW4mpCfGSP0ne2Z+EnXT7jGKFFh8Y7xh/eBCGDp51jW54RQP/dRQ8XuA/pyG+xHgm9Z1hoz6V4AVphD1S/oJy7HfT3gZccguSDEGh832WzXB6O0JsArYVYf4N0Lncu4pxZUZWKvtaYRGuqKq89f1Ja5fC1maDI0Le8+6VnASErK5p2/LOrJ/fNBbLm8yzqKkXTmCvKuCFitSY+3ivqNen5aKHXS8kPQnWZNGoscqSG9+YzEj/EoVn0ORx+NZVWQQ90hqJ1iVY2XhAFs4DPKd6Q6pPZT+mGWTeo7hTEdKbjVJ7aAeDoV+LnqI4ZZ9XpcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DURQckPMOHekdB3WhlEHLB0RFfr+NWBd6cc8WlY2qE=;
 b=snEDeSQ3QdcCwiT08WGWDDILcVugFv2kJsREI0ChvxLP7i7M5COPc4/x3IZdUKwD+tmn0/6GCWQgV1YUaeDkNOPTzk2Ly44kSTN0i3HwSJ5dMQUX266wEMHAmZMm0L7iArHKQaBFSqL7oxB2lGUA/sIFSs7AHgvh5uzLhBQeSkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:40:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:40:55 +0000
Message-ID: <d544c07f-82a1-409f-a9e7-4a409edbad86@amd.com>
Date:   Wed, 27 Sep 2023 13:40:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20230920032724.71083-1-mario.limonciello@amd.com>
 <20230920032724.71083-3-mario.limonciello@amd.com>
 <20230925052001.GK3208943@black.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230925052001.GK3208943@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:f2::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: eee375c9-ec42-46cd-8b06-08dbbf8948d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFcdyexoV0uyVpHH5/Kl4ADAY/1kNVGEUUlYL5/L1+me1IEIcjUaH+eenbwlTwJC2kgE1qbBCHYQllVGNrmIAHlKxUCUWQuCM6RTHoCJFPbX7sC5xeSPmrrWsZ/RD1Md1fcxInkhxjY+vHoR/k7DgO0w7+4m3JcVZfy8kZJrCDbEQBDKdaw6eidUCq5GB0m65j4hbNfdYY0Hu//qdtt6oz0hQGEtiSXk3yI9UQB1R0jQlPsHN9Oa9Ig8Dp8ufypzy8H1pUV+HewyMDz5WRIh92KBSlnZ27QLdmgj22ANl6KYj0NL7DfAfLzReAOl+BKmWut0rgduJzUeeerfdR0PB3JT3Pt82OwDbDzSvZ6Mqhg0ohNy1nAWX/CuaISuT2VX7r6o5JlrU3KA0+4nFrPvXKUm7rjyHnuu4glDqGGFW1UD/+hrVbn8T8a9StiVGVkBfKwF8dlovU/qSq0FyY8pWbO6Fpk60hcrjWyZlgGtSqXAyvQg22imRCKtoxye+6/5AoE8wnsVoJKYJvJTDOVeOxFyT9hJV3SK6K2SeubqxYcuJFaPEqHonpXoQX/c3qZcLIqPh/47VLzAsmAuUVPS1IBxmBk2jsWRm5FCZr4Yp8dv5T0EdIFbz3+EeV/LZ6bJ3idut6v0vz22K+MVaqLi1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(44832011)(316002)(5660300002)(8936002)(4326008)(41300700001)(8676002)(66476007)(66556008)(54906003)(6916009)(31686004)(66946007)(2906002)(31696002)(53546011)(2616005)(6512007)(6506007)(36756003)(966005)(478600001)(6486002)(83380400001)(86362001)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRNVkNnVG5zZlNQR3djU0N2TUVYcStKK1BzaFpZbkxUMVR2VzZsbnRDM0Jm?=
 =?utf-8?B?VnBiUFBYdG1iNk13N08rdDcvRG5JcVRiVENiajA3Y2R5Z25sTEVoNm5XQ1hD?=
 =?utf-8?B?aXF4TWp2Z2dlMnVrK3dycjdaNW0zWmhGWWxWSW9TbHdIcnBEeTRSVEFoRGZn?=
 =?utf-8?B?M3VpcUlxaGljQWhIRUVjZFN4QW4vMld6OU1ScytJMHFHSXJSZ09UVTBiU3Bm?=
 =?utf-8?B?STlESWdBSTZONzhwWFNtUExrbnZocjdHNFJGTzRia2wxdVpkVW5PY3dHblpw?=
 =?utf-8?B?Q2R3K09tZzVjb0UzSm91dXQ1WXN0Z3dQODRLUVp6VXVnZW96ZWZjaGdaS1pw?=
 =?utf-8?B?SnBDemhQdENTYmt0VUpSSEpEWTNqNUl0Vm9CcEJ2WDlqZUh6ZEtCZzZnRm4r?=
 =?utf-8?B?QkVaUVhMakFlNmtpb2Z0djFYbU43cVFiRno0c29kM2RiUmVHa0ZkM1lUclE1?=
 =?utf-8?B?S3FVME1NR1pwdTBpbEdCOXppZFNuR01PSUdsQmh5RlJuMm5rRGMweDBBQm5i?=
 =?utf-8?B?cW0za2RKajJDdm80SnZwWnNZMXBlZS82Y2lkMStZTkxqMFlwN0Rna09vWHN6?=
 =?utf-8?B?VVNla1RTcllHNFJoTGROTFZQZE93clBPZEQ5bUZtMjVzZUNPbWhCcGtOeFB3?=
 =?utf-8?B?OE4yREViZDRCTDFvb0k3WmZUWnNRc3BlaGx4NkEwNWdyUmxnQy9PY1Ztc2FB?=
 =?utf-8?B?Y3ZrTXFHbTF0TDJRUGdoVGJVbVVxdjFlb1JvbjJuQmhjbXJrY01BS2tPVUF5?=
 =?utf-8?B?UVNyWFdmTFhISGhobno5WEFRNWJnTzBBMU5RTTBXNnZKZ0JvTHZwT2k1TDRR?=
 =?utf-8?B?a2dYNURrMldaSC9iemNvOHd1b05JcTdFNGpWM20wVjJlTmJwQm9SRytyVFpl?=
 =?utf-8?B?Y3ltaHRjSGdvYjlPNEhnTWNsMm1jbGdrc25uZ2s1YzYxditDZXF1UUd5UHlW?=
 =?utf-8?B?TENjNjBFb1h5c2o1QTBXNmY2ZGdXN0g4Z0RaM2dJTm11Zmt2bnBsemUxVnZI?=
 =?utf-8?B?UDA2ZGlXOEEvWXp1OXhOMUt4akhUK3dMTktPVHY3eHFRWkp4c05oTkUyZ01o?=
 =?utf-8?B?SjBKejFiY0pDdnhXbXpMK0FWVXFxMnNnSHArNVVudkE4NzNXbUMveWhnUlgy?=
 =?utf-8?B?UGo5c1hLcENrV1JmUU9pY1BTKzRVd3lKeFNjL1QvWTBWVkY5RSsxdVVLNGN0?=
 =?utf-8?B?VkhmNHJhb3NpMkRBS3NWeXRRc3kvYm5BZHg0L0lJc25XSTRFbHM2eWdxQWpR?=
 =?utf-8?B?d3FmSk45c3RsVjcxYVRRLy85eDRVTmVZOThZWWZwalRFT250cFhtMWxzQnFV?=
 =?utf-8?B?Ly9rN2JCeGVuWGNKMktZeElleEMrb0U4dDcwY25ZV1Z0L0NmYVBJa2dDZ1ZR?=
 =?utf-8?B?UjBTZFFJNit1S3d0M3RBc2lxTWJVazd3alNOZlY2OStRSk9udkpaVDNVVHA2?=
 =?utf-8?B?UkR0N3Y1YUVFczFLSGVsb2pRVTIwOU84WnRpclNGV1RlMmpmYzlLUUlsL3Vu?=
 =?utf-8?B?Y2dJUmZhR043TTN3MDlHa3pnTkZqQmw1SE1ZUi8rdUNpeCt1dUJkYWEraWl3?=
 =?utf-8?B?T3lFMG9hMGwyblhpZ2hWa0NrbWt6V1MyR0NsZE45SnVPSW9vV1JKVGZBNzhn?=
 =?utf-8?B?OVBZeUhlOWZ3UUpHR3lmeGV4WVFjNlVyWXdZTkZFRituMVdOQmlkNVZPU3VJ?=
 =?utf-8?B?RFlIUFkyZmFBMkZTQUVhOUozdzRXb2YvQnVhaktkWEZHbjZVRk1peTIvRml1?=
 =?utf-8?B?cFgxNmlZblpmUkxpQTFHTGY0Y3RLaWxnelh1OThKZitNNDBaOWZDdFY5TUZH?=
 =?utf-8?B?Rlo1cWo1d0lmeFBpNmNqQVdWVURWNUF0Wk5wUnFTbzllSy80aGRiYjY0OVRX?=
 =?utf-8?B?VFc1NGQ2S3k5NDk2WVVXb3JzMGp5aTVIelhzcktYNkVzbTZVVDUzY25nNE5H?=
 =?utf-8?B?Rnh2bk5IbDJ2SEE0Sk1hSU9SK1RwOHBjU3RvM1FjRkMwN2pHejJLa0NQTE9H?=
 =?utf-8?B?eGIwdXlIbGE0YVdaQzBKUk5aVHovaUZOZmVScEtueEFRcWNYVTNjaHNZSTcw?=
 =?utf-8?B?U1g2RDRVeFN0OUtac1JmV2NiZkhPRUtWY3NEMmdVa0lOa2hCRTVUWFEyelBa?=
 =?utf-8?Q?4oFFcioKkQWSQJ/0OMSx4DGs4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee375c9-ec42-46cd-8b06-08dbbf8948d9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:40:55.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YB86ZLcy0HeJNbiYFY2gsnc9kgyxqyDcDvBib6wIiQkyEpMrFT9mAO9dccJ8dn0N0hY04I+UQO6gPnGX+PkIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/25/2023 00:20, Mika Westerberg wrote:
> On Tue, Sep 19, 2023 at 10:27:24PM -0500, Mario Limonciello wrote:
>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>> from suspend. This problem occurs because the PCIe root port has been put
>> into D3hot and AMD's platform can't handle the PME associated with USB
>> devices waking the platform from a hardware sleep state in this case.
>> The platform is put into a hardware sleep state by the actions of the
>> amd-pmc driver.
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
>> suspend"). Since Linux allows D3 for these ports, it follows the
>> assertion that a PME can be used to wake from D3hot or D3cold and selects
>> D3hot at suspend time.
>>
>> Even though the PCIe PM capabilities advertise PME from D3hot or D3cold
>> the Windows uPEP driver expresses the desired state that should be
>> selected for suspend is still D30.  As Linux doesn't use this information,
>> for makin ga policy decision introduce a quirk for the problematic root
>> ports.
>>
>> The quirk removes PME support for D3hot and D3cold at system suspend time.
>> When the port is configured for wakeup this will prevent these states
>> from being selected in pci_target_state().
>>
>> After the system is resumes the PME support is re-read from the PM
>> capabilities register to allow opportunistic power savings at runtime by
>> letting the root port go into D3hot or D3cold.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> One super-minor comment, no need to send a new version just for this.

Much appreciated!

Bjorn,

Anything else you want to see for this series?

> 
>> ---
>> v19->v20:
>>   * Adjust commit message (Bjorn)
>>   * Use FIELD_GET (Ilpo)
>>   * Use pci_walk_bus (Lukas)
>> ---
>>   drivers/pci/quirks.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index eeec1d6f9023..4159b7f20fd5 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6188,3 +6188,74 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>> +
>> +#ifdef CONFIG_SUSPEND
>> +/*
>> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
>> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system
>> + * from suspend to idle.  This manifests as a missing wakeup interrupt.
>> + *
>> + * Prevent the associated root port from using PME to wake from D3hot or
>> + * D3cold power states during suspend.
>> + * This will effectively put the root port into D0 power state over suspend.
>> + */
>> +#define PCI_PM_CAP_D3_PME_MASK	((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) \
>> +				>> PCI_PM_CAP_PME_SHIFT)
>> +static int modify_pme_amd_usb4(struct pci_dev *dev, void *data)
>> +{
>> +	bool *suspend = (bool *)data;
> 
> You could also pass the bool as value because void * can hold it so
> 
> 	bool suspend = (bool)data;
> 
>> +	struct pci_dev *rp;
>> +	u16 pmc;
>> +
>> +	if (dev->vendor != PCI_VENDOR_ID_AMD ||
>> +	    dev->class != PCI_CLASS_SERIAL_USB_USB4)
>> +		return 0;
>> +	rp = pcie_find_root_port(dev);
>> +	if (!rp->pm_cap)
>> +		return -ENODEV;
>> +
>> +	if (*suspend) {
>> +		if (!(rp->pme_support & PCI_PM_CAP_D3_PME_MASK))
>> +			return -EINVAL;
>> +
>> +		rp->pme_support &= ~PCI_PM_CAP_D3_PME_MASK;
>> +		dev_info_once(&rp->dev, "quirk: disabling PME from D3hot and D3cold at suspend\n");
>> +
>> +		/* no need to check any more devices, found and applied quirk */
>> +		return -EEXIST;
>> +	}
>> +
>> +	/* already done */
>> +	if (rp->pme_support & PCI_PM_CAP_D3_PME_MASK)
>> +		return -EINVAL;
>> +
>> +	/* restore hardware defaults so runtime suspend can use it */
>> +	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
>> +	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
>> +
>> +	return -EEXIST;
>> +}
>> +
>> +static void quirk_reenable_pme(struct pci_dev *dev)
>> +{
>> +	bool suspend = FALSE;
>> +
>> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
> 
> and here
> 
> 	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)false);
> 
>> +}
>> +
>> +static void quirk_disable_pme_suspend(struct pci_dev *dev)
>> +{
>> +	bool suspend = TRUE;
>> +
>> +	/* skip for runtime suspend */
>> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
>> +		return;
>> +
>> +	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)&suspend);
> 
> here
> 
> 	pci_walk_bus(dev->bus, modify_pme_amd_usb4, (void *)true);
>> +}
>> +
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, quirk_disable_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14eb, quirk_disable_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14eb, quirk_reenable_pme);
>> +#endif /* CONFIG_SUSPEND */
>> -- 
>> 2.34.1

