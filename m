Return-Path: <linux-pci+bounces-17593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB49E2D44
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E016648F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FC2040BB;
	Tue,  3 Dec 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZCo3Q+0L"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75185205E2E;
	Tue,  3 Dec 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258239; cv=fail; b=LhGFy0fVwD6O4PA2kyNMP5L9q0gHEXQsagkKmpr5l/YFDC51LtJDePuBQKqtiojzAD6dK9qn05v7IagvnTMzXUCkmS+nsPgh7ZDADup/nvZnBMfNv4ejHNfMk/ZEpCsMbOsnRIqMlwE5O8GwVebBqDdALyfFopESDe43TNkOZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258239; c=relaxed/simple;
	bh=VIyuF+APlHGxVbHCKBU3zVADRJEOLBTDV24SeUflb/0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qYMClfrESxfdwovsr2SKy4jAUgleiB056oyG7Asf2wjPL5hCKmG6T8sHw5MCqq1XeAwS9bHJF8DJkeTRabNsA2R0pqnvkTJBIn8WkeaFy5vVVxAAqnvsbSP53K2Yh9p55WkMvg7X2D34zMMmHmBrjs6Z50WxevbzEuIq/zgBqGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZCo3Q+0L; arc=fail smtp.client-ip=40.107.247.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3UXpdFTU1xYRecO11m2hg1MU6yaU2iU0pCVmDMm2R+B/j7ozCJFwvhkxhWuZsovFYm9DRJNr9VriEQKFeV+DHM++8ssNmuPpO7LsIaYq+NmC/hf8QtAHEw5sdiRVKqYNCb4H5mvFH6yN1aCbRDXyLhJnV3uQAhcByiiZXHnNzk8rxFDy+k/ZhnMKvJ+E8TnN1uR83RMn0VfMk3P11A81SqHoTVfdNG3Pk4Qn6jhYSWudqCB053lriNO2bbeeuk76B+4nZvR0ze921TAGmfQWYobUM9i+rEPuPPCVWUHgxHcdUsO7rMth/iA/rU8OWZHYH7XZCiFF+tKqz2OP8XMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaAaAgIktJ7JroizMUpVdHODPOvPbmLVhjbqsqOxQ/U=;
 b=lBjvb3WJ4AZZ86HD97kiyO+l5Gfnv2JyqtBdq3oHXAkMU+lfddzEp1zbSJTUcvMYpLC4QvWQm094ukIr9d6HWtLMo7oBTHO6U3Fsj4GI0Gzy2YoswofhB3GHvmrMnGLzBga+E/m+bL3CazHure992mrKTiv2Zx9iqKAMJjfRgzRKPca7LV9EPSVuh4xBjmaR9HhsTcTJ8rdjEkDnEP6SgGClhh+OeGSkDLDsw6PBtN4+tSJJTjbsfCk4EsFvN1KSnQDephX1wCf0BFHcFoHQfuiCA4Vv2QakMGR20HLeTnm08xy8lN4oOTlZaT9rogL+bb1ImeC5l3LFVTnqvXUToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaAaAgIktJ7JroizMUpVdHODPOvPbmLVhjbqsqOxQ/U=;
 b=ZCo3Q+0Lf3J7temjzT7CXBkqkzY8gkyaDc46L6tgp1Ew4SmDYHplmK4s4uYmzs2Tk7PDumoo5fH+Pa2ifM3Xid4TZcBkAqq20updqAeLJWdZrtz5Mrwr+MvZWcGXUWJWw2Y6F9wE/SPzSmdtUKP9AS4FyegWSPWzJR101GNAGpYaOGbtQkyXsGPifnCbWWS8IgEEUqRnwTdeKkoH95VIlVcuGw8veAiM20mdSqVLT+/6jRB/tLsXMUlIvmm40Lt8+xKmXROZ3uOT0e4DhOVewJUMsAOFTpe4bIh/ZIV+6nmMdulcz9K1qAyzkMGdPk88xoxixE9fTq3uEHnjm2Ey7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:37:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 15:36:50 -0500
