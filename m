Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F46998CB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 16:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjBPPZH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 10:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBPPZE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 10:25:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60D55E65;
        Thu, 16 Feb 2023 07:24:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFOGm9018428;
        Thu, 16 Feb 2023 15:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=emQ8pT9f6XYht4v/ptn8hzIMefO5uCy2q3R/xD3GFzA=;
 b=PF8I9A6GkFnXkW2pKMUp6lzyhiJgbqfgu7aj2aPcpvKiPMCEXyWLt0Du1qU9ONwxsM2k
 HbqLK/yaCFenxpDLz72ybQ2ZihOX2NHLrJoy5IfrbiFCKTI2zvEhWB66hp9EI/hIcCeP
 0QAC0Hoy9mGzpOGqBjCQ248Ru4K/bNH12R4jGurdhfh9qJqAF+1AlIpSEmx8ImFORHPb
 b/6SyN9YNRoAYnS5ZbmA/PhdpDv7i8UupBRrb6e0ByCicSLeTSZKOSWHOV0tr8hdj5/m
 n2iteQsTjBCR5pJGGS/00lkUYE2KihpdW/nqnm2CjBicBrI1EIj48OnvLUwPDwmn9JYS CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32ckey5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GEmeLS032448;
        Thu, 16 Feb 2023 15:24:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8s00d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQEdV3HYHQBjEv1ulGhVFD3RsK9JE7wK6LU7x6UNrJYNmKMpzVD99VC4OV59Zv+Ewwe27+Iw4Icm2pgxxM5pq7oCQ7BdDfCkbGIp6cDoDSLVX/d3qZJ7tLwYSskmzpuQIYGEoWeIbGUeuXxHvSIRHx1K83HcA6DFxt6csp3mStiCgwpyeHASqhDaMnDdIoBNvFaePGGPOTCqlEaKz+2vyvxgfRjjl4lp+HREo9Zqk8QqRjMiE9PtC5hyxx+qHGNs+470nT326MWFDgIbdjlfdL/G+HMDb/62b0zOAEX7W2gitcCCeJJdsN/o/+S4Vn3ysji33/ERMwH75sx/V4xaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emQ8pT9f6XYht4v/ptn8hzIMefO5uCy2q3R/xD3GFzA=;
 b=U+3YcZn44AzVs8t+FcYDSaaesOsMABDSci/ntLLSSBpylqNDji8XKz06WysQuKq2Fug4JCUmmmvtgPMo18kDxpSMdMSyQBb64b+tGjE3MhBj7JMBauqpCVnglZwHI5bJmRS8lGQGG1b2RDnYF0XjyqzyC7FiV7vu6JQha1Y32EeiX3dleiYPlAstpT8Y3m0jh6pO79JzVvnnpElE78n1p6cIB6vna8Y3cNv1ZPx1Xd8bBCqH4m0Zb3gTPxzqMJT0i6vu52EEwAOk6EFD1IPTpvbmgNdoBlelDe/VqZ+lW+BepGwcUi66YFyTA8H4eYZwXoNzNhjXUsXqT8AdzWpdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emQ8pT9f6XYht4v/ptn8hzIMefO5uCy2q3R/xD3GFzA=;
 b=j26xQgkWNZC0iukTQJZ49AvbXjqIUIXO+qy/J52SQ+5q1wBhxEIgcjdB6ltM82HpVT8n58bfQuKMUL4cbhKPCgp2D9Es7yJCB0oh/KwmUDpwb2lSlaV1X1nuanBIE8atV4zyHeGLiQ7e3OW+duv6QtdjajR4BO4JLhP8xlOGjVM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:44 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:44 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 4/7] kbuild, PCI: endpoint: remove MODULE_LICENSE in non-modules
