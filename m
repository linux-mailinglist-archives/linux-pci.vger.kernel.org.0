Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41A68EECA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 13:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBHMUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 07:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBHMUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 07:20:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F64238;
        Wed,  8 Feb 2023 04:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0vCmBL0lSaDKAMiqnxqOCLKP8yfDckHmoWA+yF/bEW8GwvbLWVfbrmNmO9G7CHlbnBTgMgQlVjQlGPyS3lgzbs9zaWWwUoMEKiIOFwG787Kme4qww1HOfylP8z3HKQVgx4+5zpWfQ/X/ovHD/xWayV8oXfsltLSxtQQUnvLCFqjH2wK9+RJvwT3Qm7Vf3wwI1767HSc3ECAXaY2sH2kAcBt7TvrecESd9C6yJx+B24Ot+1W8ftyLo2zi52Yn/IzTgUvUIIBB5zOoldDgz2ptZrX59oLdk8XxLU+4rulF4rhSTTv+6oZdRdaJnHgHsr9xY5oVrP8kbzlSCLxqUuYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bYbtIvYaqykqIpwthNf8li0oA2XXEaMbObcNEA2eCI=;
 b=QuWjdh4+UmHbpD7wMoLP7WCnW7iYKGqr7Lmf2cRU38KvAUYPVP/fFf7JeKxrYYHO4VBYLA/zGdAFIMKtq9wJZZ7ktF4KzzIPWMJavBhwENgQuKZzfVZusx65qQIkvRNYTP43TZBTgfg0MtRdFb96MnlrhyzqLNMJUadDpvq2nLx8lGEElguG7Y8ARXD/WxL2Tc6NvdpUgiZcTEBY/JTuGbuf4KTGpk+R4i3a12kHT8UjCzgMdElDb+XewK1iC7Jc6po14FaAgB5MqC52qY0x8BlET5Dad1OAYSQlM8bPCtiLTha3ERvQjc6xRr+YBcJfOV+3tVviVXdsjJXry+yavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bYbtIvYaqykqIpwthNf8li0oA2XXEaMbObcNEA2eCI=;
 b=bI5m+IFvevhKjZ2iheKC8ECGVnN6e/U0r9ikwQlkwuHDVmdWQYJwAE0CbrGTnI5MpIjKowjNLe9DPhp84W5oGUWfHz5+lTWhCxs72j7Zgwwzd3uN0GqduhyuFMn7b7c+WAgOxTMcn/EO6Z/YY37nzmo1jA73Lq4wmkbMcsZFyNBZx43JT7MoEOjZxiWYM3BCz2j6kAbtvYKtzoerJ0LLe0W8TOHs63En4WsEXTo86BsuwTw88p9DZvQ+z92v5ot29li7GU6Oyl2p9vsmWkZGmYbmVd9LrcjotKmGlRlFZpq6fmQdQcN7UPFLL15MMHEjRs378X2L8BqH94Pxqv2aHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32; Wed, 8 Feb 2023 12:20:46 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d%6]) with mapi id 15.20.6043.028; Wed, 8 Feb 2023
 12:20:46 +0000
