Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970F673BE47
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 20:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjFWSIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWSIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 14:08:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E14E41;
        Fri, 23 Jun 2023 11:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBJG1f21F/tdeo/Qkqk795R4xuJ+Oe4ASvw8AKcYKEYO1kdZLOTQz5pffO85Wq4ZlNydSJLfgtHLrhw4QctFxG+gS/RpNOIYqxG73CfHOr8Tyu2oIdVTdHLIExtfxkW+Qd4jxrKQv2AlSMujmGoifnPjut06+k1kiakK4O779XSIhwjZkUCp1oc+hLyG7mNDermzHOHtqe4813/JppHmOUF4oFjM6eBuXl8XWf1Yc2ev/ao4bXNG/8SwTRHWWZ0PKOJQynVDOX44jqfKhuOUdXalSKRiXmNi285fOSPDhvnRBrvTUeOWqk46nYinE1GQ0MmOl/yIqomBcFDbRD8x3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrVAsPOU0z1A+WzxZPXOzw+xiU1tQTF1XoaFBTJ1ryE=;
 b=ddN9sbTEx4UVxsDAg2xqj7D3iBHLhrrfKQRUdbUz+1V4gJPMZIoYpE85pML5YNhmJa7JCh5wZbkfY/CqYYHFOJDrnlujetnVvPb5ovA7ZwOSxH3qDeNp3BAp24/KKhn9RirDXXcP1Pl5rTdF1zbdGB/CnluHZBG6BJZqN/3UqrztwFrU1LLCmA4EbCvU8zij+0HBxxre6kAwPbezea2418s52U7Oh2HSKMpdCt+tlPtgkhkUO0C/Um4bonZsdEKWNofzoMFrqQKAUCKROwYj1c/ZcgUUBVTNWte9tBTcvQqVIgLZKoouP4wVj3VLukxG9K4T90LfWHv/zFh62gCDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrVAsPOU0z1A+WzxZPXOzw+xiU1tQTF1XoaFBTJ1ryE=;
 b=d6bNkLa0ie1IUbmyEEUQnP8964eQKuI4Uk6S1Lda6eVlg86Mc/widu4GxUP/Kcdu0vs3j+z4iea5gCL1QWyc+gerXO5s60HijsH6fQ/Bv3AxAavVRcxUpa2buskGGs49ZYCBrijC05u0U/JONLFT3U09YC+2x+JnQNCMeAv1A4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:08:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 18:08:13 +0000
