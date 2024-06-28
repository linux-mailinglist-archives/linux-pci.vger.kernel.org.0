Return-Path: <linux-pci+bounces-9396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED42891B6CD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 08:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE2B22576
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D15481A4;
	Fri, 28 Jun 2024 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TFEWAwEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E74B5A6;
	Fri, 28 Jun 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555291; cv=fail; b=U4hXgXEjDmBoN7xY231pB8hmvecEIFv8kPULAVvNTYH7s9BQg1PrVe9l9Kv0pdXnzlpAxhGsGK8435Uf39VCSL2p88z4WQs7H6DXBIj8IBieDlnLX+5PtaevPTMR815Qi/cOKPCgPu2xHY2lr/vttgeaWKbISasVoLIyUI4O6A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555291; c=relaxed/simple;
	bh=pIVOQywRePCwp5OVTQTZ9oTJDVBOiMoRIPSAnIFl6yY=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=JAlP7B7Q5mz4koYFdLYrvSNf+15VRjGSejfopKypkg/cNGbcTiUZNJNRqKawNFdB/2YQVSZZL8a+RPhcz332LSBnOVsngcRbaOqeVs2SQ14GSqusc+FSWO4/e3lcckHN+kskUHTMMDn+UzKKItnHxeS82xnno6fFDXgRsOpxWh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TFEWAwEj; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtGm8oCygXbD/fQho5q33k14GuQXog6EYGOLX6iqXgJU89mZglVi9mZoz90ISIPMngOcWQdJxC+zqgyG0fvEQgzPBe/Wnkv41RA1FF8NfKqLcFR7lxp0uHuZnxK16O3CTUDrnBGuymYgdlWf2EEZN8/YB4ZMmE/Wg1wAHMoMmxMq5OJQVSz1+cq95sTncfDFxyrhTH+GXO6JMGE0L/VVVcAtRdoG1yi2yQvbs2hyv1XyXLnbnrndzKxD6mS9KYaFbiXz8aidjtto09hDueEPn8dXnzylSUYqg1PRjmEXemOQ0jviKsrDh5Y6wdSafBnHc1ukrVbE/yAUAhf5gQU0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xAdhNKGcNcEClqGqC+B46/4J1Jr+3smspQnCCh/ZdM=;
 b=fmo4y59xE5WBTDbxszil5NnOI8PP1/82SIswY0u7ef7fBSOj/mWOxPWVjK82drJNOJK6MkqkDFG2Zc4vqjUpTR9mE8KITOOnGshGO1ohqPeXJZDbqSYmu0xM3YzHJsbCouBcdVFF4+nbNwMn4RBvrDIPT8etfTkWZmI/VowCFXfNA1IxEzE+/LzpTnlKw8m2TAfVGSrybmYh6/LSg1EoRIhhSuyvkViU0QXHCvhyroPN2yE9tqTjSG07VyvMqyZcZQg54mZwxqwHnwgWGNenaBvW4NWuKqjfad5q5wrL44jSTwQ9pM52dgcBOVuO1mFmAeNDaiItW6J70jpFuPAA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xAdhNKGcNcEClqGqC+B46/4J1Jr+3smspQnCCh/ZdM=;
 b=TFEWAwEjfvoyr+iFZ4JrjcAafuIRJg63lVRbr8uyPVxRElJeSMd8gDqdCsfDePWx8lTKQog2OzKRtNF94ksqEMtCrQANSMwlvUd+YY5+7zuSZ2pO0aE4ipr4uUh+FZBf2fTw2I7NtbOOypwZe+o6v2DxntIMOPvz70h2vF32DzOs9UcanKzsad1xeL3lYs8QQ8y79dfOjYQGoCPLRWJUi4PrrDO0W/ap45wKr9vHTeFQYMU5WUcxeJvc/0pWAC5KcLG27kmiuE4ivauzTHm9Af7fM1riHjOkh4fvrhYFywPRwTdhvEWt2pFT+H7XPpB4m/QezBwaxSFW92ZsQkQndg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 06:14:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 06:14:44 +0000
