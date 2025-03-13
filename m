Return-Path: <linux-pci+bounces-23660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC4A5FA43
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6ED18959B0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC626A0F3;
	Thu, 13 Mar 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YOBQjDUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746226A0DF;
	Thu, 13 Mar 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880369; cv=fail; b=cPAaeM5RS42CgojKd2F9E4HQ0L3yPlG1V1FmywfQk9FcEs3y2EgYrMnZQQ7HjcWELs5wORiCBmzivCXyjHmJjGirKZXmWg5lR4+ntoJv4gzS4Acf1gErL81ivSdq/km+KXiqXSYTyQbvBbIFFazKPUN2nxIm3LL6XnM9qho4o88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880369; c=relaxed/simple;
	bh=AqcDCqP6UFlZaHS0jNKu5fFmLQdamqvz43QCP/CWh/A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WfaV0D7z59c7sCJTZRz2xeh2TD0+af3Df8ubVU+YUnmm5rZL2tTujp80uwDNsu/pJ154eWyhUCK5wmDQMcLXBvmQj5rW+upq8da4jFnHwtHyekW9PJ/YlKzcq2yAlXVgABQ2HWDwkttsMq4sKgoKv2IjquMh8x+QBWBsac90b+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YOBQjDUY; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6EJlm70G2rE+r9LCgHd5OSpecmYNo+xipEB/TijQKKYr7WlR9DWccFq3ifV4IUK3vupNycQYFkSpieXAD8sx21He9s3N2afebGXs14llvvBcr8M2fms8yhs+VhKHU1Jo6knN1jmNVkxqX46b/nOGItH6BPNsCEWLXCBgG0LElXuyoeYuKR8JUfWJDi0QrIrucD3IiAyQXj5dk1G30SRfUrGGM0KTLl9nvQmNSaOc2gXdBlm+L2uaZpfFjWQ4/MEEgaTkUuzjVqr5XraK1/rBQrR89Cqa7Hx3zccp97Xpidwbk7WWNch+gJBjQoYdnGHZIjQTjL0GZRBt5ZvHUXnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFAKqG/OAiUEcauNBYo0XC6RY89asF13XTVlK2FKYW0=;
 b=ZzHfSZHR8yVDuha58DGVWkatkhxgaY1fWtGCmYjwVVOzootZJ2m4sAFvnFwi5wT/nYACD5Q7+66VVazqm21myZXoAPQbK+AHnh+BsyvaYkilxLJDA6jvx8j6PD4zjKhwP0w8K5BAguiIYADeiIHgsaWIvDeMrgNxIs/EA1S8T0slfeSOgK6r5DpEqZAGQKoUkxBMvSQfmRPGl6bh9XkdrrYIdQnUr4PB/FiSxqaWSA3H4nXxIy5NFTyRtuSWL3UvayTuoNrdFKBJHazKJbEOPxZhQ7HccQkGzAXbXhcPa/82YV8Tv7Hg3GV6/bEYxDwOkAmV7tPXVKidqMzfjJ1uFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFAKqG/OAiUEcauNBYo0XC6RY89asF13XTVlK2FKYW0=;
 b=YOBQjDUYkOe2dAAKHHi6jKS/LTWqTJ/YT2DnmKospwvRmyAaj91R14ZsPmKLWJ0UJ0tzOoDWbhoJixyAQwlQYfIqIdP29jwzVd6tr/qiHyzYkasS8KLtU75lxRnsz7twRqXRa6k8w04fpOn2DJIcrxRcNV1fsP54iefHJvi77s0vxqYA6yXwjd9LQt39m323yfjCwWpIcHNPoY5z5vX+OjCqu2p1NikOAsV1homW2kdWriRjac1bsmkLG2G9If0GrEHImSUcVmpp4fOvv0gYgLwU1SRtMUcj+fKh9kLFXtvvusq7Z6vjaOv/Ef5V3s5zQXGn1csB0E7Nyvv0CHkfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:44 -0400
