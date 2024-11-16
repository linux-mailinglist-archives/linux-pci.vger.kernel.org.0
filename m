Return-Path: <linux-pci+bounces-16972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF349CFF4F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E5D1F24402
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65215B0F2;
	Sat, 16 Nov 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GT4aJ7Zj"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418985270;
	Sat, 16 Nov 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768075; cv=fail; b=JgLT0m4SANv6kJWtMbF0wEo0DVrS3jOfO8sliy1mDxCjuTRgbb8bs0f2oVapP4aEBXH2rEhpGOAyNPB5oMC8COxF+19uGhaLfY0zGDDaRWdzsqbVHUzb6AfN2HxP9NuMXN2em+965v8q9fUC1XiNqdc+kq/NN1N2S6/WAh0Tz1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768075; c=relaxed/simple;
	bh=ALBAmWL9QxkgiZp6flstYazhrERZ/ebCU5ovpzJ3ESM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dktGos92A77wETDufjEy6XskzYQehJgo6zFnb2/N9LJJb9lKk4bt/lthnao+htbRSQ4ZA5iHA901zsYcbUIaLBWA+MZwy8ehs9+nYQZXf53Xc1bISqxyvUEo8YT5CVcAom4vGLhA/Bxyes1YWgp/+RGnGkzlcu/fHpuAhzJSZGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GT4aJ7Zj; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt6Kd3TCWAxZ7fa6SKW3oP2rXFY42zpkGwnlXRIredkQwyZSFep+IAd5cjgS+TKToKE06XVxvNqY4mg+bqyneMEkHqh+ysuy67yjs86Vh8JAohpolGNtvRJRPWTyXOAkwAYzeIf+0uSm0Sf76ZQZWJAGzVl+ONUUWM/1DB9hoP6xLJz3+jAosmGk31N0+vtey7Jg1qQ2y5cTpqbptc6uJU931r7i9KE53gNwjHKqubCk7Q90PPzvK7ZeTYB8KRSn8wznLcjO5iosEe8eotPCu45cq/ieGmIfV8hk3Z4cxBC6N5kamLyVyFvttSzjnF5FlTw+7vw5uxhju/EQgs/q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY5/Xe0JHtvYAV4/rZwMg3zPMgkyu1iopPbYp02fQO4=;
 b=tTL44kJ4POM5JNokvJfO7jRYotlEKAoFxAvAqjzj36SyLzr/9ULqfZAu1hfIA9TqGz2MLYYmcynuFfxk2iRbx/WC1crRYelvtXHt1JdoxFItYsGpPKzuC/4dhhGpy+Ud+cyP2DfjmfbqCQuZSHbp7nWlHm7Ow6hlB9lC+kpzyGt8PCKhluFC4Y7VrRWUAaLu75XRZSmj58ngK+LzfXKv/RTtYYdAFFm3tH4PLdNzFGKvFYTzbUht8ZgbrfXaxjKv3sQBzSNRV/AQ4Nd7wKF+BNKka9i/iyjIf/aXaOvcx+Ig13OeUu4cysduSRGZ1bYl9OXo2UjWWXOqHncJMulhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY5/Xe0JHtvYAV4/rZwMg3zPMgkyu1iopPbYp02fQO4=;
 b=GT4aJ7ZjVt7VuNYzLZ1Q2yuOBd477oXfQY1XItrIoPO7K9jW9ggWwRa1n/k0QMjZVieX2VMfXRJnD3qTQDNmxXz7mv3KvZ2sKsMUhoAPTgeqB2YKOJ7wxfFryXTVQ93oLqiF6ueVfy4mmt4MqqihjE0CLlTnBPJJJsuPUTAR5mxUAf0GF0OKUoIBvTNpkFPmJEtccRMGMNymg+RSLGi8vuIEQTLuYLxI3oZPEjtZy116FNwEPkZ743TFr7rcpjWRatk35EK+JnuDdC7C1pWXQNLIs1ttSVUskWFNXSQ6ud5cc2utBoY5OEex3U1hCX2G5pnkutwxHtHE88kLWqSe2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 16 Nov 2024 09:40:43 -0500
