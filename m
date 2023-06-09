Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE9728DC4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFICXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjFICXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 22:23:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F13AAC;
        Thu,  8 Jun 2023 19:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npfo8d0vjOL/gNbEf9o5PehWMvv0atiq82odnUsq8KWWlFq3ZuV4RN9NVaEFryLMj8SWR5T1VBzYs/Cb+AZYUpmhRttKFaE0GoPFkWr96uvDDFv0Ox9RPaG1RLxVBse8ZhpMDHfoxBuh+MZGoGeeVjlVnpgYR63QSXrQXuBeEArWhUxPuJWrdBwFhXWFxUGgvo//2ifCi9xhIhkwH2bT4qgIy4+djpK8KjSKBwtSvdjQsOHwneFVSMYIvrsrdK9axWckEkqCgUV+uMSDoQX3iULSfmT3GtCedIzBeTMqhvalTQYm4wTwAK2Rgei58gxDbuA3nY5GnJlHmDkPlm4Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVlOKnn5HD8JRSCKufll7IGP8BhaoQh8ptau6MHw8xY=;
 b=npxefhMKUIPqFrpFU/W2Q/QHR9QeOL3KVZc51dwPdojk3xipgZiobAHj/mvgAdjME4C+gmhArJ5V0AfnmuSRhftrF2uO/2pByyIvOCXgoVIAinjJo/xdAZOUrgiuNd3VmM8HtS9oVllWQPbOg7qyQJ/Cgye2pbE6nFJ6ZTy0HiHuwEoBybuCFrvLUD9ihQNeIsNAhmpckV6dSU0LP9uB0s9lr+oCrQWYoQL8Q1xJI24DGIHYFFNyDXerzJjLQuCDf4Z2Ee1/o0/9OSM4WuhntFI9ZL1akbkxew68g5sbp1w3z+O6oHHkH+z8xkJuR7xuVCEPmRvsUd82PgQfuIh40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVlOKnn5HD8JRSCKufll7IGP8BhaoQh8ptau6MHw8xY=;
 b=UzI/Jmyunt2iiIQGI5uw+O/UODj3W904N1ec/6F/7zjMojyLQhGDlVR0mtyyjwEutjtiMy/+1GEmiWAXuDHLVlrccv+MvSIykAHjN8y33mmDUunM67E1b5TQ9dSD/UEWaN7vHdI+qOj6wPw0S+ZeKwp7dokoYRslCqnBYCdjniPUNeaCVXwlUpSdHds69p81fi8QkbaavOFnoTGFLMt2lVz4xaUb13VFBcHai4YmwQ84kW8/EQtfxuBdeZEA0KlwApeKw/uv2Y0mN6QDEfjNYXO2tPFgLq23l31fmU8DHjyIBYI+qhtdgUVI97KyeOQ2qSLUPgq142s38vOI0VUA4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 02:23:23 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::17d2:59ae:ccad:5233]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::17d2:59ae:ccad:5233%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 02:23:22 +0000
