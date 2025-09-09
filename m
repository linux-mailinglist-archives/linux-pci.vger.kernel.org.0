Return-Path: <linux-pci+bounces-35746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F1B50090
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2025E598D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9921930B;
	Tue,  9 Sep 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iPqmZvKg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532A350847
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430140; cv=fail; b=o0IBbfwUIjrKzlIJg3q2KBBWAwIzXHy/qnwqxJHVOZSlvXNCRt3sctBMUEJqrq6SvA7kONH28pOCBT1JfoodsaNfTvRRd8kzBOZ3Rc51t9K1nzPU3MKscPV1pG3GHxLBDtBwY0ceyvhYxvPPLZJR6Dx8uyOo199rmcI3140zY0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430140; c=relaxed/simple;
	bh=Je6od1/La8J8dDYKGh7dyArzA2uZZLukFJTXLBeNHTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kP+dsUAS7kGOIpr6gNPExT2q0LdEcSV0UnyTA03ezLQDLQ4D1NaMRzYzAqW2xKon3QnTtglEVFVb8QjsZp52PZXbr6nOXCyuGEoQArknE9wnddLLJYDRqTL+WuEwsfrjKwIqlQGzmFdP4HxHSGm4H5cVyupN02+n8JMFLg2InfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iPqmZvKg; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPk7Rm+PJoHM23YkH03h/ahORvPP24SjmBypVBIY1wxO4u7p41sAQ1inGmTLqi3WvaKSmkha4qcmwFos7D5rVjfDKodFfa6q4mfmKoeqAki5MCoCjYqw3Y7UtzyNYUnMaPqQQzUfleAoR3VZEZNJ7zd0ASyE/KZp3zYy2NTJ8eKcHSQVTzrir6K7sHgad3yWe/DIbXsX7+4MvNBXuNdrk2QEhF56ySEMFW3lrh7oRo0qD6/yNU97miOxdDZ1mi4zzhKFqMke8Sl4G1uitwMdoKUwUc18nrf+zsgpmUl4Jk3Ahhed9UtYuDFbSdiACxJrp/fgMvSLCjNC1T+j8crH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t04n/MDy9DoImAyvdFOnudJco5exqPRF9nKmh/EUuik=;
 b=g2lMxYkz6ev7dW5Sy6edmyxIJT9NsYdm2/TfQHyoTmzny/jEkogiEIUItr4mW0EEHBsMIq/w67xclQH5YDWCVs/Zc21DedxkDGUVu6wEAClanMZEaNEJ0DghJPcf+BZ+ehvYWkZQmvVuxsONfrBroutxsqvjry+LoSPjEjTP+SLU1DW8IxDaaKAFx6aL2fXudVBq8zFDqQcchGhB6jXj5ri9Cva/qtxzBWeeGBy9BxDDvaGWAWCmBgwJiD47IjaZlo1d0ATHry+x+Wc4BYfqd8/WZWFaRdgc/QHa3w9CxPuHtTjGYJEqlGAqbuT9m5K8UcjCqMBKBnqiy6EdDqzSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t04n/MDy9DoImAyvdFOnudJco5exqPRF9nKmh/EUuik=;
 b=iPqmZvKg2HMjMldfUIl+UnNO2rDpFfiP4uTbxRFIjufPPv4FzYK/pIL+wfkxB3RU5jJ92pa4wiQx685OyPP3d1w5U39NhYGAq0nxNZKmEX4yLDG6NjYhknei1HkT22nhAK2X0oiw4NUdlgIIxj+h5hJK3l86pL++Gx555wQFptxhmXmBvKiw0VXusQMIA9yUGaBGHsmf8wAoWy3AnwJt4Sa6GlcvobIU1OR7uykG0HVJxq1e8UJqagFhHrCqA9qtYjPtXqMyZfqNDSIWQJDabggYKoEkmObergK3mH2BE8Ywy4eSVEz8cJ3G5bMZlbRE/7vAEVUmPyw5XEXn5FuEQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7394.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 15:02:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 15:02:11 +0000
