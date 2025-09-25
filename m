Return-Path: <linux-pci+bounces-36922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B671B9D447
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 05:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897117B6A8C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC151CEAC2;
	Thu, 25 Sep 2025 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1gVh2/W"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51441DFCB;
	Thu, 25 Sep 2025 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769321; cv=fail; b=KY2s9xq012kgH0Iv03dJomII/yauLz6qAXKpydnvTPPHHTG0rdQIt47ETs7RRZccj/afVjyAnb/ONbh7nRjAWeihe5sxvbdDDTuvsXe3Vt7iY7Fek/DKWc2dS7kJp1m8VywwBmwmoGLe2UGVIdA5s7M7/lhUE+c79IGQkYX3tO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769321; c=relaxed/simple;
	bh=LyQxQJCpGNxYPvIQ5ewCwePmlN4s/xBFRD8NSiPV7u8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=aNTR06jGTTiJ7pT5H9lPxgHv5V3sNtgXTX3B3hZI7mOlVVxe5p1zUz8m9tI3OBd0257uSO/LRocy39w+EgqHXzNXuCFXnKNgIA9wQukSgKeTteVYXyhKzt+Yy2mcYLYgE7RUDwUNV8NebVWTHP/fevlQuCvkgFlHuZALVm+Aa8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C1gVh2/W; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eluzuPJ9NqLk0bJUenf3Cvv5K0xJ+az2B69fXPxMtL1JW5cRgTE70FduGvashntvmezug1xKJUqonFB09K45E5CJpKYWGMsCdcYl28PIKbobeqlJ93mZiwl5EzjPlX81lqqwZVujiszdpS1pySzmh7SGHx3cHJQznhgXOJcE3ljbqpzb0eIHj25gCqLyXFQO7UxIdyjYhRXH+LMvX5/d8doSQQAxNv0579p3y14IEbwRA7LMByr5Plau8xQMt7FzqI3WHgY4v3OqrpxieJfAFS4EvCDDJgfBzFILO+/Gcblfba0P5GbyAS2CVkF5MEeuv9hq6JFYDU7bBky1bXhxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdrJUa4/k+UEVQINHhIq5hFRw1fg3fD7wi58+SQuY1I=;
 b=f9Zhfuy4+GVS4XG1PzqqtW5amqEVM6r+X00Z6uSj04P/D9U9DNTDCF9K6a71Vk5fC+gQG+ipMx3LSgzKibJXQK4zSyMXIaOFCIr5fFkEUhLEs58hSUr30jR0ltEh/qW3oQtAwAvhkVaOwgUOIiXnndDdxecj78PW1fuTq1xQXqDPr7fpuF8l3Cocc3I6X/tG1zObkkN7cwZsHo9+tL8pZ6c7S500D7DYCcxKGZbDkbui+KCqcM48CjnpN1mfOGsuQbP8pW3ghx5BGWU45klxtBcFgVcqev8LN7I7bvB0AuGmozSb6m1oqkzUww8Mvien51dqWPTN22z0W4vpuGsUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdrJUa4/k+UEVQINHhIq5hFRw1fg3fD7wi58+SQuY1I=;
 b=C1gVh2/WoFMbDcX21ONLgDvR/CwcR6Ly2i0AaHi8vH4LH2sIyD4wcFXeLPX8gkBCPwdFTdrri3TXnMJ0HClwcV6ohq9JNnoysdG+RIm1CBaKQJqimsEmfB4U1E+4G1QE0wnA4bVIx8apt9RqHWwh3CAmDS3jfnUFgZIK6BOETv6b7/SZFw1wD9+t3TFjzpqS2KkLq1LYXXFqZtrvd0YE+vfCiU/pI3dXLhKEW3zsS4OfnkcwECSQrYcbF6KOgWHxD/E0h/VpXnzIlQu9DEBQkm40+lXE54igIBZzAIwxJSn3L/49slWYFlZcY4ZOtzq70hY5QFxdQVsATuzVJ3M6cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 03:01:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 03:01:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 12:01:51 +0900
