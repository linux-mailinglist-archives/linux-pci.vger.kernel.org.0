Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB26924F2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjBJR7j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBJR7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:59:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283F521C0;
        Fri, 10 Feb 2023 09:59:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHwg9Q019333;
        Fri, 10 Feb 2023 17:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=N5l3NEypn19ia1Uij1Pb4txbi8wcU3eXmL9Yk5ngQeI=;
 b=kT6NsyMdW3u4soGzLEeoExBcYUwnkp8Hyy1s5oty7GzR7WSrEVHhdVqgzwjZuw4+BQiJ
 Yeq3chXAFpTkB5mfd+hhQuCNH9Z4EfKsPg6/0S/WXPM3MBzJXu3tt/5863DWlfi5bQUC
 2aexgNbne6dF4XyL9cRapPJcQhH8hy9V/oAAwIuVNBHPt+/HWsTck2BLcSDMy+bmpeQv
 oIJPdE9aolG/AA/+djPy7xHLP+60Bg+bRSWjfq54Kglah4TRiAUBsAqQHQvYkO9Jg6Xo
 Fz4Te/VUGTO1XbSTaNVmzRKdVv4VFBIykSzWocZYviki7uVNBAcqOb6s5zRrC1gupsT6 Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu5y9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:59:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AGCINV015135;
        Fri, 10 Feb 2023 17:59:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbf3hdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFa1UXo+MHbu21zHg9a4XZ4AQi3cqMrN9N6iepqjPGQZmq7AKlEaFdbNGMS/mpoupUGTnp9PPtT3o7YL4ocvZuJaHvuwf4AZwq5LI+XyX8BO35n+RMSzyug3hGFysGO6kDYhaIT/Crh4gIaeyWKEY9J/jFVmPMKjfJSZy2xESh5T7AFJg2jrYIOv7hwKpwopjD7x8FYv0qLxDxfCzkQiz0Uq31D6Pl1pMap/elBvtQLkYh/qYwoEu2gU+VYQcX70SS+qi7RACgsuFfb+FZOP5Wxx59mnx/rlQ/569vZjDchPlf+SWBJgeTOAl8+KNjiwjERdaZqFJAOMim9NNrkHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5l3NEypn19ia1Uij1Pb4txbi8wcU3eXmL9Yk5ngQeI=;
 b=iuAErh8Ui2VHyMcXIppJePkTnhW7q7O3+UHa89WguYJuKVZ4cCL6OY0SjGs2IkFeIGgAs5j/6H8hyRcgxZJR+qp45ymtIpLy/2RaZ/ZfW9rZiTcnho//ZjGacG14C8XNXiCMBxYDrKzNly/NYH6uYTh184irUdhXqOfvObdPXdYqtBh3JcyadJTNR+LkMWPdCPpD8tw6FmMS+Uyoky3Qn807oVtj1SdG33Z6uYfHP7NkKt24CctwD/OAaKEzUDLstMxH4rkP7JajYD62J3j4uqQZn4EQ6BKvjWT75Yv6dGj+lK5mgeF1rqPK9LVJWAJddYgDQzAdFCoAV59nndMusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5l3NEypn19ia1Uij1Pb4txbi8wcU3eXmL9Yk5ngQeI=;
 b=n0ksaVmIMvea7Fl85v18xLkiNEe8YAod2+BYXg0H0Iwi8cuw93d8QBEkIcCsi++B3Vdfzh0o707i2UIXJnNp4xPnPh3lSHoRKA9PjzutrjRRRAz/p6A8815VdW49Yi0rDBPDJqZHp5D3ee+A3R0jBQPLYdUPHtR9Hd+r1SxhVSo=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 17:59:27 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:59:27 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 6/8] kbuild,  shpchp: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:47 +0000
