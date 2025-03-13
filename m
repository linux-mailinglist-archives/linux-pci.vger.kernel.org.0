Return-Path: <linux-pci+bounces-23654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F12A5FA30
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB75E19C3BC6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4D282FA;
	Thu, 13 Mar 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eg9LDaO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2C269839;
	Thu, 13 Mar 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880353; cv=fail; b=PT27ZmzVSGIerN4V/qHjUHZGdbaQJJpc8Zx552vD2jlg22UGgNrnZm0zLomQy6YpU3CdGQ+D6LKtLtO0vx4LZAF3W+NFrnKAMsGVBB2YI9PBOh5cbQO79vBQPHnzh6rtWc0uzLg232rBCSVprQlXzcC5CKUaTedfWIAmu3eh+Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880353; c=relaxed/simple;
	bh=L0tHE6Uv7Ntor/hSxmh5b5ZqhUngTfokw6PJp+gdRVM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j89p3J8tXg+W9cXhgufnbq4GsfiqyY6jHuty8MQFOoV68Rx5sVgC+L/21TJaRsx6GkwOUiAq4Jf/E/jWTe2Zt/CzqHl7ZOm4LpDmiK06LTIAbvKTc3VciDS2813OhgFOchSsmyH8fyQGDBTlrkKaZ4MRE0ARzxrULqrAPRftF4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eg9LDaO8; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbKQjQ7fRxMqNiPH3h9zpdyD/Z3YwuuyL2d4gDYZiHZaDBV5IkhJUGlcRAEcc30H3lYD2fbgxB3OaPivJJSZ6YnuwK8q0aDW+H4DZXN+7n+EO/wWcUcDSXn/0YtAww1kaUackUwRoFuMmcjcR5t9OmGEWcmaB2K/DW5XTXMYTTT4RDtGTtAdpAUxuWmxbsqhVIN4pFv24BJVU0R2kgZi/A16aafe3nGRWWU14wkssfXsVWb94MPgQq0S7fXfADKOMDoz1VLWRiAYv6DbzNVtmswXr7JIevqeO2zYegmQGFO9WYPGBtK+IG++AlQkx6C9Inq4gNFca0SWGjMK8m5Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ONGAFiozC9KlAWHis1y3vg6b89w9u0ST/SSVfxNNR4=;
 b=rH0C63nb5oV9TnMC1KGrOamYpZn31/tNhuHCkH0Z91mv2uKccIB4Fepjds2uBgD1/4l+52lNaMSGGaG4NYmF5438yjnc/D28D03rBE4SXbB8oI7VaycsNZYJlGvr5+UK/N98o1Jpc15MI36pen0NLTlVuJq8Jn6Vkz731uEzb+eL1ezEN7cIh0dWHedYRZXjiGrFUaq4qA05YwIyiJRfM4S50N9CQvEpArmeT2x05T2ThaoYhzRqn+u1vyKgufXNm8C+pLOLyEAmr1gIDkfpY0L0BGWWExa9EPVXQkUCfE6Jt2z+B/CtAP8scYXv18wcoNdoRcf7H7zh8IRHzjfJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ONGAFiozC9KlAWHis1y3vg6b89w9u0ST/SSVfxNNR4=;
 b=Eg9LDaO81mvSlyNyqI8res4aUB10cLicwcdV93ZSaQUmuMSDR6v9G6lRdDu0heXCiFbT+EluuGD9i/cPZgnzPcfDYXDm0xNVEVCG0EzpE3PHh6Y9gENPSmCdhf3E3x3gOR7JysyxAQPb6lh5mroiJXZrESrF/U+wPwIoci0xbjDCDYUs5/+EB25qbVgswaRUXkza6ggPCPxtXvN2kcOTSGwaAspeezJaKHPb3+3A275i6UxHISQAai+CGoqtlEMMHbHOL2ADNmElz0KeugYtBfEN4wMceTnphIM552rAo0HmHXKmWAIQRqXr2E9fdcm8oJz5Q7ZEZiyE7JWD47Bi9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:38 -0400
Subject: [PATCH v11 02/11] PCI: dwc: Rename cpu_addr to parent_bus_addr for
 ATU configuration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-2-01d2313502ab@nxp.com>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
