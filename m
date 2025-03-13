Return-Path: <linux-pci+bounces-23693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A5A604D5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 23:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4198174D7A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708821F791A;
	Thu, 13 Mar 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PefI91Yw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730D1F03C7;
	Thu, 13 Mar 2025 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906595; cv=fail; b=RPCd1NAWn88t/r822pVauexZ12+6w+4QxUt6/GtgwHjdwfzBxJ4AzmTprzeR+X82g4VY1B2spElKvgOaRNjC8qJXumN34hfmhpDFajqU+LbpEt15+suUxudP+EF5gNO6YSMg19lVay58aMgcKx8GHenAInIX0j08Jq7+9ORj8Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906595; c=relaxed/simple;
	bh=MCJGUPYCDCqqFra15EFcP250BOiia4u6Ag/KMp5aCa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HJrNCI2QHptomd0NvEyymH6U80BvG1LW6NIHL/wATNjUZKp6mldBhv51LsYi4NXVok2ZkmYAXejLv1c6eE5ebGFoMzUMTBEuvQSQev+6G5X0MQ3sm64OXvmrB61VoMxNXrxWwC2OMfMTwtNRFlDdpuJGHAvz1N13IPiUeV9eU4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PefI91Yw; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4gUECf2nd4DZ5+3yNV+M3hs6c9k2klqWTqMBxEBHVt63lQh44mSJ2XgapuUNsrUSvMx/p5SLpDMuf7pKiSxtszGegLCAWCVCgSWkGtdVdn9hBm9dQapTjd8f/BY6WEUW9RRD1K+AdgDDWbvQxF5M38GsMdMRBLdOQOk9ZNcI5od4LVHKRVfwJGlj6ldNbs6mgQGTlRGU69bSO8Y6Ce9myNxT8cu8V7Wx/5gMO92gWlmA5IzROz6dligQTcnUkei7fH+WR6MMYBsfY7UlP5qRtYtJ/OEs9znxmYgrAWa/Tb6LKBNVBCF79Du8vAVPUcv6CTlZ6rk+jdGQxkVQCRobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLECAan0AzzmnPfoRft37H+ukLPx5z9AStnUZ07HPZg=;
 b=nm/jjQZr91iOn19hr/HPN9ak5ipfMLsvSpbHIBM00uNAm86axpEH+TbknFrMHt+bV3p2PQUhOGowc7w72MYPQuxt4lXxBtqCtu4185iYfb8Gh9o2oFFvLQ0T9+oh+mlPo+7q/Rk7nSgtW5aQ/+jdy97OEluvZYFt671tzbZcYRmj3YiutrQCax9Sy6eEN+eXLdkOeMxEYmQ/G+VjV3eXvsMMG4cxQwhD/Z0B2LSZjnCg3mw/5QpGbSSKsOMxHxqmnrpkZ0c4Rn52zMuiL6yikq1m57uizmtDiS+cl7qYz4zAAkinupnRDwK1EuovI+LvEClCbVMuGog4c9PaQ+o1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLECAan0AzzmnPfoRft37H+ukLPx5z9AStnUZ07HPZg=;
 b=PefI91YwunB7zeufXl29WwzWQ782wGkvg4CTiwwFa5ITKT0ClJ6xuQTGg4TPEsSWNbu9j7P7btBDYGJJSuk7K3RCENI3xz0rKhQRyLLLTqeUEBNf77tXOo/eRbT3kvyTGGCxWB94jMMdrH9cKtPxtElrnQq0PsDYoUgmJ0go2EOKK7tC5AJYTatyrJTeoq6ZeMX3puSEyfNf4Xk8ybw5hGbVQ8WLuv5ELyrTbxe3JMDgNzk0AU0q+pbhEAsdur7C/U0CeZviLzcrUkvM9k3AFKc4CEPisXUdqdW86EQGrYACnG5VRz6YdtAodT8CutOJT7BYwlnd5PxI5ivnP4U45Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 22:56:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:56:28 +0000
