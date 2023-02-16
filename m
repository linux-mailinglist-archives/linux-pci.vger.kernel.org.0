Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28026998C1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 16:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBPPYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 10:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBPPYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 10:24:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E445456D;
        Thu, 16 Feb 2023 07:24:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFO9TC009146;
        Thu, 16 Feb 2023 15:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nnhKUwMWtI+8zHGDvewkSUiT/ly04ueC3kxzj9Cwtic=;
 b=iLTIvSW9Evyyi+EuzB3hugy3rH8BvnDFcvlU4e3s9CdyJ9lPAYEKB59A1nFjo4+Ps6XP
 pOlRv8sbh4e9yrj0/bGJmJbntDX35pSUquIsc3L0q7ssmsow6rKsNEokhQjlw/22Wzqj
 HZ87zYnDTKvaDsD7vfqEE8ykwQ9hxsNSas84s7eNSGAwKsO3gRIW662f0tw8A93t+/ZT
 JlQasCUbeT9zeAa/JCnFdah8zWlHeZss9VpXN0R6GOLINztfkY35d0fKhZ/c0acY4yu+
 8gslG/Zw6nAXL6zX/N3+Mzqxly/78K1vr5FlB+2e1p8t7YdOcIWrUg0SBIgCNU2vuSrX fA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2wa3fdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GEWc6D016838;
        Thu, 16 Feb 2023 15:24:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8tqv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l//N+2O6NKBxiGni8iFD3kqn+7Ms17xMKvhPau3t0hxBQIzSXYBEUoxod5BEJLEQ/Ydg3D7Ng9UCZUPSArjxZ4HDsOUQjMmgz9mxT/8qrUOQ6eTEwkCct02bS5dNhXpL1CNgXSV6DqPr1o5LCE4/WNiWUrcwatObtanb6u2B5KQUfwuTc/4MhT4zTfX0OHBB468/TcZuDntC8Nymf2e4CHri3UXb+h4K6Jt7/vfd7EkPLcuAD13h7Tdx9cMC7R9l6HN1x1Uf5oIuMucp/zV6EJWfYcmIKm32iQgkJxGaAQZd8nnjIAXoxqKvh8rvq+hsT+hThvJwZevd+A/t2PgOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnhKUwMWtI+8zHGDvewkSUiT/ly04ueC3kxzj9Cwtic=;
 b=H723JMZM9DQnXdK6KGIjxsakJO0+32TY6tlSCZx+7bb6cVy+Ecp6zOMyoo4SAuLtzoeV51Y9r/2QB2Xjzm/0RFMUjj70UxmrxmdmFn9SxfSnH674CdU7laA9x3DNTcf6iryx56IrYqbMD0+5D8aOhNhQTyFxQ0iiejVEtvzFW4f/CqaNXIOoZIh2vmawqYV9D46qsKzzMIGinMRhZlVn/3u2pbmVgioMecU214ROrTbqMpGVK5LImmBGR3Xo7Vgi65lkTCJ1UUyA5/C5kSLDUhCETFBkqMikehpzM67YehFSI/f8syO00igRVyvKuLRQIUPHMlvvZRiX0Q0nQFtuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnhKUwMWtI+8zHGDvewkSUiT/ly04ueC3kxzj9Cwtic=;
 b=SDHmcsyAR6XF37Y6t1VPCs1sVPQ25blW+MwID0z2LE6a4h+IQ4obQBKWtKbHA4hHC+QeKW0AtJs20H+AKpWMB9xlKqod2/QfwuWnGdve78xJ9+BvYh1J8aZWqD0Oaw3s2NO0cjKDQtsA6JHpBghO3e+OUqTGDBDp+O/1bw22vB8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:30 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/7] kbuild, PCI: versatile: remove MODULE_LICENSE in non-modules