Subject: [PATCH v9 1/6] platform-msi: Add msi_remove_device_irq_domain() in
 platform_device_msi_free_irqs_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-ep-msi-v9-1-a60dbc3f15dd@nxp.com>
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
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=2997;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VIyuF+APlHGxVbHCKBU3zVADRJEOLBTDV24SeUflb/0=;
 b=vHiTlC48JtEMcLt88Yc8rsnJo0HGUpGffqsnWTfzD4aEejA2hkapZO77HOE1rYIF2bbCBH/wE
 QMpM7qCby1CBv3d4DXMbjq2MaxKf8fFVVCF5l3kfnjS8VnqizmMfUrX
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0828e7-ff92-4701-733d-08dd13da44e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3JhTE9NMDU2cnNiRGhMWHpzTnUvZGhiRHh0bnQ5OURyenk3SDE1dnFrdW0z?=
 =?utf-8?B?K2hNbWZadFJpd084UUFpSE4yWkJXODBSd3ZFaXpxY3p3YVNIMXdUMDhUNUpL?=
 =?utf-8?B?UHVzRjl4aERaTTZ0aEtjUHNZM2VVaktWNU9CRUZSNXRBdVJkRHk4UnVMcHlv?=
 =?utf-8?B?Nm16UWdUWFFyOThBM1l0d3JPOFdja2VXY0pyeWw2aUpnMGVqeW5SYTlJNDV1?=
 =?utf-8?B?YnVQMzFLS2hFSG9YenVQQlllcFdkcU1WQ2lNQ1hYTW4yRWNUbTRtY0lqR0dO?=
 =?utf-8?B?RlhtRGRSbk52MWhBbTN1RW5NU29qUmVpRmVMWDAxdUhQc00vb0JFbDRHL0Fl?=
 =?utf-8?B?MWM5TXpsaFBxSGZzamJJOTNZVWkyOTR3Q2VxeVliZzRhaXAwb3Nwd3RBbUYz?=
 =?utf-8?B?RW4zVVFHaTkyT29Lay9IWEF4M1lORGxCbkxCMjFJLzl6OG1ScTQ0cFdZcm9u?=
 =?utf-8?B?M1plMXhDZWx4N0M4eHQ5MkkydVUyZjcrR2h2WitkYzZ1Q0gxQmk5dm5VR2ZF?=
 =?utf-8?B?Wm1WSjVqK2tTNG1TREM1UVZGaGV5OFR3U0FSaUlybFhNb2ZwU2cwZXFFNytO?=
 =?utf-8?B?SXVkWDlxYUFJSWpjaXNVcnlneWdKV1RZVkpSbWM5WDE1SkdkYkFNdVBGbFJZ?=
 =?utf-8?B?OWg5L0hHcTFxeW4wMThpb1lmaFpReWtXUDY2UjlmVm1Wei9Rc25EYTRxOVZC?=
 =?utf-8?B?a0tXZGRpNnFQaW5rSENZVUdpSXRFSGllS09wcnpVSVRPcUxnODRaWE40a2cr?=
 =?utf-8?B?emVKeldGVGZqUDNlMUZmbHF5dVRPMlRQdjZXUis4QWxaWDI0N3pmRVdOL1lv?=
 =?utf-8?B?TDhLNnd3bnVJUzhEWWt3TmxESm40cndWT3RiMXJjSUpmbnJWUjZvaVFMeGQ0?=
 =?utf-8?B?b204TWJnWlJlbi84eWJUY0xDZDBadC9oUjJmK3FaeWZzS3dEMUVoWm5QZzVL?=
 =?utf-8?B?RlU2QlJ3TWtQU3oxUXhZbm9BVjVwQ2ZGbEQreE5EaUh0MHZQUityMGZaZTQz?=
 =?utf-8?B?UFFaZjBpaDR0T2ttSXBNY1JmNzNjKytJUVJaZm50cjQ2K3dPMmUxWHM2MFd5?=
 =?utf-8?B?SlNPVnExY3VBb2ZDS0pmMXpydW4xQmlhR3llUHVqVW03N0tBMzFRVDBMMFVT?=
 =?utf-8?B?Z201RE1ERTdaaTF2b2xuK0xQTmh4ZGJLbnZycStLN09sQy8wR0xlQnROK0Vv?=
 =?utf-8?B?K0wzVnBiSTh2TDU5Ymt5MUQxVlJrMHVZUk5ld2wyRjExazJqS3Y3N3F0dU5H?=
 =?utf-8?B?VEtzQXpUaDRjWGg1b284cXZtWSt6R1kzeHJSSTNuNnZLVS9JWDR5KzdjQS9L?=
 =?utf-8?B?Q1B6RENPUEZkQlJCQ2djeklJN1NsOGtLZ1VCM3hCc3pCNDVqOXBlSS9TczFs?=
 =?utf-8?B?Rm5NbWtMVGE2cVMrZk1DbmRiTWVXMDY2Q0pQSm9ENk1zK1FCYVNCQmJpS0FX?=
 =?utf-8?B?UzRlWVp6cVhlSUdHVmo2aER0SWx1cFhDaFA5NklWNFhZWFYvd0d2ZmlaZWJZ?=
 =?utf-8?B?U0dKcHEyai94U2ZFK2ZENGFORXlrY1ZpZlh3RkVxM0lHdk5VdjBUWmR6c0dH?=
 =?utf-8?B?TEhySndhYTR4YlV0U2RVOE14OWFYanlnbjF2L001bzNtM21ickU1QytTdlJW?=
 =?utf-8?B?WUg1ZFJHdGVnbHdWaEMrYVNGcEpXZENMK0F3eGpFQWJJY0xoK2VFTkd0dWw1?=
 =?utf-8?B?Q1R6VG9aejVodTQxdlUxNjlWUlZzeW9CVUgwM1B2a2RJelEza2JIRFFxWUFm?=
 =?utf-8?B?RTBGTkc2RDkvMVYyWjFtRFc4UTB3MGpnbGhzM3hzVy9hLzhHTVljbHBjZU5G?=
 =?utf-8?B?eEpyWmRCblAwZmg2L01acDZtUTQ1SXhXLy9scm9EUzRpR1h2R2NMQm1xbXFI?=
 =?utf-8?B?bkxyYWpyaStCUWhzbi9aTk1qTUdZUHZuZmV1NkJOT2tVN3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjlsdVRzTUZkeXpCQjJoZXZwclpDWEVMaFFPVkQ5ejBVeDNzcTl3SVVqNkZJ?=
 =?utf-8?B?ZWJyL25YcWJ0aUV0OFFjTVFpTVpxZXFrTHh1QUNUcENoMW1ZcWdxWER6cGJq?=
 =?utf-8?B?KzBGS1c3cU8rNjFOUmcvMnVJaUFCclV2VnQ2MU5DS1J4SzVxODNyclpweXQr?=
 =?utf-8?B?azBtSEtQdHRaaGQzYWJMU2FHYnhtbWNwdkd5YkJleHVtMWNVQlpiOERrRCtW?=
 =?utf-8?B?Rm05WEZ0Z21uT2FRRWRLU3Y0UEhsbnh1WDREOXJqa0o3TzZUVVA2TWV6eFoz?=
 =?utf-8?B?QnVmS2xzb1kxVytQUjJaczNZdlJ1SFN2dm9nUEpWNzRUYlhsRVFQRFM3Z1pi?=
 =?utf-8?B?MWhBZlVweHVqYnM2QVlaQnYxRDkrSlorRXVBNmc4NVVmZ0czNWZvZk5QTW1R?=
 =?utf-8?B?ZGErTkpSVk1LNEFSR1pLZHl1a283ZkZZbm82MmtZNktRK1puWkQyR3VOeVVO?=
 =?utf-8?B?MnJpcHJodk0vQVo5MWlLelJ1U1p4bllQME43dDZ3UmorSjF1dzFCVFNuVmho?=
 =?utf-8?B?OElJZkNZOEx5UDlSc2E1dy9RdWh1cW9OeDB6Y3QvTyt0Y2RIcWszMklBQ3ht?=
 =?utf-8?B?TEJKWDRCdjhweUtBK0M3V0xha2tYNHExZ0JqV1d6VG55MEFicWxBTkljbDlw?=
 =?utf-8?B?ZjdlVTY4QmxKMWdqKzNaSk9lenJVWGNqQlAxQ09MVWFpMTJVRm5raWFCZXht?=
 =?utf-8?B?ajVxbTM2eWQ4NHp3SHBvSlQ5bXk3L3FBQzlUYXBUcDRYVUd0Q0dLRFlwQnkx?=
 =?utf-8?B?NTlFWFJJYThXVnhGV1ZaeDNmQlhPZDgvZjFENXZtbVZyZFFVcXBrUFM2Yllt?=
 =?utf-8?B?aEJMeXAydHRqUGVXWEdKN3ZURjlTd01ENWpzV2plTXJrb0NBWFRha2ZlbnZz?=
 =?utf-8?B?eDFNdmV0Q1R1c05mYkNYNkZYOHVsU3RtUXBlaXphcGgwRC9hakRzTFNxLy9G?=
 =?utf-8?B?dEUzTU4vWXk5bW5OT0RKKzRaVGxvaUlKWXlENXByd0lZelNxWDlMbEplanpk?=
 =?utf-8?B?c0FZZ0Q1REhYYTBkcnhseTBlczU0N3pyNEphajgzZkF0ako5aFZLbU9MQ09G?=
 =?utf-8?B?NVEvTU1ia1NENFRaS2t6RzNMUXhrNFR0T0pGWDZhbXR0NzJnU0N2T2xFNGJ3?=
 =?utf-8?B?czFJeUhlSHBGNC8rUnVhKzhHREE3WjVvWlVzRC9NTHhwTFU4dGtpUVBuSFAx?=
 =?utf-8?B?ZEtQempHUmdWYWU2OTlJSnQzWUEyc3dpSDRpYkNvdzlVeVgxWXI1SFp0ZW9Q?=
 =?utf-8?B?S2lzN1hmOTIrNGw4Y3hWWHR6ckY2amhDWUxYOTZZWEwxNUd2SnVRQ2lNS2Y3?=
 =?utf-8?B?YmQ2elloWTFTYmthd0RtRHZxYzU1MVBsZk82NkViMjBsMUdQemx2MVRmYlNr?=
 =?utf-8?B?MGJWWWVZOUlHUjBuc1Z6bVQ4Y0JZcHFBLzh6MHY3N050SmJ3K3BBOFdnWnAy?=
 =?utf-8?B?VmdPY1JuOTdtRXhiZUZHdGhaYmx5UDl0UFZaODh2V0ROYk9Kc08wM0Y2T1M1?=
 =?utf-8?B?aDEwMTNQdXJaT3NXV2dUcDJhSCtVOGc3ODdsdlBRL2tZSGJlR2s4UmN3eDNE?=
 =?utf-8?B?a2VNWS8zWGtQdjEvTG5qRzJ1eWMzTUJnaXc5RHNYbitzZE14aURoaTRwUkRz?=
 =?utf-8?B?Tk1JbDRUSkk2Y3F5azVWVDNqNHNNSVdUSU9HMlNyNEY3TTZMT0RPYUhXQWw2?=
 =?utf-8?B?OFJiMm5ocTU3aXY4SHhWZDV5TGNra1RNTHZJTnArSDBVdlZwR05Tb3l4bW16?=
 =?utf-8?B?cG02MzJYR1ZmZ2dlOW82eHRpL1VDUnlQbjlVV1NDbnFmOVBON0Y0UDUvWi9V?=
 =?utf-8?B?NXBTVU1pYURVckFWYnpTc095RVl6Rng4YlpFWEZwMVFUM0tkVXhOM2R6ZitF?=
 =?utf-8?B?ZldqWEIxejIzUG1uRVQvTnBwWFdEQ0YxU2hrVkR1Q05rUXZOeUZLMGM4SWEr?=
 =?utf-8?B?WkRXNU5tK2ZEQW9uUGtJejMyd2tUNHdHRU5iTXdDVmN5bTRRZzF6WDRwdmFY?=
 =?utf-8?B?WHdxRGdad2pENEo4N3Y0WGxvLy9Sa1o4VlcvVjBSSm1sR0lQRlFyaFFrTUQ0?=
 =?utf-8?B?OENmdE9MY0V0M3dLb2kxbXRuTVZ0R2tNT1cyRG51dmN6UkYxSVpKNldMLy9s?=
 =?utf-8?Q?kQZc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0828e7-ff92-4701-733d-08dd13da44e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:13.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18JjsRs7Qv6R05+A7pPzsaKl12fGRL6C8Aw6ZSL1H8NKPJRFjsfRA6W+FCpspZrDAuNwvguxPic6Z43UlZaJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

