Return-Path: <linux-pci+bounces-27035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2927AA4814
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4924A1C1E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49623A99F;
	Wed, 30 Apr 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ByNNHBhT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RDKOG0dJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34BF235060;
	Wed, 30 Apr 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008104; cv=fail; b=gHd5iPc5cFgDmGTcLAW/L0Q1LzIZKk3plqRr5EI7vHILjt/3rYs17BhzdVr3/raNj05olR5IFRlwV51EZwlXcAjQeLzxLo587XpmRxqrLjIBm/S7+TV03gU896YD/jGNr90PgerGSt5V2B442+HrPCAVPX1aV1YiY02+iSOoSpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008104; c=relaxed/simple;
	bh=wbxg0NHUwNQrDhyNUP6TSyENGzcc2PDrQKFe4Dk72AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XC7re0pBf8m1zi+pX9UD2Kb8n7T9Tm+/v/zkWc4f8eMuwLschFBUiJ1ATAQSphuXXPiBfMvVNobGCKa/+eEjbQA+oD8jQXj6maAQK1Mrgtf+uQJP/lvX38/2yOHz2cuIr2aepSRHSkNzgf5xxxK/Au6Pj1AklKdVUlvI7wnAkiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ByNNHBhT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RDKOG0dJ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746008101; x=1777544101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wbxg0NHUwNQrDhyNUP6TSyENGzcc2PDrQKFe4Dk72AY=;
  b=ByNNHBhT5r8H3Sb/HfEE49/NXfqJJCxkX6FtdauCk8+KL0k4207yWplh
   Cxrd+y26SNUIftAdsoFAu+LTzIWwbWJMqQcvieECTfSbQJWWOU0OdQK6L
   AptQKpmFAiidrkrSOEp8JWXFtpFb6wUIYK++FV5dE97PEIeWHxrEGQao+
   2przLbmkcEp5Bq/d8wqXc6XDGqOI72MqEKj5FrxNRZI2aeZiYwYH3Sz0o
   lrg20Yk/sFgF55H24+eAkainwrKZc0UlDq/y305zhhUqkSD9ohnSQ6r2i
   yvpg5zRGaRLGoxML3YD/xGWvtiOBLH+NS+gcIzO9GLNyNTLLlqAxCqfFo
   Q==;
X-CSE-ConnectionGUID: +ZoNjEV4R86RsgO45qjGBg==
X-CSE-MsgGUID: bLMk5JeeQTeECK0dmTLrxA==
X-IronPort-AV: E=Sophos;i="6.15,251,1739808000"; 
   d="scan'208";a="78216089"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2025 18:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRt1tZLyedO8atViXDXSiR/J6N5wr+sJuD2LCwHZmTTDrJOh9MfmUzllyTvE81gS3mTW81gAEwgm09swkc3oKv+0ivIzJpfXwst6I3w1Fq7x+BIAZpX7QLjd/uo8CntAK6m5rwxRob9otxU2V9iICi1i5rHgh4Nt4OevBRBJ3avnJD0CJR+bPemFAVZaoFCUxX/MOYJqyWtzNjJ0Y/JOR2NlbJjXL8xvKHu3jqQz2042LIwmTs0BNK+jj8hBIQEgtvSxqEEDGQg1SlWEl2VuInWWd8zvTpIspllMXPujaUolRrb9J6id8TCCK42++KUAW/XPjllRpB8TgNHmCEQYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbxg0NHUwNQrDhyNUP6TSyENGzcc2PDrQKFe4Dk72AY=;
 b=sExCsPYf0cINUBpzDzkhTHGtGUgVET6+kNAOykb29Gu+kfeRaM3PkAU742UO0igqVzx1vkQxD5HZsBsHNy3pdKep1oFXeFzEC4lDBbjxAzSCHy6rcgrz4uZ8eijR2eMx5evnvaynDhj9fW4W7m2PamO9hxJJxGXYVTMX//zNQMHn6Xo0sVzN0783A0yDGNlmN/ned9x40dVeGqt3nosxmFYwciQ4IAk2VI3ANXl0077O9TtBO8brA8vxHYCz2BLoCKSl3MfOH7wc/t/PaW4wK0tSnn4vpR+nu921zzepmeUCAfyx68Ls4xLihAKnTWMVksjL8freXGIaSBr6wPlnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbxg0NHUwNQrDhyNUP6TSyENGzcc2PDrQKFe4Dk72AY=;
 b=RDKOG0dJWXO9Ai5R82ZTLHS+N2/6YiTEI3PWxYQ/EfAutSPPoWUbmqH0yh7QXGsTzv1IqD4RPJf6XKH7Fd0i3mIiFyjbPM/i72KOsnoh+EstEXEJNZQWEbamlnswpXPydhkqMOOYXbRbxk47ZK/ap3KkPbNmYrj4cokhX9NcPCQ=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SJ0PR04MB7870.namprd04.prod.outlook.com (2603:10b6:a03:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 10:14:52 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%2]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 10:14:52 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "cassel@kernel.org" <cassel@kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"alistair@alistair23.me" <alistair@alistair23.me>, "robh@kernel.org"
	<robh@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"heiko@sntech.de" <heiko@sntech.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: Add support for slot reset on link down event
