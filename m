Return-Path: <linux-pci+bounces-36212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B4B58770
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D8202CAB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05CE2C1583;
	Mon, 15 Sep 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qj+zMSJh"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A52C11ED;
	Mon, 15 Sep 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975013; cv=fail; b=O0o2U5hw4KyUwjZOs+mwxjjw33Q/FGDiKX4miYq3VIboCTJNmCJdtYfLr0UJ6Lp+7qYnfvn4NxIejFug2fAfn+8/4tGGgY9om7Fz2cbuMyoOuamKKiXUrrLkBB4U6sjYI4moSEUBjKnoCiimdU8BxZjiAaFt4ElJFpF1lRzHj9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975013; c=relaxed/simple;
	bh=KDkV/uwTOS7GyOmf8JTmSHz0ClMab30crBAE13X1Eo0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FQSZvlNQY6usJRRRckcYFMHQ1OoU6QfcIb4oukJtPHgkzkcCSGok23+lI/5HqnCOOxezv/pxNt65pAaPLAO1MnegZGd9w4KVvCE6JODEw9pvADMoEmB90BCW/2HkGlltkPgppf4ZOMFJ/gxc5oSzYdiGWD7GfK6lKr6k7jNwE2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qj+zMSJh; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw0yuSzcNQhmGdukgpljUFJOeiKOnkvB4k7ocrMy8kaDQn3Tx6FCCMEc0euXVWchocwZMrsPXM/wBeNL5PhWXNMzkOlgGsFEDTAIZgfDTUpjill9mrYT6Gjd75zzEpv/GuwCBd38onHYLqJdotKAyOHG7R8rkpEw2EDJKnIcXLczs3kRKHK2JoizqB9+/mI/p3x00qMz/7bOgk3Jt86eK0dRghRK1NJiTk0GinGRfn6C5qWC/PvZOeTsh4FoIEdZQcJcrlsKafIq0QZnBe6XMCz60p/BiMYS276nerULYfdm4ij1JPIHl62LrhhdxPE6IExeQGmc12PuKoHFn6e+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF58AR6vlNcV5G8W7sW7MpPI+ua9dHQleS0mHOla6GQ=;
 b=GVKyZor5VAX3joncSl16q0H1ltPx+eCYuD1Tguem20Pq7i6lUBYuiUdiBOdrVk/LWdDTGKWMjm0hQFiUhJIUSLvrV5wfvfwL0DLZzwfgB3xhXtce4t8EeyxmRsmy4X5HdyTyCEQ2YV4ZzACuDZmmr7Se8s5pOFYleCq56jsuY7uGkt8JCO19eIKXk0+sd5mbfvNkuYfIfZ/O9qatuhxZyZqTF7e1h3EEs91itRIZeDYrHOmcL1fnJYyL5VBJ3Qou8y1zCEMtULXu+3W9T1nWgBDeeuDzgMH/Bdrl7qkeHk58mm9YxQvJGV33ohyEyborIaoDQclq58O9ypXDwjVf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF58AR6vlNcV5G8W7sW7MpPI+ua9dHQleS0mHOla6GQ=;
 b=Qj+zMSJhwQBXoaQQeEN7pU0uN30NHdXl68/KU205CL7m9evjSivypWdrB2z23DCaMVRqIrs6t45/uAn4N2UZFZrg6A5WMOEdbOCm5artr5j8QvGdw+mXBOX1C1I1f/k+vtjg+pp3f7VjfClbzlo+1zT22APAOYx03CgG1s6UcY8/F5F16HtZpRMSKMzUj3B6U9FZ7ku9LShujMHNmBqt089t3ynf6bn2VcLqqr3ej2ECH8e8JOcjAOdLQoAegT8UFUkCn6bVrrctjE0IP9/Y4W1+E/rGlmBHbhbB6L3kRZW3jjKmYAIK81GjioXrE0FaCG52rRPf0p3hlN62+CMaqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 22:23:26 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 22:23:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Sep 2025 18:22:46 -0400
