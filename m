Return-Path: <linux-pci+bounces-22893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB46A4EAEB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F786160CB0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8A283CB4;
	Tue,  4 Mar 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bFjeXcHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93696203718;
	Tue,  4 Mar 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110607; cv=fail; b=uelYhW7/Z3JXA4+Ge0LzazAufW915u1L1cCgW7WphH9byRizFDBQld9lfIaQfI7ZNh2Pi0TiBZhz7+F8HcBExpOVJdyWt/tjWAH1qIhx5tj3ygTSCEF+ba+nWvxpMuGi6pJ7ePEexbpCPLjXAyp+tVW1mjrC/rDXFEzT34d8FCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110607; c=relaxed/simple;
	bh=Q0PA7KpngVz9cQ4OYEw0jqkYg6BS9VumbAyz300JzVE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RNKUuBkq4c0U5g5/vXQzY9Ef2r3wBNorAu5OitR1f/mst/IgwNz12LjjpuktNcxGyu+lC0SY5TY1kezbPoqXJ7pEk0PdmJHeu95iCHfLdGEd5ctatbJz+sGJ1n+alkpV3tsP3scFqXVQKDAxfzASk2hn/bLokgrVJ7C4NTO2eoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bFjeXcHO; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaXf2wzv1KJNMTgqH+Iy+qy/Us9JT3TsZN6t8ksLfJcJpiNtNKXDKr9phAqNg6yIfnj/M3iIMpSXVcaMiukYMmoVbWTgf4jqgb4WAe9YDDxEvdasocDPJi7704VAUVrPPqL0uTb7xI85GdSDduWgnb6Z3F/QyAD96Ci6djO5GlLGwpz5ps+qL20/TCs8q+136UmiihOgd/Ze4nCH4R+qUri21GXzi5ESavEwqC5cwc6E4GZ1bfHgAMv4K/KKOs4ofUw7TPsSPzlWuk+Tsls9tbvn7Z4QIdiDZwuMHSNRnJxtPd1+fQaaSeVT9ryhUoy+fk5/PTqoj++wnIDbcpODqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsK+v1j5WElGMphUwWPmhuQLs7ahqe2Pd3S5t3E3am0=;
 b=nI4SywNmGvctn3M1jYfhR2W3gQ2QqNsIjsAlSncr2NDOZvn6GmlP6i2LKIFgRIBFVT1SQDUKBa9zuiePSHceZ84KHrSx1Jw0Oj22LqVn4thpLhjcb1VYFcvK8W9szHoEucC5CX9yG7FbHRqK8WaD35MTAGHEqoQE7ml5lKPbwEEe3N609z13bc4xMhjRcPTpCoYiMmCe9BKNyZk+3SGKBedJE6M3Lda7pz0I4DqL5mZ+EjTvr8fhu02APvFzH0GEPrwb17ijdRKjRj3TMWgEu1u1ftRL1RIjQNpkBrdUwgubX5fSzHRFGpqC60ZJkq+g1xDWMeOEVbYYk9gAnrgOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsK+v1j5WElGMphUwWPmhuQLs7ahqe2Pd3S5t3E3am0=;
 b=bFjeXcHOWB24N8nLdRZ1ZDS5O39zsIxdG3wJi8FqjNdzpHonOb0/ijO2NeAvz4fmTKiBEovWblTbFOul4xxymLv1sj2Qke7+qZuY/w8kepfg2b0XoQrYFlMPJ7aTP8i0D7FaLdO1MB/R9Q5E3cgz1d+1zCWdPKYXFVhLNmc4vzAdlFpH1BWVEj7ovMJpG8wxNWo04aaGGbS7I0GckjYF2jCzEV5sGHnQDMEVDgyZGhvwWz2+RxJZ99AglPnLM2NE1SWDsE6n0+L/ZwMV5q+bQqXLkjlGKEuGCZPB8Jp7+UQpzfCK+JUUhFyFJWfiVdUuqk1RjY5LekwFiAJ8vKI6oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10504.eurprd04.prod.outlook.com (2603:10a6:102:444::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 17:50:03 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:50:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Mar 2025 12:49:36 -0500
Subject: [PATCH RFC NOT TESTED 2/2] PCI: artpec6: Use use_parent_dt_ranges
 and clean up artpec6_pcie_cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-axis-v1-2-ed475ab3a3ed@nxp.com>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
In-Reply-To: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741110592; l=1946;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Q0PA7KpngVz9cQ4OYEw0jqkYg6BS9VumbAyz300JzVE=;
 b=9IKSF9jEzuU1pUNsGv1UZAUXg0YzlMGsUsHlFi5QQC44H1VIRicda4Ty/Xol+Jw///0utFVag
 feKJ3jaI9FkDIx9v6WFUvU82zkkeEovBFSI22rSznkiowZqmLpA+1dl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10504:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d600c8a-7766-4215-09c3-08dd5b44fdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFNvUTNpNTVwOEJKbkp1TTlrcmwzeDF5Vm1KM0xXQklkamsyejBWUi9BK0Fp?=
 =?utf-8?B?STNHZ2FhdjVwNHdJMWVpdW5uMkpHOVg2a3M0Sm1keDViM0tsWk1aOVE2Q3V5?=
 =?utf-8?B?bSttSkNJR3MyQlF1UGtPNHNVVlNJMkQ5NThrSGwwK3hhOG42R3Z6ZWZKK1Rv?=
 =?utf-8?B?Uk1yclZpSVl5WHJoUFNnU3U2bk9IZ3NKQWp6WGhCQmJwWjNlRS93eXNMdXRW?=
 =?utf-8?B?YStjNkxEemFIanUvN2VORGpJdWNKZTBaOE5yeEhxTlNFa1VwRDRUVEV0OUNn?=
 =?utf-8?B?WWRyUGtCZ0FEbm8rZFE2SjNucDFDZTFqMGZIa3JQNTZtM2lHeElYYlJyTUhw?=
 =?utf-8?B?bCtEb0NhWEs4QlBCbEtkZ1VZN0ppWDZnamkvRldjR2cyemFZcUFMQ3V3RENJ?=
 =?utf-8?B?RGo1SVhpQW41NmpLL0hSUzRtcmxueHFZNEI5bCtFYkxZM0JBTmg3RGY1N0lW?=
 =?utf-8?B?U3FsK3k0TnkzOFdCQU5aOWJka2NIQzFkY1JHWkFXT0RqY3JEaXNEWmJIS29t?=
 =?utf-8?B?dTA0MktGZDRLUHNQcCtBZ2w2UC9PTHA1TC9ZWk1nR2ltaGU0MlpDN2RIYm8x?=
 =?utf-8?B?SXBKWDRLSUQvc3luWXRGZ0J1QXhuV0FteTZPcDRrTnRJRHRtZnVqTzdJTFMv?=
 =?utf-8?B?cUQ1eTJ3NDBoZUhLRDBSSHBvcnFhQUV5YlVPMlN2OEYveStOSm93Z09zRTVw?=
 =?utf-8?B?NE84c2xFWEdBK1M5Q3o3Qk0vMWNYcVdscndCK2xWQmNCWnBXTWZPQStPNkdX?=
 =?utf-8?B?V2hxOHFrN2pJeFNHYkFIMm9ySFA4WGdNMEE4TU9GQ3pyVlQxOHY1TUFiY1JN?=
 =?utf-8?B?K2drajRmZ00xd05wTm1XR1VoUmlKcHRzeVR2TlZXK1BkME1PSTU3dlhhYUIr?=
 =?utf-8?B?cmJ2ejlmdFdCQ3RxdUt3R3c4bHh5SWpEZzM3N3BJaVJGajFTaVRVWUxrdW1y?=
 =?utf-8?B?TzJUdXFUVkkxZ0QveDhDa2VQSkJIVVlSMFprTEdCeVlDTmtidjNYbjFhR1l0?=
 =?utf-8?B?Q3JWR3dHdnRuVUZLUk9FWUpDY3BETldTRVlXWWY0Rld2VlVUWGFsY3R4UnpP?=
 =?utf-8?B?aDArZkJrdUpkc3JtSWFkOTJta2E3Q080SkhxeDJjRk4ydVVFUUVPdEN2dDZi?=
 =?utf-8?B?RHVLdEIzekJMZG1uUzM5ZDhXZ0NRb3BpUno2ZkxkWFR1SjY4VHZsZGVoc1Mx?=
 =?utf-8?B?bm9DN0JQaW5KQlV0MlVwUHJ5N1BrMmx2d2REYStWU0pleWtteWVFZnplYmx1?=
 =?utf-8?B?MGMrRzdBZFhVZVFvKzFXbXBYRzU1UUNQaFlXK292UTlWcFgyMVZuWFRhV0Nm?=
 =?utf-8?B?SmM3bFVzYnA2SlhjTlpiMTFGNEtsTjBMZXpmSDJLbkpWTHhXTE14UnRISzlP?=
 =?utf-8?B?NGtKQndaSW9OS1Zxak93UjdPZm1HTzdEZGh4cWtuWkZ4MEFJbm5jeXFEcUZH?=
 =?utf-8?B?VzNWWWNjOFJEYlRGQnBoTUs1U1k4eXM2bGNJM1E2M0oxaTQ0a1M2N3dvSkhP?=
 =?utf-8?B?SVdmSmh4bzJTcXcwK1dVNlBPWXNTVFdpWk5uT1lJQ3ZCdXlSRXVaWWdXOFZI?=
 =?utf-8?B?Z2Y0cUxLM2NrRXNLelpLNEt0Lyt2elFubGZiRkQ2bGYxS0poaVFqYnZHS0VW?=
 =?utf-8?B?YVJnODJkUGFpaExMTjJnMEVMY1kzM3oyVDlLaU9vZEhjQnJNZy9Ta1g0M1Iz?=
 =?utf-8?B?NEJQZlI0TFZrZVRkS2NGMTZyTkxzSGRxQzMvOUFIaUl0NnBvd2VDb09jcEc0?=
 =?utf-8?B?bW9LVUNiWml1UXBKR3dCRHpxK0NnRnJQV1pWeFNCZ01jUjlQZEl4Mjd5UG5J?=
 =?utf-8?B?SkhVMExXUE1YODBpc1doWHdYN1BuZGRhOU9YY01yekl5aTFyVndsZXNWUHJs?=
 =?utf-8?B?UHlrOVFyR2QvN1NEdXlyQWl6b1V2MlZORU5XOE5KdFNRTG5yM3RTNHlWYzFt?=
 =?utf-8?Q?lblPRaBk4+fmxzoT5Nw2VgsAI0MBrmBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFVkZk5Cc0tmcGJWQ0l5T29vbUpvTGQyZVdUMHJIYnZwNkFVYkZKc2RPOHls?=
 =?utf-8?B?akdVdmZzSjJNWFFTWVY4dUtRKzBEeVFEUWdBMWNaSE5RM1hrUHNITTdQM1E5?=
 =?utf-8?B?N3VXeC9DejlyMWN5Nk50OEE1dHZvN2NuQjc3bXJLYzVXVVlGOFpyblROeXNz?=
 =?utf-8?B?cWk5ZHpOOU1TaVlBRDJ2b0VvSWxEa21NNnUwUjRoZzJvMVVudFBpVzJKOUxU?=
 =?utf-8?B?Ujl2bG9MVmdJMGx6Q2VXNFlPWHdFODNXdnJwcWVWN0V1WGtJRDRqRFB5NHdz?=
 =?utf-8?B?N2tXdFdKbHJFTG41bzU2aXByMFVwVHNURE5lRS9kaFowTzI5dFdKWnliYjM0?=
 =?utf-8?B?M3FWWmJmMFpCMzRGTXNWRFZDSDRpTm95bkxYTjBtL1RaUkZGbzlYWlUyd0dE?=
 =?utf-8?B?YVFyOFMwdi82bFVKWVhKd2E2eHhXVm4vaGc5NGFvTDJ2emJEVGNJZW1LcW81?=
 =?utf-8?B?am1NTGZpLzJtV2ZnR3V6c0gyMzFUVHhpOXZXWlBhU051TXA1dVRJZjhjaEZO?=
 =?utf-8?B?TFkya0FDN0NBdmFRaU1JN2xxclByaWZZeHRPS1Z1VW91SnYwbnZ5Z3p4YWdi?=
 =?utf-8?B?T3ovM2xHamJjTWs2aWZVb1F2R1Z0SWRpSmVRSlVmQkxLOExEUVRqMzV0TjdU?=
 =?utf-8?B?UVBUMmdlN0Fzb0lCeW1VQ3V1TkdJVmExMXQyN2libnVaYXNVelBQZTFVZmw1?=
 =?utf-8?B?aC9MZjI1dmN0YWJMQ1VRbXF3WkpxOWoxSHlKTS9pL1NTTUZkbjQ5dTVNbTM4?=
 =?utf-8?B?TUM4ZEg4NWxtamtXb2pCZUIyaW5BQ3RQY1BCSlh2K0RVZFZMblRDSXlRTmZM?=
 =?utf-8?B?UVJURVFVb0FPOUV4ZHBIS0JhLzFSeUtJK1ZaYzdjS2tEc0FDVzlQWEpvKy9V?=
 =?utf-8?B?eDdtb3dwaEYxeXVPd0Nna1J5eHJCS3lQaFQ4UU9td29rNDJWNGllWmQvWW9y?=
 =?utf-8?B?N29Cc21BZHlCaGJvckQ0ejJqTFNocXNpMnI1dkcvVnUyclJqRnNLc21lWTQ4?=
 =?utf-8?B?MUc3cWRaTnVaVGdsczRLMmVVeXFRbmdQTUZhbHQxS2VabUNjaDQ4NUJBZEVQ?=
 =?utf-8?B?UG9Jc3dHWHFpSzFQV043TGtrVThCTVZFNnFPbnAzd1U5MFBaUXBsY3BlYkF0?=
 =?utf-8?B?ZDBjRWNNWXZPdDVIY3l3RVZiYWZ3QU5XOFFTdnpXeVpoVnd0NkFwZlEwS1RB?=
 =?utf-8?B?TnpRN0ZDdlpJWk5oYzdFTGViY0FHcmRZNG9CZ0hvWm5pK3lveDdSZ213ZDBs?=
 =?utf-8?B?QzA4OHNrR1YxbUpUSkFRZFc1aDJnbkxKSkcwbFBXWldjb25VWFUxenBvYWhF?=
 =?utf-8?B?UXJFYmNrREJZZmdPNlAxbWw4Mjd0M2pwRkNYZFVDaDFhUy9zZjU1NkRHd3Bx?=
 =?utf-8?B?d1VSZjVrcDVPZWxkSG0wc1hxaytqa3lFVlB3eFg5SGJ6a2Fvc2Rjdnh5d3hT?=
 =?utf-8?B?ZWp2c2Jzalp1UDB5WVphYVdaWHkyNHdLNWo1MGRqbk8rbEc3SWVvOG1SWjBt?=
 =?utf-8?B?U0o4Z3YrZkpOQVlENVNNNHpuRXgzbm8xcVRGbWRlVFUyRFJTMXNsa1M5Z2dK?=
 =?utf-8?B?RTIzSTM1RGVja2VPUmkrZ1NZdDJXTkdNMkprVVZqTExqallLNUxDWkVyWUl0?=
 =?utf-8?B?U21yYjM3TlJmaVM2UU4zS3NiZmFLYXZGeGtXeSsvOGhpcWNiUlUxMVhZTysv?=
 =?utf-8?B?TitoeUFDc1FSZDFJaTFCck0rMXluRDVjMmY5TWN0UHlUbXZKR1kvWW0xbUJu?=
 =?utf-8?B?UFhpbTJLTjlEZDc5NWJMd25EQmZHMDNOMTVLMVlmb1dlRjlYcTJEK3c0c3hy?=
 =?utf-8?B?YldmN25oMkFhc0p6T0JJcEIranJOOUNHZDdOOXd5VWo5ejNhekU1dnBRbGNV?=
 =?utf-8?B?b2xBU1RDWm8rMEN6anhMaWJZRGhDbGM4em5GVFllMnltU3pONjA3MTJZVVE4?=
 =?utf-8?B?dDY3ZGJYSUdQbmtHdnlJYU10aW5WT21WRmdtUVQrWUpvMzNLcmZXL3hSRjZK?=
 =?utf-8?B?K1Y4MmhLYlBOMWo0enVBTVRSVy9wbm45U1JqaE5jUFVEZjMvcG5HdWwxS3Bl?=
 =?utf-8?B?SVJOMUcrd1JXUWl6T3lMc2VsTWtkaHBZUWprOG0zZ0VYVDRESEJ6WFg2TTIz?=
 =?utf-8?Q?QiTiveBDE7T2VCeP8P5yPGzT3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d600c8a-7766-4215-09c3-08dd5b44fdc2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:50:03.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H67ALbhKBfZ7rUOr9rDreW6Ucl7nSWpFyW/iRQ59EuKNO2BsKAga7oc8SEYAi7eljSVZqXGeJ90FkFRPOpCCEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10504

Remove artpec6_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
address translation. Set use_parent_dt_ranges to allow the DWC core driver to
fetch address translation from the device tree.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 234c8cbcae3af..d2a628a0fdc17 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -94,23 +94,6 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 	regmap_write(artpec6_pcie->regmap, offset, val);
 }
 
-static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
-{
-	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
-	struct dw_pcie_rp *pp = &pci->pp;
-	struct dw_pcie_ep *ep = &pci->ep;
-
-	switch (artpec6_pcie->mode) {
-	case DW_PCIE_RC_TYPE:
-		return cpu_addr - pp->cfg0_base;
-	case DW_PCIE_EP_TYPE:
-		return cpu_addr - ep->phys_base;
-	default:
-		dev_err(pci->dev, "UNKNOWN device type\n");
-	}
-	return cpu_addr;
-}
-
 static int artpec6_pcie_establish_link(struct dw_pcie *pci)
 {
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
@@ -134,7 +117,6 @@ static void artpec6_pcie_stop_link(struct dw_pcie *pci)
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.cpu_addr_fixup = artpec6_pcie_cpu_addr_fixup,
 	.start_link = artpec6_pcie_establish_link,
 	.stop_link = artpec6_pcie_stop_link,
 };
@@ -433,6 +415,8 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, artpec6_pcie);
 
+	pci->use_parent_dt_ranges = true;
+
 	switch (artpec6_pcie->mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))

-- 
2.34.1


