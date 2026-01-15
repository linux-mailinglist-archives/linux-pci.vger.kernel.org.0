Return-Path: <linux-pci+bounces-44983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B970D28141
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CE2E305F3A3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589E3081BD;
	Thu, 15 Jan 2026 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="lggPaaZV";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="lggPaaZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020093.outbound.protection.outlook.com [52.101.69.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0D3054EE;
	Thu, 15 Jan 2026 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.93
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505230; cv=fail; b=aZ/7GrO6REHfHchOWGSvr0QMACfvqC0DXtX0XXcTJUcLTCJ7xdWPY/t+K2+9QXI2hwI3DnyBNv9X82QC3rtWJQwqOE04ShA23wyIVPwC/05Niscz8E8pgKyUsCVCZar4ILS58t2OCA4Jb4ol9JCsWqYYjnGK5xXexwfPC5tyLko=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505230; c=relaxed/simple;
	bh=vpS7dHUh/fDkIJsvOB2qS4haEUOixuM6JR0GGhcUvcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOcY2i7wFovWw0Jn9UvAtvBd3X2SS5bB26Y1YMI8CkVhA+PUs5vhj45NndzDKfzq90bxF12uyJJ9/87ROhHzyN6JZHT5v30GnkVP3q5rzKTMClu6ri9H+c3YH2rmiP5GRwiZNLs7QeqfLOT4ahj4ZbAJvg7XdX4e9/OgySrhHZg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=lggPaaZV; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=lggPaaZV; arc=fail smtp.client-ip=52.101.69.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BlC9m9aYSNxQ4XM5PSYFdrBUqQKS4b/T0WXpQkFoIkE6cypa4RykFjE6bHdwWBSbBeyt6BGfX4Wj+Ow+zjnJApk3jJjdtnw66/BC3knyBnlYYzOISSeRrvu8plxJIFCci+Zha4yqsIEhKXBFnOhpiv7DN/ln/Q0Cfzlma0C5pbZizg7lHBzqDgsQ3eSha/3+jtUBrjigaeUNxc3c4U6JSYUtYsy7H3a6Ve3dF+DRJaWABbvCHhIWlcKbknHEbVtPwJ38Csr1WtwdgqVXqDuGALcScTaOa/tT71WeyVLDzlIW3rmPenQ8vBNNv7iyImahpGVVSsBaLumHhE3CCghZgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP50CyHuI4iW3GW11ZU0wW8e7GcVdefmffPgyWC030E=;
 b=ABoeASb5NoVq02Lsa4l5Kg45EPw831t3L5h2HJG4aIUtrYHE8BMuVA2FpXxZftBGAUwhJNjlWHxH41qi535OqFRXYi2BgGjZ1lYBXcbE7ce1JH7eYlmaUmAsYjobXuvhgYPAeZm0YSSWT5ETA1UrFQXC+p2XHv8VnBUoPX7fd+dkm0/+CSn2JkXeAuADf+mFd4bzIzOMAmys9uGhxsN3/o+3hk7Op8Mjs5tutIZ17VlvcIY9siE1+qDMPSvRe41EIFRmyvf3X0OsjH21I4j58i3zZ+iNC4w9KWb7WkyVm0vZM4sy7rq06AWVw5RtO9tS+TV9D5dK+/kDt9jfJq2O/Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP50CyHuI4iW3GW11ZU0wW8e7GcVdefmffPgyWC030E=;
 b=lggPaaZV61jRw/doUeGdC7vhHPFgvE9MU2K6MEOET9TaAZB4/a37INNqMoxZuVxxCRqkFjy+tl+Eunh851c1P8P/bL1R+Z6TOYoHbvlIyAudKyqf5CloUIM0/ctY7tiGPOpb6eeXoQPxOxqHLqdO32RBtV8LxxzgGMhQJo9L5QDg3wvgvBrDbIVVdLYhS5Ih/hie19JfX4jLsYf65hHTY1Y3sXRxlrndJluTzbIsiM8HA3bv3EuYp+vDmHFnK9nS+nNDBhoxBOwnpRY/ggL5C4LZP0SQA6tQNQsf/V98kzuhs6SQfWWc3ySw6JO4/yxnQyBPfwEc1yPiiYxPe8Y+YQ==
