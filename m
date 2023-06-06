Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FB724D40
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjFFTlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 15:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbjFFTkv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 15:40:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11F10CE;
        Tue,  6 Jun 2023 12:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCNo2g7xVGcr5Ja82y1qCWShzbAX4v5vy2/4BsRosriZPrQ3GjWtdWtjX11FivBTyYZEZeOtHNGnxFo44CDG2UBY3YpojSOjn013DCtrOsB43ctXk7QAH9Xk7u/zGc6VA0OmGJmefc6UrK/L8KLWxhXPCxktspRCDkuJ/2emifXdfOJoGJ0cZAnkIF2VV6Fr/IuMvYvfaP7UFw5j2IU9Gkoa2UCUqZJp2t+dZXbJv2lHruYu4LhW6GmtGsWm6UUtPTPildrUM/WH7E09XReab9b1oVOAaPk40qQcR65lkO1V9FXFfM+CQ5xV1rXiM5JbgWm4bSioceAA851XWzkC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOAWr3qJQxjCAXhWQg41hyvi1R0e9sAY/l6oyUhdn98=;
 b=RXTsKjJ4NuoAisoa71Nh+KawslYAFkjB7WKBjjdwnqymTU6iRcVE+nx3naQakqvF01/C28v9p7XEOdRFld7Co0sBGChgpzhzBccY/1AHNKgT/ZbMHjsdss/5RgwlFNdMOXEuR0S7YwaOnl8ukEgOT0j0dDECr/614RxEdcSiF7u8yXMDMO3mBF7XiWJpJaqjGtyx+buGiczh6ddbmE9O4PzrgkffkJt27o4giKs/4+2Z1hiWxuCHYyXHGGu5T8kMkc6oBNBo7I2N6oh4mZdXZ2doozXoEy0hgbAHXNyUb+YeYvzn1b/cgZiq6kUpZrCoXi1eOBWQkMde3eAhmcJkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOAWr3qJQxjCAXhWQg41hyvi1R0e9sAY/l6oyUhdn98=;
 b=Lkc+TVlpV2VCChB7bRSg/svVqqd99B/SyWJi6QArEr/NBYkih7MNn1HsZG2zPVqeOysr39/hq3Skl0lQN4P+VJFwkED+GmvXec4VtPpo9vFlKxu5RRHbZsumAGCL2ywcNKzhFh09WQXNHYEkEXehDzlNZf+b51Qd7phmwcB9714=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:40:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:40:47 +0000
