Return-Path: <linux-pci+bounces-26648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431ADA99FBC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9E194629C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E10642A96;
	Thu, 24 Apr 2025 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ycl9jodw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="u0dZFs/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734719A;
	Thu, 24 Apr 2025 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466862; cv=fail; b=Yi1izkV0m+qa5g8Z8hUhh6oHqqRmkwEmhZlHg6zZBiQw4fbrDM/sx/9UepmHiic08szViLhEIv6eTXn2sz1v2DmnbqtmVieCNSyIOO3SD8wyIBb83Zv6pwpFit2Cpg+tu21AH+W7hCJI1Qpluw9uO8XUmU0TAqZtZ9D46/j6i80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466862; c=relaxed/simple;
	bh=2UPEp2WP0NTntDD2ZGHz7nFQdRJgktf2yUTUZuBLX/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7P3H8wVzkJ+LSguwFZe3Jsi5e/QQCGiedUVef/dH9kmEX8K0NYYznqWAxklZB3/XhcUNqjgCHslwuvPlnh4WLYLeEqUcL2XGZVu8J4tfW7jJGssx7H4GN5DnFGntfkfaeoyaJvJLjN9MO96hJZnaQZ4ny12VpOkkOdCLfYtJKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Ycl9jodw; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=u0dZFs/X; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NNB7Gv023620;
	Wed, 23 Apr 2025 20:54:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=2UPEp2WP0NTntDD2ZGHz7nFQdRJgktf2yUTUZuBLX/U=; b=Ycl9jodwCqWJ
	2bmxztTNFlTQtVjsnknrMFNSj+/ACinRjPwpiw+40bxCB3WlHNCsXZg4FrZ5O116
	o+DYVWswjp+g+2MNmrW7prxOc4X48ItgLfzeDVAquQ+Fs/rNzhb+/1ZZhotdthzB
	YoD8n08OULY8Aky6HiqXj/nCH7OQtgZsy0RWysjPgIs3q1HBdD1VgAqP5/YYTrE6
	Joel3AX3FHPbQSWXHumn9LPWukj2cZA5lHr+lag4cTjveBB3QcKJJ1+LAqgjzzOV
	tTtVlarvlWggu9a/Vozyrq9Xcowk9JtDU3GDvW4cS4jWBME83HgY298CVi1giqLn
	Plcr6SqITQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 466jjynvm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 20:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGHEjx0dHj4AzpQQNwt2VIVAkIVW+P7ensWe6zIiB5IyXcN93IZiKgmc9nuLYg5joftRRzYWpbOXbtYy1E9uUUnDZF8dxFBG5BZEihQVRomrW3/OOzbapzhyJi35ZEKdTnPONcmeoZgglgmEeQjvjbyp058zHySYPiKx3tf4a8i6y6NVOaMFaeKnsdgypSHfdP8cXHg/Q1ev/XBaY6cBpRGDsY79xwzIK3ZHgp7pxeOJLXcNT2pTMOoi4mBU7ht31D5uq77aIhZ2ZjmG2p13e/nZiMOeGnz6VLWbv5I+3qQ0N/e1563ZJ7Qpkg/qV3iMFkt9Dgj6xLiOBWG7E0/4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UPEp2WP0NTntDD2ZGHz7nFQdRJgktf2yUTUZuBLX/U=;
 b=jg8JDmek1GcP87pfRZpVfWfGPo+eyDIUzVnCkD1KcWZ/QAK9ioosyOnVw3XhR47aFMTWDLzL0YTp4rwokolhQt3DdbTir/BWziUrqlUDFy9Wb3WtAB23i0tZNpQevDqTrZO93Xg6bkDHrjx4XBCbrELnmJYllqOneNpGQB9jH/a4j3MiGB7uMVzGM8Kb62HhExYiLXrJGEqgNVJa13qXbM25zjc72q7qibLAF8PozKcCg5cFmEodOeljnVNUf5dLQTDd8HWj3RSHjlzZaAk1iBrOnPQPJ2A24T8pnI0eTUzrjcUsc7nu30e3G9EegICTPc+vrljJu8rYyW9A6PUWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UPEp2WP0NTntDD2ZGHz7nFQdRJgktf2yUTUZuBLX/U=;
 b=u0dZFs/XcQmcAPijZntqNVjdJT+YuJvkj+Vw218SOMNS7XPd3e8XQ9tPwc51rNQCeENakiFQ+b4A/IF4wu1Tpi1LCxgLx/AQaF2qbLWstyetkJbHsYZ6jusxd9IY5EjDHufqULJvOE9DshGZQSqN8YJt+R2gayRpzjqt/vBCodY=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA1PR07MB9181.namprd07.prod.outlook.com
 (2603:10b6:806:1f8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 03:53:57 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 03:53:56 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Rob Herring <robh@kernel.org>
CC: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP
 controller
Thread-Topic: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and
 EP controller
Thread-Index: AQHbqs2z8LAkUsD7cEi1IUkgIvKi1bOe6c0AgAOgkeCAD6msAIAAC/pA
Date: Thu, 24 Apr 2025 03:53:56 +0000
Message-ID:
 <CH2PPF4D26F8E1C6C03FA2110C5AF9045F7A2852@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com>
 <20250411202420.GA3793660-robh@kernel.org>
 <CH2PPF4D26F8E1C8ABE8B2902E5775F594FA2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <CAL_JsqLNteS0m_32HuCjY8Mk9Wf+z6=HBpM7Wv=zLVqNs-7Y1Q@mail.gmail.com>
In-Reply-To:
 <CAL_JsqLNteS0m_32HuCjY8Mk9Wf+z6=HBpM7Wv=zLVqNs-7Y1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA1PR07MB9181:EE_
x-ms-office365-filtering-correlation-id: bdd6c905-4cb4-451c-2bf0-08dd82e3a385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGREQjMxYU12N0VTT1hVdjRndzF6MHVsMVNwNGRsZG5mM1EvTVhMWUtMZjJp?=
 =?utf-8?B?bHJYZGJNUmZ1L2dPT01VOHMwaVIyTkxZcE1GdWhIVjh4QXBnM3lWZUN4aU9I?=
 =?utf-8?B?ZmhRTjd3UUd1ZFM1RE9mbUpFSnk2NG02WTRpL0ZuT0NBMzJlSldPN2FOaEhE?=
 =?utf-8?B?d2Z0alNTa0xlVDlvS3NLY1l0ak1zMjVBWkJQdFJia3hLQXVYeHQyVmFmVzNz?=
 =?utf-8?B?dCtKTHZhNTRUWGtaSnVPQWJkMHlpa2psUTE0VkxWTjdQUEc2b2pCdS9KNjV5?=
 =?utf-8?B?aFhycGlVZG92NnpUSWl6cGpHUVNqeGd2WHdKZEdCRDVPWU50UTZWeDcrMmRE?=
 =?utf-8?B?M2kvcHFZUEhhYkV4cFhUc0FJK3pqemI1T3RrbUZUcU9pTHh2dmZsNWgzY2ts?=
 =?utf-8?B?cVhXZHhmeXFyTkthSzEvdUhwNmt6ZldhYWY3NFg3QUJtSkhobGJkZGx6SE9G?=
 =?utf-8?B?SThCU24zTzBWaUhCR1pxUjB6NlR3cVlERmlFWHl4d01UM2xtcXJtTzhFMWQr?=
 =?utf-8?B?SHZuRHg0MHpQcTVpSFZ5MVVqRXpZTm05bFBzNWlsbWNiQysyYmVTc1Q5cHFO?=
 =?utf-8?B?TUhncGNDMWNNQmlHR3F3MnBEZ1UwVktraDdjTlVDWms2YlAwTTNEZ2Y1dHJh?=
 =?utf-8?B?UjNZNFI4eERmZlBtVHE1Um5BYXM1cGgwMm00L2JwcVhkOU9rS3pORTFmS0cr?=
 =?utf-8?B?UjB4N04za3RxR3hxRGVaejUwcmMrNlY4ajdwNTE5eHBodmxObU9KYzBpak1N?=
 =?utf-8?B?bDFNeUdnNXRuRzZ1cGJueTJ5czlPT2FLcFFMYW1MNnYreC9kTUdqaU9uejNW?=
 =?utf-8?B?MWxUUERGMHBpeTFabmpsQWs4bGVjeE1OSFVKTGxOZWVvdG5qM3pJU3doblFE?=
 =?utf-8?B?WmZGc1dMRThGeXRuSmgwOWgxTUZHVHRLRzdVVFlKZENiWWlLYk01dkRZR0dC?=
 =?utf-8?B?V3BCL2FHK1EyRHg0NnlNVVB0R3ZJclBlTEJlMGh6N1I5YTdsZXd0RG5QU3ht?=
 =?utf-8?B?MHAyWVE5dW5SN0ZRaW9jY2l6N0FLQXZpb0N0b0RRZUJ1WEhDaStocXBSb2Rx?=
 =?utf-8?B?Mm1kV1JGMVdhS0I2ZkdqUTRBTFZjelF1dFRFNzBaK1lSTm1SSTJ2UnQxdDdT?=
 =?utf-8?B?R2VGc0taSnZzcGdOcGVad21qd3RtSElIR1hOTWpLV3FCeDJBNmQyRWhhUFJS?=
 =?utf-8?B?YlhzUXhTaG5oL29zdGc0cXhzdCtsV1cvSStkc3BEYVQrM21DQ3ErR3RxKzBj?=
 =?utf-8?B?OVdCMnlxeXgyakZZNFM2Z2crei9Cb3poNHIyL2lZSURmckVLbmZGc0Y4dnBL?=
 =?utf-8?B?TkRwT2NhWTF2VG5Na1Z4REhTc0gzYVRhRWZIYUo4bm5oTWgrZ1dQUnNKTWRD?=
 =?utf-8?B?SEh3WHNRTWVRSHhzN0ZtTzVETXM3cFUzczFDV0REb1JFbGdxdVVDdCt5Skp1?=
 =?utf-8?B?Z3l5d3hXczZUa3R6Q0J5RDdXaWYwTXo5T1Y4MlhFRkVYNFIreDZhd25POGI3?=
 =?utf-8?B?SkFCT29VaEdUZDNiNk03VUxCVEhTcHhpTWVBUlVJdTRsbjYrR2FUOEJMOXBK?=
 =?utf-8?B?K216aGZIZjB0U2FhTjJqWE11NSt6cjVNdW5NcDE0VmZWcThobExIcmNwSVJt?=
 =?utf-8?B?WElFWlM0RkV5U2doV2I3MDVqOCtsaVJ1dTkyUlRBZ01yaWJrdTlpbnp1S21Z?=
 =?utf-8?B?YytDV3I3Y0NoYWJKQUdRaVdiWnBCUGZoNUNsdGlnY2xVZUNydktEZlRRSDdj?=
 =?utf-8?B?SFJ5cnJJWVlZb0MyKzk1aVlIMGM1SHVQZnFlUUx3S08vYm82NkRxTUM0QzJU?=
 =?utf-8?B?Ynl5UVBzSVlueDZDVVNDYlFNbkl1L0lZN3dDdVFSRWtXSFZpRVBYQUliRnVL?=
 =?utf-8?B?MmlMODFOVEtreVZxVW5xajVXd0s1L210SnlYMUNObG02OTl4N01qMEFYYkd1?=
 =?utf-8?B?ZS9hSjA2dGF3T09KTzZWa1BCNEJYck5HT2VUVXhEUEswdndwZGhkZkRBaUda?=
 =?utf-8?Q?2qnM/Ld16oQ6nSJv6DP0QEVVoiRz84=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDJBMnBzMmF3RlB1bzZ0N3U4NDQ4eEFRczdGaUJjWkJCc0NTTzdMalhQZ1h1?=
 =?utf-8?B?WHNQc0tqTmdJWWJoQ09lb1llaFN2NFZ4dXlkM2NZQ2VJb1dScG9CQnU4dm03?=
 =?utf-8?B?VEZIUDBnWk9FRURVRkJCcjZ4VnBPNkdBa1BaNnhGMlF0K3VtVzlzOWl2QUxm?=
 =?utf-8?B?djVTOGI1QVlkSEZqWmZabzlNNDF4Vmk3WHhHbGFIM1FTS2RVdWU5OG0xcXVm?=
 =?utf-8?B?Y3F1UEJiYXVobjFQRGFMUXZxSWRsQ2JZTXQ2VFZ1NnJuS0xBM2tzeERKd3Zh?=
 =?utf-8?B?VTVmbGppZnJTbFBmUWgzek5BMTJxQThwWUF2WWZCU3YxeS9jM1ZXeFFQTEF1?=
 =?utf-8?B?aHR2RmlyMjd3RUFmd3pZZUh6eFZ3eVd4Ykt4NWtqd1UrQ2RuWGFNTUl2NVlm?=
 =?utf-8?B?YXlSUTlBeWg0MmdmM001RHAzRm1pTjdoR2RiVDhzRW5uL0dXWjU0VllhL2Zo?=
 =?utf-8?B?YUk3RVRiNGZ4Y2pNRVV3YmtacXNMbkhxbDBGbkNVS1RITW55bWI0OUJDYXkz?=
 =?utf-8?B?VStuSHFlWm0vUThENDVIN2FIb2NyT3RvZXYxOW92TjRob1F2YjhjVmM3Snpy?=
 =?utf-8?B?M28wRHlPMUZEdE9CS0lhVWVMbjZkMGFsZlg1bDJGby93SEphY210VnVPNVow?=
 =?utf-8?B?TjM3MUJxdUx2enppZHVjRVliYlNkY2ZaanlEbjk4eXhJOFNRV2duSjA2c1Vr?=
 =?utf-8?B?QVNpU245RTBWVlNXSGFjdnhhOS96RTNqTlQ3ZjU0Q1FuZ0h6bm1xZUhnK0Na?=
 =?utf-8?B?MVJMNmQvL0FMaUlJbGx0OVpUNVdZNjhCVWVqMStkb0R6MThXeE1ueGl3eWRV?=
 =?utf-8?B?SElIUFNOMVhsVElZUDVEWVJFalJPSzl1Yy9sSzh3NXRHRjRzTUgvT3UvYVFP?=
 =?utf-8?B?V3ArQVpnNTB4WFVHYUMrRVJTYVhlNFpRenI3QkVidXpDaC9ZV1prbERKTi96?=
 =?utf-8?B?M2FmMG9ndHRmZDVPclg0enloN0x6eFBUSlpFUTk1WWNUYTJLd1BNR3pJVjR3?=
 =?utf-8?B?TGxtY2NaNkZLekZ6VUV6QmdIZlRRUVVyUVVMNllpc0kzU0M2L0RtYjlmdElC?=
 =?utf-8?B?bmtoSzJVTVBRWFhtMTcyLzZBQlFzWkE5a2N6OW9DQlFlNGRYTUt0N1Roa2VW?=
 =?utf-8?B?WElxL3prWHJZWWI0L3I3NmNFZWlHTlE1Sy81Y2tmc2N5dW1ZT3JlTldQOGxR?=
 =?utf-8?B?anZiUzB5dzFOUFRsd2FKejF2ajdCWGl0RjMvRzZsQ0h4RnhRa2FtWmJqVXBk?=
 =?utf-8?B?dFU1Snp6eGh4aE91bDU3SW84MjVCOHdXWWljTkFTcmpQYnNRbEhWTkhrTTNx?=
 =?utf-8?B?QXREMXFnS2tjVVVFSVB4eEUvSll0U2NuVGQrY3NJdUpEK1B5ZjJSNjNHYXF6?=
 =?utf-8?B?SzZ6SVN3L1J1NUZrYm94d0d6VWZvZzBzTjdaRG9uWUVGa3UxdDVWd21kYTRS?=
 =?utf-8?B?eHAxaS8vbjdtdVRtaUF1djdDRWVKeW5INzFIcG4zbTZiSnRqRVhmMGl1eUpC?=
 =?utf-8?B?emp0ODJKWnVMUTYxVUpIL0E0YThuWnhmY3I1WUY5a2RFMjFHcVpiZFBpSW9Z?=
 =?utf-8?B?VHpEeWUwRDJacUVSYjlueEZkbkdkc1BBbmx4YTB3MXVaN1k3d0xmOXplVWxv?=
 =?utf-8?B?ampPclNpeDVKNEJWZXVjaDVRSmRVTW9EdGJwWmljUUFwd1MwME90WGl3S1Zl?=
 =?utf-8?B?ZVlxd1ZDQUF4MEJDSmZ1MnlxdmtWU1FuSTRGUHYrUXpYdVNvY0QyeEJVSUxI?=
 =?utf-8?B?VWprQzRGU0VVREI3S3dydHBPNmROcVIyNE41dTNyblJZNjVBejZHUDE0eTRi?=
 =?utf-8?B?Z2NXNEl5dmJydWdzMjZ3S29kQVpSQ0hXb0J5aFR3ZXR4dXVGdEdJQ2cycXUw?=
 =?utf-8?B?RHFwWThCUkhsMHRSMDFMbE03RWhJR0VGL2ZHaE02eU8yNGkxdlpKNkl0S3l6?=
 =?utf-8?B?NkVneXdqT0x1MWxWcmx1MFhiNEZVdS8wVktFWlZINFA1dDRlQVVpMmdmcWxI?=
 =?utf-8?B?RndQMVE0NVN1NHZqR0w1K2t4TDQ4N0NJZWZGQ1paN1dCM3U5cWFpVHZVQkh2?=
 =?utf-8?B?NHJFcXJrL3J1c3Y2M2tySlg4TUNUU2wvRnEwUjhITFpvNUVCUDNlbzJqdDhs?=
 =?utf-8?Q?zU0Q13vGapJyQL0dxNbWw+RiC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd6c905-4cb4-451c-2bf0-08dd82e3a385
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:53:56.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALTzXZYuH9YmEeAbXCvGSMvMlQFrmjr3Q6wY1kKPHotRxCVh+U8ATdc3l/RDEuwHZgKPZ+3K6+2bfRooGD1cCtvvJYWoATA8ZkuWMPoC4Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9181
X-Proofpoint-ORIG-GUID: K7ghNsWE_kUQJSKaq3xUovKk8k-au9n-
X-Authority-Analysis: v=2.4 cv=bIoWIO+Z c=1 sm=1 tr=0 ts=6809b5d9 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=5zLFWSap8OjjBXErVoYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAyMSBTYWx0ZWRfX2F2AYOp6mLkH Alza3c23+O5r6qfnZQEAyXJxNf/jqo45XjZnmqI4UDn3FiP2FPeKu29h14s2VhIA1HcMoBZgKDl jTVSl8t/L47klxUkexckvKdkM3zXIp6jLvlhsm09QX6NDZ90v36xmJveutyfH4DNd1hN7PEMEZQ
 EHDV+LQM3PPcmF/KLihH3ubwNmSH4saZ22VX/E9ywa2DTsa1UprSHnCF83tJw6RHf7CvDDvnSxS zebs7v99B0FzqQKwCEXvDZzS0Hs4Au0MYjUcXVswsIKcY9TK/xhw8owNZgOdhaRqDkVziS12L4L EtqqrRGU32YaJS8TZhD9+997AE+WS/FHK9JIupMi+3cGakyCh067w89gHQsZST2iP/vzGDQJZRW
 dBnb/Uf7dOZLmF6Xt9WvzTEeiyBZJrQyv1/c+XbsYwyML7104RgrJw+f2iMPWCDpQTN6jqsJ
X-Proofpoint-GUID: K7ghNsWE_kUQJSKaq3xUovKk8k-au9n-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504240021

Pj4gPldoYXQgZXhhY3RseSBpcyBzaGFyZWQgYmV0d2VlbiB0aGVzZSAyIGltcGxlbWVudGF0aW9u
cy4gTGluayBoYW5kbGluZywNCj4+ID5jb25maWcgc3BhY2UgYWNjZXNzZXMsIGFkZHJlc3MgdHJh
bnNsYXRpb24sIGFuZCBob3N0IGluaXQgYXJlIGFsbA0KPj4gPmRpZmZlcmVudC4gV2hhdCdzIGxl
ZnQgdG8gc2hhcmU/IE1TSXMgKGlmIG5vdCBwYXNzZWQgdGhydSkgYW5kDQo+PiA+aW50ZXJydXB0
cz8gSSB0aGluayBpdCdzIHF1ZXN0aW9uYWJsZSB0aGF0IHRoaXMgYmUgdGhlIHNhbWUgZHJpdmVy
Lg0KPj4gPg0KPj4gVGhlIGFkZHJlc3Mgb2YgYm90aCB0aGVzZSBoYXZlIGNoYW5nZWQgYXMgdGhl
IGNvbnRyb2xsZXIgYXJjaGl0ZWN0dXJlIGhhcw0KPj4gY2hhbmdlZC4gSW4gdGhlIGV2ZW50IHRo
ZXNlIGRyaXZlciBoYXZlIHRvIGJlIHNhbWUgZHJpdmVyLCB0aGVyZSB3aWxsIGxvdCBvZg0KPj4g
c3ByaW5rbGVkICJpZihpc19ocGEpIiBhbmQgdGhhdCB3YXMgYWxyZWFkeSByZWplY3RlZCBpbiBl
YXJsaWVyIHZlcnNpb24gb2YNCj5jb2RlLg0KPg0KPkknbSBzYXlpbmcgdGhleSBzaG91bGQgKm5v
dCogYmUgdGhlIHNhbWUgZHJpdmVyIGJlY2F1c2UgeW91IGRvbid0DQo+c2hhcmUgaGFyZGx5IGFu
eXRoaW5nLiBBZ2Fpbiwgd2hhdCBpcyByZWFsbHkgY29tbW9uIGhlcmU/DQoNClRoZSBhcmNoaXRl
Y3R1cmUgb2YgdGhlIFBDaWUgY29udHJvbGxlciBpcyBuZXh0IGdlbmVyYXRpb24gYnV0IHRoZSBz
b2Z0d2FyZSBmbG93DQphbmQgZnVuY3Rpb25zIGFyZSBhbG1vc3Qgc2FtZS4gVGhlIGFkZHJlc3Nl
cyBvZiB0aGUgcmVnaXN0ZXJzIGFjY2Vzc2VkIGZvciB0aGUgDQpuZXdseSBhZGRlZCBmdW5jdGlv
bnMgaGF2ZSBjaGFuZ2VkIGFuZCB0byBlbnN1cmUgdGhhdCB3ZSByZWR1Y2UgImlmKGlzX2hwYSki
IA0KY2hlY2tzLCB0aGUgb3BzIG1ldGhvZCB3YXMgYWRvcHRlZCBhcyBpbiBvdGhlciBleGlzdGlu
ZyBkcml2ZXJzLg0KDQo+DQo+PiBIZW5jZSBpdCB3YXMgZG9uZSBzaW1pbGFyIHRvIG90aGVyIGRy
aXZlcnMgYnkgYXJjaGl0ZWN0dXJlIHNwZWNpZmljICJvcHMiLg0KPg0KPlllcywgYW5kIElNTyBk
cml2ZXIgcHJpdmF0ZS9jdXN0b20gb3BzIGlzIHRoZSB3cm9uZyBkaXJlY3Rpb24gdG8gZ28uDQo+
UmVhZCBteSBwcmlvciByZXBseSBiZWxvdyBhZ2Fpbi4NCj4NCj4+IFRoZSAiaWYoaXNfaHBhKSIg
aXMgbm93IHZlcnkgbGltaXRlZCB3aGVyZSBhIHNwZWNpZmljIG9wcyBmdW5jdGlvbnMgZG9lcyBu
b3QNCj5tYWtlDQo+PiBhbnkgc2Vuc2UuDQo+DQo+QnV0IHlvdSBzdGlsbCBoYXZlIHRoZW0uIElu
IGEgc2VwYXJhdGUgZHJpdmVyLCB5b3Ugd291bGQgaGF2ZSAwLg0KDQpUaGUgYXJjaGl0ZWN0dXJl
IGlzIG9uZSBjaGFuZ2VkIGFuZCBmcm9tIGEgZHJpdmVyIHZpZXdwb2ludCwgdGhlIGFkZHJlc3Nl
cyBvZiB0aGUgcmVnaXN0ZXJzIGhhdmUgY2hhbmdlZC4NClRoZSBsb2dpYyB3aXRoaW4gdGhlIGZ1
bmN0aW9uIHN0aWxsIHJlbWFpbnMgdGhlIHNhbWUgYnV0IGl0IG5vdyBhY2Nlc3NlcyBhIGRpZmZl
cmVudCBzZXQgb2YgcmVnaXN0ZXJzLg0KSW4gdGhlIHBjaWUtY2FkZW5jZS1ob3N0LmMgYW5kIHBj
aWUtY2FkZW5jZS1lcC5jLCB0aGVyZSBhcmUgc3RpbGwgYSBsb3Qgb2YgY29tbW9uIGZ1bmN0aW9u
cy4NCklmIGl0IGlzIGEgc2VwYXJhdGUgZHJpdmVyLCB0aGVuIHRoZSBlbnRpcmUgY29kZSBuZWVk
cyB0byBiZSBwdXQgaW4gdHdvIGRpZmZlcmVudCBmaWxlcy4gVGhlICJpc19ocGEiIGNoZWNrcyB3
aWxsIGJlIA0KMCwgYnV0IHRoZXJlIHdpbGwgYmUgYSBsb3QgbW9yZSBvZiByZXBsaWNhdGVkIGNv
ZGUuDQoNCj4NCj4+ID5BIGJ1bmNoIG9mIGRyaXZlciBzcGVjaWZpYyAnb3BzJyBpcyBub3QgdGhl
IHJpZ2h0IGRpcmVjdGlvbiBkZXNwaXRlDQo+PiA+b3RoZXIgZHJpdmVycyAoRFdDKSBoYXZpbmcg
dGhhdC4gSWYgdGhlcmUgYXJlIGNvbW1vbiBwYXJ0cywgdGhlbiBtYWtlDQo+PiA+dGhlbSBsaWJy
YXJ5IGZ1bmN0aW9ucyBtdWx0aXBsZSBkcml2ZXJzIGNhbiBjYWxsLg0K

