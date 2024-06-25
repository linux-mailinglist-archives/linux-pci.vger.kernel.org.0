Return-Path: <linux-pci+bounces-9259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58391741D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 00:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEDC1C20D24
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955717E47D;
	Tue, 25 Jun 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="y4EOwRLs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387517C7BF;
	Tue, 25 Jun 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353451; cv=fail; b=slIiCIU1iQSpnvOqqXGt/6BL7nhXmFTp+iAbEzYisJ3o1p6Vlou7XkUEPyM8GIwPrWFlz1s4D/61+Zm1OQrSIKLMagAjWJu367V3vFm6Sdd10SZrJLIv43lQESSnetYN+tVYGk1OTTzmMAOnNELSoqkMIB4q+UVOwxEyv4CQz9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353451; c=relaxed/simple;
	bh=i2bAgGggPHbmeIZacOUy10iuu/bwgLKX44SrW2ef+lE=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=QBF0ky6wzPW5B5pWE8mZgBeZNxYaDX9J2Cen5cIVE1OurD/Hq8FEjRTMojnDuADRfFtTXqYOeYCfrV7rzV+TV6BpKXHy/5NnmHbLe0jqq9yXOEQiwSW+wupBMsni2W0wdanJHJlYiu1+WKesex2vag3D4jOym4F8vd9nm5E9byA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=y4EOwRLs; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+kKG56JBahoUnPBXINalBUhSsQWsBRAKnh0cioL2uu8LNzoU3b+9WbCJZMfSD8HKO2ATjjpGUI7D3wS77XUNm+NHXzInBQ+GjhytqPoJnDsBgi1RgcvV4iXCA3t/2aYMCti7cMU1WzOtsGFikx0DSMAyBYO2Jjz/w/id/RA3kHr6yo2FCFz4Tl4Abmx9Mg9Zy5sZ1YL8JTHeMpJQketq6lBWhuL5oM+DAUvN6WGUsZpPTi1feB2sxRcfQFj0l+5UemtdFm/u2JB9+SgKoOmtxYGZ+LRruiIqDXFRCYB5ESceisK+Vu1NyDEvwTr6m/wtKt1+6pOQM/WcCMbKSxDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdrOeykPc13dkVn1StjnAmIPjjVIwFu17/FVhqT6sSA=;
 b=SupQQp7u2rn5PIE2M+HZGkieOKF8MusyCfp9c1EV0TtZAcSbfsgiK9GMZpCHacpD6a79V1AP4bfQnYQurt7uO4RUFlReUwBcWLhM6pSfwNm7MXcqAa0Y7lHydxid3dNfv+Hl1dmymnUwKJr5Bv2NlvxwRq5N5i4vVKBH0n1Rd15FTznyI6WlEwKAgryBksTaFAQxma1fDHmxi3kMrwsjMQxYQmiNyg6Fg1rl/sRuSoijfTFxklyEW8Usjh5raxx5va4WGzA1F7ELzAwu6picL3gX0WzO6eB2/StGOQ76qxQnMjFLp4F2rRbSGs8Fj4HJYC86EyvWLLxh3sAHievMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdrOeykPc13dkVn1StjnAmIPjjVIwFu17/FVhqT6sSA=;
 b=y4EOwRLsOQ27FDDBvTXbv/j04l2K2D9F6I9CUtdeFsbdu+HFWySA8J7cAYyp5vETiqQ/ayU13KbO4lai2tuUDNGR5LeQMPMJgw3ca3bE6bU24gYwWFCtdJacAEuHEA3+gW2EldEMfIoQui3y+33+OmJJ6Ks6k5TzPeqCOvecNm842KrRXXphGlifAhe3KESJ/Ibm0b0lJs1VrwnJXsrZ+5g9Jijspzwb0lZWuuJtJFwMfZbMJ+omiZ4uScGQJx+TJGMh5GER3gqNqpo8w22WejNz9rTLQL0osGMdpwT0p+ZEMM0VLhRBoAxdO9Q8iNMiT0CvR5TMq012b9Semdbr3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 22:10:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 22:10:43 +0000
