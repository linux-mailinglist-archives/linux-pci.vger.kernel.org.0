Return-Path: <linux-pci+bounces-6370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56788A8997
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B20B2486B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B978172765;
	Wed, 17 Apr 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="edBHrkjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF29171E72;
	Wed, 17 Apr 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373223; cv=fail; b=ksHxjJGjav7WM7QMe9gLEBm0Hy5lpHAb9suV3tkHiGDYhw3nxZScLorQbDK0VcaZIpGewX0aMfPDgaiodTl80ALs2UqALzZO91/2A8XcgjlQP/Q8XsECcYbDRdKXNdmjSBOO0edCycD79r2uAlp5K9PXFj7elxkOQmN9H7ActpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373223; c=relaxed/simple;
	bh=TFgqFDue1aadqg2y+3rRxqvx5IDVQ3/Xrl0gfgcuPms=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tOk26Kta1iar86XKHEBnVJxdQCFHIH6RQrfZaeQq/aW9qf0sWHmyPxtLC9E9eTd6ty2MKpxlokSCmK8/ROBACQyugMv0B7uIy8TzA2M8KzttQhH2LK2qzmUNAHLA14oASvf2Kxka7HvKLJC+0CuhPdwAiOeexFOxEEBAcYGHoAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=edBHrkjq; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr1ovp1GeSURT0BDNXjPtfravfsZYzUci0iDW0LeM1MfIcJUGEBafTRG2FyVNGh63orn6B/2perXKJeLQRmPaWYdw+LMARCIlT40CNpXwb20E8kBfescVCNV9E3fX4OflOGaESO+Cg0JGPm9Qe8f7f8iajQgxsgC4rGdLWTUcrA9dQtORh3YNzTwCpOoeFJikll0556k1TdgVFSXVMqlSI0mXAmu8Zic3DZ3U4LQ+lTjDdgdp1VtrbpecAm8fkx7vxMEsMGroKFJtYkzmJywQ/kamNMzuXMTA5JZcEL/G/IQLtHLEsD1bz5Rsc3LBINGQHtzwXxGzIGub0WvQyD0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrDm70oFH5JEMjN5zo19TAic6YhIgjCqSE+nHU7GghM=;
 b=MHjRxsnKUrNP7f8Qrl0cH8U9paqVDJTxkjA/zRPoe6SYOsyjoLuSjWI4T1hUM88ckIB4fYdJVyFfa103PasqP4WMLajarvL7lbo0BOU2B2dBQj2R8w7CM76CQKWhg3PEkeJ0jTzv6Kwwq3vekL0Jbz9NLjWeUDR6VvPqI8rwppOXU0HGjH/pxEmoIsgcCiygZMz7ERdyQHel/Kkk2H0OlThN9E80QeVrOVtvHOUeQrTXtXlmYNoP4x9vdpPfpvnvr0CAZrFb+4JRNkc5wrfVO3C8S6LCVDUI+c4ZQLDCFddwZyzwRaEsEr1nC8/Ar35p+17aiK7PQCPJvQ8OUFuoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrDm70oFH5JEMjN5zo19TAic6YhIgjCqSE+nHU7GghM=;
 b=edBHrkjq+vLWopqD/xoRUHcRzHQDBCDeOdjiLA6QeIgPsb+Z7oko94g9uCwHEE1roPrvLWlFSO9sA8WGxfSfFQz6xubDHg4xgmiSA4WcBOpVjKZYzGIv25zsTh/Odt+33xE4v2Yr5ZeEaztYyxFqj5T4RRHDRRfxWHdzwlXCKvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8080.eurprd04.prod.outlook.com (2603:10a6:102:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 17:00:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:00:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 17 Apr 2024 12:59:42 -0400
Subject: [PATCH v7 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pme_msg-v7-4-9c6208cda90f@nxp.com>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
In-Reply-To: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713373200; l=754;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TFgqFDue1aadqg2y+3rRxqvx5IDVQ3/Xrl0gfgcuPms=;
 b=tgn4TYufGAAE9ehOYLzYDs3s/r+EbNJjlUnAYI3plydHApewn1eUEczxgBbwcN0Q3O4RDREa7
 eZJHFLNjvO9AP1HPMbej5Qq3kqafBXTB8iKZsv+5JKAAv/3eA2C6eiY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cf1fad-8bff-4521-f1c4-08dc5effdd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e8JF0zZrDJ90dhDYCUNm8mNfMOP3Tfgf+oYDk3F2gY4gAOttQZ9696f0TccryYtjLjPHReAPBUziDh6HJYMh2JhX0VbpMRX8KOZvva/icpFW9sMcQOG1iAwCJaQ9srn18GIRJXw32cJRS9wZsMurq849acQDECycXlWUWKMItuhNyRjFUXanC6K6wgwyG8Zlfhj+IIJqUcS75Rc6Z3rp2YX8m4GEofu+rJZJz6ZbOpOrHnRIcvH3HXXjUeJo2RSVqoZwgv3VKZOpBuTfPlm5qPnRicOCOfv9EaQ5rJbN133IIcRRnQikavO9v62yoGt534ez4R8yLc38/XoWMu6OV1HQdm9V/iqvJn1QbhETuOk4psj9i+y8LBFhhQNL/1qy4hesiDRcDqfw6jmFl4nptiBUzkUVwbl1753LB9mTvVtIuU5Q676SsZ6huoqpEixRNwwgvXX6FX4NhgBBUoeEj4dcjxao26PJsHZiEyG8yrg3xLKLKXJ83QpTRK3ZNOHL5nh7Ul8GA7Z+CZfHEu5zl5mlNslYL/xBWOYs2KmuR0WUGhssoWIlbY6Sx5inzUIkRZ+ObRqx43Yt1qD/n8jUU6hP0GgUg6hp4guwveTChsvfRt2EfR+kKOARkdHLNVinT9CVaWHW7pJoDcbR+JFAQTatKDzqjiUOEJx0ZlX4AL05VuSsdIIq9C7FNoLjcXmKyWr8GlYCN/ZkM5+dImaXWIQOtg7EvrKi9yK2Kf8AiZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T214Ny8zbEhpNUZRYXhNTk8yUHB5dTBwekVtOGxZY3g4aGNHV0ZmQ3A1NE5o?=
 =?utf-8?B?bUJVMXBEczUrQjN0SzR4ZGVCVENnR0p3Ukt1M3VwOFRlbTg2TW82aWtBL2FH?=
 =?utf-8?B?SHAwcFlma2hwUmZtSWNKZGZTLzNFTUF6dy8yWEY5bzdjRkdSZVVDMGQ2NHpa?=
 =?utf-8?B?TGM4N3dGeSs1R0cxSEpkU0RYNCtUTG92U0UwdW4ydnVWT0xLVUx2MVpEdmha?=
 =?utf-8?B?dnNFNkFaRWlzUXJmRVBLRGFBUVpYNEI2UlRmM085TUx2eFpGczlCZi9zTjlT?=
 =?utf-8?B?KzdkOWZLbVhvVmVkTlE0SG1HUmY0cHhaSDlJcy9sYVRaa21HblN0cDE3SU9O?=
 =?utf-8?B?aFRHTGY0ckdCMnZTaFdvOGhJMWRpUnRQRU91bXkyV00xTmhjV0VyaHJOSmtQ?=
 =?utf-8?B?TitJaHZ1aE9iSTRINGprME1FcG1HT2JxSVgvdktzaGJxNFZuTURDeXEvZmk2?=
 =?utf-8?B?VFR5NDJ2RSsvMlE5RHI5cTl0WllzbXlMWkdseEQ3ZWx5ejAxZU5qNlR2Vnha?=
 =?utf-8?B?VkhLNzhML0NJVWUyTFhobVdqa2Jhckpyc2ZzbUVmQXMyUXlhQjVyYm5vdzJj?=
 =?utf-8?B?MGxxbUZlaHVjVm00eS9TQTVjYjVJVHlESkNJa1BSemRYYkUxR1VCeVhNOWVX?=
 =?utf-8?B?QVNaK25nSFdzV1gyeE5wQUxzYzk2SjVxUXc0R0lweWxLVzAzQ2Ywdm1qU053?=
 =?utf-8?B?bjdwWTFDdnlseFJGUnJ4MUJ3NXFKM0V6VDVCMVcxOEhFOEthM2M5TnQ1NzU0?=
 =?utf-8?B?Q2RuS0c0RXMzSWF1UDk2QkV5SkFtUjV4cm5lS0tOWUp5eUh3UDJBZ0Mzb0E1?=
 =?utf-8?B?aUxmc0hVS0I3LytUSW01bENDa1ZlanNnSGJhUHczNTVQQk8xK0IyMkhNSzN6?=
 =?utf-8?B?anM4bUx5cGFyazE2MUlNWWpHUFowWURpdUZLVEdPRGpld25Td2psQ2VMRTU3?=
 =?utf-8?B?dTNmbkRaU2xhSjBuMkdzMWJFbkVmSFlVOFI0UEowUUlKaEtjWUU2eStUVjVv?=
 =?utf-8?B?Ty9BRjlqd1JvSWdMZGtiR2VxSEJkS1l4Z3RSVURmSzVWckttZ1JXL1NIcjRw?=
 =?utf-8?B?NE5yQjR6RW81UHcvUWk1MGZhSkNHd3lHQm9IdStTZ3ZJeHhUTi9uak9nK2JO?=
 =?utf-8?B?N0VxTDFzb0VDWnVrMGtMMDdUaXVWMVo5OUdNQkdEWDlmNlBCa1RWSVFhaDZ5?=
 =?utf-8?B?Nzh0UTdXaWgyZ0kzWWYrK0JFQXR5OFk4amRYdXpyZDJNeFdVcWdObXUwUkZX?=
 =?utf-8?B?L0xtNi93V1BVMjR2S2lXYks1OVdEQWpIUk5YL1RnbVBCMU1jSXNMQzY5SENG?=
 =?utf-8?B?ankrcDdyQzFDTlVZRFJFQ0JTRlgwRks2ekJNczFOZzRFNUIwcFUwVUk1TEhW?=
 =?utf-8?B?RmZJRFJrK3ZpUDg0L2U1cVlTc25QeUxlV3BVZW1aSFl5MllTYjM3dXVyUURz?=
 =?utf-8?B?NXAzemZJcS8zWlpWV1dNNnJBRU1XMEtENWNYSGRseGI3S0FhNE03cWpBaVhn?=
 =?utf-8?B?eTlxbndIK3U0eGd1YXZ3NzVVOTFSb0hlVzRGV2EwaHdMRjZoNjNxc3hKVEYz?=
 =?utf-8?B?U25UK2dVbTF2Tzh6NmNRY3RpN2hTYUhRNU00MHJWRkxINnZ0VWd6cFhBMEtp?=
 =?utf-8?B?TXB5dDlzNmlVaDlMTnlhU2xqenpDQlE3TkpKR0ZzbFFNbG5BWWF4UHRjeTEy?=
 =?utf-8?B?ZGt6RU1MRE5ibG9oaGVEK2g0UDhTWUVGZHBGUmowc0RscTN6dGJyOEw4L09l?=
 =?utf-8?B?eHM0M3hOY3NPeXgxa3ZORFlTYXoyaWFZK2kzWVptRkxsNFZlaGxyeVlYRWVo?=
 =?utf-8?B?WHFNZ3YxYlAyc0VtWmgxMml5UmJmMng5cWRiMk1QVGFuK0dFdGI4TDRMeXFQ?=
 =?utf-8?B?UEMwMXBhQU9xMWduMlY3dVptd29TNlB3STh2Mnl5bjE4UUFwYmRVYXpVU1hW?=
 =?utf-8?B?bGp6clVUcUh5c1I1UCtBREdQU2t0d0xtOVViS3ZYbWhYT0pCQWFWR3Npbkds?=
 =?utf-8?B?WUlIK3NsYWgyQnhvS2MvWHdSRjBGSlVmeTlXYXdYZTJPRGpzVDMvd1c5dnVm?=
 =?utf-8?B?NHJrM2dCNXN6dGdPTFRVZE5aZGV6eUVpK0FYMWNoZVU5S0lVQy81N045MkhB?=
 =?utf-8?Q?PPHGWvvgJ8AKvYUW7JC2k0ppz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf1fad-8bff-4521-f1c4-08dc5effdd4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:00:20.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jr5Z9sAPjQKwHVgtQ7QdpapBoYv/WBi/HedB7ILOjnnKQKwBFtTXSogqNhQeJPLHOFcusG/frpPF1nftiOFCAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8080

Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
PME_Turn_Off messages.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 02f46875fe2d9..36381fc7ebd32 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -30,6 +30,9 @@
 #define PCIE_MSG_TYPE_R_LOCAL	4
 #define PCIE_MSG_TYPE_R_GATHER	5
 
+/* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
+#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
+
 /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
 #define PCIE_MSG_CODE_ASSERT_INTA	0x20
 #define PCIE_MSG_CODE_ASSERT_INTB	0x21

-- 
2.34.1


