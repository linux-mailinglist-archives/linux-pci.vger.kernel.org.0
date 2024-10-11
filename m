Return-Path: <linux-pci+bounces-14257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DD999B90
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 06:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74965B2305D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45F1EF0A0;
	Fri, 11 Oct 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHNsLIq3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780361F4FA8;
	Fri, 11 Oct 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728620020; cv=fail; b=P3Oazrma0BBQpw4c4ZNjKX8VhoGmm1WoskdqYHbDmiPwjdXErVK4UbTxRgZAcEfIirYz7zv7frGCjyEVXAsrliiaGi16gZ5W6jitrAhb9MqKLmgAdRS0TJWy+dbXAVgC0mzs1dDhtQBWMFc3x1r2HV/+gd43qyhpQYQ+50QwSxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728620020; c=relaxed/simple;
	bh=daFV1mTnsaJ5orSZx97uD9ffeIflPQH7q7LKaeCKc7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ng4A10wI/mYSqzo/EgLQhI7WG8m5x5bn19ylz6+Gj/qWf8eJKPUjkg6/btXVO5aPqKzgaFCKMdGtH3YiB1tQtQQ2Jj7c6+v4Po/KbsSCFlpYQNpGrF9cR2vjYLIqRs36r8LjxYUOxnjL+uKNJaNMYbh83HnwxU+/FR0+P+vhDi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHNsLIq3; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icQAhB7FlVbVKiPFFERF4bZHFlExT1ljq6ukL/XuKMWZOnkqnC9+C5ufF/hS4dyD32SIpg+rKgyLMgKQc28u6eJ9Kk7MTkKxQefVUDRlXwHq3U0gfGfIG+6lgLR/bx0kq649+ESnU9bxmvpRQLomujSdzRQTIME8bVQYpj3LyzZ7PWHMlU+lapkdJDbMiRsWyX5IhDbcR7Tkzn+gQ4v44gJ79dFXSsoUxfdoCwP/QxPfZE5po6+jPVGGb6IPowz2tNRoq2X19RDnRLd3mdrqf+bknBEja4tIWeKYuCXXuyYXwyNMxfqseOsamdGNHM3n4QUj9d/isOAosya8El4m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsIPnqP4Ob5XT2cFtxJGfn2GyNKOQWk0C4XUuKQ0qdw=;
 b=mr4ULvWV6nSbbT61WjPP0FSbjwQzBqvaYXzYrG9KEJ/02XyeFqtkUFrSnr/kn5NBWI7d604H1/sy/AUtf2CKgIvd7t2YiNY9KSpWd7mggj48JysiFclOtFO4YYNUepyf1IrM/+uNE1UxJSkocogJjU0HnOC+8hR6urDJKTGkvwuyzJKFTIjcg3e7iiiSWRGv03zBVMBIzXwSXyTdMHiLP6ErrimdXsbmLEs/SoaD3ESBvuYYFUiyKeaiPijmacfmTQpnUIAT1zgyfY9Z1yRbUyXBhI62edrXRjzw/5HMHPgGmjHBM+m2qNLrhCwdUQgpdHEMTacwtlbSZCc4GyIItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsIPnqP4Ob5XT2cFtxJGfn2GyNKOQWk0C4XUuKQ0qdw=;
 b=hHNsLIq311eaPMizudYllHr9KUUdl3WV2xXozHNa/tr/n6+YmdlfJecmdYeVDfiguluAc8o8/hRgfq0oKBMh5V1bVh3aAonSb6mtNJtoVmmxXP38wqwGtpPPPEFLuITD1Erfn5Iu8XJD1oobSe2v5gbTaSRpD7ouGeE1pSyDbOdAp7AJ/shsEBA53uruywXNYJguYC/iHzeBu5Qkb0Vg1h75atsbQXl/h8IsnH+RUStHGZU5v+t2QBBMz9ZTqn8f45Y9FyLY378WR0plnF2xgT/ycYfoYYYH0fs0KKuCGkT+DKEkhL/Nb/02Gj1izSr4UzSirDSJHtDEGeYBmw1CJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 04:13:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 04:13:35 +0000
Date: Fri, 11 Oct 2024 00:13:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files
 and maintainers