Message-ID: <819861d0-1b3a-4722-969c-d2f48b624622@siemens.com>
Date: Wed, 26 Jun 2024 00:10:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR
 1.0)
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3631:EE_
X-MS-Office365-Filtering-Correlation-Id: a027360a-94cd-4285-ca5c-08dc9563a842
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TS8yVjdCQzEraWhFY3pQQnl1VGJjNmtJMnRJeUZ4QnI5N1MwVzlvTzUwbGhU?=
 =?utf-8?B?aEk2Ukw3VzZrc1l0c2UvZGdiTThtZjNzYm85LzU5Yk9PV084N3hrcHlJeGRR?=
 =?utf-8?B?SzdBSVdndzQ1d1U5Z0JDekZpRkJxSzBjT0taVFlWR0FMT3VmWjBUc1g3aG5z?=
 =?utf-8?B?MVJNQ0tFN1FUM3pOOGFXbWlhMnFxMHZWUGZqUHAzb2JvOW9kck1Hb01TYUFm?=
 =?utf-8?B?dWtCWldVUTIrZ1NhbFFwZHFiNytrYkhiWmdDVnNOb3A0a2YrajlWazZOdmVG?=
 =?utf-8?B?VjNQanZ2VW5rWjBmcm9VUmg1UDZVWXVydjgyTy91eXhPNW1yRGxjSXB5eVVp?=
 =?utf-8?B?aEc4dVRMdTQ4Q0NaVWV4OHJjK1NDK1o5SFJqK09YRloycGIxQngxaWlIR2Jr?=
 =?utf-8?B?ZE9pVm51YmlVSG83d05pTmR0cDdkbTl2Tzh0RmloUEd3QklUc0FsdG1rWlZu?=
 =?utf-8?B?RXBGeEpkZ05NUXRQclY0UWxCWmx1cndVbEl3dkJObW5RMitlU0J4clBieWJ1?=
 =?utf-8?B?YlN5MC80b21hZkhTRERtVHJUQnM4clNyajlPUkRrbzVnNUFkRDdIRVhpc3Zn?=
 =?utf-8?B?c015cWdNUm8zRm1PT3g1UHNiL3c4UHdOZmhVakZVYXhVWSs4WEo0Wjd1bzI1?=
 =?utf-8?B?NHcrRDYxSlZrMjhWNmRSV2FVVUxjZnVmbjlpVnpiTDRpSWN0VFVJaUpIbkNZ?=
 =?utf-8?B?WmVMb0lBby9tK2c2b2ZweWd1MnJkVW5kdnM2cnZ3SXdTOTRveEdVK2xnSXZM?=
 =?utf-8?B?eXBCVlJST1N3SUZxMnMvNEt4eG9xcDZGeGVoUU52MURJQkUxOTA0NG1EWjNP?=
 =?utf-8?B?WTBTc2d5U1hyU0NUWkVFaVJWQWF0eFZFRVFNT2RML1FpUzM1YjVaNEpCajda?=
 =?utf-8?B?Y3NPL3o4dW1WMVdtTFpyMzZ2eldCOE1QTlF6aU9Ub05UWEYraHllQjBteUR6?=
 =?utf-8?B?WjZPZlAxMTJxQ1NaWm5wUDl2U010ak9CUXBGNWl4dmUrclZWcTZ5amFRTyt6?=
 =?utf-8?B?YUxZcVFrUmhIcCtySTlyaDNNZDNKaTB4a0pzVGZTdWIrMHBBTGlRNXh3Y2pP?=
 =?utf-8?B?bkxSUlJ1NmJiR3U1UEkxS0VwMjBzMG1Kejg3RnVyV1Brd3NDaVVGYUtSOUs5?=
 =?utf-8?B?UDlBN05ibjhsQ2R2V0FYS1lTa2R3SDJZZmNQQmlkaThmVWUyR0NUZGRaMWNQ?=
 =?utf-8?B?anN5bWZBVTdQQTFhNTlpajV5Vlp4SFNCdnlxRE1WSUVqcVdJaFBXckZBOFlU?=
 =?utf-8?B?TjBqclpPc0wzNk1SVnhVV2t2T2t2dWVvTmt2T2Z6MzhlTGt5dXR2cnZOTXBu?=
 =?utf-8?B?ZEFDOHhrVUloWndkVHdwclZJUE1oM2Vyakk2eDdmUHU5MXh6N0hjWkk5RFpz?=
 =?utf-8?B?RUNxdTIwVXB3QWVTdWNCYU9wSXNrd2h6a3pLbmhWWnA3bFlKVmlqRzVhTElN?=
 =?utf-8?B?V204ZHkxNkdNTDc1SThsMUJjcDh5d0NuZnB6aFgvNGRLQnlXV21NcnNIdDBi?=
 =?utf-8?B?OUlTWktuOUphRTRMUDhsa3hxS3pHZllIZW9ZLzZjaEJCc0s5Z044cG91N3Zm?=
 =?utf-8?B?ZkZxWXVTMk9PaDRqN2RGR2diaTBtWjJWL1hFcmtxUDl5UUFoeWpWdkp6Nmx5?=
 =?utf-8?B?NVhsRm9SdmU0RzFHa3RvOTViNzhjVHBsTlJvMlAzU3QvMHJOWHgrcTVvMlM3?=
 =?utf-8?B?dm1oY1NNb1dISCtEaXdjcHoyNk43WDE1SThYSmswci9KcTE4L1QwNDdSSEMr?=
 =?utf-8?Q?ebc87nucm6wcVRGml4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDUrYk9YYk1nNUZMREh0YXc2OXRaWmc3Rlk5Rk41M05qc1FKMXNiakc4UDBK?=
 =?utf-8?B?QStOQTA3ekdXR0ZYb0U4bHcra2lvdTV1M005VDd2VlNPMGtXNXdzdk5BZ1ds?=
 =?utf-8?B?ZEh5elgxOW54Njl6ZVI5UlFHNGw0SUFYcXBQTnlUTUk3VFA3N29jd2NDTE5D?=
 =?utf-8?B?UFdOVFN1UG05dUp5d1FNTWZsZ0d6cjhJM1llV3EyUDdURDJ4UytmWEtUNWc4?=
 =?utf-8?B?WFdRaXJVd2ZhcUVURi9JUnFPaUFzRGVnRUV2UURYNit5czN0YThaSXVlNVND?=
 =?utf-8?B?UzY3djJ2T0kwR0VoOVYrZllMWWdMNmhRTHdhd05oMlE3MzBaQ2RUd0trRUlw?=
 =?utf-8?B?ZjN4SEZaZFpPRmxpNUMxajBBdVZuejRZUTc4SkFmbXB5T0d6dk5wVit5akxr?=
 =?utf-8?B?Skl2LzA3a2twdjEvUzd3RXBydTRlazU2RzQ3bEg0eng2NFU3N1Fjdml6Y1Iw?=
 =?utf-8?B?bnlVS0dGclB5S0dkMjl3MjNSd3o4VXptZU1nTWRzNURCa29BM2N3ZHFKb3VQ?=
 =?utf-8?B?RC8wU1RLa01XRFd6WFY1TkJPOEU5TUN5VGg3ZUVNSE9FR3JFaTEwbUxlMjMr?=
 =?utf-8?B?QjR0WC96ZEliRVRjaGUrc0JmWFZaZEQyNzNzdllzejJ1VXIzeHFxUmRaMU1V?=
 =?utf-8?B?WlBVVmQrY3RSM05wVVFuemFxZSs5YkRoU2pPWTRKaFFKSHpkY0phT1pyYmJy?=
 =?utf-8?B?QTdmc2szZHZTTEtnaWFlRWZTZkdndTJNTEhPYk01dXFwSEdvNTZZTm9RQm40?=
 =?utf-8?B?VExRUVF2bVdwUkY0UlhmZXhVanFQUGlWR2cvWWppZW8vazg3a0N5QkFIaFVn?=
 =?utf-8?B?WmdHTmRXNXV0cytPZXdIMTZYQWpRZkxEbVY1YndqbGdiUHc4VjdLZUYxUmY4?=
 =?utf-8?B?QVExQmRnSGp5MnBLMDRScEV6UzByQjNERkorOXJkY29EOVBwbzYyUlVpbDNJ?=
 =?utf-8?B?UW9yc09OVElUNUwrdkVFWlQwZE0rWVF1cFd4N0pGRVB6cUpzalNxTmR1R0VS?=
 =?utf-8?B?S1VFaGRhUzBhSWVoVC9JN1VmdWVKcmxLZzVybnI1dEFsY25YSTFqV3FwRS9T?=
 =?utf-8?B?NFdENUhjb1ZXOG9KN0VidGNNWTZndmZSdmwyc2tkOUllZnlpcHNBVkJ6emVo?=
 =?utf-8?B?WFE0dzRmZVFNNlk5QllYVmJIRndrYVlwelFVT0FBTWw1L1RXa01SNnhSWUUw?=
 =?utf-8?B?TnVIVHhEdDFiekxBSkx6WkRhUi9mTXBYUm12c3dzOHFRWStOVjVpaGM0UExS?=
 =?utf-8?B?VURTVTd1QVFoQjQ3WkdBeGg2OVpEbU5UbW5HOUNHKzNrRzVzMmFuMm1VejdF?=
 =?utf-8?B?eW9VY3VoQkY4QUh2WUVlQ1l1K0xZbkVrdCtJRzNKaFZkRTlTaHQ5VzRndSt6?=
 =?utf-8?B?TEo0M1dOMWZFRVJ1R1NRbmNZd2EvdWFDNXZiOHdiZDhGeWxlbDZRTm01LzJz?=
 =?utf-8?B?b2tsNlhnOVE3VlpBTmoyQXhvazRIc1JHNWpzNC9hNHN0K3V6ZFdjc3hsRWtn?=
 =?utf-8?B?dlFXRURzT0c2citkZkpDVkZCL1hCNUhJS2FrcFI5Ni9xV004OGFMK0dYcDVu?=
 =?utf-8?B?ZkR5aHlqRjQxNFBsWisrbzNCcm54ZnpiU25BN3JHenZxazMzMFVPbGpqUVZO?=
 =?utf-8?B?dEQ2RDl1TmZranVsbGN5MW93SEVxcWxEZ0ZXZTVXMTFKTWQ5N202UW1CN1Fl?=
 =?utf-8?B?cGdsWXZlc1M3UnBPb0pDK2pyZ1FVRThYaFUzY0JnZlhmS1RBZkxXbWQyaUtp?=
 =?utf-8?B?TlBlWHBFOHJpVnpHOWpOdXk1dGIwODBtOWF0R0xHWVZSelVYUWdMUmxCb09I?=
 =?utf-8?B?T2o2UDBDRTZQWkVSb3RjSG1QTUwxM2piYm9iTGpQN2JoSC84OWIvTnM0WFBF?=
 =?utf-8?B?UjlLZWFRQUNWN3h6eDNRd0FxODQ3czZCSkt3eUZkOHlqVXJFNHRvMkY1eTFS?=
 =?utf-8?B?QzBnVGFrNmtMM2tZQS9HWlppZ1VhUzNIazdqRXBUSGNnOUEzQVBmU1FZOHIz?=
 =?utf-8?B?KytHVEc0VmFVS0hVdjlhenl1a25pSGY1Q09YV0pMdzhNQmw5ajBFT1M1NzQ5?=
 =?utf-8?B?VENDVHQvb0twaWI1dGlZODVHZ2NZMHlDOEZFZzNKMi8yRUNET3hUa2VBOFg2?=
 =?utf-8?B?OUtCbkl2SzM0OVVDNFJ6b1B0elVLUE5Yd25kUUhHNWlRa3NzWjZMa0Nsd1lr?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a027360a-94cd-4285-ca5c-08dc9563a842
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 22:10:43.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSOb1CUYH8OR0K9RvRXbppTw0lln1vzTMSK/L+AO/3lHTmV5p/+xBFHS8OsMX5IEtCJmIL0oZdWbvn+P0qEMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3631

From: Kishon Vijay Abraham I <kishon@ti.com>

Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
the bus may corrupt the packet payload and the corrupt data may
cause associated applications or the processor to hang.

The workaround for Errata #i2037 is to limit the maximum read
request size and maximum payload size to 128 Bytes. Add workaround
for Errata #i2037 here. The errata and workaround is applicable
only to AM65x SR 1.0 and later versions of the silicon will have
this fixed.

[1] -> http://www.ti.com/lit/er/sprz452d/sprz452d.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Link: https://lore.kernel.org/linux-pci/20210325090026.8843-7-kishon@ti.com/
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Needed for the IOT2050 PG1 variants. Pending downstream way too long.

 drivers/pci/controller/dwc/pci-keystone.c | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d3a7d14ee685..a04f1087ce91 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -34,6 +34,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -104,6 +109,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -525,7 +532,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
@@ -537,6 +548,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -562,6 +578,32 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 Bytes. Force the MRRS to
+	 * 128 Bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.43.0

