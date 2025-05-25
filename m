Return-Path: <linux-pci+bounces-28382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B315FAC322E
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 04:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17635179743
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 02:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9990288DA;
	Sun, 25 May 2025 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BpojQ0nm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KJFhekxz"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB376;
	Sun, 25 May 2025 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748140722; cv=fail; b=JeVf4+6fSMfklAbSHXg6rf7x8nTsrQD+Ke2+Ps/4307cWr9cOvNsSCklmsMcsspHue1ydx9n81t5lVqys8S+CdyPwnPEbE6v94qO25ehgYPx0mIrDVPx/9lr6cQ1MteD9hj6Bf0z1QW5Hpo5pYvTH3JzEIBvg/lwN+s3iJ6Lj84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748140722; c=relaxed/simple;
	bh=TjnUJiDTnyt25mHOtBwCA2F9tWuBjCVAYTtKzvXiBkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ka9wSwDIPzUuiYhMH26zAqzNSL+2AW/N0KgjnXIZRae5YpbjvQb5qQPzkqnTP8njyAZywS8Qfk1/qJwvCIFpMZ0GeuvUtXk2+q7qyAWuoQPEY2/sHBf5P3kZeqoTpKCB5Of8sqwRaIwSqIQpPKlFh1G1EB3AVh6BkBFeoIj2ZZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BpojQ0nm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KJFhekxz; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748140721; x=1779676721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TjnUJiDTnyt25mHOtBwCA2F9tWuBjCVAYTtKzvXiBkg=;
  b=BpojQ0nmblAAxUklNROWQpiTGHVnZSt+MojTPgf8y66kuZthjnYAXp+l
   4V7LqtGmgOy7iAIhZDYt7nCWSO6e25PWIPMmRNggNZ6K3gumLnKyPQMXH
   7N5tJano4opAgqFpaRb7xr09bN2Np5BVkd2tSnQxROlUkcph6LFu9t/dR
   tGFfrsc8vNE7QWe0tAqHbnnvj3XHxA7nnBO2DkiKbQN9Iewg002ySiTcq
   RBXttj9fxLlcrIyZ9NDkalzu4zuvQ/KwgXP5xIWej2+Gd0MUYYzRrcqEK
   hdCQ42rQHz/3WadYGK7L61X9rp2MwAIS9CQsQWx2maZjIzudWCLZNMXov
   g==;
