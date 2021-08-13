Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A243EB6AE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhHMO1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:27:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60768 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231683AbhHMO1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 10:27:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DEMDU6019023;
        Fri, 13 Aug 2021 14:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=m9s5q88esDwuJj+NskZRdkh1Pz0NRd5D5mYFQ56kGDI=;
 b=eBwKv9U2tDZDxjmtk7ykX4C1dceYbJ7NQqx5YY6pLzyOy+9XZc2Ow8BUyyREcORawGVu
 t9KtpAvoNe7BLbqZFdD94+P/JWHPaI8fKHGslZRanFei01DJHUSCG04DBpxil1D1dW5y
 rN22m8mEuXs3UhWWl8ukpxcgXduw0vVAKYBNvXp/Yatsu5GEbCMy8Ru9PxGK5m7lOm82
 uEaA4R7Mo+GTJWEJz/kL95tP7twHx8rN2JaFcL+5Fu6Z1C5jrOE0/aRxyFuSVPd3jU8M
 0c9Q8W62fIO189VMdsHVomYHpbJMvNE+aLnITZ2Va30bKTWKyTdBQLtRlYWGZ+LsPQBD Sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=m9s5q88esDwuJj+NskZRdkh1Pz0NRd5D5mYFQ56kGDI=;
 b=xsTCSQ1EqCkyV9X3kygkbAW0v9x9mhOhau4qSRF7BMzRYgCLGJfv0seVoFfoGQoMAlZb
 z9OpLv/NS7f1dVlkFPEHjM6TZcMBllL5YFBHoz73ac3opIY1X/O/4NI6JWf6ZV+TeRIk
 sKr4USkI7Ry1JJ6cayOImyTmhNyWA2rAkIOjayrdKmwcdJchzMfHerBmj67r6R1i2ikK
 eyZie1bS20hQJhhPO+ZeMfwfcvaisOu8Vpx15z+DCiHRQsQVLuH6E4Duu42CFjUl46WB
 sPiS2GvFyNqYu+/c1oddqV2lfQU6PjQXwGWMpViwCPXByVxVMW1z18IwFPnzdBBAsyEw EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad2ajk0tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 14:27:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DEKZaD064138;
        Fri, 13 Aug 2021 14:27:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3accre4ks1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 14:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuZjg+EuLwjTyIg9XgOXrF7LY8EpMrq4pwtDQ86oPzK5eRTvGmEtJ13cVltf+dUwGTaVjctlf+o3iDGsXZkRnUnYxMlT65vjlRo7ArhGJOflhIJpDrLKC8E0s+iisTc4lRf15yDA9s/caRliNvmTZGjpjbnnt2CxyQyZr4+GIfJmTXwi2TqrIT8Idf2KKpr7A7VVOm+UvTXZmwFAJuyvUhD4cG5akDEY0JVhMAjui0Lw/DajZOihB+MuXQ7CuH1lHior/jkz2E9+2H1pyPhvtAlAuGtKntfgUUXAFqUOfSjkssq52V20HWRKGur35QWLlwQ2x+J743cLjrThvUDsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9s5q88esDwuJj+NskZRdkh1Pz0NRd5D5mYFQ56kGDI=;
 b=AX4c6s7loIGKk3jDbGFLsmr4q8EUs4G9xgeU5uaTP8qQYe6/PPw+HzdYJYejG0aM57iqgU4kmxM8dUB5Klp+Dpe1RSandx/Z/vg0f/LT5Eyms07ODPuS1fn9SUVLRgeuMaQZmEhwvYBvUi+qUsiUbcMABEKHQ7A+L1jJ5Wefc4ttV+4PjhPzBjcNW5XNdmkfAXEBkrzMIIdvlhq5Ch7YGndo+eXlcpYZW3X2845Uhggfv5lV6nYDuIQqZ3AxSuToZROpz1fupVLSwgj5dHnijCHBN84t13xdXwyxhtpWAAWFuGW3Xe7qu3JlWjaL0bwvz7zpgg7Ksy19jcsPSpBliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9s5q88esDwuJj+NskZRdkh1Pz0NRd5D5mYFQ56kGDI=;
 b=eG+/qdifAElR5lvSeinKSg8o6z6Txd5ftSJjANYg5E38QEIKn+mFFx41IMwKucw0uDaJMPtrDTBrxSdSX4rdGRbqU7PE7ZbPIZqGAtP2mt6PlpXR6dlTaMJCJzVQ+nwRpONrK3bYgXFpA8KnUAqbzoLS92x0rxprxjktur7XDFk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2368.namprd10.prod.outlook.com
 (2603:10b6:301:2f::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 14:27:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 14:27:03 +0000
Date:   Fri, 13 Aug 2021 17:26:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] PCI: rockchip-dwc: Potential error pointer dereference in
 probe