Date: Tue, 9 Sep 2025 11:02:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Randolph Lin <randolph@andestech.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	ben717@andestech.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH 5/6] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <aMBBas7etQND7c24@lizhi-Precision-Tower-5810>
References: <aLF0-0u38hKC7JcP@atctrx.andestech.com>
 <20250908220737.GA1467566@bhelgaas>
 <aL_h-HnA8Dtb0G15@swlinux02>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL_h-HnA8Dtb0G15@swlinux02>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdaf1d9-2cd1-4b4a-7b87-08ddefb1dac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGo2ckpWdEdsQkVxTVZLS3FXTWJQS3Uwclppb3NUMnhCOVM3Q2V0ak5XWlFV?=
 =?utf-8?B?Y1JqY0lPbU0zSTlQMDFFVzdoNDd5eW5DRUxkNVd3U29TdmlRQ1hoSnhaMkUz?=
 =?utf-8?B?TFBySG45OXVzaEVCVUdxL3F1ZWxaTmNOeHdzdWNrSmFPb1RkM1FmdGtON0x2?=
 =?utf-8?B?VmZlQjdMUE5BOEVIQ0I5RExPOUZxZDg0R3VHZzMvb1dmejFYRmhrdXg1NkxI?=
 =?utf-8?B?K3ppTXYzd1RoMElCdG1scHRUYmdEZytLR0ZIdG03RGI2U25rK2FzeGNqMHQv?=
 =?utf-8?B?dks5VHlaNTk0N0J1bHk3emxhQTFFNkxZeFFDNHhZS1FiZU83UHhtWnhvdFpl?=
 =?utf-8?B?Z2dpdFEvM2lsWk5nTzNrc3R3OWhHS2ZFK3IrM1NYRzlVSkw1VitmMzRtSTBC?=
 =?utf-8?B?VDFOdU9rNTUwcjZtanpqQU92VlhyZFZHTzBhcEl4K2hCRExmb3JVMG1ZSE04?=
 =?utf-8?B?UXl6ZUdLL2pFYktSZlFXL1FlclFJRXNBbmVnUENVM3gwazRtVThxbk5sNmdX?=
 =?utf-8?B?SDlXc2tsSXM5dWRqaHpKWHlIcUNRbHNUVUgza0xXNm5jSE5QN2tXd1ZYUytx?=
 =?utf-8?B?OTNnRTE1YmY2VnlaTFN6MkY3ZEEwbjNlK0NkTlp0cFVSZFk5bDdwVUY0dytZ?=
 =?utf-8?B?bklsUlpCMGlMM0ZoOStHWDJKcnNuczYvbVpIRnNSV2F1V3hVUEZha0ptLzhS?=
 =?utf-8?B?amFHak8wWVd6VzEzL1hoakhDM1hTM0RWUmJsVHh2cUhJT3pnV255WGdna04x?=
 =?utf-8?B?VEFyS2tYYjMxUk5vQ05lYkpBN2FoMU1oRXIrb3JqZ0JBcEVScWVxNVBWL1Q2?=
 =?utf-8?B?RHhHajhQYlNzUjFhS1NnSHpLelFDTVd2LzZCbFVuV21jam9pUGo2UXFZbGhO?=
 =?utf-8?B?dXVFY0tTTXAwQjBPKzlBTWxENUhFM01FdmNCdE95ZGZJbjN5dFVTYlVDL2x5?=
 =?utf-8?B?c2QxTWVwYjY4cnh1d01PTUFDbjFKNlJLZFF1eEU4d1pudHRDMlhuYllFemRh?=
 =?utf-8?B?SUtEVDBKYmc0bzBhQ2ZnR3owaGMzbHZhWG5VYU9KU3dYeXUySVg2WFI2czZk?=
 =?utf-8?B?dXZtSlRkdzJmcEFDaHVhaHVHcVdJaFNuRllIcXRuYlMyOHRqaWdzK0k3R29D?=
 =?utf-8?B?TWdYNnpEbjh6R0h0T3ZwSEIyQWFOT1UwVitPN3dGOFoycndVdU1vRno4SWRn?=
 =?utf-8?B?TldteU55UHVaeENSVUd4b21UMS9DdXJHNEhhSVV2OWl2TGdXNmlqeE53ZXJ4?=
 =?utf-8?B?c0M1YjdXUVN1MEYyTVltcEZ2ZHpXOC8yd01oZFYzdUR2MDVzZGJpQVo3UDRv?=
 =?utf-8?B?WDVuZDNoR2RqclZrNm84UUl2ODVRbkZQY0M1SE1Fc3hWdWt2cDdETjc1U0lL?=
 =?utf-8?B?SUFuTjlsWjlRa0ZHaW1ZdWdlVFE3M25aWWNOeG5MRTU4Qy9pVVp6MGpKWXlO?=
 =?utf-8?B?N3RNYWNuSkpNOE5COWhQNFFqaEEzTWc1SkRmRm1yV3FEZU9Wa0V4ZGhEQVJW?=
 =?utf-8?B?QVJrZVpETEI0M1ByeWthV29mTTExT1Vlem1BanM0c1dvTlk4TzYxT3BUUnBC?=
 =?utf-8?B?blJhbmFlYUJVRFRvQjlROUhaSlp4OWdCSVcrcTBBbE5pTjFDR1BPaDhaTXVC?=
 =?utf-8?B?WEtla3NLcE94Y1VJWHBYaThsVlJWaHVRbFlqNDZ4NE84L3pJeGRoZE5DV1N6?=
 =?utf-8?B?WEZuaU5iRUlhUDlVcngvRUxnYjFORnZIRi9OVFVXRkE2dDNQRFBTeEp3M1Ar?=
 =?utf-8?B?S1FyMjhpNXM3WUtvNFJkb1NGT1QvTGtjTUtyb2FvelRrU2F5OWNVRlduNC9W?=
 =?utf-8?B?OXdxa2JOTWVyM3EyRitnbzdYTGJwNXQ1TXArcjFabHpmNlo0VnZTQkF4c09u?=
 =?utf-8?B?a1NxQmpiYTNnekxxamhZYm5WNllhYi8ydW9XanVRbXJ2ckt6NnBEcTQwT3ly?=
 =?utf-8?B?YXpZbkdrR3RkUVpiZ0RnRTN2S0d2MnhWZytycmVHRWhPQ0tZRjUzU3lGRGRr?=
 =?utf-8?Q?MDyysEpYRgLlVs0uXXpeU236h+w958=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC8yQlVaeDhETnFyZVhJMU9HVWZkLzcxUTNGdWNMZTRKbndMYjZxYUtOUHkz?=
 =?utf-8?B?dDloQ0tiNVJseEU1NmpxbDJmYjQzK2IyRWhDTkhQV212U2hjOVNKVytRZjE5?=
 =?utf-8?B?dGZIV2M4YjNJUDlBd2Y5T3N0R0RwcnRUcjc3aVdDb0RzenVrc1dZK1d1dUV2?=
 =?utf-8?B?U0FsZU96ZzBOZjBnbXBTRzB5SnBKcHVZdWNudWt4aEI4WktGTkd0cXBDQlAx?=
 =?utf-8?B?RFE4dVBERzBTQ3RWZ2tlL2trZnhaaXA1U29FT0Zqck82VlBZWmgvNDRid3RK?=
 =?utf-8?B?Nk5yRWgyalRHemdieTFXT0NCZVZINlRsdkZqMWE2OEFtbi81M1p1Tmx0K1ND?=
 =?utf-8?B?d05UK3NQNDZJNDE4dFloK2RxREprbDc3R3JGMzRMekYyMmhNTXpJbUlZQXM2?=
 =?utf-8?B?Z1hNdGZsL0VlK0h1T1Z1Yzc2bWJ1SzR3TGxQTEQ0T0liS0JTbzBkQy92OEx2?=
 =?utf-8?B?eXpreENEelFDOUwxZnMxUWJ2dTFNMGFwOFhqQVVrWWwyYjdLZ1FQaERYRHpQ?=
 =?utf-8?B?L3RKL3J5WTlYQVpjY3N0WGhVZjNrZTVTQ01BMm5DdGJvdmgvaFRoYTJFWUJy?=
 =?utf-8?B?aG5SNXdKcjRRSHM1aTNFWDNGWU5zSHdWYmJ6L3EyREkrS3BFN0RJcVI2cTAr?=
 =?utf-8?B?Unlac2hZNUlPdXBZanUxaXd0TGpvYjZabGhGNjBNQVpUTld1MFIyREVkQ0hh?=
 =?utf-8?B?ZnYxbTIxa29XamJpYUl3ckNGdmYyM0hSOCtpbzdOeS9uY29zODB0S0VUVnp2?=
 =?utf-8?B?QnJFTHVWRTZJL01mUHJJbmxwTk0rSldsNDVLb3ZCOXVvYWFNclQxVzBEWks5?=
 =?utf-8?B?ZEpHcnRhV0haTFBlZnp5TmdvNlFDN2t1cTk5eGwwZC9uOFNuOC9tUlhGU2RY?=
 =?utf-8?B?MjBDcTFWek9jQUhpeXhzaUczb0pWaWZ6eGlOaUJFVjdaYWVDTHN3UnZteXMw?=
 =?utf-8?B?M0VLbGR3ZFFvRXluNUZXYXVvd0hzcmNGbjZLZVZXSy9NeXYzb1lNSTlLOUU5?=
 =?utf-8?B?bEM3RUh4Z21aZVJRbmtkMXJ2ZXdaY1dZRldtVGJaVExQWngxdmpPaWVpZGlT?=
 =?utf-8?B?Z1BjY1lwNC9xS2w2VStIejY5c1dzUGZXb2o1dUw3TGQzckltNTdsclpPamww?=
 =?utf-8?B?T2FycUdiSnBGakZRaWNFWXpNcGNCZUdvZ0U2eHhlNVYrN3haRzlLdHk4N0pY?=
 =?utf-8?B?SDlJYzU4Q2lQTUlGQ1FDWkdlV2lsWjJYK1Jhcllqc0dRRjQ0MnMvSVYyT1Zk?=
 =?utf-8?B?V2dJZHFJOEdZVk9JN1dHNHdZTDBoNVEyeGFTU0FHZWQ3MDRLclZxTm1ycmsx?=
 =?utf-8?B?S1dnUlh1UUl4WExFcTRNOHYwVU5JSm5rWTl4U1V2RVVkT3RnSHpZd1doQzN2?=
 =?utf-8?B?b1VDVlFoRWFJa002VHZPOVU2TFZCQXh6M1B1SDlxL1I0S1BvczZKSE9hem12?=
 =?utf-8?B?c3dwVERROTI1ZjhtOWFHSlZNTkYzdm9pUGZ6SWdLcjdMRW0yN1NBLzl1RVF3?=
 =?utf-8?B?RjRNbjhxWEtvK25KM3Z6elFnT1FOTmg2Wis1dmppbVpWdjJSdVFsUmVMK0Ji?=
 =?utf-8?B?SUJzWTdTYm9jcW92NVlWZWpBTXJoS0VLWFVzSXB6cnRleUtNa2N2d3U2NjdG?=
 =?utf-8?B?UjA3TDg2THdadG9hYWlKVUFlN0dsbStRTVUxSk90Q3dTdFY5Y3dISFdUYzE0?=
 =?utf-8?B?V0N4U2FtYWtqTFFMR3d1SmZGVGJDa01oNnpvQ0I5dWhWcHFwRXV2N3M3dE5u?=
 =?utf-8?B?Z0pQS2E5WVV2Y3pwYVFIc2RJSUhaTlVxbjZhNTFtRTVQandCb2tRYmt4ejk2?=
 =?utf-8?B?RHZETkQ2eENEM1RodmdOSXlVM2lkUW5oUms4NjViVldDT3BRUFhYRzUvUjdZ?=
 =?utf-8?B?Nk5mQkNQUllHUCtweE02K2JCcXFNb1ZmY3Z1ellnQlVUS2E5R1BFWG5CYy84?=
 =?utf-8?B?aFNaaE15cXBiaTE0dHdHTmVJU0xIdHZ3ajl6TVNnZGRTT0lWbWVwbit5eUMr?=
 =?utf-8?B?c015RGhCdXkzNlBjN1lseWtqYWlVbTNBWE5sTEg2cU5xS0JwZ0k2dVluNGpI?=
 =?utf-8?B?NHRyTXhyR3NFZUkrblNwZWFsVXdGYkpQK29kUWFKenVybVVtSEtNY2p6OXJI?=
 =?utf-8?Q?g0sb2xNAUOqnfH3j45GdE3iVW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdaf1d9-2cd1-4b4a-7b87-08ddefb1dac4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:02:11.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRuWG5ZF6mDcwOVMwADs9Sq6tk5V7JY6Ze+7pXs5wyM/0Jpx6eFfA3lzG0mJFzTYsArcjb3cgiTY3zChSC26YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7394

