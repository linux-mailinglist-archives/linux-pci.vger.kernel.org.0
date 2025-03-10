Return-Path: <linux-pci+bounces-23371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD534A5A4B9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EF53A5A1B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C21E47A5;
	Mon, 10 Mar 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQonARVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A521E3DE4;
	Mon, 10 Mar 2025 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637882; cv=fail; b=tqOTiZq1jNWa98aK+90/YRHbrewpVDzrxC+S7RJdqJbMp+3gLPWH8y+13WCDz40S3BVfhaY24/L1LPGY4SbPY3cE+KGV3uls24lfUZCGLic3F7+6Huzah64VFuEeNm9UyH4XdItGyF4yp4LJkDfl+/x/w6R0/IVPw0dGxeqAzCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637882; c=relaxed/simple;
	bh=+3MidV7XoojBAWFebcj1RI1TKBDTvuas/ORdvq98PK0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZK1G94aDSTY63XtIHPV7xiwwAYXWQctr9sREXvFuzXvT+56AoETtlVopMCz8VqDXC5ubf+OH1kpLO2siKt0Hykt9IxfA3lc23JFjxV99HdLpiXY7Haw+5tUlX5cRZpFml7hUydz7OiStXje7L8Ac7ixhK06Jvr70/9gkqMqva0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQonARVc; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOTtTd0nU3r9m2cnn4UamJAzXZTckMkP1bKFjuGKOvultd6+/uLDG+fWI2YjSTDAwfb9lbGwYT/30N73l8h/a/sZXQlQf/UvTxc+zA5pHkd293s6RFocEGcxlcUcoYBD15wR8uWn5PjKIQnXJ9kHFZ9vd+ImJ2UZhkUq8CehglInJw0cVwjx4SRWPBzmL77i07hT677cXAHYJTSxGgXx1FShEx0DByRb/mPAAxzwv5kH11cmDGfoKtlkFhKi7FnRnmCftzGhxvfotHlnbCJH+s0TTJzd0iS34b+OH3WIwYeF/V93yNfUf3vkj/U68gZM3POaIuF7OAtyPYtq/xtyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9m8NiOYA2VGSMRubWfPC/5dxLj+RPScFITjZUVIVjk=;
 b=bRResrOTKWXSNAkK5J9HIL1lX8MeBkwxsauVo4bktPCZ4BO/CV3569oCHdCPZ70A7iN3zrjMn8XNuof/7++MkinJVQdMvzWCkA3Cm2V1/LCi6auDrw+KUk6SaKO9PZhkloTqkDTtOcoemn//jPwwfa4ETs0166Dvr8kfR7q1hypAKrQAIuWipVTNHVyFf9ZlKqJgw/HbFELv9VS2lTGiobRgAL1odwbVjYt7rrCjTgqBwrmUGajIGyF4dnj7ZPeD0NSN5A+7osT8UfLvLpiTpHIv4KSWHFebYLXLnpEVJimR4baqnvZ7UKVzSLRrmHflSuuwedB0SCtXuUPcNAhcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9m8NiOYA2VGSMRubWfPC/5dxLj+RPScFITjZUVIVjk=;
 b=iQonARVci6IRUQOpwmVACT2IsfHhGA+Kq5XE3QTxJSrnhdOLpoBn6ElC4i7+Zq5Xu4yEiBC1p681wAeuREdePBw3VzLorcpxyrG56EGuVROWZ91oZu56BaV5iq9+s0YBuYgcyLpV/N7zZuEkzUg2/IixE6qZrmLZmFeteFJEsTXqltqEOR3c19riYZ7HogNRnQbDiEEXymDDQuP31w4WHItcINroJic3/c/AgSBynjgRLV/AQV8W5Ap4YtQvtJrSDe32DPXli5knpx4VRzYN+1vVYzfw6s1z0+F+VQtvTy2wevBC0IebBN3/bR0TcuPeuwIBzU9jE0HmWOsVAGYa+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:46 -0400
