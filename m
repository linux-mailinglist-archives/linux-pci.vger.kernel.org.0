Return-Path: <linux-pci+bounces-18187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67B9ED802
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC216978A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A85242EF4;
	Wed, 11 Dec 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ztx7JL0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD6240363;
	Wed, 11 Dec 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950701; cv=fail; b=SpWLxAB/FBk1sLqnjnIfKIIA6y7wAk85yF8hNZ0jt52IHAMUhVfaI4cv3zd+51HmP7+vCGS9bApfypEk1OfCt7SpFEsjF8v1JmKoZp3Uro4G3nOYZavGXhdtpqBhHfnxGK9Mxs3WE2shMznLbdVL3CpBRcM5nvkSa/E0UrctTzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950701; c=relaxed/simple;
	bh=NSt1w7/3wmlPaEh5ctXXeRua0ok+RFcPLkw2FWIyCuo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Mm7MlhGX/bZ0R4X6WpaMZRVOvymwtbkO7VEVx0WRe7MvYqaYokxnf8hcWfkxjpbsmm1mQA5wFatYH6XucYOGIh+n93q04DeDwkjQD/U15ExhhvFuRrCJHPBgqKIOBci/2aNA9qy/Wrl1fiKiKC9+TDDbX6it/6YSjnlMkdczovg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ztx7JL0o; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk9JGHQXyUaq5PxBDwg7NvuWtwh+Khw6k3ixAjtQ3nOo70YU149ZPd1XDLxSFk3pOx6LQfeCTrJMJVg2/26bn41km4DDos/1W9FUIWKewkYciUN2enFkHOMz+xVheaD/oPO7jFCReUPBzmja8n+KAJggH06gm9WlTOYXCzVQdQMWcIcNK0pjG0uvWt9A9m9pTM5IPvftSQL/4/2isoB9W7CCKesgsxrMHrlaGqcd1rlXGHVrtuQzGS0DUB41x41wGG8ijB9KUHQZojlE8sWbeaTyARPcOq/LO7owT82i/bnlXq0ZYQWl2mJaLym0ePTRUPRdL9xXhGMSDP64BQZSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvGhWu8Gge+T262HkUIK7US4UiQybpzMJMwLoHNGRwU=;
 b=XW0mBMqG2INDVwf+wprT1zaRFonCaaGYoMVOQuUZskpl77Q31iGdXpTjSogV43HMoBFbTjI5C3C8pGRYq43xYTGejhOTQtiUpPB6vnADVyTUwx5SUeF7OuLQEP6NbXorWcQ1qtnc0o8SDrWrvSkX/CE8qNHZbGTQiyhg8x8aQB9KCXw/nOII1UGG9X9IRQmnDsvDb7nfodBRKxKOPrpZLvq7wiwIOXiyjgi49w3Oise0OqaYRquz/d66tf6tMjerqRVVe4CQ0/Yz8Hf9kVNsWttsTa13JEBWnaHLV4ctN2zeVWBqZQkYv6ovmXqm+YfAs7IjJN6kXlWWcfH6odVxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvGhWu8Gge+T262HkUIK7US4UiQybpzMJMwLoHNGRwU=;
 b=Ztx7JL0oRheYfL8mkw4IWxVH8FjXov1hSIh8NAp3I17w6OWJvS4Tz4868HnfogH4NhtK/yxiHlgFacdHudumIqtFJandZRszYFQedPq6kFlKxKzrLrGGpnCSI73SdVhXGdaT0xJbfByXQSkmaMlxcdJOSGmcW7dP83OzC+/gtAVqyMXtrRxd0wIh+dt5fkiwTqwq0XR2fCwQRGy3k7PbdbEO4HRh3U1u4tVhg3ZNvd/BQ/JkRt1Eje1IxE4K9GVWEDpegCD4k2Gz70eVXTalfLTnZoRk//oq4OwkXVY7yyOLimmPdj719gzXOMOVBey6VM3p7iGZIKBBpVOWL3P5mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:35 -0500
