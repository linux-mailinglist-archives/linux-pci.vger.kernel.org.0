Return-Path: <linux-pci+bounces-17426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD39DAE2D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6590160FD7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7622010FA;
	Wed, 27 Nov 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/KjHtna"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454D82D66;
	Wed, 27 Nov 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737367; cv=fail; b=LZRFRuw8pa2DRN2VC2dUDVrQWA1OyK7URspyZ5ew5ryPgvR3bUbrFhq7VDqs1soEs2A3dTXwmffjy4Y46Zhrj0TXbGOdTICTuSofVQgbRl5wt87stCrvBW3GVL+haw+3LFLWUa9mX84bO4DitLoE6KX7gAC1EQUpeTv0MNYyC3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737367; c=relaxed/simple;
	bh=BtwyfaBY3KrvkhAg5wdL3Wx/7XSkRmp+wQI68YneRvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEy0Dt/ENnSCOa8QupOlOf+oyq7vpmvSXvFVRgnfWllmmLbdnO8yNIWcqn5emJwyya24pBrhOGeyBgrsRJSPhAHnvQlGh3yy2H9dPYCOGkyCHvTAIBilMrJc4avVQogNTqzZSX8sSu6GtS1Uqi3pyk02Do0rh6bIeq+BKCQ4R0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/KjHtna; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bgpql60uLfrtGw4PgZYyYO4k0V6j4dayKHqt+qe5/GsZITJFN0eCKvBp+R3bPw9OFaHFA4W7YMyff2wWG5n+R6o9j7+cZY3qdQEL+IgnhhShPV6AtsBwksAejm2M9YgApZwkxB3kWLYZmISSm6vsWgylCOOSIyXwLNT7FKtIr5h4g1SqsgkmH8Gut3zI+HJgznlmxeA9VH+DWHSXWvKlaKCnmYwcvV5pBGL1dvj2jxo1xfOKNpYYYPVHKvORkeJQNZIgVgy6hRk+47YcuNpPE5g/o4PeTTJ8jSkp7rLUiYtTE1OBxvvLPhcGRin7ThErVJLOEgyOE/aWd0G6ChvfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKEZVOP6Sii1WCBpuLlfdds5ve17/b+XNibL0kPJtjo=;
 b=Mb08AUxm0nooCQADbamrchuVC7Qw2Pjg3gpyeiEqNO4N26iLbm062RTfX+b5AHfNFEokfNVhjEwtCqMqpXFjEWpAA1ChpCvhYKRfkSRH47PUU3SaYzilLovSFft+WFJJQGBgUgIdE4RStIQKhO4xZdA5SwrlOb+9+kc4tBs6I9Ep2ZOsfOKsWFr/PxHfQvJwIBskL39vDVDqHsI552X74DxpwW8fhwjB1FWPBT8fImJ9ktbOLJqidOzCsa38MyQnHDNdpmu6UUpPZkpkWc902Ukimrd4sQSGBQ6iWlGZalrsDXwQ56FrHZHr6RT0L8HvV2BDj0AmUadZ9WjlvGNnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKEZVOP6Sii1WCBpuLlfdds5ve17/b+XNibL0kPJtjo=;
 b=K/KjHtna/3vaGQasAmwO9Vd/j0oij0p6ZUNmRKQ3HHFOihb6SVG7QGtzRm2v2NQlcnevMAXynB9fKplkWwxdQRxfPliBQH1UvhCFi/pAZFKgjFE0qxWK0XvHAWCi4E50Lng79iTVGStI+aPZ/fdO4LNKV7R/E3SRI62T2ph6OJec0vqHa+tUT/kyWBG30GzJ0cOP9ndJIw5GjxAtUDpkJYNNMcbX5iMCG/SPFEvO4mi/HoDY17gmlZh1SqqN9OGcKQE0ieTbLRd5/lvNiaVDgtUfy1ruVjbv1L56Wmf5jCQ4Q42foDMqfnQTSlyIsAQYk0c44Q3JX3WBNyfFIzyL8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 19:55:58 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 19:55:58 +0000
