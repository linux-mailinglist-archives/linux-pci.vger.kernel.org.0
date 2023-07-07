Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BED74AC16
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 09:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGGHjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 03:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGGHjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 03:39:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7779F1FE5;
        Fri,  7 Jul 2023 00:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUGQPTj2fRdSIpF92u1V3Ri77i9wMmu1HFCdSPCtXVGWQfBk5iUsRpECOPGR3x96CsGsyn0vihmsZ6AuFL0T/gRmEZhAzCkI/NcDOD1Msq04utzvFNChPfGEcWkRObkdK0LvaYxNlA8hrw/+lcBOGbgEXlIqHfJPSIHTkJt2mMZE82If88DK5v2VXjPZhvoqpdbr5QVrKHG8KNyjpMmh4D6VSPiVpzLUQsHA/aPaTfuqhumTsimOFAOlHErGw8oRYxkaP4Qwu6tiZA2oM3839AVq9il75NWXFVXW4/VUuzz0CoZHJVbr8N3TFHUZA+jkPsoRoVwdbKibKgSMc6yY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB4xkOOzx8zrKUMP0qhs3BRyj8jh1GopQk+q+Rr9nrs=;
 b=UqJNjPFnWyhglGwK9XdYr62Z48zmyDL7/yxaC8baFxIN34fkvDEYV/Nl2IQCYPFSlxXX5YRNapuBHYG5BmN6SxTrkOLlSnaO2Dlh1CsgfbJ0bi2bAwyv/yVx7FS5SKZBmI5APN+9dLfRDRizfoea0KjTgy5qRFv7dgqMEiFG7R6wcmxSRp4sGuobFxXFhCOowY2dNbATGfxuB5K1bWtwPLrJjcbgy3E5ICkaElnk9vPDpBIKB/oIUFlfMWOMcLj/oRxTp+fC5mCnoj1yMNPpa8DKNmh9INLj61kkdG9pB06cx24vIfoOG8yHIuQEqcZ1g1Tt49y+WkgbFxP+qPBq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB4xkOOzx8zrKUMP0qhs3BRyj8jh1GopQk+q+Rr9nrs=;
 b=PeaWXC0WdaMg7xd5cBF5XaO5iIs4vny6qJOvpu4K9jqJCLUO+Hc6o2cPJliXk7OvO6eRbwrTfwQmSx/YxVYsbN9vFktm7pIxWI25XqfLoGXSyZzoCiEJaUveKEZgJmLxp65zSBSXm92HzsBITZmPOSXrjwh1pJWFWdv6kZofZxJCqhz73DIS369q/tmTAYKJmDw7D5yFvdsjPxga6GR60et1a5PDW4FwUzSNeTi3xEfIP4e8zNg0msuaspFyjWhvRJTNEdYneYOwsvvgwAoznSvLBKcHEWbh+HwSOpYAEezEErxz4acwipOb43awf6DoR5ndckc85OPj/xzAUBon/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4228.apcprd06.prod.outlook.com (2603:1096:820:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 07:39:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:39:18 +0000
Message-ID: <5f3fb325-cecd-5a98-656d-c4fbe5e9e03b@vivo.com>
Date:   Fri, 7 Jul 2023 15:39:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/4] PCI: v3-semi: Use
 devm_platform_get_and_ioremap_resource()
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
References: <20230706092047.18599-1-frank.li@vivo.com>
 <20230706092047.18599-3-frank.li@vivo.com>
 <20230706185511.GA3380331@rocinante>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230706185511.GA3380331@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: a31b5625-7f5e-4f5c-3a8c-08db7ebd4595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbUWiHgTPsMd66mV2Z+e3l5tZ8qNAjhBRJTp3C2cvhWF8+3ZO1JnIEPg0iwZS8NlJJsxAdFvUqPIw4PNJQ+ZgZcaep7xff2XfLZ8aGODKtWZW4yjKp976c9xfXqMSbetXfqz0XvQFSS55plELcvDCPDXfvIm9N+AeWra6dNeyjhma3Kn18b/yzsc0TDWqg13acSHdaBX8ccWU/NdnI44ukiLD3Xqeljv2Pd5Ilnc72W16ptVhG1w5gx/z7f+jYvrsp15XeDxcHxPeVFRNH8sbP7Kf4JHfkvWQyarB0p6xwzPcWQaOILKL4EvMOppNMAvdrQ8E874nYtfjuA8drUAFWIigxocHqdqEPeCPBAxSXg3+RETeljE57DHj4EOLW8TJuMtIa8zhUY3paphuR2Q72ELelAF2OUu3b9WsC1JBK0UUxgQlUuh/qvHL4DxYZYmq+OpgUqJdsAAvcWxDw7IkwHYbQEfRSaTvi6sjwFVnSCuLUJJNY+Xa9BAVNOqxceez0XOH1MdCBl0fhH8DeVvFJz2FbBUPEV2T6BXotIM1AM7WH4CWQxqRxMhrF35FOCvm/uTNm/25/mXss1FxSzXqrHZUlCscktbzHc9q5sHkg3sABVR9MlKWKsJcft7buHRd4p87H5RY0RXbMsonQippB4yqXmCarCruZaeOORKeb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(966005)(6512007)(6666004)(52116002)(6486002)(54906003)(478600001)(53546011)(186003)(26005)(6506007)(2906002)(6916009)(66476007)(66946007)(4326008)(66556008)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(38350700002)(36756003)(316002)(86362001)(31696002)(83380400001)(66574015)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2EyTnhrVzcvRzQwd2pFR3ZhMytPbzk5MTdaaHB6eG1KZU92NG5FaEk5ZHVr?=
 =?utf-8?B?Y0d3QlNDMjVDVUlPMjVmT1JaWHBtQURqL1VHaGdPbS9BUTVSeDJnQlhOYlNw?=
 =?utf-8?B?WWplSUU0K2hRNGxUYy95WEgyRDFZNjdJRTQ0U0FnMmNteGc3QStlMXlPaTFm?=
 =?utf-8?B?ZDh5WXl6QS8vUkg3NHB3OFNjMTNMWDB3V1NyYVBEeWU5ZWRSOVZRUHlJa2xn?=
 =?utf-8?B?VEFhb3FCSE5LZys5aEJ6YnNCdGhra3ZQN2gwNzhmSzV1TG5CL0NTVnQ3d3VJ?=
 =?utf-8?B?VGs0NWlrbkJTNFZ1SkdnQ3hYb2NIOElxaTBMQXJYR2k3TTllVkdzRFdMTEJZ?=
 =?utf-8?B?cmFpcSt1RUlmVTdYc3JFd216U09ZcVlBdy95NlpNRWMwcFdITnhnK2NoamZw?=
 =?utf-8?B?Yis2TGNXd3lLWDZTRkFrVmxoV0c5dTJZbi9tN01kZS9pQWdTV2ZXcnpZVDlE?=
 =?utf-8?B?ZVcxQ1NiY3BodWV4UVRoWUhYSEVrTXVwQmM0MlJ6N0VudnVSZ053Tk4vditk?=
 =?utf-8?B?QWJkalJSOU9mOWFwL3Vra0pYVitGOGVyZGdNKzJaUWJCVmMyRlo5eWN6elNW?=
 =?utf-8?B?RG5McVJsZFdXR2dBRU9VNVp6QlgveUJ0aERCaGNNa0dtRy85Mktia3dhNVdt?=
 =?utf-8?B?ZE05d1Q5L0JIemdpaUVLa3lYTFZCajd5VSt3dDFJeUlDV0V5YWVCVFp5YkQ1?=
 =?utf-8?B?cm1DV3BXUk1ERHN1aXo1Sm9hSGpmMUk3UU9WUXJWQ1F2ejNyWTV2WlhLWmxQ?=
 =?utf-8?B?dERLN2dnM0ZMZERTU2VkTnI2K1puZWQwZGFuU2JhRjhkVGdZS0NmdVgvbG8y?=
 =?utf-8?B?Mm5YTGxKNHlZSzZCMkZqdnhIZEYrNHR4V3pIZmpnMmQvTUFxV0tZU2ZVTWdp?=
 =?utf-8?B?eUxoZ3dqOTBQeEFIa1M4Vy9iVnF5NHAyaGVGdm02aVk5U3Q5VW81VmRLeWNw?=
 =?utf-8?B?bjI4Q29rTTBhOEV5OGVkcXNqcmM4M3l5ajMxQzhqMUlmTHNRM1cyaU11MnNI?=
 =?utf-8?B?WkV4RDB1ZFFaWmx6OGk0aXMxZm5sWUVvbWtXTkUyUTZwbGNESjdST2w0OEk4?=
 =?utf-8?B?eFFVaVlsYzJhYnI5Y3VHcjlTaEtVVmFlUjE0WXZQaHkwdDhlU29yY0VMUHR6?=
 =?utf-8?B?a1E0MFdsOFJYTFd4T0RlZ1ZYZ3FocGIzTkh6SmdQN0pnZ3ZwOUs4cEozdzNa?=
 =?utf-8?B?OEJLWUF0cGM4SjY5TXh4SzZPUW1ja0gyclhxNENGWjVJMFhic2I0eEE5RmJp?=
 =?utf-8?B?bytGb3R1TXRhM1RZNWRIMXRFV0VWN3R2SGhEYkljQ0wvYWJSWVAvM0V6b1Ju?=
 =?utf-8?B?VHdOT2h2TnhpUGE0MmUwdGlSSXZnbTJaOHRwMmE5cGQ0ZkJ6VDFEMHBRNzVp?=
 =?utf-8?B?NEZMQTB0aktrLzRETldwMVI5OCtJVUZLZStKOGFKVloyR2oxWitjS3RMTjJm?=
 =?utf-8?B?VmVaUTBXcVhQUmk4QUFEUkVYdHdYa3E5cVZlaXBFUnpvQkE5Q2pyVUZ2R0tQ?=
 =?utf-8?B?SjFkTG5FWG5oUzBOS00yTUxLbTdnVlhtdXU4T0NSZis3VE5HUDdZQjYyUkNs?=
 =?utf-8?B?N2JJYnJPZzE1dHNnMGc4cTcwYitZbnFTSUc5TzFMUGx4eUozM1d4b09EdGJN?=
 =?utf-8?B?eW9aSnEray9JdGVHRzhTTVoxU0l4REJJOUpQd0tudmx3SEZjcTArM1RXRldm?=
 =?utf-8?B?MmZrQVpjSkJ1NHBOellyRUhZWDU0QVhDNkdkc1ZaYmVhRkM1V0w5dHpPcVJz?=
 =?utf-8?B?VllhdXVGcDc3d01IRW8rOTlqajYzMlF5dlZSdXNOVkFqS0dxbmZud0NlUlI1?=
 =?utf-8?B?eEZKbzdzbFdFbElWQ3Q5b1ExUDFYQUd4ZXU2ZFVPL1F2aGkwWitONmNFZ1dN?=
 =?utf-8?B?SU83bFBjaTR6aTlOWHNiUWNTQXdVSUFMNHh2L24rQnUvVmI2dGcwd29OTzJ3?=
 =?utf-8?B?aFVnTVJXWCswYkhqRE9uYTZ1ejF0Z2dzQkoyVi9yWmoyT1ArakI2Nm4rZ3Fv?=
 =?utf-8?B?cFp3M2YwdlNsQXY3WDBuYXl6N2VZTG5YZnZwK2Q5T3l2aXVLa0ZOOXlZUTNV?=
 =?utf-8?B?eGd0OUUrRmJpYjV3dGI0bUdGa1hGajh6WCtoWmVKck1xVVY3OVJ6aC9hVER2?=
 =?utf-8?Q?k+NgrKBYrC0DIlEdP3GVFK4pN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31b5625-7f5e-4f5c-3a8c-08db7ebd4595
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:39:18.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QppljdE5mc2zjaUb2cXUrtn/DgmXPDSCNEl5Y9mF8FZOAq5ObBhO93kzo1ln45UPDduOitTiHOIDvAXztAKv2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4228
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/7/7 2:55, Krzysztof Wilczyński wrote:

