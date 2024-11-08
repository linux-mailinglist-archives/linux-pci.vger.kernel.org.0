Return-Path: <linux-pci+bounces-16354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72B9C25C3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 20:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C3F1F2137A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6A1AA1F4;
	Fri,  8 Nov 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kC1LrNR+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A71C1F24;
	Fri,  8 Nov 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095037; cv=fail; b=mOugpms6ASrlrIBBCRhomZSxdSqX9RSyNT7tV2PeFTKEN3hlura91dapuwHRFiT/9EMvLqN+E4Z7t3fILiJK4njDASotnDnKEVh+wmuG3PlLfhspwC6OMC1EOH7sBXzsOyqcFUtly8Ysz/6DXO8cX6pmsbqq2yAf6a2tPQfokfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095037; c=relaxed/simple;
	bh=qYxIU8kchQtHsEa3c+NUqckv3V8JSjV+g2iyHqr0Y9w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FOY8zNN6QtuoIru+xv9CH54DgPbtbddYtOMA0IF4/8GCJZ/KgxHME1y1Vyf+Qcg/BBttAOFBHYbFn/Y+rkI1COsfz3HlZHblN6ytnULKUwD9vU9xwvgyorO7iywoxGU8Q2qRKzRK90s/0vR6LFiPPXOq05pesDniBQOd9RxJsTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kC1LrNR+; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjr2r76tOPXDIddMzEF/ZZjkKPq8qXgguWSB0vW6Lh/BhySWa6uEAFuIUMXKnNCA/lqNyv0c28N+tyjy/AQpkge3LlEkOGn5iNLq0eTB1wH+yAZE+69/mSI4pNMsWipvnUZEUPUBGDbpbfB9MQIscG+pMh0MqNMAi8SvuWSphJa5OLG5jW4wTvBwYNVXHs57xmEDOxh/Tmo/8O655oLXQ/cvaI0HsABUL3D4ysZyxh8tckRddFetsVhXKUCejzrOEeo9eGK98EXX5ss7JKRZmysyylpoAyMfbXj7WW1+DlaICUAEnGtmaD4FTtF7XXt02wMce15n/rN6PjBTKna2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2SKH2oS8EKt3hJu2TO5lwqproQ90A1PIbYf5vAd3Yw=;
 b=k3dHLY3j2mSpX9NDrpE9a/mQpfftGPG6LmcT4Mht1F2SBSVbctISWVB3OqRRSCQPG129RR9IOGbsov7vyjFMJsuSagctw/ixQAKgbs0MQ/rQbwAPjBHRVtw1HSPAEqnWs2dRPg85kgBrb3thG11EqFUqqRwbAVpPdEDZeE+J7DfsCvjLcUJO7Jy3ZKIwqvYKwssSRmj2HZ8s6cxsh1wQHWLwNLQtHA2Rps6XKhbrmqu6ul6IpP7ygsOHX84cbhb+LEl+16RG8n/+NgZ4Gzs7Wkr66wL9YC995jZUbHUqHqvFhWIa/u7uJyb7YJWsXXFIh2IruCknNk4OrwTFMLEJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2SKH2oS8EKt3hJu2TO5lwqproQ90A1PIbYf5vAd3Yw=;
 b=kC1LrNR+9kV5edRjY+UVsZwJLJT0Ad04ZwcvlQT/Vx0eScrtx1C32l7THJ4o3Y1u0EsHKFzyar3oHvw4grWXyajeZqPaetosQaBEhxx/+ic6yv4hzEKzlmSaq9zneud70wis+TnQROyLA/jbJMiMX1+w2G+DYr9eCPAUzDQ8Yp6oxCF8sqS4GfU6chdXgru1/LWFcqSO+fexBmafrr1+MmTg1M5j9wMMJ0t0LpaDhFIBErpEP/8/0XQaCRS7Z51d6gpPbzvthFaWuBumgBZkHCQ04yPBybyUtUK+VzXoMrJVh4llutHelkThQ7CE07uju2zgtKy0ZSCGrkBzTxxKQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:43:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:43:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 14:43:29 -0500
