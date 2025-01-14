Return-Path: <linux-pci+bounces-19769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A7DA112A8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674803A3699
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9C1CDFCC;
	Tue, 14 Jan 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIha6MwC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074820767A;
	Tue, 14 Jan 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888446; cv=fail; b=VO/NkGQuc8SnK5MshNUuSMXrx8QTQi7fWbb3UPEP/fGVpZ4fsJmiRRVMpeRTtlKeHpsWAJoqCN+wwBcEE/Gr14F/+A818aeW5wAEJRDlzrSzfBB4LsYDORfnWS8kGhT9gbnoNHS/GuPqC6u0yuoHmXob8ZBu6F3VZhWlFNcyGiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888446; c=relaxed/simple;
	bh=Lmn38N/YfnR79oBagdEXfLyuWyWm8wZ69LrsJLGxSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lET/2RLQTPIkJdLwifmQszPSy0p3PCGiLcpzYpqvIx7QlEClzk3pxZg8G+JLxeX8/xntZmth7VWvw9YllQwdf3f8kQfgySvgv0ZttcAZlv5H/Zj34JReVFiqz78fho8P5/5mol9PuyAtcGyPJBq90+xaJ8rub7fTDk1px9pu4A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIha6MwC; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqUqZJbNliQhL/Qquq6uAL8sJT6dDsPWkm6ZVB2PGW2N9beapLS4UdXYa2TWmfP94v4Ae8aizuNc0IvQnLXQnAIFYyq4vN2vU46Rl9VK19Cpnv0nEztg5fdaJb3XEY2nHZ0EBEhJpMPVp3+38bcZifMw5gCXwiGd64IjnqtTdea3O7MjWRi0WxvaKVYdhFDlzAR9YTC3harEiWiD7L7Egn7D8IKsAXH6cPccI/qucuCmfCk6e2bQWRhFfrfliVdpGCFVfWc/GBpeFVkRpNmxl21yJ1r32qC1MTKUZzOh/g+718W8/OqVfXg9y5iwn3TT5btbOnkGqkAQKAdd5xSIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djRgRrlPXo7Cg/pOVv3l+R+uoG0PzOnuy9iKcfbxO3Y=;
 b=JM5uvIluNFlb0HYunin440V/fDD+S7s3X40B8tVzQ9XH9DhrHdcQDDN/D157C5a3N9rHJ0tStDWsGSnnvPoVBzxYVYoxNu+YjaIHyA3cf/BDQM9ReGA4Zf3+uXvczNoTwMz+VVfV18+Nh6n7fq3sk+NoOBamRIJLdn8L3c7kJpB/O+nCo8f/pfCgXf+OJEWmUvzPye10CLg+KSaUZ2M699P+oVNcP9e+7GDeQf/F4zb7Lu/gFzBqg8hHsxXasnQ7jWb8AJeaamd3f5t/GGtZkdxmu7l5tR171N2Fd+QitLRLJvkAfc8nqmptHmQewXb2UT2Tn+4HAOhVc7dPxqow/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djRgRrlPXo7Cg/pOVv3l+R+uoG0PzOnuy9iKcfbxO3Y=;
 b=GIha6MwCXL4gnyFE5gWTW24kyNZJxsnrzWAT86W1kd0Mxpa4Uti5RTtiOns9x9kuhKCh9xwZsZWjjv3qRRJ4pR+nKCNNHNaNYAhJLkB1sI/dQPuR8g5DAEbBHM3K7KKuM7f9P6Ov3n/Aq9G5zjfLJpFbxNA1ZDgBjHtMQsdBH7Kvbmi1MqMBJHF5jVJ79ARnHbFAUb0pw8/A6QAF46ZwKGVotE2jGKDPMu93WBLK0VP+DJGIC8BkZ1TNoFdRpOtdNuuAWthybWwjG/07y/oGaBhPbn9gXy51/uzHNAk+V4WqfAWC3LvELKpqzSQMx82eTPWBNYJlepRXJPHmZ3O1oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8028.eurprd04.prod.outlook.com (2603:10a6:10:1e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 21:00:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 21:00:39 +0000
Date: Tue, 14 Jan 2025 16:00:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?B?V2lsY3p5xYRza2kgIDxrd0BsaW51eC5jb20+O0Jqb3I=?=
	=?utf-8?Q?n?= Helgaas <bhelgaas@google.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Message-ID: <Z4bQbosV+gMBEs9D@lizhi-Precision-Tower-5810>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6736202f-ced9-4e0e-871a-08dd34de8043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBDNWtpdjVYdEx4WVc2Wlh3M00yZHpLdHhLRjRBK2hJWkkzaTF2SlRYOU5C?=
 =?utf-8?B?QnlCK3lXU0NNOHYwa2VFYjRBdURxUjRBM2h6dHRyak4wYWd2dHhWQXFBcDI4?=
 =?utf-8?B?UU8yeFE2ZmlBSHdrYUQ3ZXFUdVV0eWxiVGdtQnNEeWpGc1RwQ1NVQys0d3Mr?=
 =?utf-8?B?NGhiakYycnBMcndOMG9hRCtCcEJLSXc0aXJYRlpBUDBVWjZXWE1qSFFWaG5t?=
 =?utf-8?B?RUg4WTY4TzFSS2RmOG9pbFlKektLV1BTOEp3S0Yyb0pYNUtUWVV4NUtjZ0pj?=
 =?utf-8?B?ZTl4T0pSQUphNlk2bEtGT0FlVDczN3JFNGNGMjhRWDZ6dUF2ZHB3TDVEb2VQ?=
 =?utf-8?B?S2Z6dW5ZRzgvVjgxS1BjakJhcTJWbWZzcTh0QlZQV1VTT1Y0UlBjb1dzNXdp?=
 =?utf-8?B?SEpMTHlwNjhBVzZtQWlsRjM3QS8weTdrZTJGWXhjbE0zWTdTS2w1aW1EM0VI?=
 =?utf-8?B?VDdWMjJKVDhCMlNYanZsRWtjdncrNExJWnFDQUxIcXVoeUxJLzdWTG5zaFhZ?=
 =?utf-8?B?Wmp3bG1VdkpzQ1RCS0FGc1hueUMza1FUNHYzWVdjZ0RyVld5RHpoTVV1RGNX?=
 =?utf-8?B?dW1LVEI1bVlFbFl1T3VEYngwc2JkOGtsL0pNOXVnNDFMQ0hFUnZjN2x6OWJ4?=
 =?utf-8?B?eGZxVGNNZkNhVlFab3M5RTQ3anIwd0FDalhZSEEwTUY0T1QxemQyNmNySDFU?=
 =?utf-8?B?LzVnYTZ3TXRNS3BSTDUrdWJ5TERsSmJaYmNqQWExbTBRaWh3OWx2cFhOenBY?=
 =?utf-8?B?enJzTmJOQmpOenBNdHEvNGVmeXpPVG02a0x5V0xMS0RIZWtqL1Fvd21tREpB?=
 =?utf-8?B?Q2pRUkdDTXlxbEsvV1hEdERFN0s0VTdhSjhBa0lTb0ExM2lnTGpuOGRxdERa?=
 =?utf-8?B?UU5oK3NsUEIzV0NSbTRnaUVPM1RrMlFJNXZyTVBHbWd2eVZqTmJHclQwaE1i?=
 =?utf-8?B?RVZRTGk3U05SN2thS1ZTVFhnSHBmbS9rVEdQRXdQM2hESVlLUDBxOFNhWkVG?=
 =?utf-8?B?U1AyMXhyQ0xSdE85M0RtRHdwK04razFhWDVxbTdhTmFkNnJSMzR3cnIxUmxB?=
 =?utf-8?B?ZTYyVk0wTDdDam9nYjJkcC8zcG5iZHA0VHlJQitteTk2cFRaUGJhdi84UVht?=
 =?utf-8?B?eXRXRkJhUURjUVZyNnN1YlhOZWcxNkdFNDFRTm0vQU9oVmxYRnAycXZwTERU?=
 =?utf-8?B?blk1ZVdydzhHS0JDTTJ4TlVnTVNqT2w0ZGwwV3ZXMEFoWVZNSTdpNWptNUVt?=
 =?utf-8?B?U21hYjlERkp0aTVrci9KL3p5OU11ZGpraDNMQ0x5MkFybjlUWW5UZUhmM1o0?=
 =?utf-8?B?Y29abXBnN2FyM2pBL3p0RW05QmNXaktMemJ1WDMvRHloMTRDdXVGb0p3Njda?=
 =?utf-8?B?SHd4YVNieHR2T1I5eTZVRjNoY1pSNVFzRnprZXM1Lys0dTI5SXpoU3pwZkdZ?=
 =?utf-8?B?ekZCbGxOcWI0R20yREFLVm1QN2I4QjhMaVZLcGNYSzh3RGRqa1VZWTFiMCtZ?=
 =?utf-8?B?TW1Cc0huQm95c3VDbWFIeERGNzZVOEVSeUNOZ2ZDaHJZamlVOFlWTU9taGFu?=
 =?utf-8?B?WkxTUHhXUTExRkFaRkJPV0U0bStBZThIenNoVW9kUzdId2VsRGI5Y1JhOFdO?=
 =?utf-8?B?U1hXYkVyVGsybEtTTGVVMWJ2dW8rdXRSSVVUNExVMmxEMmpRbDdDV1dJS2ht?=
 =?utf-8?B?b2QrSjhYZWVGZUxDTHY2SWZTc0RCT0o5Mm5lMDZ0d2lSakxkSHBmSDE0NUsz?=
 =?utf-8?B?QUczYnFicm9sV3ZpVFdGdGp4U1NYZGRhanR2VlRvUnRMSkJ1cXVheW9CMUZ1?=
 =?utf-8?B?eEt3MVNHRWVWODFZVjVlM0JjdGlsbm5DcE12QWs2aW9uWWZlc3JQbjVpMzdq?=
 =?utf-8?B?K1lMUzdaT2IxMXU2MGxkVzVKTHZsdnQzVDlHdElYZVc3Rmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2ZWTXpZejFuei91M3dLc09nbUlsbzFOWVk4V0M2cEpuUkp3dDBOWnJUZUUx?=
 =?utf-8?B?Q0NNQjZFaDdiSTdhOFR1TUF3MUNQay9BT0FMZ3Bxc09BbTRZN2lQRjRVR3dy?=
 =?utf-8?B?NTd3dnhERmRJWnhxNmx0V0JTTTg3bDI3a0E4bjUrZ1ptQkhtZCt4K2tsaHVj?=
 =?utf-8?B?T3BxSU56RUZWNVNoUWJUTU9TZzZDcldZazBSQ0M2YnpOcUs1WHdwa0gyN3lO?=
 =?utf-8?B?emdqYnloNW96NmNRaHJiWDZJYXIyWGI4aXZJaHVkemwvekFSVWs5NCt5ZU1a?=
 =?utf-8?B?SFF1R2JneGJ4eVdSbzltUGNtdXQvRmlXUGF0TzZjYk5tMHJEVDd6V1Zwajkv?=
 =?utf-8?B?OXczb0djUS9FZEtOZVRnMEw2Yk9haGRYUDhsSnFYeG9rNWtxak1nWjU4bzhk?=
 =?utf-8?B?VG1mbitoYTJnUEhMRVYyWFBsTCsvbHBFWEpCRGdxekNETGNVMGRwMmN2Znho?=
 =?utf-8?B?T2NrM3JpVDhadDVzcGI3djZxaGhkd0c5RVVrZDhCUGN5aTE5TlB5WDZSRWly?=
 =?utf-8?B?QkYydU1OWjBDSkdFdU1GRWVLaG5WZXhCQkh0eGVCZnVFNFEwMGhjSk56eE1Y?=
 =?utf-8?B?YmoxMEdiMXZLSDl0NkthSlJObUNZQTFhL2VVZld0Qm1iTnRBUm9DRHFiUHkw?=
 =?utf-8?B?QXdWRHBQdHpwVndzeTNFUm15V0x2SFc0a3JsTmdXcnNFK1BPQ25aMHRablVR?=
 =?utf-8?B?VUlrUS9QYXdiNWEySEdkRFUxTG1jY1g0R0NvSDhoQlE3Qm8rU0tOTzc5VEJX?=
 =?utf-8?B?SVk5dkxubG9jQ0tPd0g2bzNmMDRlc05WZ29PdjNLQm10UU4rcFpFRHBBU0o5?=
 =?utf-8?B?RkJqYndvSVljZEpsaU5uVDhSTEdyaWhTUjV1M0NEeWtmTkJLKzlGNFE1OHNN?=
 =?utf-8?B?WmZqbnVZZitVZk1zRkF0RFRQN0FRempjZmxuamQyZmZxQWtsSSt0bXcrM09h?=
 =?utf-8?B?UkZoYll1YmUxc0Z0aW56RmtaZVE4QkFlVzBJalJ0dHN4ZjRnbFY1cGdrY3I2?=
 =?utf-8?B?Yk5BT3NXMFlqVjJDYmxWRkZFQ3Erd1g2ZElpVFBvWnpUSkVCS2lNa0Qwclcr?=
 =?utf-8?B?ZXVMb3B4VnE1VGY2VjBMa0xzRGhwZFNScCt1RWtpKzU5aEttZ1lrL08vZHhK?=
 =?utf-8?B?b0hFTnE2Q0xhSkFrSVBuc0lRNWgwbHZjaUZ5ZkZvL1p5MGVMQ2IxOEozemJZ?=
 =?utf-8?B?TzB4WjBMN3FVM0dPTHRCS3dZTFY4Ulo0VUJrQXZwR2Fqek5KOHpaVXk3bzB6?=
 =?utf-8?B?cGdDRXFEMHRjM1FtRE1zaVlHQjJJRzZVblV2TmtodERFMzcwVGpSN2tCbm4x?=
 =?utf-8?B?ZU5QM2Zyek1FNjVaM004YVU3OVBKcjBQME1KQ2FuOHIwWkkzc3FZQTlFMm5k?=
 =?utf-8?B?ekE2VUJML01OUHNBUlF6U3djbytoc3lBWEYxVy9Na0N3aXk1Y05HNkg2cU1i?=
 =?utf-8?B?TmlVUUp1NW1hRmp5UHpMY3h5aThGUVRsNzRHTDlTbk80aFRoK0RBdkxvVEFu?=
 =?utf-8?B?VXJ3MUN2dEdnclVLTmpTamlmOVR6UEdISzBFRTllVlNNWTU4WXBBU2tZUWcr?=
 =?utf-8?B?V3RKc0ZTYnAwbWpKYitzMFF4SjlZcG9UQkxTTk1ETHlCcTZqOG9IaG1hQU1X?=
 =?utf-8?B?Zi9ESXlVcEtBSGY5Ri84OGVHakRrZlh0anFhRmZMYWpoTHJvVUJ4TTl6OXkv?=
 =?utf-8?B?NFZnZEhzNXg0NzlEVjJSUXNvU3NYN1pKWWdnNlNON2N2M1BmT1QrWVpKSjIx?=
 =?utf-8?B?TGY4bDIzQ0lsd0ZZeXVwZ1I3bXIweUoxNzRQZGhmVTd4QkFyY1A3T1JuQ0VW?=
 =?utf-8?B?QnI5NE56WGo1M1JXaFJ6SEdKOGZtbVNOK3VmV1VIYmVzV1V4RXllZ1g0QUxi?=
 =?utf-8?B?L0Q2L21FZE9oWHhoc3Y3T0kzcGZtWXdrVDRnWW4xTWRMdlkxNE8yeks1VU9l?=
 =?utf-8?B?V2laTk5wWGtwYU9TVTNFa3VjUzNWRHVPZ0l0bEZtczFPVU5VUE1pSGNrQ1Np?=
 =?utf-8?B?cHNndTVYbm9IL0ZQR0FNSHJod0Y1Z0sxWUVFZms5RnlacVMrRW1rS2I5NUZL?=
 =?utf-8?B?YTJzbWp1amtsdFVrQ1dWYzIzTmhvcm9yMWVlVVBBa0hQQ245RXZrdDFNcU9M?=
 =?utf-8?Q?+yNmpGFb33FxXBo/nkrsOukWJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6736202f-ced9-4e0e-871a-08dd34de8043
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:00:39.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXB3VXhY7N5C+eczkupNmKQZsY0zGjDVm85jVxl0G8TWQ/HgFp3Owttiu4Gd279VmVvAa2u3SUJfKuatoIGXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8028

On Tue, Nov 26, 2024 at 03:56:52PM +0800, Richard Zhu wrote:
> A bunch of changes to refine i.MX PCIe driver.
> - Add ref clock gate for i.MX95 PCIe.
>   The changes of clock part are here [1], and had been applied by Abel.
>   [1] https://lkml.org/lkml/2024/10/15/390
> - Clean i.MX PCIe driver by removing useless codes.
>   Patch #3 depends on dts changes. And the dts changes had been applied
>   by Shawn, there is no dependecy now.
> - Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
> - Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
>   i.MX95 PCIe PM supports.
>
> v7 changes:
> Thanks a lot for Manivannan's kindly review.
> - Rebase to latest pcie/next with "tag: pci-v6.13-changes", and with Frank's v8
> "PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()" patch-set applied.
> https://patchwork.kernel.org/project/linux-pci/cover/20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com/
> - #2 patch.
>   - Update the commit message
>   - Use devm_clk_get_optional(dev, "ref"); to get the optional clock directly.
> - #3 patch: Update the commit message.
> - #4 patch: Add one Fixes tag.
> - #5&#6&9 patches: Update commit message.
> - #7 patch: Refine the subject, and the commit message.
> - #10 patch: Replace the dummp_clk by one fixed clock.
> - Add Manivannan's reviewed-by tag into #3, #4, #5, #6, #7, and #9 patches.

Mani and Krzysztof Wilczyński:

	Could you please help review these patches, it was posted at
Nov 26.

Frank

>
> v6 changes:
> Thanks for Frank's comments.
> - Add optional clk fetch, without losting safty check.
> - Update commit message in #3 and #8 patch of v6
> - Add previous discussion as annotation into #4 patch.
>
> v5 changes:
> Thanks for Manivannan's review.
> - To avoid the DT compatibility on i.MX95, let to fetch i.MX95 PCIe clocks be
>   optinal in driver.
> - Add Fixes tags into #5 and #6 patches.
> - Split the clean up codes into #7 in v5.
> - Update the commit message in #10, and #8
>   "PCI: imx6: Use dwc common suspend resume method" patches.
>
> v4 changes:
> It's my fault that I missing Manivanna in the reviewer list.
> I'm sorry about that.
> - Rebase to v6.12-rc3, and resolve the dtsi conflictions.
>   Add Manivanna into reviewer list.
>
> v3 changes:
> - Update EP binding refer to comments provided by Krzysztof Kozlowski.
>   Thanks.
>
> v2 changes:
> - Add the reasons why one more clock is added for i.MX95 PCIe in patch #1.
> - Add the "Reviewed-by: Frank Li <Frank.Li@nxp.com>" into patch #2, #4, #5,
>   #6, #8 and #9.
>
> [PATCH v7 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
> [PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
> [PATCH v7 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
> [PATCH v7 04/10] PCI: imx6: Correct controller_id generation logic
> [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
> [PATCH v7 06/10] PCI: imx6: Fix the missing reference clock disable
> [PATCH v7 07/10] PCI: imx6: Remove imx7d_pcie_init_phy() function
> [PATCH v7 08/10] PCI: imx6: Use dwc common suspend resume method
> [PATCH v7 09/10] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PM support
> [PATCH v7 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
>
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |   1 +
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 +++++++++--
> arch/arm64/boot/dts/freescale/imx95.dtsi                         |  25 +++++++++--
> drivers/pci/controller/dwc/pci-imx6.c                            | 178 ++++++++++++++++++++++++++++------------------------------------------------
> 5 files changed, 110 insertions(+), 123 deletions(-)
>

