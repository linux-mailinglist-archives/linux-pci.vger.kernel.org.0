Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DA69841C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBOTHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 14:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBOTHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 14:07:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B012C655;
        Wed, 15 Feb 2023 11:07:09 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FIiSXr030902;
        Wed, 15 Feb 2023 19:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=s0sIBcUKuyrVyK/LVScaQiw+4LrWC8knDP2Wf10JF0Y=;
 b=NESviJnY65S5+g+ink6EXGs45VUT6FRTP1046WBeg8CGsMNxFyNmlNW47JaMRkkyeOWw
 MD7mDrcVAPHUd8hqRZLcxFoAFwSC1sl5XGzoC3wgDTsZx83Sl+XeKM38kzP78WPf1HBT
 goAifWqhi4g1slzjXbSi1LBVvh1VPWWi9y2UCEtdesQEH0m7cWJtgtk+wnZTzKvKsJM3
 Y+8ajEhy1CG2JhqQjL8PFz9yASpbQykpxBPkvkzyjpAkLsCK5MBLBOwz2j2DnwmTcSuU
 iUgIEMjoJlbeiA7YyhQzAWylcviGCbawb2sjq+dJB4k29iTEWbnAjR+ARuL918qWDeRt gA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb98a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 19:06:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31FHSoct024595;
        Wed, 15 Feb 2023 19:06:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f82h09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 19:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL7MBBgQlWoK1aKLr2+sAx63/lrKc79AER//SwYZwBPptxR2JecOTb5VVhmSWpUKCVXCE47zucREnc/xEnTsSn/l0pdyTqRKtF7pxZqESdh1yDkReLLNujXi9vpO41fEpihLqotXm54dj0lpQVaTgXr+IuGTgjZXCE8TqszDGrnZ2hxbI9f50FGgiV2plqvQ0kEPwpbNE/3dtvqM1y2J3+CTImKoD/o/y1khQHLQNTlL7LOpFJ6BBfIkYGhJ2ZMs12SX5yyTptjHWj9VjVusllg+qtrowqMHZSaE5DmgKfYRF46V039EEHxjm+1UJsgDHnrScN7QhQPtVlrtZvn6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0sIBcUKuyrVyK/LVScaQiw+4LrWC8knDP2Wf10JF0Y=;
 b=ATUTQqkhN7EfOeqRWlOFV6kw9ARmKHfKrPtslfhBZ5xzf8NuEWuX2iGLFVhPLFxNMs/O7W94Wz+ZFxvtZcthquXqBaTXtYO0m/qiEMFQ2/JRBjSySGDNPSXjmlS7+meA4HctemINMbCB9QtoE4/HXZ/TpbzF9uKr9qWVP+EjY/EIVlJqC0b4MUS65dGgn54e+bHayYsTk9oZAo+SHYzMzz2Uh8zAHW/oHHzXDFxVAMTXmlsxL4a3v8mCx3AYu+OjvXYyvyrzKPlh6Qkxobj3gDTGTRW2UfFlREPs57cdDbgkKoakqt8kv2HJi6tm8BLmRcjh9lqqoA+GvtTU23brRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0sIBcUKuyrVyK/LVScaQiw+4LrWC8knDP2Wf10JF0Y=;
 b=Mt1mHNiF1HSiWv1AczrTLUlprlF+l6Fov0KphMD9r7Rl05Jg+MS/2KkdFjHByW0mqPwq4bLeBxwVyH8xNsSZwyYkY3qOAftdpONcjfBBydVyTTBae4YSqg1gQNaYMpKFxm4BjSObw+/xbULvLFMxcvx+SxIYPgZvNTY3b10Elh0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Wed, 15 Feb
 2023 19:06:53 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 19:06:53 +0000
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
        <87k00ly25v.fsf@esperi.org.uk> <Y+puA2V5BoH/Cbr2@unreal>
