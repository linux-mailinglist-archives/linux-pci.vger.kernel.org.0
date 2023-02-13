Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79E2694C18
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBMQNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 11:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBMQNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 11:13:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A7FA26A;
        Mon, 13 Feb 2023 08:13:23 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DF4ZF6021079;
        Mon, 13 Feb 2023 16:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wqKW28HTLy7/AAa2l805y7EUOh5UlniDbWPka2tch0o=;
 b=tUbMFyFoQkIxzENhFtRfur3hHUXiyM4famROIiBETVm4UNasYLcH9uHr9xeUbk8WXghd
 UZZCeOcJcgjltC2W50qLN/2UAuNP1jZ+5Q2IbfZomL9v4qc8/4CXtIEpWvJF0wS2TY4U
 +9XbcGFuj4FFUGpAIK5cGQN8ZiVXBQ5t4faHyGRwKp7RivrasxXut7OTmpXOe59ON5Ka
 +9rL8Et1LbTJ2UQ1FZH2mllFWY1lGgGo7iipoQikSapEfc5t4ZN6edIOmpzGJSFw5uoj
 c1ablXBVoARxsh3HUjCyXZyV9MozFjJ7D84hP9czB9nA/GzTaAASGtrnU4vtkiT/TZkU bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0u7dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 16:13:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DF9oQ2028765;
        Mon, 13 Feb 2023 16:13:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f4au6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 16:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4rT9E8J5b4cVAY4vsRrgYYnmYSvuxC3ch6XADDjsE6q83J3rT6JtNG2LAVXx7qNGyGSwIFjZffLC0WtYhea7ieUe2oyU5unVoU7UCIjzvuSoES14DTiuofdw8/JmySkn03D3cwMdclbJK2GPR/ckqKnKtyej0MKHEUGihtswCsd1RuBS6cIEKdrzpgJqyT0mBHGjVQ4TGs0FoYAmIvfN7s8oFFzJFfaoX4oIwCHoSqvF43DRA9XDs/0fdovhNRln2cdpGqgFP3T80LD8voewdbhHhYZkcbLMLLsKvUMyJt6h8Co9RVuoQ9FtUPC47qAEuQyzEndtm22aVWice6UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqKW28HTLy7/AAa2l805y7EUOh5UlniDbWPka2tch0o=;
 b=iX+opUDTWKPSUaXLeGUXDZBLNUByRh77QcdS64/U6033RXpMmvo+Mr4iylcMLeA8cBSS9ULy+thfQVcxngt9GE3lRFfvS0vNamQk6c179WwD+/UXFqJUnl3iiQs2QSh18pv9ISBg39j564nOxU4VFAMJhuDFpiCFPiTwdqM55CCcoC2Xmq3jtH902lTetLaSgW0UILGZkSGo3TMcMvr1X0I1M/dVq5/AAMkRYoJMSdgOVXLt4V4XbvdT/lCJ17Xot2mn6VJMknefM/Lo+ZF3WI6INKt3tw4uSbSk3tVzEJT/sfD82eHqpkXB1SvJaC+dkXyQOwNLjvn1cfyEL+Z9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqKW28HTLy7/AAa2l805y7EUOh5UlniDbWPka2tch0o=;
 b=M9rWoCjtdF7e4UbPUfoNEjGSNtNs3t7CR901pio8SpzcnWLCOMGcxp4j08ti1pWhUFujfTtJ9Y8J3fQunCpsNvQ/BcJc8Ykd9gfDXrrPHPUo27+9c//OflruHv8KyZIox75nzQIdA8T6sX1jYmeP5dMT1RUTX49CT5T0vHziHF8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9; Mon, 13 Feb
 2023 16:13:05 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 16:13:05 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