> [+Cc Yang]
>
> Hello,
>
>> Convert platform_get_resource(), devm_ioremap_resource() to a single
>> call to devm_platform_get_and_ioremap_resource(), as this is exactly
>> what this function does.
> A very similar series was posted a while ago.  Patches 1, 2 and 4 in this
> series are identical, except for this patch, which adds one more very nice
> refactoring,
>
> The other series:
>
>    https://lore.kernel.org/linux-pci/20230626110226.GA569947@rocinante
>
> What I can do would be to pick this patch and squash it with the other ones
> that are already applied.  I will then attribute both you and Yang Li as
> the authors.  Let me know if this is fine with you, Yangtao and Yang.


Acked-by: Yangtao Li <frank.li@vivo.com>

Thx,
Yangtao


>
> That said...
>
>> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
>> index ca44b0c83d1b..0f993328dba2 100644
>> --- a/drivers/pci/controller/pci-v3-semi.c
>> +++ b/drivers/pci/controller/pci-v3-semi.c
>> @@ -736,8 +736,7 @@ static int v3_pci_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	v3->base = devm_ioremap_resource(dev, regs);
>> +	v3->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> Are you sure about the variable name here? This might be a small copy-and-paste
> mistake that snuck up here.  Have a closer look, or better yet, try to compile
> and test this. :)
>
>> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	v3->config_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> Same as above.
>
>> +	if (IS_ERR(v3->config_base))
>> +		return PTR_ERR(v3->config_base);
>>   	if (resource_size(regs) != SZ_16M) {
>>   		dev_err(dev, "config mem is not 16MB!\n");
>>   		return -EINVAL;
>>   	}
>>   	v3->config_mem = regs->start;
>> -	v3->config_base = devm_ioremap_resource(dev, regs);
>> -	if (IS_ERR(v3->config_base))
>> -		return PTR_ERR(v3->config_base);
> This could be made such that the assignments are together.
>
> 	Krzysztof
