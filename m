Return-Path: <linux-pci+bounces-21885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC00A3D463
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1796C189239B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F08BF8;
	Thu, 20 Feb 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wglM8BcD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555DA944;
	Thu, 20 Feb 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043093; cv=fail; b=BnRvKUYPLGjb3AQY0B01Sz7wgQjxhfiW2R5jV68hRsL/RehK/RqjnZeFT/JIEuthI85xY5hFotlwcUvXwa8KHjvixPJPE/ebJVFD5ywd5BbkALGZFBMRFXae2N+2m6JaCfuyyeJ2pdoZ5UkSWNg2xerhmGDZ2H86YRUDpeEYlVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043093; c=relaxed/simple;
	bh=MGzxwXKQO2T2Bsl4WDkYDY4HKOkddVJagdnmh9y3/kA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6rGt1NMS2u1oabmlVzPr10k3NG80W1LaxpxcVdPkXU/30f9BHtVs4j5MtXx1CjM75eh8iNq8M21k09b5nkI+u1ZY8R3ToGNnqg3ZB0/b2N7fF6x07LBQbHAbc0+uNFPlc/EerbFMxB6HBQtVjvjgQyTBpNur3w5EU9sw3JcMyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wglM8BcD; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Laa3L3GLpD/W12V1ahN7zb5NzkJ1adhI9kwZjK0iLoc9/o9kMwGOxna3v88kdP0vvbTdbD7fO0HpM79RJDiK6H0Yj+exCbFIDQFMifWEFq6zWX/BsvdBZZo5zwVtheheq+/fWq2oqF/4wvT04z+jD9GwbyZIblu8EfZGN+oSAQmMiy1jTDoxXj6vDUJzm+kjFukfaKP1FXabL2qU8ilNEIeVeT9uj7oXgULj1Q4LZXxc/q5haybulArJJPVko5tpyAM5VBXv2S/8EwK8Y3/4juU0l7IsMNmszijSFKSXU2Z6whNAxSP0opaYAUbM7xdvUi4neL4R/NGfmYmsemL9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnvBR8MYlEIyA/WX4OgACN9T0InKhJT6gCYL4CPlYMI=;
 b=uH6qldViV6IhL06rk8teOnaMujbDoujjefjdFAlkOL5eZ/390L4mGYzCQsvWvDrxQJD4x1doZvUhM1S88RRmpKHLQtwaoYTlopwXFb2AP4oPk5SBlHU4k6VVfKuJkwXraNH2vbMFHCEubbTsicFLRVsgYrIs9tUPotROz4GzMyzM89/KeO+1ZXZmzcPDk7j9RGyJgaO+oXavsHpAwKm78JJqjY4ocDvqU2Tu9EJx+xx/jbsv5Y/l7JF9rGUJaZnXoYFPhX3b4Oq7IBzLvdDKFMIbJkr6PQQ38AAU54qv1zEzW7eylBZOvpw0YdWrzLefyCiqlD37+TBKEtCKPYgxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnvBR8MYlEIyA/WX4OgACN9T0InKhJT6gCYL4CPlYMI=;
 b=wglM8BcD/ZlGs9CVpngZBY0TEav8v+c+nCzOf9OoD/C8emyUWdGymBmIN3TilCI4wUP43Iu2MRDqqlTWyAiu6J2EdrLaZWfBRZQwpgG1HZmke5TW3Tkkc382NfAFW/2/7dOktn8Qrnl+MDKFUA+UFzjr/nmK6iFunrsnrKXyui4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:18:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:18:06 +0000
