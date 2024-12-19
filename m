Return-Path: <linux-pci+bounces-18812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B99F84D1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FF2188F83A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D531B4F0D;
	Thu, 19 Dec 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e0fVAMzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B01A2C25;
	Thu, 19 Dec 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638123; cv=fail; b=D/k4TJFLzHxx/zdfCldjF1Z7T5X73AE4mA2iJ877LL/ATIUnoop2LTBvzf+Ftl/eudc4jRxD56vnovTOgLe6w88DS5fQG3pN5sdZ+GANkbz8ZBtHNbAHHJk3F9EdLgOliDF7xlh//WKSrSyyGZxzAqmYTXjG83yLIMbIFYxKVr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638123; c=relaxed/simple;
	bh=PAom8zDVTMNmUhEoowWBcbAD0keu1gPes4Wq8hfdcbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gWuJEcnCotQU483D4LwIbn2nCISuWLdnNNBm+HWy5h/xIi/Wz4MQM5VVbcwaFo9yCC/Vwt6PW02gFlfMCg60VKi2vqVcMej2to2vYZH7FTh5npPnx3fqN+9NkoFDzlcJ/hdlTUao5mhx6Mt6ritoW5OVjWFDkqHU391khNMZLZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e0fVAMzV; arc=fail smtp.client-ip=40.107.249.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS0YlWEY2kB84q6WS7QrzeBl5XT+nZeaGgOoPRIseul5ZTzM2K72AB0TLwYDHtRzBOm8fdanAO8GIO2xSWgPcO61GqkCquc6cVKvOcqdx5hmnKhZapx2OphjE6lduXeCxggZ1nBNK8cS13LUhfuFsafwXJTifnVQlBvpLR2ZjANCm+lxD2EjG47wRSXoaoWo9wuxm04t2oZn/xsnfjSTSbBM0epEbJIJ3UfLnrquJqpsIkUaijXFxcfXX624uA2V5V5sy0hiYvz5k4GM6Cys/UtQb45gxOxt/8iUPV8WNVYHbigEypkfvK4KDSGRxu+JTvf0YS/rPLehjEtmKlcRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv30BUhl2KrUk+ioQQ/VXBgYHRBVaTXn2u8ymnam/0M=;
 b=OCAr+HWUAA3unfU1A6xKmHXOBeME5Ro3sFvwWBRUsjP6h++ux97BfOPO/o8l/fRjzghoSW+uMip+TsgEc/UY4MsnDyQMhaeHBHE1N8TVplNVw1UYFOdzmM598wWvNx5ZoYKMUR1AL2du15Qydl4QR/H7qRpcB9ZoM/5k+Pxok1ZOVlNOTltJjwkYit08AAkCOcQiBEH8zO0jUz28ke4nkzSlcVeh4p85A5mdoZMalEN9+d/BcG4wZcUNRaYzNvvPP35cNeCLbuhNhn2pK+D8idwnxjLJigAQRt1w5vyCxX+lt3uy3XwZZTJnPObQ9wmWahCW48yhLbbqM3ZCQ7vUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv30BUhl2KrUk+ioQQ/VXBgYHRBVaTXn2u8ymnam/0M=;
 b=e0fVAMzV7vrYvoAba54Feyc2WyBDgDzOHSaO3R8O0oZYkYjl8Q3117lAxg0KFyc3LNHIfWXYvRfRouKNirIWI8g4tf+6XYASfO6hwTM3UGEqiLA8K96OA/TuNuvMt1HRxOuiOLcgvVnbG59uUvSTaIo3rnHl9o9SI2DG9pdwtz5APXAF7+Ui1y+FEwaADQva8KLwNdtTuTcovcslUo5Jg0/bB1lf+0REU3RmTc9gEPyHSPevIQpVTtg7ASZ69qDBftrmLx46S1F4/kI0ysVjyte7Un1hs9Ht7GGk0+gUIJ6VcUotxGqlcwd0VO4ITkfButtmSeMNVyDnhtvra0+iaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU7PR04MB11139.eurprd04.prod.outlook.com (2603:10a6:10:5b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 19:55:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 19:55:17 +0000
Date: Thu, 19 Dec 2024 14:55:08 -0500
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
Message-ID: <Z2R6HET6FZEO+uwi@lizhi-Precision-Tower-5810>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
 <20241124143839.hg2yj462h22rftqa@thinkpad>
 <Z1i9uEGvsVACsF2r@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1i9uEGvsVACsF2r@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:40::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU7PR04MB11139:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b90485-1b9b-4157-def1-08dd20670fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnNRVmVaWEl6czNFcXpEV0Z6ekhWU3lTdVc3MWJMVnhacGhCekRmSjR0b2lP?=
 =?utf-8?B?SlhLSXRGNkpibkxwT3hwd041L2JiakpvU01PKzZCL3gwTTZkMDd6QTRud3dL?=
 =?utf-8?B?ZHFXMk5EcEFJb2tid0lScERKdHZBd2Z2ajlaT3BOeTFrTEZPc0FhRjN6alha?=
 =?utf-8?B?dUxSQTFVSWxUSnAvYWxQczV0N3Y4ZUFad2JldnFXRXI4Y01Mb3VuL2ZmTEIv?=
 =?utf-8?B?U2liYmhPQVJIbHlrbWVHSFBoNFlBcjlibFlWS0RWU2J3aHZhRm1acnJ1QTJV?=
 =?utf-8?B?QkJXZ0FUSDRrb2V4OForM1gzb3k3Yy8wOTYweUVOS1RzSmQzekgyeVlkYWhW?=
 =?utf-8?B?TUM2dVBZdVpoTW1IUTdYbVdQTHdvbFJacnRQN3g3M1Fob2JiUzZtNExSTDk1?=
 =?utf-8?B?elVsY2g5MDREYnZNZzE0VlhWL3JsZkJDQ2lOL25JT1pxUE5DcFVGVjdGNHJM?=
 =?utf-8?B?T1Fjb0Y4UElpcVRIcXhwNys2ZFpLekJnN212UjN0cFNycXpVMnVZMlU2Rk14?=
 =?utf-8?B?eHduL2wxZkVpdlYweE1jOHlOdHY3N0ZDem9WWTFOYmh2VXZ0VE8rVUFVUmp1?=
 =?utf-8?B?cE9OcXV1dm9WTXpHWk02RGNVMk54elNWZXhXYTRUY29zUzRqMEliNzhqRDRG?=
 =?utf-8?B?U043RklmWDQ4aENseU02Z1NDWEJrUUVaUTZFbGNOS3FSWGd5c05yYlJ6djdq?=
 =?utf-8?B?WGk1TzdSSU5qUTdBNWRHNUFOb3J0TG1UMS90SFNITWZFWkpRbjhWSkttYUJj?=
 =?utf-8?B?V3I0cWRZTzBSenNqYjQ4L1MrTzh4dVdZWldOM3dXQmdtb0ZtZEEzcmYyRHFi?=
 =?utf-8?B?ekpKUmJ4a2tTOW0zZlVKVG1CQ1VLMHg2UzNwRy96T2hwOHlsSC9KSmxTaVcr?=
 =?utf-8?B?dUxRY0UzMlVMSlZQZ3RWMnh5VmZFN0J0LzN5dXlybW9UZDdGQ2NDdjR4ZVNM?=
 =?utf-8?B?N3pBL3RBdGFBbGlPbElZOXBlSWkydHVBcW9HSmFwTjBiUjhiQWNwaG05ZHZL?=
 =?utf-8?B?QWJQbnlqQVJVMGJaY3g5RjZ4N0o0RVBlTnFLTEZJU3U4RUZUbTZOT0N6VThE?=
 =?utf-8?B?TzAyWGNWM2h4UHk4T3A5WWNlOFhmUXNHeXFPVjJqUThrdG42S0R4WE11clIw?=
 =?utf-8?B?OStJT3lONmlkVllYTjJJMzk1dlhWWmRFcmJsMjdkOVV0bzVaNFBmWVY4RmtN?=
 =?utf-8?B?VHN5M2R2QUpPM21NMUZ2SDJzZUF4QnlKQUw5aWw0UlozR3ZrQTRWRDV3b2J1?=
 =?utf-8?B?dXhmNnhaSE9oemVvbVZId1VGRTN3MzNndll6U2EyZUV6WUI5VUtCMVg1d20w?=
 =?utf-8?B?SDRrTldMRmYzblhQejBzODBPYXRWN2RCOWgrVDNsMmNCQ1NpU25yWHA3aU5O?=
 =?utf-8?B?Rjc4d1FOU1ozc0I2dndTUXRxZkJrZC83VmNzL2U5RzZUV0N5a1NmVlBsR204?=
 =?utf-8?B?YmZJbURwVnJwekh5a29RZk4wckFDUW12eWFmZ3hoVzdsVFB0UmNhRUNRdzI2?=
 =?utf-8?B?empkNXE2eHRWMGdSNU9MVVRkeFhkdHA5Szg4VkE3bEVPQ24xeUtJdC9CT0R6?=
 =?utf-8?B?UGh2ZFl0ZC9Eajh2TDIzMWt1aG1TYWFDaDNmMVQxSFdVQm1uSmd0WFE1bHEw?=
 =?utf-8?B?VUpqdlVPYXF0cFRLOXZqMHV3U09EVlR0cEd1UlQxM3JPaWluWTVmUzhYeXBl?=
 =?utf-8?B?N2NjRFhNd3lldFpMU1pOSFc4b0ZwbkVLK0tsbitjRTlaQklpZEZLYXpYRWk5?=
 =?utf-8?B?RC9pMFhzc3pGMDlGUXFYM1JicUhUaU90YkpBU1N3cmhTZVp3OGFmQkxvZHg5?=
 =?utf-8?B?cmtuT3RqNTJUV21LaUswdytDSlRTMEpzRk1qdEtwNldkMFZ6NlRjNkFtS2tS?=
 =?utf-8?B?VXBNU2FBZ0ExeW1lWS9YNWduOTRlbm1OQ1ViQ0ZRYUtMTytPRUxwaXJMb0Nw?=
 =?utf-8?Q?fXMGyWAw2w6Ibr7/OWAE9AOsrT97qYWD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTVLcmNQZ2IvZWdOR09nWGtlQXMvRTNBRWdQanBwYUVnL0l5ck1iSzdEUndu?=
 =?utf-8?B?MnVyNXVLdHdCUWZZc2pOQS9ITTdjWEErVUJHWEVhSlpRTkdjUzZ4Q25LTU1S?=
 =?utf-8?B?MmdtQzBoNGZYTXF1M3lUaXJ4Wkh0bGpBUHRhVVpzY1E2cEVXa0FqTVRFRnc0?=
 =?utf-8?B?MVhvMnlaL1lVRy9zd1Rkc1BmZXlmc3ZpNWVqa0xCNmM0ZGdBVG1iamN4QTZT?=
 =?utf-8?B?TUJjcHVnZXBNT29OZHRPZnVMOEVHMnZLeXRvYlJXRVlVL05kajFkVTBDRzJS?=
 =?utf-8?B?Rkl1TGhXelp5bTIzRXIwOVkxTmY4N29mL28zTzZLLzNibm90dFN5ZjJtSHhw?=
 =?utf-8?B?TE9SWmhSakJUUmJTMTlKcUV4Sk9tMis3TzFFajYycFhkRXBrN2wxdVU2REdr?=
 =?utf-8?B?cCtVc2FwblJFWTFiZEQyL2NRUTA1b1lEdHV0ZmQxSCs3Sy9hUG9MWjBhZ1dH?=
 =?utf-8?B?bmFLMjRWUkJUaitCVCtXTitSOGVnUU5NQU4rZDBKYUk5L3BzMGpJenRqalpj?=
 =?utf-8?B?bHBPaHNCU3Nnczk2RDVCeXR4aVhFMWlPRFpGUmtTT2JwcWR3bjVuMVpUN2lt?=
 =?utf-8?B?RFcva21INHJIYWt3NlRLcnVxNUkzNHIrZnFSd3B3a2JpVjZlb0hEZy9wcjc4?=
 =?utf-8?B?d3VwY2VWVmE1c01MRmVIV2NWSzBzbmxFcVJjb25LeGZZMU5LUytza2M2UUt0?=
 =?utf-8?B?WVh4aGJwOTYvSWlLVkg1VEJ2K1RPSzVsaGFGQi93anFuYWpyV1BPbFFnbkw1?=
 =?utf-8?B?RzlqcUc2RWtqR0sxaXVkZ2V5VVhyVS85STVsNE4xMkRkb3lIbEpDbEg0ak40?=
 =?utf-8?B?b01jSmYwZnRtZTVyTTcvQzJObGVCY1dHZ1F1aEdDWUIxaU1RZkk2NDY4NHhm?=
 =?utf-8?B?WXBPV1FtVmlXdlRYeWU4UUlpUGZqYUp3TE9lWXRBZXltOW1OaU91a2FpY0d1?=
 =?utf-8?B?bjVIeXlrdUNNN0RQdE1XNkF6RTVMOG9SMmVMYXR4L3dodXBPbU5MMHYrY2xh?=
 =?utf-8?B?ZUVGWDlybEx1Y3RlWmFqeHFEeVJ6Rlk4ZGpZbCtCd2lJUmpjeTlnUHBYNk4z?=
 =?utf-8?B?N0RPYlJwM2pvZE9CRzcvUHNQT0RxcFBuYXBQMFYrc2hMTDZzMGNhY1Noai92?=
 =?utf-8?B?U2hXazcwZWVWNnp2SXpPc0pUR0ZDdjdaRjNLTWd6c1lXaDVwUmQwVENaZjd5?=
 =?utf-8?B?M3J1SjVhVkZuWWF2bmtnQjRKWmM3UFZ3WVVidnQwMlliNHRxVXdLTmIrYlp1?=
 =?utf-8?B?NUdmbHFHaStyeGw3eG01MnYvdmI3NGJKekwybGp5NWcvdUhPNHJ1Y1hYeEgr?=
 =?utf-8?B?VmZ2R21ndDZ6bmNHMWxPemthMlYrNFB6Zncwck4zaGNMMGlxUW5NMWZEQjFv?=
 =?utf-8?B?S1AwbFdONG1ldmR0TjBCMmliZ0FMQlNYYlhNaWhwM0hDMHFUNWhqVFdDYW9N?=
 =?utf-8?B?RWMxSXAzMnZMUkMxYnlIendjQVVuc1o2dkNoRWZpN1d2TnFZZERGTDFUZFAr?=
 =?utf-8?B?dmxiZkQ0YmQ2RWNOSlY1MWphblN3b29jTVpkTW1uLzF0VGhYL1ZSYURjTjhD?=
 =?utf-8?B?bnY2NTFIVkdiSFpoK3JpYU1aV3U0SGZSVjRscmh3QklhWUV1c0thcXZ1TG1u?=
 =?utf-8?B?Q3hGY0t6U3RTbndSeGVZVncyNnNLNithOElkaHZCeldLQkpJdHVZejBLOHJs?=
 =?utf-8?B?V1hacmgzZmkwa3RWRjNMVkhreURGWFVVeFByZGgweFR2Y01XSFVRejlFMEhC?=
 =?utf-8?B?d2Q1cVJHR1hiNlJHQmRzMUJlbGJzcTdIM2tLdVgwOGxmVWxoYVI2OTIvYXAz?=
 =?utf-8?B?Vkgwc1J6WlI1Q2FBZzBVVTZtQm5ScFRTTFJxTklOMk1yUEpMeFNGU1BJdGtm?=
 =?utf-8?B?SVMzZFVhSlB3bGg4Vkl6RWhrcDV0MHdhVm9WR2tiQnpZck1FS0MwS3o5MXJ1?=
 =?utf-8?B?SGFENG9Yd1R5b3JPZFVBSzFwd3NWSlBKU2dUNk1HSkk5SGFWdmI1ckw2S2RZ?=
 =?utf-8?B?dyt6UWxCTVEyRTJ0QXZmbHRETEpZdUR6V3JTTHBqVmFSMjJaNHVmVXRUdVBZ?=
 =?utf-8?B?NkZtNVRTUXNzTE4rNEh0ZHlkbmRkQ1EweURmdWFER2x6VEt3VTVkME55ZERH?=
 =?utf-8?Q?ARIKv5LoDF4dfIH91Nq2oDdGS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b90485-1b9b-4157-def1-08dd20670fc4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:55:17.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS5Q1KFYOtBWXdhsHNnGR62qiExlQ9D4P12K1SgCHnZyVq06BmwVd91zcb80jXVefcDcQzDt0y70O2KThotnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11139

On Tue, Dec 10, 2024 at 05:16:24PM -0500, Frank Li wrote:
> On Sun, Nov 24, 2024 at 08:08:39PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Nov 19, 2024 at 02:44:18PM -0500, Frank Li wrote:
[...]
> > > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > > the device tree provides this information.
> > >
> > > The both pave the road to eliminate ugle cpu_fixup_addr() callback function.
> > >
> >
> > Series looks good to me. Thanks a lot for your persistence! But it missed 6.13
> > cycle. So let's get it merged early once 6.13-rc1 is out.
>
> Krzysztof Wilczyński:
>
> 	Could you please pick these? all reviewed by mani? It pave the
> road to clean up ugle cpu_fixup_addr().

Krzysztof Wilczyński and Bjorn Helgaas

	Any update for this? All already reviewed by mani.

Frank

>
> Frank
>
> >
> > - Mani
> >
[...]
> >
> > --
> > மணிவண்ணன் சதாசிவம்