Received: from AM9P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::29)
 by DBAPR03MB6565.eurprd03.prod.outlook.com (2603:10a6:10:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 19:26:43 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::8) by AM9P250CA0024.outlook.office365.com
 (2603:10a6:20b:21c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 19:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 15 Jan 2026 19:26:43 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 3E757200800B8;
	Thu, 15 Jan 2026 19:26:43 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown [40.107.159.125])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id D96C0200C4FE4;
	Thu, 15 Jan 2026 19:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsyn3Nhb7xP9kIqdccEQe6eBl8IixQaquR9uZsQRN2W1uzKadZbquOnCMOFlbSAMonyzzQ10a3oZMEKm1hW4sGh47zn8HShv2348et411uDDP8s1sXrA5/4+BszOLxJxKnVzP8JV7/EeAfk9SuBriTa/PBbc7W49JoDW16im47HJyHcdW9g14jx9PSWbskswUoWJy4dmEW0Y/QV1jPFMH+7t/5WDgZR7lNM8SamGZt99rOfcVWzG2vkvzdspLwt6LkE/cIMNtvycQRO1hIqui3b2FRgbxgu0QEY8xdVAcdQjKSyifrhrrKaIC8JsB23WB5ZvdY3lp5QfuS2AMxC/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP50CyHuI4iW3GW11ZU0wW8e7GcVdefmffPgyWC030E=;
 b=R6RdztqvHwrnX9g+JiwRqmc+sp56OpIFTQ3OiqjJZgxoEc8+IdQMrRc3P5f4bR6xzFFuswaIk22pnE+TEx0D1joOgvwSE7wztdck65v/tTsNMoJe9MQdQo44wnJHYbpar3yiHfIZLOKp9gILvCUVWL3fzk7cr0yRTOUWypJPwyHAGd3mPNnqBjO/Ivq/2rIYmSkILBA27webPV3OUr49yWNUq88+j0K2kOiRXMYctlpN2pJ6/R80hu28seJBeh+glpi83B+P6UMvVhuoDdPXxLDbYbzYHy0NKoZXj2Najs4QSZinT3WBhvahCSwDGsBs4EQZ/aasnoY3euAbVXnNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP50CyHuI4iW3GW11ZU0wW8e7GcVdefmffPgyWC030E=;
 b=lggPaaZV61jRw/doUeGdC7vhHPFgvE9MU2K6MEOET9TaAZB4/a37INNqMoxZuVxxCRqkFjy+tl+Eunh851c1P8P/bL1R+Z6TOYoHbvlIyAudKyqf5CloUIM0/ctY7tiGPOpb6eeXoQPxOxqHLqdO32RBtV8LxxzgGMhQJo9L5QDg3wvgvBrDbIVVdLYhS5Ih/hie19JfX4jLsYf65hHTY1Y3sXRxlrndJluTzbIsiM8HA3bv3EuYp+vDmHFnK9nS+nNDBhoxBOwnpRY/ggL5C4LZP0SQA6tQNQsf/V98kzuhs6SQfWWc3ySw6JO4/yxnQyBPfwEc1yPiiYxPe8Y+YQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by VI2PR03MB10858.eurprd03.prod.outlook.com (2603:10a6:800:27c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 19:26:37 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 19:26:36 +0000
Message-ID: <ef5d5fdc-be08-4859-a625-cdd1ae0c46c2@seco.com>
Date: Thu, 15 Jan 2026 14:26:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>
 <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0363.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::8) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|VI2PR03MB10858:EE_|AMS0EPF000001A9:EE_|DBAPR03MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ce162c-b732-405e-1c54-08de546c040a
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Sis5Wjl4NkRNaHVXdkRyL0xKOHR4M0YvdGNSc0w0WmxiWTd3NGthck95QnEz?=
 =?utf-8?B?MnFTR2NnKzlGSUM3eEVsTUwybmtJOTV2QkYxYjR6UzUyU3p3WWlPZnFXcnhY?=
 =?utf-8?B?MmROMlB1SkRKTXhJbWdDblVqbE1zMG8vWlhIZGh0dVZzd2I5QVc0UTJ3bkYx?=
 =?utf-8?B?Sm1YRUlCYklDNDJ2NEYva09nbEE3ZlFNSXoyRWxVV0sxMFpXcnY0TzV3cGl3?=
 =?utf-8?B?UGduS1hUZFR6SmtzeW0zZENsc2phTW1lQmtuN2d1L3Y2bTZiSGdZd3VkOGtR?=
 =?utf-8?B?czNIMnJQcFBPaDNsdjVHaU0xWDQ1U29ZNjRCcUtVQk1halVPS0g2cVJLUkRp?=
 =?utf-8?B?djNCVTVIUU11RHR3bmZwUkJhSDNNUVA2ZGlWWmNjM3ZWcXQ4WDRIRm1HUUxE?=
 =?utf-8?B?OXExUVRhQ0lrQ013MXNUMTBhMURWZDk4OGgzVldmTTlFbXdvN1VEYkpZVTBJ?=
 =?utf-8?B?SXp2S1ZoM1dudjlPTFBIcEk2Y0JUNkk2enpTVEY4MmR0V29wTW9hTGt1U3Zq?=
 =?utf-8?B?Wmx5MzhQVkpHamtWU2pQUVYxYlI3akRhcjc0bXgvdUR1c21FdmozQ2wwYlUz?=
 =?utf-8?B?WkJFK2txS1cvQkNlakk3VzBLcU9IY0RqdytEcGlNZVlnUXFZZjRJeHdCR0xv?=
 =?utf-8?B?RGZkd1BtVWN6WW80cDJOL2tLd0Z3aTExS2ZUTy9yd1dkK2IybVJ1bkZSUW0v?=
 =?utf-8?B?bE1CT0IzK2s0MkFEMjJKOFlHbFpWb0tRTTdJUVJkakxzYlRXbFRIU1RnTFZO?=
 =?utf-8?B?ejN5Nk03TTRKUHVJMjdpR1VZOEticGhocEFRMlVVUTB1cE8rNXdwanR2ZExv?=
 =?utf-8?B?SW80NTRJNjZlcFUvVnI4M2kzYTMxY1dtdUkrSFZRK1BRcEdGTHcyZE9kSXd4?=
 =?utf-8?B?NDhxQUtPZlRrYWU3YTY2NTdHUVRPbmR1RzZnR1J0ZTRscmN4dWtQVlQ3S0JD?=
 =?utf-8?B?dDJZSjBJRkVoTUpSQXlYeEpyekQ1aW4wZVRGZGRWT3FXOHgwM2dFRXdyVU9y?=
 =?utf-8?B?Y0FLTjYyQzFXZ3A5OGNCd0s2ZFdzb1lqZFVxR1FYOC9uYnBFeW9BSE5EKzdq?=
 =?utf-8?B?N2x6bjc3dGdjR3A3L3pFYkg3OFFBUlZGRktuNm1ncGpJcGVvQVJYRTVPNmtp?=
 =?utf-8?B?SFZtbytvdUp6ckdNV3BRWjBxNjQxeUJtbkt5d2FUTWhYRG1tYmhHVnkydkxi?=
 =?utf-8?B?VlNLS0liOGRaTkRKT2R1bXVKK3lEYmFRY2VmWUgrWUF3Ti9XcTF3aW93TVI2?=
 =?utf-8?B?aDZ0VXFEdTlScFd6T0JWekVVRmNjRUxKR2FieG5KRm5ZK1lhS3QzNS8zNzVq?=
 =?utf-8?B?bm5jMFFnUVh2bzNJSFRWbDl2SEZhM2pFRitoRWlpSEoyOERuN201SzZUQnRJ?=
 =?utf-8?B?YmRiL1ZuWWUwY29qM3BJY2NqS3F4bHdqcGNVL3lXdW83bWFPWmNuR3cwdlRp?=
 =?utf-8?B?Ui9vMWtvUzFBb0JlajhackF5YUdhUmNzaklVS3VPbll6VHh5c3lJSUpUWlVo?=
 =?utf-8?B?MGUxR1ZQcll6Z0xpdTk4UUYxR05MN29yclpRZDhYNWFYTXJqWEpSSGw5YUJr?=
 =?utf-8?B?bi9xZWRRVTNoVFpnODBZdWQwbWszOFhFbVV1bFQ0bndBUDZGNlF1cWpuTTJk?=
 =?utf-8?B?U3BuWVdQbnpJMTJGSnJhRFJXbktrRVpYYnBja3JML2V2Z0hNVXFVVGFoVmFI?=
 =?utf-8?B?RC95cTdSQkIrUHlReCs4QWQyZVVMSStqU081RDRQa3lnRm5RU1c2VFgrUy9V?=
 =?utf-8?B?VFhhUHYvVDR0OGkzWitTcVBjd1VGVXcxQVUzeElNZlRFU1J5MlNNb1ZYdlcv?=
 =?utf-8?B?VTl1ekdPUGxzVGdya0RWUnRtSFFSY3hiRGRKZi9UMkVOanFpY29oVnZrMnk0?=
 =?utf-8?B?Sm5NcjNVZHptUHJ2VlZhNjRhK2xTV05HQkZLdVBpZXdyRTYvVHdmWkxXMEJH?=
 =?utf-8?B?OXYzUG5oNThGenVQa2NaV29pbk1UNHBhOU42STFSL1NPL1ZacmZSdlZjeTlG?=
 =?utf-8?B?QnVKTFpNYWRtTlo4MTVDQWhYdFc5ZkMxbysxMGx1UklZc0wzb0Z6Z2pra1Rt?=
 =?utf-8?Q?cQckuD?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10858
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	939d4442-6a21-4ffa-8fb3-08de546bfffb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|36860700013|14060799003|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG13eHNRVkhtY2NySUhRMmlHeEdSanZlN2JTRE1NWEdtTVNRZVM2QStldFZR?=
 =?utf-8?B?RTljUHpENEVJVkdEeGM5d3UxZFV2NzN3Q215M1FIU0dLQ1lzM2FpbytkRjdn?=
 =?utf-8?B?ZEpTd2M3Z0ZPZmt6Q3N5Ui93ZjFnUkFpY0tHTzJyMzdNYkFBRWFKZkN1bHRR?=
 =?utf-8?B?SXVEOEtaWG5uT252S28weEJsbzI3NVhnYitpcUlldHJoZ2twZm02cmF5WjdV?=
 =?utf-8?B?QkZ5aVliWVNHMGJZY1BieXpKTjRTRTNYbU9wUzloM1VCV1pwZERxb3NabmpR?=
 =?utf-8?B?a3lCTC9XMDhyOThxdk9Na2huSnl2bWVUMnp0cHZZT0dyUDFWSS9KZmVVTWxp?=
 =?utf-8?B?VnoySEJsaUZlZ3FXS3psSlNSTkYrVks3WjZGOXdwaDRrRUF3ZGpNenZnM3BK?=
 =?utf-8?B?WG9YV2U3dzgyTnFudndSZ1pyRk5QaE1TWW1XT1F5MTlkV0JNaVB6TWxCS0Fw?=
 =?utf-8?B?TzZYVE5ma1hhcFV4d1dXL1ErbWFwL2tndWVZNDBoOFRCWDR3K0x5ZUVmR1Fm?=
 =?utf-8?B?LzRweFRqdyszdmw3bkxGcUIwdHRJYWRERjFTaEU4dWhjcEY0RTFUb1lXYit6?=
 =?utf-8?B?dWlQbDg2cDFHeTFUaHRYOFpaeWdZdFFkc3djd2hpVUliZ1NHSW9WbkhkeS9y?=
 =?utf-8?B?Y2RnUHc0QnhvWm16Uk5HWGtOMnhmYXhRUXhqT0dWSVJnc2hCRGFDL09WZ3pu?=
 =?utf-8?B?U1ZrNkRRc0c4enkzenMvcjI1dVMyNkZ5K1JCSTVMaE00cEFCbG9mMEozT2tL?=
 =?utf-8?B?QUc2OVB0VTBPQ2NiS1BrZmpaMjBMM2R1SDEreUhhcjJpRXBXdUJsbDJKdEVL?=
 =?utf-8?B?RENUOGtOSHdRdHJWSDBIVmJkMXk1NnNSN21yOWZjSHVzenppMmVkVnJGdmha?=
 =?utf-8?B?bCtEcU44RENZZzhnVnI2OE0xNlprZ0xtWmV1S2RTOENVVkhNMmNtc0VRWUFM?=
 =?utf-8?B?bHNUdTAwZjJ3dzZjWnN4YUhvc2krSHNkQlVweUNCZDVaOXJmREQzVE0vTW5p?=
 =?utf-8?B?MW1FWUJlcjJJVkRmcUU4VngwSWxlNnBOT1BxRWczMmVaY3FCR2djVWhJaG4y?=
 =?utf-8?B?S1pqdzdTRDZ2Qm5hVEprQkR1ZlVlb3dSMnlLSSt6WGZ5dVZ2SmRQU2Z4Q0RQ?=
 =?utf-8?B?ajdDUmpWVXJabEZuMmR6SGUzQjZmZ3Fyd0NBSXUvNVp6aDdTTHVqb2JCVXVr?=
 =?utf-8?B?OEJUaEFDTUxEMDliL2k4MldZVWJOTWhRN3JhOUhvL2ZrUzRTMFVwSEg2cGhx?=
 =?utf-8?B?SW9FNmp0MTdMKzZaNUVXQ1BFMWdaNThmWlRYWWpqTEx4NlpEdmg2VksyZjhT?=
 =?utf-8?B?NWd4TmNua28vTFprT2FMZG82UitKN1JHVzdvdVl2aTFIdHVUZk5BSDZIQmk4?=
 =?utf-8?B?VVZ1OWtJQmU3UmR1TFZ2d25ld1MyWmR0eEtmMWhNTlgyWS9Tb2xHSlc2Nkdm?=
 =?utf-8?B?VHhjU0ozUzB6RzA2azdCa21JalFTL0V2aXNjTk9LZFdxSzFUTTllWHo0eGs1?=
 =?utf-8?B?dU1UN0hqTEw3TS90cWN2ODhqaEVyT3J5SlZFNVI2RThaN3hFTlVUN1NscFpl?=
 =?utf-8?B?WFhwMzZON0FENGJHaGo0NC93dHA3aGFGWDJZUlpJdWdSY3ZpVmJMcmJVY1RQ?=
 =?utf-8?B?WGkwV2hhZGNWUVJ1Ti8zcjJ4M1ZRN0MxQldzVklnZmRGRGdNZlkxekRaTysz?=
 =?utf-8?B?cFhSek0yWnd3YXNmODJUa2p2YTFpOU9TVE15anQrNGFOVmMzMTlocldmYnA3?=
 =?utf-8?B?N25PellMSE9vZTR6dnUzcVF2bmFsbUYyTzVjb2tSRVdHdnpoVUJxY2p0UHNz?=
 =?utf-8?B?UWhkOGZHTTZoelVSWURkd3lOd2Q1OTZnN1BRRkF6bVhrK05VenV0WEtzRG1r?=
 =?utf-8?B?Q2FlL29iNWMwTzJFdSt6RTVRUUdFLzcrWmxQYjZWNW1jcDNlMUJOZG5ob3BU?=
 =?utf-8?B?SnNTVk5mWDdNOS8xWWcwS3E0bWFjWDhSTEJWUXdoNkw5R3R2TWV2VnZYeTBN?=
 =?utf-8?B?bE1FUG9FeDFvM2Q3NjF3SXRQSUVhOWV2NTJ1TGZtM0xzL1NPTUtGeFNmR2Nw?=
 =?utf-8?B?YzZkaVdaakpiUkVPWjF1YnNQbS9LSU1NaXRiakF6R3NXNGc1M2xlK0ZtcklD?=
 =?utf-8?B?RkhvbHJlU3ZVR0V4VThBUHUvMkRMV3dOdFY0RWgwdVJRckN6ZUxLRU5RVGlh?=
 =?utf-8?B?UUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(36860700013)(14060799003)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 19:26:43.3729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ce162c-b732-405e-1c54-08de546c040a
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6565

