Return-Path: <linux-pci+bounces-17715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D99E48EE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5844A1881F1C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53F207E09;
	Wed,  4 Dec 2024 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QxiQFOiI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED66207DFC;
	Wed,  4 Dec 2024 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354783; cv=fail; b=bM0meADPKnCyj8++9/v5osgxPbcb0es7lUfjwDg7uHwCCTQnkGEFHpQeHa7NpLYTFxjnWoxabBGT3FZ3vShZHq7/V0U8mjlf7d9mxexKf/a2JnRMpsgl1nWDQSSzAY+qOlUWs6oAYmlw2OtQ2Y5hv+Xq3ZJhADCxyXXhY4ZN4Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354783; c=relaxed/simple;
	bh=bOnKJZrkUUU428ZrIY6JI2kqclwWQpvDcbMTaShv/YY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZWGFiBCiHZXUb58ucJ+5t1lM1IY2F/roqM23y88KnilSn/yBXHS940rJVhZkg2/NGDuGjOnJB7O8wt7XR5KVIbQdpL3+iW2hGl4w95hiZ79PkJ+knz0vkNulVIxiV3//N6g+l6Sov0BXXIyWfIgzlpIVAVbrio8I0SSeJ3CEv0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QxiQFOiI; arc=fail smtp.client-ip=40.107.249.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQe0nRONEWIzAIgv5XvjBDAj0KTjpXrNF2vWvB7e8xySIBxAVDPpdla9ArSKlMA9e7Ikm17tvQjzFZ7fKS7g8abD0OzFyXqlqLeljrDjSmD0yGNF2vdvfCK0V5Fbx2AIR18UkVHaPlgAxZjbVShsIA3u2IItdV+krdnMc4YEJkGLB4onjWUNYvkamn8cwmilTmLQEIkUdoIw+XBJUUUbF+Cv4ze8Dtzk+/T+6b0Ri20Nb7Eki8dqV7JaEHsWpmJScTyFWLW7+n2eN3rKRySsMOr2of8+cgmoQpYdNTdcim9236zDsBGUNSxBuuqkgj8o+Mq438bMKeNGR0V3gKPQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VObnkt52+Sp5O6OTBzUHoDM9oJ+vw4Ys5pTC/DpQbkA=;
 b=uF508p3oPcY/GxStT/qyYkv68PmalhxqeRFQ8GA3mMSVsxIvWceiZGDG9YlGz+Ev9NIeogxYcQu6PdsPueaaWpP0dA3kUnCqRjSqmRaIewatPLlbriginMctnR2YDKmu9xhM+f+wKyA5k6C3/PoesMO3ytsk1VGDKO0ku+GbC9VvNnKg7CKgXZFsBFI0m5takaQ0pPj5LxW2cfQEAy6UbuEXYf/POE7TuQB1O53/RZX6oorF875dfebnlD7S6NoMeI5CipE7QL2QqnYwtgqMxnKIMdQEVLUjVitPl5ZXTP+pKXZTBxwvDPSfRyxZnaBnx/FX1EXJO4IkhvfmfpLDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VObnkt52+Sp5O6OTBzUHoDM9oJ+vw4Ys5pTC/DpQbkA=;
 b=QxiQFOiIV2KGTBPLlHtuOkPARw8+KXePaaP8rB/Jp0WX1h/smPC12AW2ZMkYrNfBss2o2nAf3+0F4dj0P9/tJk1bLs16++yuP3L8PP1dYFzwyto1G0JWdBZOv9axAa/uYu7Ro2VqXd80znSigQugpIDblYhwMEBGl534K+BEY+fyNffV9cCoMcuu2o5MvXbGEPRE+zI5gDzH4GbFd4KjSVVDQPi8oRoDIc7yooMObCaUOkByJrJQbR4aadyv4mmfuwoUjgs6Is88TrTxQI4/VMps0O8b+1VvPNAzHIACPahw9NH64AfmVPv3lmEmNNSiaA4prJ9U1IuzmjizGxXoRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Dec 2024 18:25:51 -0500
Subject: [PATCH v10 1/7] irqchip/gic-v3-its: Avoid overwriting msi_prepare
 callback if provided by msi_domain_info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-ep-msi-v10-1-87c378dbcd6d@nxp.com>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
