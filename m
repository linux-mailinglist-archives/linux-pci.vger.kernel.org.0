Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC106939B8
	for <lists+linux-pci@lfdr.de>; Sun, 12 Feb 2023 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBLTxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 14:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLTxP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 14:53:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85E672A6;
        Sun, 12 Feb 2023 11:53:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CIq0OX010593;
        Sun, 12 Feb 2023 19:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Aamssj6bWIrT5YsmBF5eGQNq+0DEEZSluZDogH+dgG4=;
 b=D0iE2oi4dKdjneVHEIO9hID1YI4FEvbr8lObRZ+KP9abzI3M4MRetPlLsVkAooGig/wq
 hVfFl9TViK2Bugq/lPSr0ZPFWfPRUAcQN1XzWZWC5eLD/bNJcsesAYuHQSIAFBfhtye9
 gefUbl8P9aASWwdwlkl5OJBy3dIxVUo4XKq4ucgbPV7TBjX0fGVGdTXhMo34Vblelc/n
 NZew6wkUI7MrHCYQpVG/OWlrwp1lxEMiq7JHeXXUmZg4B3cTblvGGBclvVXalyNfvAJf
 BN61zl4+5xaKuaUIbFvtWD+LlwGZlKMHQy6/rhX+VqKJEtQ4WYOjfKWO14bhYJcWILho XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2w9sjbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2023 19:53:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CGXpMe028882;
        Sun, 12 Feb 2023 19:53:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3b9ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2023 19:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEg7p5jjUAsgSRJrByPly4h5k2UiXRhFd/jUV2GVdyh9/DS3VVNN+Y0yQhjEiZ8+kWpttBAHah+zq5OM/qJOR2rPZsJ+V/NnLlwoi0JmIZifwPeEcgYryYpfSuzWlaIHQK9nt2X4gcazv2e/ddITj1g8NSxiQzY8kM13ORh4JWeaUmdjDJ/drCULQk4ABgjNFpc9tyHePPKueSWVRzfDgte0oQDerLCSDqveBxa2wus0cZ/rJSuJtI6aJox+F4eToCnFYFynkwRKQ+Hem9znWzDXL6rnTnn3LEjFCD5ZQQtycsrB/pIFSKY6rZt4OaAU1k6zEQnxSabWSgruB9OPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aamssj6bWIrT5YsmBF5eGQNq+0DEEZSluZDogH+dgG4=;
 b=gzpnfe1tDiZ0ErZjZs+bqfPKovpFC2yADeMfZY54P0Ss4lhFV9jWz3cnJI2QYqPz1ahfrhWiPT4PdcMsPHjY9hx6aihFg6UUyBcDdwfaKmoWSmF4mqgW5Ey5a82Dx3cs6BaFKSDyd/D+S4tOB+oHM2lOZICLdxmY8otF6z86atmxiLPqV+xfB8KwdV/Q6j0C+dKcpMcx2Kt625f/WfEdo4pEg3lk2sseWuQbl8IQudWNUYvaSl9icf6ZAoQauhEX2+YmaRv8tkozGGRCj3UcjsEaSdeZvcmZRj+6644Iq9TxHwaUk6+EjFvqPSl1f0W9jhEN1FSJEzrYB+elZmHrPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aamssj6bWIrT5YsmBF5eGQNq+0DEEZSluZDogH+dgG4=;
 b=pigUfduws33xcHvJlY7Oaep1IHZo7rWIxFG9mkPyJetjlfUMSYLhsp+6MnEdApBuHemeb7iZiSHk1/uiu5mdAGxD7xaBn+pvFc+hwqnosUCyRfTA5sLqk+7OO/JYCXD6MWbgm6VPTevYEXtQ4pFPuwkLLyNTQDcN2uvpEU+W6Io=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB5784.namprd10.prod.outlook.com (2603:10b6:806:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.8; Sun, 12 Feb
 2023 19:53:03 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6111.009; Sun, 12 Feb 2023
 19:53:03 +0000
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
Emacs:  the prosecution rests its case.
Date:   Sun, 12 Feb 2023 19:52:57 +0000
In-Reply-To: <Y+kx3fb2Lzlg+u5+@unreal> (Leon Romanovsky's message of "Sun, 12
        Feb 2023 20:37:17 +0200")
Message-ID: <87wn4my82u.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: b015601a-2bca-44a0-d20c-08db0d32c036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcJtZaVosJJpkxpDW9XPOUff1JHa2Ipn+z2TZYbBJZD7i7v09y/x8v7nUbr+mxWuMdctra9qH7e0k96lq+SrYToFWHumCmUFV1VXSMghImxBgKnx9IUotGftCPJDUkY8EZ3S2CZI39s7ZK8Eb5yc+r7wPJpIjEfbS0Qv34SFnZ6wEkGLlH1lFsVoOgdC3W8FUuo/Q2P9CrXCeccz6Szefcs8Wz2LHc6ZyumF7xJX5V6Nozuirr3ExFIyb9YBZ3S2IrICl3V7uOXaN7vqxhcbVF9YQ5YA8ygDc3MIPDUsIwbNS2YlT0CRMsaIzbEymkYAatmNcFPqZGc93TPf0Q3oC65gF3pK5bMw16U4J3BXGwKfiHD/kqV7ij2TIB/puJz8AE9EzOMC+8ItTKtmAFw0KPWFuoHIgBfJeJynWAy0pDAPR/UauGOsozBMZRL87NH6vP7tJ/0P/opKtxyBfCDMEEw0KAw4N8wvPODw3/xjaFwCt2SASK0GuCT+LjUV5hevGImL31+H7/lfC05FY+D8VXnkbOlahQPcn8DdqhD+qGAeGZmwUCQCV8jJLWjee5wbTzydkxCWmRcwHWXLZ6lwdviUg53Gs9eFn2YBQhgfnuB2b7Qyk+9bkbEDUrI3vKMZCNa18y0FsPxdZC8+9wCibw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(2906002)(36756003)(44832011)(86362001)(38100700002)(316002)(8936002)(4326008)(66946007)(6916009)(66556008)(8676002)(66476007)(41300700001)(5660300002)(6666004)(6506007)(186003)(9686003)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBx4T5f+gYXoxexmyRFFW5VG4B3fOa+j79RBwcnH7pYQOeLdfXCjjeZp5awh?=
 =?us-ascii?Q?PNl+/VYCbCQTkt/69rGXQBFPwVS8iJsGG/kToybO8vu//jk5Cc5Hjh2nuV7Q?=
 =?us-ascii?Q?r9RY2cqFCgmgTUJ3q0SK9pcUtsJtwmJTmjP8BmU3UyQ4uHa+hjLWlyGbFeCY?=
 =?us-ascii?Q?iHeldsxftnn/pPH3H5reRJorE40CWks9+ItPqIbwgXIt8J/Lp9GnoVAtQx6S?=
 =?us-ascii?Q?WzWQi37kcKSjfqhzesGCsf2q/7BwyL4sArnY54d4WtcqcMZW1bf46kl2SDuY?=
 =?us-ascii?Q?ab50ZBAlD8AiynsgLJIqBiXwJSVVvTALhoOGIg/oWXtAZLFylBPpSeM/NGlV?=
 =?us-ascii?Q?I/zSxpDkHa/qs6BkNOCzUFTWQUbHE5gnY3bjVf47Jf6ZBtvlSWoHaDNdSbSX?=
 =?us-ascii?Q?uqXOU+Gx+bVrMgTAe/0r+G1pn/nMm82RQVO2+c9sN3YmqElLHfjaCG6ja7Y6?=
 =?us-ascii?Q?+g+oLZP/tHYYn3fDTG5ZQNsJnhUG03lfqavi18Zk/eOusoBaQZO48dgj8Zpe?=
 =?us-ascii?Q?qXp7dh9stEfOb+b3TvxXFAZIy2WL9+WZnyRO2jvI7Vj4NVxQMdBF7z4itNFE?=
 =?us-ascii?Q?jUEbbtdWszsOExsfGfugBbDMEc2s2yypLIILdiO4EyhLuFm/COMslKMJe810?=
 =?us-ascii?Q?ECuUp83FBYOmAxe7mNV/pv8TvG3QLH1nzi04OU1g2HsuB6w2LQ0wwTVdOUCw?=
 =?us-ascii?Q?yRakbSAJPsiYLLyDIhMWsl4NlJaSQZvLulGIMbOVuSiH4EOU26V+WcTL23a3?=
 =?us-ascii?Q?+ogim8DzIjRQUa16st57NKQxJNuD04yhh/qo+f8Pu4Dz8HThZna4EneGTCur?=
 =?us-ascii?Q?aSNczXqPZ4QlsjFAAsIo6Xyo6XLDcKNdogFgGsac+I/gHop9ntXw/vNeE0la?=
 =?us-ascii?Q?uW6y0QSerRNNGclyg6oTn01qq2dWD5DniBagGGSgYGFSfWqR1sv5HTDMlahd?=
 =?us-ascii?Q?Va8Da0kGueGQmpXtScFx16ytKSbCwv5IeJJzy/e0ktsZraGdevjMi6VP8/I0?=
 =?us-ascii?Q?QfbPgtv+0o/NkVMRynokEvLWvRcYb9xJ0cq80J8A4tPV0II9WzVz01Vx6RNV?=
 =?us-ascii?Q?eobVgccoKwxu2ra/GqlFl+tVpYzlRukWFIIIc6063WB5jcr5XohvWa98b21K?=
 =?us-ascii?Q?hC6zrPwG4BwYznkTVFn/KIkJ0Mlu9CjYjw9hJOSPp9mpzPzOJ0lIzEpDQdUi?=
 =?us-ascii?Q?QV+Qe3rKLxalhQf01BWr2ytM9JUnY0lP5TbKwYH3oFobXuvOnyZM4NDiveA9?=
 =?us-ascii?Q?Zbr46kK2MtjBz2W+6pf1KMm8Vknq9QzucChWcUv8Qk7wiOpBPtQq5b2zZ/aF?=
 =?us-ascii?Q?GUe+B9BIqYp6NyFrh/k+9bLcWmtrLpImJtLXxB9sitBqDNRfsBDTapu8CHLl?=
 =?us-ascii?Q?Bbc2jcRGB3Olzc40G/jyUnFO9MSMq2H7eHCSmZKB3Vc4fq/hvu5UPNWboEkZ?=
 =?us-ascii?Q?AgfggxqNWUS5yarMa/xdveLBeygWpnmvK1aF5sXHMJf/za+Ocp934q6B6ioK?=
 =?us-ascii?Q?7fDT8EEJhkXLIEprMrcTCckyu2ww+NCw+DBbcZAwM+49Xa+z8S/k3QPfMNvN?=
 =?us-ascii?Q?uqSz8B4Or+SQWWf1g0qsFJijJG9/1zcwBhqx71a8Xj0eVu2ZPqZ6Y6jckxBY?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VGyWcSPu19J5RI/zCTunJsFwgtXpvM6jfQQsJXv6UP9M9mW9l/VnhwlFUzB5U9XGmGIFdlBqQpmD29Q1Yzz9+XyGIYzdnqLgXZMW8IzRufZ8NL0SyKWRjkTVLlKZ2lYtzCWGPmcKqa8aSoofyffwOKpgEM3xYMoPTt1mUzvt2ey9KaoKTa38W74RILqgriGF1nLlRruuWNIuw/XyG2m5yL15xaRkcJGMDxLNzJf93Sn9KaVRrZDWfxaniM6zOXbiYareBH3RI5I/yaF/xuGCoqvHMtB+2MhMbb3vq5zDivspBed8Oz+e6AUg2mM4Z0ssJjbZl9CVb89PGtJOHsNM8Jo56J3aQ6qNdHhqCNKjwAFCYaLXWaUjBJtUVlYBW1i45EmjwGriwMtPmjvs1X6lOHadzhsIl4JJg5KH+IIGWE/1fQffbHPaN2ix+m2wLvMVfT6mkII6CpU+t07I/ZD9OmQujfDBXzY1nyKdjZIPqTc2i9/4i/7Pj6Zpi8z3rlgAzh5pLqnL46KmrIezl8z8Mo0GE/xpD64VbC+QM4nkrQWwkPStWmZuFbvORxvWTHANd4VJpl+WgSci9p8Afd2F17KHPkOqY7VsTqf/SYO9Fm0Iv5GtRb2SKKfSRkK6XuiBa/IBcXzIGqKM7E0nae7GJeAFbgGbHvBoO1O7yp/dVaA9jp13diYb3tM23qPNARB7an9/SxCHYisUjZlujG+uKYhyXHJHyN7z14KkAzgZNlKNTa/UQhuSb+T14xGJvYToPLn07lRW33QmZCEnAWRknPQFUBFctJ6zaaXK4DsDwI5dmSIRS20wi3o6pQVfGKQdgJCfa7Hjz6fDeHH8v8V4Cw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b015601a-2bca-44a0-d20c-08db0d32c036
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 19:53:02.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4NWF278rVyadcICBWvI07WxxKOT/5OqmMz+Pd3stcW4+hwH6Ia6vZlwuIFPMn1/EspRX9nhb7InM3CYfYYGQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_09,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=784 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302120181
X-Proofpoint-GUID: E5kbyDmLX66JS_0fGovJAv8Ap074oiqr
X-Proofpoint-ORIG-GUID: E5kbyDmLX66JS_0fGovJAv8Ap074oiqr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12 Feb 2023, Leon Romanovsky uttered the following:

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

OK, I now have two votes for removal-and-SPDX (you and Luis) and nobody
suggesting that keeping it in but commented out is actually a good idea:
I'll respin with removals instead, and add SPDX to anything so adjusted
that doesn't already have it (if anything).

(I'll stick both the removal and addition in the same commit, so there
is no point at which such files have no declared license at all.)

-- 
NULL && (void)
