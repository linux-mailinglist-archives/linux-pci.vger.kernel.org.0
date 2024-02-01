Return-Path: <linux-pci+bounces-2942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9FD845CCF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B284729D2B9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1315DBBD;
	Thu,  1 Feb 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pbD81OBE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB480161B6F;
	Thu,  1 Feb 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804039; cv=fail; b=phwgrUhlBPjeTLybvZLhpZnB7yuGg10P4TV/pgW9z0tVtjE4TB6+H64JFj+3PXc9uoODebG6XFg23GigYRPZFsO35VbP7iQP9pG2wobgkt3ZuQKUYGx9y9GNNVueettfQwRZD7MCkfQFsvQQoIRRLvgVsLBO6NI1f0IYNlG1cC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804039; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D8neSvWt+xBWm7pJ10ESywZBApIZ5aUbsRrs6appJdOGUj1KEdXf6PD5K2uYh4TLQjqBEMPW88RwQOOP4BFs29CwSZHBgFOizMcsdBBgPNwiGcHcyA56NpAHqXjdP40RUPr76C3U46dNUqbTuf2vENKLfYOBEHJhPuFzhZehJe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pbD81OBE; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gElXbfHvu/xeKBgHTT3MlpxGnzx0cEzbqhFa7JzV3nxD+FOZHNT0znyBfv+hQ7mCg0om/9uF1qwXJ6Ao53rBjHK1pUsSjIHCfNnAqe/OIWriO5ujc61A7YUrIA+u01aWMPuN3jJJad+OnW5vsWAzaXiW6I/hOsat44rF3qSCv4yxN9ugzTkqHBqRxTM/6TBh2WyyWj4Dn9w3xRpzlRMIULVTrQdSVkckvoN79OSkC1Q8wNbligEr5L/JGp01G++3XK2zgl+SAC4L/m1YdsXPWJhgFJRgKhhE1LSLfFeIoX6I+ggUd+ddpAyEl3tPZzbnx8mS3gfOtZyabhnWUWRyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=V+n5lSlJTyLbL8VpgmuoCus6tIzJhY1NA/FeKTWIB0gq2iRI5xy8RFDTAFhUKU2mQn6TC8vTO2+6ADqQaEQUpGcvWRCBLSHGHykN0yGQFH2n2AJRzlyC1hrZ6iPY6gCVwcR4cODVyxZroKLUXZB/ohcvwbjRgYQBWx1kl33t9dCRjcHvUdUzSbABuLHZjA0u/UPPfhq2PEEsEMyrf6ZPyNqp4BlzsS4TvBdhdNoJuD9ZmrIhAkqaI9gEI0hmTJfkW3MvrG8DPF/mANixfi+uRdtGW1EtWvYs7n+im0YAg/4H8TI1YWlg39bGfde6xEK2V7Fy8TV5Z9cYKSvi/ofW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=pbD81OBEpFnUndc4c41rY2A6Cz7Kae7lLcawaBUlmEfF76AsyFQflBwL+RzY8RVc//LVWc5oS8+DAUGxSbkwF0nmW1zQhDiIuIbdykQmzHYfX/QKtfawsbMSUsbD28rP5kns02hS9cNQd4sWjqXpZ1lziCorroNKNSxq9dTjUYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:13:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:13:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 11:13:27 -0500
