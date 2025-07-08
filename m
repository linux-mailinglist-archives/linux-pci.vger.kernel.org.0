Return-Path: <linux-pci+bounces-31655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D1AAFC393
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD3C17D71C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EE2550D2;
	Tue,  8 Jul 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YrNHKglm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD5191F89;
	Tue,  8 Jul 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958350; cv=fail; b=leIV3+UllSmPYXYNGoUOPfRNdyDP5rxpGw61lHebwHKkyQoDHTid/nKUpYd0U/GOpxLvCYdBq/NXQ9NKdBJoZwbOmq072yLMTBwkfEeBkcfzMxFgxZAYe/X2qnLRS/qtSZn2PdbKmjMW/wUhc2P2ZQLiR8QLXDyug46SRWZ1gnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958350; c=relaxed/simple;
	bh=U5lAqRRR9IbE3wPNjtIoiiVVTR0DrOidKKMG6B+ih04=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=l2zvroIlW0EZxZyEPoWkX4omj55XjaGR2ptlVl18zAaLryqG8kDnyco9RaLe757Ej+e1aPyQ9s1EiBHP5Bvh/QyQMrkxnJogl0FAr+G+3nAhBBPNSxRdGvtIdGtTD5hteLzHCEk3AaY21mjO6dwwgYPseK7YPnOVQsQngbbBT4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YrNHKglm; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rgjg7+tpudMkyLNzcKwlPaY7Scrz64GZQnWJlXqDr/39HfKUx4Fnw5KeNx2rxsaYrD03Q7ZRpdHwr0zxAIrr9uPeT9Dy1wTitQq1L0AJkaQ+BF0GrTOZsgT5N/rAoBHvATEi85867tPwx6cak4gVZQOe5+rLdDf0I54IMsdQiV1I2zi1RHCrdqgXUwza3GTmN8rw8YvudmQa7vkBFJOuWrDBMPAkk8X1xczGiUbaxl9n7JGDj+v5PfTG9HP10R9o+zXRU24ELNMJXcc9jMqYYC6KsKa6VemyxeoyG/06l2QKJe5qcOJgDFpxQS+pmW8jiQ4xCc6P7BFqhHwUsjELhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5lAqRRR9IbE3wPNjtIoiiVVTR0DrOidKKMG6B+ih04=;
 b=UyI0PyYoTT25ETtaudxqeHb1cqribhhvhYp1d4LTselxd2d6cfaFEhmGBdIBr4OjUTB6zIKVF78EEMjQjB0JUz35E/ulLzqNTGbGrudR/JwYQ40ZFxkURpZteK1HLI10A3mXrPMwT4aH/RaYLWCihpbte61TK0HUoxZKnwhlvVgkSFT69D4j1vPhS8xKIIQhpnw9rKlTT5oa7XF1yY5Xhrc7vJfs4+mot+ZNMZLAUOIu3ajoUwolUGVzZ0xWzbzf2vs/SzVJh/7jap16d02RRan+mMARP8/X/4/r5Bb/ya+rCxf7VMNYjifa18h1mY9NX7abJfs0IJWdF4f0gjP/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5lAqRRR9IbE3wPNjtIoiiVVTR0DrOidKKMG6B+ih04=;
 b=YrNHKglmE5nP8rNDljmiTlBB3jT+7SKvgZyqiZ5GCKtgAZWqGaz/w2DxEJ+GWQJ6ZvCo9q8080mCuYl7rKRatU4tl32xOa768G3mFnN/spI0foq/AIjkBuOnDN0RZycpXP86rF+TAc1BClx7VRJ/QgzHv2eXrRj2S629nTbMUfoQX9WoozI5IjCZBOLMbsrp0FERJnroQYL/Hp3pGcGfcPZP4fTuinAcwDS34a4d1CndHfXhnUKGqSwqiv6pWx4mNUsz3KkJiD5FrlnW2ImCh6vXtZQ6KqR46YGE4T2zTJlpDwWZe5giGuGZ4gkZyNCamUVnHkpZwxik5TGDHMbhyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 07:05:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 07:05:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 16:05:41 +0900
Message-Id: <DB6HEEYLFDUD.29ICQ9TXK5KSW@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: Add several miscellaneous PCI helpers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250708060451.398323-1-apopple@nvidia.com>
 <20250708060451.398323-2-apopple@nvidia.com>
