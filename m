Return-Path: <linux-pci+bounces-2301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B4830E87
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CDA284541
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BC25562;
	Wed, 17 Jan 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U9H9gNtp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rs4wCfL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AB2555E;
	Wed, 17 Jan 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526508; cv=fail; b=INYkSugrQ4niIOehgMryaaB+2cxnpMaWQVJ6Brbdq7GJRRCrTdAQr3yn5ia+UEL+JAPi8va7JmLIMgnUzltJQXk3eBOiMyr9YJQw28xvldbE2sGuLQDAGeZRIjHQhVM8O6rHO7Hb+U4TEwuIcC1Ia/mfSf6fN4XUuwBaljZBVI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526508; c=relaxed/simple;
	bh=PKFftlMVsMNk1NQ8VfaCfwCFnOtaUUVPGm9KQ9AjfVI=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=IOVzrhWr+9WgjMy2Zb3SKU6cmXezDTCcBLNPcvXfRYwGwj7DbmAThTbp3E+KPHyCkGAz/AD/DZw+Dc/21u0+B0SOxjM1ALvtznIX1Hgwsdnm0RZGR3x5XiiayDhujth7zFDQUllQLEq05HZXGdYL3dthnrnQEgQluoq5Gx1J7Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U9H9gNtp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Rs4wCfL4; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705526506; x=1737062506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PKFftlMVsMNk1NQ8VfaCfwCFnOtaUUVPGm9KQ9AjfVI=;
  b=U9H9gNtpvC/pkBOyCW71deBiYh6M12C6J4zLPZ/H4NYnA3LvWEMyIDj0
   jifyxFu496y1AgVEBeoyCiuNw5zyu2I4kCCZyNnHLtaiNL1r7Mb5gNPRl
   FSZwQpmJBpABv1dAt/yrLDDqGB62TVVtKfCQKWpJVxKoR3yf6oz6RE0cX
   eYwMM4XafszCLKPy/RCkUWVw289tvypxpmNaAl4HCgPjE2CNHq34LA54J
   QaOcMM436HhXDkDxl7YxIa0x3Ko85koXK2KujRKPBaHluT3aMYi7pzRku
   nm2LVsO3NJaHcuRsjapSWPWs/OLalMbrWwTK/tP0bSrATsCSWNZo4PQCI
   g==;
X-CSE-ConnectionGUID: YX4dnCukR02S18Iy/J3ihA==
X-CSE-MsgGUID: /3dyYo/TS2GB096pU8Dx4A==
X-IronPort-AV: E=Sophos;i="6.05,201,1701100800"; 
   d="scan'208";a="7081523"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2024 05:21:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP1BlM+qlGlNV/xszRvNrYct4Ztjuxi6pRrhrj9qY3uQUTcgNDQeGSnLcORAsA2/8zbM7lcWmrenAUVvFkZD1k/qRSAC5dbDSTJeTlQS6OpBcFwvZpiqdZv6n0GZZM9r4/XsZ6oUMEJ0541jfjtUBU+YP07X3xj2Z/VcSNhcEk6rfDwS8fj22ZKycR6mi+P/2cNU4yliG1ThZ9QpSdknbtApo2+1QZFdneTriRvVSCK4KcPnhe/2AP2TzGut+MVQpSWWdTNikGLU2vNrf7RhOlpycQ2qmindh0KMJDppAHv9bYvu+upOy5lhztp9VmVKj78UkArLQZ5UlcczzTA4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFdhs7kMFZw4K6EK30mRLsP2/wEQWXuBVaX/mvsrULw=;
 b=dyNoIPQB/Ykt3/2sCRQurx42BjADLcAa0H8V3dGqW2oLIGpjxUJ8g3BN223iBRrDQUJj7q4e3QwFNiKhXsD7CkoxMs97cu0Hl+aLEGRSGzyINHou1NDH6GJWtDxmQblekE7BfaFUnQ7O94oCykqdvaxnFTkpc+Ezdn500ZF0xmQOBjJuSIrVW5g6aHoIkSZ+DALS89zI3tOAdDxqTCGzvKC5CoBp2mvWy/LKxH0h0ZHhp+V5UjELM5fZR7pY2LUmNwHsAq1T5Q6Qu0Jg90CZnB6DPYALmsmj+hjSRZ6TD65M1n8dWDtQ5GhFLWR0uv+d6wc+foburwMjfmRH38D40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFdhs7kMFZw4K6EK30mRLsP2/wEQWXuBVaX/mvsrULw=;
 b=Rs4wCfL4/6LcWzYujZy9iVqhyEmph4MVRS9pCOT4QPlm9DyYOOHxLMBvnmaVDgi71cNhfZRacou+SYzgU+k3EDaPXKfSvES1dEST2U8RYyhHq2iGxaikzodyvFdQStgmmYaMr0hibUwk7Xt9NA14Ba9XrSfD2iCpM/uNVZ6+seg=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by MW4PR04MB7155.namprd04.prod.outlook.com (2603:10b6:303:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 21:21:41 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440%7]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 21:21:41 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