Message-ID: <8267a573-8546-463e-8f27-54afe7aa84c6@nvidia.com>
Date: Wed, 27 Nov 2024 19:55:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
To: Brian Norris <briannorris@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20241126210443.4052876-1-briannorris@chromium.org>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20241126210443.4052876-1-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0393.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e01b702-1696-4b87-f0ae-08dd0f1d832a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdIazVJNkxWMkVsWkp4QjR2ckZ4cGtmd0hPV0xqeFJIcUJoUEFzSEdmUm1S?=
 =?utf-8?B?Y0Y0b0hMN2Qra3VWbDNYRlEyRWJLeXlONXlSUWhyVmVNWnlFb1Fnc2VraUsv?=
 =?utf-8?B?LzJrREdWUm1tcnJJYjhZU3UrQm0vMUQyRmVwMHptcHNqZ2hHUW85MUlxdjhI?=
 =?utf-8?B?WlR0QkYwZUZjeDlNRkYrUUo3dzYyazlIWDJOdGp0WmVGbGx1SlprYW5iWjVD?=
 =?utf-8?B?Q3hxcEgweWx2VElRNDcyZGtxMTczejNYeC9mQjQ2Q2tyRVlDdDhCSVQyZFlC?=
 =?utf-8?B?Rm5rNFRoOUwzcCt5VjVoc2ZoK1dRTDNab0lWY2N4emgyallSbmltbHlkZ0ly?=
 =?utf-8?B?cFlFVG5hZldMMy90K0RXbjd0MnIxMFF0MnBMNHVEcGRvbU40dDNmbytjb2R5?=
 =?utf-8?B?dmlLTUNGK1BacW8yZ2Rrb1VIYkFibmNsUzUzd1V4TmRNQzNnazdvZVZNYnAz?=
 =?utf-8?B?cmdwNHh4TkZtcjdZd0ticFc1bzI0RUx3RGYrT2NwdGZzNDlja1dpL0lLeXo0?=
 =?utf-8?B?QmNwRmxOL1BnaUJ3L0s0V3ZXcEZoN3d2WEdBL3NhT3BPU0ZqaXVEalFzTWgw?=
 =?utf-8?B?eFdxODZqRVgwekJGUlJyckdMNkNYdTBOZVJBZnVMSDN5VVdtNDlISXliLzBn?=
 =?utf-8?B?R0lKU0ZpbkdxOVNXd0txS1o2SXFOUjJ1dit6dU5nc3JuT2dWOCs4MkJSVXly?=
 =?utf-8?B?bTNOM1d6ZDVhMG5BT0FTMUZORnBZNmpGMTdFN3F6YkVTSVBYVjZhUFlWVjFR?=
 =?utf-8?B?ZXBxb2lIZUdRV1pMQk1kNWNuMW16OWtxM1BJSnVEclZMUjE5ZjQxVngxNEgw?=
 =?utf-8?B?L2tGSHdGVit2RkQwaFg3c0hjdks2Rmlxd2UvQjJ4aUEvU1paYlAyK0dHNXVr?=
 =?utf-8?B?Z1NFQW4wbDQwSCtLcWRjd3ZvME1hVVpmTWpyR2FIUE1pQTh3aVAxK3FtQ2cw?=
 =?utf-8?B?TS9zc1hWdUlQUUNsUE56OXRjaVVHQ2N2ZnAxamVoSFI3bkNESlFBV2hvRTJy?=
 =?utf-8?B?L2RseGJieGEvWGhDMldRclJOUTJnSEZtWUVJN3dCRXN3MEVvSjJLaGVRWUJM?=
 =?utf-8?B?MHBTcGprT3Rab1I1bHc5bnJlejQzTi9sU1hTbWl2bldiYW1GL2hBYzljQk9x?=
 =?utf-8?B?VkpHdDArVElWbEZoaFp5MmlES3FoMGZxdGVHY1FqdWlhQnNFRUEzWnkxTnVT?=
 =?utf-8?B?ampBby9Md0w3L2ozaVZpc0Z2NGsrSVlERkduRTVLbnZjRHgxYkNXZ0FCejJv?=
 =?utf-8?B?WUNnUG9nSmtiUjF5UUMxSElqQ280YnFQWEx3WlZKaXZDZGxGYlhiUThmNDJn?=
 =?utf-8?B?TTRrNFl2bkw3L25hWFN5cnpRZE9WRjN3UjFDbmpTY1VnRkJTcFJROTFuM05o?=
 =?utf-8?B?Ymw0a1c2L1ZFTElTalVMSDdXZCtidHZBZlM2cnNRdmlyT1ErU3FsTWFyeFFh?=
 =?utf-8?B?bW5uUUpBYlc5L29oU3MzTFMxSUxGcER1d3k0YnVDcUFvcUVwZ1hibUlwMHdL?=
 =?utf-8?B?ZkhreGhQbHdZNXZZaExKQUxsaWlEVVYwSDJHS1lLU1dZRDRKZS9RRHppVW15?=
 =?utf-8?B?MS9CTTlOMkxTa2pmSzFlUkpnVFJ4eU0vOFZvQXJVUmdVQmZseDFIRzlmZnZp?=
 =?utf-8?B?blR6MDBiWHNjNkZGVHQ3Nk1IRm1rMDhIeE54TlVlMlhFREFOaVQ4VVpXSHFp?=
 =?utf-8?B?V2o3a3ZSdmlBMmkzTTA3bHVGWnR5blErWUdDTVVWZGNiSkxKZUxkK1JjSksw?=
 =?utf-8?B?TWo0QS8xbXdsNHZvNzdEK2c5Rlpsc0F5TVpzV1FURzV1aWNPcElLUmp6OGlG?=
 =?utf-8?B?dno2cDc4cTBrZTY1TEUvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXVBNUE3bVdjVUNsbzh6dEtuRk1WcTJnYWJ5SUZNTUdWRFUvV2tReGRsK0NY?=
 =?utf-8?B?VXhTa3oyZ0p5Y3ZCTHNoSWhUVVZ3Tzh4QWZKdlhXSWk0Uk1HdVlYRnNBYzBE?=
 =?utf-8?B?WUVicFdzcnh3bGNodHlCOE1tUkI2WEFEZUlhRFdEMEk4WENidURBTzNFM2lr?=
 =?utf-8?B?ZDlVN2g3U2xKeEFvbXhTdnhZYm84U0w1RGZ0aWtaaEgzQUtrUkVBeXhweTZK?=
 =?utf-8?B?OGxIWUVWa3NGOTJHa3JWL3dLVzcydkk0WUNjaUlXVEdqOGxxd0NQSXVncUVB?=
 =?utf-8?B?cjBUc2dlb2MyTm9zenZuL2t6TjQxZENIZjdGemtkWit5M09ZSlBXLzcxUGwv?=
 =?utf-8?B?TjVWVUZ3UzB6ejhUdkQ0YW5rZGtvUVdtNGpwZ0wyL2NLbytXcStKVzJYK25m?=
 =?utf-8?B?aWhzT3BVbmkySGZBTmNCamNCckhpNEVIUlVRZit5b3RGdnRRQkhxcDR2T3Zn?=
 =?utf-8?B?UHRCL3R6OUtGQ2p4cnJPN050a1Z2UDVleXFHNDNaKzBjbWFmeWc3VE1xZWtn?=
 =?utf-8?B?QndBOCsrcW9wZmlYU1FHN1BkMEZ1MFppdGkzaXdEd0FHQXFsUUFjblJQcGFK?=
 =?utf-8?B?czlnQS8wZ0tqWWx1d2xDVUdGRXoxb2M0VEVJeGdpN21xSUxXYjVBYm9yY0Zq?=
 =?utf-8?B?ekR1S1J0ZXlzQnBBK0FQYlBXRnFwN0d0QnZDMHNPWXZFM01WZGNiS0pZM2ZP?=
 =?utf-8?B?OWNWVk8vV0cvNmZpNTFqeDNacTRXblRLWUJ2OFd1WlhnV21pRWY5b0Q0SHBx?=
 =?utf-8?B?R1prYnU2QWN1TXRpNVc1Ty8rVkFWVTRTNEZTTkNQcjlGcHdUcyt5eFpNUmRG?=
 =?utf-8?B?NmU3ekY1VnFuL0Z4NDNWK3lsZllFTW1TcldiQ0NJeVFEa3VVazVueTQ2QmRI?=
 =?utf-8?B?UkhkZEM2NEZmTnJwam1LLy8waHRxRy91VG9uTXNkQXFhWDFEaUppdXlTdDhk?=
 =?utf-8?B?S05ZRC8vQk1ORGxDS0x3eGllUGFtWktERTAxTnNxM29GZVhrb3lZaGI5UWhL?=
 =?utf-8?B?ckdTTXJZVkdPY2JvZWJsWEtpUEpGZG9WdGVoWEh0SmFMcW16NC91b1EyQzlR?=
 =?utf-8?B?bFRiSkYzZVU2Z1FJZTM4MEdUelNxcVNLQlJNUG9FaDNZUkg1ZmVzWEpmbUlQ?=
 =?utf-8?B?ZUVEbW1vN1p6TzN6OWRXVHcvaFpmcGx5OEl4dFoxNHBtdE1qUTVVNUtKZVJL?=
 =?utf-8?B?SitjRWZJd2dwUzV1cTl4RXJMeG1XMzRKcTVFT2I3eVMxRWE3R3MrWm9hSjli?=
 =?utf-8?B?UzlTVERyTVpFVkpyRDk4L0dhOGhYY1pkK2h6TTJPUWlWdnZZbG1CQ2NpTExs?=
 =?utf-8?B?MjN1andEMjZsMlZZU1lLY3J1RENIamxYeGROdkJGSlRHTzZEUFJQbDB1cTYy?=
 =?utf-8?B?cXZKUWw0ZjlMVjdrMGEzZXJZOXNMLytHOCtnTDVYVkJFNTFwS0puUkN0MDU0?=
 =?utf-8?B?aGNUY3VOZHhmc2QzODI2LytXcjBhVVV1bUliS3FwK3FYT3hxeFRFV0dIK1Zy?=
 =?utf-8?B?dHpyV1VyM0tZdmFLeGJRT1NxU0FNT2w4QURyd0JKQjZuMi91Y1FoWEk1ZFhk?=
 =?utf-8?B?Tm1oTERNbUlkZkpCT1hWN0g3azMrekc2eStjSjNybUp1S3hWNHNlWS9PdHJo?=
 =?utf-8?B?SVlnT0hUZ0cwOWJJSTRYbmRHZTJuQ1hjSDlGbmkvRUswaTUrL1hyNHV2dGlx?=
 =?utf-8?B?bFNVTjFYOVlLVjMxR3huZFBSS25mOVkrSE9oQUhHWFpkaUJZckVJZFhCNWd3?=
 =?utf-8?B?SWdvYlpROTIrZ3Bya1lvcURidFJibCs2WkcvajlqZjdIRTNOaytIUFFJRDFq?=
 =?utf-8?B?RFo1TUFHdUlTQkJQbmxSbTFxQXpUem9BR3dKZ3RhTmNoR3VUNS9mRGJMZ3A0?=
 =?utf-8?B?T212Rjl0eXdBRzFRL3ZpS1pCOG8xalI4dXV1elI1SFFTM093cFZhVFRyMTJI?=
 =?utf-8?B?bzZYblYxNUxldm5vR3VnTnhGWFZITjZkaWJXeXVMUWxVOGsvNklpWUk0L2ZQ?=
 =?utf-8?B?ZXV0UEFySTVjUEcrYTBhcTNiakh4Q2RDWEIwV1UvWGtZUXFuMTZkdUxlbnNt?=
 =?utf-8?B?K0VWMkNCMngxN2pzaHd6NXZzYnZpMFdIQmdRbDRUeW4zeGNCbzZyZW4rMjc0?=
 =?utf-8?B?K1BQNlhabVdRMXdlOHpZaU4vWGF3RlNkdXVBVnFaM21TVUFnTENwbXIzVEly?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e01b702-1696-4b87-f0ae-08dd0f1d832a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 19:55:58.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6ISpvLGg7oLmaEaNK4dGpmzsU7tHbZVS65oX1H1wu2ovQW0tBGRlcD6yz0pIFsl5rXKY7S/7fj4CUbk/ymD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300


