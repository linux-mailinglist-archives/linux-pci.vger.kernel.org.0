Return-Path: <linux-pci+bounces-1245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4A81A846
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F092811CF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EA4AF78;
	Wed, 20 Dec 2023 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pATaSY5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA54CB4F;
	Wed, 20 Dec 2023 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUeXkpditmBjIhZ8HH0nJbTWW8kidXEP5+D/3vvyiQfU9QsVzHRAkQ1Xk7W+uaypzls+eWREdrq5tllm2dDkwu5p4rHFszPnr0M1TPZStbKjQy5foIj5rgpVADJV6H97uM+ORnnbXsnCMuA0NBkmVj4bevitbaz/zHR7+cjfN0ziJTPd5FaWWaMPQzQRLeMb2roe6+HaIwTHi0vHdrnHKT1n24NMZBJ3tPAx77VMRV/Y/sB43kQB4018BNdmWFVyHcfQAL4FOhCUwKQRLB9JA7MUqKYkgF6muNATqq8yxdpmhnLlAKYNA+bZWi74Ods54vi2/KJrPaNt37Ygw4SZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pouqXGwboygEHGEyEH0UcBGMdn3xWvJFgCWv7qfcMzg=;
 b=YdHCv/IeLkd6WYW4JQTtt3oA3e6kECW0Dfji1BLnZypB5g2veU8YelUjLZH9WjPBg5h6dHb8utpIh5Y8JIvNLZczewURxFxgfvsfUBJn06D5J7T5qT4RzvZCmYgn5K/lBpodaR57UuxCMDOKX0zwPRm+Z9TB1sFQm//kgSOrAfRwDBFooZlc3xwGQ+8shi3FOaK62WuPTVZ2vWOpU5cr3+PNozClacMb02G4WZkcpraGMNbxDy5vTfk0BzebT3D5BOm5lBnto1FE8TCn86+g7KSnqcw007dYflmTttBCZCJVuM5s8QMstiloDste6WsLsQC7SqbSj+07Z+QUYIJj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pouqXGwboygEHGEyEH0UcBGMdn3xWvJFgCWv7qfcMzg=;
 b=pATaSY5LLLyOlLKlItU4e6wkQA4nCuY+qbTW837Iy5PQrOdhHQbBy5A2uqF5dwJWGGZLFgxbWAeUj8cY80Dsqv6WedzedHuEQfALwo0OuQyuc1jy2gPW+btiDVfcvGXWfOEhKm3HqiMyu1yAfaGu7IQsH7uCFwf5hphakgzkYYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 13/16] PCI: imx6: Clean up get addr_space code
