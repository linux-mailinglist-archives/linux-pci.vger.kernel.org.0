Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375BB79DF39
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 06:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjIMEoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 00:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjIMEoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 00:44:05 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69CB8;
        Tue, 12 Sep 2023 21:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA57I3wSes4sen4y1q2L/k68fHhvkVwd8/1Fdsvdvwxq2cvo85zemzhYbxW1L0jwcFGBBuog69dZ3vmMT5/pvfb+jFmsLf33Bu4Sw6sd1OPbRvE7KtSil1kHStEWpmOxBK4QEw4Ke50nrgfZqYHJ+8JdaAhyx5u3fm/xnGuixncO4BzanuB76SJ1UZoToWa9JMRZnQhTq4dqFazr8uxF1ETeVwyfRrOWp0QrJl9443zy537tUynq0++eTOgl9WPmMOKMarZPOxxt7dPhq9qbp/RLhbe3ORKPgfTCdpjmkaAeGC1XcAZiO/7qnSP/updREDYwaqiR0if9JLP4WqwNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ORJvU9fYKNsgaW03CdQgyqO3iqtwj0NJ3iqohVi8QU=;
 b=HlNTgRSixnFCNmVT6vLlqAjc9xn6l+kh1hMvMF6CGmYyEY1VVl7lfxC0hByzK0Yuhzbo6VBudCVWHi6SyPFt2l1v5h6Bb9Cuhla9DbY6yPTE5sVYBd+5+s8r1Vny/nCsASiL3mOMR7HePj17vpn0EloFaqaozRfxKa8j1EG+1RTe3CW59x9T5wOLhJhTYiDBLFhVAvf2XkoqmLXizmfCvcJqR8WRGwgq/IWJiMpsEO/rpv9PRJcXCJM/8LYgodVxJQUx935vRsaH8YtguoqJqftuNDoAQVwFUCQbT/1BmWEuZ+vB1EcLGIgc6jaEcaFZOMDFuJ4BOFrzTjnNVwzEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ORJvU9fYKNsgaW03CdQgyqO3iqtwj0NJ3iqohVi8QU=;
 b=eyXsj9WsF3zl7LViw0ExJfK9k0MadzcDteTcd5cKuZiPudgQ3/BYF5oKUKMlGLsMPmzZPkJpfBfG1zQ1h3gLFnLU8SM6NCwcdOZzBu0IuhCYWLCAx+xapAah4B1Dgv9KXD4RKOfSP698qjVqaViQy62doLFeMM4fvVMiWbPVLsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 04:43:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 04:43:57 +0000
