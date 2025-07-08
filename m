Return-Path: <linux-pci+bounces-31663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68016AFC50A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB027A595C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CBB29C340;
	Tue,  8 Jul 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WV0uzqqH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139910A1F;
	Tue,  8 Jul 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962033; cv=fail; b=eef0E8cO88d3K5pk/aSV2c+/EMjb7odCEL58zQOKZx4vF1kw72KmzhKeoR5CJJvjAoXAOIbpLx1rHhA+xo8d3Jrdqn9e6gs8YXElzduHxiWYoabmGo/qHU22d7wnUrFNK4sJplMI3035/5Y9LmT5HUWT2KXuL7x8uMwSI+QMiqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962033; c=relaxed/simple;
	bh=7FsBPlXKTeFih7UrZRYuosWGZXofxFwyAz2MLwItyks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uBnylBC3+XdWbtTlmZC6sSS96HAMl5HVEC2b595/m5uOHSseQPhkpagEg8BC+XDVkS2WFa63hWn/s762HyW4SD8q4bo62IU2Axp4onxID6XIPQzwipcJL/qrCDCxdk/VCdGVS+vUdMHsovTRcNW8GGN7DyMtcg/kbEGRGlrP2Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WV0uzqqH; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3IGA85jGkkLU2yhC8AyKJk6cUHCpCAFRgTPehLdGpWumXheE0ZadMglcjhNdrnCoAbe/teczVeEFZWAvIc+4u9ssVw5aIhjFLolqK0XTfC21TC3+If97g3ZMwmNXYbuUKHb87+Cl/YS7z7koR3IuRfkvAQvte6VYOfvW/SWH5uMBoDaoRLRN0MbcX9v+w6F3XJCcVGwCUM7CLS9zB6klvKdePBJsUJ5wCy4dDpd8ogvYa93AglIno8ux9k/A6KqeiuuFu7/5jRtW9kPUgxD76OmIqbKimIpk1h5up7fQMZw6oU2iZKUyW+sO1I8fJCiuqIFsKk1JkTAa5syc7tuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5umCpr79j9qYqmvZsx53wd8gQDDACK17UH6TEkVWoQ=;
 b=ZDiNv6nSTgaYo7h3O23nYglMVlaTntn6x6Fz8mTtbbqeCfEdTJTpnNzOWJpsb2cCmBAxGfUWu0wbpG32r4X6YvCINoi5Dfyjf9LdCW0V7IPGxfcu14UL/7PfL+OZUMKJGKeUraB3blLrNf4LB0ejVpduioTZjBwBax1BKBc7AwSqUTGOfRFXE12/1JOWPuRkX4LdfYYrVDKpdAsEjCLsZAoaYLFk3//fF29Jy84VJoz6JRdLGCFX0NUfYm4iZmOX+48FJ/5Q9OMpKbUuS28OwQhrhK+7yN+Qjlx0IjrZW7cguuf68lnpuauWMCvXbBW4NeKzbKCN52SxLguRM3jyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5umCpr79j9qYqmvZsx53wd8gQDDACK17UH6TEkVWoQ=;
 b=WV0uzqqHzP7pAMiDRsnujbPzq4V4C4F6oeLtPzYLyadWWAUhI9FneNnIbjlNMAxXIhLnCmhuQGk568n1CX7K+1yTHdYI3xmnKBBk6EOyzehf830kBzaoNYwbCfeCjQgBdIzWj6TGrOJbilLGskiFUryWFj5skBMuYBsVX9QEmt7l6ERYqDaIYh+/p4wZTFLo601M7+sC7mGCQgDKyCMNmztZmJkrAn7OkefbvZzla8Ah5E93dknjNFnsxd4dA0wZp1XbFfJ6raX3VzhfNAPv+DMRqYzBQrLmwJMTIGJTu5m/7gyPrep6/0rK5uS5zxCvFgPLSBl2Wu2PfjujB+DM0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 08:07:08 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 08:07:07 +0000
Date: Tue, 8 Jul 2025 18:07:03 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: Add dma_set_mask() and dma_set_coherent_mask()
 bindings
