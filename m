Return-Path: <linux-pci+bounces-23657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50293A5FA3A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDD43BF04F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571F26A094;
	Thu, 13 Mar 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="khYizf/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A8269CF8;
	Thu, 13 Mar 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880361; cv=fail; b=Ftni6Ek2O1j/rZThUoUnO+buh/5Fl+frXbr9n/EIoDIR//s7Is6inOj8p8QIiWt3MbQ0XbSv44rMfbNAVWQAKd/4w5nIIkaTHrM7LFCiD+qdNCW3PTpdZLGz2lsaaTeZo58XKPrEouFC+U3+uI3RcKum1mb7fBEuLXBp6f2wKeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880361; c=relaxed/simple;
	bh=NZ7yCNLObw1oa719Qp+QmFGXAN1d3NI6LNiebuIMyWQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uSg85uEzKef0b1u4ZC6m+a1OCIJRPpCyk4sbaSJBtD6X6B8Phjdzr9V7dJgGQ9/B/0dvE8XPg66ep3N56eeWXG0GjidwmtiWDrHuIbGqaSSJ+v1TqSZGVCBrLrKj5/QqiO89Kz1EPEC7NS5AqKxm0nUNgr4OgMlUoxCwD6XJaPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=khYizf/s; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEVXlMKbrAoKJ5uXpR9N7BybdJMeVsTxo0PdGofbz2zfSsSWP7cY2axBvg150KpZ/eaEDzjVCaHYiAeZKvAwdMkTlPZCCiI3HddF6FYk12dds4mvcwk17PfB4A1jYol2id8IjizWDO/qw0sIDwKbh88Odp6e9bc4SxWaoJSDvbg11weRzDu19Z6dhGYrcJNRZlP5FWBpWvB0m5C0Gnu092AIcbkAXPsnwaclO1TsDaMauB6ZQ4iKd90xMSSsw2nPIjIrkknsw7AO043RDZ6LGtWUpTbhPozdI6IgdVVQweJ+1HVXjEfZr9H24FhzLNlPRk4EQX0tI8Zb3Q32nDGfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOfBKRRfaGBGa5Qzq4aqysziCpQia2/6D92XcGaeJF8=;
 b=MrwISYOGj5q/MFRJ63A+hzBRFdYtWYNpbsPbomnJ1cE1VMXRkAK99/qR+on3dL47c6C4ntDQ7zQmi1MA31BtFctJ1SKmg+nWqlxQjunGtfW+FHD3v3y2Pi4T+RB2PULqBcYZkCecAIKoiHozVqaPRxhTdOOKeDKZF9Q+7AIq/eoZpkYr4qH99aaA7sCV2jUuKBfvZd2LjXDZNdgteQDNcmAzHJxFMUPSNYAO8vXQw6SOrhQ5Mlq+7zKSZt6POi3EPwu+B/MM+uTNPSAAakMZHkjfs1oEsn5WX6b7hW55IHji2Uy/KNMJMbsjWqMygIEZDWja3sCTLqSRCEc56MhQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOfBKRRfaGBGa5Qzq4aqysziCpQia2/6D92XcGaeJF8=;
 b=khYizf/saHWL+5GBOxINlvoMP8hXuxR9j8oLwlih0wJATxxjMWa1l/8xn0qV2hvz+w94Otvg0EKhsQtU9JVBOyfxw+UbDy7Ph1J0lUWx8E+Q9JOricFxR1AyGjVz2mhCmSmOmI9d6QKeg146HtC/4S6edbAg6rY1+l1qZH6R1UPMcLPN09vU7zzFS4HXjWIOUBhrxX6QO8UAhaDjVamUs39kEcYSjgRT30cFPJ45PMza4Nio/fGVdXPl2S7nl/9GBr8LukP7hv6+q3sD42gbTInpsYEyKMROnt/d+ByEgu8cJCTB2nvRqaKVICB/ZT6PZII1Y8Q+SCSZVeJKVSYCRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:41 -0400
