Return-Path: <linux-pci+bounces-18054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181EE9EBDB3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B9628490E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56081EE7A0;
	Tue, 10 Dec 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="maCmOIPO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B4F1EE7AD;
	Tue, 10 Dec 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869001; cv=fail; b=m8gtBgi6sGYi9JfGNtKhUDuv40o8zWRyDS4nR15AAbCB8lTm4JlVHBSPRhsdEgzkq1hlVwU1oHgmoCgRGyUFHJ5erWeOTDYhF5ztr5MXzTaDf7my382pY8MnJDq5UVbGAjAzOXNsahTMlMUCkP+HWcKHLfDCUyKEy5iTBCffh4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869001; c=relaxed/simple;
	bh=sA6rRo5qpF4+EOZ2x1wOLftgSz0KPhaRPBUhjqkVlNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S0X8F4ON9kW1atGbGQyn8fDf0WbKUtYKDEUMqT5Ykz5OU8/fpWMh1F7D0TU24jo/XXnfLsZi06qRTL8EdqCvbR8q1sEd+CSCRPLiYFOa7eNATHVrlASiM702C0CxbH2yAx/ig32Q5QcYnh78mNXAJzTGoK32U4skI2Gq/WfyS9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=maCmOIPO; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpSaZxTinpyO+eE9oKTIgPtv7SoFfkB9PZJGUjrSjsdMrZyFjt1vdbgVst1SQZiOHPt51ru2yBUmkBFhAJlHwjiTfsblaaXD0IbBaJP066SGM2Y50HgSeqfHuxyKxok4sg+H+D2xQJwnGXu2gySzcuanU78A/gzcUcrnvPRLv4ZtkFiG06YmrEyKUozc8naZT3i3qowsS9gn/s88dFRkJMzAdaKDmp0oPh372EBIaO7NRAe6XN24ZXttr5W2LlXU9v23FqaoicD3czkqD6g6DbUfuTp+yXfk2CTvsbmVWyG2TbBsapw+LTB39JJ6DDxzYphLbyIoE9CYpEirWTt5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c61BseZjVYgsFi982n7h4lEHji1TVw3cp4Qm/mZk3oo=;
 b=VZFdPLMjCxIqbCzKkuh0dPWBvClg9ipQ94R+B3dBlDpcR4ANfGAnr6VBjEA/UtdVxVkIJ5lwq24H6Kh4iVRWsj7WkDu8a25QuEVZWaOjX4yt2t9pQS0tjHiSSPq6YnhM0z96jerRWQIB0EkmuPfAYHTnZUrRQ8BEmMDZ9skxNKNVNhSXuMN8hu2Af180cAU5ANylh4czlDQoc32iBS8gDwmSAcNGy2JFm6b39mnYC2jIkqtPMcQHj0xggJojVc2BlDT+7SiisK+rxk+3nP2duE/RXe5fiDO3zF4zvoxuNcLHncClByhf4PiHQirbEA+trGewbHSzJz35x/g9M6N9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c61BseZjVYgsFi982n7h4lEHji1TVw3cp4Qm/mZk3oo=;
 b=maCmOIPOYDD9mt8xu4REbXIusnLAHOvrjQxtU428JQ1l6YYDcRpDD/57kNdjesXXlohSNKMRJu/XdhLUaMGuD8JoaX4i9Df0+Mr6FLBgwG8CwiwFZlj10ecsQCzdrpgegOlvz8Y7SJe3OxlSkJHihnL+HZKF8TDvj7IvP9yXDhh3TSMl+nZaCVlOoK64bnn1TYmahRa9YuU1bofRkt0Qx+sbsEuzA0KKyQHGn0/QoajzdTmiK1l5QSlHx5hf9KhqPPo6DkGvvC3BRBHMawPAycDffTWDqJ5i5WT42FYEQsOPmuSo7N66qvF0JPVsTvLyA076FbWY/3Xk5B+B+LDHZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:16:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 22:16:34 +0000
