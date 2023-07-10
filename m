Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAB74E184
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 00:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGJWnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGJWnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 18:43:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D5CC4;
        Mon, 10 Jul 2023 15:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5iQM7eMVpX1GObUPFaAV5oQpij7EFu8hrQ41GuxhHr0GCtIggS8gFoBN7uirLSal6FRjX8maOr6TrheuHRCWCjFhRbdft3by58WogC3KVq3iSa93+dKyQIDDG2KsMpIhYzikXZnvgLSRe48V50W1ihL76gIHRsnNF4ORnh88Y8K4TH84dLpAZ36agDGj59QBQymj5Q9K970RXtzGGg98hyPF7thkvzhfTEZP1PqVIKQARwHjpFxieo6eMM0gNQYIsEYPrM/b/BlUu4m1x1oscTKM67OMfKGgbRMgBUFeEClxblZOX+IT9RvvGdEMjezfa67I4rfqdSRgcQSUjULvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkjfCvLvSdvMK7ffUR/WkC1W/ViWa8/QeoLOt3EvYMQ=;
 b=R95D3FKH7KB903Dcebp1Hy0NrD8PMMokcpGjVWRlr1WDJmO6JG4LW3SL3kxeLwaQCrr0rwzTtRbUrUBDO9SNk104lm6VUWN6H04IERCC4VK/eK+mgUFJ3ZSD8oRt8t7zSsORpXvTIPfVLk0a9enkdalvE32U+VAYjZlKBQZtmpRJxcXRl70/xJ4QkBVwXJIGDsS5AVCRhmMPnV7zpkJHBadNU57ND495d5oYlpSduXNdcUHpcPqBNCw8uF9Fz9lH6FltPgz+ryTDta8ZIaZ34YnMQmRzlvjPBQy0PPqkun+ZMNw/UUWv0R53kbBkInpvSI6nkYqeb2Bet9gxHwhX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkjfCvLvSdvMK7ffUR/WkC1W/ViWa8/QeoLOt3EvYMQ=;
 b=aaWn/+xqxOHyKyPo/1XqphdwnboSVA7e46STvpdtX5bDyMQ+g+ial976RZGCDcrci58ZsuWh1dIkexaXKE7fOSE5uAHxcuQ93elfok50iPpBZiJFBXriVEZ4iHqWANqZbObLSz2z6kQknvosMUFKfxJuXtLV3hw/x6Pl/0fSu6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 22:42:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:42:59 +0000
