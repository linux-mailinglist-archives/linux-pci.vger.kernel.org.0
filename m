Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6500C4D94F1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 07:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbiCOHAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiCOHAJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 03:00:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2BE0C4;
        Mon, 14 Mar 2022 23:58:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3WUk5021992;
        Tue, 15 Mar 2022 06:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=j0r1F/+kVzG7JN13ZunoRCboVAUwbqroXSzIt2ZKeko=;
 b=QFfFxPvnpjRuvNsFp1gUF7Ocvikja/aQYB1Wohq33AqCICOiB6ctYSg8iVqTe5vmV/B2
 pbjZaDnJi6qJHXXYTLy+gk+cVrTiZb2KPjsVSZGuS11KGuQiitazfVW2CMQg76BocZWi
 FdQMNPYJNylDHkzxSjJjEn5DarX8vp2wTP0vwF0XPEJPjElgGIzhM1bbl8QqtUnMwgeo
 SVYBscC0XebfVJ8RZb3KHzmNOdYb90Zq8AlgCm/ij17OgyMy87EDom2Z6pKuX5CRF5M6
 w6nSLVtjYAH9obH2PwoacAUmh6/rejRjX08Ne89+JGR9w1wKpzzzm9LYQk3xxYiIrJLu SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60ra4sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 06:58:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F6tuEP075639;
        Tue, 15 Mar 2022 06:58:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3020.oracle.com with ESMTP id 3et657b5ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 06:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvXxTkVkFz2kfNVxXsQHeChnYgtpWSYZgQBAVFozWcQAH0jDyCLRHFqy6zTxWygowDogwLwUJ7I8kmTMVe/AOocS1/EzdCE0ijhTsFIH9/b9nyTzdnK/citm0yG/IYDsWQNiZ7VB6Kr7a4fcx1ZJjo7pd0SGl0Oe9aDWfd81Bvy/yfM6ODEYjnBFWumwpiei3UpqeWUDCjKGaXZoi3+u2DRxfXcXKDGC7Ws2TqMv0ZkFYFFB/oUWdVDQAaO25lC/4hM2d7NeWheUB4U7k/kHQaaTKsghlNbkOmZyJtMc4BC7+nMOwpuA+wVo6AWAmoxNuICj21m0LNx07mErQO8AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0r1F/+kVzG7JN13ZunoRCboVAUwbqroXSzIt2ZKeko=;
 b=Na4lbekcZTIcj5inJyEoxzUyAeuujDZYagItFik4b6eAtOz1v6UVqnti7kHnD8Gm+L9cpVQXzlcVEpCy1DD2Ohw+Y+pUlS/lsiSPRI+mAu3U1oH+Jl6GN0nG5cit+fPrwj5H+pVnEFEMWcRX9V9fuENYP8UmO+4vMjYNP/gLjr/qIKUD9lrnk2Yim0i2RHMTNVGaVujXDDL6RtZO1IPOBxSbKTBv6gySseG2wf/wjJBT0PygY1LF1LIAm5jAShQQMcQGXzTqQ6PcOl3jUvJzlNtV4t7ghug7FXw5kSarF4oHURLqmE8/jdXoRsCwBPjbetQKwwn6njsDrpufMBLsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0r1F/+kVzG7JN13ZunoRCboVAUwbqroXSzIt2ZKeko=;
 b=aCjxxshd5EVkvCGgpq9qUxyhndygbBmxJBJHS0Ug8yeHk2dEb6Yqh7jkJPJu9yhTE/QVlQtz8jzjheVL/Xw1d0PnAfpcWdPJlYEjRL/v/CWKZyDB2LmJv10Rl88FqKd994i+iGiVnc00+NFWu5k3wdK1RVTAN5B88K55mrM3Z84=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4149.namprd10.prod.outlook.com
 (2603:10b6:610:a7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 06:58:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 06:58:41 +0000
Date:   Tue, 15 Mar 2022 09:58:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: cadence: Fix find_first_zero_bit() limit
Message-ID: <20220315065829.GA13572@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 854703d9-2694-4442-ca2d-08da06513cab
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4149FAB482247CE806C7AD548E109@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Atcb3dy5oJSckF1JK1x0dmFYuE3Bu5ANoOpmXlOP1LASnUC2j/gmV4oNIE/AONBH3T2Ypx+KL7+qPLxaMGNuuKkpmNiEzkR+YP3Evvsq4mpeW3NopX60cmLMM7VR2bd8ajsVS/m/ADRUCIukD0F1N51F68XTvZ4FlMLk6AOGQjcqml5CQCpWZMIu3hklbUIKYEtMd3/4cORSrETf32QyOAHhOvCJId070mdIFwNkS4vkvKHMYFHyEzh/Uy3PZdqdstBqyibHBzzS90VqnW3A74LuZDqXmmkWu3U4G0ygo/e2F2M6MSDkAhVcrld+ea8dci9vm75ATBTQKfB/xJGOEhtKKCaT8SuCMJ8ZqLFOYhz0UptSkXjZX2pcQFRyO74hInsNjqNnyq9BYXy6vhr6yYie/7LkcWj/wTYfOUY1H8lrGVfBCZJH9xHQFHzKgs7icqx+tVJyO2m+ctfEHgYvgMF5Zq9OONr+X2O/X41SxFfY2LiWClDoguKhkRND7YfHTvofk0ZbaeAS40kezTLdFczOrJ9eOPbnVvLYf6J1y15dz98TQehTyGvj9Xko8m5cBx3r3/gSyN5K5PmvRWczHacUnyX1/bqPP8r3LgaerjN5u7zBI3E5LilR7jvJ1S4XrGSHAXhSh253KrdUlrti93taBGLArKo9EFFlQqXIqdBda9wzYF+2H9EkM2AF47CUM9BjJSNU6AXTs937OekqfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(110136005)(316002)(33656002)(66946007)(33716001)(508600001)(8936002)(44832011)(6486002)(4744005)(66476007)(5660300002)(2906002)(38100700002)(38350700002)(8676002)(4326008)(66556008)(86362001)(6666004)(9686003)(1076003)(26005)(6512007)(6506007)(83380400001)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7w7sgDj4hu4a/RLhP9C1e+aOvO+0nLeBuP94b6dTd+enC6H6vrZ8BOFQp3VD?=
 =?us-ascii?Q?T8RjSXDJsS42V8cNT6zjU2o7UdiFHwWqtaf6xW6mVNgi5i8MYc0iFQVlXXqU?=
 =?us-ascii?Q?Is/xVB/kkNHf/c8L4iD368No4lM1s6prStIFJDHIMJccB370lsRfezfsbHzu?=
 =?us-ascii?Q?t8bmMJkRIc53ii3lQlr5ekPjVXbx/uUhBzTHxNXtTJQ6AgQSRMMArkd+cOiB?=
 =?us-ascii?Q?exqOIl6ojpUdV25oB5Mj/WhbNWYsTxHY9YAs5QJD75ZpgQdopu3t8f7l/3ll?=
 =?us-ascii?Q?RFr76OSdmxO8Y89lnDs4X/I6Mwug8rrCa3aJP/RoN9JKCGPsIT4BQJmzvzsv?=
 =?us-ascii?Q?PWpb+ik0glapND66DRDT3G/5G+rq5QzW3QN56kVQ10Pb+XmABLIi2I6ytapS?=
 =?us-ascii?Q?7cwyqfuJuUE5O6j7W3UVARKwSJTBDk8bPCKvmCwaIsynYj+6ISWyNzZ3jN48?=
 =?us-ascii?Q?Ppa4ORJi0vdLARs6JL4xV6YPTqrTHS5Prp4bUheQ0cb9X9czAUTblYQt9n9K?=
 =?us-ascii?Q?mbWGK9OnQg5tRPALy+mAKLJ8ufhdmGiLJmQSJBPtJi0CbDlhfgOzl+uhRy+p?=
 =?us-ascii?Q?eRb4a9Gzj3RnUOJeQX88xIlljcgO9DyNtcQNlaBqCTfSUpT3AV0kf5UP53S2?=
 =?us-ascii?Q?XxCjLMxIhvpO33aoI1GzQkQZwH8iNLOE51tx0otDiqyVHczgLGoM8H+PF+G8?=
 =?us-ascii?Q?SYf+aZc9MuBPABbsYk3OXP7xs6M9LCNRzGPtv4OMNZ+NHCJkkDlFxXtCm0s9?=
 =?us-ascii?Q?XD05cdQRmpK+kGdOgcDePKqHQRvqEKuzpBNahkBw2KwsaZXJUEjo83H+yTlj?=
 =?us-ascii?Q?wYa5tDNlO/uqp8LWROQxvib+Lyxt7O2WFNAHUyT6JbpU8WOUDJY4TWbgxfE+?=
 =?us-ascii?Q?ostHhxgcJXPD3gc68IcKY9ixLPxGYDl/d+jXpGOqyIOmCUGc5vPunBlLGpwq?=
 =?us-ascii?Q?EB5IkDJgtTPHATiiRKYBKf+S6cV6E1lS7vWd3amzvq/rFdxlCRGArRc/6I+c?=
 =?us-ascii?Q?vIOqaEK/x8YnRQ0DRsKZgu0N8jG5+0eqo6/7T6y32FKI4RxA8vHSzFvF+T8K?=
 =?us-ascii?Q?HQCBgl/x0jpSQPj7q0dNkZC2LPQfFDHI4i8zP+y7H36Tprk0aHfBGzZ3WIKj?=
 =?us-ascii?Q?AsMkmHLdRM5jM0hbAbL+I/WL6IYZrgEuFqfgv23EJXGT6TtO7zwgAa9l0Nir?=
 =?us-ascii?Q?cWKEdCZh2a5aaWxjuJsnI2+7stAUWqnJGWhuuVxgJzkiUOUt4o18H8Z8D4XU?=
 =?us-ascii?Q?+PuptVTT27qfKm08NW6byamAdZXPEmme2GHO4lCtTaFYVaZoRmBy0oserMjM?=
 =?us-ascii?Q?tFkFuE3r7eYJn7K1jjjc5ydpCfHQZ/2Wq45wqI0OKKfd2VLh9kE+9fiLtIF6?=
 =?us-ascii?Q?Lb2XCat9Mxmoas1bo+57JrJ2o9Y0xM/YNfk8KhdicYEvz3VoN+Ltm05oYlnM?=
 =?us-ascii?Q?LpjL0VJozBYgo2bVuMDQEWH4r4Ll7FueC8jq+Nq9+/6vQ9eCeWNj3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854703d9-2694-4442-ca2d-08da06513cab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:58:41.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bg3m/hAl1/oVdvgtmjDlvfSYGnbHBRCRui+TW0fYa93ZtyR4AX5/1ac0DZLjFp/BMrBAOGn7jdcbNJixe4jBBVSZCm17MoBEEkUG3coHCc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150045
X-Proofpoint-GUID: NpxFmOGazZf7ojOU3b6qjKDqr5sYzK-E
X-Proofpoint-ORIG-GUID: NpxFmOGazZf7ojOU3b6qjKDqr5sYzK-E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ep->ob_region_map bitmap is a long and it has BITS_PER_LONG bits.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 88e05b9c2e5b..18e32b8ffd5e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -187,8 +187,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 r;
 
-	r = find_first_zero_bit(&ep->ob_region_map,
-				sizeof(ep->ob_region_map) * BITS_PER_LONG);
+	r = find_first_zero_bit(&ep->ob_region_map, BITS_PER_LONG);
 	if (r >= ep->max_regions - 1) {
 		dev_err(&epc->dev, "no free outbound region\n");
 		return -EINVAL;
-- 
2.20.1

