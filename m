Return-Path: <linux-pci+bounces-13380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58097EEF9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2ABF1F21DCB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876819E98C;
	Mon, 23 Sep 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jkD839XC"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5919CC20;
	Mon, 23 Sep 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108089; cv=fail; b=mHVlezrqsgsqaKV+A2CA2Pc1+B/P56eXtFoV3gdiskd73Fl3m4OHMjeNEBHqdYI+y1jVPkCpG5+XDf3inAika08BGaTHvtg+Dn+1s4/osaYEs7zeS4G6KGuDvLwHHGNF46ZHunab5MfagcHJR1YzCiObttn0rS0DFhuqo5xsC9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108089; c=relaxed/simple;
	bh=3o+lNvlIlrN47Z973ngVG/ULUjV7VKNozjeXvHyNF7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JKY48B0u6Sfw/0+xXFxEtQOvrTOhsL0n00h+ccryr6iqTFweQ9mg3LP+5y4ESLOWMXitUEobSHIcgpW/Kwx8yahW0ML0OMh+LPLMX4voLAkZ8NO+6tOogrX3UxJTKgN0KGJ5YZjwsiRLXSo/l/49l65ut5Y4GznOvtJRUXsFMVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jkD839XC; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g00rRYHq/8hYQL4CJmlIAh27UnbtgiDedzdbUC7aguHnA3x3aLGVLn3Jwmwmaa6ZcqMKNy7p3oYnqhpxpPuXfhaL7yRiLnvVDiOKCrvSnPzyJ6PdET5J/f956YM/R3hC3SLKn+g2oI16iqgeY1Jg+GNqrUgZDj//ObkiskWhKAdYXLZ3Z9LAdcGAS7vrnNopLAGlV7wOjRprZVjDJojYoX24ZpkmIGxBFYQCGHcQN4DtX9of0aJ4HHiDLXz3/9EATSdE9iLgndLh9/N3eOPRRuGhG9sPPVjilS1xwxePIsisVQ3G9r23OdHV38ECAm3bRXSEkuukV1UdvqIpe04YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5kpuUo2IdOOrcu53gErZO0lse3ZVGGYL+0fUnI9/eA=;
 b=D6TJpMiO9k2hA/0bjbFLr7os46w3WY9C8bghipYSZKOyfB0YEvJ4ZAdaT95dSW1N0D8LyP4GDysT/ekXAlpfmt02zvGLFFLoXiZJiceXEXUt8aRbDX5CiAcDZxCvtWj9lBoT6XCoqAHGaEhPUAJRC5sMGbgaCJgI7qHCay4fyZDLJuBGxnjBEY4Ltb8i9YGWK3RSnrfc6Qq003Khsgm/ihP9Uz3OCnri5T/japnzDy9c1ZblosvFntnCIp282NgjaxstDb+dmqbuaid//hIxYkvSbTrQES/c/NrNQoiN23MgWFTwqZ3HbTqWL9EkiXxjLzT3xajzsuyGkc8awCSfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5kpuUo2IdOOrcu53gErZO0lse3ZVGGYL+0fUnI9/eA=;
 b=jkD839XCW+KrJfMjA18x3LGP9BfYZuWhUhGXKSgv4fsqMnIcVmIVqcIAmEtR1d34boqHpSGgYLTFmG01km1e/LqU/cnoOgXfSKaewJLqjt6Ej18/ziJ49gxCT0ccT3lnmldiKh12yz4bixjiGyYjb0c9PRNtdUG7ZKsefJulXIzJgINN2i2j7dxOXcj8adm6tyG7E/w200g8LJdHQguUiOALEPkO7iFr0EIjoSh9yZtakLcbFYHPJ8sG9Z3uRlJt86pW1lgXP3Z+W5jCTj0DZjXMpGPPxYGV0vsAuG9N1xLwGMukVoPp3YbwPCD/0WzetFN9EYNc2X8Wny3azfOsVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Mon, 23 Sep
 2024 16:14:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:14:39 +0000