In-Reply-To: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354769; l=2525;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bOnKJZrkUUU428ZrIY6JI2kqclwWQpvDcbMTaShv/YY=;
 b=sxv1ddiKpyNSlAyqKvqP+PQii9fk3h6ddZjoMp6m972272j6cOx22QyRwKH7UbApkljhyJszq
 PZ70sWwhCCvBIMXa9g58D65MoC/bxsgqj7RWL5BqTw8vVBSvrxkoT5S
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11006:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b0d95d-965a-4108-449e-08dd14bb0e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWIvV1VMYVJUNzRmZ0tDQVh1NFk4ZkNFVVgxdnV6T2h2R0xybmV2aVVpUThi?=
 =?utf-8?B?SlNwdTBSVXdITWxsbS9ZaUIyVUlOYkxmKzZOOC9OdUpMQlE3alhzNlVBVlRX?=
 =?utf-8?B?UHE0NmZNRFZDa2ltN3pSOUNOcW9Wc1IvWldJMW9TZDBUNFdaK3R3YW1kU0hk?=
 =?utf-8?B?QkZWNjNyVzBjRm02by85cVdpdlJmaHB0cThPbytQVnhzei9YUC9LSmRxWnVa?=
 =?utf-8?B?dHZVTjVvTEp4YXI4aGpDUU9NT3lqR0RyNS90WERMMnRyWVRTNGtsYkVFKzlU?=
 =?utf-8?B?RUtnQ1VzQlllM25mSjdhTmtFMURWMGJxejZzc01iNWtidFhoeHN6dVlQK2pN?=
 =?utf-8?B?OWZUNytNOVVuMWQ0OEx2Zm5OWWVRc2dOVUp2dCt5M1RQSXNGd1p4ZFRqL3A1?=
 =?utf-8?B?NGl0YlZiZDdwZnl1TEZUVlduWjJpTk9DTzhyMEZqU0RnVEUzbklTN0xFczFo?=
 =?utf-8?B?RGtzTXJielJFZEJZdS9uU1BSNnl4RzRwbDBKUm9mbDVsQ3Z4Q01vNmF1U3dU?=
 =?utf-8?B?czI4UkQzcXV1SmlDb25jU1ZHQzBvejdPVlljZTYyZktVd09YUThTS05SOTFW?=
 =?utf-8?B?M1NFQldRaDZzUDdWVXhRbDRtMXRmVFhWOXgrVjRQVFJEZFpJWFVHN3ZCVm41?=
 =?utf-8?B?NUZQWFpHTW91czIwUW9LZnZYbXBOKzRYTFkyVEZ1aGNPSkc3blc3TmNBWGM4?=
 =?utf-8?B?MVhpa2kyT29vNHpxajVYY05RaWNpOEJZVkRpeGpaWUUrb0x1SFhkdGd2blRH?=
 =?utf-8?B?eEgyL3djNHFlVy9EU3lLUC9IN0l4OEJPV29YdlRLSW1taElFNWJMbW1CK3U5?=
 =?utf-8?B?NzIrVTZTbTJsQWI2azJOanpENDZqSXIyT1J3TysrVjAvd1ZlS25kbEFzSlA1?=
 =?utf-8?B?ZUlDY0VpNWdweFBnRDhDTWhza0JJNmFJajhYTHhQeU05VXlZUXM0YzhtYlA3?=
 =?utf-8?B?eXZ3NWsvaGs4ZVZhVVAzR0l1dklpM3ZuYWJBbXpOTzdWSEtMZ25TMDNPckRz?=
 =?utf-8?B?ZnZwYWt3MVlhbmV0TkoyZ0NaMmpicUVJRVd4WHpJK1g0TWgvblFwUzh6T3I2?=
 =?utf-8?B?UDMwaTZOcEQ1RUlLcDBReVQvZC9lV2lWdzkxeFMwa2VOa2hTSHdIQ2lFcDdk?=
 =?utf-8?B?Vmo3YnNrdjZyQ3ZxanpFTWZjcHYyRzBIOWw4Y0F1MnZSOHlQQWF6amo0ZHFk?=
 =?utf-8?B?Y2ViVlJoQTMxN1RndytoZDMrMGo5ZFpMZ3JnUFI5VmdoOThCcE5IUDFqb0Nh?=
 =?utf-8?B?QjJXZjhMOVRlTnBaemJ0VDVtRTYrOUdncExXRmtyV3g1cUM5YVFQOTY3RW9X?=
 =?utf-8?B?cUZxbHltOG5NeDJ2V1E1WEc5Q2FxODlWaFYwMVlGQlBOUmwzdHp3d2ZLalVT?=
 =?utf-8?B?UDFLMW56REFHaWZSbjk0T1VxR2lETzFkallXcVlhMlVqcEEzc2V2Nzd0QlM1?=
 =?utf-8?B?MWVjQnFZcUU5eVkvU1MxNmZQK0Rvd1czS3hZcXFZTG85bU11VFQ2dTVYOHdT?=
 =?utf-8?B?KzVTUVJFejllSTNyK3VWNDdXMlRUTUQvQmRuWXdOMTdPcGV1ZGdxSGNFaElp?=
 =?utf-8?B?djNMSWczenBRdnBLbVY0ZFNTRTVDUzd4QVUrWGhocCt4WHFyY2E3TkhaOGxn?=
 =?utf-8?B?U3lVYk5CS2dlSFE0SGtMblduM2p6aWplVTF4ZlczbjdFWUs5cFI2MjNXR0Jl?=
 =?utf-8?B?dHpoNzA3N0pmUjBFcjlKNlY1eXdORWlqalRtemNLaTI2QjUzQThiRzFTTzdk?=
 =?utf-8?B?c1NVMFUvelF0dVkreVNKSVh4L0cwd2ViejhuRVRVQVpJcjFHYSttR1BNN0tk?=
 =?utf-8?B?c201UkZSRGJ4K2xleUJPdXJ5WW1ZK1JUT1c4ZnhPYkhsWGJ4NU9KM09pRjJO?=
 =?utf-8?B?SXFrSmsrWTJCelk1YWdsNEpDNllOVlFiVit5MWY3WjY1YkdTdXErWFVlQndO?=
 =?utf-8?Q?vLg0DMVc6zA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHM5eWtSR081UExxSG4rbFlzcitNTHJOMHY5TUduZ3BFTTdYeFd4SkZseW5v?=
 =?utf-8?B?RVJCUkxJQUZQUGdBRG0xOFFwbnBPb1FkRG0vRDh5RmZQYmZETlhZbHdwdTJi?=
 =?utf-8?B?Y3dzU3J5MjNlU05VaEpaaTNIQTdOek95d0hyVkVZWnlkYXN0T2JWUWRhOFBv?=
 =?utf-8?B?K1NFTkErWnZwRE0vWUJ6TEltQ0gyNVYzQVkxMElCcTF0ei9hVU9IWmVCaHZC?=
 =?utf-8?B?aGpLYy9kSGloVGZQa0FDc3RnWFNHWWZDQXhRWXIweFVwbFE4MEtmVloxTnVW?=
 =?utf-8?B?dUIvQzFEQ0h3N283TlByQnd2SlVYcGI0R2R4VTFaZ3JWc25jeEtCVCtaSW1q?=
 =?utf-8?B?dWJMT3gyejNEN3hHQ0R2QXJBb05aNEZ1dlBYU1RzOTY5T2pvZUpQbXRWV3Fw?=
 =?utf-8?B?TThXRlF4TnVVbGd5MzB6bVZlR3FReUxrOWxEOURmRDQvUHdnT1lCbkhVa2hX?=
 =?utf-8?B?ZFlHQ1B6aElBSHZFNktaUmpUQTgyeldVbCtmTGQ0dGxvV0tXWlZ6aXozbHd2?=
 =?utf-8?B?a0ZyRnVkcjl2ZXJQREI0U0V1b1RKb1BIUVlVRk5sSXp2SHNCeWE1dmFZeWxj?=
 =?utf-8?B?RlEyS3Z5d2xVdzBTWUFwVGQ4UWF2Sndqdm9zWkdVV0tmcC90cEMvV0JoN1M0?=
 =?utf-8?B?SDdjVkpJUHZySWs3VTZKNitxWno2Y3RzYlFFeVRUanJFL0RHOFBsc20wdlRq?=
 =?utf-8?B?Ymd5Tk5Bc3FzUzZ0eTQvNkNLUVVRZW1RQk5oVlBIQ3B1N2JmaU8wNm9vYkhO?=
 =?utf-8?B?TzdjMEtNSjBFM2drL09qQ1RJdkNJZXNSdU1XMUFzc1p0UGN3R29SZjdmWTZy?=
 =?utf-8?B?QjB3QUpDcDB4ZGxldG5Rckc3Nk1WVjlLa3czUVQ0OEQrVkNiSk5uck9xd1FX?=
 =?utf-8?B?Zys2TUNRWURINlh1VkZwdVVjeXBncFJZU3l2UnRPLzdIaUdrVkw1UnBKWDhL?=
 =?utf-8?B?c0w1VlZHY0JMRFZPanZmbWtrc25ray9ob2R4UXpmaXNmQklvcGZLODU3MUFJ?=
 =?utf-8?B?NXBCMUZzOW9UZ1BNN2FCUjJOLy9rMjhGT29iL0YrcTg5WmJDcktBWmR5bW9M?=
 =?utf-8?B?c2czMjNXaUxzR24wM1RKbUpYMkZJdW9kUzlyQ0lWdTZOMTNETUIrMHNpQy9E?=
 =?utf-8?B?QWJOMWlBOVg0K3BIU2lsUFJnNEkvZlhweGZGNzh0eVd2WHpaZUJkR3V0Tk5T?=
 =?utf-8?B?SUdDNVNCbnByQzlSSDBGSTJBc2JRK2k0ZnBoNVFDbGY1dkpUREE0c21JeHJ6?=
 =?utf-8?B?bU1KZVJQeStGdzgwSFFjOU5IS05zSEhhcE5MQi9Ha3JTTDNGUnJRQVRlK3d1?=
 =?utf-8?B?VjRTOGw5WU9GQUhrYllNMFdQczJGdHJ5VkduU2dEdGRUelg4Qnc5VGJKSU5P?=
 =?utf-8?B?dzZZTVVzUkI4TjBzOXQxaXJpczd4dEJwVDdIYkJOcUxtNmJyb05Nd2l1aDA2?=
 =?utf-8?B?dWdoNzMrbU1UNVI3ckFSQm5tbHN2K2Mrand2SjA1eERnQmlROHRMcEhlUUpq?=
 =?utf-8?B?Y0lXd2dueGJUM2xhZzIzcjJqQW1VY3B6cWZnMnd2UkhQUW10UTFNWk1qZ0tV?=
 =?utf-8?B?blIxakFFa2ZyWjJJU3FZRHJZUWF1YUp4SVRxUTdGMGNVMzFZZWtsT01kS2ZI?=
 =?utf-8?B?Vy92MHpBQWtWcm5JaGozKzFJUDdieFVLb3UwL3NtRVFkd2RrTHg3ZlpYQzJD?=
 =?utf-8?B?R05lUUVRd1J2Y05YR2hKaHhLYUZLand2cmhONStuQ0E2SEVuTkYxTVp6ckQr?=
 =?utf-8?B?UDdNK3pqdUNwdVBuaEJpZmtvTmRUZ3lGMnNOa29kWWNPaUFiV3NkekplOTBO?=
 =?utf-8?B?K2pGby9vc3QzZzE2Z2JqMlgrOFZqS0ZHWDBJd0RDNTY3SXRydFIxem9jYjdM?=
 =?utf-8?B?d2pWT3dYNVR3ZlBQcndIdlc0aEZqZnIrNHF1TFhybUlzQkZHQkRUcS9oWW9z?=
 =?utf-8?B?QXFmbHF6dDZUaU9kMytWUTl0Rkd6WFZiS2FJSU0vWWR2VC84U2xYZlVILy9L?=
 =?utf-8?B?S2pwSEFtdWU0VzNKcXFlc0dHNkIxd285WE1Uby9VWldmd2xSaGpjdG4yOXF6?=
 =?utf-8?B?SmUrNFVzUFVYZWxtWld6WktOQ0JvVzVmd21senJlck5DdmVjMzBhcmh4U0dl?=
 =?utf-8?Q?efG4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b0d95d-965a-4108-449e-08dd14bb0e22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:18.5848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfPBQq3grVG8dwv8SJGmheqclfGH+Cx2ChrYvWLspLwDX4yLluS3I32v4hFdM8f+nXPo3+pzyIAioTfxeRIFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

  ┌───────────────────────────────┐    ┌───────┐
  │                               │    │       │
  │ PCI Endpoint Controller (1)   ├───►│ ITS   │
  │                               │    │       │
  └───────────────────────────────┘    └───────┘
      ▲        ▲
      │        │
  ┌───┴──┐  ┌──┴───┐
  │      │  │      │
  │Func1 │  │Func2 │
  │ (2)  │  │      │
  └──────┘  └──────┘
     ▲         ▲
     │         │
     └─────────┴─────────────── PCIe Bus

(1) is platform device, which is generally descripted by Device Tree(DT).
(2) Func1 and Func2 is created by configfs

The current platform MSI API supports only a single device. For instance,
a platform device (e.g., PCI Endpoint Controller) calls
platform_device_msi_init_and_alloc_irqs() to allocate MSI IRQs.

Child devices (e.g., function devices created by configfs) require
individual MSI domains, with the same MSI parent domain as the parent
device. These individual domains need specialized msi_prepare callbacks to
set  msi_alloc_info_t. However, the current ITS implementation overwrites
the msi_prepare callback with its_pmsi_prepare().

Modify the implementation to assign its_pmsi_prepare() only if
msi_domain_info::msi_prepare is NULL, allowing customized callbacks where
needed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v10
- new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 75aa0d4bd1346..33e94cfc4d506 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -195,7 +195,8 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 * FIXME: See the above PCI prepare comment. The domain
 		 * size is also known at domain creation time.
 		 */
-		info->ops->msi_prepare = its_pmsi_prepare;
+		if (!info->ops->msi_prepare)
+			info->ops->msi_prepare = its_pmsi_prepare;
 		break;
 	default:
 		/* Confused. How did the lib return true? */

-- 
2.34.1


