Return-Path: <linux-pci+bounces-9400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23A91BDB1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB041F2304C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6D15356B;
	Fri, 28 Jun 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aYbO6/4C"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E126F307;
	Fri, 28 Jun 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575140; cv=fail; b=R/fHV0Dzy1V3PeJym0XL/2tGQR03DXc1m1R/l9ay1Ds9TRH9WgbpRWvNFE/oet1dO0H9gyunhDHW76qgEBqGGF0tuM4Qmx8v7K+2btFYfCJ6nuYLZAir+rTQwQOTd3KrLBiBQdN5Pj7GxvDc9m9rj7eJv9jJDbb3BzX2j3jhbSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575140; c=relaxed/simple;
	bh=6/bsnCY3nXYKuVIWq5PrGd/WZRrWILkyVJVTqlaqJWw=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=YA8t6BnbQCPa+8Yd7hIH3r0uESFmEOxHLdeJRkTrRXJ2/1Lkh8V6hBmb4y+o6Z4UOhvnzRj0DQW2cgo0IHnzN2q1OaIMS1XVAMX/ZuERS8KzsmYpZPhQiyPZ/Z0tRdHh26uwRc5IJQipcX+EbUXW+NYGMrZ8saOwUAa7TkFJtuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aYbO6/4C; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQQhNm59MESczFbX0Gs2Qrq3lNXW5Qxydj6Eh0C+2DZVVxP3SUyKfEu7ueGnlCeTDFB93/jPyo2Q1JOfwbcacIMgPegMBaCxLQY/JmjP4AxxKd2E+lyUfQBz3Ptf5owi6KH6+i+WqvqjLkCXrYbIjwz0X9iNRD0ptjSVRjO/1gtIZgDO1Sq1ds4KnN7/KS5OzNzXvnsCat1JRuIDrKQYjsCMFyqwQeaG/zEUDtmtr4QKuaeGN8YsBuVwMb86W4X9NnsixzIC26skIj8ltWJoLSOVuK7g8hRVax98QnMa9GigC326GO5iIxHLHFNQwMyEex51fs8v0UusuUMiPEvzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNLOt8SKLbCnXLra5TV1pXRGlAofI4V5vJbsGXmmd4Q=;
 b=JepSJaT53XmWXx6fcV4RFtmrpJNSNqh+7W90EiPWC418M5QkXnKmHZIKXw+NYtABqTuFXMDhUmouR3LU7JezHffbdWh2jPhdtgmTEBQ1DfOj8V9+2iwHes14behZmDsh4FXq621cnBGjxoUoYWwrVwEpnskskqyWMlTrvVdiflUF0N4MVum93x+KrE00jpjpk9kmq86OizJA4z9oUkw7UYryssOy1aeto/7O1cQPf4eLBfvcL+/haIYBTQ8zZY6iw4iRYfjMOeBOtFDaCFGMMTXDr737hu8fn701uPe7X1RaVMWgwossiMHFUgrlJbeqLiYCbmSWuVkQA6HWt5kqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNLOt8SKLbCnXLra5TV1pXRGlAofI4V5vJbsGXmmd4Q=;
 b=aYbO6/4CKUpoy3zy4dZb0iFPh9IFVvy0LcJgJcmdiJq8LlCQBdHh1OAyeYiStPHVqGnVWD8z2qGKgDZTIvvUB9uh+4vBaoSOvLSsZCl5npcgfiYA8hn/OJtiOESXaRI30ZcuzSzFbR7NadYtSkRXqSJhBrSZuQpSwOFpgOJFbNq9g+Yt2+j06DKD9hQsNrE613e2m40c6bGnXwCGurzD5reN49Uvl1f9Ozp0ZvW2TwPLPQL8EirX8vSnEhN6xvvQuwmbepN836EidKBwtc5KG5t4TSOetx2yglLQgBnpgCZruCmJ4wwhuLF+XMkSeteku1LFd/XSKUlFSeLqg6QA3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Fri, 28 Jun
 2024 11:45:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 11:45:33 +0000
