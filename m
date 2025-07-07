Return-Path: <linux-pci+bounces-31602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2ECAFAD82
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B591F17D274
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0C0191499;
	Mon,  7 Jul 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YZ0OiInd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0661E4AE;
	Mon,  7 Jul 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874379; cv=fail; b=rHrYbFGpsqH2hRGYkLU7glL5Y6LPFNjONMaMP1P/xiIGxBfMVH+99okBxtWB71h3rn+dm/gvqNPMxNFyUjAoKGUhuynuZSHC3MGak5ssRAfy1XfsQZyuONPZ9dfDmbB7TuIyXcjumjZ6tnwh31ofE3P2S3BD3OaGy5mCITm+3AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874379; c=relaxed/simple;
	bh=DyvP1qEFQXof9tHqeO+FNqLGmaAZOm6XuRYccn/OTP4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=p6uaIzhdixpbXT5KN94b6uISuwPZzhLac507YklPgNc+WgEfBXECPGH6D9f/hHRT/fp+mQ4yso9wvpmiWi1aV72YtpXgwiXPQ3IQpMqtP448AMEVFiBo7p9DgV4szmnYjiLXMssWS8vkLaL2Qk9rwhN5rTw6Q0+myz1eMYeKdNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YZ0OiInd; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CczI2loRiH0ppYIh4ZJADrzsI24CoN89LNBpMt7nNDGFSYNJReVublMMs60sFYHu/Mw0lgaku8sT441KAQULJfb1e+SM+0rolC15XwXU7xUBmyWFh3jcDeihdufUbiMEoEeq8JoNlNtxGnWgkGMLwKgV9jDMZ3HOFZEMxxtVoiiA/nsZt99ju4+cBGBQl9GoqmjSQi4NTcyHC2Uvq/750y3SYCqEKCJ+/Ou2O7yOx19woSbFrPQ29Xrek3ZJzUfsYJ7ESMEfy/1elTyWR+XWD6TlfgwQwhqcHyON/o/yIYL713c4qVVoAAvMLapbuwsPxvxvdTXGl3k1/AY0r+damQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJj/Rwz+axk+GYPIFtEkf8SLbuiS+bs+Mh2qdks5Mnc=;
 b=VyxmiF4owGg1W7/iLygj1N3bTiTn2duc315J5FLSgwEsmHDSFudheGAowLHcpIAGZ4jqzgLKWEfos41TQKtMgez/zrtASmhw1MTiDO96NI6Ym9CZgLD1/D4ChZqABpwELJgi4sFF6GFWyUTVFz9YlEMzscj3p+KshhStFXzP0/M8tw0efqtYmj9f9uN+NX1k4C6m5rOOuuy9wyNwiQAD5m4AIICH1L14y6e9QYwJ6cnOWtHqk7si7WITF+ilM9tZ+8GcHKtZ3pdljDnrFYsv9FQzLo11fQeJ5YlTkMnQH4H4SZpMrkpTmD1+wgCC7onTRbgiGasMmcX1GBUURgf/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJj/Rwz+axk+GYPIFtEkf8SLbuiS+bs+Mh2qdks5Mnc=;
 b=YZ0OiIndx4vMWHGxw5U36peu60o4I09FyaVs13e4OweVj6W0lAbMzUoOBDv6wegeWJZw2tCei2M7ahc4IaZgRLSVrQM6wpXBM0iVMgWimcAxZTWT9zOLL1FfalwuExE+pnKHQ+/f0U2JVeSGmqH8dqKGC356fPjtbPNUGCZtJYTtdg+hjU6NDbEGapeldAIThm7BfItFt2s0WjvWR/zsfFabdskEauMq8saT910xj6h2UamSUf00z7WtknM7JPdYcwB2Fzsa3HdilRJq4Dbg5CDcNq3x1kKXTxCvgY59doVCqlBDfU3YekZE9AFuVcH0M5gpkbTPdmtpRdDpvLQO1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 07:46:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 07:46:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 16:46:09 +0900
