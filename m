Return-Path: <linux-pci+bounces-35278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1EB3E7F9
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184801A83D50
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD6305068;
	Mon,  1 Sep 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1Sk9kq2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346025FA0E;
	Mon,  1 Sep 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738576; cv=fail; b=lSSdCU4vSXPNcxRuyLUtxqeHie+NN1mJDjrl7kuZaijpS5DMGILBl7ljDrLlwaj7xOm/2uBMMqJZxUOtnVhe55yJ4+HCfE4j56OcTKkxyJ98H6g7t6w0Qzf/AgasvW+dl9d8Jqxzdmf1NE6kMN9XcDQXC8MfWLGfOOfFVvrA48U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738576; c=relaxed/simple;
	bh=DLayZMlBu6BSjyby8vLsq48fRLzy0QMH0UfxwA9S7qA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M3NQaLKtRsn2Z5yAPNXM649WF/9B6/MBH4lnvM358ekBV4l0lBrkCqKBnzbX7yVuiUBuYmc6O6YKJxGAubLCqL24q+VcQEjvwKvyajqjKUXuVGD0+GFN938AdeRDufec89+UY9TBpv6jmTkuwKNenPQs47k6WYq7IZyzfp6Vbd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1Sk9kq2; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL+tkH393I0vfKX3UpeOPiO0v2Q0GhGheeeOKTxrWG+YmBa3OvWeqOnVgbcKJIS8PvND/Dfh8QhKHe7dUpgw8gkjc+ePqia3FaCBnt0nX1n+s+eyazmjcjiFqVFhvEH57spzolQKnhNmNI3Kr4ajn41H87UlNz9W+VSxTW/Iqwa5Djx5iDHF5qSZtWkXubw1g7/tMqkmcK9KLZf/cmuRom58gm+B696zrK/6sV/6+JCC5oysmNQyU5M0D+Pbk96N9w0I+K8Ef6qQbDAQpwOivonepb80ZEkAxUUTwnvRqwUhTuOzfBPCS158K4ZwF8hJ8qqFpdzAxTjae6DatC2/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUFbMNxP1pRXw3pjRE+5IM2T+dImfmn2x82ceXg4BWM=;
 b=X3bstafmLiqE5Aqwk/YCYZS35oU9dx0ik0MLK6DX0rcS+/AqWrBRYT7/qfxEaeVU3Fi+BibjAcWP1F2U7Hyofe4HWEfC6gCzm3358D5MmiSQuXegbKyaQ/MqYQ8uCFDg7y8Okj8EDqO5Wl7wH/1VCnlMYuVqzYpJNJBwH3B4maZEiBK5PbNsXQnKPB1dJnvCD9ACgnjeZLFmzcuzRjLAaWdziFECTZAuivaLQoaFJ9A4xaphcKZA5VupdAFtNcqzdkgyXXcLL6p94X5lzYvF+jPbSyj6vu5KiHJi2hTzoGAJH691oNetx/MLvHw+2/sw6qC9fqZErJo1S4nqSmfB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUFbMNxP1pRXw3pjRE+5IM2T+dImfmn2x82ceXg4BWM=;
 b=Q1Sk9kq2+gxfrx1ywgS8Kz5BGUjGNelVQMmw0dyUVUYM3KoV0PeUqMLIktSn3ZbqBG3VUuJuGNyeTBwBoRgwb0u3+45aDSYMuqpywyWa4etAHlBPfERxTMckorOFUFnm/ypC+ALbZJet3FibSjo4jdoQ47sM0gJp3J6PX/xTZ10opmIG/6sXHJnfOVSSOQjAeAtb//ZyTl9r3d/PHq1cu4nFys3eX/FNwOs3bST0KH7/73UDRGrc7000ySabkCOkOcXKIneGbCJ8ski4R3mknxsJ7x/qDRdiHEsvKEcpdG6Gmj2xLla9xt9TFX0pWA6oPqNylgtW+z3pQA9jnrO0pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 14:56:10 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 14:56:10 +0000
