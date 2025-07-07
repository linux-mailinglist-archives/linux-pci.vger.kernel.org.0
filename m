Return-Path: <linux-pci+bounces-31599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A2AFACE6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29FB1770CD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229227B4E8;
	Mon,  7 Jul 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dGHa139j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D827A12D;
	Mon,  7 Jul 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872699; cv=fail; b=d7X5oq6puzweca24+txoIRAbn0bxVLMcILgiHb0fBOX5Jwsr3GoKmtNTPz1Oj/cjmwwV686QAIbUkIbRGja+qv1RecpmdHufBpORDro2WjrB+8OWiD2Op0VGsuVcXTEGjZZkgZoWF0khm+dozrchLzJg8Xc7nghZOFk0YFD2kPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872699; c=relaxed/simple;
	bh=3dwY3w5w7VZpZ+7lGYSMz5PP121eIEOVqhmcMaXzmgQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=P6+/QZqhOugHX5gjdeBxPwwNjIBcf/fe+NfbLV806mbLuyG5hM2vES01Cn2XTp5n8mCaowG0lKTHCC3JHzrIrB+rTidsmBy/INgoLTvvGIabfv4vvkZ1tqtRVB5qNjwxXfsJ1OhhLDU82qYErzqKhnAnlZ5i0I7oGTk5CecDBBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dGHa139j; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZTvdQzih2vTfonx8EycbL+P9EmsMNabtP/TweOMK7on3A+KEy8hSmeBrEifpiVPzbFLKlPhgAQSi7eEQZA6oGiOZJlY6bZAXzkLFhgEIctqoBgyRhD9RemWd076pyuVOfelMVXe2SkrFdI8Z7tyut3/LdN8ESbzmHRA6IIV450HlnHCIuVculYU2Y62q2NMSNvhtA6F5lOmCq6NBPwc7pXEpjmLfO/h2n/nlv42HKWKY2MgElZfU0elnfHCITOQcEFS8PL5mmrPEo+DnAawco5GwVGYqcOTMEv97emOC/BXreALAKH0mvS3fvp36UVQRCa66eevSsQ8KEPS6N+kRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhBdd4umqtdfaoX+X+GK/RRudwBnLu33WJbeqdMEGP0=;
 b=hCPwhHip/IzyYEBwT0eAqnpCLKNmTU5HTzOutRFN8L863xG5qNi3EPQ56/bmGFuBsgvvdFQuYshc+LoiirPaeVuqfSyKqa6oJx/bnY28kMLI3U5vWC3zktCPG/U9epfcI+4U+FnqgUIclcCxxnLLQz2sq0vpEuLbuly+m/hY3fLZLTQ0JOeuVtG/6zzaGpQcaLhl/NAu/dDTL3u4AwyXuPU4+u/tZ/65rq0HQesFZqzSwXzfswexiOI+7RaD/GXGchizBcZkpAgaJqufFZSVTUh2mS0tQ00qTMn/ujeK3TMitV2DaXQmxlZhK+yrXHGTtpios9O+mhJtS9sUE+r4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhBdd4umqtdfaoX+X+GK/RRudwBnLu33WJbeqdMEGP0=;
 b=dGHa139jbFwTzqVXK6qS97leOikVTfdpaHebisR7qhRXen6GMYmCjx+HqNwgpqYVehwWf2L4hDLv8sd3qVNN7L868B17vwu8UpIxL6/bceCsNwGFEXWxP6p5Yy1IWdVnIq08/g7mLqZ6j/GwlD1Iu4+gcoRypqt0C0LEq5hyKG7uLz2UQzXr30E3c9CEyE99bjO+vkr4sNRkXt2kXsG/QFEzdjLVCHw29N66kPB9vv/7hxtOa9GMMifMkSIV1ZUm5Q66IVEa2OhjaBaPSsjJSFBYOheczAiFKsPKROFSR0qIbPatagxGVy5UCFVGoHkBsdcnIHcX4BudKtjuB8K9XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 7 Jul
 2025 07:18:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 07:18:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 16:18:09 +0900
Message-Id: <DB5N1F62UP4U.2XQ69N3FE1HWP@nvidia.com>
Cc: <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/8] Device: generic accessors for drvdata +
 Driver::unbind()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Greg KH"
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250621195118.124245-1-dakr@kernel.org>
 <2025070142-difficult-lucid-d949@gregkh> <aGO7BP1t-A_CQ700@pollux>