Message-Id: <DD1JORQ8539K.1H5X1SIF7J3WD@nvidia.com>
Subject: Re: [PATCH 0/2] rust: pci: display symbolic PCI vendor and class
 names
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250925013359.414526-1-jhubbard@nvidia.com>
In-Reply-To: <20250925013359.414526-1-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP286CA0142.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e011742-7961-49dd-c049-08ddfbdfe2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWc3SjNhSzVUaXd1cXNSQ1NTZTVobENXYUcxcWkyUXZPZHlhRXNFVjRKenhv?=
 =?utf-8?B?ZTZNSHBkdlhFK3BVcXFIOUlrS3VZMENqQTlSbVZUNWFjVlgxVlRQbGlSMXlv?=
 =?utf-8?B?aHBjNUh3R1hJUi9IcW9aZGxCeElrY1RMd295RmphVXgzdStGUmZhdXptRmZh?=
 =?utf-8?B?T05jNWkyVWE5ZGxmVElBR3FnSlVBemduaFd6cEt6cFJQWWpGU0JjMk1pUzdD?=
 =?utf-8?B?TFdGSGsyQU9JOEZ4WVQxOFJ6U0FXMzRGajI0L1VyMklVSmhTYlIxSVNJem52?=
 =?utf-8?B?QmpmSnFsYUdFSmFyQWxQMzFDSlhWbTZ1QjBoV2hBS3lGYzlnVHl4aDhISW5D?=
 =?utf-8?B?YXdzQklPWk00T0M5ZFFNYmxwcGJ4cWtKTHkvOXZpSDdYRHZlNlI2MTVDc2VJ?=
 =?utf-8?B?RTdDbXF1RmNZMkZ1VVc1NXlUdzJqM05JZk9FeDV5Mk9acWRqT0FzZ0VTNGRD?=
 =?utf-8?B?eTh3YVNmUXQ0YnViVXVvSVFQejRtTi9pVVNIaks4QTY1Z3lFdDJNZC9WTURD?=
 =?utf-8?B?dnB1V3BWak9hUTJRd3BPcjNoblFuOEdxNnl2M3gvZFhoUEQ5ZGowRVJsRi9L?=
 =?utf-8?B?K1R2QkpJZjZGVnE4ejVzN0FwSUlVTUNhTXpheGsvcGN3VkZraHBScnR6SXpZ?=
 =?utf-8?B?WjMyWlk4TnJQcEJOZnlzUWZQM1d5cUw3aXViL1JkdFhydU9idkF2ek9DSkl4?=
 =?utf-8?B?WHJ4R0s3MVBwdVBDUjdPc2czbEdoNzlsNkE2Nm1TdDR2QTJobTF1N0d0ckx6?=
 =?utf-8?B?R0pzMWZHMzNnR09LZUVFdmUvYXVMdUFZbkxSYm5nZ3JCdzZoL1dOL1d5aUxB?=
 =?utf-8?B?b3dXdm02dHU4bzExN1ZyOG1lL2dpU3FGQkNCSW9TWnFiV0ZlNXhtYWRleVVq?=
 =?utf-8?B?Z280QXFDelhDOVI1cmhKMmRaYXNoNWxrYUFyc1RQMEppMHVoajFLaG9zZW5q?=
 =?utf-8?B?aFN5M2V6SkZzT1JDUGVXOFNPOEpZYmxrMExMYlUxRWhvbmpjaUM2S1NJaURZ?=
 =?utf-8?B?TEV5UWpRSmUrSmVxQkMzbFNrYkVqVmZCTXUzN2dhb0FRUk1nQVlqdDZoR1ZZ?=
 =?utf-8?B?Y3ZIV0NCaFFkNkRHc0I5LzNsUnpoQVNYV0h4RUxHNGYzck5Wa2x3WGE1NEw2?=
 =?utf-8?B?MGxtbURzNmNtaGs4QThhaFExajlTZGZ5QkJzMTEvcnNiUjNMQ1YyVGxTdEF4?=
 =?utf-8?B?V2VDVTBwOXlvbnVOcStqbWptTmtUYit4Z1MwdEpXR1RVU2c3b0x6NVB4ODJU?=
 =?utf-8?B?L3ZwZTRwck1PVHBWQk4zTjZKb2VkelhnNjZDaHZMeFdHWXBwM3diSzBVZnhV?=
 =?utf-8?B?c3pxaG9XSi90ZU4yTitLeUVhV3YvUDNCcnlsZkxDQzV1eEFBU3lwR3dmYWJN?=
 =?utf-8?B?Wkw5RHQ1WVRhWjNZMFhHL1JjZHNzL2dRc3lEWmJ4eUVtamh5Qys2SHE2a2lY?=
 =?utf-8?B?dENON0I0blpVUjNPV1crSmR1UUFZbTlwaFF0b2tsZkhNL0tTa1JJT2p2b0Er?=
 =?utf-8?B?dU5Gd1ViaXdudUFKYjJUWjBxRzVjTUJpMmJxYmd3MXNzcnlmaUhaRVlsU09w?=
 =?utf-8?B?d24zbE9ma2lvV0o5WHNwRkZMZlJ3UEZidExXcFhTc0w0UjBmSmRrSXVkQ3oy?=
 =?utf-8?B?YVNjcVBNeDdzaXRTYmFGZ1lUTXMxc29TMGhtVlBaREx6Z2s4WjVoV0t6SkZi?=
 =?utf-8?B?Qk8wdHhCMTNKdGoxTVVoOWlGYjcvc2x0QW1nNDQrai8rL2grS3ZYOUFUeHlV?=
 =?utf-8?B?UGhUVWgxMWRlcG9Vei9SNy9kR1JSQWdNZkdhT3RVQ3FIcjBsOUpkcmJjLyti?=
 =?utf-8?B?dW4wNkNLdW9RK2w3L3Ftc2JkbnJkR2ZaSWFXcFJFWEpTVnc2VGEydkY5OVp3?=
 =?utf-8?B?QndaVmRiMDNOdDc4d29EbDE3MkYybUs3Z3B6bGY1SDl3eEpQSEFDcDBHcVZB?=
 =?utf-8?Q?WkAN1BXNjEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9rT1hkNDh5ZGdvdGxFcGJwVjJ5aDNWNlVYUnpLb1FKRU9GNTVuY2NrRzBq?=
 =?utf-8?B?di9KdHg1clJXbDBlSW1iVUlRZjhwQitPb3lJcHpsKzRnaSswK255Rmo2anly?=
 =?utf-8?B?VFpsUmh2MUhVak5ZMXdUY1hwZ2VOOWpRR2Z5Z2ZlM0tOVFRwZFZLcm9BaGhK?=
 =?utf-8?B?SDZzU25GcmZNSFl1elpQVHN1RVQ0N1huTUZ3MVJ0WDhlS0VmM2FNQkdTTDFl?=
 =?utf-8?B?VTFyNEdJbVBNOG03d1d0RXZ0OSthdjQ4ZUN2QUVYQVZQY1U5dU9RZVpoMWp1?=
 =?utf-8?B?bkR5ODlObGZKMWpBR0VDWW5ISEhLNUZhMjlucXJRTGFZRW1XekJZR2ErMEVM?=
 =?utf-8?B?bGdHeWhla29CbXh2cldMeW5obzg5N2dEd2pmTzBIS1hFMlBqQkRpSDdWT2Zt?=
 =?utf-8?B?VlhxMzNYUWFWVGlzc1YzTmpnVmxQMTVXcFBkLzNMVldaVFFaNXY4bHAzOUVH?=
 =?utf-8?B?K0dqTWtLSE1WSmx6bkFEbUplT3doc3dsZWdGRlBvclJwQ2dOWU1BeXhZVEdj?=
 =?utf-8?B?Z0xzSlVQNHV0OFpCejJrVmpER1JVYUdhYjNGWHcxa2s3THYwU2pTN21PNkta?=
 =?utf-8?B?aDRiaEE2Z2EzOGdyaWcrQi9kVWNMQTd2NVBVelI1bXlTcXp3bmN6RVRRZjhL?=
 =?utf-8?B?eHFSSDlGR2NPOHRRSUduakluY3lLV2RTV2phb0IyVDJOVWRML01LRHYvYkxI?=
 =?utf-8?B?UjVsWUNYMjN4T0VKZm8yZmhad2hMbXQ1SVpUS3lzQncxY21YQVFHbTZ0Q2Y3?=
 =?utf-8?B?Vmo0YmZhbXBLNmZ4SlBEYzdEb3VHU0FSb0RRN2tzMS8ydHNuYzFXOFovelZO?=
 =?utf-8?B?ZzFJOGFETDZvMkQzS1Q4RzNPaGt4OUtYck8xRUl6aVdsd2RuVDhJeVFWT2pM?=
 =?utf-8?B?KzZuMXRteGRjaUl1cFRmTkN5WHVBb0dGc0h2QnVTREtxanFTZ01yanZRRHFr?=
 =?utf-8?B?SG5sTllQb1g3SXRGNjE2YzhqQnpWS0R4SUZFTmVic2NlUHhKZUxBT3ZIaUUx?=
 =?utf-8?B?OTVpM2RyNXNoY1hwbUJlOFFFb0FJaWI0SUdmczR4SndkTmUyQ2FySkM2R3lR?=
 =?utf-8?B?RVZCMDVaVzBDVUlYWG1Rb05DR0ZtS2JqTWVYV2FUeW1SQUt0THpxWmg1cjBF?=
 =?utf-8?B?aUc0U3RlVDBtMXNBQ2tUaUVGYVFNQ2xjZk1yOUhPOWpKNE5pb2xPUGFsbnRw?=
 =?utf-8?B?S3ErVjVEVkpDTGVyYStaemdxVGRIRTlLSlVaVG5TeUsxdlU0MTZDeXc0ZUFL?=
 =?utf-8?B?NnNNZnhxcDhmL0tUTjY2RGt4UnFhTFI1djNpRWY4RElERzZaWk5BZ0pIeVhC?=
 =?utf-8?B?RmFVbUhrSWpaTGxBK2JHM3pnenovUzE4aGZTQUZ5aGtFRFNDb1Qwcm5oemg2?=
 =?utf-8?B?SG82c3lUbStQZkpYM1FXVm1TdVJNQkpSNjhsZWlOdnBaYnRQVVVOekFMcXp5?=
 =?utf-8?B?TVE0alAvZ0UxTyt2RjdLVzlRYXE1aXRqTllnbVdLUzJ3dUk2YVoxTzBrZEJ4?=
 =?utf-8?B?cjdrditiektBMXAyQWRyeTgxdi9zbTg1UFIwOHFLSnZ4SC9yVGVSbm9wd3pk?=
 =?utf-8?B?YmEwQ3N1VjNUY3BqdGN4d2FKeVNvY1dJUVNyOFdFTCsvaW9DTWdjR1lBdTJR?=
 =?utf-8?B?RWhvSWVrVlN3VExlYlRscEduaVF5cWpUMDlnbmdaNTd3QlRUMU9mVG5ZRG1R?=
 =?utf-8?B?Si9ncUQ0Q1VOb2RIeXQwYUExYmtpVVdjNHpHMG1wRzd6dkVLVkxjN3ZSOGRC?=
 =?utf-8?B?YlVvbGlPaWp6VThBVi9UVUhpZ2s5eHRVT1MxR1EvbUt3d3BoWG9DUXRXZWZp?=
 =?utf-8?B?OWVrR0VVRllUNGFyVWMvc0dpMGFmNHNNZk1jZHByZ3F3YVYxWndoWUo4QTl6?=
 =?utf-8?B?aVc5aTFER3dmSTZ3c0o0SklxdEZaTW1lS1lOc2FKcXlFL0J4WWNQTDl5OHpk?=
 =?utf-8?B?RnQ1VlMxRlhkNW9KLzA0UUt4Um5jdFowb0VuUzcwYmgzdERSN1FiNS9reEZY?=
 =?utf-8?B?UE1LK01sUE9rV01xKzc0cXNiMklOdFRMY0Y0VjE2SElmbTdWYXY4elg4OTN0?=
 =?utf-8?B?ZGhoTVVTdzlBNTlXV2dLRUxuVkhMeTRRdnJZNzZtRkg4aTZ0VkNzcnJnOU5D?=
 =?utf-8?B?VFFlTFR1REd2MFZMR1ZqaG5nKzN2RXNUSHlLNFNYcytJaEFFb2p4a3JuM3N5?=
 =?utf-8?Q?1FltewSQjeUtaBR7pkf5ip4HgeoRwC51NOJSxch+WUQV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e011742-7961-49dd-c049-08ddfbdfe2eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 03:01:56.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJydJMYez4WMEHyVjrC3ehv5KWJ1FL+CENDQV+yeIN0dSb/rZsbGLvaeu499ckdI3qNyUvX3GC/F/NHKC+E+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

On Thu Sep 25, 2025 at 10:33 AM JST, John Hubbard wrote:
> Hi,
>
> This applies to:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>
> It's a small follow up to these commits in that same branch:
>
> commit 5e20962a9fc8 ("rust: pci: provide access to PCI Vendor values")
> commit ed78a01887e2 ("rust: pci: provide access to PCI Class and Class-re=
lated items")
>
> Danilo, I've added your Suggested-by to these.
>
> John Hubbard (2):
>   rust: pci: display symbolic PCI class names
>   rust: pci: display symbolic PCI vendor names
>
>  rust/kernel/pci/id.rs | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)

The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