Message-ID: <48a843d5-ed4f-e4c5-782c-b246b81142e0@amd.com>
Date:   Tue, 6 Jun 2023 14:40:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] PCI: Call _REG when saving/restoring PCI state
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230606192341.GA1130972@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230606192341.GA1130972@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7096d207-fa36-473e-9428-08db66c5ed05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Q2KGzwQAmhjIdQl5cVed0QfEWSYUX729JMBmIqaQuxUAFBpufNVwMTN/88CkbbUCBldY8yg5MMU4tgtsjfJNtLcniCAHgUo/j1vli+EbJ6ixjCFofWPugOsvQcSrqSWbbfkSbBUdT8W2oL7Cv7lrKej0IgM7I1d30lGBilpeYw8tEpJgwyLrr9DJRGoMa2akB0L7/3M2hSSIJFb2Eg9zfunvi8GQD0wSGxO34awYSispFUOla4/J0S1T0fl/XTvuw4vfbZOZGjWDIMLqbDhhg0WiXmr26eHbuvZz3d8DBU1uUlLIPBg4j3fN5tyPelOjxnG5k2Es2a7+fX8n52UZaOrURSbxjPchTpND40vaBl4NqBayP8gEtvWmmokkCAzAAFdmHVwdrXjt21F/H3o7JxnLyDEUQSqmaEp5d2G1YztiYXAiinrdm3BEgVbSkI4kIZMJm8jegtPzdiTBlt3E0qgUWcKbCojUojBrPRq6bVloWgMYSCgjiveHaxudqWagEal+W2ruT+sZlfeRQoUwRUe9jT3w02LSvS8C1kQ9pmDs5NMgYYALx3XtmZESsF4Q3Fy2YIw535hClli1etHf2avkRqqK1LEpN3KHXmw0xfaT2v8L9rHqhO/CNRtyqBnm/ML3AXds8nw7we+ShKAM+xdEEiPBDHn2pDduOPEcig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(26005)(66946007)(66476007)(66556008)(38100700002)(6916009)(966005)(83380400001)(4326008)(478600001)(2616005)(6486002)(53546011)(2906002)(36756003)(6506007)(41300700001)(316002)(8676002)(54906003)(6512007)(8936002)(5660300002)(186003)(86362001)(31696002)(31686004)(66899021)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1DQnVIUXpYZERlN3ppcy8zUHZWczhZQ2xzTk9hSzRnTys4bVdrVGNHb1p0?=
 =?utf-8?B?NlVKUk5DWlB6Q1Rud2N2NWRuVzgvRWI3dTB1WFpFUVBiZnYvelNFV1pmTEhX?=
 =?utf-8?B?aUhqdzJ0V0FtdXVML2RhTWZOZnRQeHdiQy85dzREYlJNZ2t2ZzU1SWppOWpW?=
 =?utf-8?B?S3p2bjdZdmp4cjlJQWp4amRuSTRCT2lzMXQzbUppL2EwaFFYaGF5amhiOWFy?=
 =?utf-8?B?MW5Oa1V4WFdUUGJQN0lzZVZyU1lTYWpOZ1ZUYzVPV1lVWE1rVHNXVXo1MHZ3?=
 =?utf-8?B?RU4wVUFPZGVNNFd5anhjeHN5clRJZENKZThQU2pKeWdLQ2Z2b2NHeDlma1BQ?=
 =?utf-8?B?bkxXSndERlo2VGZzT24yOVZOdUR4ZUkxWWFoWTVOakZHdXhBNkhKRWp2UGRJ?=
 =?utf-8?B?ZFhqaVRvTUhFZUxqTEd4MG96dHNnYWRUY2FXMlNvai9TMVhqVWpLNnl0Y2Y3?=
 =?utf-8?B?SGVDYktxcFJsaWVKbFpwM0dsWXZLMWd0TFpVREVYTTg1YXpmK0ZHa1ZIYnd6?=
 =?utf-8?B?MmhqakY5bkR2NXo5T3RUVE00WVZXcUVlU2Rid3JpSWpnK3FJYTJJLzVreW55?=
 =?utf-8?B?dk52N3RETTl1WEhObHRoaVZTNUZ2RkFBcnlaV1hXTVB3S3ZJakovekwvRmJU?=
 =?utf-8?B?Nng4aVc4Nk9CbW83emVVWk8yRTdRNHdJbkF3TnpwTVhmdW5GeE5hUWNCUVg2?=
 =?utf-8?B?em94LzcrME0xcGluckwxZTFVTjEyUmI4MDRoOUlsTCtiVlRRSGNFVU9EeXdM?=
 =?utf-8?B?cVFMQnc0RFNlSkxXaGhNUWJOVGQvU3BqcjFHTmFtYzhIUEduWXlEMDg0a0ZT?=
 =?utf-8?B?bU5XRDQ3eU5Pbnk1dXlpeGZwK3RlUTNFV0FaeUJCVXFTZXV3SnpNa1oyK0lo?=
 =?utf-8?B?czVtQTIrNjlyNVNRaURXMEFraWJwaXpwYVdvSlFxK1NsQUZ2SFdoc2ZhWmpZ?=
 =?utf-8?B?ZTR2VVc0VzNWRCs3YTJTWVJXWHF4RER1YVlvVlArdVBrbFo3ZzdUK2NIaENZ?=
 =?utf-8?B?QlZidU9FOHZmRVFkVEYrczNMM1gzRkVUR0VZTXVDcjFIc3plQzRoU0djbGJC?=
 =?utf-8?B?dzVYREI2M1NOWTFDbTRCTzBBTlhKR3Bpekc1eFZibDd3b3o1a0VKMmZhMkli?=
 =?utf-8?B?OVFzM1lGMTNLTWUxUXBZaU1UU3hrd3RWTWkzVC9kQzNwbVFXcUJNamJGYlg1?=
 =?utf-8?B?VHJ2Qjh5ekdaZzlYK2Q1Nzk2U0RlZ0d3eVpuUlVCZkFyckN0VGFSaFA3bC9I?=
 =?utf-8?B?MWFMNlRta1krU0NKQnNENHlqL1MrU0xBYmczbGVjTFhSdE1rZVN2V2IwR2p3?=
 =?utf-8?B?Y3A3MjNTcUp6cGVrVE42ZzlHMmF2cTB0eHRwR25JWGtqd3pBbnkveGlYR1NG?=
 =?utf-8?B?VVdQSGhZWnpwa0E3WW9CUmdKcnFrOWNEUml4QUtpaGRNWnJHaFJHWTR1Wmdk?=
 =?utf-8?B?bTZZUmdLQS9LT1F2Qlp0WkV1WVlUOUVhY2lGYngybXVCdCtUUDlEUnllYTYx?=
 =?utf-8?B?YlQrSXJINlVTbFEwN1hKWk9tL1BORmRHYjdsUFRNU0F5WHRVVDMyWXlsNnhR?=
 =?utf-8?B?NTU2a0JHVmZ1VnFiQVovR0VYSUI4a0xaVTcvWDUxL0pCYm1rQzBUV3F3eGdS?=
 =?utf-8?B?aXpPZEZKclRuT1VZdFp3Q1V0LzM3VVhHSXl5ZW1YdlRYUXJQY01TbXYxMmp4?=
 =?utf-8?B?WjlVdEl2ci9CUHdyVE9CTlFybVQvMndqTFdjNFlpZEllUy85ZEdEN1phR2dX?=
 =?utf-8?B?QjVDWXlNM0p6TmxHekc5UVdyZ0VocHVYY05Ea3NqUnNFNjFETkp3MU8yZUkr?=
 =?utf-8?B?SFRYTmJISlZlM3FlUUgzVlFKVHBqT3ZRYlgvSzJPR2VEZTR3alhtOENROUgv?=
 =?utf-8?B?d2VzRm0zQStUVUp4WURuWG5weWpCU2haSXVuenh1YThEbU9hemdEZWZ6RWlD?=
 =?utf-8?B?UVh6aW14UXFtOU95RE5oSWVSNmhhcm4zUmFsdFU3MHkxQUdKRmlMQ3B2R0N1?=
 =?utf-8?B?bCs1RDB2NDJYZzRuUzAvclVuZU0rMlVydE81a1ptM29wRUJrNENPc2JvcHlz?=
 =?utf-8?B?YTNKdGFRRXhQbkRtejR5T3Z0WkIxeEFseEtVdWJnOUJlTnpnU3Q1UzEvcCtY?=
 =?utf-8?Q?HbaB+a3j4anowCOyRpDdKYhDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7096d207-fa36-473e-9428-08db66c5ed05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:40:47.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxbVrjpQQPbSsskI0+LdeDokq2191uqsP9XwBnVy9khK20CWgpP0mZMqwgEbx1Ax2rmu5AKocVOewH75dyMSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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