Subject: [PATCH v2 3/6] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-pme_msg-v2-3-6767052fe6a4@nxp.com>
References: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
In-Reply-To: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=Cffk8JqUvh8PY17QhvXtW4TF0el3Q7U2/B9EFQpiXMXzhS0l05W2bD/H8dFBF/NQtFGvNG7Fm
 PM+Sa3mlpnhDK9n8f6LVb2hD1o1D0V1SLzQzVdWYhYeGMEOX6YMsOEl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 0187632e-e5c4-4717-052c-08dc2340ca42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5djO+f8tUaUzwzahMWxzUeg//wQqeH271+5nO3yvPhYvgwCzELXxWG2efHQvSevxBJuWgE+PXr5LC3OjdlYLQD+ceGSBxzrOnCKf77IKScDyZVgnkO3PQY1CUSt7XWWWC7MHVE9ySTcvy+tyzX7SawaIQBf4Xa6L42NGmW+o+RE614VREguSAMXvN/26NQUlqMhDeikjjQLz9Czv6roWMOJIOObFQexAtAaxR79B8swjnhMoYTvjJSkxSrnWxwRzZWtbRBRdy/zauIBd+cld5kSzRIhmPjYEPTouYlH2O9UXeaXV/WGys4tiJCtKPnKDzFBecK9lwRRpavuuaSRdNeutdCaDihKdecs6qEBW6fd5UKQmrtas27iBn+rGz4rmMUqjp+Rvu6tel2boRouo/8SwWvxaZ1GsX9YgOVlBJXBvBwhhF7p9YvziW7GJ+iAV/7fwO6VlnQYNuA3XU8rYbjry5XKO64a6nDCH9HPGHCTZ9bel7jX/R+TsKxT1bXEurc9+Vbl8sehPqqJPibRbqYtzjypHWKIqpNty3PcWxzltDdEcYZ+q3SZ+4mmK4r0pfCIJs6oFJ7xzEqxTxi5mhST4p6W38n0dziyv1uHOYbd3p3wHwlvvNz42+rmL/fGkOJwqmqcZjzRBoIgpa6sa/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(7416002)(5660300002)(41300700001)(6486002)(36756003)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVOSnlySnFDRHpsVEo4QU51Q1plRmJEWmJrcnN0aTJoNkVOVmUva1VQTGNE?=
 =?utf-8?B?NitMc2xINXp6N2p3VFpyMWMybDNabDExNGJ5NXZQYjZmWFl3ellpRmtobk1k?=
 =?utf-8?B?Z2lOSUIrTnc5ZlRlamlkcVFzQ21LMHNGSVh2QTRlS3FFVDBGbDZYM0R0R0FX?=
 =?utf-8?B?MlE4a2czaFN1WWhwWlhmOGIrWkVWOWwzaU5RNHk0cWlVQ2xvRk9OWWJXOTJu?=
 =?utf-8?B?Y1ppMW5mOXByVGJTa0x6UWxtVGE4SzhWQzNVbmptOG9LbFN1b1RIS2tGQUw0?=
 =?utf-8?B?aVRveFBZM2dKMlR4aVpLY2REM1NxWGFBRWN2dWlXcGlIcjlFYWFLMTRuell3?=
 =?utf-8?B?VGF6OWZzZTNBQ2wyZENnNTNIbVR1Sm9xNEFJOVFiWWtlSktKKzVsYWdkeWEy?=
 =?utf-8?B?R3EzSmVXYkx0bGt5OTZ6c2c2bVJ0cHNkYlZCWUNEZlEyWE9mQUFoYzdlclBm?=
 =?utf-8?B?d3BxV01aUjA3ckpsTEE4bEtoZnJiVVRkZ0t3Si95TURKdjI4d2ZvQ1VzMWVS?=
 =?utf-8?B?WThUZ2FNaXJydkdYS05vTkdydkRZc1ZXZWxMd2dZcTMxY0RXWWFLemc5TS9Q?=
 =?utf-8?B?M3Q4MWxrOUpkWTNWTFZmL2F3dStaTkQwN3ZJenVlRTlGNDhpdXV0bjRVVENl?=
 =?utf-8?B?KzRJcHA1VkJDMEJNY1piZmVvRGl0Ym9tK1RpTmkvTGJyWHVHVm9JZWVlNkRN?=
 =?utf-8?B?KzA3TUxoN0ZFaUhMalFsTjhCdXNaUWVHRmlXbC8xQTBNOHJLQitaazUxUkJx?=
 =?utf-8?B?dHpTaUErOEpoUCtCa0xtNnNqajhiUThXVkVPcjAxK2Z3Qk5DYTZPYTJ2SHRy?=
 =?utf-8?B?SDgrMnBqRFRBMXNtSmRHa0s3dC9TSXRXclRkUUQrQVhUb2Myb0xpVW9pMGdZ?=
 =?utf-8?B?VWdLTTlyY1BVTWZWVUthSmowbEZtVCtNQ2o0TGxNSXlmN3hqMkdZcFpUeENs?=
 =?utf-8?B?SGFmS1RYSnRQaHpkRlpNdndnbXRrVTExcTAvOTQ0ZEtEdU5qVEVmNHc0QkpR?=
 =?utf-8?B?MHRTeURVWk91dEFpTjBqVEFoenBCSkZBQUZTR1VUQmVEVUtnYWdXNXpLcDFY?=
 =?utf-8?B?dVcxN2lhZlVWa1FHRWdPOEtTdTdYaTlGUVczU1hJanYxTWFrQ1BtVzQrMCtO?=
 =?utf-8?B?VXVmS3NWcjJEckxKM2NzTWJQUGJZN1pKNFNVV0VCMWxVamhacGRUTTNoSDNG?=
 =?utf-8?B?ZHcwVFRDMVN1QTcrMThvMG16bUZSN3dSUTE1YmlTR1VXUXIzTXdURktQMWpl?=
 =?utf-8?B?QVN3MFUwd2tkUFdsNzR2bXYwanErLzlkWWFFMzhVKzdNamMrTXVGbmNzNWdG?=
 =?utf-8?B?UUhTWitpUjh3M1ZKTE9MaXFTaGhnaTl5akxlTk9vamVqVHc2cllIbEpjV1Jr?=
 =?utf-8?B?NmVwVVlBYWZYRTV2RndGWjAwYWFYbko0VnBsVjZxait5MjVZOERsc0lMeEVh?=
 =?utf-8?B?SnNyR2U1NWNUNDZDZU1QTEZNUzllbEJzRkRhbzJqWGhiZmVsUFMvZlY1K2sx?=
 =?utf-8?B?UkFiUmplTi9BU0wxNXgydXA4NHgwS0tLRHIvcXZ2QUl6cGhSRCt4WlkzZkN5?=
 =?utf-8?B?dVgrUklzVHhrOWpWTjk1dWp4RGtUSE4vaDZuNEc3czVWekFRUUlUTFNzandk?=
 =?utf-8?B?bElEVWhyNFpJUnJ2azRDQ0FHL0ZabkdFeFI4bHlNaUJuemQydFI2bXhJUm1y?=
 =?utf-8?B?ZG16R3BWOVcrcEtYMjVaUXVHcXVGNFB2Q1VDSC9zUGdyVmdiL3hPNUJsLzg4?=
 =?utf-8?B?OGlYVkRpQndBRERuK29pSVllMmQ0UlZRNEt3Y21UZWVFSlR3N2xCNlAwOGVx?=
 =?utf-8?B?T04zdDhvSEdWblBQSDJXNDZFcUdQQnJpNStHNXJOZzJxQVhuTTBpa2NZNGVW?=
 =?utf-8?B?U2NkaElNbTNNRzVpR1U0SFcyWjNyaXNKa3pTUDM4MFhtRVVZZmtNNmtFZU5O?=
 =?utf-8?B?TjFyWnUyUWlOSndxd29HV2N3VHg5TXFkVGpaWmJNUUw0YlFvMDZGWE9nNC9T?=
 =?utf-8?B?YnJKWlNJekIwVlFDakliaEVkVXNhcFByT3BBcTFqalpqKzlmVzZkdUNBZjhK?=
 =?utf-8?B?eWNGYmtkSnZ5aFhveGMxdDlySS9XQjEzSjdtWGJZcDNzYjJCSmxpSk0xYThY?=
 =?utf-8?Q?hgH8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187632e-e5c4-4717-052c-08dc2340ca42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:13:55.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdrLjNZjHVTB8FF4kTvUk4jFWp2T4ZpumpT1s4DP+fiMhSMfTJxDM08z6K3wUQu9cymxYRSW8u4c5utp+5Dq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