Subject: [PATCH v8 3/6] PCI: endpoint: Add pci_epf_align_addr() helper for
 address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=3556;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ALBAmWL9QxkgiZp6flstYazhrERZ/ebCU5ovpzJ3ESM=;
 b=3llnIb+dDZT9nhTeO3V4fobFNL3Innm/Y9a784osQBC92UaQLwFT+sfqe/wq9QXW9m6CdK/yZ
 P9w6p3MbsNdBi3w4NL4lPEtLdmjpwEa3OzaDBship1VdShJ6XCXIBte
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
X-MS-Office365-Filtering-Correlation-Id: 01f8ab64-7d1b-4892-4844-08dd064cb7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0ZsR3FoY3ZiWGg4QjB0T0NkNGZiT1BOQm53VXZlbGxtbFowREVzUjJrdVpK?=
 =?utf-8?B?L0NFazk0NGZVbjJMV1YwSmV3ODNFVmVzc2VtM1Y5cTdIZTE0RHJXSXFLMEVD?=
 =?utf-8?B?MEwxYTZVd2VZbkd1MVNmai9uWHB3OFc0UFAwb3dBQkJYYXFGdXkyeEtvbU9G?=
 =?utf-8?B?eXR3c1lGZ2o4NTFtQ1cvV3dEK1Q1YlRGTm40TUtvdU00QUFoWldiSUVxN2RJ?=
 =?utf-8?B?U1NjOTJ0RW5Hc0s5MkRiak9zVE54YlQyY2krVjdhSjk4QUpmMnl3d25YTzRU?=
 =?utf-8?B?WVNRUFlRT2RON0QzN1BxdFdpcEV3S0pvdGpyaVRkV0RwaWZLekVjWnFUYnph?=
 =?utf-8?B?QjM4TzdybHp5NEVoTzRTNzlvTTMyM3RLNlJyS2V2dVRnL1RBVVNCT0lqLy93?=
 =?utf-8?B?UjZaSXBmcjRlMnVnRzlKdjN0bXlnVFYrTmpPaGQxK3pYS3ZBek1VbDY3NEZ3?=
 =?utf-8?B?U2paVWRCdlpycTlUTWhkRHZHaWRQb1l5b0h2a0FSK2lVbCt2Y2htdHpDZXI3?=
 =?utf-8?B?VTFFWlpyZDdick1NUFhvWFBiWDYrM0tTU1hPTDloWm44T1BxL1BPMFBWNHhR?=
 =?utf-8?B?TVNtdFdDSndRN2xNTXlIeHo4RlhLREhOeXFKcE91VkJLSmFsY0o0WXpQdS8r?=
 =?utf-8?B?VGFjSG5KVmFtZy9PQjNsOTVUbWpHbU9KWHJNMUUvV1VNS2orTnQyTDMxRjAr?=
 =?utf-8?B?THdzTkp5c1BFL3N6SDJwQitpQU9RT3JyVnlvbzZhc2dzdStONmhaSTdNbFdu?=
 =?utf-8?B?azZ6bWxEbmVXMTRObldKK05VUjZiV0I3VnN0TFUwNFAvTHZLNjYxRm5xc0da?=
 =?utf-8?B?Y1pEUjFFQkxaY2Fod1pkREVtczA1YjUwb2JDeEZxSUc4YktsWDRtanduNGV1?=
 =?utf-8?B?MlNZZ2lzU2pQRkYvTCtGSGpYSGtYYklKYVlHWnBZdGVZT2pFUUJ4THl6cEdU?=
 =?utf-8?B?ZjJzUmsvQVFhRDc1K2lDTUtXeXgzMTBYSXZDOEJOVHM4ZlBjUVozd2Jobkhl?=
 =?utf-8?B?ODkwN0R0VlBYV2NNM2FQNXBLVjdiTTNwM1J6Y2N1cFZUMU4vamNpWWFMUUpJ?=
 =?utf-8?B?dzNtWmtVR1ovck9tOE9YenIrZ2hoWDFZOGQ5Mjc1ckdsbzBHdjhZYlpoMStZ?=
 =?utf-8?B?MWhZSTBYeDNUOWZjSC93T1NhOUlTcU5wZmhVVEYyOXJwMHdjSmdHZ01pQlE0?=
 =?utf-8?B?VUxVU09Ub0FJd3BNWTZqUUJFaHlmZmxnMGFpek9IelhraVo4ZFUyenZ3RFFS?=
 =?utf-8?B?YmxUYXNZRUdvVHN2a3Byc3dDMk5kalI5VUZvNkIzaXArUkFodnlwRnVwbUJV?=
 =?utf-8?B?WFlSVEptOEExYnlTMll0WkZvaTVoVmMzbHVlTWdJZlZZRGYvSUt4MGFqRU00?=
 =?utf-8?B?d05Ma1hkWDBWSnhVOXJ3SlViZEpVYTJjb2lyS0o0VEl6NUJiRVd3K25lNERH?=
 =?utf-8?B?dzlNMVNsL1ByeUlzKzFKN25PTDFnZk8wVlBEN1BTTnZqbWRtZGNPRHVGRS9X?=
 =?utf-8?B?ZmFiTWZZQ2F2K040MVlpMlRwQ2grMTd0UG5lZ1NWS0MzSk1UTDZ5bkRYQTRX?=
 =?utf-8?B?TnJTVGhtZ3VyZEZyb0hMRDV3cXBlWXpVZEpFTmk2Q3o2Q3I5OTVLTnFFTW9K?=
 =?utf-8?B?M3l0RG0vaFVDZXFOK0dVR3I1S2tDemV1YUkzL25PdU9VSkhQYnlUY0k5UHRj?=
 =?utf-8?B?OFg0UEFvTXM0MFJpNk1hZ0lpVkRKZzhOVmlMK3I4LzJMUHR6L1JsQ3BmR0hz?=
 =?utf-8?B?UzY2QWpMaytud0NKQ0ViMzg1aExtUnNseHFoaTZocGJOM0NzaVRSbVRYUzBB?=
 =?utf-8?Q?4/aSmnddmikCPsxk0oqBPQqoGI3lGXRFxkZ6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnJKK0ZBOFRISTF4VGlnMEkwYy9peFFhSWJ5dnNBVGV0em9hWU5IUkREbHI3?=
 =?utf-8?B?SHlUbnQ3a0FYZFJTNTJkZmcreW80Wkw4a0p6THZRUG03R3RkdmlHcnZBYU1z?=
 =?utf-8?B?bjFOc2s2amtlYmNyOEpkYUFZSyt5aUE4OTlvdXg5OW5Qc0VOTGNhdVpSOWdR?=
 =?utf-8?B?Z091N1p3MHV1OFB5SzhxdStOdXliWGVOSEtWdzJMQkNadmhFWUxVYkl0WGIx?=
 =?utf-8?B?blorb3AxOHFUOE95Y0FlbjFwbHlsbk16b2F2YnRxcGo3aXJZMWlnTE5HS1ZJ?=
 =?utf-8?B?TkdkaHVDN0FnZGdWZHVHUkdXbjVUbllBaDA5RDc4REd3dTJneUtwVHF5U2Jr?=
 =?utf-8?B?aGJHNUN4dlhQYW91Sk12cFpsV2Y3cjlEQVQ2V3dVWEcrVlIyTldjaXN1aytK?=
 =?utf-8?B?dm16RmZ5OFZCcDkvdk41VjJKai9nOFlmNXNLeGk0QWd1cFF2UTVHZmJCYldv?=
 =?utf-8?B?em1aREswRXBWZU1YYkh5RzN1ZlpVOUN1KytnT3ZHUjFNbUVJNFhwMG1GVXZz?=
 =?utf-8?B?dUhIQWZPWDlUenkyL01SNElNK3Fpay9mdkhzTGFJVUZpK1VQVHBmRXFjZDc2?=
 =?utf-8?B?dWsyTG1XelVRZGVNQTdDbHVRZXZCSk1qQ3ZqOXkzR3JhTkFjVWtKT056SEdy?=
 =?utf-8?B?N3pEampxRlQ2YWlDOXZOa015d1QyWU0xc0tjS1kyS1NxNmUwYUZvOUVCTVl4?=
 =?utf-8?B?NGc2QmZ2cGhQWTdLbmdGT25tdFBmZG5sSldhR0FzRXlQOEtpNU1sVFdab2lm?=
 =?utf-8?B?Z2FNb3JIMHFWUWp2bFJVNG9ERnEyeHRRQURnUVNMbDlVSjdUbzc1b0U4ZnNs?=
 =?utf-8?B?Qm8yYlYrUlJXSnlHWFlnRXlZTWlKVzZDMFBTVThCUXphc201WlQrK2VQUkRW?=
 =?utf-8?B?MDFlMzdIRFFkWDVSenNrN0c3cE5jdHlnVFZ6V2orSWxzZHRDTG9KQmpiMFlF?=
 =?utf-8?B?NG9QTFdDcjNPQW9ibHJSY2FaVlJ5QkhRa1NsZE5IR29NbU92VFFpSi9pdUVD?=
 =?utf-8?B?UUNvTnovREF6aEVQRHNkSmtXN3Q0Um0xVjdPMWoxSHZlOVFjb2xXWGVaZWY3?=
 =?utf-8?B?VUpwZFAwMWQyYnAwVWJqVWNkMktVNDFCcVVwU09YRGdXZmdmNi90S21ZSHJs?=
 =?utf-8?B?dVQ0RGlVYlJMTnlKQmVSaGpsUlVZblVqSmY4QXZ1bGRUOWFORW0vN1B0U1VH?=
 =?utf-8?B?aUFWcTIyb0hjUWM3SHJNbllkcCtyREx3emFrM2pzdHYwcTZNaWxRbDZuZGRX?=
 =?utf-8?B?czRRQVhuT05JSGVmNlY4czlZeExmcDU2S2VTd2kvaUxYNWZUY3hiaU5YNUF2?=
 =?utf-8?B?eFkyYi9xdlpJMWFLV0gxcVNZZ1hwN3EydGF0SHk4YWR4S1c4RkFrT3JCSkov?=
 =?utf-8?B?YmpxMEhkMEdmRHNjSC9ISDNiakorY3NLdWw1SDBqc2JFYkM5VWhTakpnYlZB?=
 =?utf-8?B?MGRFaFQ5NFpkL0tXUFRITkpBZGV5YzlaenI4bzliRng4N0NPaDlNU1lkbnRB?=
 =?utf-8?B?UmpoWDhWenZ0TXBDTG8vRW1hZHZ4aEdHUEZSbjBHWmhDOHdJaHBFS2NZd0Vv?=
 =?utf-8?B?NmpzTkVFZldPWlJnQ201N05TcVRPRUVKNWVJck9pcjNUeFJLcTA0dDBaZ1B1?=
 =?utf-8?B?QWJ6WmRoNXZvTW8xZFhxT21lRVRTeWlKMklCZjBGUis1Q0UrY3lldE9GM090?=
 =?utf-8?B?clJVT1hYRFk0WTBUQk1YYU1JNXQvQm9yVlltS05jcUNOenZ5L1lJa29qYmhn?=
 =?utf-8?B?cjZBT3Mva2MyQUlSNUhrTWlXNTVWdUlOS01meW9remFvN3BlZlQ5R2JJYTU4?=
 =?utf-8?B?dGJnY1RTZ2FhbHRjTWx1WmJyQnNNUE5EeVI5QmZHMUdFeHNqbnRMZVZndFhB?=
 =?utf-8?B?NElBNkwwYlV5YXhtQTQ4VkplRm1IUmR2RC82QXY1N0FGUXdTU2cvazZGSkg0?=
 =?utf-8?B?MC9nNStNWjNPZC83bUM5cHF6YUNPZXplTHBxYk5OT1d1bUd2OGFpRXhJN3dx?=
 =?utf-8?B?bi9CQTV4ZmNsNC9TTDJSRW9tZWlWdnk5SUpDaUppaFFzdFQ2MjFka0RpZk95?=
 =?utf-8?B?Y0JwR0gwNjB5ZW9xTFNXVEJnZllwaUZJdHBPMUZYRlVueC9jdE9ZdWg4OG9T?=
 =?utf-8?Q?Fy5I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8ab64-7d1b-4892-4844-08dd064cb7b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:12.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJhWBaPWvJiS1vDuCnL8fuwBUjpBXXys6jI3e9zDknpHKNhHq6vaZs+byhAmT2L69YIoMLlx2WkBkLhCZ/oQ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

Introduce the helper function pci_epf_align_addr() to adjust addresses
according to PCI BAR alignment requirements, converting addresses into base
and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 45 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             | 14 ++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..4dfc218ebe20b 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,51 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match bar's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement, nothing
+ *	  return if NULL
+ * @off: return offset, nothing return if NULL
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	if (base)
+		*base = round_down(addr, align);
+
+	if (off)
+		*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..eff73ccb5e702 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,20 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
+static inline int pci_epf_align_inbound_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
+						   u32 low, u32 high, u64 *base, size_t *off)
+{
+	u64 addr = high;
+
+	addr <<= 32;
+	addr |= low;
+
+	return pci_epf_align_inbound_addr(epf, bar, addr, base, off);
+}
+
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