Message-ID: <74418233-2fec-435e-aada-d4505b34bc8c@amd.com>
Date: Thu, 20 Feb 2025 10:18:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Update Resizable BAR Capability Register fields
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>, helgaas@kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250219183424.GA226683@bhelgaas>
 <20250220013034.318848-1-daizhiyuan@phytium.com.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250220013034.318848-1-daizhiyuan@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 385548b4-db0e-4990-624e-08dd518f7c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS9CT0lsTGZ5VSswL3JCVmQxVUVTWjVaWEpoVStNbE1pM2JmTkpwL09jZ1BF?=
 =?utf-8?B?dGpReHVhdTl6UnZ6a0ZnVUhmaGFlVXRmQzBhMHA2UExJSkNZWllDYVE1RnRz?=
 =?utf-8?B?bmNRRFlwMXFmaEJFbG9mN09yVnNxd0JhZmUvVlhFbm0vZXU2UWxxS1BlRnFt?=
 =?utf-8?B?NFlPbVcxMjN3K3FyMnNBWXFXU1VqVWordGRTTElBUGl0djIyNzBzYmdxL3du?=
 =?utf-8?B?WWVFQzVrTk5UcXQ4RnpydEZjWVpMWVVXMjU5UXQ2SG5paWd3cU9IMHM2bEM4?=
 =?utf-8?B?K1pXVkt2ZjN5T1NYTWZydVVYempOSWNLVHAySzAvQVZNaEpzWFpuSnJLR3BQ?=
 =?utf-8?B?YmVFcEJ5WEZqSVE1dERMV1htZEk1c0Y0dTV5cTVLNjRicUp1UytJK0hMdEQ4?=
 =?utf-8?B?RnI2Q1VHMTJIa2dDVVIyZlpNSkN6UGhwMFVEWkZtV3V3WURxd2g5elh3WGN0?=
 =?utf-8?B?czYyODJIWVN6M1g4elF6cTNjVmYzV2o2c3lYUTg4aEtBa3daNzNOOTllQ0lF?=
 =?utf-8?B?R3VjNjJaMXc3SUE0RGlxVVdFelZUbnR4b3pDNHRHcW1RVDMza1BCc1I5VWZi?=
 =?utf-8?B?dVNtd1Vic041U1NmeWU5YUJUalp5SXlYZHNsLzNTMzVuQWxvUWZlUnFOaHJo?=
 =?utf-8?B?NFhlSHpRclgwWER6c3dpMXpid1lzU2dFSmZlRG4rMjR6UDdJNkpoelpFWDA5?=
 =?utf-8?B?TmhYRTNlZDMxTGhIdDhsQW05aSsyaStrNGtOdGp5SXgvSEZjOVUxTHlsSUcw?=
 =?utf-8?B?UitaZFBPWEkyM2RwWXRUaHlaWitZb2Q5eWcrNDF3K0F2di8xWDNOd1d5eDJG?=
 =?utf-8?B?a01Ea1Q1c1p0cVpNdkFyRGlYb21TdjNxS2RJZUhtSnpnNVdMSmdZRjdFLzlk?=
 =?utf-8?B?dmY5TTViK0c1d3hvanRYUlJzZ04vMTJGRGlpaTFBaWNJS3ZKbW4vT2Nmakkv?=
 =?utf-8?B?aGJpQ3ZZNnh5QlYwcUlNS1FSMmhpWXdYVE1XOWtramxPcEh3Zk52VnRTT1p5?=
 =?utf-8?B?VlM5QVJxUUpaOFNlWkE1cUIzMzhPK2JibkdhUXpYYndKQ2M1ODd4V2RqYVhv?=
 =?utf-8?B?a0QrbzdScnhZU1YzWEluclhrR0dyb3RCQkl4K2FCTTBudmh2c3E4L1BONkZE?=
 =?utf-8?B?aUI0MXgzMlhkNmwrM3g3VTlNdTJVQ25HUHNjbmtMcUNXVkxTOStWSGl6STdT?=
 =?utf-8?B?Q29YV2xHN09wekdJWjZTK0VLK0xrVDJ3anVpYkloUG5ZdkJaSGpDSTBQRGxI?=
 =?utf-8?B?TFRPTlo4eEUvS3p0eTU4QUc5VXk4akl4YURCcXM4a2kydThuSU9MM1ZuQTh2?=
 =?utf-8?B?M2pSaVp0QkRxZFFRU1dZdjEwYjFWMWFvaGNXc3VIVmpZcUpDN0p6ZWZ2VFVo?=
 =?utf-8?B?UytEL1NadjVTclJCRGV4dnRmb0pLek5qemIvVCtiV0E5R1BiaVNmZFUydktn?=
 =?utf-8?B?WW0rcG5nemxuZHYwZ2ZnbjVvVnBSWDFHOTdSbDBYRzFzeTVjUDRSK2dsOWN5?=
 =?utf-8?B?cnk4UDZyUWhpOHV3aGZTZUg3V3hwWURXSEE0bjVRc2x6Q1RaU2g5MzA5NlJm?=
 =?utf-8?B?K3NBM2JXekZGeXNYMlJPTVpVOGpqaFl1QnRLRHFFLzVaMy8xRzBhdGZxR1RU?=
 =?utf-8?B?ZURpKzZ3cWVyWmhST1crT21kUDQwcDZOcEcxVGlZNDBwdkVla09FRmIrMVlS?=
 =?utf-8?B?QmZSUnlnK2FJMDBvZWpTaU1saVFleG91UUJaK1EyTmo0NjlmcnN4L0ZkbldK?=
 =?utf-8?B?TWxaSXRGbTBiOUFrR01keloyTSsyMEJQcTRaUk5iM2h4emRadW1XeHR5d1hI?=
 =?utf-8?B?REpmeTlPWWx5SEFmRVdzUkcraXJWcW9ZM2R1UjlsMzQ1UVduT0dBcHVUdjhH?=
 =?utf-8?Q?WVSN2/PY4m5W8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmlEcTU1cENGTldCRHN5allhODhRQVp3VUZSZnAwaklpc1A4QzdsdFdGTHR1?=
 =?utf-8?B?dDNVbDlQZkp4U1hYUmQxaEVWemZOVHhiNmF2STBKTm1MZzJhRE5rQU1sb1Vy?=
 =?utf-8?B?TTE5VjQ5OVE0YWFSclp5MHcydzRQUUxhb09MSkRKb2dkQWVFY3A1TXZZL2du?=
 =?utf-8?B?Z2U1aUxHaG1nQkpncXg0V2xYTUdranB5cW9ZdHVhTE1qSkVPNDBSazNKa3pN?=
 =?utf-8?B?YjJYeVJ2NXlyYUhjS21zZUhuSFRUV2FTQ2hFc2ZwcVZyNnNqaFBVUko5NXdH?=
 =?utf-8?B?dnRJWnNJV3hRa3BvYy9TOXBORFpiTnBDcUdLUUtRRWRBS3gxd3NBQU1UOXZW?=
 =?utf-8?B?ckpWcGhZOVk0STNoemtKa25vczMxSDNPN1hrQ3FjcXNGaVZTUDZyQ2ZFQ3VY?=
 =?utf-8?B?azdSc1dIZUtWTG9iSEpIeHJuSjl6SHdiaWtKbTAzQVQ3L2t4N0VoWUptSTB2?=
 =?utf-8?B?d2pJL3gxcE8wNmZGWWw0MmxyTjJHdHZUdlJoZWFQbXFqdXg3Vm9VR1RuM3RO?=
 =?utf-8?B?YjZoVjM5NnVZbzBLbU0vNkZjVU9CbTlLQU1HZW81Q01McnlsM3NkbWZTTU9X?=
 =?utf-8?B?YnN5clhWWFV4M3AyYVlHNEJTbHFXVzlsK2VhN1dtZEh5VDBocFBlZSsyNmZI?=
 =?utf-8?B?VVBjTUlzSVR2V1dNWkY0T3FEQURBLzlJRVBVdWExd2ZWREdLZW5Ma2JWT3Iv?=
 =?utf-8?B?eWpQejc2YytzVU5PazFCcVphazZMN1JPTDFZRzYvTXFGVU9yT0FDMG13VStz?=
 =?utf-8?B?Ym56N3hoWUhCYURyMXlUdUh2ZHlMNUhFOXRMdTRTUkFJN0tGSHpuUGJyWmtD?=
 =?utf-8?B?dDVqWVpibDNReW80WEk3dWNpU3g4Wmt6cW01Y3E0dkNXVEdtSVlBMlA2aUV4?=
 =?utf-8?B?RXBtOGp1OXZYdWF5bHB5NEw3SFhkSGZiTmJNTHVtME1vZUJVS2l0WGk2WHNu?=
 =?utf-8?B?Slp4dlllVnJlVGhXaWZHb0d2TUJuZllHV2R1MENmWjBicFFwT3NxRW1IUEF6?=
 =?utf-8?B?eVIzQmYvRjVoTndZcGEyQVNKeVpMRExPZmNpQVN5a2x0WGU0cDVMNzczOXR4?=
 =?utf-8?B?YlJpTkY5NjNQUldlVERRZDJ4a3NlTys3d3E4YlJTaWVSVHVPL0R6T0MwQkpO?=
 =?utf-8?B?cEs5bTFvZmlRU2hOb3BWenVkVHBwdHNrZHFFMERRTE0yQkhrODlXWDRLc25P?=
 =?utf-8?B?Ri9jb1JXTkhWb0VFOFlFbkowWU9PdmFubWZhTW5FVEkza1FyRDV1c3Y4c01w?=
 =?utf-8?B?TkRidDh0VWdZUnVqeFJiZ3MwSmhjbnc4Y3dxRUI0QVFOUmtvM2FoTyswdFNm?=
 =?utf-8?B?ZWlhRDlvRzEwaWNyc0VBak5oVUlYMWk0NUU4ZjYxSUtmMUZOQTNMQTJLWU80?=
 =?utf-8?B?WkpkcjVoQ2t3djZvYWFTNks1TnArWWtKNGZwTml2WnpxdExmTlJaeXhWTjBW?=
 =?utf-8?B?KzVPS3kwU1RKSjNHV2FIS0M5dFUxdTQzVUlpVjV4cDFwNkVRdm9RY04wbVR1?=
 =?utf-8?B?V1FWOFNyNmpOeG4xekNPeStRUURrUlFzUlJ0Ymk5clhzSk5Zb0k0bndlVUEr?=
 =?utf-8?B?MGNTRUpnUFBKdUw1aWY3VWVjdFNEZC9mWitiTmtkRVc3elFRT2p3OGcwQUpn?=
 =?utf-8?B?SVIxTnJpcVB5ZHBXTjdReXAwYnl6Y0oxajF1U2oxVDQzNDZEYzJmVXlaYTNC?=
 =?utf-8?B?elFlaGI1S3lJTVNSbXRweDFRQzNMYUpkdUh4citVeEc3WDJDa3hMSzFiRWdX?=
 =?utf-8?B?SzlIcUlUejY5REVYdEQ1MDNNWkQ5MC9hcEFCZWE5UlRwQ1B2cXZpYlV4Q3hE?=
 =?utf-8?B?WGwxazhmc1NDVUFMYkkxU1BOREd3d1pHUU9QeXBhUHJudVRlVzJJSmdYZExp?=
 =?utf-8?B?NExnSnBCWnhUMzV3MGNsN2FtRVNjUTNXL3Y0clVhRUVPNkplYVBTSDdpZ1Vk?=
 =?utf-8?B?UzFGczlkcndDaGVIWkp6VTk5Ui9FZHl3ZWwyYjIyZVBxb3AvZ1hCNmxrOGt4?=
 =?utf-8?B?UTNISVUvMFd3MW5LS1hSMEdXOWF1QWUzVDFGdExBK29OSkpNQ1JROFNTcDBM?=
 =?utf-8?B?ekg3WER6SGdLYlNWWkdCM2tDUTZUZGcwME5raXNYVWJiTEJuVXVMblZZeDAv?=
 =?utf-8?Q?3DEQYWNbceKKslx0CsFz9o0jX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385548b4-db0e-4990-624e-08dd518f7c2b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:18:06.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udXXaWuH+DigNVrLAPu/qaoa2jUjW9N5jmVs0ZXB0Zta0KsxjVXVHDJWHhKmuG4P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290

