Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D591692507
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjBJSIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 13:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBJSIk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 13:08:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27F5EA37;
        Fri, 10 Feb 2023 10:08:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AI0BuJ022802;
        Fri, 10 Feb 2023 18:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=aTq8qAxwo+vyrgT3BEPdy4OT85Y4c0ZSnWaBs/R1fWk=;
 b=izaBuQ/OAxlybdXSXXPF14YtVDeZRQxPoH2YtyvxBevDW2Cw2qY99yIQlI23j2EuMMDF
 UkGhgKlzV8Qm5/pX/qH7LYDdPw9iv9vAEjk5WuES4Xi1jFW0j+nVMswSByDsVvO0odMg
 NMTohfe8hiEw4lNrkr/2Bi/glHk79Jbi+GFicX+7c9X158HaSbzQYuPJQJh/wX0SgVkR
 2uvNIy4vf0/sFKA8iUr3GUHeSzPMWAWBR/e8E5Nn+ZJRo84uyx1fXW8xuu25Hl5h3Eu7
 aWJKuehA4RKRzttVjpv2StwCtvUkh2PQumurxx3mKgYU6l3VMA9gqOSpkXfD+b2lpJoR +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8adw5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 18:08:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AHfI01013703;
        Fri, 10 Feb 2023 18:08:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtajxns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 18:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUD3FrQG6GTbO78fPbWsGAOrUCIIdVMz8HD8WrBdCsWC04771lAhK3XAU9akkdV2k19wuaraP+tiNKmtnxb8cWtb/u3+0uKMjpdA3yiLlgkWrS22xrwQOzgjpio+tz2zUu/R19K0Mg7Q4bmoCWC6U7CcDOWli2nOQuHYObPnjP8WRCRKi9wuWAPiu93ZFv7W6dHB+S+hrrx1TpqK/kmPeE23dG/w9mE2OT/a0VlXW39Mo++Z6JeS4sbjA7rkPfj+igjmirbEmwgKqgsEmwoy1kCc+ndQts/BPlWhS5Kf4oCEXoAS/r3nWkXCwekMoEwijbTCTTqp9eUJ97M2uOtEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTq8qAxwo+vyrgT3BEPdy4OT85Y4c0ZSnWaBs/R1fWk=;
 b=C0lrre2m782YJ6zNeu9DNhK6y0HYSi23zzKF0mPo4TtLQxWzbB3qy3lKYSfrZHzy4GtQlRo12x1Akvb1YCBxiOGe9oy51C7PMyXosF6ZHBgKjygBHsVOYSAEfz9By5mEHazBdkDkY357TQktPFD2Pl6UfcbgLa0dpUAC0fRRsQLqx89Zk7THhXLar265wIAnxRouGkbV02ARhvBrMsrOMW4Z8ZeZ8nIw66FlQDYnuD8RaojZY33GeRh9oEZSyceoGZjYV+PpL7yqFvTRk2ovVTkihnOvYadrF5gBLZmi69J1SCI9FCLa6tL5/4WTKUupVlw+/6q2JsOhv6ebpuHkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTq8qAxwo+vyrgT3BEPdy4OT85Y4c0ZSnWaBs/R1fWk=;
 b=T6qRc+mPG/tV7fKarymfHZh7ZIppM/7nUcnOOqTgRmdIc9EnKNTaDFkECLRakAO4cqffmhZuLfSceGbiTFcQU4ogYVS0/CfMMnsyUEQy1gL4iE8cDjKjgTrYrNka4Rmviyb1Ggoz9VkGa776nhM/nghpE3zDP++USa//Xx89fds=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.11; Fri, 10 Feb
 2023 18:08:25 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 18:08:25 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci@vger.kernel.org
