Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830969AD80
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 15:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBQOLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 09:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBQOLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 09:11:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B36BDF1;
        Fri, 17 Feb 2023 06:11:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iGq0007518;
        Fri, 17 Feb 2023 14:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=SEZJAVxBkRBJDjyfqQmJkvnbFEC56McKlujiS3nD0mk=;
 b=Exe1SlWf6dirke1pzkGZoZDWQuA0OohVke1XlV6XZagAHf50G1CgKObSjAFMBE6z3PQe
 4VTYXtocjej/T5r1sW9cTnq0BZlIUum2UDc87kOjFqdF8GzvNPXai6zSLYBnuGdaJ/57
 CjnQRN2kufiKBnFumLvbJOv1Plrp67U6aq0Zd00OxVFLl9i68oVrBxkdfcVCYWWQzpQl
 SPW6LiCiSfZexcRUUXQPrsGtQrimtgIdc+RjOqtcRTK2Wdmds+LBFv/T5q3Dftf1iO/i
 BS77BARXGCeZH5kHDlxAxdxfGY+PUrWiyWKbL8BC5gltsM5W71av6u9l70DHo/kOHGVW uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m163dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCjndi036124;
        Fri, 17 Feb 2023 14:11:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa6s3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhZ70DD1iB2J/KzlK3puGuqXedjKOxy+EnVk5/Ri3w4yFx4kgC45X9Rskq14z8za4WIs1R4qEQK8AkvkWQYxaCiOnGRgjfzrblbdBBDcj5UTHbHE9Q6jNKCVt2SKNNfFWIA7lLJf/1nvYX5V46zhcJwHcz87dgnfed1xlXTSqwFI6qxMKdyftVdEgHs6d/Ny4E8Ow9tCJPe7scqq49imTqrtdUw0daPf0xVMCCZ5lYX32+//h+ykrh8+nXsj9NWWkxLhdT8vaAEcVS+MKQ7Za4jzwVz9LSlfr/mffnLR04d/uCnebJpLjVX8gc2lErpRWf1nHEmQyyWTGS1S5DucIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEZJAVxBkRBJDjyfqQmJkvnbFEC56McKlujiS3nD0mk=;
 b=m0+jct3RiXxVDUjhh4t3+v91p50CWtC09kILWm4A8c8JVaN0qSlg9ZMY0B1Io8cj4w9hqkDJlnfZh3vE7QaZzOwpdlhmqtOKCV37dR80bCOSr3xCeuccuTjRw0frPfZ/PJ5aRhENlSOHHioPVNNvVgCNFIBZcWoWnn8h85Yh4ws+z/07ZbWQzmTRG87/tvu8PHS4h6FKLnFBn6XAbqqmITICj6yon7AFDw37a4fGM0Qxow62S/ar3cicDmIYJQEHsE7g2n0ND0d6MdMm4jL4TVx690BHCi0eiE2QBA3ht1Jw3rOHrsElocbUwo9JomDmQjFOWT4MoIlKlw2+Tqt8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEZJAVxBkRBJDjyfqQmJkvnbFEC56McKlujiS3nD0mk=;
 b=c0dbeCzDjbVE/qFhC6ITerNvLYgfMeLwzyq/OtAQ5cmd8UhVDEJ91ZC1rDOw/OLJCVJ8HWMlgHUK+Rldsoi0kPxbrWnKzGnNtZpxUaSzIJqEgrN5c9HbAJUKK+6tKwfFyXXgE7YjGA1/OOPPqFO1N7LlbYBktkiiUfQos7ANYG8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:11:18 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 02/24] kbuild, PCI: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:37 +0000