On Tue, Sep 09, 2025 at 04:14:48PM +0800, Randolph Lin wrote:
> Hi Bjorn and Frank,
>
> On Mon, Sep 08, 2025 at 05:07:37PM -0500, Bjorn Helgaas wrote:
> > [EXTERNAL MAIL]
> >
> > [+cc Frank, who can probably answer faster than I can]
> >
...
> > > >
> > > > Sorry, we can't do this.  We're removing .cpu_addr_fixup() because
> > > > it's a workaround for defects in the DT description.  See these
> > > > commits, for example:
> > > >
> > > >     befc86a0b354 ("PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()")
> > > >     b9812179f601 ("PCI: imx6: Remove imx_pcie_cpu_addr_fixup()")
> > > >     07ae413e169d ("PCI: intel-gw: Remove intel_pcie_cpu_addr()")
> > >
> > > I’m a bit confused about the following question:
> > > After removing cpu_addr_fixup, should we use pci->parent_bus_offset
> > > to store the offset value, or should pci->parent_bus_offset remain
> > > 0?
> >
> > If you needed qilai_pcie_cpu_addr_fixup(), I would expect your
> > dw_pcie.parent_bus_offset to be non-zero because parent_bus_offset is
> > used instead of ->cpu_addr_fixup().
> >
>
> In this SoC, the dw_pcie.parent_bus_offset should be set to the value of the
> config register base address. Setting the dw_pcie.parent_bus_offset to a
> non-zero value seems to occur only in the path that uses ->cpu_addr_fixup().
>
> The parent_bus_offset is generally used instead of ->cpu_addr_fixup() throughout
> most of the code, but its assignment still seems to rely on ->cpu_addr_fixup()
> when it needs to be set to a non-zero value.
> If no other method exists to set up dw_pcie.parent_bus_offset, can we keep using
> ->cpu_addr_fixup() for the assignment?