Date: Mon, 23 Sep 2024 12:14:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH 0/9] PCI-EP: Add 'ranges' support for PCI endpoint devices
Message-ID: <ZvGT4+UaPOmnGh4M@lizhi-Precision-Tower-5810>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
 <CAL_JsqJ7Of-0H+qW-ts7cVkeK0+4BR5mxocx00eVFKHaLfj45Q@mail.gmail.com>
 <Zu8cGrPLbe/psU3m@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zu8cGrPLbe/psU3m@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef72f35-7eef-4891-de6f-08dcdbead338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZldyWkhST3Jtbk9BdzJudW5Zb0lCUGV3Q0lQNk9LeUhUeWNXOFFybXNZT1kr?=
 =?utf-8?B?dHN3RFJhUVRLclZuRzVPZjYwQXpIN1hEMVh0VFlFNXFqUTRBd0J1MVFrbjJ5?=
 =?utf-8?B?VUVZNkExNVNPZjFxMDRvU1VTd0V2VXN0aTAvTmcyWDNiVUtqTTdiUkhvSFY3?=
 =?utf-8?B?UTRpeHZTU0xLTEVYTStrQk9oY1Fvd0RsZkxIMFk1clJ5QmxiRUt6N1cveG1C?=
 =?utf-8?B?SndWNENtVjdYNGlJRmtycWU1NEFIN2hObXlSSE4vMkQrbm1Tdk14ek9Ta0JE?=
 =?utf-8?B?RStGeUx1YitSWVZUT3JiVlE5MnV2MnplYjU3WFFrNks5YnVyZ2JKK2dSdUdi?=
 =?utf-8?B?TzdKTFZGRmpUc3prckdEbG1ySW1FcUhNeHJ5Y2EvWG5HaDNlMHNGeVcrbTY4?=
 =?utf-8?B?RG01Q1hEbFBhVU05b0cvOG1XcmpBZWpjbk1HZDUrZ0J6WnhJV3hWTng4WEJM?=
 =?utf-8?B?ZFRiRHZ5V3pyTEdQUUwxVXdMSWhuWU1TMFZ5Y3lJRkVzcWhDZmU3ZjBjRWlG?=
 =?utf-8?B?YzEzZVpxSlpJTnkyaTROV0VrVFE0MU1EQ2xRVmI0akM2S0FRZ1lMTXVFeU9S?=
 =?utf-8?B?REZvL1BJNTM4T3NhQzJTVUVyNThNM0c4VGduUHl2MThmdndnSFc1eGtuT2Jj?=
 =?utf-8?B?VHNFZlc5Q09RVWd2cU9EWVVlSlFoaFRrdWFLTktzV0FWSTRvTUFaa2J3ajRj?=
 =?utf-8?B?SWFWMzhURzFpdEk1ZDdCSUhEajdMUTdEWnI3OGgwdGVWYmE3cFNWRW9BbTZr?=
 =?utf-8?B?em8raHBuYnJtZ21LZDZIcjRkd20xSmlTMXdxMFlYZCszNG1hZHVPSGFZUXdU?=
 =?utf-8?B?Zkg0VWpNOC9jUFZNL3VYamEzZmFETHBLSHV2aXkrTXJZKzkrZkxmRUp1UmMz?=
 =?utf-8?B?UFFnMXIzWWdYcnBiQ0dNb254TVRXbDZ3K0Q1WkhuTTVNVVpGNnl6NCtrRVpC?=
 =?utf-8?B?N29LQU90a2JkU25paVpDK2FBWkphQXFGcnNQcE13aHJwZGcwMU95Y0t1MnhQ?=
 =?utf-8?B?TDQra1pWUU9SM3V6UE5TYVhUNGNiTEFKWXFhWUN6Wmt1ajNLTmpHRU5BRDJ3?=
 =?utf-8?B?cURQVjVlcDFVMnBjTlo1T3VmSGlxV2tFTzdRaXAvOWYvcmJDdVpVRjJoOGNV?=
 =?utf-8?B?NTBHRUtaZjBWWk8wVkxrTXA5T3h0MWVoYld0NUpIZWpva2lJbFoxRWFjT0pv?=
 =?utf-8?B?WDEydGxPYnFVM3o4Ly9jS3luSXpsamhHbkRwNTBqZVlpZE5ydGRoSkppWjJq?=
 =?utf-8?B?YThpN2RoV2RFcEI2WU1mZ1N3alo5V3FaK0dtY1JkUGxEY2hYb3ZFSU9iSk9X?=
 =?utf-8?B?cHNKUlNSeUVqT2hZb0xabXY4eFVhYmRGMllsVTl1N3BISmpIVll2YWZJOHcv?=
 =?utf-8?B?RXRmTm9FRGRuYTU0K1pWdnVheDZHdWh0Y3AzMnMxWGVnOGFOVUo3a1RvVE1y?=
 =?utf-8?B?SzFVN2NmWW9CUVZ2a1dmTVBHaG9pVWhySWYxSGk4MUZ2Z0F3clp6SHBnbGNt?=
 =?utf-8?B?dEVVZmJuV3pTMFFFZTlWcGptTTVHOXgwNjlzclN0OU1IcEVMUmxoVEJJaDJC?=
 =?utf-8?B?SVRSb1ArQzBPZGo0a1dIYWtQVjNQOW54ZkNXbkdTR0N2SndYRFhFWVFPTUZO?=
 =?utf-8?B?SXRyeXgzeHNSRlRVV2FYemp0T2hVWTFEa2kwSGdvRlFwYmN1eXRkZ29TbHhM?=
 =?utf-8?B?eERsV2F4UWdpbC9Ha3lMenM3UUpPWUNnMGw2Si96V0FjTXVIcjVXRTdTVTdm?=
 =?utf-8?B?TnpBWTAzc3hBUDFqZjV5WStiK0g2NTVGS2xCU2xGdnR6Ukx0WmVRaG1Mc2pM?=
 =?utf-8?B?U1Badng2WVovUlFjcHk2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitVUUdIeWRPNzBkMjY5UEdVMy9WOW1oUXZNbHlDSUpsa0tkUWpSYWlEWkxh?=
 =?utf-8?B?ekcvUy9KTVByak1GU3o5MEU4amRSSDR2YXZSbC9wVTVMb3ZOa3NSbDA4dUFN?=
 =?utf-8?B?UHhJVjZ4SFlnVCs0UW1WU1BXeXcybDNsc2VMbVJIRGJMOGQ2TlhMN0xwcmpV?=
 =?utf-8?B?UGUwd3NRT3RERERqM1VyVzFNTVdhQnc1TFZHZ2FFai9wS1pBNVA1cDdFUXlR?=
 =?utf-8?B?YkltSVJPSkQzNFZuSnp6cnlJbHdFUDAwdW5iaVhpR3Z6SlNBZUVEV3cxNnVU?=
 =?utf-8?B?QlNac3Y0RFA5TXV4R3J2TEU2TjUrRDRyaGdVVW9WcU5GRDYvbEJLUE1GWWp3?=
 =?utf-8?B?Y3JCd05aVWdjbVFDSVNXTzcwRGRtclNQVUF1YWtVRXpXUlAyU1JlV3pXdXhP?=
 =?utf-8?B?bVlZTERQUWhtOWx5KzMzdGVvWm12SlQvTmtKSTlXcWhMQ3NraDU4dkR3Ym9x?=
 =?utf-8?B?aDhHSUFnWGYvMWdkR01CeTh5RXJBS29tQ2hoZHZWb1gveWtaTXRnNXUvbVhX?=
 =?utf-8?B?OVNVSmk5Ry93OHpMSGVJRW52b2ZaSWJTb3lhTmorS3NqdWxYa0M0clI4cDNU?=
 =?utf-8?B?MlZtOGhad0ZueTdVeE5sUllzLzRmbEduY01jL1ZEK3RNN0IwUXBkOGxUV05X?=
 =?utf-8?B?cVNWUERIYk52SDN0RFg1L2F6Z1NDKytRMDF1M2pZMnRpcGZheW84UUhReDhC?=
 =?utf-8?B?b3JBMjVPak1rbmpmNitSS0pqOTlrT0FFcFRsaWpmNys4UCtaV2NLeFc5aXlr?=
 =?utf-8?B?Tjk3bGNhcEVPMUJJSGxkcUp0ZjJVYjNKNVNZRWtWZHFOY2VRYTN1dnZjYlU3?=
 =?utf-8?B?V0wxREpxc1JxTDFSSWQ3c0U2SDF3RnhJL0ZnMWlNdk5kNlppVXdBWWUyWlVW?=
 =?utf-8?B?NWZSOEtWZFQyTUJXam9aNmNlbnIyUGZNMkt6cGdGNThPcjZxby80U1FlZU0w?=
 =?utf-8?B?aUNlZXQraEVRdTdZY1E3Qm9RRFpuN0NXQ2NWcVdjTHVXb1JlMnNQUFpjeDF5?=
 =?utf-8?B?cGVRNWdKdGhVQjhuNERYN3RJMEVLSjQ2bGF2NWpSWnVvTjVXV3Q2eStJZWp3?=
 =?utf-8?B?VHBjWjRkaVBSeFpjM2x6WlU1VUF6SHZ5d2lCaHk3ek81bW10U3M5OHZVejZk?=
 =?utf-8?B?bm5DeDRVelA3SVBHN2RDb2FYUFdNREViRnVwdUdMT1pjSG02S08vZ1EzQ3M2?=
 =?utf-8?B?RGN0aUFtUnZZNVBrRzl6d1Y4QlFaV2R3R0NNaEdsdFNSNXYwYnV1dWlKQWZ4?=
 =?utf-8?B?Y3dORDJNOGdaVG10OVBpTC80czYza3loc0ppcjQ3aVB0NFJyMTFXYkZtNWRn?=
 =?utf-8?B?em54aHltWG43QmxnYXBidkNJOCt5Vm4wenFrMWFTMVVCTHVJaXRmQ2NyMXJF?=
 =?utf-8?B?dEY3YmJXWjBsZWtwMW9XSVlpczlXVDBvTEc1T2FkZzR1TDVmZm5FWUFCQ091?=
 =?utf-8?B?NVZRSHlVMEd6TTVhZnJ4NWdPQTVtQUtWTmU2WklJZ0VqdXhMUndzS0JiRnRP?=
 =?utf-8?B?b0hUTjd4RmJlSVd1SlhmbmpRcEowWDE3bGw3SnRuTlhPWVhBNUR0UmU3Znhq?=
 =?utf-8?B?LytLeW1Mc0w4bHNxd3VwNXRRM0F0YjFFamYyZmJrd3VvMU5QNGR6VXM5Z3lX?=
 =?utf-8?B?c3ZXSGJWWFlMenZmVUorUmsvWDl2cDJKcVM3UlhOL2NlU0gwSkxuelNTVVg2?=
 =?utf-8?B?c25SZlNIeGs2NGlQMmtNemhFTUUwT3ZGbmFEQW91aTRyeHcyNjVZazIrU0pj?=
 =?utf-8?B?aFFVUHVpZEM5Tk5CMU5RRFhTcXVOV2VHa0V3Vm9GdVRqTjEvaHhOWFZJb04y?=
 =?utf-8?B?VkVNM09yNDJXWmdpVEJtMjU2MkVsUCtHU1JmOUQ3ZFdEdkxLVVl4S1BaTzBD?=
 =?utf-8?B?VHFNN0pDQTZiYjVqNUo0U2Z4YVJteEF0WGlUN1lqdVpYUGxoRkJxdDRmOWlz?=
 =?utf-8?B?cFVaa2l1S1VsazRWNFJtbkUzYWxPOElQQlNSc3BmbE53eHBmUnE4QlU5WEZl?=
 =?utf-8?B?YVltQVB3Zk10NXJxZjczTjAxWm4zemtsQklwRkZ0N3p0NEJUVlhHdXI1Z3Vu?=
 =?utf-8?B?Uk5RM2FNbXRVK201Vmt4UVh0YUxLMnorT2tGaDJmNEh6VmZvWmk3QWZ1U3R2?=
 =?utf-8?Q?5K4vS8HZTNpEKZZef+FQPtiqX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef72f35-7eef-4891-de6f-08dcdbead338
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:14:39.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEKMzGvt5ZxG0LK0XPQ3AkUlmUGUrqx3apd2ySGmPQl68KY0liNwQou3mS1mvvux7iSszJ8kNVOPHS7wMClZfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346

