Return-Path: <linux-pci+bounces-6288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C855D8A5AA6
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC07B22F5A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF9156966;
	Mon, 15 Apr 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ep7txuhg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7ED156652;
	Mon, 15 Apr 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209639; cv=fail; b=K7elFfHScbacj0YhmMfgYHPo1/MMAS+kKMoD1wdySnGkLSo/FRqU2IRxuShXJkxGTascJUDD2O4XmT5sE0cEJyXNA9Ba3q0chD7/OlvIAa/I37ezUh8wJ9PgSeNgIer5AK+SjfKfv/FFQyLhYc5kvtwfLJbn+MAiz/C1+B7hYao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209639; c=relaxed/simple;
	bh=K5BaRqeDAmZ2aPjZDryIUtVxy8PUv+B2mZWYcdlYqfk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b7BfOHc41qVOKUIXGaGDnoZAUacwvts5bnsSzsLVHJsmDkBXuI4Mz3CQleTo4O2jj7eK60OJJ5Mfzq4/RT5Oy6PaSsOz8nbFulmGDIdPXk9mzf0KWDesfiKxlVG4RmZQyz12mQVXVwOY8jFitGu305yxEV9584HZd5V9FdYDtoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ep7txuhg; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbbfJT/o+gA03BLiuGk6sr/Ff/BZGJYxmLoRCfnlt/Bg5KQgENHAHiJaiTObjNtw/G80ey5HVbXvm4cuCElYsibf6edCdz7uN4LkWmfYIdBFy6MPUxPop2SLo6tVitKq4zWh+M/vW5NF6xksidBZdP9iyTRlrYdOTGe23Sm0d8svuMdE1zH2cCUQ+NSMuyfekJDXvqEJD68c8QtSs0ja6R/TcKPBHGD9WgR40bR0Oa+HQakW0EO8VYOQ+t0Xsit3gijJajrgSLMxP/kWrzbrrbr57+/ZTObENpjdRiKtAB48Yn8XeyVcXc2uB4d43RraQcpfTLppcMrxtkIyvMeiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecvzZcOpGwJ3HWp+XS5Bdt7sJRZa4qNZcOf5pYCrF7o=;
 b=KRjQ24LdzSqv4ZfHwcOJnnUCYM+LMxSpa4wgOHum+u8JloVhtAkS+SxOH6E1gYlfQRMlnUFO0PT/i5WBJI9anwXJ1JGJ6+OULR7cLsF5OdssUEA4ciMyY4l6Bq9mrm6awkraGomeFIXrIQDAfEzebLk8rexJOfDp3yWAUzC8+P84U1BxCxF86kHPwHXzGLHA84yFhB4hDUaKkuWGhzF057zD0dHWjHVvmwvxQ4BOBtiwPe+DJsqGV+XCn5UrqU+ISRQBjYySwSLAbFWmqtq9yX4kAOnn793ViCqVnqp8oXdRkmP3zY1VGGSOt/9Jz3jG8hnUuize+N7kVsyQaf2e1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecvzZcOpGwJ3HWp+XS5Bdt7sJRZa4qNZcOf5pYCrF7o=;
 b=ep7txuhgXNOCWZs/6+ArU3vjRa8bFOeAnAmElIkijoI/lTab/izBg2TF3NFqty988EJpGZIJd1yBtSR0T5Gq02i0lsoqPZUwWPjFny33lYtGICz+rnO3FnNg7Wt1WWKfjQGdBNg07KD9YiIz4bXOIrR6meAXoH6TCUArHkNxizo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 19:33:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:33:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:33:25 -0400
