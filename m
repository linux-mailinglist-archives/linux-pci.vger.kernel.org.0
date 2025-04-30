Return-Path: <linux-pci+bounces-27031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26676AA4499
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE89C1C66
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620820E6F3;
	Wed, 30 Apr 2025 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cHycaOZf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O3oitVlT"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C121DE8B4;
	Wed, 30 Apr 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999951; cv=fail; b=Nl+tUJFb+oebIjOszxzTWh8IGZAT5sfsxboYsC2+1yjiab6OhWJ5CEdb04sDMmnuVUO31L9gACI0OsWCTcZ3SVMSgxnRKamqEdNf2h9cpHvhbTskrIYJD/o6vq/qnqGbyZD9ZH5YAB8BeNUO32z8g6G7vqfZIDFi1H0Pexkapts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999951; c=relaxed/simple;
	bh=Akvqj5mSQWQH/igEmGDAgfCt2JEKtE5ekBMl2cbsoFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AOOrFt6T0LxTg1aRWTCrg8iJkhqm7a9F/8PUxffpcWO7D3f32FZbTnLdvb6a8cygHSUMArgEndXd3TF1JxngjWBhxvbxZLBIj+ajcIUc1ZgP3gb6XhAOds6jK8i+cW1fTpSv6txEdbe1vxNaUTVg7nNN6rn0gKAYCvblO6jUoXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cHycaOZf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=O3oitVlT; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745999948; x=1777535948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Akvqj5mSQWQH/igEmGDAgfCt2JEKtE5ekBMl2cbsoFY=;
  b=cHycaOZf74gmAmsD/nSXx+ALmUuFXd64DPpVxkBbiNNSqTfyFvewCapQ
   gP8tBsaR2hgRQSp+Ygit1CGJo8piuKxo18r4JsY09DT8AHqSKOYXfgtAj
   mtZuOGDGgCV3PxslsUxk+COwIIQ29ewINXIKStSP8qfxUcZeFytRroC6+
   8FpzfymUZ4O4mtckHtHY3gvHlR0+l/N0hb8iZRDYlr0JAvBd5IdOIYQXv
   01CbaoPdzCAkmPf1+tmshB6D4fkCB8jCDtFzlVNP7IJStx20BZpoTwM2/
   2sN5URxJlIM4YjuW9z7cEe36/vXmDhrBz/7E49hxugWsLLW23QgzZd7/I
   g==;
X-CSE-ConnectionGUID: rXHPiBHfSviMsl5aFtfGHA==
X-CSE-MsgGUID: +fcEQJ+gRlalmiz+afVNCg==
X-IronPort-AV: E=Sophos;i="6.15,251,1739808000"; 
   d="scan'208";a="82880579"
Received: from mail-westcentralusazlp17012035.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.35])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2025 15:59:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfKAtoXuksSOOIIwPhsfPIC/rJFjNzItIVg0Yg0KsFBzyiWQWVhJwyELHCB7YGTH1KhMKQguJcxWLA9M9iUa/POOtdaD2UtdUR/1Wn/LPQ3e/S6pOWtiQtcHEEA/FCtX6mI9ZKpU5OHkH/sBAlHy4XQNV9vk1h8GEMwR2jff0Ikc3ZoSCdRAbzS0DDdIuWU91WPhEsyxIDfyoonK2Cm+rFJBTVyb0NjqiSNYl756ZhtevsVKv79UXeTWFGCOjO2kfCiece2xyxnv8LIVp/SMbQkTnzwz25KJgvtuk+QpmPw6+cl8c9dtSM86aAnL6QOMkvjvxDumSJ7n1MiG+bzkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akvqj5mSQWQH/igEmGDAgfCt2JEKtE5ekBMl2cbsoFY=;
 b=NMj1L1e65kcawZ4SemBAN59357OXga7QTc6kMrj95Syxu2O5icAOvbVQmTk9+kpJiuPk5n75dyxhW/61avUOG4LXX9zcGAAhgmGTQXroon7RwtWuSCuLFqxA+YZlb4zPiu1hKUot9ClnPpxPDM7v/OjCohPebyFn/aqcc91sIVZhDU8JFa4TdU9o1pZdIbPAhXiizZAaN/fPoIFdYiLNEQ3OyoAnCyZ2TyYSZY+oO/Z82SuaRgIpfFJIVjaHfIlm0ugwhTjpTNnbkIzRFAVkL4zZw6eYPa7Jz3mzCv0KntVLX5J4+a7bzCA/OGW3EX34VXM62Js6f+1jjCjcw8nGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akvqj5mSQWQH/igEmGDAgfCt2JEKtE5ekBMl2cbsoFY=;
 b=O3oitVlTyEGIxhYez/4NlVVrojMidJoOumSw0v5x+WhcJ+b39Imgs1KtWED9gcyt9m0m88HG/HeKhCC70FffQET5HjBHSWW8yBB8C8qDrZ/U/lHPSsvmHWUiKmlL1EMNRoGsfWr35UcrT7ZucCDDVWMpc8BzYwqVcx73vnmA64g=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CYYPR04MB8792.namprd04.prod.outlook.com (2603:10b6:930:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 07:59:05 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%2]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 07:59:05 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"heiko@sntech.de" <heiko@sntech.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alistair@alistair23.me"
	<alistair@alistair23.me>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "cassel@kernel.org" <cassel@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: Add support for slot reset on link down event
