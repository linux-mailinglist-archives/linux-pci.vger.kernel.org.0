Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01D681613
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjA3QM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 11:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjA3QM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 11:12:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606E40C7
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 08:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTMbCf0G24QMnoTZs0iD7Bx7kDyZstEDQVghsBCfXgTfJy3mX343NrxPRe/YeFYrM1tnEI5dAIzZ0jyy8TvZyjTLOE2w9vVcTNjURtpAJgb/bPISE9TxNyije9TMyBymZEA0OMqimvf8McNzUi9/GpBfoSuHHsSU5tJETyE2lxR86npOmOpQce63agxHSyAAb81YgMcuEVFiFvm40vo91C/mdD4S70b+17GJPl0d0W8utkJ0sxO5/wkfwg0PhQf5bhVxZYvV9HNChpuvbbdckLaj6eD3Ki32sccoFoBghwS7F06VPvtZbrvuTlWThfS+9BASDqQXvwUpR3BMLA7sJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcfnVvXRXGnwRKMe8P2jrvXAnMsE/ABvOTNjsnnPfOc=;
 b=m/3xlJ2uDlaISK4v0hXKpwZ3Zk/ZsbL1Snqt3p0tC23mky4LWil9+Ulo0ojQcxVctFxmdFjh/hbQ2PRPI+qBwtfPlXSXjm4JS7vl/mNAKG0qEnwSaZZxepxlFkd5utLlXw0s19jVaSRAKnQlGW0rBqTZM2OduIpxtGAEGUJA5bmPLUlhaaSn5PbHD+3njInxIJg4xHpEiijs820yG3x+0pcMDvkYuy2yxKarNWIJ4aimrYC2qDGVIF7GlJ+cNCeGJi9NkhJVXKDJiUc23tw6XuZd3Y6d5f3V2Au3DffYCQL/n5pNLBV0vuQGFkxOinWIsh8SNcifxfsrJTjrmDaSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcfnVvXRXGnwRKMe8P2jrvXAnMsE/ABvOTNjsnnPfOc=;
 b=N8EtAZVXv5dc+EGS+Tng7m1ZJBSBdMFnA56Di/vsRpLhJjrVMr2tVU8ROXHGUKZb3itGlrGxjVppDSuwnIdOAHwoMtxF/xi47TwXwy+RXvmvLJMrvPhRDiK7XqQgkUmOFCMr64lSBAuOuYp9gpspod+KuZHErS8zlur0aae0uLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 16:12:48 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::e7d8:1e35:79ac:d6e0]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::e7d8:1e35:79ac:d6e0%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 16:12:48 +0000