Subject: [PATCH v11 05/11] PCI: dwc: Add helper
 dw_pcie_init_parent_bus_offset()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=5220;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CAZQ8hzaJMLFQywBKM/Cdf0akVJ63bcoavHcEFXFDYo=;
 b=exG7uAmmXILAEW7Yr6sM5bkARyDOky8PmiUmGOu2CVUllkR43Zyi8H/TstZZ7k8ZgPdgR+Yz/
 Y0iKdubZ01VBRyP+jhRQ/JYgUTauP3GwKFlW9oWY8mmSApYMQ9deCtU
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: be26cbb7-65ef-492f-acb5-08dd62453618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTMxKytxdDEvUTJUUzlIb3BLOXQrM1V6MlpFSk1kNzZDWVEvQ05CNGZ6Qktz?=
 =?utf-8?B?b0JPZ2ZIWG5VSlBQaUJYR0VSdDhjS3orb2VjYWdNNTFSOFB6SklJMHo4N1Nx?=
 =?utf-8?B?MzhGMFBHekYvcDBaV1MvLzhNUEthRjdnL3lIR3FxTlpyZEc1UjlOUDhIOFBz?=
 =?utf-8?B?dFRrbUFQM1hIOGg0NnEzN0pBRmVhSVNEY0ZzSC9rQ2tOVkpQd1JDaElybHU5?=
 =?utf-8?B?c2F5aE1ZTDBxbTRHL0dpK3VITUU2bHVMZ3UrU0U2emVuV3ZCSlhBcDVTOXcw?=
 =?utf-8?B?Z3NPOTVIaHJ0ZFp1MW03S3ZQN2l2c3N0TFloNlRRdjFKVzNsQlNmcmdJVlpa?=
 =?utf-8?B?SGg1eERIV3BGdEl0c1NhakVtMzU4ZTZENHB1TEFvOVdMYkFGNzFkOTNNa1hI?=
 =?utf-8?B?d2MvODFDbUJmRDdJTWVKRmF6MjJPTTI0eFFxelZIKzNzbUNZYmxJRVlmWCtz?=
 =?utf-8?B?Z1J5TkRnaWhOa0FKWUh4S0N4eFpISndOaHgzTTB2OWlIUHJydFZLNkJYcUFP?=
 =?utf-8?B?bnhSRDBHMFI4emNYZ2V6RmdlYkc0MVhUUUxUWVJSVzJpK2s1eHl0SlhoM1lG?=
 =?utf-8?B?QzlDOVpyZVVTZllINTJuc3VMdU5idTFoOW40WGF6SThVbjFSYkMveVRhNGQy?=
 =?utf-8?B?STB3T3BYN3VzeDF2ckRhVHZiaDduYmtDdmlXMWZ3SjNLQmsrRjk1RU16cXIw?=
 =?utf-8?B?RzlCZ2gya1ZycHRwYlhDa2FQTXRMTkJyRlBvRm9CbTBxaWNhczM2R29kOTBn?=
 =?utf-8?B?NXlzdWR2UkRXQUlIcUYwRGN2dFc1WWVkUVdCSkgvWHllbUd5RVJ4L0VvM3lU?=
 =?utf-8?B?dTNzTWFmamFTeEV1SkljRDVad2t0ZDRvTGphSklGSmg5VXMzc0g4cFFkZXJ3?=
 =?utf-8?B?TGdPRDFXQlFkSU5ldEJKUEFuWFBNT0hackNGajZuWUFTYWRiSVZ3a0g4c0Ny?=
 =?utf-8?B?YUtaeXplUmNWb0tBOURia2RkL2k1Z1VIRVRjb2pMa095anNDOThNb0ZaR1Q1?=
 =?utf-8?B?Vnd0cmdKOWlkL3EyVlplRWZkVmQ1Qzc4M0hjbmIwRHQ3bzlsWXcyM3NWRG8r?=
 =?utf-8?B?V0wzTlIxa2VwZzVMWlM3OFM3aHN1bFBxenRJL2plalVHWVpLb3R2VWF1RTEr?=
 =?utf-8?B?Q2MrdzNwbXJicmZTci9hUkIvOVJxVFpoTkdhZ1FKUzZQUWlTY1dZcml3Qk85?=
 =?utf-8?B?VGFjR3gvR1doRG14UUpTYTVFclFWdWp4RVJ3cHNrL0FEcllrZGFiZ2dINTNT?=
 =?utf-8?B?b0ltaW84Q2hXdXhHYXBYU1ZpV3JYVHZXVFBxY0VoS0xRMkhVandkbFBQN2Yy?=
 =?utf-8?B?dlJhUkJ1dFYxaVdYNXcyYzN0dTJPNktzUTZYS0lzSlRZUlVweFJiVmpuR2hL?=
 =?utf-8?B?dG51OXJZR2xFSWxhK0x1TnNNcEJzZXFuUDlPMVR0SHRmK0tNM0NTb1hhV0xU?=
 =?utf-8?B?Q3lFcVpMcys2UktHbWp2NHE0SkVUbFZwVGYxNVlSdlNSRHk2eU9Vem5mNFpt?=
 =?utf-8?B?V2VHZmVnbVFIM1NoQmtCV2QraktjZWRaOG84UWd1R2lIMGZNbkU2VHBQUkNK?=
 =?utf-8?B?cFIwbnUvZ1JqT0lzMWpuMHVTdG9rRFprL0hDVWpPcHpUOG5sUGcvSS9aVFRj?=
 =?utf-8?B?OVl4dUJOWlNSVTBXZ0VMRHh5TW4wVGdmNG1Pa2dpci9Dc29lUDF3T2l2akxY?=
 =?utf-8?B?dnJGdXoyNFpneHBkSTJ2RVN3M1NORjY1NENoV0R0d1NseVFBZ3ZMY0hWUjY4?=
 =?utf-8?B?YXM5MTVTY1cwYUFtbFl0TFo2VjUrcmNkcVZGWWVRMmpFY0pKdTZZTThzbEt4?=
 =?utf-8?B?RjBSR2taQzVDbCs1czdxbllIZHpiNzliL20rd0lHOElsdzJxbHR0NXZMV1Vx?=
 =?utf-8?B?Qy9ydkduQmF3enBKd1JiWDQrQ1dQU0dhUWFoVUxOck80cFpqTW5xc3VjNUdW?=
 =?utf-8?B?SmsvenFmWDdJelVTZ0lBbk56UlJNS0kyRlgzVWNHK01UcXBXVVVNdkhTN3Vn?=
 =?utf-8?B?R3d3TEVhaGR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWF3dnZrUWJ1NE1jandoWC81K25SSjFhTlhVVmhZRDdEdm9xbWdVMGxjeThO?=
 =?utf-8?B?bEVFM2tncmpBYysxcjl2dVJHc1VHY0ZnVG1ZTVozZ0Jnc2htbFZwNnBER0dj?=
 =?utf-8?B?d1VYQklXSGcyc0VxblFjNGExdng4Tk93Yi92dVE0SzhLWERNUnJidkhiVWJZ?=
 =?utf-8?B?cStyVXNIQTkvcGV5cjRIWHRRbzduQUJHYjFwYUxDQWY0WGVHb3JacmxTQUND?=
 =?utf-8?B?ZGlHZzFZdUxhMVFlVzNzYmY1Ti9CVzUwdk1MUkFiU0hCVzVORThweUtOSjZ2?=
 =?utf-8?B?ODlNdmZlWElISjUwalcyWTExWFp2bmY2Q1hpVk11L2ZNdzdXK04waVhXQkdp?=
 =?utf-8?B?dmpHM2VKTlBKSjVldnV3VGRVL2ptVisvTDRJNE84MmhWUFlFNnNhN0VyKzV6?=
 =?utf-8?B?RFIrVUJGT1Z1UElEdkI4d3RDZ3ZqT0Z2cG4zdmxheW9ybThRS0tRMk9ieUZ3?=
 =?utf-8?B?SWdhb0FWOGw3NnAvU0JHVFVoMTA3eEEraThxZ3ZxVWtiNEVQN0F5Q0d3b21B?=
 =?utf-8?B?UXVnMGkwRmtUeFBGTnBTRjhWTmJ5WXZtaldhbVI1azZOWndLN2hFdmF5dG85?=
 =?utf-8?B?QlZSSC81OU90ZktxUVpIVTdua2VBUDhJekxjSTJwQ0pQZzlWRDd1SEloYXRr?=
 =?utf-8?B?cUJSb3dFY296OGc0TXNTVE5VVFpsUXNhdXZXT2RwYzFoeitwYkU5TnhWM2Qy?=
 =?utf-8?B?UkNvcExvUlhZNUFtYzQ5Q1N1b09pWXRERzFIa0I2NkJ3U0lYekFjT016MVl5?=
 =?utf-8?B?cFhHclBzdGJycm9pM1VvcURjRHkyQUE5Wlh0cmk3aUxHams5TkN5dFUxN0kw?=
 =?utf-8?B?dXd4dmZ2OEgzUExocWUrUWtDM1cvQ0JxTjNTZ0FsT0N2VjhsUFFVbHE3YlNm?=
 =?utf-8?B?SVJDV2FNSXVNcUNScHpkcEtxVUdZS1dCTUcydFArOUc1KzgxVHhyTHI2K0xG?=
 =?utf-8?B?aktnUmVwQlRSeE9zTFQyMDk0TDE2bk9FdDdaYXVqRW42bHFBWXBNVXBuZ3Jh?=
 =?utf-8?B?QmlQcmJzenRZcXhia2FJbUkvenJSaGRNcjFtUlo1K0NEZTRha1Ayc2IyajIz?=
 =?utf-8?B?b1hUbk5xa0YwN0xZSG1ucWxNWU5nM0dBQUdzdzc1cVBMRVdyWGRRbGlHWVU4?=
 =?utf-8?B?SmVjMFVRUmNEN0dWRFpWdVpSL1lsY292YmlTcU9jTFgxMy9hU3A3ZkVQV0Ny?=
 =?utf-8?B?cWd5SUc2ZVJmU0JJd3VQdHFOeTFQc2lTellzbzIvL0s3YzlZZFNzYllBM1dW?=
 =?utf-8?B?cDJ0OS9FY3lCRlkvVUY5eTM5STE1bnFPa2s2cHVsUGlXeThDUjQ0STV1SXZp?=
 =?utf-8?B?ODd6TkdVZGZPZEdkNzdvdkdnSUZ6YVZaSEltY1VhMmpFQ29qSzhHY1lSYURJ?=
 =?utf-8?B?MjN1UDhLVWk4bjNTMjhDTzZMRUppcmxnNnM4WVg3WTVlYW9ZeWJSRnZ3cHZ4?=
 =?utf-8?B?SmtBVHVMSkNoTk5hZmdKK1lNYlBWaEI1VzRsU013RUtsTEtITXFoTGlqbUEv?=
 =?utf-8?B?UWM3Q3V2Ykh6VEVyYmZGai85NHFMM3JmZmFQNWRqVjIrV25zYXI2R2dDUmF6?=
 =?utf-8?B?Mm5XYnNXWGwwV0xNRXBwV2M4RnJ6S3pLL1V5M0kzK0Naam0vMVBrUmZTMHlR?=
 =?utf-8?B?cGI3SzdSMzUrcVZCV0g1NnhDd2U4K2l2bzg3VC8rWUEvVWxzckxjVzIycjdC?=
 =?utf-8?B?WGJCekJ2WWd5T21KamZOQjRLZGg2RUF3NFVIei8veHJPSVc5elhXWks2S25j?=
 =?utf-8?B?R0tZVFhPS04vdU1nd21zY2cvU1hjK1lFb1lxNEZQWDZ2aGtXWnU0Y2JkR3VX?=
 =?utf-8?B?Nzg3ekNqSS81Z3l5bm5RMXlkaEdPQ05OZnRzMFVlTGhqZFVMTW9oZUMxTHVi?=
 =?utf-8?B?eEFyYUNsZDZja3dWR2w1d1lrbnRFSTdsUlZ1M0h1elZucnFBeVc5S25VNXlk?=
 =?utf-8?B?MWtyaTcrMVpYM1dUNXBoMTJlSXhSTklsTm9KS3o0MFV3T0RwOHloR1pZd1hq?=
 =?utf-8?B?YW10NGNMSWp0aU9wTVBtT1VNSXEvajUybFB2eVIrZnpKOGVYd0kxU3pjMEpB?=
 =?utf-8?B?QVBzc29DeDJJVDk4djV5UEd5bEk5VEZwVVVTeWEvbitmODZabUVoNXVxK085?=
 =?utf-8?Q?q7rMwt4eO1sznF0ZNZvent5U7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be26cbb7-65ef-492f-acb5-08dd62453618
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:15.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f7k8J+eFdBC/xJNNXtwfvu6FTneeNHIKqeW3gX7iVMsqxXTss0zgPTvLkJy4cZZs7bNru+6Z0ZHCKU84PNLUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

