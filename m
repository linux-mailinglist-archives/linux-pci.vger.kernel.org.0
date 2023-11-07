Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6A7E3407
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjKGDPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 22:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 22:15:10 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668E1B2;
        Mon,  6 Nov 2023 19:15:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdQ8R72+Jwc+f08Np5jSaa80ahz1llaT8osBsdF9wFPjlE5s3MdDNMHn2xow9NZbfvoLMCgDd/fThx3lVH8ftylpXuYxiSkDtxxO3hkmGfRk1/LKAQ6Po0tXv8qNvc5BuIZNsRRQdS+/P89s6wucpPtYR6SMn+3MF4NEew253FBSODiB/Bq602PgytNe9MkSybWAs/VxianBYc3VQSwg86mX2CYQaG9/Qav7pqJQco78K1i5WJlF5bKFkrVacgwTZC9DykYQa7hA6wFptaWiSOXrgO1HiR0jzWtZzifvtnpyBtwDR7MFaRl4LCKEv5FFH4Jc0Wd7GSHmXuu3oaK4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQYJ+g6rNpYy9UCd/F4yLf7IQJ9K2ihwxvEQwDggciU=;
 b=AJpHQvCPJv1Kg++uA++ISYv0NakjRyOJsxhmZLyHsHck1vFGvVQ5mkBlyE1xJiI8KCDBvUxhWWONkJ60ST41/3kku8K3wFSGixY3Z4szJETnmpuNemD78HEd+NPJijcPlGjSfatayqc7ZeJbvTGf/2fLO4xK8CvVU+VOBh41qfQhfELpRc/2MFuLA9/w3AB9Ahb1R3T/fFwEhuAgHJq6cuQVivvEOkES7OsrKhCfhOICssn0kOMJ0JMc/qAqmdRcYO3SfmdaTwgr5DVCdyVbqRv3yYO1iduXIBAkbPH00LfMjELgbU44RZrldE6AJVjT8ttaD3GduO5z3tRngy4MwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQYJ+g6rNpYy9UCd/F4yLf7IQJ9K2ihwxvEQwDggciU=;
 b=CciBXdcStJswM0E3aPnFfg9dVRuG6qwY5mNunackSm6OOwYlRvn0ZXXuPH1DHfdX5D7yh/ZTGtfyfThCsgq6b+o9w6DJh90MfmpAsA8f5+J6Z2WmXIMGVAl9HWyP10vA153wZFSZVwdKlSCkCl61S3Jp6LQl+hlDuzYY38D/uDCkGCyv53+VYyw6M6kKB+eXE23mRcSSviQ5MRiCP5/R+RUcf03aHJ5+w/OkQFIt4Tlfppko2UeD0Xehxzvj4jbkRTwqWLHOqxGcdjvDUin6iw+eRzO8zFOIfgt4WcuDrb+JAe+bqFyX1Vk2N10/XwEAkEG9jvNV6KXvA63JXWEEcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:15:04 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 03:15:04 +0000
