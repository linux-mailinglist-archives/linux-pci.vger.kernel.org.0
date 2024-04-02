Return-Path: <linux-pci+bounces-5519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F3894C44
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 09:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EB01F22FE8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D4374F6;
	Tue,  2 Apr 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OGRVl9Mb"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721802BD00;
	Tue,  2 Apr 2024 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041846; cv=fail; b=mqKQRSRGhtUjRSApE1+ltOAxv6/7D+EbJXPjF85bGWMl6a2ysXXtRZc0/QnGecA0RUQw1KyUSgaUv669nnknsrUgwpC1PB84l/aYsR6E4RB4MmFAA3EfThC9vvHKlRVTiu+T+QWRGAhcipCfcaOMPtJXoNJfvjSb8qW56BriamY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041846; c=relaxed/simple;
	bh=qjrkFvkkO8k20ZNgmDC5y/7MVLeljmbkQsIXyJOFCKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsB1mKl9ycZFhVtlMpJrr7bn2iivUJ/RI2Rc7dVM7Q5zNSBS7lwr5Tz6VYDyBnl+5MMD3UVds2Nb8OZdKmmo47emIALsdcwT0GVQDliaZp9/+2zkdvFX/nwNuawOynNgTtZA61wyftguF1ICOC8xvq0wZ+0AQYGS29FSFQ+zA/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OGRVl9Mb; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712041842; x=1743577842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qjrkFvkkO8k20ZNgmDC5y/7MVLeljmbkQsIXyJOFCKI=;
  b=OGRVl9MbRezUOHoGOmNB0yWsyyx6sSr3PCO8ofoICXL16YkIFNPwIl6I
   fmAye81E18kbud3//KeBiUC4OPC7G3jboQnkWni47YIKSWiPtQitS8tRz
   i9x7t45FuscI+GZw1fL3XVtHctGJYlCjOezJ9rew4DIMeOVGIFd7LI24e
   aEYFxmXquTZyh0lbWAbRxU+7UvesVtqgNfcd0KiCsKaUL7vwi9tWSoNxt
   TMX1EDAwbh97J6UKTbyKOdJnEq/i61Dj3F+IWHj8HsmgP0yrWgYnd5XCY
   bZTfwei8vBpwCDwh/5uum1bpnI0sMiBLJ4r9B2RgRmQcoTOeiYdV5b9Xc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="28678491"