In-Reply-To: <20250708060451.398323-2-apopple@nvidia.com>
X-ClientProxiedBy: TYAPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a1aed8-8f06-4a20-aa4c-08ddbdeddbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y25lZUh1ak1nS0JSa2ZSalJESVJhY25mN3lQWkIxUTR1Y3RZYnNEb2tjb3VS?=
 =?utf-8?B?YVBucUVUcWhTYlFnRlFDUjlhdXI3TnlCMElDcDlIVi80OFNGTWtwMTA4OVJz?=
 =?utf-8?B?aHl0ZXN6Rk90d2hMVHN2STlDYjBNRVpCWmZDVUlLbkZ6YlArOVlpNTZCWVhR?=
 =?utf-8?B?c0VHc1NMcmQvN2E3OU1ZKzZtV2NMY1VXdFN1c3N1ZWFvbGVpd29jRFNJOGdy?=
 =?utf-8?B?TXZ5bjhLOFFiTlpCUmRnV0VrZ0JFa1ZnNmsyK1hTL0gzUGxxbXFZaU9zMWJ0?=
 =?utf-8?B?QUZBR3VxSWdweS9QaU16ajIvMERrT0oyc21XMzZUVlJzak1KWng2TmhNNk1a?=
 =?utf-8?B?Z3A0QWRnYWZTYWRoTVp1cVRMcjZ1Ymlac3c5VzRjay9VSEdkUjd0WWtXVUNs?=
 =?utf-8?B?MmlrNGh3TXVJUjA1VGhWaDN3VG1iV0gwZjl2NVZYZ3FrbVBXK2dydDc2NTQy?=
 =?utf-8?B?V1ZCZDJRQjNnamJHcFVrNml6THBZSnFFR3lUbWc0QTVpYzBvWkoyVklWMzFD?=
 =?utf-8?B?bDdlbzZXWjJIOUFMR1p3U1IzeWdCN2VkdUhUWDBBYTNLUmtVR2lKcnRZSlBW?=
 =?utf-8?B?RUs2WG9wTTlIN0NWYTRuYlFXb2haK1lsQnNZL3dQazNsUEJmckVtbldqQ2Vm?=
 =?utf-8?B?TndjdStIYmJYVkNhOUxzSWM4czQvMVJBb1JETmZPY1FzTkRwSzArUjJjTGVz?=
 =?utf-8?B?MmhyOXQrZHAxdFY4Q29qRzdNMDd0cHBZMElwZnhQWHRROUpZQVFZcDd5VFQ1?=
 =?utf-8?B?WEdWNUtLYnFWYUVpbFRHelV4M0duOGN4cmR0b1JtNTM3K0xqbHRWNm1iRjZ3?=
 =?utf-8?B?K2xmVERDYmdWaTg2LzRaSk1uQytzV2hkNEIwT21uaGVVcWN1NGduM0UzcFUz?=
 =?utf-8?B?TXdUSVBxTUhlTHQwN016KzB3VTJtVmxmc252Z0JmUzEveWRkOUE1ZGxOd2c5?=
 =?utf-8?B?TEROVk5vaXZmSjh1WjE1alg3WEZaNFZuQkJsMk9HdkFzbEdKL1pFNVM3NFZo?=
 =?utf-8?B?OERXcm1SZ0kyYTRRMHJoc1hMcHZWSCs1UGJuM1ppVGhDT0hXV2g0OVdwRlV4?=
 =?utf-8?B?OEN4N1BrRzE5ODBOaERQSmU1N2lncVBvSG5pK2E2V3ozbWI4aHhLU20xYlY5?=
 =?utf-8?B?ZnpEaEhTM3VqeEh4bVh1aVFGSGN6VUFQRGFEcUVLZENQNGZFWUNKU0NnM2FL?=
 =?utf-8?B?UUYvR2pnckduOE44Rm85cFNTWXI1SmZQQ2VOVU9neVloQk90M2xRUFU3ZGVJ?=
 =?utf-8?B?S1Bib2pYTTdLUG03WmErc3BWY2lVTDdCT3owUWZkam9rakJodUJIZEVZMzVX?=
 =?utf-8?B?RVdFdS9NVi9YY3JQVDNueFZ4Q2lpV2VSNWRPbFJEKzh4cFFpV2ZiRmJJTTZP?=
 =?utf-8?B?NkVzWUI3cWpDNnpwd090U2ZiYkVNSU5rWUlyRVZuMkRHQTQ4YjRiR2Q2aStt?=
 =?utf-8?B?QzBvYXhnRkhXbFJMRTRtVEtaZWJ1bHU0T0doSS8yNzdpR3FMMlJscGJIaGlB?=
 =?utf-8?B?Uk5kL2pVem94TmcvYUJNR1pPV3VYWVFsY0JObHlkbFNURkVJSmp4UkVwUTdG?=
 =?utf-8?B?Sk05NTZFOUZzNWZPcXlLZk1iWHgwaUNQUjdBb295NkJ6NUZVZXNUQUY1NkZB?=
 =?utf-8?B?SVYyL2pRWjdBd1Z2VTdxQWtwaVNZQlAvVzlHbnNRWE5sbS9pUHZWNUpOWk5r?=
 =?utf-8?B?MEdWN1F6RlQ1K3BSblFEWGdHSm51eDEyYnV0VDJ5bDRnZmRraTNBK1NmSEV4?=
 =?utf-8?B?Tm9TbGhWSnZNWVp4T1lKN2w0ekZOdGRzWmlVbDl4Q2JCSzJKSnh1bkdZaFdK?=
 =?utf-8?B?azdEcHZla3FiektmemRzWE0wWnVYa2VBWUdaRFBqSU1IZUd0bzlJK3RGNFZW?=
 =?utf-8?B?SE9NYlkxeWNSWUkzdlBvR0Z0TENjU3djVEdCbXVpZXJzMStrTFpXUXBnNXlF?=
 =?utf-8?Q?vpyW/01cz2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01sc1NXNFFWdGJZbDZMdVYvOFUzTmlBYUQ1c3QrM2ZXUEhPNU5GdGM5UTNU?=
 =?utf-8?B?Qi8vQUdnQzNlQ0gxY1ptSWFJb3FoRUV4N2UySEQ4TGtJZjh6UWxyeGtPaTls?=
 =?utf-8?B?d0hZOE52QXU3a29rcXJ1b2NkZ1EzSi9OOXpsTjEyUGxrMjgxeFFLcDhubC9G?=
 =?utf-8?B?L1Y1RkR3Wno3ZTRTVVc1U1BJeFhtTW1YckRWYzVYVjEvNmhlRWJVdDZqbnRa?=
 =?utf-8?B?cGFPc1kwR3FYNVNtZjhBSHJ0d1hxeXpuWnNHT2dGcWswZ25JVkJXL0dkQjYv?=
 =?utf-8?B?RlJ4MGY0UmdlM2lFTHRidnpLd0xROE92OGFEdS8rSnhFR083TTNzUERpdzFa?=
 =?utf-8?B?NE92Um5nVmhCM1Uzc2ZBVnBVSUoweGRmTDVwTmVQck9BM0o4bXJIM0IvZlVy?=
 =?utf-8?B?cU5Vc2FLdEkwNW93YVBSK052TGt2RDRnblF5Q1BFNkIzYlM0TFpwS3FtMFk5?=
 =?utf-8?B?NHNhc0YrVXpJSXpTSENvb1R1ODRSWGJGc0pUNmdpOFdGSmNNaGZTV3ZZVCtw?=
 =?utf-8?B?bk1NZGptcW1YdWNna2pvVno5aENpY0JERXMyVEw2QlNsY0dWQmtYM0VOZ2dJ?=
 =?utf-8?B?RGM2c2Noc2VlaTBNTVUwRUNqZjIvd3hSM2NSYzM3a0JJQnl2bzk2TWpaaHpx?=
 =?utf-8?B?OXVCOG0zWGJ6ZlJnZTd1clhrcWw1SnhXNkpkZ0NzVHlvOTRmSkZjTFVCQ0RY?=
 =?utf-8?B?QUJTdkhTQ0ZSWEpEazN0cmZoZ2JzSVgrZ1FMNEI4c0FLN3VDeE45WWZTeVFF?=
 =?utf-8?B?c1hUNm5Cc0NBeU5RS2tLZHhWUlJ1UXdsNys2eXlUcGFSeDVHNkdXWWJ6MnA1?=
 =?utf-8?B?Q0hWWGlSMjZJVTY2aWprSHZIQStmeEZvdzA2TVFOYXY2ZExWMU9NVnpQcmEz?=
 =?utf-8?B?YU9FRHkrbUlscmtHTWpEMjBNNnpydTM3eVFOQm4xVUZiQXNUcCtwcTJZd1Bv?=
 =?utf-8?B?elVoWjd3TXFMcUVVNm1iTlI4UFQ5N3VQV2RhM2lkWEZMb1orcFZMOURTU1lT?=
 =?utf-8?B?K2tVbXZsdVdzcFV2UDVucE51alBYNlNPc2d1RlVvY25mYTJaUDFRbmk3a0Z3?=
 =?utf-8?B?T3hmWk1MMnJXUWlKWUpnY1ZtYml1SEFvcHJBdjZ0QjJuTWFTRWxuU241RlF5?=
 =?utf-8?B?S3E4aEpDQ2lsblN1M3dSOU9JTlNLSVFLQkhUZmRGWUZkZGp2bGw0djBEc2Q4?=
 =?utf-8?B?dUdZZHQ5aHkvdVBFTWtITmNhWjVMU2pUWU15azF1UUdWcHRUbE9ibVVxczR0?=
 =?utf-8?B?ZkZrTDFHOWt4QmtZZ3d6N3M4ZmYrdTZ2Q0drb0pneGdpanQ1WUxOVDJsT1Vv?=
 =?utf-8?B?eTJyWWlqUlFqMGlTbDdWWDk0UFRzRDJqcHJrRFVoeGJkaUI4bGFSS0lITE1B?=
 =?utf-8?B?bzZDdzhqczM4ZTdNOU0rdmMrbnd5SUxmMXcxU0JYaFRLRnJRU0NiQkI4TWRS?=
 =?utf-8?B?Mm4vM1ZnZGp2TVRnaTI0UnIxd1BUVUtxeTFuVDFNSE1qMjJTNlp2WWh2NDJ4?=
 =?utf-8?B?VlNBcmRGZ0VrVUMvWm44cWJpZGxNRWZ6ZnRYOW9hU2JpeW9vUzlzc0xxQTl1?=
 =?utf-8?B?SllJVlRnTWYrNEtyeTZEVVFXSlhaTURIZHRXaTVzSjJaRmd1MVhYVnN6UlhW?=
 =?utf-8?B?WGFsZFRRRVl6MnRLa0VzcTNtWmdtcmsxcFFsTXZvd3RhQ1RzNDZwdDU1U2U2?=
 =?utf-8?B?YXV2OXV5WVJ6SFQzZzVhSG1oQ0JlVURzdVZmOFFtdWNBR25ocFBOS2J5dlps?=
 =?utf-8?B?Nmx0Z1FGOEdjOU5mQ0RqM2dSSHdQMlptK1l5TEpXTHZrMlprQWJGNjh2eG54?=
 =?utf-8?B?bG1BeS9US3RSZDZsVi8vakIvK09kMFgwZTZVNk1FR0VCMGhnVHhBVUgxMDNx?=
 =?utf-8?B?MStVblpvVGpsSElFVmxEWFNNQjBGMzdDRnEwNVpRb3UyUEtkYlZ4L284QnFP?=
 =?utf-8?B?bG9jNXE3eG9zYlhBTWVoYUcrRWtONmU3cDgvTzQrZXNzRzZqT2RWU1BvcHNW?=
 =?utf-8?B?bWtHVTQreUt0OThKTWNJclpPR3hRazJscjJ6a2k1b3dEZWUyMGM2NHRwbHp4?=
 =?utf-8?B?K2Nwc1hheWM0R2pweWc3ZTJsWGhEdzBUTklsUHJ0cWpPd2pyUXF0QnBqdFVo?=
 =?utf-8?B?L09zRXpYSHVkS09yTUFiNHp2YjFQUDA1UHR5cWRueTMxVWVpT0FYR1FnUW1v?=
 =?utf-8?Q?vds1STaGJsYNi/evLmcyX7SUfDeCcb44ogv00s3Ehucz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a1aed8-8f06-4a20-aa4c-08ddbdeddbae
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:05:44.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWTeFYhVlvV8DwVxvAQYOI7UGb8tudOUB1+winn8Bd+UY4nIzBDeG6fxwpfMs8Q8eo+UHdkc0IHsytP7n8h/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

On Tue Jul 8, 2025 at 3:04 PM JST, Alistair Popple wrote:
> Add bindings to obtain a PCI device's resource start address, bus/
> device function, revision ID and subsystem device and vendor IDs.

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>


