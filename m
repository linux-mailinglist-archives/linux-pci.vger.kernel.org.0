Return-Path: <linux-pci+bounces-28576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A91AC7A30
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6BD17FAEF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F120DD48;
	Thu, 29 May 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ByFVqo2g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HYjGqll0"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A811EB2F
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748506983; cv=fail; b=L0yh3gnRRFPUo45yAMsKlo0XLxq6ECSCPSbhJL8GEa+p8VA5FKQPpC6ivvjHP9bKjmB57nKhxE3kyKZ7MK7am6sawjICDfCSOyGUSYS3Dj4Qiwmz7O144JbOTwP3Yio8ycQOkRYuTdppahHE1IKTIHZ/TEeSDWdSjizoHZ2TjAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748506983; c=relaxed/simple;
	bh=onNETKz/BzJbesZCxYIb1KaRd4VQX9/bkq42qrRZ+1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KSqsGbBtroB6y6dfxqhZGruIHVESP0iuS5uqkZZ0OmEir5aE+kN5DSEIGaYWv4TD1r+OjWtxNH+SDAP7IBtLjgEWWWYLE1MkjtNB0NaeeYiLjd//fBPhd2sSpgPkQEd2D+XT4Nw/1DmOv2+0IKYaJ7XVAWe5F4O9Sk0xyQlLD7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ByFVqo2g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HYjGqll0; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748506982; x=1780042982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=onNETKz/BzJbesZCxYIb1KaRd4VQX9/bkq42qrRZ+1U=;
  b=ByFVqo2glP3kUpv14ffG9ifyggupQsePvY8Xr7xVhchafaCJmeth+YxH
   dvERqT7zna9BUqQistZSoCun+zpGPLFVEBRv5OU6BSbH6iRFNI5E2jtzo
   kSaGhJyAJ8/HsrD6SMnilljlp9/ZJxElFNI8zZvyKm7EuF4qvAwKQdg9E
   QNa76CDsKn/pms7ZYRvlPyHS4MdX7+VGD4jlUlQwevInZUpZaQtRQ88DK
   vFf+iMQrQA6XTXOKDjHua1YdU75DLMw/2Fcyw+b6C6x1vF+H1bE1y+2u/
   dj9oJaKYCo2w2JdjT25PU5t2NWrt+Hp94oaUNNOcZPoJoJpq9ReVO0UVL
   A==;
