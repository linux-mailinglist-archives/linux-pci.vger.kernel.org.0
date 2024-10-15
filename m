Return-Path: <linux-pci+bounces-14591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B199FAEC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956731C20365
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC691B0F26;
	Tue, 15 Oct 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mpJBU+xV"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7E1B0F25;
	Tue, 15 Oct 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030084; cv=fail; b=IbUoMNTtBndq0Z8RPKohvRjZBMK34q0+di4xXBwZkBe8qL16tJL0HcXwFhtWjwJ1L7/9hlXos3g2wjwh/EFLBXUJ8N8L0O6wn4ADL1YNumFXJ1/aR1Y7uSlh+KxYqkjrzAvcQl1G+Nel7FPaJ/OsMwQy7U/vQ6oIRQ7N+ycZRDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030084; c=relaxed/simple;
	bh=kWfkK5tGIegwND7N4ToQmqK7Q0IW0URS7ZZA/XfKGDQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YoyS9ZZK4xSqFCCSTDtZoXGoYctAGek1eSaYRgqZc17T/XgB8J3VucC2Sre7H1SsI82H5IpBoRWwE/U4qz8KK7i3W5/eS3xIOAAok5vnyVuqdhduOZEpHgPq9tsikGCua0oLaibZ8FBs1esaQdcxztgFO+MoBoqMiMu31HVUcdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mpJBU+xV; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEsu5yjkU1cJDzELiHq7sKO6rxo4fAehB5p2vHvf/pzfffNHeX0j964N5XMckaeA9j1afATOMvU+joD5GOxweAkTP1dCHs1GC1a/+g2JZTzsx/iFRlk1I680d/m7Uh0iq1zZ9odeDHEgWOpy9K9UxPSJidEflhMtz5/ShsawqM9P0nx+bLBvLesgAmBopSkNGA63tQ0D216m+mtNqnGoH9fkVXonv7J9+bMr3pxD09+sLo66zX2qC8kqYRyjReDEHg/NVU40mF834neCcQ63p5bnBwdaefy6suxAFSAafUyL667W2ftk00j2TBBX1bAYH476/mfVIOy1SRfsuyRLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDPHrNZObOAsbKhZx2DnQpX17gTc1G+ufjCruMErj3w=;
 b=PM2YSMInSEmKCQICuVITfI8Dshc+XUe+V64h6lq7MQF3I3IPqEmpaz5Nsg8hQqQ/d27w0DmEv+06Y7PQAg8JBxidfuK/ukL5dPKCii4PrFTw2+jsnPVeVeCpO/6ZaPZ5teQvWPkcRp2vZVeRbJEnpgkbFyTDhq9lLcujveIugXANzVqfP61+S9gtjw/tEpAaleJlEXMEaEOV36e78oVNltrkLDg6Dsf5jRgAyWwO04Vsw2K3wAvE+JW5tXjtpytXDlgEoRgG7r51GzGBNp0yw8FtP/AZhF5gd1sYOtx5zIQKT8c4mxZOvv32VQlpqhTlhfuOMgp17UFbrU2yvUVzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDPHrNZObOAsbKhZx2DnQpX17gTc1G+ufjCruMErj3w=;
 b=mpJBU+xVRpu9Xyt8JTaDWP+uFuQUof6NyDuu+e92/ME8r+oDTFFNGXEtV8E8aGuGTgsH2hoVD2Qlj/3wYh1q+GggLTXOfGj4FiTjF2Re3/L3goUiweIOdHNn4nCAzZ/zuHyWs1pd4dE3Bak2FlMzJLWvHKJH0ioxKdKK/j7dDHzKxTDnLlxRabN3PEx4jDt65wo9v1lOVZ7S4geBm23Fp4RO6tbH3YAnd2PMshUnbb/JqeMFYq7kGYFJF+u8qFkC1PWPJUqyNYtqbRQNzHPEZ2JxzBx3eXzlMw+/+o0Ht2qJ7BN4oPopatyyncg20vyKU1Uewgb5xFFDEhVOpjSxNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:07:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:07:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/6] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Tue, 15 Oct 2024 18:07:13 -0400
