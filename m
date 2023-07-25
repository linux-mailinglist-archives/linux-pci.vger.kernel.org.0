Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F5760E7C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjGYJWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGYJV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 05:21:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC21BCF;
        Tue, 25 Jul 2023 02:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDakPLYO8AXtrb7K3TO/eIj9qolFcrUfoF7DGvOdDRu2DwlQ9+I3DiiDJYm3G9P0/ndcwZoDh18OA6RFJ4SsXcMGeCGwfVQXO/ZRTwJCyjJ1SLhOuS5rsjtsoT8NDzk+5X6jOfktWCA4LcK6tdgNdNgcWNRMYdsXIjXj9btk2v/CBq1/VLgisLYp/+YLsdj4l3oNDnObRvrjb98CkOMbeXVeu03f7Sz8p3xKPhFqWJO2Nkw/0yId/JuwVxxoJnFs18C6K6w+E7DY0HWVJd8ZvsI01ZFFvEOHwnk/BugWpdBOa2jFEE4Q5nHCa/UZIdPpdB114hPxyhR14O4Sv/S6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBxxsK//6GMxNlazR3AGfWVV3BI3nkDV5COxbLcv2+k=;
 b=hXNsQgOnkPjVA17YovJxY39WIlD3ZuAcKb01PfvXBZXyUWwK61gYEUqERmDPAiZmeUZTlQaXEfjvfl+1Y8E7AitHuL0xeY2SLbssVWB4Piok7uUqubrNn/JQZVHgkoWU0TVOZenmZsAWKflj9f+gtqqEHr9ggKrrDWkONUMy7dZbXhUh0uNoqdFdNwYYZ1NK6SyaXUldppzb7GR09e9grn3gszrMglhcZJPVV0XYa40Oq0U0ipJWEqX7pi18ulNlDb1dYfEGrio8seX0L8oMQj1oyt6alrCXMSuytYMEC/j+bOfnHb0nV6da/0ECjFFBZ5xFSt9ct+NSZudK7ZqEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBxxsK//6GMxNlazR3AGfWVV3BI3nkDV5COxbLcv2+k=;
 b=YBk1USHev8sVypyQdWiFdLN0HEjN9tQAZrOKnUStk7RZCQoaefLc88Jcu+RJytMThEJOtglm0vzB7MgUTGsmlTyKIVXqNSggmHSiNqOZijGCTIkd0R3AC/f2M7Ra/pFnejsdZATNisxPdNI88HMCcFXjRuyWcOJjinIQ22RvEv5u0QaA1sgodjCJueX0zeH9I4NTEPxYgzSQ6Azp/s1nI/R0XsgmMemEcymb2cEpPlSTw/pC6hKkqyMmm/ovEpEUdPSE4NgmMYFYt8lPe/8QKAOwmvfH9+QTE6arTGOCb5W+jMWCwzMSqrJ+2dOu10Hrrq9Gr395ACuJt3vum4WYZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:21:23 +0000
