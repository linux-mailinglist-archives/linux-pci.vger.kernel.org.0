Return-Path: <linux-pci+bounces-21856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF3A3CE1D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 01:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA78B176046
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA717C91;
	Thu, 20 Feb 2025 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e1uLgqVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22633C0B;
	Thu, 20 Feb 2025 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011490; cv=fail; b=oFcXCPxymgvhfcX4CYcm9aHGlIu4gpA0AJFxC/vXR2RO7CoH9YdZmcQw7L2oHVMKmGnMrlsevtUDYaHH0VnJH6zX+d43yv+Jz/lj4nP2pmo0RSvVxz23mQj2mgMzKlq3vU/iQ0XysmIhunUyPIOApx2edyYnQia3KDPvw2Ogst4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011490; c=relaxed/simple;
	bh=9y3Aux63w3nuSogbyszqlTFSV5tf9x16nPWO2DOmMtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O8yPPd1Ef/z6cI8ggizJ6gleh/kS+AlhiU7wqzBaj7kwQxTualZjmPkncZdSP7khhT9XeuYeWh8cFZh/nBkdmen5SOAKnoUXsV5WJKkKX5hLifCY5NzPK7LFxIk7COplwK2rPZABaynlTAuQf2Db9iRy8EHXQPBDrfUZUFTh5JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e1uLgqVG; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAvD8Ql7Q5wy0dbpcUnEvHoNnplyIp3T+iVcmn3NuhcDLF4xSucgjopDqpWxEpecDLWogLY6F0DS5RI1F2/owSd+5dbYIdMwqHwfpbDhuhn3YLWZ/tk4JLZmrtnO4NhD7pIzVOImrBANujy4PjbJe6QfO+ilPBQsRcSszdFGLurB6KR7cowOR7Lj/5x08vmJ7i86mOD9d6sv37pPzqdnM33LEL4+MVHeXEtM8iYUO4MUS+bx9liibuykyIgxfNws/POBQJVaUkPjWzBYncBP2SXgwWLR/w3xdscDqtys5QEMpYXmDQBIzApE9kiwhKEiLqiOCtxSLyRL89Y+um6cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZbhxakj/jNvbj8jSSZaT0cdm6Bh66L8GukWjDl9gMo=;
 b=NnsaknvhQHeAckvlP6Y4Ekq1htBj78VgIZcNyEyNbM9ENuMfjKP5BYHke79tk5ViTG8h0m3LcevGNHTWUAYV8in9hF6TmIpoPfNC9EfhA0t+fTJt0NRwysDoHt0r4ff+aAsNILnXXBW6ev8+VqAca8nV1VSImlhN/P4J+UDnX067vUVuKNN+BADT9N0JZghComxeRCCEs8bPmPXfLGbh0yMuhQFeyGgID6gUCVaBCTwasAPJCjNCfDfd4YCLguz4sGA0bzN5euXuI9S1wGNuPtavI3WCfOjX3yoHJGwZADBpTaGtTTnu1rnDJPotHiqKSkL53gwEfkW875ipDMRT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZbhxakj/jNvbj8jSSZaT0cdm6Bh66L8GukWjDl9gMo=;
 b=e1uLgqVGnIHgCUWshQ7bJO/9pbfvmejaMPJ9cdotWhn8rXr7QeI6efiMtKhvF95H8b3b+FhCGF3AsOX+S3nsx9U1f0OZ6QohB55I2BsfbQbkang8Le82wbr6eT2nDjjjDPdg9hRc5XgJuJax3nBaF89t5O0yjug6u1qquXYsZjPs5w0qGtAMWwIcj9bR9rfFHlcHOT+XtiqhPmaFK/6NtMK2SkjiwFCPhqX4NmNLLjcbolrxP5Ua1kGwu51e9T2SF+d0GQxS7zXWiW7KytJFhVutKAZ/XOSf0zprir76lv1cUs7Wb/JjtLEcoDyOQFCWLDcnXvvt0XrkYlWFA+smTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 00:31:26 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%5]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:31:25 +0000