In-Reply-To: <aGO7BP1t-A_CQ700@pollux>
X-ClientProxiedBy: TYCP286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a06f961-7c8e-4231-43e0-08ddbd266f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnZxb1Rpc3k0OW43aUlJcWRlOXZYTWl3dTJ6Qjd2bDdjU0Rxclk2VVl1c0Vq?=
 =?utf-8?B?VFdvVEtlWWRUck9KMFZPYzUzSmFxVFRsSjkrQW9wMTRmUDRjelVzMXNOSzF2?=
 =?utf-8?B?dGRkTk5HRUsxL1Rwc3RXRkVnbTNpSEhXaUp6ZWVDUkFydTFuNjhOL01HVkJC?=
 =?utf-8?B?VnpTeVFnUllmSFI3WEpVNFVQak91d0psWGVxVlFQOFE3MkxOTTNsNGQxRVRV?=
 =?utf-8?B?V3IvNXZBaFY5VWZGZU9taFcwZ3d5ME9mRG9mYm0xNXoybFV2VStkd1p0bzNy?=
 =?utf-8?B?a0ZoUEQ5NnZ2K3lRWE5lM1pSNVhmM2VwbCtQWnM2NXdtWVRaVW1NYXNZWXF1?=
 =?utf-8?B?OXZUd1lIQSt6eCtrMFJOd0wxNmZnUWtSbkY2QVNCOHp4UFRJbUR5Y2NteGlr?=
 =?utf-8?B?Ujg4TVhyYnpvbzdSWGpGN0J6d2dDOTYwb3NQVGhFekxsYTZFdE8zS0dhVzVx?=
 =?utf-8?B?TG45WWpqYlFHV3RhK0VPTEttOUh1UDBwTGdyVVFYeUZaSTROeFJJdG1ybURL?=
 =?utf-8?B?N3BhbkRjamd4SmVMUUFjeDRhSk9WMXpEMW11RDlmK1hYMmhZY0EwOFdpZTc1?=
 =?utf-8?B?MCtRbWE4TDRKSlVsTUc4RzAzUkZQQjJ5cVY4TVRCUUlZYk9mV1NBeHl0UDdl?=
 =?utf-8?B?Z0RKdlFwT1BuaFlGWHljdHVKNGRlQXFGTklqUTh2RGlIUVpybnZqL0tBU0Vo?=
 =?utf-8?B?ZXJ3cDN4dnNSb2FiTmloUUNLWS9meWJKbjdZMXJhQWF0YzF1M1k1eXpCLzEr?=
 =?utf-8?B?MlZkWXRQTmx6RVUya3NKNU0rR0c2aGQ3T1dsbCs3Y01UTHJQcGlKQ3YvdExo?=
 =?utf-8?B?dDdvSzJpbFdiUmY1Zk5vVWhCcGFrN1ZJSWRySUlzNXpaQWFTVXh3Z0JBa0dI?=
 =?utf-8?B?cnZGK25nc0FwRFZNMVJlN0NacnhTN1dxY1FSWStsUFdnV3l2VmQxa1huc1BZ?=
 =?utf-8?B?dGtqZVlibVphNkRtRnpLcHE0d2NUNHJ6TGE1ZFA3Y2h3cC83TTBQWDR0eU1V?=
 =?utf-8?B?SEhNZkQvenUrb3d3dks3S1FVak5CbEs0c3U5M0xLYWI3bUlWWmtIeFhnVlRD?=
 =?utf-8?B?MWFhdGV4eWJVU0FzeFI3OXQxaDQ0UzcxSCtIVld2YjdCRmxvUk1YYmpCblN4?=
 =?utf-8?B?bnBmeFlxVlRMVTdMbTNDVEE5MlB1WGpueGMzZnZaMUxjUzJwYTZBb2x1MlJn?=
 =?utf-8?B?dmlURStKbm5WS1NRczlXZzFLZk5tSVlQb1VaTnhiMUxVanpEWlk3MUdKM0JP?=
 =?utf-8?B?cy83MnBFTDh2YVhFWjF5dHBxUVFjSVZGaHFPY0UwMVl6c1VxWmc4NTVSOGY0?=
 =?utf-8?B?bUFJUTAydExGK05mMjZEYVl3c3BITWtUZU11aFFNZE5OZFY5eEl2bnBISklG?=
 =?utf-8?B?cDRvb1RiTXdYSlB3RnhqS09BSnlzUmtVRG5sY0ZOQ3lJZkJDdmZRVnE3YXpH?=
 =?utf-8?B?MzM4OGNoVGMxYTJoOU5CRVNYL1VTUXpFQkRuYzIxYmJsVUk0M2ZYeFJwaHBh?=
 =?utf-8?B?K29OdHRNVE45UThSMTNkVW9KbS9yNmhZd1h1Tk1ZTjBrRnRtUnFvWWxqZFFV?=
 =?utf-8?B?Ym5lKzZzMFlVQVYwVXh0WWtGMHV1QjhNYlBwenZ1Zzc4YmFyUWRhMDg3dnl2?=
 =?utf-8?B?SDNzN0loQnZzVHBrY1dFSEk0d3huOGtTU0hQdnZndTdPR1dhb25KK29OWWZV?=
 =?utf-8?B?M1RCZmJuUXkvdDlmVTc2SWhJU1dTMHp3TkdtM05UWjgrYVlPTmxrTkZKeHV3?=
 =?utf-8?B?RHFkTzMrUXFxdlZqMkxBZWJTVGpZU1lrNWU4enVhUzBwdi9JTTQ0cWZNZXBG?=
 =?utf-8?B?RXIzSit1UlYyMkQxdDlBQkJiK0VqeGpUV2xiQ2FwOGx2WFg1R1BBRnZ0SjV2?=
 =?utf-8?B?ZFN5VUlzVWl4RFBSU2hnVWRpdXFIL2sxV3ppR1Q3SWE2SzE5T0t3MW5UQS9o?=
 =?utf-8?Q?R4xtOB1ix0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJlcXlUZHBrRVZxTkZDa0h0ekhTR1lReTdHb2tZb2hvd2crUWNwanBZekhi?=
 =?utf-8?B?cWUrbnpNVVpqL2dsS1krSy9LVjE4T1NqWkZhQTdHWjBEeHhNUk4vY3k3bk9L?=
 =?utf-8?B?bi9CY3VaK2d1dkVaQmUyanNUZHhmWDVzNWVoNUwxaHJ0ZE9oNHoxSU9rQnN3?=
 =?utf-8?B?ZTFESnZ0TnpoNyt4ak1tVm1NNkVXRGdFcmNEc3Zpa20wZFZEUWdIWTE3Qll2?=
 =?utf-8?B?OXBaWnR5bzd2UFBqYm9RMkxadlRCWmhsTGh5YU5CcUx2Q1p3a2s4T3YxOUhs?=
 =?utf-8?B?R0RzKzZ2YmpYODNhSnh4MjBQZGhQNmJZUjJYMEdydmIyaXQ1cmozY0ZmYUtl?=
 =?utf-8?B?bDRoTE5tZDE5aGYxNUVKSytkZnhvQ2NVSVdRRE9pdlpLVEhiL3M5SXVqRHdv?=
 =?utf-8?B?L1RLSXhZN2FuMFhNQVBWWjZzdlpGNmpNZXNFM0VvNldoK0RkZUU3Q0I1WXYw?=
 =?utf-8?B?eHkzVjM4cEFEZFdEc29FUzVjMHU3eXNRa0R6M29qazBWMUlld0FmciszRUxV?=
 =?utf-8?B?L09VMlN0b3RQS2d6NHM3Ti8xMlRWTUpwa04yMllvRTRqektlcWNsSHNkR1o3?=
 =?utf-8?B?Ui9WMjlOZHdvYTFWY1lWbmZwanBWYWdQbWxKQmU2WE1DVXRYRllyN2lsVkYv?=
 =?utf-8?B?aFJ5enY1eEFuVTFLVklXQkxwQVlQbEpON21sbUNRY0ZYT2hXNnhkeTEyblpL?=
 =?utf-8?B?V2I1WHdPd0R3aE9xY0xsRmtleGY2VG5xaXVJV29QNDVpNmhNbzd6NlFLMlQz?=
 =?utf-8?B?N05aL0R4Z0ZCbmVTSEpITG04WDRnTlgwYWFmNE9TdE9LOHNMQ2FUSG1pL3dV?=
 =?utf-8?B?S2FCOTdRWUQyUkZvMW8xUk1oNzdJQi8zRW1aUHFBSkRoODBabjVDV21XVG9l?=
 =?utf-8?B?N0RuU0x0WS9jSHNYdklPOHJrRnJOa1g3R3VHanFaUHc5YXJqQTJuclVwZXFD?=
 =?utf-8?B?ZStla0NNY0h0djN4MlFSb1Jsd1ozVXFyczhTc0NKMHlSeGxyaUxkQzNEdzN0?=
 =?utf-8?B?dmx4b1Fhd3k5NDFTUXhlOTduTTh5NnVDV25ma045STVMdVdGbTRFZFl5a0V1?=
 =?utf-8?B?NzRWbytKbGJWekpsU3Q3RGx5YW5YMHd0eFFVVlFoTUdMV1VOVG44THNmTkZ1?=
 =?utf-8?B?ZzdpMFZMWEsybnNGb3ovOUNqU3lMY2lTczRGNm1MaDQ1YVBFYlZaZlRPQmMz?=
 =?utf-8?B?TXhRRzZyVlNQb2lxUHZFN3ArY1RUcVpEZDVBd0tXQzBmazh2TW9JYmE2K2lJ?=
 =?utf-8?B?OHg5QTNCVDFaWlhockhjb1IyUkx3bUNTcFRuQzlMckU1T3lLTlpPdTV1bGti?=
 =?utf-8?B?Q2QrKzlJcjFycmNXR3JmY0ZRMFZJOTBJOGQwbmhBWFdsd1NCQUl6K3hkRTEx?=
 =?utf-8?B?ejdCSkN2UHlhMWdSMG1GbXdNUWRhT09MdGU2WEczcmwybWd2emJIMytQSU5r?=
 =?utf-8?B?enlIOVpGTzBBL21BRHFhSkdxWTltMGtNNzFmWmk2T1Y5VllLemJqT2dDL25I?=
 =?utf-8?B?aUhMN0NHeTVCNGFzTEE4bGd4Y1BBZWV0QXNKMy8zd3Y1L280UUJ6Zk1ST1RN?=
 =?utf-8?B?SVpjZ0haVDFLbE5TNGJqUWVGMXdNbTVyQm5hNG9JdmRVMTc5WTJSNkJRbkNB?=
 =?utf-8?B?aGNCNEh5TDFhRGM4eGFJOE93VWF4MzdqTEd4MCswYXFwTlBLZTJWb3NTZHl6?=
 =?utf-8?B?T0dETVBIU0VnMVFuN1NmNTdvdnRIdFZnUS9rWnBDL0Q0Z2FOdHdpR0dEampW?=
 =?utf-8?B?d2tDRHNuYllJd2xzZWtlMVdabDJDbjB0Q1l0V1QvTFJvSWx4N0xxeWp5NVZl?=
 =?utf-8?B?V3pxN1NmVGg4cUNDRm5vWFdjZGxGdzhJTnFydWd3clRBYzZIaWRWQnZKYm4y?=
 =?utf-8?B?anJoVE1sRHY3SDNWWUFDWmdiWmU5Rk9hYUZ3QlZ0UVpzUkowYU0wSW5TakpH?=
 =?utf-8?B?L1lvRjU2K3dEMmZoWGRrdHJmcy95Zlg0L2VvZ3l2b2R5alAwTmpoT2k1bmp0?=
 =?utf-8?B?azNLMDZxcnZKV29TTlVTYmlxMXVGVkl3U25uVm9WRGhva2djWG1KalVSN3Bo?=
 =?utf-8?B?dVJCcU5BaVJrMmhHeldBSC9OOVpTYjN2SWk1UDBBc3NHZUkzZlRkdzlsOHRR?=
 =?utf-8?B?dVFJLzRUNkFxNnRIQU16VnBYTER4eWptZ1EyaHZzZUR5aFBFbUJ5QWx3S1d1?=
 =?utf-8?Q?plRdwneTdcWkle/KPNB2V/KoWKQZ7mELI1faKH68mRoF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a06f961-7c8e-4231-43e0-08ddbd266f06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:18:14.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NJmxk+Bwjxv0G7Tq2X2uD3YZG6L2uQWq2qjvlgM7RP4Q6nPaylEPnA8YAy3GLakmSrau1YOQ70tH+j2h1tMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