Message-ID: <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
Date:   Tue, 12 Sep 2023 23:43:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com>
 <20230913042522.GB1359@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230913042522.GB1359@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e26d13f-ee6b-4e4f-c2e3-08dbb4140a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubcxqgKkvK9L/dtQIlzjCesqs2gLSuHm4HHoPMV3V51ultEtuXVxludKPSpZN7jgokI+6MZKF7DQx1Rd5WB0yHyqXzY7mWP9+yDsVv2F4wb9mhajZoXR0aMhXBz/qRgh19V4/uiAfxfkKY5vWxBjxlRMBVBzmLfFu2XtQLdAhNcpx1GIgen/m5o7ovZfC1cRdlbA1pMrYuw1mnTdz2jHA7/L5qZiiNWyUvv5iueY0Nt6pIXGs+1vTSSnbZizSGoNfqYJOzLS/AtpFFBy6hbhaIDsrPZRhT5F1JZMcyE1EiqWPM5lWPzDlt/7Vvi6V8kyseQC3B5Eahw70265rooIQyEa/ezMGYyzqJ/kj5PIVJIFUlBJLWJCv+uMSw118J7nQ7B6Nc2naaTU329oPdvc92VOcQ8pWwoxBdzHuHKvFHTodHEAqcFEcgEo3Xe5SNXaXc0NYRWRc/NMbSQ3lhEtGi5paXhOYGolG+/uQ6EcwHWe+STIpNEZnoH1MuIsGZisWVD+JP7/TkeltHaHf2SGnkJuahmjAyfh9pc4rye8LXIc9D9JQZz4T/0/XWdI2cRPOTNugdSfXBnwat4ClF80Es0N5SFzPBAAiOY13i5WBuhbZRP9ZZ8D9gfwqVpny+/q/U48cNHupmm/C7CpIKaaBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(6512007)(6486002)(53546011)(38100700002)(6666004)(2616005)(6506007)(66946007)(86362001)(478600001)(31696002)(83380400001)(26005)(66556008)(2906002)(316002)(44832011)(5660300002)(7416002)(36756003)(4326008)(54906003)(6916009)(8936002)(8676002)(66476007)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVWRFBoQklkT1czb3h1NHB6YkpIcTdScnk2Z3BTM25sUWRqNWZzZWZsNllF?=
 =?utf-8?B?eDUyZHFPa3ZQVG5TbDNHZkFpcFZzQkZWU1Q0N0poWE5GT3VFZVgwT0lLbVIv?=
 =?utf-8?B?akRKVU5vZ291eGU3YWJQbUFJUjNYRzFhZnJUVDl0dlpxK0hjb1o5TE1abnZ0?=
 =?utf-8?B?T2hDRlU3S3Y1K29iRkFVczNtY0tsNmtYZ0VGRTlHTXZkSGRUQmwwY2JvcHdW?=
 =?utf-8?B?TkpLUGxiY2hDUzRBRnNSOVBJRUcyby91SWt0eEliblZsTERPLzRQU1MzczJq?=
 =?utf-8?B?NEdtTExzQjhnNmhlQVlFQy9DaXdUMFo2aE91SHFHRGhqZGdRd3h0Zy9RMDhV?=
 =?utf-8?B?MjhVejRrZmo0R1lMeUEvYVE1Z2pITGFuQWxRQWQ1eEUrU2xOY1RVWmdvUlJU?=
 =?utf-8?B?UEN1TkY5ekd0UUZyM0pUdWZEemx4RWhwOStkK0o5VGNtYkhJOFBYN3JjeWNi?=
 =?utf-8?B?elJkbDRCa0l0aGs5czFBNWt5dnJoZEtDQWorcXQ2SUJtdnpHSDNmME1OZXJi?=
 =?utf-8?B?b0IwaWhQMUR1K1NQblh2THYycGY5NmRuSXNPck45bUluQVA0NzJaVVdOVVpz?=
 =?utf-8?B?aHNJeUZNT3E1dFE3SGxiZitRQm82bFo1Y3JRanNZRndocENzNXhDNmV4SGp1?=
 =?utf-8?B?Qkl6REJuNjdIdDdQMTBiM2pTR1BmbWVHOFJoWThpaVRTWnVmYjliWmFJSElH?=
 =?utf-8?B?VkQzaXgyb1hqcTluZzdpelMzTG13RXVQTGFFZlNCdkJXQ1hmaFBtTVBrU2h5?=
 =?utf-8?B?VXNrK2FzT01OTkxYdHU4Z094Z0lBeGZ1eFp0NWtxTjZjMGhFZkhiQ09FSEt1?=
 =?utf-8?B?QVlVWWpvL3lIZGxGU3U0ZnI0RkRsam1QWXQ1UGdFYXZBQ0sxeTBUaVlrUlha?=
 =?utf-8?B?RENZb3F4QmNnMGxrYklUTGdQWTRjcFJ3L01SQUQ4Z3JXMFVyZ0pHaGR5S3Nz?=
 =?utf-8?B?c0VJVE1oNkd1WVllVjJQSFZ1cll4WHkvWmx3d2lRYzhDVE9rVEJ0S2dSZnRC?=
 =?utf-8?B?eGxwMzhQNDQvbjVSaEhjMHZzelFuQ29KZUJnaEErbXhBZWJUMUhvWitoekN4?=
 =?utf-8?B?R2JrV0NSTHJBT1pWcldjOUF5aENLQUR4d0pSK1JtdFkvdWgxQ0ZLMFJwSXFM?=
 =?utf-8?B?YWhZaWJZUUJDU25rY0NFYXNSM0grNTU1YWdWWnFjVS8vTEF1OVRzdk44REpz?=
 =?utf-8?B?cHk5alNRb1N0anNSWWZ5dlNXNHlFWEdQSnRyKzQ5aUUwaHY2UTVFV25VRG8w?=
 =?utf-8?B?Sis5eXZrOU8wZ2RqNlZDQmFCRkgrUWRabUczUEoxM2I3a1NkR0hJdnR3TFZU?=
 =?utf-8?B?Y2o0ZTVRV3o1eWdnb0xZYmF6VTRualVTRDloNE5nRWRhdXVyUUppNVN2NmRw?=
 =?utf-8?B?TGVhR1hRVUtzUzVsemt5V2t2Y0p0RXBzTTNKM240cFBrTStvSW05eVZoQ2hp?=
 =?utf-8?B?WlZ5STh2dFgxdG5Wc2FOTnV5QkVadUtUT2NaOXJwMERDK3FvN1Z4cnBsSDdZ?=
 =?utf-8?B?SEptL3lvTzhISHpLL1hYNTVzT2ZIWUV1OFhCRTRjWmV1SUsvamtpQUcyNXVq?=
 =?utf-8?B?M1lxQWNHWkovUXdTWE1DbTNERENRZ2tza3pJY04xRkF2UnlUb2ZvTGNvZmpm?=
 =?utf-8?B?R29tMFFKUm50WUFkdFBvWUtGSkZETWozaG9IU2hRbEhHMmZBSG8yb0FHdWZ5?=
 =?utf-8?B?WW5aQytFNnZ5RW14aVZpcGsxWWZFYkZPaEdNcTd4NkszTVRzd3VsaHFhVHds?=
 =?utf-8?B?UVR4SGt3NDZ0VXFyaHZrREgrUWlVTU9xU0lWRmpRTEZUMDRnOWRIR3RoTFh3?=
 =?utf-8?B?K3dGY0hNSHZBN0NzK3IyVlpHVng4c2hTK29FMm9hdXdhOG9VWnQyT2lTT1I5?=
 =?utf-8?B?RVFTaXg4VVhMYzFYUkRzUks2YlpoUlV5WW1EaExqRmJzcDZ6RnBCN2pBZjRJ?=
 =?utf-8?B?UkVBc2Rodm5YWDZNUEkyVGIzdTF5UDFFU1hqTExxdzNCWDFpRi9YNjBvRXRi?=
 =?utf-8?B?TlRpVTBJaHlqZnBaaVB2cUxZVUR2OER5OHpIZk1yUVhYVTk1UnFwTFhabUR4?=
 =?utf-8?B?QzZvazhSQnlEcUwvV2lVSEN1bzRNT1FHMzI0WUpzR053U0lRMU42Nm52bzdT?=
 =?utf-8?Q?mGqUMCpAtOvRP/b90Gn+X55fT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e26d13f-ee6b-4e4f-c2e3-08dbb4140a7f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 04:43:57.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBNRsfczGTn9s+eXoiCHXO84lBay27RB1fNQ01HSfaDgtSpes2pqHXHVxfTvIaCby4rJrCN1QxE6fAfPstkxTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/12/2023 23:25, Lukas Wunner wrote:
