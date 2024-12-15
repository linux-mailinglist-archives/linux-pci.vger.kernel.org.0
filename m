Return-Path: <linux-pci+bounces-18456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC439F23AB
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 13:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E68160F6C
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A81547C0;
	Sun, 15 Dec 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xw6qI8pn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53116145A18;
	Sun, 15 Dec 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265290; cv=fail; b=Xievnfk2M4rUemqEIoULVC5WvNjDAPWwCjNLPLuiKiThfo+oFTpgozPX5s6ubxHnLneGWZldCcrxy+pN+ehGbgADyntzFep33iNssNQS6qKFFulmpri7MjMxWyQGcWVpOuly++n/BrTFsd7pjvqPjUY+9sf+6XoljWTIXviOhz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265290; c=relaxed/simple;
	bh=L7wmcb/9lkOT49vYgkosOmmvZy4Vy5X90Jixe8/FaMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kkQy0Lph8dcuL6xLbzLDUcX/iFxBvAu1wHPBoQt8A16I1Vc3h7arfdrHFZNKtcBbdT740Tni4hiO2MRqlmL9Rq7vPX47BfeTRLbnK2ERsqrsUfo6kldULVs9551ZvuZ50IdalJq6M2nRVCo7oYSgQz5eAsbBnBQ24sTJZLBt8GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Xw6qI8pn; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhyDltQEApv5YCf3POn6YEBrd/j/doMKzVcRYjmBzi506vn6I/kisQmOOEd9AP30e8NwiE4KL/3Lm/8lLtjq29Dotp0/VwuCh3tRssU/LK2s2ucVuzSyW9xtp1S1XEWYeIWebEVstbEJoCjqODhLPbpohXhQzfjmW1e0HoneTteHvdzrH0bYAmPeHjt9Db2RFUKXFbmTQGnrDGDw8MAaANvkA4beb/oJSoDr04Gpn9lDEZeMNdPLcE3ow5fY7Bs9S0bVmuCkp5arZTrRwjhiK1j/vsDtF+9wlVFzaGQyp7EXwaiQmTuRm20oz4OJdL2y5bxiGJLmwWPRKJzy3DQ0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rk8bBy9fOELTltiCPU0qYpY5xZog3n0XZVtqDORZG4=;
 b=qlEOpK0xxJhbs6GetILtQ4WNVATE3Fp/bNCBAE5eOjCWg8CRSFR9HZnXhhQ3ZNGskkYjQUDyUP2jPGGmwEvB4LPJKcESOHVOooPERozhWX3ozDaSU9aD3MvNF+wJ0jG+oQitJTlJwBFrVjJxP0WRis2lEt5XsgJ6oxCpiX9JT92JYjUpGB27PFyoywSchp8PalPH4BmIa/X/nuWpGJ4MLwRUBNjgbVtZ23VIH4e1lwoaFuH2ZVAf7y7GxR02/EuGdk/yrhBpP/exbcFK11NBbCjcsu5cMPceXc3lHoeXpolSWAfP+1/jtLEnCTdl/PR0CxfFIed3gisYkgkwwWns0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rk8bBy9fOELTltiCPU0qYpY5xZog3n0XZVtqDORZG4=;
 b=Xw6qI8pnn50EMVErAtuHJjy5KMzwE0eR/5mOTvol+iFYYhtbb+9KwKBX5tf2kmvLGTiwrC7Jt29SA62/l3uH2DMIIsxq5VS94dD08jAQRXIwLxT3Gk/ITs+2/0GEGcJpVvF6/lr/14jniLhQXikePMWhp7FmSgJ9fOfLTET8xXZLqva73SIeOKreJ0+WIPpPFgAJiClaDVUnhh1aQhti9DEb9eft4/A08bBMbuqYy9Mj+EMRIMkCtUegjJxwhDDBz5Ay2vLn0wNzHSwrm8DGrQ+mZMADyOwqVTE+eer0imGQGUTu1r3RW5URUECyfiqVc2lYxy1/Ga/Mmze1y1Arnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB7152.eurprd04.prod.outlook.com (2603:10a6:800:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 12:21:24 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 12:21:24 +0000
Date: Sun, 15 Dec 2024 21:26:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241215132640.GA2476@localhost.localdomain>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
 <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241115144720.ovsyq2ani47norby@thinkpad>
 <20241127195650.GA4132105-robh@kernel.org>
 <20241202092902.rp6xb3f64llpabbi@thinkpad>
 <CAL_Jsq+R39jtCeDecpEHbKq+4N-uirMQmsuNG1NaVe1Vnnnv3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+R39jtCeDecpEHbKq+4N-uirMQmsuNG1NaVe1Vnnnv3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI1PR04MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e2fbcb-452b-4495-cc5f-08dd1d02fd9e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yytma0NyZXV1Z1VScG90cHpYeTlvUGJkbUhWanpqV2FDQmRDR2QvMDE1QXRy?=
 =?utf-8?B?WnVUU2RFdCtITGRUOUhGbW03RE1ndUtjd29xSjVYOEZvU2RxRlgzUG1lOHVR?=
 =?utf-8?B?WkQ0dE0ra3BESmsyS3VnNm9CMGI3Yll4bWZQLzExRFZXUG9YTUJoQmd4bDJ1?=
 =?utf-8?B?anBUbXRhZW85bG5MSzJVbTVUbVhKd0pCdzlGT3M0N1duR2ZYeC81eTRsK0ow?=
 =?utf-8?B?Rkwray9pd2lLZHJlSXlUb2pkeG9weWhRMnZtMVBmZHIvaEN2Q1ljM1BhMWxG?=
 =?utf-8?B?UDRWSHJaZ3dpZmpNSXl4WXZWbzRmYklVNk54RUxpWkFZRFBwRk1tVDBya2NL?=
 =?utf-8?B?b1BlTlhQQjc3MkJMMDYrYlpEQzVweEpVUEREbE02Y04weUdmeDdZYXlCY3U1?=
 =?utf-8?B?bXFINGlvNU5ybllmSUJKenZ2dEZNTmtXMVljZ0taWE1KMU1IVHUzNHZvbkpH?=
 =?utf-8?B?WkZsSXg5Z0d2cHZBNmhmcnZNd00yMmlEb05oYjVLc0w5WmNkOWVyNnpLVDc4?=
 =?utf-8?B?Y3d5dm1YOXhCNTBDdTRJL3JjMHo0dUF0YjlYNlBtOVdyc05PWGNmU1NlWDgw?=
 =?utf-8?B?a3U1ZW9NeTlhbGkrWTdWelFhR3NNV3FaUFZ5czZ2MDcreWdRanV1Q3lMbzY2?=
 =?utf-8?B?SFBRVTc1NEZoSmhycUR2R3V3OGJHeDFvWGVNYWo3b2ZvQTBPcXFSRExFMkp6?=
 =?utf-8?B?YklZM3FSL0RBblRFREFPc3UvSU9pRjArVVBDZW9NWEpyRUY0VDIwSk1iODRt?=
 =?utf-8?B?WFlZRHpXWm45QkpjTDNPTE5PTmJZWFgzOUlPV3JmZ1RsZkFTMjlZaDJTeDhE?=
 =?utf-8?B?TllaZ0FXRSs5UVBuVmN6US9hU1IrclI1SnE4YmpJNU9JR1VqMThRSHA1V1hw?=
 =?utf-8?B?Z2dNNExLUnRqaEtkRnViK2RNbmtWVjFTNk5meUk3T1kxQXBGL2UwcktWWlA5?=
 =?utf-8?B?eWhZclVQcGszWlBCMmpJVWU4Y2UyTFV0TzNDZVZsSVgxVDd1eDIxcnI0QW5j?=
 =?utf-8?B?YmJtaDBmMUNsY1hIQThTSWZQblkzSVRHQ3ZTdmRHWTR3RmF3VG5zWHlwVkxQ?=
 =?utf-8?B?TFk1RVQ1Y3RDbzIyWVpNNndMRFhTbUdnMENwL1gwclNsSjJ2VWFTNmhFc3RY?=
 =?utf-8?B?TG14TlBrcE5vNTlRdHNKeWt6bHVOZ0hvYmdGYlVEVjFTUmgwcTExYmdhekFj?=
 =?utf-8?B?RUNwVytyaDUxeFRpN3djU0YrY2htVWliOFNOME5MOFNlNmZCaVEwUWkzd1lO?=
 =?utf-8?B?MGdMbFZVVE9GVk5JbDBRcU9odEk0UHBDYVJiSFRBMHZqbDc5NWtFUGhtZUV6?=
 =?utf-8?B?ZExEYTlsUGRHUks2WVZuOHJ1MzQva2tqQm1PQ1RlNHdYM1N2OTB3YTIyZ3E4?=
 =?utf-8?B?YWFHSnVTUHBrNjVOa2VxQ0p4QTlhSVlUUDJjbFZ3czZmSHUwbEgwSFkxM3Fz?=
 =?utf-8?B?Z1UyNm1qWXFZemtlUnd3OWN4bnNMRkFFaU14eW9NVlVTTm5oSjNYMkVTbURQ?=
 =?utf-8?B?bnQzV0t2SnZzZGorYVRjdlZOTlB4M1ZBcjNDankvSTM4MEhqbU5wTFdiL0NC?=
 =?utf-8?B?SVh2bUhlQjhLOEFxYnlQSlFPV1BNbE5OWnZYRHZGOVE3K1JpVG5EdEZWb0Vp?=
 =?utf-8?B?YUo5R0d1QTZ3ZVcreHVGbnY0THB1M24xdGhoYm9EcXk0ZjBTb0pTV1FVRVRL?=
 =?utf-8?B?Y0ZjMG1iamJkb05OUFJZbFF1TXlaaEowZGFHdkRhSkEzOXEzMVVKS2M4N3RH?=
 =?utf-8?B?MlhoNlQwMElPREl3UTYzVzRLWFVNME5iUEF6bzBCTDllclN3dVZxWFhOQllz?=
 =?utf-8?B?OUQ3b3F3dElCRlVvTGExc0NxWXIvNDczMEI0WFArRGxvMzVoVFI3YVIwMG1n?=
 =?utf-8?B?UUNhU3JxRXVxMUdhZ0VBb2pTcE81ZnR0SEpFbmhkczZ4Nmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0NyaGtUclJQMWNoK1FweTFtSFcwVE01UlZoMEhYYXZjcHV6ZzVCYWpDN3Z2?=
 =?utf-8?B?aUJUb0wyaFlpK0lhTmFIWnZ4anJQYTcweVAwek93NFpzQjdraXhxNmkrZTVV?=
 =?utf-8?B?NkFFeGVCMmpqaSs5RGJDbjdoUHIyam1tRE5HU1NpMGFtZEF1aTlhWWk0QXdB?=
 =?utf-8?B?VmZmNnpObWU3b2N4OHppRjVxcGVuUzVBdUhTTVg5VG9mbktENkRsSllLTXEx?=
 =?utf-8?B?R3RPVDNMVFUwU21ZbXFLaDc1cjVwT3Zyd21HaFZkUnVIOTV3bHRiNFFyQS9l?=
 =?utf-8?B?UWNSVm1aV0NsYVk1bWdpblUwbnRJQXVyQ1FGTiszV2lobjdUclM3eHhuRS9E?=
 =?utf-8?B?eGowbHU1NG1TK3VlRE0wdXhGV1FwVWY0ek9RMXgxNS9CaGM0OExicnBiRWF0?=
 =?utf-8?B?Rlk3Zm41RVdpMFBhZ3ZidnQ0RERSRVJuUG90NnVLNTlPR3VsWW84WnYwaDdk?=
 =?utf-8?B?VFh1bHlKdTNZRFpQU1lFaHhYUFR3OUJrc3hyNjYvMGlBOEVSRG84MHAvMTRW?=
 =?utf-8?B?NVJ3L2NvelNub1g1T0JFcmRVUklCQlpBZWM0MnY3TVF0NEY1c2dmaTdIbTJz?=
 =?utf-8?B?M09RZkRUZUpZbWlFdTBNNmJ1R1F2NjYwcUpOSmhPKzRnVHgremJaakxjQTR5?=
 =?utf-8?B?SXFLRjN2cXZ5OE1EMEJVQXJPSTAyMEw1TkxsQ3VZQ28ySmE4ZXRoZnl5ZUhC?=
 =?utf-8?B?TGtZeHUwaE5KNXlldVZLYmNpd0xTT3V4R2lyRTZKejJWTG44THBWVUV2RHc1?=
 =?utf-8?B?QVY1S1NGK0FGZHJGRnFMS2kvR1pFTnd0QlVGanF5aUI1NXd4c0JVejd2SXg3?=
 =?utf-8?B?b0l4NFMwcVhyREZwMlJvdFk3elRVbXZJWGsxSXoyeGZaVHRMc3hPakVvb2ZQ?=
 =?utf-8?B?SEhKYnRrRW1nVXVWZVQzS2puYStHNEZFSVFkK3RXWU9LOElJcEJ4KzFUNGU4?=
 =?utf-8?B?ZDlkR2g1NVVhR3R0UG1TdWtnUW9IRnYza1hpei9VbFVpMzIvUDBmMHg3SUda?=
 =?utf-8?B?WDk5b0hFNFVFTDdUZE11bmZLV3RNYXFaenppZVV6Q3RYMC9iUzRBdGtKVEVS?=
 =?utf-8?B?bFlSb1c0ajYzUFl6V3QvUGtDSzNvT0xPOWtOOTFmdHJVNU9zZFE0MktUQnRQ?=
 =?utf-8?B?QmVlL2xBYmZ0cW16NXUyVUdVYjZJeW44UExIeENTL0ZmOW1uQURxUG0zdFpS?=
 =?utf-8?B?b0Y1OVNzU2Y2M1VqQ2oxYUl6dTVNQUhhL3dsZklGS3VmcXMzUUVXOE9FQlZ4?=
 =?utf-8?B?V2Q0alpuUXB6TFJBcm1WQ3d2OFd0anpQV05mc21sQy9RSDE0SU03SnAvQW04?=
 =?utf-8?B?cXVFQnI3VWJ6T082RWsxRjIvY2ZsaElTNHRnZHhGb2J4dE5iYjIrcmV3TG5I?=
 =?utf-8?B?aHZCekxlYjJGMEdFNEVLdDZXVElXUG9VcXdvaDVRaDgwYnFJV1dRMjc4Vmwy?=
 =?utf-8?B?czNJNm04bi85aDcvYmdJRGZKT2ZtTkhobnUvWUgvazhBenNTeG9jKzJEQzlv?=
 =?utf-8?B?MGxZRWtqbktGU0xWWUlFNmRCL1NWcUZZQ054S2xGNzVWeEduQWY4MjJnejgr?=
 =?utf-8?B?NjM1T0NCN1ZEUVVjYkJURU5VVnVRbUlrTkNWSEhuOWFkUW02Zk5PclJaR2F5?=
 =?utf-8?B?TlVxWXA4bkxhMWwrUHIvbEF0dGJCYU5vK2Zxd3BCUWV4cHNYNlNrUVB0djJm?=
 =?utf-8?B?QnhPL0xTKzNOODZNbmlwVW8yTldQRFJqVVFvL0hPeThwRkwzWUw0Z2doWFVp?=
 =?utf-8?B?RUJTVG9aMzZMZkVVSkFkUk5hMDEyZlNLWnhWWXhwUlk3dUhrc3lMZER4dSsw?=
 =?utf-8?B?UVBVVzlCdjJVRzZSMVNXTzdTOXU2d3JQZFlwVzNvK0k1ajg2QkNDd3o3WCt4?=
 =?utf-8?B?cHpKWnZPZ1drTnFJMTlzSW5XWmdycXhCMGJ5Q3BYWkZTU29YS0JpWDdFanlk?=
 =?utf-8?B?SmFUR2F1QTNJM0dRYTMwSy9HRXlwQWRBOW4xLzRydFRLNDZoejcxUkZxN3B5?=
 =?utf-8?B?MkJXK0RjS3F1RGJmMDBvVjBrNXk0WERFYVNuOEhLZitBK1I5eFZicXBjdXBv?=
 =?utf-8?B?ZG9TREVNMktRdXNmWlF6Y3M3SGVkdDlpcWQ3citBdGlxUENSbk5IckgxYytC?=
 =?utf-8?Q?XboEJ88xqNLmjsiYQXqSk1ecw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e2fbcb-452b-4495-cc5f-08dd1d02fd9e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 12:21:24.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl6boAbGc/shu/T9VLhRqu9IjHLFV+2OnKWZpb0+6B4+1sCcSW4RzimvIe38xVNgely5IC3zSM6MQu0x8DXMxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7152

Hi Rob,

On Mon, Dec 02, 2024 at 07:55:27AM -0600, Rob Herring wrote:
>On Mon, Dec 2, 2024 at 3:29 AM Manivannan Sadhasivam
><manivannan.sadhasivam@linaro.org> wrote:
>>
>> On Wed, Nov 27, 2024 at 01:56:50PM -0600, Rob Herring wrote:
>> > On Fri, Nov 15, 2024 at 08:17:20PM +0530, Manivannan Sadhasivam wrote:
>> > > On Fri, Nov 15, 2024 at 10:14:10AM +0000, Peng Fan wrote:
>> > > > Hi Manivannan,
>> > > >
>> > > > > Subject: Re: [PATCH] PCI: check bridge->bus in
>> > > > > pci_host_common_remove
>> > > > >
>> > > > > On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
>> > > > > > From: Peng Fan <peng.fan@nxp.com>
>> > > > > >
>> > > > > > When PCI node was created using an overlay and the overlay is
>> > > > > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
>> > > > > > so of_get_pci_domain_nr will return failure. Then
>> > > > > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
>> > > > > even
>> > > > > > if the IDA was allocated in static IDA. So the flow is as below:
>> > > > > > A: of_changeset_revert
>> > > > > >     pci_host_common_remove
>> > > > > >      pci_bus_release_domain_nr
>> > > > > >        of_pci_bus_release_domain_nr
>> > > > > >          of_get_pci_domain_nr      # fails because overlay is gone
>> > > > > >          ida_free(&pci_domain_nr_dynamic_ida)
>> > > > > >
>> > > > > > With driver calls pci_host_common_remove explicity, the flow
>> > > > > becomes:
>> > > > > > B pci_host_common_remove
>> > > > > >    pci_bus_release_domain_nr
>> > > > > >     of_pci_bus_release_domain_nr
>> > > > > >      of_get_pci_domain_nr      # succeeds in this order
>> > > > > >       ida_free(&pci_domain_nr_static_ida)
>> > > > > > A of_changeset_revert
>> > > > > >    pci_host_common_remove
>> > > > > >
>> > > > > > With updated flow, the pci_host_common_remove will be called
>> > > > > twice, so
>> > > > > > need to check 'bridge->bus' to avoid accessing invalid pointer.
>> > > > > >
>> > > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
>> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> > > > >
>> > > > > I went through the previous discussion [1] and I couldn't see an
>> > > > > agreement on the point raised by Bjorn on 'removing the host bridge
>> > > > > before the overlay'.
>> > > >
>> > > > This patch is an agreement to Bjorn's idea.
>> > > >
>> > > > I have added pci_host_common_remove to remove host bridge
>> > > > before removing overlay as I wrote in commit log.
>> > > >
>> > > > But of_changeset_revert will still runs into pci_host_
>> > > > common_remove to remove the host bridge again. Per
>> > > > my view, the design of of_changeset_revert to remove
>> > > > the device tree node will trigger device remove, so even
>> > > > pci_host_common_remove was explicitly used before
>> > > > of_changeset_revert. The following call to of_changeset_revert
>> > > > will still call pci_host_common_remove.
>> > > >
>> > > > So I did this patch to add a check of 'bus' to avoid remove again.
>> > > >
>> > >
>> > > Ok. I think there was a misunderstanding. Bjorn's example driver,
>> > > 'i2c-demux-pinctrl' applies the changeset, then adds the i2c adapter for its
>> > > own. And in remove(), it does the reverse.
>> > >
>> > > But in your case, the issue is with the host bridge driver that gets probed
>> > > because of the changeset. While with 'i2c-demux-pinctrl' driver, it only
>> > > applies the changeset. So we cannot compare both drivers. I believe in your
>> > > case, 'i2c-demux-pinctrl' becomes 'jailhouse', isn't it?
>> > >
>> > > So in your case, changeset is applied by jailhouse and that causes the
>> > > platform device to be created for the host bridge and then the host bridge
>> > > driver gets probed. So during destroy(), you call of_changeset_revert() that
>> > > removes the platform device and during that process it removes the host bridge
>> > > driver. The issue happens because during host bridge remove, it calls
>> > > pci_remove_root_bus() and that tries to remove the domain_nr using
>> > > pci_bus_release_domain_nr().
>> > >
>> > > But pci_bus_release_domain_nr() uses DT node to check whether to free the
>> > > domain_nr from static IDA or dynamic IDA. And because there is no DT node exist
>> > > at this time (it was already removed by of_changeset_revert()), it forces
>> > > pci_bus_release_domain_nr() to use dynamic IDA even though the IDA was initially
>> > > allocated from static IDA.
>> >
>> > Putting linux,pci-domain in an overlay is the same problem as aliases in
>> > overlays[1]. It's not going to work well.
>> >
>> > IMO, you can have overlays, or you can have static domains. You can't
>> > have both.
>> >
>>
>> Okay.
>>
>> > > I think a neat way to solve this issue would be by removing the OF node only
>> > > after removing all platform devices/drivers associated with that node. But I
>> > > honestly do not know whether that is possible or not. Otherwise, any other
>> > > driver that relies on the OF node in its remove() callback, could suffer from
>> > > the same issue. And whatever fix we may come up with in PCI core, it will be a
>> > > band-aid only.
>> > >
>> > > I'd like to check with Rob first about his opinion.
>> >
>> > If the struct device has an of_node set, there should be a reference
>> > count on that node. But I think that only prevents the node from being
>> > freed. It does not prevent the overlay from being detached. This is one
>> > of many of the issues with overlays Frank painstakingly documented[2].
>> >
>>
>> Ah, I do remember this page as Frank ended up creating it based on my
>> continuous nudge to add CONFIG_FS interface for applying overlays.
>>
>> So why are we applying overlays in kernel now?
>
>That's been the case for some time. Mostly it's been for fixups of old
>to new bindings, but those all got dropped at some point. The in
>kernel users are very specific use cases where we know something about
>what's in the overlay. In contrast, configfs interface allows for any
>change to any node or property with no control over it by the kernel.
>Never say never, but I just don't see that ever happening upstream.

So should I switch to use configfs for jailhouse case? Currently
we use overlay to add a virtual pci node to kernel device tree.

Thanks
Peng

>
>Rob