Message-ID: <07dea655-faac-4033-852c-91674c5f09e8@nvidia.com>
Date: Mon, 1 Sep 2025 15:56:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
To: Anders Roxell <anders.roxell@linaro.org>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>, Wei Fang <wei.fang@nxp.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250827230943.17829-1-inochiama@gmail.com>
 <CADYN=9K7317Pte=dp7Q7HOhfLMMDAfRGcmaWCfvOtCLZ00uC+g@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CADYN=9K7317Pte=dp7Q7HOhfLMMDAfRGcmaWCfvOtCLZ00uC+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d50ecb5-343d-4db0-1079-08dde967b02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW9UQzFJK0xCNjVWQTlodjkveDIxMk0ycnhiQ2piMlU2cldDczBWZ0lYQW95?=
 =?utf-8?B?M3V3Ry9ONDVXWjZOZ1NrbjkyRE0zTW5EU0o5R2RtSS8wck9Da0pTWTRGeWJt?=
 =?utf-8?B?Q0ZzM2VQUU5iTmZkWXkvTTY5NXgrTUEza3U4TGsrdmpubEtTWnJFVXd1aVpp?=
 =?utf-8?B?cW5aall4ODdoSzBCRjJFdVBoM0xuRVVmY1lBWlh5aUl4UGVleVFuZE5SN0k1?=
 =?utf-8?B?cG9aQ1VrUStaTHJsR2RJbW1YWXc1QW93SitYSVArWitYZTE0b1A5aS9ITUh1?=
 =?utf-8?B?U1U5U2RwcVdzS2ZMdU5mYmpLc0lnZWxqa29aRCtlbUU4a3JOM24vTUJ6REwr?=
 =?utf-8?B?b0hDWG1iSWZCZ1oybWs3blZ5KzJ4QzZ6ZXpVVmtpWVdQVkZWb3dFaTdNL2Ix?=
 =?utf-8?B?MldTUC9weHpLYy8wKzZHYStoQlBMVGh1bE4wNU0vaFBTWHVDY0JlTXNnOEp5?=
 =?utf-8?B?OXd2alVRc0VrbENadGhYbVNCbjhZUXpFRmphbjcvUzdIOGZxV3JySnliWnZY?=
 =?utf-8?B?YU9Yb2dOaGNvY2IxN2ZTdDU2a2k0eFhDeXAvYnlHR1NYSHk2Z2tsc0tBd242?=
 =?utf-8?B?cWZoOGM5OU9jYmtpdkUvYTFKekUrN1ZLUXRCRW4rc3BnYzVtdk05TkdseUJQ?=
 =?utf-8?B?bnhoWVlwVDhwVVU0RTg5L0JMODEwNEtUaTdYMFVmdklNM3pQODhvT1pwUGlN?=
 =?utf-8?B?bEFHZWdHMWtiZTBPdmw3Q2JVUWlXNzBmeTVPWHJneStKQXdONmJwV3hZZjA1?=
 =?utf-8?B?bFp5TFJZSVI5d0o4bncreUpEalNvNXU3aU8wZFdibVpCNy9qNDRIUkh6OTZ5?=
 =?utf-8?B?VEpSRjg1MkdRakNrQkd1OHNvNVBzSUZTMDBsditpWFZxdWJoWDNDeStkblBP?=
 =?utf-8?B?Qzh4RWVjWDgxMFpFSVhRU0F2cy9iNUcvU0Rjc3dIeFFVVWQ1Zmh3cEtnK1FU?=
 =?utf-8?B?YUNOTmJkcmN0amVNbWJpL0tEL0pWUENxckhpZzdFSWQ0MHJXSkozQ21KNmUr?=
 =?utf-8?B?VDc4TmNXRVhYbkIyUG03WmJ1Y2FuaU15cEFnRURkelNFY0hUaEovYVNIODY4?=
 =?utf-8?B?Qng4eGhQaVdlZ1ZJb3g3YnBJem9WcVZ2N0JTSkM3UVZtTGN5NmF5RnZpRHNZ?=
 =?utf-8?B?K3ZuTkVqUDZkczhOa3BYci9GNFhVZDRkWWlCdVJBS20vdS81MU5YTzk2QnV5?=
 =?utf-8?B?RVVNaDJVK1luN1ZyT0RCSXZtczhDcWdKRHl5clNaTDF6WmxValdzT3dZbEM0?=
 =?utf-8?B?bStwdEpoVHZRM3RwNFprMVhUQjFXNy9DaWtIVVlYUWVXemVVbXpPdUtFclY3?=
 =?utf-8?B?d1ZMb2xaQXdDcGc1SXUwRnJ2cEZaNm5uWXN4VVYzRG1mVHA5Y3Bmb1FPTVM3?=
 =?utf-8?B?bitlMEc1U0ZwdktMcHhzTEVTWmNSTG53VUlMNVU3dkcwc0dCNnVtT2hWSmU1?=
 =?utf-8?B?UW5hL0lqc1BDYUVIcGp4MWUwaXR1UE9SUnY3M0ZZT0h3aTZIUTV2bEkzNmlz?=
 =?utf-8?B?aHRmb3hnL1BGbDg3L205OFBiQU1aUFRoZWV0eFZuaWdKU1ZJSXIwSllqb0JU?=
 =?utf-8?B?WGxjYVY5S3dKWEhzVkpZMjk3Wm80bTZHUkFXb0VZZnllVkNxSW1HdHZLOTYr?=
 =?utf-8?B?ZDRkb1BpaW5DT3RNSXAvQTBUS09FK0MxR2lRamtnbTljQzlPbUVmbVZIdlE1?=
 =?utf-8?B?MWlWZDRmYmprSXdsSWpqRStzMjlrWUhZWE14NUo3ZkJ4SHMwOEgwcEZHNHZX?=
 =?utf-8?B?UGpEcnNLQXNoQm9xeWt4U0dZVEdwU0VwY1FXcGVaUVpjUE9CSXZGQnhuelVu?=
 =?utf-8?B?WGFleXRUWjFhdDVTY3prWEdvNW5tN3lVTnQrTThiS3kxTWpKTC9DcmlDZ2FC?=
 =?utf-8?B?ajVXaFFlUmZ3NHVrSGFRYTBnc0IrakwyTWxqaU80NTJGeWE3SDErTzRvbXRm?=
 =?utf-8?Q?fDqTonRdVxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky9GS2FvSTdnM2FkZVBUbkZyMVExL3o3ZThQNFE2MnZmMXRTSzRCMGMraS9w?=
 =?utf-8?B?ajhDaURMZzQ4VzNPRk05QXQ2ZXYzLzY5Tmc1QnI2VjVkVDh3QlIzN0pZR1dX?=
 =?utf-8?B?QWFMb1IvMDVMaXpySVlTY0JyeEtPM3R5WWZOSmFKa0dTcDJGajd3cjYvWnls?=
 =?utf-8?B?OVVzanlrZGtMd2x3bzE5cWJqZUpPNjJWeXpYeWoxRFB6WXZRSE5teENRZmVK?=
 =?utf-8?B?SmIrWHFZMHJMaUtsTmVoTnhTSWtlcytLTE9DUUZDZHJTYS9HUXpQMFZiYzRz?=
 =?utf-8?B?UUZJVEYzYk10azZnQUlGVU52NnVDK3ZVVUg0dUg0QjQxcFp6Z1A5T1YvS0Z1?=
 =?utf-8?B?QjRuQ2kreFZTbEU5TFQxdnlYUHAyVkFSL2xyMWpMcVBPVnlMS3JRTEdCYmNh?=
 =?utf-8?B?TGJUa0cwbEMzczA0bEppTXhUY2F3VGR4WkNubWpBd3BudjdONk9GVUluLzVX?=
 =?utf-8?B?SVZlMjZiUENESWpVS0pPcFVWYjFGcllEVThYVkNDSHg4RUxMUkdGNms2M2dj?=
 =?utf-8?B?SWw5aVVMQmFLY0V4ZElUK1BkQTF4aGR0WCsxTVdocHB1UTdjYm1YMjlReWxa?=
 =?utf-8?B?WEM3dFhSRE1yZXAxVVVFUUhVajhBRmxadDhvQk1wRUxQSGNIZ3hXUFVhMkdz?=
 =?utf-8?B?ZGNZZmVLU1IxSGdrcEpKWFBGTSs5bnJOVTZiZ1U5TGFJanV1a3QvOTcyS2dP?=
 =?utf-8?B?RUxnMW9COUlrL1NpUkw1YkRVSzdoSkRsTGRlajF0bGZhTDJUaHdiKzdTVHE2?=
 =?utf-8?B?Qk5YVUdQVTNRRXoreTJ5QzFpeXdlQUMrbktJYkJEUVArSEpkcWtxcmYxdTZh?=
 =?utf-8?B?TkN3UmgreUVlemo2cnlYT0VYZ3RMNE1mSXJGL055MGVZNjJWdW5vcm5HU2Qr?=
 =?utf-8?B?aGQvV2ZPT052S0EwT0Ftd0dvVUVkMVBwNGZiNHQvTG90QmtNVSt1MXRNaHo1?=
 =?utf-8?B?dVdyZWJVdldNRDJkR3VkbVk3YytEd1dPR1lRMDVDeFV6ajZWSTM5NmFROVNG?=
 =?utf-8?B?OE9WOU1EdXdHVHJIaVRsOE5MZHBiUzRjTXpTU2RqWkF2dWpTZTU3UFdybi9h?=
 =?utf-8?B?Rk55TzdraldtZThIU2J0aE9KYUlkWTZLNURLSlVIZ3dBaHJpa3VLRkNYUi81?=
 =?utf-8?B?LytKT2hIZWxQZ2RrZG1EM3d0Z08rUHpZaVB1UW43QitENGcwWklkYy8rczVU?=
 =?utf-8?B?SjRVdEVsem0xcktzZWdJUHpHamYzZDVmdG1HREw2QkdGVTViTFdobDlLTmY2?=
 =?utf-8?B?SUtHUCtBTnl3b2YxRGJ2VnZ4ZzMxWmNSZXNwZ1FQNUNadnFQN1l0ZnFHdi9o?=
 =?utf-8?B?VHVKaStOb1ZrYlVOMXRwb1AyaVJWT0pVSitwMjJLaDhEMjVCZG1LQ05rbk9X?=
 =?utf-8?B?VHh5S1plczloMnNvcWExMm9YandhUzVNZEdKcGpZbFFOaHd2eDdDOE9VMkp5?=
 =?utf-8?B?ZlBCOW5veFpDVXVhWGRWUlFBK1ExNVBINzBVZXB3RzFNZmxVemVKMWVtdnhh?=
 =?utf-8?B?cnVrRlQ4b1ZLTzdhb28rU1haS1NWeTE3UEhzdENXQ0FiWEMveXdNYmdMWGJx?=
 =?utf-8?B?WUxLMWh1SFpMc3RsWW5QWDlUR2RYYnpPb0FES2FUeVdxTUVzUU1DUHlObVFs?=
 =?utf-8?B?SUR4Vmd3eS9teDVtaXY5QUNRc3ZYV2hJanJpSWRJTm1ZQzdXL20yTlBkdzF0?=
 =?utf-8?B?Tk1wRUxqYlExTHgzSG5XMThYblg3cTlIUXFMdlMzQUF5cVpMdzl3ZUJHRW9M?=
 =?utf-8?B?WEl5OWZjZXU0ME5hYkRFdUIxRlQ5Vk1PalNDNjVyeDVwUkFmaW1jQUh2dEtQ?=
 =?utf-8?B?dWpFVEwwUCtLY1BTaDgyNGx2SExMK0NNNk95SExkRVQ2WVdWVzFTREpqQ2V5?=
 =?utf-8?B?NkI2QUU0UHNrVzBtWVlOQ010WVIxTVo3Zms2V1Nxa1hyY1ppUnRNd2IwaE90?=
 =?utf-8?B?MlNEV0FQdzloZXdzOVlnUDZXaUpWRWFVQlQxbnVqSjZLYUZyL0NvMjgyNEhF?=
 =?utf-8?B?NWpUb0ZpUy9IVjhkUXdRWlRnUzRGRXpHdUQxU2U4K0Q1WmN1TVdLNzlxQXdp?=
 =?utf-8?B?bE9LeHNCZElXODFremtVVk13QWljQTg0MjFRbGViSHVXNFRaTVo5NUNtZVNz?=
 =?utf-8?B?TTJJK2RIcXJhTGdFQzRxcitNRTFaVFlxQldBbDNRZXBHcE5HNDdPenMybnhy?=
 =?utf-8?Q?/yS0sQej4H3RhlHcZbXBXIu6+IBxhDjyYcjGdl8IGEpb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50ecb5-343d-4db0-1079-08dde967b02e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:56:10.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzeL6x3PHlkUkO2mUWGTvcmAnnjKrrycGUibjCDwLJR6CT+LlSjwU51n90PyX5vEWPj/vaMvx2dMavEzLnQxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664


On 01/09/2025 14:30, Anders Roxell wrote:
> On Thu, 28 Aug 2025 at 01:10, Inochi Amaoto <inochiama@gmail.com> wrote:
>>
>> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
>> the newly added callback irq_startup() and irq_shutdown() for
>> pci_msi[x]_template will not unmask/mask the interrupt when startup/
>> shutdown the interrupt. This will prevent the interrupt from being
>> enabled/disabled normally.
>>
>> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
>> cond_[startup|shutdown]_parent(). So the interrupt can be normally
>> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
>>
>> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
>> Reported-by: Wei Fang <wei.fang@nxp.com>
>> Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>> Tested-by: Nathan Chancellor <nathan@kernel.org>
>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Any updates on this?  It pretty much breaks testing on linux-next for ARM.

Also does it make sense to squash this fix with the original patch? It 
caused boot failures on at least 3 of our boards and so could impact the 
ability to bisect other issues.

Jon

-- 
nvpublic


