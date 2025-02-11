Return-Path: <linux-pci+bounces-21134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5CA3004D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 02:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06F9162BEC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 01:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532E1EDA37;
	Tue, 11 Feb 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XQZMVeFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5AA1EC012;
	Tue, 11 Feb 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237440; cv=fail; b=iOVHeZGO7s1d8f17mCTpgDbi/WxxipIeNQBqJ14mOGjds91Js/qN4R4deagp1tRfk1i473GX5O2Wm6ObIj8rmm6vc6gX6azsfdwlNVqzrlAwDy6nyWnRGxGSNkeHgVs5pHuBFnQQq/BwmnQb5wn1C4K+1m3i0ptaoCriO4kSSRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237440; c=relaxed/simple;
	bh=+NB78wCOh/BwZ0Nk0skobcNLwlG5dBTyCCZ2hTVwgF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Epq4TNejnxnDfpaE11fcOekdsJbfKtNAYILPrPE4EPc/e/7YhG1tHEMgtp63VINAd72WHQAGjkl8Agptuw8tdtt9RhcykcXVKhcBxNC+VubTg5BACceByj+3ZpD3KjqXNg4Mit392nK2xkbNGUFcbT4WoRhPyx8DNTpVMSD8tgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XQZMVeFY; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJpzbd4TPngXTMihEiHMJ0u1kIOLFzn/T+5OoRe4IhctvL4gua+/RYsKCJj68LLjnpkkQHcsrDjYmq6esbb8idnOQx8XYd1oywBjFbePgX4vyxOhFejk9mgSITOOR0/dy1OZaDk+0j7CMEjzC/JTvHvjIkyMBgKiBIxPbmyUgxxVitvzFLzXxzsG+9Iblb9/XobXRbibHt8oPTfRyMxRnk23FRrNrz+N1xhCAJVG3AEJZl1EhIjjxc5rjesaJHwCRFgAwCPWMjWS15a691w8H/P4or0R72zK4D3UybTbJLVs/SaUyyKrqZCQAhLMWKvGsNsbPIG+8kgy4wNROomEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOyHJatpc8tK8hdDgaZEadthUaZrbL7Edgfn5oIuadI=;
 b=GtZqtrD0hoEaheYgqZ82FUakhgnwXuP3h/3KWv5zxJxF3siNeIeeFS6fc2CPg7HqHpCNkdvXlQEr/s3t5yeTGMNu38RdpWPM1jiV7ZwOXZvpM0fhwy4+axP3DuYaoVNEPIBOUwozfd+BQkJicEDNoi+BCqQEYTQRW+mGv/1lC/IeNzk+3kSajrgaqT87j55T+QRx4xE25LeP2g+7aYaKIbfVsWLRkvUP3P+BBc1rySGKN49sNOOijSqRZh3mFesOMsiawt+CUqb7DJOULTd1/pjrjegpTy3wiwRSBF7GdkxduMIYWiIzqc65f0am/srRM523fbaMa3HSa2FCOmo8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOyHJatpc8tK8hdDgaZEadthUaZrbL7Edgfn5oIuadI=;
 b=XQZMVeFYISy9zdqboRUxsmgmsUjkrZCleFv+FgaNIzaz7iO/nhjDodx87k/vKPM+1w1DuZFia2DESZIMfHowbdKGvD/GfhiFoGzmOBtvGj3NAMpoZi04mbPBoT5u1XwurBxJc4dOg1CReejvNyy6lYtJKs7hkl6h9GmtfKguv9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 01:30:34 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 01:30:34 +0000
Message-ID: <b1595ceb-a916-4ff0-97bd-1a223e0cef15@amd.com>
Date: Tue, 11 Feb 2025 12:30:21 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 00/18] PCI device authentication
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
 Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
 Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
