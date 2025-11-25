Return-Path: <linux-pci+bounces-42043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DE4C85584
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A7194E1405
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78132470A;
	Tue, 25 Nov 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sm8PdR+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B4A95E;
	Tue, 25 Nov 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080101; cv=fail; b=Id3dJ1KURlGAiwJpcXq1ImUEQSXFpSIIRprD0g9R8GKh1WCrot3rUstSXaj1av/jP9COBpHEzn1wbKjPmkdphJb9sxBIGnO8grpWl0t00Q20Cm6aFZFoorrFJIFTHPk549QV9CFzG3kB4od51Ze6pTfRt3mObb++K9GHKs/SRUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080101; c=relaxed/simple;
	bh=DrzVjqM0dmZGe2F0Yr4Eb4GLdp6KkGjwYEPIw/g36cs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Uv2B62XIpkyyrVoihq/BrjWeaxCzTdNKjFcve9cQquUtAq2V/x5eIPHuVkDy+Kv4FQim7MINvO1LEzy8/yNE/bj0GnL7zkA7eyewrR4+zohJEkRG7BWXd75OGFVKYtDjyIJypH5WxEo0BUxih09i9eRmYghUjplMcEOOZh4aU+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sm8PdR+a; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrSTRUghgYI/HbmW6ONnyl2ovpDik0t2Jbd6pAGka8fcJy9qI6ys72I+5WyQUqiosd6HWPuamiQ3QscESs38kWiQVZsfkWHiJT2we4lxPZy/dI4BqXyipxoHdGVWVIdS3w9FWunfn+8I5g1j4QDI58Qv8FVHhRzad3c7xCjXtj6yIW3MDxCX65Xv4Ddmzin3LZZWxXeKHTrqc5JBe4VUfl4GXXyS7UWkZ1CbZzX1WwkMdtXScVGr5FaVx9wJzQX4uZSgpxVR4BKrATSr0uiS0BJlD65hk8nzrDUDNcVbd8hGmmty96XpLB1t7CxIk3jXzXQd7uJcEYk+D0OuEkDioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmUYRt2TnruIBdoL8TgD6/0rFotf7PKFg27bNNkrS44=;
 b=IrdaR+OiHTN1devKbDNAQYMDOwAcUwMjIEzv1Zc3qr8b1h3TEl5krkmqkpOnF/3niOalltLzw5rfQqfogUfPuqzuzO9b40EuL24G9i7WMhDmdq5uXMh2PBuvvqPsDZJZ2I2oMl4QF1qNYp4H5Rg97J6PvDLP+8I45SqlWA6q4Lpyr/4yQK0cT91wqS5zqXPDL0yI478BbYkrY6fQa5K98AMYGR8s3J5WJN124A0YrVtfvsxR8GIwaU4Y9Xm0/t3PV3KndXe4cM1SsCCwONLjtqOby1lVJCZAYWVtQz+gqk5AAbxV2xtw0oKn43zo5JSjtHll11jAl5YmKvYqHshzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmUYRt2TnruIBdoL8TgD6/0rFotf7PKFg27bNNkrS44=;
 b=sm8PdR+aCg1Uyu5orkdED1robaVNJSrFsmRPN0kTb3L2XUuMdBNWvxOoJlPZiDM0iMjIIKubjhUGiCOoMRWgBfAhJK7CStOYtJWZsDS1a72srXB46ermo6VvkALyW9jm43oJaPI0r94HuvGJLNXnhPmutRGRSUNTs/7ZRc03ZU0uHhagU7igGTZfr17c7jMWexQFgPRoB/cJgzo+bReu0gMvgXfVvUxUq53ityDF9BKRpoOFAwXYH9f7hYblghbHLju4bPTVi1DR80ZM+ezuUCVEODR6ZwwsyggPRIhgixHZcOqwXh9+71LC0T2Fp9TL/aEOL9dXHAZzYDaC5hOA+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:14:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 14:14:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 23:14:51 +0900
Message-Id: <DEHU7A4DWOSX.PZ4CCKLAH9QV@nvidia.com>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com>
 <DEHU2XNZ50HW.281CCT1CZ79CF@nvidia.com>