Message-ID: <5nvcgno3xgybfo4dncfcw6fdm76eawf4nagoerwekzqaeftqjo@eiux4q5afuaa>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <DB6HB2VCI9CO.LCNRYZD6HWOJ@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB6HB2VCI9CO.LCNRYZD6HWOJ@nvidia.com>
X-ClientProxiedBy: CH0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:610:b1::32) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: c99b7f05-add6-4d78-5d45-08ddbdf66ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnBHVmd4c3BvcEVTTSsycGpLQ2lFT091Q0N1R3NLQXkrUEgvTG9ibG9mMFlL?=
 =?utf-8?B?endkZ0VnRy9pd3V3NlV2NUFYWE0zYktnaFlNNEM1djlKQTZJOEdEdG53YmY1?=
 =?utf-8?B?dGtZKzQvc3NGcy91QlFmQjV6azhwbVZkbUVRVVJ2NGdxRm9zUGhuZDF4ZmRR?=
 =?utf-8?B?WWhrSWxOUjVLenRqYkNIb2tGMDdvejhzblAyUlg0Z0FTWEtEMEtocEoyMWh1?=
 =?utf-8?B?a2NuWFpDb3ZCcXpxaEVjaTBVVUM2S3cyeGxVVjZmRzhka2hHbDhoRk5vUDFJ?=
 =?utf-8?B?bkVBZmNNVHBPc3RYZnBBTkpLbXB1YzdhVUxIbFhjRmdZV1llSDNRbDdFVVpI?=
 =?utf-8?B?QUxiU255aTEzMWNWeEt0K3lDYVR5aGxEOVZVdDlONUc4eC8reDZOR2tWUGN5?=
 =?utf-8?B?RGpRSkJZbGdGRkpIaVcyNFFsaEZDQktrdGZGREQyc3FEV3pWMzR6MVQwYUVB?=
 =?utf-8?B?cHFTT29SOXpwOVNKRmF2RDBLWUpwRUNReFF2MTc4T0F1bDlxd3l3Smdodm5U?=
 =?utf-8?B?STVkVk9WUkFSTGdaaFFZNzljVGZ1amEvUTRHNTVLNE1EMkF2ZUMyLytvam83?=
 =?utf-8?B?SFZ4UUY2bi9BcGlraG1BWlRpMElmVEx4amwzMXJ4eW9INnRhU05Lbm80eVNq?=
 =?utf-8?B?Y0RscThBdS85NGY2RTV3K2p6OW5MOWorYVlFWEsyOTEydUdQYW4yejBIY2kr?=
 =?utf-8?B?QVp0MGI3Zk5yMG5XZzB2cGl0dXJuRk41a3M0YnJzbndiVm01NjBlVEZMTG1D?=
 =?utf-8?B?L2swNFh4TDJIVEp2MlIvVTlOeEYzeWsyY0JVNU01ZWcycjBPKzcvUHp3a0xU?=
 =?utf-8?B?TS8zYjFPeTVEMnAxU1NObGw0dWJIVkhjVkNFT251KzgydSt6U1dWZzN5WnFh?=
 =?utf-8?B?ei8zdkxOR1lFdTZPb0tyOW9jM1Qzb3VWTjM0SCtFMXlIYzJqZmtCR1ZaajZC?=
 =?utf-8?B?QjdqaE5rSEpyWEt0amNteGVIdWVNeVNUM1gyNWJaQ1NtL24vbzVkZ0Q2U0Jq?=
 =?utf-8?B?TWZ5UE5PWWxVM0l2U2p5NUx5NDN0SU1QOFU5bEh2UkQxby84dEFPTEtUdnhm?=
 =?utf-8?B?TC9EZFhXdC92SlVBdCtqRHUxZ2tYNTl4QWtsL2VsVFF6YnJ0T2xYYkd2MTlX?=
 =?utf-8?B?a3Z6T3RJV0Z5Q1BZMFRYY3hQbnN6Yzh2Y29SZU1qV1MySkovVjRZT2xnSHRr?=
 =?utf-8?B?RFc4dzRJaHA0UzBVQUEyWW1hTzF0RGtxU2doTERuclJWTTZRNXBxVFFGcFpD?=
 =?utf-8?B?Y0MrVUVuc2RYbGlNNjZ5N3FQYU5jMEVjVzFRQTBQNGM4ak00MDhIQzNSVjFs?=
 =?utf-8?B?aG1tWXNPcUJDaVo4aWpLVHlpV0VSUlEzeW5OUi9ORElCZG80TXRsM2w0NzFK?=
 =?utf-8?B?b0RPUHN2WkdkQVNzQlpxUTc5NFFscmQ3WXpRbnB4SzZPMTBHRm1WM215YVdN?=
 =?utf-8?B?dExRcC9kay96bTRFc3VmNzVLSmpZSkRwazkrdjZxL2JvQUJwTUsrUUM2ZnQ1?=
 =?utf-8?B?YzhSUTdDQ1RHRkVjT0M3c1V6Z2RuSC9jQ2R2ajBLY2JPNzNZUUFoM1FQdHlJ?=
 =?utf-8?B?TktYNDFMckNiRW5CSTVBVEZkSGQvWnoxK3FST2FGUEVSOXRXTlkzM05UU3lo?=
 =?utf-8?B?b0V4TEZobmREcFJhUlBMU3NmY2FqUnBScjJHRGgvaFpmWTRzdjRVVHEycEU0?=
 =?utf-8?B?bmxDaVZSUE1PVzV2VC9lK3lzdGlZM3kwU0pJTlp3ekp4alRLMWlyb09sQXVt?=
 =?utf-8?B?eEorY3ZYL29mdnRyaGdTajVqblNrbFdCUWZ1cUJYL21KY0Y5eWtVK1F2YVFS?=
 =?utf-8?B?YWNmNEZmMVQwVWY4TUxHN3g1MGV6Z05lQll0elBYNVZzS21tdnJwZU9qT1VB?=
 =?utf-8?B?SHJIRHhsa1NmZ0UzbFg1Q2xyVVFQcmtCN3pOTExtUVVTbFVqUWpBYkNFdU5F?=
 =?utf-8?Q?9Y5S0M8G6u4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDdWZnVVZ0FsdE00OXIwcEIxYytMRzZQVFhNdnlaT1pjUk84ditNdnZsRnNk?=
 =?utf-8?B?SXVWcEFjUkZWa2poVlp5M01xQ29Keld5T0ljNjZHM1hHL1AvR2RHcU5YSkxC?=
 =?utf-8?B?ZWEwbTZ4cnMvc1BjNUN3eEFoY0t1U2Z0NFdEL2NvOXo4SDdjZDRscHFKQjFY?=
 =?utf-8?B?MnZhdzEwdWdISmVVL05nYlU5VDZUcHJ1L2Z3MTBseTlXeFRuVzdib2pYcUdJ?=
 =?utf-8?B?ZWVEa3MxdHBVMi8valFqVTFTZWk5UkFJSnh0OUllWmd3THluWmNSTlFlZWNq?=
 =?utf-8?B?WGxOS2JpZ015K0NoZTlrR1dlMlNEakZmYjIyR3p3c3ZaeHlIRmp0UnZSR1g2?=
 =?utf-8?B?Nk5QTlFxRlRkYVJFZFN3VGxzcFdJTVJEOTdTQ1BKSTZxZml0NFczdVYyMHQy?=
 =?utf-8?B?RmRvV0ZXNmJMUVpjbDg5a0ZKYm82MGhQdXRyemtCZUkwa29UdXJGNUZXUHBX?=
 =?utf-8?B?RG91cFNiOXpHa1J0SzhCOU1iQlZYU3FGNmNXVXMwdGxIcVVTOXJIZmw3d0tp?=
 =?utf-8?B?N2xyMGdyeFNTZ2NsM1p6bFU3SStDaHhvcEdVeHN2ZnV5R3Jrclo5UGRUTTJ5?=
 =?utf-8?B?eE42eHc0bFNQMk5jZUlYWTZmYVhZQXVRNGg0aTU2VDNmcG5jbFVOcmVJdHFH?=
 =?utf-8?B?Z1JFOGJmeVhNLzdUWnZrM1JNa0l2dkFDVVk5OUgwQjJnekdrS2I2TEozMy9q?=
 =?utf-8?B?TFVUYkRYYmdDajFocCsxd0pRNVJTRzNyZ05WTVF0QnF5SU9SdDl1amtVa1Rn?=
 =?utf-8?B?N2R1WnhEOWROUkxHbkdNNFNlVUVjekpZTHJrU3pCNlpyOVBVWWVjdlFEcXVF?=
 =?utf-8?B?NStWcnJXL3BjcHRCMzlXd3FycitUaHNkdUdyMktxbENna2ZQQnNRbFg2bVBS?=
 =?utf-8?B?eEcvclN3MjFjQ1VpRWV6amxFQlljN2VFS1lBQU1QN2pnVnZLaTZTMVI1dDQ1?=
 =?utf-8?B?OStQK1AwY3B3Q2VLa2FQcWZPKzZtemJVdE4wWmMzYVVSVFBlc2V3SFpoK2xa?=
 =?utf-8?B?enp6eUhnU04rU25VMHFZQThobk9mbkdFQ3A5UlpTOUhVOUJ1eE9vV1RIWG54?=
 =?utf-8?B?bTMrcDkxSU1KSEYzRkhIK09maVVQUDdqdUY4VGxLTWpFbnI5UVFiODJlSStk?=
 =?utf-8?B?cTVNNG5oVURGajhuUTZZKytkYnp1QUpqbnFudGZJRFdPdzhSVnB4RXFSM0tx?=
 =?utf-8?B?MHZTMWVXd05oc2FBSXNtUjBiT05HM1JpVjhTbllMMnQwRXRMOVNIWGlRZFpC?=
 =?utf-8?B?ZFFBdkZvYzcxYUtFWDIvVzhLTVlkcDExdkZRek9oWktKV29rNmRmZXd5ZHVO?=
 =?utf-8?B?UXdtL296THoycjNrcFE1dytiM2RQYVhFdkNxcUJKK3IxUDVaTUdnMHR1a2cv?=
 =?utf-8?B?S3pVTnlwTnhUREdzYmVObGFDWVUxY2RoM1Ftb0FGR3J3eE1xbzNLekVxVTRW?=
 =?utf-8?B?eDE4VldrTlNUQVFxbTFKZHlXNVdBTGlmb2tWL04xSlRISVUzRDNoRmRwUTJm?=
 =?utf-8?B?R1dnVnczYWxOaEFsSmc2NVdrM08zRkF3T2ZzVStzZDBBR3M3cllVaVJnQUZs?=
 =?utf-8?B?OVFnbzVRdVR2T1htS2lHWTlJTkxzRXVFOStjUURXS0FBc2pxRVNCZnZSdndk?=
 =?utf-8?B?UFRtN2p2YVA0bUJsWkVRUHlXYXVrTzNiRnpYRXg2c2FNQ01DS2hBc3hzWDFV?=
 =?utf-8?B?ZTEwemZnaEZFVkxmMXpJdXhWaXp1VnYzTTRVWlpSQjVTOVNGdnhnbk4zZUsr?=
 =?utf-8?B?aTNzUHNYZUlSL3dZd2VqdjlYWHJ0VG02cklnZVJiY2xGbmEzbDdpTEd4NGxm?=
 =?utf-8?B?eVo0TXpUZnhwQTZIRUZRMTFEWXZndGlhYzZBN1BiVTNkaDNYZU5DUWdYVXly?=
 =?utf-8?B?Q1NFUzU2SWRjak1WQmdhclBibm4yTUR6MmdqK2s1VDBtUkhpeGliY2JPZHFw?=
 =?utf-8?B?UmJ3Q3k5ZDB0eUFOL2lpQTlNR0twNjlzdzJ4NFk0ODFQK3BmeGpXQ1JJRitK?=
 =?utf-8?B?UXFUN2dVSmFrUWxVYjk4a1F5TnlmVlZrR0RBUHBVUUFsMFhyNjgvUS9yTisw?=
 =?utf-8?B?ZldSVVRYN0ZNY2czclJhbzhQejM1aHJHbHhMTW9ycnN5c1I4V2wzSnQrN1RE?=
 =?utf-8?Q?f0DMx2t3wEt2M6LYqyWRrWPLv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99b7f05-add6-4d78-5d45-08ddbdf66ec6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:07:07.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mx3tiuiW6TS/0Z9Zyk0M81DmCIsmS4hAnd0+nrmZIJsxDGmFE9yQXbZJ0y+Myz3BiGFD/xWUlSYIi3WPAgauLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

