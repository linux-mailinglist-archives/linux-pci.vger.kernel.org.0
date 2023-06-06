Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B72724DF9
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjFFU0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbjFFU0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 16:26:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FDB0;
        Tue,  6 Jun 2023 13:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7h3572+MjaYiqIrROWHSjxefP+XG/cN4eAUifg1Z+HZ57Pmh1GjdoF3L+GEe55P9AtG/7IXMp0uz4/CpgI6pxobeSewCqNLsG3udpnpwIsrvMs0/u7IGauPH07fGGkdLYWRe8E4zM7bg6wPbdY8Fu09FT4BqDNiBSMR1PvyFFdMbGiaRmNEL447TFAAM211NnYaRvV4Jg40VHQJN0RwJhamyBAg5+wQVyrjrLmD8q9zE/jl72JyO9dyUZ/udpXYm9LF2jCKKVjTS2SSc1+Se+k2N6GpDNzKvi1JAMnuHUfbTJhx/qtXuyszZYi92l/pUTw+/zyflJTCmsgVT8PKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMBWFq9Iid2CMpe1+2GUO0CI7WkjI2oSC/vn9pXJxvI=;
 b=c9Yj6q6se63LgzQ8i1bQCr7ENWxfjW7S3kTPGkmDJMSIVd/17SC+j7yS6DtYIU6Gpfc6ssqXkPUw4s9j3qvCI3LA4fVmdn5sbWf/pSls3QXcm5qSBUgql+B8/y57xV/IBmO58xg1X1OdvbgZf/vF1zimfuybVI+qj29waT8615QhMRRQUkpSZYuZQhgGi+rcykoFVaDPr2BmQUcJcq62v2DDig3CrcTaAJQsmdLdhRREg+fZ6exH49abfBZX7dCdqYxaKBUpU0fBU1aZ6Tp6Om5kyszExIwwtWlXB3IZ5V3TILS/geiU5jE0gN4tEYya1lVagc6M10IuqMDv9O8XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMBWFq9Iid2CMpe1+2GUO0CI7WkjI2oSC/vn9pXJxvI=;
 b=L/LUC9pOKfoD7UOK0wfxSHzm/A8awjDFlyhzEvKPATBZTHQwW4B9Ryrge7VFshUeENvSHG4OaxH0sKG9EksrbQXY2nnAVigkS+fERd8kVnzlESdawOLky9JsEiyCQwmN7NmoaJuVNaNqPvPL06BMNAERY77lnJeV9/BvdVc51nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 20:26:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:26:08 +0000