In-Reply-To: <DEHU2XNZ50HW.281CCT1CZ79CF@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:604:1c5::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7f6f01-3171-4a1b-facd-08de2c2d0202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vlp3YjJ3RC85U1Bpc0hBdHRRaUZlbUtPYmpiaGxVeHVDZVQvdXk5dWhvZFBE?=
 =?utf-8?B?QXozSU9DbytKWTdOMHNoZ0MzcGxjWFJHeG9yVmYxZytza3VEQ09GbHV4RWcr?=
 =?utf-8?B?QWFiSXlVcE9LYkd6T3JBNStOZmp2RmxwTnZNUGRiVXhsU3VocWF6a1hmL0xh?=
 =?utf-8?B?Vm5uVzQ3WGI3MnlSS2xmSW5jSVRXV1JSQWtNOTExbWRPK3dtWnoyZXVidHBq?=
 =?utf-8?B?R2dkbXZhNWlDUithMUx3MFI3b21GaVlzTnQwTmk3VUlBc2o1NHlUWlNyYXZm?=
 =?utf-8?B?ak1jWlZCblltb1VWNDRjSXZzODVNaWtadTJRQk5LbzROT3NNVFVhaE11Z0xw?=
 =?utf-8?B?SGRWSS9EdWlzd21KWWtrUFY0blYwd2VuV3FyZjBPL1hUUWpCSkp1NmdKWGNT?=
 =?utf-8?B?a0o2WlVFSHJSSUFPM0xXTGQyWlBUY2JKa05OQWdpcVNKZG0zbEc1S1ZKWkZM?=
 =?utf-8?B?UWtCNVBERUJSV0xycHRkRmMrclJFY1JmeDJyRG81RUJJS2FuMmxnM2QvOXBu?=
 =?utf-8?B?N0VyeDJnMzViK2NOeW5yV2pIZFQ0UDc0bXkyWTdVZjdVWE4xTHpDQVUzQzlF?=
 =?utf-8?B?eEZ4Z3NteHFadmtOWGUxLy9DK2xhTmxScnFqYWFFV3EycTQ0YUVtVmZnNHIw?=
 =?utf-8?B?bmc3amNZdU8rSHZGM2JFZXNMTC95YmlyR1ExUnkyZnFUTkE1Mlg4TVBkU3RG?=
 =?utf-8?B?ZlVtZURRaVFGUUhaclFUZElPVXUzejRkb3B6Y2ppWFRnb09MTDdPeXBXNzA0?=
 =?utf-8?B?eHJ6bi9Obk1NZUFqYXZVTFlwc1lJYTZTdEx6YW9NWUtSU0FNY253VjkwR0NX?=
 =?utf-8?B?VHJ0ZWdxU3A2Tnp3YWwxUW9ZbzY4SFJNV2p4c1lSSi9Hell3ODVrOFljc0cx?=
 =?utf-8?B?cjhmNjg5N0hZZ2E3eG5lWVc4SW9RWlF3U01FekVsNFpYUHJZMzlSbTlKc3dE?=
 =?utf-8?B?R0JHeHBxUHlUTUxHSXltcHlQTGNEN3FtK1hXVjg0c3Q3MEM4M2dYeUN3cHds?=
 =?utf-8?B?aWpqaGpnWG1xeDcvK1ZZSWI5d2RJMTNNZ3Z1QUhYTm5DR09YTUk3MFYvYjd0?=
 =?utf-8?B?a1oxZjFEb0pQYlUvM203dFBGeTBVbEduSUhwdmFXalJBSm9DWEcrTUFuOUt2?=
 =?utf-8?B?YVR5TnBNZE5jbUQyYU5KbGxLNDVyUkdkdUprOEovdGN5NVo4QWpCWG5kckdF?=
 =?utf-8?B?YnBka0txaTdtTVhHSlpvdUMyc2laQWNQWHNoeWJqQ3BqakttdmUwb1JDdmRY?=
 =?utf-8?B?OEZDY3hJOENISXY2ZTluVVFUeENaUmpvb1NKL0ZLUEw5T2RWTFFjMlFWeU5m?=
 =?utf-8?B?TngzNlhQektmTFcyYzJSZEhsRDhUSmxYV2Nrc3RWU3BqRDl5UXhaWVNuQURn?=
 =?utf-8?B?c1JCalJabHdEcS85VHovQzhkeFBrRVZvelIza28zZmZ1WVdsdm9pQllqVHor?=
 =?utf-8?B?bFpieUpqUyttTXBtOTNmWDdwMXhBMDlCdUJCMUFVN0RSSWJ2U3NkeEtZV1Q5?=
 =?utf-8?B?VFdwRGRzaEZ2N2hDWG9vYlErc0ozTmt0UWR0WWcrMWNoc2dIZXVJdExxaUlC?=
 =?utf-8?B?VG9XejdzTjBWcldLdDZ4cXdCUnZHaktxL2VzL1Arc3VvS2QxMUJMejFIUGh0?=
 =?utf-8?B?a2xwOXAzNlZyOEgrejQwcmNVVzA0NEI4alpEdmRicm1nZ3dRQStESC9nWXZz?=
 =?utf-8?B?WkNoWmwzUnYrRjg3bi85djFxN2tEVkJ2S05GQlk4VzNHbGZmSy94VUNjb3dE?=
 =?utf-8?B?YnQ0SWZGaWgzSXpRdFF5OUd5OFgvRjE3cXNVN2dRQmpYeUQ1T1diS2xXSmpN?=
 =?utf-8?B?WEcwVy9PdDBLZ1FTaEJGSTBneGtDMEtSRnU2RitiV3RtSXlEQnlDbnJ4aXd5?=
 =?utf-8?B?clJ1RDVlenJxU0NWRlBkOERNeGxNTUtiY2hkUnphUHc0WHl4SUJSTlJkbWtH?=
 =?utf-8?Q?JFMyGYeVVIct8fyEOki7fI0O8dOl7BpD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTBJaFYyKzNlcnRhcGRrT0I0elRyQ00xS2k1VHBEelZrWnJhSzRSZ1h2d1Z6?=
 =?utf-8?B?T3k5NWFFc0FtTm1IdWF4QmlNUHI5UEdQWHRaNnB0VXVmUmpjU1ZEOVZZUjla?=
 =?utf-8?B?aUY5Q052TFlaTmQ5V1BibVlDMS9oUkRlZW1uZDhMaHFDajR5MEFMV3BhOVY3?=
 =?utf-8?B?Z1N5SXJpQ0JmRWVleGxoY25kTDkvT0lROERFRzRVSGVjcnhTZDk5Y3Uybmdm?=
 =?utf-8?B?OWpwbjdVdDJOQnIyckZNVHNhL2dYdDJqTEpmd2NURU1DNjV4V2pDYnAyaDl2?=
 =?utf-8?B?Zlp6R3Y3U2ZjNWx3VkxzNjEvUXgxVEtISDFTUFd5cjZvTlRJZGlQVzlrZ2hZ?=
 =?utf-8?B?M25GNGZ2OXhiU1ZBR1kyQzJGclM2U0IySkhmeUFWYTlqdStXVFFlRHJpTzVi?=
 =?utf-8?B?WnBLR3VSOFFrb1ZCczRPOWh0S2ltZHJGMVZvaXZsWFhTK3Y4ZTJoZWsvL0Jv?=
 =?utf-8?B?R2MrR3RSZkN0KzlJRGdCT1lFeHNKVGJVeXVMSGRsUXczSjZnWGJ2akdkSFJa?=
 =?utf-8?B?K0t1NzlsdmxVeGVSK2Z4c1d6UTRmUEJXUGUyZ1NFSmh3S2tvbmU3ZzlvUFpF?=
 =?utf-8?B?VkdwR2g3WlVyaXpxUlFQdXRVV2RDUUZpSXBaQXAzcXYzMVFTWTdpQ3puWlRJ?=
 =?utf-8?B?ZDlvOVZsdFNoZk9GRHNkQ2dFdGNwZThHWnFvTDZTV3V0T2lYUmJoTWpTb1Jv?=
 =?utf-8?B?ZlFWQ2hpTHZsbnRROFZldUxqTVpjdmxSV1NpMnpEcm9qNVJTMTU1YzRBT0g5?=
 =?utf-8?B?V2pTcHB2SjVLMU41bUM3alBTZDNUbmlXb3ZMelplTldlZDVSN2YvQ3VGV0NF?=
 =?utf-8?B?OENJVTNRdjU5N0c5SUVVTzRQS1RNd1I4OHE5YWRvMkQ1OFZnczg5T1pXS0E0?=
 =?utf-8?B?dGtZMjRUTnZwS3RzaUxKMXBaMkQ2WVpqdVRjUEJscklpWHdvRmo4WnFXemR0?=
 =?utf-8?B?dkNnU1g5WFliWVh6OStSYmNJaFl5L2RXOTRYSXJ4b0xYRU9kcER5TGNoZ1Ri?=
 =?utf-8?B?a0ZVUGNETGx3V0hqeWhwbEp2a1V3V2s0bmJhSzhVVVVJdFQydEtDL2VMeHBl?=
 =?utf-8?B?RFpZdFVtNURFVlgvU0Ixb1V4a1RRSGV5L0Q4RDR2RTlPMnduMjM4clJYaXhV?=
 =?utf-8?B?NEhhdTdiTUJ1Q1RaYlJ6citSYXRLcTJHS0xWdWdYM21ONnFJNks5T1JlU05D?=
 =?utf-8?B?SkErQ1dLUm1uK2NDK2dQeWtuZXJvQUNxYysvM2o2Mi9RU2NWOUpobUltTGdH?=
 =?utf-8?B?Z1lWeFc5YXl3bCtsdkJUNnRBckZlVjViNXA3aDZUcit1N0Z3aWFDdGpyOUVN?=
 =?utf-8?B?R3BSY2xyYzdseVVzSnJKUW5ZYytGUkcyQTRXU0ZwRU9UeUJwT2dJMzI5bWkv?=
 =?utf-8?B?dkE4Q1ZDWmhnSUdIY1p0WU1xZHU2dXlWcDgzVTBTQlNQM01tQWEvWjdMNk9S?=
 =?utf-8?B?b1dUNW1iRGZUVElXcEFSL3c3S01yRHpZdTJGcnVSQmw3dzlhMWRyWUpweVdS?=
 =?utf-8?B?Ymc5a2hGU1lySkcrUEpEbzVNT09sWG5EY2MxQmFIUVAyWlowMnRmT1c1OHRC?=
 =?utf-8?B?ZzVwTG9aTGFMc1dJcE9yWGdzWVdkTmthS1RKL01kdy9yNm9WaU1zdDNIKzNZ?=
 =?utf-8?B?RHFpamRhYzUzSEhzNTluUXQ5VUM3aTBQd1lkTW9ReFhWNE9PYVN6MGtuRGlt?=
 =?utf-8?B?SWJacTBzVFU4VXRKSTdzK0dMSzZaZStsdU0zUDI5ODhpVFFFVEpTeEZwN1RC?=
 =?utf-8?B?K0tkcGpyRk5mRDZjODgrQ3ZlTWJMQ2xBQ2pTMkFFSzBVVm9DUVVBWlBKdVBV?=
 =?utf-8?B?a20zcTFSaHMzR2oyOTJPWmd2ckZvcURZOVNkbWM1ak43MitFOGxEV2JnSldV?=
 =?utf-8?B?OVp1MFdYV0p2QlFUQS9oQmJ0YzhJUGJCZEVJQ3RQQ1FBRXp0bSszVzdESER4?=
 =?utf-8?B?dUlUVTR0dE9PUkZ5SFNXam55S0NIVGlZNUtvUHpOaEFIeTFKWDk2cXlqR3pk?=
 =?utf-8?B?KzF0N0NRaFFaU3RmenhvUVV6eFNLaGppcE51c25zdnZEdDJpTzBWTWMvWHJ5?=
 =?utf-8?B?TDJEZE1vTzFBTXBvUVJadkNCMll1UXpsQklVOWRVTW1jY01zZGpUQ1NYVjdG?=
 =?utf-8?B?TGFmM1hMOVllTUxVZEthVzRNMWtRQ3ZPMlZMaGRXbHdza2NQaGdqYTh3VS9Z?=
 =?utf-8?Q?jg+rvlIjCUKOaf7T2y3oBG2od1e3l3rEMc4lunqT69NG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7f6f01-3171-4a1b-facd-08de2c2d0202
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:14:56.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPlGibbxorrEtgAIUdGcl3l3QYpzzxJMYC7F82SK8q+OITrZIDHnORtdLXy/PAROkS8CIh6H/pSPNpCryjoKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

