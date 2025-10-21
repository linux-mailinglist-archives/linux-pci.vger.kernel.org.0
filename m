Return-Path: <linux-pci+bounces-38903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC19BF6F96
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC611888163
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53517338F35;
	Tue, 21 Oct 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pddQ44g4"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B7337BBD;
	Tue, 21 Oct 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055657; cv=fail; b=cxqXICMk//evQbtEUijlG81q0jKgMFMAEHXXyCG4qo02AzBY5DCKJUgf/KSIAOjPfdGCtkxL6vDPivxYxWXHLo29NqUvLRMsriMRq870w0MvjYFOM+J/smI9unVWHp+isvuRO+YF59WQOKCdX/PBFxw3vDwiU/f15SqNxkb8KXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055657; c=relaxed/simple;
	bh=j0eFtWRtE+auAClu3MjS0/IrXottYVM3AwSfoWOx94Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MAcGldkcRK6F0obrK8v6NQl5IulE+bSxWLaBr8kBjLz3dRUfy6Y2kn18xSBc8JGOKjaF82ZjRQd/5AnZGV0kINQAmFiFhcmepMdmWWwPpGiVOvQfx0SCtLfV6VZC3xw0v3lHC4PUuqogRwzoOeV7TJUquBXuT9OHmHf1GSshrxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pddQ44g4; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdFhyJEIyW6EP1b0b5ejMtewPFKWTJ0rLc5MgB9pZdRqYGj0hbAtkh/JrFPbfmBggaK3DAQUvaYmzYdsCPXLroKR8ZL3aVGOnf2AdyIv5ryiEX+WMg027Fxh1914/bYu0oejZhFmLhIg6GPTqGYpWNyV4dqGk8bbxvWSdzW7CujVenTyKPgJSsnqwrtp8Yb+mvlvBRw+V6v/3xsfiTlYT11g85QOcvla6+oIrxGIoMrIRq6odWRhspqTjS75sXc1qOG7Dhqu3OasVmbdhzO8Vtww2T4e1QeN6GFa6DVNCzBZoYNb/NiJc7iM5ltDxHwiZBBGVE3Eyyes2s+sbkf+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91fTjfPlEEUs/0C4n3AtQs1NwcsHglytmXddVv9IDnc=;
 b=I1Tn+3O60b4/TZnoGqBcU9td0548cvXdRfE96GnYGWzHap+wbGTXy1OY3RgZzn0E1DAsWt5uCN5OJGLGRH0klPS2TG7Tad7ONs13zcYOL6FxKdHNtgb6rkeYEYvX5z2P9ziWA94SjSsGkbuHOvxAz/HnE212XnP+oSoX6kRtbps21Mn3mwGn0WBZ5Qp9TtVOR4sUE9WI/0OK+BORzgtUzZRzufszNF1d/g7NqbyiCpCUkUVWiQYL9K/3E/qsr98KnWFATOV8EhmIWNj2FwxwIPY5TBhOeo1XKGwnKJ26v21QY7qe6PsRkvXSfdadQ0NaCKr27pDo6xEIO/EORKZ9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91fTjfPlEEUs/0C4n3AtQs1NwcsHglytmXddVv9IDnc=;
 b=pddQ44g4AfLssOUTcumNlvxzWfXoIJWikrfyGXuJaXvMCvZB+tDI0sh8+rEl097Yqk7I1j6CswgvboUxSrjkIIQxFS4aoZgkqNAYOtqzsIiaXyVUeNUgy/KJffjX1DDVxzssKz2Rqk+xBWHi6cUpt6U0qmJkNMqooFyysePKlAWBF/X3yW//0CvuYCaTrgAkeygXyGjeMse47AspxZx5fkRP0BQQtp8UtTPDl4st3MwARWX7WDRblzqSyIOToymRqQNvptAfeNvqAgRJMiZXLfDQc9wGnbNa+LzAi+/kzv3JHE8OX4OlctsUBz4vvA2TZz/3/j3dwK1Zm5ecIdNb5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 14:07:32 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%4]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 14:07:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 23:07:27 +0900
