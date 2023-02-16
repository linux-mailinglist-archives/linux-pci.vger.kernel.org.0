Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585086998CE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBPPZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 10:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjBPPZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 10:25:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E9C4AFDE;
        Thu, 16 Feb 2023 07:24:58 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFO0j7018274;
        Thu, 16 Feb 2023 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=VCokH3ILxMnn9U+3KjTNrnTkSZP6pRo8VfzRg5PYFn4=;
 b=O8FYM/N4b+0LS+pbDR9LkjUxpiYUsMlAGWuki16n2+RWLAambxLqwri31xKt3l4q1FP7
 E3hg4j4jaCU0BKkFQLguvmk1ZVXvJSFRu5TT/7/LDtVbnnaOUw6Igiu9w3OqUxvJk1ew
 K5QcY7gO5hkfpV/6mK7reNYBlbLBjmYZcpr4954yCDWe9pAoEE3h6HFad/LWB0yKfxjh
 2CbgRrlrf9DRRyCFHDItiJZM+etpkVaAxFP3QjUz5xoKVUrVde1cUJeCnWQM0AN7ORuw
 /OI0AID9Av+dQuNlCAY7fYVa9GUfgkLgMmRakfCZA/f84oLlJ964PSqU1f4KyQYLmftx ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32ckeyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GEZsid015132;
        Thu, 16 Feb 2023 15:24:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8rs5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3sUGmfVBexcn/DoGrVJqxPn1B3Q/JRFHZCAtm4PJOBoEoIW8hiiD8H2ncuTQP2BU9wF71XHJlxZX++pacNP9qd2059OHl2nHotNAKd/MNlXlE8fjgO2bac8jSKftQ38/e/Pnw0rUmU7tZJe0+N+9emkmcFlqQNx//FR2Guc9HiCv3QRurVkop5MXgxEajLhm979vk85/jcK08KlLpmmgvtZnyR56G7sBMTaSDSXZIqlYBH4lZHDhUSfmu4mpDKl9VWpu2554oCUw0QCaFqqEVHcgh3NXY47Y9HvFCbsuS9M+8P6171/gq9HYTxdvWXkPDEdB0mRorzj/DFmEejUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCokH3ILxMnn9U+3KjTNrnTkSZP6pRo8VfzRg5PYFn4=;
 b=BLu+GAJA+v1QywmnT10XaZu03mhfKfrjE0if60UVWX2+J5/+uzt9IlKrWByPUvQoJFJFmRxvMKoCi5tYzRenNEMbBVznY8ushGAoQQMbbV21cQqssFalGSj97qi/ZC70Ls/VA+paCvjwDbbCs2WJwOn8p5dVhdsRsEDa4lvHFrpfgROjtf/Y9TEpS1miqKa41cv3WcmZ1HI8Fkl0uEiIubaVyUCa3WuddHhSOq9fqG/rUPNdveyp20XJ5+3I7maeTPyYuFqBIby0sojiHi5vJE55OcgQ5H1O9HaTNXQJ6R37IxjXDL8bZemnSWqrc0w9G0CVRZ4Gp5e8KZw1OY8vHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCokH3ILxMnn9U+3KjTNrnTkSZP6pRo8VfzRg5PYFn4=;
 b=CVlF4iQAB0wbm8uGsfIDnI31dqm+40bnZEXhN6/lPnKp4Rpieg0ciCI5wEdhxeBCwUNl9OhSKCz/6yomLHAjnPkPkvfepL9HcQ/OrlKH11aH5o/xOJIAk6VE4HoCRmJf5+iY8KgoMz8LD9hzzKmAG2Cxe6Q2hkmW6WnkY7vvkBw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:49 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:49 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 5/7] kbuild, PCI: hip: remove MODULE_LICENSE in non-modules