Message-ID: <63aeb3d7-1758-4be0-8363-506d0c5635b8@nvidia.com>
Date: Wed, 19 Feb 2025 16:31:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] PCI: Fix Extend ACS configurability
To: Jason Gunthorpe <jgg@nvidia.com>, bhelgaas@google.com
Cc: corbet@lwn.net, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 vidyas@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com, sdonthineni@nvidia.com
References: <20250207030338.456887-1-tdave@nvidia.com>
 <20250207143435.GS2960738@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250207143435.GS2960738@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:907:1::30) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0d4226-c53a-4c7b-f969-08dd5145e8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlJQU1V4YlZnbEx1UUgxeGFCUkx0czBNUEloYldDcGkzRU9BTEhlMmNEbVJM?=
 =?utf-8?B?cytGV3U5SHd0NXBJTlM2NEtCRFRQT1gyaGgyTzdMQXdlT3VTKzJwTE9tS0ZU?=
 =?utf-8?B?R29vZ2pRTkQySE1IdnlCK2lnU1pIV3BkeGlxRTFuZTdMZkQ3M0t1UmdsVytk?=
 =?utf-8?B?SjdFOWt6UHo0NFpvNmwzcmFXdlVLUkN3RmN1T1FZUzUrQ0JMK2V1cGI4cUVn?=
 =?utf-8?B?SEN2R2FZVDU3NGlBWlBPYTR1ZVZITGFxdGxhOUFvbnFxQWVlNDB4MzNWb2gz?=
 =?utf-8?B?Z2JGS3pkbXk2Sk5qcnpHR0o0NHo2YTRZdkNHN3ArK2hHMTBHeDllS2doR0pH?=
 =?utf-8?B?SVRGdXhoelBySXRxU1Q5M2JPV3RmVEJQeEIyRVp2OWE0SUZZUmRnenVtRXVH?=
 =?utf-8?B?ZWVTLzN2WEdieEdGK3Z6VkRoSzlISXVabytYTHp4UmJhT0hKRngyUTZXaXly?=
 =?utf-8?B?bkJ6WlRvOWRHU2VmcTYvOGczenV0TzU1RmhVQWRqai84RVNwT2F0RjVGME9B?=
 =?utf-8?B?MDE5ajRGV0VubUIvTGdPUzM4bUFKOUZ6b1ZNT2lpSlhZOW5RZm95RWhtanZU?=
 =?utf-8?B?VWVvbVNyVDA2dTJmKzdIS2lSUVVpTmswQ2M0b1BNQjEvaWZpbGJGVmo0UGJP?=
 =?utf-8?B?OXlIVnJrSUJ0Kzh3Q0JaZDlLYXJRbVROVkVKbi8xSnZuZDlkbVRmWXhieHY3?=
 =?utf-8?B?bjg0U2g5S3B2cmM2SXRBQ0tVcWE1MVNJZVZYbDhHZVNIQ3J6YUhVY2g2UkYz?=
 =?utf-8?B?amV4ejczR2RmRmhIMkd1U0RzMkxlTjk1QTZXcy9UVmRQYVJuMGUwbnVkQ1RG?=
 =?utf-8?B?NThGZU9pa05iUytiRjkyZWlDZVdMTGtzN080dVNOb3VSQ2tZYUhHdms2VVNw?=
 =?utf-8?B?bDJ2bzVDUzFJVk1uWkVnTVB4dFlPOEdwMjIrV054a1BLczNnYWJ4UXZ3djNl?=
 =?utf-8?B?NDZ1NWVjZGN0R2pPak1lcDR6Y2gvalcrU3RlNS9wMWVDaXg2UVFrTEQ0MXY0?=
 =?utf-8?B?WGlzc2FvZGViNnhEYlp5NExxOEJkR25aMHR6ZHk4Z0FFSnFDb3ZpeU5weG9Q?=
 =?utf-8?B?ZHZuOXVGSGdXOGlnZU5XQ01mLzZ0b0x2TDlJUytENTR3ZXd5WGwrM0Q5Q1Q2?=
 =?utf-8?B?ampKNGlmQTllSjlOZUtYbFkxeVI4bWU5UVhMZzdMelk5cURVMnduNWlQODlh?=
 =?utf-8?B?dkdrcWMzcVRsb0Ywa2NGNFlrL2ZxcVJnTVVuYWM1Ri9wWjIwMlo5Nnd2dVJz?=
 =?utf-8?B?a0pXa1h3cFdxbkVGTGdFQkQzV3R3c2JLZE1VUFFTdVRGbDdaL3E5eGZ2Vmxh?=
 =?utf-8?B?R0g5Z05TcVB3Nm9BRnArazdWTkhwVEI1ZzlYb1Q2cXIydXJMNW54emx4L01q?=
 =?utf-8?B?bGdWd3lXc3JTOUtvbDNoM2p5NFVia0RwaXl6akpXUDJHcWlNd20wNzBJRWdv?=
 =?utf-8?B?UnBkWHhHQm1rRHhPM3AyVjFsSzgzNitMdHQ5RGp5NVRDQXZnbGJmRkNRdnlM?=
 =?utf-8?B?SWRKanhybXVvbGFacGEzcjg5blVTbGVlQzcvMFF4Y0t3b0FWR0tzOEEzM2Jh?=
 =?utf-8?B?ZEJYOHRrb0hEcTNUY3dsTmFrbkFsa2I2eFJIVmhrSEJyeVhTaFlncldOSG5C?=
 =?utf-8?B?STB1clBwbU8zbkgxZTZNb3FOVXk1WjhNbWpDL3E0dFFIcGpjVDVPQTFZa1pT?=
 =?utf-8?B?Y3NmZ2dLaEh3T1ZjMForRUVPeUNFWHZScE5aRE9sUmE1OTBpa2VRWmtkU3ZJ?=
 =?utf-8?B?alR4ckJKQ3VzR2R3dmQwMkRXd1laSkxhc2dZRldEMG1POGNEY3FXcjBrbkZV?=
 =?utf-8?B?L2g4SU5yMnpMMXJvNTBIdVlpek4zS1BMUnppMmU1UkFyWDBOajZxdk1vZ3VG?=
 =?utf-8?Q?EC1Ee/ZCgjHzI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXVxVDRSaHFleFdYN1I4UzM3ejFNYVA1bDBXSEcrK1phSWxPVDRaOHd3SFlh?=
 =?utf-8?B?YWV1SUEyOE8rT0tYT0JNTmNyU1RTRGNXeitCMmFwa1lLektCSldoMytQUW43?=
 =?utf-8?B?eUhtb295UmROcldNRkRKemRDVTR3OVFOSGlsSXJzdHFib3NJKzlVS1piSTdl?=
 =?utf-8?B?bmtpRTV3VmNRZ2xjMStzWm1aVWI4b0hEYitJT2JndFY4V1JsbzYrbVdtVVUy?=
 =?utf-8?B?QWNaWjhmdG9yWGtlZEJkSHhYTCtkcVZkTEp5WWpvY0JnR1RXeGN4ekFwZ0lG?=
 =?utf-8?B?NkIzYk1Ic0ZPUm10NnFFN2NDQzI1VlpUU2Q0c05nRXV0ckl4elFYNkVndUtz?=
 =?utf-8?B?OEFuUzZaTGZvRjFVNUJjdzA0anRRaEdhYW9TT200ZVZNQzhWSjlIVkkvcjMw?=
 =?utf-8?B?VE8vdmRnUXhmbmRJRkVrZXpscjlkQURKUi8xMW5NME5hdVQ4UkhNSWVoM2ox?=
 =?utf-8?B?S2UzWm4ycndrM0NlQlgyRW5CUjBTY1lNYnh5dTNpMDJsZFpxWWZoVDgzR1lS?=
 =?utf-8?B?dVlOZzdha1JRV1BBUlhwVEVZNHlxVFRJVGUxNy81QmJndDI5L1RmTnZxblhU?=
 =?utf-8?B?dEpSa3VtbGNPZkZJWUo3VVhKYVE4ZkkvQWxmemJWeDNLQnVsU1ZqQUdoUHhi?=
 =?utf-8?B?MGVyQzB3RDR3OURRNUVDcGpiQlREaEJ6Q3htNnUxbWZka2hBSFB0eFZrZWxq?=
 =?utf-8?B?VXFYaTdZbDQ4ZzB4OTRwZEgwZlRoOUVpeWt2Q0d1M21QWWFJUDk0Snlzb1Ux?=
 =?utf-8?B?bUluV0V5enNNQlN1bHM0eVBNSXdYUGJqUEtsVHRubTRCREJnS1ZDVXhDZkxn?=
 =?utf-8?B?WmpFK0syNUcwT1dqYU1oalY3YVF4VCtROXAvM3l5QkVsZUhkeDlaMTJjYXNK?=
 =?utf-8?B?RFFWN2lQS29uUUZVd243L2xOd1BUdTBudTN5dXdNUkZtZEs0OThialRjQVZX?=
 =?utf-8?B?aFVXeitlcGRJalhMUVhDQVhmczVUN252aGY1a2o0UlFoNTV6a2I0S2J5YzFl?=
 =?utf-8?B?b1htbGFXYnFiMFhtMkR3Y0RtYjVSV3ovYW43SFpWMHcvVlNlRGRYYWNEaVJl?=
 =?utf-8?B?QmJBT0FPUmptWWFkNlYxODVJNkpSU1BwNXV0aStqWDJ0RTIzNk93a3hiK3JN?=
 =?utf-8?B?aHViUUl0SFFiVk16QmJZOFdMcEZSclA5NEpZbEgwZ1hYZkY0SC9yVG9FSXRR?=
 =?utf-8?B?Zmg1SlI2bDE4Y3NCb3djQXRLVFEzbXFFQitvcEZzUHVyUlN1U3Z2Y0lINXNE?=
 =?utf-8?B?TE4rSVFOeHF1RDM5ejJuT0NhMWNIKzRiTG41WkswYmFiUHNBNVNLQkt4NURK?=
 =?utf-8?B?cmJ3cHZtT0twT3ZpT3pQelViN0pKajlJM0JPUitlMTZRdjkwOTVaaTE1MG93?=
 =?utf-8?B?dFh1Y2JrOG1NVnB2YVE5cU5MNUpteFFESEZSakhQYXFCNGZFbmQzVU5PNzM4?=
 =?utf-8?B?Vk5IWjhxVTBDSUMzR3RhVXJSOW83d0N4VG05VXVUUjl1eENNWmZBV1krRmQv?=
 =?utf-8?B?V1B0SloxUStuM25LZXBzUjl0KzlrWjJjY1hodkNDNXF2b203dmpDUFNhOWRi?=
 =?utf-8?B?aHJCUlk4ejFFYjErQ1BFUkw5NEdia3R6RmlqdU43VXNOQ3ZJdzYrWFpiYkJF?=
 =?utf-8?B?YnBkdmdHcnErTzJ0djF5aEx1MnNCY09GQXFtS1ZUem9RcElKSWpkVThtSGVs?=
 =?utf-8?B?SjFFdytmdWJHMHFWOEUyNUZxbWh2K2srQXdnUVJKODZBMEhEU1g5RnhrRUlZ?=
 =?utf-8?B?TjhVMEkvR1A0S3hXY2Yvb0RCYUpFNThLMEJoTk10NGRIeUIvYnVER2FiR1h2?=
 =?utf-8?B?OTR3dGxMdFNrLzBGNHZaTkhUMjZ1Z2djT2xXYThXRFd1Qk9BTTBmVGRvVzV2?=
 =?utf-8?B?ZkdPeVN4akpLMCtKZnRNRkZqbHZ6b0txczQvclNLbFZoNG91M1VSMVZHbDdG?=
 =?utf-8?B?bTZ3UGJ1NysrVTF5cVlqYUhlSytHdGlkUy9tdzJ6eFplRXl5TnVxSXVHT25p?=
 =?utf-8?B?RGFtVk9JY3hnTVBDeE1qR1BqemRVckR4eU91Y1Z2V2tGd2ZXREJtUHhQa2J5?=
 =?utf-8?B?Tnpka2JsNStRZnRia2dSRi9KRnpmT0pXM0Y4K0pRemJxSTY5alRQWFlwQ2V3?=
 =?utf-8?Q?29t/n4vQ0x1S5pnFUm+OhG/sX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0d4226-c53a-4c7b-f969-08dd5145e8ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:31:25.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrXBRLRRH1bsr8QxeBNxfuI/GyH2yUf+zDc+geHrjhww9Rblxzr0H67G5aad9znVO3/djeUylucwdtYiXAtc7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956



On 2/7/25 06:34, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2025 at 07:03:38PM -0800, Tushar Dave wrote:
>> Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced
>> bugs that fail to configure ACS ctrl to the value specified by the
>> kernel parameter. Essentially there are two bugs.
>>
>> First, when ACS is configured for multiple PCI devices using
>> 'config_acs' kernel parameter, it results into error "PCI: Can't parse
>> ACS command line parameter". This is due to the bug in code that doesn't
>> preserve the ACS mask instead overwrites the mask with value 0.
> ..
> 
>> Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>
>> changes in v2:
>>   - Addressed review comments by Jason and Bjorn.
>>   - Removed Documentation changes (already taken care by other patch).
>>   - Amended commit description.
>>
>>   drivers/pci/pci.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Hi Bjorn,

Gentle reminder. Let me know if there are any review comments!

Thanks.
-Tushar