On 1/14/26 03:48, Manivannan Sadhasivam wrote:
> On Tue, Jan 13, 2026 at 12:15:01PM -0500, Sean Anderson wrote:
>> On 1/5/26 08:55, Manivannan Sadhasivam via B4 Relay wrote:
>> > Hi,
>> 
>> I asked substantially similar questions on v2, but since I never got a
>> response I want to reiterate them on v4 to make sure they don't get
>> lost.
>> 
> 
> I did respond to your queries in v2, but lost your last reply in that thread:
> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2f8269249f%2d48a9%2d4136%2da326%2d23f5076be487%40linux.dev%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-8453843623be88c725b7c9a8baf78220575003f2
> 
> Apologies!
> 
>> > This series provides a major rework for the PCI power control (pwrctrl)
>> > framework to enable the pwrctrl devices to be controlled by the PCI controller
>> > drivers.
>> > 
>> > Problem Statement
>> > =================
>> > 
>> > Currently, the pwrctrl framework faces two major issues:
>> > 
>> > 1. Missing PERST# integration
>> > 2. Inability to properly handle bus extenders such as PCIe switch devices
>> > 
>> > First issue arises from the disconnect between the PCI controller drivers and
>> > pwrctrl framework. At present, the pwrctrl framework just operates on its own
>> > with the help of the PCI core. The pwrctrl devices are created by the PCI core
>> > during initial bus scan and the pwrctrl drivers once bind, just power on the
>> > PCI devices during their probe(). This design conflicts with the PCI Express
>> > Card Electromechanical Specification requirements for PERST# timing. The reason
>> > is, PERST# signals are mostly handled by the controller drivers and often
>> > deasserted even before the pwrctrl drivers probe. According to the spec, PERST#
>> > should be deasserted only after power and reference clock to the device are
>> > stable, within predefined timing parameters.
>> > 
>> > The second issue stems from the PCI bus scan completing before pwrctrl drivers
>> > probe. This poses a significant problem for PCI bus extenders like switches
>> > because the PCI core allocates upstream bridge resources during the initial
>> > scan. If the upstream bridge is not hotplug capable, resources are allocated
>> > only for the number of downstream buses detected at scan time, which might be
>> > just one if the switch was not powered and enumerated at that time. Later, when
>> > the pwrctrl driver powers on and enumerates the switch, enumeration fails due to
>> > insufficient upstream bridge resources.
>> 
>> OK, so to clarify the problem is an architecture like
>> 
>>     RP
>>     |-- Bridge 1 (automatic)
>>     |   |-- Device 1
>>     |   `-- Bridge 2 (needs pwrseq)
>>     |       `-- Device 2
>>     `-- Bridge 3 (automatic)
>>         `-- Device 3
>> 
> 
> This topology is not possible with PCIe. A single Root Port can only connect to
> a single bridge. But applies to PCI.