Message-ID: <007c0041-c0bb-09c3-15be-4e2bf82a5b03@amd.com>
Date:   Mon, 10 Jul 2023 17:42:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 1/1] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20230710203319.GA220162@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230710203319.GA220162@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CO6PR12MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbb3194-80ca-416c-eb1d-08db819702d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlZpXMeQw7VWh6UkQl3cQgIK48hom1G+mYKTHV5y8eJWuxXKlXuSXekStJe14MG00k02JsRZZOq6OyJ980k4d6eEIZGWr7Xa221DuYYxNLT5UjYWeCRQaEnHS/EUMo/TN+K4qpOsq5cHfkc2YqrtaDTgR1DPGLLJ1ncPEfwOVaKOD2Mv9oRTm+0qfSHq50WRka+EyrYu7pDuIEtgk40z6Pn0621vHMRXgoaBe4wB5wmLFpcWhFRvSjoZcWv8o1xrrOlOPUdfHTvz/H00ZGxpEDhPe1+5IVt2J6xyf5kUWhNY/UwJM+D9dzQKxY8hfRL+huU/ti+8C4a3SCGsYf+TOT8St7GqcN7DjXykM4eT7fX5rdbJLa7Rt6uE/9Em0by/JjipZmM5keG0arhZ3Ha6+5ls1MYPu1HsKdH5bAYUPJJ1WSnvVunLHwS7JGky2ZKKJuSNBfa4Wc5uGyc4s/Mx+ZDTVc2WBBsm3jXtgh/eNiC9M9g+GA8VMV1WninXkYDEwHqdjEIpeGk2TnWkIRAUTqvDclehke2vcMTSoQ8Zwrsd2LkklIaKzXzqRzqwEScHtBiMykTLWBOWB1sq/nDr2OX8b728aS6S6gL1R+Hj3gUYkvqliVRlp4XxEVjgDOJw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(36756003)(86362001)(31696002)(38100700002)(478600001)(6666004)(45080400002)(54906003)(6486002)(966005)(6512007)(8676002)(316002)(5660300002)(2906002)(4326008)(66556008)(6916009)(66476007)(66946007)(31686004)(41300700001)(8936002)(2616005)(66574015)(26005)(6506007)(53546011)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny85WDBEYVU5d0xtV1I3OWtyZ0RROFdzUVFqZ0crWlFtcm9uV0ZhWDRuUytj?=
 =?utf-8?B?MmlLQ1pOV01ONFVEb211TmgwMHFDTEZlNDZzWDNVbDArbURiVHV4VmhhajA1?=
 =?utf-8?B?QjMvRHFiOFVNczh0SVk3OWdmdTZ4Ti9PZEl4UmQ3OHBQcW5QNHEzQW5OM1dO?=
 =?utf-8?B?UkNJdzBLR3oycnFOUjdab05jb3ZabzZSOXZBWXpTcU9kTld0dElVbTB2V1RZ?=
 =?utf-8?B?VnRnaXU3U21UWlBBclhHelN4ajI0dVNZdzNjdkQ2eTdSbzRLTnIyZk8zSytO?=
 =?utf-8?B?dmtEblpDUU1YQmNSSWVqbktVamVjWVFVczA1TURVYnlEVU9UOEhsUWx2OWRE?=
 =?utf-8?B?b0s4V0Vvb3pYVjdNa3ZDV1VQWHI4NVpGYWxWZUhUTnRxbTlHYTZNSEl3ZUs1?=
 =?utf-8?B?Nmd0QWh0eWRyRnJqSE8wckRwVHVtV1hOblp3eEVYT1U2R1UxVURJVHJuWmVM?=
 =?utf-8?B?NFlodG95NnJXZkpyalhDdFNXQTl1UWtUWmwyVHN3MXdESnIxekw2UW1LaG5F?=
 =?utf-8?B?MFBvdHBrOEYzdFd2Qmgyek45Q0hJT3R0UDJPZHlQKzc1S2s2cTFJbXIrZTBr?=
 =?utf-8?B?YkdyRXdWVmdnN0xlR3E3M2hndWRSa0R1cXU1NEdOKzIyRjVvY280Nk4xZnNM?=
 =?utf-8?B?QWZQODc0dlQ4THJBRWZsM2FTN1IxRHR2RVlsa0pENVBQT28rMWpNb1NsdjVk?=
 =?utf-8?B?ZHF2UDZFWjYvSWNXWWlUcDV6MXZudk9GdEcrNFF2ellOM1gwanRKaThmS0FW?=
 =?utf-8?B?YXBBYzJVaXJOd2VnMjU0RVR1ZnFGclpOTGNFdWozZTFZMTZCM0RsRXhtdy9o?=
 =?utf-8?B?V3NZRURBMGRXVlUrWFV6ck5tMmdQdDh3NDBIR3RXejgxd09Ta09jaEl2UUF2?=
 =?utf-8?B?eXpyR2FvMlBmOVhvc2ErREFlQ3Z6WDF2V2NIYjI0WS8rUXJ5TnEyR1RsQ0p2?=
 =?utf-8?B?V1VoWTNwNk1aeFUyYkZiNHNKQ3VOZ0hZNlgwZVhqK3d0eVhLdzg2RDB0eFJu?=
 =?utf-8?B?RDF0T3Y5anh0c3VWNVdQL05GOUVSRnVVSE90ckZBM3U0ZXZHeXk5WlRyZ29p?=
 =?utf-8?B?WU1waE13c2NBU3JpVUQrdkt4WURiY3F1ZUdadTBIVjZEMUFIR2EyL3BvVUlp?=
 =?utf-8?B?WllVYldmUXZzOHpTU2lNMlNONm0vT2pLTzBOdnE5UnVSYXpDb3VjTkFPb2xY?=
 =?utf-8?B?bkpDOXFzTEphbDJFY3Nwek51emU0QytBWnMwa1FpanduSlNFUXdVUWlmWHFq?=
 =?utf-8?B?YlZYUUJKYk9GQjMxMXhOQmc0cVNXOFNJaGxsOElneitZZFZNUGdqaW1yTjdo?=
 =?utf-8?B?ZDRWbkdnYUhQdTFrdnZQOVExdUJ3dnd0WlpUT3BIdUtra1IvQzRxWXNrZk1o?=
 =?utf-8?B?ajF1SUl0dDBtbnI1YXNmUDNQSXR5L2FtWlh0NS9pV2FLTVhHcE51T1dVeEpG?=
 =?utf-8?B?c1NKek02WkIrVk90M1RKeTN2SlJoN0R2SkZxWnl0WC96cCtQVEtNa0U2emN3?=
 =?utf-8?B?c1g4ZWszbnduN2trWmZPZC9MOFlZRUMyTWNWOGs4akF0VUlSM0NNVlBtVlVH?=
 =?utf-8?B?ck1wbjFCUUdrbVZHeDh3ZTdhaVgwL1RvZjQ2T0ZaVnhtaExjaWVTV1RJT09M?=
 =?utf-8?B?dkVNRHRXdGIrWEJPOHdvMUpJdGdsSzRWS3hWWS8zYWlxeFI2NktlSktpQVRa?=
 =?utf-8?B?azNtclZwalpOUzIxQkFlMndEczB6N0kvNTlkR2JHbFVrc2tIV2VnSDV4MkRK?=
 =?utf-8?B?bUxwTnNsd0ZHOG5UN1p4L2pmakFwQnZxRTlnZVdVZ3k0NkVoNTNTMEhzMEFO?=
 =?utf-8?B?OTJYYXc3Q3JGUUZJeW5FUWFFZ0h2Z1ZJR2xWaTVDaXNhMER0cjhmZ3h4Q2Fk?=
 =?utf-8?B?cmpDS01WNTgrOGxPaDNUMWNsbUdBU01pUjh5U0kydDZzVGNqNUUva1F0bnIr?=
 =?utf-8?B?QU5LRm9vMXM0a1JQam5URXQ0Z1R4Y2FJVU5UTSt5T3RwY3U4SWtGekxFQVcw?=
 =?utf-8?B?NUp1eC9XOUo4VjNieDcwbS9xWjcxSlJ4bkdEaWsrM05VZVE2bk81SlY5WVFk?=
 =?utf-8?B?aXFpQ1pEanpid1EzL08xcENiZUZoK1YvUkpzbWdRczBwM2pkQVUyY0QwVUNy?=
 =?utf-8?Q?cwq//ydkxJFPNZmxBNsmBx6ys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbb3194-80ca-416c-eb1d-08db819702d3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 22:42:59.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCTAph6N5PmrBD4PIx/oyXo8knJJ+2iKAwBQcXmWzP2d9DhGIGOSC3A8Sfhr8idU9LxbDZVfz/kP4r+o/RfkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/10/2023 3:33 PM, Bjorn Helgaas wrote:
