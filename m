Return-Path: <linux-pci+bounces-15546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93C9B4F7D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3DD1F22D98
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290171DC1BD;
	Tue, 29 Oct 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="izJQ6Xrv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1C1DB37A;
	Tue, 29 Oct 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219828; cv=fail; b=lckTTgRj3cvQNfqIM72G8mKYtXxuYg5FkV/tQYyLYBdMYK0v59Z6bky2OYcWRLGhtD0LIqDUL0QCdWn9jgQCo/UunClKkpocyymJf/9HfyH+34QHndHAtRrdZVULPCt/fSxZ1CsuiZk3gIVIB5Z5UG7oxFLudV1K0CzbGJS/+yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219828; c=relaxed/simple;
	bh=IMipsZtRh42ozcH33850bFCfms+HZHuAJ8oMSR3hzdU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jtRI0h9hZaq+aMTOPZ83bdW7k/8Bk12DbiwVc702IzK4dZGZOA34eFY7HwhkGS1qFf1IC4zmfJYPwjWo7mK8ydOi8Kl0t1gz5Zc7fmvqrwrPxpmvfl5JFr2dD1Ge3M/h3WsWy210cAjKDVFjmtJ4Qk8Sx2hCyo8shew2engZPnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=izJQ6Xrv; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuO9ePFZdXOcBZUWHRZW8UF/5alueua+z9cSymhZcJD5gZZMS4k7TkgUh8MOMBMqsW0JWcQRai26MGt6iuFyeQcBzEj3eB7KR1imXlk15jOTj8bBIAqQ15uVyaDbzEgYQ2YnMFqT6D4OQzOKeQ4hkOS3kpXbtERYPpY60Zwf3N7aRQYXfRCKNsbtJwiH3CJ60j20EfTsmT0syShncc3ZwfgHnL0BPRfscCDrLR5wLOkP0ftvhcxT2ZMd51OW5NVVOvEFIYl818lWgwWLim8aFyky2xV+O/Qyl6OoCeqim9Ro0CkfGaZHUThrPFEKccsapkdT8ZlNpKmqLKZJIjgAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cE+RUByeBM+zxwx0nFzkXWP0WlZvWmSl98mTrUt0WM=;
 b=x90kMYg9a5eLLvo4xsxgD86xoEaGwOY2eEkkBFCKai51G9ytCi/lVcwnLJzT5WPey0rZ0tuDB/zj5gHJ9FhPCMsGAI4J7LAfDIwLNYvHZmCx7wsnmQWxYs4QxWMyldsB5/iViFc6H/S4v6/MfMVjO5kEOmXB29qjZMeWubCehjUIdx0sZtARTh24SdRb5YsyIP2p0XV4Exc1uf9NpdVZ+hYnVBuIEUdCGBrkqGN9PLZ/fPTS5eAzLn7CcwanUjJGHNJPTQZCZstQCtVWmSIm+6DM6ydBUr+h+GEmrIaTW2YXnfJB7EqCoEH1V8w8j8IMfC3Zd2nqmhLVpm4uG8Da4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cE+RUByeBM+zxwx0nFzkXWP0WlZvWmSl98mTrUt0WM=;
 b=izJQ6Xrvjfz2ZMujKMRe8bpAWHStD4V7yYH0VrVUa9dygYifTEFQF1ILT9cU5DCAeRK0NYtrwS1QSNtzmaEGeuLsWoK/STjxQEAfxH+rDIKZxW1dFFgQAgzOCTeAT0S2FgjtTAQcizCPrcFz+Iq8f2qoe0qeUlZ69dg3ewo1BRAJkigMkvUYvQSsKfgipm+n8dPSRNwWKEApkURdWOfea/pMJQf3/7QPkWCfJERL10NKnB49CjjvvXm8UQrOEzok3uQRMpcc99Kw8q8QnxFgXhnGJOZx1YVgGjFIJ+PeesabAyzVr53EAJPb3M1vmVs8soDYbhpvaM3JQ9EezUWcNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:37:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:37:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:36 -0400
