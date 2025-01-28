Return-Path: <linux-pci+bounces-20507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2873A213EB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 23:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835E318812DC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44C81F37DB;
	Tue, 28 Jan 2025 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HcHUwzww"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFE1F2391;
	Tue, 28 Jan 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102123; cv=fail; b=sW919GOcr7YXJwxs3LFRK6XxMRsD8bMJo9Pqc6PUAbA1SDpHFbvf2zzcIerHhzTcXfc4jDobsoWqd5sjgyOZDVqX0DnSCNohM8FbjzwRloHdqAZK0auJkbOYSJMUlTjqi95VAW0K6EiNLp2hgy40lvVKdPM1I4lEdyXPyXuIsR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102123; c=relaxed/simple;
	bh=xDd9TefF0lK4uHkh/J6G2tkWLfne0/VQDc21sWcAiYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uWCvTzmn/0aYp+5D5pEtKjTBPK5wkFphrsL9DZnfRlZJnGSUjTfZFJIrdyVnoCrNH6poK94Cv4vvGqWCtm7VLV6FBWbh6mxJVPo+YOS6XkI0FHhUSZpVINsMQIWySICxJhucDslLcKXpExRssDHhBpOFkLMPKyfda27jjAbfGas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HcHUwzww; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NliEYE8On6GVsrvdhj0BnnmX6pXumHqk5ABYUDeTBvOgup+pMfcX1/vxyvMpNTY+TlDiYh/PTF4/9azrcEobCkO4GY5CxPTQDdcTuKULn66GCoA+/0G429J//Ig2w0GvJ5J4u/6H/3UhcI/+JVRtJ5XUfThchrJWRADoQZbpHzsP08Mt/uThVkPtxgWqg0khDAT8lTlbVKNXAq9CXhq4VX2CZwCWlJtI0FiMfiR0C4HcG6fP5KH6jbtyqe9nFHB4EvcfpLWwjAWzV632B2jSScbAWLSedPPdVElanTkXbwcDDza6577yB3PgEzSycSGhZMvHGse462v3Sd8rtPqmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TzfpaF1gM/sUK/g+VlPeyqOC46cDtlQN6XZqFyFtYM=;
 b=ePCmgbRcJOQgY9ynGWiwHwRLcDHSzh4GlQPdfMamr/LHa4aLdcZb+S9fqCINEC6eqi/ONikf9SNRCgXC8uBynWBL6yIWDyJ9zSoRTQixiRQ64Q/IWhC0kc7yLmKsBCCHlKAjR/ALSmYvbiAYFyPwoIPjCAbbYxSgUF5huW1eJt2fqy2uls1W9xgAyEQJZak8Mm/j9I2KjwWBcWSOdvo39HTKQ6BLbsQpdRB2KjAtb2im4rE2GDJyLoN0Xg8s0Zdb2wij1Pgxj9KmJklV+6ITe7CFYEbyIAqx+4w2s7we0Iwh/cWhuapDzGZUjBFIdLyNbv0IIOQpnpDmnvBrTmHNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TzfpaF1gM/sUK/g+VlPeyqOC46cDtlQN6XZqFyFtYM=;
 b=HcHUwzwwm8BicdEIXy6FNFdF3aNUDzUEcE3/nB1md/c9OftdYI5+1F1j/exO2dE+6usDR8PqrgsNnrUE7w82n2qtAH8KRB5uUbHtZU/QWT6nXRKxPDr7nNYFWSEe3gWeAQWfZNQ5beyLUJr/XEFlvX1kTTcByIolHZW/vpNlC1MxcqWaQpdkvRBWFbOU03xOsm0nLLWPkCnq1ddazYwfMC4JyF44ixg/iS631kLImk2YK0Zh/GwGQXAH6hyDMTrtcIthBJ5r18KEs0KkFJwOdgQ278xAyN6pXTTek067gDcU/7SC9GbY+W9hS192eeNCJUAJmZ8aWrdH2a/oqlLVYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 28 Jan
 2025 22:08:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:08:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jan 2025 17:07:36 -0500
