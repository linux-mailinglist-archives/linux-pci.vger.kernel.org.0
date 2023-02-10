Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B671692643
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 20:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjBJT07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjBJT06 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 14:26:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03715C81;
        Fri, 10 Feb 2023 11:26:56 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHwe0v007763;
        Fri, 10 Feb 2023 19:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=krTIDBABHlmSa/l0O+CQcQQR8850RWNPTscVRJaHohM=;
 b=VhAp/vGE9NHMVJsDzKrWq1G/Q0aIQ47TDY0F332kbBBqo1RMtMhnt16cKvjzptEQ81dG
 RPSv+0JmaSLVMUSa8TACxySyumb87rWIaj73CKOp+nHvhwEeSWZfkTEMLmphIAWwp+e7
 djuU2pCjkth9rBACS61Zx83FCxIUKPd4ha0MiK4/BHNDlptb1t7vURJsdRhaGTJM5qma
 VxfhSInpDayJarZ3W61/D8Oj5CC86GN3KmtfWShERgd58ISdr9XeHxnhLpGfQYxs09OE
 uTDcfKFbvKd2EWd/GPkEUKcjKsU9OFi7iDdppW3UBmuBbFBuBsrfWb1OWPwdHmMHtiWh bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdx14p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 19:26:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AHnInd013640;
        Fri, 10 Feb 2023 19:26:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtanv30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 19:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew23hdYuujdTKp/VUlmhYCx/xpz3YyKSYrbpZCBop3+K3YAJ0m+Her5nP9qzqbjmnvcxtdfAaUKaTLaQwSG+gk4jFo17hFzSUyFXgkqrMqMlQ6htf7C8QJs74HawrymynG00BSXzwtS61+uLxKJOewAZ7VeDBBXN/ZTwrMFNUZH4MhtYFQMJy+HiU9T6MGY7zab6kWKabryJ5DAaLv51giCI+fi8iswoldVhS4obbuGXVnk+x+QOtP2u9uzv62JEuNa49NGkAcTbm7QtE/FBLJLukIcMqBKVRqvDojfhiL7eQnFlqVuedzyTMP+wtpGLL9UTEtATbFZHLhuWrVCrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krTIDBABHlmSa/l0O+CQcQQR8850RWNPTscVRJaHohM=;
 b=POA/Nb5FZzOSjl07io2XZm3kJiujM46W72hhk5Kodi/tgLfStIN1A2m8aMwCozKN63t6s8r9tmL5BVRiVZbOHn63CPnZByUg4DgPGip+Hh1+g6WiHAaVl+1s/dhwreJjyLU218wUIjJT1ZSXcQ+hNdmVFRNnsP5qvkYgtcTnKaeJz9Xl8krJ7bNq0P1sIGf4LnB4CLN8U0vp+ylHIcWdtQjfHdZq5DVnyElcw/mHwG2FGdl7Czbj0eBi/MQpKAN6F2Cg8/1K2nQ83E6Vb+j98sxZbBioz/GHW6ZKDNbs33Df1XVPhJi9d9czwG40GIHKi6qVpfs3hv0dpVR6jKfnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krTIDBABHlmSa/l0O+CQcQQR8850RWNPTscVRJaHohM=;
 b=i804xBbRrIpxFB1NGkDyDcwZT6pPfnhetn4i/cGzB6J2T1ThUjeD0aD06XQnZHIupge4ZNoCzIe8bCvZQnbAPawKkwzGmgacZ9olVcmpx++bu1+Dm5dsJBNL5/sph9EIqQeH57tjRWXX04RRJBwyIo4atPCxYmkd8nagyJaGUmg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.5; Fri, 10 Feb
 2023 19:26:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 19:26:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
References: <20230210164749.368998-1-nick.alcock@oracle.com>
        <20230210164749.368998-9-nick.alcock@oracle.com>
        <Y+aMh5e9bWaTphiZ@spud>
