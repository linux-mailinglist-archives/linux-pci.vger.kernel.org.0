Return-Path: <linux-pci+bounces-31654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B9AFC383
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE191897C7C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A68191F89;
	Tue,  8 Jul 2025 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKmj4iVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF335957;
	Tue,  8 Jul 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958089; cv=fail; b=QSFYUqeHxFoIV0aDQTg3n5OGWNBsC/h6nzJDgaHw2Tq0JRBTmGu35zfKaNosonDPFH7Guj90DKVLPhMxIPTlZr77Q1LB3C7XkW27bJEmNjZYIzXqC+ybZUaIkLmna8bfstzEtL74mOL1ewFVe2LAVkiyvoBjs2erMohH4SNsiJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958089; c=relaxed/simple;
	bh=v0Aa7RZG+2JS0NqEH2by6qMewo4UiiB9kaZXoePsRlE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=u+ng196h9mpuC4OAKunuTksbL9b1fmX6TEt9KeAnQNZuOFqZuXBtiSielQb/1gJoTAKuyTxyx75rDSk6OwRRW/UTMWXp7Kf83pQWRj6pKdq/m/OLFSr97Wf0M5luBgmN+EkZaC4RRVboEi7mPmYdWqDefg1M2opmo5eDLBqHGpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKmj4iVH; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYnPMqNS7FmYW2sMoT1g9/Hs0uO3shyp2wdtwtKUmvvE3n5QUWBI8xZegnwx8Psc2OwwOqfTMRj3E8DPDw1p05qY2VQjWWABt0gV8PyDogn+tiqvCYBAC23vUNuw+R7vCTiIuJw9t15iBMMWAHCQNQua5LVRBmR7NbZnGyOGecJh0ectWOa5N+8aYVCJrSsBMW+s91Y1uTUJw7CVjigmEzYf3cFWaQB2zVpMB/XXXk5hsNkK4XxTrpQYkdqhrgpGBE3VMkCQlONXnsiLyQ1MTVVz+9L8L8UeYX8lsqOmgm5z63qBKpTB39ao6MMTt4r6NgAk/K9ZmYuA0RvDTJaNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iG3U02I8HPsElrTzOlWpnlb+skXj5XneH7NcEQqPWA=;
 b=azLxqM+ZR/WDOhOmwppfT2iGWTwM+sRNIY0MMJx/8fwOVH/a1I1QkVoDMMTlEDxxkf3OPVqGXkpk3KEZvHeqFbhz6kwioi+LTzzrgYcGNWx2APraPIIw2zOUONupdFHky34b1jgq1LjH0B/zUBIxcBdl42B13L1T7Gd7HRak627aR8IL2jAkpYFyqmTRxII+Pdzlic6y0regC6tP0aiUYkOZw4TYLCnNy09wAJGpXnsCWsIH6coPBnUC2W0UP6H7VWTqfLJv1X+18QEvKF5/8AIGWGXLA2rfFk5afc9+gf16rqQ9GDnjPsYcdsdjbBoc8Es5d2Yedv7KZiZQGMSx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iG3U02I8HPsElrTzOlWpnlb+skXj5XneH7NcEQqPWA=;
 b=QKmj4iVH7IVgCS+D6PJeDI9cLLN2ILr/e0KqNR9Oyuq72bJq7urDyaJyy0KuH3yuBxl1f0tUAkF9k7Ff0u3G5HZp/4cxCsSDHVB52FxVRRpHpgHQvSR5IQ43P0HA5Ow6pCBQM+f7NEoojUQYMlQ/9T0w7eKfVzRIhZRB3zBIPp+zSPOukdIhNJQNh5hHCDKhK3wegZO/QEHXJ+Hv2byxImYBSxSd+YjsjUNT8WJHz/f4/DUTCaHSObHHe+y1YfmgiAlhqBd2IY7pAlnYtUwDhPh3OPdW4qxSAcYM+izAEDnCHcHZLZyQimG9lqxbdkqsXqa1zwscHp1M4qdfS1w03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 07:01:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 07:01:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 16:01:19 +0900