Am 20.02.25 um 02:30 schrieb Zhiyuan Dai:
> PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
> to read the additional Capability bits from the Control register.
>
> If 8EB support is required, callers will need to be updated to handle u64 instead of u32.
> For now, support is limited to 128TB, and support for sizes greater than 128TB can be
> deferred to a later time.
>
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/pci/pci.c             | 4 ++--
>  include/uapi/linux/pci_regs.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..77b9ceefb4e1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   * @bar: BAR to query
>   *
>   * Get the possible sizes of a resizable BAR as bitmask defined in the spec
> - * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
> + * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
>   */
>  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  {
> @@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
>   * pci_rebar_set_size - set a new size for a BAR
>   * @pdev: PCI device
>   * @bar: BAR to set size to
> - * @size: new size as defined in the spec (0=1MB, 19=512GB)
> + * @size: new size as defined in the spec (0=1MB, 31=128TB)
>   *
>   * Set the new size of a BAR as defined in the spec.
>   * Returns zero if resizing was successful, error code otherwise.
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..ce99d4f34ce5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1013,7 +1013,7 @@
>  
>  /* Resizable BARs */
>  #define PCI_REBAR_CAP		4	/* capability register */
> -#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
> +#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
>  #define PCI_REBAR_CTRL		8	/* control register */
>  #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */


