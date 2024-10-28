Return-Path: <linux-pci+bounces-15488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02789B3A06
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC04282E0F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC11E0E1D;
	Mon, 28 Oct 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N44izmjO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866541E0E13;
	Mon, 28 Oct 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142396; cv=fail; b=Ul8qLmAfrFJ+HLh06WlhveOBXU2zdftmNl0Rh5AWpI/9xHREiJj1wHhD0JvQzeYzVYAbTGp35e8atjvIeRWjTJ2/9aEJzrjCFG1I2zmvNRlCdW6A6LaRd+fMHFq1Ica33xRrQzSbJ7MVQbZos5I0h9D86zPFZLiBhwDelhfh3tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142396; c=relaxed/simple;
	bh=RzDiJjc+I6wcWk13KTVhystqp6RElq6XYrrJPcrtUXI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bal1JvJjlezuqv1029/GiB0PU29j9XyHOHTXq7z4PpjVKgU6qaBADS3rYaKMqRS+fjxTaPsh5wO59bGep3nH/YWRqj3h6Ty1SQb1/ldQy+i7HraB209hA6hZJjtRw2zqq3ZXiB+hm/tWclMg3If9pQHbVvHM9geDnkASDQauQlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N44izmjO; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSV+ijxIhHNlbKkF4M6O4HgbJnOQNTIpVEn5Ir2S5Lgj0CrlWC8agsZ/31TGylcjMD4MdMBP9wo4qrFVgTBgLlU/SJto08/DQWj5FmID3XBi+uRnQMsnGvkWL+YhwBEn3VZzG9fNUmoVftHREgt/Exvyp8AAshe80m3DvKUOmSDZZtHzE3vZAy6AasbrSldFeRrlyjPEuYi/XKyzXM3W8s6RrpsWsM/VqDq0bpbpFC6BRHYETYAe4Nw+lI3bsSX1BCkEKp7YTg7vSZ4hhmQeduxqSJmymp3tOqhtmNI2rt8kTW2HURXjSXloqfwE5HORehJnFpmczyAS7mErO0orBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fLhtILW+VZvuJWqnGcQ5qJ8MgmTM/8+pr67M3KgLGg=;
 b=ENpnqWiLJBBLV+VCKlM30qePXQpCzPBVLwk2VvO8T/TI0U7JOIJHFwbUXF2cN//oakm/UzLO2CAlJ56UulQeH+W6VAyaqslOKH+AEHhUALXDVyxHeFNhy8lnksZ12x72V1KxmKLnl8FuVgJW48wdjMytMcVyqo8c7P7/J65z9AS3oaRZhvbWArkMyb77z2iNw+/i8gmOZbQKsduWqCQIYaHODBFrC7zzdFXbttDdisz4J//v+JbTmOALdCrcFZr2CxVIDwfU0I23hi/UMpk4v2giki9Gn9XCuuGeZPlNybrES9PrKtent7we61jR4G5615VRjvEkZDyWjxIAT3ZzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fLhtILW+VZvuJWqnGcQ5qJ8MgmTM/8+pr67M3KgLGg=;
 b=N44izmjOI78GLcEWrcxyAngSHk8NPOM8ScBeG6C6KQdKDCNVhhGb+rZSaJJTRsdUmDnAn+QaxShl5uPzm/x6oc4Q5UhjGq/t68pvctNxMfTuMdPazGJAWfeBCAw/tfuAyVKufOsLGWenMQw02OKfTEk1tfF5u9xxvtofOo0oSnJ68WQaurJxSJQu24EloGVhooLspRXtLo/i6/DGLRExJXPS1cfRcMPvjbUJ83cizpkGO8z+/ZlDB2NeBKWchKXDWjjIU9GVMgIUbPnuOi5hWfTvmrf3rp4kyzkCog1Q+H2V3fxAX+CaKHaxQ0y1lkYlHuyiOQIX0jqVOTL1MFRcDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:05:59 -0400