Thread-Topic: [PATCH] PCI: dwc: Add support for slot reset on link down event
Thread-Index: AQHbuaOyXpBdKDIxrEWCrSpfV1qnX7O72W2AgAAktQA=
Date: Wed, 30 Apr 2025 10:14:51 +0000
Message-ID: <011ac1d065e782258c4bf7a1b5309142b4501d0d.camel@wdc.com>
References: <20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com>
	 <aBHZT_mOruwH7HxJ@ryzen>
In-Reply-To: <aBHZT_mOruwH7HxJ@ryzen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SJ0PR04MB7870:EE_
x-ms-office365-filtering-correlation-id: dda8e1e6-0943-4837-5779-08dd87cfd8ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0cvZ1JDc2VVNCtkWDFZR2M4YWhjSm9CT2l3anJHRXNVaU9lTVZ4SjlCbGQ0?=
 =?utf-8?B?dCtRWG0wUytRYWM5QXdFamdxbDNRTHpQQzVpdFFod3NHQ1hSNkxoWGdKMUZX?=
 =?utf-8?B?ZUlUN3Z1NTNESDRDak9uSEF3dHI2RjFBMysvNVpCTll6c0c5dnZXUWdzVHlQ?=
 =?utf-8?B?aVFxdVF5TEZyRkV3cXIxQlhMNXdSTDhrOGRveVNENlRyeW1PZUdKOUNIRU9T?=
 =?utf-8?B?SU9GcG50NEI3QnRoeW04aXBodzhxOGFhVk5KU0E0OEVVT3pzZVdaVXplK0g2?=
 =?utf-8?B?S2t3bCtUaVF3WU5scS9yUmlQZlRwSW1rMk1VblJGVHVtZlhUbU1NUSszY0tL?=
 =?utf-8?B?Q3RiSStRaGR3RUtlaTRwSmc2TERKOUFTL0VxdkhOdk1aOTJJaUNadVBnZ2RJ?=
 =?utf-8?B?dnc2RFpWTC80MGdlY0tGQUNucU11ajBIMm1Ob1M0Y3NrN3A2SWtPK0hoaXdu?=
 =?utf-8?B?WEpyejRhMWgyd1hUUDFBUTZCVXlxTVRXWGUvdUhrUlBMVHRoMGJhcDRMcG9X?=
 =?utf-8?B?MHJVNmlLZ2pnUUdBdDYraE41ai9MTGNudkpicjE0NDZRZW8yR3poN2I2RWU5?=
 =?utf-8?B?NEx4NWk3MTJNL2JaYWpnc3o4alE3THN4cHhyQXZpVVl5WEU2aFRlQjZtYjlq?=
 =?utf-8?B?SlVXUEl4SWhMVm9GQUI2VUNzalFRaUlPZVh3bUNSNG0rcTVDWlJ0UmVkcGpR?=
 =?utf-8?B?Si9IK0hMVE9YK2FjU0NjRGlWVmtWZlQvSUFzWkJlaEVwQ1BsdDlIOTdyUURw?=
 =?utf-8?B?dHZqeUgxS3lwVDI5WXdPcXl6aFh0YmtqK0U3dDVmMnRIcFQxNmVSVmZnbzM2?=
 =?utf-8?B?ZnNKaVRxSFcyZnhWdXk4Vm14NXFEM1orcmY0WGdwcSs2Yk1QOGZZMFA0QVBp?=
 =?utf-8?B?SFZ1ZTJvcVhwME5RaDYzTklxbHFRKzZ2S3A2Wm8xZXdhZVB6Y2kwYnl3L2ta?=
 =?utf-8?B?ZGRXdTRZbXJhNXVRQnZBU3NSNnEyVjkxT0wwUVBSbXNGMmJQeWFZOXhOYmJx?=
 =?utf-8?B?UWtrbkdyMFQ1aXFBRHNXeEVPRWN1LzdGbEhPc2lXSU9jVkVCdXdjNmNMeEpx?=
 =?utf-8?B?K0pLUitsQm9oZUQyc2ZXUDB0dG95ZDcrYzQ5a0x4UEJXWnpKY2lYUEtQbDFB?=
 =?utf-8?B?NU9wbkFFWEt1TnZ4R3VUb2pDQWxWWDBUNWtEY1AvTnVkTXE5Wllkc0V2SDc5?=
 =?utf-8?B?ZkhaV3NwbjV6TGtQTC9QbktTMEZ3TktMV3A4V25YblJIbmtvb2RSaTV0QlRD?=
 =?utf-8?B?UUx1YmlaSzZmblRLQnpqcXc0eHk1ZndpdFBzUTd4Wkt5YytQaFFOOXR1MGs2?=
 =?utf-8?B?dGZWNnpVRXZEMGVNdzRnTDVScWptSWFDRGMrSFNTeXp2ZDdKSk5PQ01iQ2Zr?=
 =?utf-8?B?aEplVkZUeDc5eEk4aTZnN1ZrbG1iMEtabXZFb2RidG5JRUNUU1BLUHRPRERR?=
 =?utf-8?B?ZWVWWkd2MkE3Y0VOdEZJM1pPMUdaUTJ0MVVzU2pVaHdwTEFhaWwzYWtibGl2?=
 =?utf-8?B?UzN6c1creTRUd3hybnljN25FbGhhSVcyOGNoZWZzdmhqcWdzblFQRGFlVW9N?=
 =?utf-8?B?eVBUNTVmcDlHVGdjV0dGVUd4UzVUa2VIT1hvTWxoWVFTc3d1M0p5MGpVRS9y?=
 =?utf-8?B?TWJPci9RdW9oTkliSDdrV1NHVStsTVdrTXdwWVgvcjAzRDQwU3YxRGtLUTJu?=
 =?utf-8?B?aFAwVjJrdEVEc0lxWkdxWmNjMmtIbEd6Y2R2RG1oeGgydzVObEZuUitUMFBt?=
 =?utf-8?B?c1RQeTk0a01Mb1ZZNTY5VnF2ZWc0VjRmSGlTREZtcGRpcWQzazE0eGpxNjJZ?=
 =?utf-8?B?STc3ZGVxUXlTSEszUW1BY2JoRTV4S0c4RGQ1eGM2eWVRdFlCK0hZUzFGUmJy?=
 =?utf-8?B?SHdmVSsvcXNTM2xiQ2IwOFRQcGk0MzVveU9GWlAyQ3VuQzF2Q3d3MDFTRXFq?=
 =?utf-8?Q?bw0o7hkCZBYAQl+5XSUlL+hNIeabo5G7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFdQbW9JamIwTEpkcFgwZmdlNVlzamlmcUQ0MHd5NmdLMEt5QVlQelA4ZVN3?=
 =?utf-8?B?RlNQMWR3ZW1mMU03WXdKRlErRktJYjNNNjFJc3BUOFhQcTVMWWlpWC93U0I1?=
 =?utf-8?B?YW4xem5YSE9KK3h3M0kwUTBxUDZoTHVnMkJMWkkvM05PRXliQS9FZ3dhRFpl?=
 =?utf-8?B?NnRHcGxpV3Zrak9VamFhZkswUUQvVXZYWGhtaXF5cUpIY2loeG1yd1J4SUpm?=
 =?utf-8?B?bk9BVWtFNk5jVkFOalZ5RzZQVUcxRDh2dXZibU9IRTJDQW1vSGR0cStHelZu?=
 =?utf-8?B?MklIODBBOFVoVHM2VjVPYUZuTWJKNFZiZGZuc2E3V3ZTc0NMditxbGFVQk50?=
 =?utf-8?B?dmRXWVlKYll3T2FKSmtQSFdXOXV3MktFSVRIMGcrL2ZaZzBCaUEyYWcrYUFq?=
 =?utf-8?B?bTlvVmgvUCtZRVlKempRTWEwNm9oVUFhNHFvUW13a3pKRDB6VXU3NnYzNnA5?=
 =?utf-8?B?TGtPdjU4bGh4NUxkanJvM3V4QnZzRXNJR3ZOZ05yVHhBMm8yN0ZSWSsxR0R6?=
 =?utf-8?B?VnQzVnVvZGF3U0ttV1ExOFM1aTErOE1TVlpQd2dMaE5XcHVIU3ZTTnBGZlAw?=
 =?utf-8?B?dk41N3Y5WDM5d1ZITDlsSFpSNnhJQ1NGd1U0Z3dSdUxlNUNzbERkUytpVHBU?=
 =?utf-8?B?eEY3R2R6QUxMMzdzZ0tGcHhyTGJDYWU0WFRqNGswQ2xjdlJBZkFNOVRTZVo4?=
 =?utf-8?B?R0NwWGl4WFc2UlhZUFV2Nk5hTVArcTNUOVdCdXJQNytHNkI1WGkrdTJycm1j?=
 =?utf-8?B?THkzZnFJaktxTjJYY0Y3QWM5SCtncURiRzdVb3d3MlJGcGppb0pUcVZzcTJz?=
 =?utf-8?B?a3hlQnhiNlRUQ05rRDM0cHpOQ3RzTThpaDJKb3owUmRKdTliQXhEbkRjYXYv?=
 =?utf-8?B?aUF3bGJlZkFBQWs4czAybjE3ZjNpU1FxU0wvTzN2bTl2VnJWb2lUUnFzZi9J?=
 =?utf-8?B?ZTNWbFNhZ1JRallrcC9mcXA5QThkbUZ3U2k1ZDR6VFl3LzlSYzd3SnM0SURq?=
 =?utf-8?B?d2VSZlFpSStVbVhsR2pDNU5DVkRlODFPakFLQU00Uk5tbWVBdW1hZWpiQ0JK?=
 =?utf-8?B?L05FUXBYMFhWRURhRDdNOXVrdTBNck13VkI5M2FuNHRZMGc3WlVueHlUbUVL?=
 =?utf-8?B?M3FmVzlrMVR4Smpld3dDSC9WdGtBRXFHN09BWnJ1MU0yVjNaa1hLWHJMdVgx?=
 =?utf-8?B?MXZRMk5ia3VFc0dQc25XbGFQQjlzWE8vWk56d0g0eXJ3ZnRoYnVIZi9uSzZh?=
 =?utf-8?B?K015VGZab1RINFh5V2M5eHJ4dWZDMTJKc3pGQ2ZOUFNxNi9wRitGR3Q4RS9R?=
 =?utf-8?B?NVBCTmx2bi9LVGo0WFd3Tm94TlAyME5kRmhiYm82OUVTWlZaZlc3RTFlTHNN?=
 =?utf-8?B?VnA0T1RwM2tYMmJ5NTJ0dXlvYy8wZS9OOWMvV2tJWE9MeHBleGlmYXd3Si9p?=
 =?utf-8?B?VnU5ZFVwTUZwdFIyTVFlUFRYb1pTcXFSUmtwSEU1MzFST2xHUi9ZUVhkcWFu?=
 =?utf-8?B?dUl5dTZpay9mS3ZoWXlqSkt1SmFwVU5uZXB3eGJMNjFwNnR3TUh3am9xVk9p?=
 =?utf-8?B?Z1ZyTW1kdkllZEFCSWZjUmlOcTMydURLZFp6cjJNZG1sTkZUOUtCUHlPY0lY?=
 =?utf-8?B?YmF6dnRGQnY0MncxV0dxL3grNTdvSXhCdStBcmZNRnJ4UnRYYkNBQ1NzRmF4?=
 =?utf-8?B?MlMwYXkzMGIwS1RjYzlwZVpXQm9oV0NiTXRYdnZkZUtUMzBDdGpGUzAybXd4?=
 =?utf-8?B?NzZYUDFtNHo4VldqdnA4NEVNUC9xRW9BVTBJUXpHZ0g2VlE0dENFVnhsR215?=
 =?utf-8?B?NXRjdWZBbStKK2ltUE1vY1JXWXhXMVdkK1F3TVNMeXBya0RBVzRZeEJnQVYz?=
 =?utf-8?B?aGw3T2IzN1RzTDJaYThLOUFiU25yYTZLaXJWKzRkckVzQkxjcmYyeTl4b0VY?=
 =?utf-8?B?cndrMnBEZEdUZ0lMWUJMOWNWR2JrOUdHU09ZalQxZ251NlUrL1A0dmdrYkpk?=
 =?utf-8?B?OThGeUtWVUlVRkFranRrVG1LWnpWQkhNeVI4bDBjYjRJUzdhUkNJd2V4VjZ1?=
 =?utf-8?B?L2NJUDBEc29keEpLVkZvdFJWR0tnM0dHcFd4d0NnMG84R3lHNDNWMFhVdVp4?=
 =?utf-8?B?cmlpblQ0S0hqakZOVjZ6MHFVZE1Hc0JmQlhKcnJ2VS96SVVjS1NLQzllbU1P?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6931961544A5D14E95EB48FFFC218D03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K9kWHF+35V17ROYAdIdkwleAlWUdHFiKQgNNcZMNvMEKZKRnAogbsJaxqEmb3PTbat5att/vwllAPFR/TBYb+JmsM5chuyagA64LJ4EgnByd/aydVHGpRhw3vKhgHL8R+18HiR/Dp+oidrhEQLgCQxyyEUa8iN5OoO9iVHgS+lIac54f3dGXy4NX4ETihyG9eQachB9ib+tW4x+ZL4ZNMq/AAfocqO9I2cJVIBxjnBcaaUcfaX+Iz57WOtNNpG9jzA3mtOWU1ZuAzQJGZe5hQ1r5/FCb1xn6vF+jfDubjCLKcRujdSfm1c5e1d5q+FQe1SUCh482M3M1cxJiMKTDOJb41MGTwXJbbkGkSiwqV/EINtUTnqc5xS7n3txzuF2eQJxNU66aQUmvsdaWURreD1vHIuRWmZZwkbelsalCJ1gTxo9OVpDIrHsb4JKVpgJzG/qqa+mLEE6RC41s6Xu+4hTD7C3pqasRroiqyTgNoUc+muUda5a21p6Nbv1JZkIk1fCDHN2Zc0WezE+pVt4NUyK6cmAfzOH79K/bM4CTJnQX2omydqMlVzlwnQESkAPOiy20sZWJoFkFwHpZS11rgVbXw139r7mY/0QPZ8tKVa/RvmFlbjdglIXxc8YQ9TGo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda8e1e6-0943-4837-5779-08dd87cfd8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 10:14:51.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVcHGHqXO4LF4UjomYSm8seDcWBu7rYweQ54fX4+v0qOAfJoXFmeb7OlzYZR0FnowW8Ga5QJu0b/icAOeawsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7870