Message-Id: <DB5NMUV07ECB.2PQN70X9OWVTQ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
In-Reply-To: <20250621195118.124245-3-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 914bc052-0a22-4bde-16fb-08ddbd2a581a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVY4ZE9HZVJrbHV3clRRN3dwNGdua0oxMEFvZmZSaS8vQlRVV3Bpc1d2OHdX?=
 =?utf-8?B?UHZLSU50Tmd2MkV4RUxMcG13aXQvWmtUc2t3WkNvOXVxeU91cGt4U01YS1ha?=
 =?utf-8?B?Nko3NjIzdFJWMXloZVpqMzVKMld5bGN3VnQrSDJWK2M3aVRMaG15ckFxTFhp?=
 =?utf-8?B?d0pDMzV2V0NqWHVTbXMxSW96MktHUkVMZ2tacVFiNGlBOUVCMHUrOVA4MTVa?=
 =?utf-8?B?RS8wOUdOMjRMY0toNGF0ZXBBZnpkNjhlOXIyMm9lZE81S2lnYXUrSzZNbjg2?=
 =?utf-8?B?Uis3NURvOEJobFpHU01RNm9ITUczRkxjUzFrZmtpT2pMSm1GRXZ0dVg4MUsv?=
 =?utf-8?B?aHphb3lxT3k5Nm9SZlJ4VzV6MkYveW85cmwwV3BmMzVkbk5DYjc3NTNFV3M2?=
 =?utf-8?B?R1NNT1RycTE2TXBLZVVRRVJOcExuaVB3R2g1U2dEWjhVM1JZV2RJa1g1Z3RL?=
 =?utf-8?B?YlVCelduWkdEK3ErM0ZaRXYzdmtPMDFQQnBqNUJBOUYrbjMrNFNocW1zMjNa?=
 =?utf-8?B?YjdnVk1idFNLVUlxd3FsU0d3ZG9lMkJqc3V3TjNnM2ZoZzdNQ1ltVHBJcTZV?=
 =?utf-8?B?SE5ablZCSkJyWGN0MnROWEJzRHpTS0pkWEVLblp0Rm9mZHByVCszMWRkVVFx?=
 =?utf-8?B?dXJkcmhJeHphL3M4Mktnc1dmVTRFaXpsb0Z3SHBuK0M1azVUenVlY3UrQ0Y1?=
 =?utf-8?B?TlVEaEZOZldCdDE1eVBhbzNrNmptYllDbjVNd1pBczZnS2crMzdyL0F4Q1lJ?=
 =?utf-8?B?Sllad096WGk4RCtRL1ovUnRTTDZMRG9Xb2phMG1OdkExNXpld2hBeXNMZjZ2?=
 =?utf-8?B?ODl1N1pTRDBydGZrbnVoanhnOTNpM1lFM3paanhwTHhJWnJYaG9Od3JiNnVk?=
 =?utf-8?B?T25zOHdsblBTeWhPUVdWSDNQdElGdlI2MTFSTjNaUWZrR3hOL0I0L2dRV0ZR?=
 =?utf-8?B?RjlPWVNLMTR1VjJvc0kxdG9OdFVacUJrYlNBbnRXdEtFdmh1V3BqUTZsZ3Vi?=
 =?utf-8?B?amJhVG5lMFBsbWdhTG53N3JUbzZ4RXovQkZXZis5aG5Jck5YY3dhVU1MS3VW?=
 =?utf-8?B?Zmtmc3VmTjRGUTU3MkpMMEkxbzIrRnFDdC9CYkMvSXd2dHVZVituVHg0YVRB?=
 =?utf-8?B?Vzd6NDRLQlliZmFPaHkzYUdiNjJKMkdRYXByRnJwTUZSVTZZTXRPeWhWa01X?=
 =?utf-8?B?bHFiV0JaK1VjMHhIYXhEVUJpc2p4NHYvcnRBMTdNeEpGa1d2QkVHVE16bmlQ?=
 =?utf-8?B?US8yeU1CWEttSmZrVndPOHlKZXBDQ1NVOE9BQ1JQS3M3aHNtSXFaMzNBTHcw?=
 =?utf-8?B?QTRoaGRrOWk5akxPQVNMUEN4bUJ2V1RMbFF1bHl6d1A1d3BMR3JxZlFLZTRQ?=
 =?utf-8?B?YVE0UjJvTzJUanVjSDkybHBkTkxlZyswelRxdDhLR2RwRzNnUTJ3d2Z2c2U2?=
 =?utf-8?B?aU1qbXYxQmNabENkYnVuNmJIYXFnUVNIZ01JTHhqK2pVdW1zcmNNbkhHcHNq?=
 =?utf-8?B?c1RsLy9TWG9UZmIwTjYzanhGQW42cUxvUUE1Nm1rNE1ucktNdGVHVWlSck9t?=
 =?utf-8?B?UUxPbWl5ODZlWEh4amd4bXk3U3dPOFJUZ0Fvam5nY05ETS9jL3E2OExWdWt2?=
 =?utf-8?B?VUVQYXYzMUZHVE1YS0Y5N0lrdUFXeUxqenFnOElNN3kyMGU0VXMrZEl2dy9E?=
 =?utf-8?B?dllUQnpPK21lRjlWM3JiYWpBYytFaDdqOXI1RUhLa0FDN05pYkhRdDRHWEl6?=
 =?utf-8?B?NkR5OEJwdE5uWVhOVnVTNHBjaURKZDNNc3h3dXlVWVV6cWxUcEs2UVZJSXNw?=
 =?utf-8?B?SkNPeDRTSTdyWTZXR0RLRkh2QlhNMkNxY0U5RVZDS2JEMlBxWUcyT0Y0Wng3?=
 =?utf-8?B?RWYvVyt6TjVqeU5BOXVHTnNMMVZxK1VqQzlmbXBDU2xSSnZ3SSs2VXgvOHJD?=
 =?utf-8?B?U2IvNmRTVU1TZmxBS3dDeVNjMEtocXBQY2ZrS3NiZUN3bmU0M25OT0dEZWJ5?=
 =?utf-8?B?dG5BWmdoUCtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGEyOWxMM0w3UGN6L014OGI0MUZVaFNLbU9CL2dIY1d3SGNuSVdGNWRtRkIy?=
 =?utf-8?B?WmRWWWxkaFBxUEw5UllhQ2swWlZtTSs2WFdpN3loUHhYdkNiYU93Uk9veU1o?=
 =?utf-8?B?M25PSDZiQ0NuQWh0aWY1WGdOc3NaK1pDYlRnOWREbVlkUHRjRUxwZlU5UXhL?=
 =?utf-8?B?ZjVKUkp6TTFMVEJBNGdwWVVOQ25qVWxQWjBZT2J1NzhGblhpeThLN1JJa2JF?=
 =?utf-8?B?K2lqL1kwM29ITEl1OTJ1dzlFeDhndHJObjFvRkdvK2pldDNWU0FZZU9pQ3l1?=
 =?utf-8?B?UkJYY3RUQ1dWMEtwM0dDQ21VcGVxT1EyNzNwTVNGM0FTZnhCZmFVV1RScGRP?=
 =?utf-8?B?eVFMMmxVM0VTVWE0MjZoWHV2N1FPV2haZWZtWElvVWRxaHQ3OVYwZFNpWVBy?=
 =?utf-8?B?Sm9qUHhDdDZCdmJhVDVDMWE5ZEZjTEJ4Q0tsWHlEWUVObTRONzk0a1ZMNDNR?=
 =?utf-8?B?SEpaSXBxOE5aaFJ1UWs5MkRwY01YaDk5aXZzQkVsQTl4am1aUDRSelNocndJ?=
 =?utf-8?B?cnJnQ2ZYanZLYVNMbW5BT2VHeXJTRXAxVVJ1VWZDVTE0YXJQUXVobnpzNzhz?=
 =?utf-8?B?TklwM2duZEZ4elBsNURLSEh0U0pjUERDWXBjNnBHV3F0ZzRRZDd3NGVBRjhQ?=
 =?utf-8?B?aTJ1L3Jlem4zaXIyejM5TEh6bmNReTdsTkw3N2h3ajFwSHVvM216N3lnblcy?=
 =?utf-8?B?RkQ2M0VTY3IvN01jbFdXc1RpL0VseU51VjR0SGJhQm1iZGFxVW1HeHh2M1R5?=
 =?utf-8?B?S2xZUTdUaStjU2M1TmxhQ1hsa0dsZ285VVlGRStxUU9RV2o4MnBwM3NzRGpD?=
 =?utf-8?B?OHBqLzdXQSsrRmlEdlVjK291MXp2TGFKY05aTmU3dnBuNi9YSmxScGdadE56?=
 =?utf-8?B?SHdNMkFzSXRpTmhKdXRsaEpNRHB0SVJkZWlkYWRqY3ZMQk9PL25JdzRUVlJz?=
 =?utf-8?B?U2I3THhiNWxyQXd3N09EakJiRXpFRmQvV1h0dE9XeVY3aHl1d3N6ZzVYWUw2?=
 =?utf-8?B?T08wWS9Fci9ySTZobTIrRWhJMFlQRGpKSEwveVI0U1Myd2JXU2VSZ2VWQW9B?=
 =?utf-8?B?M2RZZGg3SDFPSVJiTHVpVFRrTmRqUm9VbWErazdTUDh5QnVZK0lVbkJ3d1Ux?=
 =?utf-8?B?Y1ZITDNBWnhHTytqWEJhV21rMTdoa0d5YVY3VjZNY1J0dHJNTG9qOFloNGpp?=
 =?utf-8?B?eW05N1d5amxQcDdubFFvaml3SWdqYVBXSStyaVhRc24yWjFFRktLUWdUdlc3?=
 =?utf-8?B?UEUxTlVlbFVmZjZzNUNTdGlJRFV3WW1vT1F1NG92UGxXWm5lUnhGd3VWUFZ1?=
 =?utf-8?B?NTNmUEF2enVnc212cUE1UlFhd0NLcHBtMWhuZEhnSmxuMHFFSE1WaE1zOTBn?=
 =?utf-8?B?bTVGRXk4b1RhRityUG54M1dpdjZZZnhPQkNOeDdJVFBkRkFveHY1NzF1VDVu?=
 =?utf-8?B?ZW8rblMyS0E1dUlQU09penExdTN4MGdZQUNqWXlpNGRzWG5WQWIwT2I1SUZQ?=
 =?utf-8?B?NnFjcFQyTmMxeDZDZ1VyZld0M3kxbEE1dExXUmNDNDBOMWYzbUs4OVZwdktE?=
 =?utf-8?B?ak9xYWI5bVlZdUs1Y2N1TExpbDRXT3ZQWUwvdG4wS3lDVy9vYjlpb1VUQnFa?=
 =?utf-8?B?MUxjcVViN05vQXp1ZGpZNzFxTnMyMFAwYU00eGJnUHB1VUgreEpraUdIRTA3?=
 =?utf-8?B?SUFzd2dsamhlZDAwSlNneUNNVXhBMCsxYW9Gb0djdXM4ZjZmVFNWRmlrL2ZY?=
 =?utf-8?B?Mjg0S1BNRkxFUzZLWno5ZUhHMjZGSkxMZDAxaHlQR0o0VStGWVdHOHgwSWdO?=
 =?utf-8?B?TlV4UzdGNFRKSFgyb2d3MTFIRE5Jb052NXlwdWxzL2RaOVNEMmpyblNvaEs2?=
 =?utf-8?B?QmwwYmhHeGFmUzF5emNXL0c2Z3JwNVdlRGpZM254QzhwMUhrd1FBSW5aTTk0?=
 =?utf-8?B?OGUrdU52UkwyWEJpUWlIWjl6YitEOUx0NnFWMjUwQk9yOXB4aXBIaTliYlIr?=
 =?utf-8?B?ZEs5anIvc29BcXFlZFlVVGJ0Q1NNbitRaUpMNW1DM3I5TEpQeG44WlhrNS9Z?=
 =?utf-8?B?eVFDNTF5TWlZZVNEYmhSMnlTZHlvdXJEdStDWlRUQS9OUEdFYWpIMG11ZTlJ?=
 =?utf-8?B?RFVWOUZqUEN3aThxTkdFa0h1eXYyMGlnWG80TFlnR1ZjSDZqWDg3a0hXVnE4?=
 =?utf-8?Q?0k942jCtlMlr2Qtb3ZTXUBk+bjVDlzuSs/gwvPXUtCax?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914bc052-0a22-4bde-16fb-08ddbd2a581a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:46:14.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnolQ2xVl3866alUK1NpYFzFhlGtyvJ9mHiq1rAP1h04UmU/C5X+NZiyPw8gqAOH3qJxpbHsmg2lUr/ZgS9Ftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