Emacs:  because editing your files should be a traumatic experience.
Date:   Fri, 10 Feb 2023 19:26:38 +0000
In-Reply-To: <Y+aMh5e9bWaTphiZ@spud> (Conor Dooley's message of "Fri, 10 Feb
        2023 18:27:19 +0000")
Message-ID: <871qmx1fv5.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: f89c8994-3948-442c-de5a-08db0b9cbdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqBWwP5wc6k/jzgk5ZOaFbLnWfNNq6tqgjSCjs7bnpG8iBYQyrxA9WTmP+P4rBGSikPdJsUPpsbD5QgOfRQ+r5ZcAGi4u2CWzK5Yf0Jh9GeVXK27ZzfSDJBB9jWBdb0HTUsGmuPK4ZamEG0RU0lMp2Gjr+jQYFVSW8V9XVujNVLJ8OuNNyUbEP3rMrMqHVGdnn9NH0ubX77ibi/eTPpQaBZjrJuN2iEhh4OtqUfIQei8ntWVrBazIJXpnIXsEuNvSsFi8TeCuIQRD/z/SaPJn7cUejCjm0T4awstt4oKkr88E90ybvFN7QHuvfI3WLsfKc61DO2xqKn6mNnPT6v/yT3faeuvcU/cy8qm7tMWNFivZ6ELxBylckHUVuGNBGnkC9RiMfg1RSo785JyTu6rAHqbIifnliWeaoOBLOKoqlPATDgv1ib1tmXEj7l38dUxn8M4Q6QXsAQF4Gvsluig+/BgqE2vIhHriDTcbSI09/+tKzfAfnCcdt5W7O6llGLI4nzPxOWMkzujFhXbMElkD3CX/nRJCzm1xq9oXl19m+DeLv96TDWM4U+6NJka3Ntmx0elL/JFYSHkp/1Ur2+2nsG8JnSrkQrZ8R1eyZDAsKWfMePLwcRpYneJ4XymBZIflMMCw/MNwQTr4NlcNAdHlYuDW5dzjOAD9sEc7eeRHos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199018)(41300700001)(6916009)(316002)(8676002)(4326008)(66476007)(8936002)(5660300002)(66556008)(86362001)(38100700002)(36756003)(66946007)(9686003)(186003)(6512007)(6666004)(6506007)(2906002)(44832011)(83380400001)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dK4aO6evb3n+yY9LVZhWTp09Jw64b3XH+8yQ059w5XcAAGa4zjyzwxJKt9ho?=
 =?us-ascii?Q?xvKUg0RcOc88Dg3Op/OFPmUsgY+tfUhh9y3hYB4QGg/SeQoVUx/zDmhfsEn5?=
 =?us-ascii?Q?uB0DqwESoNmYhGI66UEx3j7UFFrfJt2/53gu2zfGww4iTRcu4Um+Z92ouvbu?=
 =?us-ascii?Q?zxmR/ETpmDS6lkNdUV8xcdB261da9/UymKbNCMhEFYRQCjinqRIbAph9viMN?=
 =?us-ascii?Q?Uy3qnW8VjI8ApYZT2h+ZMLNZDCg9N7VYjLoKw2jzwXYwi+Q7sxC6gFN6ECUI?=
 =?us-ascii?Q?kFTEkWBgGIs1EzWgeMTpwB4eNpbGe/bf5jwS+qNOM5zfk1GhzthGvVR2/jSZ?=
 =?us-ascii?Q?aeWLJ6dte7y91WMYG82keOe3ss4Z0jf2VCHawhhg3dSfvvIg2Z+7utVtsLyW?=
 =?us-ascii?Q?u54F6B9lhOwqgQxdkxeHzz0dgXTolf9ImkjjAd0ba7cUPaOohzZ4H/BrUb/5?=
 =?us-ascii?Q?sJnpgVK52tIfHxaa79fXKR79J0PvcSYLRbpeQdML4YRIiLVv09jcWpdJbTBg?=
 =?us-ascii?Q?o0RzYsMSfU86Au5mul2IfB1YRJWHs9H7U1QZrIUbGmHP1oE90+R+CrT9bZ/E?=
 =?us-ascii?Q?YfPUtBuCyQaITeiWo6cxueWWw91Cl3ArCfhESKMbtQE6/HPb0+U59SE58c94?=
 =?us-ascii?Q?8yl7fhuyol0ltQHgLXUmG1ZLt9/Kv2RVg7B2tLSPRdKHByfZWqpMwD1LhtPc?=
 =?us-ascii?Q?ASE68gzjk/0+dOQ7rXifTg927QbjILNHJkrE1yeQUnZ2HD2Z1btSslg92+qC?=
 =?us-ascii?Q?uBnNc9tcf5MwxViRU473Da4mB24HP/o26QktbHFIHI2+v2QKa768FHpR5n3g?=
 =?us-ascii?Q?StBpIEozrh48pml4LXiuC2N8IvRovwvyUXYxGVemSKwD99JCSq0SaLA8KNIj?=
 =?us-ascii?Q?DUg7sEsHkLoL7fDWu0natf8SHWtU2YUgdnxDdJJvRircB1bTddlWrYtkFMC9?=
 =?us-ascii?Q?NVXn2vgpNeC/hPDmQqmtloPy3EKjmO43OMvrxkuoV0s5TgNK+Bmp0jrqztcF?=
 =?us-ascii?Q?ZmIM/GG94dkDrvsNosafLTERu+aN1V3kVY0Q5QVXe4eblQ5vj/YtWpOAPW8f?=
 =?us-ascii?Q?M4VHHrz32+nT1gJFZg8cGxuac1PE0xtZXpVjS0b79651bCboaArOv3znb6ym?=
 =?us-ascii?Q?WgIga/4dHjuSvYOABa/OgkNsfQFzViJMKgBpb9ufNdj42aXop9Tt8AvY7/0r?=
 =?us-ascii?Q?sW+vHURU9V7g3tFnLaIoHMYYWfhEH/3i9kcpX2hL3ceTIyo8QY1HOyrY6Vcq?=
 =?us-ascii?Q?XHpKRcrLAKoEokA5ikvnN6W3s1yF4GT06lkYG5Kk3nFUWwREMUF9jESVogYL?=
 =?us-ascii?Q?/ydIlO/vqJZo6pOpBjIbd6OZK1WqvVR+5hFhwgHBCV+usCnyrvZjbcmXvnWj?=
 =?us-ascii?Q?Uk+Pia9+hrjv+QLYaT40kgLbwlC3Y3yLY0wg1aD0o+h+q7KfCxubzj9IV3CP?=
 =?us-ascii?Q?gYw1ufyWI+BmtZifZoZUYA0Ei5S/76Vi+ATT24UBDoMB5OJAIDOGs+Cvdgnx?=
 =?us-ascii?Q?C/9rrfY+PennEjZ81GRJAfFDi9y9kSn0rBI5oG4i1x4xR03d43ubRiLzp68b?=
 =?us-ascii?Q?jIpGLPkMCK5MsBzl6GYtg+Wf6Tpagvva+53M8Rl8e1m2zeVwlq8UnZbuXg3z?=
 =?us-ascii?Q?sO8hMAI2yxFRvGHesYGrqRU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M8i3eY3vUvtcWBtHkiDAR8aEWTWrcJ8CQcyqEiwtTZ9Pv0mO08hv2l04fmjhfUW6fXnlw0BM1gmNfQfDsT7wrKTsj0PgZTZ+271G6Y0BH7lXO7jCzhICVM2iIfXJ5DH9yG045ycNYmdqr6ghYDZGLkb9FThozbrX5T8/ts+fg/Wzy+wNBEkTvYeNvsLJ2vCMLprk2tC5avdJ2m15dImDzEKsELUVagBgeJdAsc8FWViE89UBUVps1HeHPUUIZt2/9yPzsfzSLGa6HpQrSS2FzV4tsd1F8LbMvodu92QaWCMO60m+OBO2cq37trbPhikfIH3pIuDa9TKsalrcao7ahHFW06khZa0UpaFGHaeutgnXK8gS/PHWOzRJiQshx6RcgxSw/eIAmhUbTcAmcGVchddXuEyjkw1mZY4bUI+sZtqjrTWNre0qK+FcUaNVmwryY4h3ICUfXgVQUjDxNdPZqmTF+jRwRrvP6pRNY8SkVdwP0XyqZMnv92gb4kfArRRbmctCUgACvkfofJTZfgpJ9qbz+qrq5KjkumubNB6fGtniRHh8vKBU3ysqVAvGG/SEj890jZPaeuTNx4SDXLNS0fgugqq6+xfJa+RCKhPmGS8vPz7kGAc7UI3D8hGxv8917GI4ua96YhxuCAXaLcSav4mc7L06SanU/UK1oZAsvR71iMUl9apUb45PAVq/fnQMDCgASXpJAZqoyq+eltkv8bGrmiwzCDwuQuVvoj+EexFjMFMgqLmvoVabe14Wq2ZAXQqphVfuD/YLp9BaLA9Z4/nVFPn1ncInV7at0eRuUAs9DmB7VGNzjzCbV5bnaN3HZlggDi6P9PjHvaCYoZwGqQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89c8994-3948-442c-de5a-08db0b9cbdd8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 19:26:43.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kw01YFB3fMeMRXbq2/u54djgbhoSIIdX/C61+FYLDQuKT2YiYyplCkRrcfnu3T4JyOA1iHnozDELPBZQZCSyYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_14,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100164
