Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3C58A4D7
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 04:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiHECsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiHECsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 22:48:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2107.outbound.protection.outlook.com [40.107.92.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEFD6FA0A;
        Thu,  4 Aug 2022 19:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE8tiFdJnjonFP0Xwd4DCSOIzDbZcR/AF98YGk6R3Hgb612Vcz9K8sk6V/R0kOd9yo3fn8lOpflnQb9coOTLWyJDmg8ZR8MRpxpX6sM2EqJfN6xL4UISb8LmCvzlNkU5mlrvsb2DKGkNHsRC3hrbINFucPyBBsM8CY0ctVNlMG/R5p+rpgfxD0Uk55THR8G5r67WxOlO80uB80++U98UtkbdwSMsT+KHM0ZZD2z5dcHOR4XBKZ6WVIfA0oIUEN1Bb2yl8b6NZX6rXR04x3CQw/6zVSZwb2N8xm6VkXAPJxlvQix0y8y0fFXSl7zscp0q69Lz/kyKsA80tKZdLSSIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zi36ZjqBVSvTuOehoyM2tQCHa5Ddw31JdSA28+Vm5k=;
 b=UHYaZAiTHEtUdSB01ogFIqS7RD+8Q+YUK/PSHXeYBpxjLMbfwIvxUGq55WYlb5eqGARP8H0PuZR3tObLjEJaI2JPCCeUI01ZnLbFK1M3ncnYX3ciwunSE/pgP7ypigTMWFivfv84BlWnZ5kSoSCUwJn2Gcyd2nqylQnP+B8PoMr9oUrZgp7fYni7TZ809sAlysll1oOEAjHYoJqyppabRWQGe7IixHtsltATLON6+CPbRfxQHJqYiA3WcyCHXY3R+JmAE+lE5li3IqP+tN8+IKDF2ayJhFtDy6epjoh+iZhDaSCR9ZWZvo0+kHbdJaGM39fSXPmnAK4L/q5/8qWsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zi36ZjqBVSvTuOehoyM2tQCHa5Ddw31JdSA28+Vm5k=;
 b=UnxPm+XgU1+zaUq1R1jHGtVEXSjQ9TX8omUxNv5gNFxLDp1awnZIz88p+DzgHD9Vwjf5SbZS8dkws3qqXqaUE6DciL7cP7EYFd/C1clzvNJ9OK00bGORHRlc0DgK+viQtEvsFj2q65jVJ9zYjTUkyzqQ6QNCBg2aJVnfMjZjnKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CY1PR01MB1980.prod.exchangelabs.com (2a01:111:e400:c637::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Fri, 5 Aug 2022 02:48:45 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a%5]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 02:48:45 +0000
Message-ID: <ba920a78-6539-8fd4-91e6-987129a21934@amperemail.onmicrosoft.com>
Date:   Fri, 5 Aug 2022 10:48:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI: update the link for aer-inject git tree
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Huang Shijie <shijie@os.amperecomputing.com>
Cc:     bhelgaas@google.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, darren@os.amperecomputing.com,
        corbet@lwn.net, yangyicong@hisilicon.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220804103008.1960215-1-shijie@os.amperecomputing.com>
 <YuyDdtIC8r8k/QDd@debian.me>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <YuyDdtIC8r8k/QDd@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b222dda-8d0e-46e4-344f-08da768d03dd
X-MS-TrafficTypeDiagnostic: CY1PR01MB1980:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dfc9kgqaOg0odzUqZDisPR+feBMErXV1SmP2/QQJwFfmhKCoD/QfVncKFU5Bk7VGalYgwu8GdTJSqklnF8IxcOwGghuApF/8Csh+k+Ou0wkOBmjMEJTiI01KpFlCWskG5HG9vtgCcJoH72uwdWO5nWLGP5sbpPEV2SvHm3wsJCWKGC4mQAnqQ7V4L4VVwnDmRJNcZQUlte9jcf2dHbzM7jWw7OngiJm83isZSy/76Fp0R6v0+Xo7BJXrEVtkxoenC/9k5dqV6EvQb+4vsuPg7GWGbNwCJWEuM4J4+4MWRpa1gB2NtmMPM+L8XL0THDD2BKxyqA9IwyXUkU2Hyf/y3DRNa3CYvailf5ANdO+8KvbFtzQRs4RmltK9yLzY+MwSzbkVnUyBjzNiOsjM7uA1QUie+mjV7/CQ1jNMpIulTYrBW/QsjjrbuTVyYKjPOq9gXoTB+wPIIEfAaWrvaypdjUd9FE95TpFjLqGfsfd0PR1NSpzWDLYemg6ic8mSR9bTpjCtFb9ZYQG74kV7oPhMeFjHUPE5807JAx2uWHgzHHDpVZV5SNHyPub++3uOja40ssPskPMyj2xK56mlUbQ9BhhlyuWzlFDEO8iMu+R8K3uv1Y9HKiCYwvXj1geZJCLe1w5GSz+bXQu9JTg/My/ks78Dpx5rm+nypDV4AC16B9ZtyI0eslhsAzQam/1EvP4wesN5tuqQYkGfhXaAHMUOMv1D5Fg+JUmpEcFdb1c5dgQVPY99fn4tD7qOvdPOqb1KljfIZT4XRG/by0nV5PNDu4VlF4Z3aTZVOKBvB1CPGPwbrMtCMO+Dt/6xeUa47wXFR1qTNWOx7xGe4Z7L+Fi4hItzM7LGXsjeqYeKmt5kuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39850400004)(376002)(346002)(4744005)(966005)(5660300002)(8936002)(6486002)(15650500001)(316002)(110136005)(478600001)(31686004)(66476007)(4326008)(8676002)(66556008)(66946007)(2616005)(52116002)(26005)(6506007)(41300700001)(186003)(42882007)(2906002)(6666004)(83380400001)(31696002)(38100700002)(83170400001)(38350700002)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3QzTysyVFk4ZFNDaHc4WHZ1U290NnZTSDFNSDNTOUlZSlEraWczOHFBN2ho?=
 =?utf-8?B?MkZSSDdWM3pPanFGaStlNFh1cU9ON0g4bEk1NU4xNmtXYUlsMEVGVlN3SG9B?=
 =?utf-8?B?Nko5MDhxYlJTS1pVbUNKQXZ3R3pDSmNSamQwRjVvWnVvaGMvS3lETW11TEVz?=
 =?utf-8?B?enpmQm1FbU05WkJpeTNpQVlvNjRrRW1rVGp2ZldQL20wV0QybVNxRmtxNFZz?=
 =?utf-8?B?RlE4YUk1Mk1Kalk3ZUNJaG5TZjBCVVVEaDRKemF0Q2crMHpXaEt2SCtyTDli?=
 =?utf-8?B?VXczSzBlOCtyRjJrakhNMkdSWXhUT2NrYmhveUpyVVNvTnF6bzJYa0dvZlJS?=
 =?utf-8?B?SDYrakZycUNocEtCV0FwTjhYMEVKY0lCVjFDdXBQOVRMWUc0RlZqTHExT1dW?=
 =?utf-8?B?ZmZ4Q05xUndGT1QwUTJJaDJYWHBOanRoL2NVVkhoUE95WnZCY3YyL2tkWE9K?=
 =?utf-8?B?T2VkZGdiZENOWmUzbU5Ua0VKcGc5Z1JzV1hPOEZzRHdKb2hrbzFBdWE5R09H?=
 =?utf-8?B?enE2SXVCVExsTlN6eW43cEd6QzloRDNhY3MwanJzb3ArUW5KMmVuU1JUWTg3?=
 =?utf-8?B?K1g5azcxTGQwVHhxWTh1YTJiSzFTQmcvSENhZ1pTdVBSWjhLdTNkTkd5Ry9y?=
 =?utf-8?B?VEF0NDVBZFMybDJPWTN5S2ZUTGxVZ0p6KzJoWXBIa2xDVktGcmdlaWJ2dVVO?=
 =?utf-8?B?VlMwN2Z1UVluOFZmY0RjZXcySFJIVVZEdlBCWk5iS09HdFZETlhiZ2w5WXY3?=
 =?utf-8?B?MWJDWklBU085bXVsSlJVZk5aelhRK0xuWG4vSUttMy9yTVFmRTlyRDhzejNP?=
 =?utf-8?B?L3B2TUViTFJRTUJZWlNHb3VZQStyTHhUVGx6RHFKVjlSWENhZDBCK3lXSURl?=
 =?utf-8?B?bUhualpBTjA2anJRRUJpR1czMVJkNnRFMUt3Y1RPbFhtNU1WeEhOWFFOYnhO?=
 =?utf-8?B?RE1YVlhqeXpEZHpPMWFkLzFNbVl3RWdOc012cHNxcHl1bW1EcGhiNTEwNEJh?=
 =?utf-8?B?RStmMnR2WFd4OVV5bVJVME14ZndRRlNWYTBJdktxNXM3QlNSNGhaL1hveDNN?=
 =?utf-8?B?TEJkUFhGbnRSN0h6cjFucTd3Mm1WbGpXYStibGhGQ1l4YkZ3ekZkMjE3Smdu?=
 =?utf-8?B?TWtETEEvZjl2N0g2MkpvbmNNS2FiVlZPUEF3c1NZUEdlTFVUMUg3SnBvNjQ0?=
 =?utf-8?B?djB5VGFPMWlvd1ZiVmdKa3pWUHJLTk1qQUJpWHh0a29NU2pFUWVMbDl6QlFG?=
 =?utf-8?B?d2xiTGtwUEFjRXRWUndkNUhGTjBSWmZabjlQMFVrNUNJaXMwbUFRMlRnd2J5?=
 =?utf-8?B?QWFIV2syUFdFdHlrWlY2ZGdzTSt2bFkyV2pLYnptbWlKTGJrZzhMbllWbFcw?=
 =?utf-8?B?L1E0M1QxV2JjQXpVdXRyYXVRbFduSFhVS0hGRDROUFNQSmtIVmhMUGFoczZG?=
 =?utf-8?B?VlhnaDRJaWs0QUV5aFhGc0cwTmExWDZUOC9Rekk3RkV4VUlsR2h4N0dMNlJL?=
 =?utf-8?B?aUVkQXp0aWdxNGozQXlWT3hXUDJoNWx0V0hqak52N29sYVJmNzYzb015Sk0x?=
 =?utf-8?B?T09lSStjNmVtNGthL0JGWUtGaFhEVkYrMEswSnhhNlkwVFhYdHYwSzhua0ZN?=
 =?utf-8?B?WUZLWVJ6dzY2di9HNGJENWVqTDB1cU15UTNpbmMxTmZ1dUhwSk1rRWdLWWJp?=
 =?utf-8?B?SlQ3M3lEYkxFM0hVLzIvcDBuYXVrNW1lOUdhcXIzNllVNStheXR2ajZNQUhp?=
 =?utf-8?B?c3h4dXV1MVcrYlVBS0FNYVZxUjhyL3h4NHdOY0txMnBvZllYWEJLVmN5dk8y?=
 =?utf-8?B?bEhKOElOeFVCc3N1d3VQVHhqZktlb0xybUxRT0NzemlNOXJKWVVrYnAzK29V?=
 =?utf-8?B?SE9XdmlzRWtjSjFUZWdpY2NQSFpCU3JHaCtpZGNlMGVxUC9CYzdqNlRYNU84?=
 =?utf-8?B?WXFqWERkYWVrYkwxQVN3dFBZVVFuOVl3cVVuZnlKNUczazBBbzZVYnBIaDdF?=
 =?utf-8?B?YWlBeHArQTVHR2ZMRXlJc2dpaXU2dWhRRCs4c2lqNkN2SnUzTTNnWlJhWkM2?=
 =?utf-8?B?L0hXeE5NVTFlZ0pScFNkcnNESitBejg4Ym5EbjFkbXF4UnZBRm42TXJYVzFl?=
 =?utf-8?B?aVFnckxNT0tUWFpxaHpyS0RtOUExbldFYm5HVE1EL0E3N0FNeUdIOXdBbjg3?=
 =?utf-8?Q?O6n0RsSEV8jOTipNdQrICyQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b222dda-8d0e-46e4-344f-08da768d03dd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 02:48:45.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNgSeg6qE87p/wgnd6C9IOyNYBynftutXSXK/rINzbMP+I5urmNibS8/heo74KBTUgxnCU06FBIOsD/ZZ5fu9RSJegdVXj7t2ToK0Pf4YGMf1dD0AoKxfd0UYg71vQeq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB1980
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bagas,

在 2022/8/5 10:41, Bagas Sanjaya 写道:
> On Thu, Aug 04, 2022 at 10:30:08AM +0000, Huang Shijie wrote:
>> The aer-inject tree has been moved to:
>>      https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>>
>> This patch updates the links.
>>
> What you wrote above is descriptive mood (this does something) instead
> of imperative mood (do something). Better say "The aer-inject tree has
> been moved to <tree link>. Update the links."

No problem, I will send out the new patch later..


Thanks

Huang Shijie

>
