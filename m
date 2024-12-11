Return-Path: <linux-pci+bounces-18185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A759ED7F8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D9A2838B5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D023FD26;
	Wed, 11 Dec 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vv0YXuVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA628239BB2;
	Wed, 11 Dec 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950693; cv=fail; b=O3cs5gawom8wkWFdUSJ8zGD8/qtd7Z+lYRwwAa91Z0waP3LaDvQwyUVB3xyIna50cmFkuAy5ZSyQh78fU00iuE6PNRDB4czQW6wjU5Vw1r5f3lsgFKfoQAYBmHdXrs8SyerzAybSz9EHLKpzt9POQg3Caon6YZqSWalbaZKt/dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950693; c=relaxed/simple;
	bh=D50BZ5miN8e3VcmEA4cRlQ94cGINq2BVNdkDZoLWxHU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s1tefaIA/yirGJGqnmUVHqMzWUywBnhHymVJ9A64R1ObUh7WhoD9U3dHnWyEXQC/g3ruS4GLuFK5Ntu25Qkj8TiZV/vF/oQyhi9+Sji3/jKL9/E4arnfUa1ShZLcv6jtXjauBonqiZq1/fhFD+c9akQv9g9c5CuXD+ZUuo/LeYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vv0YXuVq; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3sVGIpZ29YiCGDxXBjg4Rkj8OAC0PgBfgezjnIX+z0YLV04fBV/JNZa2QJoGgwQKonUNuq+MVvv6Nw/2T4khvnQ9GaywtRtMw43ZFDC0OVapCsodeevA/N+Z49oTeZJZHkpTRxvBWSpdXjF3gkcUM0QBix/DyZl2ABQhi6txEF+BXoVvLD2K09pyDT5VP8JthDDlkMZP+dqOBIUrxxBw5LE8EyS8V4emxicj0Dxu3mIIUjtMTYW73ZNb6K4ETF3rxdwEbk/iuPO9Om0BK5xqgaO823mi2InF9MI5eYpt1kKwkuXLmqhJMICrrt382RPFBNYzIgVDvrMMgfTDAnAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36Izu18hCRGkuhjDFOd9R0YMGeiuE6syosxzvqdXwDI=;
 b=YU5zBA8jk4eEEA/05AB+sOclZwZEiIvsFai8AMVRMeJjdNIBu4XiPDOzx56bBQQyP3pazjNzOTLEMdHP4kot/102o++8c4C0hvhhaVrVOvNeztTgbGIMUohksFUdoR4vtgv74hgnZ4VE8LxTU3iWYLBBLU7QplMurVSEYpfZVJfoq4Z1P0fP/j/vFP7OCJM8fwvdg6BcNDid53MTxFqugeAtrGPq2ocIovfIBPGb+QWy0SkcP+fQyrHwiHQiuP4wv6Fu07V0DdrO5NbIcoIv41yeyfeF9pAVB17cyYUc9UbO5TdXV4k7L7CwFWc2SdFa0uLzVxayv+Em6XAPERApFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36Izu18hCRGkuhjDFOd9R0YMGeiuE6syosxzvqdXwDI=;
 b=Vv0YXuVqpYUA8F9pWeHCl3lZPc7dqRDO6l+r+hpnQLax6joQeDQelvu4O9cyW5D3FDHgVTGb8LFE3FpYNpWlmehLeA0nVqmtF1hXUpP7fOaOl3UDhOQsTcSUEfOTf+fqtyW6ygcuudsyiU9BqeAN7+yloVwr85MVkBxfo0+Y4OaM9Kb3PewZkd/lnpTVPvXTm2oL8GCexTuVJn2qMH5uBLWy8ycqtpvWIHRPflP/nYFds0uj9N9MQv/1jmYUqZuQtePzCymwd7O7gOr+HaQ1+ycJ5hCZeEd0kqEeiDpfGD0+8fjXZTa8gexhwcPJ3a5dsP1bTsCrDKHuJbQ6LEjjwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:33 -0500
