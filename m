Return-Path: <linux-pci+bounces-12261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243F960577
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276641C2107D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E1194A63;
	Tue, 27 Aug 2024 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jC8YH3YI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A064CB4E;
	Tue, 27 Aug 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750592; cv=fail; b=UxYeefrNPotltpQSoCi4boBRehTigW47Bx3jGwj39l3SZnXzp6XwrumiN5mJZQYPzrn3q23Q5nw0UP32Afuxp0vKUcZmOgfHw8p3jQE4S/CfMNRVkKVUARWOQyJWWlpNr0L4AwR4t5l6pjYqtfdLY9uONiLMWLQdH41HiDgRFfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750592; c=relaxed/simple;
	bh=B38TdpkshJ38Y8pgyP6JsAGfM+18ulOo6CALV0E+q3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCVYnz/1E9z+LFsj7VFBL0V4sTleSAzFU+GlA8wDoadnAtxinkadTmlLKeJNXt5AXCco8moT02guDvhh2UgvIkxERHGGX/018xvutJmakykZUGUVcL/uNJwohbyfTvS0t/9B1AhdZZy77TA+p2VaSOVrx94DQOjH8ILoVMmP0mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jC8YH3YI; arc=fail smtp.client-ip=40.107.105.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAJ7AjCtK/UKQGAIP2KO+xNQ3AUYV5rLucJVj9vsoxdcwSFGujmLyBOqk8B3R2vM+bxg2nCWd9I4lwhmEjvOkI0HMafwbHL073IFl8w+tyoDcmcKkbA3d1ccYJd1IlACJNDJ2gG1X8BF3Jkyf6zIV+mKPeMPj9jV+2LFAzmaWAS7mAYInfEkDjPNv09Gx+ftQcj/gOBYrWjXeAo6zvzbAQrR/YUZbgaJUcdouTPXzxplCSckx/plOQoEXmfCODksrjn0dkkiE4YFNcoNoh3Xkitsdgdko2Qs7ICHlqJmR4PRAN6WElkGemufyP+ZwYPArZfQmDP0PkO5aAW2dWxm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIbabSVyNeYXxQWgzdDVhBI6tzjNnkdsvCkk+G/BfTA=;
 b=SAe0b1UzgBfG/ui3Pgj3mTb7NNlAIzHlyDVvc5L844FItejzwdnUREq2aF8vntR1t5YINiRjTiG4rM4QYcU+4ySa6BpIqwlJulCnkdq6BXhpaTKlYlELduKwvgUmlgqyJBwYDHsLY1m3IU27AwTtePBuX8zglUPSaiFgMKmRMkF+BuMTLtsxW5fEldcH6qGor5/y+xn9IOtLhWOTZliFr5yz3PdxBTpg+NzXlF11KGduRaAfJJjTaFTO9sMF4LiEUSCH03lBJiN67sOX2pYavTUZzsHhWdLl0DXy8cG0LkNGhxxh4HlMBVSD21U9GkwoCd0vJ8ajhjgeFdj6uF1tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIbabSVyNeYXxQWgzdDVhBI6tzjNnkdsvCkk+G/BfTA=;
 b=jC8YH3YIlZvc0wz0xGmpgoO2ickJAFiIo9kyZEYgtMnPL6R8jbdu1X4cCyCbTWYsnHRZWyiNQrl+3yHPwZJacxuzMUcvykv0UeN5wFz9TUuUNkGbMgwOBe7wXgCkLmc4D0QLTjJuLT5HeIGnz+TGUnZmO+9dInvBQn1igMwimvLoN+3ItwrsBGCdZO+LRVCg7wx53wBVVJCdo/IfTOhzDfK8zaQQQdwJbss6+FhwmU49HxESf4GukqvUIfyAdsyu7z2Cymch7/gYhEOjrF8OqFbsJL4GqeujJ/l0hWsZowDxB7jLzF4HjJvozQIZhxag7YCfgQmX2UCPUxr6HG5o9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7206.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:23:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:23:05 +0000
