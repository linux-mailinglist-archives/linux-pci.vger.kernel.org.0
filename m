Return-Path: <linux-pci+bounces-9377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74F91A7F3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D3E28721A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260E194136;
	Thu, 27 Jun 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VIcrstD0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1A13E41F;
	Thu, 27 Jun 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495341; cv=fail; b=inwSRTFzFaljtKgXjI8nCTOsaFfG2xV2qb2A/VJ+dtp/oZ8l759jYgBsuCxa7rswX8G3WDBnMi+FEW6NYgrkKzyttnfn0ZegNQcAkPX7TeWtQH02peVAh0cj3Igrcgs4PiAB0TCUac/n5JN3c+bzQ6a2I7mq4MufjYiaQ8QVl/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495341; c=relaxed/simple;
	bh=FIE/5efCl5f5iTmiIqvxWnTZIuLnF3bQjCS7hepozec=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=ulTZSJOeEiIJMO4i7jS0aojt4XIWdqtUI1kzL5ZaXfPNou5P3kOi4C2WZfvge20ed4mgIa6PJCwS7IpmiYcQKgNrhF/oiXS4rGmUptxzlh6WEMFh3VOrNM62/eWG/k2j6ebKr75VJlRQI3fLGH86kVORB4tcfplqT4qUJFiuxeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VIcrstD0; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVCcP6FAVWyNsz/n/QgxLFOpP+tXJ8kfOwgq+Uz0TEdjTxBTdSchZ7Z/DFgIgaboKahCbqiTyC8nofj+eiuzGM9z4x2Hmfe3EjG4Og06lyBaTsB/LJSFbuJgzHdw+/L9r7Ya8XzBYnj6YpzXzXKW4dcnfUBZcATMdEhrlr1J2bPttRteWLlOga+KaoIzNdT6J4J08tu+GAaUkvk8J5KG56RbSPM38RZO0j5Dg+AqBBHEXIRxwF/80md7zO7f9XbEcW8UL0hrQVPsHDBs2E4KwVnC0cI+XWFEnBJ+fV0BeP74lGoOpZLdXip+GjpevcEsgdiY5nKE2PG9yEz0YCy9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb2dyGmG6423ryYzlJ4aypPVG6IxfNHZxZ73huRcOQo=;
 b=eGs8Lnk2nutYOlCGrn41LJxJOcphrFHMpy252/cv4MrN9sHx4iimjVYsauGHlqhpbdqsB1x202lgucLYxR2Y6ZUqqcpNyZd/TuGsJTP1IDo5Q7EgjKjkGtVXDGYG83mQ+bXettd3unbGskQa3izNF8c3PZi1WY3lXxv2KzduXeZyQUrEJ5MvVpLminNLs5PcPnTGcujuM5/3cdq4B6SrDouaViOiylypicJOoiDVmZOJhWXbYsS/4BngVTWTsdBJxtLlOK3qH2pM77LbOH3LGVWF6xUL62mBBYl1EhP8v0WDekTg7W0ZehSSm5z8JXUxMsrwi037WkCAyySW5VpmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb2dyGmG6423ryYzlJ4aypPVG6IxfNHZxZ73huRcOQo=;
 b=VIcrstD05qyV+vMXG/HZBxXMb46bjqOTVe8SjpxkhA6ArfhHBx7fQC7Krrjb4g5wvNNIw6G/Vyl7micPhf89qq6uLIEUOqfqfWJrYvDVZpqyNir4Ei7Q3d0B99vLKI/6LBEitLEOlPp6FKg3PjCSIcyEP63sqPQ1oQuVNPGHBzVc9rUYj+yTlA3bU0l70vGHFUb6CoH01edE/2NymWXX0+pYpEy68F/mX0/E+W/jF2l2NgzhpmvdU+fmudXK891Evx8M0xGTcJxFYIRsuDfs1NkFWvNFU0P65zxlRGZ2+ok1fStTDtxQJ42YIivvGO8cmOxi8/GuLl0+3M1fcvjKCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:416::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 13:35:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 13:35:33 +0000
