Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392994E99DA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbiC1Oj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiC1Oj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 10:39:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39394C01;
        Mon, 28 Mar 2022 07:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuVZsiNTwn6GS7KdfG6uLlYRVusfq+QstT+HLyJedRniiAmmZyF2V8HO92HNvoU0iXeq3OffghcwXE65Me3GGKJYYHcxQDA5KFy5zpN/yUAMU5QG7Dpy/XM+pLpCkqv+QBYpGd4BLzHg6zH8sNflYWsqyH4VoGjlg80Denu3aYEZd951x9pCBvdk2UvxpXA9JxAwB9XpJZqig38fgT94KI5VWRmbV5lPk615vpBCclgyfi/4rFGxB/2meKDpLlsBy36kSM7hkW5PVLF7SoO0NpGBeu2mULDBDIYVSvINdwazAPCxyIKvv06yBHhy/hKgmNtuWgIjw2H69vT3YE+xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iP2nCuvHu2KUW+91NwlaqE7O+QiiIpVlMIcPrXdlzA=;
 b=kPuqYa2k5mSLs7c7Yt639051Ttwao03NkRKcZCe+KPaYScLUXd3guSNSErQd6GTcZD0zDRKyqGmuRH0feBc96rXojqccpYmOijPDekEYq632jM8UGDfH+sAMbSn1qu5cbduhyvXDi8jTsCQsdnwIt4R0sWVLIrRVpTrjjG8AHBLNNEBNH41MTDm8/ENP9Tm3QzYLKmCpM7jBKP17YnWT3SHVH1t494o4Pt+ErEYHFSuDYvLXq2tcHcdgzbyQbjzPTQeM7aYW+nF/t9sAgXt7JPVo2EaF1VVebmNLakpOAbSSzFE7CB4Qi5vOONk55f2XHOY3DkJrYtHR6Ic8fGRbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iP2nCuvHu2KUW+91NwlaqE7O+QiiIpVlMIcPrXdlzA=;
 b=VLwzN4WzOSuhmYnnZcOYu7j9abR1ov/FAjgKh6i9KKQyj89RtryqOj2N2B2wtg0U7Bb78S4BIB6AtuPsa3iitjWY1hk89nUe3lrQ4u3A2rpAnZVEHB4//9hdTM++n1aYkrd33z3k2B0skl6JZ4Z58Fg7JVqQK/n+clphS/N0ExkEcUrYbuV9Yfr6JTw3yDOCBqCWX2gZqiLeMAHoQzTS//4wN8JxG58d+8PCQxMdWwdid6gudFdkppBwpN4lhCvd8ISEyYTVU/7UC4w4PoMp3P5RdyN2Kpjk2402ZMwC526DlRvEoWRJHVJSp2UD7/XyPa9dx5hG32cbo1N2ONHD1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 14:38:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 14:38:14 +0000
