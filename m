Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C77247B4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjFFP1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjFFP1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 11:27:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466E107;
        Tue,  6 Jun 2023 08:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDM2TDBOhUTR9ARHRZARtwl7g9nHwcnSPuF85M/U4cj0mvVce+uQpT1Ts1Hk96nKKMLpP5npDf1cULd5/4t0Me7HNpGB+z7AvcCcRlUoH6aCZ9LneKzczsHd22vLzmWL5rr43lw8CKw/GUUOogUY8l5Uogf7OanYN4WPN7jp/H7eKqFlWvITAJEwH8KUVJa0Gz5bGrivNBqHTSjUIz78L1IDN6izEvnEkvw8NrTk+Dv1YN3DKcVvzs+pytQwF1RTq1SGUirO1VfZSusLDe9yAwMYZ5mRgI0oP00tmXN7fG7ge45mWo/ao8DflufF/69kYgmdSC77orFR48t5w0Br5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNw8KzpcaDcBNIbokC0Tzci5l8lfg1MgK6XPJy4yhHQ=;
 b=R1auYjmxI/+Hi7jN8DlGrO0W3u+ZXuPIzv89/uiasXTk9joEMmSa7nHLyh55sB6hDpWHEuNEj57aL6gzPH7HpeEtQqZLES48zW82GU6+RgrQ4qa0ELyofAAnGz4xRSx6h1R5nf9eNDaJ1iDfzr4uj8l2s+L+i4AgLuIODUGsdMo9jy99Az464BZPNhoczolXnnczHvMZvTrvEPnxhxqasGqqrxVaH1PswZzjSanGh8ZFu403IZGY0HFgOI7Q/OgJl9hFHguTL6jR2a/lElWspNIk2jxNY3c4GWAjInYgGU3MK99fTFLnBYpx05rTpasAxe5CriYa1ONOrIb97VeBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNw8KzpcaDcBNIbokC0Tzci5l8lfg1MgK6XPJy4yhHQ=;
 b=21uh08jAlnioxL+VDzN6/rXnCIfQIc/1ULESv9KME6olGCniwElZHL6WuLWQjmVs4yRRYcFX61f9gesMrXWew0pjArg3oo0bXG6j+S7rbuSiMmcSgr/zElDEMYavgGkJMn1NfM6osxRdtR2Z121mfkHRmQoogIUrf00lIVB3r8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 15:27:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 15:27:41 +0000
Message-ID: <cbe9df16-9dbc-2ccf-4ea6-b117b41af32e@amd.com>
Date:   Tue, 6 Jun 2023 10:27:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI: Call _REG when saving/restoring PCI state
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <ZHpPOzT0nm+vddPq@bhelgaas>
 <fda371a2-da84-c764-c809-2a361418b4ef@amd.com>
 <CAJZ5v0gzSitt2zm2fhwkg51ZRUd_1ZBVB8akiUK_cnr8wupFQA@mail.gmail.com>
 <f8b5ed80-62b2-3a00-d036-08bf1ef6a7dd@amd.com>