>
> It sounds like there's someplace the hardware designers specify how
> this should work?  Where is that?  "Modern Standby" doesn't mean
> anything to me, but maybe there's some spec that covers it?

https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby

It quickly devolves into Microsoft specific stuff though and
I can't find anything interesting to our specific issue.
> Maybe this is the clue we need.  My eyes glaze over when reading that
> section, but if we can come up with a commit log that starts with a
> sentence from that section and connects the dots all the way to the
> platform_pci_power_manageable() implementation, that might be a good
> argument that 9d26d3a8f1b0 was a little too aggressive.
Yeah.
> I like the fact that v5 ([1] for anybody following along at home) is
> very generic:
>
>    @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>    ...
>    +       if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>    +           !platform_pci_power_manageable(bridge))
>    +               return false;
>
> My objection was that we didn't have a clear connection to any specs,
> so even though the code is perfectly generic, the commit log mentioned
> specific cases (USB keyboard/mouse on xHCI device connected to USB-C
> on AMD USB4 router).
>
> But maybe we *could* make a convincing generic commit log.  I guess
> we'd also have to explain the PCI_EXP_TYPE_ROOT_PORT part of the
> patch.
OK, I'll take a stab at rewriting the v5 commit message to be more
generic as you suggested as a v7.

We might be able to drop the PCI_EXP_TYPE_ROOT_PORT part well but I
would be more worried about regressions from this.