On Sun Jun 22, 2025 at 4:43 AM JST, Danilo Krummrich wrote:
<snip>
> +impl Device<Internal> {
> +    /// Store a pointer to the bound driver's private data.
> +    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_fore=
ign().cast()) }
> +    }
> +
> +    /// Take ownership of the private data stored in this [`Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called once after a preceding call to [`Device::s=
et_drvdata`].
> +    /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub unsafe fn drvdata_obtain<T: ForeignOwnable>(&self) -> T {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: By the safety requirements of this function, `ptr` co=
mes from a previous call to
> +        // `into_foreign()`.
> +        unsafe { T::from_foreign(ptr.cast()) }
> +    }
> +
> +    /// Borrow the driver's private data bound to this [`Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called after a preceding call to [`Device::set_dr=
vdata`] and before
> +    ///   [`Device::drvdata_obtain`].
> +    /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub unsafe fn drvdata_borrow<T: ForeignOwnable>(&self) -> T::Borrowe=
d<'_> {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY: By the safety requirements of this function, `ptr` co=
mes from a previous call to
> +        // `into_foreign()`.
> +        unsafe { T::borrow(ptr.cast()) }
> +    }
> +}

This is a comment triggered by an intuition, so please ignore it if it
doesn't make any sense (it probably doesn't :)).