SGV5IE5pa2xhcywNCg0KT24gV2VkLCAyMDI1LTA0LTMwIGF0IDEwOjAzICswMjAwLCBOaWtsYXMg
Q2Fzc2VsIHdyb3RlOg0KPiBIZWxsbyBXaWxmcmVkLA0KPiANCj4gTmljZSB0byBzZWUgdGhpcyBm
ZWF0dXJlIDopDQo+IA0KPiBPbiBXZWQsIEFwciAzMCwgMjAyNSBhdCAwNTo0Mzo1MVBNICsxMDAw
LCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6DQo+ID4gRnJvbTogV2lsZnJlZCBNYWxsYXdhIDx3aWxm
cmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gPiANCj4gPiBUaGUgUENJZSBsaW5rIG1heSBnbyBkb3du
IGluIGNhc2VzIGxpa2UgZmlybXdhcmUgY3Jhc2hlcyBvcg0KPiA+IHVuc3RhYmxlDQo+ID4gY29u
bmVjdGlvbnMuIFdoZW4gdGhpcyBvY2N1cnMsIHRoZSBQQ0llIHNsb3QgbXVzdCBiZSByZXNldCB0
bw0KPiA+IHJlc3RvcmUNCj4gPiBmdW5jdGlvbmFsaXR5LiBIb3dldmVyLCB0aGUgY3VycmVudCBk
cml2ZXIgbGFja3MgbGluayBkb3duDQo+ID4gaGFuZGxpbmcsDQo+ID4gZm9yY2luZyB1c2VycyB0
byByZWJvb3QgdGhlIHN5c3RlbSB0byByZWNvdmVyLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggaW1w
bGVtZW50cyB0aGUgYHJlc2V0X3Nsb3RgIGNhbGxiYWNrIGZvciBsaW5rIGRvd24NCj4gPiBoYW5k
bGluZw0KPiA+IGZvciBEV0MgUENJZSBob3N0IGNvbnRyb2xsZXIuIEluIHdoaWNoLCB0aGUgUkMg
aXMgcmVzZXQsDQo+ID4gcmVjb25maWd1cmVkDQo+ID4gYW5kIGxpbmsgdHJhaW5pbmcgaW5pdGlh
dGVkIHRvIHJlY292ZXIgZnJvbSB0aGUgbGluayBkb3duIGV2ZW50Lg0KPiA+IA0KPiA+IFRoaXMg
cGF0Y2ggYnkgZXh0ZW5zaW9uIGZpeGVzIGlzc3VlcyB3aXRoIHN5c2ZzIGluaXRpYXRlZCBidXMN
Cj4gPiByZXNldHMuDQo+ID4gSW4gdGhhdCwgY3VycmVudGx5LCB3aGVuIGEgc3lzZnMgaW5pdGlh
dGVkIGJ1cyByZXNldCBpcyBpc3N1ZWQsIHRoZQ0KPiA+IGVuZHBvaW50IGRldmljZSBpcyBub24t
ZnVuY3Rpb25hbCBhZnRlciAobWF5IGxpbmsgdXAgd2l0aA0KPiA+IGRvd25ncmFkZWQgbGluaw0K
PiA+IHN0YXR1cykuIFdpdGggdGhpcyBwYXRjaCBhZGRpbmcgc3VwcG9ydCBmb3IgbGluayBkb3du
IHJlY292ZXJ5LCBhDQo+ID4gc3lzZnMNCj4gPiBpbml0aWF0ZWQgYnVzIHJlc2V0IHdvcmtzIGFz
IGludGVuZGVkLiBUZXN0aW5nIGNvbmR1Y3RlZCBvbiBhDQo+ID4gUk9DSzVCIGJvYXJkDQo+ID4g
d2l0aCBhbiBNLjIgTlZNZSBkcml2ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBXaWxmcmVk
IE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+IEhleSBhbGws
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBidWlsZHMgb250b3Agb2YgWzFdIHRvIGV4dGVuZCB0aGUg
cmVzZXQgc2xvdCBzdXBwb3J0IGZvcg0KPiA+IHRoZQ0KPiA+IERXQyBQQ0llIGhvc3QgY29udHJv
bGxlci4gV2hpY2ggaW1wbGVtZW50cyBsaW5rIGRvd24gcmVjb3ZlcnkNCj4gPiBzdXBwb3J0DQo+
ID4gZm9yIHRoZSBEZXNpZ25XYXJlIFBDSWUgaG9zdCBjb250cm9sbGVyIGJ5IGFkZGluZyBhIGBy
ZXNldF9zbG90YA0KPiA+IGNhbGxiYWNrLg0KPiA+IFRoaXMgYWxsb3dzIHRoZSBzeXN0ZW0gdG8g
cmVjb3ZlciBmcm9tIFBDSWUgbGluayBmYWlsdXJlcyB3aXRob3V0DQo+ID4gcmVxdWlyaW5nIGEg
cmVib290Lg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggYnkgZXh0ZW5zaW9uIGltcHJvdmVzIHRoZSBi
ZWhhdmlvciBvZiBzeXNmcy1pbml0aWF0ZWQNCj4gPiBidXMgcmVzZXRzLg0KPiA+IFByZXZpb3Vz
bHksIGEgYHJlc2V0YCBpc3N1ZWQgdmlhIHN5c2ZzIGNvdWxkIGxlYXZlIHRoZSBlbmRwb2ludCBp
bg0KPiA+IGENCj4gPiBub24tZnVuY3Rpb25hbCBzdGF0ZSBvciB3aXRoIGRvd25ncmFkZWQgbGlu
ayBwYXJhbWV0ZXJzLiBXaXRoIHRoZQ0KPiA+IGFkZGVkDQo+ID4gbGluayBkb3duIHJlY292ZXJ5
IGxvZ2ljLCBzeXNmcyByZXNldHMgbm93IHJlc3VsdCBpbiBhIHByb3Blcmx5DQo+ID4gcmVpbml0
aWFsaXplZA0KPiA+IGFuZCBmdWxseSBmdW5jdGlvbmFsIGVuZHBvaW50IGRldmljZS4gVGhpcyBp
c3N1ZSB3YXMgZGlzY292ZXJlZCBvbg0KPiA+IGENCj4gPiBSb2NrNUIgYm9hcmQsIGFuZCB0aHVz
IHRlc3Rpbmcgd2FzIGFsc28gY29uZHVjdGVkIG9uIHRoZSBzYW1lDQo+ID4gcGxhdGZvcm0NCj4g
PiB3aXRoIGEga25vd24gZ29vZCBNLjIgTlZNZSBkcml2ZS4NCj4gPiANCj4gPiBUaGFua3MhDQo+
ID4gDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNDE3LXBj
aWUtcmVzZXQtc2xvdC12My0wLTU5YTEwODExYzk2MkBsaW5hcm8ub3JnLw0KPiA+IC0tLQ0KPiA+
IMKgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDEgKw0KPiA+IMKgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kdy1yb2Nr
Y2hpcC5jIHwgODkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiDCoDIgZmls
ZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiA+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiA+IGluZGV4DQo+ID4gZDlmMDM4NjM5
NmVkZjY2YWQwZTUxNGEwZjU0NWVkMjRkODlmY2I2Yy4uODc4YzUyZGUwODQyZTMyY2E1MGRmY2M0
Yg0KPiA+IDY2MjMxYTczZWY0MzZjNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
S2NvbmZpZw0KPiA+IEBAIC0zNDcsNiArMzQ3LDcgQEAgY29uZmlnIFBDSUVfUk9DS0NISVBfRFdf
SE9TVA0KPiA+IMKgCWRlcGVuZHMgb24gT0YNCj4gPiDCoAlzZWxlY3QgUENJRV9EV19IT1NUDQo+
ID4gwqAJc2VsZWN0IFBDSUVfUk9DS0NISVBfRFcNCj4gPiArCXNlbGVjdCBQQ0lfSE9TVF9DT01N
T04NCj4gPiDCoAloZWxwDQo+ID4gwqAJwqAgRW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgRGVzaWdu
V2FyZSBQQ0llIGNvbnRyb2xsZXIgaW4NCj4gPiB0aGUNCj4gPiDCoAnCoCBSb2NrY2hpcCBTb0Mg
KGV4Y2VwdCBSSzMzOTkpIHRvIHdvcmsgaW4gaG9zdCBtb2RlLg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYw0KPiA+IGluZGV4DQo+ID4g
M2M2YWI3MWM5OTZlYzEyNDY5NTRmNTJhOTQ1NGM4YWU2Nzk1NmE1NC4uNGMyYzY4M2QxNzBmMTky
NjZlMWRmZTBlZg0KPiA+IGRlNzZkNmZlYjIzYmY3YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gPiArKysgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gPiBAQCAtMjMsNiArMjMs
OCBAQA0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gwqANCj4gPiDCoCNpbmNs
dWRlICJwY2llLWRlc2lnbndhcmUuaCINCj4gPiArI2luY2x1ZGUgIi4uLy4uL3BjaS5oIg0KPiA+
ICsjaW5jbHVkZSAiLi4vcGNpLWhvc3QtY29tbW9uLmgiDQo+ID4gwqANCj4gPiDCoC8qDQo+ID4g
wqAgKiBUaGUgdXBwZXIgMTYgYml0cyBvZiBQQ0lFX0NMSUVOVF9DT05GSUcgYXJlIGEgd3JpdGUN
Cj4gPiBAQCAtODMsNiArODUsOSBAQCBzdHJ1Y3Qgcm9ja2NoaXBfcGNpZV9vZl9kYXRhIHsNCj4g
PiDCoAljb25zdCBzdHJ1Y3QgcGNpX2VwY19mZWF0dXJlcyAqZXBjX2ZlYXR1cmVzOw0KPiA+IMKg
fTsNCj4gPiDCoA0KPiA+ICtzdGF0aWMgaW50IHJvY2tjaGlwX3BjaWVfcmNfcmVzZXRfc2xvdChz
dHJ1Y3QgcGNpX2hvc3RfYnJpZGdlDQo+ID4gKmJyaWRnZSwNCj4gPiArCQkJCcKgwqDCoMKgwqDC
oCBzdHJ1Y3QgcGNpX2RldiAqcGRldik7DQo+ID4gKw0KPiA+IMKgc3RhdGljIGludCByb2NrY2hp
cF9wY2llX3JlYWRsX2FwYihzdHJ1Y3Qgcm9ja2NoaXBfcGNpZSAqcm9ja2NoaXAsDQo+ID4gdTMy
IHJlZykNCj4gPiDCoHsNCj4gPiDCoAlyZXR1cm4gcmVhZGxfcmVsYXhlZChyb2NrY2hpcC0+YXBi
X2Jhc2UgKyByZWcpOw0KPiA+IEBAIC0yNTYsNiArMjYxLDcgQEAgc3RhdGljIGludCByb2NrY2hp
cF9wY2llX2hvc3RfaW5pdChzdHJ1Y3QNCj4gPiBkd19wY2llX3JwICpwcCkNCj4gPiDCoAkJCQkJ
IHJvY2tjaGlwKTsNCj4gPiDCoA0KPiA+IMKgCXJvY2tjaGlwX3BjaWVfZW5hYmxlX2wwcyhwY2kp
Ow0KPiA+ICsJcHAtPmJyaWRnZS0+cmVzZXRfc2xvdCA9IHJvY2tjaGlwX3BjaWVfcmNfcmVzZXRf
c2xvdDsNCj4gPiDCoA0KPiA+IMKgCXJldHVybiAwOw0KPiA+IMKgfQ0KPiA+IEBAIC00NTUsNiAr
NDYxLDExIEBAIHN0YXRpYyBpcnFyZXR1cm5fdA0KPiA+IHJvY2tjaGlwX3BjaWVfcmNfc3lzX2ly
cV90aHJlYWQoaW50IGlycSwgdm9pZCAqYXJnKQ0KPiA+IMKgCWRldl9kYmcoZGV2LCAiUENJRV9D
TElFTlRfSU5UUl9TVEFUVVNfTUlTQzogJSN4XG4iLCByZWcpOw0KPiA+IMKgCWRldl9kYmcoZGV2
LCAiTFRTU01fU1RBVFVTOiAlI3hcbiIsDQo+ID4gcm9ja2NoaXBfcGNpZV9nZXRfbHRzc20ocm9j
a2NoaXApKTsNCj4gPiDCoA0KPiA+ICsJaWYgKHJlZyAmIFBDSUVfTElOS19SRVFfUlNUX05PVF9J
TlQpIHsNCj4gPiArCQlkZXZfZGJnKGRldiwgImhvdCByZXNldCBvciBsaW5rLWRvd24gcmVzZXRc
biIpOw0KPiA+ICsJCXBjaV9ob3N0X2hhbmRsZV9saW5rX2Rvd24ocHAtPmJyaWRnZSk7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+IMKgCWlmIChyZWcgJiBQQ0lFX1JETEhfTElOS19VUF9DSEdFRCkgew0K
PiA+IMKgCQlpZiAocm9ja2NoaXBfcGNpZV9saW5rX3VwKHBjaSkpIHsNCj4gPiDCoAkJCWRldl9k
YmcoZGV2LCAiUmVjZWl2ZWQgTGluayB1cCBldmVudC4NCj4gPiBTdGFydGluZyBlbnVtZXJhdGlv
biFcbiIpOw0KPiA+IEBAIC01MzYsOCArNTQ3LDggQEAgc3RhdGljIGludCByb2NrY2hpcF9wY2ll
X2NvbmZpZ3VyZV9yYyhzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gwqAJ
CXJldHVybiByZXQ7DQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gLQkvKiB1bm1hc2sgRExMIHVwL2Rv
d24gaW5kaWNhdG9yICovDQo+ID4gLQl2YWwgPSBISVdPUkRfVVBEQVRFKFBDSUVfUkRMSF9MSU5L
X1VQX0NIR0VELCAwKTsNCj4gPiArCS8qIHVubWFzayBETEwgdXAvZG93biBpbmRpY2F0b3IgYW5k
IGhvdCByZXNldC9saW5rLWRvd24NCj4gPiByZXNldCBpcnEgKi8NCj4gPiArCXZhbCA9IEhJV09S
RF9VUERBVEUoUENJRV9SRExIX0xJTktfVVBfQ0hHRUQgfA0KPiA+IFBDSUVfTElOS19SRVFfUlNU
X05PVF9JTlQsIDApOw0KPiA+IMKgCXJvY2tjaGlwX3BjaWVfd3JpdGVsX2FwYihyb2NrY2hpcCwg
dmFsLA0KPiA+IFBDSUVfQ0xJRU5UX0lOVFJfTUFTS19NSVNDKTsNCj4gPiDCoA0KPiA+IMKgCXJl
dHVybiByZXQ7DQo+ID4gQEAgLTY4OCw2ICs2OTksODAgQEAgc3RhdGljIGludCByb2NrY2hpcF9w
Y2llX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDCoAlyZXR1
cm4gcmV0Ow0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gK3N0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9y
Y19yZXNldF9zbG90KHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UNCj4gPiAqYnJpZGdlLA0KPiA+ICsJ
CQkJwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwY2lfYnVz
ICpidXMgPSBicmlkZ2UtPmJ1czsNCj4gPiArCXN0cnVjdCBkd19wY2llX3JwICpwcCA9IGJ1cy0+
c3lzZGF0YTsNCj4gPiArCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fcHAo
cHApOw0KPiA+ICsJc3RydWN0IHJvY2tjaGlwX3BjaWUgKnJvY2tjaGlwID0gdG9fcm9ja2NoaXBf
cGNpZShwY2kpOw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcm9ja2NoaXAtPnBjaS5kZXY7
DQo+ID4gKwl1MzIgdmFsOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlkd19wY2llX3N0
b3BfbGluayhwY2kpOw0KPiA+ICsJcm9ja2NoaXBfcGNpZV9waHlfZGVpbml0KHJvY2tjaGlwKTsN
Cj4gPiArDQo+ID4gKwlyZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChyb2NrY2hpcC0+cnN0KTsN
Cj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBy
b2NrY2hpcF9wY2llX3BoeV9pbml0KHJvY2tjaGlwKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJ
Z290byBkaXNhYmxlX3JlZ3VsYXRvcjsNCj4gPiArDQo+ID4gKwlyZXQgPSByZXNldF9jb250cm9s
X2RlYXNzZXJ0KHJvY2tjaGlwLT5yc3QpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlnb3RvIGRl
aW5pdF9waHk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcm9ja2NoaXBfcGNpZV9jbGtfaW5pdChyb2Nr
Y2hpcCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCWdvdG8gZGVpbml0X3BoeTsNCj4gDQo+IEhl
cmUgeW91IGNhbGwgcm9ja2NoaXBfcGNpZV9jbGtfaW5pdCgpLCBidXQgSSBkb24ndCBzZWUgdGhh
dCB3ZSBldmVyDQo+IGNhbGxlZA0KPiBjbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZSgpIGFmdGVy
IHN0b3BwaW5nIHRoZSBsaW5rLiBJIHdvdWxkIGhhdmUNCj4gZXhwZWN0ZWQNCj4gdGhlIGNsayBm
cmFtZXdvcmsgdG8gaGF2ZSBnaXZlbiB1cyBhIHdhcm5pbmcgYWJvdXQgZW5hYmxpbmcgY2xvY2tz
DQo+IHRoYXQgYXJlDQo+IGFscmVhZHkgZW5hYmxlZC4NCj4gDQpBaCB0aGF0J3MgYSBnb29kIHBv
aW50LiBJIGRpZG4ndCBub3RpY2UgYW55IHdhcm5pbmdzIHdoaWxzdCB0ZXN0aW5nLg0KUGVyaGFw
cyB3b3J0aCBsb29raW5nIGludG8gYWxzby4gQnV0IEkgd2lsbCBhZGQNCmBjbGtfYnVsa19kaXNh
YmxlX3VucHJlcGFyZSgpYCBhZnRlciBzdG9wcGluZyB0aGUgbGluay4NCj4gDQo+ID4gKw0KPiA+
ICsJcmV0ID0gcHAtPm9wcy0+aW5pdChwcCk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2
X2VycihkZXYsICJIb3N0IGluaXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gPiArCQlnb3RvIGRl
aW5pdF9jbGs7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogTFRTU00gZW5hYmxlIGNvbnRyb2wg
bW9kZSAqLw0KPiA+ICsJdmFsID0gSElXT1JEX1VQREFURV9CSVQoUENJRV9MVFNTTV9FTkFCTEVf
RU5IQU5DRSk7DQo+ID4gKwlyb2NrY2hpcF9wY2llX3dyaXRlbF9hcGIocm9ja2NoaXAsIHZhbCwN
Cj4gPiBQQ0lFX0NMSUVOVF9IT1RfUkVTRVRfQ1RSTCk7DQo+ID4gKw0KPiA+ICsJcm9ja2NoaXBf
cGNpZV93cml0ZWxfYXBiKHJvY2tjaGlwLCBQQ0lFX0NMSUVOVF9SQ19NT0RFLA0KPiA+IFBDSUVf
Q0xJRU5UX0dFTkVSQUxfQ09OKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkd19wY2llX3NldHVwX3Jj
KHBwKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBz
ZXR1cCBSQzogJWRcbiIsIHJldCk7DQo+ID4gKwkJZ290byBkZWluaXRfY2xrOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCS8qIHVubWFzayBETEwgdXAvZG93biBpbmRpY2F0b3IgYW5kIGhvdCByZXNl
dC9saW5rLWRvd24NCj4gPiByZXNldCBpcnEgKi8NCj4gPiArCXZhbCA9IEhJV09SRF9VUERBVEUo
UENJRV9SRExIX0xJTktfVVBfQ0hHRUQgfA0KPiA+IFBDSUVfTElOS19SRVFfUlNUX05PVF9JTlQs
IDApOw0KPiA+ICsJcm9ja2NoaXBfcGNpZV93cml0ZWxfYXBiKHJvY2tjaGlwLCB2YWwsDQo+ID4g
UENJRV9DTElFTlRfSU5UUl9NQVNLX01JU0MpOw0KPiA+ICsNCj4gPiArCXJldCA9IGR3X3BjaWVf
c3RhcnRfbGluayhwY2kpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiAN
Cj4gSGVyZSB5b3UgYXJlIHNpbXBseSByZXR1cm5pbmcgcmV0IGluIGNhc2Ugb2YgZXJyb3IsDQo+
IHNob3VsZCB3ZSBwZXJoYXBzIGdvdG8gZXJyb3IgaWYgdGhpcyBmdW5jdGlvbiBmYWlscz8NCkFo
IHllYWghIHRoYXQgZG9lcyBtYWtlIG1vcmUgc2Vuc2UuDQo+IA0KPiANCj4gPiArDQo+ID4gKwly
ZXQgPSBkd19wY2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gDQo+IEhlcmUsIEkgdGhpbmsgdGhhdCB3ZSBzaG91bGQgc2ltcGx5IGNh
bGwgZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkNCj4gd2l0aG91dCBjaGVja2luZyBmb3IgZXJyb3Iu
DQo+IA0KPiAxKSBUaGF0IGlzIHdoYXQgTWFuaSBkb2VzIGluIHRoZSBxY29tIHBhdGNoIHRoYXQg
aW1wbGVtZW50cyB0aGUNCj4gcmVzZXRfc2xvdCgpIGNhbGxiYWNrLg0KPiAyKSBUaGF0IGlzIHdo
YXQgd2UgZG8gaW46DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21h
c3Rlci9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jI0w1
NTgtTDU1OQ0KPiANCj4gKElnbm9yZSBlcnJvcnMsIHRoZSBsaW5rIG1heSBjb21lIHVwIGxhdGVy
KQ0KT2theSB3aWxsIGZpeHVwISB0aGFua3MgZm9yIHRoZSBmZWVkYmFjayENCg0KV2lsZnJlZA0K
PiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gTmlrbGFzDQoNCg==

