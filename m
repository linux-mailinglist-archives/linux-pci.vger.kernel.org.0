Return-Path: <linux-pci+bounces-20083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5025A15900
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 22:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B626A7A3CD1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624DA1ABED9;
	Fri, 17 Jan 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fyPxNneK"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C941B4F0E;
	Fri, 17 Jan 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149269; cv=fail; b=Qey9KIrMs+W/ARuJWXB7LTuHamLdcx3zujTSdRlTWVM87WFXSOEQGAx0677to7G/scG1qYKHqez2NxtEGTnY5eFw5LM+U6y+WDAp6l8uuRT5ekNjpMFxrorGrj1eDJrwnVjKc76FY0SL4d93htT8iCLgW0okAl78T15XhemML4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149269; c=relaxed/simple;
	bh=s6Hs5Pjoex+sjE3EFbEruLrB5vWWSC0XuPh6HeQjYRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0d9kR58S+BRO80AclwGMDzSNVTLh+PB7COQ7y+bzHaFqRRil+oEigcpGu70txZieOJ9lLjWBACON3+KQryT0SLdGxKyC4RPSMlTp2JznkHN9HKK74rsDTFxsWXgVCinMTUXv8fXe8ka/VpULda4X+bZAgSljYz2HYuheB0UQfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fyPxNneK; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN6HHCOJKNZn4SGPnT4j9vU5+YcKXeOwPKCgWPzQDLYzqe1SrbKxZjzYYJMUBNYSxZyF5jAeTj3amn2rJiRgQQDYB6CT/lAlzWVBFFVuPXjFwl1Udh1RGFZPSyc9nu6NqHVKr1RLSaLM/1+dmQF3RC1oX2Gdx3jmcqbNZQSvRN16MRvbKC3NnyJAmyQ6ioXaW7GwF+0bhIn3k6jFnNlWlercwrFZbsDZvqcZgXmJizTl8yy6Xd+zrO1YY+t/KwepgxYdiWUeMndfKKOatBsAhHf7l7nu7ucnGWET2oztwLoxKq883as9GmCFr3ZAxQbCXAqDw2P2x7hyXxwEwJfnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbqw3gi44u7bFVz5sdTdEWotqDEw3FPN3hl4i9jzuM8=;
 b=WMpNN6YqZvTmw32fTbcDIpfeUkJt4UOnBe/xUaD4YeK8Yrliaj85wkyp6/ip3EIhtF62snWd0Eic78nsjysB1YhaGDQbyeyUy2ULIGbJlUCJi+L2yxmBNnFNlazvO9co4UWxzrvHohKjhZzEU9taBuovMFO5h6Vk9eQnG2aKGhOsaOIxyMKjEK2G31lFV/CoF+T1VV1Q0Cxe5/dfUsVNEmy9IonPsNJ9kWnBzylZq3yxGkpoNQxtGrFqdPfpBgvBOFRwefiyB+VBKuhN0GugVFiH45lwrV2FYxgEzYBWX8QIyC0I+gcXm/rdP2R2vku5lA5vL5SW8CGr1lzpNcmjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbqw3gi44u7bFVz5sdTdEWotqDEw3FPN3hl4i9jzuM8=;
 b=fyPxNneKHzaEzGLlTEfPs2TTPTTCXuKWPuo0QW+WFSvxC/4+W+igie+hgubsGD1X89d0TX/b+bgQ6TYXR69x4lVCfvw5xRg8H0uwyybfCqsl2YZkMSJxZ9U0RW93tnYnFpVWfAEiG1/5IqkzET2tlTOOwiLMGWbJ/htS7FBvJ5wPys1k806H0uMdrcMwcmYUGGv/NiH7/gWOgQy5ikLfp6ssH+eA1B5Xp5FNR2REBhCWREhJQ0UUxzV0tSKNi7H4ztBRiW7l3bGz7+rZL3fScw9xKF6XejwRogsleZPX5mFjbyn470N/Bu5MWIHA4A0dKgkodmNJ+P2FV3o6crRk5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7460.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 21:27:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 21:27:42 +0000
