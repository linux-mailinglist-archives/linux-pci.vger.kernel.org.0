Return-Path: <linux-pci+bounces-34123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBDFB28855
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 00:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AE13B299B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649B26E708;
	Fri, 15 Aug 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQuLBdHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28C25F78D;
	Fri, 15 Aug 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296506; cv=fail; b=lY1RtID9x8eKRtWRTe+tFAWPeE9xOh4yb/zqTnt8rAN+oIIIDzrkArqrdmY7CIYK07tyKLjKIPq/LUtw4LT9Hc/5ROw1sGf0joT2BlH1UdlNMD1AJWyemu/UIhUUfhFG9dMLRdpjMvDaLTkaRWoXEKAwsoNFGOKw3F3M9bViM70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296506; c=relaxed/simple;
	bh=/ewaBgqKg6QF6pAR/4LoDeeqxxh8vtU9sJ3wJAtWxT0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QUxRtWsr3RRP2Jk5CSE7YAwNCRk5QyfA2W7Y22nJWQMnAFwm7AJdbdp9zeAag8Cr1pamRmQCjJ6IQytkHMLny+jWMp6Ob+hG4fw+JvMzaK0mS283IMErTCSG2Yl9nHrcqW+K/2t549C5cCmSFM/RWdEohcMmlunyMt7oqoG/aos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQuLBdHb; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCgUlmecbNZHQ8b8hKrKFkKjR6nK4lrgSYcddnRlFj7SBfZH9oluEyLFKKPUlJb9VTYFF8c2Zr4FEgN4Nl6cN4QGS7TWlcQ/o3P9vm04TQ3FC1EDCh6ChWygcu65tLVa0E/lcWZ6+Dm5QIJU7Asyscg1XevlClku4KPBpuFSOkebu6+2y+8GyBBB5TU4FzodcUUSkRA3vf+Y9z1Yu4NkX5E/OmMAA1VjW+CE4otX2ppuag+gzQnFCFv+goMr5viuiAg4fuIsjixAzI/t12SkFIULPYEAPayfiWzT9+AFvp0zzouvhMPOYz1/ALlFNK3UVjpDQ/itKcN/DFMMtScidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNs/TkenyD23bp8b/i+p0+nsz/9eDvM2Wmg6eh6cuIM=;
 b=h/X6TTFNk/tiTGEco6jsH45k47K4Pwze/qPvcHrft0msQSBCPKTxBMYCIKk3rOKaInSVN0EF7Qp+W0isK2Xy/LLX8q+vgJypZ7hMPrReQyAHVkkDiYni59jZ7nfMNdLNNIplOwhyqbBzMB+xUOSVAJ03DblK3bK5I/7drEqHCl6ZL4b5CHp9J3jhHRG2ZqgHV9N++qKDQFZj6pKTflq6H/BPXlbhRA3Gnhxj+EVuJa+1MajpJIaW2kOd2x4mLBoIo8tub5fl25pi8da9NW3mSq4hJt+0ILKfb4L0F5FClRXVqTRuZIowm9w+udRgj9TWAvZXhyDHlaJm+j6AI3WXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNs/TkenyD23bp8b/i+p0+nsz/9eDvM2Wmg6eh6cuIM=;
 b=iQuLBdHb5WlDgrN5YCvGVIK3aGXxWUtgIYaikFbs6dnrl7YISx4gXE//XWAJMgyD4NX39+C+mduwvv9+oG7+zmi0NWxtvTT/oRk8WTm3X1b31R8IhN5HJFbum4lgLd2kPLQS/vGBWTI32btD1ACEMg+VQdpx6atvNJWADkvbAgvEvwslhQLn0i0gUfMS6yEzDOma3emu1tfp8dbYpjI4ZmIqL3sTawwbo2ZDqhKUe2dLlOPJ0ulPvPQA78e5wdujtG1IsDtUIPRaG1nV3zxVfwV62ztAloqTzALUndGcOhnYwgnRhzFz/C0ff2lCiJPfh2ZOSIMWclp/HfrFsgEjKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6949.eurprd04.prod.outlook.com (2603:10a6:20b:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Fri, 15 Aug
 2025 22:21:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 22:21:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Aug 2025 18:20:53 -0400