Message-Id: <DDO24JQ1I3ER.1GOOI7RQISUS@nvidia.com>
Cc: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <zhiwang@kernel.org>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: Re: [PATCH v2 0/5] rust: pci: add config space read/write support,
 take 1
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251016210250.15932-1-zhiw@nvidia.com>
In-Reply-To: <20251016210250.15932-1-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::12) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b5b747-4b43-4d05-1ec3-08de10ab2d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXNjT2RBQUd1TXh1LzJCaUpGNDNWZGI3SWZQU1VHVWJGOEM1U1VjdCtzeXNE?=
 =?utf-8?B?VSt3NjRsWUptRzRrd1BMeHliRUJVTERTRW1Zc2hLRlcvNE1hQ3VXTWtmdC9G?=
 =?utf-8?B?aTdkS092RGdJNUdDemdjYzZITWFTSzlLZ1M0S28rSlhLWFQwS2lncW80V1hQ?=
 =?utf-8?B?elE4dWlCS3g5bXYxUy9pSUw4RW1IMVZFbENZVHlJSGRhZzN3TzUyb2NaVjZi?=
 =?utf-8?B?WVR0Mjl3T093cU1Kdzhhd0IyVS9DaHh0VTlYSzlYdE5obDhlc2duMzhMQUtO?=
 =?utf-8?B?UXpjUlU0WDMyOGxmOVVsM2Jsd2d0UTlUcWpZMUppNWcrb2tFRWNmcDJzMGQw?=
 =?utf-8?B?UXc2cHdwVnFkUG0zc0NIZXhnVkJVVlNZWFFsc1BCR0Q3b3BLTVlLazd1NThr?=
 =?utf-8?B?dS9yUloycDdpcnVSSGlxUXgySzMwdjRvUWFiVU5kL2tESGVNRDdoeVk5Z0Jq?=
 =?utf-8?B?NHVNQ1ZZK1RGYURWK3Znem5PRmYyeUIzbFV2VVk4MWh2Y0MyRWFwdCtzdEpa?=
 =?utf-8?B?RWlmeDc1bGRIdDNNalBDYzNMbk1JaHJSNXhueWJlLzcxNUQwTDdqb0ZueVU0?=
 =?utf-8?B?VmdDRkVlalVyOVQ2T2FuRnRDY0FsdytzL1pNN3pnYzFudHpsM0RNRjlhOWw1?=
 =?utf-8?B?MUdyZ2N3cHhDYnhJSk5YL0tQUitGSzRFcWdydyt2MDlKWmNLUzh5YTczQWV4?=
 =?utf-8?B?anNPTDYvTW5FWlFvZkUvTGlqZkV1cmVIZ0t1dWpNcUQrRUw2S3JzbWNwZENB?=
 =?utf-8?B?N2E5anlnbGIzSXU1NkdwMmo3OFdiaEQxRGN3NDNIZUlNQzQrczJMaFNtZW9x?=
 =?utf-8?B?bW1SVjdhdlVKQ2NYSVpyekxLVXpyYjF2REpHdGFsb3psTG0zQVA5RitDSDlQ?=
 =?utf-8?B?Mi9XUCt6dmQ4UXpYeDJ4UXYvTnB6cmw2djIxalplNmlIMmFXREdQVXk3WCtR?=
 =?utf-8?B?bFk4YVA5UEJFa1VUait0Mkp5dythZzErSmY0aUNDTHNUSDVrTk0vU3h6QUxy?=
 =?utf-8?B?NG1hLzVNMm1TdHJub0NYQk1ZTW9FTko5ZWV0TjBkNkhyTC9QMm9jYjJyb3lm?=
 =?utf-8?B?Q29pVWxHemJ3amFsK25QTC96cGExOWNFbGk0MHRrWXhSZDlrcXE3RDg3YytM?=
 =?utf-8?B?UCs4bTd2ZWQyb1B4SEtxR240QXZJcjVTSGphWVlFOXRmNzVLTlhONHE3ckJk?=
 =?utf-8?B?Z0lFa1lSOHF6dGNMbEZsR1NKcGx1RERKRXNoa29sZTczS1RnNkhDZjl5S3BP?=
 =?utf-8?B?ZXFOc29DNEdsNnZrWUVLaG00WUpiQURLN1VXTDUyOG41ZUltUkJEU2Vmbkoz?=
 =?utf-8?B?RFB5cmxJZTJXenZFK0ZoeTI4NE1ZaDM0clBlaVA3cmpiMzUwU1pjK3lIZi9N?=
 =?utf-8?B?anFVM0x0MlAySHJ5d3hYN1VZTzhNMGRmM2dQNTIzbjZQbUdscHpZWkZPRDBN?=
 =?utf-8?B?RS9QRENWWk1mUzRlZU0yVVVRT2RtaFBXL2loOW40M2crVy9KeEh0WkNzeUlR?=
 =?utf-8?B?WWdJYVA4NkpiaDUwRTd0cml4MktFVERGN1Y0L3VvcmF2aEZuMWtJbFVlaThJ?=
 =?utf-8?B?dzhFQmV4VHhHaGdlanVYY0lydDM2VE5yYjhUK3ltcDh6ZWVlYWNySGtzc0kx?=
 =?utf-8?B?RVJEa3J2MVgxQjByVHBrK1dVcDJIUFZDTk84UVM4ZU8yN2x4SjRLN3JYb1dY?=
 =?utf-8?B?STQybkQrNTZxMy9wZUY0Z0JSemI4Z1h0bVZ3S0psdU5oWTJvMHcxZlEwMDRG?=
 =?utf-8?B?aXZYK0ZYUm9QRFRzRloyYmd4NHRGUEdlbHNIR1pIdjF3SFNOQlU1YVFMOC9v?=
 =?utf-8?B?cmZ6QTlnbThBM0VMTDJud2RlS3RTOEFzRnVpMFZaemwzZmNUN0FROW5QVnZI?=
 =?utf-8?B?MHpUOTVkOXpkenk0VHdoR2Exd1NoVFZRMzVveG5BeGYzTlNBYnMwYnUwZXdX?=
 =?utf-8?Q?/bu0oRg5gguiGDpgCSxAEAxFtt1J53gb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0djUHliUjdZcGxySWxrdWNlSVdJSVc3U2UzRmdVNWt4MzdkblFtQi8yT0M4?=
 =?utf-8?B?YkhVLzB5b013MGhIc2ZZRWZodmxERnRTWm9maUlCNjIvMGYvOGFlYi9TOEZN?=
 =?utf-8?B?RzVVOTBBSGJHRXpxQ05TU2h5eEpuNVVxUDljQ2VFaStCekRpQllZRGNYUlh4?=
 =?utf-8?B?d25ROHZTU05pOWs5YmhtbUlCdUdkUGtLRVhsNjJPK0hwNkMrbSszMjFqbnY3?=
 =?utf-8?B?TVl1WUJlYU9NZmpES2E4bVpSQVNUcUJwTjZjYWhnYnRwbzBLYnNuczJBSThI?=
 =?utf-8?B?ZlNBZGtwRmorc2FQSXpoQXI0Z2NQb0h5cnoyQ3pzZjBRMmJ1bThONUFiZ3B2?=
 =?utf-8?B?RGIxZ05CY1ppOVJxODEvODhrL09LcDd2THNJcEk5WjNSSkdkWjVobWVGbmF3?=
 =?utf-8?B?TVg1djRzQ0gwNkFSTFp1N1pYZGQzeHI3S250bW9Mb0lRWEd1aG9oSWg0TTJv?=
 =?utf-8?B?eVdMcmhkTWtOMEs4R2pGdDE2MlVQWE05VjJSMG9IVXV3WHdXeUdaNVJrRmhW?=
 =?utf-8?B?QkZCVStlVWZPd0tjMm1yK1g2dkFuSFlYTUgxN0lad2htaG9FSzBNNEdJcndF?=
 =?utf-8?B?Ly9aNkZQekdSZTBxNkw0YjF1SnJoNERDeUM4OHJnMkZGbHkybnVqRU9NdkJO?=
 =?utf-8?B?blB2anMwQlg1Q3N6ZXl3Nmd3aVdXOXNuNW91bmEyKzlIQXFOQXB0aXpYMzVH?=
 =?utf-8?B?VDllTjdUYlpET1VhZ2tta2xpYkpBdlh4SWhiNjFKWDBvcXJ2Vkt6NnlRNzIy?=
 =?utf-8?B?NUhMdzJmTTFWZEF0bDJ3cW5VUXo0cGdZbi9nbnN6ZldkSXU1cHpmd3RCalJ6?=
 =?utf-8?B?S3Uwc3VuTFVCMTVvWW42cE42UDVUQzc3SzRabUEzbEJIVGJBd0p5ZXJtTGY5?=
 =?utf-8?B?WjVCNFI0VlZGeVVadURHVHFpZmVMMDVmNGlDdWRRNUJZQStETzM4cm1vbCtk?=
 =?utf-8?B?ZUNBL2FzRWgwYnp5c1l6WXJ4WjJNWEdJU1lrc005WWRUNktHS1hEaStia245?=
 =?utf-8?B?bnN5TXJaOFJYdUNwaWEwVE9QRzVtNWRUTVFqWTIxd3B1Nk5qcllrQWJwUm5t?=
 =?utf-8?B?bWVJeG16bDNRbEMzUzBhcW05ZDRhYnd6QXRkZlZPSE9JWnVmUnQ2MVpCR1d0?=
 =?utf-8?B?U1duVHBaS0g3VzZFTlNwYkNEaHN2UDNwOVQvRDEwMm42YzRLS1ZkdWpveWwr?=
 =?utf-8?B?RzU2YmhocnBpWDVXRmlXQWlpdTdhM0dnUE9VRVVpRUVNaVRqWEdPNm9acGhU?=
 =?utf-8?B?a29UVEZ3Vk0vRTlYUnNWK1BOSVhyR0t4Y3VsTENVNXQvcVlHb2RkU01MVlpy?=
 =?utf-8?B?Sk02SFhCTXRLTnZyKy80bVArYzdON0pwRUdLMDEyZmdGTG85eXYra1FleWR1?=
 =?utf-8?B?c0Qxa24xS2U0V1FmaHI3eGEwR1N6RXVnWHJnVzhRL210eEN4WmxrdHphaHN5?=
 =?utf-8?B?NXNTa2JKc2NQRjBJazE0UzZwSkhGcVJUeTNRZkhOb0UrdXpWVnR2OWhxTnN0?=
 =?utf-8?B?OHdmQ3BPYk04U1NZb09LYVoxdmlzbTZlNWlxbEZXc2RHWHVjdm5HSEJmUERF?=
 =?utf-8?B?ZUgvOEZZNXVIQ2NPQmJ5akx2NkEwNVlWYTNCeVBlVFg1VWdLeFBMbUlRRnZ3?=
 =?utf-8?B?dGxjY0NxYVpla015OHlueFZZaWdZc2MxdVV1RkxZVUhGamJwWHFhaGNQOW9O?=
 =?utf-8?B?RFpNMjRpZVB4eFY4WmlIYjZyMUx1K1VqcEUwMGthTnNFYVlhMHJIYXVCZHVv?=
 =?utf-8?B?Y0s3aWxMK09vRTVhYlZhV1h0Nk5ReGF5bG1jbU9ERWp0VW0raktwOWcrYTU2?=
 =?utf-8?B?anZLZGNaTGUzdVhGMllrZ0xSVUFvb0JDaTVaZ3NTYnV3ejJXNnIzZW03L3lT?=
 =?utf-8?B?eHF4MGxlUGlJTTFjWW82b1JDNk9rYkU5L3pJcDhlV2FxRFFmaGdaTTdLT0pt?=
 =?utf-8?B?V2Z1WXFjWEVtVGxSVEwxYmk3Wkg4a1dGTVhOeFZkOFlSVTVuYWtQcEpzNS8z?=
 =?utf-8?B?RnNydGZ2NlpCV0pPeHRXZjlpVTJoVUJNTUVzRkhlRnI0RDlvdzlYV2dqckR2?=
 =?utf-8?B?Q1owVTBkS09nQjBYWEdVZGxkRnZwbFcwdFg4TFRrMFFXMU1FN1IzVis3cG01?=
 =?utf-8?B?bkp4OHNSc2ZDTVplOFZQQWNrMm5xb1ZhdFV0bXM3Z1l2Yk5JSG1YcnEzM3Vo?=
 =?utf-8?Q?e4xaWPoMbWkW4LZKqyWqciIv5W95eeLATdbKSSwEx4p8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b5b747-4b43-4d05-1ec3-08de10ab2d03
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:07:32.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkVkAN74qdvH+r145RzM8uEzG3QfhaWj3fxze2VRHB6P1PFn+FPpHj/teNUNa+CvsCuF+IjuG/rKPaDyt4i6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642