Message-ID: <7c5b8986-c69f-4ff5-9ed2-b2055ae848c4@siemens.com>
Date: Thu, 27 Jun 2024 15:35:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR
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
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8511d9b9-efc0-4477-d7fe-08dc96ae050f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVlHL3EwSlQ0ck9PNXM4Q3YyNW5uTS8zQ0pxbGFLVUxtMGhRSFBvRVN4ejUw?=
 =?utf-8?B?cDlnYmloWkdBS3hxaVZ3V0hyYTgxTXd1NGRzSnQ0Z1JFSkxZcDdwdFZhVGV3?=
 =?utf-8?B?Q3dGZjlYRHRQM1RQUjlObStDOXJHbTMwUTJkRk1QS0ZrM1lFZTFKd1Foc3FC?=
 =?utf-8?B?a1N2aC9iS1BqNmVIa0QrMCtEcTIvTkcxbHpVeUxMall2UDJtSVVHVWtzN0Ny?=
 =?utf-8?B?RVZkM2NEQVQzQm5JOU1pSnFKMDlBbkZmRTFpeExtTWF3WEhYeTduTGdpano0?=
 =?utf-8?B?ZkVuVFBHQmdEZ3FsQjR0bkFWN0luU0ZTaXZYY2tDY0djVTNmT1E2L0ZidHpa?=
 =?utf-8?B?REQrY0NSWThCWGFKN2lTTVlabjc0bG1FYlA3UnBpWDhXSHNmMlhyVVlwVjdn?=
 =?utf-8?B?UTRaL2pFZGhOR2RieW1JYW51aUE0THZEU1Bpb0VEU2VOc2w2MjlreFhhc1Jy?=
 =?utf-8?B?RlVESEJvWWdrWm5rR0RuQkxMUkFlc3FSMnlXNnI4VDRDYnRKZmV3QVZHWFpG?=
 =?utf-8?B?OVhhVnR5TjZVQ1lCdThyQjh3c2pvOEZUTUJMaWZDcEdGR3FNdlNmTVlyYlBE?=
 =?utf-8?B?MzUraDFHZ2dJNnZYbGE2M2NkQnZybDgwcVNJREhUMXAxSzFUcVZiVThiWXpR?=
 =?utf-8?B?c3BUaU10ZDhwN0NWMEZ3bmpISU9sK016LzRzWGJacWI3alQrd3htTmMzTGZJ?=
 =?utf-8?B?NFFYeEhNYytTYXlRSjNCQUt2ZXBYU0JGOEhseFY4RkdrbnRqYmRkTURSYUY4?=
 =?utf-8?B?bW82MVkvc24ycTNOMnltWHFnS2hFVERhU3FoanplVDdQanJRb3ZZUzZHeVVI?=
 =?utf-8?B?S28zaHNCVUxnSUlCRmQvNW1sQ0t4dUhCc2gvMzVHZ0IvcGM3bzFYRFhHbWFl?=
 =?utf-8?B?akNvT2JmT09jbkh6elJQWExoazQ1d1VvWS9WNW1McUs2WUQ3dXAvTXlBRDhR?=
 =?utf-8?B?anBvME1Id1hiUWpGTjdsSGZ6L093RStIdXVmWUVmT2tOdWtXVE1POHdzZ3NE?=
 =?utf-8?B?b2NIZlVyMURKL095bzhzR2syN1lCQkovbm9xMXB3YlE1amVzVFc2TGI1VG93?=
 =?utf-8?B?MzQ2V3FaZC9uTkN6a0tQbXVLRVM5S21SNTUxWk5tTEhBd1dwSHg0MjB4NFcz?=
 =?utf-8?B?WjlmdmxXR3BhV2pWd1hCb2g4QTM2WnR5c3p1MzMvVVUrVEFBT21wajB2QWVr?=
 =?utf-8?B?WHVSWElJSVE4TXlLejB3OHp4WTBpeG9MbWhwUy9mRGdtTDZZc2hKbmVKQ0tw?=
 =?utf-8?B?M1cvbGJBOWNva2NOL3NEWDBKTWhOdHJlcWp5RVEveE0vR3JKUmQyZGtCT1ZU?=
 =?utf-8?B?cUZ3TWh1SE5HSGF2bHNXOE1VeHJVVzRqcTV3WmJ5cFVaUDBIWnpGVTA2TnAv?=
 =?utf-8?B?QWQ0aXdEa2RjVzlaUCt3UkFHVkkxR05NRjRSMnh3Y2hXVjIxcGtiYUd0aG94?=
 =?utf-8?B?dkgvbHpQZGRKZE15Y1piTjh2QTlxZ001SjZMZWtRVFUxQVVWWURvQmtjbUow?=
 =?utf-8?B?OWdBOVNKR0V4SmNZd0J2bDF2N29RM3dBekRYSG5TTUQxMUxTUDNSeGlOV09N?=
 =?utf-8?B?UURnWFZxTUw4T0JvYUExSUIwbEFEVXpHSlVycDhVM3gwbFBJZ2xDNGk0b014?=
 =?utf-8?B?RGIzUmUvZ0FuNEVZOUZFRXpGcDZ4b0dnOGZvMkhJWXoyZXFPanNDNFNRa1ll?=
 =?utf-8?B?OW5JREVxU2NVemdDNHVjU2xQOU5pT2Nua3JoSE1DcGhReDRaSEZzMDg2SmlY?=
 =?utf-8?Q?dwxDDZRYwlOGjPGYvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S25MNzZIQUFvckFEa2FXNWJmT2s1TnhvNEdFNklQTkxGVUNhKzlEUGExNzVs?=
 =?utf-8?B?UzJvQnZsWVMyUkU2dm5rMDYyTEFVRFJ2NDJBRFV0V3JPb2FxSjBMSTVoUEF1?=
 =?utf-8?B?YUttNnBwN3QvL1RIOWlMNEYyYWczanMvVmFSYWQzUDRNT3JBaXU2ZGk4Y2tk?=
 =?utf-8?B?NEh3NElqR3hIQ3VsVHh5dENiT3VJMUpIVDE2Y2pKRDBOU3Fxbms2ajlnRlgv?=
 =?utf-8?B?RGJEZUVCb1EyYzk3UDdUSHJTcjdPNHpVRkJpeGtBR3ZUVmdqakd1V3VqZ3Aw?=
 =?utf-8?B?WlpGeXpLRnU1cElOOXd5V2lFUS8ySkc0bDBaSzltU3d2ZjVIM29xSXFFMWh0?=
 =?utf-8?B?VVk5UDZ6RGdjVlRBWmczakdiWm5yK2hmTWtjNll2eHhzbGJ2ZGNIYVV6NEJ4?=
 =?utf-8?B?TFpVKzVQYzYxOXJheFByWEZoRzFJUWtDZ0xmZnZNUnk1WXBZUUorRklodUpD?=
 =?utf-8?B?U2h0N2psRnllN21ZZ3Z1UTNPNTBBVjJDUkpqRndBSW1ucVhPZHZFVnhSNm02?=
 =?utf-8?B?RFpnd2d4emg3OERFOHhiQ2RZc1dxRGljUkduYUV4UUhXLzhJaHZOOWtzcVpz?=
 =?utf-8?B?dzJydnpsZkFNUFZ3aS9jb1lES052d0JvVjNzd1NkbEgxNHIzdnQrKzNPQ1lV?=
 =?utf-8?B?UWRVOTk5NzlZZ1RhaTIyb2ZsNlpDamlmQTBiSVhNLzRIYWVNWGhzaWVrNFFo?=
 =?utf-8?B?YkhQaVlOMVdsRUthZFFhdDVISkRjajJlc2ZiejVKWk9IRjY3ZVlDaEI1eXZ6?=
 =?utf-8?B?cmI1NHArZmVOMEVvSkRSWDF4dStqOURpVjdhQ0FWVW9ydHdXMVc2Vlhzbkpm?=
 =?utf-8?B?bjBMdWU1eFdDZE1HUktjL2dPOWYrQUJ2MktsQnZMZXdkQThpV2k5dzhFa3Ev?=
 =?utf-8?B?QlIzMzV2TnNIbGVIZWNYdGlUOUtpVEs0Y3hRM2ZSOFBldWY3MUxCQitzdUVp?=
 =?utf-8?B?YjRXT2x2NzNkckFEYy9IdEtONEY1UEV2aUYxdEcrYS9UWXBqOVBVYkFaWGtB?=
 =?utf-8?B?RXZpYmxRUm5YTFp3QkZTaEJHbERCNHJTUThTcHdXeTdRRmp0bjROelVoOW1G?=
 =?utf-8?B?VFFxcmxsTVNJeXF0U0grVWRtSkRYNmRrZjF3bWprL002TTVsenFxVEhCRS9h?=
 =?utf-8?B?TmZzdC8xWHNuSmdqRklJb29Fbi9GSU1yUTN6WWRxRFRmQXQ1dnZqb3ZTdThi?=
 =?utf-8?B?dG05UmRFYnkxTGdvS2g0UjFscTloS24xZG9kQUJQUUVGWGNwNHRYZStpSXRR?=
 =?utf-8?B?Q2wzRmlxQk5SanJGYUU2RUxHZUJoQWFHb29pU25TR09XZERBSUg3bHNidS9q?=
 =?utf-8?B?MDhVUzI3RVRtSmttTE9qRGVvczFvaWdERitUMlpXSkQ4TG5KUXZEVjJ0ams0?=
 =?utf-8?B?aDlpbGhpampRNGNvYWZISmRwck5iRE5jY2J3ZnA4ZitTNkZNQmtpK3JJUDR4?=
 =?utf-8?B?R0hvK2lmZ0dvRWtmTHdrZURyN1hNUVZrdmVsKzhQcVp1QVhVMFZsUmhOeXZm?=
 =?utf-8?B?K1hOeldzZUlSTU54N3lkTHQvUzk2aWJMbXkxL2NxMVBlOTlZdGpWY05KMFFE?=
 =?utf-8?B?Z0RuZlp0NHFaWHM0SE1KLzhoZ1ZnZ3JQQUtlRU1pQUhnNFgycU1WQnhKTW1i?=
 =?utf-8?B?b0JUZmN0RkRkSWVlUDlIOFgxY0pKMFRSZHkwc0xlOVVGUytVTXdjcExHdWY4?=
 =?utf-8?B?MXU2UmxNVm01YmRKMzdjZHY4K2U5NW9xbS85TnJRcFlKL0h3TDJ3M2wwVUdk?=
 =?utf-8?B?OW84ZjM2MzVnS3VsbWtDQ1dpUWdNdWNDT2NXWTltMkpLcUkxeW9vUkw3Y1JO?=
 =?utf-8?B?OStaS3JaZGYwZFZMSlpCZW40YW9mVlFialhCWi9pSUpXSHlzT1BMcVJLMVZj?=
 =?utf-8?B?OWtBS2JWZXdPZ2JvM1pEMHhvL0pKUThFRm9vRHYrMEtYZTlPaFloU3hzd2s1?=
 =?utf-8?B?d0s1b3YzUnBVRFlXWExrcjQrbEMyczhUeUFBb1ZsVDAxY1NNamwxRDZ1TklP?=
 =?utf-8?B?amJpZFMwMjZ6OTVWVTdmVzNnRGkzNGZ2WWdrVW0vOS8ybHQ4dWlIYUtPMHdn?=
 =?utf-8?B?U3c4bnRxYnk5aWhpRXFZclF4S2phT1k4RkFjL3llUVYyQjdXeHl1RGdjNHpl?=
 =?utf-8?B?dlVEcG5kelFmOVJ5MXRxVXU5TWIxOUVQQlZJdHg2bzVUc2hGNWY0N1R1RFlL?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8511d9b9-efc0-4477-d7fe-08dc96ae050f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 13:35:33.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dExQ12hOPYx8DyFKHhjEbLZJSWBWW3M3ZQLFGeEG3qErgMo+IMNFXrWzsYINh4+alHhiichI1TsTo/Yboc9UIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8479

From: Kishon Vijay Abraham I <kishon@ti.com>

Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
the bus may corrupt the packet payload and the corrupt data may
cause associated applications or the processor to hang.

The workaround for Errata #i2037 is to limit the maximum read
request size and maximum payload size to 128 Bytes. Add workaround
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
index d3a7d14ee685..df9df2dc1f8a 100644
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
+	 * when MRRS is set to more than 128 Bytes. Force the MRRS to
+	 * 128 Bytes in all downstream devices.
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