Message-ID: <439f8a4e-8561-a0c9-ffd1-715dc0f75461@amd.com>
Date:   Fri, 23 Jun 2023 13:08:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230623173500.GA180070@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230623173500.GA180070@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:4:ae::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9a4ff9-8268-44a4-7b5d-08db7414cf6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vxqp/qAPvjgfiwc5JroiV6k2VaMCgp3Uqthz3yjYT8xY5ANGQIoP2e23uzE/2l3g3/JO0nlZIbO7H/SDeVmN2WzGaW8gz5IioRDh8XbbIlW9L/iOz9pEuc78Psii+DyaJFb6+DdLmLysXUAWr2T12yL5fn6lzMV7HjDVsegocHpjWHFetW2PIenr2mvJi3TzE5rs0M5fApVRM8edkjvIE3AwtMFUT9PQ6ppbXaaA3Nd/k57x8lVgkxoqkhuXMidz5VqlWd5NBR84iVHIOsM6bNG1z3H3ekM/PNf2E7xULJyB0rqy9nSuBydtW4PI/GWHc6N+FvHBZg0qpNGuPqJYnvyFix2CDqzn9BKfuyBTo6DHwfaakLtyQv07o8uUx0wE8AiYbfBl6xApt6f3PCqZksFj2igMMFTTH60m6UzLt0Uq27gGlQjkLqnLnRe20Vi9WnbQ77YlEjGRX2JstY9S87Q2Q3dcUnwEid6lTwlEc0lFFYY5CddsThv+0lZUuiTuIDtjOTB+sptmxFvtpAPXrAdDBjnMIe+vqIuXxJlPDUnHAqhnivJshgDE60tY03cFvqlFsj5dN6YVog71VqeEXjuCglDe4cJFBrwZu//dD3zI7FqOV/BnSAQLbErR8hp7ys4bAaHChKGB6iyoU0mNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(8936002)(8676002)(6486002)(316002)(186003)(36756003)(26005)(31686004)(41300700001)(6512007)(6506007)(478600001)(53546011)(83380400001)(66476007)(66556008)(6916009)(54906003)(4326008)(66946007)(31696002)(2906002)(38100700002)(2616005)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Erd21JNCtOUmlldUFQYWNyaWNNZkdQTXArVnBDZXZGNUxOd2lGNDlEaTlZ?=
 =?utf-8?B?N0Z5RGFLTWtHRWVzR3dBc2w1bHkrSVJQZ1BsbzM3U0dYODlrWjJUNit0K3Q0?=
 =?utf-8?B?V3BJbjVqZFRCTU5ZQWtOUFltZFdUcTkzRW9iMGJPdWFoeStzeXh0OVRyNFIw?=
 =?utf-8?B?bHluSjZ4YlRoN0ZER1dTRUZPb3dFNnNKeCsrak0zV2xVcWp5SENhc3hKYjdo?=
 =?utf-8?B?VUJNWlhRanlpSjh3Z0x2cFFQT0lqZm8xUlFnUmFoZ1NxN1ArWW9PYzRXRnVD?=
 =?utf-8?B?dXhnNlY2bnNsRExLLzYvaUoyZmVIbWpEZ1BpUmVrYmRob0lYaDlKYlFWMEs0?=
 =?utf-8?B?a1ZZODkwRHNLelJRNlRlVXpGU0I1V0ZyWElIcmdhVVdEalZYWTMzTkpnTURO?=
 =?utf-8?B?VUJJNVhKWENLbElBaUFSOVNnM2FucHhuOEszRmFicWtpVi82RzJVTkROdFJM?=
 =?utf-8?B?M1dwWlJWcXBKbmQ4eVJLcTUwV0JndmFnbXpIWERLajJpRUppWXdSc2dlcysr?=
 =?utf-8?B?RG5jZGJWam5tUG4wSGhWUkt4V0ZUMWo1d1o0b1Y5MnlUVVlJYUxvWmhaanFE?=
 =?utf-8?B?bi9KUnlyN20zSThINkl6OGc0RDNOREQwSFpITVE2czg4bStmZEQ0U0wyT1Ez?=
 =?utf-8?B?bjU5M2hoM2JEd3p2UW5Qa3RrQjVHL3FQNW9RdnhlNndVSjBsZW9KRTEzSjdn?=
 =?utf-8?B?aitSNGNZRHQzc0dmcER1QjlkU3o0S092dEVtRVoxZFV3LzNYeXFBK3pSNTE5?=
 =?utf-8?B?OGdWcnIrSUFuMlVhd0V5T2oyZ29aU0JON25taWl5YzVBYnZibmpXUUNNQzFv?=
 =?utf-8?B?TTUzUHE4dVo4RnBlUXVyZGdub2x3YmZjZGdvbVY1dUFoeStpT05UV0dOMWxM?=
 =?utf-8?B?RlFTcXdoWnNlNk1FL3JTOGdiVEtZN1N2NHVwMUE0MjFLbmRnendxOWJXY3cr?=
 =?utf-8?B?TjIwVThoZGtIYzdSeTQ1ZHhJZHQ5SkMyOW5wRFJQTTQydHgvWFRrZ2NrK3Iy?=
 =?utf-8?B?RUFXZlk0S0hjM042YzlOYk5kQ0NXVWVCU2hFQnZnVFNjNngxQ2FvWVZabDZk?=
 =?utf-8?B?VHgzOUJhdlVhVEQ2UlhidXV3SmtUODExQzlzdVVwaFBlWjNkYlc2QzVtSnRM?=
 =?utf-8?B?UnVFMnVaQjkzcGRXOTVlTTBTejk0c0hrNjVkS1VpOHErSjB1Y3BpVVhWZHhB?=
 =?utf-8?B?UTVYeGg5MERlZFpWUFdCRTlINGpFc1VWRjkyZHdSWUp1Y01ySUc0VWRuRTBt?=
 =?utf-8?B?ZWpYWDI5aVRLMlpoU3llbk8zNUlBd2FHSHVHMXl4V2pDM2lCYks1dHhxbWIz?=
 =?utf-8?B?V0NjNDA4cW1aSlBQY3Y2bHNvWWRzNmJlVE9XbUdmdERNaVVaT09sMVhpWUhJ?=
 =?utf-8?B?SXlHQU9LWXUvOVBMRUVxMWtCM0RpKzVIem1UaDMwRHMrWFdBYVZ6dmcwZXRm?=
 =?utf-8?B?Sm5mSkpKSFNocmUzd0NyRGk2TXFzOXlNWERFRXdYSDFYMmdYTHp6R3VxeU1m?=
 =?utf-8?B?MXdjK0NZaWNLN1RQT0FKNUZlSWIwR0t6ckx6L0FlVWZCNTBnZTU0MFhYcE1J?=
 =?utf-8?B?SU1JYkN2WGZYT0tJU1phU2lFMzhJZFpRQVdaTXZOd3loSTBVelVYcTdzelI0?=
 =?utf-8?B?Q1M2eHY2cjhFUVE4emRTOUU1VmtZLzFYc3c1TzF3QlA0SjV4d2QzMjk5cVFt?=
 =?utf-8?B?RC9MSkpXeWNpTGpmWGhXL09DcG9pUm8vdHBJTlEvNEZJeHFKbzNZZ1duV1ow?=
 =?utf-8?B?VGZjaWt5WDlpNWdzbkxSOGNhZlJvMkhBWTdRYXAzOTRucHc2WXZ0MFM0M1g5?=
 =?utf-8?B?bnA2M3M5Ny96VDBHdUJTaFlFblJMb2pNN1ZJZ21yS3VTYW1ORkUzY1JkQ24v?=
 =?utf-8?B?WndVd0dKOWpzRE1DMjJFSXU3c3VMSmhVNWhrOEFsWCtoTWk2MWs3SWZOT1Zh?=
 =?utf-8?B?US9MWnZ6NGp1NmtLVmE2THYxSWVpNDBSN1ZIQy84Z2F1SnZIV2xDcWUrZVJm?=
 =?utf-8?B?d1J5aW1EK2twZVJ2UEhxNTJHcm5CcWovbGxSUEpmLy92WFFYMndEZXFwNFVZ?=
 =?utf-8?B?WDhLWXhNYkhNYnBmaktmRFY2Y2cyVUQwdGYyb3BzYzc1S1EyUnhpVmJ4d1hI?=
 =?utf-8?Q?rzDhiZbEb+2SJsaxwjXyaFX2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a4ff9-8268-44a4-7b5d-08db7414cf6c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:08:13.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tuuJy8F5epEbNkqjzSeSRa8N2hIscFWvcgEZeLASitHqs9IqTn7C+zbqytUPLoQZpcAIl4M/qRzZTelc92/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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