Message-ID: <0d217128-b08c-4c56-ba7c-ed7b7ddfb75a@nvidia.com>
Date:   Tue, 7 Nov 2023 08:44:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Question: Clearing error bits in the root port post enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231103182053.GA160440@bhelgaas>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20231103182053.GA160440@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: f7682541-8b3c-4bad-6281-08dbdf3fbb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhCB9McUaeSKnM4leYgkJhR5vSOzdGAQaXYIhRkPT6CzSeFeWFOZKiBjI7hvkX2buvTgtF6K70Tm0c/iIpKp+ZHynWk6VvQmXLiHBiKG9PrJgdY14pB7tKfjIZZ/SRDoAtAXgPYcAsQ0FSeaS8TwBeB5JCE83rzhRLYDuwqK5yyrgcH7NP+pO1ryxnpwnj10mQEAmDVPJONPnUuvky9ljUfbeN9a+gvXA3s75L4SOTDZpNLWtR8DZFJcLQVXv4Q+mHnXL6qQrA01MFWOMi4egTHRlMApUKBM05cAqtzUXLNnuZkCftCybmO59RSINtldiaL2oQmWLzUhVMWgb9+Sgl9iKVKl7FiE/W37ujYDTHkE3ldegcJ6nfeE7SRwykJFEOqSZ4tJ914qyupXTt4fyJXCUq8kCNP91wwemLJneuFL4Sem4gMO83iA+xxZVOgSNHBZPafhIJDNk9N8tcSeOzo5/EJAaBgjtyI3IvQYjczB12yVehfQFdJ9YcRNOqF8RN08TssnuXFunkMQjr5QD6QCOU4BDtOxd4F50Ad7mRBEHNWtYKc4AMrKQu/r66W7ZPScaK/wYIgvZtvLpR6Rm65gHBfVrVB7ec+Kp7gWTS0V4wP8yxlOcwTPOeSrsJJadLiOyHrfGguNMTuoTi27uliKqymUSWkXqPgca9AFtQh5Tus5kMhzpEsqwAnmrRhV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(6666004)(6506007)(53546011)(6512007)(6486002)(83380400001)(2616005)(26005)(5660300002)(2906002)(66476007)(6916009)(54906003)(66556008)(41300700001)(4326008)(316002)(8936002)(8676002)(66946007)(31696002)(36756003)(86362001)(38100700002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFPVlI0VnlsRGUyRnQ4TGdFNHkwRU9XdVp1MWk4WkF4L1R5VWdza295NDVi?=
 =?utf-8?B?ZjVCR1dUZjhnZ2hHTGJ3a1o5UzhGc0R1S1ExN3RLUHZ5YXE1L3hHRlF5T3Yv?=
 =?utf-8?B?MjE5MENqbTlPbFozQzRWQXIvaE45clkzMnlObUlXQm1CRGZhdHI1Ky8rSy9v?=
 =?utf-8?B?UCtlbEozQXVTcjJ6eHpvUzEyS2VodDZaa2FGaUw5UzVVTTdRMUtlaHBteUpX?=
 =?utf-8?B?RWc4YjRDV09LYzdyc3VvNlV6b2laL2RDeWc5MmFoWWxlTWtsYStRL2dmKzhu?=
 =?utf-8?B?V2I4US9wRDV4RXVmaUc4cVAxOXZVWVpJRmxhcUpJZDN0NXhqY1lzL0xvNm5q?=
 =?utf-8?B?NE9HR0p0WFg4TWV1K1BxdzErYytVVUZUeXNwTUh4c0FrdlVyK1NiUFUvWGVl?=
 =?utf-8?B?UFJPOCtsanQ1azBXYXVJbi8yNDlRUFpOSzRKbFlMa05DZmxvUXV5SWVSb3pl?=
 =?utf-8?B?RFdodHBGZDJJbTBhVFk5bUtUMW9pOGE1MERGOXVWWjdnSW5vUWc1L0R0eklw?=
 =?utf-8?B?dUNlMmczTTBLOElScnRDRkFxeVRJOExpWWk3UVpsN3k3YUo2NXRlUHRaZDMv?=
 =?utf-8?B?OFo5aGFNejU1d1l3bUh0NVAxTE5WZ1ZUdGF2bEtGWmdSb0VkbHJiakZScWpq?=
 =?utf-8?B?S2cvYzNSelR5ZXNxM2hJR0ZBeGQ5eFBDUkp4R29pMW5ORy9icWFVaDdUblpt?=
 =?utf-8?B?NnhET1kxaDMyc1V3eW92OGpqMnE1dDM3VnR1SHYvMFRITmx3bURMOGZXNEkr?=
 =?utf-8?B?MVhNazc1aXlkK1JJVmdtYUxsa1prMkxveVduN3pXaTNGcmMvNm1HS1M5cy9p?=
 =?utf-8?B?V1d5NUhBbjA4SXRvU2V5V2xwNkQ4MFdHM3doZURXRDFUeHE4NlpKU2FWQ2V0?=
 =?utf-8?B?Tk1zNituVXB4NDRxN3lEajVpNUljNkp1RzF0b3ROTDA5UUtWbWhCcmNQZnhy?=
 =?utf-8?B?aklPekdUV2N2OXR1TXcxRklIQ3ZaUi95Snp6QWxYYStPWGovbUYwaUtVN1Uw?=
 =?utf-8?B?RFllUUgwY1kxcmRWckFaclZCY0ZqRlB4ZSt0bUFJSCtpU0FQcjl1blZSdlpo?=
 =?utf-8?B?N1B6WVJOdW1aaldteXQ4TTAzV2N0RWhFdHYrYUpSY1lwU2NpYTRTdE9kQ0RW?=
 =?utf-8?B?a2JpRHNROTM5d2pvUUU2MGtIeG4yYlplNE1Zc0V6bVhYQ0V0NmlXWGx4SUlr?=
 =?utf-8?B?QUFXZlpaVmlGNjlSS3RraC9lTkowekMrOS9Eb0xlUm85M3dra2h4VkZzazl4?=
 =?utf-8?B?U3ArUjNRMGtITWYrS2YwTjRjdkowc05Zb1BEd2d4SGczbUFLWjRubGRWNTR0?=
 =?utf-8?B?bEtLWjVwOUdxTEEyNnFtbjU5Szl4WC8zdlZUNVg4R2xmSlovVVNnVER5eHQ3?=
 =?utf-8?B?NjgvNFZBbC9TVWxTS2ZpWWQ0Z3JPTGc4UlBueTlZeXpFWDVrNjNiNDNaajlP?=
 =?utf-8?B?VnNrQmw1bnBja1htS0Z4amxyRUlhd0xlWWZxa0psYkhmRldMcWs2dlE1eDV1?=
 =?utf-8?B?NFlqTkVRRkJkb1RQeThEQkZ5UitSR2c5TnV4bktNd1NVQ241Z25TSzR0THNG?=
 =?utf-8?B?VitVY0svaG52b0tSVWZNeGlGOUF1UGYzV0ZqbkhlMjRiRlpXNTJTcGM0WlIv?=
 =?utf-8?B?WTFTaWxNQ2dXM0VWYjhqbXRUSjk0Y1gzSVZFK2RKOVBKYTcxZHdXSENJbUFu?=
 =?utf-8?B?ekVZZXFsYXY5M1BnTHIwWWpGU0FCZ3dKWmkwclFaUmZSeVVJaTFYYUtiSG0v?=
 =?utf-8?B?SUdhcFBzZ0tIQ1N3K01SVkloK0xnU1BvbkF2dzRuUHJaczZWQVAremxidjB5?=
 =?utf-8?B?RlBXdk5ZQzdHNnFUajRkTGpoUk9rbll0RzNyRE16Y3NaL1Bmd2RTWUI5am1R?=
 =?utf-8?B?MUtnNnQ2d0ZzbXg4cGtEcVh1OFZLUk9EUTFjNXZudTVvUDhtbHp0Y2pLbWZs?=
 =?utf-8?B?ZXlCdkg2VjNSNlFlSkFhSDdhTHVtSmZQdWhwUHdHbkhabEpHSGVEVTdMQ0ly?=
 =?utf-8?B?SWN3MDlaRHg5NFdHL0E1RW9ReDNrZXdlZlF6SmFlOWFHbkFTNmRURzc3MzA5?=
 =?utf-8?B?MGFvZ0lCMjBuNXY0Z2cyYlpIb3lrb3dQa2JZcE9QRytUMkVsQTRyem1JT2o2?=
 =?utf-8?Q?8re/ye8ERe4Qw/Ml2Nm/Px6Wp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7682541-8b3c-4bad-6281-08dbdf3fbb8b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:15:02.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv8NwqSK8LWcMkgIAwn6NVva+o+45GHF4/yi3sohZjbRR/yrXyS9qFhyauGkoV6ZqMjcN6QReuZ6pxJfWeoqag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/3/2023 11:50 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Oct 31, 2023 at 12:26:31PM +0000, Vidya Sagar wrote:
>> Hi folks,
>>
>> I would like to know your comments on the following scenario where
>> we are observing the root port logging errors because of the
>> enumeration flow being followed.
>>
>> DUT information:
>> - Has a root port and an endpoint connected to it
>> - Uses ECAM mechanism to access the configuration space
>> - Booted through ACPI flow
>> - Has a Firmware-First approach for handling the errors
>> - System is configured to treat Unsupported Requests as
>>    AdvisoryNon-Fatal errors
>>
>> As we all know, when a configuration read request comes in for a
>> device number that is not implemented, a UR would be returned as per
>> the PCIe spec.
>>
>> As part of the enumeration flow on DUT, when the kernel reads offset
>> 0x0 of B:D:F=0:0:0, the root port responds with its valid Vendor-ID
>> and Device-ID values.  But, when B:D:F=0:1:0 is probed, since there
>> is no device present there, the root port responds with an
>> Unsupported Request and simultaneously logs the same in the Device
>> Status register (i.e. bit-3).  Because of it, there is a UR logged
>> in the Device Status register of the RP by the time enumeration is
>> complete.
>>
>> In the case of AER capability natively owned by the kernel, the AER
>> driver's init call would clear all such pending bits.
>>
>> Since we are going with the Firmware-First approach, and the system
>> is configured to treat Unsupported Requests as AdvisoryNon-Fatal
>> errors, only a correctable error interrupt can be raised to the
>> Firmware which takes care of clearing the corresponding status
>> registers.  The firmware can't know about the UnsupReq bit being set
>> as the interrupt it received is for a correctable error hence it
>> clears only bits related to correctable error.
>>
>> All these events leave a freshly booted system with the following
>> bits set.
>>
>> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-          (MAbort)
>> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-                                                              (UnsupReq)
>> UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-   (UnsupReq)
>>
>> Since the reason for UR is well understood at this point, I would
>> like to weigh in on the idea of clearing the aforementioned bits in
>> the root port once the enumeration is done particularly to cater to
>> the configurations where Firmware-First approach is in place.
>> Please let me know your comments on this approach.
> 
> I think Secondary status (PCI_SEC_STATUS) is always owned by the OS
> and is not affected by _OSC negotiation, right?  Linux does basically
> nothing with that today, but I think it *could* clear the "Received
> Master Abort" bit.
Yes. PCI_SEC_STATUS is always owned by the OS and _OSC negotiation 
doesn't really affect that.

> 
> I'm not very familiar with Advisory Non-Fatal errors.  I'm curious
> about the UESta situation: why can't firmware know about UnsupReq
> being set?  I assume PCI_ERR_COR_ADV_NFAT is the Correctable Error
> Status bit the firmware *does* see and clear.
Yes, PCI_ERR_COR_ADV_NFAT is indeed cleared by the firmware.
> 
> But isn't the whole point of Advisory Non-Fatal errors that an error
> that is logged as an Uncorrectable Error and that normally would be
> signaled with ERR_NONFATAL is signaled with ERR_COR instead?  So
> doesn't PCI_ERR_COR_ADV_NFAT being set imply that some
> PCI_ERR_UNCOR_STATUS must be set as well?  If so, I would think
> firmware *could* figure that out and clear the PCI_ERR_UNCOR_STATUS
> bit.
So, are you suggesting that let the firmware only clear the 
PCI_ERR_UNCOR_STATUS also? if so, then, I can even make the firmware 
clear the PCI_SEC_STATUS also thereby leaving the firmware responsible 
for clearing all the error bits. Does that sound ok?
> 
> Bjorn
