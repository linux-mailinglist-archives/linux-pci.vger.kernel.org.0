Return-Path: <linux-pci+bounces-9376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88D91A7DF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 15:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA711C244BE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BF193099;
	Thu, 27 Jun 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DVfc5/s3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2075.outbound.protection.outlook.com [40.107.103.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B225193071;
	Thu, 27 Jun 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494971; cv=fail; b=uXpUEv8mOLXMg4ogQd09ATpa+oUcsmpZMzs6fAUAyYPa+T5POvQi7gQer8Cyb8R/DQEGwlimTD6r/sDbmlqEdbRpi5XaB+eD/QBslUVRnCASiUjzgIUgcymU9DW3wNh7u0K+r3bo9NidixwkvFe+sOh7wx7c6EYFomL0FyF5byE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494971; c=relaxed/simple;
	bh=/uVQan4GqO4C72PvhPeslVMPFDYPPNqEz0JlqdVo6Gk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZjol9GtQx4NurSqv7HUy65W8DUNSvCTaBdEOsCaWdbZHG1OFaf/Z8GvSV7FIkJcW8tyNrWj64eQ0h/qo6NGLPI9bnMHZdiYCnON5XL6kEiWBaI38k8xxYE5bJYdKwJqa26PRnLR0DYW3VRDH11SUtvRwiPZpD3QyQpAkrV9qGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DVfc5/s3; arc=fail smtp.client-ip=40.107.103.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by+r1tcp/me0dO1dGtgT8vBvRE6pQl3LN8UFuIyN0I58QYbIx5atLMVglgstpipYY4R9gSRCaU5fkS/h3rFY4PMp8u4gCgBTa74vHlvTTPEKvkgOw+/0ORGFhncKY4YKCn/uXiBrzIZf5t7YUswXd+M+/YzKLxGqjpAlgGbaCcn5GOWfQcccrbQlcBy5gYbQKRj6ysOjjFmy7RUu4+1g0wqP3UegsUigiZe+iJAyjDzS8Wp+ITcMXh65kzZs1zXjDNU+Johmc/aI3HvIwBeNjkagdyulVj4v9Mipc7wMtg8bI0E1H3ifzsWuWbYcF9UpLI02E2prmGgV+vBdWXtSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+oFVkAFQl/cQx55QNQHsu0cFKDctkGIaK7Wu2Vaq34=;
 b=oWJQ3ydAqBnR65WySWPst6QJpe1c7ufaslWfwuuhCbQ+qlNcCn5U1f7GpD7UNMKunbJWNzkFa+yOtCGvTpLro3ZDt3RYFMjEJzxWtHImG03vTA8FRluZooHcIK4ooapRoGEO4kf6taC/ETVPIQrsIBYiD7gn/yMHdwMfbqyRcK9PDgzYKfbviadrgO5o/pkldH8ygUQ4/GF05ox3PUByItiNnacO2GGxlsY682AHEGoEGIf+eB9u0VXFfOG3mqZDFqVVODnOzgeYggWolFLcwir/PGRzB9a3ntb3TWHxOjiWj6L0s9t8tc/pLe93s5B3lDEL2pSlUEe4xuU9eNviMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+oFVkAFQl/cQx55QNQHsu0cFKDctkGIaK7Wu2Vaq34=;
 b=DVfc5/s3A8kBFqkYPI/Q2UvNIpz0Q1+CqZ5iZw+P/HCqLm6EhAuHP88Qw6DSP5mLN5guxg5QGWljYYdBYRMv9mUeS4WNyEZmBfU39Xd+5czCd3Tk02xqbnLfWZPbvnuJMSWAbuUTOd7tx+uNPTQruA7T7uL74YhQiae+xUfpXAq95g/3xikC7VypV5TEnBP/3o5GRU72/eDlHc979suhGz1GqWcIDaa0fTF5XZ8ZX0N1i9W2qzDDe6vSyLQ5sHZ2ixCO1ZK7taITCWx7StIBVsmx7MQDCg3rr1ya2piDEzEKTCf4+r9jxPlkxYLDCem10dvMWlJSiJOmNtRS1QfUXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 13:29:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 13:29:26 +0000
Message-ID: <a0f50d92-defa-4241-9128-5d016f5915de@siemens.com>
Date: Thu, 27 Jun 2024 15:29:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR
 1.0)
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <819861d0-1b3a-4722-969c-d2f48b624622@siemens.com>
 <f27ee4af-eda9-49b1-aab1-2477e5a79642@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f27ee4af-eda9-49b1-aab1-2477e5a79642@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: cb228106-fe3d-469d-19ad-08dc96ad2a21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW85UndSc3pBdWRscU8yQ1RJS0Z5NU8ybWRKbUp6dDh5NkY4M1VpSW13R1Vt?=
 =?utf-8?B?QnYwc1lLS1dRMkdzQmNGNUdEcDlGZnY3UEd4Q0R3MmlaVHBVbVFPVVB5R0R6?=
 =?utf-8?B?cm1kU2NyYVNPTW5CN3U5R3Y0dW1EVmxwNTVwck1Ma0YvK25Hdmp0K1RSM3l5?=
 =?utf-8?B?dGdWNFNlYXVVZlZUT0R1UlNmV1dicEV4YjdLYkx4TDYzbmhkTXV0UmJyYWZN?=
 =?utf-8?B?OVpjREN4R21WZjBOcXRzOS9OVmd1d1hzVmppcWtXWDJiSkgvbGdKdEZzdnEz?=
 =?utf-8?B?QlFzMDc3WjE3dDQwWmJMYXcvQU1pY0RrU0NwcVZpb2kvSU5mKzMrNXFueHA4?=
 =?utf-8?B?Z0l5MlIrSTkra1FCaS9DZG01MEZGYWlsdHVHZjVnSUZVb3hCVlphSi8zL09D?=
 =?utf-8?B?S0NRbGZDUmFkWHVFaXBWNUJnU1NXU3d6UFdxYys1NjQzTHR1Y3NOVXppRmpm?=
 =?utf-8?B?cUN4c2lDLzZVRDhDNWdhaG9rd0FQakw4UldtVlJsV01ZREVOVENvbEtEbUhp?=
 =?utf-8?B?bTUvTzZZcG95N0pmMnVTcTJUL21VTHRNbW9jeGdKU2JWODhCeFV0N1BuQ0t1?=
 =?utf-8?B?RUtkWFhORUcwVTJQMnlJWER2V0VYYWxLMGg2MmdhVFVzV3hrc21RMW4vTXhH?=
 =?utf-8?B?UEFZcTdTbXVLcng2NDRJTkpxS2g0QUZQS3VCSFlidDNCNTNKZ25sWnNlY3h1?=
 =?utf-8?B?bmhDZVRWcEwxa2N4aTB2ajFFdjZvZ08rWDlyV0RZZWJRQWYzcGJBQmpEVzRU?=
 =?utf-8?B?Kzh6N0N1Y0RYLzV6ZHg1TDNPNzhmN0FsdXVNTXdnZzZKUm5ETUppMUJ5bTRz?=
 =?utf-8?B?SEV6VThYNHZpY1Z0cnRWNWh5TGV6aVYySU9vZzRER3Y4SUJQNjVIUG94NmNx?=
 =?utf-8?B?Y21NenFrWk9RTUZxb2NUNHZJQnJUTGJVY2RXaFhDTzAxelllVE12cGRKSi8z?=
 =?utf-8?B?TEswK0NyenRaekRXckFvK3lrbXc4RlM1bm9hZzJFakgyQ1pYY082a2pWSHpL?=
 =?utf-8?B?eHdzYTE4U2RDUnVIeWswYjR4UjNwUkhPKzFwTW5qMHU1NDMveVVLNm9qelpk?=
 =?utf-8?B?VkFXVHpqVkV5YS82WXVoVGY5UTZMN09mb1Q3cTlEUVBCRzAweXRScVFBNEdy?=
 =?utf-8?B?OW5iWVM5L29URmVqejUvZzFkTWVud1JtS1FneHB6aWhrQmx3ZVUyRGVMRUJB?=
 =?utf-8?B?ZnlubU1hOXN3UHNVUlFnWC96dDY5VlY4UHYvMXB5MGhkK3lMZkM0enB3WkxG?=
 =?utf-8?B?U3JZL3RMZVVwYU5tY2JqNk9jRHZnZ05mNmpKTHJSSVJYc1hpc3gxeHdRaU5u?=
 =?utf-8?B?TzgwR2ExU2s3Z3pyMDY1T2FLOTE3K0FOQytCK0pmdi9OSkhOOEt1NWZxUUJp?=
 =?utf-8?B?N2xsVXBpQ1crTXJrMFNGMmZMS3pjZE1BZE1BMHRlZ1huRVJXdVZvcllrWVZq?=
 =?utf-8?B?blF2MEZ1M3h2cHIrVVBwSzJiRDUwV3E5NEhOcVVzRTNFekpqYWsvVUtGQ0th?=
 =?utf-8?B?QVVhYnRCQ0hnaVZWcjBTYUNyWEJyTElxUi9zWjQraXFkbzZNbzJ1b1VoNjY5?=
 =?utf-8?B?WnJLaG5vbUI0ZGJNVEVFRUZoQTRaeldKbUZsQmRkNlpVaXI3UXd5Y2RMNnZU?=
 =?utf-8?B?TGpKeFdMQ0VOcVRBaFpDNFRNa1JpeTdEdGhIRlVnaDNGaEZYbUJRSlBCek9V?=
 =?utf-8?B?UC8ySk1CUWJNcnhOWXZKSmlzd05kUUhLaUxEMzJUVVhnYlNIWnhodWF3eTg3?=
 =?utf-8?Q?y6VH0Cnjoq06B/arc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anZrZit2b3J1VTZkZGVZUkliZmRKZmNucjllVFlaT3pmVERqTXVOQ2tpQVNS?=
 =?utf-8?B?QlNQZW1lQkJBTlFQS3JLWkU5T0gyck5vTUdCNytQTUFiL1BLZVZZRGFhcVhj?=
 =?utf-8?B?VnBhNHl3QTg1S01MU3Q4enVsdUhxbE5tRjhlSnF2Y0QyRTNJaXJYbEljUTRa?=
 =?utf-8?B?cFF1ZUVqdG9MS0hwdjdnbkNXa21aOWZDa2dTeFdRU1V2Y29zUm02T1QxaXlw?=
 =?utf-8?B?TEdPUHJ3eFFseFhKSTZJeDZXdS8wZG1keG0yWmxrNzNCck80ci9Kakh4TWlZ?=
 =?utf-8?B?SnozVGZ3dm1LT2Nzd2l6S0djcFdrblRxa1ZTY0tnVlNGRDM3dFh5MCtlcVhM?=
 =?utf-8?B?WDNPbi9jZEZFSnNudEtmemtNeEwzaHFBelJZQXM1U1QvempKOUhEUHlWc0Na?=
 =?utf-8?B?TjI3amh4ZWZUOWRnTFdvZFpwZXc2UHFjVGtyQlJycktjVjBYbzRFS2V0ZEFE?=
 =?utf-8?B?aDRsZVpwRGU2UzVVcElLSEIrNmIrTmtqaWFjL3JyQjM1Z2E5UHAxVEVFU25U?=
 =?utf-8?B?SDlTbkdjcTBhVks1bklCd1hKMVpkRUgzazd6UlJlOWFCNWxFTXZ5dHM1dG9j?=
 =?utf-8?B?V1llREZGNzZwV2E0bDdhRTBQQXRCTWJUMldtOXhvMDBqUlFaU0JWSTNaNFlz?=
 =?utf-8?B?MFdGMHVNRXlPbW11KzJQOWthUy92S29DK1A5ZlpEckhWT05YeWdCVGkwYjla?=
 =?utf-8?B?c0xIOVZZRkE2VnZ5ZjZvMU5nd2c4bm8rZWoydkJJM2h1OUdLYnBTTC81b3dE?=
 =?utf-8?B?ZzRoMEdMKy93NGZITW5PQ09BVEhnM1FvKzZZeGVKY0ZhRldLZG44YnVvcTdU?=
 =?utf-8?B?S0t1Y3ZJNTBIWWo0Yk5RU2xac1JmNkRubWc5dFFFc2xSU1RXc3ZpcUVGMUlu?=
 =?utf-8?B?SDQycEkrT0tkVmpRUHhneGFPdjZmemFxZTVJR0gvTDY0UEVIckRBclJrYnRZ?=
 =?utf-8?B?bTVkSGNDQ01mNW5xTTVGNG4ra2hJUFdycmNLd3I2eVRzVFpIdjRPdVFkRGsw?=
 =?utf-8?B?NmFza0pYRzExR2JSM2V6TVVIUDN1WWw5Nmx2QnV1YVBBMDA0QzR2L245aVZx?=
 =?utf-8?B?RVVmaHJHbWpOaFZ2dUcwNDhrbVFseEJZdDVsSEtuQTJhanFxakdOaUNITmVN?=
 =?utf-8?B?eGszUXgwOXE5VDlLVTZDM09PMjhyVzBreXZZQXgrNnhiZHBoN0VSSHhEekRI?=
 =?utf-8?B?WFhRMTBvam5jVmhNbkZLTmxEWG51SUNOTzZYNXJoR0FzRWJ6Mm9UcDNSM010?=
 =?utf-8?B?d29mbysxdHhHVk1rb1I2a1o1RExOcVkyK1IyY09vVURMcWNVWnd2T25rNE5T?=
 =?utf-8?B?RFBtRVVEY0lQU2w3d24yMzNWZnZIUy9vS3FYUnhvMTcwMDkreURtU2NlcS9R?=
 =?utf-8?B?MTFaK2podTBsc3A4b1U0eFVURmRjUWRCTDBuRmVvcXF0MkRQWG1IbGkzN1Q1?=
 =?utf-8?B?T1Y1V3NwRkwzVXBja3JTVzlYRHMxbnQzU1YwbTNVRUpoM3ZIQzlodzRnb3p0?=
 =?utf-8?B?YVFFYktoME5kUVZ1bllsS2JkTXlIZUx6eG1QNEJObmk5NHVZU0d0M2h0d0NY?=
 =?utf-8?B?UEtKZEhnQlVwMXhRMUs2NkgweWtQVzJ1WUVMOVJ2bVJQd0VWUkZDelRSdUpJ?=
 =?utf-8?B?azcyd0FuRDdwRlFCNk9CKytac0l2cGZhS0JEb3ZidEN4cExweitWNGFQL0pq?=
 =?utf-8?B?YXJPZm1ETk1pa2thUkdqdFVjREZ1MTdxbE5rTEVsWGVDb2RRVkIxOGU5L1RS?=
 =?utf-8?B?bTVUc3FWRmhLMGIwNFRvVU91UHdRbTkwY0swMnUzeFZCWVRJL2lGVS9JUzVC?=
 =?utf-8?B?VFFsZ1J2RzVoOHRrb1htaFZDb1RudUJENEN2cGhnYkloaW9vZXZoYXF1MlUr?=
 =?utf-8?B?d25zSUZ5c043aVNoMDZJdXVaVVNRRjFDTmRLL0xxU0NqNU4vUUdZQktERmNa?=
 =?utf-8?B?UlUxSFNuclBaU0trREJTVjkzYnJOd285NGdua3B4TDV2eE5vRmkraXVJZ3l5?=
 =?utf-8?B?enJ5RjFBWFlxT3RuRnIyRmQzV3FzWm5JVlg5bVN5UTR3UG1qUlRpdGV4eUYv?=
 =?utf-8?B?NVJsTHg0dXMyb2FyVEdnK2E1aEdLZFhKN0lQclB0Y1JIaUVnMHV4YXFvK252?=
 =?utf-8?Q?Q0p+dErjJ3SYRDf9lFo96VENi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb228106-fe3d-469d-19ad-08dc96ad2a21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 13:29:26.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCNBJ7AEy/55lT0fDEgT66UI7U3kNL/Sv644LF1nkTvp4aozd12XIxUU8y60oxggQvjjFWpRL9KRJou0c5nx0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172