OK, well imagine it like

     RP
     `-- Host Bridge (automatic)
         |-- Bridge 1 (automatic)
         |   |-- Device 1
         |   `-- Bridge 2 (needs pwrseq)
         |       `-- Device 2
         `-- Bridge 3 (automatic)
             `-- Device 3

You raised the problem, so what I am asking is: is this such a
problematic topology? And if not, please describe one.

>> where Bridge 2 has a devicetree node with a pwrseq binding? So we do the
>> initial scan and allocate resources for bridge/devices 1 and 3 with the
>> resources for bridge 3 immediately above those for bridge 1. Then when
>> bridge 2 shows up we can't resize bridge 1's windows since bridge 3's
>> windows are in the way?
>> 
> 
> It is not a problem with resizing, it is the problem with how much you can
> resize. And also if that bridge 2 is a switch and if it exposes multiple
> downstream busses, then the upstream bridge 1 will run out of resources.

OK, but what I am saying is that I don't believe Bridge 2 can need
pwrseq if Bridge 1 doesn't. So I don't think the topology as-illustrated
can exist.

It's possible that there could be a problem with multiple levels of
bridges all needing pwrseq, but does such a system exist?

> If bridge 2 is a hotplug bridge, then no issues. But I was only referring to
> non-hotplug capable switches.
> 
>> But is it even valid to have a pwrseq node on bridge 2 without one on
>> bridge 1? If bridge 1 is automatically controlled, then I would expect
>> bridge 2 to be as well. E.g. I would expect bridge 2's reset sequence to
>> be controlled by the secondary bus reset bit in bridge 1's bridge
>> control register.
>> 
> 
> Technically it is possible for Bridge 2 to have a pwrctrl requirement. What is
> limiting from spec PoV?

If this is the case then we need to be able to handle the resource
constraint problem. But if it doesn't exist then there is no problem
with the existing architecture. Only this sort of design has resource
problems, while most designs like

     RP
     `-- Bridge 1 (pwrseq)
         |-- Bridge 2 (automatic)
         |   |-- Device 1
         |   |-- Device 2
         `-- Bridge 3 (automatic)
             `-- Device 3

