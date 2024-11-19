Return-Path: <linux-pci+bounces-17094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188EF9D2EFA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9708C1F21CCC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE011D3581;
	Tue, 19 Nov 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZfVtg563"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B11D2234;
	Tue, 19 Nov 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045492; cv=fail; b=YwjAxpdXZdjFv38+dRAcL2Oge32QvvOjnqk8ThmAg1O2mxkucCpUqwyQ4+iOgWvIBhcs0bYlf/0o8E1X1NQgfwEU16e4XgGWQNcwbmwtZjHqcU6qhwQ7V3Y9KcJ3N3GZa8sWFsBaH9e9LPpPXSpahLKRCzXCayGUTg+Eg+K6ObY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045492; c=relaxed/simple;
	bh=pBEr3qIZ3MtXH8tsEo1g0q/TpoDEnc9FIkQttuF8yAU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rSxOpR+wuW3UCAd1tWBzJDrdWI96tzLo0yeBw6HJIrzTFFWlq7HhfiaKDooTuiu1yFoIcHf2OVDyVxr+5vqI79KupBCNCHJhutsW+4MJ30gkBywqFs0xt3VjtizjL81ONFRUJZ/CIw9eZzyQNRGNzIhYjgHylpuMO28oWR+axCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZfVtg563; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSap2T2G5yPjhmHzu1ufqvXIbi4vpR2SzLmRbtC6CDKF3RTUMEZAKvZ+dPDoRYqZ2uZ5oT3gXkvff8Ohpgk/fpZ16ID/lWliyA18hZwu45hrp7zV98GGTkljxm6z0i5Zr0OIDuKA4649Taf6BJIwnTisjYHiAFHQ5ffvUNLB7DC1sRztddls5W8yHrCEyCsw8DXcxO+xwgQGWMIqk/Nh2y35X4JRapwm5Uvji3ZxfTm+60l7yZFcfZIXOqjplL8Zt9Q+apa+yANur4g09GAB6pYnZ/pb8bi1FlYoM0K7/PL40xrVCw02Zv8PGIUxDRh/l32IhF5g61IUgBbdANokQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMo3hBX8GeMdL53WMeb8f+oFb+ZgvK88u9g588A/Bz8=;
 b=WZrnjyrzUavolmo7BVilXyhQ7EI7LR+eBoqLeGWmas3IyUj4CpMVOp9yK2VTnkahITUP+VfPldhxr2wARcpE3gDrXtMeMmoZviy1ViiS4kTVsplsiVhZ/0s4+VvKGajC3+L3au3POAq2jNfs8K8AmhWpLtw1eOmnEmJTzPb3+Be6tebEpd45jDRStbZ6ZzSUYTspxuoILnFK8CLaJu/ervBR23doYFemCmNO080swe6oKeVz/ARNMiKaxtr4/WLzVi+u74nRzZK6C/w18GN6TICePJTW+mrOpN6kP7EChXhtjq4pkA+8omlm3fAhHiEeIoCTXbjSMGd8LAmtPpTKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMo3hBX8GeMdL53WMeb8f+oFb+ZgvK88u9g588A/Bz8=;
 b=ZfVtg563NtoFPQ0Ji+loiZBtEshOFevKTV7Uuqc/Ckj1SAOxIXd5kwxD+D6Y8mdVgJb6QTxG9rkg1/L4zLuKs44TAjyzKncr7D40O5eOJIwdW+WJf/LSkpoGZfmNcEBaeM+V2q0CxJXNcOWQZmFFLWZgVAd3kbHcSUyeIxWBZ4+hZFCGm1wZ2AOvDdVx40S4+lx2NUc6+IM/oMjDRItCUaeIB1bAleNbz2nx/CyJpMUZ7pv4KuyM1uNXdRs4+vkDLVVZHHnDnDTBen4sRRTP7Ncc+xUus9z0JPpQl62er+shy7PW0CpvahswFOpK9IGKbNq7dS3zUa+79zM/dKqQng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:44:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:44:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:20 -0500
