Return-Path: <linux-pci+bounces-15387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B2A9B1443
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 05:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C47F1F22752
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0D13B29B;
	Sat, 26 Oct 2024 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B705/EfV"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18105217F2E;
	Sat, 26 Oct 2024 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729912119; cv=fail; b=pwWN7a19ALJ7smg9P1u0OGzg+yli3e4J3kCD/EEZcOmYV4MbxvJxM8S3mCBCpV223tKXgGwcqDbswkVPbAL3gIUbFLHkF9H9ate+z95DMv3WaFAtA+JJKdw/DZqaDD7VANbQ74JY42cJMijYmSUxOKsLDv0iQAuoeb+juKVpXx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729912119; c=relaxed/simple;
	bh=eJuf6QRLPCMp4oYVKwhT6505vnCA687jdVYyxCLQ+vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H5662OtVsLygnftZJ+sy7exYV+e+HSabQTBDxdG12WovbQv9a5Aj80SVomiFZUf6mw1Ka3D3RwZUp9UNVARH0FDT60NZJ0Oq6XUeRcc2j4NHLuRwRxuxs3W/7/Db9TnKxp8so2X/mSrlWHaJKS2vGHmv8D8cCPnUKoGixVg4urA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B705/EfV; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5Q8LcJ/FyERJQ1QW3dbhZ+fco7PxaoudZRU2j66Kz1LPSi718YHJ2k8ISGe9kphgSSCHIpJ0NzizymLln9Nq3gOeg59Aaf++8c8FO/SCCc/H2Lx56uumBMYTY+YeeGOZWOzskLdiwM6hPEWDL5XRadCOb7hU2VU0Q60lhe7ehSvLw6CEKTacbNjXgfOswUP5Jk9QoIceAOPzDBVsnoL+w+Wi2RapTC/rri13IWHY+jKR0E4kizYSpWhH1/P+4FumgGU2RWGbt/3l1OfwpoJOkxNaZi/YscA42gXJktnz14T54tekCZnPlc7cUY6TOTyWlj94frXpQYUNT9s64xmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXMOlna4ozOKWLDsYWDlZkGYjqytjjWJPURfdYjKv1M=;
 b=HEiQNCBSuU44JA3gMsODRhjmT1ab9b7w8bHtAZq4k1t1rld42WlPAR0jHQKBgzOp51OMClwd2INm/CYYowj2dek1wDNpGoq0UM8INqZ/GdtMitoGc0z8A+o+CiqetzRukY7raBnIPb9ueisf7xLPx2DZdGbICqkuycTHSGbClaH410Ry0YfAI2bzVYBKOD89g2BHykGNrq+Dhi/4xeok82WWEdZikZkeuDs5nxfNOSe7JKXQ/6wIu+zu+A1GoAjJ+PMAWpzGlZz3TGbhRid/X5zx6E4l3Kk1OOeQIlH035zl0EZlwW2VT2daU7fVYQeA5FLcGu5K9HyeLyfQY/24EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXMOlna4ozOKWLDsYWDlZkGYjqytjjWJPURfdYjKv1M=;
 b=B705/EfV48HwIl+k/102YtXsvVtGKRjqIs8SYcdlI4XvGAbZ8nK9KGCTYwZ8sQX5UT8Y6ohROpsGcorG3mhT+aymfd0iFAQIcEJEwQlfdts3UyE+A1NTR3TBTgQknbsEV3RRUB0Rz0ls9BUPB81T7tgS6ZAJlrBED0TUed7mNmhaFPiL9KAhB/arJYYfqnaVjvUlMX0vkgZeZJrabpMozKASi6eKUxJC88OA2XWOYgrPpqqKwG3Pd+1Cnan5pO3uWDxCHDEKHafAyubO5jnGEKbVchDG4716Fnmm2ycY1+kza9Pr7uy+Ey0VSnb/xaLvS7/f8GqbmERVG6CNmG+8Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sat, 26 Oct
 2024 03:08:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Sat, 26 Oct 2024
 03:08:33 +0000
Date: Fri, 25 Oct 2024 23:08:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] PCI: ep: dwc/imx6: Add bus address support for
 PCI endpoint devices