On Tue Nov 25, 2025 at 11:09 PM JST, Alexandre Courbot wrote:
> On Wed Nov 19, 2025 at 8:21 PM JST, Zhi Wang wrote:
> <snip>
>> -impl<const SIZE: usize> Io<SIZE> {
>> -    /// Converts an `IoRaw` into an `Io` instance, providing the access=
ors to the MMIO mapping.
>> -    ///
>> -    /// # Safety
>> -    ///
>> -    /// Callers must ensure that `addr` is the start of a valid I/O map=
ped memory region of size
>> -    /// `maxsize`.
>> -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
>> -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
>> -        unsafe { &*core::ptr::from_ref(raw).cast() }
>> +/// Checks whether an access of type `U` at the given `offset`
>> +/// is valid within this region.
>> +#[inline]
>> +const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> +    let type_size =3D core::mem::size_of::<U>();
>> +    if let Some(end) =3D offset.checked_add(type_size) {
>> +        end <=3D size && offset % type_size =3D=3D 0
>> +    } else {
>> +        false
>>      }
>> +}
>> +
>> +/// Represents a region of I/O space of a fixed size.
>> +///
>> +/// Provides common helpers for offset validation and address
>> +/// calculation on top of a base address and maximum size.
>> +///
>> +pub trait Io {
>> +    /// Minimum usable size of this region.
>> +    const MIN_SIZE: usize;
>
> This associated constant should probably be part of `IoInfallible` -
> otherwise what value should it take if some type only implement
> `IoFallible`?
>
>> =20
>>      /// Returns the base address of this mapping.
>> -    #[inline]
>> -    pub fn addr(&self) -> usize {
>> -        self.0.addr()
>> -    }
>> +    fn addr(&self) -> usize;
>> =20
>>      /// Returns the maximum size of this mapping.
>> -    #[inline]
>> -    pub fn maxsize(&self) -> usize {
>> -        self.0.maxsize()
>> -    }
>> -
>> -    #[inline]
>> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> -        let type_size =3D core::mem::size_of::<U>();
>> -        if let Some(end) =3D offset.checked_add(type_size) {
>> -            end <=3D size && offset % type_size =3D=3D 0
>> -        } else {
>> -            false
>> -        }
>> -    }
>> +    fn maxsize(&self) -> usize;
>> =20
>> +    /// Returns the absolute I/O address for a given `offset`,
>> +    /// performing runtime bound checks.
>>      #[inline]
>>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
>> +        if !offset_valid::<U>(offset, self.maxsize()) {
>>              return Err(EINVAL);
>>          }
>
> Similarly I cannot find any context where `maxsize` and `io_addr` are
> used outside of `IoFallible`, hinting that these should be part of this
> trait.
>
>> =20
>> @@ -239,50 +240,190 @@ fn io_addr<U>(&self, offset: usize) -> Result<usi=
ze> {
>>          self.addr().checked_add(offset).ok_or(EINVAL)
>>      }
>> =20
>> +    /// Returns the absolute I/O address for a given `offset`,
>> +    /// performing compile-time bound checks.
>>      #[inline]
>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
>> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
>> =20
>>          self.addr() + offset
>>      }
>
> ... and `io_addr_assert` is only used from `IoFallible`.
>
> So if my gut feeling is correct, we can disband `Io` entirely and only

... except that we can't due to `addr`, unless we find a better way to
provide this base. But even if we need to keep `Io`, the compile-time
and runtime members should be moved to their respective traits.