X-CSE-ConnectionGUID: GxYPXidSQX6v3UASaRZgQw==
X-CSE-MsgGUID: kxdpPtfnTcCHk07OotoOQQ==
X-IronPort-AV: E=Sophos;i="6.15,312,1739808000"; 
   d="scan'208";a="88958083"
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2025 10:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN6wtX/bRVG8dSDs7DiLxmFkAZ4WXcFgP4KMmtz2aTNQ2cKHm6VqcWYCqHSsWePzMljM6KcpAe74iedWTvOToH9lK8naeDnX3tD1yRcmGznfqHzUTcqSn7d8DRVqKY4iXE6cxNmrpN5tuMg6dBnN+8GgcIu18yWfd+9z21Mzwr8tRMBQs5/56dQsoocb4TlIm57Mar0YZQvlp9iTGY1l3pJFVV8Ny0u8S2Ik4b94KupOpDG2fDmQBDOwMXtzUPz2vW531m9+IuYXJ9Od78Kuep9V/0jMFmCm4fdsw0dQ/IAjlZ+gC3BtWKDPv057SWso28xf+dXyYydh9FtDf5bqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjnUJiDTnyt25mHOtBwCA2F9tWuBjCVAYTtKzvXiBkg=;
 b=rdL6rua2umoyiPkS0RF1+3kNKXxgFTjbOZuKFt1TdLSXPwURZQtRv3hfehaHRBLKnvkr726wOyUC6z6hiuMKe7jDHQjhUnNmZbo1MEV+OOaJEQV5jEnRVGbq5j3eqO/XGV1k6q7xVTHoQsiUTbOEbW8J9mTUM7zQiWUaOtKjycTx1Dl3eNKZyVfuHO83PpSEcskwnrGPA9vlwOyTDbruZIFwLl7nJkHOn69cuBlp2pzh4ofva0kqJkiTb/xO+4r/4mem7J0LBDJz8YluNAFfEDPmjw/k0hTYMg04MAHRkuO5cRoL/OuDs3/VauYJysaDvty/lAlQV5wM5RGX2PcSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjnUJiDTnyt25mHOtBwCA2F9tWuBjCVAYTtKzvXiBkg=;
 b=KJFhekxz+NUTReHNjaaqkrj6h7iJbpOix07jmEpD5uPbq1Q5I3GtELEZzDRIkAi3XKKnj1+JPhnDcXUJuOvh/K9QVyt3l+m3AbquPWK1kn/v8ABX5RZPwKXTZyVwTaMSlda1kaAS+ReyD81QNyX5I+gSTFhA4f8nIBXkWHJBwgw=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY5PR04MB6964.namprd04.prod.outlook.com (2603:10b6:a03:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sun, 25 May
 2025 02:38:36 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8769.021; Sun, 25 May 2025
 02:38:35 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "cassel@kernel.org" <cassel@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: "lukas@wunner.de" <lukas@wunner.de>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to
 host_bridge::reset_root_port()
Thread-Topic: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to
 host_bridge::reset_root_port()
Thread-Index: AQHbzN0itpE6GjctPEiZF3ybMaU/cLPiQ0MAgABfO4A=
Date: Sun, 25 May 2025 02:38:35 +0000
Message-ID: <e01aa311ea176d182610059f10d900bda7ff93ec.camel@wdc.com>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
	 <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>
	 <aDIyyMvQkMC40jnQ@ryzen>
In-Reply-To: <aDIyyMvQkMC40jnQ@ryzen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY5PR04MB6964:EE_
x-ms-office365-filtering-correlation-id: dd2300d6-b8b8-4c8a-782c-08dd9b353f9c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zy9sTzd4WFNxQlp6MkZyaXhEUmFZSlVyNlFSZWhZdVFacUZmejIzSSt2QnR4?=
 =?utf-8?B?Q3dPd3NGZEgvTERlYVVvWE5JMENWZ3hRYXdtclFPK3N1S1VHQXFKY2g2TTND?=
 =?utf-8?B?SmM0bk9UcXdFSkR1NmU4WHF2ZG1KVUxtYkZuODAvRFVOR2l3ZFI4dzh3STBv?=
 =?utf-8?B?WGJCaHFzMU5ubDF2RWltM2ozWm5UeFpOSWpTb0tiMmRGV2dzTWFlbWczZmpN?=
 =?utf-8?B?NFFKclo1STNFZ0h5ZFlHemZTbU53RzZBK2ZTR1diazNwemx4OGpOK1ZyQ09u?=
 =?utf-8?B?djkrd2puRzUrbHhrQTZWbjdONzhrdTY3Q3NaT2tycmtDanJxOWlGSWlWK1Jv?=
 =?utf-8?B?SDVjQ01VMXNhclE4TVVGdkQ4WVNTejYwY2grUEpKU3hqbFNqL2JQY0tablg2?=
 =?utf-8?B?M3FOTkFOSDZVVGtrRVM5VEtOZ1JHbVZwcVFuZFBrMUJ4bHNSZWlraFNYZHVI?=
 =?utf-8?B?bVRrQVRPMWMraXd2MnVxTmZTZk9Zb1dpc0FreWtnQTFBT3g5TWFiUE5icGdy?=
 =?utf-8?B?NWdMWGY4NWNKSTJsM0lIazEraDFMWXc1OU1tR25EblRCd0J0OEVGaDNBdHd4?=
 =?utf-8?B?eFRnNHpZVHpBTGUxVGEvblJXMjdoaDlxaUE4OGFmOU5CRVY5Y3RZL0k5azNx?=
 =?utf-8?B?ZkZrTFdOL3BsTERCejFOTUZ1K3BFNFR1R0hWQk9pdmp0NmdUa2NpNXJOemFv?=
 =?utf-8?B?TzdjSDB6bjRFeDBFNG40YWNxQXQ0bUEvbXVwdDZDWnRkSHp4YUcrU2NRRTZo?=
 =?utf-8?B?L3pFZ0YyUE5LU3o2N2tLMVpOK0liak12RmNhajh0R3Z2ckY0UVZxcFFONU4x?=
 =?utf-8?B?RUF0eVRCdi9Vb2kxNGhEdStqVjBvTGVBVEZEVGVLU1lBMWlwSjNDWHJaSExu?=
 =?utf-8?B?SzNQUFRtc2F1SlNGcUdCbjBxYmpsY05mWjdTQUdkbVpWL0lLUERDZ08zTGRp?=
 =?utf-8?B?RTlOQWdVbGdMd04yVjhlekk2VFdSdUdDZGt3M0lOQzBvYk1ucmRwdER4MUxT?=
 =?utf-8?B?cjFpSS84VUE0Zng3OW1RQzArQXhlL3J4ckRQeVIvdDZObFFodkNBejZ6cmZO?=
 =?utf-8?B?eEVDSXpabDNhQU1HTThjb1BFSVdWbTV4aUJtemhLUlNObDdhOGo5TFZXdFhR?=
 =?utf-8?B?aEZTLzBURU1nL1Y4OUVpRnJVdXdpd3lIdW9NVXBTbWUxb1Z5YXlPRThqelZk?=
 =?utf-8?B?SDZtRVBFUWZwbXBzZVllMUhabk9OaUovMlFEL3p6VURucTNtQzMzQk52OFY0?=
 =?utf-8?B?cGNtWnYwNTNkSnp5MGN5V2xKQklTTEJacHFiYUQ0dEFrbWlrNU4zc3hHSWRx?=
 =?utf-8?B?TzJLRHhuNGR3VXo1c25EVWlNUStZamdKOFBmZkp5Nkl0RzBGSTJqOTQ5cSt4?=
 =?utf-8?B?SWR0UUpjS3VNS2lyc0dSNjhBSnBlNUZXdE1pZC9hOThUWVlzSFR0TTcyNzBw?=
 =?utf-8?B?U041SWEvMmZNclh1d1Z1Q053bmhxNVN1YVhlY250VzFmZTI0c2NNOHpSYlVX?=
 =?utf-8?B?N3NGTnduN050V2hLUFc0a2M4VEM1QVRaYUFid3RsYWFRbkc0dVh6a2tocTNx?=
 =?utf-8?B?NjVFemF6UkZKWGFiMEgrVW9pVmU4S3A4UjV2dWduWTJZRGtscHZCS0Z0UjRF?=
 =?utf-8?B?QW5PN2tPY1dZVkU0dldHR2R3M2c0OHl6b1BUUGx0T0thZW52b0JIYnBhcy8r?=
 =?utf-8?B?UG95SXliUWp0Zkd3MGx1c0hhVFFUN0pqZjlpaDZ6OFNTUHd3NHVVU3BhMERG?=
 =?utf-8?B?cnBYVXlWNGw2WGN3TURSNUdVaEJRNXlDbGpHWG1lbWFmb29HSnlacGFUbFJh?=
 =?utf-8?B?MVdKTUxHUlJiUzMzeWZLNkJiR3dNYTlDVFRDcC95citENjVIY1JOUXRuaTVk?=
 =?utf-8?B?aGNRUWVxVU5uTGFkblVwelZ1VUdJZ2MrbDZRY0d6RTkzcm0zR1l3SnpGQ0U4?=
 =?utf-8?B?M3lsSW5HRnRYMGtBN3NjS05qRmlHK2JaelArWjlwWGlFZ1gxRG5GUEpsckxn?=
 =?utf-8?B?YS9JMVlNQkdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUxQRTR0MDJoWW9GT0FtNHovUE8xQmF2NHZKWUdxNUxYMzhzcUlXRmV3Rnk3?=
 =?utf-8?B?WllMRXBFRlBGYzdseUN2V1JyZjB5TjBocDFUdkVjeWc2VHMxSmdFUVFkVklp?=
 =?utf-8?B?SWRZd1ZYSzNlVnc1QUxmeHFyekJmaGJ2REZxUElhWUh0RXRpSDZKMzNjcmVa?=
 =?utf-8?B?T0VabWZqWWRZMVhpUEszZVNGWlIwQVNVbzFpYVFDRVM5Wm05QWRyNk1Dd3VW?=
 =?utf-8?B?NkZUNHlTUzFSOUpseVBQUUE3YXVVdWVtWUFKYTg4cDF1NG9HR2NNUC9scVIv?=
 =?utf-8?B?eDFFcSszeUxhdHVJSnY2TERxYS9uRnA4V0NGUmNjcW5OVm5WTEVTTVMzQWJy?=
 =?utf-8?B?UUhEM2FvcjVLOVVMUzErZTd2aHpGZkp3Q0Q1OHhLU05iZGNWL0xYa01lUENB?=
 =?utf-8?B?QTZGd0JweGp2WC9HbHFPQjhNYmhKRFRQNXNXNzdhWFAycGtkMXFtYVVGSnZv?=
 =?utf-8?B?NUgySzU0UzRSNnROdldXV0ZQcy9MZ2ZycXdrNlNLSTRiM0RHcXhYQTVsTjdB?=
 =?utf-8?B?Vi9CU3FMdExuZGxoS3NHTHRvU1dFTG1GeDNoOFcvSG1GUy9BTDNVT0JEbjd2?=
 =?utf-8?B?Wngzb3JDNFYrdHVmaElNdlR5VUNpZ0tuQVU4RE1mbGdBNGFYQS8vVlJTUlJj?=
 =?utf-8?B?eE5MN0NISUwzOGU2TlU4UXdLS1B2cURDRXZ4N2c2WlNjN2lCTkptN2FQTWZB?=
 =?utf-8?B?TXN6L1h1bHJOTUxUSGI3MTNTWHNrSmVFQTU3OVVyQXhka0JQblB4aSs4d3d3?=
 =?utf-8?B?RWJteVZlNjdwSStEY3h1dzc1SFBuclA4TEl2eUVjLzJ2MlQ1SW1ZdTQyTytC?=
 =?utf-8?B?UitsZUNDVEZhYTdYK1ZxNFM5NlphajdhWEhsQXNsWitSMm4zbGZjYlM2NGJP?=
 =?utf-8?B?Q1lTMi9vSTNOUHJMN2tUNEJpN1pJTUdsdHUweFJUWGdNL3Mzb3MrWlVjNks3?=
 =?utf-8?B?anB1UzI4NE9GWUkwbWtndGpkdmVoTnA0ZWV1NDZBbFhrNCtlcENoMWtHZzA3?=
 =?utf-8?B?c0JkeElmdC9qcVZVWFZOYmdic25tYnlUaGNLbmhWM2luaXJFb05iVnY2TDN5?=
 =?utf-8?B?K2toeElFVzRvSkt4TW16TlVldWMzTEg1cGVuOXRudlo3RWQ3R3pyanFPQ084?=
 =?utf-8?B?UmZ5RE9zWnV1VGhRVXhQalZHbCtBRXRxSmNJVi9CUGpmYVdjam1OUmlTMEty?=
 =?utf-8?B?ZmlOdmFMaEM3QjFLb2g4NXh6UFhPQS9NVTVnQTVaUDl0UUVzc014eW1USW5T?=
 =?utf-8?B?ZGlxejNrUkgyWFdJNS9yKzZFancxRnNnMFFUQXBZekNvdXBibDlKejBqRUg1?=
 =?utf-8?B?QlhzcEdDdWpwaFNSUWE5Vnh6OTZBWmVNdEt6ZmpEdEZsNmF6SXhnaXlaMW5v?=
 =?utf-8?B?OERqVmFTVFZJYThWakRFbE9IaWpsYzk3Yi9xRURtNml5SFZnN1FidnFuakc3?=
 =?utf-8?B?YUFRRXRRNG5FdDdEN0VrYk9aRUgvdHFGWTNLWnhsR3AwdTFDdTgwWUI3a0Y4?=
 =?utf-8?B?c2gweSt0bi91Rm9RN0JXaXBScXhmZzhzT25temlQa0w4alkyL2ljQS9OZDdI?=
 =?utf-8?B?VlMwWVVZRVZTdWFwd3dVV3VIV0lsRzZPRnREdGlQTHFkWjJycHZ6Q0xaVkV6?=
 =?utf-8?B?RXJVWGZCclh5QWR0bjMvckJXcm8zMkhEbUZldXpvek0vdThvYm14bFh3VWxy?=
 =?utf-8?B?ZzhwdCtWNnowUUd3U1BzVUdWeERpT1p1d2UzbXlHdCtrRUpWYmdiSk0ycjRN?=
 =?utf-8?B?SkU1MHV3VmRJaTkvSHpsbExnTXVqVjhzOU5IYUxncjByb3Y1a2M4T1poVUky?=
 =?utf-8?B?akgwcVZudUVwMldRK1oxS2pGMERPZ0pib3A0amowbi9kc3RING9YMnRkem0w?=
 =?utf-8?B?dnFaUThqazNieGl2VGxYaHJwbUlENnhWU0J3bXgyemorakUyWEV2MkNZT1I3?=
 =?utf-8?B?Y3lHRzg5bjRpMG9EWDdSMzA0VXVaT2JacTU1bDkxVGFqdURjbHpiY1NZc1Y5?=
 =?utf-8?B?dDI2SXplWGhkSU8zQmE1bWJMakhJRkcxcGI0VjlqLytpMVhzbVI5YXFLS0dk?=
 =?utf-8?B?VW9FeFM5UjBtMUJ5SE1HYTRrZW1VeVBncFR1SVBCRG1NdGFmMlo1SVViQWRq?=
 =?utf-8?B?aDhMenk5cVEyV0drUEgySytxdXhZMlplMk1wTDhYVVBmNi9pcXlOUXplL3lz?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <477F48A84CB02746A326BD82A566A87D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XXWu40Fj3PzTFupExlefoFXCiv68NfSJdp8K5VjpHeDxi4VF20zofsGthd9q0KCD33aHuigPjWLxm0SUFQHBBfFBFbNPNpR0YPXGa/ET0a89byXo9lc1jJA5ep/NuuWAgJeNd/YYPRqCPoZUO+2kxZPc7qTQ0QAX5Jx+wB1OqjyurlAwglm21EAxNbZdJxeimDoG9y5zLWp1b+gmqHEdsQBNXrM3kFrhVGR5LBboJ+kZj/Pv28dZsAYx/zwmTWv+pUO/qkWUXHQkTtFWQMnTz+sPdRja+M/K5I5XPtTGsJxCGJ8FGb2Pd1cxny7QfiGW3SyISt31o6BITlHDmiXYDM4MT0gd2hxtr1slzVWqY3sgSFKbvFQo6qYyUvhExSn52slGJrSrwIIrV8FLKk3ckYNeFVwntXpBzC7zFym1MI6jmejlOekHhRWA5nhmNhQZ5RaIeBy3AgZJHLCxgD0Ic2ajWIpKivDtEcss99PQ+R75dQRQM2payLE70dyxE6cAN+AosE5dqtYcvdWuauDJN/JsdEB949ylvYbgpP7fE6eD/jdTS7s4gVx5JbxOHOgYI8pmQuK6tV41eKnUTFGVo3tuXbKtZ1jKyoGwzvkMIWt5B5Jhr3BPPGEVcaSbUwE2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2300d6-b8b8-4c8a-782c-08dd9b353f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 02:38:35.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsiCl/Rb9Ta/FZ0TsOK66HxIpLaVEi1F0aW0XDm72h3TB5bFFbXU8xrHrKxzrwIo4v+hrVHqx/wMpXQgwTZfxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6964

T24gU2F0LCAyMDI1LTA1LTI0IGF0IDIyOjU3ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBPbiBTdW4sIE1heSAyNSwgMjAyNSBhdCAxMjoyMzowNEFNICswNTMwLCBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0NCj4gd3JvdGU6DQo+ID4gVGhlIGNhbGxiYWNrIGlzIHN1cHBvc2VkIHRvIHJlc2V0
IHRoZSByb290IHBvcnQsIGhlbmNlIGl0IHNob3VsZCBiZQ0KPiA+IG5hbWVkDQo+ID4gYXMgJ3Jl
c2V0X3Jvb3RfcG9ydCcuIFRoaXMgYWxzbyB3YXJyYW50cyByZW5hbWluZyB0aGUgcmVzdCBvZiB0
aGUNCj4gPiBpbnN0YW5jZXMNCj4gPiBvZiAncmVzZXQgc2xvdCcgYXMgJ3Jlc2V0IHJvb3QgcG9y
dCcgaW4gdGhlIGRyaXZlcnMuDQo+ID4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBMdWthcyBXdW5uZXIg
PGx1a2FzQHd1bm5lci5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0NCj4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+ID4g
wqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMgfMKgIDggKysr
Ky0tLS0NCj4gPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jwqDCoMKg
wqDCoMKgwqAgfMKgIDggKysrKy0tLS0NCj4gPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWhvc3QtY29tbW9uLmPCoMKgwqDCoMKgIHwgMjAgKysrKysrKysrLS0tLS0tDQo+ID4gLS0tLQ0K
PiA+IMKgZHJpdmVycy9wY2kvcGNpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKystLS0NCj4gPiDCoGluY2x1ZGUvbGludXgv
cGNpLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAyICstDQo+ID4gwqA1IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWR3LXJvY2tjaGlwLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZHctcm9ja2NoaXAuYw0KPiA+IGluZGV4IDE5M2U5N2FkZjIyOC4uMGNjNzE4Njc1OGNl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9j
a2NoaXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9j
a2NoaXAuYw0KPiA+IEBAIC04NSw3ICs4NSw3IEBAIHN0cnVjdCByb2NrY2hpcF9wY2llX29mX2Rh
dGEgew0KPiA+IMKgCWNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzICplcGNfZmVhdHVyZXM7
DQo+ID4gwqB9Ow0KPiA+IMKgDQo+ID4gLXN0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9yY19yZXNl
dF9zbG90KHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UNCj4gPiAqYnJpZGdlLA0KPiA+ICtzdGF0aWMg
aW50IHJvY2tjaGlwX3BjaWVfcmNfcmVzZXRfcm9vdF9wb3J0KHN0cnVjdCBwY2lfaG9zdF9icmlk
Z2UNCj4gPiAqYnJpZGdlLA0KPiA+IMKgCQkJCcKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAq
cGRldik7DQo+ID4gwqANCj4gPiDCoHN0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9yZWFkbF9hcGIo
c3RydWN0IHJvY2tjaGlwX3BjaWUgKnJvY2tjaGlwLA0KPiA+IHUzMiByZWcpDQo+ID4gQEAgLTI2
MSw3ICsyNjEsNyBAQCBzdGF0aWMgaW50IHJvY2tjaGlwX3BjaWVfaG9zdF9pbml0KHN0cnVjdA0K
PiA+IGR3X3BjaWVfcnAgKnBwKQ0KPiA+IMKgCQkJCQkgcm9ja2NoaXApOw0KPiA+IMKgDQo+ID4g
wqAJcm9ja2NoaXBfcGNpZV9lbmFibGVfbDBzKHBjaSk7DQo+ID4gLQlwcC0+YnJpZGdlLT5yZXNl
dF9zbG90ID0gcm9ja2NoaXBfcGNpZV9yY19yZXNldF9zbG90Ow0KPiA+ICsJcHAtPmJyaWRnZS0+
cmVzZXRfcm9vdF9wb3J0ID0gcm9ja2NoaXBfcGNpZV9yY19yZXNldF9zbG90Ow0KPiANCj4gWW91
IGp1c3QgcmVuYW1lZCB0aGUgZnVuY3Rpb24gdG8gcm9ja2NoaXBfcGNpZV9yY19yZXNldF9yb290
X3BvcnQoKSwNCj4gYnV0IHlvdSBzZWVtIHRvIHVzZSB0aGUgb2xkIG5hbWUgaGVyZSwgc28gSSB3
b3VsZCBndWVzcyB0aGF0IHRoaXMNCj4gd2lsbA0KPiBub3QgY29tcGlsZS4NCj4gDQo+IFdpdGgg
dGhlIGZ1bmN0aW9uIHBvaW50ZXIgcmVuYW1lZCwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1l
Og0KPiBSZXZpZXdlZC1ieTogTmlrbGFzIENhc3NlbCA8Y2Fzc2VsQGtlcm5lbC5vcmc+DQo+IA0K
UmV2aWV3ZWQtYnk6IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQoN
Cj4gDQo=

