Return-Path: <linux-pci+bounces-15244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7FF9AF3E6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F171F21A33
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82E21832E;
	Thu, 24 Oct 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m28Z4gIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC421730B;
	Thu, 24 Oct 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802555; cv=fail; b=mHsuKAXN5yfau8tIg9OiiXd2WbBiHS2mhiViznzh5QQXALKdYKJyirHhwuwR2eb4ouXpVu9Ft0PA3R7ANdNnO81+bVRHUN63VACmMhKXyADJGUvVQoglYB+n79g5LgXV5nxLU6MtUqcI1WpxiCzDWo0pTNNofFbTb9YcXTdXlKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802555; c=relaxed/simple;
	bh=pa21YroKN1Hep2b0+6lkuwO0n6eajEDfXOfgCIbz374=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tp+HLB71lt1ADAJxK3MVVaVcljyC56wkqJylQO8mLSykm4WXiO2s2xVSbt8uqUxv4bm9nE0H1UJyIE94dN38vKIjiCpPjxCA8wIZ3CDi1qTWwRbkGLseJUhbWECvuyaAs8WoOHLGK3gnyXl0xZRukVcLdV5IARyiScYGjaybgyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m28Z4gIq; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRAf66y8yVdTkJ5VLjm2JfKLA5t+koxWWYubaBi5k976xZMJv1VJbhaS5rRHyXO3AR/VIitYrXHRNScMa6GHeepORchyLY+MOPypP8w11HNKRiCFJJwXp40oDukx8r5HtdGxRjIP3Xs1nL1XuS7flPb4Jd6Uhx2THKMLr0rWDIYjtJqtX+bnCxOpTsoNz6Juoe3RqAJJoQ+aavdcHgqpFtbcAXWha5JCm+fjpLX9qvq5cZAQfY4Igf5eqyaArhmoau9RVB1mvaSN/e5vLAsEbf4mWCg4gJI4IxKSAZzETbfWhY+93jfM7eBZlhTSQM6MUGGUtzPVRAlumktFge/gKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xag/w1g9a9ktecMSESDiXVwOlvIRngpJp5VTemD6Bv8=;
 b=ZkNPmeNNvO13x/CQXqPMmz19S92m9cxX6Zsamu+fRZ8SMLbCG9c0GqzFqmrVB6wVjJm3QMX6CzBrth4pMAlaG3AHE4JS0ZSJTO3EcyV1kFoNoxJmnWw0+SlqTlg9A34uF9r+5Wrg6vmRtzmF1wCqgKwTmi3JOseaGWjo3aHvjRBYqf7vf0NUa1bSHx0A+qwjvNQLer5CPRJMMRffGXAdIWkP+TrSHbnaz0AfYU7VNsAwM9YOQWgBApjE9XO8reGgt1oBzZYRnVHjehJSNDX6mAyBAwddbTw5F794ViCYFw84Or5YMr9wP6mRLWI82tTtyfox3meJq0X7iQX8N3hfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xag/w1g9a9ktecMSESDiXVwOlvIRngpJp5VTemD6Bv8=;
 b=m28Z4gIqjPsSD0KRqb/snBgSPaZLxtqKDjSJuDi8HD8NEUsU5pQ2ErqK9bASy1vHggI5b7uQDsfGHqXojGh/gf54svbNqfOY8uSQG13JPKp+Xye9FbVZ0pC/1/cK9K+24z4DJC2UFRBmu5XD4JEeaWqM/9WJKM9OxX8Uq45xu1WuZfEiVWagqsymWmDVrm0qTWgkDL9N3Ul/Qo1CatdHbQerfsAd6TEm0R/yBFzwhXaDRgeVGKeV9dofBOv5MWbfZsFQc+9BR/0G+6UeJkCkB1B3uP4fcdPczHaoNGxkPdExESXgTeguZQj8UaDhkyvX4lqTwnLSU6wnIUsqOwl9bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 24 Oct
 2024 20:42:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 20:42:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 24 Oct 2024 16:41:45 -0400