On 27.06.24 14:24, Siddharth Vadapalli wrote:
> On Wed, Jun 26, 2024 at 12:10:41AM +0200, Jan Kiszka wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
>> (SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
>> inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
>> the bus may corrupt the packet payload and the corrupt data may
>> cause associated applications or the processor to hang.
>>
>> The workaround for Errata #i2037 is to limit the maximum read
>> request size and maximum payload size to 128 Bytes. Add workaround
>> for Errata #i2037 here. The errata and workaround is applicable
>> only to AM65x SR 1.0 and later versions of the silicon will have
>> this fixed.
>>
>> [1] -> http://www.ti.com/lit/er/sprz452d/sprz452d.pdf
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> Link: https://lore.kernel.org/linux-pci/20210325090026.8843-7-kishon@ti.com/
> 
> Please drop the above. It needs to be mentioned as the v1 below the
> tear-line.
> 
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Needed for the IOT2050 PG1 variants. Pending downstream way too long.
>>
>>  drivers/pci/controller/dwc/pci-keystone.c | 42 +++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index d3a7d14ee685..a04f1087ce91 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -34,6 +34,11 @@
>>  #define PCIE_DEVICEID_SHIFT	16
> 
> [...]
> 
>>  
>> +	static const struct pci_device_id am6_pci_devids[] = {
>> +		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
>> +		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
>> +		{ 0, },
>> +	};
>>  
>>  	if (pci_is_root_bus(bus))
>>  		bridge = dev;
>> @@ -562,6 +578,32 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>>  			pcie_set_readrq(dev, 256);
>>  		}
>>  	}
>> +
>> +	/*
>> +	 * Memory transactions fail with PCI controller in AM654 PG1.0
>> +	 * when MRRS is set to more than 128 Bytes. Force the MRRS to
>> +	 * 128 Bytes in all downstream devices.
>> +	 */
> 
> Comments on the v1 patch at:
> https://lore.kernel.org/linux-pci/YF2K6+R1P3SNUoo5@rocinante/
> haven't been addressed in this patch. Kindly update the patch based on
> Krzysztof's feedback on the v1 patch.
> 

Oops, I didn't even realized that the link above pointed here - let me
fix this up quickly.

Jan

>> +	if (pci_match_id(am6_pci_devids, bridge)) {
>> +		bridge_dev = pci_get_host_bridge_device(dev);
>> +		if (!bridge_dev && !bridge_dev->parent)
>> +			return;
>> +
>> +		ks_pcie = dev_get_drvdata(bridge_dev->parent);
>> +		if (!ks_pcie)
>> +			return;
>> +
>> +		val = ks_pcie_app_readl(ks_pcie, PID);
>> +		val &= RTL;
>> +		val >>= RTL_SHIFT;
>> +		if (val != AM6_PCI_PG1_RTL_VER)
>> +			return;
>> +
>> +		if (pcie_get_readrq(dev) > 128) {
>> +			dev_info(&dev->dev, "limiting MRRS to 128\n");
>> +			pcie_set_readrq(dev, 128);
>> +		}
>> +	}
>>  }
>>  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
> 
> Regards,
> Siddharth.

-- 
Siemens AG, Technology
Linux Expert Center