Subject: [PATCH 1/2] PCI: endpoint: Enhance pci_epf_alloc_space() and
 rename to pci_epf_set_inbound_space()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
In-Reply-To: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755296496; l=7383;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/ewaBgqKg6QF6pAR/4LoDeeqxxh8vtU9sJ3wJAtWxT0=;
 b=xph1MA24fu5oqRB6unkO33bhPNNNkL7P+/n5HQJJcmZ1KsTIMejTrQsthb6a7YY4Gav2y04+S
 hZGa9YrYgZ2A3jwHLCJX1/qvv9wR4hTdYgi7SrgP1j4RO01vKu4AjAJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f47be6e-b2ef-4379-70cf-08dddc4a1c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFVNaDhHVEJDWHlzY01pSHdxQXNTckhCOHo0R2xQcUwxVjczelk4MWRMS09I?=
 =?utf-8?B?UlQ4SzlJME9mWTl0Z084Z2RMOHFKT1g3d1JqdzNIZHhOOVFFaDRxVy82R2lv?=
 =?utf-8?B?VmVYYmJsKzZUaHU3bjFkeFFwUCtEWFk0U2FXQTkwQVYybUVTUGlwQnVXZ0VP?=
 =?utf-8?B?ZlIvaldibG5HUVJRdGtyOG03bSs2UUIxVlR0VytzeTdlZ1g3WTBrYzBDRzZo?=
 =?utf-8?B?TU5SY0kxQmNWYncyS2pMb3hKZ1E1R1NjalN1MWZKRXArMW51UFRCTW1id2NE?=
 =?utf-8?B?K0lZOWt5OFBTZDRiOUF1aWRVaDV1OC9VQmZGaHQ2OGZTaG1UMitmOU8ra0Rn?=
 =?utf-8?B?TUVQNEdnUXk4K1htQll2aEFuV3puQlZFODIxZG5uakZWRlpzdXhrekZWT2RO?=
 =?utf-8?B?R0dYWFViQ2Y3OWtJOENGRGZBaHdJTXkxTVprUHNoZktMSmV2V1NyV2ZJSjhW?=
 =?utf-8?B?aE1VYWtFb2R3VWtXVmZqdHV3VVM2OEptdm1QWC8zT21hM0p4Z2QvT0NzUzFH?=
 =?utf-8?B?Q0NUeFV3aFYvWHpuODRuNUdWWlVseEVoUEk4cmJseTRpODR6dUFOSGg3M3VW?=
 =?utf-8?B?WEJhcHQ4L2dqaG00QlpNRkpiMVVIT285NFNGejhiTmxXOFVnclVMaU1ucU13?=
 =?utf-8?B?TUpGRmNxOTlLdzJQNGR2MVJ6eEJtbkUyQkJ3cUNjOGVHZjFwR21vYnJkb21Q?=
 =?utf-8?B?VENpeURrVllOelU4Q1paWEdabVdGdFFsTVNsaUsyaHR4alRsczNtM21DQ1BW?=
 =?utf-8?B?WG1RelJZN2ZlNTlza2dhUlVSZ2ZoZVE3a05uRys4Tm5aRnozeUZIWnYvK05K?=
 =?utf-8?B?RjZwYmZrOVZEZXdGb3lWUWtTcjZzdHFkVXFORkdYL0V6YUZaL1h4Q0YxMGxv?=
 =?utf-8?B?UnVFV2JOdEF6NVorQVJhY005b1hqbWtIZW9kbktRZloxOWZURnNQS3M3dFJN?=
 =?utf-8?B?MlZMTGsvUnp1OXp5cDBndFBHdElUdWU1MXI2b28wMVZ1M1BkNXVIY3JJN3Nq?=
 =?utf-8?B?elNlVk1ZSEd4RFEzNFRXaThBUmNHY2FPVG0wVlZ4QStQQVBOYkZYUFh6a1FH?=
 =?utf-8?B?dkhURmJYc0dzOUptT1dRd09pOGJLMUdxK1VQZ24xaWp0ZFdIWlkvOWpGWXJ3?=
 =?utf-8?B?NmpJdHBRVG1iVzJ5VjlCL3VSZG5tQ0hKZlZ4QmhtVTN5NjVmN29TTDhFdHcr?=
 =?utf-8?B?S0Uxc2hFdmZjTmEvb1AvMll2ZXJYRVZIcEMvZzNKdmV1dlN3L0FaR0lNL0Uz?=
 =?utf-8?B?dWJuSHF0MWx2UGlUd2xxNGRUY05HQ0MzT25TT1lGWjdjQUNoamdRQzJ0TDZG?=
 =?utf-8?B?R1BDRGlsaTI3dWVPd1RRKzJNMGpHdEhtMEZnM08vUDdiaXIzS2l5cWM1anpS?=
 =?utf-8?B?K29wTFVMTktGVitUbWc2OU91V3VZQlFGR1pGZlZrbFVWdGRVaHgxcmlwWTZD?=
 =?utf-8?B?MmdjQlhLUTc5WnIyVTFaVndaYmpuUVBLSzZGV0taTURDWWhmVzk0MFdiRHFQ?=
 =?utf-8?B?OEFWV05zUkVydDFFL3VFckNiQUhzYjlxMGxyNkNjZ24rbVRlUVRFbWh2Z24z?=
 =?utf-8?B?NzZIcUs2SnBXMU96NldpNnJCd3diRnBYSGNOZU9NRlFGUm9Nd21veGNqcmY3?=
 =?utf-8?B?SnA1cUp0M0l0azEwN1VSS1QwbGlaUkJwQjRrVmhJTjgyZVFLZHlvd05WclhG?=
 =?utf-8?B?Wi9OZHE1bE1EWmJWNDRZLzRBR3E0OFBObGh2Y2ROdmRBSE9OTW55alREVWdP?=
 =?utf-8?B?UHd4YjVvREN2NFV3ZEhHeWVhVE1lOVNCVlNnM1gvSTZBUGI4R0JFSG85eDhs?=
 =?utf-8?B?RDZ3ZWd4dUtSWlN1SENnUEJFcGpCajlzWk15UkJLakgxZHl3aTVOVHloNFlM?=
 =?utf-8?B?cStXdEttVVN2NU00T0kxYmNLVmo4bjVUYTFJRkFzZCt1TUhyZEtiRXdEdllP?=
 =?utf-8?B?SjBGY1JHVVR0UVdqeFVybVduVjZ5eGdDM1ZtZ2g3bk9CdHNqRTF6a0FqSGph?=
 =?utf-8?B?eWlpK1hpd2tBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjMwNDNSVEFuOGFRNmlIaFVsTE9qZk5XMUxvdER0Qmh4VFhhWCs5YjhxMnBE?=
 =?utf-8?B?MmRMV2VEbFNmcHNxWUtFMzFyMi9jeXZici9SdktsMXRqWlNzZy9KYlV6dGlt?=
 =?utf-8?B?L2tPbU91VGlxY2ZybzhGcEttNHRVTFkzMTVqVmVhS3oxMk0yREF5WENUam9R?=
 =?utf-8?B?MDV4SlVkKzJ0QktQZkhHT1VnMml0dWVFc1A5UUtORjdzWTFualpKb0Y1Y1NK?=
 =?utf-8?B?dlVIKytzRWhQNDNYNGFMN01WZEJlL0Vrb1BhMmVuUkdoaWcwV3lrSHE4bnd3?=
 =?utf-8?B?NVNyOGxiaW1nb01MaUNBMHJKVzFMM0pHKzd1b1pneWlEZGR3b1J4T3pIeXpG?=
 =?utf-8?B?dE56NHBCZWZPSjdLZTFDUUJyUWZjYWs4OUUzN1JORE1TcllQcUNKbGh6QnI3?=
 =?utf-8?B?R2tCaTlmbVE2RmFyVy9VQnJUM1pJQjRsWDV5WWNrVGlOUGJnWVA4MEplMWdR?=
 =?utf-8?B?bnpvK3VjTXZCRjgreXhjVzM1QUNYRVhUcENqbCtmNkFVVmVNblNFOXFIeUVR?=
 =?utf-8?B?L0szYUpLcVBOOWZ1c1AvU1BOaUZFRU14TjJ4ODFGazduSjZMdE1BTVU2c2dT?=
 =?utf-8?B?cHFLMlN2YmpJZkxlTG5BQ0NteCtpMTdIOFhLMHJhQnJCY1pwdE9jT1d0cjlh?=
 =?utf-8?B?K1BTblY5VlRhajhlbGRDaVlXTkVuZ3VIVjdEbXlGSG5vT3U5TnI1T24xdEY5?=
 =?utf-8?B?NWhyWGxoaXE5aDlHdkVVd3VOK3htSmNRMXFJaWphbkV6WnFIaFpudG1RM1dW?=
 =?utf-8?B?YVIvRFBiY0JsMTdRbHNBSHJkb2I0UHp4VVY2TGlUN01ObFZGNmM0T0lqL0xM?=
 =?utf-8?B?c0pRcElyVWd1QkpBVUFTSExoNWJ6ejZyc29NdlhSMCsvYnJ0VDN4cElyeU9S?=
 =?utf-8?B?alJySjdSYWVlZUFvVU15a0RBcGJzRXpkRE5ZU1VtRFpZTmM3d2lPanFob2FG?=
 =?utf-8?B?ajdDWWtVWXFWdm1zdUcwa211YjFwOWx6WlVnY0FIZlE0VU5qRk9kZVEwa1U1?=
 =?utf-8?B?VHdwNUhpaGlxMGxBVjF5KzJRUTJyQzJUVWExMWQrNjhNWVBFK3VIcmFjbGN2?=
 =?utf-8?B?UFVVVUN1ckFkcS9yS0tpbUNvTXFVTUZSdy85UjZpWVpMbVNrVDFJOWJ6TVdL?=
 =?utf-8?B?ZnZVNnZWcyttaGtJamJkYWNtdE0xNUJNaEdlcy9SR2MwZGp2bGd0V2VIdStq?=
 =?utf-8?B?a0ZLZ2t6MzErdFoyVVlVcisya3RwOTRpWlNQazVjT1NlZG5zVitOMkJSQStv?=
 =?utf-8?B?bzFIQlBWdmdrTkwwWHd6TXV6OXRFR085dUJvTUJtVXhQQUx2eEI2WWRqbnhK?=
 =?utf-8?B?SFZYZ0NSdnZ6dU41MXZBMm43ZXdkZzdTVTVVZm4wMkplMGhaTWtpUU5iVm1q?=
 =?utf-8?B?T2tyRElhY1h2Vk0vTk5jM3lyai9sMGZ5QWZielFsVEtQOEhFY2R5UVpmV25X?=
 =?utf-8?B?QWNNT3RTdVJ5dVVWb2xscmNiMEV5WXZBbTNqOW1pRjhQY09HcTNLSzZUYmYw?=
 =?utf-8?B?ZVQxWmp3czdQVVpjUGZPZklGNmpvR1duSjJCTG9UdFNKRkRhZkpPa3VDSTdV?=
 =?utf-8?B?M2ovdmZvQ2IwaHFiR0hxRG8xQjJQM1piZSttZEIwZDZacXlyalJFUjBZVXpH?=
 =?utf-8?B?T2J5Y1owekhZWWV6SHk1LzFIYitYUzNDeGxBQ254dTZ0Z1JWZEowZzlqMnZk?=
 =?utf-8?B?K1l5Rm5FbkFmSUh2Z2QzTlZWQzFYc0xlL1piY2hNVTRzcG5MQ3dOUVhYSXV4?=
 =?utf-8?B?L1FmTEVTZ2QzclMzV1dHZlJrMGhDYkVzRU5ZQ2c4djgxUDl4emJMR1BjZzg5?=
 =?utf-8?B?ZG1rdzNBSW55dExGdU1nQW5DcERXcVBTY0RHSHRxRUNNWFRVQmZ1UFFneG9p?=
 =?utf-8?B?dmNOWEdzUkowYzd1TFg1WkJScWV1WkNxTEp6b2JSQ0NKcGdsT1J2R1dIT3k4?=
 =?utf-8?B?QjlPSUVyM2tEUFhoQlNKZGxqeVdKRXhucUtQSC8xVWlndlVmL1dUZFlLRHhG?=
 =?utf-8?B?dndwOU5ibHBFSzZYek5ybHZsV05uMzZDV3kwN2lpVkZBL2hOSmxzc25kb3VG?=
 =?utf-8?B?Um1BYXBBaHkzMGxtSklGc1hWR2xseVR3Q1dRRktwbjJvQjlDNFhSNHVicjI4?=
 =?utf-8?Q?AV1BTjdedhHnF7Q8u7OZAypgG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f47be6e-b2ef-4379-70cf-08dddc4a1c1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 22:21:41.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgErCriuvIGZhj5UNNndXNe7Ouw6kJpHnt6nGy9Knybf1tPq6UELA308L16noxHme0AUSuJhoNhppojL6Erpng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949