Date: Tue, 10 Dec 2024 17:16:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <Z1i9uEGvsVACsF2r@lizhi-Precision-Tower-5810>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
 <20241124143839.hg2yj462h22rftqa@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241124143839.hg2yj462h22rftqa@thinkpad>
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e09213-3c55-4746-7ac2-08dd19684ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWVEdG1SZzBQVDJYQlRmT0pROW9EbUswMWVWVWhmN2RZRlJVV29DRVN3V25O?=
 =?utf-8?B?aytBb3hubVIzZnhJTDRnSy9ySDFpTTJkbjZIanNEbWFxaGNjUU8wM3NNUFIx?=
 =?utf-8?B?WkxrS3pDU1JUcExoWDgxL2l3aTZJRWN0WmxySk5pbWwvOVhKZ1RaNW1hUHM1?=
 =?utf-8?B?cDZ1cTI2YjE2emc1M1ZoUWMxSjhOQzlOeVdhQi96bTdVQXJqc3REcVkyMHJn?=
 =?utf-8?B?S08xNHBmRDd5Ui9wWno2ZFd3T0p3MGd5ZTM4akFyeFh0L0FONjNCZWFsU2dV?=
 =?utf-8?B?SE9ZeFk0bmt5c2lSV244Qm84cVUzdWxPc0JZc2hNQ3lZS1lUL3hNYnNzelRW?=
 =?utf-8?B?VnpGaldkQi9iNXZKSWROckRWSWhUSGZvenhaUTU3VHhQZytGbHQ0UUhoSkxh?=
 =?utf-8?B?V3JhN29TNUNPbEY0U3BZMmRIeVNVWVJWQ3lOZ1c2Z0FBU1VzOEJYeFEwR2JX?=
 =?utf-8?B?TFRTVFJ3dVZWT2M3N09PK2JUZUZ4Y09wK0x4bnA0a3lacmJQcEo0QjF0QjV2?=
 =?utf-8?B?R1JWN21zSSs5NkJPUWxIVmR0UU1wWXRSVjVEZ3BLOE9jU0NuT1FYVkNCZjZ4?=
 =?utf-8?B?K3plS0lRTEtlRnJjQmZVTU15ekg4VDRrRlVRZC8wdEl2bTJtRll1NXc5WDJX?=
 =?utf-8?B?RGEyYmZ6RTlsVUJ1SmdTeDdnQTNqcTRTN0R3OXpweklCNDhwem9OVEY2OHQy?=
 =?utf-8?B?S2JINWxJaldpRFM3OWRyb0NGYVZveThJeFJkVzhRaU9jOVhLWEZ3UVFlcDVa?=
 =?utf-8?B?NjMxNVdBWEN3Tk9IYnNXMVlKazdjano4aktyREhMWXNGNnQ2OG1GdkhoTEkv?=
 =?utf-8?B?S285WXMvOXdBNUxDVkxncVdwV0t4RllOakZIeWJhcm5NVTFFU3RIV0VZMlFx?=
 =?utf-8?B?bVZlb2l0Ris5bGsrcVlla2RVS1d5K0RQTHB6ZTloeGVDQ2h3dHdrS0s2S1Rk?=
 =?utf-8?B?aVVYR0NsV3BVanVBa3U4NENuUlJ1MTNBSWdYcUcxUnN1T2ZEbHRacUxKR2Ey?=
 =?utf-8?B?VXlFSzV3NGhmcDU4OU1jMGxJQnIycHp4K1AvVXRMQWNMbnp4c24za2JCYTg3?=
 =?utf-8?B?cU1kQi9weVdBQkJWYW5HQ1VKRFBnVWU4bTV2Y0Q0VVVIS3pwamZVL0VPVFRr?=
 =?utf-8?B?U29kSFZnenY0Q3M5d0QyUlpVUzRqbGcrMUY0T0FNM1BsWmhTbDFLUGZFUGda?=
 =?utf-8?B?bVc3aDBETEwwTjhuV1ZhTWl6K3ozYmwwOHRnR1ViWGNDaHZnUzRyY3A2TTlE?=
 =?utf-8?B?OWpsTVNqYnB5MnB3TjFSeDlTbGNyWTFwS1lMaklpcjFYVkkvU3pWWGwwR0Zi?=
 =?utf-8?B?RFhsNGEwNTJoOUxWTmdzYSsyNml0ZHJmYW5NSEJJMXNyWTloT0ZmTFM5NENl?=
 =?utf-8?B?ZDM3RWJDVUozUVR2eHd4YktvVVNTSzE1T2kwd0paWGZLbWNXc3dnN0pCNC9v?=
 =?utf-8?B?di91YlNWbTdlTDVlbVk4YlM2UytWZGs4MG1Kc3NHWGhtMXd1aE5JM1paWVBH?=
 =?utf-8?B?ek9tM05oNFlKNnlrMHpJVWlGa3pUUzZGZW1xSDhaUnYvRk5RRG1FYzV4T1p2?=
 =?utf-8?B?MEtreG0zMlpiYXI2ckxRbFhSVm1mNXE5OUxPODdrZ0FCQlpVemtXSVZqRHFu?=
 =?utf-8?B?M2lseFlIaU1GRktob3JHR0Q1M0s4NllkMEZQSWlWYlZmMXBSRFNGZUYrZzFW?=
 =?utf-8?B?aHJ2alp0aU1EcWxlelNQUGlGVjB3RWExUG5BRDRJM0tmNVhQNDVDR0xiR2hT?=
 =?utf-8?B?V3pYY3BPYktJTVg3NEVjOTlDVndFeUkyMmpPeXJhTkFBNk5oVmtFVWs1K2VX?=
 =?utf-8?B?d0hVcW9qN3UzdEg0TklLQVM0SFBRa1NGdjR5cUlXQzZCSmZ2RDB3T2ZoN1Fw?=
 =?utf-8?B?UU1HYUxHTnJGL21FOVo1NjR4dFBRUWlwNEpTb284aXBqTWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGg5N1NodlEreHNUcmpkWHFjaDAyb1RLNFlmYW1LMyt4OVNBeXFkSm5WUC84?=
 =?utf-8?B?WnZ6Qy9nNzlDMFFseXBEeVNrN2JUVngxUEEzUzdnVmVFbzhrbjNBRk9RbFY3?=
 =?utf-8?B?WTRGekZscDZ2NFRMdTdyeFBwZjNuOTNvcUVkUnc5YTJBVTBHWTVRVEs4RlZ1?=
 =?utf-8?B?dXBNcHlhWE9Wa1k2Zm53UWZKd0xQUko5WDJya09mMFlxb0wwd0ppdWhLTFNt?=
 =?utf-8?B?a0dSUFVFd0IvT2VmQVNZT3YyKy9wOEtxT3lzaGwzOWhOa0ZtMVRRZGVYOXNK?=
 =?utf-8?B?Qi9kRm1DYXRtK09aS2owdWYwT0pubWpSaHNRUzJ4WHNmd3IwNlhzOVppcFo0?=
 =?utf-8?B?YWdQM2JHbFdEUGI4N0VaMnJ2a2Q4UnR2L1BmczJ4UEhVNzAwR1J5Y2dqT1Fp?=
 =?utf-8?B?Z2lMTEJnQlEvWEs1TWRhMkRGUXNublU4c3hoQytoZUhSMVY2czdscHNvOGw5?=
 =?utf-8?B?VGxxNnZTQS90aXMrZmhLcWJMN0hzUnRyNFVub1FmaTI3Sk9mOSt0U2VZVEgr?=
 =?utf-8?B?M2g5T0FJRGRPYWp5VlFEbk9QSVdadnBadFFNclFTdkJBbWFvVjArc1NKL0ZZ?=
 =?utf-8?B?cm9lMXY5V2R5eGZxdWRlT0lEUXdreDlyTDJLWXNwdVVoVEJubjAwZ2sreU9m?=
 =?utf-8?B?QmdQb3h3NFJzVG1OcWFOREw3MXNwVkN0Sjd3cWZhNXdZM1d3ZWdlenI2bkhK?=
 =?utf-8?B?NkJLZTFVQVNQaFZ1dTJiakovUndRVUN4eEw2TFRPa3VKb0ZEclRVQUtKcnkv?=
 =?utf-8?B?enFTU2JycnR5RmZXbzV4UWdFbEFDVUlpVmFJb3pEVWRMSHUydUVGdGdsbmwx?=
 =?utf-8?B?NXMrUm5lR2xXVDQ3NDFLQnI1RVQ4aExERFhzUk1tdVY3S2IrbFBERXl0dkxa?=
 =?utf-8?B?NGtScVUzbEtmemxMdFZlN2I4THMrK3duc0ZXYjJDUm1MRGFtZkJGNjRDUE9Y?=
 =?utf-8?B?eVlKeGJ5Sy9KYjRKMkgzRVBEc0lWa2pPN1NoT3dMODFmSWNkcWVreTcxVHl3?=
 =?utf-8?B?c280dWlQU0d1Ny82a0c0bWNMQVk3RHgyODJLN3h5eENkMkhQWjRCWWJCS2RC?=
 =?utf-8?B?WTBDTHhJU2FuWlZoNkgrSmVhN016Q1VscEMrVmdyUHh5YllKSCtiYXFwVGtK?=
 =?utf-8?B?dVZQbXZvdFYzbGZ4MS85T1pFZXowQXhpZ1NQd0h3UEVxNHZ2eXRNaGc1TGFH?=
 =?utf-8?B?OWYyMjJFaGNrMmZIeUdBYzJyemgwRlQ0NTlJbEh6Mzkrc1pEQTFDa1g1N3Qv?=
 =?utf-8?B?bHB6SEthM2lBZVhJQ1BBb3k5bmkxNlJsNmlZRW5PVlBuN21xY0NaaUZwbWlN?=
 =?utf-8?B?RXVHNFcyMXY4QzBEZFI2WlA2L1FUZ3d3aFZodTNwZmhkbWtpb3RXZmVYREFj?=
 =?utf-8?B?VVZqNWgyMXp0cjFab1FmYXlVZitVeEZ0eWR4VWdNOXlVQ3VXeitoNENMQllQ?=
 =?utf-8?B?TUJoNlBqZk9Dei96OTN5amtGaU9wbXVtODRYRU1iUERwQ2lmdGxyODN5VmNV?=
 =?utf-8?B?SVpNTFZrdFNTUU5LT2EwOXZDV0EyQ01PQUxQYjVwYTRyR3Z3VU8rby9UOTlo?=
 =?utf-8?B?SzVmbXM0ZzhxaFk3d0JoZHRuRWw4YUtSbXd2bldjUDkrb1duZkQrM2pFWTdm?=
 =?utf-8?B?c1hiTHI3VWVsWjd2d1QyVGZKSHg4MmV1cGVjenAzZGZyazE1M282bmcwUGdr?=
 =?utf-8?B?Vzh5THJ2M25UR2xvdWVtSzBpUHl4Zms0NEFaMXAyS2lsR0pEU1pnU0FhbCtr?=
 =?utf-8?B?YjF6NFFNb2lrMUlla1dtWnJ2R2EzY0NrRXBRSzZaU1pUenF1WFBtbHI0NHpV?=
 =?utf-8?B?Y1pNTTVwTGVlSUJPQXg3ZGpteElHVVpDMStYUld3QUE3UDltYTJTc1dHU2ta?=
 =?utf-8?B?QUlPY2pZaWZmWnpBd1RoQzRSRzJYL1o3RzdkQzBDenZxVEtERmlrK2loRHNh?=
 =?utf-8?B?ak54MGxHV25DbGRveGdsRGRKUTlTWmtVUWgxNjkxcTVhZmV1eExGVjVWS1pE?=
 =?utf-8?B?VmF0YlJGOEpsVjYxQVNQQjk4cU5LcHJXeFB6NnBwd2tqYldDQ1lELy9pblZt?=
 =?utf-8?B?bW1QWjYrTi9IUjBVQ3JPZXZJYlNrTzl1M0QrbDJScTgxMWk1eHFrVFZVdDY2?=
 =?utf-8?Q?Ytsc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e09213-3c55-4746-7ac2-08dd19684ea1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:16:34.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1nwVZdWwG82TvIGYF4USGgSsMcDeEImT8Uk+t63ukp2Gjk5GH1EBSApwFz/vNElvigkFEsC8tQyjj/uR83k9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

