Return-Path: <linux-pci+bounces-18182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22969ED7F2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4305B283B48
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2B22967B;
	Wed, 11 Dec 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iTc+YW1t"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5125236F9E;
	Wed, 11 Dec 2024 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950683; cv=fail; b=XDEb9rHIjHTHb8+EtEGFlkrvZMMrc3cDdFyJWmaDNtU1xiMUf6KQz2B7LgQoCY5fBEKlYqC41yx5ek0yAvLS+GQmOge2pC6BsrrUMqW7CJGwHIVCLZbos8tl6XAKIIrKhaWWhR1LC/M0pGwSzIbNjlXpS3bmALt9IBxy997rXZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950683; c=relaxed/simple;
	bh=Udf092p8YjxrnQN11gltHeyiotoRRFrXWEdyz1BjlZI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=heFNE0pJ/x/r4PTaQsFbrkGELmRHX1PKztBAB0nC6k+85iYrR8a7mPGElJk+zbxygiwcIRH9DnkZtFkNto6EViBiyS4w61caSwU1W+OXQ9eXiSuCMrAZ12zNmPZyJw4fuMOxaU5BKA8/iHN4ZID3769JJuSt1Z1EEFUoP5IWMSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iTc+YW1t; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOO1sI0CuvMXkg9lwYysUU7z9xjxEVgAxgUV1bgcd5xmvgI2A83M48NdLqf2BaCjL6ovtD43+b7VZ1rnMhzlKsQYNh/LmJTDO1Seg5mIaKaTocB6XoI4/GBff2ZSeyM9+GKUQIdIQdaqkmxNZinWg92YW/aV/awqa8nEkPElRBnI8lJ2EKLbHB2LNx202kmL87m64+SRFEDKXkZF1QLQhY7C/eBuUw2S/gVpJO55Th+4NqgJiCLNs3Mo45pFqoNtSyHKvB0pyXdKv8zCz1AWs4TD1fH1P/lRkR3NJZ9DXgDuJitBY/i9lxHhqVaR4v+Jfajh8vYZYiteSXoqZMZH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSjI2OUg9zpkx5v2mVQeZQbwxanG9aTvPl/3UjNHnHk=;
 b=W8WtlFClJ4eEfmlVbvcTB2UNzHBc1FqrpfXZZ8/p1UrD8bjrgZ1iDX6T4Lozhv15tKsSeaxC5izRwsQul9eX1gM6wW0I5rCC3bhKskvr79eEgNVOj3X+qMI77iQxrzn4YU/JQo56NDfuxGFDJGKUmSsaj7CgxA1OlzFQGvZRINw57ZBqLml4nbRxpPfc6cOEI4UZV+36BIbp78Yku0YLr4xQ/Q+XliRiLalmF9CEdg1jfxj8077QkoKY4iHMRszk3jD7uPYqbHgEhMmur9tpqtcN29SYSZ2kjELSsFM+wAaApZ1Uc1DHtAJuBmpMAvVGa5z3xNoNyrTmUaIkodKoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSjI2OUg9zpkx5v2mVQeZQbwxanG9aTvPl/3UjNHnHk=;
 b=iTc+YW1tQHH+GXA18yVgyxlODIRzWvmcQtxKxdQO0wyEdBwNwO0FqJI+8wmS1P/Z5R864OC5j/DDgbHFYayYNo2BKabHEHx865zmZ0y8H4Lzp6O4NFgCCRW6AL6+mvLh3P5ijRdVS8U4gIvOR7PykkKtMxPKmf1O+wSFeibUYDoQnsbNHa1bYZBpRXZgHgnqZyTUW9CXYiGRI57zcRup6hp7tcGG1qMPkY8iiZwrN2kRlSTq9O92S9S+icHV6yMHQLGzTIkOdbKJ9zhDn7P5a+NDPWVFTM94dOkGJqhhgVLLtY1An7TJw4ayuIgihce5xUxzsuthCFUjHwP9Jt4XvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:57:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:57:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:30 -0500
Subject: [PATCH v12 2/9] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-2-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=8536;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Udf092p8YjxrnQN11gltHeyiotoRRFrXWEdyz1BjlZI=;
 b=uBHyPAj0CEvZaks+WEu1KQpI8LXbt4CPR/bd0UABXhGiJTkjOsHSaRUtZ+10g3No16A7PEmLc
 t9TrdVoy4NgA2ZM5ThbbpU5795ZXeXzSPzAKJnnd5ayMHmwT2R6zDqb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: caedd752-9a95-4b9b-10e1-08dd1a267cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGpyY2Z0aEgwZlMxNEpRd1RwVzVoelIxYmZtQ0N6a1RDTnBpZ3R0SWVjbHl5?=
 =?utf-8?B?MVZjSFZJQTEraWNnWlB5ZUNyWDB6WkowOUJya0ptMGJOSjVIUjV6QXRFV1BT?=
 =?utf-8?B?THlZMVl0V0VhbnhIYUZPeVFFYVg3N2ZSVGVuMTlMOWhFU3JqakxBeko4MkNJ?=
 =?utf-8?B?aVVGVWVnMVBqT2NlcmJhL0VnTXlIbGZEWTdBMFZOQXZMcDZGTUVlNXpZN0hZ?=
 =?utf-8?B?L1hDUDBPaFJlcmI5WDlyT2IxZE01d3ozdW5rUVh3MnpLeDBhNjdNMG5nT1RB?=
 =?utf-8?B?b1Foc1JOWUZtTUlIWlcrQ1Z0eEd6V0FjS3B6RHlsb25hQll3Yk1lNFRadjF0?=
 =?utf-8?B?V3V6NmsvU1ZtMS9NWm5YSHVCWUV6MkxwWWlsUlRzZXk5SjZkNTVtREh5MWV3?=
 =?utf-8?B?b2JLR2Fxa0pocjNqS3ozUHFwbEwxaW5XT3d4Vks5aXBmZXRENWs3NUk2NUdH?=
 =?utf-8?B?TVBSaFMxQkcwdWJ2L0c4K3YvSjZ2azdrRDUwc3RmS1ZmMWNuWEcvR1JkUW0z?=
 =?utf-8?B?TS9GOUd1TFZ3dS8yb0VjMHZwL0Y3akhFUmNQSDlHQkNYZithbTJqSFZKa01D?=
 =?utf-8?B?Mnoyem9xVFhTOTJ5RlBmdnZNdDBYdTZhZW8rUEJMcDRKaXp1a0l4Z0Vvajcv?=
 =?utf-8?B?UTczdFkycUIvOGlnREI3aVI5Y29GMXRRVjdsUFlGSytoMzdGL0lwTHB6ZTBm?=
 =?utf-8?B?M2ZHSE4xQ2ZYbEg4VXB3RFkyMXp0V3puRWlsRXNpd2tIbTVvVHNoYzhaRW9p?=
 =?utf-8?B?UGxKUjZKVmlYZVJ6OG1FYzVNWDV5d0xPclJ4bExSYjd1QkUwUDE2U2hlYldl?=
 =?utf-8?B?d20rREpWUGF0ZWZBd1FVT0hXVGpuY2RsZDBqQi9QT05sMk1JUm9UZmFmL3ls?=
 =?utf-8?B?WW5oM3QxcTNFem16TXFqTS9vOVVtMUZhaEkwSmlzMXFFV0N2SCtWd2duVE03?=
 =?utf-8?B?K05lOS9zb3ZiVDdkem5oRkFsQXhJUDhENTJQcE5ZcEtFck01dythT2dzTjFY?=
 =?utf-8?B?cVBlZGFSeStlbnJ3b2RINDlyNHQ4TlZyRzVLQmZYSkJGM3htWVpPYzhMOFlJ?=
 =?utf-8?B?cjV2UUVjTGRKRG1KaUdJZG5KbXNtQmJEL0hNbkNOU3lIS3NjTDBVZWZtdEtF?=
 =?utf-8?B?UDdKVG9va3R3RFlIUGd4bjlYRS94emJMRXpkU0ZqSGNqVXltUDRHY3AwVmxC?=
 =?utf-8?B?aUZrRlJCWVpEREk4RmpEaVZiUkt4ZEZQRnRFVFNuS1QvaHpZWW1rMy9VYkxN?=
 =?utf-8?B?Rll6bEdDQm5oSUYrdEdtM3czaVdFZS9yR2Q0L25uRTRXMXZyMlJSQ0ZTUmVp?=
 =?utf-8?B?aFBubThUdXNqR1dMRXFqbnEvbmhMZFdwUGdyeHdjcEt3Nm4xVTB3R2FIYmk5?=
 =?utf-8?B?YmVvTWxhYWNySmpYRkFKODdTK21SaVhHZ1BCeWIrZnQ0QXFhSzVyWGFBeGll?=
 =?utf-8?B?eTVSWHVYbmJvdjlyK2FkMmdHWE53K2R1Z3hqT2lhTUlJbG9GVzlldUxPR0xS?=
 =?utf-8?B?UnRUK1ZCN3IvY3JvUkV5V3UrV2VHSGJ4OHo5eFhnMUNzTTk1S1IwUURJZk5J?=
 =?utf-8?B?NEo2b1VXb1JqeW5lSnZHTmh6WlhJWWJSamtsRE5VNEFBQVQ4UzFXVkdkcWlR?=
 =?utf-8?B?QmxlQU5UTStsd1RkdlQ3cUJNWDM0TlJWVU1zaThwVnZPZ2hIeTJwY2dRR0hH?=
 =?utf-8?B?VnVzZjIvNHVHaTRjdG9XUStSTDhQZlBhZTFuODdad1FZNnFBNWhaQllid2cx?=
 =?utf-8?B?KzZkQ29wVW5ub1g1K0NQL29oVHp0UTZJY29wVFo0WHBDQlVUU0lINE1ZMzl2?=
 =?utf-8?B?WVlIYmdOUDhHbktyY0ZaQWRSbURyMXE2OWtBaHR5TFJLMVozb3hFYXNPcVd3?=
 =?utf-8?B?M1p1RHVnODFoUlNCZ2NqR1hiUWd0RDJjNmFtcmZGTjg4S3R3SEFPUFZ6bDh6?=
 =?utf-8?Q?aYJDjeoMQ1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmhkMXJTeEFKUVRLeHdNRXZtMXhMSWduQUVTU0dtV3N0V1RycGVhdTFDb3ZH?=
 =?utf-8?B?eEhlVmZaTEhBRCtLMG5JeXcvalFuakdYRUd1Z0NRNXo3RVB3bmFaeGhtdHFB?=
 =?utf-8?B?di8xemEyZ0h5dTV4ZGR1RzEzTHlUQXVzNHBPYXJGU0o2NDNBT2x0TmtVbW02?=
 =?utf-8?B?R1dpcStCOWk5K29Ebm0xNEo5TC91RzVnTmE4aDl3QzhuQ2JNb0RRSGY4QUk5?=
 =?utf-8?B?cHdoc1dCVTBWdnFBSFc1Mlc0aFF5SGVHaXBKS0E0aCtmMmxvQzlNNkc1dGxH?=
 =?utf-8?B?TW95SHArV3pBTmtQUHZaRm91bXByQ3Q4eTRVZkE5Rmh6OWJwMnB2SUFHdlJ5?=
 =?utf-8?B?T1RtaXY1dEtXWGJkdlJRaGRGTUg4QmthaTBvQ0NOOXl3Z05teHNlOEVYL0FV?=
 =?utf-8?B?RlYvbkJrallWTW44QVlZbDIxQUhrM2pVYjlqK0tRUUN2WlB0d0V1ZWxwTUNl?=
 =?utf-8?B?RVBCK2U4TnhYTjBMMDJlSUVFZjVvMENHTnFKdXhLNFdhODlseVdvK0x1VVp4?=
 =?utf-8?B?bzJkYXVXVE9tQ2w1MHFEaHc0N2lQc0g3bGdmNDRNejEzWlR1QUlTcCt0YkpZ?=
 =?utf-8?B?dkRIU1VRKzBRN083aUdlREtUZ05pTitaNkZLMWxYM3p6aGVjUWJHdmIyeGNj?=
 =?utf-8?B?VEN5SXVpZndSei9sa1gyMllNSXlDN3BONFBNTmt4RHdMK05MVDJVc21XaHVG?=
 =?utf-8?B?eW5yV3FvQllmaG5jWllaUVAxSjd5SXBiRlU1OElPUUdCeWl5OUtGY0x0blFK?=
 =?utf-8?B?Z2xkSzlxNi9ad0l2U3k1ZzhZczB1UjJnR0tqREk0NDExZ0xvZ1VMTmlMMVNT?=
 =?utf-8?B?b0dxZWk5Uld0cG1yK1dRcmZUTnVZTlRWTWtCQm5aOGFYNXFHczl1aU5MSUVH?=
 =?utf-8?B?MnU4cE9OL29PWmpUdENyYmNScVlDV1YzS1VYZFhncmxVRENkMnlTZzhTTWZT?=
 =?utf-8?B?cTRXYVVubzZGSzRQQ1F0Qmc0Wk53N0lZTmNudlZMYTIrWnNiVXdDZFROTDk4?=
 =?utf-8?B?WXg0ZmtNc2JiMFlycXdmOTFHVXJySGR1ZUVUZGdpL1NGSFpMTEhZNFp4QWFE?=
 =?utf-8?B?ZmduZEUyNE0veGdZN041RmhOZjQ5T3R1VmJtOUx3ZytEZ0tnYys4VzA3bHdy?=
 =?utf-8?B?aVpxWGJ4ZFZ6Vm1HUVo1T3NvZE93Tk9FY0orZm1vM1VIdUJFZnNWTWM2Rml1?=
 =?utf-8?B?VE9sYzVxSWp2TWxJWG94b0RSdjMwdU95S0NYSC8yT1ZVUTZwSUxXOEFkRXhw?=
 =?utf-8?B?bnM0TWZlcXVzZUh0SmNBS3YwOW8vR0dUaEtXbXZHYmYrazlHMUdJNklTUG95?=
 =?utf-8?B?dWUzZWJkSmpPZnFaRWpCYzBCRmFuOVJxazFXVGdNSW1Qc3RabFpldWVpb0dZ?=
 =?utf-8?B?cWtzWlhjYTVtZDEwekdUZk9kY24vWGRiT0ZOQ3ppVVdSbFVHY0p3elcwNGdU?=
 =?utf-8?B?U1Q4dHN2ZTE4c3cvTkFlVlVKc0Z5RkhkZDBid2pRT2NadC9vZllCYUxZaWhh?=
 =?utf-8?B?a0xWZ3prWS95cUh2eXR3REF0d2I2RTJNRDBLTjJ5cmdDQ2VaM2xGUGtnZGt1?=
 =?utf-8?B?cDluWmxEU2VzVG1NN1huSzhocDhBVzhpQWFKcWxvMWFiaXI2elE2Mlh5dEpT?=
 =?utf-8?B?cUtuaFhXUU1ydllRaDFUMjQ1Ujd2MTNUUFM1MGFEb0VETTVIR3Vqd2hMSTVv?=
 =?utf-8?B?SzVGRkNVa3JOYk5DVkU2TUYzd0NJYTVnK1p3UUZ4ZDNrMWVUVzFDN0NFb2NP?=
 =?utf-8?B?Y25TZ3F5bGNUS04waTR0K0NsdnY3Ni9mZDlVYWp0NURTaURlb1pIRzUycHNr?=
 =?utf-8?B?dWIzS2EvZXN2L1BjOWZXRVo0TGptdEtQOXZpWHpwZnAwOUFDbkVDSEJCOEVH?=
 =?utf-8?B?WFhoYkFwOXd6MjkyQXRNaDNFNHhhVnYzSjA2djNVVXd2OURaeFgzS3grQnUr?=
 =?utf-8?B?WGxkK1g2MXR5a21POFZhM3ZSbEhRR1czcEdnbUxoMzRPUjFVYnh1UHBqa2VM?=
 =?utf-8?B?MnRuTTJQMHFwY3dqYmdQWTJDUFhQUm5OaDQ0WmhlTlJIWmVjUktxSmgxNGdK?=
 =?utf-8?B?eW90OTVCcTBFVk9xajh2TzVMRDM2dFh4UkFHNGJUTjNnZElvVVlCZlBNQWFv?=
 =?utf-8?Q?Pq/9kfRGiEKCjTO36b/8cHk0q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caedd752-9a95-4b9b-10e1-08dd1a267cf4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:57:56.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym669mySxWsqdPziA77iKhfxbUrt+JOGu65kxPpZCEdSBeK9tWbusEkX9QuD8KcMBGfe+pJ/0CFl2cq6bIIKQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v10 to v12
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

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
 drivers/pci/endpoint/Makefile     |   2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 148 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |  15 ++++
 include/linux/pci-epf.h           |  16 +++++
 4 files changed, 180 insertions(+), 1 deletion(-)

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
index 0000000000000..b0a91fde202f3
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epf_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->msi_index;
+}
+
+static int pci_epf_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *arg)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct msi_domain_info *msi_info;
+	struct pci_epc *epc = epf->epc;
+
+	memset(arg, 0, sizeof(*arg));
+	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
+					      (epf->func_no << 8) | epf->vfunc_no);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the device
+	 * domain, but vector allocation happens one by one.
+	 */
+	msi_info = msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec = msi_info->hwsize;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, arg);
+}
+
+static const struct msi_domain_template pci_epf_msi_template = {
+	.chip = {
+		.name			= "EP-MSI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_write_msi_msg	= pci_epf_write_msi_msg,
+		/* The rest is filled in by the MSI parent */
+	},
+
+	.ops = {
+		.msi_prepare		= pci_epf_msi_prepare,
+		.set_desc		= pci_epf_msi_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_DEVICE_MSI,
+	},
+};
+
+static int pci_epf_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &pci_epf_msi_template, nvec, NULL, NULL))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = (epf->func_no << 8) | epf->vfunc_no;
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epf_device_msi_init_and_alloc_irqs(dev, num_db);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	msi_domain_free_irqs_all(&epf->dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(&epf->dev, MSI_DEFAULT_DOMAIN);
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


