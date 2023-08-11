Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD5778FAF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 14:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjHKMkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKMkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 08:40:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8A030C4;
        Fri, 11 Aug 2023 05:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH0/Uw1MLfE+sdox+kbVK1ZvctwK2wBW9Dn6+hZp7aZ7ml5WiFVxZAcmPeI2io9qmOhXyzUwgFeFLrir0lPEzAylKM92Jo+zrN6GgBFbl+ZUxzT2xIsp8RYP5VJupemeWJsaDrynvKqUO5u7a8IoMzKooMux43dlecvYDhtAw6ezg7GQMQPl2/CiRs+MWSWP8Pw365YOfMXBwvG5yVz8rY/yybCIhIyTt6b3n/qLGc9EwEZ9cz8av/7A1JH5QHuE/1ybXUxMB3zGWS12ikqV0dVLARporl/UJPY7EFljlWWLtxkZvX7DY2FPk5DgNz5LHG59tKd+4Spmpa5DAATi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18pNzsDSNvpbh2hEaSOXfiD3nKicVKaqgQGZa175baM=;
 b=N/Wk30thiHIxuESoQ9e27/rNRIeFQP+NzKbKBywERmfhTwT8grCLHYL9rJlbBRWWPFWqteZcPLhnZMh3cwqnEHuy3GeU918Jl00Lrs7NjuEYE4JNgZCoOocrATmKChiqBFjyupT5LxXwBHhGNRXBcafKfaX55Ls2bxlbLPgfimjHhTX1bAGiYa8eV7SWZ4vgafvWZ+NRcHkaQpQ9w6WZoXlug6fQkZefNB1x1x/C2Nt3A3DQ/GIeVRRFJ+omizHktqJ24lHFqxNbqFu+ft/VGuD+yTvRuW2+zOU18KzpT6WSs9iI9TVR0AJ1TNMqhlT96tTtze8T0MCM3Yip5kuLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18pNzsDSNvpbh2hEaSOXfiD3nKicVKaqgQGZa175baM=;
 b=v7JffSqo7xNDsIrOO0EyZCLs9gebfCalUeOSNfplU7X+201PiXNO5QvEr6TJXSFWECvuWl+4cLGczIQQj5JQqy+R4EeBJ29dOjcx3hmZCoXGaZ35PKzqVG/28mGXk+CK4ehvwEnbhITKA/67Z7lqyawHL08tVKjJtFxC13hTf1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 12:40:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 12:40:13 +0000
Message-ID: <3d13c3b2-fdb8-4782-ada5-cf3f94e0e643@amd.com>
Date:   Fri, 11 Aug 2023 07:40:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] PCI: Split PME state selection into a local
 static function
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-9-mario.limonciello@amd.com>
 <ZNUOo+OKEv6zfPSY@smile.fi.intel.com>
 <c07aba63-6ca0-4889-aa98-30248f86c313@amd.com>
 <ZNX3n5rHBHkN4kZy@smile.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZNX3n5rHBHkN4kZy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d231cba-be7a-41ca-6c87-08db9a681b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DyHPCDkS1TbVFfZoucggnH4pkDu15UD+uuV6Tczey+YywXc3OnypMSTU5xnUhR3g/NT70qaOXhcqESkJw0l7hv1P4y5GOiQVs1I/vN9C+zLPH8vvKA984PReGUUcRGg9VsLA8z4Pijr5yXRv22jz5BH5J/8YqjlvO27TGFrcKSmu2XMEK+fD3PuuNOdaUiyBvPBprGou5SmkbYnmc5c0sE03nzsvdGtyZKX2B37XzK0Mr+w/CIm5s2LYpJqGJXknMOWsWs49rvuLr69fuB22cFJOoa999BySFZ97EqBNGPVYeVy9aX/5xIxJ/aPChZWvROERoIeDUWjlDwgycOLQlabzL9jOiiXuXzbM2PvqFcaAqpQvBqI3RhZYYdDTsri7Bbgz56b29zcOrLzBUiiqYc0cdAtRd5mkhp09ewLuFyAS60BMR83ch9j4moTi7w0FY1YiPmIaye2rHNaWhf46Q9ZAblup4VMhYUd+35NeBLpvuPBfH8deQ7H2bXFWA3XKv9TvUla6lNIN4cORUOPC48eMUI++jYBs/p0jgWH0iTJWbs7QhjpfIIdlkcjpK4m6oGVAkF+JsD0+yhIOc5K3TA4JlpSJZeeVwkz/9un5BHADvYBPDBoK6PASg/+N5hgVgHNKXXizUB8tWIZGy00PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(1800799006)(186006)(36756003)(2616005)(5660300002)(6666004)(4326008)(8676002)(8936002)(38100700002)(6512007)(86362001)(31686004)(31696002)(83380400001)(66476007)(66946007)(478600001)(26005)(66556008)(2906002)(6916009)(316002)(54906003)(53546011)(41300700001)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmUvcXdvdnA4YUdOOXNmN21ObjN2REFuNGZZcEpOaklFZjY2aEtLK1E0dWJ6?=
 =?utf-8?B?bHJ2SEIvdyszNlFIVXE5Wm9TWHk4bXFHczF5ZE1DVDRScG1YM0xMb3NwWTY0?=
 =?utf-8?B?VWowc1Y4UWU2dmsrYy9ycE8vTys5cjExQnUvVkFIbzVGMEpQUWhiVWh5dlA0?=
 =?utf-8?B?bFdLSnV4dno0czV0RElVQjBrMGlUMFI4M0xubUFlbUdHQ1JBRVJCRUQ4eFg0?=
 =?utf-8?B?eUliK3pJWnNRT0FHSjBPbmZZQnlkZnBrMi9FNnpzZUZDT2p5S1FIOEFocTdO?=
 =?utf-8?B?aEVpc0hQWGE1dVZxSjlEcUR4SjZVaWZSRzRyb0pKK3BObDdhYlhFdFg5NzF0?=
 =?utf-8?B?Q3NtZmVZQ1Qzd2hrSHBtQ3ZkTG5OZ2FuQlpxZXFhZ1p4VzJ3TlQ2QjlKc2ZX?=
 =?utf-8?B?eDZITGZRa2VOUnJUdXZhMWVjaDBWTkJPeGdsRHhkU3lkc2RkOVZtb2VQODE4?=
 =?utf-8?B?Tmg5REtDQWtHWTMwMDVaWTQxQ3NDdStYSktDYXZ0bU9jdlE3VHU2V3pBNytz?=
 =?utf-8?B?TjRxQy9kT1FQOXJHYUlveEtjeVR3ejQvZ1FUTlByRm1PNThsYVpVcmhVMGln?=
 =?utf-8?B?NEZ2clVuRmNKR2J2NlpRbm9Ea09QZDVaOFBFUVcrbFRnRmhSQmlSWU9VdTFI?=
 =?utf-8?B?cS9rL1JvRUh0SVFtWnRnbkN3OHVKVGRMUGVLcy9Wc2EzMFFJUE4zZExtNGFl?=
 =?utf-8?B?bHE1dldXTXVHclp1V2czSjhXalpSNFlpcTVlT2g5clhEeUpsY1k4M0toZ3Qr?=
 =?utf-8?B?WWZxc1hVMFNDVzhNOGZiK01Sd1NBaVNIaGk0S1FXWDRPSDZ3NDNML2xUaVZE?=
 =?utf-8?B?RFJIdllxZGxzUXQxZDZZREd1ZlpJZDRFRzFTeXZ6T0FOT0lsQnZ4UFQwanYy?=
 =?utf-8?B?RXFJTmQ5ZEIxRGVRNXRsZ0pXNlV2NEhvTlhzeWZJcHhhU25uV2NhMXQ4My9z?=
 =?utf-8?B?V2VpSE5VaEVtRkMrTFRTRTdUbmlpSndYdk1LZmlmalRuQmFHSWdQRkV3U3ho?=
 =?utf-8?B?TG9KK295VHA0ZDI4eEtqb2llelAzWEVsenA2TTdieGc5ZURpbXNLZmEvbzQv?=
 =?utf-8?B?dVkzaXMrMVdPMlo1WnF3Z2swV01rZS9BSmVlS0tZeHB5UE1UY0kraFJ0RE5J?=
 =?utf-8?B?K041N2Z1eTBMQ29UWHJBNXBUaks0MkwwbXRKbGt1M0R6YWZwbERKUndyc0ll?=
 =?utf-8?B?ZFV5L0pzRmREUUxFczI5TXBoQzBWbUt4ckZWUUpMVjZacE00NkFZWVFiQ2ZH?=
 =?utf-8?B?Zzk1UWxlMU9DSlFsQ3dHejA0WEFiQ3U3aklGL0FlSkVtd1FFdk8wam1hTGtW?=
 =?utf-8?B?SDJtdzUrdk1YNmdONnFpdFMrOGdTWnd0NkRCa2JkTU8zeDNiTTlZOFJ0ZkJy?=
 =?utf-8?B?Q2VaUTQ2RlRBZ3hSUzR1Z2pjRWZFK0FPcFIzbUtHNlRKRGJrelR1NElDWjlP?=
 =?utf-8?B?azNGa0QxbU5mekM5MllZVXJJMTdZLzNTbUdjQ2JyMUlQMTc5WkFxUHBqeEE4?=
 =?utf-8?B?TjBIWSt2c0tkK2xTek9PNmtydFZzeVFPMGEyRTc1K3l0aWlWN2lZQzBpTFNo?=
 =?utf-8?B?YmQ2NldBa3YrNWxSL2JQb0R2dzRTUGwwUGxISHhFMlVpY1Y3R05UTlBhVGxQ?=
 =?utf-8?B?alNzZTNBUTQxV0llNUwraGl1R2V6eGR3MkYrOEdlK3dVL1pyQ1ZQb2U5cDhP?=
 =?utf-8?B?aUlSa1Q0cVEyYldsak8yd0NveDBKTHV1UnF6UDBVWFM3Y2RmSCs1QWxBWHRJ?=
 =?utf-8?B?ZElIZkxZcUtWZ0N2SkNDd0hsemxzRzJ4d3Bkc0pEa09jZGtiMVQzM0pEemt3?=
 =?utf-8?B?bXRvc0I1elVnbndMRHR1eTkvRnpZUEVYcTc0R3pDVndkVFRvOXhkTmk3U3ZF?=
 =?utf-8?B?bzgrVjQrMmtkVU1idDFqWTZnTnhtYW41TzQxRHAvRlYyQVlOdWxzNTQxOXFG?=
 =?utf-8?B?YW5nUUNrTlNIY2c1c2I2eTN1TFAxRHlvNU9hbDVOUzhUSGJpZXdtOEVDZ3F4?=
 =?utf-8?B?WVdHN1BPL3FQdjZ4amtzT0haNHVGZHpUTTFSUW9qTzBrU3ZUbzFvZEY0Tmhn?=
 =?utf-8?B?K3NrdnVlbVNDNlQrK0dnaWczMk15QXdpS3lob1N3K2tWcEhvYzNTSVg5ZS9J?=
 =?utf-8?Q?SSRAqXwvFeL4vIgGt7+QgChnz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d231cba-be7a-41ca-6c87-08db9a681b8d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 12:40:13.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a89sfqurdZYh1v8o4fS7S5/qXCJ6kzphi8QbOyO7G2HBVb4kS4RetncSqvaijg0X9WYqlgS9GGE76L/PqTlhiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/11/2023 3:55 AM, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 11:29:49AM -0500, Limonciello, Mario wrote:
>> On 8/10/2023 11:21 AM, Andy Shevchenko wrote:
>>> On Wed, Aug 09, 2023 at 01:54:52PM -0500, Mario Limonciello wrote:
> 
> ...
> 
>>>> +static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
>>>> +{
>>>> +	pci_power_t state = PCI_D3hot;
>>>> +
>>>> +	while (state && !(dev->pme_support & (1 << state)))
>>>> +		state--;
>>>> +
>>>> +	return state;
>>>
>>> Sparse won't be happy about this code (with CF=-D__CHECK_ENDIAN__).
>>>
>>> Basically it's something like
>>>
>>> 	return (__force pci_power_t)fls(dev->pme_support & GENMASK(PCI_D3hot, 0));
>>>
>>> (but double check and test the logic).
>>>
>>>> +}
>>>
>>> ...
>>>
>>> Yeah, I see that is the existing code, perhaps amend it first?
>>>
>>
>> Are you sure?
> 
> Yes.
> 
> Just the original code
> 
> drivers/pci/pci.c:2711:60: warning: restricted pci_power_t degrades to integer
> drivers/pci/pci.c:2712:30: warning: restricted pci_power_t degrades to integer
> 
>                  /*
>                   * Find the deepest state from which the device can generate
>                   * PME#.
>                   */
> 2711 ==>         while (state && !(dev->pme_support & (1 << state)))
> 2712 ==>                state--;
> 
> How is yours different?
> 
>> I actually double checked the sparse output using this
>> command before I sent it.
>>
>> make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' drivers/pci/pci.o
>>
>> I didn't see anything related to the line numbers for this function.
> 
> Just in case...
> 
> $ gcc --version
> gcc (Debian 12.3.0-5) 12.3.0
> 
> $ sparse --version
> 0.6.4 (Debian: 0.6.4-3)
> 
> $ make --version
> GNU Make 4.3
> Built for x86_64-pc-linux-gnu
> 

Oh, I see why I wasn't observing it now.  Because it's inline code it's 
processed separately and isn't with the rest of the grouped output from 
2416 through 2922.

drivers/pci/pci.c:2679:52: sparse: warning: restricted pci_power_t 
degrades to integer
drivers/pci/pci.c:2680:22: sparse: warning: restricted pci_power_t 
degrades to integer

