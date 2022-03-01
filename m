Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3534C85F2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 09:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCAILe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 03:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiCAILd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 03:11:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3583003;
        Tue,  1 Mar 2022 00:10:52 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22180TOS010124;
        Tue, 1 Mar 2022 08:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Kkswbnq8IC7HLIuQ3ZJuH0TTAyqjRwvOMsTelD2JFjM=;
 b=p218rp1bvXa3jmLVk6nrRKDGVRBrDfc+YxM+MAfp0JssXC6X4co8wC77SqMTRBti7Qtl
 x1ast9GYmlJsNlGVocz4JkvHH/BKXxDB6/NCyg5AfjiW7zbGX5fruMis+R4wTw2rRv2d
 jaLcO+QaJa2enOsRzJwR/sibICbT7YNBPH/afKphW1kuXCtHe/I59+yO6MakHitJnK9D
 LY6IvNofsOFXQFGRBGSPNBWDLIJRhg9BnnM+rjPhBYcHbKCJX3Pz1yq5ObLQUnsF4sqp
 5xqdcvtgtn3lN6eKXwlRwPT2U732tRvwmj6WP/dpNuGZ0xTXE/fgDiKxHbUXT08v96ln IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k41wsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:10:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22181EK3099015;
        Tue, 1 Mar 2022 08:10:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3030.oracle.com with ESMTP id 3efa8ddxgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Subk9bJOY5V5ZgMkq+yPgdNSMpXGejCg7OUqCAlOtki4sCGekFGLds+Ywi5+Qcl7UCW8L8Ru/JSV973Eu+PJVwNG5dtHZ5dI7tBiEAY5KptbI9zA9tU0E5mia1aYE0dkmBByx7TKkLzETFXfLrf8iwNaiN755gdpoE0kVY/j51icfySaKu8MgblHBE4SuL5mJq6HMDlBYs553g2jc37Exet2Sp7PSmGqvUJ1276y1UvrleeaWdfeGDd2khUCK8c7kkIcbnTzvY96srCFv3fc8YMCmKdO4LqJAlXHsFl/oH4hkcVqo5HSHoK1xPXmT4MLmFb2pJGCHB8zlPC8ltcGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kkswbnq8IC7HLIuQ3ZJuH0TTAyqjRwvOMsTelD2JFjM=;
 b=ZWUYBDgw3xtIDPJqUtRerZ0L0176WP1JAdRMGhKWNjzA+s7x+drHVMoYjaoE7GqbXflJMB8+NewuTl13BjIalMusPFsaxU7WF3qMQDeYSBkxgk62FfSS6NyRRAir9akFuU53l0l9m3EE2bIKA6GEOe1aI/O2LKpIF/ZT9HK2daX1SCXo5NpeaImsKzKRwcBP4aTNs0n36Gyg9ieL29Gc5VRNH88G4GV8R9vKHua4g+lQV/IVrWfv9bHAjVXKGtMWPAfGMtnn+9dWcfwi/Iodee6t/I/0HNaPf1uRKU+vLIxQ1lQ0ae1EyuJXyH3KVl+Uhv5c/BycVLxUWYhfD932oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkswbnq8IC7HLIuQ3ZJuH0TTAyqjRwvOMsTelD2JFjM=;
 b=aTZ1Lzwjcxy1djDe7dq+kJtGhF/qp0/s0aewKKhWkJqvpRTx2qykYQlPx33AiwOehQHVbhxix0eQ/0fN79A5h+QClFjGwv2i0JUBayJQDm0ZHYLoBXqHtKY5tn4hL7NTH8opVGB/JA6D7aciBLu6fHdNqXblvlTAKZC7iHjj67E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1760.namprd10.prod.outlook.com
 (2603:10b6:301:a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 08:10:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:10:23 +0000
Date:   Tue, 1 Mar 2022 11:10:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/PCI: Fix use after free in
 pci_acpi_root_prepare_resources()
Message-ID: <20220301081010.GA17375@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a394c1c-bd8f-42cd-011b-08d9fb5aef8f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1760:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB17604D075C3D740CEC1607338E029@MWHPR10MB1760.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQawFgxYaAsEEmn3h9EFrC8Tnm4tneL54UJ4pa/hsDI6DktYKd0uPxhNoRNTgjPzBI9MFxOG+H1c6cpsrTeQjYbVIh/mNygMA0BmQvORChYzmWwEV7SvVeOaZs3Ga77JsivtedjycICWMcSpr7A3AkKmmWrFtf8XCkapB7EkQXJv4TMNhERTBFczZmXlFUgp8IqbQtGXqgb3Ei2+hT/6nIcN1eeSYOnfp4b37g9qS6c6FrC6ENYzdBb1TW0+yhTNgq5vcu2oCWTCxIeANfKSMqECzjJAlKDUsv5O22rWI2krlmDDjmyO6uTx8GvQj6Dh+zVSftEGs53PVg+95xq6NO2n08DyeOCMr/+pPdA5aDAgP7+i+4qlALBtaI7pwTL/SN9ZE48aI+Z6fkGlzWmwqz42VDndWYXbw6uyeEl8taiITc6WpF9m7on66vLGhpL63n2xvYmzS4xeuyxdCJV1Bl6W+qWmC982e6KVjstXduAMYZeN8L9sGmD91PfPZKfFxhOf2egeWmRwTZFlBZMtSehAnhNLw/J/tWEZ7NdKbWmA94hUY8N7YTgbzPz3To7tyiEDC+3kyo+LcrKKIUMV9BEDHVgJEZM/uVZLKQ8WLYEYEdzEH/DkJZvwPgUzDVVw69ffRjCrnYjvRDRFawfDgZ759C9stcNngKn54JpNs1py71bYc8l6Hr/FubyKEshVGJK8tuzjKVXj3cNvbwO9Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(8936002)(86362001)(6486002)(508600001)(2906002)(38100700002)(7416002)(38350700002)(5660300002)(186003)(44832011)(66946007)(66476007)(66556008)(4326008)(83380400001)(8676002)(26005)(316002)(52116002)(54906003)(9686003)(6512007)(1076003)(110136005)(6506007)(6666004)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiCnybVTmCp0PTB/zClAw7fqdArcbB7LwhlbfjOXcAO5dcAhzUzgJDbsT4If?=
 =?us-ascii?Q?6yaRhbW0dGgvPVh08HnnDPbfDC5rqyuTsnBoxEKq1ccLDGZzgxproPvUVDil?=
 =?us-ascii?Q?RxXAqLBGQQah044d7pf8cKK7MexcIgmqwkqgUz9Qm23+vnyfksgmTrLxibNK?=
 =?us-ascii?Q?0VTtgTwhsC+TkwfBIlzVIRbSqyxaRl9U+2jNt5uE4D8WUAErTdePSE5w2ZmO?=
 =?us-ascii?Q?zMKe1yNpqwvCGQIKn+n8yt9cNmz0sop921T0Lia3TbF99+LMGKTkhkz7MNZU?=
 =?us-ascii?Q?gxy5zbCWKY3oeZk+xbCuqGWT7MUvmHWu+a0yz4XrtVqg3Sce9M+/kVEiVY14?=
 =?us-ascii?Q?6BukynO36QcMDjonvOhuPkn0Rgliv1VZrQXfRF2U1BjxyDIA/u66n7sDCD7K?=
 =?us-ascii?Q?oMDFCLNbxBAwWDkygLN7psl/HDe0S/ZirFFmlXik2J5aQdOQiDessLrsS497?=
 =?us-ascii?Q?iXbfkClDdJxYB+LZQj/GTO9pBAWvrdDxcIJz2ObY/b5uXN5yANH8em2MDntQ?=
 =?us-ascii?Q?oiY0BMQ2rZaVjYmLqXvPBulL/R1TIqBTxiSFWYbkoF8Dd8vR5reS1xhYFggE?=
 =?us-ascii?Q?oaCggkC3evoTMx9mBEoRzWKD6n5dyKXlaaZkTihPp+R6jOp71CrsuB4vBSm0?=
 =?us-ascii?Q?Lm+21lkdxQsf2HYlG9/U7L9umRZdpIPQSqcypsvQZhJwRAaP77ZLIB1yNzSf?=
 =?us-ascii?Q?Yf33mJFlQabZ7/VsNI/2hGkHHn3pVG6pqwOZr417l7i4e9MToQC7VEfXsjpr?=
 =?us-ascii?Q?tiLPcZ2SW5YaRoY3sE3GSGdqHretjTZVfXzIvLKiUPEd+Zb7aSTRBXpNmsf5?=
 =?us-ascii?Q?uc0POvuDlNWWdrRmFcUvQu5Yr/cvVRiHD56xZF/gp6mYf8lQRxzPneXEEYex?=
 =?us-ascii?Q?w9k6w/a6GWJCP9D9WAiNsF3D3DGp3A+FP98AQPApU+coYWpHizJZ0481UFFS?=
 =?us-ascii?Q?XYGkxgbs0yV1CO+5jK8Ne8DgI+3jZaKfdRHXTRyDneXjpC9re7xITLV9qvWM?=
 =?us-ascii?Q?G/h8ZrF5D2XBkK9nlql1dhM63sBHjgDr6rfKogyq45DqVR2teHwU2LcB1jY/?=
 =?us-ascii?Q?u7y8nDuTfxBPwrK5QMQ3fg5wYmRMwU+fZGVp+MuHx9FRtFs0kJmq1JKhuteO?=
 =?us-ascii?Q?Ql+tPNgudoVbvye+3Iy+aRuT+UU/ur/Rs89O8Jh6CUImBMwhUupG9i0Dntu7?=
 =?us-ascii?Q?rxuA0r+RmTUgBRoRSp+sLVN4UMomfBBsAFraUIDduHn6djP1yBWZMKhgMnQz?=
 =?us-ascii?Q?V1PKz55O4XCRA6/a3gRoDqk40UNTxycBB1VHvhS/Kco/PlRWLUtSq6fD7wm9?=
 =?us-ascii?Q?/bmQmf0HG/c3JQSqbWTP4JjXNF/j+Fnv/iimh9oBslXyernJjn3bEADZmmxC?=
 =?us-ascii?Q?m7QQRcKSGiqbWTq/IBc3rcV6dE1yqEFmPp7nBu+BuoYzWWhc+Dt4KP4nWT4Q?=
 =?us-ascii?Q?GQorWfgSmaeq1YtiGrJxA7k1kquLSAQ+RQvdhZEWtecyj8+w5HVrPrKn/Pex?=
 =?us-ascii?Q?Tn0FEruXxyFk1NUzrf1agr+DZgcVRENKPQNUIm09JaOc7e/HZ6rKqiFebgVi?=
 =?us-ascii?Q?y5oYUsKfGVLLMtirimIyvoUfh192vgx9y/hzMc5zr/ghNMWm8pBcgG0XI+91?=
 =?us-ascii?Q?Q6rRNSCQrbGDnjhrKActmP96FeS2f4nDimbbylH6ntiqQYzJxNK4X1vxomzz?=
 =?us-ascii?Q?gCDzIg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a394c1c-bd8f-42cd-011b-08d9fb5aef8f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:10:23.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HqiRn27oFWxtyNcuCVhI+pZCUn5c7cpdpjTBnRQHXEYcjXqrL7F/Wong5WqG5JDIknk4Plv0iwWs261al+4hFE7zo784uyKPGL+8wtZFqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1760
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010038
X-Proofpoint-ORIG-GUID: 7r6V2YdOQFfaE6EuF7eO94Ou25Bp-qC5
X-Proofpoint-GUID: 7r6V2YdOQFfaE6EuF7eO94Ou25Bp-qC5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The resource_list_destroy_entry() function frees "entry", so move the
dereferences before the free.

Fixes: 62fabd56faaf ("x86/PCI: Disable exclusion of E820 reserved addresses in some cases")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/x86/pci/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index e4617df661a9..fa89ffba2e51 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -357,14 +357,14 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	status = acpi_pci_probe_root_resources(ci);
 	if (pci_use_crs) {
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
-			if (resource_is_pcicfg_ioport(entry->res))
-				resource_list_destroy_entry(entry);
 			if (resource_is_efi_mmio_region(entry->res)) {
 				dev_info(&device->dev,
 					"host bridge window %pR is marked by EFI as MMIO\n",
 					entry->res);
 				pci_use_e820 = false;
 			}
+			if (resource_is_pcicfg_ioport(entry->res))
+				resource_list_destroy_entry(entry);
 		}
 		return status;
 	}
-- 
2.20.1