Thread-Topic: [PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
Thread-Index: AQHaSXODJQL0XZUgYEa//+ZWpXISHbDeg2qA
Date: Wed, 17 Jan 2024 21:21:41 +0000
Message-ID: <ZahE455neE3wPnHA@x1-carbon>
References: <3f9f779c-a32f-4925-9ff9-a706861d3357@moroto.mountain>
In-Reply-To: <3f9f779c-a32f-4925-9ff9-a706861d3357@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|MW4PR04MB7155:EE_
x-ms-office365-filtering-correlation-id: afc15497-e80b-4d1b-ced3-08dc17a24c45
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iHoqH5nJI1yuJIQbYBH7trarH+958196tCmlm7Un3NhUIOgMIKlgSQ5zfVayiiDD/H95sSK4mVmewOsZeisHWwzntFtx/j4B+KOxUGgX6qGHP6lfMdCKToFlqyrQKLc3WdNZYZoGJOQk7Rk1gW3KMEGbGJE/BOyUUjkqBW8XPo8HS+yN7SD2iuyVS7nzs2ctTzcKUluik4WMd1XDLPHbborCIgD2PNF0YaNZhMKVxCMYHxRHeqXstgTeg8TI8b5rt+8keknq9x8brV2slw4ywrFaN/Om5TBbLWCKTjFiO8TBDGlTRGQ6Ta1Kl8/h34A3Pm0z9HaMvUIQlN/P80oSOExgBJX6tdD3SmogffDuRLWigik+jK9yIsnSkYGDpWjY+HawiAGMPd7t+bcOcs6nDcN7jMpqa+oU/evhuJNe+JjhJ5aonWHpw65LJJQxL0jvVHWlmLnrh/ElfOqnaop3f1IWiBTrT86r9MRO3KuPIBSezcs7UNFQ2iHOUCHM3uPYqy0bSzaJcUv2Md04gW9DH6t7aFGnGvclJA8PHNbJhcnktXwR8LERrMMDwKBB8QwqvAFGeK5Q4axKyNI/gVhlp9aRXhKv4R7+eG5e5gsN5qEuTGkXqK3dKNRoaBpc6THG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(33716001)(82960400001)(41300700001)(38070700009)(6916009)(86362001)(38100700002)(122000001)(8676002)(76116006)(8936002)(66556008)(316002)(66446008)(66946007)(54906003)(66476007)(64756008)(26005)(91956017)(4326008)(5660300002)(7416002)(478600001)(6486002)(9686003)(6506007)(83380400001)(6512007)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ZmdZCxKuzbbSdGKhKc9hX+nhkqYQyMupwHe6PyvOVwxyFtacWmjDnh5AlO?=
 =?iso-8859-2?Q?9vXJs7QS8p+bF0/iZUYeBpKuffN2vLN/r3c66zSB9GK+Z2O6fNYFnDCxMW?=
 =?iso-8859-2?Q?jPCZjqxHUF7IUx3Y98LGl/YBchOfMc1b6n5fiT/a22SMpOIEILNf4qV7Qh?=
 =?iso-8859-2?Q?G8AVsrERWr1aS2H6yOJEFCLbZ0kuobk+XsLMzqDhDxRc4LXRFyBY+rgzuo?=
 =?iso-8859-2?Q?2jIFgxdzcVT1pAjolLo+7Gwra+obS3xVzsAGFS0howgNFKsSPGpS2QJKzP?=
 =?iso-8859-2?Q?MxyvhRUc+Bq9+900Y5zfnFUfNMjgLwtGNMtynWek0gJWPws4xhqdTd9BQ3?=
 =?iso-8859-2?Q?/alnXdEYd6p5CiUrUo8Xcyx6e8XnWHeXDB21MVYUCp2HkmkUNM0XliIi8S?=
 =?iso-8859-2?Q?ZfSDrR8+KaFPkn0p51pReKSZaqKNbxG6Q4W6Y/g8G8PD8uLWQrUcrhtq7X?=
 =?iso-8859-2?Q?wJaweqsaecvlnP/zRkR4HwsW8SprDvuGInoKkAskDvPUUeqmqCh4MjyHvO?=
 =?iso-8859-2?Q?ejsf3RndN7eLbrNNkUs0E4RzPnJzGZZThQVauW5n63jaRgJySh6CoVctLY?=
 =?iso-8859-2?Q?6OEQgC5UrDLP68my/UfcYu9ZTVmkuTGKLAB+3N1zr/KRgeoIbC+toPx6BA?=
 =?iso-8859-2?Q?DhFta+f4o6mkY3Xa4SbIbEPGAQ1K+A6foU12VANeypeTuakZO1X2unn/o3?=
 =?iso-8859-2?Q?4FRPr6WcnAwbib42hpPx6XQla3pqsxGuSn4FSrVPrudvBC25j8hzh+vdR8?=
 =?iso-8859-2?Q?4NLSwBIsJvnENkWXhjdaMMPr0YlZYvCBPdnHw/jPumEseOMxL3zGHpKEmK?=
 =?iso-8859-2?Q?QjmvrUHtxeZr38gwFDYbE0UFNqj5LgAk/OX+37zqqn/fCXLfWtFnqgfvYA?=
 =?iso-8859-2?Q?wGFsB3VdqNeZaXKM7jQQJyHgDTlIzqdqjLqYnsK/dQDX9SQygtVGzTD7i5?=
 =?iso-8859-2?Q?tTxytSWH1MLqk2l53OlcLloFP3qNjfGYIaOsDLC1JBY4bheHAyywBmLh4G?=
 =?iso-8859-2?Q?hZ1YhgPogPuLa33ggMnHKOiheIy9OiItlS1lGd0Z50tPb9RrMaJ+HpL/Sz?=
 =?iso-8859-2?Q?KXoDbxPJXDur6LdlbeXRX8L2x3T6dzMS58yrLnbU7gsMm4rOpd3ShtrBtV?=
 =?iso-8859-2?Q?pu03vFoEd1cICUmihAhENnnBgAiz8xvhDZmkk1H9tmdZN0hSwK7/U2Z7lV?=
 =?iso-8859-2?Q?h6xSGk9gEJf2xQyCuXzpXZ5ub5Ne0V6mnS+g6OtjiZYyBjz/5HuZ6pFbnn?=
 =?iso-8859-2?Q?C8KOQ0DVTEIABwDgG8hVgwO4IVo3lyVmQWmaOygiyony513O5fLyldkWUw?=
 =?iso-8859-2?Q?LzXUAGC8O7JnQxa5ZwtovH2tjh50cufn8BonqYiV6Wmf/UNsgQ/8YOQ/dn?=
 =?iso-8859-2?Q?CGmgYKHK3Su6JyQsUDqmFBcODXQwyEN7pTcBVLBgj1y2tkuamHRs2g65WG?=
 =?iso-8859-2?Q?VtE+h4Eh3ajliEWU/m21S7kXWNZzXl6ZLMgggMeCRGIpB7u6MqSSLR0pxE?=
 =?iso-8859-2?Q?3M093WdXBIsJyMXOi0Pm44rfoNmVzAPRWXc8L4LueHJ4AgYlEQF2aYIKZP?=
 =?iso-8859-2?Q?QuqS1R7FwnMT7+Ozg3cnU/9lF729xTy0gVIpDXYUxwVeVHjDwTG4sQFL5Q?=
 =?iso-8859-2?Q?jxRzsr40Fq/fKtTgo7sOcJlkhxih+MLhiH?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <A99151DF02266F4F91AD13020260F28D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8MqpvQ8OMDmQ6kHArU4x1H2DR0sKr8AAWDZ2uBAgDPtnEXVUeO8doBT4lFJfVnl2bs7vbEO6M3yDSDw/gyPryGidZrHt213T46xqQxAHyTHHYwum28qVyVDKPYzh9wqpguLCYf1jqNSZ/CkICMxiRu6imGBIBoju7msP9AK7h1XPAL4v4VIko1S7ewyo2NMeAdvDvPaz0Z2Grjk/poxiyHlLg78+vh6e+jBqEIBha6vUOJqqY608Y1Fddk/Z1SAVT9w0jKbjd1UDxGh5EJGTaP6g/Qo9qe5JcBvtaMGstssRV9nDKfJ24OxlAHDFLKXVKNTF1tPAF1hs47xl2C+8e5bKVUN+Po2gX+kIncIrJYqTHrfvrAPDG1YjJwH2w0CZCNnQN6vII/tkuJKzkhq9QXKrbWzE2L5s8rM6v0gSEVKow9cTT2KtUpEfJPsLCRo2u9V8E6iSxCKVZfKeqQGX49FgCIKj0hUOiz9UHb6GTtD1NlMX7iw9ExyxIRXJKq/wlHLQqvM9OU1P7OCSWGzcV9yCQSfDkED4kabGSqhO6ewEIwTQO2gASzrrzlzJec9f8TDui76J+gba/8Yw3ee2p8IKH0Q1CN+hoHMdT3v8U9st1D8tixBIQpElKOkSL4Wg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc15497-e80b-4d1b-ced3-08dc17a24c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 21:21:41.1445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfAWL0gFL1UTFQ7W73Qs8t/wBuCMYSWB7tTciJi7ukxs6O4vGvb0QqyEAjKw7kBOCK9vy1jNjBJzUo/hAz+Vaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7155

Hello Dan,

On Wed, Jan 17, 2024 at 09:32:08PM +0300, Dan Carpenter wrote:
> The "msg_addr" variable is u64.  However, the "tbl_offset" is an unsigned

Here you write tbl_offset.

> int.  This means that when the code does
>=20
> 	msg_addr &=3D ~aligned_offset;
>=20
> it will unintentionally zero out the high 32 bits.  Declare "tbl_offset"

Here you also write tbl_offset.

> as a u64 to address this bug.
>=20
> Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()=
 alignment support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> From static analysis (not tested).
>=20
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..2b6607c23541 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -525,7 +525,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc =3D ep->epc;
>  	u32 reg, msg_data, vec_ctrl;
> -	unsigned int aligned_offset;
> +	u64 aligned_offset;

Yet here you change actually change aligned_offset.

Since msg_addr is u64, aligned_offset should also be u64.
Sorry that I missed this.
I followed the pattern of dw_pcie_ep_raise_msi_irq().

I've tested my original patch, but the MSI address must have been in the
lower 32-bits.
Thank you for the fix!


If you modify dw_pcie_ep_raise_msix_irq(), perhaps we
should also modify dw_pcie_ep_raise_msi_irq(),
as it also has aligned_offset defined as "unsigned int"
and msg_addr as "u64".


Looking more carefully at dw_pcie_ep_raise_msi_irq(), it has:

u64 msg_addr;
u32 msg_addr_lower, msg_addr_upper;

and does:

	msg_addr =3D ((u64)msg_addr_upper) << 32 |
			(msg_addr_lower & ~aligned_offset);

So there is no problem there as that operation is performed only on
msg_addr_lower, which is u32.

However, perhaps we should also modify dw_pcie_ep_raise_msi_irq(),
so that "aligned_offset" is u64 instead of "unsigned int",
so that it also matches the msi_data.

That way dw_pcie_ep_raise_msi_irq() could instead look like this:
msg_addr =3D ((u64)msg_addr_upper) << 32 | msg_addr_lower;
msg_addr &=3D ~aligned_offset;

which is slightly more readable IMO, and will ensure that
dw_pcie_ep_raise_msi_irq() and dw_pcie_ep_raise_msix_irq()
are more similar. But I will leave that decision up to you.


Kind regards,
Niklas=

