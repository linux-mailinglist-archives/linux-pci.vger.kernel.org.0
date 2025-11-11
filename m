Return-Path: <linux-pci+bounces-40802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04585C49D2E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 01:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27FE18895C4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5E17E4;
	Tue, 11 Nov 2025 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0bkWfqM"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88408173;
	Tue, 11 Nov 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819312; cv=fail; b=uWe2XIC38/75k1jLJxdMaM/QW3cSSLEEGxM38P0UmlCNjpeGKzjRV2SFeswtOCbsUXOSrui6BZ9MGRgMjsDbvzrlqBsq3t/KZoOOH5QFZH6/EzFUSNMSZPDJPBvIv2w0EtMdTsE2tHG/RSjFrlgD8sJX8rZGKmG87uH37SmHTd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819312; c=relaxed/simple;
	bh=CE0NVjgC+7nYhL4xVZXBFskZA2LTwq03APTPgNBB7HM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c37TIvxmDoaNCZZ6RyNJ9Cefw9VPVbyZin9+LT/dmyclal+nLgG7lXhFY4ldL0I14c9sxyod8Rl7VBShBv5HFkfIprZWruRbendeT0vafymPLei4vepyC3G8WQ/ltk+Pu+XoTubTWDNeQk3P8ftanusPJ8/NiaRo5M7ZZhr3zRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0bkWfqM; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVsLYUN6qTTXQB8R/FkGKjDXAoYJgFWRT/SQqK0LBHyx2QuojRczijm+O8T32dLt1e/waDQgMO+eWOPm6+w/ITiA/OQkaWaI1T4+2PyJJKYxFD+7X8fprkfXNu5/2AW2uJAJpQO3PEK1LrnNnaQUxfkOT/l8CjcV4wKX184Q9btKCEwB0sJIJDTGgaqPtvqUvo4p39hj1xYKJ/Kt8cmBxgfEwGRPP19Q2cgyjjhSemiRGAAhye+KCr4TxyOm337Cg6XuWHxQLOv35fhnyH22/E/2At/KB2u1fZ+l9TSo+xZaBpCpHIQ13dogb7TMR7A/iA7H8Mm6r4+/BdyHSchsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE0NVjgC+7nYhL4xVZXBFskZA2LTwq03APTPgNBB7HM=;
 b=u798eSW59U2PIKqGQJlHqam2h+rn1ljpEge3048cSD1IUzOsqlet3psMMK6ptT4EoZBy0/vgGECrV3podbd6X3UMAxBI99TXOIY2pFDv2kpcjUvO6+9oFgiBzVF8VXZMNJ0cMxxKNo9bfxaINJiewockE2ux5GcC6S2bAVkUAlslLtg9HBIv4dXbCJ/6K7/YFX4jU6HEsnq9u1gL/qcte43pkdE1bXyPAndBeA+kZ08yxLbyH0wOKg0WsbEtEmDLe6+m69VB3Rdui6T4uuUldV0+gordA5Do5oOA/iMRPuEJIfimZK5I17LPFPNKS+RZ6OTPWpdZ6v1GNWLO4iH7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE0NVjgC+7nYhL4xVZXBFskZA2LTwq03APTPgNBB7HM=;
 b=c0bkWfqMeSIGIzZ64ohWB8Yf+uAshcVZJAIjyNrHLjGneUKy9A9uYvnwqDMmctxyDXvHJpabS1JbcUq4DAr0ZBivYgysMWCGOz0MlYHEyHsLJUgjDAS/4dyTp4+YFqaJkqhhZAw0kvXXbieYi5I76bkyfWTWVhD8MglYJ04trL2KRGWejWtscnAe5GpUBbBv7kqs5tsiLO++58xYee+QSViasAJOV48M10YaLqZcTiPDq35WDYKoEgPMHp2KiRXfR7OGSn0P8uSfxllUoiFQVOanBwODU6NI4oOBBgScH4iAllrXj6rZFtjaaPtpOoi3+2A319vmEDhSx2wPcQviDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:01:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:01:45 +0000
Message-ID: <0e8988f4-07ba-4c3a-8285-2960bc40dc65@nvidia.com>
Date: Mon, 10 Nov 2025 19:01:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND 0/7] rust: pci: add config space read/write
 support
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com,
 smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com,
 jhubbard@nvidia.com, zhiwang@kernel.org
