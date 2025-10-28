Return-Path: <linux-pci+bounces-39504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B228DC13933
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 09:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643B11AA04EA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F72D6E72;
	Tue, 28 Oct 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="lAh9t5vZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023096.outbound.protection.outlook.com [52.101.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768727AC4D;
	Tue, 28 Oct 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761640905; cv=fail; b=d/EEtZnyX3KNnMSCBRC1g4cPu0fuKXH6u5OpwRyaO7nGY3zCrgVPh1mQ0koNO31kz39+tK7S9drCWjqtuBtYmX9815tS1pHnoGuRI6F436XaNnu1tcGHZdlzNJAN+l/1zcNoSSnJrzzj1fYkKmxjd8k+F9oU6vdOr/0zI+sDVQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761640905; c=relaxed/simple;
	bh=iSp6QRrqRlVKZyh6PwKddC8WwDrhRhF4BhXP7AwRzIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ljlu8CsjfVF6VWzxg8F3esNgATadW9d863dHbTIb5fE6asPW5yuAhKsMax2LJ1SbhksjcRW+kfxFTfEXGMb7wK9yUOqGFp1TLlSdc+AmUHx9nsl0gZfmyYo3Xr8dpi9erEZE+2ZRvoGWdAWoLPYEwRAmBjA0zLPWA0dp8NutVmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=lAh9t5vZ; arc=fail smtp.client-ip=52.101.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piFjuaRAJvOSPnkAxWMY8REXl5rVoD5vEATlz2fQiH1wynvYeqnS3YCQXg+SaIXaNTNQt/xI5MrJ9lu7Y7szMCxRLFxnIRgEreptkT/DsrECzLMQTiEL7UVTUAj1/J97hwCb+GcNw7bX9AqZ0uPrgF+XL9DPeDCKSiCKCA8NGttvCdu99azjVOWzw3hYa0XTu2riuH2HkFruAL5WMm0b5y8wzty/kVREYpKywTcjviwXFdl8Vw7Qn9zS8Cgn2K+yL48JC2DvckpukL7l9iuVoUSx7DxzQtqJ7R8RcXwbeQnM4wCH+3tthzfugnOEJLIB/E/MhtoSsZ9x5Jp031Xatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSp6QRrqRlVKZyh6PwKddC8WwDrhRhF4BhXP7AwRzIs=;
 b=pqs70SnZ6xQdEsVcVwOK0QmLa9S4Vn2kJ4S2eq0wsKlUUHO1lCf9Bgo8pXMZd0IDxpOALcSUODqNjsTRGe1y0ZAvyMuVs9GaMngrie5fUA8CsASIIYISuZHO4QOoq12a2fqcCdRfg72bltXRMPaYravPMSPGTkOmC7lSCn60R4FEOiVqK7O7PU17k/pYsxsmHenTBViJDZc/mdufubUVjUEPIK+xYPnpmc2y+T4ubm5lpjICkIVzxV2BmOEYLmOlrFKQiH4LHhbNcponXOV/Yqh2ZgLa5/rUxmPdmD4qZt46S0ZoO7kdnFxEzViKlwCkhBMQfbbsFqdKFsz8hT2asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSp6QRrqRlVKZyh6PwKddC8WwDrhRhF4BhXP7AwRzIs=;
 b=lAh9t5vZJMn+NNU3x/Cbheyv9FP0gZJVwXeyMlCAgmcgX2NKJUNaarRif0W3gCZ43fvRDArRO/sSnQQAIqGKWd2l1CCN0vU5VorM4Q5mKPKAgeJ7eaBouMEJge5O3Jpzlye23ywG3EsjM2LmP4RxFHHWV7f8j75jlaMuskz31Py71g3YNhKcPkjJHLXTtMFht51SkevfsVrSHURILFNAn9b96X/9Ok8QUxdKFctLm83Xy/qxyYXRpxUw6toXOimtEU/FZsOjs1AENSA+pK6Cq2OPSdxp81YCA81MEoH9Q9mXl1QdOjKQ0LTMtFyYQzHelcVymedKu4kU67sH+KtBKA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 08:41:39 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 08:41:39 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: [PATCH v4 4/9] ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST#
Thread-Topic: [PATCH v4 4/9] ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST#
Thread-Index: AQHcRyhBkwdEhUYe506wXhLgpJneR7TXMXOAgAAM4lA=
Date: Tue, 28 Oct 2025 08:41:39 +0000
Message-ID:
 <SEYPR06MB5134DA0859EEACE4B308CD159DFDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
 <20251027095825.181161-5-jacky_chou@aspeedtech.com>
 <20251028-witty-nickel-pig-5bd4bc@kuoka>