Subject: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
In-Reply-To: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738102099; l=4272;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xDd9TefF0lK4uHkh/J6G2tkWLfne0/VQDc21sWcAiYg=;
 b=x6rEXtYPQr2iyX+EHkUdtEriWbrtkBn6bQMQThrD1Y4xW/dZS2Jo1ZjuzUQBJYyUrZ/falMcS
 UUK34NX510PCcJDKfZD4xhQ8E6gehk6Hg2FtuetDDt8mvBLoKNvvlxx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 3177cf8b-9858-425c-1b1a-08dd3fe8517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhOWFRnS28wUkFUWXVOUjdkbzFCTTdDckp2Rm1OQm5CY0kweG5zT2xwbktQ?=
 =?utf-8?B?TzJXem1kT3g0YUxvUXlobnc5b25HbUI5SUV0K0xOa1R6WjZlNmlLY2dWMUlj?=
 =?utf-8?B?ZG1NUms4YlVHaGVTbmtSTm1XZDFiSmtOOVkwZ3V3NVJsTldQQ1JwcFhuY3dG?=
 =?utf-8?B?S3c1a0dhU1lpdU9jQU01RTlEcm50a0daVFJqMVF1ZFdZZGRLbmJrdExLNmxm?=
 =?utf-8?B?d0RENnNYeVF6ZUJaMDR1K200TzVPV1RubE1Eek9XSG01ZlNBU3hEUkV0T29H?=
 =?utf-8?B?Szdja3gzMTZINWFvNHQyaHNib1JDWGhSQXpsOWJKWDR3dnkvSnVUYUI2K0No?=
 =?utf-8?B?YWZoSFBVdVJuQ3dxRWVzK0MrNm44S0xZd09WQTE5ZmU2YVhtZlVwaXp0VnFH?=
 =?utf-8?B?emlWS2p3ZXRaZ0pLM3cvNVlneEpqUjR1S3lUdjg5TlpwRUVmNFJ6RzRMYllN?=
 =?utf-8?B?UFJhZDhVV2N4c3VrNlRQaWpmcWlLNWhUem0vNjJ5cGZXNEVyQTR0VVFFSHJM?=
 =?utf-8?B?ZThVaTBkdHlXdGF0SzlSaG9ONURtaGN5Y2lZcUlXazJVU3JMMUJTVDFIWW1v?=
 =?utf-8?B?Q2pwMHBwSlliSzNlQmlROGVVVE1LMVBIVzlrekpBdTduRnZ0cG0wTGhBY3Zr?=
 =?utf-8?B?dHROeE40QzZmd09MdWNpYnJJb051UFZtOG5KUXpITXZmTVpCTXdkK3pYeWFh?=
 =?utf-8?B?L0FKTWduN0hlTzJwZkduZTJXTU9zQjVoempnQ3JlUTN4TnRhVE9pWkJGVkYz?=
 =?utf-8?B?a2dSQjhRS0p0SlAvN1lkZXdoN2lRV2hEWnFrV2l2THgyOVRVd3lCY3J1ZU52?=
 =?utf-8?B?NmdPTUR1YWNhMTlYNmN0aEdXUnhFOGhnKzdUMW0xOTlMbnRxK1RJdHlnTWEr?=
 =?utf-8?B?eitLMVZCUUtaV0ZVd1ZUSlRDYmEvTjlpb2kwSXZFMmVEdDczS1phMWQ1Z1ln?=
 =?utf-8?B?ZEJUcUFmYnFtWWdvZWlKdkYwclN1ZUllZi84TVhHUWcwV1FKOGs1NzFYMEtn?=
 =?utf-8?B?by9ieG5zL1ZlaTRIUEVLME8zdTBCSWJ5NTlNem0yL1JZZ3puYitsbFJXMXB4?=
 =?utf-8?B?VDJxNmpNUkFFd1UrOXdYMGlxMXVxaXhLNDVFMGFESGxZNmljVGdadkVxU3BJ?=
 =?utf-8?B?UnV1TDdWQnY3QWpNU05sUVZrUnFZWTZkZHlrV0ExY0ZsdmRJSzBHT0FhUDlS?=
 =?utf-8?B?SGVwc01rVFA1TktidWE2SkNoVDJ0a1lDZVFiMUlQNmg5QUdFaHBCME9waS9Y?=
 =?utf-8?B?eG5vWVBkYVNPWG93WkJRWDJ4aWRYRFU1cUI0YlFFQWkyUUxMci9LN2RMN0Fq?=
 =?utf-8?B?L0g0TThIQk5GQmU0L3B6ckdKQ1I2QTQrb3ZiVVJFdzBsYk5VQXgwd1F2OEo0?=
 =?utf-8?B?clpMOTA2MXM2aW5MNy9HYkdwb3llRGhMeDZNYTlJMmJYelZ3MEhIZkJCcDlk?=
 =?utf-8?B?dFlOVlRNMXVYT2RJQUY1R2gvdTg3V0lIUGhUaFUrUmdsOTFqQ25OeDVmbmNj?=
 =?utf-8?B?RXdqUHRIZVpWSTF0SGtBcEptREdDUjcwRHVydDhoeUdaNGRMM0FGVnhoZWhx?=
 =?utf-8?B?cG9RZUlTK05VbmFicWZ4NmUyNGE4QXE4bTFlbjVHditKTy9CUjJPTVdoRkUy?=
 =?utf-8?B?dW42YloyckVBeGx6QjcvL1lqS3JuaW56eGxjMmxhQVpUbkFTNzV3VVZDRHBS?=
 =?utf-8?B?NWFVb2ZHcVFEVzNaMHZKZUk2ZFoxUndxcW0vZEowaHdNWGNVRnJCaGFJeTFh?=
 =?utf-8?B?ZzZjRDVkb2c0VFRSZ3FGYlV2Y3Zjb3NzSTRXNk43cUFtcHBXOUtCaGJTZEIz?=
 =?utf-8?B?eWZUSStnYnI4QTF2dnBEcnhiU3lpMGQyZThFSUpsaEFCLzRUdWpDSDNoQncy?=
 =?utf-8?B?NzUwTnZlUS8zcGw0RDNFUEhRdzJQSnE3MnBZK3FRbmgyNVlQUm1TczNNRUl5?=
 =?utf-8?B?YUpxYjZONmluWVVnVnZRbU5TeU9jTEZIYTdtazlEd0ZGbnR6TW15SkdKaGdy?=
 =?utf-8?B?NnRhaENJTHVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2xNVk5vOFE1N1dNVGhyNjhLUFBvUU5OK0pOMUp6eFliS3Y0Qkhua2lwTXgr?=
 =?utf-8?B?WThUMm43VFlDampYb1lsMjRWWDh4bjc0bmJBYVExNDJQQXgxT1FQb0E2QWRE?=
 =?utf-8?B?cXpjREJpeEh0MW80ZWZtMXdmKzZVZk40dUR6Zi95b2dLdXEwYUd3eXFqbzdF?=
 =?utf-8?B?VmVZbUhnTDlIZXo3YXlSa3Q1RGxndll5WFd4MU8yM1lnQXdpM3NTZHREVXo5?=
 =?utf-8?B?YmNNUzBPNHJvZVh3L2d0SFF3dG1FZEFqa1R6OW95eHpPM0RRenFYWTJ2REg5?=
 =?utf-8?B?ZkRlc3lHZGtuNTdYR1RZbFhZVUx6cGgxSlRUd1A2N1MyN1ZOditocFBzczJO?=
 =?utf-8?B?QkhOeFhwN3JOTFRlYTRmOVUraVhaUTB6ZGNQWE1XbmFJbXNrMGwxNURFVnZN?=
 =?utf-8?B?VTFzL2lobENTZlpYOWJuS3JVcGlGdnRxSnRpNEFDWThzUndibnoxWU5ZczBt?=
 =?utf-8?B?dFp5WDlEZmk0RUdEMEg5TjFSQzJUNHU2RGJ6b0NNcitWS3pmWUx0cHZVdC9o?=
 =?utf-8?B?T3lGWFdsU0h0MEE1c2RyZW8velh3NW9JcGcra2hpRlIyR2RLUnZybkxRT3p3?=
 =?utf-8?B?aGhsc2QvRDlQRGRYR2NBN3lLZ0wrdGFIbWp2NDhScy90THJBR2FIQ25WbUpN?=
 =?utf-8?B?KzhnL3V4N2RDNWlJNnZWRlNVajRaZnBUWEhuNW1CdmlqN0tid0plWVVXbk5D?=
 =?utf-8?B?YjQxVW53SFY4bWhQTnUrRktoYU91TDhkUWRuMGhzWm9JSnN2N1JPbytZS2N5?=
 =?utf-8?B?WjVOeFRqQUFoT2FRaWJRazNMVDdBdDZ5TVZKSUdmR1VaakpTWkRlQ093aHBx?=
 =?utf-8?B?eGpaUXBWclFreENrUGJ1YUxYK3FlUS92OC9MdFFCU251VloxSm92QnB5d3Zi?=
 =?utf-8?B?NEtwNVpadEswaDkvZEdMQUdNeURSRmhsSms0WHJ2d1RzVzlkWjJGVE9IWldy?=
 =?utf-8?B?WGZXK2w4OHRhTW8xcElDRlJKZmY3NHVOcGtRL3lha1k0SUZEbEZYekNiMXdM?=
 =?utf-8?B?aGVVenpUWnNkZlFhbnVuaFMwMjdXNGhIM1Q5dVNsMkZLcFNEVDlhVmlKWWhu?=
 =?utf-8?B?VE4wY0d6aXdZbk5KUmZmaER4UTR5d25lRmZROE50ZU80YlZOK1NnT2lUUlYv?=
 =?utf-8?B?OE9oM1QxUHlBNFFVM2xQbzd0WkFUcWdiNGRyT3FNbWZ3dVZUZ3AzZ3BDL1BS?=
 =?utf-8?B?czEzb292Y2JKSVF4ZkpCT1dscVNtZXBzeWFSWTVOb0pPNDY5VEc4bnR1cENo?=
 =?utf-8?B?aE9PV2ZER1R6azZGOTdNUTYvNm55OXFHOFF4amdUdEVSdVlEa1dPanY0R2tR?=
 =?utf-8?B?cERHa1BEQ2g3Y2xrSEZIR2RjbWFYcHpCaS9DcFpEV0JiMFdia1ZwOWRWV3Qx?=
 =?utf-8?B?MnIrYVpEMEQ4NDREbkxUdWVWTkJRRit2enp6dWFodXNaZ3pEY3VGa2dOUzc3?=
 =?utf-8?B?dG9PTU54a3NiT25mYnRuV01weVRNemJFUVQrTVg4U0x4c09JeDdZTGJCWHJz?=
 =?utf-8?B?d092NGRoY3hQNmJVNWE5VFFnb28waE5DM0ZRUHlBT3NSV3FDNzJYQmFMZXZT?=
 =?utf-8?B?QUdmNEtMSmd5MkNjbzZGK1d4bW9XNVBVWXR0a0hNajgzNFhhdk1Lc3lQMVlP?=
 =?utf-8?B?aVc3ai9GaWJmV242cXYxcjh0akRjZi9rd1k4NDFJb21FTEVhU24xWTBSSmQ2?=
 =?utf-8?B?SVVLUVhXMGRsL25vYWk4anlITi85cittdWlod3JWQWd1MU9DRys4TFhjSi9V?=
 =?utf-8?B?Q0taUkRjVzdiZGpGZzA1K2FxQnhYMXNYL2ticU1UVWhTeXlFNVEyZ0RvM1RI?=
 =?utf-8?B?Z09FZ3ZKVlFIR1B0NnoreStTZ1dGNndVNThJMFMyNE50Rkk0UXdUYjJXUmhE?=
 =?utf-8?B?WTFyQys3UkRPeURjdU82enA2NjhqNWdNZnA2ajFzc1FUWW5jN1k4cnE0eWxU?=
 =?utf-8?B?MVFwK3VhOGM5Z0cxMHRvLytTYU5vWHFxdmtFbzFzNXF4RGhkYWl4N3Jxd21I?=
 =?utf-8?B?N2V3VmVDeU84NktocWROMG8xRTRJK0ZEWnhRbmlnOEdrWThackgzcXRMdlI5?=
 =?utf-8?B?bytiaDJZTENmYXE1azZjK0N3ZzZGYkhrd0p1RVU5NGo1OSs2OWw5dUMzb0ZG?=
 =?utf-8?Q?9SBaqLcoOxZ3vYv9QpjKW+dUr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3177cf8b-9858-425c-1b1a-08dd3fe8517a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:08:38.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6ieKBKCWDgoQWQBsqpf4tEVJrYjdEYfn2xU+pNHh72ShLb0fww8FlFSJGkfUcXXSxE6jlV48/4vU9fxC1DvXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

