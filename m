Return-Path: <linux-pci+bounces-36355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35848B7F31C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A61888C15
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958032BBF6;
	Wed, 17 Sep 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MUyzuQqZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836A328996;
	Wed, 17 Sep 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114923; cv=fail; b=OD82qNmqqeN4xcCUWUZT1QkHd8NAGlyLiC5P981MB2/1awdg5et7sDjaq/WlnqmazG3Owqnz1cSnHs20LOsJK7TdfVjeqS0iX0pREcQ1uNKfPnnMXovOT5vh+wNlsdJ7+4zRTML6YpG7ofGgKkhQrsFymDrnFOxY/sjxEK5ZHOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114923; c=relaxed/simple;
	bh=ltbCNBD35a7PITe1HFAxpQnVIQutTMXBV3EmUCNvlcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tw86D/ZUd8Sze0m7Du7G7RlOSJZ+ezK9dLLXMVmLtr0SD5sHxji2FYa7sNhIHNSXDEuMA8w1+m/BDwoe+LtJGLEoCUExJu1oHHvXDFyA9vQSd3deTPCx9mYwGWA5sQgnC80SDsv45r4Lwv4eZxYE+LKPIrCAIEkuNX0iHeUpqRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MUyzuQqZ; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBdW2dDrike6X8W5vqLHPg5/Z5NOBfFW/J6woXfDbbFV3l7j8RESn3Ev9uY9S8BzrPdh8cRqfeg9IJ6VRO1329ee1iVD9mLnW0rEOnVmmb6NqpJy2z/nyPijs1anIZVEkOePBCG/nRvWkm67gKwKpvdSTlaXv2MjvAtvKb/3knRne3+dZZtRrXV+V+aIUtD2bpY6UMG+vPQgyVl1TF1nJMtNt+6+1c7ljXPYxfmNfh1QL+jY1BgpN7kFcFgZEnDntPL935Kc51HWwnLKCYQ4YMeoO3rjDOEzfyO6zsXcPhTfostIy3HxfBoBbxgDn8g3Sp+Wp6Ks7KehLrQvfQY1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S21Fx5CZ0ha03OV2CVVgSE8ijAYCSnrbzMqsEb1dJ8s=;
 b=W1fStj629wiJYOSCGNt75Qt2HgH4UaZo6Ki9SomRhVfJl5WOwL4sLF6H8iI5IMT3AmWrsVciNxOAjqPUIVw3v69QfnZplEcEyBzN1wOjw3IN6Zvw5XVM1zNPUUCM6PJskAWLSU6u2jLruKcdD4N612TExN1mvozjElGNGptklC1Z0CMcrKtC963Xxu2Y8s+rnnw3EoMxAaPGELURYGk11CejYEkqVmIcjbWhw76mFkEy6Y+HUZC1rAanQu6ftg0AzIr/+35N95uPrbVjRMLbjSbhNQ141VuD76zI+dooW0AMI2rejCu+/a97cvR71vW8vKiiaOcRJQ75GQZTl7BLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S21Fx5CZ0ha03OV2CVVgSE8ijAYCSnrbzMqsEb1dJ8s=;
 b=MUyzuQqZbaFT6AVPK/0c/W+7uA4VpUBZlRpr3aZAIyGB7s1VJHQF+DSN/ux9ZP/daw+A4vHo1ZAWylozp/Wkltc3h3NAhlYSKzIjJ5NLh2Lb8d0XV5FVN0dTYyRwlVL7eOVhr6XVdDlh8icXpFVYXKNYb1+jqDPVvF2Wz6zb9hK1BHmsz5NpqjT7I8nX2cL26H+tXTMnHrQzrhUifrDUp9fEtA8iBLOdCPJGwkJFGwSMPL0vpqTq/kw1H/YuwOURjWvttkK1DuMZ7pMWfyeDBuG0lNRPcsYIMxveC7NWIDpxCUd8c+x4UrAfVHfizm6P+VIv+v8x0ZYogdwjjrCS7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 13:15:12 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 13:15:06 +0000