Subject: [PATCH v5 2/5] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-ep-msi-v5-2-a14951c0d007@nxp.com>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
In-Reply-To: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731095022; l=6220;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qYxIU8kchQtHsEa3c+NUqckv3V8JSjV+g2iyHqr0Y9w=;
 b=B/e51zaazNqgVAEv7Uyg42iGV3dN+UwtuAT8I2kJeQRw9NZeabJN8dxxMdVuIuXuIBRPUXf/P
 HfiMe08bSL4BwAIX7a/Bpxd5Raq3wx4zWssS8I2eswr0sNijtWc2tF1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 61523f2f-c7e5-4bc6-23f1-08dd002dacfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WitESjZDYXNob2lVakg2cHVkVmdyVVlSRmYzdXVBd2tlTldUbm03bk9qSXZt?=
 =?utf-8?B?ekNFZGdxdk5nZGlOQ3JVbEF0bG5zWHhPd2hyN0tzZyswMURZZVo0Zno3V3dB?=
 =?utf-8?B?MmM1bmlnUzNNeUZOL1ZEZE50SGxSTHZsT2U0M2dWUGRZWTBOUDMybU5Rdzkv?=
 =?utf-8?B?akVsTGtGVXhia2NOelh2cUhlSFR1UUtkUE5EeWdBSGNXQzcxa3IwdmpMNEI1?=
 =?utf-8?B?K2UwOUh1V3E4OVlIZDU4NmxYejJHNXhsTGh0djFNRkkrTUlZdDZEaTdUc0pt?=
 =?utf-8?B?bk9VaHJFVkhKa0tuOGJacjdmWlhTNjdqb1RERWZpRzZyQitJcXp5Nm4vVkFu?=
 =?utf-8?B?a3ZOQnh2MDIwM2RlaGg3ck5iMGxoR3JiVlI0TnNZTFZCZEQ3V1pqL0dZUHJj?=
 =?utf-8?B?NU5WUW9EMDE3NXVQU1lOVGRWVlZucWZuSFpmbGl0SkdRdUdlM1lYTGpkN2RP?=
 =?utf-8?B?bmh0M0RWSkNtaVNlSFQzd1o3WmhwOUI0c1RuamNpWm83Zkc0ekFjQkFyWGFm?=
 =?utf-8?B?cTNZMDBhNGQ0YXR6YzBoYUF2SnVpeE1taFU4VTFLZXR1WnBQSWxtbGFXRXg4?=
 =?utf-8?B?TFl1MmNDUTNia1Q4WW5aS3AvaUJqOHg1MXE3ek1oVytkQndkVTM4UE1lWFV5?=
 =?utf-8?B?OWFWemppM2IzSG9jOG1FZklrV3V5U1NRcG1sOTRodUl3eFVybEtKbjVmSjdq?=
 =?utf-8?B?NDhQSzVrT1B5MlJXdDVyWk9maVlXOHRxODlhR2gxTHk2VktBZzFXUnBaR3ZC?=
 =?utf-8?B?ajFqQmIyU08yNVFTM0dpOWJUa2d1V2NQWGI3a1FzY1BXM0VwMXpWUnhYUDhh?=
 =?utf-8?B?UkRldEdmZnBuTDRjaEI3SkJRQkVZTy82aEZ3VU1XU284WEdNM2NMWnI2N1kr?=
 =?utf-8?B?YjBoSWd5dS9sUVZ6Nk04YnE2UVZpZlRaWExoRUhIemJqS1R4bXdYblNpU2Ux?=
 =?utf-8?B?TVlnWEJtZnpRTUZ3OFlOOTR5aGxudU5rTGVDSFNONmFaaDRidmpFY0I4SU56?=
 =?utf-8?B?YXJIbW9lNllOWVY4dC96cUlqUUtPelNpYXFSWTJyUWJkWkw4bURPdjVRWkNB?=
 =?utf-8?B?NVFtWXFXYlFBc2xKNldqc1lacWI0RlVsSE5VVnFObUcyeXA0d1NWdDJZTEZU?=
 =?utf-8?B?TjlwT0UxaDVGL29Jdmd5bkdoSEZPdndWRUVjcUhlaVMvUkR6RGpnWVBMZXl2?=
 =?utf-8?B?UHBTNEtQNU82K0dRSldKRWtUMEUwOTVkdEZUUmRIS05NS28wUWF0bkt6alVi?=
 =?utf-8?B?T0hpb2xBcE1GZmRWK1RRcTdKUGczNEJ2b2U3djFUb1pKMVVjajBNYi9BbEV4?=
 =?utf-8?B?WWxVMkltckhCMFFNMU4vY2FVZjhaUy9pQURRaklqNmd3aFBRcGQwS2dtMkVR?=
 =?utf-8?B?ZFNJTGlGdU1STjVwWHVnd2V1RmZIYnJpN25JOUtUOVg3NUJ3cXFUVWJCeFNy?=
 =?utf-8?B?Z0E5VG1hb05HQS82RDR0MHB4QUVFdUVhMkFpbytOZXFjYkRWRnRSK2J0a2la?=
 =?utf-8?B?bWtqVGFoRkZ2Tng4Qy9GQWxNb0R3bFN1WjFFUEZNZDNwUGVmWitFcU5PaTRW?=
 =?utf-8?B?VHMvSnlqU0VxbGRkdm9IQ1RzWHdvV0Ezcm8zUlVlbWdReVFYTkFaUjNyUXg5?=
 =?utf-8?B?dHdUNmI2U0YwZWFLeDB6K2h0K0haY1ZSNVdnSlVGYVRKN2JDUmg4NjREYnM3?=
 =?utf-8?B?ZkszWEVVU1RhbjVRN25mWGRjRDJVL0Z2SU8yeGljb2R1NGVNM2drZFR3aElU?=
 =?utf-8?B?cjEwS3hJTjNSOFR3bmZramNvN25hR0hueGVsd0FOSFVEWG8rREd0OW5rY3cv?=
 =?utf-8?Q?vEgYJWk82hSg1Inwl4C1/S1SsW2e7M0bqgSAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRhcW9NMGhlTE8rNUpVd3FicTNjWUI0SDFscTRaK2ptclR4TWF3aTNUWDV0?=
 =?utf-8?B?Z3RDNXk5aHRqSUFqclhXQlBnSnJpYjZncmlqaTJ0MnR2aHBaZzJNdk5HbFpa?=
 =?utf-8?B?NGllWkMzdFdNODREcitjWXFmU3VLcHo4VGJnM2pMOFExcWdiZStZYlJUOTJC?=
 =?utf-8?B?azNNTmJKYkJVSEJha2J2NXcwdnFQNUlmeDNmZ0JYTlo1cVJFMjJjd0NMNXI2?=
 =?utf-8?B?ZDZmQ3ZQVXQvcEdSb0NDd3UrdDM2bk1mb0VlaWZRSDl4bVVJYzhpYWRTandC?=
 =?utf-8?B?Z3J2TlFmTlJ0S0NacUN3QSsybUlmN3hvL0s5NnZ6WTFNL1lVUnN5MUtETmZn?=
 =?utf-8?B?SnFXVGErUEpCY3p4dFVmdldFdmJmTis0NVlFbnBhVFo2RzE4UHcxRy8xNVNy?=
 =?utf-8?B?QUVyTnFXck5VRnE5NzRSUWc1ZGVDS3FyZVRUNmtOY2M2cldVa1BWRUpCdHFu?=
 =?utf-8?B?VVdjQUxISVkyLy9KNlMwb1lmNmIrM0QwbU5zNHlUUTBPZTdwc3piNVJSSkFD?=
 =?utf-8?B?czZQeU9qYWJZL0VEL2FWMGtFdTAzS01MRmd5RllpdVFkRFJrZ2tyT05sSUZk?=
 =?utf-8?B?ODduTW9haGh0WktaZ215aG9ZYnEyUmE1NzhoSHVYUjdzZjBLM1NRanNWMkhn?=
 =?utf-8?B?SHdiclpTQnJjWm1LdkRyZGZZLysvRzI5WnUyazQ5MXM2UGdvL2NFRDM2SGxL?=
 =?utf-8?B?ckQ4OWhRb0V6bWJiK0h6d0paOEV0VmRyZnhQMDVQWmI5TjVVSmsrSStISVND?=
 =?utf-8?B?R3dyOTF4cU1VMWFnZU1KeHArOTliYnlHd0I1ZFg3VWxrT050b2xLN1paTldx?=
 =?utf-8?B?UGJsVHRxdU44djBtT3hVNm0wVmtiSTRnUitRaG55b25QMEZLZmZ0MjlhQ3Zs?=
 =?utf-8?B?ZXlITVZLZGR3R2llSlh4dlRrOXgrbUxIbGVmT0lHN2VIZm9qaTVNUE1ZK1RF?=
 =?utf-8?B?d3NEek4rM2taR2c1ZDJvdmZkS3dXUWRpVTRyU0lDd0svL0J5alYyS2FpTS9M?=
 =?utf-8?B?QVdvU1JWUkNHNGlKSmFQRi9JRERYNG1YUHIzZVFXN0ZDV1RzTmNIcFBzWThq?=
 =?utf-8?B?TE4xb1gxSTQ3Y3RnVkxSeWQ5T2tSUTUvaEJiZ3NVN3JrVkdXc2U0QU1KK0tr?=
 =?utf-8?B?Mkd3VGhGT2JNNlkzdjNEVzc5a3RBZEY1RHMxOGJJWTB1WlRkdlRUQi9OVnVL?=
 =?utf-8?B?bVQwYzBWb3lYMFFHazhRUVhFOTdLQmpKMjBGUmJLaU5SUHdxbnE2bmNVVzNq?=
 =?utf-8?B?cDBkK0FnS0FVRWR0emZidXlYNWxvNkt4N0MwN2RyU1dndnB3WjdvMlgzdlc3?=
 =?utf-8?B?NkFKSjhnRmpqVHlUSENObXhKSUZ6ZlRlM0U3VVJma0U4QWxWNVBYUTc0aUVh?=
 =?utf-8?B?cWY2RitYZWpia3VXL2UzQ0llVkdIbjVVeCs3cWxQTTRXU1pEcVR5d21PSFlE?=
 =?utf-8?B?eFp2b2VsbmRHZzNZSWpQNkF3WStObG1ENEpWc05SOEZXeU1BQmJETkZZUW9m?=
 =?utf-8?B?eGp3VVFPZ2lFWVNXWmo5UnkzWmdZRnNmenZBMDMyMkRLa2FxSkRnbWgyMzRJ?=
 =?utf-8?B?L2Eva0JRQ1owbTZiandLSWQ1djdLRlNhc1VTckpyeHptVlJKWk1Vck5jdnBy?=
 =?utf-8?B?THQxVDhJQ2QzRlBCZDJxNTZwaDBLYnhIRHhLRGlnNkRhdlVCSElBZlI0VlJR?=
 =?utf-8?B?eUhaUTkrL0laOUdSTWVHTjRiSm5sRUVFSFE1RjM3RVlLTmVmN2ZLMzg3dk9G?=
 =?utf-8?B?NVcxU1VGcnpVbUdITjgyS2RVNEN4QXZzaFk0bE1wQ3l0RXo2VW0vb0t3OGZu?=
 =?utf-8?B?NWdicldlZjdZd0NxSXhjTk11OU1QUEI3d2F3dmJJWTJCcmlWY0k0ZEVTUEQ1?=
 =?utf-8?B?MDNJcHBoV0RCSXNjMWRuS0xUNmcwdXJnNHkveXZld0psQnZIZ050R1l2c0Y3?=
 =?utf-8?B?bDhnVUViUmtPUzRkMVNLUm9LWWo2TGhIUkFsQU1jREdITktJQlo3MHRtbk1L?=
 =?utf-8?B?NU5YUXNuVkF5WHY4ZjdwbFVUV20zcjRVbnVWb0xaUzhKd1Q1enlaTE1mTmNm?=
 =?utf-8?B?YlJwVTM5aXI3KzdoNVR3bXpzTGJKR0licXdwL3FaTkVsZTY5L0J3cC8zU3Yr?=
 =?utf-8?Q?XoM5UFfKYztzN1q2nUworJl0N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61523f2f-c7e5-4bc6-23f1-08dd002dacfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:43:53.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCWTffUS4Lbs1e4uyU1obX18Ar5BLYOvbF4VPNqae6/nkseXbNsrASowY3chT4orWb3KdheJeLnUcJ5VeRfXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 15 ++++++
 include/linux/pci-epf.h           | 16 +++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..7868a529dce37
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+
+static bool pci_epc_match_parent(struct device *dev, void *param)
+{
+	return dev->parent == param;
+}
+
+static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc __free(pci_epc_put) = NULL;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
+	if (!epc)
+		return;
+
+	/* Only support one EPF for doorbell */
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epc_free_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	guard(mutex)(&epc->lock);
+
+	platform_device_msi_free_irqs_all(epc->dev.parent);
+}
+
+static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	struct device *dev = epc->dev.parent;
+	u16 num_db = epf->num_db;
+	int i = 0;
+	int ret;
+
+	guard(mutex)(&epc->lock);
+
+	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your DTS\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return 0;
+};
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	void *msg;
+	int ret;
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epc_alloc_doorbell(epc, epf);
+	if (ret)
+		kfree(msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	struct pci_epc *epc = epf->epc;
+
+	pci_epc_free_doorbell(epc, epf);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..f0cfecf491199
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..5374e6515ffa0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