References: <20251110204119.18351-1-zhiw@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251110204119.18351-1-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:408:112::34) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 807898e5-6eb3-404a-c288-08de20b58073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXd4OGl0bmFTQ0xRWEU3TGg1Q1R0dStlbXUxYkQ0Z1ZYeU5Mem82eFMrSWU0?=
 =?utf-8?B?R2FhUDNVZk9vV2lKdzdDbjdOcVFEMFc5WWVsZUpIdGxBaGtiaHpJWGRLcXJw?=
 =?utf-8?B?Z0VRNnpyeG1oM3k1YVF2VU16MmtudllOb2RrOVhUK0I5Y1BhSlkyU1UxQzZJ?=
 =?utf-8?B?bWxpTUEweWRoZ2lweDcwQlBoaHhwWnMyMEJtTlNnTG5vREtJT3hheTA1RTd0?=
 =?utf-8?B?Sy9VbEhrODF2ejZmakVPaTFzYUxob3hyNHBWL2JsYm9NV3ZqYUpOQzRXOUN4?=
 =?utf-8?B?b0JPWHU1OXUzOEx4aWhjbmhnWmtUdVhnSnNjMTlYQTNzY1Z5Q0hrOVUwbG13?=
 =?utf-8?B?WmFGMWpFcDQxVkNCOUgzWFhRRENQbTBBUndnclRXOURBZ1NxajYyYnBmaG9Q?=
 =?utf-8?B?cmZlSFN6aHV6QzV2Q3c3WmtrY2ZZbmdOOFBDV2QvVHRPZk42YWljVHV1SlBy?=
 =?utf-8?B?YTlNWmptK3ZHcVFicVcrZm1nc0JlNlJsOW94dDJqTmZPWTZJSXdOeHlUMVR4?=
 =?utf-8?B?L3Y0MTBzV2NZT1ZZcnY5aTJDeHBQZHlVVmFhdDZXOFRnSXd0RGl4cVgrd0xW?=
 =?utf-8?B?N1hmdTQxREI5Y2U1dkFveUtvdm1nMDZRdmxld0FkTjc0TlhKclU1ZFdHeVVW?=
 =?utf-8?B?SU9mTkl1Rlh6NFFTNjdJZktMKyttMFNQWmFmd29ZM3pBdkkyaXRtaDFYbjFo?=
 =?utf-8?B?K2VBU0lrT053RHZlSFJuY25DQkFxYW5hUmZRN1p4aGtHWC9VNWZOTndYVjBs?=
 =?utf-8?B?cUhKbThiSU44YWZ5TWwwcEFjK3FMTFlEK2ErYi9OVzhCaEhaWUpjRXYwTWRw?=
 =?utf-8?B?czFDNnVERU9mSmorSStvUC9zelZhYkkxejNyd09LVnhhaE1CS2UvS2hxd1Ju?=
 =?utf-8?B?UG5Vc0VTNzhuZUhOK3AxWFRhcFIyQTlCN3RpYzd6ZGQrWXFLVEtEdEVpR2lI?=
 =?utf-8?B?djFTVFNHZFppNmNzZmxscFZualdPdnI2N1NBNWc3bG9oNUJEM243VDYxQXVV?=
 =?utf-8?B?aXdwaTdvNmJwT1oyWUxHdStoaVIyYWhLenlJQWl4aXJVM2JaQjI1b200YjBF?=
 =?utf-8?B?d1VEMmhTTWtjeXlYT0QyRzVMNGRHUjdhZmRhVDFnUGJRaTZQYlVHd0xnemZa?=
 =?utf-8?B?RWJmUHB5VlREYWpZblo3MXZjNjRGcHp3RHVjb0FRL0lrb0xmeGozZUlvSlM4?=
 =?utf-8?B?dUFRcUNkdlNMWEx6cXoxUWRUQzZ1OVF5OUFReW1pTjRkUHliWEhlZ0p0Znl5?=
 =?utf-8?B?NklLUDlMS2RHODV3Uno2ZkNGcXU0ZWpvME1UODNmeTRYNElBQzJ4Snh2K0NC?=
 =?utf-8?B?a1RyQXZwUjdhdmlOTFRiczFWaEZ0dlI4T3o4WkFNZ2poejFQWDFXR2NETnBM?=
 =?utf-8?B?ZllHVS9ZejRSMDBrN2JvWHRXdmVONVM3eWJ2K0VnbkMwb0oyYWVkRmpQRTNI?=
 =?utf-8?B?Qzh2TnVxc3dVNFVkSjhxMEVtR3ZDZ0daaEJZSHkwK1NjRmQ2bGNlRVc5UG5C?=
 =?utf-8?B?MVZWNnNCT3kvcy9TTWtrTWZnWGxTeUw3cCtlUC9YR1Y0M3h3R0FOdjJBUTNq?=
 =?utf-8?B?M1ZVT3ZmNzZsdzdiR0ZONTFZbVUyZ1Z2UFMxcEYzVC9obTFQZjBCZ1JzMGYv?=
 =?utf-8?B?SnNXenE0NTNhODF6QzRBazlSZ2hHVnlGSENibkdBR1d2dG05SFFOYWpVN1h2?=
 =?utf-8?B?b3dZL1VwMmxTbExjYjVCSzJOVGYrb0l1KzNCdTNOamZRR1lIUEVuUU9DbFBD?=
 =?utf-8?B?ODNIU1ZnZlpkS0Mrc0RidkRaaEZEVEp6TW1BYUJtOEwyVmdRY0VVOTd2dms4?=
 =?utf-8?B?TjNJQWZUSjE4SmJPM3grRkRtZTIzNGVGbjgwNTJJVjFSVU93UjdGNUlHUmgv?=
 =?utf-8?B?NlpHaGpTclE5cGFBVjdwZWlGWE1pYXltSDNTdjRDby8yYzRJQm9SdkJ5WWcz?=
 =?utf-8?Q?+wu42ToQ+IU2+Xwp8ttsAvIN3sB6VdQC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm1LU0FpZng0ZlFRSmVzUDZxU3l2WXRLN1pDRE5WVFFiMFdGTkhickRkR1d6?=
 =?utf-8?B?QTk2dkh6VEV4VVRrbGZ0RDhNQ29nUmpsWkJVODBPUVR3SVVFVytCa056aC80?=
 =?utf-8?B?OVhBSEltNTlaUlhNOUZjTkdiZit3MFdsTUNheFFwTlcvTzVLZ3VYL1pRYWFP?=
 =?utf-8?B?ODNlL3lNNmRkaTRCUk03bFUzRk8zdXRLY3hQd09TNHh5YWpGTHJ1OHVtRFdZ?=
 =?utf-8?B?aGovZ3JZemFxNWZSMGxzckhRcDRsMnh4bTN0UWcyd3pEMnBxUTB6NVpXbGZ4?=
 =?utf-8?B?V0NrQ2tYODdPRUpEQmNJejJtUGl6WHZlNVhYZnJrdGlUUmViNUc2d1h1aERs?=
 =?utf-8?B?L2RNNXc3MWRYWEluQytmVzRZZ1hqT1FJTzA1alRnTnZ5UmZ0U0JVOWxDUlZl?=
 =?utf-8?B?VE9rRm9RV0FyUkVsR1NOazRYUUNEZUxjb215cHYyMjZXL0ZkQ0xKb0tPNHNU?=
 =?utf-8?B?eXRjc0RpUVlOcGlONkwzTG5CQ2JWMDFkSVorSWhGbEpQeldFUDV0WWlhc2Vi?=
 =?utf-8?B?S090MWJZR1J2ZzZFMjFrQnZhdkpYQjFBMWl4OW9GdC9oNmtyQ3VBY1d3TERF?=
 =?utf-8?B?cmo0Sks1L3RSUjVHNHp1aFNQbGVyWTA5K3lTbjhhRnpBVk4yT2VXYVhKVzNK?=
 =?utf-8?B?WTQ1VjhQNUgxbmw2aEZCM2NENTg0L0VnZTJraTNxRlhqamFPSTBVZ0tKTWhF?=
 =?utf-8?B?Y3NTZU9NaGF2TUJRa1AxMEczYzRkMmF2b3U4dHk1b25CV0kyTXJPb0NlMHN5?=
 =?utf-8?B?NjNvZVNCRmNpaGN1bVdPc3cvcHBxS3RXRHdXWE1vODJlY3BYQ2lPaDQ1eHZn?=
 =?utf-8?B?TXFka3J2M2J6eUhzWVZGTWdnUWNhRWY4Qm1Sa2ZWdWFRTXdsWURmT3dKMlVS?=
 =?utf-8?B?ZTJDSTFPalVIak43ZnYwdVovYjc5WVdUZnRrVG5IcGRiYTBkTjRIRS9RenhR?=
 =?utf-8?B?dWZyT1Nac0IxZmxYbU9IajZDT0R4bmp2S1c2YUxjOG03cU5hY3ZIOEtua3Vv?=
 =?utf-8?B?bU1mdjdmb3hBdzZUMU1QaXlzdHR5ZGgrbTJOeHhxcGNKSnc1QWhhNElVcUdB?=
 =?utf-8?B?MWwzUXpyelJKcnNYV1F3eHVMV1pSTTlUQi8rN3JVRFlvMHViYlBUdURieThu?=
 =?utf-8?B?ZzMwYkZIR1M1TENvQjNvTGtsSEtlQWtudG9NalNxYXBqRkFMZ3lacEhkdEhL?=
 =?utf-8?B?MWVqY1duRTB4YzB6VnozZk5CeVBPcTJDU2hRQkhiaFM0UzNsaUNkNW5IakFO?=
 =?utf-8?B?VThQTjB5Y083RTJNWXNaT1NvNm91TXNMdG50T2dlY1FLeHhMYVM0STcxWFNo?=
 =?utf-8?B?ZnFWVjdUT0Y1Y0xraVoycWwzdjQ3bkFhM1B6UUJpV1RMVm9nYzd1SndGditl?=
 =?utf-8?B?ek9hTjF1N2xyYVE3MGl4a1RzMGxVdmJhOUI0NUV6UGxtcGJYQmxaNmNDa2pL?=
 =?utf-8?B?VE1GREJrb0FTZnBXeGhFbXl1cWZsc3dvQUNLQWFqYUdRNzRSakNmZ1lHb1dB?=
 =?utf-8?B?QnBIdTRKRFVOakR3cE4rbVFLRUdRaEIzR01PUXNvSXJHN2wvVnBacXppSmJZ?=
 =?utf-8?B?azNiblJla0VTcFNSbGFZa2huUUc1QTRXcWM1RWhhaTFFakRuY3czYVFMOG85?=
 =?utf-8?B?YlJxbXVrUnRGNURrazNvczNVQVVQK21YaitSY210NUdZdmpZVU9SNVR4TXVR?=
 =?utf-8?B?M0kzUkVZNnFJaTFMK1NKUjV5MU9Ea0d2V1ZZZkRZVHBTekNGd2Z4UHNnVWty?=
 =?utf-8?B?TG9haThhKzlEOWw2blhhZlhlUEEySkw1UXdtUldnZU83R3R4QzRISUdpYStk?=
 =?utf-8?B?dldSNjBkb0F0Sm53cjRWMTM0emVHUDRvOHlOa2FMM3c0NnV4d1NHN1F4bXRM?=
 =?utf-8?B?UmZRY1JNV2ZCbk40SDdsdnBvdThDRXNGMXFwbTRoejJ3RGd5M2x0RWF1WnFj?=
 =?utf-8?B?VFNtbUFjV3R1Mkd6Tk43VjM1OEltRzQrSWVaZlA3TDgxUGY4dDZ5UmRaTkFH?=
 =?utf-8?B?UDIvUGU2UlY4V1ZtT1FDMit4L0RjTTVoWU5DMXQ0ZWdOOU52cUJpbFVDeEY3?=
 =?utf-8?B?N1ZTRndlSG42djJlR2FDNlYwc1RBVWNTWWt6emc3dGNJRXFuYUdFcE9KWWx1?=
 =?utf-8?Q?kfWwtYF0HdtrfutNtW5L4jvBZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807898e5-6eb3-404a-c288-08de20b58073
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 00:01:45.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf9BWpYSJ59LWbIrqoe1ErWCw/dPDiR/VLDOfmRlc6F8SLnZZe7JY5kwmbO/7j61FQpkyvvPrhV2XQsvLU5W4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On 11/10/2025 3:41 PM, Zhi Wang wrote:
> In the NVIDIA vGPU RFC [1], the PCI configuration space access is
> required in nova-core for preparing gspVFInfo when vGPU support is
> enabled. This series is the following up of the discussion with Danilo
> for how to introduce support of PCI configuration space access in Rust
> PCI abstractions.

Hi Zhi, is there a tree with all the patches and dependencies for this series?

Typically it is a good idea to provide it with all dependencies, so folks can
checkout the tree.

git format-patch also has an --auto option that adds base commit information, so
folks know

Thanks.

