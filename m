Return-Path: <linux-pci+bounces-43403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA07CD06FA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576FD300B902
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646933B96B;
	Fri, 19 Dec 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3xyEACy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED13246FA;
	Fri, 19 Dec 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156396; cv=fail; b=GSxE4f5cozsmWoaQPKLDfGqT9YCf1VPTCKriVGE5flTrO0gqQTYlqI8SPZxITpwCuL3th6U+vAE/gJNYUCMemm8Kw7ppfrsR2OAtAx45a65q61M0D1botcKl0S7Rvz9GOOcuHbKOX5+S4O/VeNyVMlzvxiOIE3vVuNXI7HEBf7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156396; c=relaxed/simple;
	bh=H+ZvWZsDn5I/BbhZWMNEcqATahCAJAZfUQErI4bw/RQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K3E3p/f1yhHbXHdQJU2fOFeoFBxigOsTzQxXXh8lLe5fb6O8S6gdwgSEl2I8tx2FyzJgibY7+lACFKthGaLu0KaPQhFuDEfMxdVawD8KlTyAdhc/TcNbMu/OVuepK/wX/SHoCJrifslZii7UYy5LfGt1BJg4hNrtTAo7XCH/ze8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b3xyEACy; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqJPgdI0p3cOufqZaYUsR8mdnaEr57WmRwwZuxyZpQANoIovl01En3xcnutqpDnGhJ9uxAd5kmAtsknYvb6KP9Vipv/VZuSNTxNMhOFA8JAxTJ8vJlgg6pnZXKD10g8PgdRd0OV7Vh1sxEyo1rTBoKUXqlaLxeylHf25NhuV+NS7UohNFmLioQjkiWlPGRknFOHjpt7/tdS6vxrE5033tPnvUA46JW9rmL6cxYn9rpEngY2JDmbO63eZ13GmVLOCWMBfrA/PArXyqyceb2Mn2z6LSihYQFHzGPRHgBT88R7az3p7yyZmA3jd8AHmzkQ3WoJUxOrDhbigv6us+rrdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d2Tb3waxMxHoU0t+kSVhmHzQAilLHjRMU+faWB3xBo=;
 b=hX2oUFk8eJkE9eFC8sKNRfNP3UFg+0nhYrXCoIizO7QmLvWbbA1psLxGpfFMBCiBKG28Q1t/zl6lWxi2XwTDgTP/uG+nsY5SDVNl8NCFhntGm6AhwV4A5i9TOdqrcSQQL1T8nORLmWhpbGGZZPAb/DdzVUXN9UWJPlWOAngekLdpTFes7SjkUxC+2YLQz+SlYnVdWgqZS61lABtQywkCgpCS+uMf49sipKS7tpr4dVHKQD50R+kKekOKo3vMVNnhTeREc6vzUoiT2bDROd23R0R9zVZq/xpOZoVfh3bs/4fsW3kK8zUPD16Mt55cxNAWa7AADobrDeBG09ZqZ+p1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d2Tb3waxMxHoU0t+kSVhmHzQAilLHjRMU+faWB3xBo=;
 b=b3xyEACyLf0qXpE967RcApzlWNuWgN9L1UQpmdl60whjk/jOpim2AQctqdM/6iCiFo1gTu51NGx0eMULH7wIN86hDyLCerz9WqtDpEJfjauqySQHIvk7N0cTtd5OQBgzXZ/sKdlLxExdykk+YlZiHbb/ox24s5PA5YRIQXyvCStqsRWyvmZxXqQrZ9QlCuCfbA+gB8acVIrvqyF7MXT0yToyMYqCEFRWCG0zkK8onXV8JJZqFMQy4Hg7aIXhk/6vntJ0dA5HSIzdAY8+Tbd/30urMrKovDHdiEEupxaVnqWxTHhFks1bvSEE9lDaoGgub4pMprJrXF/jiAcVK5O95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.9; Fri, 19 Dec 2025 14:59:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 14:59:48 +0000