X-CSE-ConnectionGUID: QCZjyp/8RECRZU/xhItfhw==
X-CSE-MsgGUID: gFN2nn1rSc+MPgM3nbLssA==
X-IronPort-AV: E=Sophos;i="6.15,323,1739808000"; 
   d="scan'208";a="88557685"
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.73])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2025 16:22:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6n5CqXEpUUfgp/FPcyyB/AiJ0vvg6PVxsPPGocQ/CbKfZkD6UbYG+Yuw+Dr9Kftr/grnKT9eUzYC3SF6ETDbGEZUoqWyQjqFz1KWBfyRChJRC9Mg4OkjnW1EikCv2Ld0RraNzxbZc0pGmuQgUkHjG+jaCEJxkBRD2RVyhMCmaWRocHJU03KM8vc8Dk+wlYpaEpQV90Oh6wgyFdoC3eVUItIQjgqt+Hh0f/frWuRiTGUOVRMrMZa6CK2tPaDhzM7eKOPtNiY1dvcRxGwnJ6P/LFkaSrd/QchnxXZ41vSVK58tJrCQftiJeWhGlfbvqyuLu9W9uiQxOeC/62hUkb1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onNETKz/BzJbesZCxYIb1KaRd4VQX9/bkq42qrRZ+1U=;
 b=GrVmhU+QnmzpYNgssHjP0b2g3fkmTgrZFRGZGIjhLroaQbyamTILOwQujMkUv6Naefo+j1qAC2rbKEJseyYbbs39agQ89lgyjWsX8mImUSQsIT9TOfhnD2WxpsZvva1Ky9MKA86hY/0D8iUCYMxkzH/wsAt7l+QjIHQSovH3K2+roPZTUCxEkDMsxiwz7AQtg6jqSfFXWd3wDLs+UUnuapshSVzaH1i8McUby+6ttqTCWG9Nz5VHyonSCsuMjGA+69AMvIj6re5BLvFvB25BUK4tQPan3cY3P+R4P+Lw/QuDS09egAEI6DaADTZSJWxc2YJgx70S5PR64bahQrtBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onNETKz/BzJbesZCxYIb1KaRd4VQX9/bkq42qrRZ+1U=;
 b=HYjGqll0sHBDgci5XtPYJgmOsKDvmDSXWBBBOce0hABEs4jvxbH9gi+RnjpLJbPNVRmO6pcnIQDly8RjnqCJUjD0yuTqiSQv3fTLY6CTy9uKRxjz1rdKTgLPws1QmSv5Eg9CMAdzaNVpZ25Hj/CFp7TifNXhijtyRJfH1bGKCH4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA6PR04MB9637.namprd04.prod.outlook.com (2603:10b6:806:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 08:22:52 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 08:22:52 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "cassel@kernel.org" <cassel@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Delay link training after hot reset in
 EP mode
Thread-Topic: [PATCH] PCI: dw-rockchip: Delay link training after hot reset in
 EP mode
Thread-Index: AQHbyxaqha+l71FMZkyFVMP1KnQns7PpT4+A
Date: Thu, 29 May 2025 08:22:51 +0000
Message-ID: <93692bd09d8515da1506fe89b82caf91ea1012f2.camel@wdc.com>
References: <20250522123958.1518205-2-cassel@kernel.org>
In-Reply-To: <20250522123958.1518205-2-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA6PR04MB9637:EE_
x-ms-office365-filtering-correlation-id: 88c68655-8bf7-4dfe-6955-08dd9e8a0160
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXNlcjV6dVdyTWtjV3lPMFNHb0hYVW4wbXlXYVZjNUF2ZW1YUmVINVFYcEgx?=
 =?utf-8?B?M3V2UXJsSXNaeDQ1Mk1jN01oeU53OTRPNDJzSDhOeGdHSExKMmQ3ZFJuRUxI?=
 =?utf-8?B?R1VDY2V5QUlIcEpyd2lmU1RLK3NobXVOYmxyNjI5eEdsdDd5SjJlVEFudDAz?=
 =?utf-8?B?MTRXSUNjYTFjMWp6cWN1cWttWGFsemU5MHlXK2w3bEVEaDJxMkc0Y2t1UnJX?=
 =?utf-8?B?M1BLNFJUMU9FNmk0eEp5Z25WU2NSU2NrTmhMUGswTmR2cDFmSisvRjRTb2JK?=
 =?utf-8?B?VXlZcnZqcGxXQ3J4blBOMGRyOXJqNU90QVh3cHpPOG1QYUR5cGF5UTNtc1VW?=
 =?utf-8?B?d1lHTk1scFo2TTZLSERWYkY3Sm1sa0FVQkFnbnJTay81QVJnOWJQM3Q2L1Fx?=
 =?utf-8?B?a2l2WWMrMmJicFR6TVBnNUJLZnBIUkg4RFRwZGRjZE8xTnpLaENjK0NzSDUw?=
 =?utf-8?B?WTZlVHRMQ0E3RGdlL3VGZ0g1QkJLcks2U1lSaWpFVFhGNWJYU24zdWxyRExl?=
 =?utf-8?B?NHlCSUVMTVdWSG1KeitnRm4xRzRuMEhjb3pVbGx2b1VJOFo3UHloWlNxK1dB?=
 =?utf-8?B?cGg4d09qTnhZZXZlZTd2RGhIYUNPUmhrbEY0S3llYXBVVjZyOXpxM0VIMWcy?=
 =?utf-8?B?c2V6ZUV2R2V5am1VZ3d4SmJubWhFWTNpLzhsYzRjQUFyOG5JSlM5V1pSZ2k0?=
 =?utf-8?B?Qmw3RDg1SkkzbFNWL3drUHhnMzJwbmh4M08xTUgxNWM4bzVZQ0I2V3ZsWGZ4?=
 =?utf-8?B?ZUY1WDg2ZUE4dEZLVkorYWNkMUw4MW96VlgwS1JBOUQ5K0tCRlhmTnkwN3hs?=
 =?utf-8?B?SW9uSkVTTDlDOHdIYTY2enNrNTVMNllFS1lzSmVoUXVyaG4vclFVdWR6OWk0?=
 =?utf-8?B?SVF6QlF3eHdTMG1DNjkzM01OWE5LOEJSNHVJUDJuZmZiNWRBV29CZW1adDE5?=
 =?utf-8?B?RFVqalRNY05YZDJmT00rK2lOY3Ftc09VNnF4eW5TZzI3Z204VzRUSElUeXNj?=
 =?utf-8?B?K0g3QTBoYzEyMEJCT1FDbmNJano5ZzRLMXJDVktGQmRtc2dhenZ5MVczUzN6?=
 =?utf-8?B?aGhmUkxOTngyYWZKc2lMKzZsSVQ2WXJYTzZvRys2Um9VZFpMT3N3aVI1UXhX?=
 =?utf-8?B?QUxtdTcvQ2dDNVZ3LzZYN2VFd0dBTUV0bERVSnpSVmt0K0VIK0tjNFg1OWUv?=
 =?utf-8?B?bjJ5Q2F6S0JmWEFaaS91NHJTRXUxNlpMV0JaLzNIZ3E4MW1nRDFUZ29ESVl3?=
 =?utf-8?B?NXB5dWhqT21rQ25XdjhSVnBCZS9hVTBVdU9ON0NNUnpDeG4wRnFXMjlaN0Zt?=
 =?utf-8?B?VkVVZUlTa2VGQmUzRXFodSs2OFNTbnUxSG1EQWI5QnVIaFNHM3BHaXRPTFU3?=
 =?utf-8?B?R2FQTUdOZGFyUmhWdGI1aXh0VldHV1FZKy8rN2daLzFpeXFBQWxDSkJmS2Qy?=
 =?utf-8?B?blNPTlJGVDFJeFduZnhxb2IyblJrRzJMODhncGJzQ3FtMit6ZXJoakhIQ0Nr?=
 =?utf-8?B?SGc3Zzl2L1pJcUZEdHdyanhXYXRBbExpZ3Fuang4YmtBcG9GbHlBUC9mNVVS?=
 =?utf-8?B?L3pyeGhyNlVzcGM5eFdmZFBTOTlKL3NFaDZMem5zc1JFNllhZGZNcWVUaU1m?=
 =?utf-8?B?UXVNY09JZGJSQUpYT24zSWV3cm1ZcDZnN1p5aWU5Q3ljb29RRzRPampsUnJl?=
 =?utf-8?B?Wnh6bXVuaENQenhuMERtclFvdzJUYkhweDBTaUhLQWRQT2dCSk5qWXVYUG5h?=
 =?utf-8?B?RlhtbllaTUFUT1ZiTmZrNUN4ZFZ3b3JSSlU4YlNpY0oyNXpNMnp6RmtDd0V4?=
 =?utf-8?B?ekJxcmR3Z0I5bHBlRUY3SVBSZmI5cVMzZnpmMHJBWTVidERuRHNab1FuK2dK?=
 =?utf-8?B?UXBUa1Fwek4wbDNhTGlOaFA3eWFnSHRKRWIrV3BCa01qQkFNTXBYeFBXdG9L?=
 =?utf-8?B?czNpSHpONXJOVHZBNFNxL014bU4vQUZabXZuN1VUQnZPZjYxSEozeUFlSWRS?=
 =?utf-8?Q?/igd/gNaSAGXJrUzYibkUoywearD2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFRGbjUvRHY0SjZ5amQ5MVBUclAvVVJoMHJPbHpKMDJENW5waTl6TXF0c1Zi?=
 =?utf-8?B?OEhWQmk4Y3NBMmY2UXBobnBKRTM3Ty9PRlZ5b3VGS0d6emRhRFM4OEwzaEt5?=
 =?utf-8?B?SWwrNUJuSW91clJPUlcra3B5S3ErWEM4S05SUUVZRWQ3bTltWTFweXJiMUNM?=
 =?utf-8?B?bWFjTmh2Kzd1YlJralVFSm1HbzgrdjhMQWZNd0FXV2Q0MG5ZMC92Qkw3S01R?=
 =?utf-8?B?MFNPbTZuVkJZNXR3NnZyNWgxRlUwakd6RWV2WFhySW96RDRNQ2xjZDZ4NmQr?=
 =?utf-8?B?b1pKV293aDZoOGhGN2duT2pPZE9SUGltZ1ZmZmdFbEd6ZCtFK2pvbEp4WjlV?=
 =?utf-8?B?aXZTSnVmRU04NkFJZmluK2oxdHpSVTN1emNhcFBDYXpkUmRSQzVLUzN6dEY1?=
 =?utf-8?B?UFNJYlB0VDVoTURMWGNaZ09ERWZPdUJrUTdXcUlEbVR1S0JKWG1sbFh6SklP?=
 =?utf-8?B?QlFPcFhoN2YxL09ieWh5NFp5ZE5wOTlMTThERWVxVVlNQm9GR0U1S1B5eEoz?=
 =?utf-8?B?MEdsV2JFTzlYMmtFUGw0M1d0YTQzZjFueXRVVzJScWtMblJKVFFkYmRKRng0?=
 =?utf-8?B?b1RUSUh3c0VId3NpaGd5RW5DU2F5K1FxVER2bnJIeGdZakFPY1dqMnNpWjBm?=
 =?utf-8?B?R0VXK2oxWjFuQndFU2JCdjg5eHhUSnBSQ25vUCtBT2RXOUpGZzNkcHlJbWty?=
 =?utf-8?B?amFtek9xb0YxV1hIT0t6MzlYbG4rU0x4dDNIMjBjZUd2ZVFBWkU5OGdqT0xU?=
 =?utf-8?B?UjhLK2kwUWFHUzV6enRhVUZvbitqU08zNHNraWMyZDlibHJ6RE40QmtBMjdw?=
 =?utf-8?B?OUNhRy93cEpsVEJDL0xjZFJxeFpiT295QW10RVZDa3pUVEpyT3NBdE85V3lV?=
 =?utf-8?B?cFJRMXc0Z0phbHAzakZqWFpDb1BEMGkrc1k2a2h6aXF0TzlCQjlUbjIvWjUy?=
 =?utf-8?B?N0gwMEExLzI2eHpRUVdROXZyNWUwWlFISW1wUFNUeUxLcFp5T1FFdWd2V0tR?=
 =?utf-8?B?TFZHcDduS2FvcVU1cHIxUUFITmVhYU1oNEF0V0xrMGNsQ0h2YUNCem9RMmdo?=
 =?utf-8?B?ZS9yakVLRGhRMHJIWnFucUI0UTRMVytWY1JyREFaakFZS2RmZTViZUV3RHpv?=
 =?utf-8?B?VEM5R2x1VzZvWEhlcjBvTXJKZlBEZU1UbjF5bEMrc2lhbTRNQWFZOVdVa256?=
 =?utf-8?B?RURDdjZKVjFoN24xcHJmQnpUR2ZlNHNqbGRCMmw1MW9FYjl6VzN6VkVwQkIz?=
 =?utf-8?B?aWk5RTdUanZTb1RUVm5LZENXZ21icVQwYkdKYWxicWMyWHhOQWxJZkp5Ym9P?=
 =?utf-8?B?QnYreXlrVEE4eStSWDlSMyswdWx5d01ZTU91Yk4wZVNJaVNIZU5sRXJXRU1w?=
 =?utf-8?B?dEJSK0lCRkJSaDhGLzlRQlZWejZocDRObFRCTWRLVi9CLzUwazNwM3cxUytX?=
 =?utf-8?B?RCtYQzJxNmYxVHlFK0o1dUs0dzZuQ2UzV0VhOVRRR3lyNkVIeGRQUlM3cTJS?=
 =?utf-8?B?LzJLMWh3WjBOZnM5UjlZd1lIMG04ZGZnc0k5clZKZVJ6RGw3MEx5eDRKM2Rk?=
 =?utf-8?B?N3Uzdy9kc1VwRTUyTkJCMTdyaDF5QmZDVGxBK1BHME5aQVhIZ1VPNG1BZ1NZ?=
 =?utf-8?B?REthUG5sczVFSjE4RWROWVhNSFFwTm9qMS90UFpKckQ1Ujd5OUNVR1FVV0tB?=
 =?utf-8?B?N2xabVhsbUJ2cUNzVHBCb3ROVU42ZHFLa05YbUUzemZoTGwzcGtvOUd1UWZa?=
 =?utf-8?B?azgxaDlSQkg1b1dWTU85UkNrVTZZQm1FV3BQT2dsY3R3UVQyUFZUbXFZNTZF?=
 =?utf-8?B?YWd3c1puUkNxYTROR25BdTgyUkVuWHE5aGxqcUNVRm5JRXNZTGVkemdDNFNI?=
 =?utf-8?B?aCtYVlZzenlncFhUTE84MThaWkoxeWhVeldQY0hJU1NDUEZ6MzlOS0RsR2ZG?=
 =?utf-8?B?ckhlK3BMdzQ4UUR2eTJhKysrVEdJU2xrQkxadzZJU0RQRjg2U0g5SVFTVnBm?=
 =?utf-8?B?TzlzZFk3YWNiZFdzME5iWm16ZGh3R243VzJza05yNHZnSmd4blFZQXJMM0FE?=
 =?utf-8?B?eXBBaUxuZm9SVkNWWW9pWGZpU0lMMnZzY2F1blBuQ1E1ZEJtbDRoMFZxQzhu?=
 =?utf-8?B?ZVR5Qi9aTERuSUhmZHBFQVI5VllWZm9RNCt0Ym1OR1hQLzErdVI0Q0ZFODYw?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5954701FBD830843B844C371989D7FD4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y3M68lFpS67WuMScNZLkbEHY0mdfvITbtPB4kYeDPF7Q1rRyaf05yN2s+pV1gjiz4YrH8UEPWFo+Thv+yKSzxRqq8m3ELXnlw4x+c9S9y3enedOySOXwT8FnzzaB+VgYKYJZWwl9LVh5XjstYHWUg/qZXeeruv8mBS8nlxf9MfDVZfkX4p5vHQ6BBNYKWB2J0TCqQ1JlDrFGI9fXG6536Jr9G5csWDvPAhZiuIeX1IKU2dWgVBHrJYs6g+8NcUR+aKFMGeYHDV+WjFbk2AQzJb9XqvpcsK0tAj5YEpY/blBE6fK3jWYqSr6qroHeK0DTtdzeC9vraGluK6HLl+Q0udQaurV0cR+rx6FPo8tlUZSIrRvamWVbwlY/RaG8pIjKUfaypR8LWEutEJib3MBAtl5DV36NiHhf62dvVyRt9VTh4VHjQ7qMxVHHTnoBAKFGGUW1xvX40+FHtqHlOAb7NEtdOQpmvNmeHUuHJKOzWQT4yzYrANdzYxoQjRp3lhfRwqJ+Afuu+iDjcNbqzQA93gNDfZw9yhXnmk+nM6+oFfnDYn45lJrUxDQUkUH86tVMkBIuJnuogdqVoftxHOG7DKOnyhXCu7mk7b4BHkH+i8BiwDpQKFLw6GEIbn8mR3Le
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c68655-8bf7-4dfe-6955-08dd9e8a0160
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 08:22:52.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+8uZGDkJOOQkAKy4gHanunpJB+UykEN9yJXiSHlPYIJAFP3tXNSU4Vnj+YouOUmUo4/4poA9W2AVVeCUnAk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9637

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDE0OjM5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiANCltzbmlwXQ0KPiDCoAkvKg0KR2VudGxlIHBpbmcgOikNCg0KDQo=