In-Reply-To: <20251028-witty-nickel-pig-5bd4bc@kuoka>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6959:EE_
x-ms-office365-filtering-correlation-id: 2e04c4cf-ad17-4dfb-7b9f-08de15fdd03c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mjl4aUJPcllTQkYxdERrTXo4V3NoWld0M2hmYmVoa0c1UnhGaStjVFozZTdG?=
 =?utf-8?B?aFZQaG5YYWRYd2J1R0dPMk1PZWp3MGVhbUpVNktSRzRnM0RXNHU4SU5ISStP?=
 =?utf-8?B?VTMvNWJVREtPcFc4VDVpY3JnOWJJNTd0MUJENkUwMHFMaXcvN1BvUTFPeHI3?=
 =?utf-8?B?NzJ5VDNmU1ZxMENoekxMRThkdWhuLy9DSllLT0dEb0ZrNWg4ZTNRU1Y1ZVEw?=
 =?utf-8?B?R3gvbVFxVm1YSDcwVUlPK2pUNDk5KytSUGk4QXhPYm5iMDhvOE1lbUFuZG9K?=
 =?utf-8?B?Yi95aWN2VENmVU9vQmYxRWpBajZ2VjRWaHR1QnUrQWRuQkhxUFdCbllZRHJD?=
 =?utf-8?B?aThnLzFUVGlMWkdwVUttcHZmbHRHai9MUUthVkZtajFWYm44QTZDZEFhMG93?=
 =?utf-8?B?MFEwemNXL3BHL3cwTmlKN3BNV2JYeEk2eVZvV0t4RTFzTHRWZmErdHVsb21G?=
 =?utf-8?B?ZDZjNTdhV3JVZUpFL2thSUxUM1RLY0VtakpYYnljelVXdEpwdGcvYmtMZ3Nt?=
 =?utf-8?B?dzZweWJVSy9vVnV3UW9MK2FzcUJlMUJBVVBtQ1VXbE9nNUtWZmVJZllrZGhR?=
 =?utf-8?B?TzQ5M3V2U3VNOTBWaHVKakRHVXphU3ZvVFhaRXFSYXg4bm5xWVJBRmdPRjVX?=
 =?utf-8?B?WkNneFVLRkp5Zi85bkVPVFBDa2xxdVdkK0RDRUlZK3RRR0JZejFqRUFmTkdM?=
 =?utf-8?B?bHRQQUF4QU5HeVRrZkhTQ0o0VkVmemc0bkpDUXN6czgrT1dNRHFjQ3hXRmlJ?=
 =?utf-8?B?TnorYWhqWXE5TThNNjVNVmxoeFVjRXN3Q3FyVUNvK3pHV3l2YlloNDRCUjhk?=
 =?utf-8?B?Q1BJZ3dNd0xlelQvMjZBWTJYV2dSQldMYnFRYytDSWJZNFQwN2dtT3ZJYnNK?=
 =?utf-8?B?SUN5dUtnbjZMRElpaytRaEJSTTk2Nnl2TkQvd1I0emdPWFI4TWNXQzFXNCs2?=
 =?utf-8?B?ZHZVb04zT0ZPRk5HTUVYUy9GUm8vcEQ2WDFnRG5JOWx5OUgrR2tFSFByeVF5?=
 =?utf-8?B?RFNRcCtHT2llM1JLblZYUTFpVWNaOGZVSHZHQ1d3VUJJWlBJWlVBZ0I4M1JT?=
 =?utf-8?B?TW1ka21xYUgzQ0lDYzROS1dUbjI1SldOcTRwcTZQQ3JCYVFtbHljMDhyQXpI?=
 =?utf-8?B?c3ozenFaZytHY01kMUg5cUFhRXlTZDl6ZnZhb2tCRHhlVFc4N3NIWlc1a2o1?=
 =?utf-8?B?TU0vZGdyVHZ0UHBmNk4xMGs2OExmKzBzSnE1bEpyOHk3UzhNa0IzaGxrcVc4?=
 =?utf-8?B?Slc0QzBvc2pBc1NhRW55RXc1cWtRWU02MmN1cGN3WHRNaWhBc25VZUtaVkN6?=
 =?utf-8?B?WEJzbFp4b2pGUHVYbEpsYnoxeFVDVVVXMlBsRHFFa1pCeVNpRTVDMDBZQkwr?=
 =?utf-8?B?azVyTk1NQTlKZzJWRktoQ1g0S3dyYUZsajErYnJTdElkdW02M1BNWDUvVk41?=
 =?utf-8?B?NVB1MzNTT3FhbFh0Qm9EcWZGWTRRVS85anJ1YUI1RVh2VkxVZDNYU256K1Qv?=
 =?utf-8?B?OC92akZ0Mi9rQmtJbFl6M2YyVDIvdUI0U0d5S3cvSTNIWnhPbjZnWmtmT0dI?=
 =?utf-8?B?REN5WTBEUlBHaXRMakpPdGRQbnpWS0pTb2RzZ2FiRjlCS3hqTjQwNEw5QzNl?=
 =?utf-8?B?L1NxVERCUHFTd003b2xoYnJYMDdCcmNueXB1VUxlcktrT2wwbjYwVjJrK0lq?=
 =?utf-8?B?V1E1ZFZ1QlBkR1pZaGppMUdEV29QM3lDc1JkOGdYWWVmVWc5WVprcTZiWmhI?=
 =?utf-8?B?Y3BoWjRaOStISDRESVFUNVZvdUc0Mk9zS2VLMStwVFFvb0JxT2NOaVRRWFlI?=
 =?utf-8?B?ZWNBT0tmSzlzV2VNd2xDNmFjWjFPMzNWdGhDckE1YXR1RWZPbmxmN3VTM29X?=
 =?utf-8?B?c21hT1JSVFZxak12MkZielE2YTJINGZwVmdPSkczcCtldEFpNmVOV3JyWDRS?=
 =?utf-8?B?bllJNEo0Y2RIV0ZHaEdoYm84d0tudkF1REJUQlNPS0x5QVRHVUFoOXVzKzdP?=
 =?utf-8?B?QlllVThYUjBSNDQ1cHNmeVp4aTE0MDN2aXl0bW84VFcvK2thd0VKTGx3c05Q?=
 =?utf-8?Q?wq2pQU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGF3SUlyQ2ZYVzI3MDdiRjRpVThSZHhzYm56R2lWSjc1VUdIMldVTUh3SnV2?=
 =?utf-8?B?Mnk5TUoxUmFCU2FnbnJPcDBBa2NkdFZZYmZUcmxaaVhEZVUvWEQ0YmxoOHg2?=
 =?utf-8?B?NmUwUi9sMGVIYzdJSHVPTU5sRzdRendGQml1VGNET3JweXNjQzhxdHNTaHN2?=
 =?utf-8?B?eGRKNjBsNlVnVFVBeWlHbjdjaXhMYkFvSGpKUXhTYldVaTI1V1pzampoM1R5?=
 =?utf-8?B?cUFWYXE5emx1NFFpSFFKOEF4QzRhRi92Rm9oeDhjOVZzdDdCMmJpWUNDWXVE?=
 =?utf-8?B?bE0zZHp3ZmV2bDhZV3B2R2hibWgzNEEvbDhKa000VGVuWmJLSEcrbEhveDZU?=
 =?utf-8?B?WHVIeTdmKzRYcTJhT2padDdsSXVKSlZrQllkNnJvMUduN01xR0VLNFVWUHlV?=
 =?utf-8?B?UFppL1gvWFB0RmFsNnVQSlk4TFFKSEUwaURiTTRaSEplT3hab1oxRGNxbG9K?=
 =?utf-8?B?ZzduU0ZLVUFBUHJxWmkvM294K3dGa1dOZDFNZ3Rxa3dXMVR3RnNyYnFtM0hD?=
 =?utf-8?B?SkRlZEdvc0J6M0NZRTlJOTdFWXcvV2dqV3YxUW0wTW5CeU5YaUZ1OEprOXR6?=
 =?utf-8?B?eWlsdFlMaThpK1d2SXZWZWZyOVdtNnpiQ0JueGxQUEhSQXBYdE1aaUZVa3FQ?=
 =?utf-8?B?U25xY3p4bVhSbVpvckdQWVBpdU9mWUZiUmVDN1VVWDBwOWdOYjRJUkdBcXh3?=
 =?utf-8?B?VmozUnlNMlg0WEtjbFRSejYzUEpTUFVMSHVqQVdmNEpqNWdsUEdSbWo2RVg2?=
 =?utf-8?B?RkgyVEl4WnpmQ1dKZCs1SEsvRExGVkxXOXVKU2ZpUDFJd3I3emZYSzVkUk0y?=
 =?utf-8?B?L2hSVTFnQ0doQlpSaVRTak10ckFPWUhBOTF3UHF3eWRNMVZ1d2ZmZGIycXlq?=
 =?utf-8?B?WXRydW5RejE0TVplcWJzQzRwUUdQZUFqemxwbU5YcEhWUUd5eTEzU2lKWTJ2?=
 =?utf-8?B?aG5qQXJhZzVmNnUzRStDeldJS1h3UWd1aDl1YTY3L0NFODI3K09iTHhpQ0cx?=
 =?utf-8?B?R3g5enM3MURBNXZoWnA4d21CNHdweHdEdFpyVXAwSXNIb2d5MGN6S0J3UGZk?=
 =?utf-8?B?NTBtM3puYWVOQzQ5N3BldkxJK1pTZitOMUNjdzh0eVB5VzhVZTloeWwwZlZr?=
 =?utf-8?B?YVdQZjUvekFpVTluYWF1QVlaaUozQjJ6UGxDU0VIY3hWbUxuZSs3RWFQdlly?=
 =?utf-8?B?VndTVzVZejRUZW1FbElOa1hxanFPcmJjZ0dLZVRLZDZ0VGVsK0o1UlVDQmIw?=
 =?utf-8?B?Z0V1MkJSb2pXNW5XUG02U3Q3aERnMVh3b1hLbjNZWmg3THdoRDc1c3BsdXZl?=
 =?utf-8?B?UWtVS1dPSktlL3hrTm9VZ2J6N2xYTkVjYUJSRktZSTZjVlROM3VnNWRsazVK?=
 =?utf-8?B?YVF2bERGdUtlR1JOMmpFYTV2bERab1BYeldRV1Y4STVtV3g1Zm95UHJjaXRj?=
 =?utf-8?B?akE1SUtBVnlrbDZuelB2V1oxNEFGUjlybjBLaGp6QVIwY3RldmJjaUpCVXBP?=
 =?utf-8?B?cUNUdXVWYW1rUEthMXlDZlo5Sjc0SlJXUTdXOWdMUjZwUExuNkJ6TGVqOFJU?=
 =?utf-8?B?a1ZDMGVIUENqQXpyVU8vYnhjeCtnTjJsTTdVZjl2UkR4SnhsaHUzMTArYXdl?=
 =?utf-8?B?ZzIvN3JKM1A3cGdDaEhBSjB3UU4xUFY1SjZ6LzVlY2dwVU5pdmt3dWV0UVNQ?=
 =?utf-8?B?SFBoNGwyVmN5N0k1YVVwbEpBT1R1Z051cjZGdzBpam9Sc1lpTXBGS3R4ZEtw?=
 =?utf-8?B?clMyN25TZ0NlbDdFZlJXbUlSVkhwSmhvb2FPcnVEc2F4aFdPMHVWb1NFZldD?=
 =?utf-8?B?RWVva1orWm5RMXBLMEwyUENqNy9oVTZFZ1VxYStIdFBvVy9Ec2dYRzFYcWNw?=
 =?utf-8?B?QjBQVVlaSHBhMFRuV1J2QXdzdDg4c2xYLzdHOHpMNmROZzNTTGVaaitPZkpr?=
 =?utf-8?B?Tm85MXRXSUhMYUZkVm9rVG1TckJGY3lMUXk4YWh4SEUxWitRN2xMdWMxZDJQ?=
 =?utf-8?B?MzZNc25aL1c0QUM5MzIzVlJJcHgrb2lGelhDSXZaUXFDOTZpUVdDUnZKOVJi?=
 =?utf-8?B?SUQ4ZEFWUmNjQjRkU1VUdGhwRUFiR2JUWWVxcTFaN0NrNGNPTFd5Uk83Qmxo?=
 =?utf-8?Q?EVFPcQ+GBViW/p0R7i9dhOO8L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e04c4cf-ad17-4dfb-7b9f-08de15fdd03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 08:41:39.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTje9earqnBuB0eEbzDU5BNA0eGoMURxa1KHumwhHe8JV595rfCGARz64fwxiCegYp5QdYWEz1GdgX/WXfkwhWHpUEsbMfYnCoTIgBD+z50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6959

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCj4gT24gTW9uLCBPY3Qg
MjcsIDIwMjUgYXQgMDU6NTg6MjBQTSArMDgwMCwgSmFja3kgQ2hvdSB3cm90ZToNCj4gPiBBZGQg
cGluY3RybCBzdXBwb3J0IGZvciBQQ0llIFJDIFBFUlNUIy4NCj4gDQo+IFRoaXMgaXMgcGFydCBv
ZiBQQ0kgY29tbWl0LiBNYWtlcyBubyBzZW5zZSBvbiBpdHMgb3duLg0KPiANCg0KQWdyZWVkLg0K
SSBtZXJnZSB0aGlzIHBhdGNoIGludG8gDQoiQVJNOiBkdHM6IGFzcGVlZC1nNjogQWRkIFBDSWUg
UkMgYW5kIFBDSWUgUEhZIG5vZGUiIHBhdGNoIGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0K
SmFja3kNCg0K