Date: Fri, 17 Jan 2025 16:27:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, daire.mcnamara@microchip.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <Z4rLRpNt7I3sOkBT@lizhi-Precision-Tower-5810>
References: <20250117-curliness-flashback-83519e708b52@spud>
 <20250117173031.GA644050@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117173031.GA644050@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2ef6d4-0611-44d5-23b6-08dd373dc68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmJudzIrMmVaUmhDTHE0dzY5ejZJamZlUjMwUjlMSktSbFBweWlHZ2dXb0pT?=
 =?utf-8?B?YWQrVXF0MnhxcllUT2hQNHhXaFpBZzVJYllYb1licVZycS9XMzJXb1ByMGdR?=
 =?utf-8?B?Z1drWk1mNEk0MWFkR3I2K0oraVlKTHR6d0l1djBIcSszUnRXdDlNY3IxOFp1?=
 =?utf-8?B?VWV0T055UnUzOFp5SzB6MC9yK0FTc2djcVJjN1dyYUVoVXhrZTRlVUxNR0tr?=
 =?utf-8?B?WGRCNVJLM3VWUitlNHhUUWNZbXVFdGNjRExlc1ZVYnZYVURmQWwxWjlsVWQ5?=
 =?utf-8?B?Q05uK0xadWR5alBMcDB1UjFVTTJvMElaWWY5U0MybURyVUNPMUtucVRvMndN?=
 =?utf-8?B?V3B2b1h1aWlWY1hZaUVJMWpQU0RPTmpjM0xpM0hkdWdBeDdrZGdrS1c5VWhT?=
 =?utf-8?B?T0VlSGFYaFpZMTg4eXJ1MmRSQWVMSDN5blFaQ2lWejU1U2hadEJJV3lsamNj?=
 =?utf-8?B?YjBIUW9YK1hieE1UdDgrelQ2Z1hvNllPL09GL21KZ0ZkdDNSSVlGSGphM3Yx?=
 =?utf-8?B?S1NGU25MQ1drbGdEV2V2TFovZW5lWWVtUFRsRG94RU1LeEpvN3VLOFlaZW1Y?=
 =?utf-8?B?WGtocWFKZ3ZFMG4wTllqdllMaDdtMHRTSzN4aVBhNzlNK2hKeDZZRFBTdGF5?=
 =?utf-8?B?Z0YrMUQrMlRucy8rd2pBcTh3cnBEUkY3dDdnZ1hFcWZxU3lsT2lONkVJT3FQ?=
 =?utf-8?B?Q3VlUmJKYVJocytZZVZUeFlyeFRiMkJEekkxblV0SjlSREN2dXhWc3d2ZnNi?=
 =?utf-8?B?Q1hiVUoybU9tNzl1MHFSS1hyYnhGaG5VcVJrdC9pY3NsU3A0emVjaXlETmNr?=
 =?utf-8?B?eTRvYWhnNTJIQnlSVkRQWTdxTnB2YU1iak96VVFwa3pQTERVeEtROHB6ekpr?=
 =?utf-8?B?UG5qaVp4KzNTNE1IcDBUNkdBREVVSFRJTlRmZDRjUy9Ra05tSlhJMjBVUDZX?=
 =?utf-8?B?R0s0YzBaWHJyWWd3enRveHF4cXZJbHJvck5sY2FBcWFhOVl5QXJVcE0yM2I3?=
 =?utf-8?B?WEpCaDQ0REhlTFptak8wbzJEYkN4aGM2SnpYVHpmWnpXRW50dVlUV24wL3V2?=
 =?utf-8?B?QkVzaHJoSEw1RGhkM3VoK3dPbFZUejdqSW9NdWd0NW9mZGtDUUE0TFc2QmJu?=
 =?utf-8?B?dkFRN3NPbzdVRmhQUmRNMkhxZmZNMlFHRWE2YkRLV0ZVcDJtTWNZcUZUWFd0?=
 =?utf-8?B?QXdsL09JUG1CVlFJcWVTb2k2VVEwd3c4OExGd1VaZUhQck56aXVUaGkxNXY1?=
 =?utf-8?B?NzlBbkRDSmJsTTNzUGZJMitSTkF0VjdMMENZZVg2enQveENZcVo4eHp3N0NZ?=
 =?utf-8?B?RWs4aXh5MEVaQ1FPejNMT1hHZ1ZPeUpyUG4zclBRd2JCVUJTQWRrWU9rN2pQ?=
 =?utf-8?B?OHZ5ZytFNTZvSTN3cHZ2SGkxVGJrbGYzZU1Nd3RERXhrbDYzMENaTXRVMWM3?=
 =?utf-8?B?NTgwMFdZVWRQdFRmS1h6ek1udzMvVDBIYzR6RklBczJSeWtOa0hDcUhTazlT?=
 =?utf-8?B?SWdVWEh2SjNZWEJvS2ZmdFgvNUhScHBFR3NmTm9hYmtBaEJrL0hnaDVpalht?=
 =?utf-8?B?NEJWbjY4dmRxWFhEN1ZSYW9mVDlFK3A5ZXZnR25qUXZOUFVOeEwvMStoVmVS?=
 =?utf-8?B?bDgyenhPckQ0WlFLdkpNS2QveW5lb0JtVzZENTdicUtjbmZxcEREam5tMDVt?=
 =?utf-8?B?N3I2VWU4OHVBZ3lwSWlPQ1RzWnJ3SE9mSUU1TWFONzR5VGxBRmc1L3NxUE0z?=
 =?utf-8?B?WHE1eWt4QnZscm9uZnJNb0g2OVlwdm9YZFh0SDVKYUkyTS9LQktlL2luZG9V?=
 =?utf-8?B?c2V4cG41Rk9BTXR3Z2xRWHVRMnBnSENPZnI4VTNPNU9HZXUvS1pLd0tGaVJy?=
 =?utf-8?B?amYvNnlIRG5xNTM5RjlheWFUcll4UW43VTYxSFcySDZ6QkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1M3SXdiamZXTHdnaWFHdmxVb1BEMDVUa2tXOXdOaS9WMklGS2FxUUJYWEQx?=
 =?utf-8?B?eFAxM3l4amZTeGFDaWQzNHljNkRESTVIZXdER3dNRnBwdXlNcTlhL09NZ1Fv?=
 =?utf-8?B?RzE3d244RGtReTd6MUtHbDFlQVlxeUpOOG9RNXNvSHJhTW5pTTk3VUxWb3lJ?=
 =?utf-8?B?VGhrK2tPNE9CNkdITXByb2VzNVByUjBabW12OGhVWGJQWXdnZzF2ZEF4eXJk?=
 =?utf-8?B?MkM2VG15c0NPOWVPUGxTSFdqNlpOSHErRmhTUlV2TUpETEhzMzd4d0ZuNmM2?=
 =?utf-8?B?UmF6YmVibXl3VGFPWHBsVmZUODltL0cvL2piZ290dk4wUFVLY3krYjJ3cVNP?=
 =?utf-8?B?TFZTOEpSS0RGWUk1bVpibjIzWmV6U3pzNmx0emxsNlVyRVl6RlRaUGdhdmpP?=
 =?utf-8?B?ajBYbTcreDM0MlZsTk5MelVMWWs4bkFLR2RGMTBCejBuaEFxMG9TbDdZaHJj?=
 =?utf-8?B?aXM1Q3JtSFhDZEtXZkkvcndCWXhNMTBraEJkaUxOZExLdlFxNGE1Q1FuUzda?=
 =?utf-8?B?R1NLaXZDMEp1UVc5SnBPUzJpQUplWHk4TTFQdkJQQkRDSEtnTjFla2ZQQjR4?=
 =?utf-8?B?M1Z6OGhvdFgzODVPT3hnVlozaDJIaU1pSnpWYWdlY014aE9QWm02MkZxVUdu?=
 =?utf-8?B?Z1psSnowMEw5OWJMVkdRMVlTeGhRYkY5blAzMzJtbnZzSm1MMlJQRUhyL0py?=
 =?utf-8?B?K05xZzFTbTlIN1JzeVZxZmVEU1RqRWlGVXhzS2ZIdUVBT3R3Qy9xVDgrUmtQ?=
 =?utf-8?B?UkZWY1NidFpXNXBEaFhHU2U0V05wMTV5a04rNDhXQklCWmFQaUJXL1RzRk5K?=
 =?utf-8?B?UkI0N0xXVDdHZ2FhLzVtdnVLVHlzYWZWaW0ydHYySnFFMDlSQVdYVjNTM1Iv?=
 =?utf-8?B?YUR2NUtrQ1ZTNFdMeDVicUZGL1hpRmlSNThQa2svSnJMRnRwVWlMUW95RzFL?=
 =?utf-8?B?T3Z4THBIRXdwQkM0V3JXNnRiaTlTYStqTDdEWFJuZ3h6MXJobjRKS0hqakRj?=
 =?utf-8?B?aWkvd0h5RDVlaGZSeklXaWw4dEhJcnltQ2wwOERZZXEzUHZzNUdqSU1wT0lD?=
 =?utf-8?B?dzJNZjQ4dFVnY3dXQnBkMGVHc3lOZUFOVU02dEY1bGFYbXBUVVE5T0hZQ2Iy?=
 =?utf-8?B?Z2xQREJkQ0lFc3UzaXl5cVhkUDhUR1A3aHp0S2VzTFBsYzZLNVc0Uzd4UTls?=
 =?utf-8?B?OGM3VjEvMUR0RXNMNXFwT25GakkxQ2duZFRNNTBqMUtPMTJtVWtic3U5aFN1?=
 =?utf-8?B?Nzk3dmVGa1FRSHBWOFk1RkF6YmZlU2g1MlBHbWtiVGNKdHk1azdZUTZQT1Fs?=
 =?utf-8?B?ZUdBMkx3eTVRYnE4Q0tSenQxRnB6VStmSXgyZzEyYVd4Z2ZUSGdzR0h4TlZC?=
 =?utf-8?B?UTRxdDdOMFllUFVqeEdJbGxlblN2aTBrWWZ4anMyc1NhS0VzUSs3UFhQdVcz?=
 =?utf-8?B?L2V5YXlFc3ltcm12Z1AzTVFpWGF3NlJKbTdwWGY2UTZLejMxNk8vUzIzUWls?=
 =?utf-8?B?VG1yNmQzZjFMREZ3SDRTRlgxekljU2c2M1ZXQjJpRmJuQTFDVzRpajF5RXNj?=
 =?utf-8?B?bUJxdURMT2pva3p4NElRcWV0ZnJVaW96OFJlVXVQc2t0YzdpSjhlUDkvRFFJ?=
 =?utf-8?B?elFOY0J5RXFVYVFhNEVHeURqZ3l3dElpQks4Y3NxYjk1L3d5bkxuQThYcE43?=
 =?utf-8?B?Tm9DZThYOEJMZHM2Z2ZuZXNoTWxMRmplTW1nZlM4d0QrbE9MV3RCUERxTzFB?=
 =?utf-8?B?RDRzcnp6R1lGaTFRSEE2M2xTZm5QSHRRZG94UmdyZ0ExbHd1NVo0UURwdEJH?=
 =?utf-8?B?SFo1b3VaRlVFS3JmVFhBMFlhQmNmNExITk1YRDdiOHRLdGVsdTVkalRpNGZJ?=
 =?utf-8?B?UG02NzN4M2JiUVUrMFJDL2lRZVRVaXJ0MllSazRUcjhFMUtyUlRzV292dE56?=
 =?utf-8?B?d01HcEM1N1hYYlZkWkJBNERROVpEWkZHbmVPUXRoTi9meUpSY0pIZ09Zdytp?=
 =?utf-8?B?Tng1YitDazNCc1ZJUTc0NXU1dTFrQmw1cVoyR2w5Ky9MeEtwSVNlVjdvbXJZ?=
 =?utf-8?B?UHNNem5EdFN5WG9Sc1YwZUt2cEdGck1DNEgxdlE2cXpHZHVrZE1FUW1PMWJ4?=
 =?utf-8?Q?UzpORfh5hwd/a3347eZYunDb1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2ef6d4-0611-44d5-23b6-08dd373dc68c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:27:42.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziZpAPGkPAKLX5VyCkn9mqJgYYXMp94BPVGBtJCCIlM1ZLb7efI+qqMaaNx0znniYKZ58dBlmaJuCmx8LRQINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7460

