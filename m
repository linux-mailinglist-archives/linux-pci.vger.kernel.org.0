Return-Path: <linux-pci+bounces-36886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D3B9B7F9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732F83BF830
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CA52848A9;
	Wed, 24 Sep 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="drw0PQkn"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3B248F78;
	Wed, 24 Sep 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738946; cv=fail; b=fFH2tb2Y0W8gQtDeHk1rppSNRG7r8X8pMLNQJT0xfia7rUINKQDrN4+nfQ7LeuwY7FZWNQB0iurNhTLlEP+9ZRMm462JE0sab3gfJzBz6y7W2Y+eI7gbXZv6GAhEl1aYa9fo45ElBlWV0yPCrEQOhRfF8yJcAw2fxEDkI73RZ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738946; c=relaxed/simple;
	bh=Dt1cZe02hD7K6keuiAN04iSyImsiB12le1O/Z2m98ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dx3Jg1slAcnyKnPVCGC9cOlNz/YVoV2cFTrz/4Pqw+1SMzDK7ZSjc5mvFiatwEPF1AYy3Am5bvYKn/6s485Gl7LdHlBSxg2/n7X7tXgJDHaYoy+IwPsyJCN5xvw3UcBX0Wpv+cSxxNGXKYYydyU+wb5ZBhqQho0uH429Fwbi7Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=drw0PQkn; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujdQSqtILzXK8bzA/TlfkH87EVvTRAgDS2mYu2RjVqsctGfDCUiUYCUWNq6cAVQFVbZloRIIfUp0Zs6YaZ8loGKz0DJxooivV3OqnCr4EigesN0jtnJxlzOAVFg4mM9NWLgdB0X7zQchgnEJo80H/uUxmVNPmXjJWBV5VQhpiWHN9dTvhSGEt1chkPaOil4A7KyM5Up99dtEk0IpUcCZGdHODe1KtiD8ItkLoK1p3ymj2jubpkANEYTGj22OLu5CrrW/BaHFa/+K6H+TUxzDQqJZkClYVqALa0wV1cju+a1O3Qkjlce8kyuced05kYylvXrAI+UA6ZpgkmII6V5ZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GTErhxOR1bJ96o/iDV5j8n90Q8kQ23wJAsJ+hGuWM4=;
 b=CnVo1UOQBg5DKp1h0J6ooT1DBk0ig8BEogwVpIOD3NwSCDoQDdUHbkW2xPCowWU2cvkzj2FKj10d9/gG0PEA1ZgGLLiL6mxdvVNGzqYP4LOVV8le6AuLEWsl4ehp2kX/gVkgWaOtZHBCAJ0659U3OzjiwsjbWLyEc91ve4ESsChjP5LdpnQTgBbVXDLY1VwHKuQel6XJjWUCRqLwQ94cjcadTJ475VLn3pQtUBi7qamGatuftVkjWU1OMYUoPJtwmWz8xIrJE0tMduuk0xYxQ3/ihvwLfOH6eYLIKwssInmn5qH9NOBvjoMF8KNL8CYQvruluFChJZYhQ60rpwKOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GTErhxOR1bJ96o/iDV5j8n90Q8kQ23wJAsJ+hGuWM4=;
 b=drw0PQknQ4SRFRQBMmqHuy7vFZpwjdnNbSyRZNRcv2S/QEPUJfeyLElXbvsZRKsN2Y8UzMeP2z2dPq6lPXhSabHHw+EJTJdqgkFWXE5iPLOYSsnwV8Q4KwNNQEwWEm/SThIViHigHMkL3LclXR3RdE3fwuqlp4y2LdZPKrvw3xPiftMKOhiPRdiMsLH4As9dE3fshhivmsm9LZP6tXqHc/Del08hwCcaAkEgzcUidoGIFdCtLYy3pMGDgVjid2G58c+l6i0jqj2n4qb1z4YcXE1CHrTf8qAzvxL1hH+K7Znq8mjld9X5hlr+rlDQPXR9oPP8idMKAolIy3I1u3B4RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:35:41 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 18:35:41 +0000