Message-ID: <526b895c-adb3-4734-bb2a-018759b66f14@nvidia.com>
Date: Wed, 17 Sep 2025 14:15:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: tegra194: Handle errors in BPMP response
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250911122728.1465254-2-cassel@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250911122728.1465254-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f19ff7-3b7f-4c55-00e8-08ddf5ec385c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjBsQ3JoWHplVGVWOXd5QXRVTXJiYjdCYkEvTXVJK2pqaHJMWThRVHhwRENQ?=
 =?utf-8?B?ZTI0S253aXNQOEthTXRXOEEwTjdkUHlLQWZjNXY0TGgyQ3Q1VjVuU1ZCTDJH?=
 =?utf-8?B?alRRVzdVL1lsOU00a0FkNU94VUFITkhLZjhTVDJucEdGbkFxUk0xNUZxLzN4?=
 =?utf-8?B?Z1hGdHdMZXNmMnY3MVAxSFUzY2FnbjVsQVdRS2dtTHUzNUJVL1RXZDcwbVJz?=
 =?utf-8?B?SmFpeXNVV2Q4SURNdFE3YlpKcWdwenVUcWFFcnhjQ0F3ZEtxZWsxYkVxTU1h?=
 =?utf-8?B?cjhKNFBwZVcvV1M4Vm1xbGxDcVBVaUFibHplTXV4RFVlR3AwV1FoUkJyT0dW?=
 =?utf-8?B?ODVkWHNUT2p0TGRLckkvQm5ZRjI3VFJTQU5Na3RzYzkrbVZMT3RVelJPUXV6?=
 =?utf-8?B?ellCWUlCa3dsK0poOUhhdXRvVC9uby9IK1VXQ0tLejRHVnNRMUg4dGdjaGZP?=
 =?utf-8?B?YXBNYTlaWnpqdFMveXVJSHkydk9hWjgrUWN1eE94UDVHN1YzZEQvNDl3Y21i?=
 =?utf-8?B?SHZpUFJEcmdYZjdCMzdtL1AyTDdlZjBIbjZrOEZ6Nnk4Z2E5RHVKdldDY1l0?=
 =?utf-8?B?Sk1abXJGdUVxc0dvWmxNU3RMQ3NJSTIxSDVFVG43Y0JnUUpncytWOGhMSkE2?=
 =?utf-8?B?dWxmWXBWVFdhbWFlVnB6NGdNaXphYWJyOFh1TC9JVkpMRzNLS3BGQk56bmpO?=
 =?utf-8?B?cE4rUmZxelhCa201VXFtSUxmbC9nam9BeGl1Sk8rby9SL0RsWUNZV1RWeVRT?=
 =?utf-8?B?NmRtTzMxZ1FLdWY2QXNLWjZxelVramluTmM3ZENSdFlQTEJqTkhKMlJHaXkv?=
 =?utf-8?B?WUJNYXdYRDdncUR6VzQ1K1VZZkhnQ08wcTIxMmZISkgrc0E1QXNQRU43NEFV?=
 =?utf-8?B?NFBGMmROblYvNlBmSm41ck9YRlY3d1hVTnFCQ2VXMkhybWc1blN0Rkc5R1lu?=
 =?utf-8?B?d28xWkRFemlGRUtyc0RWMlJCK3BlSjdSRFhOY25xQVprVzZXYkMyVVJkZndB?=
 =?utf-8?B?dENHalEzbXYyKzFabEVLN2NVVGtISTRSUGdSMk9qR1JFOHN2Y1l4VDNkM0ts?=
 =?utf-8?B?amlNNmsrNVpTV084dmQ4Nm5UWWxqT2E3Y3JONVZhVVpIQWdIVnJJeDhrakFX?=
 =?utf-8?B?R2t6cVlNQVpwbVZXUkk4cis0dUs5UFpLdVVNcVJhaVBhMjhVdzlZZFI1bnJH?=
 =?utf-8?B?Ym1TQnR6b2l2aFo3elc3UmxBU2ROK05xUUVUL1dROHdLdkJqZlByeTIwMC9H?=
 =?utf-8?B?TjRnKzQ5ZUlqNCs2bVVya1p5S1RUNEQxU3UxMVFzcWJWKytKSXpXS3FNbm5J?=
 =?utf-8?B?L0ZOZ3ZoYmluc05rc1hQeEN1dmsyK2g5a1pqWGdvc0xLTUlsb2RTclNxS1lD?=
 =?utf-8?B?SzR0VUZkYTM4a29sQzJldGNzbWZaZ3BlSndDbTY4alI5bTZ1OWY0cVpEbHcr?=
 =?utf-8?B?dFdJWENqbXVFNXNxVm9BcGVCL3hRYjkxU0V4SDdGczJYMjQzMUdGVzJwNDIx?=
 =?utf-8?B?b1ZIZ3RjOWxLYXpNZzk2UCtlMi82QzJ0SnRzRTFtS0h1a3lJQ0JnSmpqZkNK?=
 =?utf-8?B?T0ErRFd3Q0g5OTdPcDR4Y3lhODFYSSsrblBLWDNqeDdMYnJrSjdldkFkblkz?=
 =?utf-8?B?bnd1Rnp5aEV6RDlCVkxtMWlBVlBwSFBLVjE0Ri80SkMxZDU0OFJscmpmaVlh?=
 =?utf-8?B?SUl6NmR3Z1pLYnR5cEk5UG9udWdtS3lSWlU1U0hPTDRVcHZNdmdXbzlsUUZG?=
 =?utf-8?B?QWVBN1ptd3d4TE1JWXpab0VTbzc4VjZyYS9GYnZsSzRzMnRlWjdQTnJRT2dn?=
 =?utf-8?B?dmdDakRtYVJKb3ZLMTR0VnRhc2x2UEg1RnZRTlpDN1E3SWRGT1RhRGtNSmxT?=
 =?utf-8?B?WGJaN1FKQlhZMTJYSjlCZEVEOFZiUjBDSHhLdTV2T08vc1FFMDVvQ1cxaVJ3?=
 =?utf-8?Q?vl4mt2ysBY8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJkcEZqb0pWNXJQOXI5V05zZjhneEZJak5uVXE5dFBHbnJ6NHZ5dURGR0ZV?=
 =?utf-8?B?dFFzTEowY2Y1K1J1YUR2RGhoQ1k1akpDbXo3VGlBaHBGcVlBSnEyWGhNYWsx?=
 =?utf-8?B?elVSVXFNNjZESTJkQ0s3akRiaVprZDVrVU1EVUMxd1ZmcGZFZkhrS3FOckt5?=
 =?utf-8?B?V2pIaXlPM2YvYjdnQXhqZXdlVGUrTVVFS2VtR3R4NVZzSExVWjErQ0JSWVF3?=
 =?utf-8?B?VWE5MlVqcmFPWEkwZU5SaUdoVmdVRklvVVJJZ2QwVnVCNUgyVWROalRRY1pp?=
 =?utf-8?B?clJYRGhER2lqZEl0WUZ5TEoreVo1eXZZR2I1R3JTdUd5dWZHOTFFSENPMlJz?=
 =?utf-8?B?RHJscmlUUGZzWDcvaXI5L0JzRy9BL2lLOExyd2FIR203QVgrK3pEMXNQMmdh?=
 =?utf-8?B?aS9mTDdLSGU1dHFnU1lpVVRiUGRZVmtTeUptSUdjRHVEUDM1K21BTkl0ZkFz?=
 =?utf-8?B?cVFYb0JmYStmc3F2WFNXbFExVUhsVjZia3lvb0c5Z0RSME9VOEc3ZDNJM3pP?=
 =?utf-8?B?ZXc2VjhXZ2dXZjRTc0NBbDNLVzV5T3VlMnlVZGdqOXpTV2plZnR0WkoyZmlG?=
 =?utf-8?B?UkhaRzNDaGFweElrOGJSdDRkMlpCWlJSd3M5aUJaeDBCV0ZUSmFaZ3lYRm42?=
 =?utf-8?B?djVPQThlMEpxeTBBZ1dtamZpam5zZDVSY3pQRWg0RWNnOFlmczlJc2Z2VTVj?=
 =?utf-8?B?cEYyMUNQb1hQTnByVnpGdU91elQ1T1pUcmwxeTRPSkd5NGtFaFZoNGpPY3BU?=
 =?utf-8?B?WVU0Zk9RL2VTNnJaRHI5SWJoL3FQMXhZdzZyK3VtWllReTN3eS9KV1F6eC9N?=
 =?utf-8?B?N25HMzdnZmlLVmJtc1cxZWNINHkzN21ueXhaWloxWDN2TFd0RU1zMEJFYUFF?=
 =?utf-8?B?ZFpzZHIvVWJSQWRJNWdSbHBXaDdYRVBsaDlOQXN6L2pFVW1MaGlabVdqM2Rl?=
 =?utf-8?B?cmFwNm1mRUlYMVRtYU5TMWtLUnp5YVNuQllYejh6UXpHRmxpNG4zRnZITGhG?=
 =?utf-8?B?Y1lXcU83NHFkbVpOUjliN1dUTUVPa3VINWNQamYwYWtvL1pJODVCeFkwcXRx?=
 =?utf-8?B?bkZVbFBYQmExamc1bW4yMWRRSGx6aHVqbjdmQ2ZHUXpLUFJHWTE0d2ZWalZk?=
 =?utf-8?B?YUZhZ1pUdW9Bd1JQcm9nejlzamRTQm1uRHgrdkFBOFZ5ZzV4L0VNcWs5bnJZ?=
 =?utf-8?B?bVlEdDl3SkdEeHF1OUFmTmhOWGlZcmhTd2ZJZFBodHBKREZ0TXVNU2g5TkRL?=
 =?utf-8?B?czhEVEM5OFFEb1UrTWFQZ2xnSUNoU3QvVEJEY1AwWGZUUHJ3Nk8rUDhzMnBm?=
 =?utf-8?B?V09NdXBWMDRHUDR4dTJVUjNkK1VTSzBjejlEbG54aGNzVmpJd083dTZ6NUQ0?=
 =?utf-8?B?S1NmL2IxcW13d1BCelZEeXhLM1EzN0xlaE9vb0I1UUxHS3k0LzBPMWxleTdw?=
 =?utf-8?B?VE9LVWlPTnNtUStXYjJSZDFqQnBHK1VTbFdhb25VTkFranZteVhIZGYyblJK?=
 =?utf-8?B?SEhCNmxNZi9UYUZYODZleEcvMVNhY0R0QXh2cFFYTjJha2M0QVJueUQyY3k0?=
 =?utf-8?B?RjVrQkJlQWU5RzhWM0JzaE9nWWNNR21SZnNhZXdzeWNMdWp4ZWpjOXlFK3Jp?=
 =?utf-8?B?YXgreVpFM1JoL0JEeEtSTFJBMllFd2dUNEJQN1NyT1dXMUNkUXVEUys1OE9E?=
 =?utf-8?B?YVR2L0tVcDN2VW5KczBWOVpmWnlYRWxXZmcvczN3QTExR0R2ODVqTmNSUmpH?=
 =?utf-8?B?SmR3aGxTNjZQbTNMSkZWeC9GTm04VnJsdWx1aUp5N1g2YVRxb1hBM3gxZmN2?=
 =?utf-8?B?WE9KNmRRdlJWbWVnejJmSVRiNnRTL3V6QUtzcUxsWGQ1dHJuSmtOci94b1cr?=
 =?utf-8?B?SFZCMUVUakgrKzNGNi9PVHVPWGpvUTZpYlViOU1jaHFVZXFuVFFoTC9uZ3ky?=
 =?utf-8?B?SG1iK2t2eUVheWxSWU5UcEhCTW81Znk3Y0prTXJDWkZKcUg1NDE5TTlHZTlH?=
 =?utf-8?B?WTc0c3ljdUplV0lpeDFOWUFXTDdGdkx5c2wxU2tpdUdCNHhCc2Rlbk5CdS9u?=
 =?utf-8?B?ZmF6Mk9QSlhUOForQkc2UFpOZXRSOU9qYXZueElvZ205MzJDR2xBbVFUcEEy?=
 =?utf-8?B?akNXWFRaN1FHaXlWZ1RUM3BhblY1NzI0SlhlNlFFTXZ0QmNnY3l2c3NINnJR?=
 =?utf-8?Q?0kzPFxbwporyZy+outUpjNUX4DJS660AgnnwDK0PXJre?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f19ff7-3b7f-4c55-00e8-08ddf5ec385c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:15:06.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Xj9ZANxRfZqx+FdagBeU4o4iQgXMZmPGoBg6EFZQnsLR6YIYDNV2Q0Egza0hKKVzDQm6MkFtsXRgyQiYr1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404