Date: Thu, 13 Mar 2025 18:56:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 06/11] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <Z9NikZqmmnkt/GQm@lizhi-Precision-Tower-5810>
References: <20250313-pci_fixup_addr-v11-6-01d2313502ab@nxp.com>
 <20250313220450.GA755590@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313220450.GA755590@bhelgaas>
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c10601e-5367-4696-f639-08dd628249cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzVlbmEvUHJ6anh1dVZPOUpCSDNSQ2NqcTd5N1ZNM1VKS1duUmY3SlRwN3Qx?=
 =?utf-8?B?cUtCMnNYRU5seFFGazljRCt6QTNrMlZjcmdxclZyb29pUllBbTE2d3RUVXRO?=
 =?utf-8?B?ekpOazFkY1VPR3BLQVR4emF4QW5SQys3WHhUWC9Gak9CRDAwbVUrZHE4eFJW?=
 =?utf-8?B?MWl3Q0Ywd3dEWlQ5RVNHNSs1bVp5RDZ1ZVYwTFhsRmllR24xTFM2K1hYTlpZ?=
 =?utf-8?B?WSt6SFR6S0lQUFJnK2o2U1V6NFpqTkpWQng3dDhBZFp4bWRtbis0OTdQeGFO?=
 =?utf-8?B?VEhSTkRzdGRxMXV1VDBUM1lKcXE0MVRHUXZMOGNlaWdLV2xnMnh5VHRJSTE3?=
 =?utf-8?B?Q3hsdDZ0ZGFwZTFkRGp4dHYvamRpSnAzMGdETmVsRUE5cDNWZnFuSTBxZUcr?=
 =?utf-8?B?aHQ3eU41dm9Hb1lZT001VFlGNnAwaFVRTGRiSUhzWFJSeVFtdVd5VUh0MWlM?=
 =?utf-8?B?OEZ0MXhSSUM1VlhadWc5UWFpRk1Fa3VxbEZ2d0hWUkhoQS9obDBsa1dnRTdy?=
 =?utf-8?B?a2tKRE5wSnYyMFc3RW4rc1NwTE9ydmhpcGErVmhTTXpVN1l1cStGeVFyVk5o?=
 =?utf-8?B?N3krc1J0emZ5SGxiTU5nMGVaUXV1U253NGlMVWdBQ2xlQTRPTTNNcjZ3ZURi?=
 =?utf-8?B?ck9DK2dsSHNmMkEyNjZIcEdQeXlpZWdGNCtaazlxUlhrUUpVU0s0UkZVZkxT?=
 =?utf-8?B?RjZpd1AwYzRlSitBL242djkvQ3pqNEdWRVlQOXpDNkdIL09YTVhkYzFKNjhH?=
 =?utf-8?B?T3NPWEprQTIyaTZjWmQ4Mm14VlBCMEJuUlBITU84NTZRL0Zmd3VWbGxsdVhJ?=
 =?utf-8?B?S0dCMFp4cjZ5YmgyUlBEM1BXZFVNWWRaZzdQN1VSaW83M25rNU93ZTJ1b1RI?=
 =?utf-8?B?RUhFRVZGUTgvaklua2YyYUxhbk5uNmdnOThvMmpiRG1WZDBOZFZLYk9MYXVZ?=
 =?utf-8?B?NTZmYUVPTmlPYzNJeVBaamgveEFCNWhvV0YzU3VhaDVNOThJWUw5Y1BBN09H?=
 =?utf-8?B?dVZmaGM1UlRpcXhSMDZXK2VvV3Q2NUNIN1dJMUx2bUcxK3VkQVl2ek9rcG85?=
 =?utf-8?B?d2Iva3R2alorM2c5b01iY3NlUXppMFNXZUZBck1yKytSeG95MnNGT2NEbkM0?=
 =?utf-8?B?UDVqUU5qNGt5VENPdnBnTWFwWFZMaXVRZnBCSTdPRzVqcGk5ZFdEeVpsY2FD?=
 =?utf-8?B?TExvT1VhMXJrV2t1SjZFekt6TGFNaHNkNFQzSzY4MlV4NGZnT0pPNWRxcExY?=
 =?utf-8?B?bHIyeFo3djdKSlpsNFYzV0Z4MTE5M1ZJZ2d5cDBtSThQbGpaZTFGYURKTmxj?=
 =?utf-8?B?U1JmZ2lDeGZ1cEZNZkxYVDlTT3ZoUlZyWDZncXI3NzRBKzBzYXNJVEJyU212?=
 =?utf-8?B?OFNuWUhhd24yT3lLaHorNVRLdHE4dmJJMjZkSjJkSjNFWnhyNE1sSXhpQnNZ?=
 =?utf-8?B?eGpnTUlsTWFwaU9rdEU1TTdmdDRmcXpuQ2NQdEtSVHoxUjBLM2U0TXBCTnBF?=
 =?utf-8?B?TVZVbG9OWVk5UlU4WjlhUDJLdXZJVmdxd3lxMlN0NTROREZKWktGVy92bDZn?=
 =?utf-8?B?d1hncEFrZnF5dllWZ0xoYUZWQXZ2cTdEb2JocVpuNVlhTWs0Zm51aytZcUpL?=
 =?utf-8?B?ck0xeWxiMWhLYUdsNk9KTllBS1J1U0prZVowRWpqRE5JYzYyaFJCa1Y2dVZT?=
 =?utf-8?B?UUVWTWhIYng3OUpXMlBsNVYvVWQxVDkrbTZVWnIvcmlaM2RSZW54WEFGZGFw?=
 =?utf-8?B?d2N4WlR4QkNvWmJ2Y2FYNng4UExSZXhZck5GRDZya3E2dndDNmJLRmg2Mi90?=
 =?utf-8?B?bDZPd3BpLzk4YlB6WGpPNWJ6Ni9KbFVSZ3R4YVVZKzlxZTV3Nk9OYTlOckFt?=
 =?utf-8?B?dHZHbnZOdWhPVTFZTDJzcjBCVFg0V25Qck13Qm1WbFlnd1NRUHpYdGpJNVlM?=
 =?utf-8?B?TGlUZmNOd3NJTWNMYVVweloveTUvRGM0eDIybXFVdnVVK0dXTTVoQmZwS29J?=
 =?utf-8?B?QytRcG9qUkN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1Y0QSt5RmVxVDZObnFuT1dZeDQvZ2kydndXQ3FaOERVN2dyNUhCV0w4b0Nx?=
 =?utf-8?B?eERFcnBvZWhrZ3ZmbkJWV3V5eFo0aExzRm5QV1FiR0xyNkE3aXp6RFBrbzB0?=
 =?utf-8?B?eitXYUsxOVBqay9LTk5kb3RRY1JyTnhYNjcyR0RwVEMxSDN2cXNPWkFQVldv?=
 =?utf-8?B?eFB3WTBWaGN1c3pjZzZLajVYUG1kM0VEeE1FdXBrUUJ0RXhDWHFxYUJia05k?=
 =?utf-8?B?UXZhZWVucDRaR0NWMmVkOFkyVWQ3YmFHYzVrMFREcTBDMk0wejJxQ1M3VU9Z?=
 =?utf-8?B?NitISzFoUWVuWE9kbzZRalowYTNvcXJtemplZ2F2YTBzRDg2WldtMmNLb20x?=
 =?utf-8?B?ZllReHdEZTROM09KR0NrYU4xa0V1aWhoZnhxSTVqVVFzS1IxM3F1bWd2dXp4?=
 =?utf-8?B?UmdzUkpObDB1MzJtVFpqK2FUSkhoaXQ3aUxDdFd4c2lseFFPNTRoSXA4VktL?=
 =?utf-8?B?aUxsWGEzVU5tWDhlTEFuQ3p0VEdnVTRHalRvV003eTVJaDU5ZE01YzVBclI3?=
 =?utf-8?B?SVJpUDlrRWFEWkMzV1hOZDVDQlJGV01ORjVDSnRZdkZzdUQ3TE5iRkJCNFNP?=
 =?utf-8?B?dU9rdi9KR2NSZENLb2tsbjBKMnNVMlYrbUlnQ0RvbWtFRG1EUGZRUGhLdVlN?=
 =?utf-8?B?ZVZXVjhOMDBTamhxL1ZMbGlaMENWVHdSVSt6RERTWDMzUXlKZnRUTkhJc2Qr?=
 =?utf-8?B?Sm9SaHJmSmsrVjBjb2pYMUUvaXoydmRJamk0MWZqbVEvYTFhWHlJN1pWYm1s?=
 =?utf-8?B?b3VRM2x6VjJDWHNaR0dWNk92NnVaZm11UWtNb3BlSXpsYjhuNDJTTGVYNnlo?=
 =?utf-8?B?VHp2MXZKRWE4TVJXVHdkbHh0YnZ5WEhsSkMvVzl3dm9wMURsRldUZWJzMUxK?=
 =?utf-8?B?OUF2bU1FM3ZQVVRqd1hDOVFNMmh4SkJRNXplZUpYSlJQOCswU3h4UUpzNUNu?=
 =?utf-8?B?ak5sZ0RDNXYvbVVnWkp3ZWxGYnoyZGpvS2Vpd0tLUUJ3U2c5VHpCQVFYcmNE?=
 =?utf-8?B?K0VVWVRQK0d2N0tVMk1KUGZmeEY0bmQzalZISm4zRlJhWEZHSHBPT0RsZmI4?=
 =?utf-8?B?QnJpZHJMQWFmdkgwYmtzdXVrcEduUzMzV2lJRWgwSm1oUkdhY1hiKzVGL3RN?=
 =?utf-8?B?VzJiZVQrakxFVmFPRW05dGZQQkw5bVpHaWduQlBPNVZZVFJCcGlNSHF6UUFv?=
 =?utf-8?B?Q1paOFNSeXZocmkwY1lwN1RTemU1cisxZEVlNjlUTGt6VS9jdkZLOFIxRTNu?=
 =?utf-8?B?TVVrRG5aZExvTFlaZ3c2WHlUdHlJVmRuTUVTL0RMQXp3L2MzYlBhdlcvejZt?=
 =?utf-8?B?cUF5TThod01yWnllMFhYWUJ2bnN6TTY4UTZxa2lKaVN1OStxLzdiTUhrUjRG?=
 =?utf-8?B?eHVRS1dVSHYzMWtVYzRtQzJ4Q2haZXpnbjRacGJqQkV2cHZZcjIvTThtN0Jz?=
 =?utf-8?B?SFBqUWkva1U3WktkNVlzWnhHdGswSjV1cyt5cHZSS09aV2h4c3VlMThWcXY3?=
 =?utf-8?B?a21GVnNUbnkrb1IwK2wrak9MVmF2ZVZCMnBtaUZsR203aU16WlYyam96WHVT?=
 =?utf-8?B?R25OVlBhM0RPd05OaVdGY3YxSEhreVo5ZnNuSHFaeThMeCtzQXUrdnhJNHhK?=
 =?utf-8?B?YnFYVGFFMVRaNCs3bFVYKy85Q2Z6WjROaWs3aG1obEhKMys4SCswcGErSDFk?=
 =?utf-8?B?cVpSZzV0b1dBWldSRkZXZnhqZ2VpWmZRN3djTnFsc1dNYVlaQjFqSFRVRWNi?=
 =?utf-8?B?bExTV3FiTUlmZ1dCWExlT1QyY1BjZU9ocTBNeHJOVk0xYnNtWDd6SnNTYmFv?=
 =?utf-8?B?eUpSTFRsN0R6cm5DcG9CcVd3TTJaV09OUTN1U3FBZnZQQWFRU0doam9SbVZj?=
 =?utf-8?B?UmxYSWRIb2tvTmhYS0ZzalZwSzBJNVFVMENoK216ODN0NnA1UDhKOW5XK3Zs?=
 =?utf-8?B?SWR2TlQrSDFoSG1jeXJXclNtZUE3VlZzZVVFeDA5S3FaSWxRRXMxK2ZrczZt?=
 =?utf-8?B?cUhmRDBjRmJFdXRGMlJSbDVxQ2JVZ0QwNkZsbDE5M0txL2hKekM0VnpxWjN2?=
 =?utf-8?B?VHlnMmc0U2EyL1ZQaThxVXdIZWpLa3JUTFNEK1NtRmxsYVFINlhNZE5vRGVw?=
 =?utf-8?Q?Yl+mLMf94QqC+xd79Cod0xFHG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c10601e-5367-4696-f639-08dd628249cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:56:28.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOrdPM+MuPL+rl9OI70yI4waofckncKZpCzbiObmlCwcuURa2W1/EopEEe1lLryEjWVwP2QYNk4ZzfffVakp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191