On 6/6/2023 2:23 PM, Bjorn Helgaas wrote:
> On Tue, Jun 06, 2023 at 11:23:21AM -0500, Mario Limonciello wrote:
>> ASMedia PCIe GPIO controllers fail functional tests after returning from
>> suspend (S3 or s2idle). This is because the BIOS checks whether the
>> OSPM has called the `_REG` method to determine whether it can interact with
>> the OperationRegion assigned to the device.
>>
>> As described in 6.5.4 in the APCI spec, `_REG` is used to inform the AML
>> code on the availability of an operation region.
>>
>> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
>> state of PCI devices.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Handle case of no CONFIG_ACPI
>>   * Rename function
>>   * Update commit message
>>   * Move ACPI calling code into pci-acpi.c instead
>>   * Cite the ACPI spec
> Thanks for the spec reference (s/APCI/ACPI/ and add the revision if
> you rev this (r6.5 is the latest, AFAIK) if you rev this).
>
> I don't see text in that section that connects S3 with _REG.  If it's
> there, you might have to quote the relevant sentence or two in the
> commit log.
I don't think there is anything the spec connecting this
with S3.  At least from my perspective S3 is the reason
this was exposed but there is a deficiency that exists
that _REG is not being called by Linux.

I intend to re-word the commit message something to the
effect of explaining what _REG does and why _REG should be
called, along with citations.

Then in another paragraph "Fixing this resolves an issue ...".