Subject: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-vntb_msi_doorbell-v2-3-ca71605e3444@nxp.com>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
In-Reply-To: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757974988; l=7424;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KDkV/uwTOS7GyOmf8JTmSHz0ClMab30crBAE13X1Eo0=;
 b=0uKk5PswLw/TDxZd16myXX04rRH4/Lk1jypR7DJ6XlWo5TE/m9nlS+sBYCayktWg0mDXBvXaA
 wkTux3fk2xQB82lSrhoC2kt4kxSJNcMsivpP2RqtHMrlNKcGXQOT/C9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: a892d9ba-950d-4ee0-6591-08ddf4a67b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVJnelJuRUY4bkN2bFhvOWc1djh6SE9TR0lBemUwSFRvck1GS3BUWUVXd2di?=
 =?utf-8?B?NC9hUzBXK0QvV0VReHdHQWlGVHZjUFQvWWc2WXNTck9zV2NGcUNMbWRsSldr?=
 =?utf-8?B?VS9CMnVaUGpvTHliNlF4V2lLK3M2ejJjVXFHTkluUXQyc0oxQk9JUnVKLzlj?=
 =?utf-8?B?cmFRNkJ5QkJuU1d6VXRGNTVEazE2U21qN2lsVVYvaWlhaVNqckR0NmJySU1O?=
 =?utf-8?B?RnhOMzdzTjI2MVo0S0IvbXluaW1QbVZyS0c0Nmw4ZGNpRnR2MEZET2QxRmVB?=
 =?utf-8?B?ZWt2dEpucW8yU1l5bHJmT015aXd1M0hBMFVOcWRCS0NDd1ZGVThrNmQvM0ZT?=
 =?utf-8?B?eEk5eCtiOVRhWk9scytuRXppbDZXKzNmeFIwRHZRVlpqWExZVHByZWRnK2lX?=
 =?utf-8?B?ZzIrOE5mL0pQVE1aY1BaWEdyc1JCNXNHV2hnNDdsN1RrZlVrZFNoMEJpRnV3?=
 =?utf-8?B?VFl0dUdsN3FQWmhWVUNqcGZVZHdGdEFDbFZMNjhtQ09HazRtR3NleStvVmlr?=
 =?utf-8?B?am1sQkFiTkpVR3BzUkpIaUs1cnJhSHR4Zkp5Y1B3ckg2amthUDVId2kyb1Vi?=
 =?utf-8?B?aElQVmZrcGtWLzE1bzJIU2Y0YmFEWHFXSmFRNXplSWlwTXU5SUR4Y0tlNzZJ?=
 =?utf-8?B?c1d2dWQzR2tKZlVFNjN1ZWZwakluZWx2SUJ1blJYNW9lSWgvQisyRHdXNU55?=
 =?utf-8?B?azZDMnJaZDF3aDVETUpxa25MdERCZFpncVkwU0lqemVZa1JPeG8zVU1ZNmxL?=
 =?utf-8?B?bEY3TTREbzN2Tm5FRnBSeHJndlZ1Vmd5UTJIdkljbFVvSk9reWcyYVFWZkp6?=
 =?utf-8?B?NWdGcVg1eG9vdm5NNUlwTjgzdlYyUUZud1lRR1BCRVc0RlM2RGNrcGtsb3dQ?=
 =?utf-8?B?aHZickUzSzdSZWl6UDVlZEZYRFBlMkRoOUZLOWV6MEFmQ0hOL3lXSHNUZlpV?=
 =?utf-8?B?VXRZcFJLbmhwQnZuM2E0UVBTeDZYaEVGN012eC85TDFWMzVEMDUyaXloMmNk?=
 =?utf-8?B?M0UrcTJPR3RFbVBnL3NUeVlrdFdWZGN4czR5NVp2MStLT3FyNkxXWnlsOGxK?=
 =?utf-8?B?Mk9vUjNHS0FVVWpOQ1h2STlhZDYwZHF3eWhhd2hBRk5mTWJMQzFFbmtpVnBi?=
 =?utf-8?B?YkxpTlk4T0dpU0NDdjFNZ3NFYU1CbkJaT1doTVJFYjlpYUdDdVVUckJva3Ri?=
 =?utf-8?B?cWdaZW9od0o5ek91TzlZd09Edk4rTFlDeWNzR08zZ0lrTnBBaG1MQnVocjJM?=
 =?utf-8?B?S3ZkdnBJTlRJdyt5Z1U1Yi9IZEk2RmRPaHZNUlp5cTlvZWZmTi9leVU3VFI1?=
 =?utf-8?B?SHlKYnkxVHlLYllxRGF6SmVDOHBwVkoyclFVcmpja0dYYnZLTWlQZjdPb1Ax?=
 =?utf-8?B?YXJmcXVsYkdPcmpHaXdabGxxMkJ5UzlZMUZtL1ZsNGdtNVdmZWhXbEoxbmh0?=
 =?utf-8?B?YklhcUR5R0FLdzlUMG5Xek1pdFpibVVEazkzYmFpZkZrZEIveFFVMnFSYnRp?=
 =?utf-8?B?OFNGMkU2MndPZGdJWmZ4TWVqK1B6OG9hMGhteUdFNGYrMHRraVNpRHNNaFhX?=
 =?utf-8?B?VXJqR3dEMVVGbFpGOWtzMzBZRzNyZy9PMTgwUEVaYkJ5aGpDeFhiMmhlUkpr?=
 =?utf-8?B?TGtWcC9HMVZKS050T2h3RWRRQTdXbXUxZWE2eWtDUmFmZE5DU1MrYTdlNlRI?=
 =?utf-8?B?Z0tQTzVBeW9rNGNtQ3VjdXhNbm1RRHZObElpVW1Jdm1URzVYeGVWMG1Xem44?=
 =?utf-8?B?ZVJ6b0tFamp6QUc1d1BkS3FzQlh2UzFRQ0prTEtNc3ovdk5uRmM1MEw5M3RF?=
 =?utf-8?B?anh4ekMwSFBTZURROTJNUHVZQ2hHaGtRMkpNcWdvWXBDM0dWdmkzaStPMVkv?=
 =?utf-8?B?MUt1b0lJMWdjYjM2NU13d29QZ3hEbk5IZEJDTzZ0MitlZUw0R2E4N25SdjAv?=
 =?utf-8?B?bGJ6UUwwU2lidjRiaU1SS0lQVVIzOXBTZXhHVk4rY24zRnNtLzRiWFlwOXJt?=
 =?utf-8?B?L3pNQ0lxcVBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZ1ek1ud2hGeDBzTE1raStUaXBCYXVjZnpzWGloWjBncGpiUXYzcktVcEo4?=
 =?utf-8?B?b3VCT3IxVFRJTTNqcVdPOHNCOGlVL1FHVlJYeVhRcTVyNFlDQVNLRE92ZEt0?=
 =?utf-8?B?RFhxa1R5VE1JMjlCamFTYmhsbC81b09mZzBIeUo3OFFWRVVhU0VCekNRRXJr?=
 =?utf-8?B?T1pMRVYyR0hTcnUzT21aTi8vb0FoZTcyUTF1a2F1RHZmR0FzNVRQeWRwRS9p?=
 =?utf-8?B?TnhEVE1MUnk3UVpFejlKY3M0MVVKUVhIUkkxNXJsYmkrUGxrSm8wWnZxWGkv?=
 =?utf-8?B?U001R2JMNjR6TFI1S3lxVVZGNG1lUTJLanhCaHN1V2VVMit3ZXo1T0J6UUQ0?=
 =?utf-8?B?NGdJM1NwZDhldlJtNWt1QXVKdWhPSnVaWlpLcGtqNldwNDVFSzc2TGJRNEl3?=
 =?utf-8?B?cUswSE96Rk03SnVXVC8rVzRaUEdvenFpOFFGZ2wrL28zWEMwUjd2MjJxcjVM?=
 =?utf-8?B?TzhGcnk0N0I3UCtWc1Z2dWI4YnB3YnJQeFJwNFJ0SzRBaGpISTRiUThGU2ow?=
 =?utf-8?B?M0poMmJCM2llc0xxZmRVbE1udjZDK1hpNEhoVlZaOFlZRlV1SXlPR2R0cGVm?=
 =?utf-8?B?eGIwSHlFcFd1czBIM1FiZW9mNVpoWmd0UW1tdDFuUkVjSlVzdHFaUENzdDY0?=
 =?utf-8?B?eVlJS1pwODZMMXh6c0ZGU3liNkhXaDdubkNRdEUxaWxOcEErUktDbVl5bnVD?=
 =?utf-8?B?QVB5K3BseWRFMk9hTGVSeVFCc3ZZQlVsTEc4anpjZmZGLzhYbWdYbTM1NnJO?=
 =?utf-8?B?ODlOOEpmZG83VHBlV2ExVm01aEpLMFk4VjVycEZITkgvV3NsY285SkVDamQ3?=
 =?utf-8?B?OEtweEJYSC9CZzNHejFTL29SMCtOdFpvaDFNUWpDdHhjK0liVnRkZVpPSzhz?=
 =?utf-8?B?eThMWjRSV3dpaHJGejYxdGpSczZqbXExZ2l1Vk5KU1A4NkRhRWVHaE5nZ0Zq?=
 =?utf-8?B?aVF6aFRVUy8xejNXc2thd2VndDk1SGMrM25rY0NUc1Q5UWROWW4vbjZRSUhh?=
 =?utf-8?B?QllhSWRFNzFqV0tiUEFHZk1HQXU4Yk5YOVNlTjhad3VieUVtR3FqMXYzdThJ?=
 =?utf-8?B?QXM0TXYwbU9YRUxCSkdiWm1SRUFOUWJXQyt2eVNUWG1WM0RsZmdEZk4zSHMw?=
 =?utf-8?B?VFZyWjROQmZLNUpFeEdIU3dJRit3WGJidDVHRFRNWngzY0ZFblRGenpDbWps?=
 =?utf-8?B?V0IwRXc0NlMzOUVGUS8wbUJYVit0V3U3S2R1OGRscEZnYkkrdkFLWWRnN01k?=
 =?utf-8?B?VEIvS01BQ1ZBQjNadFJCT1ZtcklGL2ZJVVhzZGJIRnQ2MWs0MWYxQUhjVmhZ?=
 =?utf-8?B?K2JzbHFKVWlaOE5IenF5M3F2YjUvdDZzNEhNdmpZbzJDcm9YRjJrV1kyQ0Z4?=
 =?utf-8?B?YkVFc1dHOGkzczdvZVlub2w4a1NVRWRVTzY2N3c0dlhFc2NrYXlWSEtKTytq?=
 =?utf-8?B?RDRvTXBhRUJRcmk1aDZFY2tscjNqbmdTcW9VQ0pwOXpWV04rNVN0VWtJd0pT?=
 =?utf-8?B?VzFQeEQ5TGdSOXhHVHI5V1MwMS9RVFZYNmJxOXNHV2d4TjZ6RUZ3OUd1b0JW?=
 =?utf-8?B?YlFNTDlST3lSMDg4dys1blpDUGQ5bG84YXhKZEVVSkhDQmZpajBuOSt4ZFlw?=
 =?utf-8?B?SHYzZitadmFYK2piaGNvc0ljckJQZEx2UU8rQm1QclZUdy9oM3RSS0F1VjM3?=
 =?utf-8?B?SW1DWGQ3VlIxRlkxSzlVM0cxZWlxUzZreENwUE9LWmJYV0dtZ2s5ZC85eWIy?=
 =?utf-8?B?WVBjK3NGTG1QTEdGc1ZkWTJyRW5aMllDVXpBaVEvd2FMZUdmN0xoOWpzRXJv?=
 =?utf-8?B?WnU4eHQyMy9hZXJnSmZOZ1lmdDA5RUxqK0Q0dER1UGtraG5CR0ZpN2s4QllJ?=
 =?utf-8?B?R2NINVoyTUs1bGphRzhKZzRzWDRObzdPSjQ2UUF1T2VFZW41WTdWaDVGRWQ5?=
 =?utf-8?B?QVlraXFBYnNuYjNyZjZRcmVLeTc0WTRxL1N0ejhqSmg2bjJrK1c0R3VWSy9u?=
 =?utf-8?B?ZWFyZ1NXUHhIK3BNZ1I4clVXNkNHYVo2MW9PSzB1MWcxaE54SnJZNVBxNk5Q?=
 =?utf-8?B?c2VoZi80eVdXRFJ2L0hvajVoeUtwSDhiYnJHQzN2RkZVNmRrOVNzSFgzYVkr?=
 =?utf-8?Q?m2IwG28TnlS4IwAGa5canj+1+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a892d9ba-950d-4ee0-6591-08ddf4a67b2f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 22:23:22.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +riC+xAOCPj1EZWLqHgetbRRBgKU3SLmGwwPvAaQu4QsLJem3xnmubaGoXuFoS9/LSCoypjtgHnEj/HkGVOYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Add MSI doorbell support to reduce latency between PCI host and EP.

Before this change:
  ping 169.254.172.137
  64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
  64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
  64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
  64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms

After this change:
  ping 169.254.144.71
  64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
  64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
  64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms

Change u64 db to atomic_64 because difference doorbell may happen at the
same time.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- update api pci_epf_set_inbound_space
- atomic_64 should be enough, which just record doorbell events, which is
similar with W1C irq status register.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4fc2b485d5463faa2172500f12999..06c13f26db1c6e55d23769e98e2cfd80da693a20 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -36,11 +36,13 @@
  * PCIe Root Port                        PCI EP
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
@@ -126,12 +128,13 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
-	u64 db;
+	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
 
 	bool linkup;
+	bool msi_doorbell;
 	u32 spad_size;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
@@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
+			atomic64_or(1 << (i - 1), &ntb->db);
 			ntb_db_event(&ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
@@ -319,7 +322,24 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 reset_handler:
 	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
-			   msecs_to_jiffies(5));
+			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
+}
+
+static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int i = 0;
+
+	for (i = 1; i < ntb->db_count; i++)
+		if (irq == ntb->epf->db_msg[i].virq) {
+			atomic64_or(1 << (i - 1), &ntb->db);
+			ntb_db_event(&ntb->ntb, i);
+		}
+
+	if (irq == ntb->epf->db_msg[0].virq)
+		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler, 0);
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -500,6 +520,90 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
+					    struct pci_epf_bar *db_bar,
+					    const struct pci_epc_features *epc_features,
+					    enum pci_barno barno)
+{
+	struct pci_epf *epf = ntb->epf;
+	dma_addr_t low, high;
+	struct msi_msg *msg;
+	size_t sz;
+	int ret;
+	int i;
+
+	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+				  0, "vntb_db", ntb);
+
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request doorbell IRQ: %d\n",
+				epf->db_msg[i].virq);
+			goto err_request_irq;
+		}
+	}
+
+	msg = &epf->db_msg[0].msg;
+
+	high = 0;
+	low = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+		low = min(low, addr);
+		high = max(high, addr);
+	}
+
+	sz = high - low + sizeof(u32);
+
+	ret = pci_epf_set_inbound_space(epf, sz, barno,
+					epc_features, 0, low);
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, db_bar);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR set failed\n");
+		goto err_request_irq;
+	}
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr;
+		size_t offset;
+
+		ret = pci_epf_align_inbound_addr(epf, db_bar->barno,
+				((u64)msg->address_hi << 32) | msg->address_lo,
+				&addr, &offset);
+
+		if (ret) {
+			ntb->msi_doorbell = false;
+			goto err_request_irq;
+		}
+
+		ntb->reg->db_data[i] = msg->data;
+		ntb->reg->db_offset[i] = offset;
+	}
+
+	ntb->reg->db_entry_size = 0;
+
+	ntb->msi_doorbell = true;
+
+	return 0;
+
+err_request_irq:
+	for (i--; i >= 0; i--)
+		free_irq(epf->db_msg[i].virq, ntb);
+
+	pci_epf_free_doorbell(ntb->epf);
+	return ret;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -520,22 +624,27 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_DB];
-
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
-	}
-
-	ntb->epf_db = mw_addr;
-
 	epf_bar = &ntb->epf->bar[barno];
 
-	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	ret = epf_ntb_db_bar_init_msi_doorbell(ntb, epf_bar, epc_features, barno);
 	if (ret) {
-		dev_err(dev, "Doorbell BAR set failed\n");
+		/* fall back to polling mode */
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+
+		ntb->epf_db = mw_addr;
+
+		ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				      ntb->epf->vfunc_no, epf_bar);
+		if (ret) {
+			dev_err(dev, "Doorbell BAR set failed\n");
 			goto err_alloc_peer_mem;
+		}
 	}
+
 	return ret;
 
 err_alloc_peer_mem:
@@ -554,6 +663,16 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
 
+	if (ntb->msi_doorbell) {
+		int i;
+
+		for (i = 0; i < ntb->db_count; i++)
+			free_irq(ntb->epf->db_msg[i].virq, ntb);
+	}
+
+	if (ntb->epf->db_msg)
+		pci_epf_free_doorbell(ntb->epf);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
 	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
@@ -1268,7 +1387,7 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->db;
+	return atomic64_read(&ntb->db);
 }
 
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
@@ -1308,7 +1427,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	ntb->db &= ~db_bits;
+	atomic64_and(~db_bits, &ntb->db);
 	return 0;
 }
 

-- 
2.34.1