have no resource problems even with the current subsystem.

>> And a very similar architecture like
>> 
>>     RP
>>     |-- Bridge 4 (pwrseq)
>>     |   |-- Device 4
>>     `-- Bridge 5 (automatic)
>>         `-- Device 5
>> 
>> has no problems since the resources for bridge 4 can be allocated above
>> those for bridge 5 whenever it shows up.
>> 
> 
> Again, if bridge 4 is not hotplug capable and if it is a switch, the problem is
> still applicable.

This doesn't apply even if bridge 4 is not hotplug capable. It will show
up after bridge 5 gets probed and just grab the next available
resources.

>> These problems seem very similar to what hotplug bridges have to handle
>> (except that we (usually) only need to do one hotplug per boot). So
>> maybe we should set is_hotplug_bridge on bridges with a pwrseq node.
>> That way they'll get resources distributed for when the downstream port
>> shows up. As an optimization, we could then release those resources once
>> the downstream port is scanned.
>> 
> 
> That would be incorrect. You cannot set 'is_hotplug_bridge' to 'true' for a
> non-hotplug capable bridge. You can call it as a hack, but there is no place
> for that in upstream.

Introduce a new boolean called 'is_pwrseq_bridge' and check for it when
allocating resources.

>> > Proposal
>> > ========
>> > 
>> > This series addresses both issues by introducing new individual APIs for pwrctrl
>> > device creation, destruction, power on, and power off operations. Controller
>> > drivers are expected to invoke these APIs during their probe(), remove(),
>> > suspend(), and resume() operations.
>> 
>> (just for the record)
>> 
>> I think the existing design is quite elegant, since the operations
>> associated with the bridge correspond directly to device lifecycle
>> operations. It also avoids problems related to the root port trying to
>> look up its own child (possibly missing a driver) during probe.
>> 
> 
> I agree with you that it is elegant and I even was very reluctant to move out of
> it [1]. But lately, I understood that we cannot scale the pwrctrl framework if we
> do not give flexibility to the controller drivers [2].
> 
> [1] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2feix65qdwtk5ocd7lj6sw2lslidivauzyn6h5cc4mc2nnci52im%40qfmbmwy2zjbe%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-377ad79c69a5ff9c69de76d9fcf5f030d066027a
> [2] https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2faG3IWdZIhnk01t2A%40google.com%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-9a33d827cf703f2827fca86fd99acf563ca26bd9
> 
>> > This integration allows better coordination
>> > between controller drivers and the pwrctrl framework, enabling enhanced features
>> > such as D3Cold support.
>> 
>> 
>> I think this should be handled by the power sequencing driver,
>> especially as there are timing requirements for the other resources
>> referenced to PERST? If we are going to touch each driver, it would
>> be much better to consolidate things by removing the ad-hoc PERST
>> support.
>> 
>> Different drivers control PERST in various ways, but I think this can
>> be abstracted behind a GPIO controller (if necessary for e.g. MMIO-based
>> control). If there's no reset-gpios property in the pwrseq node then we
>> could automatically look up the GPIO on the root port.
>> 
> 
> Not at all. We cannot model PERST# as a GPIO in all the cases. Some drivers
> implement PERST# as a set of MMIO operations in the Root Complex MMIO space and
> that space belongs to the controller driver.