On Sat, Sep 21, 2024 at 03:18:50PM -0400, Frank Li wrote:
> On Sat, Sep 21, 2024 at 09:43:17AM -0500, Rob Herring wrote:
> > On Thu, Sep 19, 2024 at 5:03 PM Frank Li <Frank.Li@nxp.com> wrote:
> > >
> > > The PCI bus device tree supports 'ranges' properties that indicate
> > > how to convert PCI addresses to CPU addresses. Many PCI controllers
> > > are dual-role controllers, supporting both Root Complex (RC) and
> > > Endpoint (EP) modes. The EP side also needs similar information for
> > > proper address translation.
> > >
> > > This commit introduces several changes to add 'ranges' support for
> > > PCI endpoint devices:
> > >
> > > 1. **Modify of_address.c**: Add support for the new `device_type`
> > >    "pci-ep", enabling it to parse 'ranges' using the same functions
> > >    as for PCI devices.
> > >
> > > 2. **Update DesignWare PCIe EP driver**: Enhance the driver to
> > >    support 'ranges' when 'addr_space' is missing, maintaining
> > >    compatibility with existing drivers.
> > >
> > > 3. **Update binding documentation**: Modify the device tree bindings
> > >    to include 'ranges' support and make 'addr_space' an optional
> > >    entry in 'reg-names'.
> > >
> > > 4. **Add i.MX8QXP EP support**: Incorporate support for the
> > >    i.MX8QXP PCIe EP in the driver.
> > >
> > > i.MX8QXP PCIe dts is upstreaming.  Below is pcie-ep part.
> > >
> > > pcieb_ep: pcie-ep@5f010000 {
> > >                 compatible = "fsl,imx8q-pcie-ep";
> > >                 reg = <0x5f010000 0x00010000>;
> > >                 reg-names = "dbi";
> > >                 #address-cells = <3>;
> > >                 #size-cells = <2>;
> > >                 device_type = "pci-ep";
> > >                 ranges = <0x82000000 0 0x80000000 0x70000000 0 0x10000000>;
> >
> > How does a PCI endpoint set PCI addresses? Those get assigned by the
> > PCI host system. They can't be static in DT.
>
> PCI address is set by other channel, such as RC write some place in bar0.
>
> It indicates EP side outbound windows mapping. See below detail.
>
>
>                                   Endpoint          Root complex
>                                  ┌───────┐        ┌─────────┐
>                    ┌─────┐       │ EP    │        │         │      ┌─────┐
>                    │     │       │ Ctrl  │        │         │      │ CPU │
>                    │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
>                    │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
>                    │     │       │       │        │ └────┘  │ Outbound Transfer
>                    └─────┘       │       │        │         │
>                                  │       │        │         │
>                                  │       │        │         │
>                                  │       │        │         │ Inbound Transfer
>                                  │       │        │         │      ┌──▼──┐
>                   ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
>                   │       │ outbound Transfer*    │ │       │      └─────┘
>        ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
>        │     │    │ Fabric│Bus   │       │ PCI Addr         │
>        │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
>        │     │CPU │       │0x8000_0000   │        │         │
>        └─────┘Addr└───────┘      │       │        │         │
>               0x7000_0000        └───────┘        └─────────┘
>
>
> This ranges descript above diagram Endpoint outbound Transfer*'s
> information. There are address space (previous use addr_space in reg-name)
> indicate such informaiton, such as [0x7000_00000, 0xB000_0000] as PCI EP
> outbound windows. when cpu write 0x7000_0000, data will write to EP ctrl,
> the ATU in EP ctrl convert to PCI address such 0xA000,0000, then write
> to RC's DDR>
>
> The PCI Addr 0xA000_0000 information was sent to EP driver by use other
> channel, such as RC write it some place in Bar0.
>
> The 'range' here indicated EP side's outbound windows information. Most
> system CPU address is the same as bus address. but in imx8q, it is
> difference. Bus fabric convert 0x7000_0000 to 0x8000_00000.
>
> So need range indicate such address convertion.
>
> >
> > If you need the PCI address, just read your BAR registers.
> >
> > In general, why do you need this when none of the other PCI endpoint
> > drivers have needed this?
>
> Most system, the address is the same. Some system convert is simple, just
> cut some high address bit, so their driver hardcode it. Maybe imx8QM have
> first one, they have more than one controller and address map is not
> such simple.
>
> We use customer dt property in downstream kernel, but I think common
> solution should be better, other drivers can remove their hardcode in
> future. And it will be more symmetry with PCI host side's property.

I found a more simple the method, will post v2 soon.

Frank

>
> Frank
> >
> > Rob