Subject: [PATCH v6 5/7] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-pci_fixup_addr-v6-5-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=2245;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RzDiJjc+I6wcWk13KTVhystqp6RElq6XYrrJPcrtUXI=;
 b=4pLCC0gu4iUv8H3jhxnhRvuIaw/u0nXT1sQLIFaamEuBI4cI2BBNKfVSbOkgwvowA/asZbAt6
 PlbQkvTs0tnDhy+C0RON5/FEnA+7pRc0hrxhondKCLzaAboBcbUHIO4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: e22b3740-aac1-45f4-f963-08dcf783a1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nit4OHY5UTF2dkdXUXl2d1dJWGU3anBjanRoUS9FYWdyc0VjY1UwMmhaSVcy?=
 =?utf-8?B?aDJQVTMrMWloNDViNUwvWk5IQkN2aDdTYUMwVDU3cVdiYndkRGt5ZGJpNHN1?=
 =?utf-8?B?Y3pqdDJXMU5VZklSS205S1VqRjU4aFpteElPSUxXRzg0b1kvdEJxVDBFR09Y?=
 =?utf-8?B?VkZMaTlvSkpVSUc3cTRPbmh1ZVNOWmI5VmJ3VGNBZFhpV2FCb2RINXlvaUZz?=
 =?utf-8?B?RU1Ldkw5NTE1bitsS0RtUk9yajY0UnkvS0hoSjN1NC9tZ0VzSlA0a054SXFS?=
 =?utf-8?B?MEExYVZZOWp4Y1MwQnhCbDdSR0hnUXhWd1lobER6QkY5cVV2WDdUUy8xUDhS?=
 =?utf-8?B?RkVjS1ZjNlBTNG1GREFKRlNZeDF3VzNOdkx6U1NzSDZoVXlSVzhnenEwd3R3?=
 =?utf-8?B?ZXdaajBhOG1OTk1TMVZyMnEyVk8ya05nZlBBVlR4VU90ZG9oeFl4MGw4Y0tJ?=
 =?utf-8?B?UmxKeGkvYmtOUzVseVR3KzNJeWNMNW4wc0htZ0dMckI3ZWFtZFNKclZJYUtk?=
 =?utf-8?B?RkpaOG9uZ3lRc2cwbElyOW9ZSVdFcVRIb21XUWw0cURxTE5BYVM4aENiSTdU?=
 =?utf-8?B?a2MwRUZETENKczhNM0xkMG53WU1UQWVXYkZHYURETGFrNTBIQ1JGWGRla2lQ?=
 =?utf-8?B?VjkrSnV5dW1Dd3dBL2RsQVU2WVJlME8yU0ZtbXNVK2RwTFZ1TGNBU3l2Q2pF?=
 =?utf-8?B?UUZQU1pVQVFoUkdwOFF2WEp1bmkrZXpORi9qYWNaVERjbWxnWkFWZldqeXB2?=
 =?utf-8?B?elh4MGtXVU05M1VxSmY1RUdHQTdkM0ZUbzFaS3Z6ZCtUT0pFNW1YTWJMYUw4?=
 =?utf-8?B?NTY2OFhjN2tTRXBNb3g3K1FPMWxqOGZFb1ErWE1nRGU4WDc5VHMrU3ZlS1dK?=
 =?utf-8?B?aE8ya0NYcHNleURzVDR5WVhINlBIczNGTXZhenpRSnNRQ1R2c3UxYmRrNmJ4?=
 =?utf-8?B?b3FIU2VrUDIvdHdkVEcxQnhiUmVIcXYxQUZzeDdmOEdXQUFzQW1mM1ZPWVJx?=
 =?utf-8?B?dmEzWUxRS0NmSUw2cjBxTE4rSkl6NzcxTjVXSHY4amFGV1dHcTd6ZEtLaFAz?=
 =?utf-8?B?TmRpN005VzIrKzBTK0E1ZUQ0Tk0zYmFZTWkxa2hWd0x3QlpmRS9GUkRZcG5j?=
 =?utf-8?B?L0JkL1NYRENCN2UzQ3JaNnpUVGRCbU84WnMrYjgyRXlnemNqS0ZjYUdPcWpm?=
 =?utf-8?B?MjUzcVZMUEtJTHRUSEFmeVRGOVpydjRiZHMvZU9xZTVtclRsc0N3OHQvN2xz?=
 =?utf-8?B?WG1yVjNBc1NrdmNSbjQ4dDJhWGR2TCtJN3c3UlUycGVuekczZmM3QWZqazZ5?=
 =?utf-8?B?a3NxaDIzYWhwKzBoMFF0VE9IQWd5alEvQTJPQ3hjeGpLQWVMRWdFTjZHbTVp?=
 =?utf-8?B?Smo2TVlMdGl2MytoZmQzTkJTVGJiVU82QThacEtoNlFGU2V3czhXMXdHckxy?=
 =?utf-8?B?YkZkaDB6WjBuOWNPcmFhaUpBWkJDc0lzUUlyNFE3UmVIbFpTOFQ3b0tuWUJa?=
 =?utf-8?B?YXZHdENmcGlHNXo1MS8rTE1weUQzVzBvR29wdm5tb2syQm4ybVVBdURqZnRY?=
 =?utf-8?B?R2RxcXBYMGp2ZnM3RTRBc2o0KzhaRFhCTU5mMkxKQ0RrSktzaUROYS9Pazdp?=
 =?utf-8?B?M25YZzJUYmVWSzVMOVhzei8zdzJUdWt3Yk1XeW1MRDczY1FVTUV4UG8wVnZK?=
 =?utf-8?B?MUhDNkhpMXdGS3I0Rm9admVTdlVsaHVia1NrU21heFZzL05PTWNnVkxPQ3Bi?=
 =?utf-8?B?QnpTRVltSnUvMUZEOUlLYyt4czAzeS9nTEVJQSs1UTFMN1F2ZDVOL3hJci9v?=
 =?utf-8?B?b2FtKzJzUmluRlZMbWF0bFJ2SUZtZmxGUXg0N0tNd2wzQVZXbWlWWnR3Vlo4?=
 =?utf-8?Q?BURK2NUJgsNB/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RThOWDJCWW1xSTBwQVlZSmcrQ0tBNVI3WU0wSTVSYy9iZi9OczZiRFh4NjYz?=
 =?utf-8?B?T2Z6cExGNGNheTE2OEdVTlYzODhQaENDRm9JTFNmSVY3YnZUdG9URDNxNWZB?=
 =?utf-8?B?M1MvVmp4T1lJZU5YVnRJSlMvNWcxY1pkUDlhdlo5Tmo1SUpSUDNjd3ZJaE9N?=
 =?utf-8?B?TExiUFE5MXVIYnpWS0dLQ0RFeitCcGJhUUQvNnRPY3paeXNpRURUc1ZuY0gy?=
 =?utf-8?B?MXUydHE4T2c3b3Y5UUJtdW0wMzhwcUFyV2hlT1BlejdQUUtSY3BwQkFPWWFC?=
 =?utf-8?B?NlZkWHIzbDNseGN4M1ZPRjVBdCtzUkh2Y1dGdXdDN2I5ZXAwV1ZMOUQxRkEz?=
 =?utf-8?B?L01HZ0FIaTVjKzZDdVU0Q1BtcHdwWVBqMnljVlZ3VVRNa0JibjhlQ09KSHdG?=
 =?utf-8?B?QTIrVU4yeWpsakxyUE1BWEJjRUlxWC9ROGlaS2ZseTRFQWhWMC94TlBLNENr?=
 =?utf-8?B?ejgzcUF6amtuaERtNFROZTBHOFF5K1VGaGIvNXBtdnlleGdrL0xVQi9qeDNn?=
 =?utf-8?B?NVN5ZE5ORWNJS0xlekJydlB2dzRPc0hBSytMV05wOUIxdUFSRXZ1cEtnK1k0?=
 =?utf-8?B?QUdoZk9Gd1hDeUsxSkk5VTdaK3ZYcG0yYUNXaGIwNVdOV0tYOVFaZVEzOUpP?=
 =?utf-8?B?dXA3a0dvc29oeTc5ZWpCSzJLMjJvS2w2OERUejVEdkNiVW16ZzdBTnRrcnRJ?=
 =?utf-8?B?S05zYUZ2dFN3OTRXRW9GRUY3Q29QVU5LbXZZL3Y0QVB1VXptVVVvZW1Scjg2?=
 =?utf-8?B?NFV5ZDdYMSt1bUhIcm5UZ2graTFYQWdPSlYyMFJxd2x5REQ0WHlBcGszdURS?=
 =?utf-8?B?NVNLMmdnbU0rRmZ6dklqd0NIM000bjUxQlJ4TVpFZ3RsWDBHS2c1TUJDeDZp?=
 =?utf-8?B?d2RrMzNSK0NDcGhtdk8rNEk4dXdKRFE2c015QW5neHhJb1YrZ1p6aXBaMjU3?=
 =?utf-8?B?U0JoeGsyTFFRQkM4UkJlTElXamdGRjhJWlgyNzU4QXhJUElVR0FJaktPOG85?=
 =?utf-8?B?YWJxNlUxSU1kOG04djhaNW80KzdpWTA4Q29QeXgyOHQrVmlLdjNOUFpoTEl3?=
 =?utf-8?B?TXZmRHkxbFMwdVh2WTVhczN2Sk5XbDZyOWM3OTFzOTlQbDFmWVpLOUFINW5Z?=
 =?utf-8?B?N0pBKzBPWEZ4dlBET3lRNC8va1pVbVZIRklMVnFtMHVyK2RWdjdXQW5WaEt3?=
 =?utf-8?B?R0lndDEwREoycGkwZTRySENGc3M3dVFiS1NRQlQrcUk1SFhRTEh3NG8rNFRk?=
 =?utf-8?B?Z1JBWW52NWY4L3dmdTZHdzl0RGRkcjZWeC9OUjV5bHlaU1Y5VFRXcitRMkZj?=
 =?utf-8?B?L2hydGFkV0ZHekhTNHc5MCtpN2tUSnpHSVJMdXVNWW1aSlVZNGFvcmRYLzZ3?=
 =?utf-8?B?TEdLNVRwemwvWmxVWVVzaXNoL2tLS0E2R1dPdVVLaThTdDB0dXJkRWIxclZG?=
 =?utf-8?B?YUEzYzUvVkc3ODFnMEc2YWcyMTZzTFZxeEdRa0pEV2xORDd1REJiTFdieklt?=
 =?utf-8?B?aENjMDZRNVNhNERRVmtvelpHSjRXQU5obXdLZC9DcGVNVlF2MjNzR0w5R2s0?=
 =?utf-8?B?K011NHdCMEZRdGtqSmNCdVBnY3Z4NktUOFNUNThsNlhqMmtSM0JaYlpGTlZB?=
 =?utf-8?B?M0E1WGdZMm5NSjZrSmUrRk0xbDhYeEw0Y0J5ZDBpaTBRN0krYnpmOXg3cC9j?=
 =?utf-8?B?RUFaaGp0V3VHSksxME8xUW15V1hzeEpPakZjcWE4K0RsbjRXd1ZlM1FrWWpa?=
 =?utf-8?B?bzB6VkE1K0tGWVV3eGtNVmNMdFlrZmZwUlR5M3o2U1dhaTZEL21vUXdQZjhW?=
 =?utf-8?B?VmVjTHI4b0tuVjRwbHo1U1d2N0hkbjNkRWQ5RVpxL2R1QkhMajV0ejM4Y21h?=
 =?utf-8?B?c0ZJRmEzWXNzSG1jaXdJZDF3ZVN1YVZ3bXFnODF6T0h1Q3ZFN3dxL2JrWGdB?=
 =?utf-8?B?TDFTOFVZaGRmSFFaQjBJYWRzdmxpaEcrQkE2Y2wvcjJUbGJJS3R1WDV5NzAx?=
 =?utf-8?B?RWU3S1JZQ3AzSXJiL21oK21ZeWNvRlpEdUt4VHhOSm83U0R5c2xRTkhudUhE?=
 =?utf-8?B?cnpJY09mNFV0MEdnbC9BZmx2Z0k2MG1idVQwSVF0L1BZdXowTDJ5d2dWejVk?=
 =?utf-8?Q?1dqaePksWiQFtXP+kvaxN4zpY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22b3740-aac1-45f4-f963-08dcf783a1e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:30.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecl2W0LQDKHR13T4eIaNja4FRVInU+ehU/8l4+DPFb2nzx8mqLk4VFf6C/QygXAFVWT/Q/SAqTV1LmtkU71QDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only needs
'dbi' and 'addr_space' because the others are located at default offset.
The clock-names align Root Complex (RC)'s naming.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v6
- none
Change from v2 to v3
- Add conor review tag
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..7bd00faa1f2c3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -74,6 +75,20 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
   - if:
       properties:
         compatible:
@@ -109,7 +124,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +141,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