Subject: [PATCH v6 1/5] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pme_msg-v6-1-56dad968ad3a@nxp.com>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
In-Reply-To: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713209628; l=1631;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AFhhy/CDUuf3GAzxVcI28t15j3n2X7gwgdDg1sEklSY=;
 b=MhKwiPE8w5aMx2pqfwDqzKzSVWpDcfvm1H8vKqlK7Xv66ZNJRBfbvlAgR/F/Rlzi5prUh0idz
 TJF5e8n6cAlC9OD4qINfi3nrQV2KXx1X97M4l8ast+YbmYSM6lij7An
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 47acada7-4568-42f3-6ab7-08dc5d82fd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w9C0TRi7Qd342fpTzdsUKQtCjs+4BEy84Msthg3a1nAafwm3Qdnu9bLUdhJVKD65m4gn8RScgE3Ji8Esk0wtt/Ho3ZLuOUDdjIbJ8pxPnpjJxt+3Qdwq/mf/GjneQw77bcgL4BVdEaBzC5dwrttWAh3DO7d9PPaL7r0k1PAAA2VsvKVfwpHZfVgXMG5u8ux4KkXRVioLndgj3wi+D+dzDNNqMhCr3jSVzbxe1FE9gvikdOa2vPan1FQBAaaBB7xEk01ojWdwnmF8hqRrqwtVUTZQaoZ4H2vDOsxRSQ9jlvIgHnPojQjx0P7TS0iq5sqdSbpW8+899h06JllwI+JNZgaSKT92gnF/9oqfI/SpRTkdWXYbwYMjFgJ9c879WNuEMOAjWy3EP+XS4/dUpy3TombMt7QkBx1rBtxMkoHBcMW2Xh/wipcQX0/32Rs9PIcm2kNBIHWOIMWpH/vRPm2Iyfc7JXB5RvZyog4vPC6DZafjVpxcdYBm+uV4yLtIsweIvkMIw2x0wu+UwoSdIOS3jcykIqODGH4Z+hOx5anQcvtOYUYsGMxFk3GXjcpqkMSWF7WNcfIYryVXCpbxlq0MQhEVapCPYlzzV6GhUFhSVVF3aGjnM7hIkk0nQn5KmYGQzDW5lQ+aVK6tmbqlYgPf+t6WNyMgXIQjUTz11dFRKfFbOzzp8MHMV0Am9x2lFST8KPxCcdM6VnqON5V+Or52YqSgOWfi78DSanf+KqYZ9os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlNDcEQwMUN2eXJ1Z29lcm03OGZMVVQ5SnFjOStOcFZNRHR1LzV2L1E4MDdX?=
 =?utf-8?B?QWpwR0QzUWg2U1hSNFlZdjhxbU1mbTVNWWlFNlkrWEFaQm9VQkk5c0NRdGR6?=
 =?utf-8?B?bXYrQ3pVQWp0YTJVclJwdll6bGVSUmRadnN6TXZCelRlZ0s0SVJNOFR1L1Qw?=
 =?utf-8?B?cElQM3k3UWRNcVFhN0t5cUFTZXduVjh4VXpSbTcwbVZhT0p0eXFwNEhzcDN3?=
 =?utf-8?B?cks4cmRJMHdta0xnOXVXbjVOSzhCQUN0ckREdFV0ZGxFSndqMFVxS042K0ZQ?=
 =?utf-8?B?bjdVdjhXdEV1WitwL1pvditYRGVBQjhNcXJnelk1eUFpSjZBYkpvdDFyanpk?=
 =?utf-8?B?Sy83RDNTaDYrNSswdk1ucENwQXZCUHZjMXpUTkJVMXNoaElQMjhOYWNJWEs1?=
 =?utf-8?B?UWllVU5HSFV0djJZTDJIL0Y5UUx2a1ovVUxqY0NhVkdYeVk2Y0xyb3BSVXJo?=
 =?utf-8?B?eDR4STN2TUsvTVowUEphVDlJeVFjdXZndzY1L2F0bjFjdXhhL3gyZXVLUjRh?=
 =?utf-8?B?UDJQV2FjMzZnd1Y4NERYVnQzd2NVdWxyR2xOaFhpZDA2aDlSdEZjajBuUjF0?=
 =?utf-8?B?Ui9STTlNSjBoUi9RSit2UmpjUUNkUmZMQlBMa0NBclhWQTZyL09NSzZ2bVRM?=
 =?utf-8?B?K3ZUSWZ0NWRyTUxYcWJrUng2enhPdm5GcVg5RkJQWi8vVm5FYzlobGk0bU5X?=
 =?utf-8?B?RmthcWhPSkxaZjVBTmJIaXp5VHhxMExLUjVqNFdFalN2R1hia0VMdk9xWGFy?=
 =?utf-8?B?U2JBYSs5dGhqOE9haVphQlJ6cFp1WlhMUDE0NlowSlZNRmhFTlFMQXBJZ1M2?=
 =?utf-8?B?eVJtaWdndjU5bTR4dllyWC92dGpicTdINlFKU3RMK2ZzOVZ1VGd1VEJhbW1F?=
 =?utf-8?B?Q3JaZkMwdXRNbmN0ODB0Zk4xc2hYVEFWZCt6cnIyS3EvRG5icDhpemtpZThQ?=
 =?utf-8?B?Z2ZNVnozMExzR241VUoxZk5xeGN4WmlBTkJzeGR0WkNMT3hsdWJ3b09zMDFV?=
 =?utf-8?B?MkhYa2VVTmtxNjRqN2YxTW04VGo0NFV6MXMvQlExNytPeHpjTmxxRVQ1cU9K?=
 =?utf-8?B?Mm4wMVNjQmFwanFlWUpkUHNNdWp1dU5hbHVQMWhBL0tHa0JaRmdWZ283dVgz?=
 =?utf-8?B?ajRycHRCczJTL2crRDZPTG9WU01MT1A5U1RnNVpSU2MySlBOQ3NUZ3VKc2pW?=
 =?utf-8?B?Sy9HdTM3SXl5cThRNU1FSThaTitXc0pOaE9mQUpqTjBBcWdnamRuK2RmVnhN?=
 =?utf-8?B?OFVVcDVIOWRsb2xpZVJ0dTBPTUlVOUtWTGdFVWIrNmtLOVVxdFlFdW0wYWhz?=
 =?utf-8?B?QmdMNDY2TkNjaG9MOWVTdFdXTENkcTl2QnF1Zm5jWEV6UDd6UHNYcHhlVmd5?=
 =?utf-8?B?S3ZzNm54UThwNGU2d3BtRXJhMDR0Rlg2cnVIa29TUksvc3M5OFVJNjhHTlRX?=
 =?utf-8?B?cHovVkt2dWxydXU1Z1RBSjYzSWd6N2szTW50bEorZk9LdlowZ09PN0NUdmYr?=
 =?utf-8?B?Rk5XTVRnYVN3UEI0MkU2U083U0dmSzB3dnc2NmVza3hOZkJxUE43eXQ0djJq?=
 =?utf-8?B?S0Z5MDlWWk82dnJVYy96SFowZ3pPcHEvK2lOekh1MklMTFVBK3dmRnZiOGpv?=
 =?utf-8?B?bHR4MFlsZjgrNHBwdjFIK2NpOUFZVGd6aDlQY2Vrdk9QcXV0eWNLUThDbVU2?=
 =?utf-8?B?RzNlZ1E2MFlsSzVlTXIvZDdCY1hMVFdaQzBwK2NHb0twS3dWN3BXbEpnTmYy?=
 =?utf-8?B?NFgveXAzU1dvdUJmSUk3Tm90YmpmN3Q2WHN4alZDbURNa2E1UDNDSGxyMlZ1?=
 =?utf-8?B?L2Z3bW1DRGIrZExYS0ZwVnNpTGxQYlJaT0RQaEJST0tRQWdwZFBNSGNZdTBR?=
 =?utf-8?B?TVIwdUIzK0hyLzJETUhpOUpKYTVUS3czVUNLRWdpYnA1VWh5UG54U0FscU5t?=
 =?utf-8?B?RGQ5YzVLZ2laVnBlbUhucWowdkhxbUw5VGE3S3hhNVhORkhLdkt6M05iQTdv?=
 =?utf-8?B?NFNybXFFNjNsSERJcTBqQ0hxdGpjbzhzaTRyR3JqTjQ5NjBTVkt2a1BKb05m?=
 =?utf-8?B?QU4xV2xJSE1LNmFSci9kNnY5dmFGakdxNXNxc1BveEFBMzg3K1V6L0RWdlFi?=
 =?utf-8?Q?GyJ4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47acada7-4568-42f3-6ab7-08dc5d82fd69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:33:55.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhEr+UuSwauny9eq6H2+zeC9nXH0x6yb/oSywKt9CLYM4T+gyhtOkNLj/GoUTjVKomOBCrdkT57yI4KRLRDxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is in the section 2.2.8, and the "INTx Mechanism
Messages" is in the section 2.2.8.1 on the PCI Express Base Specification,
Rev 6.1.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed18468474..19b4227a8a7e8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]) See: PCIe r6.0, sec 2.2.8 */
+#define PCIE_MSG_TYPE_R_RC	0
+#define PCIE_MSG_TYPE_R_ADDR	1
+#define PCIE_MSG_TYPE_R_ID	2
+#define PCIE_MSG_TYPE_R_BC	3
+#define PCIE_MSG_TYPE_R_LOCAL	4
+#define PCIE_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages See: PCIe r6.0, sec 2.2.8.1 */
+#define PCIE_MSG_CODE_ASSERT_INTA	0x20
+#define PCIE_MSG_CODE_ASSERT_INTB	0x21
+#define PCIE_MSG_CODE_ASSERT_INTC	0x22
+#define PCIE_MSG_CODE_ASSERT_INTD	0x23
+#define PCIE_MSG_CODE_DEASSERT_INTA	0x24
+#define PCIE_MSG_CODE_DEASSERT_INTB	0x25
+#define PCIE_MSG_CODE_DEASSERT_INTC	0x26
+#define PCIE_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