Subject: [PATCH v12 7/9] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-7-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=7892;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NSt1w7/3wmlPaEh5ctXXeRua0ok+RFcPLkw2FWIyCuo=;
 b=naHZNzdpwoG3x0/z5Q6iRQMjrj4BbsUwmHXU2VzDjweC/9l9EY1MwTeZ5H3BdQHT7kFF8DV2g
 oCqWk3zyeaeB4egXZPNE+AIjc887RVYAt5GW4BjYDGoSLGNuyAaPuCA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8b3db8-4504-4b4d-be26-08dd1a2689c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BNWjFma0t4MzNudGtaVyt6SWhQNytiZnJNc1Jvekw0MzJxd0gzUEJCYThD?=
 =?utf-8?B?cVVwWUtmWjNxcnZGWUV3SzZrNTB2c3dxWUtEOWlxWTFhUjhrTWdaRmtzQmtV?=
 =?utf-8?B?RTA1em04VVJ4UGtkdEJsYWs1SUk1WFJlZlNTdEFjeGdseTZRbzZqYVpZcUdi?=
 =?utf-8?B?WE83VmxtVytRMGUvN1QwZnRtYTJ1K0pIN0QyK1JwVG1yKzVMSFZMWGx4b1Uz?=
 =?utf-8?B?TFNqSFQ3SWxDQkZDY3kwY2FMbS9ZczBZWEtDNTJXVEtCWUpEUlhLaTQ4emRV?=
 =?utf-8?B?WnFMbEZqd0src08wUW00TnIrYTluckpNaVlPL0JrQ2lLWXFYM09EMk5SbU52?=
 =?utf-8?B?NEpFVTUrY20yL1lwZXRmRlp3L0g1RDVwR0M2MitMZ2J1OHFzQnRPdlBIdGlv?=
 =?utf-8?B?VVhCSHRzMExsYUM1bHEzdlFPQ3k1MURJTTBTdndzWmtwM21hZldsMWxtZTRJ?=
 =?utf-8?B?N25UNXVXbS9pZGp0NWs2VnNsMDljK3c3dVFyWXh5cG9EZnc4WXBLaFdONnNi?=
 =?utf-8?B?UHlHMWtxVDMzVkJTNlByaUdFOGNuMmNGR1cwTnQxSk00V2dqMEJvMjlaQkdZ?=
 =?utf-8?B?blVOVkltL3l2SWRnY0tmUGVzaU1DNldDVnhFMzJSMWhKbXN3NGlZeWIvTHVz?=
 =?utf-8?B?Vi9lOHFzQXNYbktyS1NFNXNjU0thNThQKy9WMkpyTHkrVXdvZzhycVFMZzdO?=
 =?utf-8?B?VnI1RDg3MnQ0ZWp5eXJSb2JmdmhUTUFmV1FUWEx0ajU0dHEyTUZCaHhPeFNX?=
 =?utf-8?B?TlNxb2p6eWI2TGtRejRTWXI1UTlCRUwyemxlcUVka21uNm9TZVQ0KzFJUHQy?=
 =?utf-8?B?OGFrTFUzdGVwTkdnNkxBKzNEQW5GK2ZTbTRVRkJYdW5PU20zc2tuTFB6S0VQ?=
 =?utf-8?B?dXNwNS9JbC82d2drTk9aUHFncnRaRVpWL3ZhK1VrL2xUSkxvUEl0dCtSZWZP?=
 =?utf-8?B?NjVNcElSNFlvZG1peGpNODRDdnhwejc2dWxGSFlCQWFqZEtDUGxDV2pKU0xC?=
 =?utf-8?B?MDFvOTk4SFZNMEgyeGFqQVpOeC94N2hPY0dDalJjK1BmOW40WXlvMmdyL254?=
 =?utf-8?B?ZE1pZm50T0lXY2pTQzFpK0tHcFlseXdLZGdRbFpzcXFZMThWSzVvZmdxdDJP?=
 =?utf-8?B?YUZQRm50cVlFRTJDcGlnWHlYMEVoTkY1Z2xlVGdNRksvUUJFMlJaZ2RCa250?=
 =?utf-8?B?SjNBME9lY3ZFUEJHaS85TlI3VE92RUpTMU5PeFJxL2prNXYvTU1FemRubUpB?=
 =?utf-8?B?L2xOVUZPMG9WVlVheUFreXlvZEkxUjFianZSZTIwRUl4am8rVytobE5HUFph?=
 =?utf-8?B?dlZOcTJJNXM0Wk9iaWovNGdXMEwzdHZIMFo4ZThpZWRNeTJkUE5WOEFpY3NY?=
 =?utf-8?B?cXJZNG5nOFh4eTRrTFJGSmFMSHJ0ejJCcjEzM1dvQ0Y3ZE1JL3JHSXVMSk1j?=
 =?utf-8?B?SEpoT2Y2R2dOMU1ud3lVWXB3T2p0Q0YycE5NZE83L3k1UWNaWjdrNWJZbkUx?=
 =?utf-8?B?K1NtNEU5TEZiTTd1WWRma0ZPdDZWV0d1N0EwcEdYeEFnRzVmSEFGa3MrVmVR?=
 =?utf-8?B?Q25Cd05EUlBhSDh3NmhXOG1uTXFYM1NDekhrdGdNd0RUNTJYR3BQN3UyM2pL?=
 =?utf-8?B?ZTBZK0V5em9LUkluaEQ5b212V3owalExRWdlZ3Ztc3dzL1RyVWd0NVRPcDla?=
 =?utf-8?B?UUNWWkgxZjhHYUk1S01vd2lzNWtPSERBbFkvQjg5OVJXUUFYaEpGVEhzZ2Jo?=
 =?utf-8?B?V0cxT3h4aytrWDB6eXNoYnMvRURmanlBVUw0MlRHT1EvQXZLblpBSnh0dm1r?=
 =?utf-8?B?MVpFSWs1SXhONmlkRmowaWZjVXhoZVVHMEVKSFNWUWgwVG1QQkQ0SGM0L1ZW?=
 =?utf-8?B?RHhxcEV3OElJSU9TbWhtMW1VQnlHWGtvRnhTaXlOOHlTV1FWa2lidG1ndlpa?=
 =?utf-8?Q?cvDjW3U8O3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2kxMTBoUzlnczlGQmxFNzlRdWVObUJ4NU4rOFZtRVlLZThKZmZzRGF1d1BH?=
 =?utf-8?B?Rk9CNFRiSE5LYW9mSWFyNGJmYnJtczVhbklwcnlxUElNd2haR2gzQzVGU3Vk?=
 =?utf-8?B?Z1FtdGxxbHRVb3p2K2pGRkFRRVFuVTJrSWtnMEJMb3JxeXpzdmZBYUZhZTNT?=
 =?utf-8?B?NFliVm5BbWtWR2N3dUZ3OFkzY200eno3SU9aS01MQ3NPQnI1SmNmbkpXUHgx?=
 =?utf-8?B?ZExJQVFBV2ZpcWVZcVB0WjRKa2V4cDg1QW9PWnFOMGpkWVEwdkpHV1lUVG40?=
 =?utf-8?B?NVZRUFB0QlowQUhxTktVMlBvaWd5cFoxS015bEdCbHcvTmFpcDZqYzN0RzE0?=
 =?utf-8?B?NXF4aWJ3VjMzMTBRYmxZTHdIVjgyc3lHUHhEOXYrQ0V0bDgxRzdibFlqLzJi?=
 =?utf-8?B?YXIzSEQxc2wzUVZpeHVYcFFNYjJVT1F4UU1iT3RnYjIzdmpPOVhCaXdOYU5q?=
 =?utf-8?B?UHZtWFphZFhiYi9SZEtmazE0aVROOVhnem9MYURHbGJzWVRTQ25xa04zTW5X?=
 =?utf-8?B?MlhodlJFYm04UWdEUlk5RlI2MWpXMzRlN2J3QS9qSmhPMWhtTEJ2MkVOYXYx?=
 =?utf-8?B?SkZET1Z2ckVFMlJtYUx2NWh5VEpBcjhNeTE2ZkNybmVNUE95Y0FZd0FLQVI1?=
 =?utf-8?B?bzdPeE1pNlhIZzBUaTdGUjV2NjNTNmtWSVl0eCt4a1luLzNnRElrbzhROGJZ?=
 =?utf-8?B?QWttTFpaRTNlL2xJWHBQaG5PR1NGR0xvVGg0MGxJY25vd3p1elJZa2l6anhu?=
 =?utf-8?B?a3ljWVFUNGNKSTRPNHZtbjl3MUwrYVFnLzFMNjd1M24wRVRwbm14YkNQQWZL?=
 =?utf-8?B?VHEwci9iSEhiSUh3Nzg3dDQxMUxaTzhDK0JFSXlnYU5TdG5BSFh0OE53SFkw?=
 =?utf-8?B?SWZEb0d3V2t1RzlCQnBOeDdqNjJ1RThaR0tLWndKODR6VGVjVHBtdGo3ZlFC?=
 =?utf-8?B?bTVBWDJxZDkxK2xiOHFFUkI4dDVtSmFIWDdaUStCbTd3U0IxaTNRenUvRmJS?=
 =?utf-8?B?eGtZcmdIM0ZqRTVCWWR0WkUxMjhHelpDUnN1ZjBxTkdjRGp1NzNpTUU2bWtB?=
 =?utf-8?B?aVc1QlQ1MlNVWEMzOTdBcFpnUm9sSDlmc1dFTkcvWmRPYzNqZWZqWW5TZVBj?=
 =?utf-8?B?TitIbi9OODY0cWExWUhManVVNmxyVHVFM2JIbjV4Nk82a2wrU0l3ZGhYNzdO?=
 =?utf-8?B?ZVlvRXoxOGRkUSt1clRlcmRCYjhGZ0VlQU16bklqazBFN3ZMNFltVjY4KzFi?=
 =?utf-8?B?N1pZMTVobGI0SDk5dHlnUDRVWXhKQ2kzdUpkenFoRG04SGhVZlFIMjlJZ2l4?=
 =?utf-8?B?ak01VmtkYTNsS3BmK2dxTlV0eTgyK2JyMDFma2FPUzIvUmdVaUJkN3dqLytI?=
 =?utf-8?B?VFROdVlHYSsvcWlOejlQSHJ5clg0VnMyaHJMSmNabkVlV3NQMG5XZFRkNE1E?=
 =?utf-8?B?U0M0OHlkVWpjajIyQmJ5c291dkxuV2pOeGN2VmdKdkdxRW5TdmhPY2p1YWhm?=
 =?utf-8?B?QVhvVFcxcnVybHdJOVA0RjZiR1BvVjIwSU9PR0ZuWXpOZUt5eWVnQ0crdk5n?=
 =?utf-8?B?cFBCM24vb2RselFOTTB4UFd0Yk52ZzlJYkdNcjZ6bFM0emtQSGMrQ2tBUWNI?=
 =?utf-8?B?UFYrcDBucHNjUUZENTRJRExmWUhKQS9GVVRqT1YxdmRGL05aQXBmcnAxQmNM?=
 =?utf-8?B?MXBhcFUvalNIWVBad3JvTUVtbXdRNkxhaHRqUkMzaWJSQ1MvUUoxaHpmM1RH?=
 =?utf-8?B?V0UrWUh0YzhrZG9FN2Y4ZmtHVDM2MTNiNDZ1ejEwNlpPWDlWSFVvMzNudTI5?=
 =?utf-8?B?SWZwVHFPbnlnRlpPMXNMcm9CU0F2U0JRdjdCVGF0SE9ZUldXTkFTL2pFU2Vt?=
 =?utf-8?B?a1FRM3RUa1EvakJHMmhvVFQ5ZzZ2ZW12NFlsckFGdUYyY09IaVQ1R3dtVk5E?=
 =?utf-8?B?cFRlZFVrMm1jRFhpV1FTK1o4dFZDQzlPTlovcGJWV0d1TGl2OWpTZW8xRFFz?=
 =?utf-8?B?dy93ZlhpVkpXZm5iQ1lYcWJ3MVlHV0ROcnVDOXQzSmdOZHdFRWZpTFF0aWVr?=
 =?utf-8?B?a2ZWbEYwWEtKZHNSY2p4NUMrOE56eHU4aDRhMFF2NVhPUGh5SjJTNGdjQ29K?=
 =?utf-8?Q?JfKDQ5Ni/GkKBO1VUryNyKhzB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8b3db8-4504-4b4d-be26-08dd1a2689c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:17.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+vszG+Xg4m2TwbvnOpMwDrpAlHuU97ryr0GGGRzMFN35n9INtRL97BBBxqRF7mYk+12weDMXWQo1lufnrdBMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v12
- none

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..a0a0e86a081cb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -642,6 +654,117 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = NO_BAR;
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_bar db_bar = {};
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_data = msg->data;
+	reg->doorbell_bar = bar;
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +811,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -934,6 +1065,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