In-Reply-To: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
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
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=9728;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=L0tHE6Uv7Ntor/hSxmh5b5ZqhUngTfokw6PJp+gdRVM=;
 b=uOedPlWlXN3hFasb1tnf8Auz1/8lTTjkq3xjyk11oUCVev5Wdo0cGK7qOp0odEKl/ravh82pm
 P3v8XuOZ6wKARfU645xv0hi8cNrha1w6WN81PLzec7TzbwC5hc0IsBh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd51d36-482b-42cc-5f1e-08dd6245304a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkdpSmtHNUE1QUVYNmhHU01XcklTbjdJK3d3c3dEbEd4WjF6SFp2SUtDWlps?=
 =?utf-8?B?MFdhaVNGYTBTZ0l1QXJaUnlNUlQwamV5b25CKzJHbHNvRDdiQTM2Q3JZVGho?=
 =?utf-8?B?RG9FRGIwR2tNOWZoY0FvRGVmRFJVU2tCS1JMTXgzRlc2eURrcG1QZ1d2a3BC?=
 =?utf-8?B?bnMzY0ZBOWxyQzRNUjdLZDBLa20rdjl6NFJkZmljWWdEdDBMbWVldStEcmZW?=
 =?utf-8?B?K1N6cmVhTEF0YUtUYy9OL0sxZ2phMGZKQkdENUN4emVTeEs1NG9tcWt2SDFQ?=
 =?utf-8?B?bVQvZy9ZL2pMMWo1dlNjWDl6Q2I0Yk1EME5oS0VtdW9uS0xMdTBsNVduRkRH?=
 =?utf-8?B?WXVaYmo1aDZSVnEvdWt5Y0FQTTMwWmk1K1VuTW9nKzdzRFRTTFNhOU1NeVE1?=
 =?utf-8?B?ZWlRMnFPRE1jMTNuVXUzRzBxa2lDSFpNL2JkRDZsdStZeXovMTZGS3FZOElZ?=
 =?utf-8?B?K2FKUzZ4MzNYeFRCL1NiTUowb0xHTFNSTHlmd2V5blNqcWVZYjVXcjBscEts?=
 =?utf-8?B?dWhadEh6Tzg4OVo0ZVRmL3Y0M3VCYlFJV3BPckdlVXVySlZrc3U4T0V1S3kr?=
 =?utf-8?B?elhBWUxpMTdoR3ZDNHZTayt4cHl6ZGx5UWRhdmdSQTdMREJvaVVMZnUzL0Vz?=
 =?utf-8?B?WVFrczF6YWNMRlAxelMwK0llTUZOMkJkK2dQYmFCbTFwT3A1ZUFTNVUvLzY1?=
 =?utf-8?B?d0xEajFWNWxJZndrMklrU29UVlFJOHdOS3F5QUZ1cE1NVUd3Ny9vSVJKZHVu?=
 =?utf-8?B?Tm1MUzhpK2swV3dJRWN3QmE5QVFOVzZqUGVSZFlvd25qMmJQOTh5TWdzVjI1?=
 =?utf-8?B?OUNSZnJ4WUNVV0VQQzR5MEpJblBWNERzUUt1WUE2Mk5zOWhrV083QzFTS1Q4?=
 =?utf-8?B?QUFOYTJvS3VVZ3RzSjVmZlQ0VlRjYndxaXRXQ01CNW5XZmQ3YWJwMGJ0Vi9U?=
 =?utf-8?B?NVlpY2tRTVJQT01Bc0cyRXpZL1lwK1VhZ1F3bGo3dk5URWxhL0V4S0drbnVD?=
 =?utf-8?B?ellqUjJLY0I0RUlXNFQwS0FtYU8yeHF2VkdaTTZPMkdhYy9hRSsybjVOYWdT?=
 =?utf-8?B?dWpnSnFlUFFrUVVRc0hSdmJkUTYyNWVsT010WWxPSUM2SS9CeFl5RmhvZ29D?=
 =?utf-8?B?eFJWc0RLeXh3dDJ4c3BZM1VuU1ZIL0YwRE9zby9vWDZnVzI0VnhSVm11cXB5?=
 =?utf-8?B?L3ZTZC90V2N5c1VJa0N0TVpOVnpoUjMwZmNQVXVFR3gvdVVuRi9OYS9GZ1Fl?=
 =?utf-8?B?ZzFYc09VZ1RrQndGcjk3Ni9pWXdaTGR3cWdNQzNQUjVEMWdBMkN4bnlLMHk3?=
 =?utf-8?B?OE5uYXFNMnZRWExSNUF6R3FlUkZqMVhleGh4ZzEvNmFNdkl0WEhvY1JadFNQ?=
 =?utf-8?B?OFNYZWlqZmJZci9ENVFMOGdpVEljWm5melZZaEZBOS9HdmxHd3R2RjdPYXVM?=
 =?utf-8?B?czNWazZvY1psZTAzend0NTdRK2IwWktBQmczMnRpc2NnZ0F1aENXRFJ3UXEr?=
 =?utf-8?B?WnlHWjcyaUdMTERZd1NTbzEvSW1oQ1RZVUFsTEc1NnRwbzhnSlR2c0N5OGVo?=
 =?utf-8?B?WVZpOGxPMDkwYTN3bG40NTBjc2tZZ21DRTF6MlJncnpWNHhoSDQ0V1hrcVdl?=
 =?utf-8?B?L253YVJla0dZL0VEYmhtZjZBTDZmTHE5S1hlci8xYnhsSGZaNTlCUk15THZy?=
 =?utf-8?B?bjNRbzJxRzBnUndzSEF3c29HTmZpVHV5QXE1d25wRHo0K2NibnhvM0N0OUFP?=
 =?utf-8?B?N0d5RXIzam9Yb1h0VUJHTFZTN2ZsVlJlSVBSREY3R21wa3dhbUlMMVhJbnBp?=
 =?utf-8?B?WFV1WWtRNmdnd1dhcXZwclRoYXJ6YTNxTDg2cnJpaE9EM1VQSk9sUXV6UDB3?=
 =?utf-8?B?dC9BNThXWk1QYXZvNlVhcE1XeHBkSGlIR0VHL3hHSWFFcUx0Yi94Qklocyt1?=
 =?utf-8?B?d3BVRFgyLy9yaURpanQwNjltVkFabS9BdklJSCtHMEJZMFZrdVhZd216NjU1?=
 =?utf-8?B?N3pHRlhJbFNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5laUxUMHUvWjBmUnFGS3BmNE9JdGZCejh3Y01kcmdaZDhUeUcvU1ByalU0?=
 =?utf-8?B?b3pzT2Zld3Z3cFo3UzJGNnhEY01saktuVVQyZWt5cWwxdTgxSEh4V0VEYVAv?=
 =?utf-8?B?SVFLZmE5ZEZFRHg4ZlI2VUIzbUdTM1NVVXNpb096VTRCRUdmNWxNUDZudlkw?=
 =?utf-8?B?RHFiazQ2R3Rzb0RnWXZIOXNlYlVWVUdXaDd0Zkd0WmlvRjJ4VkY2aUhVdnhO?=
 =?utf-8?B?OWlwUlV6bEM2U1U4NjF6cERRQmo0MjROc1preHp3TDNZd1A5WTF2WjI4dzI4?=
 =?utf-8?B?TEtYa0h6a2lsV0tYQVc4WmhHUmZBRkp4bDZJOS9xZ2t0VDVpWlRBenVURTNm?=
 =?utf-8?B?dXhXN0J1Z21SeVlVRzcvS0ZxWENXL202ZVhVcnB1eU9nT2g3OFJxZytoNGR5?=
 =?utf-8?B?cklTYkIxbDZJbDFBZ2ZPRXJGNzNQeS9IVjN0T1V2ci9qMjVDbjNzTXhlRHJO?=
 =?utf-8?B?eEhudGtObi92a0krYmtwUWl6YnM0VFE0Y1ZXc1d2UGtHV3IyNHJ6cTVyQjlQ?=
 =?utf-8?B?emFEb3FueDd0V0NGUU51YnBsb3hqcFRYUVZWVGsveVV1Yy9aV2I0MkNQZVhD?=
 =?utf-8?B?OWhhTlA3dmRHd0ZEZXlmbmw2bXhtQTFtNlNYYWsvMVovdDNFakkvVWFiWUtn?=
 =?utf-8?B?U3Y3aE1zSVFDME1KcFlFczFLRXV4LysxeEtyVUEyS0FLY2JQbExGYSsvbi9O?=
 =?utf-8?B?ck5iZEo4THhmVDBVZlBPQVJqcUFBL1BnZTF4cmhocWVkZ2hVdnd0Y0JLSkJM?=
 =?utf-8?B?aFFUQUhhL0J3bTd4bGkweHg0YjNjOXBmSndnNy9IZHIzOWhzSmlHOC9VMzJu?=
 =?utf-8?B?VU1MN0FjVUdYTnUybUdnc2t2UjN1SG5ud1JWZDl6bVlrSjAvdUgzZmNhWVk0?=
 =?utf-8?B?bDJHdklaWXU4L0sxVDVTTElvdkJwZlZ0Smd0WnE1UzVHMEZaclV4b1kzeGhz?=
 =?utf-8?B?MzJUd3UzUVpLWVd4SGRqY2JoOWN1a0wxazJ5UzZWWjJnTUdZZldsNVBFcFN6?=
 =?utf-8?B?Z0ZvVnpZS3RDZXMydmhLc3JLdGJrNUN2UDg0Y0R5aFcrb29ibFI5ZmtzQm04?=
 =?utf-8?B?VE1nV1Z5WVlJai9zZmN2V1JTclRQL2w4T3J4RmRRZkZBUTh1NS9hd1Vsa1VY?=
 =?utf-8?B?UFhGeFAzQnQ2WElacXBTS09VY1I3WC8xZXA4SnMyRnZYV0RYVCt1NkxoUkF4?=
 =?utf-8?B?d2dIL0VoVWwydUFoemJSTFRscGY3ZXdiTzNvQk1YL2lZQXBGQVgvaFRnT2o4?=
 =?utf-8?B?UjZVS1RPTEZ4a2VqU013Szd6UFpNM3Y4VWtTWnpINGdGT0paa250YWU5MU0v?=
 =?utf-8?B?RCt0OFlKWUIranVGQWFGbmY1eEdDOWdqdUlnVU5wY24vdFRTc1JqVWg0b0VM?=
 =?utf-8?B?YUFDeHhycWQ4a1RDRVdSY3d5aFg5T2ptcU1maXAzTjFsNTdXNmhhalNxTXVy?=
 =?utf-8?B?L211SGYzYXJBaVljdVlIbE8wYUE1UGR2d0dCQ1pWK3BpQ09SYXMyUzN6dDVP?=
 =?utf-8?B?dVh2UXlnbHU1RzRNSisveENOZURnNExOS1dNZTkvSGxhZjlXRkhXU08xdjNE?=
 =?utf-8?B?aUw4Wm1IWDkxTWh4SWUyTi9xWC9QRFNwcmZrdC9Dc0dma3JIbXYzQ1lxVnd0?=
 =?utf-8?B?ODhDM2tYNThGcVcyWG12bUpjOUlJNXZFNVhycjRUbkpjZUpmOUp6N0EyVUFy?=
 =?utf-8?B?R2g4RmlpN0I4cmwyekFWWUhBaGVRWUp4eHBxcWNOdnFuRGRxVGxMbFBkNlFi?=
 =?utf-8?B?ZERmZTNJcWN3bEZZTk5venp4aG10K0hrOVQ0ZmpNS1FabzM0TnRGUTU2OWxs?=
 =?utf-8?B?VXBySGx3M3I3eHVsNVZMWkZWa2c0TnhvWXdqZC9WbDR1bUNCZ1RkalpRbXgx?=
 =?utf-8?B?WkwwR1pLQVRwQjRBaTRBZ05FWFVOUHhEUTE1NldZeElZVnhxeXE5SUFENEZP?=
 =?utf-8?B?YkI5aXJjY3VGK1FCYUdpZGg2YTkyYkFlTFIwUTZyRnFLTUZmSUxPRk82OWw3?=
 =?utf-8?B?bFMyNHZkWU9CVlZ3Vitabm1hbzE0cWI3MUJsaDllNE5ZZDROcmJseGJWaHFU?=
 =?utf-8?B?TzJNWnk1S2t6ZHBXZkhwS0lQaGdmdVpGODBpMHIvK1FnNjFWOCtMWlFMOVZK?=
 =?utf-8?Q?JXE6tUOhYJOhokefy9ARcBa9Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd51d36-482b-42cc-5f1e-08dd6245304a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:06.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFzdyDjsJorq/UWpT5zYzohbuw6FP5KCcXNejwVU48nnGz0K+8ZEULuZDciQXeSsagKgVCmNjrMrEkogZOVTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119

