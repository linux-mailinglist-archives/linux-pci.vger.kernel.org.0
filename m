Return-Path: <linux-pci+bounces-13535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CF986B39
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 05:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838F28342F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB015539A;
	Thu, 26 Sep 2024 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UNh+Kv71"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB41E86F;
	Thu, 26 Sep 2024 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320900; cv=fail; b=a8oB5ZFbjr8e6S05Azt9KNp2PEXVCyOfHYeGcNXvkb9pZ2xHdqQ72A3014ZNkNlR2mMsTnp5fEnmA9Suu1uxCYua2iAY0qjoeXxLuBOqquXezHFt8yA6q9AaMzIi858AHzDt1hFGgfRFO5hYIst8Kf5MW0XtrMxZvG321He2opc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320900; c=relaxed/simple;
	bh=m4AF3N0cPDcKAIunglfphVq1tF4fS7zyp0Qg2a3MZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tnHCWMh3TRDTW+TRPFFSoF8anDk80zbCi34LkIWkDCLxJ9KO9sfLsVFOhIxo82QoWlDCyNiuw5DfuIuv/FYpwPohCwzQvpQWTOHDgsV9pDYz+Ci4Or2EBRIHLnZtCqohTujuJlL6C7Xs6QeuTWAGVQHicMxGUOQjPvLVMhyY6Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UNh+Kv71; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQerOverPaeWieoI6Wqyhndfe/ArI6m+Y+7+dbZHmtuockiuWgTGNAZSthJ9hDSYM5j2+bRRfQrVzrlN6W1EEt3NzOYB3ItAhLj0xFZIkwdm1BNaSnpoyar6Ae9C/LWh1Zt69gix6ZRLBphXQC+wS2cmke+00cUe9fJY2f//OOZmIxETrgJNSaJ3JBHmW9btLXCPtnbKRzmra6mE40BdXLdJpgSYictzZmsSRNYl4ugPiGDAORC7mVam846FXJxb7aCwlkDYb/SQtS0WJpIaqEH9ywznQqYQTX/pKlpvEsxEorg+BLhlVZ+Bb1kx8NlrmESYg/8ntfDkdVKbENQsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNXODmrNw6nW3pV/rhac1X23eztTZis4/SAZpKx0iLg=;
 b=ylOiugH6TuYGds/n42jQXGtTeY20bdP8LDMrRECDsc61r29CtX7mECb9Hmn/QyqOaXJaLkUq0vXw++jiVpPFXn0ycRzJrD3S+vN+Qs8gJ2WJzBZpFxP/O62b0YGmreya/NQuFcqnibZy9AXsPq3C8spQmPG+FlFDJV/ZGR+Awk7NCXNQ4+929DEE82CIAnYKzZHPKs54HdBh1bhSAuGyvZh4R3itlaXzR5nuHzKLoUdzzLqgTtUOfdQVoEMr9Gm+67bwbBLIGXS7UI4Of6rKTzOv6QS0cXGSKKA3P7BbMqnRc130OMQE1pITOOIxFFQlW21EpubA5qnXRPMt+DUsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNXODmrNw6nW3pV/rhac1X23eztTZis4/SAZpKx0iLg=;
 b=UNh+Kv71e46KQpKZh3f2gTJpJ0pstYDINbjEfP8NaCB0rwyJkIp9f0xesngo6s8ja7KwKCZUQjbtCiRaX9rFJSnG1O/gdxVVO6KeT0S0FIrzgUZEhhzQmG2GqZIxGmb7QXDMGEQbNLJDJfUEK6YLgmr+5u9UpaeuHtpTP9lA+BT1SdRTycLtpuz8pqa92qoSAJHcmMtn7V6AcLC0qIY9QDLgxs9re5Yqfe3O1kfHtuVwi0FLH0ZCmGXUFjT4JVLgoBQJEv8Q0j+1khjc10UQDDMrhvCm0NzYQZnrOJCHUDTAzpw/hp88ucQIaDZV3EpDXapj8qjy30DqZeiv9XV18Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 03:21:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:21:30 +0000
Date: Wed, 25 Sep 2024 23:21:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/3] of: address: Add helper function to get untranslated
 'ranges' information
