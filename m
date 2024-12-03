Return-Path: <linux-pci+bounces-17598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE629E2E97
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D29B64D18
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A920ADD3;
	Tue,  3 Dec 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dKDkbAYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1A20ADC1;
	Tue,  3 Dec 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258258; cv=fail; b=s3Y8Dmvgiao6nNQt+xRiOVsI1vJHCAlSjg6JbuNk0EmSZubnvfeclg8w8UfUvOQAtQKc4xbisDZVuUCP/JyPFkWVNfRCdJuujclJfzJ347UivGllhTc5kkKKFjybmRmFRNM3ixZipYxZ75Tf1ynP61AbQC+hw8dkNHSrIk2a6Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258258; c=relaxed/simple;
	bh=D6QS5dGBAjaAnBQe6gXEEbxTtlI1jz0FCsmMW1skoMA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s8IujtBVDQwDmM63T/e8JBDDdXs3B11WKTalygXoroyqdHGEeqgdy6mBZz1g9Illr4tdEKctLqtiyRzFU1IFSKJNN8j25t9D90chMYWUF6hGk6PtR78CVPEFrQYU6o7gmqBJ7H+h20hz45aAiULLzwaTG/4X5l6KKpJ/8i43ssM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dKDkbAYB; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA7SG7/3BKQex33NxWDJzkKALxJf9yYbrBtE07RMfXBALfpu3IiEdjjpllM8P+zEHoQj8y8EIBzzfG9wMOvQPgbKCQOR+KpKEei8QuKF8d1o7aE72kxEG7jYeF3DdqSwlwdYnkUYPLKylwoFXMRMWA+cH/JXxjgr1Xq/g+5f9jrVGC6WtBDhjsJk9z2VPSTP1HTX+RArheUmyLStW9C+EVrQjwWn3lmMh/CvJl1/9E9UVz8tFxOQn5rr4bGNkexkt/vz+hFny54vWJwrwNryLRSxcMvW+LcOyT2ChAt7AbqhI9crl/qM/tCWAMfWxl/NxGpyWwLPI6Ey/fW19s4s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvAWpxw8OJYRN509YqG+wyWqM/bl2CHBc0A28i8a/jU=;
 b=OW5JcaV0ejAmipUsjNGjaoVSOI8dGTGsGjNWSnP9aItVtywDxTYXn76jmgO7lLG9QkKa4wi6o7wvZEZ+SKy3t/udeA2wkOmbGsIz9dMcTQ+2LdOjtZTnL/6WztsGOjYfhxjml1IHM2rQDqoHxpuZjGCcUQNFydFyhIP+bZDsVFU+yOz9rmGXb/225xsNrkwop4Eb/5j5j4Ex3R10jB3mt67aX9mDq76p7SiGXq6kjscZWfN5+zQJQKfMfx/nM+a/HEG1GpGJFdi5giuUyFKhu94VZZ0dPUBC2+/CZmkiiUAM2UCxU9QF62NWnJnIXxBUkbm8qP/guAhNxUCTNYOmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvAWpxw8OJYRN509YqG+wyWqM/bl2CHBc0A28i8a/jU=;
 b=dKDkbAYBg3vERimHNPPkxff0HubrVBC8lyIVfyYTiJjUnIDAl3AIFdyzG5ttjSHYBP9tA07PKhmMymcNLnLJKYFpBapI6Zacld1E0CiARuc6nZhel0CidpGXOFYwHO1TJBC3NtReA9qL7uwxtr4ntMp4TzkSB+GyBXCXPxXBEyPU6gWh4piXKCY5+BeX7bS4bXlpWI7OTEOctVU06l3+98FugF7IFFFnxA27XmsV6Tzb4E/eSTk3xTO6kydRAZNLKBW6VidYz2PgbJ5z8ia/roYqn4kRA2+hFH8ZEQbBDUKX+U9BGt1hYKCvinCe3k/OT4GbcJ1wM2QgQDtDXiUW+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8730.eurprd04.prod.outlook.com (2603:10a6:20b:43d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Tue, 3 Dec
 2024 20:37:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 15:36:55 -0500
Subject: [PATCH v9 6/6] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-ep-msi-v9-6-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
In-Reply-To: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=1850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D6QS5dGBAjaAnBQe6gXEEbxTtlI1jz0FCsmMW1skoMA=;
 b=TuL4mT3XQxv8A9zvPGp7Rfla4KGi1wwLYktz0aij43KJ8PB8a1t2O7AkhqWfpSQOeF0p58fe9
 qGrmuI2ArjsA73bujR0EgBXjr2iBnk5S63mgSJuDTI7OJeIAnTplXlq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2504c42b-9611-4339-0e07-08dd13da5168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS9EN295Zzc2ZWRjaFd5dHl4UjVPWWVSdW9xb3A0b3ZzK29uMXRJL2hnRWlR?=
 =?utf-8?B?VUsreWl3dElvRWRIdjJKQkx1UU1KdlR4a0k2eHloNG1vaGIxdG5PVVpGYzZS?=
 =?utf-8?B?VXpYVE5VUXg5VlY3S3ZadFYyOE1GVkZUOFU1ZzJ6TXpSWGYvVjl3aTJUdTBO?=
 =?utf-8?B?NGh3TmRwbjlqV0F6cElENzEzOEg1Ui80b25YNlhQUGNISzE4Wm5INlNJL2ht?=
 =?utf-8?B?Vm4vTUxhUnlydTRaR1ppeW5FTndzK3dXUGR6UTJzbW9TSGJRRkF0TXMyZldu?=
 =?utf-8?B?M1hJYkVPSkY4bTB5R1BkR2FGZWg5bWNkZU9qK3BtRzhvM3h2YTBTRFNrRE92?=
 =?utf-8?B?R1RFdElxbnpMV1lRY00ySWc1c3FsQUtZamJ6R1E2a281WVlwNE5sVjV2Y0oy?=
 =?utf-8?B?cjZWR3VnRE9OU1E2R05KYlVOU2NnbDc3TTVCWVhIZ21mUENlN0czYitBNmhL?=
 =?utf-8?B?SXFpQitiL1kvQnNKcmRNUER5MXlJME9OeDZaVGh2Vnh5WGMzTTJEd0ZvNTRX?=
 =?utf-8?B?WG9wbitGTEhmdkYxSkZqaUZ1NmxXaU1jMWNhS1NQTHVEVEVWTEducjV6L0VB?=
 =?utf-8?B?YXRDU0dUOGsrblduQzJ6UTBuNjFTYzc2bUI3c01INzhwaWtoSXB1UGRnbm45?=
 =?utf-8?B?T1paRndJdUN1Ykw4dmhUWlRES1dHTkU4S0xMVFo0Sm9FNnNsUEVkZEZIaU5T?=
 =?utf-8?B?SncxRGxZZkxhNGVrMitKamRldmY5NEJQTU1ReUNqdHpBMitKbVhSSmNRdmla?=
 =?utf-8?B?V0Rxd3hyM1o2dlltODNZcE9iYndBaDNHZFZUS0V2K2V5WXpXYTFiRFlGNEYw?=
 =?utf-8?B?Y1BnMFZsWXNzL2l4UEl3YXhWQ3VrQTF6SkVQYkRTNmExV0ZNSWpHd0U1MzZj?=
 =?utf-8?B?SmRudTZHcTRIdXRSUlU0bkN4clZZajhpRys5OVc0U1dXblg3NHNlWEpva1g1?=
 =?utf-8?B?QWhQUWxWTzdGWXVTdWozWDcwVHVub240V2xSdk5DaWFuUDZpNkVaeEpmQS8v?=
 =?utf-8?B?MDNpUjBaWmwrcSt2N2pWTkwybWV0ZHd0WVMxcHpMSU9RdTQwWnd4VWFQZWZw?=
 =?utf-8?B?WVgvS3VvREpCRDlYcjdrWHVmdDBITjNkTVFZYXN4YnlieGRDcy9qdkdLTE80?=
 =?utf-8?B?UE0wVWJGTUtLZVVsdmlKUkJVSVVUektnVThvOFpCb09yUW9PYkM0N2R0bjJl?=
 =?utf-8?B?aldJVmEwNXY1ako4b0hYV24vcTl5MWJOc04rZE5TM1c4Z1dYWGNkd0tQT2xW?=
 =?utf-8?B?Q2cxakk2VXZXR2JRNWh1d2MvMmVPWXlEKy9idzMvTUtrTWpnblBSNDgxaFZt?=
 =?utf-8?B?RkFNV0VVSENrYVA1UE54ZkZ0V1l5ckwxTjhpa0JKVHZOOGoyTUptZW5yU1cv?=
 =?utf-8?B?ZkRwQ0dHNHp5Q200WkhoS29ReURhNzJ2V0VJS2ZJcHVINmk0MVBuSWpEVmpM?=
 =?utf-8?B?VDVLSDFIcEZYYkZRMEkwT0dTNEx0WTZkU2c1V3FpZVBSTGU0azNvTW5jeW5S?=
 =?utf-8?B?WFI0OHRseUQ5OVVPL0xzZmgvSWtRMUhJa0U5VHJHZWE5ZDdXQzdiSkM2elAx?=
 =?utf-8?B?M2dKN3cwcEMyVUloanNpbVJQeW4wckEwemR5bmJCcnZmaXFjeDJEdmY1a2JC?=
 =?utf-8?B?ZTQ1UDZxRHFtU1ZuYVB2aTcwS21Kb1VCMENTVkZtbXRwTTZ5OWNHc0w2OEZC?=
 =?utf-8?B?NGRwRll1K21yUjZMZzJRaEEvRzAvYVpkMUVoaWhrYm5iQXRnNGlEbG9rSlBN?=
 =?utf-8?B?UTZZdE9ZTHRYTzNwUlFWY3lNWTlxaGVUZHNvYjRQd1dZSDQzalFnNnNBb0FV?=
 =?utf-8?B?N1J1TUxrZnZSV0hteFUyUTdLTTN6SXBCYmY5WWppTjJoaVZTd0QvaFVFRk5R?=
 =?utf-8?B?aDJWanRjMUsvZDFnQjFXODc4TmRIZDRHd0ZZWjZnVGo1b1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFVQV3N3RHQ5SjRoQ3pZSlFlWTBDUWZyMUlyNGV6YThUM09qVTlCTHVTQWhv?=
 =?utf-8?B?enJiTlhPdXV5MldQUEhVTG0xV21oeVlwRU83dk5Lc0FGTi8rY2xkYU1ZdDVw?=
 =?utf-8?B?bWIvZ2JwckJ2aVA0V0dMbVpnd0NNMHowYTdXcVFOcW9DM1hUdmlnZkpnYUhY?=
 =?utf-8?B?ZTRmMzB4cVdlNjR0bXlnU2FHUEZuT2tKSzZwNWlYdXViSkUxNXVmTEJyYUVa?=
 =?utf-8?B?eGVyaVU4QU1lSW85a3dRYXhqMTM2Zkx0ZXVwbGltRjRKVHZPTVIxamlheVVI?=
 =?utf-8?B?dGNLd1FSZHQvSnVsWkx2c0NhYVYrS3Y1TXJ6dkJTTUc5N2tPNFdwK3VPL09Z?=
 =?utf-8?B?NHRIRFdndW9VWkFTQUpqU2szNUFPUHZXSzMvN1ROcnQrS1FPdFU1aXZWcXZk?=
 =?utf-8?B?SHc1TGxJQngxZit3U3VVR2JpVkJNVzByNmRMdlBORzI5M2JpYzlyaWx6RTVs?=
 =?utf-8?B?QVk1UzFkNVorcEd6M0duQWVhOGJmdmsvdDVwajZsR1VuWDcrNWVMTnJLdEJU?=
 =?utf-8?B?OGJqNTZDODhtbDNEM2Y0QjBnbmpIdUtnYUcrZ3dDS2dicnZNSDUxMFltMTk4?=
 =?utf-8?B?QjlZUVJRa09GakNRMCtpODl2NHozaVNLM1lQd25FLzRSaUNRMnkzUnFEOFkr?=
 =?utf-8?B?S3JPTVEzT3E1MVhYc3UyTDJweWxEaTJ4eXhaeklkTFBUdWlsdFNyNzVCWHJS?=
 =?utf-8?B?YlVrMUhEVU16alJIVE9aYSt0T3VLZW1xUmo2ak9OWUQyY0xUeDhLdllma0tw?=
 =?utf-8?B?L2JTVm5wVWlNT0hMZ1pZcG1LQUt1SmcrQVhZakpZc0hKZndqNDEwbGZXazVC?=
 =?utf-8?B?K3BYc3RNRXNKNkZ1ZnJBZjlqNlVQcnR4WnVOWUd0Z1VqK3d3RnZFZTRnV3Na?=
 =?utf-8?B?WmpZY3M4VTh4VGNKSUNjSU5tSGUvM1h3NGlmdW1vS3VnZWVtdkJMZ1BNZUVn?=
 =?utf-8?B?UkdrVVlLRyt2K3pDZWpvS1ZxZmsxUnBEU3RjUmNERzhFZ1JRSWl0ZDlEK3dS?=
 =?utf-8?B?MDFGbGozNllocmhMY0FPVkJIem5NOS9vZ05yZ25rQjMrMXdDdkVJdDRYd3ZY?=
 =?utf-8?B?RHlueTgwZGpseXUwWXpQdEg5UzU4dzNqbTNNL09IWFh6UXMyclRBN3FxN1ly?=
 =?utf-8?B?aGJHU2FOQWMrcUgxQ3hRYk5aYVk5dElYeHZRQTRYanFlWmtBYVFuNXJMZlZ4?=
 =?utf-8?B?eHRvSzBWU1d6b3RKTDF3eTZzdCtkZEg0YmZmVnl1WFRHMnIzYlR5NUVtdE0v?=
 =?utf-8?B?QzJJdDFzZTJHZUVnclhaQWxaM3lCSE0wQ1NlN3hIQUF6TU5aUzFRQ1NJQnJO?=
 =?utf-8?B?VGRJUHBVMFVpTVZQWXNRU0ljRkN6eFMzUmhiakNzcDJFMzg2RDZvUlBFMkFh?=
 =?utf-8?B?QXhFV2p6SnEvckVhOWNjWTVxR3Q2VVMrVVBoYlJONUZoajMxQW05QXFHcjRN?=
 =?utf-8?B?TEhxNGY3ejZUdDNTZml6MjkxNHVyRVhjRjcveE81VllsM3FuakFWNnY1czdE?=
 =?utf-8?B?aFozaC95N3lDaURic1h5UEgwSXdlR2p2TG9rRTR1SEdFcnN2TE8yWCtaU2RE?=
 =?utf-8?B?YnpZLzZqMGhoRHQ2d2NZcHduZmlVa25kc1pocHFYNi84TmcrbWdrS2V5YS85?=
 =?utf-8?B?eDNxYkpDK2piNXYraFBsbXlaTXRaRUUwTlJudXNFNDZFRmY1bEt5TTkrMUdF?=
 =?utf-8?B?MmlQSTY0djZMVUJURGZheWU0eFBNZ0I2U1lYcXhQU0FLbTY5V1A4dDhmSDRK?=
 =?utf-8?B?bnBCMTkvS2dwL1E1RlBGcFNlazFzY0NvaTBlTXVUUCt4Nmw2K2JFU0RPOGx5?=
 =?utf-8?B?T05BTUN1TkRGbzNmeThSOEtNQXdGQVMrODZ5UWVydGpUbEQ5SnFZMDdsYTc3?=
 =?utf-8?B?WXhTNjRtZ1RMUGdhNDVkbXFkUU1oSlpSNGJRbkpQeEp4a3AzRzVZb25PVGpK?=
 =?utf-8?B?WGFRS2Fia3RFMmdUYXdzQzgwSytQYWwyelhVTWZmR0xwRU9TRW1McFVBY01C?=
 =?utf-8?B?VXN0YnNWT2FYY0pkMFo4MnQwSGl5K014OFFDSi9oeUNWSDdFTGl1cUtGakJ5?=
 =?utf-8?B?OGNMVm5vcEwyVmtjcER6VWpZRWYzYUpqSjJHRnN6Vk5pcXNmMkR6Umhic0JL?=
 =?utf-8?Q?OjsM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2504c42b-9611-4339-0e07-08dd13da5168
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:34.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrMI0qoemBFV1Mseq4rwLCM1iul79zO+m6l7r3xGyiolNDjHmDO/XjKjplgh8C8pMAkYusPYQhLTGHXRII9aYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8730

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v8
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 7b530d838d408..fcff0224a3381 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