Message-ID: <20210813142648.GA12057@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813141257.GB7722@kadam>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 14:26:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd22a34-6e2a-4446-9e5c-08d95e666b74
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23688060C294F32DA993F0F38EFA9@MWHPR1001MB2368.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuKwG+bs87zIjpxom+V9CLnSJjIl0xHawFY1L7EWJjBpQukYYKQs8/MOnE8w+zrWPZ/t7TxwEGRTEaoi8m+JFcACbirlmVelZR986VSEqvtN0SfKBWz9MILv9D9EKsMdfyh4OBquGGCwoqdhBK++rYvCzjgg40N1v+1qHUljdLWqAl0HbgOhkKNcICWOeIEdNgW1QFL7bkIJ9n+7RxQ7p82VsPMPdZxrsx2hzdnIDzDwMUivk2+hfLI2TXXe2oQI6gQjRpT4i3n3ASdeA6MBhSsta3LaxePb5DgG1OzFjuzSqTWikvx+9N9FuSoAdE1IMKv6czEwXGNEQN9ePN6zm7MnEL0FEBsdML2Oo01D1ugOS/5T9pCpmnVyZ0DlV5cL79/3FICYFkCt6vMLjD0WVeTijU/mHd1onDqtrwn/eJc6FhY2uB2X7ry2JGv8i1Vr0hd0BcaQZ1jnYJ7+R+QBjBHooWxCgAxbewc6VcMb0PV5Fj4cVykdtBJt5d28MGbzR5Z2QscuD4NWZEr8jJ8LTwilKqV3wdlD/Lbjn+QM2ymANspKPDaI/BAgdJeTvGMLErjk4BmkxDA63eG22fqBV10QOFqpmZeScJz0IOYhXgRHzLfSYYHrxgW9rx9uIC9IqAVckMEKEpdonKmQXDRJ6nHBJGia4LyuV3MH2RMgi4tb+dHHfgo4rwvlYbnQ+L0v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(136003)(346002)(8676002)(38100700002)(38350700002)(186003)(33716001)(26005)(83380400001)(54906003)(6666004)(66476007)(7416002)(956004)(1076003)(55016002)(478600001)(6496006)(6916009)(52116002)(316002)(66946007)(9686003)(86362001)(44832011)(5660300002)(4326008)(8936002)(2906002)(9576002)(33656002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mp9oC77S4Edx++mhD+OULQ8Rmy1S7iDOURAAUlQcz+zNvKBFU80gdj/G4dEI?=
 =?us-ascii?Q?rGNaGDLGyKsTtlZ+pviEQGSR4PPd39qrQpD1iHcCGGzDZ4hf8bGTD47iDAty?=
 =?us-ascii?Q?V5qJ1ICPEBKMPpUOqW7bEXDh4iGgreW1vsemV34sRe6n0NhzlOjwTRJfeZBX?=
 =?us-ascii?Q?xxQmm+Sce/lqjUqTb2vNc1/Unw1Kv0ZurZxSJns20bx8Xf2rMMJVXV15xcY5?=
 =?us-ascii?Q?va2URzHBq7Zkw8nXA0okEGW4fF1rPXYese3NOemV751neNNuxb++H1UbuLLV?=
 =?us-ascii?Q?vZuTDDnzAOpLkXahp9YfyxQl58eDuxHNjC2rhWiGUldZgVNL5FHpGQIS6gh1?=
 =?us-ascii?Q?VfVvFw1ciaDnvLq1YecnI+1qtRaqI9eq1ROC6nTlyHF919JYW0vD40XkUG2Y?=
 =?us-ascii?Q?VcMQv539UpXM619kpIIEbRdeDrah+pjoupDf93RuNRW+zq8gitH6cnQCvfgn?=
 =?us-ascii?Q?qENG3ONvLj9zqBhg+DGFBezGyfoym4Qfrf6UTrb/HCFl9OLECz2nR+SsgbTb?=
 =?us-ascii?Q?F0S2yifOtDwdY9MTKUVazCREuhDERGiwkL5tChKjY8clOoYeALwzoa8Jwq/f?=
 =?us-ascii?Q?AuUk3qN99t6cEsdpArqEuwICzUHAncPVmmJmLyaJcKnEBomYvdwQ/SMLCD3F?=
 =?us-ascii?Q?jYbWGAyq3Vp8LL90qY9PcYDyZEH9hPtNqJNORsR7TlEDZrBf54gJYlTr1bJ9?=
 =?us-ascii?Q?joeZyKNGs/vUc1RVcZXkPwWLzFxCcn5h/qOBYJtcw8nlid1YVOSvKY1s6Y6y?=
 =?us-ascii?Q?QP8E9G9azeG26d9eAWdhSxyBpGfnD9hxSlR+C91JRWfMIH7ZeaeejyZiZXLW?=
 =?us-ascii?Q?2Kn/6S5+7bKSUfNHi4ozkVmOB5sy/hbNVK/syZLyT7BeRQe243Ecyaq1he+w?=
 =?us-ascii?Q?1ieGVmIznmzYxihCjDnWw5JVB/fjXXuQQ2jSEWWZ29sS90+7hujjoZqt8KUq?=
 =?us-ascii?Q?rNfBItv0b0mi8/lweoMJsGCEcmnmgFuNbJ0GZhYRMhJrUQPvaO1KlPeQ1vwy?=
 =?us-ascii?Q?UpJut/j7VD3Q8y7Da+5MZXSX2Bzsb4joj0cQzx7lK3uEkCOQJsW6ON4va/r+?=
 =?us-ascii?Q?voYuNA9JaQTkgj3reG5Wn5SMthjR8OaJqtnF0XC9tkCafFDNnQSRl7p2QWw4?=
 =?us-ascii?Q?fNyTbDRQKmwzWFoF+3gzZcikh0RJuO535eKQARi/uFhGqih/y6Wf4zoaP8i4?=
 =?us-ascii?Q?nFsnQr+jqnnrf5KnHBE5NBjUsKeZ+W5eIRcCFgJPKoR2fI8MtYoUIbgm6XdZ?=
 =?us-ascii?Q?YiDSsRqzDNHWSWl6wbVtmzQFFML/0fT5GvZhJ//PHz1W0MoB+NKK3LLGand1?=
 =?us-ascii?Q?nylnmtTkdcA3hBCLjMpjWl2E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd22a34-6e2a-4446-9e5c-08d95e666b74
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 14:27:03.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSiJe45sSU5NrZx2TOSevMhTEegIXA2Jzg/3D1bIFRpql+o120tiqqhWlqjV5Q7p0j2o/omorHlvNXI5oQNPSU5iwVS+xoFxBqgGC+aiKLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2368
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130087
X-Proofpoint-ORIG-GUID: 9yYdF-1UQwqveNpEG4d0oBLcYq2keyFv
X-Proofpoint-GUID: 9yYdF-1UQwqveNpEG4d0oBLcYq2keyFv
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If devm_regulator_get_optional() returns -ENODEV then it would lead
to an error pointer dereference on the next line and in the error
handling code.

Fixes: e1229e884e19 ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: The -ENODEV from devm_regulator_get_optional() has to be handled
    specially.

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 20cef2e06f66..c9b341e55cbb 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -224,15 +224,17 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	/* DON'T MOVE ME: must be enable before PHY init */
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
-	if (IS_ERR(rockchip->vpcie3v3))
+	if (IS_ERR(rockchip->vpcie3v3)) {
 		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
 			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
 					"failed to get vpcie3v3 regulator\n");
-
-	ret = regulator_enable(rockchip->vpcie3v3);
-	if (ret) {
-		dev_err(dev, "failed to enable vpcie3v3 regulator\n");
-		return ret;
+		rockchip->vpcie3v3 = NULL;
+	} else {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
+			return ret;
+		}
 	}
 
 	ret = rockchip_pcie_phy_init(rockchip);
@@ -255,7 +257,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
 disable_regulator:
-	regulator_disable(rockchip->vpcie3v3);
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
 
 	return ret;
 }
-- 
2.20.1