Subject: [PATCH v11 08/11] PCI: dwc: ep: Ensure proper iteration over
 outbound map windows
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-8-01d2313502ab@nxp.com>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
In-Reply-To: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=1478;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AqcDCqP6UFlZaHS0jNKu5fFmLQdamqvz43QCP/CWh/A=;
 b=V196LLvts0CZlPIzM4HbePyv0rXYwas/XT/yu0lERN46Zz45SEk6HMK2mg3OTNmV0XHzSsNzC
 zNvwIz1WAXgCm4aLRLd15Z0AeAAJFx75tQTBHMXq6YOSFS16vMmVtm6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd2fae1-16c9-42d7-bd6e-08dd62453be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU1vclZsclJ6UTlhR2I1eVA3L2dXZUl3SFB1bHZoSUdJYXRmNXo2cmRzaGdn?=
 =?utf-8?B?WjZFMDhqU2czMHNqSDlHdWJyOFJSSFVuZW9BR2xZTmtNK2dwdVI5aW9sQTNa?=
 =?utf-8?B?Qk41NDNEcWRMci96dDVzcG1VNnRTN0NWYlpHejN6TForV21KRDJDbXIzRlJ1?=
 =?utf-8?B?a051MXpMSDIxMFRQMWhOb0lwaUJaUWJIZVg5ak9Qd3Z0N0VwSmFhTnZ3OXhy?=
 =?utf-8?B?eTZmTy9XbDdkY0IyY0NoUVkrYkcwWVRENHhXRVNmZ1Z4eVV1bmQ5R2RWcjVv?=
 =?utf-8?B?VUxsL3V3MEFrOFlZWDVvdDEvRGhkZDFUM1hBMG1yYWJPVDVzcG5YZ3Z1aXJS?=
 =?utf-8?B?V3ZDRWpJNkNlRGdnTUJlMFJzcllJUi9VVGcrNHhFbGVpT1ovTE5SeEsyUnRD?=
 =?utf-8?B?MFZTZXBpeHdYS00rcVVIVWhMTzFqMlNPZzduUTNRa1BZOTZabzFGc21jZkR2?=
 =?utf-8?B?eXVmc0J6dlZWVGxtVFN3QndDVXNQVEZ6YXdQWE9lc1dkR2RNMElxbUV6YnZT?=
 =?utf-8?B?aWpjTStqYUtnMGJpMUllWEJ3M1UzbStvV1d5c0w5dlQ3U2hDWDIrTURsVDZQ?=
 =?utf-8?B?dDR4bFlsQzl0Nlc3UEhMR0RjeVY1a2pVeXNLd2JtTGJFMXN5NlJmNGNPTE45?=
 =?utf-8?B?RkFJSyszTjRHUjRwajVXbklseVVVZmx1LzBhcjRjY00wamFuYkNKV1VPbUlQ?=
 =?utf-8?B?WkozTGh3cG1melFQeTlQQjdla216eE9jK0JsSS9HaE9rVENBbXBJVGJ5S1Qx?=
 =?utf-8?B?YnNJQlg0TmVDQlQ2cW1KNWVwZGVNcVJvZmNaMFVrcDJLTVpRam9ZOEl2ZXRw?=
 =?utf-8?B?L3RPdVZIUy9RUmczZTU5cndPRGgvVmo4ZGVDU0cyNmNFT0tHVU03WXlralAx?=
 =?utf-8?B?RzRPVzE0QW1IbUthRGh1U0p1Y3FnMDFCZmFrY0dYTThMRWdIbWlraVNOVS8y?=
 =?utf-8?B?MmhoT3pMWU9YY3RZK0dEaHVsTDBSTm5ORHd4RTYvRU9sYkFUd29rMS9vak9v?=
 =?utf-8?B?Nzd6NmJsZnhMUUlnY2k5VjMwK3R3ZXcwcGgwbU9Mc01OUTdWbnNNTEx3SHNS?=
 =?utf-8?B?U2ZDVVZuckJ1MzY2SC9NNHRmdE9aWHF1QnlqSWRQRTZJblEwa0YzRFJ4NVNj?=
 =?utf-8?B?M2wrZDhZTCtEbTRFcmRiR2hoYUJLc1dwaUt0NnpKOGphREtoOGEweFp4VDQ2?=
 =?utf-8?B?NWZIRWdPOExBanJ3T3lqcGJmaXRuUnBvaEk1U3E0VnVtZWx2RlppOUJOMzZP?=
 =?utf-8?B?TEZPOERUY0IzaDlvZXdvbFp4MTNvVmFjYnBaWG5UeG56K3BKTG14QTZLZHh1?=
 =?utf-8?B?SFVIZjJ5Q2s0UU1vUDM1V1EwclFnMHFTMS9lRkh1SHZJMnFqdkpjZ1ZkS0or?=
 =?utf-8?B?aGdxaUx5Q2FrMXJYV1ZjQzV2SEZZOFNxbmZ0aWhtOWtJNTJWcVBSdmp6ZXdI?=
 =?utf-8?B?bUY4amtiUCtGUW53MFp2UGl6SlRHSEFVNHRDNmc0K09pN3FGM0pibkVzYUIz?=
 =?utf-8?B?TUZPNW1MQWlQR1dFZ0cxeVl2NmIyaDFDNUo3RW9jbkdYSFZCc0lDNlkxNU0v?=
 =?utf-8?B?QWpZWDRFeksrSy9tc0tuejNPOVRseE9PL0VGVElrMkg5d2JhcW5YZWNkekdK?=
 =?utf-8?B?QUZCYjVoV3d3N2k0ZUtTT0w3UU5QNDlLVGRBQ2xOeDhwYUdqWUJ2QzFsdnEw?=
 =?utf-8?B?ZmJDWnJqVUxITWVJNzZMTEc5eHpSZ3JkcU4ydVgwdUJMcUg4S1dMTWpUalZ5?=
 =?utf-8?B?L1c1K3Z3MWRuUGlEcWRNV3JKbUVyakhPSUpabE5qSm1NS0R1akwrOWUxcDds?=
 =?utf-8?B?VkYrakFISTZBdVJDNFQxN2I5MmN5Z3ZQeDl1Y2EyWDZ2NGdDS2ZLZi9NMENk?=
 =?utf-8?B?S2w3anN0L1o4ZmJDQWRBbkFuR3B3dGsybDJQbGdPSHpJQjhRZVJCcnRESndv?=
 =?utf-8?Q?OpzI9ZI4VXvnkat5pIM7M+LsXSrYtAtZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUplT3YzSHJKQWdRN2x6Nkljc0h4MWhmaVo2ekxxSURGczNCa3VkTGQwVW9R?=
 =?utf-8?B?RDR2MkJzVzdiR0dQOFlGU0VXcDU0UWhWTTJTckFBZ2NzUEx6TmYyYVI0Ynls?=
 =?utf-8?B?TlhXeXJvbkJzWFZoaUpOek5vQk1VZ2JYMGM3L2szc3dXMlNJeFY3YzFFUzE3?=
 =?utf-8?B?TlZvdGNTVURGaG9pa3F4bitFcFlhWEVUTWxJQkpOVi9mbGhLcGdIVzVpSFBG?=
 =?utf-8?B?UloxckgydnY5bUFycHViMENvTWxMcHA0ZUkyRisraGxJbnNBWUV2ZzlGeDhT?=
 =?utf-8?B?ZlFOZC82NVFtNTlWMEw5MlZUeGRyaEZrSVhvZWdiL1ZySXNTcm9PTk5mc3dF?=
 =?utf-8?B?eEg4Vkd4aDZ4anQ3UnMweDc0aEgrbGcxK0ZlaldrVnF5dVFMMVovblRVWDJK?=
 =?utf-8?B?UThRRGdnWEhHVTRmdzNNM2lSUmI5SkF1am9Fam5xc01Hclc3dURuQmkwQWM3?=
 =?utf-8?B?WG5sS0t2UVZFbjYwRlgvcXdSWjhNUXYwbFJFSzV0LzRSZEEycWVqc05Ja0Mz?=
 =?utf-8?B?ZmdPcFROTkpYb2NjUENlYWFueHg0L2RqZm93OFZTVm5vY2ZZSjlOZWxJM3pl?=
 =?utf-8?B?RlVNZGozZDk1d2UzWVplWEV5L1d4dDVTSW51eEJxdE5KdUVCV1I5SjM1a1dG?=
 =?utf-8?B?eHhzUkJ2SFdKQzlONERBbnhacTNqYUZxL1RVTHlCSzZ1UDA3T2FwOEJCSGl1?=
 =?utf-8?B?NjN1ZEhVWWVMTzlFLzdzV1dZOVhITHdtRDJaVEpRQWxJK1I0dzZURkEvS1Ju?=
 =?utf-8?B?aDVsVDRqVWwwNVZwY3hCcjlxQ2xpNEVzYm9DUFhMaGVoQVJxMVRCd29ZUzJz?=
 =?utf-8?B?RnBkRTIzcG1PaEtacnlKNXAzWW51Tnc1T1o1T29NUjh1OWs3aERGNE9nM3BD?=
 =?utf-8?B?cER0QjFmbEhReWo5L2ZkcjF6b3V2TEVRa0R4VUJUZVdVR0U4NjdkMytSOC9N?=
 =?utf-8?B?TXI0eDhyQW4wMUkwMTYxRm5sWnBBdG9ydFJmaHdaMXRmdEk1K3RGQ3M2UjAy?=
 =?utf-8?B?Y0tZUmpGSzNSeVNWOHU1bEFrU2VsTVYwMGpSY2VwdUQva1FuOUFWNWxKMXRk?=
 =?utf-8?B?SDNFMHdNTHpid3NybWMzNUxteUd3OEUxNmc3cFEyN210eldyN3BRRnNpQ3pn?=
 =?utf-8?B?Q09TSUdicE1GZmFYQkdzZ2hWTGhOSUUybFZDaXp1V1RyeWd3YTh6ODhNcnVr?=
 =?utf-8?B?S242ZVRJNXNxNS9SVW82VHFrRzJLZkFMWXlRN2cwY1RCcnNIeW5pVjlLOUFs?=
 =?utf-8?B?Nk5tU1lCM2xDMnNoYnZrR2kwZ1ZQNkVEWG9Ed09xb1dCM2gzRlNDeUYrOFNB?=
 =?utf-8?B?Z01tc0czZktUYWJJcHdVaFFxMnBJQmJlem1Lbm9uRy94WDlDS0lSMDI4U3lC?=
 =?utf-8?B?cDB3N1N2TGszb2N3OGJlaGFXc0pYNlNldVhjVlFQZEowYzRXU21xdjJ6NE9z?=
 =?utf-8?B?ek1nS0FCemt6b0NacCt5ZUw3U1pNUjFZYWdmY3RlUVJMcHBaY2dFZ2xxd00z?=
 =?utf-8?B?dlpQVGs5dkxvN2R3WGlCNmNOVkY3ZmVBYU8rc0RZa2FDRmNBWUliTUhqVERu?=
 =?utf-8?B?U3llemo0WGZrQlRsSURlVy85cGNnSGVtYjJzdHo1S1hiM28rZ1lQNGNRV3Zq?=
 =?utf-8?B?b0F6L09nQStsTGRZTzBsbnQrT09ZeFRidGVVMXNYNGh1MnZFenhqRjM1Q2kz?=
 =?utf-8?B?T1ZieWszVFBqVFBKM0ZUVktxN1QrZTNCNXpKTlhCRXY2Q2hvSDczUklSNWJG?=
 =?utf-8?B?aXRBMzMyaENHM0JPOE9NcVkzd2xJRUhGdDErZUl6d3RoRThWQTB5S092UzI4?=
 =?utf-8?B?bkk5dmRjRzhmaUZxeHdtWGYveGlrMURLdkJzQXBZYjNZTGRnQXYyRm1PVFpz?=
 =?utf-8?B?Wk5ZZ0R2Zkl4Rk1pdzJGTXZvM1JUbmQ4MVE4blhJbVE0dVpGTngvejJjTUdC?=
 =?utf-8?B?Ui9yaDdQVUNOVDZNMjlkL0FibDBGRXU3c1ZJa0NFWm5ONnpZdUo0MUFqWWN2?=
 =?utf-8?B?RGpEakVEUlBIdkh1Zm1UT0NGUWpESGdmVGkxa3Z5T2Z3ZWxBWUFJcW1jTmVB?=
 =?utf-8?B?b0xlUWFCWUpmMndhVGpDMkZmMlIyLy8zd2JXa3draHE0S2RDcjMyVTQyWGVo?=
 =?utf-8?Q?SYCaLguVNw+V54ZXPmHO2+m9C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd2fae1-16c9-42d7-bd6e-08dd62453be2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:25.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSl68L5glxPttXgbNn9taZKfRMWZ61f+ucOMMHX0TcqskjjcuUO7LmMFxW0kQwLlRBFKcOfU9IafTSA0lJQ3nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

Most systems' PCIe outbound map windows have non-zero physical addresses,
but the possibility of encountering zero increased after following commit
("PCI: dwc: Use parent_bus_offset").

'ep->outbound_addr[n]', representing 'parent_bus_address', might be 0 on
some hardware, which trims high address bits through bus fabric before
sending to the PCIe controller.

Replace the iteration logic with 'for_each_set_bit()' to ensure only
allocated map windows are iterated when determining the ATU index from a
given address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- change refer commit

change from v9 to v10
- remove commit hash value

change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d69d76c150d92..4ecddab131b33 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -282,7 +282,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;

-- 
2.34.1