Enhance pci_epf_alloc_space() to handle setting any physical address as
inbound memory space, such as an MSI message base address. The function
already accounts for different alignment requirements for different BARs,
so reuse this logic and rename the function to pci_epf_set_inbound_space().

Make pci_epf_alloc_space() inline and call pci_epf_set_inbound_space() with
from_space set to true to maintain compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
---
 drivers/pci/endpoint/pci-epf-core.c | 69 ++++++++++++++++++++++++++++++-------
 include/linux/pci-epc.h             |  5 ---
 include/linux/pci-epf.h             | 35 ++++++++++++++++---
 3 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d54e18872aefc07c655c94c104a347328ff7a432..5b802b1ea3e28a32e38f4ab6a649cb97a2f29b95 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -249,20 +249,26 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 EXPORT_SYMBOL_GPL(pci_epf_free_space);
 
 /**
- * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
+ * pci_epf_set_inbound_space() - set memory for the PCI EPF inbound address space
  * @epf: the EPF device to whom allocate the memory
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
  * @epc_features: the features provided by the EPC specific to this EPF
  * @type: Identifies if the allocation is for primary EPC or secondary EPC
+ * @from_memory: allocate from system memory
+ * @inbound_addr: Any physical address space such as MSI message address that
+ *                work as inbound address space. from_memory need be false.
  *
  * Invoke to allocate memory for the PCI EPF register space.
  * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
  * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
  */
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
-			  const struct pci_epc_features *epc_features,
-			  enum pci_epc_interface_type type)
+int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type,
+			      bool from_memory,
+			      dma_addr_t inbound_addr)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
 	size_t aligned_size, align = epc_features->align;