On Fri, Jan 17, 2025 at 11:30:31AM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 17, 2025 at 10:53:01AM +0000, Conor Dooley wrote:
> > On Thu, Jan 16, 2025 at 12:02:55PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Jan 16, 2025 at 05:45:33PM +0000, Conor Dooley wrote:
> > > > On Thu, Jan 16, 2025 at 11:07:22AM -0600, Bjorn Helgaas wrote:
> > > > > [+cc Frank, original patch at
> > > > > https://lore.kernel.org/r/20241011140043.1250030-2-daire.mcnamara@microchip.com]
> > > > >
> > > > > On Thu, Jan 16, 2025 at 04:46:19PM +0000, Conor Dooley wrote:
> > > > > > On Thu, Jan 16, 2025 at 09:42:53AM -0600, Bjorn Helgaas wrote:
> > > > > > > On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> > > > > > > > On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com wrote:
> > > > > > > > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > > > > > > >
> > > > > > > > > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> > > > > > > > > three general-purpose Fabric Interface Controller (FIC) buses that
> > > > > > > > > encapsulate an AXI-M interface. That FIC is responsible for managing
> > > > > > > > > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > > > > > > > > the Root Port driver needs to take account of that outbound address
> > > > > > > > > translation done by the parent FIC bus before setting up its own
> > > > > > > > > outbound address translation tables.  In all cases on MPFS,
> > > > > > > > > the remaining outbound address translation tables are 32-bit only.
> > > > > > > > >
> > > > > > > > > Limit the outbound address translation tables to 32-bit only.
> > > > > > > >
> > > > > > > > I don't quite understand what this is saying.  It seems like the code
> > > > > > > > keeps only the low 32 bits of a PCI address and throws away any
> > > > > > > > address bits above the low 32.
> > > > > > > >
> > > > > > > > If that's what the FIC does, I wouldn't describe the FIC as
> > > > > > > > "translating the upper 32 bits" since it sounds like the translation
> > > > > > > > is just truncation.
> > > > > > > >
> > > > > > > > I guess it must be more complicated than that?  I assume you can still
> > > > > > > > reach BARs that have PCI addresses above 4GB using CPU loads/stores?
> > > > > > > >
> > > > > > > > The apertures through the host bridge for MMIO access are described by
> > > > > > > > DT ranges properties, so this must be something that can't be
> > > > > > > > described that way?
> > > > > >
> > > > > > Daire's been having some issues getting onto the corporate VPN to send
> > > > > > his reply, I've pasted it below on his behalf:
> > > > > >
> > > > > > There are 3 Fabric Inter Connect (FIC) buses on PolarFire SoC - each of
> > > > > > these FIC buses contain an AXI master bus and are 64-bits wide. These
> > > > > > AXI-Masters (each with an individual 64-bit AXI base address – for example
> > > > > > FIC1’s AXI Master has a base address of 0x2000000000) are connected to
> > > > > > general purpose FPGA logic. This FPGA logic is, in turn, connected to a
> > > > > > 2nd 32-bit AXI master which is attached to the PCIe block in RootPort mode.
> > > > > > Conceptually, on the other side of this configurable logic, there is a
> > > > > > 32-bit bus to a hard PCIe rootport.  So, again conceptually, outbound address
> > > > > > translation looks like this:
> > > > > >
> > > > > >                  Processor Complex à FIC (64-bit AXI-M) à Configurable Logic à 32-bit AXI-M à PCIe Rootport
> > > > > > 		 (This how it came to me from Daire, I think the á is meant to
> > > > > > 		 be an arrow)
>
> I'm trying to match this up with the DT snippet you included earlier:
>
>   fabric-pcie-bus@3000000000 {
>     compatible = "simple-bus";
>     #address-cells = <2>;
>     #size-cells = <2>;
>     ranges = <0x00 0x40000000 0x00 0x40000000 0x00 0x20000000>,
> 	     <0x30 0x00000000 0x30 0x00000000 0x10 0x00000000>;


Sorry, I jump into this thread. Look like fabric-pcie-bus trim down to 32
bit address if I understand correctly and try reuse my previous works.
      <0x30 0x00000000 0x30 0x00000000 0x10 0x00000000>;
should be
      <0 0x00000000, 0x30 0x00000000, 0, 0x40000000>;
      <0 0x60000000, 0x30 0x60000000, 0, 0xa0000000>;
      32bit only 4G size,
      [parent 0x30_0000_0000..0x30_3fff_ffff] -> [child 0x0000_0000..0x3fff_ffff]
      [parent 0x30_6000_0000..0x30_ffff_ffff] -> [child 0x6000_0000..0xffff_ffff]

0x4000_0000..0x6000_0000 look like use for controller register access.

>
> IIUC, this describes these regions, so there's no address translation
> at this point:
>
>   [parent 0x00_40000000-0x00_5fffffff] -> [child 0x00_40000000-0x00_5fffffff]
>   [parent 0x30_00000000-0x3f_ffffffff] -> [child 0x30_00000000-0x3f_ffffffff]
>
> Here's the PCI controller:
>
>     pcie: pcie@3000000000 {
>       compatible = "microchip,pcie-host-1.0";
>       #address-cells = <0x3>;
>       #size-cells = <0x2>;
>       device_type = "pci";
>
>       reg = <0x30 0x00000000 0x0 0x08000000>,

0x30 is impossible here!

> 	    <0x00 0x43008000 0x0 0x00002000>,
> 	    <0x00 0x4300a000 0x0 0x00002000>;
>
> which has this register space (in the fabric-pcie-bus@3000000000
> address space):
>
>   [0x30_00000000-0x30_07ffffff] (128MB)
>   [0x00_43008000-0x00_43009fff]   (8KB)
>   [0x00_4300a000-0x00_4300bfff]   (8KB)
>
> So if I'm reading this right (and I'm not at all sure I am), the PCI
> controller a couple 8KB register regions below 4GB, and also 128MB of
> register space at [0x30_00000000-0x30_07ffffff] (maybe ECAM?).  I
> don't know how to reconcile this one with the 32-bit AXI-M bus leading
> to it.
>
> And it has these ranges, which *do* look like they translate
> addresses:
>
>       ranges = <0x43000000 0x0 0x09000000 0x30 0x09000000 0x0 0x0f000000>,
> 	       <0x01000000 0x0 0x08000000 0x30 0x08000000 0x0 0x01000000>,
> 	       <0x03000000 0x0 0x18000000 0x30 0x18000000 0x0 0x70000000>;

All 0x30 should be 0x00 remove here

     ranges = <0x43000000 0x0 0x09000000 0x00 0x09000000 0x0 0x0f000000>,
              <0x01000000 0x0 0x08000000 0x00 0x00000000 0x0 0x01000000>,
              <0x03000000 0x0 0x18000000 0x00 0x18000000 0x0 0x70000000>;

>
>   [parent 0x30_09000000-0x30_17ffffff] -> [pci 0x09000000-0x17ffffff pref 64bit mem]
>   [parent 0x30_08000000-0x30_08ffffff] -> [pci 0x08000000-0x08ffffff io]
>   [parent 0x30_18000000-0x30_87ffffff] -> [pci 0x18000000-0x87ffffff 64bit mem]


[parent 0x0900_0000-0x17ff_ffff] -> [pci 0x09000000-0x17ffffff pref 64bit mem]
[parent 0x0800_0000-0x08ff_ffff] -> [pci 0x00000000-0x00ffffff io]
[parent 0x1800_0000-0x87ff_ffff] -> [pci 0x18000000-0x87ffffff 64bit mem]

So whole translate for example 0x30_1000_0000 from CPU to PCI Bus

CPU address    ->    fabric-pcie-bus@3000000000     ->      PCI controller  ->                PCI BUS

0x30_0800_0000       [0x30_0800_0000 ->  0x0800_0000]    [0x0800_0000 -> 0x00000000 (IO)]     0x00000000 (IO)

>
>     };
>   }
>
> These look like three apertures to PCI, all of which are below 4GB on
> PCI (I'm not sure why the space code is 11b, which indicates 64-bit
> memory space).  But all of these are *above* 4GB on the upstream side
> of the PCI controller, so I have the same question about the 32-bit
> AXI-M bus.
>
> Maybe the translation in the pcie@3000000000 'ranges' should be in the
> fabric-pcie-bus@3000000000 'ranges' instead?

both needs ranges,

ranges in fabric-pcie-bus@3000000000, convert CPU address to local bus
address, such as trim high 32bits.

ranges in pcie@3000000000, convert local bus address for difference PCI
transfer type such as config/io/mem space.

>
> > > So is this patch a symptom that is telling us we're not paying
> > > attention to 'ranges' correctly?
> >
> > Sounds to me like there's something missing core wise, if you've got
> > several drivers having to figure it out themselves.
>
> Yeah, this doesn't seem like something each driver should have to do
> by itself.
>
> > Daire seems to think what Frank's done should work here, but it'd need
> > to be looked into of course. Devicetree should look the same in both
> > cases, do you want it as a new version or as a follow up?
>
> I'd prefer if we could sort this out before merging this if we can.
> I'm not sure we can squeeze Frank's work in this cycle; it seems like
> we might be able to massage it and figure out some sort of common
> strategy for this situation even if DesignWare, Cadence, Microchip,
> etc need slightly different implementations.

At least first two patches are needed before other people can start work.
of: address: Add parent_bus_addr to struct of_pci_range
PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback

Frank
>
> Bjorn