Date: Wed, 24 Sep 2025 14:35:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/3] PCI: endpoint: Add API pci_epf_set_inbound_space()
Message-ID: <aNQ59vGIu82JtFhT@lizhi-Precision-Tower-5810>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-2-ca71605e3444@nxp.com>
 <bmz36usaey7skutdukgryq22sgvyidfnmtx6z4zrpcvrgpvcdh@4l47wob6grkn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bmz36usaey7skutdukgryq22sgvyidfnmtx6z4zrpcvrgpvcdh@4l47wob6grkn>
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5e756e-4451-4b7c-25f0-08ddfb9929dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2s2WDBiak1qNFYxelJ3YVlYU1lVZW8yamxheXB1Mk9BeXhKbEdCSVpURUdq?=
 =?utf-8?B?OXlSKzYyUkl3emRjVGZuSVU1OUh4QU82cVVNWE9OeVM1Qm5VbGJMYWx1dDZN?=
 =?utf-8?B?T0pzMmVoUmN2RldBeHlIWE9UTWVEUHFjdEhwbHlETzdaZlRDT3huckhOVG4r?=
 =?utf-8?B?bkdyZDNSSzdQSlF5ZDRraEduRGRIZlZCM2lDUFV5Y2F6QVNjOE5TZmN3ZE43?=
 =?utf-8?B?N2pOMHJ6WGo5OVhMNnk5SkdnbGtZT3dsZHBQSEhZTWZpamRwUnAyajcrRXlR?=
 =?utf-8?B?Q1JvanBiMWtqYXA1WWdjM1k1UlovMGkyZXZDb3RUd2Z4TVUyUlpKUkV3eEJw?=
 =?utf-8?B?N2c4M0F0TjIzU25sSGNOWmFGUjFSSCtoTGRFWHNhRThybVN5RU5XbDM5eEVY?=
 =?utf-8?B?VE5ET1YyWjU0ZWRvWDYwYnI1UjNpRm51amhNS1JKajB3ZURuY2F2WUwxZUo3?=
 =?utf-8?B?UEU1N3dlbUl4N3RDV2ttbTQrR1B3SVFhaVFIUDNnMm9nMXJwNkFoVjRzeEdM?=
 =?utf-8?B?YjZVZmJiNklVLy94ZW8wU3JOLzh0c3lxc08xTU95MWFFOWRTZTNQaFZBSEw1?=
 =?utf-8?B?VC9MVmd2RFRWUXNQTmpJU25qd21Na0hhYThYakFKMVh4Lzl3TlhlR3FpOG5G?=
 =?utf-8?B?QlZNU2pLQ2NXczJ0czJsTkEwSlF3N0J3a3J0UXZiQ3N5aUZsUDJkN1dHRXNK?=
 =?utf-8?B?ZDQyeFFzYllacTlmUXdKdnVZL09idXZrMHVNd2w5SXNKQzZaNWFTcWVsU09x?=
 =?utf-8?B?MFhpTFVEeUgwU1E4RWhNaVY3TW1KQkdET0xuVE5sYTloWXFadUNqM0FMbEYy?=
 =?utf-8?B?VG9hbENpZ0I3RE1OU3c3WUdOdWtiRDEzNnd3OUtuR2NLc2c2azc3SkNGaGhZ?=
 =?utf-8?B?OW9NRG9CVVZxbjJCZ2lzTHdYT25hVDlrMHdQbU8wVzZjYXVFZGVYU3ozUG9J?=
 =?utf-8?B?enZWMHZQWFpMcCtIUmo1Tko2QzRuOTZUZUNhSkh5VEV0bSt2MTRtU25laE1l?=
 =?utf-8?B?eldmcW5XTlo2enhVV0hHUG4vQ0ZUMjBOaHIvdHJiVDNZcGRPMlUzRjk3dEVD?=
 =?utf-8?B?RXlQOHZvMmc3bTl5VGRJWVplbVRIdXVRa2FFYXBRSENadUU3RlUyY2pRbHlt?=
 =?utf-8?B?dEpKUWkxNzF6TThqM29iaXhsSWtNQzl3UWdJdUpibTl3UHFZNndtWkdYZXda?=
 =?utf-8?B?bVFTZ2Q4OW1CYUpJOC9tN1dZZGswYnlxc3UwRTM2aWJjZEdkTHBOTGhha2Jj?=
 =?utf-8?B?U3kxOU1lZUtuK1AxQUYzM3JHaU9COVJxdEhHSUFFQUJnRWVTOGdyQ0dhZWVO?=
 =?utf-8?B?bTByRlo1WThzSmhTWENHRlpRb0RnZkw3cmd2MkJ1czhOZEYxcWk2M2x0ZkRD?=
 =?utf-8?B?Qmp0bUU4dkZNbDBKUlpEYkpTTUxBQXh5UEFUK00rZnd5K2kwRC9wTG01cWVx?=
 =?utf-8?B?TzRVK1dXZDZ2bmtMY291cHZ6K1VwbTZoYnpGMjNiNmQzdTV4UHhrYTVFYnpM?=
 =?utf-8?B?YnBrbjluUldya2hMLythMytnR1VvNWVzS2dESVdiTS9RRjh0OWZmNEJiL1NZ?=
 =?utf-8?B?Yzc4UEFhN1E1dkRrTnBNcWl0OVZGYXFWS3gzZHdhR05vZjByUG5jb1l2UzFI?=
 =?utf-8?B?NEh4VTlsMnRReEVPcGk4Y3JTK2lESU45aGpLZDJvS1plV0Exbk0wQnV2V3RI?=
 =?utf-8?B?cjZHL24wMVVQS2toTUx1dTNzMHMxVFlaZHd1dUVqS1NOODZrNUphYmlpQnJN?=
 =?utf-8?B?MEVIUWc3M0VMemd4cEIxQjNXU2dUMWVlRStncFhnaERGSGp5K204b0FYZmNS?=
 =?utf-8?B?SFE0YXVlTk1ONmU3Vyt5blRhMDdHblFiMGEvZWFwOW1CaGQyYTlBdU9vR09Q?=
 =?utf-8?B?MDlMb2ZLV3ZPYktsdkZaZ1d6Yzdzd3k3THFDR1B0ZVpWRzFldkl6ZjJwZTh2?=
 =?utf-8?B?VUxzb096UFZzbkxKMys0R2xTK09Zam5tYWhidXIyYjRsajF5bHBYZTdSQ3Bq?=
 =?utf-8?B?YTQ0TkZla0hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGNIRXJMMFZuQnY4Z25LNloxdEV1RlJybzYyTVF4aFd4VTZZMkFxYW8vRmdJ?=
 =?utf-8?B?NDdNbFNGWFhBM3lJL1UrSi95TmprOCs1WUVmZWNWNWV1SGdoenBqYU5EYkFu?=
 =?utf-8?B?NS8yVHF5RFlLM3J5QWtvK3VWdkViZkhmcFBZaS9PWDVzWGlNajRkRVVSVUxD?=
 =?utf-8?B?T2MvM2VDMldwN1IzZndIWWducnhpU2UwWWJuK1NZc0IrWnJXT3BEd25jZ3Zp?=
 =?utf-8?B?NjFSckRXcCtqL2lZUjNXdHFEN1R3cEtJUHhZL2ZZa1VlWmJYVS9teTk0TWRk?=
 =?utf-8?B?VG04MVFVZWRudU4zZGVaMnhkMHhKMmwyNUQ3MXZnWlcwVUlpRys4Kzl5RWY1?=
 =?utf-8?B?RjhZSTUrbk9OQWoyK2ZMaFF5N3B3Z3grbWVsV3V5YjJTMUlnN284akpXdmpt?=
 =?utf-8?B?aEJDTlp0aE1oeXBEZG1WWk5nNlpXRVV1aklDdWUzbmFyNDVnRkJrNHUvWlRF?=
 =?utf-8?B?clNJUFJWajFlNHU5R0NXV0RxVW1WblIwalNpOUUxN05oNXByazhXRWtIdVJK?=
 =?utf-8?B?VkZiT3ZSUDdvZlJ6dWtxanlEYWlCek43TkNmeHZlYWlvbmNWZzAxWFI1Z3lt?=
 =?utf-8?B?S05lTFVERCtsMDgrWkY1elNpOFJvdkJXQ29iQnh2QjBJeTR0QXlRVldyN202?=
 =?utf-8?B?RHU1Si9EMTc2dGR4T0kxRmkzOGdSTG12M3VodC8vU1lmSDlLaDFTVTFBd3Zs?=
 =?utf-8?B?eXUrQWRTK1Ziak9rQVY3NHF2TmVpOGJMb0tOMnpVYmJ2aXFKeWJWMXcwakpr?=
 =?utf-8?B?TTlkb0RpYnU4a2RTdE1GejJvM3pWVkd1U1MxMzVTU0JwMldQUXVkMU0xOVBM?=
 =?utf-8?B?T0pxcUd0dWpNZml5TWF5OFRBL0tTK0ErNzFKSXNIM3ZkOWVsZjc3cENyT1lF?=
 =?utf-8?B?WDRIWFlwcjJINU1QWlA2cS94cm1hdDhjL3F3ZFhSTVJnZ3RRY3NzSXFXYThN?=
 =?utf-8?B?dUJqRWUvMk5kWFdxdTRFNDBXcjJkRlZ5cE51aTBMaklBRXFESFMzeTZHYXJF?=
 =?utf-8?B?WW9ud2dYcTdnTHR1aHhhSzdKaFNwOTBncjNoWG5sU25xSnJqUmFpUEY4QXVV?=
 =?utf-8?B?anRpcmVBS05Kb3d0UVFoOTdpSVpaN1Q3aWZBYTQrQm5HbE83cHFISUVFcXg3?=
 =?utf-8?B?dHV6MlY0MnFkQnd1U0hIcU5ZVFFGN0F1cGorODlLSS8wSUc5MHozc0liY04r?=
 =?utf-8?B?aGlEVlRTKzJHQVg3K0JVZytXNUg1RTZseG44ZkYxV0hKV0pScEFKTHNpOVVt?=
 =?utf-8?B?NThkZzJ3WFo2UUFJNmdlcnlVQlpyK09BR3lzbmVsemRqdW1NbjlPTk9KZEVx?=
 =?utf-8?B?NnliejFPTG9kaWJkV1FMTXBidjd2TTd6TExPOFYra3RFVzVxckRSemlxNHQv?=
 =?utf-8?B?aDRUbVdWVXpSbllUWjMybkQyWmxIUTFGV1RzN2dPbTVWVWwzc1lQS3NKZVhr?=
 =?utf-8?B?K3pJRUpwRk9UUERhY2R2NHZJV2F4bVMxY1ZIck9sMTI3Q1U1VTlXSkdWRDVu?=
 =?utf-8?B?NmFoTUN0a05RSll4QmVDREdXdHNjcWNMcWJkRU9Zckd0NStXbE5zakxmT2Nk?=
 =?utf-8?B?Y2dYMGJZV05zaU9xbXpZcmZhc1VjaUEyUlZSV3R5NGhIT2hESmRRWDlPKzhS?=
 =?utf-8?B?RnlEdVE4cXI1Y014VlRsZ0pxbG4xTGd6TUx0Yzd4SEZORi96Uml5dXJvbWIw?=
 =?utf-8?B?WXYrNmxzV0t6MmdYQ2Y5WE11U3ZKTTR4ckE0QlR4SWpaWGlkbENKQTdFRmhT?=
 =?utf-8?B?WWZUVnpYaXUvaGs3RFQ4eUE1VGgxRlZhQ2c5Sm1KMm8rY2ljeXFEKys5dDNF?=
 =?utf-8?B?Z2QzSmxwdXlLbjZ1NE1PYWVNdllxWkkzOGJtMmpFQVZrcDJLY09vNjNFMlpw?=
 =?utf-8?B?VGoyVSt0dHBqNXAyRExCQmlYSzI4NVNYRitJSUltZ0h4VDBsTnpmVFVsYU9r?=
 =?utf-8?B?bzV4RzFUekVvcXVTNnN2RHBWUUEyMXZCdVZZYkxkaXU5cWVOWVdKNlBiOCtE?=
 =?utf-8?B?Uk4xbFYrdlRhdk1wZ2cxT1BVVkJERTFVUXYzZU9HTXlXOE5vUFJ3VFlpRjlQ?=
 =?utf-8?B?d0VJSlB3OXc0M3gyZmp6K0VMTHNzbC8wckZENjNmd29nemhRUlo5YjFrMWFr?=
 =?utf-8?Q?CF9Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5e756e-4451-4b7c-25f0-08ddfb9929dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:35:41.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yCmDwfpcwZeonUXGLFjHelTwerQLvZBnUv2obtmMLR5rYO8/+mzGkECppcrm4C5SATWNGkazfS2kqikuRcnUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276

