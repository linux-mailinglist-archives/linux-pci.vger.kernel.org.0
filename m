Return-Path: <linux-pci+bounces-16356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAB9C25C8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 20:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF55BB220BC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A69F1C1F06;
	Fri,  8 Nov 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="apToalrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD491F26CA;
	Fri,  8 Nov 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095045; cv=fail; b=kpuQa1HXvJWhTdnK0lJqsCgpWextnQUXaMdxJhEGCXfvZCu0ghXwevUH1aWN7JmBErjDwpM84W2t99bVim3+4x7i54P9p7PmEImBDbCfH24timYRzFzlz2X9YSzG2Eoyuf3CukHOhA9PTJwa+c4t+mMgBIn+PQ3dCFMtlnWZ5mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095045; c=relaxed/simple;
	bh=SU3fKgx2Cixu2vdRhLxkwq1ELVV5yh+eHERg3ui/hfM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V0JxH/dPOIz+Qip6riAe+WHH83GwphIf80RE2Yfpf+sdZBHgpEJ0ZMPvk+uRwU1zxAiWzqouaMjaKmMS4BhTHlyLcOsUmKULjqcYd7lP3TQ1M2WRaOENdHb8+XicQG0uGv2Jsnij0p9SH7yl/pbSIkN1Amr0mAzWKyoavNi1sXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=apToalrw; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/BWNrGVJoReaEl6npD3/C9rzhck6Ddj4E3y80cN1wIIFFdDygyoGOUGhhmibsVE+IzUgnEXDUFhA9GAJuDZeQ7s59W+7/OuYH2xYFYWt7EisKpth0ySXGQn5fOREifs7oR0fatVC0OsnW02rJDxKp1XsKnAEKwsbDVkz9kkeKYx6a928J0oHwjl+fA3BGIi+lakAAqROj7O21+7nh0Qw/b74Ack06c8J9lFCbEznAleYlxL4h1dw0Qe7vkPTEKme/TWWJCte6wiSZ6JjsXR98y4hIRJP6X3M6Ao2eJ3YENhpuijku0+eC15jNzwnNhduuwWYJTOgCs5pOONwxJ11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYjCSRL/Hn961hMFw3NHAPh5b2ogFPlNjKf7ozvJaZc=;
 b=vWZRvyGeJ0KsCYHzGAr+vlKscGkRQsUtppCNz60gYFq/NqeauW/2Bl8dXVGmHDpHwk50eJ9AIbGWsAiQJw/PdAeRq7zWXaGFZ+fZs+urdj1bKYnn7QtHnOK3jB9P4pAWBFv64a04FDEyXDVQ2Pyy2/LNo/4N357pHL4R0sCzXBQWBkKieXnYIgpVoIyRlqJdg0LkG1qFV73FCWgpv83N5RjipAqeBFjjuVrjadQvKTwei0FQtQKwk7hvUd5Q5ujvU6OGljsVyzXE0rkdGUjyuuG/AsW9TfuH4tMh3tjlepMQAYNRJtOTsUHm6roOQioS1xTAqtafFLtsjho9fXtkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYjCSRL/Hn961hMFw3NHAPh5b2ogFPlNjKf7ozvJaZc=;
 b=apToalrwjSlIE7SRmEIK1S8gHcH1aIyQxCeGj+IqCGNzmEQ2SbJ/I+3sePgpnfsQ5yh4HYZptmeFf9njV9niI+7QTUDXXk/f7GJhPrHc3q3Cu4LVKtCGmw4N0y4wXqDWcm8hhpjAaTqsLRe8Q43Qa+wpGEGTTq6lD+WSYU52sohmHUjRm9IDP+4l0Q6N7NEw5I3O7GQzC+/+3aIA3y4mPzwMy0fOst7MustMUiREzuuFISJ8LuBq8b93DUReESrmrpScxKW1mWxCRy6rdmq4ijV9daDKtCwbR+OJIlhV9qodI3Hk2gtUFnmoLmhuLWfQijWqLbT4bOP4IGEwrjGp2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:44:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:44:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 14:43:31 -0500
Subject: [PATCH v5 4/5] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-ep-msi-v5-4-a14951c0d007@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731095022; l=5357;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SU3fKgx2Cixu2vdRhLxkwq1ELVV5yh+eHERg3ui/hfM=;
 b=N3iARweiI0kqEpBr2XlbgjkpHJixWh7oa8XQ1V7tpT0QkUc4grkbCqtEbgyDcYK1IRQb6Tfl1
 UmhouqsOoL5A/TGNATvqakaW5/llE77/v3h5ib49hJ03skfRPwArf0E
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
X-MS-Office365-Filtering-Correlation-Id: fbb97368-9f76-4f56-6963-08dd002db17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1NPYW50ZzhZdk5rYXh0LzRoelZnUnpXT01QUXFzUjQ4Y3IrZk1OTkNub2Vo?=
 =?utf-8?B?azNWUm53ay9HTlBEditheWZLR1paRmlEazc4OThZcUQ2Y2VEWFljTnNhb3JW?=
 =?utf-8?B?cDZXWnE4YXJQT3J0LzhXOERUUFhWbnk2dEJrM0ErWFY1cnBHMkExZjg4dFRQ?=
 =?utf-8?B?VmdVTVZFL3JrWm5QN0F4UnFoWHYwQnJNZW1JUXJndGZYSCt5VUE1ZEFUeHZn?=
 =?utf-8?B?ZTZLajBwajNqaDhDWlVjNXd0NEpQOEVYWUdTRjRQZERUc3VlR3RlSUVMdkpk?=
 =?utf-8?B?MG45NDNrWFdXMVgxckt0TjlramU1T3oxMHk5MGRmZS9ycngwdjNOSWNRUjhH?=
 =?utf-8?B?NEpnL01EbGtGZmNlTENNQWlBZEk2UENYeUdUUjBLM0h3Y3pIUGNteXBtK2hk?=
 =?utf-8?B?Rm0rU29Cbk96Y0xobWZkRnNPemhubzFRdzZOazlQODhvSkV5QUFVdXhWOGFi?=
 =?utf-8?B?N084M09hdkgyQVgzdWp2aGVWUlRiZndudzBhY0t0emh6T3lTcnhzWEZVbURO?=
 =?utf-8?B?K0FrM002QnU5YWdubUhyNW9BeUNsNDJ6MFFETjYzcUhVSHFsT1Q1WUMyL3ph?=
 =?utf-8?B?QnVOWk10ak5RVlRrTklYVkp1S2dHbWZEcjI2Z21jREVrSGlZeW9JUEg5RHRK?=
 =?utf-8?B?ZUJieVVFOG1IWGJQV0xvckZDQXdseTFUZmkvQXZKTkVvcEZmd0x3ZHE1YVA0?=
 =?utf-8?B?T1JMVHFyOVB5UHNRbWZZL1RXbHBXSVJHL2x5UElhd2YxZzBSTlh1VkVwRVJr?=
 =?utf-8?B?OXdBWlUzVEtkRkpRNXM0NGMveXMveUZGZCt6eEpHK0VZNiswWnZRbFAvdjJk?=
 =?utf-8?B?ZGlFZTZtT3oyekpmY2RZUmlvNUp3VHNSUzF0SlhHc2wvNHdCUlV4UE1XUGlN?=
 =?utf-8?B?YUg2M3U1VjJGOTV6VGQybXkyYWxjdFkrSzVTTko4UTVMMVptU0J6bW4yLzlR?=
 =?utf-8?B?S2RIYUhYZWdqNkY4RjNxcTlUOTdzRmorbnR1bTRsSzRKQW93ZnZEbVRNeDJs?=
 =?utf-8?B?Wno5YzhaT2QrYnRjT3o5Z2tLVHN4anRIbzJOQ2Q4WVZhTFRVd3ZGQTZWRXpO?=
 =?utf-8?B?dDVZdFNnZ1pSVGtJVTZVSjcyREJLY0lWazB2Smtrbm5WRTdpNytRK3YvT01y?=
 =?utf-8?B?ak9pZWhmOEhSODJwT3JNSURGNHZIWWs1Q3N5aHU4V3IyRHVzOExMTVlrNzV2?=
 =?utf-8?B?MnZqbkdXUkk0aEtHRktPdXIyR2p1Zk9RdENzZHBEQ2tLQ0ZxZytnai9FbFJK?=
 =?utf-8?B?S1ErS0N0THp5Q3RHWDROY1VkUmJRS0VUek4xSVhvenpuV0hwYnU4dEZoUVRv?=
 =?utf-8?B?bmZ3VWxqUU5QTXRIdkJrMXpyblgrdUZGSElnT3ZiR2RQWDNTVTRXczJLVGpM?=
 =?utf-8?B?d3k0YUViaVpuWGJJaWs2aHhqVUR0cHhjWk1xK3lHLzlNY2NPYTJnWUxia2tD?=
 =?utf-8?B?Q1RTeTJzajM0cUxoRVptMTdpM1RWS3hqZ2M2MlhIMmVkc2VBWnpCUmFlTWI3?=
 =?utf-8?B?eFBLamNhclc1MytCM25DWU9jOUJmSVNNYmtXU05kWXRlUU5IZEt4Sjk0djZy?=
 =?utf-8?B?bmluL0Y0MTF1Q3F0TUdTc004UnB4cWdvcU42SnRKcXB1QXppQ0RQSmJvTTVn?=
 =?utf-8?B?M1Rya1ZZeHA2U3J4Q1EzSUo2L0YzRzBZbXM2aStENzNGSVMydDVZMUt0cGZk?=
 =?utf-8?B?Y0dwWDF2c1RXNnorNS8vQmxMeFh2VFB3VHc5N0ZyOUhaTVhOSi9LMVpIa0Ur?=
 =?utf-8?B?eFplc0grVmNXVU4rNVdJYUhOSklxRWVVVEJVaVh2NWF6V1ZMbHM5Rkp1eVgv?=
 =?utf-8?Q?jNJlGMnxnvWV36IGY0KnDdYol0HBt0QtSXBAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG9NUE5VQXFveVRmTEtYV05zeWZ0VzE3R1EzM2NnTGhwM2FGbE52UUhQa2FH?=
 =?utf-8?B?RmQ5UjR1OVJyYlVKRFpqNVJnUVh1cE0xd3ducVNhYXpTU2dJZWpFVVlLOTM0?=
 =?utf-8?B?NC9xRzJEa2JWN1IwM1BPQmQ0SUM4ZTFpSzJOVTNqTWZpdUNnNVI1aHlKQzF1?=
 =?utf-8?B?TVpkLzl0bm9La25pckhySGdVSmRya3dwUEtnNUR1QUdGRUtqVjdjQm5QQUNV?=
 =?utf-8?B?SDZ5cFM1SmdSaEJpa0ttWTNkNTIrRFJWOFJya3N4RFMxdXVwUTFpdGFlZkFt?=
 =?utf-8?B?Z1BwSDhyVitTZGRCRVl3R1p4VUtkK3owcTJaVkdlbTZWL3pzaGtTK0pzaU9q?=
 =?utf-8?B?VHB6Y2YrSmJmSWxCQjBOSHJZWWpCSFBYclhDbmp3dm1hNjJnQUlDNVhtL2pp?=
 =?utf-8?B?dGpybEpjMnBhRUl4WFJPSmxtWlRjWEdWdVp1eElKMk9OODJYQlZGMSt4Vm9W?=
 =?utf-8?B?WDNRQVRENXhWa2Y3bVpkVU9qeGxzVkowWDdXVUZLc1d2dHBURy9vN01ueERB?=
 =?utf-8?B?Ky9wWlQxRzM2T3p5VVhkVnM2bkJzbXp4a1Rrb2RxR1R5b0owUndhYVFyd2gw?=
 =?utf-8?B?bTc1c0hPaVphVDRWdEY2NUxYRms2MVM0cEpxOUFuYmJacUpVb0t4NzMwSFRo?=
 =?utf-8?B?aVlCUmdJY3kzZ3NJS01mVmFzNGJIczBVR1hCRk45ZUExakZvdVRNaVd1bmh6?=
 =?utf-8?B?cVpxNWhyWE5QVmxvS0w0VFpYYkEySm5kT2lseG55NkxJRnNYQnJUNnVlYkh6?=
 =?utf-8?B?dERaaGVFM0VhOGRRdTZGTGxmeE56bUxzcGRLZ2J2bUJqekJTeFdreitYcXQr?=
 =?utf-8?B?SXMrSVQxR25iMW5TM0V0U3U1emk0amdMM28wY05XSThGejNvOGRtbExFeDdQ?=
 =?utf-8?B?SitYakU2eEpCM2dNQnpmQmNmem5QOW9sVEgveVFVak84ZGMxU2gxOUZJZ05t?=
 =?utf-8?B?TjZYSWh5MHNtUkxVU1pBZVBpVE9Lci92aGdkU0U5MGFLYU9mVmpHL093dWgr?=
 =?utf-8?B?U1NqdWE0b1VOWHpBNVQwTE1XK2dEb2JjNmR0TjA3TEVCZzV2WWhxcVMyMnJR?=
 =?utf-8?B?ZGt1d0oxaFc5VmFYSS9MblF1OXNIdUJqYVNXSWkxREdocDE5MjBKQlJ1U0Y3?=
 =?utf-8?B?a21leEd4QzVRUU9LVC9vQzRDMVEvdmRsNlJtSkZqdDlTanpmdzRTUHlkWjJG?=
 =?utf-8?B?N2tITy8xZEh1a0xITHB2ZHJnYklSRTNpaXRvbWQxUzU2azB1VGdvSjIzdDFD?=
 =?utf-8?B?TkZmWnFGZUdBc1VOSitzbzhHaWx6cHpzVEwvOHZUVjNUekNGZWVrVEVNazdS?=
 =?utf-8?B?Yk5BQXFJNEk0VDZrWFdIR25RMGVBVXkxVUxrQU1rVTFyVytlSGpsVkR6SDdl?=
 =?utf-8?B?VHRha3NmOU1vOW9PVHhxdUp1MGpKTGY4Mzk1V2NtZFVielhwTGNPNXo1dEpH?=
 =?utf-8?B?UUcwenhhVndMeDFCV2hSU1NhM053MUZQdVo3MEZXRmFzRW5uaXJacndJdE10?=
 =?utf-8?B?RDdRL2lQUEpmLzdCTE8xWEZzS1l3U3AxS3AyYlpua0UwVzdFQ3dJUml1WUVm?=
 =?utf-8?B?K0VZWjYwbEZyaGxmc3E0aVhZZHo4K2NjTWQ5UUVPYkg0eGRxYXBWSGdGL2tl?=
 =?utf-8?B?a05KcWJZNVlzT3ZnL3lKNEU1aUdSOHR6MDJKY24wV0lCclBWN1Y5bUZNN3V3?=
 =?utf-8?B?cHMwVnAwWjJZZ3lHTEtDUnRpcEZ6TEdSSG1oK29hS09lNzVEVGhJVUZnd1Zq?=
 =?utf-8?B?bTFXTGxtNmw1enhXNlpEK0xDVDlBTnRhbGkvTHZNUkVJMVdGczQzSGxkOWxT?=
 =?utf-8?B?blhpVXM4b1Rtekk3VXlPcUx3aUFONUdUTWRqeWJUQVA4WEZQQUM1aHpwZVhH?=
 =?utf-8?B?YktDMWNqbnNNRjM5RWpJWk56MlJIYkZoZVZMcmN6OFB2NEZMS0lKN09IYVR5?=
 =?utf-8?B?WUtyZGRIeVlQMmw2d2JnUHZkTTFuVHFjVVhBanR6VXRra3R0RFJXTWtsSXFI?=
 =?utf-8?B?UHIvZmpwa1NVMndkY29iQnlnMjB3c3FYMDYyMS9sVEFEYUR0ZFNTSENRT2J1?=
 =?utf-8?B?dFVnK2lwcUI1eEIveDZCcHd4Y0dUYXBNM2dONjhLRnVHYzB4ckNkeGlCSXl1?=
 =?utf-8?Q?IFftwp1PdlA4uTnF6uHQEGaoe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb97368-9f76-4f56-6963-08dd002db17b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:44:00.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skBbqxRhrs9Nxg1T0KYkY/EQMd6mv7IS6NYl+oM2j8at1xFNzAL4ObmnwWNVnKi6c8vux8uRlxitewhUcaX6PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_ADDR and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem.

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 71 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..7e5741e163630 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,62 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL)
+		return false;
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if ((status & STATUS_DOORBELL_SUCCESS) &&
+	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +861,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..06d9f548b510e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+#define PCITEST_DOORBELL	_IO('P', 0x11)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 

-- 
2.34.1