X-Proofpoint-ORIG-GUID: FBpmXufFMkng4JPKiHeDhV-P9913u42h
X-Proofpoint-GUID: FBpmXufFMkng4JPKiHeDhV-P9913u42h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10 Feb 2023, Conor Dooley said:

> Hey Nick,
>
> FYI $subject seems wrong, this is a PCI patch AFAICT.

I'm deriving the prefixes automatically because there are so many of
them, picking that prefix which is most commonly used across all files I
touch in a given subsystem and which is present in all of them. So
the PCI: microchip part seems right to me.

kbuild is present in every patch in the series because this is a
kbuild-driven change (the thing it disturbs is part of the build system,
the construction of modules.builtin*). This seems to be common practice
for kbuild-related treewide changes.

> On Fri, Feb 10, 2023 at 04:47:49PM +0000, Nick Alcock wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>> 
>> So comment out all uses of MODULE_LICENSE that are not in real modules
>
> This patch should not been needed, there's an existing patch to make
> this a module:
> https://lore.kernel.org/linux-riscv/20230111125323.1911373-4-daire.mcnamara@microchip.com/

Excellent: if that's likely to go in I can take this one out.

>> (the license declaration is left in as documentation).
>
> I don't really get this one though, why leave it there as
> "documentation" when the file has an SPDX entry anyway?

I was asked to. (The first version of this series just deleted it, but
people were unhappy about the outright deletion of what looked like
license info and the loss of MODULE_LICENSE while other MODULE_* was
retained.)

>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: linux-modules@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>
> One for the future:
> How about also CCing those listed in MAINTAINERS for the file you're
> changing?

That... was supposed to happen. I'm invoking

scripts/get_maintainer.pl --email --m --n --l --subsystem -f $files

and then parsing the result for maintainer:, open list: and moderated
list: lines. I thought that would catch everything, but now I see
this is more complex.  You are there as an M: line, so I thought you'd
be reported as a maintainer:, but nooo:

Conor Dooley <conor.dooley@microchip.com> (supporter:RISC-V MICROCHIP FPGA SUPPORT)

I didn't realise that 'supporter' was a thing and thought
get_maintainer.pl always reported maintainers as maintainer:. I'll
resplit the series with supporters Cc:ed just like maintainers are.
Looks like those are the only two I need to pick up.

Sorry about that.

(This sort of systemic scripting bug is why I did a small tranche first.
So thank you very much!)