Emacs:  more boundary conditions than the Middle East.
Date:   Wed, 15 Feb 2023 19:06:46 +0000
In-Reply-To: <Y+puA2V5BoH/Cbr2@unreal> (Leon Romanovsky's message of "Mon, 13
        Feb 2023 19:06:11 +0200")
Message-ID: <873576wxx5.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: d575c20a-95d6-4ebc-8fad-08db0f87ccae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIuRVRKdGE+Yc4smGK8WKqArsSfoPXRAdQFIiZ+Jie7UUmBcJt9UBkdIXj7uVu4Z8oKGP5OZXyUcVY0UeIHX8zVVOqIJzyqU71KKnnRUAK/kEwbaLeJ1PpcKnJtj3XrcLaGzhpFGmZAHsoG09Bv4AmKYfaorgPRfU5M6+s3KGnN+ZDxgAk9Gy9JR4T70y9E549qHhUy+lLWkD1qxxDn1K4dLqGDFQwWXnbdvO9fTEGK9nmCTbKJw/hWGV2dh9F/zxA3VBd3AgCM1VrxtSg+CV+DlqqOJiY0S2l5x6Cygjg3Zl4hKKAdQ+34yNqpCIfaSyi9sH8ez4vMQXIZD5uhBWNELXMpvmFslsWc7W0QpoKavwJU+hqclRaIwZRvswlk9rB6iS926ayBf+iOLjopTiKq4F8i8ZBJpDWVqugzlZ8iPAQMAzmcvKA3SuwPl4wAMRrI8tLXwEKcs8M+z7iVyBvDfurVVCfZYDpseOuclWxf6eGbIi/uYN9jKO6dMWZ7aI9hVg8Ug6PX9bxulUluuilmYT96jQXj6+9woueTJKAqUGCkw5p0DPSJ8SmUlFAeqHhUdFhjQk/S2GXE8f6ps2CeenHWvXV+A8Eaply6zLLM/pvzFSl7fd1SZ8yHGotUJm1gqiGgnAYuJHdYVEQt9kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(36756003)(66476007)(316002)(4326008)(66556008)(41300700001)(66946007)(8676002)(6916009)(38100700002)(86362001)(6506007)(6666004)(9686003)(6512007)(186003)(5660300002)(8936002)(44832011)(2906002)(6486002)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhO1J5Ot9ZsVKipdqUQK3xJYczhen0Tskev36ulZ2200TIA5QJjFuGryfZOm?=
 =?us-ascii?Q?Viby4JV/qLT3yQNx/qS9Kw8scE3lx2Ie5gZd5qA6TBXNPf3YCA3PDgnaQhhC?=
 =?us-ascii?Q?GA1DccJ/ugpWXILlc86RKgZDD0ZkUd2EsaUuKesZn3Ir5FqZtBHobowq0w25?=
 =?us-ascii?Q?hZqXLrLWh/y5CJCTsdfzot6HXWz/LCsP9tZGhsG8EvHRJ/940zKpaKD8EBol?=
 =?us-ascii?Q?Nr1CNnTj97HCJy5dn0mWQgn19tnCRjotOjBahjJ1F79wfbhvCvZM+46ra0gF?=
 =?us-ascii?Q?Pyii0t5PaaXpXQMlT/rBu7ftk971MHmUJrB/evpZm3mIT1aOEVQJ9KSt0Sbz?=
 =?us-ascii?Q?eiPXl9nEOVTeDCSpGF4Kg0A4DZf1LhVmklIhsEsZC0+rLKn8guXAxDMMkGSj?=
 =?us-ascii?Q?j9/vf+xMCQQ8SbhuaQZFSmqA9ogU8iU2Z6Ag5RAUC4jr6Z3KEfIbneFlcISu?=
 =?us-ascii?Q?2NLEMVzYqcgaqRG5zh3o7UyQeesa0NuuSJsobZuCYT5STC/DtYeLPLfBi6UE?=
 =?us-ascii?Q?+yQJNR9JJL0U9fXeLeoK1qBNFqqpJ+zM4w0Z3DSUDhUvpTGqbiHKWTTLLLmH?=
 =?us-ascii?Q?YU6w/uBT5tsyYmO4K/owaWDtje8RieMK1IhnFM9Y7kBroE3GoVm8RKeJXZCP?=
 =?us-ascii?Q?iC6VeXebrijMb7XuXAna9mTNCTX9Au+mudavmOyMV7KWLcNaFA740JolMwaI?=
 =?us-ascii?Q?ozjzkYDrON2goJ9trkCUSRGTDR9+XYTanLJLd10YC53fRxZ/tI57ljuGGr7F?=
 =?us-ascii?Q?NdVxstN5o39t+krXfsWvy72CCKH/TmmRUO2VgT7+7MHOr6hLsHoJB1/jAHVe?=
 =?us-ascii?Q?Y37KVgTM1uM3rlfv3pAO4HjFEyM5zqL6e7UMUqnEtcDFmzsUHZLa0/7Xzut3?=
 =?us-ascii?Q?svurFPTWWZQjJpFYghkQ9wt+Ty9+Cj2en5wLtWyT2M9qRZLjSMQe+sjHW10N?=
 =?us-ascii?Q?5faXgAEvYmiugpgKuFYVlz81by88hfgA+pyUUTAwSmeAbqve1YNi7MsIV2U/?=
 =?us-ascii?Q?5aZCYe/oUQusY1Uv0kHId9ONS/nG2PkG26hLY4LtakWomwnEIxsy+KJBC6Io?=
 =?us-ascii?Q?LRaa34Np9aYQyzN58lfTT2Wj1ppASCvGei6ZTSZkt5Cb81yWVZ5XT/Cf75mZ?=
 =?us-ascii?Q?DuVNHuPXj9QFuFOiKeM6M274TMIqOVi/94K4m7X4I2gPjdNwsjpG8jUHYDTw?=
 =?us-ascii?Q?KjfGtFjyQ4/2ACmmJPE/te3jPkOL/rFlXepv3GZk+a3ZDWrs+kzSt6BO6kkS?=
 =?us-ascii?Q?fyq7iDborz+55PzXm+MFxYbcaq4GJjz3iakMz1jtSHEBGCh7muHPtdstfh1h?=
 =?us-ascii?Q?hgtFjrAPIm4xYeHaJwJmmapYHfwLRFGaqTm+wTRTtl3LGK/n6EJk5viUTTB2?=
 =?us-ascii?Q?xMVqQ4aJ5T0NR+vrStkGtge/JzjWoP6LE8FfRj1BV2H/zDbcs8wfPr2UGUeB?=
 =?us-ascii?Q?y/ELLRYu5lccmIyP+TsCcWH3NMq1J1S95Ut46rau1SkTF+ZjGdJuPrZ3X+Ys?=
 =?us-ascii?Q?DSLEoq2X14v0NS/heTKuLoVfCO9V2ZjNxnGHk4t5XzaxWbFfq3nXSVvuiLEk?=
 =?us-ascii?Q?6kEETzY2014LmajG9wc3PXe/z/lwi/BtcL39kaMtRHnWRvREoIAVw8fg/FUu?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 78aRDdhkor/DZ9hIwdzb4q2/PEEP3CrpFt2XRn5WrSq17Sok4TBbQO2tGKHRUtqXRo6S+0x0Tb5mm+oVeI3IXFqd9s+35/bowwjnNhqj/w6vZtR8HAdqNlbvzhBYBSQ8UUmR/q/FstASfMV45hZmiWN68D3ZyDEdlywk6kZBNz6IOoLdn0xgtq9JrNaGMJoiXBKw3ilH50v06CoDZyQutkXlnAvsbZwnUMNDHm0DodIrDNhNuABY5AElfS5Oj0mjWGqRFwUUKw0ENx49zqwwa8cW7p+urV0sqR8TNO2PdlhZRoWop5JxQ89uCdRbnRrecqLmQMK6ypEKWdy8zekd5x44fDw0ocxJ4Di9zr3apF8wL8chTQ8vYEsMT3aBUANy6e4iqWBrxd1LDIIgBGcf64/iYkjOeB91JC9gqALOWFV48vACg2h2vVg9O6o/hguFzlIyQrg6X9tCtnDDtnhPB8F0DhUCktmAu9lD1IH0WcgR18GeJSxFUIsvJsq3GFI+E0LnYvOo78gZFroAKj5jokubBrw1M8kPk8+e5reOGZcbfOHnEBDfG9gmMwWcdVh/g9wsG7Py+4PIuyWqgnlw5W++R5Yz3TvylCATBCVChe0ak3yupukwm3CEVlWME6qcogdSOFiVItHauoG2JINQb0EgsGugS+Gq72KexoeX9iFU2HtTUv2nMc+Rb9WOrFOr1Y7bIL2Sx6Mj3Rk6I68JR9WqqcS1HwbzzO9dnKOs71V67mgZQTq1Y9wH+PEIC9FtkGssUc+zuwNf2q1npziQZ63CvVZs3hnW2k13/h0WQ7SDeO77ncXMEp+HBPZASG5gVJ82PvvmSMJmWxVWEV9eSA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d575c20a-95d6-4ebc-8fad-08db0f87ccae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 19:06:53.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA5gV0aAi/O8qtARzU8jZ3ScqpjH+1oA4wWA0ZMY9NSFWVjsi7EVETOYXu20opIQzMM2pUCSKTrXz18KHC5bJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_09,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150169
X-Proofpoint-ORIG-GUID: GsZj66oU4u_Uzp9LKhYpBtsHgRu_W2Kd
X-Proofpoint-GUID: GsZj66oU4u_Uzp9LKhYpBtsHgRu_W2Kd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13 Feb 2023, Leon Romanovsky said:

> On Mon, Feb 13, 2023 at 04:13:00PM +0000, Nick Alcock wrote:
>> So SPDX is usually more precise than the MODULE_LICENSE, but is it more
>> *accurate*? I have no idea, and I don't see how I could possibly know:
>> going by the presence of advertising clauses that obviously nobody is
>> obeying it doesn't seem like we can trust header comments to be any more
>> accurate than MODULE_LICENSE. Best to just leave both in (and comment it
>> out so it has no side-effects on the build any more, which is all I'm
>> after).
>
> You are overcomplicating things.
>
> First, GPL == GPL v2.
> Second, SPDX is the right one. License in module is needed to limit
> EXPORT_SYMBOL* exposure.
> Third, we have git log and git blame to audit and revert any change.
> There is no need in leaving (even as commented) dead code.

Agreed. I audited the lot anyway -- all those files I'm touching that
lack SPDXes (14 of them) have copyright headers at the top of the file
anyway, so there is *definitely* no legal implication from dropping
this. Moving to just dropping them in the next round.

-- 
NULL && (void)