@@ -270,7 +276,32 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
 	struct device *dev;
-	void *space;
+	void *space = NULL;
+	dma_addr_t up;
+
+	up = inbound_addr + size - 1;
+
+	/*
+	 *  Bits:            15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
+	 *  Inbound_addr:    U  U  U  U  U  U  0 X X X X X X X X X
+	 *  Up:              U  U  U  U  U  U  1 X X X X X X X X X
+	 *
+	 *  U means address bits have not change in Range [Inbound_Addr, Up]
+	 *  X means bit 0 or 1.
+	 *
+	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
+	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
+	 *  [Inbound_Addr, Up] range.
+	 */
+	if (!from_memory) {
+		int pos;
+
+		for (pos = sizeof(dma_addr_t) - 1; pos > 0; pos--)
+			if ((up ^ inbound_addr) & BIT_ULL(pos))
+				break;
+
+		size = 1 << pos;
+	}
 
 	if (size < 128)
 		size = 128;
@@ -283,7 +314,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 		if (size > bar_fixed_size) {
 			dev_err(&epf->dev,
 				"requested BAR size is larger than fixed size\n");
-			return NULL;
+			return -EINVAL;
 		}
 		size = bar_fixed_size;
 	} else {
@@ -308,13 +339,25 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
-	if (!space) {
-		dev_err(dev, "failed to allocate mem space\n");
-		return NULL;
+
+	if (from_memory) {
+		space = dma_alloc_coherent(dev, aligned_size,
+					   &phys_addr, GFP_KERNEL);
+		if (!space) {
+			dev_err(dev, "failed to allocate mem space\n");
+			return -ENOMEM;
+		}
+	}
+
+	epf_bar[bar].phys_addr = from_memory ?
+			phys_addr : ALIGN_DOWN(inbound_addr, aligned_size);
+
+	if (!from_memory && (epf_bar[bar].phys_addr + size < up)) {
+		dev_err(&epf->dev,
+			"Given bar can't fit required inbound memory region\n");
+		return -EINVAL;
 	}
 
-	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
 	epf_bar[bar].aligned_size = aligned_size;
@@ -324,9 +367,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	else
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
-	return space;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
+EXPORT_SYMBOL_GPL(pci_epf_set_inbound_space);
 
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4286bfdbfdfad2754d763be2b8474e5d2d403a1f..5f1d8787c3bb7a6130adb54c079a48c82d5afcf4 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -13,11 +13,6 @@
 
 struct pci_epc;
 
-enum pci_epc_interface_type {
-	UNKNOWN_INTERFACE = -1,
-	PRIMARY_INTERFACE,
-	SECONDARY_INTERFACE,
-};
 
 static inline const char *
 pci_epc_interface_string(enum pci_epc_interface_type type)
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2e85504ba2baf93827224884ca19ae2bd0e6906b..4311a8ba1081b8a8aa327c8ed10f9c5d9af2feba 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -17,7 +17,12 @@
 
 struct pci_epf;
 struct pci_epc_features;
-enum pci_epc_interface_type;
+
+enum pci_epc_interface_type {
+	UNKNOWN_INTERFACE = -1,
+	PRIMARY_INTERFACE,
+	SECONDARY_INTERFACE,
+};
 
 enum pci_barno {
 	NO_BAR = -1,
@@ -236,9 +241,31 @@ void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
 void pci_epf_unregister_driver(struct pci_epf_driver *driver);
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
-			  const struct pci_epc_features *epc_features,
-			  enum pci_epc_interface_type type);
+
+int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type,
+			      bool from_memory,
+			      dma_addr_t inbound_addr);
+
+static inline void *
+pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+		    const struct pci_epc_features *epc_features,
+		    enum pci_epc_interface_type type)
+{
+	int ret;
+
+	ret = pci_epf_set_inbound_space(epf, size, bar, epc_features, type,
+					true, 0);
+
+	if (ret)
+		return NULL;
+
+	return type == PRIMARY_INTERFACE ? epf->bar[bar].addr :
+					   epf->sec_epc_bar[bar].addr;
+}
+
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 

-- 
2.34.1