Subject: [PATCH v10 08/10] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-8-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=1041;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+3MidV7XoojBAWFebcj1RI1TKBDTvuas/ORdvq98PK0=;
 b=f+c2fQFST6BaETKVDccQMUW8c/KeNmeOjqrdGApCWgINs63xwbb2manqvo6vZgsCXUr+JqpKe
 ZegMovj99rlCj5ux1p83vd/aHZJTQuYBTBQuZwB/Pff4Q+Vkd5ddBF4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0f55a7-98af-4b9a-c1f4-08dd6010a673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXhnaFIyek81R3N0TUpjdHh0ZFNRdS83RXl6ZFR3VWM2MzB0NzU4ck9zMHdh?=
 =?utf-8?B?QkFUMlJ2V0Y5UTJ5RFRKcFFYL3gxd25sSDQ4QXNQQ25SeFlOQTRBQW1YdHA1?=
 =?utf-8?B?SEFKc2VyM0xtaURGN3FRaTRXZk1uRFc4aExQMjVHeVJLMGxXYytkZm1IbTRT?=
 =?utf-8?B?cmxiTEl0Umo3MTRKemJMNm0vSkgrd09kUWIzT0NQRDZCM0hRSzQ0STVxU0Vn?=
 =?utf-8?B?a1J5c3lkR1hNalZHTXVrb01pMHhSYVA1Y3VlcTEzT1IwV0JrNkFLT3JzY21D?=
 =?utf-8?B?UXdwUkZ2OFgvbU1NL0pYeng1WDVPeVNqK2k3ZmptR3ZaSkZ0UFJrNm02RTlU?=
 =?utf-8?B?YTJFdlFsUDA4MGgwd2dGMlM1V1kxME5wSGRreXJIZXVuaTMxb1JPK2swTFhi?=
 =?utf-8?B?YTJzNTZZend5ZERiMk5HbmdWemVTWXNtL0QzaWpVcVBCL0ZRY0hXOU5EY2JM?=
 =?utf-8?B?UktGc3RXSWVjeEE1RlZuMWIyRHRBVkovWXZzZ0thTENTengzRXRFeG1ReGJz?=
 =?utf-8?B?TEdlMmZpak5Sc3lBdERqZFdzTmRWOE5tZUxtSkxFT3RNK25OQ1Z3NGNNdzNQ?=
 =?utf-8?B?V0IrckUxSW9MT0VDZ2J3cGpmM0FTODZ5SmQvRlRLK2Z4ckNqemdlZHZJT2Ny?=
 =?utf-8?B?VGovbGhTYnFNdnhFeTEzdzBoSHl5UUVQL3lGdTFrWk8yZW5CQ241VER3K0Ru?=
 =?utf-8?B?Y2oyblo4N2VHVzRTR1grRmplNStBL1k4VVpYenJYL281Snp0eWw1dWZYN2Zt?=
 =?utf-8?B?RC9YRXJqa0pDVWFMRWppdTRiempCQnVkdjdaWVNoNStVUFBUUEJIZHZBaXY2?=
 =?utf-8?B?dHM2NldRa0tXYkt3NDNPSGY4b2xCUlJkWmRKRytTeDNsL3k1YW5pZHBvcU5O?=
 =?utf-8?B?VnV2QlR1SlVDM1hkWEtKak9iak1WUFNCWVdJMnNyNjdPbXhBOUpuNlBQSkpq?=
 =?utf-8?B?SlJVWlJCemN5MGJHSUViTCsvWG01Vy9tcHpVZHBPeDdCVytQMGxhSE4yUHdx?=
 =?utf-8?B?NTFIb21ib241OFdCbnFJM1NtWUNMeGs4RGVKeTg1T1gxNjJZSjFhdDFPNUJE?=
 =?utf-8?B?T0I0YU1qM28wRkVsMjNucG1xbXRHUUY4VWpiTnhIME0wRnFZdjZTSFlVbjY5?=
 =?utf-8?B?TnFxZmJnN0xvdEtGb2JKT0ZxVURLTFhwaXY5YWs2eExtMWNuaDUzZkZRQ25H?=
 =?utf-8?B?K1FuTWtqeXBNdXVISWp1Q0xibHB3UGk0UWxZSG9ZNTN0dE5acHQ4Q0liMEVh?=
 =?utf-8?B?N0lISDVwbHluY0JLR0VSVCs0cTFhOWhRQUZ6TDFoN09TTnFQSzd1ZFhqL2lQ?=
 =?utf-8?B?R2FPMDdyOFZVVmJVNEJBRHR2cnNReG9OcHVQam1PVUt5SE10cFFxMloxalhT?=
 =?utf-8?B?VHhPS2VaaUloNjdKcGpNMWhSMHFsWVRBRjJVSjA2MXVrY0FSUlpkZDl2aThO?=
 =?utf-8?B?VTgzY200bmcvNWp6T0FSa2g1V1BOM2s0c1FkaVFxL1NMd0VaSGw1Z0JLY2Fu?=
 =?utf-8?B?SXJmSEcvaW9Qa1RlZ0lRVVgzNHZseGR2WDY1VmFJMklIcHBnTlhwYVM3RGc1?=
 =?utf-8?B?TlltbmVLYXF2eHVmeEFLT0YxbTRyZWJCMjNRQlpXL2VjNDBqY2ZqdFhPdFhW?=
 =?utf-8?B?KzZtL3VpUGpJcHV5VGRUcjJMN1J1Sy9Ja0NiY2VBWVYxS3o2M20yT1g4bWov?=
 =?utf-8?B?UDJWOFcwQ2lWVUZMTjlyR1dkUzJYQUdPVG1mZlQ2YlRKR0cxWUZ4TThHYzR2?=
 =?utf-8?B?VllUTTU2bE1SUEdpbEJ1aVBoZXROSkxqTFl0UUVSNWdrdE1jZjREM1ptMFE3?=
 =?utf-8?B?V0IrYWY3N2xvVlJJd25HRjZLbXEyZUJjYUF3ekFPSGoxTDlWMG1JdGlPY3M1?=
 =?utf-8?B?T1VKM2RzMGVvdGlrQmNHd0hPMll2d2ljTVhDUUxxZW9zeU8wVGZDVWFtQUpy?=
 =?utf-8?B?TThuRGlkQ2x2M1JQaHJuUXFwVEEweHlQQlI2SzJHcXRyeW16QXZScnBONnZW?=
 =?utf-8?B?OVJkS1o3VlVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3FyNENQaGlWYnFFdjVxaCtIbkZ0RjArRXVEQWQyY0NLMUdrZHpGSHRPR3pq?=
 =?utf-8?B?Q2NreTZZd2k4dFc3Z1haWWJ6MDE0amJFKzFzaFhZSTlmb3pXa1RkRWozK2sy?=
 =?utf-8?B?RUtQdGxPTzdWNDJRM3JicTVWek14VDk3MHBBdkNRekNHV2d4a0RtYWNINklx?=
 =?utf-8?B?c3d4dmJHMnlhZlB2ZC9GOW1aZjhnVlE5V3puc1lud3lpN2hVZG1zSjRwSG91?=
 =?utf-8?B?ODQ1Q2t4dWovVGh0WlA4cGxBTG0wSjhGVXBSMlh4S1dVNU4vSmwvRnozOVoz?=
 =?utf-8?B?RVJuSSt6eGpsWWNoc014UWJaSUtRbnZxdEU2anhEMU5LNnExZHNDODFoZHc2?=
 =?utf-8?B?RXNhMENSUEs5ZkU3bnJpd2pTMFpCUzFMYjAxeWdQSTFjWTYrQWlnWkZxcnVU?=
 =?utf-8?B?dlI1L1hqbGZ5RmFSZEtlaU1nb1VocGJWb0lQVVlwTVNhZG85dHNnK0wyK1FL?=
 =?utf-8?B?RkIzSGowZDFzcEN0aGNHUGs5b2dGUzl2ZlFIV1VGdHZsczNoRW03ZUxDdmJS?=
 =?utf-8?B?VGdNaGtmeklLZUNydURzUjBONHJtZVBDblhUZjhvcVBsRFpPRTZnNWxuazVl?=
 =?utf-8?B?UWYxdHFoWHJ6NUhGWjJ3ZUZ0VFBJVFUzRUlvczdHVUxUTHljdWtZeXBwUC9D?=
 =?utf-8?B?Q1EwVW1EWnM0R2FLaG9uUHFzR0l4dGp6T3VVNjJvU09KWGJIUUtFSXpCbGlk?=
 =?utf-8?B?ZUt0YkcvSnBQdnFLVmtkYmx0Q2xJblM2VzlqbWRNd3psTm42WXd1N00rUFNM?=
 =?utf-8?B?dUhMeHNjNjduZ1h1ZkhKNFlGUUgralB1YkFWODhEYVltNEJOVXNhMDRJRUpR?=
 =?utf-8?B?UGJUQTVyU0E4Vk9sYnRqRmZWdW1aZG9SNTRCQ2tSOWliWjV0NWVxblRTbmJy?=
 =?utf-8?B?eXNFMU5qN1VVK2JVVjRGa1phSnhoVGdPM0hpQ1dLeFV0bzhDTjJMbkhMTERO?=
 =?utf-8?B?S1NJTjNDNjNMOXJTYXVyT2lqWXJpVmhNY21NUDk2aVU3amcwaTEwQ2orOSsy?=
 =?utf-8?B?WUtNbGN2TGNFbjFqSzRhdjVQR0VCai9IejBUb01qTVdFSkpFRnlKSDkvZU5N?=
 =?utf-8?B?OXBuSThKbE1DT2FxeXRMeVpRTDdyZHk0NDhFYWUzVVM2WHBUVDdRRzRDdnNo?=
 =?utf-8?B?SlNGMG5qWTZTdXphUVAzclI4aUw4QTIzUlFTOUhUeHR2S0ZFcEFiNGRTcWl5?=
 =?utf-8?B?anZlcVlyTkV5ZlY0R0N0OFhROG8wODNvaENRYjUybE4xT0VTbTVxNVRZV1NK?=
 =?utf-8?B?UDNvUEVqZmlsY2ZFY0t2YnpaSTJNYXZGbVVQd1ErQitMNmRZLyt4TVhmQzBi?=
 =?utf-8?B?N3VjTGZVOElueDNDUTdjSE1ka25VNUN5Zk9yMnBxcEJYdDhiaVpUb0hrOUl4?=
 =?utf-8?B?Q2VGNGFUbmh4NzZIWlVtSWxqZkVKdlA3NlRDd0RIRWFiU21Cck10L1VDbWhH?=
 =?utf-8?B?VGNDeDhLQWhpWjMzNncycVFHeUN3VlYxbDRzSFN1ZUZ2TWErTjF1Qkg4TmtU?=
 =?utf-8?B?RnZ3Nnplcjc1VlUxVDlpRGtocDI5aXpiZFBicWxXSWRGbEt0TTVCbWJET3ky?=
 =?utf-8?B?bEJiRDArcmNTZkhEeFBxY3Y4bkdSSEVWV0lFcERGYXR2MU5XK1RtRURyQjRx?=
 =?utf-8?B?c2tWRVdxMHB4UXRSL3VwelpNQXBxOFVId281ZHhqQzh3dU9iTlZERU5jRTBO?=
 =?utf-8?B?TFVqUG8vT3NSOHp3bi9hbGtNVDZYOWJXaGtuVjI4ZHVBOTJoMmtwK2prdGZE?=
 =?utf-8?B?eFh4cmJyV3pyR1hhZ1BDMEpJb1dvTmRmL3lqVzhyNWh2ck00eG1uekZNdXoz?=
 =?utf-8?B?MFVvMlFCbnVib3Z0T29sS0EyZlc4aEVGK1Z2aUhLZ0h6MERqOFozNC8zbGU1?=
 =?utf-8?B?SWNoTG94WktDSk42OHJWY05qNmpiNzNudGNZUUFLckxVWUJEZkRtY2Y0UzJs?=
 =?utf-8?B?dDlxT2c4Y2F3NkYxNVVNcEpqUE1OMUdlQ1hHRUM4WlJ6RFhkbHlBRThEVVpF?=
 =?utf-8?B?NXNwSGZvMmErOWduYk1RNDNjL3FaY1V2S21wSVRaSHRhU3krWWEwNHZDdVJP?=
 =?utf-8?B?RnRINzlTb0Z2R0FkT1IwczEvSTR3UXNHSjFmRVo0M29sbnJtenZyMFc3WFNM?=
 =?utf-8?Q?yM0vvpcKch6LYKiGi2qCv0Ga/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0f55a7-98af-4b9a-c1f4-08dd6010a673
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:58.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZebD/H7/s3pWpW3eT35O0Etstas4INjjXwOh0vlWwTbnc69VOLVeQ5D1KoGdLDG6M3MtvPRViwWOqFnA4CsNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

If the parent 'ranges' property in DT correctly describes the address
translation, the cpu_addr_fixup() callback is not needed. Print a warning
message to inform users to correct their DT files.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- new patch
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7061a7ec08cb2..3ab85dde22ce4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1125,6 +1125,8 @@ int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
 
 	fixup = pci->ops->cpu_addr_fixup;
 	if (fixup) {
+		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
+
 		fixup_addr = fixup(pci, cpu_phy_addr);
 		if (reg_addr == fixup_addr) {
 			dev_info(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",

-- 
2.34.1


