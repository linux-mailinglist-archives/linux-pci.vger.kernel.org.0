Return-Path: <linux-pci+bounces-16975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C71429CFF55
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B516B26E19
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A818E050;
	Sat, 16 Nov 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n0nd+Anm"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85D44C6C;
	Sat, 16 Nov 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768088; cv=fail; b=vCyU4dUILQXzbCHoTA7zkqtZsOHx89ehMucXYuwY/K3EMcHSllZxk1lH+EuQwsLGKdU6dQfU402Dd9JcULii1hwGr6j0ypSd21y+khLzz8cZyhVsPailP60APskuIVlZneO0hu8XZ5vfM2dfhJ3VA7Gnx+cQ45jb9HVZPAQKn5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768088; c=relaxed/simple;
	bh=PMPeULWcd9APEf5NgSWWzp7T5Vx20NKWDiBCjH7nCZ0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rVswaRo56SJbG5cV4lKEwZUEQvncUFDeO4Jxn7j99SpxMEdEpNbZIesiRNLbEQjkLAxDHSriyYhxeoiHLXIUzVA+YufDM2HKNVzsIOFv9y9U2qiedvzfJovScXyTnURH7CB195WFe4BK4pZpnA48ZmrDTt7qVJ90QC0ZX2IaZ74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n0nd+Anm; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okmLCxSWKzH8j6tXc4JjsdkY4D2xEN1qPAMFnahjRyfjjq9R1IoRxyXxe8NO683tpygD8fr5XnEUf2L78vf2vNC4v2DbTr4Cj6TzweF6cya+jF8W1KjyRyZvSDGueZ2N+ZPnXkz65KrEPJAd6ffA5VxQzBosl85B9VnZxFiVpPRLUPUSwbf9NkAc3MRrYqfPoBRKP02PN/y3pzEhdAAW7IGyudwlwYW6IEgk10hvgli1j4EaGdxIfNJC4EntOLAWAVBiDNNH2e6frTSa/Qj11edQUlwbF7CWwD8dV5nxwEDFHzPTv06ldrzoAD7i0DPFpOWSa4RV62kXl4B+bQdsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwKvm2PFG7IelxAqz673F2KybERhxfLWfXM1E5u8duU=;
 b=WyRVkUZ2VV2axrfoEnddbli0XSQIrsvFLA1yiLPyxjC3mkyv4g3ulVraj7ZPGGkeZcCb/8iglwwtI0sOatD96VpuSacemWx4s4oh0VQJAoPWdXvLbttprD2rL51wucUyPpy/MdJDXhtA8pOdNU1bD6WSHKYi2wrEbth7L453ormnaXHS8EpCr8WOsge9i+u5jAEJ1bBw6mG4sU9hH7Kbt/F3ymTdF+PvicYnXmzFyzZ6CC3WlzwCGLvxzn//rQJCphOYpP6LKNzbhITrwjSCCgjHrP/f8zpdpVgZlQDgjdiyd6Yx/0CzDHoM905yvkADGRB7ZsDY8W3grBujjVwQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwKvm2PFG7IelxAqz673F2KybERhxfLWfXM1E5u8duU=;
 b=n0nd+AnmNV4NoF2TeffY6DIcIICa7zUKLfRbvWO7m3T4556v7Vu7DYzk54QgErlD/E9tsq04VsCOs2xyhH+Aezm3ZK2WHH435uXnkq0IwyyUtSP8NVN6X/jtHlh3ZDBVZicpDjQBeF1sFAgqYO6J9hoD5GMBVeHrzX5LrDUtUk3ONEk26W+KXwySHyvEJ4k9n/YRHw9TmWpqt00v1/ouktoxetEtxqEQNbdubVjv76WU2yMmKRPiskKtCk+O6jvrtI+K0YFuouwhFudZTZVP/pYwLpvCMQ7NKpI/WKdAkbtMfgem3O3PWiYx/iz+x3pSC9/jRzRsqGp+7+K++/XKtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 16 Nov 2024 09:40:46 -0500