On Fri Oct 17, 2025 at 6:02 AM JST, Zhi Wang wrote:
> In the NVIDIA vGPU RFC [1], the PCI configuration space access is
> required in nova-core for preparing gspVFInfo when vGPU support is
> enabled. This series is the following up of the discussion with Danilo
> for how to introduce support of PCI configuration space access in Rust
> PCI abstrations. Bascially, we are thinking of introducing another
> backend for PCI configuration space access similar with Kernel::Io.
>
> This ideas of this series are:
>
> - Factor out a common trait 'Io' for other accessors to share the
>   same compiling/runtime check like before.
>
> - Factor the MMIO read/write macros from the define_read! and
>   define_write! macros. Thus, define_{read, write}! can be used in other
>   backend.
>
> - Add a helper to query configuration space size. This is mostly for
>   runtime check.
>
> - Implement the PCI configuration space access backend in PCI
>   abstractions.
>
> v2:
>
> - Factor out common trait as 'Io' and keep the rest routines in original
>   'Io' as 'Mmio'. (Danilo)
>
> - Rename 'IoRaw' to 'MmioRaw'. Update the bus MMIO implemention to use
>   'MmioRaw'.
>
> - Intorduce pci::Device<Bound>::config_space(). (Danilo)
>
> - Implement both infallible and fallible read/write routines, the device
>   driver devicdes which version should be used.
>
> Moving forward:
>
> - Define and use register! macros.
> - Introduce { cap, ecap } search and read.
>
> RFC v1:
> https://lore.kernel.org/all/20251010080330.183559-1-zhiw@nvidia.com/

One small nit: the title of this series=20

    [PATCH v2 0/5] rust: pci: add config space read/write support, take 1

Is a tad confusing. How can this be take 1, if this is a v2? Also there
is no v1, the previous revision was a RFC.

Technically this should have been [PATCH 0/5] or [PATCH v1 0/5]. `b4` is
great to avoid this kind of problems, and a huge time saver generally
speaking. Can't recommend it enough.