Date:   Thu, 16 Feb 2023 15:24:04 +0000
Message-Id: <20230216152410.4312-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0525.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d1cc25-dd3c-41ff-dee6-08db1031e617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/bOX+TwqzgRJEKgPrGTYTvlDBTiPoCwpcOI3mS5gNa201jx2tXwSRVn+rOiRUwlwg9W0+Feam3XlaoGu3my7TMuD4tKxafXpIRYqoRgG/j2NaaG6vyv4w5xAJC0sPRXjgUn1pqtpcVynwnxGNC/TtuSEHxSGNH4bMGs2dzR2JAkrvjHa9P+taQL3KcmaQsC9PEtcijZSaCSZgHa+4GXxYeFNPFCc9ZXzyYRCA+kloqXZGTE0K8sxHZsLbqgQyueND6Y4PQBf8xP/j/yZr2p+nlW7LTXZ4Si7Woy9O/skz/Tl6YZNx1+EQI9nYjqlVnfOhqOsKYokCxD3N7TC308tEypere7zf2q4LTzaYOy6aSS5n4rECwudKPlI2z1gKHic4duhBocQXSxgQ4J4aPPkfg21T9sSG9cQJ/GaKt9ExHredJn3JCJmiylKCTLX0c8lzoP8aUU60ZY7KkkZNOPdDQkYXQ7klKSwEJlTsIHdEhldKCc64d2a5GjDc/hVm9KOwlEJI4BlvtWTT8qSQwXvmRdvb07bsxi/2HGII5Wp7f1EUVBePP5dr2MrG5/8N1QvKdkZyUhkU56Rli6nNfeOCZbmzrYdh2PKAwGx9bTIxlepVK+uMS7GvM5B7+SDdQeyEocm50p8IDvMKaiWHchUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbPxmHBoLHdXilKxeVghYD/3GTNUPuTEPy12MVjR4gXcamo0ITvmiEblCy9V?=
 =?us-ascii?Q?mD8sns2LlNUV30x1JBODirzODVfN+kkGtxxFPqsM+Cx/kVnemNVykn5bbPq9?=
 =?us-ascii?Q?yxnY46kQbbtwotp4A0HOydXvK9Q2AjlGPlQxHZkWWSolulL/AFm6VtzBzdu0?=
 =?us-ascii?Q?4GGW/eCHRxQg3vY7JnkRs3jj4O55QtzzwCDCrC6+k7xDA4hXBw8IPt4Yqm96?=
 =?us-ascii?Q?K7YAbFIB20j8KmSboSxuu70EjxB5CapEbD65CFTzoxfzy1MblUJ7str9hfGf?=
 =?us-ascii?Q?RH0OSwNYMzttRW4pFIZpANLAo9rQvwjf4ChCFIw66//E65uC+GcDk+Xs6KQ2?=
 =?us-ascii?Q?rgbN1WRSJQ46QheYOj/n+a9ehb7Ay8y1SMesgwYIy5PDQJmmVaDu0qhjsaq7?=
 =?us-ascii?Q?CZNfCaDoF1FxXEBsRUdyL5cZXpJm9SaIA+DSgKaXiQntQYRx57p6pdJ9GsWB?=
 =?us-ascii?Q?+BtYfgg1l1QxBZOrlSluziOoRvjYjxUEaExe+YerNYNaJtaj2ozPuKvN9AQ8?=
 =?us-ascii?Q?icjL375xIWpfTPnI/yvM4vqI9OxzCEJOcXpqJH29bvLsbYTTJRuT8pkkn554?=
 =?us-ascii?Q?YrxaxKqYvuqqaPrrduZpRDKZM8p+EmyUVlcWGkG3tG9k2SQssySd388oxIiV?=
 =?us-ascii?Q?MGneZ49tn99pFcTPMFJOPoFMzjZLdaH0UOS5ZmgJNsXre8yYT5ngSwaptPgk?=
 =?us-ascii?Q?2Y6w6hpa3d6Pd61p9owEae2x4F6pWEfMXyHM+uhzFNKhnsCc9OFj/XrjkXa1?=
 =?us-ascii?Q?qsvSQRPSxffnBlAtNwmjaiOB3OuM2aj5OZ/pYCTaAYZUc7oTqxE4uExZI4Gu?=
 =?us-ascii?Q?C0+SG9LhFAjwcfAMC0DV1Bxtjl6MTZLZA72vGX4k9KbhYcHByDiFoRQXuFp2?=
 =?us-ascii?Q?VuApYNB6geytOPcbHSAJKZdE1o2tAtKMITZh/nHPs6AcAYNroXVt2MVirYgp?=
 =?us-ascii?Q?rx9zq/ZgK6fVsl1ChZ8Of1M5EhAPRfNZvJF6zhJptxrS66nf/mL1vvyJXbL1?=
 =?us-ascii?Q?/hCmqau+Lem/r0gbgBpzll3yIv3K9CAPOFKza8kTw1LEaELL93cRpQGfobCW?=
 =?us-ascii?Q?rs+v8iG+Y7/ro94el/k92ce3t/7dUfokVYPVw01X8SOSqTWpa5mmI91Z+aJP?=
 =?us-ascii?Q?6FDlBnWrQcSMNGjxhbTKpCNea7HDWilkJOuh75tLNJLKLilTwo7QG0O31hll?=
 =?us-ascii?Q?Y5uxFeepH9nEKnxujjisGScorLeb4U58hOwGqkj75IIKxRHJGDSY4+fGebw6?=
 =?us-ascii?Q?vGlWRwwgxPHOYRpGA1zSf/PjdEQW26V85o3ckg4KLzO/l4nas6d0Rgb9hjzv?=
 =?us-ascii?Q?1OHuSETc0eCILUJa27y9ujdvLzI1M9jJw0pEic3rsaEKMopLnDnzo+/rVtIq?=
 =?us-ascii?Q?wmkp3sinEsh6Q5PXIjRDvzBFZ+hB8wPAczfRdtr7KLd5P1X0kkGPzDrK42Ca?=
 =?us-ascii?Q?92dK1BMq3hLsNxFKtEqP01jYadO4D5wIExgHAfP3eIn9uXS3KX1nIP/8/Eej?=
 =?us-ascii?Q?cJyShk019QcDa53sdVZWqwwSeWXw+QE4AzR2PRAm6WBCxOCcqzi6R3jf9jpU?=
 =?us-ascii?Q?47aXd6TmQGO7ILFDx3XrRgKYDThXBv+BSeLDlvM5+qImRh4Qw1rcPv+5tFd5?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QtVe4XttI6OrzknW/SYAEBHHOqG50u57K0dMZgGBKixEgMA6ebjnK109RBq/8uuhh6Yh8gL2iGMlSX+0M6nBNzS62m73FUqUHMzMfYjDYBLXDI7+VSI7K8zrgAbmgsArpFsOIpji3TifGeUZXt0Foew841YcT8aDYt1Q+bCMt3uvXlRk/PkFYg0OKThGC2MDkS7nd759GNoPiXnhwiXbRgDRS2Nsm34gdmH0V3esZcus/POmYq7+zCYhlbWHds6K1y+QaYmWADMiPAK7+v7keI3cU1XTM5uvQSd0SL7G3dWtl+7oz3bERwUshDSSXVGTpkfo9xDXtLH3kZ91qI7Lm8q2ZcuL5Wot2XramrC4yPNNHILcrDPn0XfC05vTFIpBW1Wj49cuZdMJXZSGDvZtBsLMZeyJ33bI+Cj9eOXdGs3WV1NXNxCmqMUe9QKt733G7tFCfoKGi3I5y5mbiU0GC8KD6cQbSR65oulfd67F5Z4qXDzTcxK29hrKvs2rtyAbBuJjJ4fLzCfa8mT571zTUS0wdPn6L87gLrPnH0XdAD3+Hu2sgaQ4fbV0Oa7uaddH9eLonF8Cpde7j+pMoDQ0divzzkLNLP54wduO0+fx0ERcl0ayeGblu3RmZKaj5Dx6ivq30FrfoAMQjFAO1Tec5CKNQtRpTKVRrXqaxfYxomptrtT8scns6TCfBPzqrY/2KlFd/u1R8d05fzJkzY6DNAeWPHrGmyR5QJ3MAaiDqE4l+ExHC/1uwEKBD2xjV97qOoTyB/47e5wkHQjRM5PMYZOoim/yljsIcRSbv7okeyfUUdjXoyuilhrOCqHriUX2qD70xgqOYbnCK9KLt6BYNnAa7pZPvVvYYFTYrXAN1mfgYQcsWdOkRTV3DSFP1ghahPxzdda33bo2xduid+AkeQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d1cc25-dd3c-41ff-dee6-08db1031e617
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:30.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrjH9jlTWz7uKdH2TgUusp5/volnmYoOs+Qv1JYN0nwI/nbWcpvVLOg5RecrW4FXdsISpzDayNS8QQsxA1BDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160133
X-Proofpoint-GUID: 5X9YXy8cmIf6CYC_q0c5Ol9qPGiTGH-j
X-Proofpoint-ORIG-GUID: 5X9YXy8cmIf6CYC_q0c5Ol9qPGiTGH-j
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
Cc: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pci-versatile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 7991d334e0f1..e9a6758fe2c1 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -169,4 +169,3 @@ static struct platform_driver versatile_pci_driver = {
 module_platform_driver(versatile_pci_driver);
 
 MODULE_DESCRIPTION("Versatile PCI driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