Message-ID: <e8aee86f-4f4e-47f7-a472-58a7c154ab06@siemens.com>
Date: Fri, 28 Jun 2024 08:14:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v4] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR
 1.0)
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b0cc00-4dc1-4e0f-946a-08dc97399a68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG8zN2F2RmN2bTltcklhWnM2ME5PekpVTC9QVEhkU09QYmgzNmFvaFluc3gz?=
 =?utf-8?B?Yis0Y2Jnbk9BR1JaNk5sUG1MV2RlakJ1ekxNaUZFMWJhTU4yZHoxQ0d3NDVS?=
 =?utf-8?B?WFR2cmp2WjVHd245MDQ3a2JxS3pMWk1iR04wL3FaNkdqamczbElKY2tpNXdu?=
 =?utf-8?B?Unowc211aFlTL281Q3Y5T05zbzNsZG5UT2NIU0ZSUHpLWHo4bmp1RG5NeU1y?=
 =?utf-8?B?M1FlcjFqc0QxYk5YdG85L1R3SzNkbzIxTTNyTytCWitHbVAwSDBLcXZGTVpj?=
 =?utf-8?B?RHVmdUtuVlR4a0xsanh0Z1RSV3pHU0FPdFRLZUF5d2R5dU9FMHMzTSsvb1Vh?=
 =?utf-8?B?TEZYM2hXOVYrbWJxRXZnNWFEeWVsVDNrWGd2Z2VGVzlrTGIveGkxOHlHRGRY?=
 =?utf-8?B?eFptY3dURDNaUXg2ejJHY2ZSK2hiV2xTWXNPM3l3T0dYRzFnc0ZTK0VCbEZL?=
 =?utf-8?B?MWNxR3pIa3JtWkpBalZ5akc4SDRZWWg0aHJvTVhHb0E0czlmMjAxc2RhcHhr?=
 =?utf-8?B?S2dxc3I3QXNYdkY0T1hXTmJmVmRraWZwU3hxVnJBVHhZRVNPK09TM2JDNFVk?=
 =?utf-8?B?bEwzMHhoZ29Pb2UrN20vMG5FdEFNdWx6bUpKRVduZGt2ejNvNEs0VWRMQ3Fi?=
 =?utf-8?B?QVFLVDcyQW1LcHZhc3Zwa2NMTnZFdjdrcGFvTUc5UkxPUHd4a29FaUczcXRl?=
 =?utf-8?B?dHh4SlNIbHRGVkJFamRGL2RNSm9sai9SUkoyRFVkUUhiOHcyaFpMYnBUUXF0?=
 =?utf-8?B?eXYycVFMQjd2YWY0Q3kzWGk4bUNtZHhxaWhTSG1Ld01xR2FQbFo3TmpGTG1O?=
 =?utf-8?B?RTQxMU9ZYjE2bnlzMEQ5NGowbHpRTFpha1VoZi9hYUZlYUduMm5LMFRHUlFY?=
 =?utf-8?B?WVRzaGZNWFhFcnlLd09Qbjc1ZC9yZzA0UFRiOUFRcFF3SndEYXZ5MVpnU25z?=
 =?utf-8?B?cTREQTBHajRvMmJmNjlyZ2poNENzaVkvYm8yUDBJekd3N2hTdnN3VXNjYWNw?=
 =?utf-8?B?RFJYcEl4M1Izam1aSERqNXVlUjhwUElTSnVSeUw3VmJUdWFFSFlrRVExaWR3?=
 =?utf-8?B?VENmd2lwdkV0UTY0bUczWkVMcmlqRFNQRXVPYUVLR3RSdk9JU2Q4N2FiL3VD?=
 =?utf-8?B?WnUrZThPMWF0ckFET1pXdGVPOWh1d01nWSthYXRNS0RIQ1E1WkRUQ1diN3ZB?=
 =?utf-8?B?eDEzdHNyUFNITzhOV21vN0R5WjdDZWpvdERqSXo2dmlaNU5QMURiT2FOdjlG?=
 =?utf-8?B?VVZUNUYxL0hYQTY4elgyLzFhR0VZYnFta1ZubnBFK1lKaHNOYWphREk0cEE5?=
 =?utf-8?B?b25jdUxSWVhpdzdpVGhtNkd2U3JWZ1hsUnVZYnBibkh2eGxsNkNEeW56WFk2?=
 =?utf-8?B?QTBqYWtJemFidXU3d3RrS0t3a1NCVklOUVNTa29yOUJLY3NobkZPdGZzOEtw?=
 =?utf-8?B?KzJyV1ArZ0J6ejNvRHRpcTJyUG82ZmsxL21LaHoyTEtJcThNSlh4N24xNnU0?=
 =?utf-8?B?RDR2M29HeEE5RVpiRkxwOEhXcnQ5NG5UNlNzbUVHdVRudTd3NkoyQkt3YzZk?=
 =?utf-8?B?dWVERUtEdlc0N3dJUE1TRHhCVTdmOWNIOG5Ka3pDemZOa2UyZkk5UXRhQWQv?=
 =?utf-8?B?QitzR0VpUmFiNEtIV0p3VCtxQ0dCbzBuYy8wQmFob3hVR1E5TkFUamVwVkZs?=
 =?utf-8?B?eVNJVUthTUhKOXpjVVFzTGYrQUo1VlBWM1k5ZnNRYTBscmpCZ0ZoWVRKUm9U?=
 =?utf-8?Q?ZIUq/0vclLCx2udJFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFh4MXJ4Nk5ZMXlTTndxaVlJK3hwZDluK2UzZ096TDFPYThsdStYKzYyaUQ5?=
 =?utf-8?B?T1VMblBiWUgrQmRSNVppQ2plTTB5TzNxMUFkNDE0WGJvemM1TXFMOGJ1dEc1?=
 =?utf-8?B?WnkrWlZzajdpUDdYS21QTGV0M2RCbERrVVdwQlVLbVFLOUx0WStHcFgvc3NN?=
 =?utf-8?B?OWp1YkZGYWc3ak5KU3FUeVpLWnZYSndiMGdoY3V0YmlRT2k0S3YwbkpYNklQ?=
 =?utf-8?B?VDVnelZVeFdvVW81TFZCL3pGZy9QSDNlOGUrVFowZEVHTzFyZnhyam14b0RG?=
 =?utf-8?B?REsvRmc0ZGtneWlUNFI5VURCbFhkOFNJSmlrVXNKTDdTNFF2QXRhbFpnNVYz?=
 =?utf-8?B?UjFTM0lwTDh5cGdkYzUrZ1h4WFRQVjd4dHZFMUdJK2MxSUVneTMyNmtpUjRn?=
 =?utf-8?B?WUpZR0Z0ZllUWTY1bE00T1VkSnovcGNmL2NkaWhkMEJVVEpPM002c1h5aEN1?=
 =?utf-8?B?RG5XUjVGVmFjMnBLeEhuVXBhcVJpZlYrVExWdUtFNlJHa0F1OWNlaCtZbmdv?=
 =?utf-8?B?Z2tYb3Y5WmV5a2RUbFIwa3lJR3Ntb0s5VjZWRHU3cCtoWkYxaEQ2UlZLNW9F?=
 =?utf-8?B?RWUxTkFXeXc1QlhHeGxQcE1wYlgwcGdWd1RMa2J6aTQrbW9lMmwwU1I3dktC?=
 =?utf-8?B?UlBySXVodlJ0WlRqVWllemIzazBSKytGNEdZQjBRL3JOY2VtL1ZhbjBUclJ4?=
 =?utf-8?B?eFh4NitlWFVjOHh1bWNHNGxoMzlqT2dGOHREbHRCVldzNjlVeUNoZFZxZit4?=
 =?utf-8?B?Ly9HS0l5VjZxK1Z6WXFncGtycFRhMm5tMWtmdmRtMlgzYWRicGtGMTVoenQ3?=
 =?utf-8?B?RUE4SUhXdHgyb0xOdElCeVY2dFVmRGhDbmtmZlFCSW5OdFVPb3YrdEpnYWFM?=
 =?utf-8?B?QlNSS1JWTzBIaVJwZ2htMkxxK0JHOVdVV25MbmhGdGRESTlGdkpUZkpwc0o0?=
 =?utf-8?B?TUtZN3JCdDk1Yi9QSTlkem5KcXJCYjRVZEJpdnVWeWRlbEVXclhNRVRnS254?=
 =?utf-8?B?SmptWnVRcnhycHEvS25EOXZyMk84RzJqSW9RelNHa3pyWHVncGx5dWZWV1dD?=
 =?utf-8?B?RmhSSWprU2pWSUR6bDFSOERNL2tsL3FFSDJrK0VqcVRJSVhmUk9PRHlpa2lD?=
 =?utf-8?B?dGZab2Uzd0xzalVnNno2MFFKOEpHWDBHeklWai8yeE1jMXdjVTgxRHA3SEZO?=
 =?utf-8?B?MDdDTEFseGF2ZjFwM3pWbW5UaUl6cE4ycDlqTkhZYVFDQW5RcW5mdlZteHJu?=
 =?utf-8?B?TU04a3JkcDZTMEM3WGlJaGVvT0M4MjhwYWhCYUFKb1lSSC9uM0VPYzBmSE9r?=
 =?utf-8?B?OUpwTjdTRmVpUTNzYkY3SExjOFJKNkVDaUhZQmtDc20xNGIzc3A1a1hvUGhQ?=
 =?utf-8?B?N1JJWkE4aVRXVzdralhHR2tJM1pOT3YzckgveFNNc3FocVI2VEU4b2tZT2lL?=
 =?utf-8?B?NTVjZVNXc1BmRU8rTGxOK1BaODNKNFhLRUptYkhsRGtORmUxZmkrNDdITE1t?=
 =?utf-8?B?TXlDMUZmVDBJT3lOVjdueGg4Vkljd090Tm9IRjZZVTZuMldBY2pkcVlZd1RD?=
 =?utf-8?B?YzZqbnA1YlZVWmFHRGFoeGdNSWlwTnU3U1A4Tng5YWwrM0VtWWlaTlFyMXBN?=
 =?utf-8?B?bUhpVTNCT0ZZNTU4dngzYXNZMXdlUjZRckMreE02N1RZRGc3ZDBMN2lkZXJC?=
 =?utf-8?B?M1Z0QzZIQ0ROdlI5NUEvKy8xUERWV3JmR0VVd1pGbnZqSUQ5UjQ4SG1US0V3?=
 =?utf-8?B?MEk3bHZDWEV2OEtoVTVwQ0RPTEw0anZQYWV1WHdrVXZqYVNNMUIwU3FuQ0Fh?=
 =?utf-8?B?WWZOenVjMWs5dXFBK0t4Yml4V1ROQjNLaElwQko5NzM2VXNGUEM1RXowTXJU?=
 =?utf-8?B?RThMUFhYeUg2ektUUmUyR0dNZ0NDQThsYVhTM1RJUytnMWJtcElURndIdWVn?=
 =?utf-8?B?OVEyajhSWWtHOHpoT2Y1SU5hcHVhRk92Z25QdkpPSmtGK0MvdTVhdHBRbXRX?=
 =?utf-8?B?Y2crNm9mSDdGbUNBbXJiVGlPR3MzZGU2MW5zNU8xMis5a3BVYm16L2Q0aWtk?=
 =?utf-8?B?WVBMRXlQM3lkdjRXZjB4c2V2OTArdzJ4ZHFPOGFpZ0lJbVluNm16RlpRWmJ6?=
 =?utf-8?Q?/uVbUdqsSUBinI4n0OgPzCNO+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0cc00-4dc1-4e0f-946a-08dc97399a68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 06:14:43.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hIi/G+iYj/3ovbv320jT+v0yxUbhFmobRjHFLZV40FyiSBtJwqrnlrdy5kDoGT5IGmNt7Tx25yggfDN97x3pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7499

From: Kishon Vijay Abraham I <kishon@ti.com>

Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
the bus may corrupt the packet payload and the corrupt data may
cause associated applications or the processor to hang.

The workaround for Errata #i2037 is to limit the maximum read
request size and maximum payload size to 128 bytes. Add workaround
for Errata #i2037 here. The errata and workaround is applicable
only to AM65x SR 1.0 and later versions of the silicon will have
this fixed.

[1] -> http://www.ti.com/lit/er/sprz452d/sprz452d.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---

Original patch:
Link: https://lore.kernel.org/linux-pci/20210325090026.8843-7-kishon@ti.com/
---
 drivers/pci/controller/dwc/pci-keystone.c | 44 ++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d3a7d14ee685..25e365c0c5c7 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -34,6 +34,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -104,6 +109,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -525,7 +532,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
@@ -537,6 +548,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -558,10 +574,36 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(rc_pci_devids, bridge)) {
 		if (pcie_get_readrq(dev) > 256) {
-			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			dev_info(&dev->dev, "limiting MRRS to 256 bytes\n");
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 bytes. Force the MRRS to
+	 * 128 bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.43.0