On Wed, Sep 24, 2025 at 11:39:56PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 15, 2025 at 06:22:45PM -0400, Frank Li wrote:
> > Add pci_epf_set_inbound_space() to allow setting any physical address as
> > inbound memory space, such as an MSI message base address.
> >
> > Since PCI BAR size must be a power of two, the input MMIO range
> > [inbound_addr, inbound_addr + size) is mapped by finding n such that
> > [base, base + 2^n) covers the range.
>
> > The base address is also required
> > to be aligned to 2^n.
> >
>
> Where does this alignment restriction gets checked?

Needn't check here because set physical address to
ALIGN_DOWN(inbound_addr, aligned_size) in this function, which must be
aligned.

memory allocate return pointer also align to size. So check is not
necessary.

Frank

>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v2
> > - add new API pci_epf_set_inbound_space()
> > - fix bits 8 * size_of(dma_addr_t);
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 86 +++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-epf.h             |  6 +++
> >  2 files changed, 92 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 4281067d4a62da6fbf6c2fb807b0f1b5afd1f45b..cd10e8619d03c7e2ffe48e437b0aecf0e8a499f4 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -344,6 +344,92 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> >
> > +/**
> > + * pci_epf_set_inbound_space() - set MMIO for the PCI EPF register space
>
> This is just assigning the memory for @bar in epf_bar. So, how about,
> pci_epf_assign_bar_space()?
>
> 'Assign PCI EPF BAR space'
>
> > + * @epf: the EPF device to whom allocate the memory
> > + * @size: the size of the memory that has to be allocated
>
> s/allocated/assigned since this API is not allocating the space.
>
> > + * @bar: the BAR number corresponding to the allocated register space
> > + * @epc_features: the features provided by the EPC specific to this EPF
> > + * @type: Identifies if the allocation is for primary EPC or secondary EPC
> > + * @inbound_addr: Any physical address space such as MSI message address that
>
> s/inbound_addr/bar_addr
>
> "Address to be assigned for the @bar"
>
> > + *		work as inbound address space. from_memory need be false.
> > + *
> > + * Invoke to allocate memory for the PCI EPF register space.
>
> s/allocate/assign
>
> > + * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
> > + * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
> > + */
> > +int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
> > +			      enum pci_barno bar,
> > +			      const struct pci_epc_features *epc_features,
> > +			      enum pci_epc_interface_type type,
> > +			      dma_addr_t inbound_addr)
> > +{
> > +	size_t aligned_size, align = epc_features->align;
> > +	struct pci_epf_bar *epf_bar;
> > +	struct pci_epc *epc;
> > +	dma_addr_t up;
> > +	int pos;
> > +
> > +	if (!size)
> > +		return -EINVAL;
> > +
> > +	up = inbound_addr + size - 1;
>
> s/up/limit?
>
> > +
> > +	/*
> > +	 *  Bits:		15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
> > +	 *  Inbound_addr:	U  U  U  U  U  U  0 X X X X X X X X X
> > +	 *  Up:			U  U  U  U  U  U  1 X X X X X X X X X
> > +	 *
> > +	 *  U means address bits have not change in Range [Inbound_Addr, Up]
> > +	 *  X means bit 0 or 1.
> > +	 *
> > +	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
> > +	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
> > +	 *  [Inbound_Addr, Up] range.
> > +	 */
> > +	for (pos = 8 * sizeof(dma_addr_t) - 1; pos > 0; pos--)
> > +		if ((up ^ inbound_addr) & BIT_ULL(pos))
> > +			break;
> > +
> > +	if (pos == 8 * sizeof(dma_addr_t) - 1)
> > +		return -EINVAL;
> > +
> > +	size = pci_epf_get_bar_required_size(epf, BIT_ULL(pos + 1), bar,
> > +					     epc_features, type);
> > +
> > +	if (size == 0)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Allocate enough memory to accommodate the iATU alignment
>
> s/iATU/EPC
>
> > +	 * requirement.  In most cases, this will be the same as .size but
> > +	 * it might be different if, for example, the fixed size of a BAR
> > +	 * is smaller than align.
> > +	 */
> > +	aligned_size = align ? ALIGN(size, align) : size;
>
> This should be handled inside the above API.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