Subject: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=8867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pBEr3qIZ3MtXH8tsEo1g0q/TpoDEnc9FIkQttuF8yAU=;
 b=KZDByhYYt5+VS4oBF47h3gWxfMGGXGgWkRF98wXxz0OpFfcGPdbHAJ5LWbo/uwZaRYA941MNC
 1ndPTBaw00RBfTidx8qI8xR7bKYKW4l9+OWoXpUJ1XZcK5esbwmMvfx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7987f9-93c7-4cd5-77fb-08dd08d29d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExQUkRSWDN3b0M2VVpFbEU4emRmdUZRZDNOMHF4em8vc2ZGNVh6bkdnSXZ0?=
 =?utf-8?B?M2dWSmQzRElIUzNvTEY2N0txNzM3NmJYMlNJaVNsTzNJR1ZGaHRYc2tpbEd3?=
 =?utf-8?B?VG0xNDJueHhSdjRHUzhGdEZrc2Z0RU93UmhwYVNINmFNM3hWblYzM1MzUUpZ?=
 =?utf-8?B?RWFkNE15QUJ4SG9IWVRCeFhhUkRzTk5TajFoZ0hJWC9WK3lMUlBaOGdpek5Y?=
 =?utf-8?B?RG1PeFNtdXAzU3g3THBMNXJIdnd1MTNBWFllQmlPbXJNL3ZZL2ROK3FHYks5?=
 =?utf-8?B?K0FuZEVuQklLeXNFOGR6U3U1NmxmQ3JHMzNhVFp0bEpCbmxiRG5jTVJOU2RO?=
 =?utf-8?B?eFEvaVRIQW5hT3FtT2pjSDNvUTZvcjhldFc3c3VkcU42dS9ZaEZ0UkcybCsr?=
 =?utf-8?B?V3pqSU9XanJRa3BMVnNEM2s5TWdNOC9FRHRQNXAvdExnRGdyTytTMXFaSzNz?=
 =?utf-8?B?S2lncXBTdVVqVlJmTVlvN0N2YXJnQVRvL0tjZlpMd2tFdjZoa3ZONDhPL3VD?=
 =?utf-8?B?K09lcGlnUXQzSU4vTlhaeUcyRDNGNVMyeTNsd2VzNlFFQldvWEFObGQyaEkx?=
 =?utf-8?B?em8ySUZCRWhwTkpNeWQ4dzlnak1hT21sQm56YmJaSS9mcEFhYmVEWC9qZHAy?=
 =?utf-8?B?RDFrTDVIUTNXV0tmelRybFBMajFmS2VKNnNsZklwZ0JwSGEvd09kSEZCN05M?=
 =?utf-8?B?VXpDR2lhN0ZGcTdocURxY3pZQWU0clRtWndYbzlBektBR2d2MXhSV0NmN3dx?=
 =?utf-8?B?VmVZMlFYZjdmK3M4Sk12b2IzQkx3VFZIT0owYU9QazhuZi9KV3VabVU3TFo3?=
 =?utf-8?B?REdTb2lhb1lPcVVVTW82UTAwT2xKbTRtRURkdHNuVkpianl3T3hpRFluK2Qr?=
 =?utf-8?B?RUg3cFJxV2w1WHF1bERzbXc5UmhGWWtNKzY1dW1sSE42Q3plZ09uV3BxWWp3?=
 =?utf-8?B?QTlZTXJtRnNrVlRwdWlJTUVTbE1IRDhxY1cyVVlnKzV5QjhMV1R1amtybkkx?=
 =?utf-8?B?SmZaSi9QbUdrOXlDVGhhQmhMRC96UlhvWmNRYzJMY0JIZzIrVSttbjlYeEJZ?=
 =?utf-8?B?VFR4ZU1rTnFRMmJabzFiN215VFk3c2lIMWIxVzFaYkJyYnByUm9CWGpHbjA3?=
 =?utf-8?B?ek5BRnlOSU96OUJWbVlUbVNYNkxKeTV2RldKNGd2cGlLWW1pVk1rZlhXbXph?=
 =?utf-8?B?OVVvTi9SclY5V25tZlNxQnprQ0hEWGhJeTBkWllOTEdBQ0cyWEJ2TU9KZHFG?=
 =?utf-8?B?eHNkL0tQMSt6aE5wek1GSWp3K3VUdHZPYnhMaUxzajBSVmRtalZYVDROOWdV?=
 =?utf-8?B?UmpsMVdRaXp3SjliRVdFbGRDMUJSRHR0dUJFWVBYc3Bib1ZhRTFESk1pREJo?=
 =?utf-8?B?VUViWW5UaWlzUFJUU1FCanB5d0V5ZUo5T1h6M0RRbmN4SEx5S2I2aUd6NjJr?=
 =?utf-8?B?K3JrQ1Eva2o3RnNCQnVKZXhmdjFtNlJBZklTTUlrSlRlTG1OUk5EdkRDVkM0?=
 =?utf-8?B?ZzdRRXpQNzE1cm5IUWxvTnQvU3RUeGtiMXMyYURUTGo0S1I4UFBOZ09xVC9E?=
 =?utf-8?B?OVEwb2gwV2x0SDFZT2hTaHNkMS8zRTR0Zm5BS2RIREZaUnV5K1o3TnVnTHNn?=
 =?utf-8?B?cURzcmdoNEd4WEVtdmdDajNkNmhOdHkrWDMrYnF6TjNOcEVjUkg0bjB0by9s?=
 =?utf-8?B?Q29GN09pb0RjUXk0ZmVhUWtLN1F5YXZ3T0hZTTJmc3B0cEhUWndOclQ3VmFk?=
 =?utf-8?B?b2kxOTg1SDNWL05nZXpGSE0vUGRjSkhTTm0xeTJWY1IwNGl2VUdicVBEUmt3?=
 =?utf-8?B?b0tLNlBXbUE3azdwa2w4Mlh3YkZwc3hqTnZjWVFKSFhKYlB2QnFGYUZadmZG?=
 =?utf-8?Q?+4J7WhxCHWeiT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0lpRHEvcjFGOVFiNUYyRnRPVnQvbk5ySnkrVGNYUnZxbnlobkdhNVFiWEdv?=
 =?utf-8?B?QThoWjM2MExvUytrVjJLU1NOMGtiVUQyQjVBN0dldHZMUVM1ZVBPMHhsb3U3?=
 =?utf-8?B?S0hUMlEzYVljU0VOMmVBMGx5c0RlLzRDTmtEUE1acHJQbW5BTE4za2J6NkFl?=
 =?utf-8?B?RmpiM1RDZkFGNlF1TFZNVHVzcmdiSXRJN28xNGp1dkhwbysrWWF6Y3V1MTlR?=
 =?utf-8?B?K0F1WXRZK1luV2hSQmNLVlpnVS9MamRTV21keEhkeWdXa1g4K1pYTjg1NUJ4?=
 =?utf-8?B?N2g3VlJFUWNmdG1kWHNiWEJaMzVraFRVYVdKZmxrUk5vd3o4UDRQRjFiSjIv?=
 =?utf-8?B?WFlOM3YrSk90T0YwR1I3anpyNnpDMDdhU2ZOczlqWTR3VzBZWnk0amJSNUJT?=
 =?utf-8?B?RHFQYi94V3VCVzAwNFMreDJHM2h0b3FWMVFXVE01Ni9aQzdPMDJ4U293VUdB?=
 =?utf-8?B?VTQzQkt5aWQ0YU02a0MzMmlpM1B4YjFKNmdzMmgwaHB5RzhqckhGckYyT09M?=
 =?utf-8?B?bll0QzFoN0FpNHV6T3ZreU9ScitFK2tmYTllanZxREdWaklxSkU1RVpLR2JS?=
 =?utf-8?B?bndrdTBhM3V1NU1IWGVUSnAzNWN0aXhrTjdqaXlKclh4TnJRaURoUjhBTXVQ?=
 =?utf-8?B?bkxBMFRKbG5Oam03Q2hOTWxOd3Z2a0gxRmNyZ3NrNEw2Z0FQVHB3QkFXNThu?=
 =?utf-8?B?YVB6RWVOUUlKQkR3MUI0UnRCbGlSKzRKcHhnaCtTQlAxZmIzT3ZBY2tkekor?=
 =?utf-8?B?eGZHdXlqakdWSGFNclN4anNudjFsS0J5OW1XdUtYU1BJbGFwOEJPeTBQSlNK?=
 =?utf-8?B?dzN6Ui9QY29EckU3YUMySlhzNFh5U1BNWVZySmVjYzFwMlpaaW10YXNucWgv?=
 =?utf-8?B?SWgwNUd2WWFxdVNreTU0L3ZoRHgyV3Y3QnZpYXFrR1FvMUJwRmdNMjJROXRB?=
 =?utf-8?B?SmxBcFVCb3dNb1E0dThVVHkyK1IzWEdGZVJqbXRkeUQvdTQ3UCtFaDJoRGFP?=
 =?utf-8?B?MTZGb1RhQVpFc3BCSDlKOUV4UHdHR0V5dXl0RTV2SXVDYkRpbmRJZXVkMnVX?=
 =?utf-8?B?bXdlRG5RT3BoZFZxdDNaTElpQXIzTTQrWVFJeXc2Rk5xb1haT2FncUc1K3Q3?=
 =?utf-8?B?NVpSMHdTVGJHeTJsdFpqY25IQ1FTNjB2WEZzeVdBSkhEcTg5TDJmS3Fsa2l2?=
 =?utf-8?B?alVWNHNsVHl2b3p1MWZIbHBrWXNiSzNmaXB1cTNVOXFuNVZmZmtBRmV4Z2di?=
 =?utf-8?B?aVdZVjk2bGMrb0RTSTVzcVY2eUhWYmpqdUZCaTI4dVN0clhYdkJxMEluOExK?=
 =?utf-8?B?ZWwwU3owTyttNGZ5SGdESjljSXhzQ05zUHBabUF0YVI3cFRzRzlqQVZUYzFP?=
 =?utf-8?B?K3R5ZUh1VlJhbWpoT3dySGttNEcyVTdGWmtNWTh2ZnhpYzdqM29xZ0Q2S3Bw?=
 =?utf-8?B?d0YyTWZselNEWmRUQnFYd0lVY1V0akhjbXo2bW1qeVJBMWppbXRCNDhRR3hw?=
 =?utf-8?B?dWo3KzFuYXVqdGJYVWdieWppT2pKc1IvN2F5TE96bEw4a0xEUnk4dGRKM2RW?=
 =?utf-8?B?NEI1SjBqeHluaFpwMEVzREF0ZFUxN3JHckNqSVBJTDFNWEZLeHJlZE1RSFlh?=
 =?utf-8?B?ZG9XeS9DYWVEd2UydkxMN3JsN2ZBMXIwM0FJOHh4ZGlHaSs5TnNJVGNRL3ZU?=
 =?utf-8?B?eGZXUVBjL2ZJMjJoZGlteUJaU0cyK2J4QTVKVVRsYW14THA0WWt5Ylp4Qnhi?=
 =?utf-8?B?Y2RNaEFRQThkajdCK0ZaNDVSM1FQYmI0REtLdFQ3bmpzeUtHaEdUOVZwNTlm?=
 =?utf-8?B?SUpVRFJ2V2lybXhxa0VVdzlUak1aSTJtVDJrcmVzWmdTZ1VlRFZxdlVMbmlt?=
 =?utf-8?B?RnNyeVdNWFVpWVhKMzhHQkRzRmFoNnNlTVJrWGdiZ1ZzcFFLR0Q1eXBYc0Vq?=
 =?utf-8?B?emd6ZmhQQWdhLzh1NURZRnJwdklMci9paDM3RHlPbjRwQ3ZNaFdMN2NHNmh3?=
 =?utf-8?B?dG5QWnd5SEp6V1VialFmdUJMVWRFRW1Bck9PeHFtVEdpRFJWbUVyQU8wMHVr?=
 =?utf-8?B?MER1Q3B1OUoxRXMwVlcxbkRDbllVYktoYUNGaEFzNktIS21XQzh6UUsrNUhM?=
 =?utf-8?Q?xHUA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7987f9-93c7-4cd5-77fb-08dd08d29d6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:44:44.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7bHEOBH8hZEi5Wb+wwBJCcdXvxd1iOl92kC8RtRKHqy8OICK2LHXkICz9veKa1jsTtzwpxozSuIGh6DVr/96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