Message-ID: <ZvTTMYrsHpXoVicX@lizhi-Precision-Tower-5810>
References: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
 <20240924-pci_fixup_addr-v1-1-57d14a91ec4f@nxp.com>
 <20240926022610.GA2360654-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240926022610.GA2360654-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7081225e-f377-418d-bf51-08dcddda5093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDlxTzZTMk5IVGs2U3N4Zm9KcWZKbDBGTWZZS3dBQ1lSaHNpYWNlUE1OaUVY?=
 =?utf-8?B?KzMwTVE5S1VINW4wQW5vYlB1QTBrYjZtUzJBZlA0KzJQRnNrcWhXSmlCdHU0?=
 =?utf-8?B?dlFkR0VZQkQ4bitjSEhobXJZNktxb01LRXRKM2I0WFp5SDBKUU9LMk5Pcm1H?=
 =?utf-8?B?SVRqaUtPWkpzK21kMW5zVldHWDJEUjNpbC93OEQ0eW1ISHk2N2Z6S0d4eUlN?=
 =?utf-8?B?dXNQMG1ZaHl5bmdFTGx1UXo4Y2RseFg2czVPQXhBa2NNaG1LVXFkUU9kcFdF?=
 =?utf-8?B?UWZ6WFQvYzdVQmpwT29EellrZ0RMNW16a1kreHZMaHBtUjlJZ1NXUmVEZDkz?=
 =?utf-8?B?bWxsd1dXd01HaXV5YVZDZ3grS2NWTEVLVFhzTTltZEk3MFprNUlQWHRETEZB?=
 =?utf-8?B?K3hMbVRmQUE5cm5FZE9FUHN5dUhSaWhpWVBwU1dGU0xGa2xOU3ZraGdaZXZ3?=
 =?utf-8?B?ZjAxejZiazUyUzZaV2FZemQ4c052VXViTjZqemZmNHkvRnVkenNjbXdBTWMz?=
 =?utf-8?B?YVpXN3JjQ0k3WXV4QW5ZOUFZMmg3US81RmtaMitMNm9QK2haVUh3L0ltVXFG?=
 =?utf-8?B?WWlwZUtaM3dTSEU3VkY0bmpISzd4RkZXVEg3Z05QdzVqaS9hR0ZEOXFJKzVC?=
 =?utf-8?B?THpCbjF3VUU5UUVVNS9keEZMRVpEUzE4dEMrSnQ1MUlHY1NjdDJYK0ViY0pl?=
 =?utf-8?B?UHVWdVg2SWs4SldjN0NaSzVBWWxvdjA2Q1FtS2k4VVZLYzBqSnNkVzFJOXQ1?=
 =?utf-8?B?MTZTSm5zZk1sQ3h6SmVGNW9tOUU0NFhmdTI4NXRPNGVnRW9Hc3JreEk0dUdZ?=
 =?utf-8?B?R3FZWmtkaWVNMGxVbHhQZm01eWs3T3J2V2RTSlIxak1xaDVzY1FYcUJLRDMv?=
 =?utf-8?B?cjh5cmgrako5R2czWmZnNTJHNDJQb3ZxQktRbEZNQURZazdhcUg2a1RZcW5q?=
 =?utf-8?B?T3VCaEExQUdXN2tXdTFJZURnTFdXdG5reEl4ZGx4SGEzSFFTaUxZUXpxUWVn?=
 =?utf-8?B?MmpmM3cwVTFRdGRPWFROeitMelBjODhIMTJFc2VFRDMzWjRKSGV4THR6OGdl?=
 =?utf-8?B?Snp1ODdpU2Q0eTRGc01CR0xKWlZ2MVNSTHpWSGV5Ni9RZ3JUZEhMZkdLYlhM?=
 =?utf-8?B?YXVueGtnQTVHWHdVcm1DSFJvK0FPMzc1QU1PWFdteEs3cnMvY3pzaVloYzFT?=
 =?utf-8?B?VDZuNU4ySGxVb3IxNnRiTE85Zmh5UksrSDhnV0prV2NoQktBQS94Y3pNYXR1?=
 =?utf-8?B?c0cza2JHQW14WUprRDZCUjRyZ0ttR2tyYkpUL3VFV3JNMGN4Um5wSEZ5enNT?=
 =?utf-8?B?SVNHSE10REduSVllNzNVVHVGSEd1K2J2WVRCYXZRZWZ4SW5rWkMvN0dKRHEv?=
 =?utf-8?B?UG1Gc28vTG4vTkdiVmRBajhLWGRKQVlUQjhydzZhbU03YTNUVTd4djhlUjZl?=
 =?utf-8?B?NGZzTXI4amI2bnY3SlVSMkY4UjRVV0tjdTNORUZnZFBMYnJFT1l4bzNiZkNJ?=
 =?utf-8?B?NURsditqLytlOEVFdEdzVzR2VHpONG1sRlFxRDkxd21qYUJIRUxaWTJuTWVk?=
 =?utf-8?B?ZmVzTDV2MXVObDhzNHJ1TmtZUnpHS091NlpBQy9GRUhwTjdMcmIrdEs3SDkr?=
 =?utf-8?B?Z2lhaUJjRG05d1h2T0VKWWdHMHFod2NtWmZzbDg4U01pb1lKRXV2R21HT3Bq?=
 =?utf-8?B?NEFuK29md240eitheTJTeE5TUVJzeFUwSi8yNllpcStkK2Vsa1JvaTB5MmZY?=
 =?utf-8?B?WE9UUnlFSEY2MHVxVnpoQjdsQ3ZNdVoyaTVPbnRMSG52RldGWC9hSGw3Wkhj?=
 =?utf-8?B?dmUzYmxPTFd5TWFlZVRWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFAwS2RPMmZjZzk5eGpQaU1PTGppZXk4ZUorc3lHWXhFNmJVT2dBZ1F4NHRK?=
 =?utf-8?B?Si9ndnpzVjdBbW53ZzVjTUIrMEVjY1ZXdHRtZnRYR0g4cXJ4MEtpY00yY0tk?=
 =?utf-8?B?SG16blRIbmszT3ZkZEk1SUwzKzdwUmRlYk5qOWhwOENSNFlwZ3krWEdpSVRR?=
 =?utf-8?B?Mk9HZnlSZHI0eklxYUdVYzhLNWcxYjR2Y0ZheHY4RHVueGxFU2VDbyt1b25w?=
 =?utf-8?B?NWJFN2g5aW5qRE1IcTZGY1VCRHpDVzF5MWljbXdMWWFnTm1vTS8rbExUcTc3?=
 =?utf-8?B?WTA1MGpJT3ZlWmxIVEUrVHo1NUxSNjZVQUp6cmRZUWVRNXhoWGoxWWhvTVlU?=
 =?utf-8?B?R1ZJbmtVTVk0Z2xYU0N6MXQwSTJwNkViVHppdzh3eWNOeWVTdTc1VGFFWWVt?=
 =?utf-8?B?VUliL25XR0xXWlVKYjFwdkR5VVZkaExLMzlBdmg3QnlqTzU2MG5kL0d2ZWlp?=
 =?utf-8?B?YWJVd2Z0cXB3ZFdsTFczWndsMDExWDFGYSt5R0ZUTTQ4L2dJOEZHUWR5Z3lM?=
 =?utf-8?B?T1NsNUkxZVRST3Y5aUxOT3AyajJQUFRITExuNGlid1U1cGdjeHFsc1V2NVBj?=
 =?utf-8?B?eEthem9kNjlsY2NzN1drQU93SWFkcmNzbzBRdGlwQW1XYWxYV2VOZUo3dVNI?=
 =?utf-8?B?YW0xWnV3eTFsVStDaENaSFdpMDJDZkZDSFBsS0JYclV2dXRmWTFqZGNVV0NP?=
 =?utf-8?B?UWtjR29nZE1ZRE9FZHp3UThubWZQZ3NmVnB1RUpFVldWcjFDY3p4MnRxWWhU?=
 =?utf-8?B?a3hUcHdWRk52QnlDbXlwcDFSU3ZtSG5sUGFZMEhScFVZaGRKSGFKdk1ZS0ph?=
 =?utf-8?B?U1JLaG5yQVdhbC9aK3JVT0t4N3FDTmMwYXhmNG1La2ZQSllYKzgxM0MybVBX?=
 =?utf-8?B?WHBQaHppYVpoMnc0b0ZLTFpBMFFpVWVSelJNaDZlbnEvQ1R4OHZ2WkVqNXRo?=
 =?utf-8?B?TDlmOE15SWF3K3FPd0FqZStPdEg4QU8xbjEvTlBCcGowMFM5ajdCRUdlUFpB?=
 =?utf-8?B?bkJGOTlXTllzYW1zTEkzZ3hMQ3dCSitVcS8yVTAxZmdoZFhlODMvYzYxNXRo?=
 =?utf-8?B?MVU2a29OYzRRbXFlUVdUYVZIbi9vbkllODh6THd6c3dQaFNmbTRqNDQvMFpr?=
 =?utf-8?B?L3JWQVZNMlI5VTlOeUFRWnE3NitUZUxNTTRvcHMwS2U4anZMTVRhTWw3NGpq?=
 =?utf-8?B?WElkK0Y0Z1JQb0RsZWNqUllpL3EzSnRxN3FERW05Z1FINkd3QUdCTjVzMVow?=
 =?utf-8?B?NXZ6My9yYXZsZFNjdkFiRFN6aG1QK0dSaUxEQlo5VXBqOHY0Y1FMMExKWVZH?=
 =?utf-8?B?K1JYbm9VdTJKM0I4VFZtSnAybytlcXZRSEd6aVZjd2wybVRzaWdHbXBWdHph?=
 =?utf-8?B?V2dQbzh3RW4vQ2FoL3NiNkwyVE1PM0dSL3NqdnhyK2NQbWo1aEJza29LVzFT?=
 =?utf-8?B?ZW9XRWJPQzhVM3UxT3FHbXdQS0ZVdnY4cElrTDRHSFNFRDQyc3lhalYvdlJk?=
 =?utf-8?B?NllWLzhraHhBT3Q1a0ZJZDhHNXhNY1l2TTg3Q25rR2ZjSFlvTmlMNXd3WGhm?=
 =?utf-8?B?SDBKT25KNjFhVEhsSnp5WWh1eDQ5NUFZaXJYQllBWjl5cEtUL09GWTJkMWhU?=
 =?utf-8?B?M3BCSmMxUUlsbDg3UGd0SzlwL2I0L2dwQkoxL1FFZjFsYjBKMTJRYzZCNWpE?=
 =?utf-8?B?TjRHSEY0NDUzbm5FclFTWWVZQ083ZmY5TkhLdXR2cS9ZKy8xbzZGZVdlQlVq?=
 =?utf-8?B?UnNLSVN6TTdDeUc1NUMvTnlRdmpKVTFMUHBCa05FaCtzWnZUajdZd0p2T20y?=
 =?utf-8?B?d1pLRFI0RDdsVmo0Tk9ETE5POVJ1YWg4K0tMUkNmQUlZQWUyeldvZThDVEtM?=
 =?utf-8?B?SGpNU3gvNDRGMXVnQk56WmxnSEp1Rm1TS1U4MEJQdjh0SHladFYyVmJoaU5T?=
 =?utf-8?B?M1g5eVlmV3h1ckNEUE0vWVpJVXczZDJLY1dOK3BYN282VW5iby84ZFpNRnJ4?=
 =?utf-8?B?bXk5NDcxTmUvMXZKeTQ4NFhMZkdab1VNVk9lazdmNHRBWTJQOHZKbTdQcUo3?=
 =?utf-8?B?STNNYklSZUczZTRWQ2M1UGNXSGdCQUt2OVNOZWdQRnNURjRJQTZwQzdJWGNv?=
 =?utf-8?Q?cga8Nki4C6kJVH6bTF9LnhS7u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7081225e-f377-418d-bf51-08dcddda5093
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:21:30.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uMpUm18uQJwDKKdraVyKSGn9IgfwoLIjEtoBtk1ZDGo6Rgd/iT3fvEiEzVspzWAH/jVOCg5oYazZXYraNh+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418

On Wed, Sep 25, 2024 at 09:26:10PM -0500, Rob Herring wrote:
> On Tue, Sep 24, 2024 at 05:54:19PM -0400, Frank Li wrote:
> > Introduce `for_each_of_range_untranslate()` to retrieve untranslated CPU
> > address information, similar to `of_property_read_reg()`. This is required
> > for hardware like i.MX8QXP to configure the PCIe controller ATU and
> > eliminate the need for workaround address fixups in drivers. Currently,
> > many drivers use hardcoded CPU addresses for fixups, but this information
> > is already described in the Device Tree. With correct hardware
> > descriptions, such fixups can be removed.
>
> Just to be clear, you don't have to change the DT to add the
> intermediate bus? If you do, then that's an ABI issue.

imx8q's pci dts is still not upstreamed. We are working on it. I think use
this way is more reasonable.

>
> >
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
> >  │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
> >  └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
> >   CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
> > 0x7000_0000 │         │             │   │  │            │
> >             │         │             │   │  │            │   PCI Addr
> >             │         │             │   └──► CfgSpace  ─┼────────────►
> >             │         ├─────────┐   │      │            │    0
> >             │         │         │   │      │            │
> >             └─────────┘         │   └──────► IOSpace   ─┼────────────►
> >                                 │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
> >
> > bus@5f000000 {
> >         compatible = "simple-bus";
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> >                  <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >         pcieb: pcie@5f010000 {
> >                 compatible = "fsl,imx8q-pcie";
> >                 reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> >                 reg-names = "dbi", "config";
> >                 #address-cells = <3>;
> >                 #size-cells = <2>;
> >                 device_type = "pci";
> >                 bus-range = <0x00 0xff>;
> >                 ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> >                          <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > 	...
> > 	};
> > };
> >
> > Currently all function related 'range' return CPU address. THe new help
> > function for_each_of_range_untranslate() can get above diagram IA address
> > informaiton.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/of/address.c       | 33 +++++++++++++++++++++++----------
> >  include/linux/of_address.h |  9 ++++++++-
> >  2 files changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 286f0c161e332..09c73936e573f 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -787,8 +787,9 @@ int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> >  EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> >  #define of_dma_range_parser_init of_pci_dma_range_parser_init
> >
> > -struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> > -						struct of_pci_range *range)
> > +struct of_pci_range *of_pci_range_parser_one_common(struct of_pci_range_parser *parser,
> > +						    struct of_pci_range *range,
> > +						    bool translate)
> >  {
> >  	int na = parser->na;
> >  	int ns = parser->ns;
> > @@ -806,11 +807,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> >  	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
> >
> >  	if (parser->dma)
> > -		range->cpu_addr = of_translate_dma_address(parser->node,
> > -				parser->range + na);
> > +		range->cpu_addr = translate ? of_translate_dma_address(parser->node,
> > +						parser->range + na) :
> > +					      of_read_number(parser->range + na, parser->pna);
> >  	else
> > -		range->cpu_addr = of_translate_address(parser->node,
> > -				parser->range + na);
> > +		range->cpu_addr = translate ? of_translate_address(parser->node,
> > +						parser->range + na) :
> > +					      of_read_number(parser->range + na, parser->pna);
> >  	range->size = of_read_number(parser->range + parser->pna + na, ns);
> >
> >  	parser->range += np;
> > @@ -823,11 +826,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> >  		flags = parser->bus->get_flags(parser->range);
> >  		bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
> >  		if (parser->dma)
> > -			cpu_addr = of_translate_dma_address(parser->node,
> > -					parser->range + na);
> > +			cpu_addr = translate ? of_translate_dma_address(parser->node,
> > +						parser->range + na) :
> > +					       of_read_number(parser->range + np, np);
> >  		else
> > -			cpu_addr = of_translate_address(parser->node,
> > -					parser->range + na);
> > +			cpu_addr = translate ? of_translate_address(parser->node,
> > +						parser->range + na) :
> > +					       of_read_number(parser->range + np, np);
> >  		size = of_read_number(parser->range + parser->pna + na, ns);
> >
> >  		if (flags != range->flags)
> > @@ -842,6 +847,14 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> >
> >  	return range;
> >  }
> > +EXPORT_SYMBOL_GPL(of_pci_range_parser_one_common);
> > +
> > +struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> > +					     struct of_pci_range *range)
> > +{
> > +	return of_pci_range_parser_one_common(parser, range, true);
> > +}
> > +
> >  EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
> >
> >  static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 26a19daf0d092..692aae853217a 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -32,8 +32,11 @@ struct of_pci_range {
> >  #define of_range of_pci_range
> >
> >  #define for_each_of_pci_range(parser, range) \
> > -	for (; of_pci_range_parser_one(parser, range);)
> > +	for (; of_pci_range_parser_one_common(parser, range, true);)
> > +#define for_each_of_pci_range_untranslate(parser, range) \
> > +	for (; of_pci_range_parser_one_common(parser, range, false);)
> >  #define for_each_of_range for_each_of_pci_range
> > +#define for_each_of_range_untranslate for_each_of_pci_range_untranslate
>
> You may want both the translated and untranslated address, so I would
> just add the untranslated address to the of_pci_range struct and return
> both with the existing iterator.

Yes, let me try it.

Frank

>
> Rob