On Thu, Mar 13, 2025 at 05:04:50PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 11:38:42AM -0400, Frank Li wrote:
> > The 'ranges' property at PCI controller parent bus can indicate address
> > translation information. Most system's bus fabric use 1:1 map between input
> > and output address. but some hardware like i.MX8QXP doesn't use 1:1 map.
>
> I think you've used reg["addr_space"] to get the offset for Endpoints
> forever.

Yes, it still need ranges informaiton at parent bus.

	bus@000
	{
		ranges = <...>; [1] /* still need this */
		pcie {
			ranges = <...>;[2]
		};
		pcie-ep {};
	}

>
> I just noticed that through v9, you used 'ranges' to get the offset
> for the Root Complex (with "Add parent_bus_offset to resource_entry"),
> and I think v10 switched to use reg["config"] instead.
>
> I think I originally proposed the idea of "Add parent_bus_offset to
> resource_entry" patch, but I think it turned out to be kind of an ugly
> approach.
>
> Anyway, IIUC this v11 patch actually uses reg["config"] to compute the
> offset, not 'ranges', so we should probably update the subject and
> commit log to reflect that, and maybe remove the now-unused bits of
> the devicetree example.

We use reg["config"] to detect offset, but still need parent dts's ranges.
There are two ranges, one is at parent pci bus [1], the other is under
'pci bus' [2].