Message-ID: <bac7e1fb-83d0-40de-b789-0a4e469a0b64@siemens.com>
Date: Tue, 27 Aug 2024 11:22:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <93da058b-8d72-4f76-9ee7-f6837a1a4a9a@linaro.org>
 <3dcaee19-3671-4658-a2e7-247e42b85805@siemens.com>
 <2b368426-a572-4d3c-b991-9532fa828d23@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2b368426-a572-4d3c-b991-9532fa828d23@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 446c6b47-101b-48e6-db5e-08dcc679db13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXNQdVdVbTMzRVhuWFFFK2xEa2FpcXRtNTVYdE1UcGs3c25DYWMzeDNlQWVK?=
 =?utf-8?B?MUJhNUEvUEtCaHA1ZmdaK1NyLzRCc2ZGbXVWcDM3dkNQbzZqTURRYUN2bFh4?=
 =?utf-8?B?MVQ2RnZKU1o5VVYyUFJiQVFTYXF4UVdCYUxhSnpIN0trQnQ2YVdmampWZHdS?=
 =?utf-8?B?NUFaLzNRK3RlcHVCNExJeW5McDJUSHBSeDlCcHRoM0dnQU9VYTU4SVdSVVY2?=
 =?utf-8?B?SEdJUnVmWk9CV0RBSzJ0UHFKRjdDdS9uY0JiRS9pbXYvMThQb1Y0eGJuRFls?=
 =?utf-8?B?OFZXUkVDb1czSnkrT2JxVEZ3NzJQQ1JUa28zODhaUEMrV0xkR3JraXdJZmZ4?=
 =?utf-8?B?UktYbWVyNjkwbU1tWHcvay8vU2gvendtSGwwUGNKU0UxdGtHVlp5WUVsVFVn?=
 =?utf-8?B?QnNlVHhiMTR2TXYzN2taVGJMS3JnYlc1S3FiVHdUdnJWUTAzV0R2ZDdsY1Rh?=
 =?utf-8?B?Z21QaTByLzNWRlNtWUZtbWt1NFA3TW9ob2dsQlBqVW1FbEF2djNRSlNzSzd5?=
 =?utf-8?B?b290NEFxM3JxajFrVm1WaTJrNU8wVjRmZm0xS29WL1FGYlRxSFM0NE5pVi8x?=
 =?utf-8?B?QitnS2FkOUV2elJNT0VFejNmUHBHT3pTRk1DNVZ6TFhONXlnbWlFbHJlbnc1?=
 =?utf-8?B?MmpXZW5DcXMrakxyaW9Qa2RYUTJsU0twK3pqeklKRWtCdEgvaGg2K3ZLU3dK?=
 =?utf-8?B?ZDZ5MjR1QnZqZWpXQUtuVHoxUWRvT3FuY3RCd1h0WmdGVHBCSUpKbjEzWmxv?=
 =?utf-8?B?emgyYTRGWjQweWNPSkhLRzVqdFhtbVQxNnNNT0EyYityZ2Ntc2FZUzJnbTZk?=
 =?utf-8?B?djFJU0x0MFpIR2dBa3JBN1dvUVc0NTJYUmZ3UTl6dmMwL05YOVhlRUY1YmN4?=
 =?utf-8?B?bWhCSWtZUjlNN0lhNE5EZlEwUUxQdXZRS250YzBHYmZWL1hFL0puYmdialdE?=
 =?utf-8?B?SEtYZ0NSaGFJTW1aQXByeXZEaVBsU1F4VDE2aEV2aWR4WkxhMjYxdXEwWTNI?=
 =?utf-8?B?YzhPdURWN2U5VWxOczVTQ0s5NGtxQlh1bjhER2thS014enZmVWN5czZGVEd6?=
 =?utf-8?B?UVh6MzU0bXE4UkhMWk9FZnpuSDZyTFA4eEx1SFV6SnFmQW9vNGtMQkZIMkYw?=
 =?utf-8?B?Q3ZJclZFK2lGSVludEJPMXVQdjNndnhxMGVjamIxM0VucS9JendXam9uVGNP?=
 =?utf-8?B?TmhBZWM5cjBpODl4eThGVkk0QXJuUGlZVmxxMEwxeW91RlYrLzNRU0EzZVpu?=
 =?utf-8?B?Tk9tS1pUZ3lXbG1aK1l3T2VyODBxS0tmOXFONE5RaHJNb3dsamt3T29Waldk?=
 =?utf-8?B?bUpuK1hJVEdMTURlWEx0VEFuTGhPSS9ZeXl4Yk82Ujh6VTZMbnZtNkNDSUdq?=
 =?utf-8?B?TFZzSlE5cUxldGc4MXhlT2RCeXVNSHZEY2hnM2llaUZMTGNFRXN6blB4aDJK?=
 =?utf-8?B?aFgvcEJXUUplV2hMSGFmV0dYdDg2eXRNeGxJTURWN3VqaERLTDBIM25XUStv?=
 =?utf-8?B?eWtkSmQwZERDOW5RS2NkSnh3QjVJWlBEK3F1MmQweGJ2ZTREdnNKYkJPMlhX?=
 =?utf-8?B?MStidStWYmtXc3ZhbC9pTlRBOW5WamRLQ0QrTzhuTGNLS2JMcmZVelJpNHBk?=
 =?utf-8?B?VVpwSTFVMk9XK29WVVRCdGVhVTE0REJLaXVwOWxDcUpIWVpaQlFGaUpPR3Vn?=
 =?utf-8?B?U00xOTA5RTMrZEwvOTJHMGNGQmVlNVFGT21xYURic0gwa0xOMnY4bDV0WHhY?=
 =?utf-8?B?azU4cVBNNUlhNmR5SllabnNwcFRNZEt5aE02Q3VTV3BmbnZIZC8xSlEwRGZD?=
 =?utf-8?B?dnFKM1NIcXRKc0FuWDN4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2dqQWZiVGZnTEp2WSs1N3Nzd3JIZWRESTVEV05pU1gwSFJPbXpUWWQwVmh3?=
 =?utf-8?B?L3Z2T0xqUGVER3lRZlNDbkowZXV3T1Y3dWVTcFl0d2ZBb1RJcDNvS0xGajJC?=
 =?utf-8?B?OGc3V2NHNkZUSlI5Q1RXZFVnc0lEUnBaS3hCdkRJRnE0b1hFSWQ2UnJqUXQ0?=
 =?utf-8?B?M3hSN21KalNQZTcwZ3c0Tmp5THFsWm82aEhlSmM2aDhYTEhKMDlkY2NqL08z?=
 =?utf-8?B?NnpLQUZSTEFFUWxvZkhxM2Z4WDJ0ZmthYjhlRnF6MEN6WnN4Nnp6WTJESnlP?=
 =?utf-8?B?TmV0MUt3bkE1YUFJN3FocFZWMnJPckpvSFQ4WTIzUVZScCtBU1NhSUVad3VM?=
 =?utf-8?B?NzhkaEhXWnNNUmp4cUZrRXZDQ3gybEVrakF4Z2F4L3ZKdVNrWUdHSFJjVXZ1?=
 =?utf-8?B?bkUwcC9ObzBGaWhzYUY2WkpBWG5Ud2NicGJSS3lRZHVvKzFRTndFVSsxSE1M?=
 =?utf-8?B?TGwvWDk0R2h2RHcrUlB5TnRFM2ZvbHZYYU9JTlNyY0l2Q1lvd3FKSzIzVExm?=
 =?utf-8?B?aU01cktsNEdOZEtyakJEcHRGTlE5bUpGRS9qQ1BzeVdvRk54WDhXdFVlcnFI?=
 =?utf-8?B?Q0J5enhUSURvN0tYazU3QWdSZEdJWVpHN3FFWlZWNDVyRUhZTEIwbEJEcTdR?=
 =?utf-8?B?VVVlK0FqMlozWkFoTEdzQko3RFhjM3hEMW4wUHJnMmo2TnVHMG00UHhWbmhT?=
 =?utf-8?B?SlE5OHhMcTBMbWhyTXE4cElTTmxlOFozcmFuUkxZREJmZVB0czZGOE16bDR3?=
 =?utf-8?B?QW9saEs5ajNKSGpYSFZOVjlXZzJRNmtGRitIM3dwRjJrQmd3cGVkQ1M0Y3N6?=
 =?utf-8?B?RFNXaldCcXhldFkrRlpJN2J0eGhxcmZvZmVQckpDZjE3R2VzN3BlakVTWVpG?=
 =?utf-8?B?R3VYRnltSW1lZW1mZFNQTjR0OHFPd1YrU3RudnZoTysxek9tZUE1ZTNxbEIw?=
 =?utf-8?B?bTRreklWalNpTDVEVUpJTk5Da0RSeUFuOXNUV1dkem5DTkh0M05VZ0IvdHVZ?=
 =?utf-8?B?Z1Rqb2JGWS8xRlVGT2ZzNEU3VmluL09jb01mOGE3Nk9qYS9OYzFIQlY4aXN1?=
 =?utf-8?B?WklkUWFUT3A5Ti9PZVduUUN5bXlxb1RnTmtWVlFaUE5VdkdEbkd6RXVtTFl5?=
 =?utf-8?B?R3hUVVlsVS9IVnJyT2VSVm1SOTJxM1k0VHZveW1rOS8wNHl3amVCVXpYekp6?=
 =?utf-8?B?TW1FNU1LcXd5TUlKeGlYTFgrelJDanRkWU54RHpFTUc2TXg1UEJTeXAvVitv?=
 =?utf-8?B?VjkvcGZXaDBSVUY3b2tMRVFxN0dDTmhlODcxWTZMUEVIRzlwbW1Qc0dnWW8y?=
 =?utf-8?B?eVM1UWRocEhXRllIblNkc0FLWVlsOGFxMDNPdW9wZENFd3N5REE5NUFqQWhY?=
 =?utf-8?B?bjdLeVFsL2JCenEyRVNVTCtJTTNJTS9ZYmplRVdiMEZkTjlYSzVINUtkaW9w?=
 =?utf-8?B?TG5zZkdxV0tpUlQzaVJVSzNCY2RNS1FnaXZpMUhHTlVnT3FSeVFxaVJLSDh2?=
 =?utf-8?B?Q3d3KzVrVFM3RG0rR0pRL3lhRTJWcFpkTnM2cE1YL24xakNvODlNWDVXMXdx?=
 =?utf-8?B?cERXek1YNzZSUkxCVFA3Zzk1YVpZMzg5WFBGY1NvN2NJNjgyZVU1MFdTdWVw?=
 =?utf-8?B?Rms4bUVWNm5OMFlJT2FwWFVoemFjdE9ZcnI4TE9FVURzUlRrZHBTOW42TjYx?=
 =?utf-8?B?N2J1VldhY1o1VzRDT1Q5d01uK3Q0UDFkQkJGc25wcElKTEh4TytmZTk3eTJB?=
 =?utf-8?B?aFM0dmVmM2ZFZlFjYUtldE5QQmgzdk1zNmdYZm5lSDBqNUttNnc4Q0FZTUdr?=
 =?utf-8?B?OFFzekRNQlpXUVZvNFpYQ0hrOTRFalBnalRRak8zb1cxeTdkYXhFai9ZU05D?=
 =?utf-8?B?b1FpNDlxSmtBNnlhNnZTcVdUc1ZZc200YVd3SENwU1diRHVOSlh0SWY2RVNS?=
 =?utf-8?B?K0E1bExFTm1RZEg5cXNNRjBRa1MxbW1oaks1M0tDdUZiV0M3WVBwWjFpYmxk?=
 =?utf-8?B?RWZKb0lZeDE0Ykg3YUdabTVmQnlxV3NtY0U1TU5JbU1zN2NuZ0JBUTQvSEEz?=
 =?utf-8?B?Q1MxL1B1Q3pDVzRzbk41R2JXMG5kU2NQRTFnc1lFQXYxWXNYRXR4RU5TUHNC?=
 =?utf-8?B?TEN0bGlqR0lPUHozUFViVTh5VGxXaU4rSjZYNHpqTVJpZFQyNVdhbWViSzM3?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446c6b47-101b-48e6-db5e-08dcc679db13
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:23:05.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw4awaUPSceHzG9Sdpts197lKAP1ZZONoNam7f1MkYbeXWlZOpQTAJUGyAx17vmV4dCIKn8pO0tmY9wpzuKiXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7206