Date:   Thu, 16 Feb 2023 15:24:08 +0000
Message-Id: <20230216152410.4312-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0302.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c73fdff-d717-4c1a-3ce5-08db1031f181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pq9dgKUN/6SM0I174whNqeZBt17QPsjh8lbGT/bN586bC8UYcdbpozG3yJgPIxsf+7kHnRjMtzxinqtRPcHefkBf5Ud0byF0Za+3duqEBHjpS0VLVH2xiJI7INfEkiadoUF3NiuG6G3TTK/isTu2CXLxWn64Q2n6JSYEEiOpqdE1XEmAMS2wVkU20EaCm/Z3nhhxmlCGzlktxzCx1tc0iWtBRmNBO7JD+ENGKJ92YqKB2FuhnCOsqIIOLoEH9nCXqf8BkaNGvbn/5G4d5LzQil8FkoRzUt7AbCWXWhaWlHX0W5B4SY2zv91xMvShpvEx/JbYWqGepPnMX48Dzgh14GBAAxp/Y1x+pF9Q2Tb8ByeXUfxtc9duhQ+eVGIofWvi1WVXmWxK1b4Hm/pymh19LclSqgCy+RGA8Oupoxui0RHGI85nioyd7w71Oc8AkkAVjZBw+4QjYFtXASD5SxsLvVg/1Ahwt/zwU9jRxU3Nio8iWgw7K1HhCUzbFwosxJEf2LWNZ4ZFNFAZUaetDTKrT1ZUNZYjviRYTmWIAQiu8SEaNxrVu8GtpK9tIYGj60XKc6+A26nxhGXEUeJWDqrX8pKSHiHr59V0E0isd6p7yDAFOEbUziihQnu2Kt4Yjc2DU9AFoBewmTjUQJqDdhJiGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5Z7CYzlD/FAD0mbIYynB1LrF2CRljQetcZL8aRtfWJ0Aep69T0VsrtGNa+0?=
 =?us-ascii?Q?tLYFG92dQZOg76dJ6Wwl+X1l3C4vdeozZenWL/stWlxLV5vrYX/SWM/2b/UT?=
 =?us-ascii?Q?X7vxC3BM+8njD8kNTfhAkT2+x9g7Bjm/NFs8lfjVVkWHlbDIn5cuyNsifiOR?=
 =?us-ascii?Q?/xXXikPX74CJ/bzmFn9g8rahDtr1EbUUU9Q18r9I4j2cEazJx7A+U7ZVhsjN?=
 =?us-ascii?Q?GT6GsYseyHsWIaHgcuLmXVtRInzySAQPnyWbGh22kPj5wsArPcFiIO+Uvrsx?=
 =?us-ascii?Q?EsTJlNtDwnVL+wJQsw0WtC8U2lJuJaNn095zKZ5j/dia0dYfeaBqio5ehQUm?=
 =?us-ascii?Q?ZyHhUBW/cqC0YiJHBWcu7Dp3zlX7Ik8oFORVLiaKnHdV7JMal9otSKYdLtef?=
 =?us-ascii?Q?cJDOMmqTqlTdwAuHGOTvpUcr31+TgWNCzG+H4Y0AdPBrEa+Ddv79u9IwPdbP?=
 =?us-ascii?Q?8+K8iH6VHpg4nlbmfTjaQP3bph9aE1XQtI6tq7dyyK46ABRkqtmF1rGnN+J4?=
 =?us-ascii?Q?7mZBZudF7DB8Pmun7dtNDE4D9M+TBGFgIVrtrNWw+B1759Bdyv9qt/KXkpjy?=
 =?us-ascii?Q?jL2GwZWYyOXbFnZnhq2BagNKI8AIugupm4qgaPCiDdf3ndeVeSsa5WHVxTCf?=
 =?us-ascii?Q?teUSvOudfaFFkaRe+K0wuAjr3V27RAAV3NDw5gha/OCAatJpL0CcPBlVc40F?=
 =?us-ascii?Q?NSOkVL3Fa0uo0SFJIguBbdYtmJ0Mjb9fZHDsLQlHwX+W15xfHL0/z7cpeEPy?=
 =?us-ascii?Q?G4Wj2OjOMTLOQiRFwRsxzY+5AlfxAECVz13BnyBiBVtr52CyRnEtXY7hVTcL?=
 =?us-ascii?Q?ZKkLuMIMggTcYR7vIrxqGfFCzXFkECMPoTerSPd56z+07rkZBa6we1J1NX5h?=
 =?us-ascii?Q?7w9VuaInS8swyk3R8MTCyQw9ly4pi6vg3AUqEv5ge78rT4bGbEIQzj1NyAAU?=
 =?us-ascii?Q?RGQ7/3o89lC4MGOjL3GO9NYe3qL3DW1S3vpCuEBYdb3bEX5nrvc5VvaoI+5b?=
 =?us-ascii?Q?PHk/PZJcK7L+mXUwGu1a1scAC6xVrVvcgc8YbZiRfwROkc5FhHK+6ENRgnaR?=
 =?us-ascii?Q?5aSdBzBtv4XqQlTT9znVDqSEw66o80WGB3vE3MDMhmjax2X1CmG685LUh8Ys?=
 =?us-ascii?Q?rk7vB06/U5X1JDnb6FzW6U39HLrtuqQmg1T2s8WMiMCQn8gHx1CkdzYtR8yV?=
 =?us-ascii?Q?owTs16Fm99mQ48XCwHnyE8FE/qqg5BH2md0hMW1vnSGFxcQ7SS8zWxeQsGVC?=
 =?us-ascii?Q?opi06IovfL69YGf6ZDvaaC4gMMhhMJB2IZO1O6Y2/DlwQXIRvgz1JlTKrgPy?=
 =?us-ascii?Q?o2OKFMngo69bTjf4aDfOH4Ub4Q7ouPOVRZHlB5OD8F4DTFdEdUZ+LUfRyBl6?=
 =?us-ascii?Q?0ur+Fl6Ve0ZDErzSyjxfIK+fTc5kHRTcU0/pW1PfZfnNKxCo/XZ7Ea3HNnml?=
 =?us-ascii?Q?pFpIweymUw5N2DYigK0QN6XjQefyqquBAFRH5CZoXhF+aNYhhOMh4NNHO1bh?=
 =?us-ascii?Q?482GPmKqzmsfXHLROiR/R+RwcpmkIdA1a9ZlxFLLkFMWTkPWzjip1fUHSZXK?=
 =?us-ascii?Q?GYovndz4jYar1w3Qdvm+IJ+DIRLY2hBla2XmnFVFssJqBnlVRJUiRt2Ed2qv?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B1BU9s+XNCKUhnO7nAg3vJJbs4syiLS+/yRi7T5Lmyd7MQLxZJ4+hbbh37Xo9YLxWMg/e7F1rOYZXsrcxWkhyoAOxuR9FB1ev9AkRh83eOrIw0kW/8u7Khgf4rS7G2e7Wd5v0+SfmNA9UmaDyX3MsQi++O8ETCCbYQRHdsbF4j0ff9wczZuThQGt5XWghjIwgZ6lMxj2FDGXu/1Oz/rmeLyfmCMr2k9yF9oIDfEhij+SpwLHhIyfffHq4MlaDO+9N6/YpRyvOcz0aeqcnhElJjB/2ipnJhLTrgUoaEpFLNXopBYi3vTlghAHM9ACU4c+Pjl84Gj30sFrzqQwPoKkKP41OJwXq9IAagVKpN/29dpf4G5zs3B+Re75e1vxjF/NuHeNY5ewtL5n0wdFBioz11mAnDebhYoeyu82rj4fRRHucoSAvltFhUBjbGOpKgvv/eAx1LBBkGsD/PfSHgkJT+fvgfR0LQZiwXfkuXGlRSooBZhMCFdIpgqyj/nkxq/ySpAkXdxcfdYSuVjUffOE9mozcRIRUgDuak7gczkNnfYoWIksQILpfzA6btNopOI1OnZ7FRP/jn33+dyMU61kL458XaLaNCF0W15kcX+c7JDt4qJIOJr0kOX9oj/cGz9oNL2RZQATbiSyPpgnrLItIl2lvapNGOBDOlKw3wACrLruvCEYDixvdbQzj0f0N1htgQcMNcxhOG9VcHZAIxASEt0igd37rbLzZUzWBd8DQpTBTdBiq6LGklNWPUmZIhOLRtvnEEMSgTmL00sK3OB9wPBg4fupSEmTuhaNOvGmQoh3up6wjFeimypKhXskviXY0BQGvUl9FqS6sCRu9K11cOsEnHNQNnTIgQoWMkp1uGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c73fdff-d717-4c1a-3ce5-08db1031f181
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:49.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyo1mA3/nVDWMWWUSZEZ+QIFH+LG6uHatyOJ1K+wuZPJWAm3L1LQX/HfiVzhZ0RONsrDprLbnEDktr2tve/Low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160133
X-Proofpoint-GUID: M18TT2eNpt8BSahqJ3rxwruMxZI4zfIY
X-Proofpoint-ORIG-GUID: M18TT2eNpt8BSahqJ3rxwruMxZI4zfIY
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
 drivers/pci/controller/pcie-hisi-error.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index 7959c9c8d2bc..7d88eb696b06 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -324,4 +324,3 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
 module_platform_driver(hisi_pcie_error_handler_driver);
 
 MODULE_DESCRIPTION("HiSilicon HIP PCIe controller error handling driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