Subject: [PATCH v12 5/9] PCI: endpoint: pci-ep-msi: Add check for MSI
 address/data pair immutability
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-5-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=1254;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D50BZ5miN8e3VcmEA4cRlQ94cGINq2BVNdkDZoLWxHU=;
 b=1sb9dAGttqH8P7CjUNrMxsMzRP0NEC+vA4sl2/yVV3DBxkKNXbba9W9FhU+m4Am6vJ+q6eUZ8
 PIoONzggDPMBcArX/Sl7byxm2BuatYebiIdx1mUpu5DS4UDtwqAmPan
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: d157aaf6-9c68-4bdf-8e98-08dd1a26849e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmJRblVXWC9mYVU1YlJvOEo4U0VvdjllOXIwU3padXdyOGtkS2RRbStrU3JB?=
 =?utf-8?B?YXdKTklOYVNCZUtQTytjSE96NnRsRmluLzRpa3FCNisxOFdHV1E4NjRBSDJh?=
 =?utf-8?B?aFM5K1ZwbW84K3lCZVRSOEMvRUdhWW8zMjZGeWQrMUk4TWZUVlp3dmZVdnhQ?=
 =?utf-8?B?MmlnRys1cHFZdHZDTGVzY3kvVmxvbCtsQkp1eXMxdXYzdzRidk5QTmM4OG15?=
 =?utf-8?B?WFYvOURQQVQ4bW85ckNwWU50eHlqeFlTUGQyd1o2dzZHemlQUS9oNzJiL1hI?=
 =?utf-8?B?enh0QmxCWFN4SnhSSk91Wiszd2lIT0t3aCtibkJzMjhwaDBud2dnZC9LeGF5?=
 =?utf-8?B?N3JqaFBvei9JUjFiNnFGellyMFRTaFJXWW54eTAzU2Nocm55Tk9vS24vbmUz?=
 =?utf-8?B?UkVFbDNQdHJkcFR0ei9Cc0ZzQmd6dkQrUzZrd2V4RmhtZVd1ZHFkZ0ZjT0Mw?=
 =?utf-8?B?ME1DZEwrOHI5T1JHdWtoNmY5eTJzYmpmeU1qcUt6TTc0cFFQMUloM0VzRnFJ?=
 =?utf-8?B?ZzNjd0lsOSt4WVhtd3NyUXBQVWhFNTdyN1RjRDRqVFo5c0prc2tFZzFSQ05Z?=
 =?utf-8?B?dy84cmVNMU1KVGl2NmhCSytObHZHSlYrZGZhYklaTS84YjMyL1ZRc0RJVHNi?=
 =?utf-8?B?dFpUdjM3ZCtVVnRydzFEZ1o1V2NCRlBCRytXQ2xmd0ZBWFN6K1N3RHZwWlpm?=
 =?utf-8?B?Qi85OUpyL0k3ckp1WERsTUJIRzF5bEs4Zm5HbjlXeHZyQ2R2eDkwbGV0c3Ri?=
 =?utf-8?B?RTZITHJmMVRyRUQvelpDZ1VRY1JtcHlwN01tNGxacjltSmJCWkxHR1g5Zjgr?=
 =?utf-8?B?VGtzRitvTE5xdDduNTUrSE5BOCt1aE1jUExQT29zRFVXdjZZN25zSUUrcGdy?=
 =?utf-8?B?YVJsUzQzU2phc0EzZVQzRTVuY3dxTEdtaEs2NEw2S0hEeWsvcXU3a0lLQ204?=
 =?utf-8?B?ZWlVTzNtK3hkZzFhSm81UUQwQUNaZ3NLZUVBSDF6aFBrbW9yQmZva2g3YXZX?=
 =?utf-8?B?M2xGdm1vNzhOVnVmV3VyTUE3a3g1Q2xSM1E2bjVqQTZ0dmdGallxMXB2YXNu?=
 =?utf-8?B?ajRENlhwR2t6c2tIRXpsVGNOdmh2VHhtVm5YTi8rdU5YRXhsVHFFTjk5Ukpa?=
 =?utf-8?B?OEp0bnNvdUp3N05FSGxkMk5Ta0dlR3ZEc2dOaThDSENEdmtlVjhkNHhnY0I1?=
 =?utf-8?B?U3NXUldlSEs1MHdzVzlrcEVQM0FNVUJJd2MzWkk5a25DZlR0ZjlTc1JaWDl3?=
 =?utf-8?B?RWcwZzVjQzJUVFhDc0hmUCtJdmlGMThUMldGK08vbk0yYTdrb2k4OC9TYXBE?=
 =?utf-8?B?dUZkY1ViZ1UzSEFJYmJJeVlJRXRQNGptZm4vSk9yL3gzS0xYdng4NzZjWm1U?=
 =?utf-8?B?aTJZYTB1cUsxaEFXcFFMcXB5UzBTN3hKRjQyeGdxbzUvcGpZY1V6dGovdGQ5?=
 =?utf-8?B?aW9venk1cXFtYTRRVGJuRWZEVitKdmpBME9Ud2dOUFNONDZnaWMyRWVydFdl?=
 =?utf-8?B?YlYwcjdROElnWVVQRW95REFzWktjdUM0RUhacmZ5T1RGN1c3ZzJod21idVk1?=
 =?utf-8?B?RllUN2hqVTd0Tnd0d3hCZzA1NTlBY0xBOFpVYVpVUmRKZTc1dGdGS0NUVnov?=
 =?utf-8?B?MGdoanFlUW85MzBPc3JyYlZGWUxPc0s1T3plWjJVdkozcTJzeUFTSXlxMGVG?=
 =?utf-8?B?dVBJcTJJQ3M5Wi9Ed2lSb1JJTjZLc1A4REFrMmg2ZkFqRjB1bWFsUS9JK2ZK?=
 =?utf-8?B?Y1dFWUpBZGxwbW5lVTJLQWhaQXlaVkpSQUhwYW9RVjFzcnJYRit4WWRSYzFC?=
 =?utf-8?B?UmU0bWxxQ1pPSUNOQk9FL0NEbU9BMFJmTkdNNFBSeFg0R3BxNUR5NytWTkh6?=
 =?utf-8?B?enA2MGxTalR4NHJqYkJtNVJCMEU0VC8wWEY1cWJSelJzL296NHhSaFdSMUFq?=
 =?utf-8?Q?5vdxOJWmVhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFg5azdYUFV3TjJWOTd2QnprcVlDRjZSOFpSODFaRjA1RmNySEF4TnlvWVNH?=
 =?utf-8?B?Z1ZML1Rxdm1qQk50UGdaTjZwMUkwdWdHQ1dmVUV1aWt0cktSY2VSaEZzK2FX?=
 =?utf-8?B?MTZJK0d0VDFCQUdsQ1o5MnNRR2FlMWlubTNkWkVtOGtEMTVKWDRtQWc2UUZq?=
 =?utf-8?B?OC82UkcxeUpWQThaSy9Kem5ieEpXc1hndUNZNWVJS3E2UUpIU2hzbUYvYUU5?=
 =?utf-8?B?bUQ4ZzE5bnphVUIzWWVyYXV6WkZFMW13cEViQVdLeXFiMzhnUnlaYnZpUVlw?=
 =?utf-8?B?S0FiR1o3K3Y3ODNHZnEvVS9SWlJqLy9jVUUwM21uemRMNHRsdGJqMnJoQWxa?=
 =?utf-8?B?bG9hYjFkc3AyWTdyOUV0K3hyYlhtdkZJaFJocGRjV0tmS01tNjdCejhXVHRn?=
 =?utf-8?B?WXB0WXdTbXhpYkJTd3pWN2ZHdk9MMUVyK2UvaVJGcW1VQ1JaSEhLYmRoWjFy?=
 =?utf-8?B?bWdHalB4OFJpTSttb3RzdmoweThTTFJWQlF4T3hyREhIT1JzcU8xdXV1blBE?=
 =?utf-8?B?SDJwRGNBZWxORFlvaHpCcDZVRVZZdkhOZTA4UUhkNGJIUDRVOWo4NWxmcEMr?=
 =?utf-8?B?MXFIMjNOQTZ0eXp1Rk1PcmNNSUFRWEd3YW91S055b0N1RzdaazBpMnpacnlY?=
 =?utf-8?B?QTNHTG9XK3d3MkVlSXJGa25jaU1jeDBYRGZ4SjhTQmhMaVFHenB2aTJsV0Vv?=
 =?utf-8?B?akFTWnZJMjdCdUlCN2R0a2RGemFOWGxIY2JyWEt3bkF1OXI3K2diVlpUK003?=
 =?utf-8?B?aS9PVjVOZXhOTVZnck0yYmMxaWgwNHE0UXYxN2pkUHVJMG1NaENTYTNHUVRU?=
 =?utf-8?B?UDBLay9vTUE3eTZNR1V4TWdheEtPTlRQRzRKQUJEbWV6ZG94d2JuR0RHcDdZ?=
 =?utf-8?B?TTJuNEZUamFteXgzTkNQZzR0ZjlEZTVVY3g5RkhiR3FBci90ZTVqMHhhQURM?=
 =?utf-8?B?QzFsLyt4T3ZhZ1JmSEFFb3NrK2ZEcnVVMEM2SWZ4QWlHS2lZSE5ycVkrK3Zu?=
 =?utf-8?B?bEFyUjc3VExLRXZleDRNSnF0ZjFRUmNMcGpjbzl4M2V4elV6K2YwaU5YR2Ez?=
 =?utf-8?B?bkNGVDRRbE5ieGkvVjNYYkdBM0h5Ty9MUExXckdjRlplemZRcGk2Yi9uSkly?=
 =?utf-8?B?MURHZWc3TUVJcVFBQ3I5S3lYbjhya3FXNUgzTWlhTVpPcm1nWTdhTlZpL2FN?=
 =?utf-8?B?c0ZpaG90bFBkeGNBVTJBMmNDRXFCVWMwQnZ4QnlUemlyUTdpK3BTbk1WS1Qz?=
 =?utf-8?B?SUZ2bUU2cGFLK1Y2Y0VvNSt0WDdXR2crOE53SVJzcjhPb2QycFYxWUVyT3dE?=
 =?utf-8?B?NlBrbDUwZXB5MitBaSs1d0ZkNlNEKzBFMUVYanZYcWtveW5Eakh0bysxNzFt?=
 =?utf-8?B?ZktYaWFZZ2JaUDhzNkJsWXo0cFNkT21naDBFVWNKZDlQNEk0ZjVibVJGL3la?=
 =?utf-8?B?V1RCZXhMWXZHT05ja0Z0VlM5N3RtUUwwb1pJZU9vd1hEdmZId2FJcUw1ejBl?=
 =?utf-8?B?clc3RE51MXQ2VEtoQjFqTGJLT2I5TncybURreFJNbGttREo3TmZIODQwRUpj?=
 =?utf-8?B?dVZWd0UyMDBrNlcwd3hnNlRmbVBQRGFrODJ2eGh1clVVUTREQVcvdEVDcDlG?=
 =?utf-8?B?dnh6VmRDQkVvNC9qVDhNNC8wcW54WVRFTzM0MSttVDF2V3ZHOEFtTlRCb1BC?=
 =?utf-8?B?WGZQczMzdCtPTVpnenFQWjJORzVDdXFRQVlMeWxoTkhhNmtBYVRQek5Gc2dE?=
 =?utf-8?B?K1lGQlZCOUR6YnJtUlE1Zlpzbi9YMjZudWIrd3NGOVV0NGhVcGVrWWNxMkVp?=
 =?utf-8?B?aDFrQ0R3a3YwNWFsR3p2S1pUdXBWTGQ4dTgyY215SzFEWUF4ZnVNaVRtUmtI?=
 =?utf-8?B?dWg2Y2xVb01QOGJUcEY1SzNLOGFJazFZNk9DN1BycGZ3cVZaZkswNU5hM0dV?=
 =?utf-8?B?RitzYWs5cDRkZHp6VHFTdDB0Q3VubGRydHNLQ2s4WnFVbkdJQmhuKzZ5QnIr?=
 =?utf-8?B?VXkyVTAyRDdZLzE3cG40Q3JFMUZuenlqTjQrR2VtOEgzRlZZc0t0V0RLaWQw?=
 =?utf-8?B?cExxanNNNGlIMFhGdWo1V0NkOE9hc3B3QWJWM00xZDBvbDRQbm50RTFOekVC?=
 =?utf-8?Q?WZj1BBUZ10ZvDZCG4wSvO97dY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d157aaf6-9c68-4bdf-8e98-08dd1a26849e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:09.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjhu8a1hR7Svg1/4FA5bk4oqG/BH0RLafNwgODUG3KTn1F+gMG+htGawKRALGEhPfLZu8vzeHNDZ0JacJmsCgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Check the immutability of the MSI address/data pair by calling
irq_domain_is_msi_immutable() when allocating a doorbell.

Prevent the use of MSI controllers that change the address/data pair during
irq_set_affinity(), as the current PCI endpoint implementation does not
support such behavior.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v11 to v12
- use helper function irq_domain_is_msi_immutable().
- remove msi parent check.
- split msi header, its and endpoint to 3 patches.
- rework commit message.

Change from v9 to v11
- new patch
---
 drivers/pci/endpoint/pci-ep-msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index b0a91fde202f3..eda027b734b73 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -107,6 +107,11 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -EINVAL;
 	}
 
+	if (!irq_domain_is_msi_immutable(dom)) {
+		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
+		return -EINVAL;
+	}
+
 	dev_set_msi_domain(dev, dom);
 
 	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);

-- 
2.34.1