Introduce `parent_bus_offset` in `resource_entry` and a new API,
`pci_add_resource_parent_bus_offset()`, to provide necessary information
for PCI controllers with address translation units.

Typical PCI data flow involves:
  CPU (CPU address) -> Bus Fabric (Intermediate address) ->
  PCI Controller (PCI bus address) -> PCI Bus.

While most bus fabrics preserve address consistency, some modify addresses
to intermediate values. The `parent_bus_offset` enables PCI controllers to
translate these intermediate addresses correctly to PCI bus addresses.

Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
PCI controller drivers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- new patch
---
 drivers/pci/bus.c            | 11 +++++++++--
 drivers/pci/of.c             | 12 +++++++++++-
 include/linux/pci.h          |  2 ++
 include/linux/resource_ext.h |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 98910bc0fcc4e..52e88c391e256 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -31,8 +31,8 @@ struct pci_bus_resource {
 	struct resource		*res;
 };
 
-void pci_add_resource_offset(struct list_head *resources, struct resource *res,
-			     resource_size_t offset)
+void pci_add_resource_parent_bus_offset(struct list_head *resources, struct resource *res,
+					resource_size_t offset, resource_size_t parent_bus_offset)
 {
 	struct resource_entry *entry;
 
@@ -43,8 +43,15 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 	}
 
 	entry->offset = offset;
