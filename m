Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248AD694BC7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBMPyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBMPyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 10:54:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C16DDB;
        Mon, 13 Feb 2023 07:54:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DF3blK006205;
        Mon, 13 Feb 2023 15:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=4Uo64o/P/OtuTJBZzjQ6xW8Rr7PfAXuVIBzs0qZZKYY=;
 b=ODf8mBBu9oHkZMmMNHwwENjA6zynb6B7VCYnutI/H3FSe9Bn13o4we2VsbSg3WrLVSQg
 lcohzIy+62nNnMDEvTztxuxhCO/PjUOpyGtqQXBuLvhoMg+W/3LP8ddifbswYq7NF4PG
 eWqto93H7lu7Y+TTeWn7NxDmQppxv74KIHBNh7FqO7knMc1xYRNcLsFKRdQySUft9aCt
 In1lXdmCpfOhRnd+uifm5zdBubTR3/TwH9K3d5ZLim0vyM2bGhbICCbv0dFveta8Q4z1
 MpezIY/6e9pJo0UclsL2f+5Twd79BCAuA+CgiIP9hu6RqYHTrRNJ4Ij4F0BTzbZbALjU Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtb35n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 15:54:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DF3Vfm011439;
        Mon, 13 Feb 2023 15:54:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f4a2tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 15:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9h75YFoyxM9IjEUXZ9tIjTYpXdG/foGlcetfe/UjRVd8rQsCS6XHEm5aQiUETb/6QoFOScOiTfGz5VPkKPouxLR7cCPX8cssFrq2F0EoPlZJtHaG6VqWnAO76kRxhC1mnKWDeJhYvKVKSsYk+QAChq8LrLq/VGJE1FzZ8x9941p75d10CZCNOdGAXePGBfVtYULBTlroCACN55WcaFF6AOFrjaV4rIKgHEozZFHpqzBlDsI6Q5OtUDlmMC/6EI2oVjvDJS/YaohG/1GHmCHRSCQof4vTdWD0ES/CieIUQbc6c+m+oOl8I0duc0C5RTSIgeyToz8VqmGlC/EUu6apA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uo64o/P/OtuTJBZzjQ6xW8Rr7PfAXuVIBzs0qZZKYY=;
 b=boLr79ipesjTr89vRuInCF1YarLE7ZAv9KJhk0p8AVzFhqTlAwJeQCnPeZaRLEDkiH7HQqThDXQ99anE+PX63V0mLYxVtCeRcy16XdAwBfM0YPZNp2QKwoH24C7TYLxtmdqqKY4s16SJdRpSUY5Cwv0L5SdgJS6Stxse6nW74wlnS9Xkj82qOWlipeVgE00MruDMFB5zt/+DijqLyrTXH/Bww17KBQt6/TQjXNnQBztR4ATt1IRF4ZTO7I1NgOzHM5vUOviz8gGV+kpoIF7P/O/US+SnOjgjlBKcdrz4vAReP3kciA3BxfHmbPbgTfPU3m6BfqlhaYtEG7nQ/qhKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uo64o/P/OtuTJBZzjQ6xW8Rr7PfAXuVIBzs0qZZKYY=;
 b=sMACFzkE7ouHt+0MR609hC6ecKmmZfE03suPRe/LAMEEytlTtIeVpl3IMca57aZZX3dAur/Hvi9Jk9jThao/jrbjDZjzgqRNsBBFB/ZYGnGqYvl4S8DgS4yiKr1le3p/sBWkIw/RfgdFB3zQDbD+y9c0nnKMFMBSkRsjrwrL0Ww=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB7213.namprd10.prod.outlook.com (2603:10b6:208:3f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 15:54:01 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 15:54:01 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
References: <20230210164749.368998-1-nick.alcock@oracle.com>
        <20230210164749.368998-9-nick.alcock@oracle.com>
        <Y+aMh5e9bWaTphiZ@spud> <871qmx1fv5.fsf@esperi.org.uk>
        <Y+akw9VBjg9oZ7QV@spud> <Y+kx3fb2Lzlg+u5+@unreal>
Emacs:  more boundary conditions than the Middle East.
Date:   Mon, 13 Feb 2023 15:53:56 +0000
In-Reply-To: <Y+kx3fb2Lzlg+u5+@unreal> (Leon Romanovsky's message of "Sun, 12
        Feb 2023 20:37:17 +0200")
Message-ID: <87lel1y31n.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bc284d-d1f0-4534-0854-08db0dda8627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaptUAWLRAA2aaJPUB75JiLDRae2TyTAmdFNEVfq02B3nONoPpG8SLZ2kf+2hR+ZMxP9rYvV9TcxjzFLcJV7q6/s115NyG8BYh6C0ZVoWKqELdbXTglp9BvGqsFp+hqVcp+yIzcnPDeRQLBnnTqJEC9DMdZCDL6kShZITjWVmEqMGpKrG6JTqP7mpgq407XxkakFhWdljJOw4hrCbSbZZfM6gBJITErUX0dbcdTX3DWARYN5V9vrxQnmuMfUIm+YLgB3PgaqPP203s55R5kpNOrJw0QEnx01I1TqqdP0oP6TTeS8DZNCdQgevZOar7aTci03DZHn1KjDnsP18jQf1fZk/+wZgV2/QM70VXsCBjJElo7KppLwCKtiG5OpOvmxW4og15aEBr8xmeBac/mjaUMCeENBG5xkk+ym2WKflzJpBmYuFyuNqn65cDYMqMhsP+ihX8jFPePFd/STTtUP09UcSyKE5+E18TeLHwgOq4eeacKjHu9MwveEOxnRm0AGOYI9Aafs4PkvEBrt3URwVVh8ko5sxCInv2JiOySqntsK9Hb2Cu11gdMAT4tYFyo53LX13L9MJNFr4KLL5yq9ctjFn3fFgGwU9tu4e9CFBC6eInET66Y6/KLyN2bF/+fdFQVrmD78u5JWabS/a2RIvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(86362001)(316002)(4326008)(8936002)(41300700001)(66476007)(8676002)(6506007)(66946007)(6916009)(66556008)(186003)(9686003)(6512007)(6486002)(478600001)(36756003)(6666004)(44832011)(2906002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OQpKN1InE06W1YBaJRKj8fTpVuPqsVDW1dLMvxBqufoPMmEaiS51ovd+qNQH?=
 =?us-ascii?Q?SlrX+kKE3w4RiyKy3Qe2hk93HDi/iIRu8ZJRpPCxlOiflDmN+8IKth6H/s6l?=
 =?us-ascii?Q?2nAQ5c2Y2EmrYofTDposJNey1/a+apKXWzjO3Nx3YuSWn0k/31vphwWzu7km?=
 =?us-ascii?Q?n0Ourqn57JaFZ4dgURo+vNiW93bPxhs2k5/+uTvtqpec28uyZ+iL7r7Z07aS?=
 =?us-ascii?Q?7izteu1Y2QEs/UOObZAUV6TVTtFC6uL0OoL7ywaymW52CdIWh1U5kDdNj2d9?=
 =?us-ascii?Q?BJ2aNlpA4aXNNlB2tDJlwE3BO+/q7bjMAithUBUpBZgwBWVXMjgmc+g+MXnu?=
 =?us-ascii?Q?UPIChFJzoXISJPdwWrh+PYb1dRWrnW6T/qgarTounJAmUVsd1rYjxjDNL0ae?=
 =?us-ascii?Q?I4YbJyMH16Ov7cLriF49tWH5iaSkBPZkMQK+8+tAiGcjVDAkFMT42tPgrlrl?=
 =?us-ascii?Q?2kw/Nj/XeGFvaiBD7SCteaB27KXJ/PH9CQVhatvYVpsCa8MfWPbvabz6i8p/?=
 =?us-ascii?Q?tVleMoXKZRWuJFwn/f4FuVSKEVu6WxAYnbc44mys2R39oilHyRqQe9dIdrxB?=
 =?us-ascii?Q?i2l7WALNhyh0/HrYxQr401SfD/KLURCKQUr6GdbVCy6pqVqIm2eav5QpuwJJ?=
 =?us-ascii?Q?SYH1FaiFD7tmWLzj7Yu2wGliCiCgmTZ3j6pFhfUtaHC26y2bV0R3Gx0H6zkH?=
 =?us-ascii?Q?Z1rLZS6s61B1audeT9KQKdb042Gu8zPQqRtfGR69YdPW2XVl26G+MBqv0E7c?=
 =?us-ascii?Q?AhQKmrO3lMA97FZmYmLPp2WNqyXeJlcexNPGPMwjKwLHV8jwJBh0M5tf73HZ?=
 =?us-ascii?Q?7Hgp0gBEOYrPVvhg5xGRuhpZfh5tdbr1HPSp1IatUvC/IYBWBnX9x3SFyiSi?=
 =?us-ascii?Q?/ALVSIvnHsuVQS364vMdLgoLSWKG5h913X+wie8YIqJMor3KfZIdXJI/BvoJ?=
 =?us-ascii?Q?Ikg69gOctEmNNxE4YO073M9UDyq6U2gw9N977QTIloaqc7Z7mKA1IbFylLiJ?=
 =?us-ascii?Q?JQrCd+i4g94CcYavO+8LMtEYdfFeZAtlzkllltKtyM4fsxUAU88T2eRcIUMa?=
 =?us-ascii?Q?hi9/J1PR/PDBvDXouPh1onX7leXEmG62FeWgskKFXe6hKBtadgh2GNHBNHGR?=
 =?us-ascii?Q?5agrAOLD/vz8+F8TuKca1k9Smau1ptaMW5jmrnvUalrzQy/ZRGrF1nmWamfb?=
 =?us-ascii?Q?Dak1lFGZ3LHcvm/WbOrg35mU268LoXZiB1Fc309OcfjqhpB1rGmSe1uE4b7Y?=
 =?us-ascii?Q?3HSaitWC+6kuOdpquAKOm3KitI5JlfsDbzrISYpMjiQHib5wGKToUugs9t0I?=
 =?us-ascii?Q?FPPUcMRYw4CUUuvMBkw98qQMCxgM9oBJFc2wymU3kPY0kSbkKn/9V5skiwCG?=
 =?us-ascii?Q?dbTNWuXO+AxGpsX5LEvDCecZUjdFSY9ZEcvBT41SgAS0cuqv8IXoP6q4P4OY?=
 =?us-ascii?Q?Yu1dO6QplnwWUe3b1j4rpcjs5CxINAG7s+4DNpYmbpxjSEQnnQgney6NV2GP?=
 =?us-ascii?Q?3EZIZBlHL3q1FRZquIK94HhEV+MS1ZsHkLXangXIGW6W6Pzs8cEwtqGVVOjb?=
 =?us-ascii?Q?SHa3YLx7p/G+CUqYtCcW2KIrGJPm3Kn6prSoyYNWH33k1ULlp4RUmoOCyqHp?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DFPHuRg7V0MVVslZz6713Izf3DK2O9ek/EErlIu35ZR7dXlvX47VE04KFyTXGqptVk9u0UJ42XdYasO5ZESfZfZw+Kqk0EwdSjK4JQwTrS8uleaNjL6wCTta8cLgGxAsW/nsNYLXr5Q44DunH16/YJIB484+NxSIlzLj5GMoEVTqzLh1jQAWx9J+kNflcncCm/ZHBdiXAomMNolkjFhvUbtQLO+oJl9BW3irqMeWm1wRif26qWeVlVdDSZahiMjvq0EOI4yfr6GJXCCbLIQSrIa44z0BpQINU0S1ryUhwT7qgEQgOEHm3NYC9W3HQ6uu1d399wZGSXGAm1AKyb82M8N4sLJLySQ50P+6xjPapHl5FGgZYunGhPbR4ObkQZgEexV4HmfXJH8I+Y4JWWx5Qj5aXIEUbVnj1KcdbKLG9J01vuDKTi20twXzE+ifG3/BYQx2jqmKp72XSK05MGd2FlkRMpqmrt7j6b6DTQJ62WHYG3KC67D3gSa5qjOBlHuCKbCbGbZm1BKxUscpgyILWVrHwhvwZ/WYcyFx+eEKiLV3BTHbDRfVGvPQ41RtCX9WcDaV4JGHodItvg5ynZkdF10QpeKjm8rqzKpwwp/1OgPxqEX3KO9CXI9nmn6qmKoiL+UIMh8Lo01xOCG3TJqIOwhD3inLQRFgtoEGx7bPa9JXewcVZr1Jbr07j+wuY5tAD+6BAQwNnQv6hXTYLAutVxhSDhxCArnpOwn9qt0CmT0AFJcOwHWJx8BVGm94kK7MR81+hL5s/78igZvq1uD5w94t4IQb9SSeNFLH8y1/KgmjFb2KGHn629BDIEu10mWMTUZAQaWVBWFTk8L0WSRLWQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bc284d-d1f0-4534-0854-08db0dda8627
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 15:54:01.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh1K519C4mJmFcli9cibplHnHkcUQCxDU+cK8IdpeMFs5RBd/1JB1bw4mPu3jZPs0WtrIRZx88Fe1rNUM/VCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130144
X-Proofpoint-GUID: qrcQZM6MDdhGNdwL5IChIRwgYw0eMKnj
X-Proofpoint-ORIG-GUID: qrcQZM6MDdhGNdwL5IChIRwgYw0eMKnj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
flamewars, so I think I'll leave things commented out and let
individual maintainers decide whether they want to reconcile
contradictory info or not.

And if I'm not doing that, I feel I shouldn't really be adding SPDX
headers to files that lack them, given that I demonstrably cannot use
MODULE_LICENSE to tell me what the license is meant to be. But if we
can't rely on MODULE_LICENSE to specify the license, and it seems like
we can't, I'd say that it is truly redundant in those files that have
SPDXs, and should probably emit a series that removes MODULE_LICENSE
when files have SPDXes, and comments them out otherwise.

Does that sound reasonable to everyone?

-- 
NULL && (void)