Subject: [PATCH v8 6/6] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-ep-msi-v8-6-6f1f68ffd1bb@nxp.com>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
In-Reply-To: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=1850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PMPeULWcd9APEf5NgSWWzp7T5Vx20NKWDiBCjH7nCZ0=;
 b=SoKGk63GaV3YU7XiowdjYlWsuvNkLChxn7Ujnh30C8YKXF7nI7eRONMoL0yKyljgwCpeCUpOw
 yZegV3FcFcDAFCoLusTbNUlZtnKt+uzTUf1Mz0hvgLd7K5cj4ajccFx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: d54d38f2-020f-4751-2b97-08dd064cbe86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1RVeXlPUU1FOG9nZGttbUNIeTBsR01qVmwxOFhuNyt3T0lIRGxvZTlmaUho?=
 =?utf-8?B?eU5BV0RjVWdZTUVZT2x0aHNSZlhybzAwVG9wMm1yNGgzTUZML0lrUDUxLzBN?=
 =?utf-8?B?WXdTYjhQSzBJT1dZem9lS29nanpxRUs4cHAvK1BZN0d0ek9Id3dPayt0aFBL?=
 =?utf-8?B?VHR1MkZlY0l1QWU4clBxdEtKYlNPeWEybGJRWFkxNnJsYnc5dmpEVGRCY2RR?=
 =?utf-8?B?dVhwT3E3SkprS0E3ZmY5RHVybkI5eU1DdGZCc29wa0szWndyWlBCeHBJMnlz?=
 =?utf-8?B?Wk5Xd2J3Tk9TdERybE9VcTFSd2ZLaVU0UXNRV204TU1odDBuNERpNk5NUCs3?=
 =?utf-8?B?d3k2M1NUSFFMellKTVNLVjBCWEVZOUdYWnJXUDN3TUJZbWJNUUNnOC8vU1lN?=
 =?utf-8?B?MDNYR29pWGJndTNqUmFmMWlmQ0YrQm85QjQyVVdpNUlzM3NDbld2QnNBMUxj?=
 =?utf-8?B?dlNoc1AzWGZ3Q1kwVWNKTnZYRndyWlN6T05wYzJKVkxTcGo4MGEwWkhZaTZX?=
 =?utf-8?B?Lzk5TkVMQlRyNEhzWXBIN1pZVDM0QThoVHArLzJQaGF0WGNkVmltcjJVamtL?=
 =?utf-8?B?eHQzbDlTenJxVnI1WEhvcjhOamYyNk9rVS9wWFRVcVhkRXBEQ0lLaHlYdWhU?=
 =?utf-8?B?QzJpRTdhT1NMTzUyLy85T01Lak00ZnNmbCt3UHh1OVlFR2NGZFJUdWR2alFv?=
 =?utf-8?B?UEJVSkkxRUpjckNsclJVUmhFMWE0L0NxMGIyTXBvekZPYzRYRDhGVjh4aVNN?=
 =?utf-8?B?eitMcFl1TlZSQjBrM04wNSt6Rmo2cWF5WFNKVnZsS29ieEN1Z0M4TlZoK0hZ?=
 =?utf-8?B?bTIrS2pNQ09oN051YzlNcS9kbytKNkFvTUxqUG9VV01XbUw3SnkxMnQzTEtB?=
 =?utf-8?B?ZVB0WVZSUGYrTzFMSkFkclE0dlhkL0xYWGlKUUJKOFc3dXJKSmZkVlZjZHN1?=
 =?utf-8?B?SDd6ZXVxWXU2TUFTblFQclFBRG5PZXI4U2pPbWRYNFNuZWYweEVMZERiVkFK?=
 =?utf-8?B?REtnUnhiNldEWkdCOW1FaCtzR1lLY3picXFZY0gvcDJEMDBlQ1AybFIydjd1?=
 =?utf-8?B?SHFRRitTbklSRmw3QVRvM3BtUGpqdnIrbEtCK0JYZDVWRS9RamdxMGI4cDFX?=
 =?utf-8?B?TDlYK2hDVmFmT213cEZiSHdoaXRRdkxOdTcvZ2d5eWoweU45ZXNXTUEwTHl1?=
 =?utf-8?B?REVvZldLbmFReDJpUUd5UkZvczRMd0xIU0VCL0krWk4rK3lkWHFJeWIyTUxi?=
 =?utf-8?B?OTgvS3V4cTRBc2poaUtJWTRLdnNuV3RUa3NSNjdBWmg3ai9YT2pLeC9rVzlE?=
 =?utf-8?B?Zmh5WDU1WktjeWEzdENSRDNxRFhjYUJackpDdm51Q2IybGg2RXBxM2ZycEpF?=
 =?utf-8?B?Y3Y4NFdoc1VnUW1BYW1tcEUxTit2Qm9tT0QyUjJxTHIyNm5FT1hzY0NDQjF2?=
 =?utf-8?B?djljT3lENG41RWxpb2hJTFl4ekJJdW4wYkY1VENsaGVlMzdHV0dlWmZuMjdn?=
 =?utf-8?B?Y1Qxd0VpcTZkaGRkMlllUXQ4R1RBQVJIYU82RU1iTVpWdTRiWDFqMXdqWTFL?=
 =?utf-8?B?UkZJcGhYMTZNSmhrTEM1NzlaU1AwaHNKcVlabXU0K0xXQWRDUzhoUkkwTG1t?=
 =?utf-8?B?OFBpRzArTG9ZWHZ5VmVpQk05K255MlJMbnFveElweTZ3SmlmRW1sb2g0L1gr?=
 =?utf-8?B?cWVhS0dmdmN5RVY5RENjK0R6a0VDSDJBMG1vZ1ZKY2YzeU5kc1EyY0pPUUJu?=
 =?utf-8?B?eFBHcDN6YUMzQldnOVhBYXF6elh6M1EwNTdjVkJHS1RSSk1JQnU4SExvaHBI?=
 =?utf-8?Q?Z8FHrUdPogZP8rIlg2QUG/H1QusQPJyz6UXc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjNaRkZBVEhWMWJWazl4S3JtMCthTmNjWjBBQ1E2bVpKc0xjSjBpQlRrVEND?=
 =?utf-8?B?amhLQUFRVW9OODUxYkI3THFiU1pvVk1pMVhWdjQ3WmM4RHQ4cFVMSk9ycmFv?=
 =?utf-8?B?YndTbVhwNzlzMGxENVNCUk95U2pHOWNjajdLVTVVeTVna0pEYUhSRTlpVUNi?=
 =?utf-8?B?ellQYmd6VkdNcmlZNk9aSXBHenBiMjh2WTM0a09MMVZrNFUvZFBlUmtLampZ?=
 =?utf-8?B?U25GVjQ1YSt4V2lFc25IRjdYR203eCtsWlZOemFwcDltMWZ6enh6bGNYNG5r?=
 =?utf-8?B?WW8zYXhKMWF0dG9KTkxqNjlJbDFBVWl1NHY2ZDRyZ2xLQWE3Tjd2MTFldHJP?=
 =?utf-8?B?ekRJUzQzdEMrREYyb281V05DNDkxS0I0dEVRSW5maVVlSTZYR1d1ODA5d2lY?=
 =?utf-8?B?aFVCdWcybmQ4cis1bWZSMUtxSTF0MGpvMFR2NEo2TVNic3V0S21pQndBTjI0?=
 =?utf-8?B?Q2ZzeCtPRnZhdG9hNHdRUy8zSHlseXh6TW83bkdBZHE0QURZTkN3NW9EKy9F?=
 =?utf-8?B?T25pRG5BbDdwd1haSFovM2J5aXdId0NVMS9JbnZ5UVB1d3RvcElSYWRpZEFt?=
 =?utf-8?B?KzRzdzhsbFdZSVFnMlpFZEJjTy9Ga0FiZDIzQy9TdlpsbUFFb012Zk9tYU05?=
 =?utf-8?B?UTN6VWVZbGFBTmU0VjhJMWFzT05rT0QvUWlBRUVCajJIS3h3K2FQQ1hqLytO?=
 =?utf-8?B?VXFXWjZxWVFDWTU5SXV1MVhuSEtyZEV1ejRRWVhvUEJiZUp2bkVaWGhHR1Iz?=
 =?utf-8?B?L1JDSlF5U1pVUmlZWVFINUk1ekpkZWpvazJ6QWRNdG9IM1JmdlhoZmxLaENp?=
 =?utf-8?B?UjVoWDZaaUxDU1FDazJ4RGZVYXhtMWRyeHlqMjlodjVCNDZFUURCK21TRzdY?=
 =?utf-8?B?S0xhc1RXZW5tTFZheDR6SUlKSGk5K2E0NTEvTjZ5UncwZHJuVFNTbGZYcm1w?=
 =?utf-8?B?MXBqL1BGaVlwS1pJTzZjRkU2dDY1eDhzWDk3WFl4Nk1xc2Q4ZFRGb0lwSlFF?=
 =?utf-8?B?VCttWk11cFN6dy8xQ2lKNzIyb0NqMnl6eEg2RW5Gb0FONkZWV1Y1OWhVQ2Rp?=
 =?utf-8?B?UkZrVzZlMnUwUjAwWU5LQkJ5VU5pRHZBQ1lBRWNrVStuMFY0MFAreExFd01r?=
 =?utf-8?B?c21XaUo3Z3U5Mmk1TlJiMVVsTXBCOFk2c1JtbDc2bWZmd0dtYnV2c0xFdHhH?=
 =?utf-8?B?akUvaFFWMTZNVWl0U2Q2cjVLMWZhM3BTbWZLK0JCRTBkM0xaV0NoSFVFSGtT?=
 =?utf-8?B?RWFUMXhBZUs1SkVrQ2M0RVJCT29GZSswUFIzOVhBaVdkeCt3NDUrdmpyTDdv?=
 =?utf-8?B?NGUrWlc5eXVXRmhmRXR2ZEllM0I3aGdMYjB5WkJoN2Z6elJrcDI1emZEUDV2?=
 =?utf-8?B?R0Z4c1BYY0RZKzB3cVMvTGQrMTlMazZTR2FlQzBmbnJQQ0J3VEdFNS93d3V3?=
 =?utf-8?B?L1h6L0ZYcFN3QXpvSmUrazl3Zm80Q2pub1RmUFpqayt3d3czcDBucW4wL252?=
 =?utf-8?B?c3hWRWhWck1XTzdWQ0Npbld3ODI4QmIxN1E1SVZjV0tIaENoblVkdGRDY1RB?=
 =?utf-8?B?RDEyUk4wemp2NjBrZFdiZTNhLzNuWUJ1dEtmcllCSE5wazBsaWdNRzZUaWhC?=
 =?utf-8?B?azRINVpMRk5Jc2M2TjFLOGJnUitZM25zRzJ1Rk5jVWZiQ0k0Z3duL0xRWkVp?=
 =?utf-8?B?NzRNWVhtbzNiQkEwTTRRVzVXQmVPTllVeEczU3VWWmVINTV3SEZRRkdDUHBK?=
 =?utf-8?B?Yi9vMlk0Z0JXU2krazF1VUFCUzk2a01wdFpNZjdKQjdESytmTVdRcEQ5MXlx?=
 =?utf-8?B?ZjBXbWhtTkQ0RW9DMFlwMm0zOVA2ZllRZ3BRMTlHZWhEZmdjUUlKejRmK2Z2?=
 =?utf-8?B?TWp5S0UrK255eFNZU0pVczZkbkxSYW5oZjFMZWUwZ2JibFk2a1QzU3ZNdkpH?=
 =?utf-8?B?VlI4UUVtemZyUDdRUDgzZmlUT1pmL0pPWThIZlEvU25kUUowdTdTc3Z4ZXFW?=
 =?utf-8?B?cU9tZGRxZU1SM3diS2VtQWI1RHRwWXZ2UDV2L3NESkhQYnBDWjlzUE55UlQ0?=
 =?utf-8?B?NmRmclJTOUZNYlNkeWp1UEQvbnFnSjE1RnpIbmxnZkFkZmIyT0xwazZhYkZt?=
 =?utf-8?Q?HjcY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54d38f2-020f-4751-2b97-08dd064cbe86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:24.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pigb8NQxYoKCEgvM8rdYRamBcYtymuuZQ6BKIP3N0ojMg3D2FwR9z9GqUo8ZB7suBSzSPLEMbOPLowFZ8X6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

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
index 470258009ddc2..bbe26ebbfd945 100644
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