Message-Id: <20230217141059.392471-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4c1098-caa0-4d4f-9b65-08db10f0d6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XMG4N72Rn6WxgmCG/GdJ0k7Q3RWa6vhDrRvfXpTO4VQtzX53w7rfCwRR1hmZ3bqvHOOIP2XiguSpzOHtd7L5tn0gSJxpusnVKfhTnIs/qTrP2FaOhHByP5p0aG+S+100iBMvRiS831MmxlOzMGhpNpDgsEm4+8TvHA7vnqFTibXyoSF/pWhayPzMAG28SpQCEx4o621SxGj4tUE/imflIWZpHkAUQkQYAS9JcGtGhkbKHdgOhCKFqBoh1eefkVDv49XGjnhqG/OVmmLBheoKjnJwpvcJID3xltxxjih4wn3lkTgDK3WTxlm2BGX/5TvGyb7IOuXrEL+BGFKGkP+EeGhdvTSjUGZWwRpAinCia8DK8sqK9mU7fzb/ic/kh/wdGacxYvJ8rgeFaHxuqkfoKjV1LFsNCzBBeH1qWmp2n6SLYFQq9W5bPlgTVPoTLxXJZBzLwr8g83U1Y7HgsqK9Hek7N05vw9kdUytotbVsg7sB6oDcbebG+aJe4NKOFglqc8W8TgreJ8+oLtJPpA1q1shYeLGsEFiG+ktCTz93dMz83rpoECKlKU4Md5mmKq7/V5y6nFAR9oomUAD1DRPGT7E/WEemMqON2BWiNdhtbeyyAT8nw61rqii3aH7oYFWZxgufdvOJHXrcu26WjQlZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(8676002)(6916009)(83380400001)(54906003)(1076003)(66946007)(5660300002)(8936002)(2616005)(316002)(4326008)(66556008)(41300700001)(66476007)(6666004)(6506007)(186003)(478600001)(6512007)(36756003)(86362001)(2906002)(38100700002)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqkShMpSEKMWdyJNEU768j76dTjV4FzJ1rsYuH+ivd/flz6gVd2Gsrx012R4?=
 =?us-ascii?Q?Vl2+W1wf7MlJX7n4ls5Etwyxn6YgygSpQ2HMQcme12pNY30OxPYvFtG971zM?=
 =?us-ascii?Q?YhAToTpnjkA/rAPSI/Y488nkIFSy/dk8ROh1MWjLQUV+SBzSxuYzp0/ro7Uw?=
 =?us-ascii?Q?324WcvC0dEFaQKeS+MIwDfltAjOIe4xERpNyRox1fEGYcXL0waqaSnMxZqSQ?=
 =?us-ascii?Q?qYRMiF+M27gQ6vvMGPPPnQ/M7aKd3ZnSTR08nLjGMrwdXVuWWO85kigAyxcy?=
 =?us-ascii?Q?DOhcCVe863LhRkRdqcmzCIhZe0UkcUpqorL7caV41NIc9UGnrqX2Z2WXurZB?=
 =?us-ascii?Q?B5R3hGvdE3F5jOqFvzEWbtozTxXuqJv70CrPSZIkhZ5/ukMdCgvyE/WlUEKj?=
 =?us-ascii?Q?FN794or3LbdGNvndSx5FmlYKMURLUrrcF4T8NQhunOLe9vx9pEkIDolSyRoC?=
 =?us-ascii?Q?3oKpYjHOy1Vk7HeuNm85t82EKgQeYmM66dd5yiWBRUDgSS8YXXxjZgfYk2Ks?=
 =?us-ascii?Q?w+EJuM7EVls/4SSJshR89+SWIq+dWxi24hL0fJjITzf9j6zpaUysMM9Tt+Oo?=
 =?us-ascii?Q?wlYF9SV3FAdWyNeFL0P4RG2atJ6CpHt265RR7CLKjqZ0U+IhLKgmCneAZf/5?=
 =?us-ascii?Q?RD/JmvzYVtrBYCFqAoO7lWKMa/dVMK1vWit+Abp8DmhyLbjueha2UIX4wUjs?=
 =?us-ascii?Q?L855ds/6w2xU3JGQ1bKl4emz24J822a1bqlVcy3BDK/OSL2rDLwTwH6exFDe?=
 =?us-ascii?Q?xAQXxM3DwvSK0y1V0t7U9a3j0LYn62L1aXMXi2mcQoPHkQDSS5cIFlXD7tPc?=
 =?us-ascii?Q?undKJVSOaSti2A7/dfrD+LIlqU2UKDx7RS0QZ5+DkhvFqkcJVXHNJ15JjaV9?=
 =?us-ascii?Q?Nx+5JoC7ICSFlJlflz6cuPQGSRx5zvVqFZspuFZjakFYdwuCZOxPWmLHHeDw?=
 =?us-ascii?Q?G8R/5Rq/3vB7zS4MuDl5GOe1j7Y9ygQ8J3PsucUOd37CWiyglXaLzh4ijXWY?=
 =?us-ascii?Q?+uwZc40eIb40jj1USCkrieHP34w8GENozDfHV1jlWKPS8PLDc61aenF9qY+J?=
 =?us-ascii?Q?4Hyu8Ve1wYFUsL9cra34o8zQGrT8QWipICXv6ZpUBD7Bzaeioyp8gX5JDUGW?=
 =?us-ascii?Q?BZ2vgGgatHXa5m1DLWo3pbxonn01XK8nz521re31s8ozc06s1/VisgvBj/oy?=
 =?us-ascii?Q?/1/o7TP6gk/cTodqUQjLiFN8/siKAAO8ZljxfUV8vJjbnMJJNyL65+DDrqeC?=
 =?us-ascii?Q?e1MerS+DsKUquSjnu+prBKahxhVI0Y9bfDHoDQHwc/Sxlfoebwv5F1swBIjb?=
 =?us-ascii?Q?6lHZFWyw5icp06Ssqw3tqU8zOU9qSv6qZebR5dfUuqtUceFWEjbK5nwCjOxB?=
 =?us-ascii?Q?wsn5AZehzIElc+ucMnEyBE0//eecb5X1sXr8Hz9RGVYO5zMT8apzqZtaiv8X?=
 =?us-ascii?Q?qNPXMpCDS1veOl075YxlLsTyzRPlCH7nY7oIO4wNXlMbJ2xDVDMjaHYqF8yY?=
 =?us-ascii?Q?PJmtFFlgsSqonmQ0zbQHRvY60v7Ci8FhIXxGqjt+7tUxAYfavoCHy7oAlwHg?=
 =?us-ascii?Q?JomG+UozhIVPCxyjSaU4dkkrk2Rhu+bl2At40Ei0gOc//NYeOhruAlNbJj2B?=
 =?us-ascii?Q?m8MW1Jp59LTLOK1clf2hS10=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8kEzfzWGGTLNa1FURcq1MSQcxgquhgiBCSmfXuLpwR1mUwf4FHGoZaSxVs9s4Rz5DvCiigKiTX8UVLSfUxlP0S0wgmFTPyN4FrI9d3jQ1OPX69V1CcPwIg0Qh2oldF3Rv3tD2U3ItSpy+I3bITgmdf0LT4HDmUjSmchud47CMselik1KJYAmuLErZrVTNUtC2iJGDsp97gdwPwiT8iLeOmFo0ISgkOrUrPHdcO/7TUJ9sTsQtx4CJy6L4XOBcBHkiDwYnE73CGCfVAMIWwJepNfIiU+k7/WqTpsCuPLOA90y8Sb6CKvWLPtsh3BrqgVFo3zolSvcg75fBlm4Qji/sL7p+MMMcfZs5BbSJgE/5f6d8/h+3swhh4NlJJylCCHj/IIj++Kcp0lZcm62zy7SG7j8RKhOzl/e6DlZaIasK70s+TPelrSdz+Gbl8nmBMZtLNjZ19R/GtQnNonbeWvUSb7QoZT4UH3tt3g6Be+wACTvcXpFyVEzeTjRzedgaZpP7lDcbU+WDvRrSZ8KzDSQ4arRzh4kHd59KrOfz+V4be+eVMVF8/spi9t4JoW/M2xHHoGuGLG6NJQEEmHjBC4TYV9VRBWRAjH51+mhS5YM6IY1HmhUWIR2HHyAeruDkkhe2CfZ9TrzAnRErqd4p8OJPJFLvhaXRUWRMxcmjrZNAgVSHL6hx+w2krBNmWmZmRagx14GYwBLjTw10NLS/9a93o+cxMnnW0pi+h11lBf17BKSVWyj4h/wempAg23G5F8N7dP6vnbV8OPk10DvomZjfOGnlOMcaQRqd+4Xo3pWjGoLzAgbcPU0alCA6ueKgKPerpRxSLme/3WPMbKps1/0Te6vV366LbJNQAbihX6ZwmY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4c1098-caa0-4d4f-9b65-08db10f0d6cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:18.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09B7+K6rtGdl5U6CwKPptRSF9dWatctamnI1GR4COpY7wLRwaHztXzvC7n6eodJkwyXlkr4LSYa4WTIigi3YFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: eqlWxWDXmDCuQW1w2kUg6qMfhDPwEOE3
X-Proofpoint-ORIG-GUID: eqlWxWDXmDCuQW1w2kUg6qMfhDPwEOE3
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

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/hotplug/acpiphp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index 853e04ad272c..c02257f4b61c 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -45,7 +45,6 @@ static struct acpiphp_attention_info *attention_info;
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(disable, "disable acpiphp driver");
 module_param_named(disable, acpiphp_disabled, bool, 0444);
 
-- 
2.39.1.268.g9de2f9a303