I have a hunch that we could make more of the methods above safe by
either introducing a typestate to `Internal`, or (which comes down to
the same) using two separate device contexts, one used until
`set_drvdata` is called, and one after, the latter being able to provide
a safe implementation of `drvdata_borrow` (since we know that
`set_drvdata` must have been called).

Since buses must do an unsafe cast to `Device<Internal>` anyway, why not
encode the driver's data type and whether the driver data has been set
or not in that cast as well. E.g, instead of having:

    let pdev =3D unsafe { &*pdev.cast::<Device<Internal>>() };
    ...
    let foo =3D unsafe { pdev.as_ref().drvdata_borrow::<Pin<KBox<T>>>() };

You would do:

    let pdev =3D unsafe { &*pdev.cast::<Device<InternalSet<Pin<KBox<T>>>>>(=
) };
    ...
    // The type of the driver data is already known from `pdev`'s type,
    // so this can be safe.
    let foo =3D pdev.as_ref().drvdata_borrow();

I don't see any use of `drvdata_borrow` in this patchset, so I cannot
really assess the benefit of making it safe, but for your consideration.
^_^;

And if we can only move `set_drvdata` somewhere else (not sure where
though), then we could assume that `Internal` always has its driver data
set and deal with a single context.

I don't think the design of `Device` allows us to work with anything
else then references to it, so it is unlikely that we can make
`set_drvdata` and `drvdata_obtain` morph its type, which is unfortunate
as it would have allowed us to make these methods safe as well.