Message-ID: <6bcf0e30-8a33-dbe5-415b-593f916f0fa5@amd.com>
Date:   Mon, 30 Jan 2023 21:42:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20230130152111.GA1673431@bhelgaas>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20230130152111.GA1673431@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a71f759-54d6-4a8d-dbc5-08db02dcd452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1bwcFR+UAJSIXGGTbaU+wvYnA1+0wp9CXLG1Ek/NEGwIM+9+J/XiOw3pLBgoctBSXwHS8Eyf4GVVAvIx2HOw36jpOG35vSVY5XJklg41IIDNFdC/a6JlY6pdi4gFVZ+gaO6Pwez9q/oin/lb/K9jMADl794BhCYIu3GlAGmJDeR92f4QXKmo41boKrndm4U5kJCa6L5diL0HzZQyBnIxAK9qewa1UlGmTbcjE8JOZe+fYuTGua7A3ISESLZaVmsou0ZFjl2C9N4/TTlujWZ0LAK7SFDMerzoe1waq+/CEKarQWSoxHn/pCn4jOiP7TRWGCHriknxDiJFKmHPzzn+sDm8mhOQ54qqpt3NxVkCgcdKDYX3zBdAY+9Mz5k2Fwpz0ITCGNdtcFGAZNy4CukaM1FMSKKsUxkQMrLdJAJRTihaFY2Nnbulue7LSiNitJo7PTXNYQH7TyW3M9i+0fsLX6tmX0wRILP8oodriDfZZGB5/XmhfOhtQTbqdOe3MxhPWzfxKQfsgtTdfS9NZ/FrrBrDGhVWdQOvllq5CX9V6q3WyzJxLNztmQ4k4hdTsyik6i27yRrWrCk8AQNc2tu7E0cBqc8lORH13ZktqOQPQTMgdWxItW69fvblwwtOml4kFacAT4sa5AlFSxeGlU1FDiwUrUMMxM971TZ0o50CemIxRcmbznzpZImfB9ztatvobOeNTowwiviyMq6+aiVKNozDpSosbaohsFGWosXtwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(31686004)(2906002)(5660300002)(86362001)(83380400001)(8936002)(41300700001)(31696002)(36756003)(478600001)(6486002)(26005)(6666004)(6512007)(53546011)(186003)(6506007)(2616005)(110136005)(54906003)(4326008)(66476007)(66946007)(38100700002)(8676002)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDJlNzdEQnNpbkJvSlU5clk0aW5qS003TmFCT0x5L0hKNHQ5VEViVzVSN3B4?=
 =?utf-8?B?a080WG9lTkU0eENtKzFsc01LeTlJb2pyc3VaM2MrSk9KTWVwMDNQTTdZQ3dK?=
 =?utf-8?B?WndRVG5HYnRvR1piZEV5Wm5MRjdHWTB2N0toTnE3VmNzdXIyaEJ3UEpIT2VN?=
 =?utf-8?B?QVQ0WmRIMDJ4UFFTb1o5UEpZWlh6Q2hUZnRhWHlQRDhYQS80aURxV0tZWW90?=
 =?utf-8?B?TU90TUpxOWNXNzBzYWdFakZORXEwS2xicEFsY3IyOFl1eGNiMVUzaDYzWmJh?=
 =?utf-8?B?RGFhaHVVaHJmNlM0TC9LVG1NOG5Kbk1PYkxDenozekhZVUVSMnhqMGoyZlpI?=
 =?utf-8?B?ZlhOejVNZzdXaGc0RXh1UW9UMWZTZ0hYTWtpS2lORjcwTWh3VXJiREhOSkJy?=
 =?utf-8?B?T0ZraS9TU0ZESnhZajBVNjFQR2crN0tZTDhzWDBYQ0Z0Q1lGWjU4R2g1amQx?=
 =?utf-8?B?VjVOcmpJdFdvSitJd2tGem9xMVMvQ0t3a0I1VEU1c0szdW5lZVJJSmZtL3JC?=
 =?utf-8?B?MDEyUmc4RFdqcS95eEtad2JCM0c0dzdBUTFOb1VVT3NIKzJYMUNBMjhUYm5w?=
 =?utf-8?B?REZhNlVPY1MxcE8rN0hMTzAvdVpCUmZqcm9saHZRTEhnaU1pcTROOTZkUkRJ?=
 =?utf-8?B?UDZvTUNNVVFlOWI2Ymtzdk91NXFRVkhmeCt3ZU9RNy9aQUJWdWZLbEgwZnVK?=
 =?utf-8?B?UkMwWEM1Wmd0YzZmTmIrUTkyOEsxYXcxNW1WOUhaNXluRHRhUENiSWtLY0Ri?=
 =?utf-8?B?V2hqdjU5U1A3MS90OWJVTjBCY1g5RGdZWVc5Znk5L0RPeHhjR0ViWDB2Y0gr?=
 =?utf-8?B?M044RmVYUkJvcDR4RDdINFRVOTBaTnlrY1hFRFM3eUN5SFJkaVhibElnMm4r?=
 =?utf-8?B?MTFWbWxYRnc3NnVKMnA1QUxaOUl1ZTFQVVhLamo4RHZRUEloRG5ta0QweU9z?=
 =?utf-8?B?NVFhY3A5QkdLeFVQUjZ6cHNTR3hDNGRKMEdvQ2ROQmNDUFRvK1I5RldRU3FP?=
 =?utf-8?B?VGllYnF3bTI1RUtnNE9NSlFxenMwblNwcS9iY3pJNzNQYzRvU2tCZFRYZ0Ur?=
 =?utf-8?B?UW9hcWdIdEpvSU90dUlobkxxa05jTUQvaWt2dTFYWXNETWdkZVk3ekM2WFJI?=
 =?utf-8?B?UDNVZ1kySjh4ODdrRjUzMGRsanNuMkg2c0VlWlBZQndvZWtJSVY3bXBTaTRI?=
 =?utf-8?B?NllCQ0hUZW8yZFQ3SkxFa21yVzdRM2llM1Z1ME1yaTJyTnQ3UUhITS9kN01u?=
 =?utf-8?B?NFRiTThLbi9RclNlSzJObDJFOXFnSEFNdUlsS0F4NkNMTUFRaGNuek5xM3pT?=
 =?utf-8?B?dlowSlJkbGp4bVBFWmxIcTZYTUVLNkljVlVGMlJiZlN6c2prcU9NSmVvMVhw?=
 =?utf-8?B?NXBjVEVaQS9RRHJDaVdqbmlZSTdlMXBmRnZtVGdSWElIZWg1WnBxVVhoY0hw?=
 =?utf-8?B?ZkkvblFzNkJieWJFRVIzZ2QrRkEvcERQYkZCaC9HZ2VqaUdaOWlCYTV6bStV?=
 =?utf-8?B?NmFrNnpla3RtVlZQMDlqMjNsTldzTjNydHppY2FoZVZsKzZqQ1BqMTZobEEx?=
 =?utf-8?B?b1N6cUZuNThwbitoeWR6WmJHaDB1RmE5ZHBVOXhia1ZYZmFQYkxLenU1a0FZ?=
 =?utf-8?B?clF1SHZvYS9CaE55akhmeEVyM2dzTW1VM0p1OUFRVE5wMFl0T1hTQ2VEdk91?=
 =?utf-8?B?Z1A5bE5nbmUxbFF2bjNvSFNBRU80Z1VUUDR3ZS9WK3lzWVc2QTR0VVZBenM1?=
 =?utf-8?B?MFQ5eXBuWFhjaVV6OXoyR3pucVRZMUtnSmpTREhYY0JCSWJlbGJXS0w1QmpX?=
 =?utf-8?B?ck56VjN1MGpyRmo1aTBGdGdSUmg4dHpCcHcxWUFZYTFXemt4MlB6WXZWUGFY?=
 =?utf-8?B?Z2IvbGZwTUg1MkNlNUx3cC8zQVcySTFLczRHQkwwSFpzdjVIWkwxTlQwSnlr?=
 =?utf-8?B?bEZ4NnMzejhlQVAwQ2s1QU5tTGhQZVlWa2lXMjZWcWh6V3UxTkNjdU1GK1pP?=
 =?utf-8?B?Q1FBQ1ZmMmJYMCtNeFNyNlNGdjRoNjZuWmNqb1lUbndBRU1qMkJzdDEvYXpo?=
 =?utf-8?B?UkIreTBTRHJWSzd4SDZhc2lBU21SVXozWlhBdklrU0E1WEpUZ21ZeDk2UUxY?=
 =?utf-8?Q?7A9J9znl2NO9Vn6Z/mN/6JC4s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a71f759-54d6-4a8d-dbc5-08db02dcd452
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:12:48.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynEKXghQFj1RXGjpNvENSidEQ0eLo9g0XunyaSagfxLBfKNiKQwSDJGkpRciHUb9q1FrpFuF7G4mnHQS7rxC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/30/2023 8:51 PM, Bjorn Helgaas wrote:
> [+cc Mario, Shyam, Brijesh]
> 
> On Sat, Jan 28, 2023 at 10:39:51AM +0900, Damien Le Moal wrote:
>> PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
>> guest OS fails to correctly probe devices attached to the controller due
>> to FIS communication failures. 
> 
> What does a FIS communication failure look like?  Can we include a
> line or two of dmesg output here to help users find this fix?
> 
> AMD folks: Can you confirm/deny that this is a hardware erratum in
> this device?  Do you know of any other devices that need a similar
> workaround?

Niklas, can you send the list of AHCI device id present on your system?
perhaps a lspci output?

Based on that I can talk to the FCH HW design folks to know if there is
erratum present for those device(s).

Thanks,
Shyam

> 
>> Forcing the "bus" reset method before
>> unbinding & binding the adapter to the vfio-pci driver solves this
>> issue. I.e.:
>>
>> echo "bus" > /sys/bus/pci/devices/<ID>/reset_method
>>
>> gives a working guest OS, thus indicating that the default flr reset
>> method is defective, resulting in the adapter not being reset correctly.
>>
>> This patch applies the no_flr quirk to AMD FCH AHCI devices to
>> permanently solve this issue.
>>
>> Reported-by: Niklas Cassel <niklas.cassel@wdc.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/pci/quirks.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 285acc4aaccc..20ac67d59034 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5340,6 +5340,7 @@ static void quirk_no_flr(struct pci_dev *dev)
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>>  
>> -- 
>> 2.39.1
>>