+	entry->parent_bus_offset = parent_bus_offset;
 	resource_list_add_tail(entry, resources);
 }
+
+void pci_add_resource_offset(struct list_head *resources, struct resource *res,
+			     resource_size_t offset)
+{
+	pci_add_resource_parent_bus_offset(resources, res, offset, 0);
+}
 EXPORT_SYMBOL(pci_add_resource_offset);
 
 void pci_add_resource(struct list_head *resources, struct resource *res)
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d201..aa4a2e266c55e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			res->flags &= ~IORESOURCE_MEM_64;
 		}
 
-		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
+		/*
+		 * IORESOURCE_IO res->start is io space start address.
+		 * IORESOURCE_MEM res->start is cpu start address, which is the
+		 * same as range.cpu_addr.
+		 *
+		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
+		 * IO and MEM's parent_bus_offset always offset to cpu address.
+		 */
+
+		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
+						   range.cpu_addr - range.parent_bus_addr);
 	}
 
 	/* Check for dma-ranges property */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa5..0d7e67b47be47 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1510,6 +1510,8 @@ static inline void pci_release_config_region(struct pci_dev *pdev,
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
+void pci_add_resource_parent_bus_offset(struct list_head *resources, struct resource *res,
+					resource_size_t offset, resource_size_t parent_bus_offset);
 void pci_free_resource_list(struct list_head *resources);
 void pci_bus_add_resource(struct pci_bus *bus, struct resource *res);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
index ff0339df56afc..b6ec6cc318203 100644
--- a/include/linux/resource_ext.h
+++ b/include/linux/resource_ext.h
@@ -24,6 +24,7 @@ struct resource_entry {
 	struct list_head	node;
 	struct resource		*res;	/* In master (CPU) address space */
 	resource_size_t		offset;	/* Translation offset for bridge */
+	resource_size_t		parent_bus_offset; /* Parent bus address offset for bridge */
 	struct resource		__res;	/* Default storage for res */
 };
 

-- 
2.34.1