Rename `cpu_addr` to `parent_bus_addr` in the DesignWare ATU configuration.
The ATU translates parent bus addresses to PCI addresses, which are often
the same as CPU addresses but can differ in systems where the bus fabric
translates addresses before passing them to the PCIe controller. This
renaming clarifies the purpose and avoids confusion.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- none

change from v9 to v10
- rename header file's cpu_addr for dw_pcie_prog_inbound_atu() and
dw_pcie_prog_ep_inbound_atu();

change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++----
 drivers/pci/controller/dwc/pcie-designware.c      | 34 +++++++++++------------
 drivers/pci/controller/dwc/pcie-designware.h      |  7 +++--
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f2..80ac2f9e88eb5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 
 static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t cpu_addr, enum pci_barno bar,
+				  dma_addr_t parent_bus_addr, enum pci_barno bar,
 				  size_t size)
 {
 	int ret;
@@ -146,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	}
 
 	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
-					  cpu_addr, bar, size);
+					  parent_bus_addr, bar, size);
 	if (ret < 0) {
 		dev_err(pci->dev, "Failed to program IB window\n");
 		return ret;
@@ -181,7 +181,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = atu->cpu_addr;
+	ep->outbound_addr[free_win] = atu->parent_bus_addr;
 
 	return 0;
 }