On 6/23/2023 12:35 PM, Bjorn Helgaas wrote:
> On Wed, Jun 21, 2023 at 05:52:52PM -0500, Limonciello, Mario wrote:
>> On 6/21/2023 5:28 PM, Bjorn Helgaas wrote:
>>> On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
>>>> Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
>>>> an OperationRegion unless `_REG` has been called.
>>>> ...
>>>> It is reported that ASMedia PCIe GPIO controllers fail
>>>> functional tests after the system has returning from suspend (S3
>>>> or s2idle). This is because the BIOS checks whether the OSPM has
>>>> called the `_REG` method to determine whether it can interact
>>>> with the OperationRegion assigned to the device as part of the
>>>> other AML called for the device.
>> I double checked a BIOS debug log which shows ACPI calls
>> to confirm and didn't see a single _REG call for any device
>> before this patch across a boot/suspend/resume cycle.
> Sorry to follow up on this again.
>
> The commit log says these GPIO controllers fail functional tests after
> returning from suspend.  Do those functional tests pass *before*
> suspend?  If so, why?
>
> Without this patch, we *never* call _REG, so the fact that calling
> _REG when we return the device to D0 while resuming fixes something
> suggests that it might have been broken even before the suspend.
>
> Bjorn
The reason it works is because the only time the AML attempts
to access the config space is part of suspend/resume.  If it
attempted to access config space as part of startup then I'd
expect the same failure at startup.