Date:   Thu, 16 Feb 2023 15:24:07 +0000
Message-Id: <20230216152410.4312-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 156fc0e7-dd27-4c6d-bb7e-08db1031ee96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzh/Y0aX+BeXUxaSp/ZQIX2LdjImC2SfYPwoLVhohAWnC0AYv0SODbHzLncUml3lOx3JEK+l8KAfFawKqgNuMJBecu2V4zJw/7+pNJ67M+kJieWg9b0Y+c/YezOfUifBIN95upyKY/GreuY70hQmX7P1RbLHpHZwPhq2p+TlZ3rnAxVcMV0WfYZVJ08fLQfpTF2m20jIa5BLwzHjJKpju0X2M4006a8tUhnE23t1/7nzIjB/fgRt6gRsGLleXWsPZmbKb20t8DAYUA5/gEXI5zxaKOxjpwMoXpQLo+s38sFvjqASOJGcdOayeviAXxc78gB2JvX8hTR+9dJWDu4LddsQNgWEcHyv5TSw0RuivyEdM14BO30GNyDCYnOXtBezEHsYhCkbgm77xUJgyBl4AFeRPH3MiH7JIOsGOVHQYG+R2PuSD23iLgLsJj0JDElsIFUdyfgU0a1oGdRg3oRM8Uh2gJig4yTHhl64iexzGuwyjDMcHK0PHA3T+LpmR2uORDGYOzih763WFKrVF2aUE/hAnJz7L8GcEzYH/R1D+L6oqsBUt2ArtdUNKSam8h5PiQBOY2TIc+JxGNtDchS7UfjwRs+2CQBcDXSnvGe2YN+osfIF23GlnDDuUHCePcWjYsDxQPMrmcO0B/OZ6U3oSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/mXO/wlenqz1W4rCfXqRgMWikfS7ms+5yJD2XOnGv90KqPA/YgmXXWm/3Wh?=
 =?us-ascii?Q?PPLI5MbiwXv5aPJI3qSkQWTgl4P5IuzTq++Pap57/mUO4syC6T5Lh09F/iEK?=
 =?us-ascii?Q?xpHZTFZGJBSuwC3iTAgZZ81Q+JXzNrgrx6p2fIcqrMp011+lKtEQs89mAKfd?=
 =?us-ascii?Q?MgfnRDzYU7h1Fo62iAIbnXKwCCXXGzq8vwyPSo5apD5UbwD8SQmrOzP6UKBt?=
 =?us-ascii?Q?FDvJrCOMXbeb50kknMRtSlq9S4+2qhG/FSRqYfKnykwZiOcaLv57n/5M+woj?=
 =?us-ascii?Q?FJw0ZWGrkglraGDD4f2KFf/wp1mjASKJko12OGTsl+HbnoystSkK/d9p535e?=
 =?us-ascii?Q?Vs87y7eo69VfNAOE/ElEpJtASRNkEU+rKW9hkiIRdwi4tvY3MXIGCFxh46qd?=
 =?us-ascii?Q?deW+3jnSB+sRQONf7Ok1e3o1IucR72MF6YKhefAEMr0sQG032jSMO7qqn5WZ?=
 =?us-ascii?Q?vcN/yZPJEOLXjdRZraPkXEtd5YN+roHUlVp6bUDlzTpbyUfZl3Ey+CMwQqFx?=
 =?us-ascii?Q?i1QYDe91UrihS/5vQ1VosgO2fQXeM/fX2pVudO8vhJZ3/Ulpl3faR+rzlfN4?=
 =?us-ascii?Q?K0Bnc72bNjjTnSd1mt9sV75mPh/JMoKo+rnzqElWfeLT01NEgvGrDbvu/JQW?=
 =?us-ascii?Q?+g21ywEcjeWL7eLBemQDlnO5LN+YnB8ruqAzs4gpMUh4KNzaxn9ju/IyiGh0?=
 =?us-ascii?Q?+kvyI2PHmdyM0+fmM112MTh70kxOv8O1HBMEEQGCjci5jCzZLXEFb25/9BWg?=
 =?us-ascii?Q?5lZKEA5nDdTCuEzHdTUbcMnddbgoS0EvAtK7VlJ62JbOxmckNjlm21Vm9IiI?=
 =?us-ascii?Q?qEBvD5vQWqoAk0QqWzd3D4ovqVbaIvQPH+s4Dt64RChBZkyACipmPPgBvnLF?=
 =?us-ascii?Q?xgbCmzF5uGKz2P1TGbM4sOLhDuDreB9D8E8xnc8+v5TJeB6hKlzgCABgFTIe?=
 =?us-ascii?Q?GQKQ/Kafwil9f7lnxMEY+/Wd8Jr8GqpO2Ch5k2Yj8zlYo6TbJVgmOtlO218G?=
 =?us-ascii?Q?VDGlyAsL1OP4tp8N4vgDQeEhFrjF00lXWFR9NEZ7dVKNow79YKYQZN09TuQj?=
 =?us-ascii?Q?2VsHJBPnL9Z62f1bgKvH0fhK0rKmW8E5DCoX0G+bOZUxbeE+K2ju5W5cDFXJ?=
 =?us-ascii?Q?uEK9Zsbzi6ae7Zdsu5EoLdrIE72hY7N1jbV4ZzUPZGAyMejQlObVl/sejZz5?=
 =?us-ascii?Q?CICeVf2d3z/mblqgyr04gDFwAkXGMh7Y2le8k1FLEFXuQQ/c124hLefreqRc?=
 =?us-ascii?Q?Pbz+q61VK4Lkp1t4t30hinrR/ldy+8gEZOqw/iDCCDPpp0JgLRc/CXf2pTRl?=
 =?us-ascii?Q?nu/clSdSh0NbMsSh6iyRK8+MlYnWNIfLF2EX4GydZNPffM7aTxWYOOnRWmR5?=
 =?us-ascii?Q?+bmcwSE+cTE/Gh2/k72NDmL65KdLvfrrCQZQoIQITU0uuBmBP99eZ7I7yBOi?=
 =?us-ascii?Q?r9HlR/vVoj6OFioes/saOXrn7vygGpAmSwNr2WrkUuzcUjxKpcgTisG7LUjW?=
 =?us-ascii?Q?HhNnbNKpvYQNS1ErXEotAfrEn5Mt6Xut4S9NVORISAWYklD+37NWpgaOcODw?=
 =?us-ascii?Q?Hxjmonw9RSvuz9L+CRqS/LPYH3htIsk2412BWD0YTfc9TCKOhyljZkxKdvg4?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I+P27AUUMlbJECAv/Agmvz4dpS2DVcGALc9HeqNzzofFrj7Jp01kpAJYdovnGCrYHDm+KpYfOPnhwpTtkpf0Awb04aUA3zOEr/re2X/ROJGqJ6gWWNfNmn8m4NatqNoc8G3lGQig0LI+6xtBWr7tSvZ7ffo+2ES5vqD2MFpnGRjTJCfJUoRTUvGMEBmTnw4vYgBSrUFOjfOi5bzl5GsD9fgrNkGItXb3V7a2Cxj35Fvdsv5jCOQIbOUxp1mYej1g5st12oNzls0nizB4bC4XgelV6EKoEMSk6zTUxafuIly3d1OP4GfiDUbucTqF1ZEj3dgkf+phujbqFJYoe+LrjGTMpPmU+y4woHrMnLElyreZHF0jjYKgfgLpxWeugEGF0FtAWS59vpF0nllubDtujT6+eIpp3llqlpwO+PvmRmlFCp2AGshu3Y2qiab2VUT69cFn2CmwHaz5RN+z9HUMUjBOdmPY92MIOGWcN9yATLGK7bf1fgTTZYTKgdNsCNMPjbjgXA76oa6SUIjkoT8HfMmT61Wo2Cx6skbE94fDJSdZWv3fesYR5sHgI+zg4v/Fm1K7K1zfn8G6ByrAQw0EY4SyqtDL8r75LPO+AxiXBV1g10l1pjJqK0EL4lqEAnWCgUOtK9lVLkTalwpUQXOe6Axfnc6FL+cavwqpAGmFO8znS6JMg2weLpz2JxnF7kU5VAPpZP4fhTr8Chxi8e6heG8rJufixqmzIxvcvMqES7KOr00And6j99O6IiWHdO7NDLB+iYn82gCpaEGxiDDq0w5b/1mK6SGGkgJ69eUWAoddxzBuX+N4yuAK6HuBP0wJb6fz96VGM95tA6Qqm5BiDXGQtOZnUzgCATMof2v9pRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156fc0e7-dd27-4c6d-bb7e-08db1031ee96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:44.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUNpPMAhqnRAGl04BUdR7ix2iP4wSP7/xN4xQwtxKMQ/ZMZxSz23EkZD7k3e/9q55ucUjJQg+1AFZEq+QvZBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160133
X-Proofpoint-GUID: YGVL61ocyZPmblJMYl8tchnKHfKnR8dF
X-Proofpoint-ORIG-GUID: YGVL61ocyZPmblJMYl8tchnKHfKnR8dF
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
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 1 -
 drivers/pci/endpoint/pci-epc-core.c | 1 -
 drivers/pci/endpoint/pci-epc-mem.c  | 1 -
 drivers/pci/endpoint/pci-epf-core.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d4850bdd837f..4b8ac0ac84d5 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -728,4 +728,3 @@ module_exit(pci_ep_cfs_exit);
 
 MODULE_DESCRIPTION("PCI EP CONFIGFS");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2542196e8c3d..dd750ad29485 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -861,4 +861,3 @@ module_exit(pci_epc_exit);
 
 MODULE_DESCRIPTION("PCI EPC Library");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a97b56a6d2db..7dcf6f480b82 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -260,4 +260,3 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
 MODULE_DESCRIPTION("PCI EPC Address Space Management");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..2036e38be093 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -568,4 +568,3 @@ module_exit(pci_epf_exit);
 
 MODULE_DESCRIPTION("PCI EPF Library");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

