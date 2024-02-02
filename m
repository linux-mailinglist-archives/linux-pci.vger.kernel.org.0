Return-Path: <linux-pci+bounces-3029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140308472C9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903DE1F26C4C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAFB77654;
	Fri,  2 Feb 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HqnhNUWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A71474BD;
	Fri,  2 Feb 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886724; cv=fail; b=bHc/dlwS72DrFn4uonDMGwcVvC/hPniPVyQmLVmX89OSmAhhtK5871c2ztiqVc9FeRiKWsuCQlTkemKt/mDzF0erez1qm+Ch/5PIZ/sBKZoUQ6f3O/uLTCmBVEKN7UChVzNV5Zm1Ob1vAGr8AdqkKOj5UUT7vqIt0bnN9TjO9A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886724; c=relaxed/simple;
	bh=9vOBvFwLsQFfcUpqiTBHWGAwQEaDEiEalYuERlgzbJg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W1G52gWy+Ppd4RyfClguJlyQ3yRx/1uJlyGtpWYWQzocVoJNRVGOhR6e8pwA6Q7fL6BlIwAqI1wN9lTvlNsWKruLqmEtW5f/xGgvm39sg+DwFs5/KmjYmB+iWSlUNarNCTOciLglbtEY9DGKRDbCMjEvAS9xS4WnhacuSYIwHks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HqnhNUWb; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4kof3YtA2iTEio1kQbUv4xpblrsEGpTabxISQLn9P1IIPJ6oDAcVQePkhvXUi04pQDLeq2RrXpiZRTt3AcNB7hKmiFJR3Ds7dIKqGg8AQeFjWGMh0JcRfFybznVZE7vHGHC53WIiejk/wSSUrYUgEaT++SXv+JANRAlpXvPrMQpZ+HxWhHw5wZj1xfaXqlu5a7uHhC2/Crlfybkx34+85c5l2e0YGgaKTnpPFOVpRHjszbHwDwnaNCZ+YPYK7W35RFLIOj1g/fDwriuTAGK3J+PlYJP8PWpTpbmf+79+Ej0cOYu+ARGAycf4kFzTlLD86qS0nsXg2f1kesj2VqyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkGPA7ShXT2dMqSftoaGZPxvURuUZhBj1jU23CJyNv0=;
 b=j7pQoJ1+EoaD01oZRKy7NcGbyspy7isevtE5ji4sWZA1AuFvf0Sn27m0319stlMmYvDAC7ytJvIMjSTw/SKxhrzLfXY7yiM1LaO18HQLiANM527kLxcNEy4bqnEKWHGU+vENn4aPJPVdcH5AmUorwCA9kuw9RvehksYQ9kq/JHSGOVuNsYX4zIqm6s6IDds6JBrVs6vjflzzw+GhvUO5ktkcnWtBUgwia7iB2QbbNgRtvX6AdLEObXD7yFr+tKjTq5OrfuVjn2AC1K0fxQPL8JcT0ce0CdTV4moWy7AfBNbmWAWHdon3mqo6etHO8Y/YzBkn8GaDmTTdOIDPdguyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkGPA7ShXT2dMqSftoaGZPxvURuUZhBj1jU23CJyNv0=;
 b=HqnhNUWbRU4K8B03NES8qSTMpGi9p28567SVPYZf2hEZlUP352I2SZJB3KOo+NYe+jpyGyxffOZEXVHWOxQxZSQyl0XWGYsx3e5XVhscYivfpn7qHLHTBnLOz0NFlleMAdwCjArA0tQqteA/7CBCMiebRr5iG1aZ7anY6L+Dvrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:11:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:11:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 02 Feb 2024 10:11:27 -0500