Message-Id: <DB6HB2VCI9CO.LCNRYZD6HWOJ@nvidia.com>
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
Subject: Re: [PATCH 1/2] rust: Add dma_set_mask() and
 dma_set_coherent_mask() bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250708060451.398323-1-apopple@nvidia.com>
In-Reply-To: <20250708060451.398323-1-apopple@nvidia.com>
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f66299-1d26-4a56-7aac-08ddbded3f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnJvWXNsSDd3SktqZFZZTUtnak1BYStJSVFHeWRjMTVYNjBmQnJFS1pvK3d1?=
 =?utf-8?B?ekN3YU1NeFFuS01NWitZaDdOU2tIdHVLTlpwUTQxMU9LZW9hRzM1SlhUVVFG?=
 =?utf-8?B?dm0wUU00M0ZnaGVLMHMvTmgwOHRYU0VWdUFNMGpzZDIzVWRkczhmVzNMMVRk?=
 =?utf-8?B?djloUCt3TkRIWFBkSnFwbzFFQXhhUkNkSHNmdTBFVUl3SDhhNGxUTkUxdVBV?=
 =?utf-8?B?dkd0QmRvZGVQUjBoOGIyUkcvUDFqbTljWE1YOVZyK0NEY0ZkY3FnV29sQVF2?=
 =?utf-8?B?ZmRvdW5UcG5XbVFJcXBwSzlxOGpkS1BJZnl3TjZ5bTAvTGhqVUdZNEhHNEZy?=
 =?utf-8?B?cVQxY0NaSWZUMkRFWWpMYU1uK3krandKSWZuTVE2Y2IrWHRWaXJFaFQ3VFFJ?=
 =?utf-8?B?T2FUb3RWa2FZTW1DOEhPNjk4K21CdWJPYVRmSm9FVlhTNHpsc0RVQ3EwMnFG?=
 =?utf-8?B?enFseCtrV0dGVzN3R1c1bU4wemdUTGQvd1BzY3NJNWtLdjVpYlVkL1RHWUNv?=
 =?utf-8?B?Wk5BRnE5Y3I2dFFZdjdIZTlUQ1JITUZqODMrWWxISHVzdmJmUDBuNVRCMkI0?=
 =?utf-8?B?bXlqQytMN3FzUUxsZ05QbXdCRHB5TFkzcmY3K3NMbHlZU3Q4U3IrMjN4NW9F?=
 =?utf-8?B?OWhBRy9zSHYzS0srejlvTlV1TGx5aXdHaTYzZnRhTFdFNDR2Wno3SmtYTnY0?=
 =?utf-8?B?cy9xS3F4eW1Qb25pNEh2OWNlQ0pkb2dEWVo1RFBBVWZxYXkvdDlBbVlSY01p?=
 =?utf-8?B?S3NYVjFTeUsxNm1TeTVwbmo3Mmttd1hxdG91RVFWRENtSlBkWkxENngzVlBx?=
 =?utf-8?B?cXJqbUdBaUJuc3JjRzRscjdtYzhIWU5XYlB3M3NpT2lvOVFiTHFjVSt5STB3?=
 =?utf-8?B?dW5HNWtEWnBDbkg4N0NMN2U2dFNQM3JwTEswK0hKMnI5SDRxZ1ZVRXZVcVBV?=
 =?utf-8?B?STNZTFlpblNMblJhcXVRUWVyNEJUNWJwMW1sRnRFVjdJV2t1Q1JuM25Eell6?=
 =?utf-8?B?RmFwNW1Lcnhsb0JzNmxSbngwczM3VmF2SUh6ME1ndmp4ZGtXeEttM0FEb0hI?=
 =?utf-8?B?dnpBR2VGb0Q3Y21YVVlIbFlUN0txNVNEcmNOamVUdmxBU0gwWlQ5VEsxYnI4?=
 =?utf-8?B?ckE3UGFMSnZpbjcwc2Z0NjIwWlFkSGNIRERnS1pleGJJenRhdklXSEFKbXZZ?=
 =?utf-8?B?REdBNjliMmVmaE16OGsyR3hrNzNnUFN4UWtlQUdrd1BraG40MzJxYnRzT2dC?=
 =?utf-8?B?T3JmUXNPUzcwcnkxV1V5VG5tNll6cnN5VzM3a1RnZVd3cnc4OHVYUWNmbTd2?=
 =?utf-8?B?cXl6NlYvZXN4ZGZORmVHYUZqZzVtdHJwa2d6dGJjSWJXakh2YWlsZjV3YkJK?=
 =?utf-8?B?alVXZ1U4LzRDTVJodEtabVJPYXNvcFFnMkZZTEhJQytHd1g2ajVLQmMvK25r?=
 =?utf-8?B?TXQyMGNEQUQzQ1pNVVc3aStkTXJ2MGN6cEhSZEFvS0J1dGd5dHF4NVV5bGhj?=
 =?utf-8?B?WGdSQXY0bnlZWUF4eGp6TGFYUUhTUG0wa2JzTWRGRVVZMzRwRWplVVZtMldK?=
 =?utf-8?B?WFZEQThtVkNyV2JCUzNYNFNTZmpxblFOVGJKdSt1Z3lhOGhKaDdjcVRxL2dF?=
 =?utf-8?B?YWR5QjIzcDRUYkM4WFZRSXJ0WXErWEpCV2M0Z3dRejlyWmEyOVU2RDlCTnFj?=
 =?utf-8?B?cTdicHpZWjRyd3JDK1llUXJWSjQ2SXZCRy94QWZxMlNTdWIwZm8raVBydXdy?=
 =?utf-8?B?WWp1YSt0SmZpWXFzd2loYlRkbFlkWFpsUGh6ZVlrdlJqUFY1a2hZVEZNQUFN?=
 =?utf-8?B?N01ZczJQOGgzaEJqTXZ4RENxQlJFdnh1N2ZlY3FMR0Mxb0ttN0JHeGVFSm1n?=
 =?utf-8?B?WC9PVkhQMVkwekoxa1FOTEFEeTd1RmFBTXhYbjlacUcrYVR5YjZHUW5seFJz?=
 =?utf-8?Q?yk2X7U6sYqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1TS3RDcmR4YXhOc0lwOTNHVkFQUThoSFNtZDJ4ZEVVamRhZUdiQkd5MEs3?=
 =?utf-8?B?enVzS3l1VEdObUNKR3ltWkhvU0Y4Z2M1U2NvQ2VJV0VoRVdvMzcvZnVmc2dV?=
 =?utf-8?B?YTJCZ1NrOFJjL2FLOTNVcFVvTHRFenM3Y254a3JEaFlVU1grM0tsNEJnVE5n?=
 =?utf-8?B?V3VSNWQ4U3Z6UDdWNGgzbmlGcUczTytqNmk1ekFtTjc4YnFMNll2OVh2WlNC?=
 =?utf-8?B?Tk8xS2oyNlI0b3g2K3YzVGsvSU5XcldJT0Y5M203UEtBTjlwS2ppREZTSWxH?=
 =?utf-8?B?RENOZzgvYVRXZFFSa0IvblpLd2lvSXF5RUxXMGhFM1NtcFZ6djRLdkk1ZGY3?=
 =?utf-8?B?WHpmaGhqOW0xaVJLeks0bDc1azB6VGcwakdOVktBRTc0eWRkRnJlMGpydmJC?=
 =?utf-8?B?K09ZcUlTTGJNeW1Na0dtN1RxejNQT2hJZzFTTEl3aDJ3WGZqOGZ3TEF2VlhY?=
 =?utf-8?B?TXIxZ2lLQ0NvK0JZTUhXTTIwaC9wU0pLV09jTmRQVWZvU0JYWEZQb2JlVWdG?=
 =?utf-8?B?TXk0NThrY1NIMW5LTEUyTEsyV1VsUHhFK1E2cVZ5U2UvMERXOHVtbjNIVHdT?=
 =?utf-8?B?cGdUbG14YjlqcnF4UEhlV3UwdmNmWUdNY3kvSTdPQk43dXV5WnZTVEhvZ1lx?=
 =?utf-8?B?Tm9IS2FJeVFaQm0vY0loTnM1ajZKbDF6S1ZaSksrbnc5dGZId1ViV1hURStJ?=
 =?utf-8?B?UExqZ1RQeEQ5SlZZNEJQalR2a3Y3d1c1ZThFa2tQcXBvamNhVWdkUUEvYjFz?=
 =?utf-8?B?bm5SU3ZQMXFrTHBRRmJXVi9RZmJoV09lTlhBRWFZZUxEUDNiOHhUOUhmVHlQ?=
 =?utf-8?B?N3YwZS91VDFLU1V4QlIzU1krVC9PZm1RYlMzN0Yva3VRZk5WUS9VR0tNbmkv?=
 =?utf-8?B?WUFHVk9VWDFBUTlmTVBDQ2N4dENIYzBXM3A4cGthZytZd2RBaEVRdzM3R25w?=
 =?utf-8?B?UVVxdzZNeGJXYy9xTFRZTXFkRlFNS0NoSG5pU1ord0pOaXkzaU8za3Vlc0pY?=
 =?utf-8?B?OW5rS3dvb09qczAxMXJrNjZnaFJIaXNKQUpxUHJUZ1V0SFdZa0J6L0srKzUv?=
 =?utf-8?B?QWlEL2dPSzNCYmRCcitnYTg0dmoxcXZ4WEhwbU9zS0k0cjBsWElERnVnQ3RH?=
 =?utf-8?B?L3RQQnJaTGtxbnRzTWp1RUsxRGVpdjBZSUZDL2wrTk12b091VEdOMmZ3UlJG?=
 =?utf-8?B?TWZWQU4zc1pLcXUwb3Y1bjRpWFFmcG5UVmd5MXR6b3JSb0ZEdXRTcHZnbWdk?=
 =?utf-8?B?MVdnWjUzaFA5Q3Q0U3F6cG85YTRXajduL1JsemwyWVY2eko2TkhLN2lyd0py?=
 =?utf-8?B?Z2RRWEFCMHdvZDZEcWZ0VVNJNjBKbWtTRmFCblVXRlNRbm4vdTI5Q3U3SkQr?=
 =?utf-8?B?WWYvYUc1ZEtBMUpZb01tYWpVZURhMEVqdGpNbmJKMmJZNk44VGxLOVpQWGVW?=
 =?utf-8?B?WTI5Y08rTnVlL2NyRmFuSHJWVFdMTWhnRUtDNXdWcHY1OHZEUUxPSWdpSFp0?=
 =?utf-8?B?TzIxc3JtQlUvSXdiV2tzMnpWRWo0VkIzWnlPRWYxSHZDemYvWk1GRG5jTGRz?=
 =?utf-8?B?bGttbW1KQ3Z2KzZhS1d4aTBqM3pnWjRoOUdKVDVJS3V1alNLckt6OUpjQ3Jv?=
 =?utf-8?B?cHVNUGRxeUI1WVA1dklTaFRhanZrdCt0VnplWFpMRUVWM3VSZzRlVGd4ZEFn?=
 =?utf-8?B?SEh5cW9sLzFJUzFyc1NhWmNDclF1L3gxeWlGWFU1Nk1TWkVNVWVNaU43ZDJ3?=
 =?utf-8?B?QllIeW5CcWpNRVZJb3c3dGx3ekxCQmJQV2lTKzVjNjJzTWtLb3JVOUc3Yjkr?=
 =?utf-8?B?SHJjUWZ5aGkxaUpLay8wQWFRQlZtNGtEVDlZejRXU3p6S2dGcHoxMlQ1blF1?=
 =?utf-8?B?ekZOY2tlc2lsQS9HOFNranBWaFpJZ3VwR3BheUowZDkvc3hINDNHbWJ5SHYw?=
 =?utf-8?B?VWQ4cytZa09td09NTGRMS2pPRkhKUkRFWUgxQys3NzFMVmFsV242L09pUURL?=
 =?utf-8?B?K1dxZ0NYa1RLV3l4bC9DOFFYR3Q3UzJ4MGxVMlcrOXdLR05aUkhFSFJ4OVBC?=
 =?utf-8?B?L290OW5tamJlZXAzUitUdVBFOHZoYytIWEMwSkFSZTl4eGxRQVp3V3V2RktK?=
 =?utf-8?B?NncwenAzT1BIUlpuZm1qdmt4UHhOSU1KNEdmcVQ5Q1ErYXMvYVFHbHlBUDRW?=
 =?utf-8?Q?RJup7GkQYyeFs7qhZYMyvY2nEFZTR65+PWT5UCQUeuxs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f66299-1d26-4a56-7aac-08ddbded3f7d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:01:22.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qkNa6MvdbAVa+nzDvdQc2VCg7sIbhcK9s4Z/4fDJAFdBmMadvjfJVySAQY2sgowWyM/MrlMLXwzKQvKYlNEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