References: <cover.1719771133.git.lukas@wunner.de>
 <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com> <ZovrK7GsDpOMp3Bz@wunner.de>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ZovrK7GsDpOMp3Bz@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0022.ausprd01.prod.outlook.com
 (2603:10c6:220:1e4::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb1d8e6-9228-45a0-a099-08dd4a3badcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejdEeElhaWdTOVd6QW5qWmhqWUl0TzNFRFlGMENKQXQ4TWIyWEl2K0NSWlUz?=
 =?utf-8?B?WjhXbHljektIMzk0MWlObDBRSjlZS1I1c2tWS0FGeEFLR2UzZXUxbTA4d3hm?=
 =?utf-8?B?QVB2MXNUWFpJMlNWdUJDTEJrNnZlQkZNVUtqUEZzaWhyMzhvZmRDVkJzcjZi?=
 =?utf-8?B?c0pXRU9oTTVzdzFBK25UWURwKytRTENXQzZCT2k3QzRCZGtUTXNYclJsMEFI?=
 =?utf-8?B?Q3RTK2d6Q0wyWkhZbWlqMTRjU3QrRThVZ0tuM004ZXk1bzY5enp2VXg5cmNU?=
 =?utf-8?B?QlJkTFdUekRPdTZXWXhYTDI1Tld0Lyt5d1EvcVZLL1IwM3BLREtxMWZkbTE2?=
 =?utf-8?B?OERlYlREckZnQXN2dkNZMzl3RnBkV3VZYXdKZHZJV0VtNXZ6VUtUUVlDUzI3?=
 =?utf-8?B?aXQ1MDdRaXNOTXpJVjllN1dtTEZLMlZCZXRJUGZWcnhydS9FeW11a091bktl?=
 =?utf-8?B?aGZkb2I2bkFWY3kzK2ZIdHRvb1VGRVhkQmJPLzlkc2Z0UDFZUncyWkV2L3hr?=
 =?utf-8?B?VHNWd1A5TlJRanZEbjRHc3NrZEZVRTVmRjFLTzF3ZCtqQ1pieE1kaGNDaGVn?=
 =?utf-8?B?NTkvK0xNeTFDTWpxNzJXa0cxWVQ1Um85SkNyWG93UDlpbjVxZWh4TFY2Vms5?=
 =?utf-8?B?dGNmWnc3VHA3TnVEUVlpOTFyZnpkWGIwR3RlTHZkdHAwbThxYmxUVUI2QlVY?=
 =?utf-8?B?dk1qcitiY25TUDhoVXJhb3NOeURNQWRlRXYzV01XUFpQZkZKa083RTg0clc4?=
 =?utf-8?B?dXFFeFRERVRwMnZqZGdBVEJJQjUxTjFNNHViRzhBUWZlNjE1dWZCeHFPL3RM?=
 =?utf-8?B?QlpPQzZkZTJXNnNXSW01WFk5WWlXMzB6a010eE51UlJaUmpZWmZZM2VNeDA2?=
 =?utf-8?B?VDRWTmNqWU9yb243N1pZYXB1MlUybzB0RUJPV3V4Wjh0Zi9udjJqdlF0ZHJK?=
 =?utf-8?B?R2pGY0Jxb1FYbW5QZklVRzkwaDc5MDI2S2w0UkJjczV4bmxjcHUzTWlJY1FD?=
 =?utf-8?B?d040YUFURWczUVlabnNEMUh2N1NobFlDK0JjZ3JxMVQrSk5UU3J3V2tONmEv?=
 =?utf-8?B?dzZ4b0hFUW44aUNpcUNLQVppQkcyWi9CNE1tb0ZTNDU1bjJUQ2N1RHc2M05i?=
 =?utf-8?B?M0VNNGovZ1lkMmNkQWM4d01PNG8zWituN2VqODlCakFaVWl0RGdFblpIVnpy?=
 =?utf-8?B?dGw5b2I2MElGR1g0RFBqVDJiRERwemd4M0xwdDVacHY4TlpjOUhOQ0NySmRm?=
 =?utf-8?B?L1h4VVByZWhqYWlaSDhQNHBVL1ZpM2lXeStNVlMzVWQrbG9ld0hoY1VPd2Fi?=
 =?utf-8?B?RllIR3J5MlZCVlVRWnhlc2NSeWxWemtGRjBSeDlVNUpDR3ZpSjQ5M1F2YzR0?=
 =?utf-8?B?TTJ0MzF4ZkdLcThaZ2VmZWdqcVlFTW9DdXZyRUFkd2REZ0dNTmFYNURsV1Qz?=
 =?utf-8?B?YXAvSGZvcDVqdDJ5VjhEM0xZeXJHdkVSK016K3FVYWMxVDNjaWRyQW9xd2RE?=
 =?utf-8?B?d1Y4dDM5MXQ5U3k0OFNxbEtsT1RWTWNQYVBYWWhIaS9tSHMzbi8yZG9ySW9C?=
 =?utf-8?B?UHFydG84WHJPNzhXOC8rRlkzV2o0WFh4V3IrOVd2c0VVejdpZmNsekloVTcw?=
 =?utf-8?B?djg2cnRRQm5SOVVXODd4c09vUVRWaFZZaVhzdVU5L256ZS9NQW11UnU0ZkdS?=
 =?utf-8?B?aTdwMlV6eENXUGEzYzFWUWtYQjFhdjFDdU9FM2diSVNkNjUwRGI5VE5tbE8z?=
 =?utf-8?B?WjVlaWplVTFOdG0wSFBqVTVOK2RSdWZiYS81MGZSREJlMTkwWHZkL3RWbnhr?=
 =?utf-8?B?cXpFRkhWNnM0Y1dxMExpdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhpekszdUUxRGQ5b3J4cFpxNzR1R3dRSFRIOUpBcEZ0cjNOTTlrM3pUaFUw?=
 =?utf-8?B?aEU4TjRFcG84T3BnREpTdk5pNW04TW5lQ2todUt5YWw4VkkzTWZjU29KQnRy?=
 =?utf-8?B?OXhPY0U0cFp4ZWI2b1Jqdk1RZjIvVkFKSjhBWmc5N0dXMjFqYklIZ2gwUWZO?=
 =?utf-8?B?Ri9BRkdKeWRLQnBpVWo3TmhFMkg1Um1iVm5oai9qb1RlRFVNRTlTTUppUlRi?=
 =?utf-8?B?NnRvbVFoMzhXcnZCTStsQ21LdVlnbnd0SVJaYkE4QzZSUXIrU0FhL21rd241?=
 =?utf-8?B?VGdpei9kWGI2MVhnK3hsMGZwRmxEQVdHUmJ5SWhyUS83NU1aUitHRGNGTEU2?=
 =?utf-8?B?SEM1bGw3a0l5RG9WbWdWUHdBekwvWjh1am83UVcxV1J0a01VZnBla0JKWWVy?=
 =?utf-8?B?Z0twYVlIcTlaU1dHQUlxQldBYjBvV2h4SkNTZWZaSWNaUXk3NlE4WGNvVnRh?=
 =?utf-8?B?cXp1U1hYMTRJdlRnTEd4d3hsZ0VtNjFNWW1IWGpXekpldjY5ZUl4bVE4ZEJR?=
 =?utf-8?B?ZUVuVXB5ck1PbGcrNFVDSWY5ZWp4ZStrSlhJWnB2VTVNR25kOXdHamo3N3I4?=
 =?utf-8?B?WnlMWi9zTzJpaHhNaWdhQmh5WWdKQmZlQ1ZuQnNSdVJSMXRmaTFtL1NtVHRX?=
 =?utf-8?B?U0ZUS3V4VEdURVdxNGlFM0dEanpqNnhlWjVVUWwwd3RxRTJhQTV1N1QybXJa?=
 =?utf-8?B?MzFQeXBPQVlZcGxkM0w4UXlOcU1aVjdKZVJ4M1Z1eFVTdnlELzBUWUNQVjlV?=
 =?utf-8?B?TnU4VTZRZjVUVU1FNVhRczBHREh5ZzhxSnNVK1YvQXdOcjliWWh2eGp4Ny9t?=
 =?utf-8?B?UUVsQ01OdkxrcDFkelVvYnZxNkVQYzR2ZWpsTlhUMWovbm9rQ3F6dUNXd3Fv?=
 =?utf-8?B?OE1RZ21iRkhSVzJGZy83V2dBb21wVzVVaWQwNlUzRlYybzYrbW1EYmR3Z1dV?=
 =?utf-8?B?QS9rR0htSXRmUzVjRXNERFlhYjhTbTVDT003N2FoYkFTZ0xFOVdOSHBPVHBW?=
 =?utf-8?B?UlNlZjI4OGpWM1FRNWpwa1hwSWIrWXh2ekpGVzRRMUg1MEhMSWUzU3AyREox?=
 =?utf-8?B?SHg0bUI3dXNabU9Sc3hmMzZzV3dMU1ZsV3UxMFdQV1EzcDVFNHdTd3J3Z3Nm?=
 =?utf-8?B?SSt3N3dmUU55RnZmb2ZWWHJkMUUrRElvM3lDamUyUUJHbVBROHdMT0N0WC9W?=
 =?utf-8?B?ZEc3UExtK3J0VXBCUk13dGV3M0l3K21rUlBNZklpNmV0algxT2NLY2pMUmVo?=
 =?utf-8?B?Y1VKekJBOU9mTVdmRnlqM2NlbkF1QTJ3b1V4NktaYzBPT3lTTTR4Y1JjaGVM?=
 =?utf-8?B?QXR6K2Z5c1lZUXFOcU5kVUdGS2ZPSHVSSXRWVml1Qlo2V29XQzh1RTVkZWRK?=
 =?utf-8?B?NlJuUmhBN1gwUFNlU2dtUE9obkNkMmpxdVAxRHlFYVdRbk4wNzVqVFFwd0Vn?=
 =?utf-8?B?NXdRSVY4aFRRNGhrcy9aR3g0bGx0bmpMMUpyN1U5Kzh2VDR6SGZROHRtbjVi?=
 =?utf-8?B?NC85Y0ZxNVFFUExDNGlQQ01GQjBTalQyOElxU1duK2VRMitEanhTRnptdVBH?=
 =?utf-8?B?djFYamRsdU01bUhaOGxJendzTXZka1hvY2RJdHhHL05jZVpsMnJudHFPTnFi?=
 =?utf-8?B?VzJ6WHhVN2t3bWd6QTYzSFp4M3JLL1JkMzB6K3BpN1hMOHMyZWZucXJjTWhT?=
 =?utf-8?B?aEd3NU5pUGdMOGwrZ3pJU1BjeWxkZ0g5Rk5lR1VkTHZnRkRVSTRpM245STFu?=
 =?utf-8?B?Ny9yWHJnQ0dMcklrcS9ZaGx5ajJBOHJzdS90NTRsVTdKOW1vcEZENUkzMVFL?=
 =?utf-8?B?Y3Uzam1icnp4Vkg1dUJxZXhCcU1SYnJPcXh1NHNmdHh4SStiWlRNUkJVNHkv?=
 =?utf-8?B?b2EwVGUrUDBWTldGOXJlOXhuRU0wclhldU8wd3UwTkJUcjlZZUNyQ2NsOENK?=
 =?utf-8?B?NFhUUGNyK0czSUVXa3pyTmRmd2VzZm1nLzR1c1U4K0hnZHp6bExnYmhxNjIy?=
 =?utf-8?B?NVFlQXpTVHAxVFR4N3VrQVBhS1VjcS8vWVhOQUxDODRwbzFTSk14VHpWWTBG?=
 =?utf-8?B?MGgzTmJHUk1qRjdyeitjbGhSeGNSTnVhVDBha0hkUEdQc1gxQUJuZS9TNDlX?=
 =?utf-8?Q?BHRDb3EZ6akxOSC39EbIqkvfI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb1d8e6-9228-45a0-a099-08dd4a3badcf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 01:30:33.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLKEpxrAfGQisD0Lfx/mvHLPdGIPUrAqzC6wJGyRpg7yafJrk1AmWIrTWbnlTGTKyAfaBxAqJXYsx3GRbecnTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

On 8/7/24 23:35, Lukas Wunner wrote:
> On Mon, Jul 08, 2024 at 07:47:51PM +1000, Alexey Kardashevskiy wrote:
>> On 1/7/24 05:35, Lukas Wunner wrote:
>>> PCI device authentication v2
>>>
>>> Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
>>> expose the result in sysfs.
>>
>> What is it based on?
> 
> This series is based on v6.10-rc1.
> 
> I also successfully cherry-picked the patches onto v6.10-rc6 and
> linux-next 20240628 (no merge conflicts and no issues reported by 0-day).
> 
> Older kernels than v6.10-rc1 won't work because they're missing
> ecdsa-nist-p521 support as well as a few preparatory sysfs patches
> of mine that went into v6.10-rc1.
> 
> 
>> I am using https://github.com/l1k/linux.git branch cma_v2 for now but wonder
>> if that's the right one.
> 
> Yes that's fine.
> 
> There's now also a kernel.org repository with a testing branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git/
> 
> Future maintenance of the SPDM library is intended to be happening
> in that repo.  I assumed that Bjorn may not be keen on having to
> deal with SPDM patches forever, so creating a dedicated repo seemed
> to make sense.


Has any further development happened since then? I am asking as I have 
the CMA-v2 in my TSM exercise tree (to catch conflicts, etc) but I do 
not see any change in your github or kernel.org/devsec since v2 and that 
v2 does not merge nicely with the current upstream. Thanks,



> Most patches in this series with a "PCI/CMA: " subject actually
> only change very few lines in the PCI core.  The bulk of the changes
> is in the SPDM library instead.  I used that subject merely to
> highlight that at least an ack from Bjorn is required.  The only
> patches containing PCI core changes to speak of are patches 8, 9, 10.
> 
> The devsec group (short for Device Security Alphabet Soup) currently
> only contains the spdm.git repo.  Going forward, further repos may be
> added below the devsec umbrella, such as tsm.git to deal with a
> vendor-neutral interface between kernel and Trusted Security Module.
> 
> Thanks,
> 
> Lukas

-- 
Alexey