Received: from DM6PR12MB2907.namprd12.prod.outlook.com
 ([fe80::8912:729e:2027:9d21]) by DM6PR12MB2907.namprd12.prod.outlook.com
 ([fe80::8912:729e:2027:9d21%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 09:21:23 +0000
Message-ID: <770da5a3-ea02-ce87-8515-beb246082de8@nvidia.com>
Date:   Tue, 25 Jul 2023 14:51:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230608093652.1409485-1-vidyas@nvidia.com>
 <20230725075159.GB22139@thinkpad>
 <815d102d-be0c-8e5d-ac12-1500d90628da@nvidia.com>
 <20230725083030.GC22139@thinkpad>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230725083030.GC22139@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::19) To DM6PR12MB2907.namprd12.prod.outlook.com
 (2603:10b6:5:183::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2907:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac58d2f-cc87-461a-7cb5-08db8cf08385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVyYMaNVWrEuwjiH8BE7GFnjMa+KkhE+q3zi98IZ9B6r8bCz+GYdAmkAia/mnGQVFBRK41tFC0pba8oqxIkFL/IankUBW916AgJ/x59+mwDp/ys2rJ38hYaaVkcjQHIgbG1HT4g33oVJhc4l8GnO2Mdbe9fxkwTa3p2QFLWnWMUjpfiWOToztrt+p5YYJQsFwR/0fHIyxbUyyEUQJfjUA2+Z12Q+Dog9JdIF25dup8DIQG4LV+4VbEJprtsv2Tn/Ut9RDx32EdQvkRMYzdhgVWyQ+U0KBBWlRjmGh+QK/ADz1WkMjZsVm8iXqkID5sCrwucviII8q299GESZdfq+JGlLOpScm3yn4y55I9TuyFjaGsy1k4w6bRaa4y5hNVdpxauAW7TteEaZFLeVxTRksbM0WV7KMYCaynglAtKZ7w73LdJ9GL5NKuxvVwHjvzuJAo0Jp5n7U8xKIFP0UX5OiDoTwb7h8LEjm6bBv8nwBH/K5L5Nj1fjnkk7YpL+Hu902AiRgpXTsu4qsLJFByn88SLtG0EhiDi1ZnHYaq+ubWYX+pVr8bZvFH8D5cw/v4Ba5VDmbA1FaqBASWvNUNBfnCikWKPcmj2WXZhBvlxkHp54FLD7Qx3uQwE04XqnYhPLS5quH7FYYaj9Rs0MPi++jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2907.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(86362001)(36756003)(31696002)(31686004)(2906002)(478600001)(38100700002)(26005)(186003)(2616005)(6506007)(53546011)(41300700001)(5660300002)(6666004)(6512007)(6486002)(7416002)(8676002)(66476007)(66556008)(316002)(66946007)(83380400001)(4326008)(6916009)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0Q4MmxnYmtiK2Nidm5TekhnRmZCS2lTdnBKNGhqUUhsaDBMeWtNTTVNMTc4?=
 =?utf-8?B?Y0U5ZjZnSHJyVVJlblkrWWZrTjNGbStjT1Q1cE0rU0ZvdjZRUkI4aGdwZFpv?=
 =?utf-8?B?eERxNHA3c1k3S3Rob0pibUpPUWpsdnFsbkZCRTNDNDQwMWM2NUxYVWQ1Y3oy?=
 =?utf-8?B?YkhMc2FBVDJvU05nd0ZwZjZRMEVkY3ZXTzNuenpWMHYvcDhsRkxIV25vUHk2?=
 =?utf-8?B?M1BEYnd5Z01odDJTaWFQYjFKendic1VwWlMzNVFLMmJLVGl2YVFLQ25LVVpK?=
 =?utf-8?B?dWNiek1jb3lnMlpkVTgrOTVNNDUvY0RSd3BMWUt1NGRNUWNrUmQzNmVzUjF3?=
 =?utf-8?B?eWREUEw2dEsyL2oxRERqdGd4NXE3UnB4QnVkc0NNL3N6bHVONm9LMjRxMUdz?=
 =?utf-8?B?elVDVVJtM0cwVUt1YXpzaHppM1BYUDNnNDNTQ3JTcWNla3luZUNuclIzNDNG?=
 =?utf-8?B?bzV2Q1pEbS9sOXdnUDZRWm43QmlJNDlxY0w4bWdROUlNcFpFZVhiU2lSalVI?=
 =?utf-8?B?cnUwMGNIMGMvUm02dldhMG96QjU3Z0liZERHd0VYNmZCMi90UGhJRXA4b3Bx?=
 =?utf-8?B?d3RFTlVJa2JNclFwc1F6K2RZYzYxNGVyOTEzb28ySXBBS2J5aHFLRDNGUkZu?=
 =?utf-8?B?OVJiRXR3bHcxWHd3b1FrdEpRV0xvNzN1QTNuVGtRaC84NkZ1WUtQbEh3bld3?=
 =?utf-8?B?M3U2MUZOczZmZHErMVplMTlxQzRiZWdXWndGUytPVUh6by80cDltcUVUTTBu?=
 =?utf-8?B?QmhUYjczdWQ4ZUtnTTBrdGVoeTluZ3ppRWJuUi9pdXFHcHRTWmdEOFlQbzZB?=
 =?utf-8?B?UjNpeFFJcFVoSnpRc0hGYSsvelgvM21GSTdTdXh1U1dJLzF4aXVJOVFvVUVi?=
 =?utf-8?B?MUd3RE9INGUzT0JpMHR4RTV0UlFKWlZkaCtOS004SWY1UFFPcnhMSVBpRU5p?=
 =?utf-8?B?aUQ0RXJKLzd0aFZWVGoreGtBN0UzNG03anBnRXVaZjR6dHN1Umx0RVV5V1JR?=
 =?utf-8?B?TDVGNmxwaUdXNTg3bUpKREpYSXg5bXU4UWpScXNLVHNpeW5WVWR2ZjdIV2Uv?=
 =?utf-8?B?RStEMWNUNlUzUTEvdGw4Q3FYUjV5Z2JmSzB4MFJQMEdYZE1oYjEzYjZIVENP?=
 =?utf-8?B?K21hMVEzY1czOXN0ZStPdXVVVkFjemwvMWpXRHhyb296NVV6SmRBVVBFZTV0?=
 =?utf-8?B?NWM3UzJGZW5TVHBzTFZobEVPNkhsOE92REdUak5ySFN0bGlyU1Y1T3pHWGY5?=
 =?utf-8?B?OWlmaEZsajNGMnJscTBlNDJ0czBxMmViS1VEeXNDVit0UWFsNlRwQURLeGll?=
 =?utf-8?B?MFRKY2pBNWpkeGJEYkhUOXhLQW95aE41aXRJZzU3S3pxd2pobHhHN1RSSE1F?=
 =?utf-8?B?dUxPcnJzMnRRZmlpQXNwNzRtSTc3bnladm9tM2lhdXpFQVZzZUxZWVdUbWRi?=
 =?utf-8?B?SG9JZzZXY3pQTzQ3N21kYzdHK3UrZE1rV2xjNUJCNWV0ejVGMnI3YjlycGNn?=
 =?utf-8?B?MWFUaE1zaDRWQWU5ZVdpN2c3YUU3UisvbHZuT2xndzEvZllFV2hueXlxMkJw?=
 =?utf-8?B?WFRPSkI3eUtyUFJLalpDRnFFOHFCZ05menhUVjRvTTg1RnBBTGptbEU4Z3Jx?=
 =?utf-8?B?dzBnSFNTS3dTZWFUMnQ2bkFYVHJEMTlNbUh3YS91eGFDaExsTnlMcEQ5dk1q?=
 =?utf-8?B?ZHpmOUJRWWp5MDNPRHozNldHM1RHemQ0cWNwVGlxVkxVTmw2Q0R2akllNWlw?=
 =?utf-8?B?OEF2YTJkaFZ3dnhjYlZpTS9wR0VKb3B0MU9OZSs1OE00QUdhTThYTkdabkg1?=
 =?utf-8?B?T3FaSS9lMHk2KzdPOHVZa3FzYTNJdTQ2YzBPRGhsNVdUWmVJSG1Nb0laU0Rx?=
 =?utf-8?B?S2xQY3pPSElWMnJOb09VL0tGTVg5MFBUa1hEcXhCM21keXlEMCtXQjF6ZzR3?=
 =?utf-8?B?TDZsK3JtQlhsN0NQRmlnSm82QnFKR1Z4VjFuT1JwRXZkUk54YkM4d0V1b1F1?=
 =?utf-8?B?a0N2b0doTEN1SjlYWUFzak5CaEZRSDdzTlBIQm81dm05cE1yd0YrLzVVYWw1?=
 =?utf-8?B?VG41cDE2emRlVTgxK3YyaktKVFlKMlRxQzdUcDhxekVpOEZJRG9RVEtRNmcz?=
 =?utf-8?Q?dqJiNLMB9bZqK1HqZ8NmG67NF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac58d2f-cc87-461a-7cb5-08db8cf08385
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2907.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 09:21:23.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqctOBjUjbCPEhOc7SIC4G9dlUa+LhNSIliU9ZzMHDvE7Xb9ucISZhpGBPbJgGffUbkTbs6Bn0qPgQtc1IvBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/25/2023 2:00 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Jul 25, 2023 at 01:49:35PM +0530, Vidya Sagar wrote:
>>
>>
>> On 7/25/2023 1:21 PM, Manivannan Sadhasivam wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
>>>> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
>>>> support for 256 Byte payload")
>>>>
>>>> Consider a PCIe hierarchy with a PCIe switch and a device connected
>>>> downstream of the switch that has support for MPS which is the minimum
>>>> in the hierarchy, and root port programmed with an MPS in its DevCtl
>>>> register that is greater than the minimum. In this scenario, the default
>>>> bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
>>>> configure the MPS settings in the hierarchy correctly resulting in the
>>>> device with support for minimum MPS in the hierarchy receiving the TLPs
>>>> of size more than that. Although this can be addresed by appending
>>>> "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
>>>> good idea to always have this commandline argument even for the basic
>>>> functionality to work.
>>>> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
>>>> Byte payload") avoids this requirement and ensures that the basic
>>>> functionality of the devices irrespective of the hierarchy and the MPS of
>>>> the devices in the hierarchy.
>>>> To reap the benefits of having support for higher MPS, optionally, one can
>>>> always append the kernel command line with "pci=pcie_bus_perf".
>>>>
>>>> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>
>>> I know that this patch is merged. But I happen to test a similar change on Qcom
>>> platform during a patch review and found that the PCI core changes MPS to 128
>>> when a 128byte supported device is found:
>>>
>>> [    3.174290] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 128)
>>> [    3.186538] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
>>>
>>> This was just randomly tested on a platform whose Root port DEVCAP was 128, but
>>> it shouldn't matter. And I didn't change the default bus configuration.
>>>
>>> Wondering how you ended up facing issues with it.
>>
>> If the endpiont device that has support only for 128byte MPS is connected
>> directly to the root port, then, I agree that the PCIe sub-system takes care
>> of changing the MPS to the common lowest MPS, but if the endpoint device is
>> connected behind a PCIe switch, then the PCIe subsystem doesn't configure
>> the MPS properly.
>>
> 
> Ah, I missed the fact that your issue only happens with a PCIe switch. But
> shouldn't this be fixed in the PCI core instead?
> 
> I mean, PCI core should use 128byte in your case for Root port unless it is not
> allowed in the spec (which I doubt).
well, if the RP's DevCtl is set to 256MPS by default, then, the core 
wouldn't do it automatically unless either 'pcie_bus_safe' or 
'pcie_bus_perf' is passed.


> 
> - Mani
> 
>> -Vidya Sagar
>>
>>>
>>> - Mani
>>>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-tegra194.c | 13 -------------
>>>>    1 file changed, 13 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> index 4fdadc7b045f..877d81b13334 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> @@ -892,7 +892,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>>>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>         struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>>>>         u32 val;
>>>> -     u16 val_16;
>>>>
>>>>         pp->bridge->ops = &tegra_pci_ops;
>>>>
>>>> @@ -900,11 +899,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>>>                 pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>>>>                                                               PCI_CAP_ID_EXP);
>>>>
>>>> -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
>>>> -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>> -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>>>> -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>>>> -
>>>>         val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
>>>>         val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
>>>>         dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
>>>> @@ -1756,7 +1750,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>>>         struct device *dev = pcie->dev;
>>>>         u32 val;
>>>>         int ret;
>>>> -     u16 val_16;
>>>>
>>>>         if (pcie->ep_state == EP_STATE_ENABLED)
>>>>                 return;
>>>> @@ -1887,11 +1880,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>>>         pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>>>>                                                       PCI_CAP_ID_EXP);
>>>>
>>>> -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
>>>> -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>> -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>>>> -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>>>> -
>>>>         /* Clear Slot Clock Configuration bit if SRNS configuration */
>>>>         if (pcie->enable_srns) {
>>>>                 val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
>>>> @@ -1900,7 +1888,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>>>                 dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
>>>>                                    val_16);
>>>>         }
>>>> -
>>>>         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>>>>
>>>>         val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>>>> --
>>>> 2.25.1
>>>>
>>>
>>> --
>>> மணிவண்ணன் சதாசிவம்
> 
> --
> மணிவண்ணன் சதாசிவம்