Hi Alistair,

On Tue Jul 8, 2025 at 3:04 PM JST, Alistair Popple wrote:
> Add bindings to allow setting the DMA masks for both a generic device
> and a PCI device.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  rust/kernel/device.rs | 25 +++++++++++++++++++++++++
>  rust/kernel/pci.rs    | 23 +++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index dea06b79ecb5..77a1293a1c82 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -10,6 +10,7 @@
>      types::{ARef, Opaque},
>  };
>  use core::{fmt, marker::PhantomData, ptr};
> +use kernel::prelude::*;
> =20
>  #[cfg(CONFIG_PRINTK)]
>  use crate::c_str;
> @@ -67,6 +68,30 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
>          self.0.get()
>      }
> =20
> +    /// Sets the DMA mask for the device.
> +    pub fn dma_set_mask(&self, mask: u64) -> Result {
> +        // SAFETY: By the type invariant of `device::Device`, `self.as_r=
ef().as_raw()` is valid.
> +        let ret =3D unsafe { bindings::dma_set_mask(&(*self.as_raw()) as=
 *const _ as *mut _, mask) };
> +        if ret !=3D 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }

I think you want to use `kernel::error::to_result()` here?

> +    }
> +
> +    /// Sets the coherent DMA mask for the device.
> +    pub fn dma_set_coherent_mask(&self, mask: u64) -> Result {
> +        // SAFETY: By the type invariant of `device::Device`, `self.as_r=
ef().as_raw()` is valid.
> +        let ret =3D unsafe {
> +            bindings::dma_set_coherent_mask(&(*self.as_raw()) as *const =
_ as *mut _, mask)
> +        };
> +        if ret !=3D 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }

And here as well.

> +    }
> +
>      /// Returns a reference to the parent device, if any.
>      #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
>      pub(crate) fn parent(&self) -> Option<&Self> {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 8435f8132e38..7f640ba8f19c 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -369,6 +369,17 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>      }
>  }
> =20
> +impl<'a, Ctx: device::DeviceContext> From<&'a kernel::pci::Device<Ctx>>
> +    for &'a device::Device<Ctx>
> +{
> +    fn from(pdev: &kernel::pci::Device<Ctx>) -> &device::Device<Ctx> {
> +        // SAFETY: The returned reference has the same lifetime as the
> +        // pci::Device which holds a reference on the underlying device
> +        // pointer.
> +        unsafe { device::Device::as_ref(&(*pdev.as_raw()).dev as *const =
_ as *mut _) }
> +    }
> +}

IIUC pci::Device has an `AsRef<device::Device>` implementation, why not
use that in the code below?

> +
>  impl Device {
>      /// Returns the PCI vendor ID.
>      pub fn vendor_id(&self) -> u16 {
> @@ -393,6 +404,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindi=
ngs::resource_size_t> {
>          // - by its type invariant `self.as_raw` is always a valid point=
er to a `struct pci_dev`.
>          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_in=
to()?) })
>      }
> +
> +    /// Set the DMA mask for PCI device.
> +    pub fn dma_set_mask(&self, mask: u64) -> Result {
> +        let dev: &device::Device =3D self.into();
> +        dev.dma_set_mask(mask)

Yup, I have tried and `self.as_ref().dma_set_mask(mask)` works just
fine, so I don't think we need the `From` implementation above.