Message-ID: <Zwil5tBLtO0X6/ke@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-12-wei.fang@nxp.com>
 <ZwgpF3CJepAklWeT@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510EF1F7A375A16211F26CF88792@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8510EF1F7A375A16211F26CF88792@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9375de-dd43-4536-44cd-08dce9ab131c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZpTklkZnFOMis2bThnUUtuSVFmbDN0NFFGczkwZlI2MEtnN0Y0c3pTYXZj?=
 =?utf-8?B?SnR3VWJ1VUpNQjd1VzBkS3hXVzZPQ3VOc2t4UWpKZzFTZkNFZ3daVitPcXp6?=
 =?utf-8?B?TVZoWGRkNzBaYUNwZnEwN2RieS9GVDhEaEVvamVzbTBmRmo0L3oxRkQzQWpx?=
 =?utf-8?B?aklGdTNJNFZrYTJZaWxFaS9qb2F2c2YyZnRlN0d0MUdZc1NCdS9UNTBpZ3Ja?=
 =?utf-8?B?cjV6YlBUS2pLeVNXdnFwejNuNHpweW11Mmd2YUhCQ0pueDJZN3MrSlh1VGxz?=
 =?utf-8?B?cnhCY0pzTVN5eHBWYmhpWEcrRUYxS1lsK3pkQnpCWnpNbDVMVjEwdWh4MG5q?=
 =?utf-8?B?U21JTVhrQ0U2enkwb0w2YnJBRFBiQ2pySEVmVEw2UUNnMEsvNzMxVzlVRGVx?=
 =?utf-8?B?bVFmNVVwNkl5N255anFONWZGRVJBbm82V2MxVGVqUCtlYzN2d09OKzY1NmNl?=
 =?utf-8?B?cjdwY2tSa2dpd2dUNEJkL1JmNmVzQmQ3TWJWWGhMeWg5MmVxYUgrRkptUHlT?=
 =?utf-8?B?WXRLbXI0RWU3Q3RaUmwrenMvUUtjRFJrNU1jYmdSY3hpdUpQeFRUVG1kNm5l?=
 =?utf-8?B?YWVhUVY2UUVTWUFIa3B1bkx6QXBBVkZzak5EWDhLVm1ub1BKMldkODl2bjlm?=
 =?utf-8?B?MUVzNWxPa2M4MDNIbGRGQlhWRmlhVEx5YlE3OHVTZDlDWURsU1FvOTQyUXpZ?=
 =?utf-8?B?MmYyVVhvdFFDUlJsOWs1ekJxQUN2LzIwN1BpWEhHSEYyQmZ4NEsvRVVIZUdm?=
 =?utf-8?B?bVU5N0xmcEt5aHovYlVRd242NThvQ2IvU2NBcE1uL2pWcGhSb3dQeitPamxp?=
 =?utf-8?B?U0VjL09ZYk9Sd3dYSndNQUxvUlRRaUZSY0xPekhrRXBBbkl2Z3pOWHJhYjVX?=
 =?utf-8?B?Y3FEOVNFVDlFOXFHcnJyMW9kdGJoVm5mTU1QNjNRN0lGdFJUdnpEbjQ4WllH?=
 =?utf-8?B?a24vc2Zva2tPa2JCbTNja1dqT3I2NTA4eitZYWVmeHlWbUxqanJzZndYNDkv?=
 =?utf-8?B?NzJLOEMxbGpVQ0hnVTZ4RzMrQk9SY2JUbXhVbEh4UDllcEtSSW14QjRMMXc1?=
 =?utf-8?B?dmxnVUFibEVMdEptOFBDUXJUVDVGVjZOY0hnUVBkaEpranQyWldxMVFpRGV2?=
 =?utf-8?B?Y1FJNGJSdzVnMDVDK3NQK1ZnRGwzMUs0WW9PMUtMdWh5UEoyU0MwR0tVRFpG?=
 =?utf-8?B?dTltRTJvUHo5MTBHbzQwc2QyUnRMbng4MDFySmI0T0M1blpDcXBBaVBsejNT?=
 =?utf-8?B?NUVJTGdKR2ZZWlRrb0NTWDY5cDZRK3FDdEJnbGtZSm1uajN5RnliZ0FvMVVZ?=
 =?utf-8?B?dWhRUTZSeHhhR0pSTjdkNUpPaEQ2Zmh2dEdWeXJJWDY0clIrcnB3UCtVQmR6?=
 =?utf-8?B?cFl6ajZzVHNkb0hKMm5yc3lqdGFXdk16MDVJN1d0SzFKUkFzOTZIYjJwZU95?=
 =?utf-8?B?aFFvTVZkR0NRcHMwMjdzWkc3MlZNengwY3ZqQ3ZGQjFweFdQbWpCLzVWL0c3?=
 =?utf-8?B?dVpDbVZHSzhSUnlLME5iQnVYVnRTVXNaa1RzUjg3UW9JSDNkUFdOUjJnd0Ur?=
 =?utf-8?B?MWl1YVNodWhmRWQ4MW53NWVJRHl1U01kTzZoc1diOE9OUHVpRFd1cnJFbjhs?=
 =?utf-8?B?VElzZ1lPdWgxMEduRzljRjRWdjNNaytzWWxYeUp6QVJvd3RycHNuaDR0TldZ?=
 =?utf-8?B?TkFiVFYvTmhBd2s0K29teEpRRld2TndBaGYwcVJSR1dkWTlsQWlsVXJiT2VM?=
 =?utf-8?B?MXdxL0Z2SlRac3U4QUVaaUV4ZlBNd2JnWGZHdlBIT0pqS0U4NjFRV002Qm9I?=
 =?utf-8?B?Y0JaNHVoWFhFVEd2T2R0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE8vMDRvdVNMMmdyMVRjYmhlZFdoZWI5cVNDNHF6OU84aDU1TG5nb3BTdi9C?=
 =?utf-8?B?NEVuUi96UXR0TUUyZHNnQ21KSWJUNVgzSG9hdE9DRnlGQzVadjJlcXpaQUZa?=
 =?utf-8?B?cHFKZURxU1diMnUwTm1ZOVA0Y240L2w4TEJEZzVYRFVIWHY4RWpsZUdIckRm?=
 =?utf-8?B?amdJTEx3bVJIa0Y4ZURHaTdCZXIxWG9iLzRUY3h6M1BSNDdkeEVKQm5LNVBY?=
 =?utf-8?B?UFRyZHZHZEM4cnBvMjNpRUZ4S1ZrcGJmUmVQeXJQaGFKUldnd2FoeWVCTTlR?=
 =?utf-8?B?bEhSVWxSWERONTQ5dHlDS2s3VmJkQXdtYW1IbWp1RnY2K29XeUtzY3d2ZGQv?=
 =?utf-8?B?NjRScUc3TWMxY3M5WlE3cjNoQ3ByOXdOdWJjTmlSWE04TmdyMkp0d2hDSXFQ?=
 =?utf-8?B?SDhjbUtOV0laWHNUOW5LUG9PUmVhcEZuVVdNcmdQSU9welBVS0hwdUo3OGtF?=
 =?utf-8?B?MmR0ZnpPV3M2WnZ0dXVXVnpac2NkZEl3YVZjbnI2TDBSYm9FWU9ra3BmNmVp?=
 =?utf-8?B?VmMvTkMrR1lkVGRNVFBTOStMNnJkdERkdXRjZHVHbFE4S0pad0l4RDJsOXpB?=
 =?utf-8?B?U1o1cHd5Rnl5a3BiRkRYazFCTWpvaGVuWGRlRTVvcldXNjB2RmFmL2ZrSlQr?=
 =?utf-8?B?ZXdDaHZzOE1pL3JNYTJrb1JZT1RwMFM4Tllxa0NWdXJRZEpxcld6dWdoT1VD?=
 =?utf-8?B?Y09lWG5hamRpaG9wT3dWbUNjTE5sbkxRTTRsb2VkWWhMM09uRS9ZMlJUSElj?=
 =?utf-8?B?WEpqUkdZL1lvMmFWZkFnMW9xa3I4cXFXRDliU2FXcVl0elpwMnpQcHN4S3N1?=
 =?utf-8?B?UXR2YXY1cjc2REVGNC9LUXNlQyszWTRVeG5BTE1KOW93QlNrWUJmN1dSOGdX?=
 =?utf-8?B?NGtwLzIxbTl1VTR5UEFGczkrRFNjNXZOc09kVTdKdWl6bTcvTkhQeXpJS3pV?=
 =?utf-8?B?TDZUUmlyVi9UaUI0RkZtRXdENnA5MlZnUkhqZjdyZmI2RWJreXNkRFFQWnhs?=
 =?utf-8?B?OHRxQk1zbk5ObEQyYitKd3FEK1dkaDdHNmtyL3l1dGdWUkphYThxZ0xZMWJC?=
 =?utf-8?B?TE5PeGtHOE91YXlMYWtsYXNPakI2UzZnS0JCdEpFM0N0S0NraERYaGkvLzUr?=
 =?utf-8?B?elBJZ2xqZm9wRkl0ZmxQN3dLb0dxK3BWNEUveGx6bEZqaS9wQ21URVJGdkp0?=
 =?utf-8?B?SVorR1Z2QU5ER2dTSWdXdU01UHdoK2ZIUzJhY2VUYTRKNXpLS1czaW5NV0hO?=
 =?utf-8?B?OEJqUGhhTCsrWWNGaWxpVjRSUzRLb3hoeUV1VTZBd3VrUmNVa3B5OHhsQnVM?=
 =?utf-8?B?cEtFRUVaRXp1WUpmUlJ4STlKSlB5aHUzVHpSY0FPa3Q0b0lsSjUwRXdQVzFL?=
 =?utf-8?B?Z1RhV0x0YWxuNWRNRWdJTWx0bFJJTXlMUXY5SU45SUIxRTVRRzE2Mko0RGxO?=
 =?utf-8?B?RFo5YVJ4VUtuYUFWS0x5dG1XUHp1YjNyNlBXWlhhdkNtd0tZZWUvOFdTWFJo?=
 =?utf-8?B?eTlZSnNITFJ5bjY5MHgyN3IvOWcrODZTeTVjc1BKYnNiL3NMR0dHdkVoWGFy?=
 =?utf-8?B?bmhoY0l2SFNlNWlYeW9xc295WDRFZjk5eTlTODJ3RHNaOWJtS0NLaHRreUtY?=
 =?utf-8?B?RTg1Y2JNTEVucUxCNGtBQlNMTlBFL2Rnc1VRZWVXVTFSNENtQ0IxTS84MnpD?=
 =?utf-8?B?TVI2OVFCT29jcW9vZy9HaTJqK05oUGxoM2pRY3NuOTlmdmQwdVduSENDOHJK?=
 =?utf-8?B?SjBxY2FGWDdVSTUrOHFDRDUyM2hVNVpBZ3FCUmM4N0ZsaWlMY0lucTRLeC83?=
 =?utf-8?B?SjF3VWhwa3R2NCttWTBwQnk3M1NaNW05T1JqNmV5RjRHQWlpWlBBdlpWQU1B?=
 =?utf-8?B?R3BGdFp5ejVlSkFIMVY3MDBpMHduLzF2cmhFZGg0dHROVnBpSDRqQjNDcURX?=
 =?utf-8?B?R2lyUituUFNncTJhRFFkS1RjL0FrUjFUeXBIMU1rM0lERjIzNXFLRDhNY3lX?=
 =?utf-8?B?SGJBR3g2dWttVThqOXVacTN0L3I2WWVrYlpUazEzdi9aeUwwQmt4OW9za1l5?=
 =?utf-8?B?SUZHRFh0aGFnS0Q3S0x3WGNjT3JqWFNWM0hPSmt4cTNHTmZCSEV4V0hsQmsy?=
 =?utf-8?Q?c1IE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9375de-dd43-4536-44cd-08dce9ab131c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 04:13:34.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYWrs/wv4lpcTv2AIwEKoQ2/3gq+p2QjFczUprth6op1TLBEVDv7SdUFd/sric+6sB36uuF71NJSIBOpmeUXWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952