@@ -333,7 +333,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.parent_bus_addr = addr;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ae3fd2a5dbf85..1206b26bff3f2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -616,7 +616,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 		type = PCIE_ATU_TYPE_CFG1;
 
 	atu.type = type;
-	atu.cpu_addr = pp->cfg0_base;
+	atu.parent_bus_addr = pp->cfg0_base;
 	atu.pci_addr = busdev;
 	atu.size = pp->cfg0_size;
 
@@ -641,7 +641,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -667,7 +667,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 
 	if (pp->cfg0_io_shared) {
 		atu.type = PCIE_ATU_TYPE_IO;
-		atu.cpu_addr = pp->io_base;
+		atu.parent_bus_addr = pp->io_base;
 		atu.pci_addr = pp->io_bus_addr;
 		atu.size = pp->io_size;
 
@@ -736,7 +736,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.cpu_addr = entry->res->start;
+		atu.parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
@@ -758,7 +758,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
-			atu.cpu_addr = pp->io_base;
+			atu.parent_bus_addr = pp->io_base;
 			atu.pci_addr = pp->io_bus_addr;
 			atu.size = pp->io_size;
 
@@ -902,7 +902,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.size = resource_size(pci->pp.msg_res);
 	atu.index = pci->pp.msg_atu_index;
 
-	atu.cpu_addr = pci->pp.msg_res->start;
+	atu.parent_bus_addr = pci->pp.msg_res->start;
 
 	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072c..9d0a5f75effcc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -470,25 +470,25 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu)
 {
-	u64 cpu_addr = atu->cpu_addr;
+	u64 parent_bus_addr = atu->parent_bus_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
-		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
+		parent_bus_addr = pci->ops->cpu_addr_fixup(pci, parent_bus_addr);
 
-	limit_addr = cpu_addr + atu->size - 1;
+	limit_addr = parent_bus_addr + atu->size - 1;
 
-	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
@@ -502,7 +502,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      upper_32_bits(atu->pci_addr));
 
 	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
-	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
+	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
@@ -545,13 +545,13 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
 }
 
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size)
+			     u64 parent_bus_addr, u64 pci_addr, u64 size)
 {
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
 		return -EINVAL;
 	}
@@ -568,9 +568,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 				      upper_32_bits(limit_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	val = type;
 	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
@@ -597,18 +597,18 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 }
 
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size)
+				int type, u64 parent_bus_addr, u8 bar, size_t size)
 {
 	u32 retries, val;
 
-	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(cpu_addr, size))
+	if (!IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+	    !IS_ALIGNED(parent_bus_addr, size))
 		return -EINVAL;
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(cpu_addr));
+			      lower_32_bits(parent_bus_addr));
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(cpu_addr));
+			      upper_32_bits(parent_bus_addr));
 
 	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, type |
 			      PCIE_ATU_FUNC_NUM(func_no));
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea163..d0d8c622a6e8b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -343,7 +343,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
-	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
 };
@@ -491,9 +491,10 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
-			     u64 cpu_addr, u64 pci_addr, u64 size);
+			     u64 parent_bus_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				int type, u64 cpu_addr, u8 bar, size_t size);
+				int type, u64 parent_bus_addr,
+				u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);

-- 
2.34.1