Message-ID: <5bf550a9-146e-ad51-bbeb-c55b48478f62@nvidia.com>
Date:   Fri, 9 Jun 2023 07:53:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230608163346.GA1204586@bhelgaas>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230608163346.GA1204586@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::6) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3674457c-ea13-4a28-829b-08db68907f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gw0CGx0kf8DnEJG4IiPrscoPBp1DZa+fL3XFgJPCPK+NH1Rq3Mdri9BxQOGpmsF/i9oGmNxBeQwfd3kJwNWWEIZmCypdQyRjuRMS+pKXLIhRyXT5BbfiTvX1BAeLqflx1JhpsLh1lf6l5F3N/MSbJ2BbaZvs/P7Nm1NIHZK7RmhSChNAWxhZxVPJWBu/YIBiUfoToJoeBlMUbudcuBQDt+jTbty1NNcza0g26fYFje/R6hMevj6a1ru9mXfGiI89ZIiM04Irqx2bnhRn+MsT4Njc14jRUjoMHFT5qJRdIjT/rD1Tz2n0YsmyHKEd5+98NPos0wmfHB8VwCP3fitB2D6dzJZfFc4TkERad5JdynbDtCDK7Th2SLV5Zd0E8lz1hjL4PMArGXy/yY+XKJelOiEFV4CDQ8cFaoPvcHc5Gu2m5gE2PZuDrJe6ePxDjUCKSeIbm10Q3SLxpkD4Cswx1x+YaL2GWxDERpS3KHDFmNg0LRmpiK2bGYEHNy+h+NsrQyexqHVvRWjgSiiLvagMYkwnBwd5vnu3eoZABt3XFGmt2GQmekQOmf3gUqkZc8pnr0M4b+xHrgCRpoWlJJfGUc5g4ECq7FyaS+w17dwIseGXPoVSaTjehmvmfYUTFHL8jEOpQw6agEL7vP6US+7XRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(2616005)(53546011)(6512007)(6506007)(26005)(38100700002)(31686004)(41300700001)(6666004)(6486002)(186003)(66476007)(478600001)(66556008)(316002)(4326008)(66946007)(8676002)(5660300002)(6916009)(7416002)(86362001)(31696002)(2906002)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhGci84SXBMbWs2SzVRN3hpMnVuMmZjdmpncXBNeGNpRVY3eFVGZUZPaXBt?=
 =?utf-8?B?RFh5MG42eStIZG5RK2IwTzhBZFg1SzNrUk1ZUUoxSk43d3RlVStSald3RUk3?=
 =?utf-8?B?RGdFcEVQRVpNSGhiMktCZW1CcTd0WFYrdG5EczBOODF4TmhjRnA0Q0dvNkNE?=
 =?utf-8?B?cjYyTDdiazllSUVzSmIvRlU4RGZxNlNuc2QydFltV3NmVkhDazc2dHhlV2h3?=
 =?utf-8?B?WWk2VGVwVnNNUTRVeTBCNDZmR2IvazdWajNHYXBWcFpvVDNhcWY1Z21SaWw4?=
 =?utf-8?B?aStzZEVmeXppY3dvV2szckpvRUlMM0FaWFZLWE5KYW5mYmZWK3drM0h3cVBv?=
 =?utf-8?B?WkpKN0gwZURLdUJwQVgra1hsVUc1RnNZUEozanN2Yy9oS2g5Ymw4N0U0NUpL?=
 =?utf-8?B?NW5GakJSbm1vSjRtdjZwdVlqT2tkU2k2MTgvMnpLNC93cTh0RWgvbk9iMUhC?=
 =?utf-8?B?R3NGeFRoWm5Gcy9OS1ErTStHVERZR3ZyTjdJVHlCOTJlL0dTQjIyUHZ1Q2pP?=
 =?utf-8?B?M0NJeHZyZnBsUmR4bi9SMmhBZHFRNysrN1VsM25lSzc4enlzVlZXMmdIamta?=
 =?utf-8?B?dDdxKzlOMm5YbEttQlV4MDZRVTlGZmxUTE1mTkw1UnphenIxMjNyODRTOEh5?=
 =?utf-8?B?cG0wRE1VWStnTlJWN0ZsdmZyaDhHN1VSWnpZUEdKT051aEQrMktGTGd4YWJV?=
 =?utf-8?B?dlgvVnlXQmFIcDYxYjF6MGJISEZra3hmdGdPTjRTN08xQzlRcml6NUlrZ0Mz?=
 =?utf-8?B?OWJEK2xYZUlFQnMrUTVRRVB2UmVsT1k1amNwbFBSNHB0WXlvRW9DbE9SRXhK?=
 =?utf-8?B?UEpUcmhvbTBmVlFZN0lBVVpzeGx3NTMyZ25iWVNyNHRheVB3Z1l0TVpVK1FF?=
 =?utf-8?B?OFJ4TTMwV09MODIwTVJHemR2SWpOckY0eEk0dkovTE1zOC9HTTNQVTFyaGFm?=
 =?utf-8?B?MnY5azJnNHI3ZnA0Y2R0UXIrcTduM1psNTRPK2NmM285Q1pJNHlZK25zdkRL?=
 =?utf-8?B?bERaQStVdmVTcHYvV1hINVhOanFqZU1MdTRaNnBZZTdzRlJmRTFEckttdWcy?=
 =?utf-8?B?RVFFeEhJVWduVmpLUlhKSE4zck45cXZYT08rREVXZmhBOUgyWWhsVHc4K2s0?=
 =?utf-8?B?emVCekNUakprdVRjNzRJRkRZNjJHRytzNVd1L2lPS1g3SjJvZGc1dlNGRnZk?=
 =?utf-8?B?bzRsL2E0T256UDNUdkZ2MWEwV2tyOWdKSWx4dWs3cXpIVWl6bmVQZDJRdjlJ?=
 =?utf-8?B?aGJYYXVQanJBSFAzUnNIazBUa0w5ZHJvOFgwaU9vMEcrWkhVU3pFc3JKOXZN?=
 =?utf-8?B?QWlvalZhTFVrbkNsRW1adnNGQ0NXWVZPcmlnV1d4NWJhWkpnQWlEVi9mcVo0?=
 =?utf-8?B?Mk9zNytwbWlKcUNnamM5OFlYWlE5bVlSdXNyQ3ZReUNjVWZ0dVNObG1weDRp?=
 =?utf-8?B?dUNYQnpTMXVOYVBGODI3cHE5dVArTS9NVi9Cd2JER0hid082Wlp2UmE2TSt1?=
 =?utf-8?B?Nmx6d2ZEa1NMWmR3Sko1dXZISnROUUdHTGV2NVlBb1N3RG5SUEk3TTFTWm55?=
 =?utf-8?B?M0NxQzlKakFhWng4N3hBR0tCVEtOalFTdXFCKzdSTVRQaXdqdU5LNThqOHov?=
 =?utf-8?B?UHoxR1VEZUluZkR6OWJNTkVtakYzNnpMdVhBTkxzSDduWnYzRkU5RHlJbm1F?=
 =?utf-8?B?anlJQThHTFM2QlFIVENxdFNQV0d0UVUwMkxGeVJkQklFbElNcmZGaks2K01n?=
 =?utf-8?B?Wk5weHUyOFBhQVp3YnNWVWQ2L3A5TFhCYTQvK3lBN01UUlI5RHU5bDNOTHJS?=
 =?utf-8?B?enhPWkljUnpSUzZIbFZSOUJwSHhHVkRWenF4bEQ0K280TTdPakNETmF5Qk01?=
 =?utf-8?B?VEc1Qy8yVmEvdHM4cWx3UUdLVTROa2JRTG9HUHdmdlZJb0JJRXh0Z0FqUVFY?=
 =?utf-8?B?L0VXRUJhenJDZUpuL2FnSDRDWGNaVFNPNW9mM01pczJOQmprSDBzcTJpa24w?=
 =?utf-8?B?T255SG1ZaE9aTFVVLytpT3NlNUxHeWJheDZpTHFoSjhUUmRpZ2l6U1ZtYUc4?=
 =?utf-8?B?RlExK3BMR1o5RXIycGRKYWlsTExZWHJBUWc3RFNLZFhwdDBQNStveG5HUkVT?=
 =?utf-8?Q?tif+5zmyg3mv27rM3WjryDg/w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3674457c-ea13-4a28-829b-08db68907f34
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:23:22.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnEzZyV6VBByscfMaXdfHVbhqgetmxG90KXsSCzwzLAQ6ScXAOCTN6VuYcA6GOLw7yjlt8XzoHV5FU4onxpbOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/2023 10:03 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
>> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
>> support for 256 Byte payload")
>>
>> Consider a PCIe hierarchy with a PCIe switch and a device connected
>> downstream of the switch that has support for MPS which is the minimum
>> in the hierarchy, and root port programmed with an MPS in its DevCtl
>> register that is greater than the minimum. In this scenario, the default
>> bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
>> configure the MPS settings in the hierarchy correctly resulting in the
>> device with support for minimum MPS in the hierarchy receiving the TLPs
>> of size more than that. Although this can be addresed by appending
>> "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
>> good idea to always have this commandline argument even for the basic
>> functionality to work.
>> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
>> Byte payload") avoids this requirement and ensures that the basic
>> functionality of the devices irrespective of the hierarchy and the MPS of
>> the devices in the hierarchy.
>> To reap the benefits of having support for higher MPS, optionally, one can
>> always append the kernel command line with "pci=pcie_bus_perf".
> 
> Please add blank lines between paragraphs and wrap to fill 75 columns.
> Also add a period at the end of the very first sentence.
> 
> s/addresed/addressed/
> 
I'll address your comments in the next patch.

> I guess that without 4fb8e46c1bc4, Linux configured everything with
> 128 byte MPS, and 4fb8e46c1bc4 was intended as an optimization to
> allow 256 byte MPS.
Correct.

> 
> If the Root Port advertises Max_Payload_Size Supported as 256 bytes in
> DevCap, and the PCI core doesn't configure MPS=256 when possible, I'd
> argue that should be fixed in the PCI core without a driver change
> like this.
Well, kernel does configure MPS=256 but only if the 'perf' configuration
option is selected. 'perf' configuration option also changes the MRRS,
to extract the maximum performance. I'm not sure about the reasons for 
not making 'perf' configuration as the default configuration though.
(IIUC, this is what you are coming to, right?)

The current patch which is a revert of an earlier patch is to keep 
things working for different PCIe hierarchies given the default
configuration that kernel is using at the moment.

-Vidya Sagar

> 
> Bjorn