In-Reply-To: <Y+kx3fb2Lzlg+u5+@unreal> (Leon Romanovsky's message of "Sun, 12
        Feb 2023 20:37:17 +0200")
References: <20230210164749.368998-1-nick.alcock@oracle.com>
        <20230210164749.368998-9-nick.alcock@oracle.com>
        <Y+aMh5e9bWaTphiZ@spud> <871qmx1fv5.fsf@esperi.org.uk>
        <Y+akw9VBjg9oZ7QV@spud> <Y+kx3fb2Lzlg+u5+@unreal>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Emacs:  no job too big... no job.
Date:   Mon, 13 Feb 2023 16:13:00 +0000
Message-ID: <87k00ly25v.fsf@esperi.org.uk>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 70096595-e323-4ebb-e083-08db0ddd3051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZNp162u8/YOdkFCzIg6Y+Ftg0UNQ2BSj2TxI0n8aD50FcpAXOaMYO2OI7J6mI8MIVI4hjO140m+6pL7vFYcoRbCYS6s6y2W2qjHtWt0R4mYT39K5Q3B9fiG5cwOUM5TLSy16PvlrpsCbDl/fbGK+k0t3rlzaNwNIA/S3g83eGtsDUyll4fRAuoeQu4v4c3J68RtINbiW4VXDH6F+ZuP7+0dIKS+9y8oguLtj+CxyQrhBd8xnFA3TmgtP3kEWULKFynxeMWvIEkSqho9n2bN2zv6EgRzseaCExoCiCcOb9+JuEGUeOdudpKLrdpUI3ZOqgnMwwFpcElkxGnpeg82UoX24s6tEf91UehdJICnZnOhpqPozRUx3grjhlHP2LNiXfo1LbUNwngOypIkfm0nqBn53hv0SEoPNKaV+nXiEdLSkhHhvhBWZ/w54b9dZn/JJccMNhp5/h513zyPGptRomau6A6bsEbcix13CI2ABlTSg/B2RLHT6lZhimUe1p+U8gptRGeuO5TTKAILrzN9ZrH0NCbFyRCnNCYwPjTHVsFNQH6JTfqh5gN3liMfdpGjOK7kUWkCiJhQOxO/Y+654d/r9PeWsDIWwGSx8QUvzrTbhSu2IAeCdrCgIUMoXNlGG7DYHX/G1Wzh+73y6S5Juq9CHE6kcgnXQb8fSuR/TN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(66899018)(41300700001)(86362001)(4326008)(5660300002)(44832011)(2906002)(83380400001)(38100700002)(8936002)(66476007)(478600001)(66946007)(6486002)(8676002)(66556008)(36756003)(9686003)(6916009)(316002)(6512007)(6666004)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXJsBdfJweKINtGsxc3CUjJNyiD0McMSiX5OE/HzBn/prziGK6x8MZd5L8BL?=
 =?us-ascii?Q?5wvhs8trK5Z3BctcRJhmKCCuQflp7HNltH1Sy+2DmAetUk1YJPV+0AjK8zIb?=
 =?us-ascii?Q?MWnbZUj29vDaswgrq+d1Q4DviYeiSCPo3NRpgHR20wSZLpSg3tJoMl5ykvgH?=
 =?us-ascii?Q?4bgbRDOVw6Gtfeyy3UlgUVcaQ0mQoIRIsROK6OwnfS+HuyIi7bG5beqtXqnC?=
 =?us-ascii?Q?qx8E4Le/6lE22NnUUVk+0eFDmukR+odZElNKucSJVV34ipI2Yb+yl+CzbBQg?=
 =?us-ascii?Q?O9xYnuij4fsfyFmwDtBTfWstXtkT/dSdEpoq83gNDqnOE3qxJmoYkYIPLtyL?=
 =?us-ascii?Q?js7Nju+NR6z8iz2fxOg2hVoRKnJXA0zw4M8gKg2cDvmFZ9yozrnH09szHFu3?=
 =?us-ascii?Q?+fJWtesC+SUL3Kwimv6VSWAFEI2joGScKr38XZQ7lcrNsTYzjmUqyIRO3so2?=
 =?us-ascii?Q?q+UFKxE8rQUHgAR2OU/jKBHJmYAYeqCIIQlCEiwzmjzhktNYApzXX73UgAdm?=
 =?us-ascii?Q?dQ4LGU4u3NEPMqfTg/gnfSxfTlzDTokaQUzmIcmxXAervUU/9DBeov6H//HB?=
 =?us-ascii?Q?pyOjpv/jL7MyzpI3U0SaKjpP+NISOxKs6upbEYR9rEZqiUSUoDxWSjU8eBt1?=
 =?us-ascii?Q?QSbTrZecGboMzXaS1LSiZH/EirCHq8ZEIfQxmDuna/HrrAuahT4ujhUi8Zkt?=
 =?us-ascii?Q?tykZ4XCDv0Z6/qD2B4R4DydtkcO0/zPDpCbgSFLEjwMDQvXharoAc8mzD3i8?=
 =?us-ascii?Q?s9L1toQCFBpxNkD130Csmq9XfH92Syczph7yfM/inUjQH10WrnOafXcbVkcn?=
 =?us-ascii?Q?qNyHr0gLQ3dZ5nw/4Bc3o0fWRvVQht+M0P4AtocJ7uf7flYLM0slLXinfrVi?=
 =?us-ascii?Q?WTD6TxYQgR44pfuj7OtYuye0iJDgJH1RpJS0PUjDvbGcsSiPSdMDdk8EZ9Yu?=
 =?us-ascii?Q?KtGvyHUMeBfwEGkV8LIgZ3ymJw7iBI5Zw/i6yIvHDEg+nLI1w4Qjw6wf0RCW?=
 =?us-ascii?Q?hpMNOfOpblJ/ZkoFxQIXhx5VsJmGL8pnfySn7rujvMTYqc/Xs63CkomBYYbZ?=
 =?us-ascii?Q?Ecowt4qieGq7Q+79zWUa5xAvFjIC/OXNwb7oBbt509/damPLSHrpaMgQgP+f?=
 =?us-ascii?Q?8TQJC1+3wfZ+mLnn3WIy6bdeTOL6TwD9lHDdqs3EOT0CQYZpkdSU8q6UuGUU?=
 =?us-ascii?Q?sNQ877aJMKZRdO+ML6JVbScTbGu4r95BaKy8kV460GSV+BfgmLZfb823lGEU?=
 =?us-ascii?Q?Nx/k3kjtg5PBnzogSbXsCzS+8roIojc+47ktXT9hGzsEY52ygnq0TEckY3vN?=
 =?us-ascii?Q?CoTuaZSnhKK4nypfW1C5Il44aGhaRi5Nq8VEZaUrFjUOOTsCwTwGjZS+K9bB?=
 =?us-ascii?Q?RQAXXYNNs7Nzo+Q+EMpex7wPLIX2q7+2ExhFVuY5Jch1mqIXlDfBE2msiLd5?=
 =?us-ascii?Q?bnfMrjyo/qx3+p2AwEwPsnRdKtAUSFR1JVtOmRU7UdzNozH08ZfA73z+GYih?=
 =?us-ascii?Q?DdM+dVDy05pBR5CwcHX/hTUjzNEuQSg13ffKX+TatMDBVSxHE/S2m2vi6cXx?=
 =?us-ascii?Q?Nv2Y3iwymmpXr1qz4CkFLAcR2M6CgVF1S1hTr4SPZXuG0d8n5uvvo+aQkGZc?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x+L9QwRZeG3JH7+oiu8MZJUOdiYXv26pVoTUnbjKTitwVf/fspxdUNG8ndSg/H8HZziK08kNqqMOpbn8JEe7u7BSVP4VOfp4pKko3bJYEbZQL3ay+yL46IpazK1jc6AbJKFuwL/n+GmPxLdcNeJVcmXND01CJyyOV7tfONiTMJHLmfkvBGPWA6URxCaYKPIxwK5+b8XvMgxyRTHw+VdYXvJW++3lT+yaffW/rb4I6htpxUkffkre517ZN51Fnox+bfUoPfK3/dM1hulJnFQ8OlgrB4RIwOt9NNJWF16dd6Jy+JoQ/BqCFv2LTFgL9v46EjH/pPBxa3reaJuxdrCKtIXz2RiO0FPA1qY46eYUtcO+uQpcmHBSWntFOVerX6ZcKjKyAU08etCVRT1cr4MsFp9aBzzAVghxnZHJj4vd2kQSqA8dBvaAMDTjVAEm4gVVQzuWzlk2vqyKRYmOKfTqwqCpu3+tvHgqalNKbFLgtrLEjUnQTjbiNX4rj88RX8wg11mVBhkFrY5nDxZ2Z8UitoQ5otpk+peGsqqgivpUEoGjoju+KS0PHU+dQAOmj74YA0BbCF9kqxOs3y2WF4eoOtLW9qnSOuqiqaT9dX9w2dMw/kuQ7wNhLUlO+YxA+WFAGvn3cwx2ihv2EyV93euACpF80hUmyaiRpQcleVwN7p42dJxLvTvj+qV4XV8exK8ChxRqSqytN5e2PR5j6x07ddJ/YmpnFOVbhBlg2ZauZ2mlTEsUpd/OvoGu9NoETMHBKVtMk+Mw4g8qSNnT0zQvgPRm1xtLCMDueAKNVj0pOaVQESVQBi+nr0QxdTIzdKN3EedY7hIGODRsclgzBxE7pQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70096595-e323-4ebb-e083-08db0ddd3051
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:13:05.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ohkNBobuuGozPGHCxunab6VqQgSV13lwtZhw5nzh5leGfbihETWQrdFOP5dtxUP3rbau0UwaUhuzcHiEVkqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130147
X-Proofpoint-GUID: 74XHvQU0XYEtzuDbYOs1wVIiD_o6183M
X-Proofpoint-ORIG-GUID: 74XHvQU0XYEtzuDbYOs1wVIiD_o6183M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Modified resend: my MTA claimed not to send it but then sent it to some
 recipients anyway, and then I was asked not to do some of the things
 I'd offered after I sent it.]

On 12 Feb 2023, Leon Romanovsky told this:

> On Fri, Feb 10, 2023 at 08:10:43PM +0000, Conor Dooley wrote:
>> On Fri, Feb 10, 2023 at 07:26:38PM +0000, Nick Alcock wrote:
>> > On 10 Feb 2023, Conor Dooley said:
>> > > FYI $subject seems wrong, this is a PCI patch AFAICT.
>
> <...>
>
>> > kbuild is present in every patch in the series because this is a
>> > kbuild-driven change (the thing it disturbs is part of the build system,
>> > the construction of modules.builtin*). This seems to be common practice
>> > for kbuild-related treewide changes.
>> 
>> Okay, I'll take your word for it. It just looked/looks odd to me!
>
> It looks odd to me too. Please add SPDX tag in modules which don't have
> it already, instead of commenting code.

Alas... nearly all of them *do* have it already, and in most cases it is
different. Usually not *very* different, but different. In most cases it
is more specific, e.g. drivers/soc/fujitsu/a64fx-diag.c, where we have
MODULE_LICENSE("GPL") but SPDX says it's GPL-2.0-only, but then there
are things like lib/packing.c, which throughout its history in the tree
has combined // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
and MODULE_LICENSE("GPL v2"); which are just not the same thing.

I commented the MODULE_LICENSEs out specifically because I wanted to
avoid getting into hundreds of simultaneous license flamewars while
trying to get *a different thing entirely* into the kernel (kallmodsyms,
which depends on modules.builtin.objs being correct).

I still don't want to get into hundreds of simultaneous license
flamewars or get my employer into legal hot water, so I think I'll leave
things commented out and let individual maintainers decide whether they
want to reconcile any contradictory info that may exist or not (and as
noted *most* of these are conflicting.)


This email is the closest thing I have to indicating what Luis would
prefer (and the only reason I'm doing this is because I need it before
Luis's modules.builtin.objs change can work):

<https://lore.kernel.org/linux-modules/Y5AgMuMu75gne6Ka@bombadil.infradead.org/>

Yes, Luis thinks we can just use SPDX, but given that they are usually
different, making such a change seems well beyond my pay grade. Even in
the PCI domain, we see (second column, MODULE_LICENSE: third: SPDX,
sorry about the line lengths).

drivers/pci/controller/dwc/pcie-histb.c:		GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c:	GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/controller/pci-tegra.c: 			GPL		// SPDX-License-Identifier: GPL-2.0+
drivers/pci/controller/pci-versatile.c:			GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/controller/pcie-hisi-error.c:		GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/controller/pcie-microchip-host.c:		GPL		// SPDX-License-Identifier: GPL-2.0
drivers/pci/endpoint/pci-ep-cfs.c:			GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/endpoint/pci-epc-core.c:			GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/endpoint/pci-epc-mem.c:			GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/endpoint/pci-epf-core.c:			GPL v2		// SPDX-License-Identifier: GPL-2.0
drivers/pci/hotplug/acpiphp_core.c:			GPL		// SPDX-License-Identifier: GPL-2.0+
drivers/pci/hotplug/shpchp_core.c:			GPL		// SPDX-License-Identifier: GPL-2.0+

Not much in the way of consistency here: GPL sometimes means 2.0+ but
sometimes it means 2.0. GPL v2 appears to consistently mean GPL-2.0, but
if you look at other affected modules you soon see inconsistency:

drivers/powercap/powercap_sys.c: GPL v2		// SPDX-License-Identifier: GPL-2.0-only
drivers/firmware/imx/imx-scu.c: GPL v2		// SPDX-License-Identifier: GPL-2.0+
arch/x86/crypto/blake2s-glue.c: GPL v2		// SPDX-License-Identifier: GPL-2.0 OR MIT
drivers/iommu/sun50i-iommu.c: Dual BSD/GPL	// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

We even have

drivers/gpu/drm/drm_mipi_dsi.c: "GPL and additional rights" (header is
non-SPDX -- a BSD license header with advertising clause!)

So SPDX is usually more precise than the MODULE_LICENSE, but is it more
*accurate*? I have no idea, and I don't see how I could possibly know:
going by the presence of advertising clauses that obviously nobody is
obeying it doesn't seem like we can trust header comments to be any more
accurate than MODULE_LICENSE. Best to just leave both in (and comment it
out so it has no side-effects on the build any more, which is all I'm
after).

-- 
NULL && (void)