That's what I mean. Implement a GPIO driver with one GPIO and perform
the MMIO operations as requested.

Or we can invert things and add a reset op to pci_ops. If present then
call it, and if absent use the PERST GPIO on the bridge.

> FYI, I did try something similar before:
> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flinux%2dpci%2f20250707%2dpci%2dpwrctrl%2dperst%2dv1%2d0%2dc3c7e513e312%40kernel.org%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-e06652b06144d91b37cae1f9289747fe7cbe0762
>> > The original design aimed to avoid modifying controller drivers for pwrctrl
>> > integration. However, this approach lacked scalability because different
>> > controllers have varying requirements for when devices should be powered on. For
>> > example, controller drivers require devices to be powered on early for
>> > successful PHY initialization.
>> 
>> Can you elaborate on this? Previously you said
>> 
>> | Some platforms do LTSSM during phy_init(), so they will fail if the
>> | device is not powered ON at that time.
>> 
>> What do you mean by "do LTSSM during phy_init()"? Do you have a specific
>> driver in mind?
>> 
> 
> I believe the Mediatek PCIe controller driver used in Chromebooks exhibit this
> behavior. Chen talked about it in his LPC session:
> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flpc.events%2fevent%2f19%2fcontributions%2f2023%2f&umid=db5ea813-d162-4dc2-9847-b6f01a3e22ce&rct=1768380513&auth=d807158c60b7d2502abde8a2fc01f40662980862-59ecd8a94baa970f1f962febb6fe20f15058ef42

