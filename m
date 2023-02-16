Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049436998D0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 16:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBPPZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBPPZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 10:25:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89554575;
        Thu, 16 Feb 2023 07:25:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFOAMx031730;
        Thu, 16 Feb 2023 15:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NF9qsrkRvixFGW6JfYw5tbv925wRA8/2RjsLpV/gjiA=;
 b=0E9sNsL54IMloiP9JuISXkY6BMUvlzWy6MZluFwh+ShdS1epwEbxDbIfl9R7BbC/RTD0
 UzT/OkEPprAHCOm9XfXToA/gJQWmfL7dDH28nsUEskZ3pwnRIPpzWDuCV+OOyD/FdnzY
 Cu6KSkdmbWpevsNTHBvuL0mbz5CBrWJHQ8XXprQM4ujNeNgh8AXNIVEJgK90hE6OGb8Y
 YcCrAT8QoVmurqz0XUjeMD/45U8B0Tpu/U5KI19i7fdnv07Z1Ho7vexa6Iccdn4LdYH+
 Zx03yby+YvwNajVKzoBS6qbcYwrZfXRDK4X1UKrUmmyQWQwqqskZ7NsrVovhwj81gqUL 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3kcpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GF4PlA015092;
        Thu, 16 Feb 2023 15:24:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8rs8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuhmXfjA02N5W66fvZxU9MOru1GyLEw25c+GrpbA6WVdsb81FBjYXnHNA8y7zJ3x62GkBlqmPMkZ5o8JOq4oaJLwPr9tOyyOOXPC1v/5FOUeIV+1STXVEa05iGSDtDj3g8CH75TxNRPLq/Mmn6qeYmUJXgdId9Wx1vXfWq2PiO8Uo+iYU9heREH3yqAn3XB3wnHPh88qAJxXPD5VKonCo6zKiehGoxkE2ABKcdRi43pjwxI+g7a0Zju/pdQlgkSxj2XPkV5pgz0QRJR8jpWUAQhXSzqjr8BIMKmmNwFVZhM9fBalhWQ5Fn97vIHj2fKIrng2k6DiSqPHAcV/gXwu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF9qsrkRvixFGW6JfYw5tbv925wRA8/2RjsLpV/gjiA=;
 b=mkiXQ2t9P1wZhEZrvlJwI+cSQg797sHNP1/Dw/ZWOZnExOdwvUCLxOGujcZV5ZpLFttpaWUbGCxhcxl2ZiceVwaC0+ggACOIpJAGJkfyjvXmNpyvOj5cJRjqj6PT6A1/Bqgv3QrBVZy81xJv4IoLhSPLRknYVRPlyc2ojO2Z5pdOAx5nbNCSc6OT18QvRkMD3hbP55wbi97TzmhkEQrAm0cBxdcMvUZ90+fv70avG1NQvHYrTNmXIQ0SRVAOVjE9SRVMRS2b+rPBHx1EhUk038kBHAq8ZoQSbXwF19GsuwZTu9SCgj6prEJz45qXuoK3zuOUhN6SdOSh9S9n+rqGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF9qsrkRvixFGW6JfYw5tbv925wRA8/2RjsLpV/gjiA=;
 b=nTuAAkEFMQBOFesVcK3hQiGmeaFAHq4xGC+aKc3aZiWgl1UklskvD0RsmnxOqbHhEJC7Q7Y12yYbxCyzBNKxfJ+P4Eu/6b1UiOfCasFBr26d0Ci0ZPhkf/pWP6DUVKW7r9kmn9w7/hTPHVHEmeZVpoc0sxgAewDVxvcFdpFfmXA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:54 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:54 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 6/7] kbuild, shpchp: remove MODULE_LICENSE in non-modules