Date: Wed, 20 Dec 2023 16:36:12 -0500
Message-Id: <20231220213615.1561528-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 7541fd4f-0e28-400b-ab60-08dc01a3e9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w50yZythWavAatm0+D0ixn2uj9Q2r7WQZq1EkgChhS6EvabMAUfVMiGPtsTxPEJIXLZUXl8m6hDLlC7lIpIm2vMSumjgtD3E9o+AULPD18XVBuM7ZwCmhpYtfLFQvigcInNU722jXPnJntyTRQeEWOOaGQAacVf0hbv+QsCn0gYdVyLZjZhlni3oJU0F/li8jY82UD0GJJ0uliPX1JyVheQBdL7a9dA0oLf4Pk9X7ooFrAxYdeBIjMfMTsqR4yY3HGZh+XJ3aiRA9wcPaJjUfGFWBsGZJex1UU4rEW9oXn+223evIXJRcQML6aXs6csFS2dAOBUmaZiKx9SPCllyR6OgQlDTitLicfgpH1dtXASbEipZ3MRfBjHe2TlRyd2K0IkyZU/7kdAKNNnXNa1mawwPcLpiIePOK0U+F+smgnV40Os412lG4L859fdoED5+KzV2RYp6RCFeQKbvdD5XfL32k/oWgtqQrM/OsJc8NvwbHjPgu+63eBctABc2h9DBLSvWlMlgmXJPMwPDsjuzfrvPQKGMykZ5XjTcEZyt//TPhOTHzZzUzH53D93vajZddLfktD9egI8/mmopJqDCK6J4u+EvrINKar2V66JhjlKmCAz3fUkh3qZ+dPL1X9gv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3TBekhqsbVEigRy2tk5nYlHBzSyyQ2U2J8QnYTenw9rjERP93/jjRAVh8Kf?=
 =?us-ascii?Q?uS38QVi408Yj0ZWteUY2Chx5nlrTsSOkwrQeH5Xdkw7lOb6T4VNzzTuJFFw9?=
 =?us-ascii?Q?ItIgGvxlX0xVe1iQS15/1KNzvlZNAoAx5yJzw4MFNPW26DzTWTo1c5KpHxWD?=
 =?us-ascii?Q?nMI4LeetIfDsobQzrldNcMmtN3wZ7/2CuCt2UZ4e/hVxK1CxsS3kP8OK6HNA?=
 =?us-ascii?Q?CwYtkg4qi3puxBchYxNtXWOKBXXOB74liUdEbif4ImCOUyiqjHa92xyNJdx8?=
 =?us-ascii?Q?KtB+s13v6hgZGFxDja7sbp/6HJZ4cLBhn0UNr3YoutCeb60cfgH2jx4Ft3pO?=
 =?us-ascii?Q?JrXg3uI1XIYQUaanuPadx9m2rLdhPZbuAYrRi1Eye7q0YbB7cfC6VZzH8/ik?=
 =?us-ascii?Q?2do7X6jexuxiRcyiwKmcBQc0mQaGDaJ9MEpA+60kT9TExxcRxNWqZifx2dCY?=
 =?us-ascii?Q?1n2ZDoHo1Wg8c+mJ1wYPzEIDCCQNA58p0NrzGYa3vJAKNagf2xm6nIIjrxVU?=
 =?us-ascii?Q?FNJ0k3AR2OElL1aJJtHqREPyZ+v2SDRWjXT0T8JZ4vY36t2Acsav9yqsVTBX?=
 =?us-ascii?Q?a6Oh4k+59gbEbjssSgGqsMahLJQsT8kR/z3fM3uf0zYBV5XPTd3jILIGCNJj?=
 =?us-ascii?Q?wCplI9HkFOXUuN/oAdbjlizX6M0Ob2vLXuwJxiHKUT97LABTjXK0t+y7dQY5?=
 =?us-ascii?Q?L7vE3ozN1y5QhtCUq1IDx6ZuA49Et70VHghH+99aDX2F48S3SEhl8Gjpynjs?=
 =?us-ascii?Q?dV+w09+t39fl+/HZBeJRATJZzK+gUHIInyyNVHMMWpa7UcWxtirsyYME894l?=
 =?us-ascii?Q?gAZPRGp7v1umZ0qIO5XDrvE687fEGKaB9uPObQRwfiE37SZj195KGhNSl3OH?=
 =?us-ascii?Q?uJGhwBUs7ZKYGGJgWpA7bDLHi7L+naPtRj3cOOGF/9cUBAWOjfKhl8b4tErq?=
 =?us-ascii?Q?UDe/gkl1ddP6r2tmt8yPu5V+eNzn3zmTmKgOhRG90iKSK1ciOIdy2u/fhQwH?=
 =?us-ascii?Q?WGxgS/PCvQfaz4Y8U3w/0fmftlt2+XVj6ptVHL9Wj3jwWb+O5SnBFmyW3+y7?=
 =?us-ascii?Q?G88mgnSvT8l1HOe45VplRPnkQ9EhpBHx1/xWPyHJYRta2HALGj8P5XAr7wJH?=
 =?us-ascii?Q?sG6ut2OXu9P8o6myJUQ801OhU7NYfxaA+szEmnrbNN8r8LV4/P2mVEsxQeiF?=
 =?us-ascii?Q?EmM477bypGySIu6C1+duXCC6Je+UjZIbI075EzPy9fBsw/bJF2zOD6dNDtDC?=
 =?us-ascii?Q?IbVgJ6b5rcvLsb6Uz8tl6XnSEhRFYXCW0/MZ3miJaAlzm4WtD5Hhj7WUz4oF?=
 =?us-ascii?Q?GrdIj3/5HkpRkQ8vlRaSFMelXxeeRWaHK02INrCooerPp1Ilx8T7DhCq49b+?=
 =?us-ascii?Q?oower+Li7JFWbIIV2xSOMQ5wzUcq9UFc2YRpJwviJiLa4BYnxvx+cmcXhuAJ?=
 =?us-ascii?Q?GhUG6JOVV47+nmDkIBfhWGm0D6tbzXAJaOPXbpyqQn+0b+U13WRVNr7ZzOzL?=
 =?us-ascii?Q?wC7KAs/5/f8WJJPXHEt2lGEjjWJR39Es6PjbcH2OO3AQWRO8BETyDq4D+sNY?=
 =?us-ascii?Q?5tmtev1UZphN22oTkfs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7541fd4f-0e28-400b-ab60-08dc01a3e9b8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:49.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeZ4QRAqEoTF+fwzlIauf+9MXSdgmG5cZW5qWATCRUCRdhr25me44a8QFOAbjuMLcpHLNPmX9DlmU5Dn4Ph+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

The common dw_pcie_ep_init() already do the same thing. Needn't platform
driver do it again.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches

 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9e60ab6f1885a..4b2b9aafad1b4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1080,7 +1080,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1099,14 +1098,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		pcie_dbi2_offset = SZ_4K;
 		break;
 	}
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
-	if (!res)
-		return -EINVAL;
 
-	ep->phys_base = res->start;
-	ep->addr_size = resource_size(res);
-	ep->page_size = SZ_64K;
+	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
-- 
2.34.1