Correct your dts file. See below

>
> > > In the commit message:
> > > befc86a0b354 ("PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()")
> > >     We know the parent_bus_offset, either computed from a DT reg
> > >     property (the offset is the CPU physical addr - the
> > >     'config'/'addr_space' address on the parent bus) or from a
> > >     .cpu_addr_fixup() (which may have used a host bridge window
> > >     offset).
> > >
> > > We know that "the offset is the CPU physical addr - the
> > > 'config'/'addr_space' address on the parent bus".
> > >
> > > However, in dw_pcie_host_get_resources(), it passes pp->cfg0_base,
> > > which is parsed from the device tree using "config", as the
> > > cpu_phys_addr parameter to dw_pcie_parent_bus_offset(). It also
> > > passes "config" as the 2nd parameter to dw_pcie_parent_bus_offset().
> > >
> > > In dw_pcie_parent_bus_offset(), the 2nd parameter is used to get the
> > > index from the devicetree "reg-names" field, and the result is used
> > > as the 'config'/'addr_space' address.
> > >
> > > It seems that the same value is being obtained through a different
> > > method, and the return value appears to be 0.  Could I be
> > > misunderstanding something?

I missed prevous discussion. Actually address convert happen at PCIe's parent
bus fabric. If your DTS correct reflect this address convert, you needn't
cpu_addr_fixup() at all.

bus {
	ranges = (0x2000_00000, 0x1000_0000, 0x1000_0000)
	^^^^^

	pcie@xxxx {
		reg = <0x2000_00000, 0x1000>;
		reg-names = <config>;
	}
}

0x2000_0000 is actaully address input to your PCI controller although
CPU use 0x1000_0000.  "bus" fabric convert 0x1000_0000 to 0x2000_0000

So dwc common code already can handle this to auto calucate
parent_bus_offset base on ranges of bus.

Frank

> >
>
> Sincerely,
> Randolph