From: Bjorn Helgaas <bhelgaas@google.com>

Set pci->parent_bus_offset based on the parent bus address from the
"config" (Root complex mode) and "addr_space" (Endpoint mode).

.cpu_addr_fixup(cpu_phy_addr). (if implemented) should return the parent
bus address corresponding according to cpu_phy_addr.

Sets pp->parent_bus_offset, but doesn't use it, so no functional change
intended yet.

Add use_parent_dt_ranges to detect some fake bus translation at platform,
which have not .cpu_addr_fixup(). Set use_parent_dt_ranges true explicitly
at platform that have .cpu_addr_fixup() and fixed DTB's range. If not one
report "fake bus translation" for sometime, this flags can be removed
safely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- add cpu physical and parent bus address information when no equal
- remove "Using this flag also avoids the usage of 'cpu_addr_fixup'
callback implementation in the driver." for use_parent_dt_ranges.
- change dev_warn_once to dev_warn because only call once.

change from v9 to v10
v9: https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-4-3c4bb506f665@nxp.com/

- use help funtion dw_pcie_init_parent_bus_offset() because both EP and RC
use simular logic.
- still use use_parent_dt_ranges to detect fake bus translation for
no .cpu_addr_fixup()'s platfrom incase block exist platform.
---
 drivers/pci/controller/dwc/pcie-designware.c | 48 ++++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 12 +++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d0a5f75effcc..f17a25fe55a5b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -1105,3 +1106,50 @@ void dw_pcie_setup(struct dw_pcie *pci)
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
+
+int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
+				   resource_size_t cpu_phy_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
+	u64 reg_addr, fixup_addr;
+	int index;
+
+	/* Look up reg_name address on parent bus */
+	index = of_property_match_string(np, "reg-names", reg_name);
+
+	if (index < 0) {
+		dev_err(dev, "Missed reg-name: %s, Broken DTB file\n", reg_name);
+		return -EINVAL;
+	}
+
+	of_property_read_reg(np, index, &reg_addr, NULL);
+
+	fixup = pci->ops->cpu_addr_fixup;
+	if (fixup) {
+		fixup_addr = fixup(pci, cpu_phy_addr);
+		if (reg_addr == fixup_addr) {
+			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
+				 cpu_phy_addr, reg_name, index,
+				 fixup_addr, fixup);
+		} else {
+			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; DT is broken\n",
+				 cpu_phy_addr, reg_name,
+				 index, fixup_addr);
+			reg_addr = fixup_addr;
+		}
+	} else if (!pci->use_parent_dt_ranges) {
+		if (reg_addr != cpu_phy_addr) {
+			dev_warn(dev, "Your DTB try to use fake translation, Please check parent's ranges property. cpu physical addr: %#010llx, parent bus addr: %#010llx",
+				 cpu_phy_addr, reg_addr);
+			return 0;
+		}
+	}
+
+	pci->parent_bus_offset = cpu_phy_addr - reg_addr;
+	dev_info(dev, "%s parent bus offset is %#010llx\n",
+		 reg_name, pci->parent_bus_offset);
+
+	return 0;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d0d8c622a6e8b..bfed9d45aba9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -445,6 +445,7 @@ struct dw_pcie {
 	void __iomem		*atu_base;
 	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
+	resource_size_t		parent_bus_offset;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
 	u32			region_align;
@@ -465,6 +466,15 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * This flag indicates that the vendor driver uses devicetree 'ranges'
+	 * property to allow iATU to use the Intermediate Address (IA) for
+	 * outbound mapping.
+	 *
+	 * If use_parent_dt_ranges is false, warning will print if IA is not
+	 * equal to cpu physical address. Indicate dtb use a fake translation.
+	 */
+	bool			use_parent_dt_ranges;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -500,6 +510,8 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
+				   resource_size_t cpu_phy_addr);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {

-- 
2.34.1