On Tue Jul 1, 2025 at 7:40 PM JST, Danilo Krummrich wrote:
>> > This makes it inefficient (but not impossible) to access device
>> > resources, e.g. to write device registers, and impossible to call devi=
ce
>> > methods, which are only accessible under the Core device context.
>> >=20
>> > In order to solve this, add an additional callback for (1), which we
>> > call unbind().
>> >=20
>> > The reason for calling it unbind() is that, unlike remove(), it is *on=
ly*
>> > meant to be used to perform teardown operations on the device (1), but
>> > *not* to release resources (2).
>>=20
>> Ick.  I get the idea, but unbind() is going to get confusing fast.
>> Determining what is, and is not, a "resource" is going to be hard over
>> time.  In fact, how would you define it?  :)
>
> I think the definition is simple: All teardown operations a driver needs =
a
> &Device<Core> for go into unbind().
>
> Whereas drop() really only is the destructor of the driver's private data=
.
>
>> Is "teardown" only allowed to write to resources, but not free them?
>
> "Teardown" is everything that involves interaction with the device when t=
he
> driver is unbound.
>
> However, we can't free things there, that happens in the automatically wh=
en the
> destructor of the driver's private data is called, i.e. in drop().

Can't we somehow make a (renamed) `unbind` receive full ownership of the
driver's private data, such that it will be freed (and its `drop`
implementation called) before `unbind` returns? Or do we necessarily
need to free that data later?