parent_bus_addr in struct of_range can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term internal address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v7 to v8
- Add dev_warning_once at dw_pcie_iatu_detect() to reminder
cpu_addr_fixup() user to correct their code
- use 'use_parent_dt_ranges' control enable use dt parent bus node ranges.
- rename dw_pcie_get_untranslate_addr to dw_pcie_get_parent_addr().
- of_property_read_reg() already have comments, so needn't add more.
- return actual err code from function

Change from v6 to v7
Add a resource_size_t parent_bus_addr local varible to fix 32bit build
error.
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/

Chagne from v5 to v6
-add comments for of_property_read_reg().

Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

Change from v3 to v4
- none

Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 57 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.c      |  9 ++++
 drivers/pci/controller/dwc/pcie-designware.h      |  7 +++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..f882b11fd7b94 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_parent_addr(struct dw_pcie *pci, resource_size_t pci_addr,
+				   resource_size_t *i_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	if (!pci->use_parent_dt_ranges) {
+		*i_addr = pci_addr;
+		return 0;
+	}
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.parent_bus_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +469,20 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		if (pci->use_parent_dt_ranges) {
+			index = of_property_match_string(np, "reg-names", "config");
+			if (index < 0)
+				return -EINVAL;
+			/*
+			 * Retrieve the parent bus address of PCI config space.
+			 * If the parent bus ranges in the device tree provide
+			 * the correct address conversion information, set
+			 * 'use_parent_dt_ranges' to true, The
+			 * 'cpu_addr_fixup()' can be eliminated.
+			 */
+			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+		}
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +505,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	ret = dw_pcie_get_parent_addr(pci, pp->io_bus_addr, &pp->io_base);
+	if (ret)
+		return ret;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -722,6 +769,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		resource_size_t parent_bus_addr;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
@@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.cpu_addr = entry->res->start;
+		parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
+		if (ret)
+			return ret;
+
+		atu.cpu_addr = parent_bus_addr;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c6..e1ac9c81ad531 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -840,6 +840,15 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 	pci->region_align = 1 << fls(min);
 	pci->region_limit = (max << 32) | (SZ_4G - 1);
 
+	if (pci->ops && pci->ops->cpu_addr_fixup) {
+		/*
+		 * If the parent 'ranges' property in DT correctly describes
+		 * the address translation, cpu_addr_fixup() callback is not
+		 * needed.
+		 */
+		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
+	}
+
 	dev_info(pci->dev, "iATU: unroll %s, %u ob, %u ib, align %uK, limit %lluG\n",
 		 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
 		 pci->num_ob_windows, pci->num_ib_windows,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..4f31d4259a0de 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -463,6 +463,13 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * This flag indicates that the vendor driver uses devicetree 'ranges'
+	 * property to allow iATU to use the Intermediate Address (IA) for
+	 * outbound mapping. Using this flag also avoids the usage of
+	 * 'cpu_addr_fixup' callback implementation in the driver.
+	 */
+	bool			use_parent_dt_ranges;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