Message-ID: <ZxxdJn3DucVjiiXN@lizhi-Precision-Tower-5810>
References: <ZxwH//clayRL2emF@lizhi-Precision-Tower-5810>
 <20241025213626.GA1030542@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025213626.GA1030542@bhelgaas>
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f96537d-35a3-487b-5b76-08dcf56b79ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkxwaktZSEJ1bWp1T0RTYXZsa1gyRDI4ZVFZNTBCNWZCdy8yS2wxYzM3S2du?=
 =?utf-8?B?eUltZWpPajJ6VFZuL3RZaXBiMGliMWNwSXQwYzRXRDE2L3NMQ29vNUUvYldK?=
 =?utf-8?B?NnJsTU5jQmszTmdvNGgvSGFjV1EyRklrN2pPeFlFNStwZWZjMmZPZis3V3JU?=
 =?utf-8?B?T1QyK0xLRzJPa0Z3UGM5OUhETmpHRllRZndGYXZMK01rMkk1elZqa2s5cVJh?=
 =?utf-8?B?MHhsdEZ0QzFPazdmdVEvQWY4S1YxMUlrRHpDc0NqRld0SnA1c1VMZlNPOGM1?=
 =?utf-8?B?UDVLdjlpR0NOdGpSSG5hdUJzSStVOGd4cGd6ZVFDbVFoSkVYR0dNSUZFOXZq?=
 =?utf-8?B?VExSbDRaRVMxRjJNc3FWTC82RFVrOWw3WlhKL2pnK1EyREhuVkw5TU0wRlZT?=
 =?utf-8?B?VlBldnBaU1l5N2Z3aUdFKzlvaWVwekROYnN5N3RlMXpzZnZva3dxS0lEckpi?=
 =?utf-8?B?YUt4RlhjcnJXZWhlbFI0R0pNOExSN0ZQYXFQWVJpcWxzOWo2SmNlUXAxTnlZ?=
 =?utf-8?B?Q1p2aHI4UFVRazNUemxEclF0RmYxek9aejlrdFgwOXFkaVJ6bk9DcTd2dVZD?=
 =?utf-8?B?RERab1hxdEpuMGtsaFdyMXZjaWRTRlQycTBwTDdORmpWSjR4NExGdFF6SzJm?=
 =?utf-8?B?b2FSSnQ0S1R3YXlkdkJ4T2lqdVFXdjN3VHMwQVk5S0dBa1VDYmhpaXgxbFRP?=
 =?utf-8?B?T3FoM254Q3RpYW9jWW1jLzdZOGo3SUIwRUZWNDNmVnBOd0dZNlNBd3FnMTZX?=
 =?utf-8?B?SXA0OU5WYjh4S1hhU3JpbHZBVDVJcHFHaFBSUk4rd21LeUNwbkNqbGhRYkNq?=
 =?utf-8?B?dm5TdFdXTFhXM1RYdmlMY3h1aktjR2dSaXVzVEF4N1dPU2RtK0xId2ZSemRw?=
 =?utf-8?B?cWJ5eUpwVnlOb3pjcTNWNjdEY2RSdFZVdGlvYW05UmMxZUhCV2Z5YUhxYVB3?=
 =?utf-8?B?bmtDenhyZ3BZRGYvckl5QVdIeU0vdTJMaTFSVElNb0pVSWU2TDRCUHVJUERJ?=
 =?utf-8?B?alhCMDhLbFJKOGtiUWl0Y1JrZm1xTUNja0w0WXhJSHNoeFFJcDgwYmphblNh?=
 =?utf-8?B?SUxyc2I4SkdwWTZwejgwWmhjYnIwUU9ZUnlxdmlKQVVobHo0SHZqNVV6MTZ3?=
 =?utf-8?B?OWN5bWxhODg5N2UzbjBFb3ZEUXZxVFFlVFZuOEpoNzY4MkFTTDFERlZNUTN0?=
 =?utf-8?B?MWlYaHJTaUptWkgzY3BiZVFrWVNualRzYTFMaVRzZHZ2UkVvcEMrTW9BVUF6?=
 =?utf-8?B?bmIxYkovRjJtRkhiazFFbmV4Q1JBVVhQRTE2ZWgrTk5HemhveWh5eWhLMFpK?=
 =?utf-8?B?cEo3YjU1aW9zb1lMSnNETkxwK0NOZ1B0NE1hU2pRTUlZOGwvMU42UFV5aFZz?=
 =?utf-8?B?aWdwSE9UdlZuMEcwU0E5MkxjVUdtSGxlS0dpZW1takY3Mm1HV0JvZHByVk9P?=
 =?utf-8?B?VlBJK0xWRGNVdnhWSUNaclBiamJMKzFnc1N1RnFaNWVrblN2NWU2UHlCWmFx?=
 =?utf-8?B?UWhJd1pYdysvYWhzZlJKRlJwRnpET2t6RnpnUzdkRmFUZG9qMkFBOHkyT3FO?=
 =?utf-8?B?K1B5T0JYa3RFR3FSeG5qdjBXM2ZnaU1RaW9mbXlqZ1JDRUhsbUZUVDFBTGwz?=
 =?utf-8?B?QzlMRDh4REtVNUs1cjZSWmlvbjQrL1FSNWplelR6YXBta1g3UTVnQ1RUSjVn?=
 =?utf-8?B?Y3BDTWNFQkF6ckxHNnBMSVF2b3NJaXlYQlZOSlVZUitwN0pzbmpqcTd4NUdS?=
 =?utf-8?B?eFVlM2x4U25tWDFGdm5aNDR1Zk50NDcwQ0x4L2YxQ0M3SnM0T2JUUThlRE5u?=
 =?utf-8?B?VGZ3T1NDejhGK0xSUjA0eFBRUGg3V0FhK3JFS1VoS3lRdXZCdUtLQXNDaDBW?=
 =?utf-8?Q?vhSsSMZPMWGcV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZWNllHc1J6M3dSNEhSYURCRUFHTTNJT0Z2ZUpWTVN5RTZHVkNQS3JxZkMv?=
 =?utf-8?B?b2l3UUlDOFRoR210d0VmR3FqSFF2d3J1WUlhNDFpNXpScGJ2VUJab2ZIWWlG?=
 =?utf-8?B?V1F2eFovN0pJU0orMWhzeFNibjlKNm1uTUxEcU5VZmJoWmg4T0drWEVmeXNC?=
 =?utf-8?B?Znl5YWhvZEZ2ckpnMjZla1FhcWF2NUU4bEdPNmwxd1c0V0dNZHRhY3I1UllW?=
 =?utf-8?B?bW80NW9Qb0llRFdsYTNkVEhnRzhmQnhOakdGc01XZWIyY2I3TU5rWGhLZ3h3?=
 =?utf-8?B?UStiaXg1S2k5ZnJsMDNnbU04RFlXQVVoeWdpRXBBUlMzR083aXFDSC8wd1dJ?=
 =?utf-8?B?K1BsWXVENGNxVlpoV0NDZVFENXFNZXB2NllWbkl6M1ZvYXg4TFMvSEpHVjZH?=
 =?utf-8?B?TUVDQ2lBbmE2UDhLZHZkdFVGTzdkYWVFTzIxeklNYkx3NHo0UTBUYlpFTCtM?=
 =?utf-8?B?RlZST2YwRmRnNnJBc25LbmR6Ly9QbXlQNTlaMjZybW5BRXd2RUtjRlhqWEFF?=
 =?utf-8?B?dG9ONGdMRnVBN2ZKOUdFTHJMYnFqWHNQQjU2dllHUEdzN2pPdTZuUXNRZnNO?=
 =?utf-8?B?VGJybWxMS2t3QXpSendEblJwb2pOSXVHVWJ5QS9ZMkxoWVNMNVEyamx1bDZL?=
 =?utf-8?B?a0cxMFYvWm5lYjc4VmE5MUxLa2U0b0tGR254alVxUUp4eEp2YW1DUTVGMjlE?=
 =?utf-8?B?Vy9PNnJkai9iNWxKZjUvMWxOVXZoTEtNLzgwYmwrUE1xbW5MellXem9EeGxu?=
 =?utf-8?B?dWxXNzdpdEQwZjRHNnRROXRvamVIMmlUWG5aZGlWSGlGRTRzWXMwbFk2TE1k?=
 =?utf-8?B?YTBhMmE5Tk1mWmdiNHB0cXcrWndLbDJUNE5tL25KRjZuNEF4bmZ5UFFaVDNH?=
 =?utf-8?B?cW4zQlNuYzNnMmc3UFZCSENqNkpNZW5ySW1TMFVXTk4xK0thWlBQc2Z4WU1Q?=
 =?utf-8?B?ZnAzQzU3UUVnUmZ1Tm1MMnRFY2FsUGZhYkYwaVRpcVYxNE4xSkxXQ09obTVk?=
 =?utf-8?B?bUdteUtJTHBBdkZNOFNNUWtkdjBlTjVTSkRHNm11VDNUS1pKNmlXVWgvNWZJ?=
 =?utf-8?B?TmRiZlp0SXNkeStzM04wMUZ4TGlDeWRxcWg5UFdDZ00zaG93Y1JRV0orK1M1?=
 =?utf-8?B?QXNlaC9BTGpQajBTbUJ3R1lVWHd3WmtiWHZ4OFBVMWN1VDVUdUtrQkFIQVl2?=
 =?utf-8?B?T1VDQW02d2cveDJRbDVHQ3BlMWptMVRuckxCWU5ZRUhPY1ZYREtnaEtGdXF3?=
 =?utf-8?B?SFRtcksyaFVHOFhZRkUzS2U1dytJcE1VaVNSb1RxY3dKRnpkajNKS1B3bWla?=
 =?utf-8?B?aGxPWVo0SWJrRUp1Nko0N1ZwdkxLVVhWTXgvYlhUa3RSOWtEcWx0MG9kZ2dR?=
 =?utf-8?B?Umg4TEg0WjlDSTk2VHdpWlFic3dqSnhKb3Iwai93NzE1QkgxVG1VZGNaNU9o?=
 =?utf-8?B?a3JCS09HOE5EZEpTbDVoekFpSm1zeDlDRnkzY09aem1IejRMRVZhRTdPV09H?=
 =?utf-8?B?eGtFL1d5TnpSQkFnTytYYjl4NEdzOEkzMXl4OGFBNXVEbEFSNkwveDluQnh3?=
 =?utf-8?B?RXNjbGZhcU0rdTZ3UlFITEFvMlpGc1RpbDhCUW8wR2FIZDZ3cnRsNDdHQURE?=
 =?utf-8?B?R1lSa1VPSjVIR3NIcWM0NnZWdHNnTE5mTkhrYlVEY3JXN0ZZOWt2c0thSlZl?=
 =?utf-8?B?T1VoeTlxbVA3dkI0cDBEYmtTTzBPNlB6QUVpeTJIZGhLSlJnWFlwU0pLdTN0?=
 =?utf-8?B?T1RnbEdzbWtWNWRBZDRGNHJvbzN6b3REcWxJdlVGcFF4dSsvY2lnVFRZWnl4?=
 =?utf-8?B?OEdDTEQzQ3FrT1krd3NyRnI5ZVBNZnV0MDd4YkFPQ0JxTHJ6ckI4WUlMUys4?=
 =?utf-8?B?T2tDRHdvTHhiWHoza0wxQTlaZGNPNDN4T2NhalpLRXFnTGx2ams2aFcvMC92?=
 =?utf-8?B?N1pBQndEejRPMmhrR0d1cnF6NVFkZDV0cHdjWUhQSTUvM0N1SDk5U3dHRkpY?=
 =?utf-8?B?cVJRNjdFbFpsNVAydnE2a25kV0k3c0ZxVE1lVnQxcUw3UG00YjJ3VWFyaTZB?=
 =?utf-8?B?c2daalpMTWdtR1loOUFjbi9iaFpvSVArdlh3SHRwVGRqbFdDQnN6dUlhZWU4?=
 =?utf-8?Q?kxpI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f96537d-35a3-487b-5b76-08dcf56b79ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 03:08:33.6881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVZJbKcPQ+0Zk/W2i/iRdVAsOAVdRrOjLi0503aAeuTNTKxaLpl6P03yjZJYt6ISfTtffEda8Wz2ekQDBsa2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998