Subject: [PATCH 7/8] kbuild, PCI: dwc: histb: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:48 +0000
Message-Id: <20230210164749.368998-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0691.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a69e9d-6f53-4133-e517-08db0b91cdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpAEFG+u5NoOJe4eEoXiG4GbAuDAefY2BpoUTU5CsASX6ZZ0/6Puljx1qb1eQAn0dVJ71AimGx9tudNulzhEGY6qINi3cVJ0FTyR36bKYTP/ZdN4Ni6MX1sMsFkkFlWBRVRlRhsSyg3Jtjr5rBgwARLpsNJnA2NJns0F/o2jl397GYr2zMuzS9oZORZSJ1CWgUK8+SeGadvrreQGUHRtKx7EDoO+b02Fjk3739ers2x84kkFQllQW8akPV7vskvMRS8QNNKT3I9jPNVKIDj4pbwI1R7KggUmBkhg+f/PL1YsZ9TnWpVabLqdk5V3FMJfyQhNc5ZAl+eoRhGWqxjnwHTSrEOvGl8LDWNWcVPOl6+/teOLrZ9JV+v5CoQa5UpeQqaX+Eda3PgXbFs3nD5Ol08+rCjMiPAiHOkP5blTLEsKD59nBEl1ovCTfYkG/DPUlj2ehhYQz9OTa4V6GsWDCAkUn/f80PazOf0Casuqz7UvfMcI7C+yL9+x4Ac+mbRx5Z3KGFx6SGFNl60pZKL1GDYzv6N0FNauzAYy/iYvPVJOiluQghBhmYMfLC2U2F3oniKlWfGNB9RkwNxnblL0CJS+2Wb1/JKGFsRuaI/CiJzBoNW//Zkuqz92oADVzDSnJidUe5ZwQBF+FsuApY+FOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199018)(38100700002)(26005)(41300700001)(6666004)(186003)(6512007)(2906002)(83380400001)(8936002)(6486002)(44832011)(2616005)(316002)(478600001)(4326008)(66946007)(6916009)(8676002)(66556008)(86362001)(66476007)(36756003)(6506007)(1076003)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yhETCZCSTdILZXsywPy7+3jBYiX2DWe8o4n/15i3Q9ubpaJOhkZ2yiJjIOL3?=
 =?us-ascii?Q?/W861T/lo9IeLzyiCkLhdZLaDcivKNirL53y5C0nTTQw5hzaga5+M7yd++ym?=
 =?us-ascii?Q?f7005hYopO25iOqgvn2zeGiMuRyuPjnkAn4UISMzDUy/7vm99/tkjfTlRoU+?=
 =?us-ascii?Q?0ltQKjG+lzseP7LLFtFG1r/m7KGUlTM8gSVCZdBrvlHgCGdliSiNwz8pRzYs?=
 =?us-ascii?Q?kSuiuqPWpMpOSA6gpunWg/RJ3fI81Wxk7jAwn7DZ5CYAxuKQh4ycEc53d2oA?=
 =?us-ascii?Q?47PhpE6ygLgcgne/9e3PxKPq7BERDcnyD4u0UPOqStVndFmIGlHriGqYYNt6?=
 =?us-ascii?Q?qjfk9+KbsAQBE2d1/8KPSKY1pbWwhNoqID7lUmzXw4vLFxg4GWKw4zeuTGia?=
 =?us-ascii?Q?T/1fk4i5pFRANNf9KMpvqB29jU2VSG+NDh0RbCO5JpF0gLPPmDDdIsq1Cef9?=
 =?us-ascii?Q?XCknnwicxyl8DmaCLftsZHL6v9cncyO5UTmdaEdETv7ElllvJbtTWwe1pR34?=
 =?us-ascii?Q?8voCYKc5lTB6tfstFfkV3kMuWXuj5gh6Y3Hh/UiY9UrOWmFUeQHfEPYL1CvV?=
 =?us-ascii?Q?T5OI3heq/7G37PQYBGoDKJTU+KZaeizFr9b3dH6sjonlziV4mpu1hRA4Y0aT?=
 =?us-ascii?Q?ohgsH//KFJXJlJhDj+MwgD5LvMoKfGdm6qw/gTluygUaink8FoHqAcVh9E6X?=
 =?us-ascii?Q?xhcstOlmpfg/AoHA+GV9NCbMPB9UT3tnNZV8bxyJE+7XdJ+kM6OPgFL2GZt4?=
 =?us-ascii?Q?C5lf8oc/WLAy7zYXVNsR2JWvGbAoKywEQuXnifepo1oX5I+uRwum0xFFoBrh?=
 =?us-ascii?Q?qKVd8Yrek70rNb7/RrQKyG64iVv2jqN/KTARbynQ4/uFcxqehhSjDpGjhAIS?=
 =?us-ascii?Q?MBbtaPZZJTIF0NzDzw9exhRU7N4TbpiV2laNi2rixHF18IkAsekGEo6bmTnB?=
 =?us-ascii?Q?eiNpG32bRLmn7bBmzULwWrP+rHwH6qzoibCl959A3ZCLEMiJfQFaqKKEBRLC?=
 =?us-ascii?Q?dPQ/ocWTOvxXCSOR91KtsqbbXIr9MUhKlCtx8gwqdtthZ+YTpf1xGCEM9INy?=
 =?us-ascii?Q?H4XWHdUM+r/bu7Crd1kBuOcCgEMcZP0skhFtgk6KUqrqrJESCBqwOoFzhwK5?=
 =?us-ascii?Q?c4qpNkUXAjTDAFjN7BloVU4ArWl8x/Hz2vvk/CAY0AJkmnIW1TpT9M6vbriW?=
 =?us-ascii?Q?tFbznNoupfozjqV8VyUF9RV1YA6FbzmSRjfJ1CmFd/wOAeW2T/vwZC6K5OVQ?=
 =?us-ascii?Q?Z2SmoYi5XiawFWxRXARdOikAerDcyGtyHC8KVw/wO8sCJ7quPGqcGnFD/9Lt?=
 =?us-ascii?Q?pZTSXoIZeq6RZxrNeaBqGgr6tg4Z1u1sExGvo3NgF6pDqg3iatdwcVIFnFG4?=
 =?us-ascii?Q?EjP6GfEt2WscXfT/UglTqTp56BlIRwTSKktOwXDAun5mGuJTCR0YZ0xL58Dp?=
 =?us-ascii?Q?w0Ai+nTh4CrALQ7NTc/7Giodz/fOFDc9Y4GKpE6Dat7xpdsDUqQfLgDoSa5j?=
 =?us-ascii?Q?qMakaFRAXLWVVaVrt2ecofKCriBOm/M2qTn7sgJCTrBZAj8y4dXxu7zOv/0c?=
 =?us-ascii?Q?I/+/0shl+K4ptnj7/HRHbaP8FqnRgIYYRQUSStFYqt52oQSLEO9Th0VVI04K?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q/HdhAZ28TdKO5qCs+mSQ6T2oZIqZ/MYehjZUCggPgeAZwZtPXXj24q3dtogAMjsV2gMGaenweuLg1GLobeWhnrUjLsz1zHhJs4u1vuwCWLPNgkhn9X/cdkgbWv/3VpAyZj4WbaziGtGW+86IQo/Rr2epIqEjZAN5E3xZ6yV8e/9sJv7jINa/UD3V6QQ1+vKYNstJTMRWvFLc9L+PGAAINUwNXISnbyI1lQsR0JKM756g4WaR0P7MOa1CsA7Q8jlsRBakOPW8qlQWdnrISsIaf8jeRabybldWiRE7RbXpsC+EDkMdYu351MqPJeekNbqANRjAMXPMdCKJy1vQDN1UwJbMmDise9Zvhg5QN6Vo+rDVOKOWIX446RKmjR8Xn9Zi/wacvJbt6fmcpibd9lBtvmoOSjQbhMCpZcLmve0b+211TTWE2HwlfUR5edIKXO7iH6302jVcScSEU3JO2v4QG+iEkNkdo1wpPkn5FOuKVflDPd8wJ8brNDT7b3P0P59eAUwDkoGoS5uEcJopKgUl3UjSEuPMNkyoPUlRxSliKjx/8Y2Vsgo1zjqR70RS6WaHlDqAfAYDc8NF9lcgrRSVwZmJXbANDj2/lsVigMtu63FcBo6I7334VbqZqe2jNprN+dcTxmKJk5+/EU20h4THFApKitYbJNBMiU4vRXR9VOboav6EhP2dHGrWlRH2SsHshXvl/SV6QmHEoI6BMbYmLcOzr6YR8r3MEkw3wURxARKr6C/2RyXDMo1q8SW8xx2Gib0ITrW4G0br4E2cRfJR037fEnCLzhjq1DOglpJv1oqv6GolPuLuQWAl0NRVhwtClTPxDG5P5HKDMClkGwZLHjgddheaB+gszoTHVMYcdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a69e9d-6f53-4133-e517-08db0b91cdbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 18:08:25.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6CqtSYeKlxGPJIkcp2hOQHpCXi20rPiBmuWJsyHEG7bmd4jb7GkbLFtb4s/kfI7d1zgL/uS5HjqENdgkLZTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100152
X-Proofpoint-ORIG-GUID: nKDQ2Od64x_PukIP_lCYESZjI0hclh2Q
X-Proofpoint-GUID: nKDQ2Od64x_PukIP_lCYESZjI0hclh2Q
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
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-histb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 43c27812dd6d..11be36852033 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -450,4 +450,4 @@ static struct platform_driver histb_pcie_platform_driver = {
 module_platform_driver(histb_pcie_platform_driver);
 
 MODULE_DESCRIPTION("HiSilicon STB PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
-- 
2.39.1.268.g9de2f9a303