Date:   Thu, 16 Feb 2023 15:24:09 +0000
Message-Id: <20230216152410.4312-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b29422-571d-42e1-b7f1-08db1031f48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q086hdlD6n7SeLo1s3LIRDgtJdkyXdbmz8+LWTs8vnWU4akfJTqeQgUqf94BJo+dyVD4xRDr1+zrEpRfKZBn2e0mgZQQ3oXpsD/nI5y+htVUmMIGym3YX5JSYmXfJPEVjWyYMPBOg+Fm+P5y6JVGl+NbC8tXV4xk2zn6RtguJG8bMn9IHWq3Ju7Or+LhAZlvx5xOq+JCAhLErTQifsSOcMnM+Z5X/AunK6JvmxthkqJTuWLTir5N+u1bxTR+FslCwWz7ZdXt3TDmDWPR2vuBadBVwkd+i57ROzkCYELjtbzm6gGqhJeg3TKc4sem6QCF/N4q02XDNcbONApvydY/T77chuyue5eeEInyzMeRHoeH2pD04tKObzrhonf0rVA2QuX/HukpOaySLnG45DAcqa0JPme6SPXOA1680BCECfUOkMCRsmyTSz+K+hueAgs06Wc3J0eGvnjfZOS/q4eVRDDRHJK5HFWTObX/aQFkX/7STC2kdP1kxpACJtxVxL3yTiMwfItLOTyyK1SJiGzHvrvNbmyiNtBpeqM3sn4hslthU48w2JecpH8N4DIxYaDq2cenWq7/hXmKIB8aGjeUSMLhFQZ3jj8qKIc8MUfWaJHfH5A2mNONY7Przvqnj5wFFkwRMppmJ9X3Ntva6+8UPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zicRgEh5a9jR5+qtrN6nbGwakH9Z0TPvfpI93Qb2pq51fmrsOYkW8YnL+fXF?=
 =?us-ascii?Q?uQu+xynNhJRDGhfRC89nGa9RnHZt23sIru8gy1vvWxbe52Scei1/t4XwnEwB?=
 =?us-ascii?Q?nvYCwcpa0DoEbTmh+UdcHUkYp3QWYax5kQWbGOJMSJDJoa9pM8rRBKFPaZ/D?=
 =?us-ascii?Q?UJVmnHmHqJbFg1GdlazGFDVUd+CxuwSGdE1Vc/4c92Tu7xMnhMTfmH19qic3?=
 =?us-ascii?Q?l380Xw/aVdDUoXhRindd3CgxCdtAHBtvq3PzmdHfr9bWJ96SUbxRB9QHW3Oi?=
 =?us-ascii?Q?5rt+8phUEnYM7326lgzUjMJ1ynxleIncMKM3eEEYrMRw+lU3S34P6Q9GAr9o?=
 =?us-ascii?Q?MzNgOPnNkK3qMTtDJytTdLPj9TNpGi3HGHtA2LefcXE4j7vxKxQkXxLXCB0+?=
 =?us-ascii?Q?EZeabbUGzG3mFPbXUHS4XAVvkff08wpV/HPZv0VzkUJNZMIB9Zg2iJ3JZlnv?=
 =?us-ascii?Q?Z9pwO5W0rf8iXDxiN+/QLXrjfFJZbPDLY/+lMZaEALS3p5MRZVEHRKZzitWr?=
 =?us-ascii?Q?mHxUQJisTVuvC9WgMfped/kMqPWzhnF0Jio1CetruFWQM5nDye5xrQJiHCWU?=
 =?us-ascii?Q?dFqVFmfw2XsxS8JomzBQ49LwA3STGryxavcFG8Ej2ZgWvv2LQ1atch5vfrEy?=
 =?us-ascii?Q?E0wlq6M+W6t8tw1KK9ugt+CPzW+1JbvXyd2+okLr4Wm03G7bxLnF7T195i5T?=
 =?us-ascii?Q?/Eg1KVu3WZOzCepf/l4Aog5VbG95hnX3c3LHSaVWdfU5+5DvWoeqHpkpqFtV?=
 =?us-ascii?Q?iXpe5crFb8zEbl27s6blwkiBO2LJLWRu/sFJgRHq7emOcnt5DteVtS4EJ6W3?=
 =?us-ascii?Q?zm36EMXFtDUd9QE8wR/paUU92GgB5YxpxJHtINa7JESmycyz3OfGVUFqYd5F?=
 =?us-ascii?Q?ME1NhSwItgIQ28eG0Cmx7wcuutdgzeitNVp6jszpbPcvpdjgf5sR8AOvbXM6?=
 =?us-ascii?Q?wY8zD7FVdy1GFIeb01sDAx61/botoUmOTK1NHQDbdQEQxlXSQEJIMgLdE7Nz?=
 =?us-ascii?Q?7d9kFL7TZh0CgHiJiXKXeL1BI7v4WeA934T8e0cLIgrs+7Lenyql6bxYNKp3?=
 =?us-ascii?Q?bBbP9cYxeqI/oT7Qxzi2bJ/XexfHJ/YNNd9rtqYDPEa6g2KasLMTI68bknEV?=
 =?us-ascii?Q?QKIy9MXm+lp1tqG4UAx1S/PnR3PSiGV1VuE7MJefT4BvPF4tQ9SlWvF8owKK?=
 =?us-ascii?Q?f3bICcZTWMzpbPei51y5iJeFXOUDPxvtl5v688IHEyClNX97/wHc+ItxvBuy?=
 =?us-ascii?Q?KcYwwT1A00Vj6DIdI2K6IK3pqbz70uA4j9IZHojY0jGmXwaR6nHw3WrWfQQ5?=
 =?us-ascii?Q?i7aUl/OMY4PdX8HlFuPpCw1AwKFd7ukCExOAbXr6QoXgpEh6G5YplbDrgf2I?=
 =?us-ascii?Q?rdX56EpwbnnUMdLnyaUGgzaEmsX27QJeUHx/sGd7X/kFuEY2LRCqWed8/v0t?=
 =?us-ascii?Q?KpPNFNBvhQ8LToPkphbARzMHFI/mrxGiMcB/M5UZI3F3pkGvOtVTt5kBHHPk?=
 =?us-ascii?Q?+POTxLEvgmvYVuTwcseSR9iW62me0yios92v+WF12gvv9FfUBlyvJfx9CVb5?=
 =?us-ascii?Q?tK3Wow57/tJ6CNvOVb/D4iNrQC7HxC2qd6qPXd7ry4251V7NYcPSJNfI5qvs?=
 =?us-ascii?Q?zSff/0wLgk2Q7ocmfPhGyso=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qPywts7mmgmJiHFU5z0HsqMQOllTuHyWn8oXnIXvxJ8+x4a54gMI4w8IzTmnb+7ymYPnxzlA/xG+uAo2dB88xlGtUKWBwOeDl8lK1xj7CPW+Y0akercM9TJASZKY9AGqpH5B0aCM/SchWqy6JGcOjguTKotGl2SDZxjAYfRS9a/9V6+BK52jAv7FAgeUpsfLqBPrgzHmw71bR0sO3MJ76tODN2NpE+OLcz1QCf0PUTepkvRNueNK+KLCleZ8JmQx8HVo2wcWdr54eBcMBnMKC4ynizyNzN6L3ZGFEpOIHzBXZ7THShcw5pyXFIBFgrFsVbbiFpyEpkQC/LnTxjvb08jif5F+4WaUIJDG/IB+/96IhDcoQjrXFJb+7DoFY7TXq2I4xOI72fo+/FW0nlLepyPtxeBY/f0WFsKeLfW09LHfHYTC7A+6qJmFigFMFbV9yMcIEJmeaFUhzRj/LELdBQCE1AnivUivAtRv8VSMMSj8xcxiA9MLfyRoGkRnYCtE/gx9AIQcjDFftBQaCinyzu3xeUSgBWpUhEoE7IlbcUYt+/NsP/cmSeQ1Bk0CjGjJed4ccYNOibzb+6lEKP+nY4vGPLRIsXaT14QqVbMmeigg6c6Q99S4u7I8JjuNVD3Fo+bbFkQKSNVGxGAmCGUvWgZ7S0S5iSfoC3ulJHKQBJ/K4+2+3O6bZZxCVKULtl89/IgViETNSq7AFU/dC4cxMbShZoq3W0NiEvBDjQAISTzlk1JV8uZuIhvnNwAEjxzyztKy5DsIN+tR+otvQP5YdMeQsJNzixrOracDOkeZn97vOyn0SsRmeGlOiaAex03cHG37+esXQ6PekM0ktUIF7nsUa6VBCR/9txPIC5GqXfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b29422-571d-42e1-b7f1-08db1031f48a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:54.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPT7rZ/SqVqRPfvvL7c5NJBWmvwlGsUWBm5qeGevkaVvxrBP2AZnRk9rMSQILzBxTcqqiN+vpNb+1eCg6M0Szw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160133
X-Proofpoint-GUID: rZRgnW_kxEuUnJwb8SyVd1nJ5w8KuAuj
X-Proofpoint-ORIG-GUID: rZRgnW_kxEuUnJwb8SyVd1nJ5w8KuAuj
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
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/hotplug/shpchp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 53692b048301..56c7795ed890 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -32,7 +32,6 @@ int shpchp_poll_time;
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 
 module_param(shpchp_debug, bool, 0644);
 module_param(shpchp_poll_mode, bool, 0644);
-- 
2.39.1.268.g9de2f9a303

