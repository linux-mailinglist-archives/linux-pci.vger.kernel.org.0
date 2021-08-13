Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C33EB497
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbhHMLeq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 07:34:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5680 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238157AbhHMLeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 07:34:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DBVbQ7015352;
        Fri, 13 Aug 2021 11:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sJTDWx+xA2qNub2NudQZ+e+xDSGMnmFYCjt8d9XClIw=;
 b=y9ENvXJCjMGUU0RKQ00TOFX4SnV8n1EEeqEmdU7z2Cg2bFV+HpvMCEzC4809Kr5Q/wDk
 syfmiXmdZM3ABnrxbiV4M5LB381n822SeHnNRw2HFc8fW9EoP+uLfcMRHOxIgwanAI9T
 sUsDdLI38dumBRzA6BZ8iWRhuCYPSbtj2xqug7VvJdrHFX/XlHP0S2jaIAlV6lAvKp0k
 xA6u84/HGHMxXlVKQDcUrBcDS1I0VdHmFjtR0O7CLmbKekDDXAwWoP+D2mYfZ19IDEqY
 QOCU/YUqrwPe3e3y+Cxc1qgkNGvVwFPzmFlMb4qKMeogy3iYM+qReXwqXNr3YdJQJIkq 9Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=sJTDWx+xA2qNub2NudQZ+e+xDSGMnmFYCjt8d9XClIw=;
 b=uPLKc0xm7OAf9eAx/EKKuoeQUefD3CDhduejg9qGu6G3vLR+I+7+mG0uwtVHVnwlEFit
 hOQTqWYItQxwfDVOdr3Cy9PxmidqMt4AYo+8q3mD7Zh/bArdBUxIOG2/xVQDXvjLMK05
 27MZOAAJN/WUZTs8lpWYOuSxoGA4lDw1LO222bUIrbGeMCB51TxQ32fUK4/9nN1sFvTv
 PxAKNJGKOqZNba1ZJH06diUpqXTDvFBWVj05BacaCmIvbxal5dreoxeDwbt6fqYWSeF6
 qBEC53cXwPaLEUSili92Vqnd/HFyHhVss030M+e+4ljZ8Lbf5f7ogm6lhbvXwpdQsbw4 Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad13vaqrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 11:33:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DBUgAo148703;
        Fri, 13 Aug 2021 11:33:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3abx40jhrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 11:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCTSJUmFc/m0CXvIQS3+tM13tsmUuqHCZ/wxJBep8tXyEy8c06YaqXC0r+yx1ckBCzxW4kG4g00sgLWz9yb/ueImb+dHkWqnLFoBQUK7ikLWbuodsHG80+hiGSW1KgowjXzunEV7BHjdrsokHyqN0V5RJr91HKaLN/1S/qMEbPIkb7hg1ah1bO/q8+ZQ1Xn00kQt2nz7GrwODzxMnJSewWGS/aNwUcVtAfswEVVIQ1k70699XP4KiHYIwN+GsCpFMI4xITx45jxeT0vjzRGf/VnYyk7kmQh4Kai7hKN83uWTueWnyVL+nDiEoATVqqfsvt8WiP0vDq131nYkPd6BnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJTDWx+xA2qNub2NudQZ+e+xDSGMnmFYCjt8d9XClIw=;
 b=h2HB2kQafCbLcUyxnqHvxijOCTtgnjiPaghTx6kpYuE8cEecIFTlJhH2PWre3tdr9bZp2MzpdUcZlgzXjy9w/Z9/v7IOrTcdPvpHsZesHF0Yf1b+Wg02ZtLrAKIznh5zbQNV59dGLGJQt0r42He95Ay9MC95TsZBhnjg3AdFbA5O4wNwMTK2f6CWAvy3xAPWAyNwf4KwkBN65rukwuJly7Vh1/e7pdhxktF6/rZriVUigHNGNXO5Rv8UOLNEStNb7+EXPp1Xz709Mw4weG4d85j9IXW+sMMXe36fsyOpIsiIrLP1J4T36LGIu1UtBOu7Y8SZ/9noXyrfR1nCo8vB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJTDWx+xA2qNub2NudQZ+e+xDSGMnmFYCjt8d9XClIw=;
 b=dBm2EOiWSKqum3SVdDHScvnpwqsioBPbdyyUxJuKrVU6GqFrYiFs9/BjEcjgBHcglMvX3DEkarh4zL4UC9qGr3TnwveRygXMiGm6sL968/R3XhES/s5OsdVF5i7zPdGFPG5ZXdSVHLXybFWU7d0MWNv20yElAac1Gk/wISbpgls=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5569.namprd10.prod.outlook.com
 (2603:10b6:303:144::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 11:33:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 11:33:56 +0000
Date:   Fri, 13 Aug 2021 14:33:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in
 probe
Message-ID: <20210813113338.GA30697@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0124.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0124.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 11:33:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f86535-adb3-47c0-1331-08d95e4e3c43
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB55691F536FC7F31A9716BA788EFA9@CO6PR10MB5569.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TgI9tXdB7812nt8nzQK1bzWOorHa8gfdLfD0davSUmEqP1kONy8bSjLPwyAv9232fZCasK3r+zsv7ME7wvjQwd3BrYEsOmxK5xvy2KeIN+UUzjABYmODS5ZNzsOdJlmE3l5S9btAtpOSD7ywCoDRLJdXwUP6l1xfDFDX6m03znivf+wRbNt8QCiS15ym8EIa35lLiTW+/s5vugOXCn3eG2TOHpdsOyXtGcZKVlXvKVykurN9vMJVh/XXe8kWUL9GXFlOCNuZh9CdfFk1ZAMITFYwecTVjx4WCsUk89QPZaIfVaqWxXZdPRAnbm//LfgkBGyzRI1K0q/QCRuDPhCWGkjetOEOT4V9Lgo7Bu0a+9ugxgkza8dM92peUS7ZrmIh8lMMlEYjzLyPikthPNt+TRlX0DneGgU/3S+qtGb5Y4PQ7fayZfDbVxogzNmq6i1dj+uF5s+WpSjD6faEd6qKQOOh4emQmcyNwVizmnPV5xBnTXa60+oihZTiIBoemslW9aXdC8PH+ic5LnYkQXnEg4vuJAPslZ3qBmEhe2dEtklGUUb50iXdGm5D2AOqCU+WZjKVRhJTXR/n3wTDNHephQuQXJalSvpuuXLt/9ilFhEegtJ5xslFg7l7Qx/FtLvr5AT8QgAgiUQ7eyhRH9xUvnS5y5FCTV3a5qGjV070VdoAbyxyFq+sVAbzBYhurZT4vH1AXGudQJH/jSIXFzElA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(396003)(376002)(9576002)(55016002)(44832011)(86362001)(9686003)(5660300002)(316002)(4326008)(110136005)(2906002)(33656002)(6496006)(52116002)(54906003)(38100700002)(38350700002)(7416002)(6666004)(186003)(83380400001)(8676002)(33716001)(66946007)(66476007)(66556008)(956004)(26005)(8936002)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NrAswdHuvEQfo+zCO0XB2my7PfGh3qvf1GtnbiRo+cF1osVn2IElNAYZN1w?=
 =?us-ascii?Q?lkGC8PZ2q+HPBaKOUVPUmlDWdpzmw9u3wx+jy8f1zHapTdJsAmCSoj/j/dQI?=
 =?us-ascii?Q?xtRKa5yNpv9nBT/YnZGWWB0+30ovar+BJ2hOKk0qA1LNgsiFgT8Ax5H64EcD?=
 =?us-ascii?Q?gXCctKvO0uEnWAft1P0bdRQ1VoLSDf2+N+yjy4BGvekUp83FUzYAGMw0D58p?=
 =?us-ascii?Q?JNiZ9RsWfYRtpbRYKWjPoERT4R7PhY+WAxY/RAWGMtnav/gTj5+G0HKC6wF2?=
 =?us-ascii?Q?4zghMUGmO7SNlgNayx/Ay4QeNPeIYwllaXng2nW9OSpILKDyDaGAzS/qdEoo?=
 =?us-ascii?Q?4MJMJE4HbvsXt49Vl26c58v016PgAdqOp3TuevJybpAdppLdW68nmjQG2wMu?=
 =?us-ascii?Q?ON0EKpDKN5Lt/GxbFtnQ2Ke52WtexLkQhwXhXchUtuhPcaJzj9oGN/RiMs9M?=
 =?us-ascii?Q?TipJLrk2RpXG0JEcLI3E/zW75poVYI8Kix1aJwQE1siYX99LCZW1dOVN+DXY?=
 =?us-ascii?Q?8+RN/dSsgvjwd4bW5u8AQ/Ry4Met766u6gMJuO0Jm6Y8a/Oh5zk72ZGq82AY?=
 =?us-ascii?Q?nPv0RgtKe9mRCRaHQXORREkgn7JFDOaQ1kM2PkBVpgTxfQXF7usemxuw8xxi?=
 =?us-ascii?Q?Kz8liuRK1dBb7gEIGSI1IxKT2m3TLtU04GoE1asq6RMbz/liHnsh8o3i/5Om?=
 =?us-ascii?Q?ekNyqULFQZ8tRZgfsqUUQVuTXFha+/ujuK8hAOIPTY52iiH+F4d4YonZc/b1?=
 =?us-ascii?Q?ucsv69ruC7fNR1+fYXpUWiqLTZQ8g3SSg0WdflMhi/4PhD+y89nzaiV6tlTk?=
 =?us-ascii?Q?fB89e4u9mpGVu1ge3FBrpXYLazJCxGQtkxs4sWAlR35ZmbXdhLy1tee2ZNNr?=
 =?us-ascii?Q?pn8uhAZcv/F+op1zV3X0FAnIUXHHMhGLTjgQxOMr02lEOkAvsAnrfyE/L6uE?=
 =?us-ascii?Q?k/iJBVmlkLPfXg6/+inFnX1etrdUadcO2F9Qtv7S/Drf2ns2CzydhMcvXiuR?=
 =?us-ascii?Q?2zYe8jdwhNpYw3nQERobSaCFrGwiVqGu8yND152byq259IRDcagv7VVUqPx0?=
 =?us-ascii?Q?YUQeHZfSs/TVZBg6Fcw8+zF5LPb3E25x5Umie2m4JuJowrOAMQ55wgWfpEg8?=
 =?us-ascii?Q?qLZdRKjmP5NItfKaLXXFFPjrLtrRZA7D+vmqwQbIgnr9LPylrsNtDRWgA80c?=
 =?us-ascii?Q?vQ+N9b9zmdba9w7uWpL3OUb8IM+MMc5Ti9WKVH4ZBzNAxnEZ52GWQ2P5xV8Q?=
 =?us-ascii?Q?Cm3cHO9xGz5NO1BQ9fEBcTEaDzCtaB8CDISVn+ZmuHaKUsSSLgwUKIu0CMWy?=
 =?us-ascii?Q?/nTyIsT/sSDPsZIzXsIPStcj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f86535-adb3-47c0-1331-08d95e4e3c43
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 11:33:56.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuBa7BQIG3XADTPxut4g2axYbQyiZMQ6FV1TR6CRfyA3dCmWeykGMZLuN8OVHQfym16uymaJexpdHFRsfAEBK0erzHrYGjiPw8xftSik23o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130069
X-Proofpoint-ORIG-GUID: f-Y_XSSciaU7WKLhTKjobwnU8n5Mk_hr
X-Proofpoint-GUID: f-Y_XSSciaU7WKLhTKjobwnU8n5Mk_hr
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If devm_regulator_get_optional() returns an error pointer, then we
should return it to the user.  The current code makes an exception
for -ENODEV that will result in an error pointer dereference on the
next line when it calls regulator_enable().  Remove the exception.

Fixes: e1229e884e19 ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 20cef2e06f66..2d0ffd3c4e16 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -225,9 +225,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	/* DON'T MOVE ME: must be enable before PHY init */
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3))
-		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
-					"failed to get vpcie3v3 regulator\n");
+		return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
+				     "failed to get vpcie3v3 regulator\n");
 
 	ret = regulator_enable(rockchip->vpcie3v3);
 	if (ret) {
-- 
2.20.1