Message-ID: <16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com>
Date: Fri, 28 Jun 2024 13:45:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v5] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR
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
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e85067f-7c2e-494b-28cc-08dc9767d15d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStWSVhidnBvQzRFMngrOVg5ODZIazltZ2lmaXoveTQ5SkkwTkFjditud2s3?=
 =?utf-8?B?NHMvT2ZpK2ROd0VTRkxWR2pINDg0aXpxSkZnTnZHWHdZbFNJZ0V6ejJtaUo2?=
 =?utf-8?B?NUhqbFZBZWNPNW9aT29Ka0ZEQ3Z4SWZ4WDB3VFBYUjJKVHVuanpvYituR2E0?=
 =?utf-8?B?QWNLS2hndStGb2o0aHk5NlRycDZ3SGJRM0V2OWFSbU1WL050SEVOaDI2dW9q?=
 =?utf-8?B?emZtQ2RYMUpPQVpycFdYUlpjdHdpRXNnOWZYZ2NGelp1WUpFZXcrMWE2VzBn?=
 =?utf-8?B?WUNSVFNGQXpLSVQzcU1JQllieHpzTklnMUN5d05BUHdQV0RFblc1bUNBeFNh?=
 =?utf-8?B?NzlGVnBwcnp6M0cxdHRoTUV6MnVqL2VMTmRhdTc2Ym9Id3dJWGtWdWsrSGJT?=
 =?utf-8?B?TEE1WkNkdUJJcHp5SG9XT3JiL016eDhscm5yVGtHb0FXWENabTF0WFZoMjla?=
 =?utf-8?B?ZTlIUWV0UnFEMmFUeFhRS3I5ZmxmRGdrdkhlaVVTUDd6WFp2WXNYUVNyWngr?=
 =?utf-8?B?SDV6c3UrdDhXY2wrMEFGNE9Lc0Y0V2RKaCtNdTc0M3JvdW15YWNjK2kxVWtJ?=
 =?utf-8?B?aTdId2ZKNVJ2enBOYitmRkx1UHZ4SzJlaFZCdmFhd2o2VkZibzZMS0ZHQ2Nw?=
 =?utf-8?B?OVhvR0Y5WWNhUEtsTURZeG9iTVNEZGpEUkR1NFBoU3llL0lHNXhrWVhMdG0z?=
 =?utf-8?B?NCtrbVN0b29HcWZNeFhoQ2RkVWk1bTVkUHo0SVpqMUU0ODV3MHczTlF6UFdk?=
 =?utf-8?B?M2h6QXVvVjk5WlJrSGpQeHFORDV0ZGJmTnY5UDd6SHhVdStSUEZrMHp1RWE4?=
 =?utf-8?B?dXNQSkhLVko0ZzRpbWpCdnRaV3pNelRmWlNTVjNhcGE5M0ZnN29yQ0YrNmRy?=
 =?utf-8?B?SklEWFhkM1BMUi91bUEyaTNvQVlsWWgxOUN5SldQZGFqN1MwWXR1bDBwWFlP?=
 =?utf-8?B?aHVWSUdCSGpOUW96YlBBbDdUck84dk5wZXZuclc3cEhBTUVQK2VaQWZEOWRO?=
 =?utf-8?B?d1FvZWkvRllwTDlBTElsem9LZXhtcWJMa0NpZkNBeU1tOVFZcmlOL3hJV0tB?=
 =?utf-8?B?UTBqTU1uOG9hN0IzZE5YdlV0NkZvQkQxbGxFSlpMV0U1bmpLeFlHdEVHdnJz?=
 =?utf-8?B?UG80alU5SktUZTd3QkJBN1Z0TWNXYXdkOE1lSDRML3JBWG1FVXVPeWJBTUtD?=
 =?utf-8?B?a3ppR1FHaVJObFNOSGI4Yk5SUnF6b0plNUJqYkRWNklxRG85cVQrYytUZmNa?=
 =?utf-8?B?OFRsUENybG9wUU1GZTE2M2krQmthSDVTL2w5OU90V0RMd0VDV1czTFhCZXNV?=
 =?utf-8?B?QUlOMHByRjc2blJRYmx2aHI0R0s4Ymdscnd6UG9OUmhQS3NPUmRxNzB1S0hk?=
 =?utf-8?B?Snhpb0l5VWdpY0J4NGltQktVWkVTZzJ6ZTNUdktqOFJkaHhZWFFPRkMyWEJI?=
 =?utf-8?B?R1VmcUMwdUJNVzBOT2NoSGVmb1dMWmROcUg3RUJoeG93NW5CNC9URXVmb0Fh?=
 =?utf-8?B?UWJOZ2hEbGJxd2V5ZVM1TEtyODFJNE8zWDZ3MnUxZWJuSldOdDlZb1BONmpk?=
 =?utf-8?B?MmFpRk84Q0dENC9nbEZtSHJnckd1NjVhT1k2aWNlNWdOa2RQUjZ3Q0hObjVR?=
 =?utf-8?B?ZGhpakRJbitvcHB1K1laWWdUWVJEN2VmQnMreDU1TU1Nam5CUmdaaWRCYURv?=
 =?utf-8?B?R1E2ZlJ4TlgvVUxBRFF2ci9uWTdTbUlyYmw3bTZ5VFR6dlJ4Vm1pellYVWZ1?=
 =?utf-8?Q?sSlqiunC/ijLuzLdrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhjbVdBOXV1dWw5NkpIQUtKN1N4MTJVcUFvdFIvdmcxQ1FnTmQrY3UwQndX?=
 =?utf-8?B?QlNwSElQU0RwUmNqL0lWMGFWSzhUbG5KTFhMK2hnS0VIWmIvbmk2TjFhMWNr?=
 =?utf-8?B?R0FNT2t1RHZiOGEreHFRUDk3MWovZ2UwYVllVW1OMzNBZzJwY3NZcEszbHBR?=
 =?utf-8?B?M3krc1Bvdm5EaTYwcWFJZ0lyczZrcjlnaXZzWFUyVVM1ODBiaGhEemxPOEoz?=
 =?utf-8?B?YVg2aHRjVkdCQWhybzNEZElmZldnbzJvVTYrVUlOc0VlbFlndS9jcEI5NnlZ?=
 =?utf-8?B?QVhpc0cvbkN4dUlnNEZ6b3VXVXFVYzFxSXpJMEtZam9VSVNuS2dnTzhoOU1w?=
 =?utf-8?B?aTQwZ0Y5bnpJV3p3SGcxKzFRK2tCQmROY2YzOTlSM1BGRitqTG5MWldQV3B5?=
 =?utf-8?B?ZmpBQVRia29EU0ZGUFJXRVZRYTczRm9HMmdNVHl6eVdWbzE3SjI0NGNwaG1R?=
 =?utf-8?B?ZmJPMnhPY2NPdlVlQTAycVdXb01lYXBNcHRVdkoxNGhxcU9ZVXNBOHJOT2ZF?=
 =?utf-8?B?WUlLV2g5aCtsU1liSDZQTVh5STR3TExWczJpWjhsUys2UXZoZS8vc1Z1dWJZ?=
 =?utf-8?B?WWgyYWNmaHl0N1VMaEZkMzZQeDVtYXhxUVREWW9USi9zYXJZNmxBWWhMV1lH?=
 =?utf-8?B?UWhlWVFMOUw2clc4QVRjTG0ycHlKYTBVUVVrSlMvSEU0V1hXVkx1UjI5MVRX?=
 =?utf-8?B?ZE5VMWFXdVhrVDZ4RElwd3pwMFZlYi94RVRjSUtrMkI5Mkk4WU56bTVHcmhz?=
 =?utf-8?B?bks2a0NQLzYrUHFqQUUwejB6V2p2Ri9FWWdsNU5FK0RkaDF0bWxRWG9uajVn?=
 =?utf-8?B?QWovc2hkQXpnUGNiVzdlREtNZlR6Q1kxNTcwTXFoRTQ3ckxOSTZSRDZpdVlj?=
 =?utf-8?B?dlV6Qnh6NUE5Zlg2bGlIZmNsakZOaExQc3lrTHRMcFZxZDlzZFpvcnI4d3or?=
 =?utf-8?B?T2ZhMSt3MFpjVU1wQi9KM2FyU2ozbUhRODgxZ3JObzluWC9HZHhOek1COURJ?=
 =?utf-8?B?Y2VOZ3lsWklKVzlNb2NEaTN1aU96SUg3MGNGTEFjWURwcXJCYzRtaXlwbjRL?=
 =?utf-8?B?bUlINnFiY0Y5QnVZeWs5ZnpMWXlEemFraXh2Wlo1Q1ByeEw1WlcwR3gvWWZu?=
 =?utf-8?B?UkhWVHlEQmk4UklFUmsvREkxUzROc091OWVBeWVHZVdVK0RmQ3pGenY2YklI?=
 =?utf-8?B?T3FBQzY2S3k4bmtySHZiYnBlSEJoblZSVG5JbUJLTEJENXp2WUdacHVlU0pM?=
 =?utf-8?B?a1cyUllCWUg2bDdDTGk3b0hjWEdySUd6a3pGMzJaZmFPNUI0cUU4MUNGQTdp?=
 =?utf-8?B?SnA2Vm9iKzJCdzdDRXN0dmpqbmcxMWhPWFlXaVJpRGlYVHRFY0dSSENLZXM4?=
 =?utf-8?B?NCtlam9DMHdNNlpYdjRVQWUvT3pvVExqdzh3YU14NXRMMVNUbGY3ZFl3bkN0?=
 =?utf-8?B?MUNCNDJCZTI0cnVFdkhGc3BqMzRwQklmNk1Hdm1SU3lLVXEwVVNnRWd3OHh1?=
 =?utf-8?B?djh5c1E0OGNxOUs3Q2xXTEdxaXZWYlZVNXpUV2dDSmV4cjRlaTJUQXRQQ2Rp?=
 =?utf-8?B?MER6RDJDK3Vhb3I4Y0phM0V3R0dLSlN5QkljYUxhNm8vNXJWdTRIeS9vc1dZ?=
 =?utf-8?B?a0ZxUXNXdzhlL3cwbUFjbGU4QzRSSWxGc0hCbG9KSEZSRmx4VVRHWmp6eTdh?=
 =?utf-8?B?MUpaMlVqSFRLTzZVSUhIMWdRM3NNQWY5Ly9PblFEcEJkTm9jRkZwNzN6WDdQ?=
 =?utf-8?B?K1Bza045YUFpUitMMXVodWRPb2RhZzM1WFZFc2ErLzNoNktXeXlLNytNNjN3?=
 =?utf-8?B?cVZNUkpYVVgxcUtseHhwTDl5ZHlLWXVPdkpqY0h4QWtDV0hDRS9iSnYrOS9Y?=
 =?utf-8?B?OS9VV3J0WmNMOEFvRHp6TTVhR1F0UFdjY3dEUStabTNhM3p3WTNlZzErdjla?=
 =?utf-8?B?OGJhY0JNcFA4NUdMRUtZbU81NGcxZ2d6eDBkUGMwdE1heGpvNExXeGZtWnFE?=
 =?utf-8?B?QWNrYThZVUt6eEllbHJDaW1aMTNmT0FJMUdVMzNLL2M1OGZ2eER2eUowbVpa?=
 =?utf-8?B?dXFtdXNMUkxxVThnTWV6ay9QR2FtUnFraC9BSHNtemkrL0ttdFQ4bE82Y1Fw?=
 =?utf-8?B?VGZSZVEyekI4UEJMM3lZYUFtY2FrL1hteFdyYnA3dC9oVjQyMnFZOGNEMlQ5?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e85067f-7c2e-494b-28cc-08dc9767d15d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 11:45:33.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSu+YOeezSAQMJD022z84gxlBymlnfuSfNYyRK/KekLM+iZzXhrMu1wsM/3H3Up3vvrPN2ptfxZpisDHXp2NAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5784

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

[1] -> https://www.ti.com/lit/er/sprz452i/sprz452i.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

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