Although use reg["config"], but still need ranges [1]. And information at
ranges [2] also need be correct.

The whole devicetree example also validate to help write address translate
informaiton.

>
> I do worry a little bit about the assumption that the offset of
> reg["config"] is the same as the offset of the other pieces.  The main
> place we use the offset on RCs is for the ATU, and isn't the ATU in
> the MemSpace area at 0x8000_0000 below?

No, "Bus fabric" only decode input address from "0x7000_0000..UPLIMIT".
Then output address to 0x8000_0000..UPLIMIT. So below 0x8000_0000 never
happen.

>
> It's great that in this case the 0x7ff0_0000 to 0x8ff0_0000 "config"
> offset is the same as the 0x7000_0000 to 0x8000_0000 MemSpace offset,
> but I don't know that this is guaranteed for all designs.

So far, it is the same for use dwc chips. If we meet difference, we can
add later.

reg["config"] only simplied our implement base on the offset is the same.
But whole concept is unchanged.

Frank

>
> v9:
>   [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
>     https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com
>   [PATCH v9 5/7] PCI: dwc: ep: Add parent_bus_addr for outbound window
>     https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-5-3c4bb506f665@nxp.com
>
> v10:
>   [PATCH v10 05/10] PCI: dwc: Use devicetree 'ranges' property to get rid of cpu_addr_fixup() callback
>     https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-5-409dafc950d1@nxp.com
>   [PATCH v10 06/10] PCI: dwc: ep: Add parent_bus_addr for outbound window
>     https://lore.kernel.org/r/20250310-pci_fixup_addr-v10-6-409dafc950d1@nxp.com
>
> > See below diagram:
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
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie@5f010000 {
> > 		compatible = "fsl,imx8q-pcie";
> > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > 		reg-names = "dbi", "config";
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 		device_type = "pci";
> > 		bus-range = <0x00 0xff>;
> > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > 	...
> > 	};
> > };
> >
> > Term Intermediate address (IA) here means the address just before PCIe
> > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > be removed.
> >
> > Use reg-name "config" to detect parent_bus_addr_offset. Suppose the offset
> > is the same for all kinds of address translation.
> >
> > Just set parent_bus_offset, but doesn't use it, so no functional change
> > intended yet.
>
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -474,6 +474,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  		pp->io_base = pci_pio_to_address(win->res->start);
> >  	}
> >
> > +	/*
> > +	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
> > +	 * so have to call dw_pcie_init_parent_bus_offset() after init
> > +	 * pp->io_base.
> > +	 */
> > +	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
> > +	if (ret)
> > +		return ret;
> > +
> >  	/* Set default bus ops */
> >  	bridge->ops = &dw_pcie_ops;
> >  	bridge->child_ops = &dw_child_pcie_ops;
> >
> > --
> > 2.34.1
> >

