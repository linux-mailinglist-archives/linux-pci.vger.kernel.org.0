Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BC36993D8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBPMF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 07:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBPMF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 07:05:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DE959C7;
        Thu, 16 Feb 2023 04:05:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8FroQ020165;
        Thu, 16 Feb 2023 12:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=95e8rDq+apX9FrXY/4KW89soKvYzCbX49K3apwoddkg=;
 b=lyldH37McxvFJWWxr8w5wZG9PMs7bd6R/thEQBL5pdr7tMwbJnCG3YHUj1SbN46Fy9kq
 o89B7e7fy1kOaG3Ym4szFIlLzJwm3upOugzY6jA1SEWCl4x5mwiuLfD5bqWFUUPwI7l8
 CM8FWLVZWiHm7+zC7aucy8sr6Z0KjHJLTvWoL9PAuMsNKcfXZyew9sjs6VOUi6JPvnLV
 wIP6V1ITW98CgVI689NFR68gU1OYTOUSAKhd46RBpqdbtIpBYe4nwgyk6I0af3i5XH8P
 0OiVt7cTtxhx/eqw6jQ9S+I/KWb86mIYR0zXhGcau+lrrduEdGi8aVTn1y4Wyn+elu+s Rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtjxxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 12:05:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GAcEhs013504;
        Thu, 16 Feb 2023 12:05:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f87vw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 12:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHW0DgWtK9ER1vPHRnMeKFMm3z7Kgz342IrmhM71iWPQul7hlhi+IDZjgZp/UuH7qR63GQjk8kFiQ/fD+6Br/24wbiSj1x4CjaMasvgI/vr9KaWT9itd/SqdxIoULykfZA+Hn/tDVqrQLSrSngrCfW+kWcE4u7Cr+pUx37JEY5TfIfmeUEYQvTt4CcvZy1czOxosobWWVMWYU98tGZkse9e4G8lYeFqRADNHkywCfatpbC11HEYNmMGmh97wc4FYA52X/k3PX65aZG0G6o0s4DinU6iBPHNDn4AopIfbFdJ/tiRLBl/+h+Gs1hbjm52kEEr2dI98LENw1JWz+pnZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95e8rDq+apX9FrXY/4KW89soKvYzCbX49K3apwoddkg=;
 b=hvOhyNIkiZ634qIYTxpkMFwJd6qWqDLO64IGchVKbhMPMF0fhdIpAeJi6x7/dX6pHi6oid4APz0j+puGAWI/41Q6c3cpbndRI0zKJanVxmhzagDHqavuPUeAEtSOYf5KDB88XnvxlOyRVpatk7S24yb99W26xSyZFP5MHZJRS3ELigsc+/ISzRL7dpnKJYeW3boOEOIQtbpxUHzA7YChG27D4c30PiOWFBvisTMqe1MfwjEKhzjAfsxBw0VII5fRubCyeLl5d9ITnXtStDIf/cZ72ZEYHNZsYoSWwQ3W7Qw8I1lxqwcRqDCPVEB3UIGAIlAGMW5fZr8GPuzqw3Oqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95e8rDq+apX9FrXY/4KW89soKvYzCbX49K3apwoddkg=;
 b=o3zP9HAG/xkJptu/K520qU6tnTAdrySmhWX+P+saAuPPi1IMyD7FOjcOeNfXDJeDwij1cD4BOcTLM6CTEts4mNDhkD4rR2XZwY1OYDHK377n8R0jRxaMkLHIuE7MHXzHyeGu4GYOjFN+f2vMnHiBHf5B+jLCxZvOAqEcIg+MyJI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Thu, 16 Feb
 2023 12:05:13 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 12:05:13 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor@kernel.org>,
        mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
References: <20230210164749.368998-1-nick.alcock@oracle.com>
        <20230210164749.368998-9-nick.alcock@oracle.com>
        <Y+aMh5e9bWaTphiZ@spud> <871qmx1fv5.fsf@esperi.org.uk>
        <Y+akw9VBjg9oZ7QV@spud> <Y+kx3fb2Lzlg+u5+@unreal>
        <87ilg5mq0r.fsf@meer.lwn.net> <Y+qOS9fx9B3Y3gd6@unreal>