Subject: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
In-Reply-To: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=1219;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9vOBvFwLsQFfcUpqiTBHWGAwQEaDEiEalYuERlgzbJg=;
 b=gJWw4Vot3hs+HU+csuaNF+8iTFT5SdejAXpp7Nis8VQtP4S3ZU3DdXgPoF+Ky0jKSmmAtCeHW
 0ozUKXLt37QCPV/LFSSVS7vEmiI2FNDWsrFaCyTBkvz//EGSCVvbvkK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e8e0bb-041d-4332-764c-08dc24014d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ci18+xKaHUWDLFvHDmLPPimhx8yxrZ4FArSHANffsXLU945TlxdqLLj92FVj6f59ewWxr13WGnzk/msfQ8FUij9VDLmE+fFhXNursNNekF58VcyE2l1qwyMoYjvacL8to+geWtWoL3kF+jRMvEJVr6bRyTN8Ghd7elunkQkf63WTkEihxRlkKMuRMTE5k7kmGY2rYjDU75yHEQv19Jak/rsKX9q2MyqzFBJ2w3UscYtwI+e7nPIqV5aKMdoCMHPSdS0QqvyyR7yMBtThTN1Q35ovDH0bKaAtZ7sibrNEvIYVdyWwHjzmEckNvEZfZy+YySb+bH1qPXdNzT3soOvFuVJup5QmbTUR5l1NrVWeCAj6BcHNx7Srh1pxr35qP5J+PL80T9LLgKlr5HBTa+x9dLe1Zs23ShK1eyDhigirDPO+XzTbkHJLKfED/X7DZ1rWD/C/1kgDwfLO1/qFszl5Jt8pYMx/tiw6vcpy6oXWg0LVzHHMWe9doEoNkm00ga5qkc9iZ2DF4TubrCjHWaEPcDZ1QLOe1D4Vtn9iH9mMhn8cHhqV1g6hSjt/4fCdDbbmW+YJFxYocSFxhWNFwZTsPq0YwdCUcQpsjpHopDq9e/z6yNrzfXACJUbn6wnrU40ytOhIGlaUulXkh8Pz57a2Vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(316002)(66476007)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhZOFZYTGNVNUF1K3RZMDhxd0dsQUhYeVNIUkRBQ0wraCtCemV3R3ZNZU80?=
 =?utf-8?B?cnpWSVgxSmRlREEwNzl2bk1WZ0s1VE0rUnJaUU5NdkVlVFFNVVA1dGpHdnkv?=
 =?utf-8?B?U1RaV1UxTFVHWlZxdTh3eUZsNWtmYUdKZ2RwNHd2aVFyOWFGNVhXNzZWT3dm?=
 =?utf-8?B?cVdEZ25TanA2Rko1TUdUcjFyaEpkVDQ3ZVVqNFFIbUNMWnE1VW9mZ0VUWWRI?=
 =?utf-8?B?YVd0dVM1R0V5Vkd1UUNNU1MvY0NldVFQUUFieVFBZDUxbU9ybUgzd212bmh2?=
 =?utf-8?B?UzRtWVNSN2NlVmVFWDZZOXZ1QlM1QVBHWENOeTN6RXhRZUF2VDF2OFdDL0dh?=
 =?utf-8?B?bnQ1SEhONDZIMEQvaTB4bHV4V3RsUDUzeEFvaUptdE8wRDlHeVJWVlQ1MHFN?=
 =?utf-8?B?djRyU2cwWTQ5UGJZTTdXM1BLMS9McGFZZjR4bzFnUzBxY3g3Z3A5VC9LVXQ0?=
 =?utf-8?B?aVY4ZHBPcGMvRTNaMXRJdk94T09VMG1oRFdCRjZvaWFiYnp2YnZCdURONHlu?=
 =?utf-8?B?RFVPMVJNamZuTlFQWDM2RWJYdFhJNmdCRHEzdlJuOHFGcEFvUUZHRGF1Z0h6?=
 =?utf-8?B?cXpGWFVCUU9yNG5hN2RPWXltSjRFanp2MzJEVlJCL3JkbWlPUmphbzFXVG5Q?=
 =?utf-8?B?bDc5MVFQdUxWWEpjNmYydUp0eTBtZDhKR0dKTmJhb2NzM1dZR01TcVZnYjNz?=
 =?utf-8?B?eXhXTWZETUdhcFhMM0pUM0xrQTRZYWdnNk9qTWZmRUJGRWNSR3UyNVBiTFcr?=
 =?utf-8?B?RFlnamh0Nm1mbFZVU3J6V0NpcTU3NzVrOWRkcFpZTXBWd0dHR0Z1UkozTmtz?=
 =?utf-8?B?MVprWFdXVmh6em9lYXZUQzc4ZWZGeVZybm54NGRnNXZKbG5ZMTRQVndjcmFy?=
 =?utf-8?B?MVVqWU43Q0JkbDNrLzhpOFpER2xsRC9McThRVzI2cmkzcStrUlU4ZWx2UFJ2?=
 =?utf-8?B?QnRkWjlUMWhFUFk2dWhZOUl3R1J6TnBpcDJZdnIwZ2FMenZJd2l4VWZJc3hN?=
 =?utf-8?B?ckQrZXZrT29NMzRiM2pMTUNPdjI1MWtEcjFrWURLa1RXQmJrb1ZLNFNBRnhm?=
 =?utf-8?B?RGl6VmNUN1B5a1pNSVF6dVhxTko3WTNJK1ZZWUpDSGlwVG9Xc1RjcFlJSHhU?=
 =?utf-8?B?S3RhNFh3ZGFBb3FNS2NwdDVjU3oyMkR2UVlnSExTVVI2bDNpdUYyQzVTbVpJ?=
 =?utf-8?B?c2NXZTZGR2N4WDlpak1RU2d1NG42UXFjNXRIdG1jKzNxejhhbnBOSGtDRFFV?=
 =?utf-8?B?aFJmdFc0akpDcHYwWW1ScXlvVDkzTFpnK1l3bEljRFNtR21BbDhlblg0UzRL?=
 =?utf-8?B?OGphby9sZG8yMkNlZEo1Z2pEbTFoME5WeDd2ekUySk1zbnRqUVhqU2o1NUhE?=
 =?utf-8?B?Y1RXTHltNUFUaFl0KzR6NHRUaDFCelRxVU03YVFQNkZMZlV2d29ZSHIyTHli?=
 =?utf-8?B?dWtIL2pqZ09YRVcvUVgwU21JQmVNVzhhUTZIUUVFQ1NBT3Q3NWpQTmNDaDEw?=
 =?utf-8?B?RWFrTm1TU3dSYlFibkp0Vi8xS25iMytKLytnRDdGcGl0NFBtN3Zxemh5OVRG?=
 =?utf-8?B?S3ZCcUVJZXBjMDcvVEdFTGIvaDA2aXI4WldtZ1pmdnpvMGgwN3FxS1hnRUxl?=
 =?utf-8?B?VXZrSUJDQzhZaDBCelJWdENncHZEbjl3YU8reXQwUkhLNnJueUVSUWlwT29T?=
 =?utf-8?B?UGs4SXg5SFc2ZFFadTJtWUhDRHJXT2N6Si85QTNvVjlHbFREejJpbU5uQU5K?=
 =?utf-8?B?VVhLcnlNNkFLRWx1YzJzVm5uTTdzYW9rZ0xEbytOS0FESHNpekljVVk1bk0v?=
 =?utf-8?B?cnNtREtwMENERmhNYnA0NzE3Nm1MczVSTS95ajZmSDhXWUtOdklaT2FXRWxt?=
 =?utf-8?B?SGNJOUlXRVdoVVJ2REd5akpjaFBxbG5rYy9PdzFqZEZVaFNqMXhGTkQ2UEVU?=
 =?utf-8?B?TDdjTXVsMkRFTDI2Qm1CMnNaTTFMNWpMSDNpMGpwUy8wd1FjZ3dFRDhuU3hZ?=
 =?utf-8?B?MVpUVUJwcEdYSjlnRjliQWtBUGVya2JscCtDUHhwTVZHdk9lRVhSMTRiSEt5?=
 =?utf-8?B?QVVYdC9NT3ZGSVY1OEdvUlZ4YitsY0pLemxIOG5JeitVZEJuZDViWkVUY1hq?=
 =?utf-8?Q?YK+EGgT7ZZuXmcxymiqQoofxf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e8e0bb-041d-4332-764c-08dc24014d45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:11:59.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLbXhVr52j73qLy/11sWq5qqWQWp9ArS3P71DSp3mC7xOeS6re6m+014YayfMPffKE3XReIYufvjozYbvkuC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

Add an outbound iATU-capable memory-region which will be used to send PCIe
message (such as PME_Turn_Off) to peripheral. So all platforms can use
common method to send out PME_Turn_Off message by using one outbound iATU.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 022055edbf9e6..25a5420a9ce1e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -101,6 +101,10 @@ properties:
             Outbound iATU-capable memory-region which will be used to access
             the peripheral PCIe devices configuration space.
           const: config
+        - description:
+            Outbound iATU-capable memory-region which will be used to send
+            PCIe message (such as PME_Turn_Off) to peripheral.
+          const: msg
         - description:
             Vendor-specific CSR names. Consider using the generic names above
             for new bindings.

-- 
2.34.1