Message-Id: <20230210164749.368998-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: d77ef8ec-f52a-480c-1941-08db0b908d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8C5gWa0UpsTBBLZFIKkoMXO35OG8sUqaxLDmyTIFL6IzNZZ8x9glzHgGw+KwrrL5oBZS402ztbwk7MgyxYkq5d6wVLpIAPANQ8ceEiWOCLynGorgB0HyG2ZhaAEH4bfKCh7jgGh2aIKrO4lBT763jXBt4HnxmjPBA724rwNrfs0g7Df6ZqyCxxrBau8Rz4vTpsCq3fdQg5dJLNjaKYVNew1Ddb+Ru5DmkP7fF04iP6vK8UF2RcB9RmXF87ZZFBuxG5l2JPKhiY24Tn0Nd5h04qH/AoN8Muy/NnszlU7Q9eDIxpE6E+qv/jGyFE0kyPMaBHqICsfRfc2f3KB4VqUx9CX5tVv1pRlZYJNqXErmnz3fjlGGC5di1NGXboXu7vjV6L/ycimIR71hbwyiRgH9gWEGJYnmUN5qy8F0NSNtoK/9gjdil2kGcDyBhM5jVV+57IFrnsOj8H5713TNEFXBE0xbuLoQL4gAQ5D2ThZsVWGIMNC3YGTZKXLok+6TQ0ItvGEy6ZDq4qF3qjC2n8a+NrGeqgihwWYsC2Wv69DBTYey2e6MahN3Ls9OlrnFALR3+2fbaevdk/Y2XVItAPFRXNAPyfpdwWexx/htA6HjCFDD+p4J8ybj4096ibrsddqR3RAIfjpfTtklFLmFcLeTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199018)(6512007)(83380400001)(26005)(6506007)(186003)(316002)(5660300002)(44832011)(86362001)(2616005)(6916009)(8676002)(36756003)(66476007)(6486002)(1076003)(6666004)(8936002)(66946007)(66556008)(478600001)(4326008)(41300700001)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/CY7rPq3uDUqSm3TykLNPuufGgkO+CfYQGA5J0s+TXoDPXW/FWdMgdIcSEb?=
 =?us-ascii?Q?eIY7jAQduhYabKaYABlRMtd9JI85DoNG4+vFRncpIVEBsjI2fNZzpBmOyZZ4?=
 =?us-ascii?Q?7wTjDKKks5wQV8kzVSEDN/cZRnWumFgvbXVR+7RUeQzhXbk8zP/U3oy06rbD?=
 =?us-ascii?Q?QeBGwe8hWAjoCH9k534QW5lsbEYgKDkrU2M8i8h5W9A8pHGvqwI0m+EoEvfy?=
 =?us-ascii?Q?ckxyNhMcupmp5LMZMmjSDVGwKi8ojnNC9gPqUpGFJjflSWQhJPOC6wUEZyxU?=
 =?us-ascii?Q?Wz97pm1wRDq42KQ5E1axewVDRqyjWUSPiMA8mZItIBW6hzkpnHDfFsJwzxLG?=
 =?us-ascii?Q?ZCMq4whSYcxITGqDYkmn8kPl9sHPjgmLPsc1sX/0PiADQdJJCxRW+c16/YmP?=
 =?us-ascii?Q?tbQk9zXF0Lpsi3wVabIS5X+KcSo3GT6D9RG9sbkAA+EHb15/bPek2gFFYqkQ?=
 =?us-ascii?Q?pcKxMD2hus2w5OVQZ5oXhYFeO+e/FbfsZCBDnX276OUw/f71IUy+oWPYc8l3?=
 =?us-ascii?Q?UFFWprBTENgT+VAxOsDLpW/8cAFfBbVkY5/zN2YMYS9M3B0uABRQdf34Mu1l?=
 =?us-ascii?Q?BNrIEb6Tngo2nbxWsuhSv49/a3DbZKjekR2o9/Kbjya6YaDNtZhua9VYiaFI?=
 =?us-ascii?Q?Q9ybPD+q6OMpiuiFLdS7GDw/3d52pLuepMqQ4pVNF4AQf//HzOFmLrjmiAsp?=
 =?us-ascii?Q?UiEG7Ok4l6/hUpHPuajqsDtLkb2W0o38D/acc8A/8sevLqhN0wXHdyD/r3ub?=
 =?us-ascii?Q?WGwU3QAq1tf/9MAMoM1liQPaRbqFIVqZ1nPjrgnDSN1rgD76za4STck+YgGg?=
 =?us-ascii?Q?LBS/NteVZ2zikFk+RoAYmV3ck5ATcUZMN+7UclR5tZgFUhwoxLoqLaIsorTX?=
 =?us-ascii?Q?PM1IOk7MwQcJFUpyC/gCu/HTvpRY5bn1guy2RmB6pHnJ2kWSK9eyN5x4a4ns?=
 =?us-ascii?Q?IiVDHAW3G3NrBqiKHLeao0Ykr69nRKfwigrd/bGKfyCComOnfjY9ccU5qbfz?=
 =?us-ascii?Q?4tuLpv2uCKJeU9ghe2SYltitYW+gt0RaABF+vDvXFrIZdFS32aOMXp6D8zhb?=
 =?us-ascii?Q?ui7Qg6NHYHtv+SjO3ZCkrt4+oa+Y/gD5RRZzqG9Yg9so9f/fieUQXL1VwIES?=
 =?us-ascii?Q?mkWkGp8dTGL4sTOEH5/pb0T1hp03nMI2QuXwIO1wCOfNp84onvnSfllXI/mI?=
 =?us-ascii?Q?VRqpuF9Xl97emew+Q95KC2qMXXnxI2SpDkHrUCf/28gbwatbsvs7vbWQsstB?=
 =?us-ascii?Q?HbskkdbbOsONrHwLGP3RNHJZvpDVhtBb3sg0cpuOykTsW2gurJF2YbGYNu9r?=
 =?us-ascii?Q?KurVQ2j1cnXM8URExfejpY1yeAx8WZHU5PQMOaaUeNUrMoEdkLBlJ4PFb2B/?=
 =?us-ascii?Q?yl1+u0xAnQo+EOGgQX6GKVZY+Uf5tNzNXaOua5RJTDb+CD+x072p8k8v5POh?=
 =?us-ascii?Q?hJHJUn5OpXz46Gra+REIpt92xf5rsWcOhzddqrZNv9tFliJk5l978MAr6h0u?=
 =?us-ascii?Q?mzT7tLlfH8CJXaxTSOzEukfDvQFiNLT19dx8mYs0y2k1kgtoOX1ahrpIsxWQ?=
 =?us-ascii?Q?Ag+dv16TmrZjTkIKDo6/hLn4vySsluRUpoGDfcY12NCaOnZDfqEebrtOHJAd?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TIiwrXXkmaagdV7bRK4lqJuI3/racIPb4pSwrvbw1EtQZk0eeJo/ka9U2hqtakt7X8G6zwMHwucL7kAf1Nrm4+LYXki5tEoM0STqX0P2tFvR9jfh1Ue38pNSUTZ5cMcDqu9EOf+x0QYaiRuwWFxDALWgR9626HDZ5TnGSzWyT7Wq8x4TYFqXxZmqTZOpk6u1H4Q5pFTRY7p0WyrL0V21yz/PSH7KSdpLtq9mTch4QLfqtzfvI2QCtTMYidtYxJg588ddLsfwBtrEEZjtAFksuDsxTDqGW3hh+Nav8HmawxOvhEjSS16k1w/hyPn2WuWDFk6CCifUB8KgOo8YT64COeAIn7UiyGbqMgmOTcOhkGNP7kOpd5o3tgnJVDSX1bDG31qVEk1wHOUk4ylSFeUJNIJTgkKhHeS4/pB4aK1n9ad2vIsnrDFgEGwLCGbWFDaQ3YnSVAzTnLV8KcJHys8pR2Z+NxpoNlLvDY8rzCcTXtD15jPEQmD9Wn+HhN1qU7G9Z0tNnGyWkiRcioW2N5eKs7VzDhpR6Fc0bqjMUVvOuEVfDqBkqPJ1oHjA0HXfwQJvCOnBpaNdEXpZV40LXNmu9+cyZ5i3JODwrR30MCMj14vvjVh3hMounA2nTplRWqAQyoGxSB5f/4JTkT+kq5ak9a7MDrHrcuj13zwfyZxHrq+12Y6vzGaYaiANPkIDeRKpI7GRnucsf2BHXcjlGN5kNdLG60pZLlciCixuFPAGJnZJ2hR5GPGZKswUJN+AAbxz+ZoJt2/0cFgRlJmKFYJ3P7+XlOF8XuSRElCpmlAqDjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77ef8ec-f52a-480c-1941-08db0b908d59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:59:27.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4QzBTRSjp8XzFJutfXUkj9BmM+HUHmq2Awjvd+jaKOgUX4ROITBu/MHSH7ZB9uRTyHALYK7qTqbO68Dv2WUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100150
X-Proofpoint-GUID: qHmrJN2Yn902Xu7V3lWr9ae-fnHPbzew
X-Proofpoint-ORIG-GUID: qHmrJN2Yn902Xu7V3lWr9ae-fnHPbzew
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So comment out all uses of MODULE_LICENSE that are not in real modules
(the license declaration is left in as documentation).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/hotplug/shpchp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 53692b048301..455f247c27a2 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -32,7 +32,7 @@ int shpchp_poll_time;
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
+/* MODULE_LICENSE("GPL"); */
 
 module_param(shpchp_debug, bool, 0644);
 module_param(shpchp_poll_mode, bool, 0644);
-- 
2.39.1.268.g9de2f9a303