On Sun, Nov 24, 2024 at 08:08:39PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 19, 2024 at 02:44:18PM -0500, Frank Li wrote:
> > == RC side:
> >
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> >             │      │  │             │   │  │            │   PCI Addr
> > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> >             │         │             │      │            │    0
> > 0x7000_0000─┼────────►├─────────┐   │      │            │
> >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> >              BUS Fabric         │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
> >
> > Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
> > fabric convert cpu address before send to PCIe controller.
> >
> >     bus@5f000000 {
> >             compatible = "simple-bus";
> >             #address-cells = <1>;
> >             #size-cells = <1>;
> >             ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >             pcie@5f010000 {
> >                     compatible = "fsl,imx8q-pcie";
> >                     reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> >                     reg-names = "dbi", "config";
> >                     #address-cells = <3>;
> >                     #size-cells = <2>;
> >                     device_type = "pci";
> >                     bus-range = <0x00 0xff>;
> >                     ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> >                              <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> >             ...
> >             };
> >     };
> >
> > Device tree already can descript all address translate. Some hardware
> > driver implement fixup function by mask some bits of cpu address. Last
> > pci-imx6.c are little bit better by fetch memory resource's offset to do
> > fixup.
> >
> > static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > {
> > 	...
> > 	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > 	return cpu_addr - entry->offset;
> > }
> >
> > But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
> > although address translate is the same as IORESOURCE_MEM.
> >
> > This patches to fetch untranslate range information for PCIe controller
> > (pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().
> >
> > == EP side:
> >
> >                    Endpoint
> >   ┌───────────────────────────────────────────────┐
> >   │                             pcie-ep@5f010000  │
> >   │                             ┌────────────────┐│
> >   │                             │   Endpoint     ││
> >   │                             │   PCIe         ││
> >   │                             │   Controller   ││
> >   │           bus@5f000000      │                ││
> >   │           ┌──────────┐      │                ││
> >   │           │          │ Outbound Transfer     ││
> >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> >   ││     │CPU │          │0x8000_0000            ││
> >   │└─────┘Addr└──────────┘      │                ││
> >   │       0x7000_0000           └────────────────┘│
> >   └───────────────────────────────────────────────┘
> >
> > bus@5f000000 {
> >         compatible = "simple-bus";
> >         ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >         pcie-ep@5f010000 {
> >                 reg = <0x5f010000 0x00010000>,
> >                       <0x80000000 0x10000000>;
> >                 reg-names = "dbi", "addr_space";
> >                 ...                ^^^^
> >         };
> >         ...
> > };
> >
> > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > The BUS fabric generally passes the same address to the PCIe EP controller,
> > but some BUS fabrics convert the address before sending it to the PCIe EP
> > controller.
> >
> > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> >
> > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > the device tree provides this information.
> >
> > The both pave the road to eliminate ugle cpu_fixup_addr() callback function.
> >
>
> Series looks good to me. Thanks a lot for your persistence! But it missed 6.13
> cycle. So let's get it merged early once 6.13-rc1 is out.

Krzysztof Wilczyński:

	Could you please pick these? all reviewed by mani? It pave the
road to clean up ugle cpu_fixup_addr().

Frank

>
> - Mani
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v8:
> > - Add mani's review tages
> > - use rename use_dt_ranges to use_parent_dt_ranges
> > - Add dev_warn_once to reminder to fix their dt file and remove
> > cpu_fixup_addr() callback.
> > - rename dw_pcie_get_untranslate_addr() to dw_pcie_get_parent_addr()
> > - Link to v7: https://lore.kernel.org/r/20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com
> >
> > Changes in v7:
> > - fix
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
> > - Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com
> >
> > Changes in v6:
> > - merge RC and EP to one thread!
> > - Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com
> >
> > Changes in v5:
> > - update address order in diagram patches.
> > - remove confused 0x5f00_0000 range
> > - update patch1's commit message.
> > - Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com
> >
> > Changes in v4:
> > - Improve commit message by add driver source code path.
> > - Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com
> >
> > Changes in v3:
> > - see each patch
> > - Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com
> >
> > Changes in v2:
> > - see each patch
> > - Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com
> >
> > ---
> > Frank Li (7):
> >       of: address: Add parent_bus_addr to struct of_pci_range
> >       PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
> >       PCI: dwc: ep: Add bus_addr_base for outbound window
> >       PCI: imx6: Remove cpu_addr_fixup()
> >       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
> >       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
> >       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
> >
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++-
> >  drivers/of/address.c                               |  2 +
> >  drivers/pci/controller/dwc/pci-imx6.c              | 46 +++++++++--------
> >  drivers/pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++-
> >  drivers/pci/controller/dwc/pcie-designware-host.c  | 57 +++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.c       |  9 ++++
> >  drivers/pci/controller/dwc/pcie-designware.h       |  8 +++
> >  include/linux/of_address.h                         |  1 +
> >  8 files changed, 155 insertions(+), 24 deletions(-)
> > ---
> > base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> > change-id: 20240924-pci_fixup_addr-a8568f9bbb34
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> >
>
> --
> மணிவண்ணன் சதாசிவம்