I went through 

mediatek/phy-mtk-pcie.c
mediatek/phy-mtk-tphy.c
mediatek/phy-mtk-xsphy.c
ralink/phy-mt7621-pci.c

and didn't see anything where they wait for the link to come up or check
the link state and fail.

The mtk PCIe drivers may check for this, but I'm saying that we
*shouldn't* do that in probe.

>> I would expect that the LTSSM would remain in the Detect state until the
>> pwrseq driver is being probed.
>> 
> 
> True, but if the API (phy_init()) expects the LTSSM to move to L0, then it will
> fail, right? It might be what's happening with above mentioned platform.

How can the API expect this?

I'm not saying that such a situation cannot exist, but I don't think
it's a common case.

>> > By using these explicit APIs, controller drivers gain fine grained control over
>> > their associated pwrctrl devices.
>> > 
>> > This series modified the pcie-qcom driver (only consumer of pwrctrl framework)
>> > to adopt to these APIs and also removed the old pwrctrl code from PCI core. This
>> > could be used as a reference to add pwrctrl support for other controller drivers
>> > also.
>> > 
>> > For example, to control the 3.3v supply to the PCI slot where the NVMe device is
>> > connected, below modifications are required:
>> > 
>> > Devicetree
>> > ----------
>> > 
>> > 	// In SoC dtsi:
>> > 
>> > 	pci@1bf8000 { // controller node
>> > 		...
>> > 		pcie1_port0: pcie@0 { // PCI Root Port node
>> > 			compatible = "pciclass,0604"; // required for pwrctrl
>> > 							 driver bind
>> > 			...
>> > 		};
>> > 	};
>> > 
>> > 	// In board dts:
>> > 
>> > 	&pcie1_port0 {
>> > 		reset-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>; // optional
>> > 		vpcie3v3-supply = <&vreg_nvme>; // NVMe power supply
>> > 	};
>> > 
>> > Controller driver
>> > -----------------
>> > 
>> > 	// Select PCI_PWRCTRL_SLOT in controller Kconfig
>> > 
>> > 	probe() {
>> > 		...
>> > 		// Initialize controller resources
>> > 		pci_pwrctrl_create_devices(&pdev->dev);
>> > 		pci_pwrctrl_power_on_devices(&pdev->dev);
>> > 		// Deassert PERST# (optional)
>> > 		...
>> > 		pci_host_probe(); // Allocate host bridge and start bus scan
>> > 	}
>> > 
>> > 	suspend {
>> > 		// PME_Turn_Off broadcast
>> > 		// Assert PERST# (optional)
>> > 		pci_pwrctrl_power_off_devices(&pdev->dev);
>> > 		...
>> > 	}
>> > 
>> > 	resume {
>> > 		...
>> > 		pci_pwrctrl_power_on_devices(&pdev->dev);
>> > 		// Deassert PERST# (optional)
>> > 	}
>> > 
>> > I will add a documentation for the pwrctrl framework in the coming days to make
>> > it easier to use.
>> > 
>> > Testing
>> > =======
>> > 
>> > This series is tested on the Lenovo Thinkpad T14s laptop based on Qcom X1E
>> > chipset and RB3Gen2 development board with TC9563 switch based on Qcom QCS6490
>> > chipset.
>> > 
>> > **NOTE**: With this series, the controller driver may undergo multiple probe
>> > deferral if the pwrctrl driver was not available during the controller driver
>> > probe. This is pretty much required to avoid the resource allocation issue. I
>> > plan to replace probe deferral with blocking wait in the coming days.
>> 
>> You can only do a blocking wait after deferring at least once, since the
>> root port may be probed synchronously during boot. I really think this
>> is rather messy and something we should avoid architecturally while we
>> have the chance.
>> 
> 
> By blocking wait I meant that the controller probe itself will do a blocking
> wait until the pwrctrl drivers gets bound. Since this happens way before the PCI
> bus scan, there won't be any Root Port probed synchronously.