Message-ID: <15a3a37e-5c3f-4084-a420-34614df243ad@nvidia.com>
Date: Fri, 19 Dec 2025 09:59:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
To: Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251215025444.65544-1-boqun.feng@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251215025444.65544-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:23a::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f3d4eb-6a1a-4f1b-73f9-08de3f0f40f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MklsQlMvQjEraGYxQ0dRbU1kcVhmcWFJdU0zRDNKTmJIR0FZKzkrUjlBRXdK?=
 =?utf-8?B?Z3Rjd3Jna1VWS0NnN3pNR0g3SlhzSjkyVmdVdXg1TStxc0laZHBzQ0E2QnQr?=
 =?utf-8?B?VXFSUFh2Wkdra1dkWjNMU1JQYkZmc0FxVGxTU3l1eDVoam5hSUZGUHNZUzRS?=
 =?utf-8?B?Nkt4a3AwM0Iyc2FQSWowVXhNck5OWWdHdjVoUFZtYWI1K1NId2VET2srL29H?=
 =?utf-8?B?aS9QT3U2aElpOTkwc3pSaGVzTlZNMnZoVDBzdFZMUUhOTThwQ2Y4cWU2K2tM?=
 =?utf-8?B?SGd4TUE1V2xSREJCeGRyL0ZFcGtkNFdRdCt6N2NIZjI0S0VaNzNFL05KcVhF?=
 =?utf-8?B?alVsNVp6YjJNNHVXdWZocTBwZEt6aTB5bVY5enAvMGNlRUdWQ29UMDhWTmwz?=
 =?utf-8?B?VFQwNjdncFF4ZHh5T2lJT0RZZzBDbm1rNTJOZzVmRFcyRUZoZFVxQ0JTckFz?=
 =?utf-8?B?WkpRZWNkYkYvaXNpOUptWUw5RnVWUHJDTmxueE5HN0h6RlF4Yy9WREI5ZllD?=
 =?utf-8?B?aTV2Vk5oOHNmeUo4NVk4SjFiWHhtWEJqVEVqOTRtR0NRVnVwMmpDVVZqQ1JF?=
 =?utf-8?B?WUtLWGVyUXd2eG1SMlhlQTFSV0k3OGw3N3VsN05jQWphOHhJOHNzRmtkeG5t?=
 =?utf-8?B?dVB6bk1mcGYrUVVQdVZSYk5DTzZqQ2tFSEVpaWdwU2xoa3RBKy9sZUZ5UXZ0?=
 =?utf-8?B?SlhORG9oMmxaZGVmMm1xOTkzUkJGaDIwNTBjOWpVb25Ndmp6a1lHdnU2cmZk?=
 =?utf-8?B?WGtlZjBmeEJpWklXSENGQUhjMStweGpyVE15N05qU0N0V0lKVjJGamt1enZo?=
 =?utf-8?B?U3VrWjhXQVJDQTFVTHFZNEdKRVJTM09wbHZ2TCtzVVY2dUdGcXhJM0txbU1B?=
 =?utf-8?B?dlVSaSs1eVZodFdobzZzRVlsTFZlZXFCMzRSVDNmL0F2cXdnSUtEbTJHY2NO?=
 =?utf-8?B?WmMxYklGNmV1aVhJenptUFkwTHZxM21aUi9vai8zRWMrTGdVdlQ4eHZtM3kv?=
 =?utf-8?B?ZVUzMnc3OWFwd21XSmJNZVQ3QzRhQllQYjgyR2VGWkJCY01zS3NqWWFBRUor?=
 =?utf-8?B?d2p1bzFiQmpiQURnSDVCODh3RCtzVVN2TmpESldCVWRqUFRBUm9XdzhpMXRy?=
 =?utf-8?B?NlM1bWd5RG4rNzNGUEZqZFJwV2tmb3lTZERLaUxzR1U3bjFIZTAySjNXZzI5?=
 =?utf-8?B?eStPZzdYRXcralFHNElWM3AvOWZsaDZlQ2crOFBqcDFMQUtvcWFubE4wZEJF?=
 =?utf-8?B?Q0FQVU95SzUrcHVyU2NXcU9XV0VCU2l3M0thMG4vczlQeWRsaWV1WHErRTJY?=
 =?utf-8?B?TS9ybnN1cFRJYUNCTlNZNCtuTThRTzBraVJicmFPNWxXWGdyTjJsV2h3VFhw?=
 =?utf-8?B?Q2psRnQ4cGpDNTVxa2lNOFB3LzRXSVkydG9FZVZIbEdtcDhZRkV5OGkvRGpU?=
 =?utf-8?B?MmxWWGVMY0pUeGNVZ05TUGI2cWovVHdqOHNDaWxwMWx5WHZJK29iM3hwN215?=
 =?utf-8?B?dHRaM1U3K0NPUU5xQVErYXVaeWpRTnMyVTVkSUtqMmFSVFhJOWEwZjUyd0Mz?=
 =?utf-8?B?eWpWb3ladTRiR2swYnZ6ZVhpWUx0dVVpSldMRlhzYUsrZ0FkQVlDR1F5SlV0?=
 =?utf-8?B?Yllta1BjUkdDQXNWNUZPRzVERmlWNm95dm5NeVROMWgvV3VvUy9xeFFjNFR4?=
 =?utf-8?B?dW9yWHVHNWNVbzJuWldHWU5Zb1NORzlsQWllc1NkYm1DbkhxdGNzS1dPN2Y2?=
 =?utf-8?B?ZFhmeUtvblgvQTI0WllsdjgzZ2NHcTNVQUt1bXFOQUVqallLS0E1SXhPYytx?=
 =?utf-8?B?WjJSN1lZNm1lUEJQZW51anhRVUJRV2t5TTYrSW5MSCtLZUN1VXhFUkd4S09R?=
 =?utf-8?B?Nk0wWGdDYnM5NUdhdnFIM1ZUZTRNUS9OTisxSkxrNUhJK3pTNUNoLytnMytG?=
 =?utf-8?Q?yN39YcFStmBh8SKBRTkoicronSy5wyD/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG5sUFhWVnUza0dCNy9QalFhOXBWZ1ZlTFRlOWRvSDhnTWY4UFRnTVZBM2FC?=
 =?utf-8?B?d3hPVWNhVVFiWUFOK2p6RnF1ZGRMOGJqbFZkd2VoeDc5ZVFxQkxyekczOW9Z?=
 =?utf-8?B?SjNlZFhzaVFzTlcxT2REZDVrVkNNQWYrbzVESnZUWXVWODVSdFZya2tsbnJK?=
 =?utf-8?B?YVRZMVJjUUVQYkxTK04wNG1wRmdhT2FRSi9EZXkrRjZiRkFibU94VHJTWko4?=
 =?utf-8?B?bEJINzNnV0IxTDdnNnRXVG9rRlRGNlNaaDc1WG1CZUc2YXgzYW9kcjlvSzEx?=
 =?utf-8?B?T0IyWFltQktqS292cUU3RVp0TWlqQWtjM2ZZaDBmMERHQUt2dG1oR0lFT3Fh?=
 =?utf-8?B?Q01lWi9TTENRRThlYWN3Z0pvSXR0MU1oUjZSWXBvSFdaY0gyNVFKVWFMcElY?=
 =?utf-8?B?Nk5iUVZaY2krbUZwN2pTVXF2Ni8yS3cySmlFMFNXbExVNG44ZVg3bFdKR3N5?=
 =?utf-8?B?UkZTaW5mQm1kN0VVek14RlBLejFPRDRMOUlWUjd4aUFGQkVXZjNoZDZIZXF0?=
 =?utf-8?B?UTQrRllUYVR3TUNPalBQbENCaDVBa2pIM3lkODBkRGpETFhzbUxpZmJoNzdM?=
 =?utf-8?B?NXNMbExnNzhoVldwQ3hnODRjV292T29lSWtRU0NyMnFkQTlZc292RjZvQ0lS?=
 =?utf-8?B?M1RhNU5ScE5kRDNrZEs1dnFSWEZIUDhvTVB5bXJrS0Nod1c0cUZobXlJc3hn?=
 =?utf-8?B?a1JON0MwTzlOV3FxcVN4bER0ODIwTDVLQ04yQnp4VFM2SkpoTUNCZ3F1cEYw?=
 =?utf-8?B?bFp6UXBHNmRyZkcvcDVVdFNSVmFPa3FDUFJxS21aTC8vMkYxWnpBN3Yxc3la?=
 =?utf-8?B?NXhIaWM1SG9FK1VJUk1ZcXhrbGZGL2pVNncrQjA0bVA0RUF4cTBOVFZPbFU5?=
 =?utf-8?B?Q25GK29QNmZ1NDgrMjYzQ0k3bWFFMExXeU5MQnVYR2UrMXF3aGNXU21zdUt0?=
 =?utf-8?B?QWdmWmdPSjhaMUh2WXdwclU1eG53aW1xZ3pySjU1L1pZOVBMckVVNmVnMVJQ?=
 =?utf-8?B?aHFBTXlGbi96dmtaUVBVY2VPQm51TklNK1h3WGk3dXdtdHRDekJzcmRidkdO?=
 =?utf-8?B?VXZXUE9DOHR5bFMyOHFpMFVoR0R2SnlFM3FYcjRhTSszVlF0ZzZ2WXQ5Mk1t?=
 =?utf-8?B?czhmS1dIcGNHSU9USDRRdEVvckZzQzc0S3ZoZklUMG1kcHNqR0FxNHdMWTE3?=
 =?utf-8?B?U0doWVgvWEhwcVdEVW5ta29lMDc4YTBFZTlFUEJxQ3A3bS9IVHMzMDJwSUo4?=
 =?utf-8?B?VTRyaGlLTEhuM3JIc3N6aHV3Sm16R0JXcDh2YUhONW9uTjJNUy9VOXBLNlQ1?=
 =?utf-8?B?RFBoYVNISzAxcGlBdFBnTXpwbkJqblRVMWZBVHEwUi9MUFppVjFiUTFncHRW?=
 =?utf-8?B?NUl4dUlzZVdTeW1LWUJ6VVJuUlZyM1YzQW43dklPcFR3eEllcmlBL2szbmYv?=
 =?utf-8?B?RGJZb1E3OUV6RjhDYlhqRmU1bDN1SW42ZVVoY1I3NEoya1IxeWdaL1EwL2dS?=
 =?utf-8?B?YTU5WWtXdldkTVNIT1ZUUEZhSE9HMEtOVDZsRXJoUFNNS1ZnbDRraTdMc0Ft?=
 =?utf-8?B?MVBBZnp6MFJLdkdQaXl2bjZyTjlYYXd6UGpORGhzRy8ybDZHc1h0WmhXOW9p?=
 =?utf-8?B?YWsyai82L1NLUXFySXVEQTZuM1JCZU9lVlh4cjlWUUQ0T2Mya3RRMkd4R3hu?=
 =?utf-8?B?L3F4NW1yQlg0WVZEVjh4akFTQVFkS1MwQXoxTEV6V1hhdlhLcEtTOHppQTgy?=
 =?utf-8?B?blRkY2MrTTJyK1Y1bytZQ3MxOWYvNkVZTEx0UlpjZjhGcHVEblY3YUxGSnlP?=
 =?utf-8?B?b0hBMlR4VXJWQTNRQktWb09jSnVLYlBVQW9jcm9JdUxWRFJrTlZmWkw4dXpq?=
 =?utf-8?B?UkREcUFNY0FXVGFIKzVPK1ZtaXZBRE5mZ210V09LUVRyV01uL2VRcTloYmMr?=
 =?utf-8?B?R0x6QmdEMTRvbmdkNU9WV214SGg1ZEhkVVFFWDlIa2tHdG9RSzN3elV3MzRq?=
 =?utf-8?B?RjVybW9nellwb1ZJMGJCN2VDV2Y0dmhOdVU3bWFyejBmaWloZXhEMUhoQks4?=
 =?utf-8?B?dkMzY2xXWkQ5NDk0cTJOdEVVUmp0NWc0TktZcFFGVHZCd3dnMmJLLzhvenAw?=
 =?utf-8?Q?IezrWptCVgqvrtksODkMmDXGv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f3d4eb-6a1a-4f1b-73f9-08de3f0f40f5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:59:48.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGj2gbAjJNrujIllTVUBZ9bCz8u23+Lu3UKsDQqCJCK7vlrbt4GMkdvVN+Jtw18yhUINhDd95+47N2lCKXfAbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071



On 12/14/2025 9:54 PM, Boqun Feng wrote:
> Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> is disabled") fixed a build error by providing rust helpers when
> CONFIG_PCI_MSI=n. However the rust helpers rely on the
> pci_alloc_irq_vectors() function is defined, which is not true when
> CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
> could be just remove the calling of pci_alloc_irq_vectors() since it's
> empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
> pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
> more reasonable fix is to define pci_alloc_irq_vectors() when
> CONFIG_PCI=n and this aligns with the situations of other primitives as
> well.
> 
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>