Thread-Topic: [PATCH] PCI: dwc: Add support for slot reset on link down event
Thread-Index: AQHbuaOyXpBdKDIxrEWCrSpfV1qnX7O72DMA
Date: Wed, 30 Apr 2025 07:59:05 +0000
Message-ID: <2fa15dbbe2452a08ca4a02b4179844829fb4884f.camel@wdc.com>
References: <20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com>
In-Reply-To: <20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CYYPR04MB8792:EE_
x-ms-office365-filtering-correlation-id: fb944570-2556-42d1-66fe-08dd87bce0ea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTNLSjUxaDZTeHEwRmt6REVCL2VRUll2NUhadHFGZng1SGkxZ29waDVNWjQ4?=
 =?utf-8?B?NUJNc1RDK091c25NOGJ5OCszaTJwbGdUTzBBSzFDa1lHWkE4Ums1ZkYxODlF?=
 =?utf-8?B?KzFQQnFab3JRVG90SjZXNFBGN1d4L3ZPMnlWeGdpd3FsRy9vMG1iVTVlSkYr?=
 =?utf-8?B?NVRZMjhGSEtWUkpaemNSQnRyT253RUl3MnNOU3pNN01ocElFS21Ha2hZUnRZ?=
 =?utf-8?B?UEVrbTVEWWFZU3NaT0x1TWJIaDRzdzNnbUFoaUZXc0Y2dWhxVk9RNVlmVkZT?=
 =?utf-8?B?UFJUQ1F5THo1N3NhSkg3N2dPVVBuMnlXbU1JbEZrNUpFVmh2aWxYU0hBV1BJ?=
 =?utf-8?B?aGtCVHRoUnhid3NCZmIxZUdXZVg1Z3lkcjFoNTh2SHQ3Q1ZXTEI4Y0dWUUhH?=
 =?utf-8?B?R3p2SzZVM25jMkZIRGkxMWFrQ01teE5sNURlQVZsVUpmYmZVeHBwZHBjV3JE?=
 =?utf-8?B?V3daWUxWTzNCMThteVpMOVlxTDR1ODFQUWwyYVFkeDBzYWhObWo3dnhkcjB5?=
 =?utf-8?B?Z1E2cnRKbHJxa2dQTDJYNmo3bnJiWHRrOWMydWdqVks5OXpCT085QjY1NVJJ?=
 =?utf-8?B?ZkM3WnBqSEUzYUswQXZDYzU0QkhRV1k1eHJiWHZod0xaUHdQblc1RE0xUGY2?=
 =?utf-8?B?ejI0dXVjYit1RTZleDM3UDhLUkxYdTR0MDVVZzMyYysxaW9rUGdzcytxVURV?=
 =?utf-8?B?TmlRREFaREhsYWZDbGVrSy96TXlHaDNiMm1iOE1oRUg1WW94TDdMbkxEdkFs?=
 =?utf-8?B?VFNsR3U2VjBpK1dxNlFqbXBETVE1QTNHcEpFQ0JTS3BheWZZSzJadk5EamFS?=
 =?utf-8?B?WmpsR0ZiVE5jVDNSNHlQZG9PNjdmMk44czMzUytlU0NFY05wQUZJcFNWc0Q2?=
 =?utf-8?B?SkkxMDltdzZISG4xTW9WUXNibTFaY1cwTFhrcEkrYkdLZDBnUjN2S0dhM05k?=
 =?utf-8?B?LzZISmtSQzBCY3Q4bHFWV0phR3JlaHE1aS9BMHFpeVJtQVFQVEQrTzk3NWVT?=
 =?utf-8?B?VnloWEVTQnlJcVEyRnpnQjZSYW5SdWRxN2gzSUdMRnI5d2xvLzZQRi9NaFNu?=
 =?utf-8?B?ZVNwZkloVW1ISGNTWG5HM3hvaXNkdHNHcEVIWGV0bHNHK1ByZFdiSi91ZUJ3?=
 =?utf-8?B?MFFNbFdqY3dSVGRwK282cW9ZWmtEZUYyY1VRZTRQZVkyWXpvT0EwVVdsT1JJ?=
 =?utf-8?B?SHpJT1ZuSG1CQUNlWkpqdndoR0FjWDBTV0xoNUV3bzhXeDhWZm55anRsZEFq?=
 =?utf-8?B?UklNMWhDQXAwM2VnYUdEa1gyR1pSb1I4ZUlpYjRORUtabXJTajFla2xwbngz?=
 =?utf-8?B?ekRNZG5COWFWZnpNZEY5QURpbVkxREp2aXhEbzZBNHBvK2RiYnpmT3NMcCtB?=
 =?utf-8?B?TC9FMXNlSy9Fa0drUW9tRmZPM3pYVXg2cWdNeE9STkNDbnFSb09nZVRTNktK?=
 =?utf-8?B?UTBnSlBoQ012Tk1kM3lVd2F2MldESmdOVEFyWnFaYkJuYmU3dWhpbmN4VWdi?=
 =?utf-8?B?TFkrczNuM3l2ZGhDbEtzTW1oT0R1T1FkbDBlMVZVb0xhdk53cXlsZlNHRHlO?=
 =?utf-8?B?cDlNdXVMVE11cmVYdnlZVmRwci9TSXlYWk5kcXZYUVRIRStZZmRHSzJzZDE3?=
 =?utf-8?B?QUlCR1lHU0pQNDIrOHY5VWlQV2hncllWWXNhYmc4NGVtR3pwSGJ3UUNFVmVE?=
 =?utf-8?B?NHhFMllpcWZEbWpDNTBsZEZkaGg3bWhZN3V2Ym1YSFI5L0poRjliQ010VlZE?=
 =?utf-8?B?RC9vMDZvdCtubTZnWkV5YlQ0c1I2S08rb2o1TG5sMjJZMkpzbldxbnFweEM4?=
 =?utf-8?B?V0w1NVovQ2tmU3c2K0RQNmlneUdCU0VaSUNxcS9jOFV4L3d5RmxCbnN4Uzg5?=
 =?utf-8?B?TjNjMlIxS3pEc1lCODFUcVJnaTJyMWpOMkxGc3puUktsSjFBcFlXbTh3ZGdZ?=
 =?utf-8?B?M2E1Z2ZpcHlMdHF2T2pEajdmeHNmTGlYK1ptYmd1T2Q3Nkw1NnpvNDd1aE0w?=
 =?utf-8?Q?qoX8UrW5LYvKfjt78PzGH0rBkXW3WE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZW9aeCtwTUZPdmlDSUtOMzN4U09SeHRISjdXempSYlkzN0JMVE13NUVDL29F?=
 =?utf-8?B?QTB1MlhFVEpBSGlwQVd5cmsyOEtmZVpMVnZRRGtGRlIzQ0VJRkhEaWZ0Sm5s?=
 =?utf-8?B?bUFaUmJ3RG8vV3A4YTcwNFJSbC9rQXJaOEdnMENkV2l2dE5ZVmVkWVhrc2xz?=
 =?utf-8?B?WkwzVUhnOVdwT0lpSE5XdVNLTzg4Lyt0MFlhMDQwRWJvTmo1cFplZE9uVWtY?=
 =?utf-8?B?YWRsRzVuOC9PNCtPcE9DbE9oYWlldTB3R29sTEMwY2tCS1ZhcGVITjNWSHRO?=
 =?utf-8?B?bG1iLzFWSU4vd3ZCN1c4UTNJb2NqV0U5Z3VrdXZWOHM2TDkxYXZ1TmM5SWNj?=
 =?utf-8?B?cXVEK0xoTkZuRFg1RDQrUkw5L1dZc2pWODB4b2ppK20rd0dmRDBsNEg1blJR?=
 =?utf-8?B?cmxPcEtLUnNCWi9KbFF6WjJ3N2RFdXFOWlphTW9xZzdCdVIrR2JyZUxBa1Bm?=
 =?utf-8?B?NlVNZXJ0YVNIbXM1bEhTUUR1c3R0TC9tcmVqRFdveEZEUjZBaXRTMHptaGpW?=
 =?utf-8?B?TS9TREkxNU42UGhGRGljdGZ4dllPRm9PN1RRd2ZZNW5HVTFqUUpJQlNQZ1ov?=
 =?utf-8?B?VUhVckhlSFNaMHRGcmhPZm45RC9PbVp3MmN0cHZvaGZoN3U3MFB4Nml4c01k?=
 =?utf-8?B?ejU0WmJjaDdwQk10clE5Ni9aYU0zL3dWeDI2UllLeTB0TWFqdmgvZkx1dDZD?=
 =?utf-8?B?NTQzSHEwdEd6QXR1WldadC9HNGFLWkhEcG1HSkdtTEdkTHNNT2VsbXBNSnE0?=
 =?utf-8?B?bVJKTVBYNVNDcDNwcnZHWU5DdU1uNkVpdUxwOExjNlhSVUQyKzM3dXRLR2sy?=
 =?utf-8?B?NTB2WVNGN2pUNGFJQy9JRCtPM1V2Y1JuT2Y3UDgyUnI1WE1SRmdjNnFIRDFq?=
 =?utf-8?B?WVNnM3RYU1VwTzlpTmM3aHhOUTd4eHFDYTFGRWQ1YXc5RkxwNzlYblF2NEla?=
 =?utf-8?B?L0JSbHRWS3VJYStHNmJmZ051TENiYnEreWRDdVA4cUJubVVRODB5d0xOdi9V?=
 =?utf-8?B?eDdOOUozN3V2QXk1aFdnYlpLVVUxcWdsY2xhb1FqOVJxc0E1eG1FTy8yYVFh?=
 =?utf-8?B?cnByQXBRSEtKMVFvUzdMVWVGNlRva2U3ekpPL2gxSE9hUGRhRFJiWllBZ1hY?=
 =?utf-8?B?K1JXR091cjc2RE1qRFZ1VHZrdTRxN1hFeTc2aStwbHRSYldMc1crYVMrWUpR?=
 =?utf-8?B?NFVrRUVTazVmNU5zTVgwMTJzRzlDK2hIQnFhR0dXOGRoQVhXKzZXdy9vZDhq?=
 =?utf-8?B?K3RyRDhGM0lQcUNVdUZ1RXhRR2cwQ1h0WjhEZmRjcnFXaGhsd3JIUDlERVVG?=
 =?utf-8?B?RnBCeVRBUk1UTk8zNk5GWnp6VkZFZ2g2eHl6dnNaZ2JlbktuMFk2TFdycUVa?=
 =?utf-8?B?NkZRMW55WTJSOW5Pdlp5UVRlSjhjMXl0S3hPU1lVUnhmQ05BenhadWVFMHg4?=
 =?utf-8?B?Q0dDRXI5OUpWc1d5cUhtc0dYejJZalVZVWhQbU1zdFRNOGJLYzYzaU83azZD?=
 =?utf-8?B?QlFlWXg4aVBGc3g3eGJmM1owWXY0cy8rb0VsQ2JJbXBLU0IxN01tRlVWblBu?=
 =?utf-8?B?V1c5bXJxazljOVFOektlck5aamZlalVlSlYrY1orR1I3aVliRURtY2JuNjdi?=
 =?utf-8?B?Y0JIa0g4WXNwT1pJQjE3ajUxd1JlUW8wMm0xZVVrcFpoQ1Fad0s3bGo1dU9R?=
 =?utf-8?B?eWQvQk1wK2xacTNRdi9FVVhHZ1h5aEFLd0xkdUlzcTA2aDV0OWZqUHFRNklB?=
 =?utf-8?B?aEF5Ni85U2NBd1l5K3kvM2xaR05BbnVVMUZVLzhQb3A2bVhOTGl4eGZzUDho?=
 =?utf-8?B?QTU5QVJKNXZXcXBycXphN2Ywd2pxdmRlR3JTREh1Qi9oWnlTRENITXlZdC9P?=
 =?utf-8?B?aUFNb1pXV243SDdSRTlweVVZU2J1S1RCVThOcHYzMnFVVlRGU29RUUszc1Bl?=
 =?utf-8?B?cEQ0VHdVanlOYTllQkNwUWpzQm5YSXo1OHRpNGZaN1Z2b0ltWFh2KzB2cUI1?=
 =?utf-8?B?VW5zdHZHanhYSEs1S3FNMmxua2NrbENacDlkSlZUR08xeXVPcEdYUGpIeFJG?=
 =?utf-8?B?NXUyZDhNTUxYR1RDaklJS1YySVQ3U0cwQWV0RnFtSGRUZVRkS1Q1TEFQdGxw?=
 =?utf-8?B?NjhWMXJLNFc4eU93NHZFV1NCTXFhMWRveDJJay82NjJRQk5PenNZbURMWlJG?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9831BE0222904540A52D738C0A5EC698@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5/AoLzxniZtsXmNd8S1ybi+4Vp7qXIM8DuZPOA9nRwr2w+Day71Z1rSMJLNKxNRGiZePuXvjV0LqFv7OWB8xMFLb0MLV8z8rD8ZyNKh1MfIUeMBipJZ6YlxCvg2ukow9IHx2bQ1n07IwFPaJRvqJ3f+D0gKUTcgVXCce1K0Q0GpcQ70PMu6N8TH3PHwSX0pyXbvw3CiVSUPR5K2HJrLn9+oaSJsnQPpRsOIXhdfLbtcdNg05VmAdcN6aBw/Quwl0tc12ZyTRAXCYvNpu4jg83Jr4OEon+hM45anzdA/1aUcBq0c3a8XREdPD+GsHPeSXozhSZwgn9YDhw7UyafjB2eJzjHkq+X7gsOUwgqe+jnNsJAJdp7yJJmIDZiOleX4avagpvYOI5ME95yu92VyINUv5HbDQHD0i9ZQysPGA82f/lFLjhXyPuPVlJiMd5U2vjJ1q1HT0RUTaEXnOVsCZDFj88Z2rCyCctuLSg4CY+30qjqhpqlr0lRmEoNZDMWrI37/SWPkdq7W88V6Jb2U//VvNXnlS3qDe+OT2r/2ZRc6U6IezsRUeFAe7K+yiNuUbxk/UNWltxZ7B/9Bn9b2J+r7I49fWNZA5Aj0vI2wRIbekYVgar/E9p+kG8eXR2sP3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb944570-2556-42d1-66fe-08dd87bce0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 07:59:05.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROHad/OV68sBVxJd69h4Ylpwmm5MnJmJBjHRKphkG/LEC4FoLMQIdT6dKCbvU8AiZ5APdYvIn6LMM5gHc/WcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8792