On 27.08.24 08:35, Krzysztof Kozlowski wrote:
> On 26/08/2024 21:25, Jan Kiszka wrote:
>> On 26.08.24 20:53, Krzysztof Kozlowski wrote:
>>> On 26/08/2024 19:56, Jan Kiszka wrote:
>>>> Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
>>>> against DMA-based attacks of external PCI devices. The AM65 is without
>>>> an IOMMU, but it comes with something close to it: the Peripheral
>>>> Virtualization Unit (PVU).
>>>>
>>>> The PVU was originally designed to establish static compartments via a
>>>> hypervisor, isolate those DMA-wise against each other and the host and
>>>> even allow remapping of guest-physical addresses. But it only provides
>>>> a static translation region, not page-granular mappings. Thus, it cannot
>>>> be handled transparently like an IOMMU.
>>>
>>> You keep developing on some old kernel. I noticed it on few patchsets
>>> last days. Please work on mainline.
>>>
>>
>> How did you come to this conclusion? This patch set was written for
>> mainline, just rebased and tested again over next-20240826 before
>> sending today.
> 
> You send it to addresses you CANNOT get from mainline kernel. There is
> no way mainline kernel get_maintainers.pl produces them.
> 

That is likely due to that I didn't re-run the get_maintainers.pl for
all areas of changes but rather reused an address list from a slightly
older posting, sorry.

IOW, your assumption is still not correct when it comes to code.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