On Fri, Oct 25, 2024 at 04:36:26PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 25, 2024 at 05:05:03PM -0400, Frank Li wrote:
> > On Fri, Oct 25, 2024 at 03:48:18PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 24, 2024 at 04:41:42PM -0400, Frank Li wrote:
> > > > Endpoint          Root complex
> > > >                              ┌───────┐        ┌─────────┐
> > > >                ┌─────┐       │ EP    │        │         │      ┌─────┐
> > > >                │     │       │ Ctrl  │        │         │      │ CPU │
> > > >                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
> > > >                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
> > > >                │     │       │       │        │ └────┘  │ Outbound Transfer
> > > >                └─────┘       │       │        │         │
> > > >                              │       │        │         │
> > > >                              │       │        │         │
> > > >                              │       │        │         │ Inbound Transfer
> > > >                              │       │        │         │      ┌──▼──┐
> > > >               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
> > > >               │       │ outbound Transfer*    │ │       │      └─────┘
> > > >    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
> > > >    │     │    │ Fabric│Bus   │       │ PCI Addr         │
> > > >    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
> > > >    │     │CPU │       │0x8000_0000   │        │         │
> > > >    └─────┘Addr└───────┘      │       │        │         │
> > > >           0x7000_0000        └───────┘        └─────────┘
> > > >
> > > > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > > > The BUS fabric generally passes the same address to the PCIe EP controller,
> > > > but some BUS fabrics convert the address before sending it to the PCIe EP
> > > > controller.
> > > >
> > > > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > > > Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> > > > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> > >
> > > The above doesn't match what's in patch 1/4, and I think the version
> > > in 1/4 is better, so I'll comment there.
> > >
> > > To avoid confusion, it might be better not to duplicate it in 0/4 and
> > > 1/4.
> >
> > Yes, cover letter don't come into git tree. This part is common and
> > important, It is not good just said ref to patch1 commit message.
> >
> > Add do you have addition comment about this and
> > https://lore.kernel.org/imx/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com/T/#t
> >
> > The both are the pave the road to clean up pci_fixup_addr().
>
> I think it would be helpful to combine the "PCI: dwc: optimize RC host
> pci_fixup_addr()" series and the "bus_addr_base" parts of this series
> together into a single series because they are doing very similar
> things, and it's easier to review them together.
>
> And split the dt-bindings, PHY sub mode, and new endpoint support
> parts to their own series because they're not related to the address
> translation changes.

new endpoint support depend on patch 1. let me merge two thread together
to review easily.

Frank

>
> Bjorn