The follow steps trigger kernel dump warning and
platform_device_msi_init_and_alloc_irqs() return false.

1: platform_device_msi_init_and_alloc_irqs();
2: platform_device_msi_free_irqs_all();
3: platform_device_msi_init_and_alloc_irqs();

[   76.713677] WARNING: CPU: 3 PID: 134 at kernel/irq/msi.c:1028 msi_create_device_irq_domain+0x1bc/0x22c
[   76.723010] Modules linked in:
[   76.726082] CPU: 3 UID: 0 PID: 134 Comm: kworker/3:1H Not tainted 6.13.0-rc1-00015-gd60b98003b43-dirty #57
[   76.735741] Hardware name: NXP i.MX95 19X19 board (DT)
[   76.740883] Workqueue: kpcitest pci_epf_test_cmd_handler
[   76.746212] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   76.753172] pc : msi_create_device_irq_domain+0x1bc/0x22c
[   76.758586] lr : msi_create_device_irq_domain+0x104/0x22c
[   76.763988] sp : ffff800083f43be0
[   76.767313] x29: ffff800083f43be0 x28: 0000000000000000 x27: ffff8000827a7000
[   76.774466] x26: ffff00008085f400 x25: ffff00008000b180 x24: ffff000080fc6410
[   76.781624] x23: ffff000085704cc0 x22: ffff8000811c8828 x21: ffff000085704cc0
[   76.788774] x20: ffff000082814000 x19: 0000000000000000 x18: ffffffffffffffff
[   76.795933] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   76.803083] x14: 0000000000000000 x13: 0000000f00000000 x12: 0000000000000000
[   76.810233] x11: 0000000000000000 x10: 000000000000002d x9 : ffff800083f43ba0
[   76.817383] x8 : 00000000ffffffff x7 : 0000000000000019 x6 : ffff0000857e443a
[   76.824533] x5 : 0000000000000000 x4 : ffffffffffffffff x3 : ffff000085704ce8
[   76.831683] x2 : ffff000080835640 x1 : 0000000000000213 x0 : ffff0000877189c0
[   76.838840] Call trace:
[   76.841287]  msi_create_device_irq_domain+0x1bc/0x22c (P)
[   76.846701]  msi_create_device_irq_domain+0x104/0x22c (L)
[   76.852118]  platform_device_msi_init_and_alloc_irqs+0x6c/0xb8

Do below two things in platform_device_msi_init_and_alloc_irqs().
- msi_create_device_irq_domain()
- msi_domain_alloc_irqs_range()

But only call msi_domain_free_irqs_all() in
platform_device_msi_free_irqs_all(), which missed call
msi_remove_device_irq_domain(). This cause above kernel dump when call
platform_device_msi_init_and_alloc_irqs() again.

Fixes: c88f9110bfbc ("platform-msi: Prepare for real per device domains")
Cc: stable@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 4401cc31e4736..e7615daf5f539 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -98,5 +98,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);

-- 
2.34.1