T24gV2VkLCAyMDI1LTA0LTMwIGF0IDE3OjQzICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6
DQo+IEZyb206IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+IA0K
PiBUaGUgUENJZSBsaW5rIG1heSBnbyBkb3duIGluIGNhc2VzIGxpa2UgZmlybXdhcmUgY3Jhc2hl
cyBvciB1bnN0YWJsZQ0KPiBjb25uZWN0aW9ucy4gV2hlbiB0aGlzIG9jY3VycywgdGhlIFBDSWUg
c2xvdCBtdXN0IGJlIHJlc2V0IHRvIHJlc3RvcmUNCj4gZnVuY3Rpb25hbGl0eS4gSG93ZXZlciwg
dGhlIGN1cnJlbnQgZHJpdmVyIGxhY2tzIGxpbmsgZG93biBoYW5kbGluZywNCj4gZm9yY2luZyB1
c2VycyB0byByZWJvb3QgdGhlIHN5c3RlbSB0byByZWNvdmVyLg0KPiANCj4gVGhpcyBwYXRjaCBp
bXBsZW1lbnRzIHRoZSBgcmVzZXRfc2xvdGAgY2FsbGJhY2sgZm9yIGxpbmsgZG93bg0KPiBoYW5k
bGluZw0KPiBmb3IgRFdDIFBDSWUgaG9zdCBjb250cm9sbGVyLiBJbiB3aGljaCwgdGhlIFJDIGlz
IHJlc2V0LCByZWNvbmZpZ3VyZWQNCj4gYW5kIGxpbmsgdHJhaW5pbmcgaW5pdGlhdGVkIHRvIHJl
Y292ZXIgZnJvbSB0aGUgbGluayBkb3duIGV2ZW50Lg0KPiANCj4gVGhpcyBwYXRjaCBieSBleHRl
bnNpb24gZml4ZXMgaXNzdWVzIHdpdGggc3lzZnMgaW5pdGlhdGVkIGJ1cyByZXNldHMuDQo+IElu
IHRoYXQsIGN1cnJlbnRseSwgd2hlbiBhIHN5c2ZzIGluaXRpYXRlZCBidXMgcmVzZXQgaXMgaXNz
dWVkLCB0aGUNCj4gZW5kcG9pbnQgZGV2aWNlIGlzIG5vbi1mdW5jdGlvbmFsIGFmdGVyIChtYXkg
bGluayB1cCB3aXRoIGRvd25ncmFkZWQNCj4gbGluaw0KPiBzdGF0dXMpLiBXaXRoIHRoaXMgcGF0
Y2ggYWRkaW5nIHN1cHBvcnQgZm9yIGxpbmsgZG93biByZWNvdmVyeSwgYQ0KPiBzeXNmcw0KPiBp
bml0aWF0ZWQgYnVzIHJlc2V0IHdvcmtzIGFzIGludGVuZGVkLiBUZXN0aW5nIGNvbmR1Y3RlZCBv
biBhIFJPQ0s1Qg0KPiBib2FyZA0KPiB3aXRoIGFuIE0uMiBOVk1lIGRyaXZlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4g
LS0tDQo+IEhleSBhbGwsDQo+IA0KPiBUaGlzIHBhdGNoIGJ1aWxkcyBvbnRvcCBvZiBbMV0gdG8g
ZXh0ZW5kIHRoZSByZXNldCBzbG90IHN1cHBvcnQgZm9yDQo+IHRoZQ0KPiBEV0MgUENJZSBob3N0
IGNvbnRyb2xsZXIuIFdoaWNoIGltcGxlbWVudHMgbGluayBkb3duIHJlY292ZXJ5IHN1cHBvcnQN
Cj4gZm9yIHRoZSBEZXNpZ25XYXJlIFBDSWUgaG9zdCBjb250cm9sbGVyIGJ5IGFkZGluZyBhIGBy
ZXNldF9zbG90YA0KPiBjYWxsYmFjay4NCj4gVGhpcyBhbGxvd3MgdGhlIHN5c3RlbSB0byByZWNv
dmVyIGZyb20gUENJZSBsaW5rIGZhaWx1cmVzIHdpdGhvdXQNCj4gcmVxdWlyaW5nIGEgcmVib290
Lg0KPiANCj4gVGhpcyBwYXRjaCBieSBleHRlbnNpb24gaW1wcm92ZXMgdGhlIGJlaGF2aW9yIG9m
IHN5c2ZzLWluaXRpYXRlZCBidXMNCj4gcmVzZXRzLg0KPiBQcmV2aW91c2x5LCBhIGByZXNldGAg
aXNzdWVkIHZpYSBzeXNmcyBjb3VsZCBsZWF2ZSB0aGUgZW5kcG9pbnQgaW4gYQ0KPiBub24tZnVu
Y3Rpb25hbCBzdGF0ZSBvciB3aXRoIGRvd25ncmFkZWQgbGluayBwYXJhbWV0ZXJzLiBXaXRoIHRo
ZQ0KPiBhZGRlZA0KPiBsaW5rIGRvd24gcmVjb3ZlcnkgbG9naWMsIHN5c2ZzIHJlc2V0cyBub3cg
cmVzdWx0IGluIGEgcHJvcGVybHkNCj4gcmVpbml0aWFsaXplZA0KPiBhbmQgZnVsbHkgZnVuY3Rp
b25hbCBlbmRwb2ludCBkZXZpY2UuIFRoaXMgaXNzdWUgd2FzIGRpc2NvdmVyZWQgb24gYQ0KPiBS
b2NrNUIgYm9hcmQsIGFuZCB0aHVzIHRlc3Rpbmcgd2FzIGFsc28gY29uZHVjdGVkIG9uIHRoZSBz
YW1lDQo+IHBsYXRmb3JtDQo+IHdpdGggYSBrbm93biBnb29kIE0uMiBOVk1lIGRyaXZlLg0KPiAN
Cj4gVGhhbmtzIQ0KPiANCj4gWzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1
MDQxNy1wY2llLXJlc2V0LXNsb3QtdjMtMC01OWExMDgxMWM5NjJAbGluYXJvLm9yZy8NCj4gLS0t
DQo+IMKgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKw0KPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9j
a2NoaXAuYyB8IDg5DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiDCoDIgZmlsZXMg
Y2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+IGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiBpbmRleA0KPiBkOWYwMzg2Mzk2ZWRmNjZhZDBlNTE0
YTBmNTQ1ZWQyNGQ4OWZjYjZjLi44NzhjNTJkZTA4NDJlMzJjYTUwZGZjYzRiNjYNCj4gMjMxYTcz
ZWY0MzZjNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZp
Zw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+IEBAIC0zNDcs
NiArMzQ3LDcgQEAgY29uZmlnIFBDSUVfUk9DS0NISVBfRFdfSE9TVA0KPiDCoAlkZXBlbmRzIG9u
IE9GDQo+IMKgCXNlbGVjdCBQQ0lFX0RXX0hPU1QNCj4gwqAJc2VsZWN0IFBDSUVfUk9DS0NISVBf
RFcNCj4gKwlzZWxlY3QgUENJX0hPU1RfQ09NTU9ODQo+IMKgCWhlbHANCj4gwqAJwqAgRW5hYmxl
cyBzdXBwb3J0IGZvciB0aGUgRGVzaWduV2FyZSBQQ0llIGNvbnRyb2xsZXIgaW4gdGhlDQo+IMKg
CcKgIFJvY2tjaGlwIFNvQyAoZXhjZXB0IFJLMzM5OSkgdG8gd29yayBpbiBob3N0IG1vZGUuDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlw
LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4g
aW5kZXgNCj4gM2M2YWI3MWM5OTZlYzEyNDY5NTRmNTJhOTQ1NGM4YWU2Nzk1NmE1NC4uNGMyYzY4
M2QxNzBmMTkyNjZlMWRmZTBlZmRlDQo+IDc2ZDZmZWIyM2JmN2EgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYw0KPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gQEAgLTIzLDYgKzIz
LDggQEANCj4gwqAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gwqANCj4gwqAjaW5jbHVkZSAi
cGNpZS1kZXNpZ253YXJlLmgiDQo+ICsjaW5jbHVkZSAiLi4vLi4vcGNpLmgiDQo+ICsjaW5jbHVk
ZSAiLi4vcGNpLWhvc3QtY29tbW9uLmgiDQo+IMKgDQo+IMKgLyoNCj4gwqAgKiBUaGUgdXBwZXIg
MTYgYml0cyBvZiBQQ0lFX0NMSUVOVF9DT05GSUcgYXJlIGEgd3JpdGUNCj4gQEAgLTgzLDYgKzg1
LDkgQEAgc3RydWN0IHJvY2tjaGlwX3BjaWVfb2ZfZGF0YSB7DQo+IMKgCWNvbnN0IHN0cnVjdCBw
Y2lfZXBjX2ZlYXR1cmVzICplcGNfZmVhdHVyZXM7DQo+IMKgfTsNCj4gwqANCj4gK3N0YXRpYyBp
bnQgcm9ja2NoaXBfcGNpZV9yY19yZXNldF9zbG90KHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UNCj4g
KmJyaWRnZSwNCj4gKwkJCQnCoMKgwqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiAr
DQo+IMKgc3RhdGljIGludCByb2NrY2hpcF9wY2llX3JlYWRsX2FwYihzdHJ1Y3Qgcm9ja2NoaXBf
cGNpZSAqcm9ja2NoaXAsDQo+IHUzMiByZWcpDQo+IMKgew0KPiDCoAlyZXR1cm4gcmVhZGxfcmVs
YXhlZChyb2NrY2hpcC0+YXBiX2Jhc2UgKyByZWcpOw0KPiBAQCAtMjU2LDYgKzI2MSw3IEBAIHN0
YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9ob3N0X2luaXQoc3RydWN0DQo+IGR3X3BjaWVfcnAgKnBw
KQ0KPiDCoAkJCQkJIHJvY2tjaGlwKTsNCj4gwqANCj4gwqAJcm9ja2NoaXBfcGNpZV9lbmFibGVf
bDBzKHBjaSk7DQo+ICsJcHAtPmJyaWRnZS0+cmVzZXRfc2xvdCA9IHJvY2tjaGlwX3BjaWVfcmNf
cmVzZXRfc2xvdDsNCj4gwqANCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiBAQCAtNDU1LDYgKzQ2
MSwxMSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QNCj4gcm9ja2NoaXBfcGNpZV9yY19zeXNfaXJxX3Ro
cmVhZChpbnQgaXJxLCB2b2lkICphcmcpDQo+IMKgCWRldl9kYmcoZGV2LCAiUENJRV9DTElFTlRf
SU5UUl9TVEFUVVNfTUlTQzogJSN4XG4iLCByZWcpOw0KPiDCoAlkZXZfZGJnKGRldiwgIkxUU1NN
X1NUQVRVUzogJSN4XG4iLA0KPiByb2NrY2hpcF9wY2llX2dldF9sdHNzbShyb2NrY2hpcCkpOw0K
PiDCoA0KPiArCWlmIChyZWcgJiBQQ0lFX0xJTktfUkVRX1JTVF9OT1RfSU5UKSB7DQo+ICsJCWRl
dl9kYmcoZGV2LCAiaG90IHJlc2V0IG9yIGxpbmstZG93biByZXNldFxuIik7DQo+ICsJCXBjaV9o
b3N0X2hhbmRsZV9saW5rX2Rvd24ocHAtPmJyaWRnZSk7DQo+ICsJfQ0KPiArDQo+IMKgCWlmIChy
ZWcgJiBQQ0lFX1JETEhfTElOS19VUF9DSEdFRCkgew0KPiDCoAkJaWYgKHJvY2tjaGlwX3BjaWVf
bGlua191cChwY2kpKSB7DQo+IMKgCQkJZGV2X2RiZyhkZXYsICJSZWNlaXZlZCBMaW5rIHVwIGV2
ZW50Lg0KPiBTdGFydGluZyBlbnVtZXJhdGlvbiFcbiIpOw0KPiBAQCAtNTM2LDggKzU0Nyw4IEBA
IHN0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9jb25maWd1cmVfcmMoc3RydWN0DQo+IHBsYXRmb3Jt
X2RldmljZSAqcGRldiwNCj4gwqAJCXJldHVybiByZXQ7DQo+IMKgCX0NCj4gwqANCj4gLQkvKiB1
bm1hc2sgRExMIHVwL2Rvd24gaW5kaWNhdG9yICovDQo+IC0JdmFsID0gSElXT1JEX1VQREFURShQ
Q0lFX1JETEhfTElOS19VUF9DSEdFRCwgMCk7DQo+ICsJLyogdW5tYXNrIERMTCB1cC9kb3duIGlu
ZGljYXRvciBhbmQgaG90IHJlc2V0L2xpbmstZG93bg0KPiByZXNldCBpcnEgKi8NCj4gKwl2YWwg
PSBISVdPUkRfVVBEQVRFKFBDSUVfUkRMSF9MSU5LX1VQX0NIR0VEIHwNCj4gUENJRV9MSU5LX1JF
UV9SU1RfTk9UX0lOVCwgMCk7DQo+IMKgCXJvY2tjaGlwX3BjaWVfd3JpdGVsX2FwYihyb2NrY2hp
cCwgdmFsLA0KPiBQQ0lFX0NMSUVOVF9JTlRSX01BU0tfTUlTQyk7DQo+IMKgDQo+IMKgCXJldHVy
biByZXQ7DQo+IEBAIC02ODgsNiArNjk5LDgwIEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9w
cm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiDCoAlyZXR1cm4gcmV0Ow0K
PiDCoH0NCj4gwqANCj4gK3N0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9yY19yZXNldF9zbG90KHN0
cnVjdCBwY2lfaG9zdF9icmlkZ2UNCj4gKmJyaWRnZSwNCj4gKwkJCQnCoCBzdHJ1Y3QgcGNpX2Rl
diAqcGRldikNCm9vcHMsIHdpbGwgZml4dXAgdGhlIGFsaWdubWVudCBoZXJlIGZvciBWMiA6KSAN
Cg0KV2lsZnJlZA0KPiArew0KPiArCXN0cnVjdCBwY2lfYnVzICpidXMgPSBicmlkZ2UtPmJ1czsN
Cj4gKwlzdHJ1Y3QgZHdfcGNpZV9ycCAqcHAgPSBidXMtPnN5c2RhdGE7DQo+ICsJc3RydWN0IGR3
X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9wcChwcCk7DQo+ICsJc3RydWN0IHJvY2tjaGlw
X3BjaWUgKnJvY2tjaGlwID0gdG9fcm9ja2NoaXBfcGNpZShwY2kpOw0KPiArCXN0cnVjdCBkZXZp
Y2UgKmRldiA9IHJvY2tjaGlwLT5wY2kuZGV2Ow0KPiArCXUzMiB2YWw7DQo+ICsJaW50IHJldDsN
Cj4gKw0KPiArCWR3X3BjaWVfc3RvcF9saW5rKHBjaSk7DQo+ICsJcm9ja2NoaXBfcGNpZV9waHlf
ZGVpbml0KHJvY2tjaGlwKTsNCj4gKw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHJv
Y2tjaGlwLT5yc3QpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwly
ZXQgPSByb2NrY2hpcF9wY2llX3BoeV9pbml0KHJvY2tjaGlwKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlnb3RvIGRpc2FibGVfcmVndWxhdG9yOw0KPiArDQo+ICsJcmV0ID0gcmVzZXRfY29udHJvbF9k
ZWFzc2VydChyb2NrY2hpcC0+cnN0KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGRlaW5pdF9w
aHk7DQo+ICsNCj4gKwlyZXQgPSByb2NrY2hpcF9wY2llX2Nsa19pbml0KHJvY2tjaGlwKTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlnb3RvIGRlaW5pdF9waHk7DQo+ICsNCj4gKwlyZXQgPSBwcC0+b3Bz
LT5pbml0KHBwKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiSG9zdCBpbml0
IGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICsJCWdvdG8gZGVpbml0X2NsazsNCj4gKwl9DQo+ICsN
Cj4gKwkvKiBMVFNTTSBlbmFibGUgY29udHJvbCBtb2RlICovDQo+ICsJdmFsID0gSElXT1JEX1VQ
REFURV9CSVQoUENJRV9MVFNTTV9FTkFCTEVfRU5IQU5DRSk7DQo+ICsJcm9ja2NoaXBfcGNpZV93
cml0ZWxfYXBiKHJvY2tjaGlwLCB2YWwsDQo+IFBDSUVfQ0xJRU5UX0hPVF9SRVNFVF9DVFJMKTsN
Cj4gKw0KPiArCXJvY2tjaGlwX3BjaWVfd3JpdGVsX2FwYihyb2NrY2hpcCwgUENJRV9DTElFTlRf
UkNfTU9ERSwNCj4gUENJRV9DTElFTlRfR0VORVJBTF9DT04pOw0KPiArDQo+ICsJcmV0ID0gZHdf
cGNpZV9zZXR1cF9yYyhwcCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKGRldiwgIkZh
aWxlZCB0byBzZXR1cCBSQzogJWRcbiIsIHJldCk7DQo+ICsJCWdvdG8gZGVpbml0X2NsazsNCj4g
Kwl9DQo+ICsNCj4gKwkvKiB1bm1hc2sgRExMIHVwL2Rvd24gaW5kaWNhdG9yIGFuZCBob3QgcmVz
ZXQvbGluay1kb3duDQo+IHJlc2V0IGlycSAqLw0KPiArCXZhbCA9IEhJV09SRF9VUERBVEUoUENJ
RV9SRExIX0xJTktfVVBfQ0hHRUQgfA0KPiBQQ0lFX0xJTktfUkVRX1JTVF9OT1RfSU5ULCAwKTsN
Cj4gKwlyb2NrY2hpcF9wY2llX3dyaXRlbF9hcGIocm9ja2NoaXAsIHZhbCwNCj4gUENJRV9DTElF
TlRfSU5UUl9NQVNLX01JU0MpOw0KPiArDQo+ICsJcmV0ID0gZHdfcGNpZV9zdGFydF9saW5rKHBj
aSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGR3X3Bj
aWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+
ICsNCj4gKwlkZXZfZGJnKGRldiwgIlNsb3QgcmVzZXQgY29tcGxldGVkXG4iKTsNCj4gKwlyZXR1
cm4gcmV0Ow0KPiArDQo+ICtkZWluaXRfY2xrOg0KPiArCWNsa19idWxrX2Rpc2FibGVfdW5wcmVw
YXJlKHJvY2tjaGlwLT5jbGtfY250LCByb2NrY2hpcC0NCj4gPmNsa3MpOw0KPiArZGVpbml0X3Bo
eToNCj4gKwlyb2NrY2hpcF9wY2llX3BoeV9kZWluaXQocm9ja2NoaXApOw0KPiArZGlzYWJsZV9y
ZWd1bGF0b3I6DQo+ICsJaWYgKHJvY2tjaGlwLT52cGNpZTN2MykNCj4gKwkJcmVndWxhdG9yX2Rp
c2FibGUocm9ja2NoaXAtPnZwY2llM3YzKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+
ICsNCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHJvY2tjaGlwX3BjaWVfb2ZfZGF0YQ0KPiByb2Nr
Y2hpcF9wY2llX3JjX29mX2RhdGFfcmszNTY4ID0gew0KPiDCoAkubW9kZSA9IERXX1BDSUVfUkNf
VFlQRSwNCj4gwqB9Ow0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiAwODczMzA4OGI1NjZiNTgy
ODNmMGYxMmZiNzNmNWRiNmE5YTlkZTMwDQo+IGNoYW5nZS1pZDogMjAyNTA0MzAtYjQtcGNpX2R3
Y19yZXNldF9zdXBwb3J0LWQ3MjBkYmFmYjdlYQ0KPiBwcmVyZXF1aXNpdGUtY2hhbmdlLWlkOiAy
MDI1MDQwNC1wY2llLXJlc2V0LXNsb3QtNzMwYmZhNzFhMjAyOnYzDQo+IHByZXJlcXVpc2l0ZS1w
YXRjaC1pZDogMmRhZDg1ZWIyNjgzOGQ4OTU2OWIxMmMxOWQ3MGYzOTJmYTU5MjY2Nw0KPiBwcmVy
ZXF1aXNpdGUtcGF0Y2gtaWQ6IDYyMzhhNjgyYmQ4ZTk0NzZlNTkxMWI3YTU5MjYzYzNmYzYxOGQ2
M2UNCj4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiBhMDEzMDAwODNlOTRhNjdlYTdjOGJmY2RlMzIw
MDgxZDkwYjM4NGQ0DQo+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogZmY3MTFmNjVjZjk5MjYzNzQ2
NDZiNzZjZDM4YmRkODIzZDU3Njc2NA0KPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IGE1ZWU5ZDRi
NzI4YjgwZDMyODQ0YzUxMDhhNWI0NTNlYWE0ZjY1M2YNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0K