On Fri, Oct 11, 2024 at 02:05:37AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2024年10月11日 3:21
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Vladimir Oltean <vladimir.oltean@nxp.com>; Claudiu
> > Manoil <claudiu.manoil@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > christophe.leroy@csgroup.eu; linux@armlinux.org.uk; bhelgaas@google.com;
> > imx@lists.linux.dev; netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files
> > and maintainers
> >
> > On Wed, Oct 09, 2024 at 05:51:16PM +0800, Wei Fang wrote:
> > > Add related YAML documentation and header files. Also, add maintainers
> > > from the i.MX side as ENETC starts to be used on i.MX platforms.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > >  MAINTAINERS | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > af635dc60cfe..355b81b642a9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9015,9 +9015,18 @@ F:	drivers/dma/fsl-edma*.*
> > >  FREESCALE ENETC ETHERNET DRIVERS
> > >  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
> > >  M:	Vladimir Oltean <vladimir.oltean@nxp.com>
> > > +M:	Wei Fang <wei.fang@nxp.com>
> > > +M:	Clark Wang <xiaoning.wang@nxp.com>
> > > +L:	imx@lists.linux.dev
> > >  L:	netdev@vger.kernel.org
> > >  S:	Maintained
> > > +F:	Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> > > +F:	Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > > +F:	Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > +F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> >
> > Missed enetc_pf_common.c
> >
> enetc_pf_common.c is in drivers/net/ethernet/freescale/enetc/

Oh, sorry, I miss it.
Maybe

Documentation/devicetree/bindings/net/fsl,enetc*.yaml will be simple.

Frank

>
> >
> > >  F:	drivers/net/ethernet/freescale/enetc/
> > > +F:	include/linux/fsl/enetc_mdio.h
> > > +F:	include/linux/fsl/netc_global.h
> > >
> > >  FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
> > >  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
> > > --
> > > 2.34.1
> > >