On Tue, Jul 08, 2025 at 04:01:19PM +0900, Alexandre Courbot wrote:
> Hi Alistair,
> 
> On Tue Jul 8, 2025 at 3:04 PM JST, Alistair Popple wrote:
> > Add bindings to allow setting the DMA masks for both a generic device
> > and a PCI device.
> >
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Alex Gaynor <alex.gaynor@gmail.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
> > Cc: Benno Lossin <lossin@kernel.org>
> > Cc: Andreas Hindborg <a.hindborg@kernel.org>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Trevor Gross <tmgross@umich.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  rust/kernel/device.rs | 25 +++++++++++++++++++++++++
> >  rust/kernel/pci.rs    | 23 +++++++++++++++++++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index dea06b79ecb5..77a1293a1c82 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -10,6 +10,7 @@
> >      types::{ARef, Opaque},
> >  };
> >  use core::{fmt, marker::PhantomData, ptr};
> > +use kernel::prelude::*;
> >  
> >  #[cfg(CONFIG_PRINTK)]
> >  use crate::c_str;
> > @@ -67,6 +68,30 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
> >          self.0.get()
> >      }
> >  
> > +    /// Sets the DMA mask for the device.
> > +    pub fn dma_set_mask(&self, mask: u64) -> Result {
> > +        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> > +        let ret = unsafe { bindings::dma_set_mask(&(*self.as_raw()) as *const _ as *mut _, mask) };
> > +        if ret != 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(())
> > +        }
> 
> I think you want to use `kernel::error::to_result()` here?