Message-Id: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJHnDmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3dQC3dziTF2LJJPkxCRj4yTDpFQloOKCotS0zAqwQdGxtbUAsn9
 wilgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=5417;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kWfkK5tGIegwND7N4ToQmqK7Q0IW0URS7ZZA/XfKGDQ=;
 b=8VWmKaUolR/qj/7a7+4DScqQ/BbjQpgxV9yUjujE96e9xXgeNLQtsigb07VZTDyN2Yk7doCJ1
 nf/ZWPh/keRB3sMDMvRMXAqeeXqIYILuFb4PRTC1eyYTfRR/98ZAfXm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: fc96b135-8c48-4952-5be2-08dced65d351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnB4QjhneldVSXkzbHZ5OTc5bGkwWVpwTUNFaGF2WUFtcU1UWVlCZlhGZFN2?=
 =?utf-8?B?MkFXdW53ck9PVUJtM2k3MDNCWGhQQXRaRVZDRFJvZllpaWFaakhTZ2ltMHho?=
 =?utf-8?B?bHM1UW9SbjBqU28xWHBvTDlCRFpLc1lMRkhydXlSb3VEblpTSzAxTXFjMFUz?=
 =?utf-8?B?QkZPNk84WGJ0UGZuQXBMNnZtL3doRmpUK3BDdTF0YWx0b3NYRWo4d0dwOE1i?=
 =?utf-8?B?TmFmdlRrQlNTTy9YeUhmL3c2eGpPeWt5Y0VodVcrVWFacHRGcHhKRTZNNXRU?=
 =?utf-8?B?aWplQW4rU3pkeUwxVzJXang0bXdMWmdJTlFUSjZUM1BHZFhmUTcrcXpweFY0?=
 =?utf-8?B?aXJiYjdGQkl3Q1I5UWZaZHA4Sk5RZ2ZrUmkwamUxZEdJYlpzb21QVEw2bVRC?=
 =?utf-8?B?NHlKNXBUZ3hING41QzhaUDdMbWtkelB2UnBOU2VCMjJ4TEYvQzVGNDRTK21K?=
 =?utf-8?B?NXB1WlpDRWdqNGN1b2h1aVErVWgzUXJxUkxnYVhNdXkyLzh6b0UxTEJ1NWt1?=
 =?utf-8?B?ZEFpd1NSNER6Y1JsdHNZVEIrZGhaK1dIOUtXRFZrWGVkMGlib0llYklZUWRz?=
 =?utf-8?B?MEhITUkxb05mMW1ZN2ZWU2QvRkxzM01wYkMwMXhka0dPK3prYVlsb1Zqdngx?=
 =?utf-8?B?ZUwxNSsyM0dGaGVtaC81YmJVREkzSnZjQXFRZXpNdmlIQVcyTjhMamZ6Nk9a?=
 =?utf-8?B?UTRmTTF0aFhSQStyRm5kdlZrdWJyaUU4cEVUcmo5VHpwOXhUajU4S05zWUNN?=
 =?utf-8?B?UHB4Rld1ZEZ0b3Q4UTAzSlkzdjZsZDJKWCtjWEw0SGVXSjlhNUdFcGRkRktQ?=
 =?utf-8?B?UE15M3RteTVrZDZ5K0hQd1YwNXhGU2FpeWlzWitaMGVjeHNlcm10eXZxbllO?=
 =?utf-8?B?amZKUVl4SHlQR3ZLZmZqQUc5TEV1cHE2Ym0wbU9ieTU2Vmx4ME00Zjkvd2Vh?=
 =?utf-8?B?RWRLdmJuQklzMVNOT1N4bGVzMm5NV1ZjVVVNUml0ZFUxRFlSYXptcUZ4UXVp?=
 =?utf-8?B?S1hud1JMOEhyekY4MG1na0kwR1ZzYVdKYWlFNEJKWkxnb3dGdmk3T0lVRDNN?=
 =?utf-8?B?UUpGSW1KeUpqM1lrQzI2TTRZUjBiQnpHZzlJa0JDY0R6aUJyZWQ1RzY0bURP?=
 =?utf-8?B?ZDFSSDJQNUFSb0ZOZEZtZ1JiSlJad2VBWW1hQzlTS0RNa1V0Q2NNai9BdEtR?=
 =?utf-8?B?dUpWMUhnYmpacGV1QWpqWk9hVWw5VWJjT05tVU5xbVpIcE1kVnRaYm9xMkZS?=
 =?utf-8?B?VHQybXhsUEROYVI3NTZjNEZBaVJHczFvSGxCT045RWtaOVFUTzlJTlpoUG02?=
 =?utf-8?B?ZHlOekY0T3c1VHp4OTZBajBSR0hxeFFyZndxUDhjR3M3TGZlSTBXSnQzNFF6?=
 =?utf-8?B?RzZ2UnRtcVBqWDArQnk1cE1BMm54REhoSysrSjY5UlZiWlFLV3AxU2dYWXQw?=
 =?utf-8?B?Q2VJZGpMUXBmRWpkS01RdWpUU29ISGQwaHBGTnJEUmxxcnFEcXkwYTN0UjZ4?=
 =?utf-8?B?S2JzL1diOWdwOUpoOE5MWjdyYmNJZnowVFp0MWZ3Z1hEY1lFcURWWUZMNEpB?=
 =?utf-8?B?Z0RVSzg4K0Fic3UxTnQrS1lOK1gwdnpZY1Z4WDl3NzZkWDAzcm9GUzJQRHR0?=
 =?utf-8?B?ZUtIbWNRMTNqYVdjWndiM1JGY2dURkg2eXZiMWxwVFh6SDduNmJNMW9SZXlX?=
 =?utf-8?B?SHU2LzJHQmNSUkFJT0NabkZiTlFaWUt6ck5qSWVLbWdJZGdkN3lveVlYVEww?=
 =?utf-8?B?ZGJ4aXJscWpjS0RvdDUrR0hKZHh3blZGaVlKTU9nbXovd0pqelAwemJtUGhu?=
 =?utf-8?B?VVlBdW9TcytuVHZ6WjZWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1pWcDJaU3FzSVJUMFFlc1ZycjVpaXRNdlB0cFFNUm1LblhrdC9OcWlTMW5n?=
 =?utf-8?B?M0h2QzIzZ0lwQUdEaDZ3cU9Pdk5iMElXZGVZVUN0RzY2M3k3eEh6MEtONTFF?=
 =?utf-8?B?MFM4WnBuUVdCSGRuVHgvSktmUFFZWmdUd2o2ZWtQWWtPdDIyMGFVUDV6dU5y?=
 =?utf-8?B?NllkcElIMEZPRThoKzdROUx4cHRjZTQwYkYzWE9BTk52OXpuSWY2N3dxeFdx?=
 =?utf-8?B?V0JNUDZMZkMzMWYyaDZiaGk1SWgyeG5LcjJKenJZaFVWN282UzdOMjhKZDRP?=
 =?utf-8?B?cVRKRGVNdHlnTlVmUFFHSml5eFNHeTU4czNKQnhkTEJkWTJGeWd4d0w1aW1V?=
 =?utf-8?B?dnM2Rk02UFBqblBJNEFpcitqMEF1WVpuMFIwY0t4eXhDbUh4ZG5KbHpKaU1M?=
 =?utf-8?B?ekhRMUxpRktKS09ReUs2V2tnaGtnTnlSUktqVHRmdlRremFaYXBOTytEYmNH?=
 =?utf-8?B?aVhhT2kwYzBmUHNSdXVScGRPWndjQ1JlN2tZMmQ3dnZFeHBjUEdvUnpXZ0lv?=
 =?utf-8?B?N3BJZUpQRzZIaFVvdVI3eStvdnR3a0dqZURpcnNjQ2hYdkIvR3ZRNFJyV2xt?=
 =?utf-8?B?aStGUUpvUVRQTE9lbE5Kd1Bjd3lKandZQnd0M0NXVnJWZ3huZHZVaUp2cHJ5?=
 =?utf-8?B?cS9yVjBnRkcydFdQcXNPOUFLckhHNnQzbHVkUmQ3a3lUOGlmOW9UMDJqNE54?=
 =?utf-8?B?QUdGbHM1cnlzdlNGU3lTZzFLaktCK0x2WXlsbktCcnUrODNRUkZ5NklkaUht?=
 =?utf-8?B?d0szV1ZCRG1CcFlFakd2SnFYcjU5RTJuWkptV2h6UWtVanJlS1NHMW1KUjBu?=
 =?utf-8?B?RXdQU1phS3J4V1E1VUFLUWFpRlQxQnd2ZlpIdXlRKzF5UngvVXZldDZuVlVJ?=
 =?utf-8?B?Y2Z4U3ZIMWxtVEVReVl3Y0pjb21wOWd6aEhabU52dFI1cG5oc2VSaS9kRExr?=
 =?utf-8?B?c2ZXLzZqbnJtR3pLY2haNlh2aDNqVUZJelNSZFVaTXU2ZjFXbVJQdUpqSjJP?=
 =?utf-8?B?amxvWGo3WElwa25lVkNFS2VqOUlTNHdqSHJMRGg5V0t5R0loNERBTDM4Qi9x?=
 =?utf-8?B?WEtNSEtWbUZ4UFdKTHVtNDJtbVVncTJuOW9GQUxvcjFZSG5IakttTy9oSWc0?=
 =?utf-8?B?bmw2VWFNTXRXcEJEQUZyMU96WmdxNGlwTmFzR3dSbDhoc01sMDBMZHFqMkx6?=
 =?utf-8?B?VDNhOVhsRzJMMWg0UlpEbEliaGt0U2VMK296aUluQThoZEc1eWtwSEFoM0JH?=
 =?utf-8?B?aXlIbUYxdXdUVS9FMk93bjlaU29KampnT1JYQWpTMlEranNtVldlRHZXZEF5?=
 =?utf-8?B?bk9paTY3bC9jS0hNWHBHdks3N1cxOEF0bDRCNFZXWnorN3ZET3o3aUFvYUNu?=
 =?utf-8?B?b0ppOThjSFg5VnJuVjlWaVhoQjN3V2V0Z2NpMkdmWktRdXY5UW9Sb0JpejAv?=
 =?utf-8?B?aC9BQ0xESGxzZmZMTTFHbVAvazlDVHRqdnpQZXRGWFVsTkdYVFJDTk5IR2xU?=
 =?utf-8?B?NE83MkphSG51dTAyYlptdGkvTDI3NlhIVUVFN244cVNQeTBTd3NGM0I0cGEy?=
 =?utf-8?B?cU5paDZBbGpZV05ybFcvTXlxRGFTYTNMM2dVSDlBZUJYR1FMNzY0K1FLMzBK?=
 =?utf-8?B?VzdIek5ibXhzNVpyNnFyMytKaWtrY2J5MzBTNnEySzRlWGpRK1VKclV6L2xa?=
 =?utf-8?B?WjllK0tTYUxMTTRIVS8zWis1eDUzTmd6MzhNMmsxdnVhYzRRWjVtbFhZNjFT?=
 =?utf-8?B?UysrYVcvNmMydmFLVy9lckkzMlRNTUhWZUM5a1puOWdQaWRwT2hKdmNWR21t?=
 =?utf-8?B?OTJ6akFEbU4wcG1pVGFLMmpQSXQxWG1kZXNVUHV1dGpiNjV3ZlhmVjEvcys2?=
 =?utf-8?B?TGc1Q1FyVzBYNTROd1BtbG9pQzhhTGczU0F2TXo1WVV2Ni81YWc2d2xNKy9X?=
 =?utf-8?B?Sm54a1RBeVk2bnBSeUJja0tNeUo2SkxTdU15bDFTeTRTWitFYUtGRHB0a1Ft?=
 =?utf-8?B?dlNMQ1NIVy95NEltNTF5Ujk3MGlrWUF6YVFKc1ZhTnZpTHZPeVFaTWNHVW10?=
 =?utf-8?B?TzJES2R3SVpyZlBGTGlCTytZWHpkT3hZNXNEZ2YvaWdHZmF3c1hXZFJ1UUpC?=
 =?utf-8?Q?ydUE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc96b135-8c48-4952-5be2-08dced65d351
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:07:57.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIFH08wfMFilvz2m/43gAGlnebh5V2DT+guN9WtVIdYDKxlBmI3X6KnExoQsjD3YNsMLuUXuWj6b99Xsuf6cZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: tglx@linutronix.de
Cc: jdmason@kudzu.us

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
      PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  60 ++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  58 ++++++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 162 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  23 +++-
 include/linux/msi.h                           |   2 +
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   6 +
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 ++-
 11 files changed, 341 insertions(+), 6 deletions(-)
---
base-commit: f231847d7f5a171be4566099f654521606b3ec37
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