In-Reply-To: <f8b5ed80-62b2-3a00-d036-08bf1ef6a7dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: a49633e9-ae90-4f82-1e88-08db66a29130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vloUtbEZJiCJGuUFm3a+WGxLfmKmCtTXE5LZj1sEzBXAVgQDpmKkCWotrxSsXEpnSWQhpsllI6ihpfKbtSgz8AVbHoInK3Yt47vnztBDn76BmFOk49duK/2D+BIrI4/Kq4IUlW3daP5js46JLoYY475i1MX1bwvt/kbsMcaXJ7kTZeqbd11OQhoZcedT6UJqIQaQV5ibixux5LX9rb03XU6is16YtfiXobVf91pnRhi1LZAs8+nvS3L1wJ65ZmYAVPei82svSjXY7Kahq6xWpMUlbkn0NcPTC1W5FVRzym+gcCzx6oyIrqO80r0KdPba3nY88gjw/+eYagI0eydH9co0tUOpcH4Oc8fa2V/jE8+CHT1LFNXug0uNrYtBm8eoTn+nNtmJ10MgQFulOCR2tCOuFl9eQtmOfE+Q7zuDNeKE2DyoGqfQP75f+iq8Gm3YdxBkWu2EMNgvlutji56cAkSZotv3RPUZPFQoqZbz5KlKngrn2HZPyFMm7NeBNDkoLLjBXx77bm/lZI4zQo/4kcv++IzbzLkP32WUL18au8S3bGaVcZTKAd0sp+vHf73DLLM49b358JHk23JIi0CWEqpJ9xxLgBxNkHsE7JTv1RefLgFmoe3set5xFf/pnC8t4SWHapU/2UXCSyk1yu8mOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(54906003)(478600001)(8936002)(5660300002)(8676002)(36756003)(86362001)(2906002)(31696002)(4326008)(66556008)(66476007)(6916009)(316002)(66946007)(41300700001)(2616005)(38100700002)(6512007)(53546011)(6506007)(26005)(966005)(83380400001)(6486002)(186003)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndOMmEzOE1FUjlZU0p6YVRqNG9adHY2Z0o5WFA2VVBYamlXNVAwVmhzS1E1?=
 =?utf-8?B?OWRLd2F6aDZoamFRdXdzQ21OTCtHTkdlaG4rY3dDdlFUTmhYTGF4VDdiUTNI?=
 =?utf-8?B?OVBVY3JBUDUydkdHY3lxU0dkd0JIZys2ZXpObzVkNDVaaU8zYVFGRHJzYzhl?=
 =?utf-8?B?cmZyOXRJeXV5ZGc4WkRDQUp2bW1qVjZodlRGaFNRWFF6UUVQZWd2dFA5cGl6?=
 =?utf-8?B?K0ErL3lnYTNrazgva2F0NXRrNFUwWHZVV1BQUjlLRHgyUDVzbXRNcGVndmE3?=
 =?utf-8?B?UDdtNHJheEQ4WnFEQkdjTFhyWWJPL1ZSeU9Cayt0cXR4OXZiTE1KUVdiYjdG?=
 =?utf-8?B?NEZsdkNyZG4xY21lWWkyTTdpRWVSUk5IVEJaYzk3aC9qM0hkTDBRR1ppU3Z1?=
 =?utf-8?B?a3BEeGw4NFJzdmdkVy9CNmhZbDJhUUZaOS9sRFdsaWNCV2w2ZEpTNU4yMVRD?=
 =?utf-8?B?UGhpWXF0ak5NUXVQOTdOWTdmL3RvNWh3RmdQTjFiVG8zZWl3V3h1akVTdG4v?=
 =?utf-8?B?QWFKUitqcGlsbmFPUytDTG1sdU1nSG14VnFUeWpoYzROMU5xeE5QQms4NGRR?=
 =?utf-8?B?eE5ocW1uVWZNcjJZanY5aVRQOUFMRS9vY3ZiM1Zqb3B5aWxpeXNabmdvVTBa?=
 =?utf-8?B?Um1MbHpSWkxtWk15NE14WVdVeFhIejhmY05ZSDRzMDMvUGExN3JTa2lnRjFP?=
 =?utf-8?B?TFBzVEtUdzRraTlRTytQakFzbzhnNmZvZFFGZmd2UzFrSjJIZ0t5K1o1a2lx?=
 =?utf-8?B?aVZiRTFYR2FiZ0ZPQk5Pcm1lUFZneG1mUFRybWlRNkxtK0NTMUVFNCs5QlFX?=
 =?utf-8?B?cDJGaHhLZWRUNXVwU3psRmdKaGhpRjhDVGd3OWVlU01ucExldFlwMUUrNjli?=
 =?utf-8?B?ei8vQmxSbVBSTEprWHY5aTBOd2J2SDA4ZmRJYmp4OU1WajBnSE5rcmRDSXBs?=
 =?utf-8?B?blo2UVdOUWVseGRFdU9vK3M5b0VNVWx0cktJRFJmaU1UaDN2MHBscWdEWXND?=
 =?utf-8?B?UDhyOFpEcXRsazNlbTZmMXpISmdIK1FQUHVTZituWlF2TXZsbzZ5K2FqeTlu?=
 =?utf-8?B?SGZnYTR0OWpKMzNjM1ZYUEFndWZ5YmJYOFlGUmNsMnRFQXROYXkxVUtGc2Mv?=
 =?utf-8?B?VjZ2NlR0MXBNR1JBWUw1OWUvd1dXWWQ0VFFhdjg1WGpnMzNOaXlkZGxjYjF1?=
 =?utf-8?B?M0VNSm5uR1lPenAvS09hQ2FDSXZ2Q0l4Rm1xUDlWR1NFbFlhZWIydFJuL01U?=
 =?utf-8?B?YytEQmtsSUJSUTNwZkUrSUorS0hMcmtBcUJNMWl0cmRSNStwd0srNHdHMnJW?=
 =?utf-8?B?MWxNV1VsWlZ6eFEzNjFzekdWUzlmREFKMGRmM2Z0YWM4R3p3a29rUW92Ymho?=
 =?utf-8?B?MS9paXVxUEtIMXF0MlBMWHQrOHFiUk9FbEhSSmZWNHlpNVZGRGE4MEg3Ym1D?=
 =?utf-8?B?aHNZbVZCcEg0bisxc0tFNDdFRDAzYU5rV1lwOC9GWnptY0k2VFRRRnFLNHBK?=
 =?utf-8?B?Q1pROFpDelE2eEpDUGI1THV3RHdpR01hSmM4S05hZ1VVWURZTXJPK2FkaTRp?=
 =?utf-8?B?ZzhxQ1RZem5MRTlYTXNkajgyM21uVDlJRTBUMnAvQmdsdzh5UTNGdTMwWXpH?=
 =?utf-8?B?cTV4RUptQlBFQktKUENtcTNaVWNtVlUxbGVqUHFoOXpQdE5jMlFzblR2RkV0?=
 =?utf-8?B?R2RsL2ZnS0Q3V2hvZjhIWmNycjJUNVlhUlZHSys4anVrdElyU0NlSHBLb0hO?=
 =?utf-8?B?TVhyYkgwNlRwbGFkc3dtRjdFd0s2Zk8zTXhDekpmYis3ckUzdG9oUWR5VUNw?=
 =?utf-8?B?SHJ1R29xcEhrd21FUnhjejY5aXpPZlV3YS9wM1A1ZzNUb0RaQzBLemNBRXRs?=
 =?utf-8?B?N3FaTVRFMFFRV29QTzNkRlc5WE52UmlSc3RnYnl6NktucGdpRk9sWnFYaVU2?=
 =?utf-8?B?MlBubVJTNk5XRmZUbFVQQUdSOE1KbXBMQ3FqT2dHalN5OTBMaVdOekx3TmRJ?=
 =?utf-8?B?ZnhSTFRwaWdxTnZDZWdKWWRDUFY3UGFCMnZ6a241dWdPMDZFQ1pnMWNFRTZB?=
 =?utf-8?B?RUs0S3lkMlNDbXEwQjNKczZkdVdKWDR1aEZ0elFBSVRMKzMxRytZNDZXOFRl?=
 =?utf-8?Q?j/H2NLJBpSwH4PKJVv3Id5+mM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49633e9-ae90-4f82-1e88-08db66a29130
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:27:41.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45ol7A/9p8GKOoGBV2UNxsoW8V/1HU3CzR98LzsiE/lg+ZtS0S2Dp9LJ+Cv2BpzxagnBuKVeVdmOXgVeSUQmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/5/2023 1:33 PM, Limonciello, Mario wrote:
>
> On 6/4/2023 6:30 AM, Rafael J. Wysocki wrote:
>> On Fri, Jun 2, 2023 at 11:57 PM Limonciello, Mario
>> <mario.limonciello@amd.com> wrote:
>>>
>>> On 6/2/2023 3:21 PM, Bjorn Helgaas wrote:
>>>> [+cc Rafael, Len, linux-acpi]
>>>>
>>>> Hi Mario,
>>>>
>>>> On Thu, Jun 01, 2023 at 10:11:22PM -0500, Mario Limonciello wrote:
>>>>> ASMedia PCIe GPIO controllers connected to AMD SOC fail functional 
>>>>> tests
>>>>> after returning from s2idle. This is because the BIOS checks 
>>>>> whether the
>>>>> OSPM has called the _REG method to determine whether it can 
>>>>> interact with
>>>>> the OperationRegion assigned to the device.
>>>> "s2idle" is a Linux term; I'd prefer something that we can relate to
>>>> the ACPI spec.
>>> It's important for the symptoms of this issue though, this
>>> problem doesn't trigger "just" by moving D-states.
>>>
>>> It happens as a result of system suspend.
>> As I said in my response to Bjorn, s2idle is D0 from the ACPI
>> standpoint.  It is not a system sleep and it has no special meaning in
>> ACPI.
>>
>> The problem seems to be related to the low-power S0 idle _DSM calls 
>> to me.
>
> This particular hardware that triggered this patch can do S3
> or s2idle.
>
> Let me confirm with internal guys whether this can reproduce
> with BIOS configured to S3 as well.
I did confirm with internal team that this issue also reproduces on S3 and
this patch fixes S3 case as well.
>>>> Maybe a pointer to the specific function in the driver that has a
>>>> problem?  Based on the patch, I assume the driver uses some control
>>>> method that looks at PCI config space?
>>> The issue isn't in anything Linux code "does"; it's in the "lack"
>>> of Linux code doing what it needs to IE using _REG.
>> So the argument seems to be that under certain conditions the PCI
>> config space becomes unavailable and so _REG(dev, 0) needs to be
>> called when this is about to happen and _REG(dev, 1) needs to be
>> called when the config space becomes available again.  Fair enough,
>> but I'm not sure why this is limited to system suspend and resume.
> I didn't think it should be limited to suspend/resume
> either.
>
> That's why I had put it in save state/restore state.
>
>> Moreover, "PCI_Config operation regions on a PCI root bus containing a
>> _BBN object" are specifically mentioned as one of the cases when _REG
>> need not be evaluated at all.  I guess the operation region in
>> question doesn't fall into that category?
>
> Yes; that's right.  _BBN is only present on \_SB_.PCI0
> and the problematic device is on \_SB_.PCI0.GPP5.
>
>>> At least for this issue _REG is treated like a lock mechanism.
>>> In the spec it says specifically:
>>>
>>> "When an operation region handler is unavailable, AML cannot access
>>> data fields in that region".
>>>
>>> That is it's to ensure that OSPM and AML don't both simultaneously
>>> access the same region.
>>>
>>> What happens is that AML normally wants to access this region during
>>> suspend, but without the sequence of calling _REG it can't.
>> Is this about being unable to access the opregion or racing with
>> concurrent accesses on the OS side?
> Access.
>>
>>>>> To fix this issue, call acpi_evaluate_reg() when saving and 
>>>>> restoring the
>>>>> state of PCI devices.
>>>> Please include the spec citation: ACPI r6.5, sec 6.5.4.  The URL has
>>>> changed in the past and may change in the future, but the name/section
>>>> number will not.
>>> Sure.
>>>>> Link: 
>>>>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>    drivers/pci/pci.c | 12 ++++++++++++
>>>>>    1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index e38c2f6eebd4..071ecba548b0 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -1068,6 +1068,12 @@ static inline bool 
>>>>> platform_pci_bridge_d3(struct pci_dev *dev)
>>>>>       return acpi_pci_bridge_d3(dev);
>>>>>    }
>>>>>
>>>>> +static inline int platform_toggle_reg(struct pci_dev *dev, int c)
>>>>> +{
>>>>> +    return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>>>>> +                             ACPI_ADR_SPACE_PCI_CONFIG, c);
>>>>> +}
>>>> You never check the return value, so why return it?
>>> _REG isn't mandatory for any of these uses, and I wanted to make
>>> sure that if it does end up being mandatory in a future use that
>>> the return code wasn't thrown away.  If you think it's better to
>>> just throw it away now, I have no qualms making it a void instead.
>> I don't think it can reasonably become mandatory without adding a
>> specific _OSC bit for that.
> OK.
>>
>>>> The function actually doesn't *toggle*; it connects or disconnects
>>>> based on "c".
>>> Can you suggest a better function name?
>>>> This looks like it only builds when CONFIG_ACPI=y?
>>> The prototype for acpi_evaluate_reg isn't guarded by CONFIG_ACPI
>>> so I figured it worked both ways.
>>>
>>> But looking again I don't see a dummy implementation version for
>>> the lack of CONFIG_ACPI, so I'll double check it.
>>>
>>>>>    /**
>>>>>     * pci_update_current_state - Read power state of given device 
>>>>> and cache it
>>>>>     * @dev: PCI device to handle.
>>>>> @@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct 
>>>>> pci_dev *dev)
>>>>>    int pci_save_state(struct pci_dev *dev)
>>>>>    {
>>>>>       int i;
>>>>> +
>>>>> +    platform_toggle_reg(dev, ACPI_REG_DISCONNECT);
>>>> I would expect these to be in the PM code near the power state
>>>> transitions, not in the state save/restore code.  These functions
>>>> *are* used during suspend/resume, but are used in other places as
>>>> well, where we probably don't want _REG executed.
>>>>
>>>> Cc'd Rafael and PM folks, who can give much better feedback.
>>> My knee jerk reaction when we found the root cause for this issue
>>> was to put the code right around the D-state transitions, but I
>>> decided against this.
>>>
>>> I put it in save/restore intentionally because
>>> like I mentioned above it's treated like a locking mechanism between
>>> OSPM and AML and it's not functionally tied to a D-state transition.
>>>
>>> When the state is saved it's like Linux says
>>> "I'm done using this region, go ahead and touch it firmware".
>>> When it's restored it's like Linux says
>>> "Don't use that region, I'm claiming it for now".
>> So it looks like you want to use _REG for protecting PCI config space
>> against concurrent accesses from AML and the OS.
> Yeah.  When I discussed it with BIOS guys they
> explained to me that the BIOS will typically save/restore the
> PCIe device BAR when _REG is called (depending on the argument
> to _REG).
>
> They'll only operate on the region when it's in the right
> state, and they'll restore it as necessary when OSPM would use
> it again.
>
> This is also how Windows works.
>
>>> Think about that other patch I wrote recently that controls D3
>>> availability [1].  If it was only run in the D-state transitions and
>>> the root port stays in D0 but has a _REG method it would never get
>>> called.
>> And why should it be evaluated in that case?
> No matter what the actual D-state is the OSPM isn't
> accessing it anymore, so AML should be able to.