>
> You mentioned _REG being sort of a mutex to synchronize OSPM vs
> platform access; if there's spec language to that effect, let's cite
> it.
That sentence I included was cited from the spec.
> Ideally we should have been able to read the PCI and ACPI specs and
> implement this without tripping over problem on this particular
> hardware.  I'm looking for the text that enables that "clean-room"
> implementation.  If the spec doesn't have that text, it's either a
> hole in the spec or a BIOS defect that depends on something the spec
> doesn't require.

IMO both the spec and BIOS are correct, it's a Linux
issue that _REG wasn't used.

Hopefully disconnecting the issue as just an example
will achieve what you're looking for.

>
> Doing this in pci_save_state() still seems wrong to me.  For example,
> e1000_probe() calls pci_save_state(), but this is not part of suspend.
> IIUC, this patch will disconnect the opregion when we probe an e1000
> NIC.  Is that what you intend?
Thanks for pointing this one out.  I was narrowly focused
on callers in PCI core.  This was a caller I wasn't
aware of; I agree it doesn't make sense.

I think pci_set_power_state() might be another good
candidate to use.  What do you think of this?

Or can you suggest another call site?  I'm hesitant
to put this into PCI suspend/resume code, because
I think this same issue could happen at runtime too.

>> ---
>>   drivers/pci/pci-acpi.c | 10 ++++++++++
>>   drivers/pci/pci.c      | 14 ++++++++++++++
>>   drivers/pci/pci.h      |  2 ++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 1698205dd73c..abc8bcfc2c71 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1209,6 +1209,16 @@ void acpi_pci_remove_bus(struct pci_bus *bus)
>>   	acpi_pci_slot_remove(bus);
>>   }
>>   
>> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable)
>> +{
>> +	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>> +	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>> +				    ACPI_ADR_SPACE_PCI_CONFIG, val);
>> +	if (ret)
>> +		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
>> +			val ? "connect" : "disconnect", ret);
>> +}
>> +
>>   /* ACPI bus type */
>>   
>>   
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e38c2f6eebd4..b2f1f603ec62 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1068,6 +1068,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>   	return acpi_pci_bridge_d3(dev);
>>   }
>>   
>> +static inline void platform_set_register_access(struct pci_dev *dev, bool en)
>> +{
>> +	if (pci_use_mid_pm())
>> +		return;
>> +
>> +	acpi_pci_set_register_access(dev, en);
>> +}
>> +
>>   /**
>>    * pci_update_current_state - Read power state of given device and cache it
>>    * @dev: PCI device to handle.
>> @@ -1645,6 +1653,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>>   int pci_save_state(struct pci_dev *dev)
>>   {
>>   	int i;
>> +
>> +	platform_set_register_access(dev, false);
>> +
>>   	/* XXX: 100% dword access ok here? */
>>   	for (i = 0; i < 16; i++) {
>>   		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
>> @@ -1790,6 +1801,8 @@ void pci_restore_state(struct pci_dev *dev)
>>   	pci_enable_acs(dev);
>>   	pci_restore_iov_state(dev);
>>   
>> +	platform_set_register_access(dev, true);
>> +
>>   	dev->state_saved = false;
>>   }
>>   EXPORT_SYMBOL(pci_restore_state);
>> @@ -3203,6 +3216,7 @@ void pci_pm_init(struct pci_dev *dev)
>>   	pci_read_config_word(dev, PCI_STATUS, &status);
>>   	if (status & PCI_STATUS_IMM_READY)
>>   		dev->imm_ready = 1;
>> +	platform_set_register_access(dev, true);
>>   }
>>   
>>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index ffccb03933e2..78961505aae2 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -703,6 +703,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
>>   int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
>>   bool acpi_pci_need_resume(struct pci_dev *dev);
>>   pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
>> +void acpi_pci_set_register_access(struct pci_dev *dev, bool enable);
>>   #else
>>   static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>>   {
>> @@ -742,6 +743,7 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>>   {
>>   	return PCI_POWER_ERROR;
>>   }
>> +static inline void acpi_pci_set_register_access(struct pci_dev *dev, bool enable) {}
>>   #endif
>>   
>>   #ifdef CONFIG_PCIEASPM
>> -- 
>> 2.34.1
>>