Date:   Mon, 28 Mar 2022 11:38:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com
Subject: Re: [PATCH V2 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220328143813.GT1342626@nvidia.com>
References: <20220328113728.GA1693573@nvidia.com>
 <20220328143536.20761-1-shlomop@pliops.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328143536.20761-1-shlomop@pliops.com>
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c567cc-d0ab-47fd-6ea9-08da10c8975e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4156:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4156FF0B7FD96CF0D91AD9AAC21D9@DM6PR12MB4156.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trU8ppAwrMsK/kytqNVq/JdUw+H4iJN1C+b6dbev6NVJ5DXA7m5as2zESfjXgab9uBpLX2FFXpaz5vePas14QuujtfY9X6sbxRj+LA/GS1HwaNQYxEHkucx49FnkWTZUOWu0zEjv32nbi+LuOs1e4xvV24WK2w3XJDLMDHE+Dq4lCR9tImiopppkeJzy0Tpa1zsiaL3KDMPJg2I6F4CsmpPrioqXIRy4FM0xjFSoqcQP6V6cPchocFtlSV85V2YnIsjMth9JpE2t2gGgCqYXQrZq+U2MHGkFCtLk3HkTIi2/3wkEd6FiXiz0BCM2jwCosFJkxt8DX1bg26EwrmYDyyHSY/dxj+1/yfAXzqhfeT48ayzPq+igekQoPp+Jm/EBntINfa5/2Db7fDqgkHV+R73cgQm2EX74/DC9KCj1UB6dg2ggDJUbZnAhrInFD6IZXocPMfyXB2pCFzTBC+2hJmI37uYt0tETL+3dyC7dTsNW/9x7I3+ixooYldmTQ1UZqoN7VVamtn/iAOw1AiSYAh+KhhGq+i/CWnFOWxpDMTi3K6jrzMVLkPhVb9us6RcX+lXvwHef8a6kB2nf7WX7DUOOBS5aWqNQWm796iCsUjrSNFUVPfcxzbzp3OYnKNeiyNUifkP/gmqoYsav2ZsAgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(4744005)(2906002)(6506007)(33656002)(6486002)(186003)(26005)(86362001)(508600001)(8936002)(5660300002)(2616005)(1076003)(38100700002)(316002)(6916009)(66556008)(66476007)(66946007)(36756003)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcHqh19p2FcaMxPmlaBJWmZS1BZKOxUV9E2v59OZfb2JcXcMuoOIU7N0KT4R?=
 =?us-ascii?Q?nAEAbeZeYlQyvCaGDPkzWEU9djJ5A2HeEoyTBJ3b5OIomfm44k5HC+s/nxc8?=
 =?us-ascii?Q?OK7vIIE6dy0HhdpHNRNv82kBaZ8jNjgKEjJks+LhA9dXVGAg2ro+MImhaPPs?=
 =?us-ascii?Q?kTSZH1itcwHG67LB81cAeZs1VI+9mLjxOUrvRonFYRJw/JOi2+8WA8inyO7r?=
 =?us-ascii?Q?6nrPUxXLwzxwSnOgKp4C8rmq1aFVnhC8v9Wa2vBAJsmifCpYRZAx6RjHYXJv?=
 =?us-ascii?Q?I4KxFYa6yWZrp/WVAdF3+7XhULoTlONwt/gsWf18MI+68wdYSUEzZUXCoYfn?=
 =?us-ascii?Q?B9IPPhWNfN87+k0nFQdb5ps4Zkotq+cZFSJQoTqQdU5ZFxRuTA82kdscXxLO?=
 =?us-ascii?Q?vP5OukSKssGoudlmzO0HfsCzFwj4kF3N4gOTk9bFLcg8IXXVCJ51lBRje7uG?=
 =?us-ascii?Q?ub81gO+Kivdkv+Fo9+rldwTADR4l8sMydMsjSCcZUFdsinJ7b2DaV9a+L43K?=
 =?us-ascii?Q?Gf/iCzTfbZeZXjEysXXi+JdgnO4HZ49kOq/mp6X/W0ZwbuW4GdWB2OsUIksg?=
 =?us-ascii?Q?uN3Js1JmwL82+eD5B2doAMiBM+QcQqTmWbtNU540KayrQjJrtI9QZ/VgqdFv?=
 =?us-ascii?Q?GLzq7IsesTwsU0aPPouT0Ij68rL+S+Jjs9VOcsIsVmSeqsoQQtIA1ajfBH3C?=
 =?us-ascii?Q?JzgpSFrjOx6fSvxYkFUh17bN5rEY3w655vOketB67sUQpBUN6U+GvWpgNq1C?=
 =?us-ascii?Q?n0Gai2WMXVXYuympWzGSpe4HGf0kVuCP8kziOZ+sVcABnuyJyJP8jsAFGs0A?=
 =?us-ascii?Q?ghQcOuwepDEQKg7m+22937QgEnvwU5I32iOWu/Tlnjp7f58HFdAnMNDVERdI?=
 =?us-ascii?Q?7nL3NB9EdyDHm7A63atHTHFm3Xy91+sdC9WpJMfKYrJW3kagAqIIzmpif19X?=
 =?us-ascii?Q?FP7yQe6sinLIbfJShrmHDwGuTH/7N4G9tQXeE8g/INvr5rj+uSsRJfGg+1eB?=
 =?us-ascii?Q?rw5LLXLN75EvjQjVT34JW9XuggSkxGsNtIbKFE3bAzDp7NjzvxspheJ+7kPD?=
 =?us-ascii?Q?z1JlXbbrJQlgcBtQCWg0HzeXa1WikwLOKbNJ1VgDXVygSiuuPML2rRAnqnVF?=
 =?us-ascii?Q?PPcaMdgOS/RLNaUVsfddGlrT/cQjfGFYdwz2gxxeO8C4c903k4x4PXdB2Yk9?=
 =?us-ascii?Q?xQJX3VCJYJjEbiNm/v1VeNzNptaNpIO/YOK+y/7C5jaohNx1qEfuXvAuJYnf?=
 =?us-ascii?Q?ptzTF7VcnTvkRiC2R0qQO2saWNxeZOOlmXdWzytRmSrFojvyxNV4ofopUxFz?=
 =?us-ascii?Q?XfO7Z8G7DO1SonRlXeVwpxGGCSDfK5E/qwSrPbwpNlRTZ/ZFfymklDc6waNz?=
 =?us-ascii?Q?H6ltgVXneiKQFyrrnF5hZnNo+Aw7znWdjO62WYVfU1SbgEI3WJbz4aJaiiOO?=
 =?us-ascii?Q?N87XNJcZpjpedHTIol7kyfrBXz725PklJMpaT+/a3odCP3NVSRS9JkEE5wDt?=
 =?us-ascii?Q?Bnlw4jdcaFe3DvJqIQWmD4RiLfO6bV9uoief02QvfafwaTJkU1nEzM/DLFto?=
 =?us-ascii?Q?37dppIrlNNwLvQX3x4TQRN38nvxZ9jV6NusLVHYYTqWVpSn93KLmCKiI+8yX?=
 =?us-ascii?Q?81+BDkcwWO4bZp4+PnHyOA2yAt2SQGK5Mt3YR1iu97BS+sFpm76lmQoOKVQI?=
 =?us-ascii?Q?vqrPYV/kYMEeAaQLYnapDYOEJSk6alUTHdGoAUUXnVttLnTCBXV7koISls2D?=
 =?us-ascii?Q?xzIH5ZcPmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c567cc-d0ab-47fd-6ea9-08da10c8975e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 14:38:14.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNs8dDLaVPPw4UYARO88qSXSrdvvASMMhF96RCq2y/2l1ueNoQotlPJniZcLmcNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 05:35:36PM +0300, Shlomo Pongratz wrote:
> Hi Jason,
> 
> Thank you for your comments I'll fix the spelling mistakes.
> 
> You suggested to remove the port field and to ignore the slot number for root ports,
> and I understand the reasoning, but, from safety reasons, if we know that device 2030
> will always be found on slot 0 and 2032 for example will always be found on slot 2
> wouldn't it be prudent to compare the device number vs the port number,
> unless you believe that the BIOS/ACPI issue will be fixed.

I'm not sure that is guaranteed, it seems like a BIOS choice..

IMHO what we know is that if we see those devices then we are on a
Skylake-E already and we don't really need more checks.

Jason