Message-ID: <1d920ce5-8279-65e9-db6b-7cc8a9cb4779@amd.com>
Date:   Tue, 6 Jun 2023 15:26:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230606195847.GA1142401@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230606195847.GA1142401@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:805:de::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 88933c93-fe9c-440c-afc5-08db66cc428c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PX7H9JQqMe8zCtn8L8YDuqimviqs4AyvPajehfVZs5J+inNJGnxr1J1FHUBzImFiTAvGAkg7glZsprwSD4KTDqQq8c8tTgOjmIEjMYfe4p+LMMP2q6xS51zsGYk5B4YCafd5O+TosHUS4+2z1RF11Z8HdWxTq21hCOppqShX815rqBAKFocBedK0IX+4nCfH5cT+nP0UlVNPjDun3TDoRdE9K8IobHYhZI36tLQesm57AHLAPHt2qKICdIFaZK2JGurPDS5xmNSmvyw/jFv5jbQsq4h+apvU4PdlJpgO4JYHZEZYBiXeby1+bdAK6MDEx5VI+GDHvswt/CL+9NBKtW8o76VNDGaL78sRUZDQtW6rQxQsb1tBqBw0MZXllHqvi57ay2mAj3IvfLtaaIYH76Z1n2pMqWc6CSz9gWneNUgh0dSu9TwEU3zx/tS5XXzWScdOEScY78Q3BU+ioWLCrcagYri2iuM6z+kVeCZOtAEJUkZL7T0Gp+cxCaSxB5BaMN8vOWn15e6QEwDoyR8+osw73zzq+IAISRDiS6BQXoU616WDEn+c1bE4zUISyNY4+iISwDuZQLCjUMES+M8wqXCRW22LDulzIWv5K0iXSyfB38zfPTqJNKQYBlco3q/ngzm+YOlNC5T0Y/WQuJ2SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(6512007)(53546011)(6506007)(2616005)(38100700002)(41300700001)(31686004)(186003)(6486002)(6666004)(966005)(83380400001)(26005)(66899021)(478600001)(54906003)(66556008)(66476007)(6916009)(66946007)(4326008)(316002)(8676002)(5660300002)(8936002)(2906002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnA0TFlIRUdNTGF3RHBCVlVrZXRmb3FXTjZydWZqMzk2NlM1L2pKN2lWUVZU?=
 =?utf-8?B?eU53bmFENVJaTmhwWUkxVTgvZUNvMGNqMFU0V3pvbUpmUVZVTkJOVitzOHRK?=
 =?utf-8?B?RlJoSjA0VFlGd2FSbmQzMXU3U0dpbm5QR3VYKzBKNWlSMjRIaVRtelg4YUcy?=
 =?utf-8?B?VlBuQ0VHeCtPWitJU2ZBamNHWlRncXhBZWIzT2QyOG1RUjdrZm02bk42dUJW?=
 =?utf-8?B?VUNQWkZMWEk2RFlCVGYwUkZmbWRqbmpmeDNPdnhIL3hEcnVsa1c3RFc3ZzRM?=
 =?utf-8?B?R1RKSE16aWVadUZyalUwa1FTTTd4bTVXZkROaHRpSUhDMTd5elgvcG9rZmho?=
 =?utf-8?B?dS80eldYc01QN3hESkl4OTFTUjdFRXFacDRoZFlmMjVNT1Z2MjRnZzNscGxs?=
 =?utf-8?B?TWFoRTZvajR0VzVvTDBDcFp2V2V3Z1JGOVdIeW1OOG4yTmU1UDJnL3pUazdm?=
 =?utf-8?B?UW5KM0NNcmI2MTRPbmVETUswVTNRMHlISGx3aHpVZVpPYytmWkZMTWZId1Av?=
 =?utf-8?B?V3NJbFJkQ1dKUFZYdXNnRDloK0IxNnI3VGhuMFZnQmFGNm9SUXpOVnpCVnRN?=
 =?utf-8?B?OVgvRUdNVVpQcGVsdFR5SHNqL3ZUMUVjUERIZUYzZ2ZnUkRiMVR0K3RmTWFG?=
 =?utf-8?B?NTVCbzJLVS9IbEJOYy9JMGdIYTROUFQ2RzJWR0lmUDBGRW9nbGhGTHBjZlBm?=
 =?utf-8?B?dXh0VGY2SGpNMk1KRmdXVHV1NXo2WHJIQi9aQlQxdDhsY2Q2QU5TQ0JtSVJv?=
 =?utf-8?B?ZFNnZnRJRGxHVGhNLzRKdUF3SWl5WXlJaUM0bEt1Y0tTZDloSUlqWm9rN1dp?=
 =?utf-8?B?OHd0TzBXVHNWcEpRdVRuRUY0R3A4OFJFZGRyb2JkNjJtb0dxVnY4SFpJMjFl?=
 =?utf-8?B?MWZuWjZyR0w0eXRsUmtNQ2xRWUJJcUk0ajhXUThSM2puZXVKeWcyaG1oRWF4?=
 =?utf-8?B?TnlNQlhLMGFaS1FnV1h4YTdFL2plaCt5SkRINzZyUFBKWit6NENzaDhTQVVt?=
 =?utf-8?B?SWxkaDByaGFsS2xsSE55a2NwMG1GOGNhSCtUOEJUcWdKREFXY3BPWWFIR28y?=
 =?utf-8?B?RitSVVg1aTAyMlVJdDF2VU9UQkl3TjJkNm5ZR1p6YVB4NHlSM2JkWFdlaThF?=
 =?utf-8?B?K0gzMFoyc2hjUEdPU2VzRVdpZTNPWlR5cG5ncnJ3b2dmcXdsSWVCMWlWZ2th?=
 =?utf-8?B?NjE4UXBHZEdEQjRmdXlLMGZncm5QVmVlQ1AzOTZTblV3a2FXMXNQLzJDcXBB?=
 =?utf-8?B?YXhuQkZRaSsrc0psU3QzUTM3eFFmS04vYWhnWUthTFhQYUJGRjIrV05iQ0c1?=
 =?utf-8?B?cHhseEp5UDJ0T0YxQnRtZDVTWnlZNGY3eC9QL3VFdjBLTG82bFIrczkwTWha?=
 =?utf-8?B?UitNemhQZG5GY21oZ1pKL0Y4V01IZTE2amZLaWtyMVpiU0JsZmcxYXJUYzhK?=
 =?utf-8?B?Mkx6ZTgyaWlJdTI3UWhQOFBiRkhXRG1wRTZRMGRXc2ExN1V5b1d2bjFkZnF2?=
 =?utf-8?B?elE2cEFOWEZZT3RvOEZuMkNub0IrZGV1UGNuTGg3KzBXSW9OMjJyMEhuanRC?=
 =?utf-8?B?bzExanZnYlZyem1YRDZnQlk0T3pRcjA5bkgwelg4L0VUZ0RzSmRYM1NDUXB5?=
 =?utf-8?B?dit0T1ZLUnV5bVBmOXBtK3JYRU03c2JRRzlPTXQrRDlUeEd6QnlIUUNuNllz?=
 =?utf-8?B?cFE1MmVRTlZSV0VQTVdvbXF3UG5vREl0c1IwU3J4ZmFzZ21LTUEzZFdZQUxD?=
 =?utf-8?B?cW5JV2I0aGhydmgrN0s2NS9YRDRBaVpwZyswbjFoelIyemErUVRlRHdrMTBF?=
 =?utf-8?B?WkhFNW9kcEQ3T2xVTm1ySjdDU1JOWHA0MWZSOCs0SXpYZTFudWNMRk1wK01h?=
 =?utf-8?B?V1hBV1V1MDE3Z0E4Q1ExajBLSXVhUDlLb1ZnU2M5dXhaUWROb2ZDWHdnSTZq?=
 =?utf-8?B?R0QyZjRiSWw1cHJLUFoxMitaRGpBWk13TEMyTU43c1QwTk9Ca2g0ZkFVNlZh?=
 =?utf-8?B?bWg1bDJyRUNxZ2NFbDFxMkFoclFpZlZmUDJwVk5vZlFiYjdNK2tDWUIwb2lJ?=
 =?utf-8?B?c2ZGcnhLbnhBb2lZU2VZMFh5czlSUkNOc0gwaGllM0JudlNzY0NjcDg2N21B?=
 =?utf-8?Q?0aeUQtOkDNPu18DBYFK9tNq4x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88933c93-fe9c-440c-afc5-08db66cc428c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:26:08.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nsNhfs02HIc/7B+fJ3jyoMS8bh8vmNiAVJbOVe2+YTG006USwWmtO29KYLAT3/ty6Al+Fff2kuuxLySdbKPFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/6/2023 2:58 PM, Bjorn Helgaas wrote:
> On Tue, Jun 06, 2023 at 02:40:45PM -0500, Limonciello, Mario wrote:
>> On 6/6/2023 2:23 PM, Bjorn Helgaas wrote:
>>> On Tue, Jun 06, 2023 at 11:23:21AM -0500, Mario Limonciello wrote:
>>>> ASMedia PCIe GPIO controllers fail functional tests after returning from
>>>> suspend (S3 or s2idle). This is because the BIOS checks whether the
>>>> OSPM has called the `_REG` method to determine whether it can interact with
>>>> the OperationRegion assigned to the device.
>>>>
>>>> As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
>>>> code on the availability of an operation region.
>>>>
>>>> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
>>>> state of PCI devices.
>>>>
>>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v1->v2:
>>>>    * Handle case of no CONFIG_ACPI
>>>>    * Rename function
>>>>    * Update commit message
>>>>    * Move ACPI calling code into pci-acpi.c instead
>>>>    * Cite the ACPI spec
>>> Thanks for the spec reference (s/APCI/ACPI/ and add the revision if
>>> you rev this (r6.5 is the latest, AFAIK) if you rev this).
>>>
>>> I don't see text in that section that connects S3 with _REG.  If it's
>>> there, you might have to quote the relevant sentence or two in the
>>> commit log.
>> I don't think there is anything the spec connecting this
>> with S3.  At least from my perspective S3 is the reason
>> this was exposed but there is a deficiency that exists
>> that _REG is not being called by Linux.
>>
>> I intend to re-word the commit message something to the
>> effect of explaining what _REG does and why _REG should be
>> called, along with citations.
>>
>> Then in another paragraph "Fixing this resolves an issue ...".
>>
>>> You mentioned _REG being sort of a mutex to synchronize OSPM vs
>>> platform access; if there's spec language to that effect, let's cite
>>> it.
>> That sentence I included was cited from the spec.
> If it's necessary to justify the commit, include the citation in the
> commit log.
>
>>> Ideally we should have been able to read the PCI and ACPI specs and
>>> implement this without tripping over problem on this particular
>>> hardware.  I'm looking for the text that enables that "clean-room"
>>> implementation.  If the spec doesn't have that text, it's either a
>>> hole in the spec or a BIOS defect that depends on something the spec
>>> doesn't require.
>> IMO both the spec and BIOS are correct, it's a Linux
>> issue that _REG wasn't used.
> What tells Linux that _REG needs to be used here?  If there's nothing
> that tells Linux to use _REG here, I claim it's a BIOS defect.  I'm
> happy to be convinced otherwise; the way to convince me is to point to
> the spec.
 From the spec it says "control methods must assume
all operation regions are inaccessible until the
_REG(RegionSpace, 1) method is executed"

It also points out the opposite: "Conversely,
control methods must not access fields in
operation regions when _REG method execution
has not indicated that the operation region
handler is ready."

The ACPI spec doesn't refer to D3 in this context, but
it does make an allusion to power off in an example case.

"Also, when the host controller or bridge controller
is turned off or disabled, PCI Config Space Operation
Regions for child devices are no longer available.
As such, ETH0’s _REG method will be run when it is
turned off and will again be run when PCI1 is
turned off."

>
> If it's a BIOS defect, it's fine to work around it, but we need to
> understand that, own up to it, and make the exact requirements very
> clear.  Otherwise we're likely to break this in the future because
> future developers and maintainers will rely on the specs.
 From my discussions with BIOS developers, this is entirely
intended behavior based on the _REG section in the spec.
>>> Doing this in pci_save_state() still seems wrong to me.  For example,
>>> e1000_probe() calls pci_save_state(), but this is not part of suspend.
>>> IIUC, this patch will disconnect the opregion when we probe an e1000
>>> NIC.  Is that what you intend?
>> Thanks for pointing this one out.  I was narrowly focused
>> on callers in PCI core.  This was a caller I wasn't
>> aware of; I agree it doesn't make sense.
>>
>> I think pci_set_power_state() might be another good
>> candidate to use.  What do you think of this?
> I can't suggest a call site because (1) I'm not a power management
> person, and (2) I don't think we have a clear statement of when it is
> required.  This must be expressed in terms of PCI power state
> transitions, or at least something discoverable from a pci_dev, not
> "s2idle" or even "S3" because those are meaningless in the PCI
> context.
>
> Bjorn
Right; I'm with you on not putting it with a suspend
transition.

The spec indicates that control methods can't access
the regions until _REG is called, so
my leaning is to keep the call at init time, and
then add another call for the D3 and D0 transitions
which is why I think pci_set_power_state() is probably
best.