On 11/09/2025 13:27, Niklas Cassel wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> The return value from tegra_bpmp_transfer() indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> 
> If a host deasserts PERST without providing a refclock, enabling the PHY
> (via a tegra_bpmp_transfer() call) will silently fail, however, because
> we are lacking error handling, pex_ep_event_pex_rst_deassert() will still
> set pcie->ep_state = EP_STATE_ENABLED.
> 
> Because of this, any succeeding PERST deassertion will incorrectly be a
> no-op (because of the pcie->ep_state == EP_STATE_ENABLED check in
> pex_ep_event_pex_rst_deassert()), even if the host does provide a refclock
> during the succeeding PERST deassertion.
> 
> Add error handling to tegra_bpmp_transfer(), such that the pcie->ep_state
> can not get out of sync with reality, which will incorrectly cause the
> driver to think that it has been successfully initialized, which
> incorrectly makes future calls to pex_ep_event_pex_rst_deassert() a no-op.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> [cassel: improve commit log]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0c0734aa14b68..8c5c370dbba5e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1214,6 +1214,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
>   	struct mrq_uphy_response resp;
>   	struct tegra_bpmp_message msg;
>   	struct mrq_uphy_request req;
> +	int err;
>   
>   	/*
>   	 * Controller-5 doesn't need to have its state set by BPMP-FW in
> @@ -1236,7 +1237,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
>   	msg.rx.data = &resp;
>   	msg.rx.size = sizeof(resp);
>   
> -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>   }
>   
>   static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
> @@ -1245,6 +1252,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>   	struct mrq_uphy_response resp;
>   	struct tegra_bpmp_message msg;
>   	struct mrq_uphy_request req;
> +	int err;
>   
>   	memset(&req, 0, sizeof(req));
>   	memset(&resp, 0, sizeof(resp));
> @@ -1264,7 +1272,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>   	msg.rx.data = &resp;
>   	msg.rx.size = sizeof(resp);
>   
> -	return tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		return err;
> +	if (msg.rx.ret)
> +		return -EINVAL;
> +
> +	return 0;
>   }
>   
>   static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)

Looks good to me!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic


