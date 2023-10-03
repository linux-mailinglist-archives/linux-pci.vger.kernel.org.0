Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6928C7B7083
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 20:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjJCSG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJCSG6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 14:06:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6C83;
        Tue,  3 Oct 2023 11:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgrX6JTmFOcFXSNHB3YWAxTh+GPZBt7nRaGldTVkI31Wd+f8QMJMTA7ppcCm03SNbKAc3ExD4zsr1o1p+ifKII/rT//3Xxb3l9jahqd2bEdT2TVPnoyJYXZnLZPml30OWe3DEvE0T9AkWJJFCMGN4TVGD13SbETv7eN+DzuTBh1qW/YZPl8MWgxwowWU2jOF9vloeO2bsrOVbY5JsNLYJUnBZgCdGnOIqyz+EBWoV+//6Jc4ifE2Tg9zStKhpe9gUIl/19QPcSFLqkq0coIJzDokGOoUhE4hnEEYIxPxXsLTrqflAcZRPJBmeRRD7HYxDQ6LRVcZSQqNzeVsqPr/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g39UjUzmbCr4DztgcftDN0EM/fwDiEchYtDicro8OrI=;
 b=M4Ee1arpziCw51+EJabhXbj5x56Sf9qYeNVw1pye5lrd3FF6S3RjevCfFBTtJema4TkMo2/lr4x+ONeyc9KIPTPPHLjLGtE0Cx4qAKXls813Tj9QhYLmezvbjAf0qkUfuHr7BTifVRQ4pSl3ydQ5AbPZVyD84RnDLDcxQjvLKb4rGOEBeS42WotZVPq1M/Zh0O0J3xBlDrTSsVFg9n+nDY3hN+0KUbbk9MbWCrNH0IUNup4KD+2dkGrkjQUu3Xx14JcJI4kz73jwljRrVerytaQxsK98gzUIXgLe+4pE4rXOrRMyMZuQokbNZ3FbTePMkm61F5e8vZv7wcuaRn+GEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g39UjUzmbCr4DztgcftDN0EM/fwDiEchYtDicro8OrI=;
 b=bXuRti/KMPh842OnkhtpO4AJ88rIJNN2ygRL2XVSz/fYKY7YITJuKhy+vx9oEUmPUqqzgJjWfiwVZtGZbxzC9NKO9OQ0DX0ULGuW4NZr2/xm0dScE5UVazdwpcDWqkH/12Icz7DqN6T4jEY0BrdmKmDgUz1LM4DBGyu8FwubaVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Tue, 3 Oct 2023 18:06:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 18:06:51 +0000
Message-ID: <dc7c5ecb-12be-4b2e-8f36-7d65dc171482@amd.com>
Date:   Tue, 3 Oct 2023 13:06:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
References: <20231003172447.GA679295@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003172447.GA679295@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:806:d0::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 89681c20-1a1e-430c-d830-08dbc43b84ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mtmil5Srk80HCS2mMbi7xY3bUo7KCUhte6Tl73oWEkqUmgOrgzoHoZKkEaTGPGU0hHQGpH1FZ+OhDEMNsRUFoLPJWqFBdUnax44VBxyvUxoMM4Q7yzUHvRLmIwXCtVv20DApBoLRQRRkfzzB2gaC5w6a9eV2FoNiSoWs4lwrhvZpfvaVKVxFSvNtxrNKUe24Ifv2F59wEs8/+Hszkr/BCTDe/SfVNnaIosdxcIa3dWpKvxilvF/2JTcxm3vhIy5ZSIwn8BwardFAodSWDaiZG30DPQ8WS/DReIZxaqb2sg3DuEu5dQFqyeOFriAZrc5aaKdpcgQVR2vOcaps2XNygutgdfsthx1amGZ3JwPrv5/jYWcGnq0y2iuKSLBqstVTrvFsSCFwQxf+Uc6B5ob3z1GCuqQQkTafJvWhI3blxkQdx1/1iWQViDVtbcTP7ZFwFXXuekdYxCMERKPc1h1rRezN2GE1YKm9/tYnOWKGaU3WQDnwKh4mc9Lxetj+sRRGL7/C9yhpRuO5/wDlHXiz2PdJEf+iUzoSBoPpCAr3/oC40rq3PbIAFa9abCvPUUXKKx19Rka/hYMrtqKHDj2+4OlhYZH/ovOBxbpPvivxGm2mzELUBgAkDofY2PQygQZe0TaC98kcL35WEDMNSAC7Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(2906002)(7416002)(6506007)(53546011)(6512007)(15650500001)(31696002)(86362001)(83380400001)(38100700002)(36756003)(26005)(66574015)(8676002)(316002)(6486002)(6916009)(966005)(8936002)(4326008)(478600001)(44832011)(5660300002)(31686004)(66476007)(41300700001)(66556008)(66946007)(54906003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGgwRFh4dWRtRXdrRWJYVzBJMnlJeU04Sm0ydElUbkhVbldseTBISkxZMjB1?=
 =?utf-8?B?TUplN2pGc0ltRkI2TWFKck5NbENmWDZKL1J5WVNCYU5UdzMyZEY1UmRIZWYx?=
 =?utf-8?B?MjEyd1Y5SHlhT3gzWk9Ya29wemJTamVDTlRUTzNUQVQ5OG5MZmp3OTI0OWdk?=
 =?utf-8?B?RUZNTHAwL0VZNVNLSnc2czMvNkJPUlVnVDVEWW11UXk4Z2VnaktHd3N4NDkz?=
 =?utf-8?B?ZXpRVHJQRUhJdDVuelZMbHF5cGV2bHNneXVoWGRIbkxCbmpsanN1Tys4STJE?=
 =?utf-8?B?aUdJTmJoQk5SQXJJVTFyMGk1T2FyM2p2aUM2dEsyUHJtVHFYU1E3OHY2WDRG?=
 =?utf-8?B?OEh6eit5Qk16dHhRMkZGNVdTNWh1dXNIeUZNV2NlRzVRMjV3ME1RNzd0SDVT?=
 =?utf-8?B?SXJ3SGU5dGZFTUgvaHJYZTl4MU1JY2FsWmRvVWM2YWNESURYYjlvLzltRVRw?=
 =?utf-8?B?QjBKbnBRVXdoTVhieTdscklUMTJ4VTBZenVPUU9ieFQwdDJ4Ly96ZysyeG9O?=
 =?utf-8?B?Z2dFYlFmMjhUaVQ5dUlVNlNCc05QWlRNK1FxY0lwUk5vaVhKNkJqVk94QTNN?=
 =?utf-8?B?eVFwaS9aSDBGZytKVllmV05EQzJ4ZVlxaTdJOFp3VCtXNjd4WXo4b0dYem9C?=
 =?utf-8?B?UVk4ajk0NmllSjVIQUZqa2NWcGk4VUE1NlBPWktsbGZZanRQalR1Z1ovU3pZ?=
 =?utf-8?B?Q3dXUXpJeGQ1SThpaXVROGhVb2lnNFA2TWdNa1FpVU9Ga0k4aHExTFBwME94?=
 =?utf-8?B?SDZlZVpMYzlMVGRFOFBuLzRpenpxOHdsZWRkWWJlUVhRTzgyOE02REtNM3M2?=
 =?utf-8?B?UVJIcUlKbVJhK3VPQjJMTkhlZWkyanVQM1dZa2Jua3c3UVN4QTEyY2syZWh6?=
 =?utf-8?B?eEN1NEJyUzRBelhZRnJrRWpTbkVNY2h4aEtoWW5xdWZxN0xHNnByT2xUWlY5?=
 =?utf-8?B?eEVzYlJmZTYvVzRRYVpNSkZGQXl1cmxITUFrRHlJSGo5VWVQTXVOYTgyYXJX?=
 =?utf-8?B?UE1EcHVSNmFLT1hJMGQwcUdmYVZqYktmNTNSMmg3MlFSamxFVE1SeG95VjB5?=
 =?utf-8?B?YytqRVdla1A1d0pnY2lrZkFmK091b29oS0RGSTlpeVRjRVlsNmFrOXNna0po?=
 =?utf-8?B?WUtVSTdNY2wrcy9JZWtMbXJjS0JHUmlMbC9jY1Q0UnJxak9mSEphTXZEM09F?=
 =?utf-8?B?ZHBGaGQ0c1RGNjFnVmwyVmlIV2ZzVHhpSUVUU2RxM0d3Z2JCQ0loam9PMDZ0?=
 =?utf-8?B?VVQwZTFtWG5SYkZXK0htcFlRT3ByZXQxL01FNjlaMWJ4WENMblN0UVZoYjhS?=
 =?utf-8?B?WjVhakxTRk9zWDBSUDJjamF3ZllXbkFDakxHcUJkV2F0TEVib1YwVkNaM1Nm?=
 =?utf-8?B?YW5RRHNhdytGbDRVK2VNeHI2VzhWQkd0SkZtQVNWVjRTQzRmVFlJTXk4ZXRm?=
 =?utf-8?B?YzN1b0VwdHRGMjA4NnF6TlRYdlVSSXdhTEhHQzJDZU1PUTRXN2VRQldwQUVL?=
 =?utf-8?B?SGRveDRYYzV2R2hTNStKUmdQTjhxaG4yYUwrQlB5dmpvTnplS0Q4YmhTWmdk?=
 =?utf-8?B?RXhtNjRhSFFLUTFNbHJZSStST2hiVVRMc1Q0RCs4eUdrOGpJYzlIejVXdElp?=
 =?utf-8?B?VC92MzROazBDa01KZEg3cmJJc2xvWHlTRGFHSHB5MWxOMUxrM2tzZVNGTHVN?=
 =?utf-8?B?S245YUNvVWFldTVYYi8vQmVtZW13REV6MFRINUlDcmE2YTJTYm5mTkZmSTZu?=
 =?utf-8?B?a0hHbnlzOFRWNlE2eExWRzJXU0ZJSTJuNkJJeHEyb2ZleHRsSFB5dUxrMkFv?=
 =?utf-8?B?R3JjSHNOcGsxa2RnTmhHMm5PK3cwTzE3VnVRbHJRT0xuRFNBaEwzVVhxMlQ1?=
 =?utf-8?B?dzdHNXIyZC9ERmVCVStqMlVhdXdyTDUzOFVaRXAxaWFKYm5EWXRwUGt4amlV?=
 =?utf-8?B?WlpqK08vMisvZDhUNTdha0cxaGgrem1mWlErRE55cXFaUTdJUTBUU254OHpq?=
 =?utf-8?B?Vk1BemxUY2o1YkEyeGpaZGtGYXpIZVI1bGNiY1FsczRoV05lMlJkc0dCaHNF?=
 =?utf-8?B?OVdMYnBTUkYybUxKZTJOVms1NDN4U0R3VUY2MTh4RjNYKytoNHcvZjdFMnFC?=
 =?utf-8?Q?zFsAsmhpn97lRtU+6GA9oeTU9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89681c20-1a1e-430c-d830-08dbc43b84ae
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:06:51.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnqyf5dxzzedqV9PpHWHmoESUOps2OgMAvxjcq62q/0RnlDQm2ijaxTcjhM1RqBTwgoQYyJLjnrAq8Xf2vwtOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 12:24, Bjorn Helgaas wrote:
> On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
>> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>> suspend.  This occurs because on some AMD platforms, even though the Root
>> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
>> messages and generate wakeup interrupts from those states when amd-pmc has
>> put the platform in a hardware sleep state.
>>
>> Iain reported this on an AMD Rembrandt platform, but it also affects
>> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
>> generates the PME. To avoid this issue, disable D3 for the root port
>> associated with USB4 controllers at suspend time.
>>
>> Restore D3 support at resume so that it can be used by runtime suspend.
>> The amd-pmc driver doesn't put the platform in a hardware sleep state for
>> runtime suspend, so PMEs work as advertised.
>>
>> Cc: stable@vger.kernel.org # 6.1.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
>> Cc: stable@vger.kernel.org # 6.5.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
>> Cc: stable@vger.kernel.org # 6.6.y: 70b70a4: PCI/sysfs: Protect driver's D3cold preference from user space
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v20-v21:
>>   * Rewrite commit message, lifting most of what Bjorn clipped down to on v20.
>>   * Use pci_d3cold_disable()/pci_d3cold_enable() instead
>>   * Do the quirk on the USB4 controller instead of RP->USB->RP
>> ---
>>   drivers/pci/quirks.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index eeec1d6f9023..5674065011e7 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6188,3 +6188,47 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>> +
>> +#ifdef CONFIG_SUSPEND
>> +/*
>> + * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
>> + * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
>> + * Root Ports don't generate wakeup interrupts for USB devices.
>> + *
>> + * When suspending, disable D3 support for the Root Port so we don't use it.
>> + * Restore D3 support when resuming.
>> + */
>> +static void quirk_enable_rp_d3cold(struct pci_dev *dev)
>> +{
>> +	pci_d3cold_enable(pcie_find_root_port(dev));
>> +}
>> +
>> +static void quirk_disable_rp_d3cold_suspend(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *rp;
>> +
>> +	/*
>> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
>> +	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
>> +	 *
>> +	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
>> +	 * sleep state, but we assume amd-pmc is always present.
>> +	 */
>> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
>> +		return;
>> +
>> +	rp = pcie_find_root_port(dev);
>> +	pci_d3cold_disable(rp);
> 
> I think this prevents D3cold from being used at all, right?
> 
> Two questions:
> 
>    - PME also doesn't work in D3hot, right?

Right.

IMO pci_d3cold_*() is poorly named.
It's going to prevent D3 on the bridge.

Maybe we can discuss renaming it to be clearer what it is doing after 
we're done with this quirk and my other proposed change to drop 
d3cold_allowed.

I'd prefer to keep renaming the symbol separate from this quirk because 
it's going to require changes to other drivers too and make the quirk 
harder to land and backport to stable trees.

> 
>    - Is it OK to use D3hot and D3cold if we don't have a wakeup device
>      below the Root Port?  I assume that scenario is possible?
> 

Yes; it's "fine to do that" if there is no wakeup device below the root 
port.

If a user intentionally turns off power/wakeup for the child devices 
(which as said before was USB4 and XHCI PCIe devices) then wakeup won't 
be set.

So in this case as the quirk is implemented I expect the root port will 
be left in D0 even if a user intentionally turns off power/wakeup for 
the USB4 and XHCI devices.

> I like the fact that we don't have to walk the hierarchy with
> pci_walk_bus().

Yeah, it really is a lot cleaner this way even if it is "8 quirks" 
instead of "4".

> 
>> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
>> +}
>> +/* Rembrandt (yellow_carp) */
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, quirk_disable_rp_d3cold_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, quirk_enable_rp_d3cold);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, quirk_disable_rp_d3cold_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, quirk_enable_rp_d3cold);
>> +/* Phoenix (pink_sardine) */
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, quirk_disable_rp_d3cold_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, quirk_enable_rp_d3cold);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, quirk_disable_rp_d3cold_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, quirk_enable_rp_d3cold);
>> +#endif /* CONFIG_SUSPEND */
>> -- 
>> 2.34.1
>>