Ok.

> > +    }
> > +
> > +    /// Sets the coherent DMA mask for the device.
> > +    pub fn dma_set_coherent_mask(&self, mask: u64) -> Result {
> > +        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> > +        let ret = unsafe {
> > +            bindings::dma_set_coherent_mask(&(*self.as_raw()) as *const _ as *mut _, mask)
> > +        };
> > +        if ret != 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(())
> > +        }
> 
> And here as well.
> 
> > +    }
> > +
> >      /// Returns a reference to the parent device, if any.
> >      #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
> >      pub(crate) fn parent(&self) -> Option<&Self> {
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 8435f8132e38..7f640ba8f19c 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -369,6 +369,17 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
> >      }
> >  }
> >  
> > +impl<'a, Ctx: device::DeviceContext> From<&'a kernel::pci::Device<Ctx>>
> > +    for &'a device::Device<Ctx>
> > +{
> > +    fn from(pdev: &kernel::pci::Device<Ctx>) -> &device::Device<Ctx> {
> > +        // SAFETY: The returned reference has the same lifetime as the
> > +        // pci::Device which holds a reference on the underlying device
> > +        // pointer.
> > +        unsafe { device::Device::as_ref(&(*pdev.as_raw()).dev as *const _ as *mut _) }
> > +    }
> > +}
> 
> IIUC pci::Device has an `AsRef<device::Device>` implementation, why not
> use that in the code below?
> 
> > +
> >  impl Device {
> >      /// Returns the PCI vendor ID.
> >      pub fn vendor_id(&self) -> u16 {
> > @@ -393,6 +404,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
> >          // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
> >          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
> >      }
> > +
> > +    /// Set the DMA mask for PCI device.
> > +    pub fn dma_set_mask(&self, mask: u64) -> Result {
> > +        let dev: &device::Device = self.into();
> > +        dev.dma_set_mask(mask)
> 
> Yup, I have tried and `self.as_ref().dma_set_mask(mask)` works just
> fine, so I don't think we need the `From` implementation above.

Right you are. Will drop the `From` implementation for the next version, thanks.