Subject: [PATCH v7 3/7] PCI: dwc: ep: Add bus_addr_base for outbound window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241029-pci_fixup_addr-v7-3-8310dc24fb7c@nxp.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=5662;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IMipsZtRh42ozcH33850bFCfms+HZHuAJ8oMSR3hzdU=;
 b=FKTkpRxObUzPe+YEiqYW8Y9/yElh1Af5kmudHZK9r0Fshr9nflpupBLircq1RQSrr4tcidQ2u
 r2NuBCH7+QpBgYu3eaURUZKm7goAuMUfwdU0J3DonLt4ygIWmAcGoqz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca8fada-dbc2-4b4c-6b67-08dcf837ea8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q21Db1E5SHQvOHljRzhiMVlwWGlkYmhqUzJLbVZQSnpITFpyd1MzeXcyMWRL?=
 =?utf-8?B?YmMyYVNqRzR5aUNFdlF3QTdBMHE5emw5UCtSclhmS2RxdWdsSmoyMzgvdzJa?=
 =?utf-8?B?ZXZvbWhQRWc2aTJVZlppYXc2V29wc1pxR3R0eGxGNWI5R3hrb09DcHFOK05q?=
 =?utf-8?B?dExpMjRHeW8rNmVYaVluMDU5YWt5dFc3QXNGNFZOZE13cmVzRUhpdXh3SFU4?=
 =?utf-8?B?QVE3RnowN0tpMys3c1o3R2M2YU9aVm5HYWVlZUk0RUk1Ulo0MkIyOUI2WXFn?=
 =?utf-8?B?bUJBTE8wVjRQR3VHMjJkZXl3aithbXVDVkJKZDlTb1U5dkhEQkJtOGNqU0Ey?=
 =?utf-8?B?NC8wdDdjdXh4SXBLWEhUaGRxVVNna2NtNUQ4dTFWbWRidmVWUFpES2pMWDYx?=
 =?utf-8?B?SHBraHFMNmpxOGhoL0kxN0NlRzFWQStPeFNoRVlpVlgwRCtIcnJiMEU3UGp1?=
 =?utf-8?B?WmcyQlVnWjBRaVlnUTRHdHpjMmlucXNLRVh5OFBmZ21LaWNFcXFnaDRqT0Vu?=
 =?utf-8?B?UmMySDAvWXRoeGllSC8waE5CeHpmM0pzbFF4TDA3dm9PMGlZVFY3d2pMMzRL?=
 =?utf-8?B?R2lFWnUzYVQ2Vmt5K2dzaTNTR29ZZWluS2tRaW15a1B3R1FhUFRRU2FpWVZo?=
 =?utf-8?B?ZW55OGp3d3Zaczg4SUtYOWdwOFU4YlFHR2Vwbm5xZXhIVmdXS3c3RmZhZzhu?=
 =?utf-8?B?TG9zbytmRW1iOVpreHpBRFE0eENxSCs5ZG1ES1Y0QTN0UnlxMGZqMW1wSndk?=
 =?utf-8?B?Z1N1U25LS3RkQWVNY1RYcWFPczVQdEd4a3YwK0cyQ2FQczVjdVBLQW0vYTUx?=
 =?utf-8?B?ay9scHMyRUJ0WVNiL0gzSW1JZjBzUkN4bldrVFp2VkpyVUdUUHRuM2MzT0FU?=
 =?utf-8?B?cEdZS2VodlFtc0JDeTUrSHBicHQ3OUlRTUtKd1RRL0pZYUpFV09OVzNYTGI4?=
 =?utf-8?B?Wm0yM1VxNXZOZ0hBRnp1VWJseFc0Vk1aQ0IrcE5YMFkxRnRaaU10dFo2WXhM?=
 =?utf-8?B?L3A5ZDhJdVVwSi9kV29la0RybUJ6Q2cxZ3FyOTc1akVXUkpSK1RhWXB4UXAz?=
 =?utf-8?B?MERNZUZKTjRmaUxQbzQybGdxTTh3eFJ6bFp0Um1USk1lWFdyVG83QVR1Wmc0?=
 =?utf-8?B?OHZXcEFUam1FL3gzR04vOFpUeGVqTnE2RzlJcHpONEtMSUNXOXl0MVJmampq?=
 =?utf-8?B?K0pNMUs4ZTF0MGFmTmF6Mmg0ZFd5a0lVNnM3aXVqM1RGeW5RWUdyT0NoK3Jx?=
 =?utf-8?B?aEZ3NVA3a3gyTjF5TWxXYWN4U1Z6alBwV0oraE9uNVJjaGNWWnNCZW8yZFhS?=
 =?utf-8?B?NEd5dnAvc3hiZndySU5SSmpOTVFYMFBwVFJFcU85UmZoalFyY2UrMGJPV05K?=
 =?utf-8?B?NVptMDZVeSs0Sk5pL0prL1NMRVZVcHZZVlBEVWpkamx5VXJZejlhSnp1UjhP?=
 =?utf-8?B?b29Wc09oT0VVOGJ2MjBQSGM0SjAydTFPZUZTWVduQUlxQ1VHSWdOY2V5Zkt1?=
 =?utf-8?B?UUVkaW1kTVBrNTZRNnN0T0pFMy9pTEtrWWJjUjltU29ldjZLaFFXeTQyTVdi?=
 =?utf-8?B?Y09RZ1NCNWRjM0JMVFp4NzhucWZEMGVpU2NWQzNPNUxXRkQ1Y1RGOUQ5eS9R?=
 =?utf-8?B?VGxRaU9TQ3BXZC9iZjZJRHJlQzBtUkFsNHNrcERxYmNpL2E4T1dYaDVwWUF4?=
 =?utf-8?B?UHF2QXRGemhKU1JDZ3Q5SU9hUXhOeU5kWjNKQXBjT0NHRC9yUzhURlJSYVBT?=
 =?utf-8?B?V3g4dVkyQmVwMXJoelJKZC9lQWNNd3BEUVp0d0dkSVlBUTE2YUJ1cE52ZjJX?=
 =?utf-8?B?RU05WjFWbUk2UXZBWnZYVm5POVN5L1BmK3lvM1Z0RURMckhIT0lISmQzVGJ1?=
 =?utf-8?B?dkNGTDBsSmVTT00ydW9ZVFJLbkUvSGJvN3dRMnlYZi9ET1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVU1eWRMTHo4MGpmTEE1WkNNdmhnRCtEMTdrejV0Y0xRUmVFWUw2MU52YVFG?=
 =?utf-8?B?cldQcXc0czJsNi95ck5TbmZQdC9XWEJ5c0xFaDVhMFBFcGZyM1FlVnBqa1Yw?=
 =?utf-8?B?TnU0NlA2aDFodkVwYkNvVytLS2hPaDg0ZWQ0aUFGaDE1MCtRWDFNRFUvbUIx?=
 =?utf-8?B?VmxVY1l3VHMzQTBPYmM4Y0hSMXJoaFBtdkhyQi9xbEJkSjBNVkVVTTJScHBJ?=
 =?utf-8?B?R3c2YVpmTGIvS20wMlIwRjlqT1lkS01qVW54V0R0bm53eHM1TjlJUE40dkZo?=
 =?utf-8?B?UUViVEF6aU1TK0ZXNml0NG0zTWlvQlJSMnowMmxCcjZZUDc3aWdscU5QdnFn?=
 =?utf-8?B?d3E0VWQ4bk0xSjdHYzd6ZFRaSWgxOWlLb014V09vYUdPcEl0ektxZW55enFL?=
 =?utf-8?B?cDdveTdMVjE2VWhqT29XNit5ajFSdWdIK2k5R1hQVzJmSllML3lnVlVuT2Rm?=
 =?utf-8?B?VGRRaU5hd2hBNFV1ZkRKNmRFRGxybm5mK1BSRmZHNGpVSXBLNWUrOUxGTnhV?=
 =?utf-8?B?djJ0YmF6eUVrZDV4Tll5WTNWZkV6ZDlDcE02WkhRTTI0Q0Q2ZzdiQmxQcTVn?=
 =?utf-8?B?KzB6VzIrU2xGNDNNQzlsWmRRK2R0MkFaUXJ4RTE2TzdHS21wcGVPRVNJdnNr?=
 =?utf-8?B?akJZY0tJekpEYXNLOWVQaUhLWDJhVDBOUE55N2ZVWHpiczhhQmRZbSs3VnZi?=
 =?utf-8?B?Ym5KRTBmbjlZZXJ0RnY1NWZ3WFpRdmFWaXJTNThLUXlxL2RiZzdMT1V3eDlH?=
 =?utf-8?B?Y2twQmhpa0ZDc3dDbW92SzEyZ01sdjN2OHZYVm9UcnBQL0FONVBLeHlBYTJ0?=
 =?utf-8?B?cktza29pQmppQzBuVVVjbStYWWUrd0hEYklBRHdrZ1Q4ejZVYkNBL2djc1Bm?=
 =?utf-8?B?MjFYQ0ExRVFtNUNxZHYvM21QZm5RSUZ1Q3FSeVhOTnFOZWNNQ3Q4eU5sR2JP?=
 =?utf-8?B?ZUU3SEpVOEZkK3BYY0FYTUxvcUVmaXdLbEFHSTc4N2gxTndOeFhaSWFkU2h6?=
 =?utf-8?B?cTJZVk5DWlhQbFE4ckpEVXhsTXJ4QmNUakl1WkNDMFhLSkdML3I4dWFhNHVW?=
 =?utf-8?B?dStac0tHWGN6MmthYk91a0NXYk1Vb1BKNlJiK29ycytxMHZ4c25XWWpYNzNi?=
 =?utf-8?B?L3dSOFFEb2NZVUNMZWszTER0dmNySUpJTW40SVFxVVEwSytJUzl3SDNkdXZo?=
 =?utf-8?B?L2tJOG5tcnVIV0JPZUFBbkgxVlF2OUxDbi8vZXhzb0NOWDU0d1JJVVQvT2Jv?=
 =?utf-8?B?bEpxOWxWV2pRMGVEd2haeURqU29sOGZmSjJjSjI3RVBhVXQ2disyQmVmSVVI?=
 =?utf-8?B?OVhLR2lBWllkTGhneWlnaWlGVFYzdnNwZFkxYnQ4dWJIbHZ6NkpycHRCSWxK?=
 =?utf-8?B?NzI3bFVXTDBDYyszUXRET0sxdXlMR2IzcENjRlZXMk1VT1g0VllhdlBxNndm?=
 =?utf-8?B?Q3pIV2l5Mnl6NjA5TEZlYUpIVW56aElRNVFKSnVXUFk1RTZselB4Z2k3MHEw?=
 =?utf-8?B?enprVG05dUV6YUdrZE50UnQxeFNRcFRiQjBCK2tndS9ZSFliVUwyMVA5S3BW?=
 =?utf-8?B?SzhoQUdXajB4LzQxRXlkUU9LS1ovRDNIdWZZTjRVTnFYbjY1d2NlbzhIS3Fo?=
 =?utf-8?B?bjFNTkYwS0Y0NUZadFBncDBjMEN0c2ZkVjlCQTFuN0ZZYW0yK0JLTEM2T3RL?=
 =?utf-8?B?WUJrUHNHL2ZzU295dGtxWG91Y05xN1dRZkZZTEVVdHRaQ3FZRENCNExETm9H?=
 =?utf-8?B?eHJveHQ2eTJ1b0dSL0xlc2FobitIWkFjK05DZS9kTmI2UVpEbnU2Z1NpWmFa?=
 =?utf-8?B?OU1yT1gzREJVOVpaWGQvM3grZW1rZU56Y2IwZEZNdDZFS0cyZkJuOGtsWTFj?=
 =?utf-8?B?a2c1MktlSnBrNTNYUU9yUkRYd2wvakZRdmExZ093alNlMDEwd1ZpWUIrYW0r?=
 =?utf-8?B?dnc3Vy9LNEtHUmFMV3BMRGpYQndURDlwMTdpWEVkenBnNkt1Wkd1OUtaWVFq?=
 =?utf-8?B?QjFXSHBXRG9NSU1nRnJveVphOUJPalo2Vk9MMGFFVi96OElZWlBPTFRBczNY?=
 =?utf-8?B?UEYvcFJDNkpIb0IyV2dOaFhiNkg4QjlscjJyTkFHY3ZuUmdoM3phRVZrU3kw?=
 =?utf-8?Q?dYgogIHN/LHCcEbDznKWACUyU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca8fada-dbc2-4b4c-6b67-08dcf837ea8f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:37:02.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CCCn7cz3AH38vpgZaeSpChUNkWhNGyT7ELq9B4XKzuJBhXLJoO05Ga0OCNF3TxInF/onuRYwINr/lWqnyA9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

Add 'bus_addr_base' to configure the outbound window address for CPU write.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use bus address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x80000000 0x10000000>;
		reg-names ="addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to bus address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Add 'using_dtbus_info' to indicate device tree reflect correctly bus
address translation in case break compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v7
- none

Change from v5 to v6
- update diagram
- Add comments for of_property_read_reg()
- Remove unrelated 0x5f00_0000 in commit message

Change from v3 to v4
- change bus_addr_base to u64 to fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 21 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..a5b40c32aadf5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -873,6 +875,23 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->bus_addr_base = ep->phys_base;
+
+	if (pci->using_dtbus_info) {
+		index = of_property_match_string(np, "reg-names", "addr_space");
+		if (index < 0)
+			return -EINVAL;
+
+		/*
+		 * Retrieve the local bus address information, which is sent to
+		 * the PCIe Endpoint (EP) controller. If the parent bus
+		 * 'ranges' in the device tree provide the correct address
+		 * conversion information, set 'using_dtbus_info' to true. This
+		 * allows 'cpu_addr_fixup()' to be eliminated.
+		 */
+		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
+	}
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8067393ad35a..f10b533b04f77 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -410,6 +410,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	u64			bus_addr_base;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];

-- 
2.34.1