Emacs:  because idle RAM is the Devil's playground.
Date:   Thu, 16 Feb 2023 12:05:07 +0000
In-Reply-To: <Y+qOS9fx9B3Y3gd6@unreal> (Leon Romanovsky's message of "Mon, 13
        Feb 2023 21:23:55 +0200")
Message-ID: <87y1oxvmrw.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e58d848-e170-4299-a7d1-08db10160f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n12z/xszz+lQYu/vWQlAnpqftZfAvOdPbwLuMuMKWGs+zCmkyy9lJXBvTP9EYg0rHjMLSE+EymZTyJoHd29qUURH/2VovENpiXwEDrAO/vWiA7ZZuUcJ4ZRlAIVa+Km75VZncCcrUQNQIYUPmUgGEHDb3wNEI+4FfWU5TNP8l/h4GyL+4tFsITqhE6gtn7SHvIYaRd8qhuCjxnZ1FLJ5UWpzN+AzeUNV7WCapM4t3Ec9NDB3UYII9szFyuYDvbyaMMYD9+WIIDOX19pnFj3QQ0EVY6ZXiJwVsH0LkfQKeRyj8m+JlhmVzwwUQ2MuyoQbfLJS9kbHaI3q5us4GV5+p7SUmdmUjXvs3XqgJMuACZsW0ugB9qlqIjXcX6poezrvS6qd9e1KlYtEv0OyDRHCEnamlEj1ZZsjv+u9CUNK2eXcEqvMJ9bcbN9I9sSVr6TSMc8eQLeXlbyMrplK4D7m+/PRksDkx8q8+ILXsEzRBaR5hePW4FF16ozD7PfK12QqZrI9ELNUxqrMyrkEAQEDlP87Axx2gNGavWNnLg3MfAz/LmwIoab8RbjK8sR4c6MAO0Yi2uXbXQT2sYN6llc4edecZjAqe5DKiX2ljLuSvMw2Bm7RKCFrqvsmkLwkZMa3IB+BYkZx4ESTD39Djjyv9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199018)(66946007)(66476007)(66556008)(6916009)(6506007)(9686003)(6666004)(186003)(4326008)(6512007)(8676002)(38100700002)(2906002)(86362001)(54906003)(6486002)(316002)(41300700001)(44832011)(36756003)(8936002)(478600001)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V6uadGOw0/PjYP5sLaumiCjeXKhZr0hmIIL9TyMOztopcAIyg4P/7RwYZ8W6?=
 =?us-ascii?Q?7ET2hm5YbFajVoQ+Lkc3Wgpk36bBRhojTMh4TWFRT2CZkC+fU9ci5naSgOuL?=
 =?us-ascii?Q?ctPq53ji1f+TJpgTZS4f2BVlObY1e0QQQcXk90Y68mzgMNKB054Ejy3tOwbU?=
 =?us-ascii?Q?scP2/MKQWyVmq+Qlc/HmjIbDRIvXJnLGWEGZ4BeToBCO1FIYsaef+oMIJHjP?=
 =?us-ascii?Q?E1N3PGwacjURekm9vhMaIrT4ih5qldBjrILFzCvczLwTBoqveN1ffU2lhEY/?=
 =?us-ascii?Q?qKB8TCFWulG4O7kFJJDYDzvorsJTZckOCG8TmkXn0VH7v1UurRv0fojkHClg?=
 =?us-ascii?Q?nZ66Dj1yKMOs+cVLOMv4YJ3BQyRM13RcLMRLmEyZiO8duVVRJbAaHTfeMay9?=
 =?us-ascii?Q?noLNOkY3ahwg+ATDesWktg/WkZr6HcCHMVDhCwfN+9pNntOXPvLYrKsNcOrF?=
 =?us-ascii?Q?FVHFU+nhFFxxc2iCouIAnFcxKqqAFJ6TC43oDZCA+1jQfE+Uv+ErZw+fvbIN?=
 =?us-ascii?Q?CFj+auZx1c5Kyk3KludbghCm7BP+im85ZjmoQSjndYnxpH5grhYSrEEjY5zg?=
 =?us-ascii?Q?nnaFq8x2cjMwRqXyQWCGAlRxTEethJZ2AFiAXismR2lPnHoDiUDRXPIl2MUE?=
 =?us-ascii?Q?y/VUphczdrr8yr3+7WkfxatwEvWAnMx3gXN5E3aAnbK+8fa1SVtcLHSZKmh4?=
 =?us-ascii?Q?X+dZ4rd0f5b9VPUsN0xnvGIQfnXGDBuJkjKKNnT8wXmtsC2cx6O9n/a2pKtq?=
 =?us-ascii?Q?MJLP96iQO3gTOBMHf8rZvCQxVTJoXtzh1ZwZB4PUMFln6pHyVtdxl8tNGRfn?=
 =?us-ascii?Q?qm4bNNIk1BxQsOCIKIh0WVsHSh5TGEzDNWejhosbu25jMp6tFE0ch3m0/jUh?=
 =?us-ascii?Q?CAkLvyABCeLj0FuZGm5/IUafthKcJEJPS/0AAAlmXb4E293t4/tRi/bRo7ad?=
 =?us-ascii?Q?naDm499p1KwrFmWK+Kf9lJ97pNYH9D8YLEcWLZvmY4JZQummIAqBu5vzsymL?=
 =?us-ascii?Q?wXkjU1vMVXWgza1VJecmC4v5/6d9uGVqB5dK12gJkHNIS8ppeqzbioR91Vr7?=
 =?us-ascii?Q?Ui5e9O7+XbSGLrTsK0BQ6T32Vq1kA50xWr8hEhYDxJm+UNmyQncq+dEMVmvo?=
 =?us-ascii?Q?RNTBvB/NcoaTOJ2CzO04th/XZR01ScJry+3zvpNjnxVu0hhukAms2nS11Qjk?=
 =?us-ascii?Q?thQmoL1xhTp253ugXoPogmzkqC0EHVQBy5o0ldjW6MMwW45Lxw36afqhgmSn?=
 =?us-ascii?Q?526V8y80lVQWlEXK6ZsaQ+Eq4A7zWKjJjmvzel2NY50vUAo3rPZ7v6UYQyU5?=
 =?us-ascii?Q?Ai/J+EVv1Y/skMyUerSroIKzXMAjXK0EfeM3xwpvY9ct7Mls1qxR/EM8L2wu?=
 =?us-ascii?Q?m+whDKIwUcEUriJ61hfDqT5+E7peo6jaNthACw69w4c/XWuiQKmtt3cAIkNl?=
 =?us-ascii?Q?GnMuwBSsAsLydJUMsz+JMhtZaGG/lcgO1PGImfex5qP4qI6N9jFFuvhuJfI6?=
 =?us-ascii?Q?syWxEjD4D/OU3R2vtxffX1wY6So/tqV1xM1vILgHMo8rfMVFpr+eSyhpv/GI?=
 =?us-ascii?Q?wr6pxEI518fJ5UVryt8eTfvs+5kbb90IbHvkOojK2tmvv/gSTWMwleHRkB4J?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cr/BgzTChz3OkRThozLxM5F1s3AYcX8RHO4hBKVlIYIRRn78IxTRwINPTyI5j5r+Qv2dnt3gp/eYmRCpbvnvmI99XUM8CWmFNzJc4XgkNvsP5ZXl6GXKV86fRmrZCbnxx+0ooZn+L5hZIA48YO/FnrvN1YiL+ww1jGdpXRr46OQoHnkbgFWPpBteaMg1OlmeoNaWpqK7Ii4X7wCPXUuLZV4Uo9fxXd3O08mdnyv1taMvphW5zK1uzUKJBNlOjvi6+GwrxpCXmFUcoQZ5rz1OY4clFQHtiDxejnB+7lLCYTSXr5jno6b9suWNL1LuZdWzPQr2ilYtG+LGbz6hwRDYN9U1cgvNM/Z4FYHuLoWnx+X1s/+xsFUSFzhoCl+HyLThEc4/YGcHP11pjhWT63zMFPnfJ4KR2Rk1gO8cnHt0h8i4I6Nn2qUlY0PB8Y0VbznuiGPbKTAyrWlcac9A9IlCflZyi87f90WQQz3Xhg/Am2IQp9w3OCbqx5d5yg0w9p6sUYVOqL0sKmUBEht3m5WIcse/aiCZfdfQleooUR/gIGrOM3ukUu2HB6I64AlkDlPH6A2ncmw+a8TyArtQouiRrVIOLRa4nhB5iSax9ZZrGz36FbXJM+cfIekGEfcaDyzC9nrgYa7flEgwYnQephBNoZalkqIID6Xf7e7yBNnyXsPD7HSm+xEj2swrbFFscARzXGd9BA/2nfhKtFoVibt9Bdbr8+QjE7/Qjv9tgJPLSNyVnbLrXCQSwbE2zRkm1yDyQOmIgLlQEJO20f9sAQ2lWU4s62/p8DbIMVgH+ueECPcRMVHZDioAW3VTg7ou4tRNORzd0347yunW9TAM/ae/AUQ536jt6IBv2ayRXv0bIw2f6aGmIq1e07IYUwh13sgt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e58d848-e170-4299-a7d1-08db10160f50
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 12:05:13.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYd/+3JMd7l2ccsyuR6wIUjKKpMPFDrgmYG2aNxa8l+IffaAeIdkRUu3nASqoLUif66oPlWfCcgbty1v0Pq0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_09,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=766 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160103
X-Proofpoint-GUID: YFsmeqTav1Wji5eiD1CweEGubXCk5JKx
X-Proofpoint-ORIG-GUID: YFsmeqTav1Wji5eiD1CweEGubXCk5JKx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13 Feb 2023, Leon Romanovsky told this:

> On Mon, Feb 13, 2023 at 10:30:44AM -0700, Jonathan Corbet wrote:
>> Wouldn't it be better to let this work proceed while making a note
>> of the files still needing SPDX tags?

Since I have this list anyway, I might as well emit it, even if I
believe the general consensus is now to not add SPDXes but leave that up
to individual maintainers (phew).

The files (otherwise touched in the full series) that don't have SPDX tags:

drivers/bus/arm-cci.c
drivers/bus/imx-weim.c
drivers/bus/simple-pm-bus.c
drivers/gpu/drm/drm_mipi_dsi.c
drivers/irqchip/irq-mvebu-pic.c
drivers/reset/reset-axs10x.c
drivers/reset/reset-hsdk.c
drivers/soc/sunxi/sunxi_sram.c
drivers/video/console/vgacon.c
drivers/video/fbdev/asiliantfb.c
drivers/video/fbdev/gbefb.c
drivers/video/fbdev/imsttfb.c
drivers/xen/xenbus/xenbus_probe.c
lib/glob.c

-- 
NULL && (void)