You can't do that because the pwrctrl driver may *never* be loaded. And
this may deadlock the boot sequence because the initial probe is
performed synchronously from the initcall. i.e.

do_initcalls
  my_driver_init
    driver_register
      bus_add_driver
        driver_attach
          driver_probe_device

If the PCI controller is probed before the device that has the module
you will deadlock! So you can only sleep indefinitely if you are being
probed asynchronously.

-----

Maybe the best way to address this is to add assert_reset/link_up/
link_down callbacks to pci_ops. Then pwrctrl_slot probe could look like

    bridge = to_pci_host_bridge(dev->parent);
    of_regulator_bulk_get_all();
    regulator_bulk_enable();
    devm_clk_get_optional_enabled();
    devm_gpiod_get_optional(/* "reset" */);
    if (bridge && bridge->ops->assert_reset)
        ret = bridge->ops->assert_reset(bridge, slot)
    else
        ret = assert_reset_gpio(slot);

    if (ret != ALREADY_ASSERTED)
	    fdelay(100000);

    /* Deassert PERST and bring the link up */
    if (bridge && bridge->ops->link_up)
        bridge->ops->link_up(bridge, slot);
    else
        slot_deassert_reset(slot);

    devm_add_action_or_reset(link_down);
    pci_pwrctrl_init();
    devm_pci_pwrctrl_device_set_ready();

--Sean