Subject: [PATCH v4 3/4] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-pcie_ep_range-v4-3-08f8dcd4e481@nxp.com>
References: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
In-Reply-To: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802524; l=1266;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pa21YroKN1Hep2b0+6lkuwO0n6eajEDfXOfgCIbz374=;
 b=TMYO6I8IT2cnF3WLAyfp8t7Qbi6JBVX4CUPFyIdQzCC2HU8mvJe9M7EXVYFTaoWf2LbgRWml0
 E+bz7aEhthvA16GvXOruBnW/aVQSmhPgW0tfMcmOWuDsDm+dnDfbaKP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: b392c4a5-34e8-4c59-282e-08dcf46c60a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0NDWUE2czdSNVlhMmh2dmRpU0J5U2R4ZmtEZmFiNTFFZFdlUTh0UmJpb0tC?=
 =?utf-8?B?T0g3aGhzbndXdWFkSTNPYjFxODJNcmh5WnRsek5neFpoVDRnY0htVm9GMHFh?=
 =?utf-8?B?SW01NkEyRXBsUUtvZC84TjE2eHorVFZZTUNIT0gwTW9YU01SS2pqVEp5dXl4?=
 =?utf-8?B?a3lqdGQzKzJPdWgxSzROVDB6Ynp0ME5uNG8xdGhrWlRuQWNISVYzdFFtdUxF?=
 =?utf-8?B?K0FjdThHRlRueUxLTEtuTjN2TGpzcEVUa3d5cE9FODF2Z3VYaWNZWVgrdEtS?=
 =?utf-8?B?QXVZVHhhMStTbWtQcUpaV0xtRWRqTlZCV0VJeTloQThsKy9OVkJ0VS9qeEh5?=
 =?utf-8?B?VnJiQk1vby9FemtvMXpSSFpxQ3Rzc3dHVXlQQm0vRmtTek13Vko1ZkJyL1pS?=
 =?utf-8?B?Y1M4K1hzSFJCdEo0cFQrMGJXM0ZoNHZCb3M2TjVJZ1NRNjF6ZXhsZ1FxbjZN?=
 =?utf-8?B?NXJ4NkNCcmYwNHM5SFhqNXRxT293M0p3Q2FNV1dUelJQK0gzelkwZ25QTHVU?=
 =?utf-8?B?Mm0xdFNxbDBKU2RCL01GcjVvV25JNG1YV2QrU01TMjBqQ3crRFQreHlsR0o5?=
 =?utf-8?B?VFBvMjg2elN0MlJYQTF0Yi83akgrQ0IwV2tsRFlzRFBxemp0R291bXdNMUNT?=
 =?utf-8?B?UldVbmNMY2YvYko1SHpwaVpCRGV2bjFpTlFQV0tjS0c4aFpNVFRQaE81c3pK?=
 =?utf-8?B?TjNtMjlZUDhPOW9ld1owS0tHcnpUemVMM2VQeHRNRitSc2IyZzJBWG12Y0hx?=
 =?utf-8?B?dnA5eU14eUY2MTNnUkkvNzhISHdwSzE2ekl3UEtMb2d5TXpjWURUaUgvOTcw?=
 =?utf-8?B?ZEphSmx1ZGdnME85b21zZllpU1RGUjBPdkVRSnJxQ294eDh0RnJUeGE4YWxl?=
 =?utf-8?B?QkFmalFEb1hEYThCYUNVVkVUMlRaazU5L0M3KzZOSmRIbFgzaGl6NzZTRjhv?=
 =?utf-8?B?Qi9ZQmErVjUwUk1SSlF5Mk8zMDBSTVFXR2ZWeGJ3RTZ4SlhabERSTzVPL1pw?=
 =?utf-8?B?OEZ1SzRpNEQzeFpaUld0VGRZNGRSTWs5NGpqVnlIcnpSdTBmOFdiTjIyV21B?=
 =?utf-8?B?SXVPS3JjQ0hGOGdYVnlDNVVzYXBodUJNT2JmMWd4WHJpUVA3VkxiSkk0bDRR?=
 =?utf-8?B?NmRxSlhuRkVUMWxOcW90NWZtUnpQTk5TcjlOL21uWFZRbjk5ZzNneFd0VFNH?=
 =?utf-8?B?TTZJazFBcDRZWUxNbjY3ZDhtUmVUSW16aVl5MGo5aEFybFNkWElCNnRlUkNa?=
 =?utf-8?B?bE1mUXB4NnVKNHVuVEtDRzUwYU1WYlFxbHVJUTVCdi9Xd0ozenI4dENOMWhK?=
 =?utf-8?B?VS90K3RDTnRPdHlzY2JsZDNyY2NrWm9aekV5OHRPSVVjWjNuTVZFZnRCY0dr?=
 =?utf-8?B?M3dVSDNMazZjOFovdW9BVFEvdEVNcU5vYmlCdUMxMU1YQTFESnhkU3RoeVRK?=
 =?utf-8?B?RG8rNm1Sa2IxdlFEWGVyRUgwaUxNb3p5QXJReXZRNEZaTEk0SXRhdUpjYlBN?=
 =?utf-8?B?Tkh5MUxiSkVwaUU1MWx2ZERQTXBiUTUxaHNWRjIxY2s0cVdMMW5zVWM2d09j?=
 =?utf-8?B?THMyejJ3dVlYQWlibGdzamtiYVdESFhJdmxNaXhXVTNyek1CeVQ4TDUyVTlo?=
 =?utf-8?B?Z2pmQW94ZHIvVDQvUXh5S0ZOMHZNdWZGdUNCTU9YeGJFdzkrNHZHNWhScWZk?=
 =?utf-8?B?VThlNG9aejlHdlg2NTUyS1hQK0FjRENyMEFlK3poMEVJY1NCRzJJSEQ5RjVL?=
 =?utf-8?B?UHNRS0NLakNhcVQwV3A1dnZKbEpPeCtVNFZnbmttSXcvamNlczRUQ0Ird3ln?=
 =?utf-8?B?RlFYM1VGbVBQaHRBa01vaE05cWNQaGpXSE9OT2Racm5oRW5aMERCYk5XNzRt?=
 =?utf-8?Q?6twDKvc75nAyZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NTZ01EWnVsQUZ5YTc3bE1GTThFcG55TC9HdHNjNlFCU1p1bUhDM1RMN0VV?=
 =?utf-8?B?bzcyODhsK0EvT05pVm5QbSt6ZmhYam9XcHoyNmZqNTBVVnJLemxkVHIzYlJo?=
 =?utf-8?B?L2ZnSURTKytnaUQwVndHU1dQaFI3aWlld3VxTjBHekZyRTV4UXJOaU9lcFow?=
 =?utf-8?B?SUkvS21neks4WDlYajJLVGh6OUVqczdyQjFJTWUwVWp2cFllZ1dJUktJSTFE?=
 =?utf-8?B?U2N6anVlWW9DWWU5dVdHNGd3c2xTMWQxRGRRcHRsc3M2eTZPUFkwdWZXMGhY?=
 =?utf-8?B?T1VVRWFCZC92eEZ2L0V6WlY2V2pndlNMYUV6TEdyUDFzMzNKaWpQRzNReHFV?=
 =?utf-8?B?dWJDMHdmbXBSUThZVlNraUxqVXVNYzAzL1orazRMSXl3blJYTkxNSGNaOXJD?=
 =?utf-8?B?Q0dVeE9Vc1N5TU8yeTBWOFdFa0IyVy96cEVuSHNQSy9STmwzTlJTd2RSbG81?=
 =?utf-8?B?ckVWTTVOYnFqb1FmeTRKK3VTVVhpQlBIZDFNM1F6d0lPSUFrU25EQ3hsdXkv?=
 =?utf-8?B?c2ZnWFhhOStFNWJBMUtFSEkwVWpsWUlqbzdMMzBMSzcwUzVaWnVHYk9raGd6?=
 =?utf-8?B?V3hWQTVYamxlYnRJZUJFU3B5cHBrQVFIWG5Qd095cUlIc0JTQ05QNWVnaHVZ?=
 =?utf-8?B?WGc5WDNvRC9ST25Hem1hQmUrb3hiODNrUFBzZG40dXBZOFZTSTM0ZFFUWFFs?=
 =?utf-8?B?bXlyRWJIQ1A4aTNPT2hFbElyRVpKSnV0R01xNStUcERjNW1iQlUvVWs3UVJH?=
 =?utf-8?B?T0JDa1Q5cERpd2gyNmNSZG5QLzNVL3dzYzlGNCttMTY5T0RaREdQSXdNR1F1?=
 =?utf-8?B?Qld3ckdhSllLb3lPaVpaZUROajRNakVyUWJ6Zk5uQnZjNlJucU9rSFJZTTJv?=
 =?utf-8?B?NGQ4UEZia2hXNGI2eElqOVdMR0RDem9zdWM5NGNMWUpwTkxEbDBHcnhQcEx0?=
 =?utf-8?B?dnBUSzZPeTdWUnU4OFM2NDF5bmpnMktTamVpSzhsaTc0VlZVR2Z5UnpIUWJo?=
 =?utf-8?B?dEw4VUUvM3J0SUtBcENuelZGZjhvbjk5RWI4bkg2TUlUQlpqbkwyYk5tTWNs?=
 =?utf-8?B?THVvN2tuZUJLR2ltQXhITk9mWDVuWXEyZ3hhaXJEdkZ5MGtqNElPU0VDazcr?=
 =?utf-8?B?dHlKWHAyM05Ha0RIZVhRSXNpY01WMWZneUdIdk1hbVh4VDBBN0VURE9TYmho?=
 =?utf-8?B?d1dxQ2UyM1MwN3l4cElOWGRLR0QrSFFCWEthcE93VmFqeDJTT0d3TytTRUhS?=
 =?utf-8?B?alEybXJBT29PUXVDSFpnYVo0cnllSDBSMDBaNms1R2lMdi91SGExSkdnYmpj?=
 =?utf-8?B?RXVHZ0hTR1YzYmpFMjNqaExleUNRYnlvUEZiMEU4WEFWSHo2THNkVE9IbUcr?=
 =?utf-8?B?VzBwUWhGd0RHV3VnTXNqeFB5TEhMSjYwZDcwQ3pyOGtVRThsVXkyN0x1TEFs?=
 =?utf-8?B?dHltRWhLSndORGxOckhlVXlCNXg0Z2lVMHFLVS9QZHkyREo5djExenpxNzRa?=
 =?utf-8?B?SVRoRTdNdkk4b3JOcEtmSGI2V2phMXFTcDRpS3BtdFV2Vm1sVEVGMUFVWDNp?=
 =?utf-8?B?Y3c2WXZHTlhaZHVsZVB3NmJCTS8wWlJDK3dab0ZRdHFGNk40R3VCUGViMTZH?=
 =?utf-8?B?OXZrWlpGWHlhTTNoT1NFell5dGVTMVdyZkxwK3BIc1o0NzBHeWZrekdoY1ZN?=
 =?utf-8?B?S1RlUXVoOXRMcU9NUHp5U3hnSUszZkR4ZEtiNkY0bERPMHRPZDNUc0g0Z3VP?=
 =?utf-8?B?NVdNZHA5L1JiL2dEbHJ2QXI0YlRWVVdJanZZZGFOU0twVTBwaWFDcUs2QmhE?=
 =?utf-8?B?NEJ4dmJpUU1MdU5uZEhhVHRUQU1Ob2k1UmlEdlZZOGp4SFBGQnFiSlJGeS8x?=
 =?utf-8?B?VnFiSTl5QmFzZVFwWFBmaDRBUmRhOUtxQ1F6dkNESW80c0s3djQzT0hNT0hv?=
 =?utf-8?B?ZmZjZmMyWmpvRE9ZcGdnbURqWk41MjZVOUNrZVVHNVp1VzMzNyt4S0t5UlFP?=
 =?utf-8?B?VDlZODB2WWlnRVNsL1daN1c5dnY0NTF3OCszTUx6RDUxb0w3czM1SE9zZ3FI?=
 =?utf-8?B?VmlnK01IL2tJTUFxSXhTdDRPODRUQk1wMW44eFBKWHh1RkxPcjIwakpqTjdR?=
 =?utf-8?Q?yoiTM7A0YVjZa20lF02L7QNs4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b392c4a5-34e8-4c59-282e-08dcf46c60a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:42:29.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xntXs1Fo3VE3UTHzQy7Qd0MKaF2Z9lBYv7Qql4YIfneCQavcuFcOsRCYcKaoGC6P+3BeloqRUjR2d4LMhNYSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3->v4
- none
Change from v2->v3
- Add mani's review tag
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..bdc2b372e6c13 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -961,7 +961,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