Message-ID: <fdc729fb-2d66-93e0-9544-1a8c8d231b4f@nvidia.com>
Date:   Wed, 8 Feb 2023 17:50:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC,v14 2/5] of/irq: Adjust of_pci_irq parsing for multiple
 interrupts
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-3-mmaddireddy@nvidia.com> <Y+OLLMrHqMCrHxLB@orome>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <Y+OLLMrHqMCrHxLB@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 520a0dda-f60c-446d-b4be-08db09cee7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDg9Gp66oSDNxFoQH2WtK3jQLmvlRncdlMu6riu8BQlkzJ1BLAQoUSXm1tk8xnpOghudv9pDnO+XBnN0c+6jM+ctysUq5dY/cr3KWOHZ7na6G6rWmzwdf1daIfQ7nbzqixj9lgNOd/SqQiPTQop2kHY8V7QzvdLgZvTziVSIneETPg/lCu18qB9FvR2D4YEPv8xwC/CdtjAxpeQjkU7/dgvRLtN8U5wifVGqSuTlCGKKSuy+O5SCSYO7ObwoEWCBA7i2iVIsF0JjE2dWt9RRR0WJzo/bdcTnGUX8+ISvD3RjQnzcCw9r3czv2uLCUOOPsDKUX9FHqcrJlT2QyLTOEQ/qh2y6kAsJsLKCsq/fvKlFqIFMNkeVxSsxWS7jTZCgkhV85G63zpV6SZcqvDhJF/b07ji56J93HM719BZ9aCiQuuD+uePJa5PSvShwxWNJdhUXZl1ESkon3zFjn27JO9RxCz4ScAfqGKVAYcxBa+maxijgkDPO2upgC/nxPqL65QOKm3Cw2Z0sTDnLumvUoC1M7767hoL/3LttQj2T1dUaBxZ81hoZSQ0kl7qTI370vS/io2rbflJKdaW/YzMY8Na1MoDn2Hk4BU59yp3Z6lR7cK/uHIcUKyYCGNfELpQBHJPWh6Vj68a650Kny2dCvZ+uGuKIHOuKxMAfnCBIdEaU5xnAUJhXGjDrbii07YjSBJMGFbDTVUAl97kCQZ6915UEheSWOB/3AUHWUJfi6i8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199018)(5660300002)(7416002)(53546011)(6506007)(26005)(6512007)(186003)(38100700002)(6666004)(83380400001)(107886003)(2616005)(4326008)(8676002)(316002)(66476007)(66556008)(66946007)(31696002)(6916009)(86362001)(8936002)(36756003)(41300700001)(478600001)(6486002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qml5Z0MrOWNuQnhXTXJVSXJzTFVkUnM5TFI3L1duNzM0M0k4Tm5uRXE0SWRl?=
 =?utf-8?B?TmlFdlJqVzZla2NYQVBrdnR5c2E0SXRRTFlNTmFtTFZDN0JiZTFuOWJ0R0dD?=
 =?utf-8?B?T3BzaVdyRUlYamhkY1NhRnNJOS93K3VneU1kUWJkQnRQU0d2R2VRYmZOejdO?=
 =?utf-8?B?ZDZjQ2QvVGNjejlJNFA5QnVFeXBRL0pzVzBNWnI1MFZRd0R0TkI0SHhMSE0v?=
 =?utf-8?B?VTgxejRyQkw4YnNPQ1IyNEVFdE5pZlpHZnZZWkdIRzZ5M2NLMzRUcUFrZXJI?=
 =?utf-8?B?SDN4RTZ3bnVMN1RXQ3YrdGVDS3JJTHdySkRydnJJQzZQNzg1U1NPYXFrbjBa?=
 =?utf-8?B?WjcybHFOUFNEVi9CclRTbEhTNVM4S0lBZU9Zc0tHbG1PV21HNGZTOUszRm9W?=
 =?utf-8?B?eDZZZVRpSUxCQk5mKy9PSFBJUnNwSzBBV3lJdlNEV0sydk83bXh0VURXTmF0?=
 =?utf-8?B?Zml3OTZ3anlteVlIdys3cll2ZUhkRkZFTXFnK0MxZ0pqVHlUazlxejdKVUwv?=
 =?utf-8?B?K1lmQmw1dnRicklkWnhQVW5kblNOem5iWjdQTEg2RHFrRGRSeWhXWmVPUXlB?=
 =?utf-8?B?djNucEdGQkROUXNQczI0QkE5MUYxTitCL0VkTzZOM2NCZW16ZXFqbGhVNmYy?=
 =?utf-8?B?MU1pMXlCOXBCTjUvbTVhaDFoTjViR1FyTW9hbDhjQ2NyOXpxVGJ1bWZwQ2lj?=
 =?utf-8?B?UDNTZFF4WEVyaW1hcVlqTStFaXV3NUVhNUdvZzMzakFJcDlFQklDa2IwRktw?=
 =?utf-8?B?YkVNU2tzMWFLZitTUGpHbDFsTWNZK1pWWTJDcGU2MTd3Ykg0OVdjV0ZXdE03?=
 =?utf-8?B?eS85blgxZHhEODVOYTJjYjZsZXFMcHdSa3JCVGpFS1FmVks1L3ZUTzZaZEt2?=
 =?utf-8?B?SWZyWUF5aXVLMS9QaDhpd0Z3WUxWNEpFUDFVY1NtTlBkdzJNYW5lSnYzVnRR?=
 =?utf-8?B?N1VVVUk2eXpNV0Q5THhEbFcvQ052ZzZsSnQ5QnVFdk5SUVFORTF2aXB5TFVB?=
 =?utf-8?B?Z3c3eXQzVWNzZW1yenlXU21xZmYyRWkyKzQ4ZHlIU2JLaFhNNDBGUzIveUw2?=
 =?utf-8?B?ZERVWE5CcWdmU2ZqUTBXWHVCRzE1Q0YrYVVDN0lsR29ZNXNKYTh6OFBXcFdj?=
 =?utf-8?B?b28yTk8wU05KaVVSNUtzWkd3bGJPYkpManFFNXhjR2JaaWZXOVNFTWQ1Lysr?=
 =?utf-8?B?MTRRbHp3V1NvZkhlVnFBUFBCbWVkRkUzemZzOHdwK1BOalh0S0FhZGdGc2FB?=
 =?utf-8?B?dGNuTjZqSGt4ZjVuTG9vaHpaYW54aUZyZFBaUGRKUkNWUjQxSk5MRWNKQlVz?=
 =?utf-8?B?YVBkdXlCZkZLVGpzRVNwN1Z3aUY3TlR5RVhpV0R1b1l5SWcxZFhHS09WdzdI?=
 =?utf-8?B?VnN5Nm0vYWkrd3c4MlIwMHFSRkxVdUJrUFpmQldtUHhIUUdNN2UzUnBuejE4?=
 =?utf-8?B?ZzRwa29ZYUJLVCs1S3U4QVVoNDdpcEdoRktJclEzQW0zQ2NFb21mY3BxOTRZ?=
 =?utf-8?B?dEtCNllMNVZjY01vVHRHSU9SQm9oQm8zdStlemcxOFdQTUtUdGw4OXMzR2Ji?=
 =?utf-8?B?bSttamF2UjA1ZVFrdkdtZmIzbHRCZ1p6ZS96YnhvaWF6dE1uaEx0Y2FXVERk?=
 =?utf-8?B?ejRPZCtQT0N2cWlSN3puWnVXR3k0Uk53bXJpQTI3OFVFQzhhN0ZramtvbXBK?=
 =?utf-8?B?bjk4WWRmTytHaGMxN1ZQUUczaTR0cTFuQldId2swaGZqSkk3WUZwajhod1lo?=
 =?utf-8?B?UW9mejVwaENuc0J1ZTZXWlZwbnM1QkEzemJNblJCZ3k4WENRM242ZEl3dFFl?=
 =?utf-8?B?ZXEvVjJ0RWNiTVFDUHlERlFQTjhTeG9TczE2c1VYN3lPM2JTVHo3eVNTYnN3?=
 =?utf-8?B?ekdHQ3Fzb3pTOFdqd3Q3V1J0Mk9NVGY3N1hJbndINXFXdHR4QUova0V0TGxz?=
 =?utf-8?B?RjlzV1ExcE92ZGZMeWlvMUxralpZbjhFdWk2VStTMmplRnMzT0NkR29raS9S?=
 =?utf-8?B?Qml2ZWVhaTBWSnQ3Z0JFNjYvU09seXhDQzFGVnBKVk1wMjVZajdYRlZtWHNu?=
 =?utf-8?B?cnVXaEVDNEVIbDNCOUlacGcweUJXTDJtM05sUjdrUlh0OGM1RTNhQ1ZIN3px?=
 =?utf-8?B?UGVGWGRuTEFrVUZFTWNXRllPNHQ2YmhJaWFBTEVpTEZxaDdzTFBJMTk0YllL?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520a0dda-f60c-446d-b4be-08db09cee7b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:20:46.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9/T0p3fkwCkyVcM8p0ZMhMV49RzurCYJBpxtT2hgVyzGzt3ZW1DN8ZYSCCaadKvXx01tAgQqx42ZvAEnh/p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/8/2023 5:14 PM, Thierry Reding wrote:
> On Wed, Feb 08, 2023 at 04:46:42PM +0530, Manikanta Maddireddy wrote:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> Currently we are considering the first irq as the PCI interrupt pin,
>> but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).
>>
>> Only parse the PCI interrupt pin when the irq is unnamed or named as
>> "pci".
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>
>> Changes in v14:
>> Address Rob's comment on using of_property_match_string().
>>
>> Changes in v13: None
>> Changes in v12: None
>> Changes in v11:
>> Address Brian's comments.
>>
>> Changes in v10: None
>> Changes in v9: None
>> Changes in v8: None
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/pci/of.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 196834ed44fe..ff897c40ed71 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -429,9 +429,17 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>   	 */
>>   	dn = pci_device_to_OF_node(pdev);
>>   	if (dn) {
>> -		rc = of_irq_parse_one(dn, 0, out_irq);
>> -		if (!rc)
>> -			return rc;
>> +		int index = 0;
> No need to initialize to 0 here since you're assigning to it immediately
> below.
>
> Otherwise, looks good, so with that initialization dropped, this is:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
Ack, I will take care of it next version.

Manikanta