On 26/11/2024 21:04, Brian Norris wrote:
> of_find_device_by_node() doesn't like a NULL pointer, and may end up
> identifying an arbitrary device, which we then start tearing down. We
> should check for NULL first.
> 
> Resolves issues seen when doing `echo 1 > /sys/bus/pci/devices/.../remove`:
> 
> [  222.952201] ------------[ cut here ]------------
> [  222.952218] WARNING: CPU: 0 PID: 5095 at drivers/regulator/core.c:5885 regulator_unregister+0x140/0x160
> ...
> [  222.953490] CPU: 0 UID: 0 PID: 5095 Comm: bash Tainted: G         C         6.12.0-rc1 #3
> ...
> [  222.954134] Call trace:
> [  222.954150]  regulator_unregister+0x140/0x160
> [  222.954186]  devm_rdev_release+0x1c/0x30
> [  222.954215]  release_nodes+0x68/0x100
> [  222.954249]  devres_release_all+0x98/0xf8
> [  222.954282]  device_unbind_cleanup+0x20/0x70
> [  222.954306]  device_release_driver_internal+0x1f4/0x240
> [  222.954333]  device_release_driver+0x20/0x40
> [  222.954358]  bus_remove_device+0xd8/0x170
> [  222.954393]  device_del+0x154/0x380
> [  222.954422]  device_unregister+0x28/0x88
> [  222.954451]  of_device_unregister+0x1c/0x30
> [  222.954488]  pci_stop_bus_device+0x154/0x1b0
> [  222.954521]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> [  222.954553]  remove_store+0xa0/0xb8
> [  222.954589]  dev_attr_store+0x20/0x40
> [  222.954615]  sysfs_kf_write+0x4c/0x68
> [  222.954644]  kernfs_fop_write_iter+0x128/0x200
> [  222.954670]  do_iter_readv_writev+0xdc/0x1e0
> [  222.954709]  vfs_writev+0x100/0x2a0
> [  222.954742]  do_writev+0x84/0x130
> [  222.954773]  __arm64_sys_writev+0x28/0x40
> [  222.954808]  invoke_syscall+0x50/0x120
> [  222.954845]  el0_svc_common.constprop.0+0x48/0xf0
> [  222.954878]  do_el0_svc+0x24/0x38
> [  222.954910]  el0_svc+0x34/0xe0
> [  222.954945]  el0t_64_sync_handler+0x120/0x138
> [  222.954978]  el0t_64_sync+0x190/0x198
> [  222.955006] ---[ end trace 0000000000000000 ]---
> [  222.965216] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
> ...
> [  223.107395] CPU: 3 UID: 0 PID: 5095 Comm: bash Tainted: G        WC         6.12.0-rc1 #3
> ...
> [  223.227750] Call trace:
> [  223.230501]  pci_stop_bus_device+0x190/0x1b0
> [  223.235314]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> [  223.241672]  remove_store+0xa0/0xb8
> [  223.245616]  dev_attr_store+0x20/0x40
> [  223.249737]  sysfs_kf_write+0x4c/0x68
> [  223.253859]  kernfs_fop_write_iter+0x128/0x200
> [  223.253887]  do_iter_readv_writev+0xdc/0x1e0
> [  223.263631]  vfs_writev+0x100/0x2a0
> [  223.267550]  do_writev+0x84/0x130
> [  223.271273]  __arm64_sys_writev+0x28/0x40
> [  223.275774]  invoke_syscall+0x50/0x120
> [  223.279988]  el0_svc_common.constprop.0+0x48/0xf0
> [  223.285270]  do_el0_svc+0x24/0x38
> [  223.288993]  el0_svc+0x34/0xe0
> [  223.292426]  el0t_64_sync_handler+0x120/0x138
> [  223.297311]  el0t_64_sync+0x190/0x198
> [  223.301423] Code: 17fffff8 91030000 d2800101 f9800011 (c85f7c02)
> [  223.308248] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>   drivers/pci/remove.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 963b8d2855c1..efc37fcb73e2 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -19,14 +19,19 @@ static void pci_free_resources(struct pci_dev *dev)
>   
>   static void pci_pwrctrl_unregister(struct device *dev)
>   {
> +	struct device_node *np;
>   	struct platform_device *pdev;
>   
> -	pdev = of_find_device_by_node(dev_of_node(dev));
> +	np = dev_of_node(dev);
> +	if (!np)
> +		return;
> +
> +	pdev = of_find_device_by_node(np);
>   	if (!pdev)
>   		return;
>   
>   	of_device_unregister(pdev);
> -	of_node_clear_flag(dev_of_node(dev), OF_POPULATED);
> +	of_node_clear_flag(np, OF_POPULATED);
>   }
>   
>   static void pci_stop_dev(struct pci_dev *dev)


This fixes a regression we have been seeing on Tegra devices. FWIW ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