> On Tue, Sep 12, 2023 at 11:08:32PM -0500, Mario Limonciello wrote:
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>>   	if (target_state == PCI_POWER_ERROR)
>>   		return -EIO;
>>   
>> +	/* quirk to avoid setting D3 */
>> +	if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&
>> +	   (target_state == PCI_D3hot || target_state == PCI_D3cold))
>> +		target_state = PCI_D0;
>> +
>>   	pci_enable_wake(dev, target_state, wakeup);
>>   
>>   	error = pci_set_power_state(dev, target_state);
> 
> Would it be possible to just add the affected system to
> bridge_d3_blacklist[]?

It's initially reported on Lenovo Z13, but it affects all Rembrandt and 
Phoenix machines that have USB4 controller enabled.

It's reproduced on every OEM system I have access to.

> 
> Or would that defeat power management of other (non-affected)
> Root Ports in the same machine?
> 
> There's already PCI_DEV_FLAGS_NO_D3, would it be possible to just
> reuse that instead of adding another codepath for D3 quirks?
> 

The root port can handle D3 (including wakeup) at runtime fine.
Issue occurs only during s2idle w/ hardware sleep.

In v16/v17 (see cover letter for links) Rafael suggested to tie this 
specifically to suspend behavior and when wakeup flag is set.

I didn't think it was appropriate to overload the existing flag because 
of this difference.

> Thanks,
> 
> Lukas