X-IronPort-AV: E=Sophos;i="6.07,174,1708354800"; 
   d="scan'208";a="28678491"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 16:10:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryg65BA82CC0qB2GySEpJ6gzEWI8RZJirPI+6Mnot6Yn8Zeh0joeYmc08bZ93CGNshpUcSMYHYwhtDzkVWnmY6PFynhrkuJvFzgLx9XmS0EGcOWSHcW7RGxnK6gmvqrLPiO4+dfGqAuIe+n5338DtngVIsj+BdWpYdQ4yljxUtnkYe9ZaXyH5PCf+PzZjI/e9PMhEymu5KNgMm4QU+VcAx2ETO+i+8Zso2zzDIw3DqOgWVtU6O5Z9LrTgp40z6FUmfKL5SNNxnpabIv+3kfZ58TCMD1JFMTVYJo/HHJMT/08V0IFT6Cx+sSx4HfCwA2IQW+eN9kjpjPPv1XNeHuKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjrkFvkkO8k20ZNgmDC5y/7MVLeljmbkQsIXyJOFCKI=;
 b=LCwR6OUOBduBrM1JD655p9vK+y1xja9T86KRgEl2BE8VMVFGHhT+9AaMrK8LIywaq4yqlhhFy66c5uBgfOkqlmYAJBZdyftMjnhMxW0WIapT8Pc6sQUS98sMVB7QnK4EIRLlYTeA6YNM7LUjg8KsuU4u/Bx1J8WQPRIrN1zMga1JKLOcz9D7pXMo91Hju5dcC8ChIMr2VnwTw6M89CYzYrIvwdmSQYQWuApmDYzXKLKDNY2cTseux6UBfkUGbVclTKUqFeZr5LNOVpDbgE6C4R6ZgFKEXycXHxs150ii16nDKptwmCfdQnO+j14T52EvrMSgisFRdmW2T6yQTAvw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSZPR01MB8562.jpnprd01.prod.outlook.com (2603:1096:604:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 07:09:32 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 07:09:32 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>,
	=?utf-8?B?TWFydGluIE1hcmXFoQ==?= <mj@ucw.cz>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Thread-Topic: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Thread-Index: AQHadFPEocvhHDRYFkS2dWSvCFH3ObFPZsMAgAAwD4CAAY8jgIACqp2AgADbMfA=
Date: Tue, 2 Apr 2024 07:09:32 +0000
Message-ID:
 <OSAPR01MB71826AD4234E0ADAACD1FFE0BA3E2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
 <mj+md-20240329.221545.11188.nikam@ucw.cz>
 <660767abc418d_19e0294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <mj+md-20240331.010245.99093.nikam@ucw.cz>
 <660af31b8541e_15786294ae@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <660af31b8541e_15786294ae@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZjFmYWIxYWYtZDA4OS00NmM1LThlZTMtMmZhODAzZTk2?=
 =?utf-8?B?MmNkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA0LTAyVDA2OjUxOjQyWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSZPR01MB8562:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FAOkZsch/cpyT6iNGFZYH88bSnR4PXcIM90r0wIe7bqCXdu/5PEtHdVh5UpTYvfmbV3Fonp+yhi8qTjVvYoHZdoTlPeqzSXjjmVbFty8f0PAADm2CfK287FLoV6WGvGh7CN2NTlsqyRIIomxwLBZCS6+fhjcQEM7DAn9kIabxCkZDFfboo5n6lKbOSjOYQqrgX8Xk1tQztXwbH1Y9VaQK4p29ZpiPc4wEvFiRnb4v2mIQAvs9lam4yYMUteaG6ywXLTYtp2uyTyixHadkoaSM3QJNTceERnSrH+Ro8kJROQ8xqHlrFxLiabEg9C8pIC9TrEwuLCISVoAy/0QXQCztnVnulRoxCSn9ikMbevJ8ypGqBg6DeGJ5DMbT/hS6RJJ5lhap+wgvc1Ir+AE2Il5pwYmfhII+qPNSoebqVjrfGyBjTQ5abv/o4IeYO7yec4IuVZlA24u4+7kOTCxQtmYDfd0UN3dN+xCaWqWboFlpdRvvq686Sp1rh8bvMedTiQ/329Xzdt0MN+QtSDlBLgcgPokqfBTWAtW2M2umlOSy7hU+kLGjJ97tZcmS125CycWjE3svT2+7AcIwrN7nKJj5IbALJdyrz7Wcri/ErPuN4KeVnk4Sg+hzHduSq0V+TR6Olz/M1M+GECAXMNd7uFe/DkF+w5urL1kJNGX8XT9GGcANDQ0ivpoqaMlYYQNegxqwe8ebhirKCtY7Mql+E4LTQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z29wMk9LTmRPZmpjY0dLd2l1SzlpcUh0R3hsSjhLYzBOQ0tWU0kzWDloNFBM?=
 =?utf-8?B?YVl1VnV0amRaSWRndFhhNFZqRVRtWTg1Zm9EQ1FwY1IveHVTZDlTSDRZNXRI?=
 =?utf-8?B?TVIwTGNNa1hVeWp4V3JXS2x2NmR4bDNOd1crM1J5eE05L1M2YXB5M0J3VEZr?=
 =?utf-8?B?MG1YQ21zMkF4K3JLUHBvZjd1Sk96clpIWXBuRm01cm5jM2hOZDIwb0g3eU5P?=
 =?utf-8?B?MmVhYkQ1cE9XN1NkMVlrRC8rY0RXd0I0cm4vWGJDQW03LzlTQUpUVkRiWDFs?=
 =?utf-8?B?SlBiYXBWaXJPNUh0aDluc0xRNCs2eTJVSkhVZ2ZPM3RrSnZ1MkRxVjJSaHNQ?=
 =?utf-8?B?QW11R0RxbXhlei9QQnIxYnl4V1VyVndrbHBuanNWTUQrU1BNUUdDanNYaXBP?=
 =?utf-8?B?VTd0bHZ4VHhpQ2FiZEJmVmlnS0Z6amdpNHAwZm5vd0FTdFVBS2dtZEt1Tjd6?=
 =?utf-8?B?TTF2d0tUY29wL0JCZmZVbTJIY2pYOVpWdmlYZjMxYnlsN1NjM3llRUtXUmJG?=
 =?utf-8?B?SkJkM2YzKzJZdEZjaHhPWWwvdkZJNHZDdzJkeHVWZEwzbys5Z0M5Q1F5Zzh2?=
 =?utf-8?B?MllDR1VmKzhnSVF4U2xaVkZ5a1A0UXNnbHBPeVROdzh6ZHE0ZHoxaWVtYS9S?=
 =?utf-8?B?MjAyT3lRY0FYVmN1cEdPdWFoSFd6RU1MZVkzd2x0bjRtQTB6LzZkMGdKbXBy?=
 =?utf-8?B?bE85Q1hpK2ROdzdySGpUemwwalg1RjZyelhPelRyUXZlTk1zMWpWQlJISXNZ?=
 =?utf-8?B?SGt3eUhDeFJIeXdnNCtpTmRteUV1Z3Vaa3cvQzU5STgzZ3ZOby8vaHQwbHgv?=
 =?utf-8?B?NVBScXIzUGZQMDM0SmNDZkNibEF5emI3UmxPdGxMR3ArYXlidnJPbE83K01u?=
 =?utf-8?B?dVZRNjdrakl1MktVSlFBbnQ3ejhoNW9IUTRQMml6aGZLKzMrS1pMWWR1R2FO?=
 =?utf-8?B?WEFkTjZ5UHF1a2huc041ejZjWXY3YkIySElaOTdDbTJvQ0xxb3lXTUJtNWhs?=
 =?utf-8?B?R2tHSWwyQVN2M2NPckplaXdpdUxoS1R2eTVpZFoxb1l6elZoMHhuZFd6Z0VK?=
 =?utf-8?B?ZWtKUE9ibitFREdjekt6Vk1Rd0hCVHF5NGY1dG1teFNrVWVxQW95SzFWWjV4?=
 =?utf-8?B?d1RpQVM1eE9YdjhNQ2wxZWF3OFNtZEpDdUVBWlZISU14czdHMnIwNWRjYkk4?=
 =?utf-8?B?dDc1UjlsblVScTZabFQyNm9vQ3JYT2hJQmRCVjVEbVRqT0VKdEdOTnh5RzVy?=
 =?utf-8?B?Zy9PRy9DUS81OFFqNTdyM3JVRUhsNzFhWFVtREtMbTlUWHJpZzlTTDlWcmxj?=
 =?utf-8?B?TnlGTzJYeUR3SWQ1cnZNYlFSRTFka29YNXk0VW9VK2tGRTlRY3ErVHBOQkxo?=
 =?utf-8?B?U3BKTmJFR0luSW4xWkx2SXJvMEI3RnFXcFExamhkaWF1bGx1THFTeGNvMGhu?=
 =?utf-8?B?UUdBaU1ROUVrQThVK1FXRmRPZ1VBY0tpd1VtM2k1UjF6dFBmdm9mVEZmUDZk?=
 =?utf-8?B?djZpbU0zWXJpaHZEZTBqWWdkeDd0WW9vSzFwYUxtamIraE9FbmNjMmt0YzVX?=
 =?utf-8?B?VzNjTGNjaVJRMnpMd0R0ektTckJWemVBM0haWW51RDlBRlVycEFRTndweWNO?=
 =?utf-8?B?OFQxWjNRandJdlpkS1RwZGR1QkRoeEJFNUNPT1BLRXg4ZlNSUUw0ZlZsVGtX?=
 =?utf-8?B?M284bkl3dnZ5ZnNGY2IrYXUxa2p2bHg3Zlp1UVFMUy9tdjYrTm53YXhNbG1E?=
 =?utf-8?B?Q1lTY1ZVV3hlN2Z3Y2xBUVVFQnlVTndnOHpIeDFkS1U5S0ZYdXEwVHJDOE1s?=
 =?utf-8?B?SG42d3YxcGNyWWxocEdXSGpFeU83dHN1d1FFZFhJd2xIVGZKaVpBUGFULytO?=
 =?utf-8?B?WkhNc25wNkYxdm50MEovRE1OUk5sQ0Y3Qlh2dHhOazhIU1EzMm10RkNGUHRQ?=
 =?utf-8?B?L1VNR3pQcURnWlZ1M3pBVjlFK2tQUGp1cm9VUG5VTnNQREw3aktScjlzWjMw?=
 =?utf-8?B?am5oYTZiVW5PcGs5dFkzUzVONXpCQ1RLTldrY2dJWmZBSDNQYzlHY2F5NFpz?=
 =?utf-8?B?NmxFL2xtZEFiM21NQkFXVlpYTjRHSk1icjNDR21YV2ZEUVAyVUh4Y1dweFlJ?=
 =?utf-8?B?ZFVIdXdRcUo0V0xIbWN3UDBSMlNLbGIrNUpNSmVJbWI0YUFyajFqUVNyQnVt?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JIAY41fnElOAArCT3UTVLI1wd1dcHhGdf6AT8VYkkO1WDCF3zu1ecYGlrQEnVWVjOTG1ivU/jWYxDv/dW6To6N75xHxY8xaQCFo3ACfaokaC1EWOgw4jMZ5uGCara6TCuJprp7xxq7HkrIrP/PW3oqcQSj/Pfls0RWPu+/aJa9JJTYSnN1egvojuP2bHyy8wWieamBqfV7oIwIyf4d9m0UCT7vAFAzAF0bk7N0Cfson+xawCs265TMK0fcS3iBlapxj106lslux8GNJ6KFETnnPKeTkWur0etS4JEVblFeY4bOwnXvEwph/yFQsHnZbswE9FT1KAJjGu6ShSSUo4WADxIA1RmmMp0cx8Z0cRX6+oWOCiXnd0Pqv5ABGvYqk9w9Rf0KfoFNl6EIiOTVGGH2dE9WTJALv0enFQmOBunoZuB1VaMccNTpShwxNObgDPVregCGNLVcrvUdQbLSwLipxIQ09gMw8XiwYXeyeSwsQ0KJLjqRQRcjUqV0EuqkDdbEFsA//c2vxSwJhOaS+pxQ7vrqM6ZV0togLvIkfWcugY1s1tWKXV4CakTb7lQB/LI47QPIYWyHvt/keJKt2FIm/RBPI0c9XBdghB1mPFyanmXrpdbsk0ZS+3hreKwpy0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93976ed6-f56e-4cc7-247f-08dc52e3d872
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 07:09:32.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pptwp8Qdb368KjL8cgEEnKL2kPIdlq8JodTnOBrJjR09GjW3nITFoyUILnAdJPLINWIw262DgtrSMVZdhCuW73y/66/2J9tWQAxigLt4GrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8562

TWFydGluIE1hcmXFoSB3cm90ZToNClsuLl0NCj4gDQo+IFRoaXMgcmVhbGx5IGlzIG5vdCB0aGUg
cmlnaHQgcGxhY2UgdG8gcmVhZCBmcm9tIHN5c2ZzLiBUaGUgbGlicGNpIA0KPiBzaG91bGQgcHJv
dmlkZSBhIGJhY2tlbmQtaW5kZXBlbmVudCBpbnRlcmZhY2UgZm9yIHJlYWRpbmcgdGhpcyANCj4g
aW5mb3JtYXRpb24gYW5kIHRoZSBzeXNmcyBiYWNrLWVuZCAobGliL3N5c2ZzLmMpIHNob3VsZCBw
cm92aWRlIG9uZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGludGVyZmFjZS4NCj4gDQo+IEkgdGhp
bmsgdGhhdCB3ZSBjYW4gZWFzaWx5IGV4dGVuZCBwY2lfZmlsbF9pbmZvKCkgYW5kIGFkZCBhbm90
aGVyIA0KPiBQQ0lfRklMTF94eHggZmxhZyBmb3IgQ1hMIFJDRCBwcm9wZXJ0aWVzLCB3aGljaCB3
aWxsIGJlIGF2YWlsYWJsZSBpbiANCj4gc3RydWN0IHBjaV9kZXYgKGJld2FyZSB0aGF0IG5ldyBm
aWVsZHMgaGF2ZSB0byBiZSBhZGRlZCBfYWZ0ZXJfIGFsbCBwdWJsaWMgZmllbGRzIHRvIGtlZXAg
QUJJIGNvbXBhdGliaWxpdHkpLg0KPg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQpJ
IHVuZGVyc3RhbmQgdGhhdCBsaWIvc3lzZnMuYyBpcyB0aGUgYXBwcm9wcmlhdGUgbG9jYXRpb24u
IA0KSSBhbHNvIHVuZGVyc3RhbmQgdGhhdCB0byBleHRlbmQgaXQsIEkgbmVlZCB0byBhZGQgY29k
ZSBpbiBwY2lfZmlsbF9pbmZvKCkgDQp0byByZWFkIHRoZSBzeXNmcyBmaWxlIGFuZCBhZGQgYSBu
ZXcgZmxhZyBhdCB0aGUgYm90dG9tIG9mIFBDSV9GSUxMX3h4LiANClRoYW5rIHlvdSBmb3IgdGhl
IGNsYXJpZmljYXRpb24uIEkgd2lsbCB1cGRhdGUgdGhpcyBpbiB0aGUgbmV4dCBwYXRjaCBhbmQg
DQpzdWJtaXQgaXQgc2VwYXJhdGVseSBmcm9tIHRoZSBkcml2ZXIgaW1wbGVtZW50YXRpb24uDQoN
CkRhbiBXaWxsaWFtcyB3cm90ZToNCj4gTWFydGluIE1hcmXFoSB3cm90ZToNCj4gPiBIZWxsbyEN
Cj4gPg0KPiA+ID4gPiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gbG9vayB1cCBDWEwgUkNEIGluZm9y
bWF0aW9uIGZvciBhbGwgUENJZSBkZXZpY2VzDQo+IG9mIHR5cGUNCj4gPiA+ID4gUENJX0VYUF9U
WVBFX1JPT1RfSU5UX0VQPyBTaG91bGRuJ3QgaXQgYmUgZG9uZSBvbmx5IGZvciBkZXZpY2VzDQo+
IHdpdGggdGhlIENYTA0KPiA+ID4gPiBjYXBhYmlsaXR5Pw0KPiA+ID4NCj4gPiA+IEkgdGhpbmsg
c28sIHdvdWxkIHRoaXMgZml0IG1vcmUgbmF0dXJhbGx5IGluIHBjaV9zY2FuX2NhcHMoKSB3aXRo
IGEgbmV3DQo+ID4gPiBzY2FuIGZvciBEVlNFQyBjYXBzICgiUENJX0VYVF9DQVBfSURfRFZTRUMi
IGluIExpbnV4KS4gSG93ZXZlciwNCj4gaXNuJ3QNCj4gPiA+IHRoZSB0cm91YmxlIHRoYXQgdGhp
cyBuZWVkcyBhIERWU0VDIHNjYW4gZm9yIENYTCB0byBrbm93IGl0IG5lZWRzIHRvIGdvDQo+ID4g
PiBiYWNrIGFuZCBmaWxsIGluIGRldGFpbHMgdGhhdCBub3JtYWxseSBpbiBhcHBlYXIgaW4gdGhl
IGJhc2UgUENJZQ0KPiA+ID4gY2FwYWJpbGl0eSBzY2FuPw0KPiA+DQo+ID4gSSB3b3VsZCBwcmVm
ZXIgdG8gZGlzcGxheSBhbGwgQ1hMIHN0dWZmIHRvZ2V0aGVyIChpLmUuLCB3aGVuIHNob3dpbmcg
dGhlDQo+ID4gRFZTRUMgY2FwcykuIElzIHRoZXJlIGFueSByZWFzb24gbm90IHRvPw0KPiANCj4g
VG9nZXRoZXIgd2l0aCB0aGUgRFZTRUMgY2FwcyBkaXNwbGF5IG1ha2VzIHNlbnNlIHRvIG1lIGFz
IHdlbGwuDQoNCkhlcmUgaXMgbXkgdW5kZXJzdGFuZGluZyBvZiB0aGlzIHBvaW50LiBQbGVhc2Ug
bGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYSBtb3JlIGFwcHJvcHJpYXRlIGFwcHJvYWNoLg0KDQpC
YXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nLCB0aGUgaW5mb3JtYXRpb24gd2UgYXJlIHRyeWluZyB0
byBkaXNwbGF5IA0Kd2l0aCB0aGlzIGZlYXR1cmUgaXMgaW5jbHVkZWQgaW4gdGhlIFBDSWUgQ2Fw
YWJpbGl0eS4gVGhlcmVmb3JlLCBJIGJlbGlldmUgDQppdCBpcyBhcHByb3ByaWF0ZSB0byBkaXNw
bGF5IGl0IHdpdGhpbiB0aGUgY2FwX2V4cHJlc3MoKSBmdW5jdGlvbi4gQnkgY2hlY2tpbmcgdGhl
IERWU0VDLCANCndlIGNhbiBkZXRlcm1pbmUgd2hldGhlciB0aGlzIGRldmljZSBpcyBhIENYTCBk
ZXZpY2Ugb3Igbm90LiBIb3dldmVyLCANCkkgY291bGRuJ3QgZmluZCBhIHByb3BlciB3YXkgdG8g
Y2hlY2sgdGhlIERWU0VDIHdpdGhpbiB0aGUgY2FwX2V4cHJlc3MoKSBmdW5jdGlvbi4NCkFzIGEg
cmVzdWx0LCBJIGV4cGxvcmVkIG90aGVyIG9wdGlvbnMgYW5kIHNldCB0aGUgUENJX0VYUF9UWVBF
X1JPT1RfSU5UX0VQDQphcyBhIGJyYW5jaGluZyBjb25kaXRpb24uKGN4bDMuMCBzcGVjaWZpY2F0
aW9uIDcuMy4xLjIsIDkuMTApDQpGdXJ0aGVybW9yZSwgc2luY2UgcmNkIGlzIGlkZW50aWZpZWQg
YXMgUENJX0VYUF9UWVBFX1JPT1RfSU5UX0VQIGJ5DQpQQ0lfRVhQX0ZMQUdTX1RZUEUsIGNhcF9l
eHByZXNzX2xpbmsoKSBpcyBub3QgY2FsbGVkLg0KDQpBbHRlcm5hdGl2ZWx5LCBJIG1pZ2h0IGJl
IGFibGUgdG8gY3JlYXRlIGEgbmV3IHJjZCB2YXJpYWJsZSBmb3IgcGNpX2ZpbGxfaW5mbygpDQpp
biBzdHJ1Y3QgcGNpX2RldiBhbmQgbWFrZSBpdCBhIGJyYW5jaCBjb25kaXRpb24uDQoNCg==

