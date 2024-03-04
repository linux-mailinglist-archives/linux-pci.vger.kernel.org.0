Return-Path: <linux-pci+bounces-4382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD89D86F8D5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 04:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26151C2099B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 03:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48803211C;
	Mon,  4 Mar 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OcUsCY8E";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JHWTgqpp"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD3A59;
	Mon,  4 Mar 2024 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522361; cv=fail; b=QkguKPw8wbRhfiRJcC+4ycXca12ZYCiDrbmA7FtHsRr6A5cR18Bt7LQrX4YxulIiIdM47NytQdbjIKXE/VzLWUNBy/hP9NHerbcyxLFcaZoLK2Hp2qwwQO9ll/aF9ie2u0ovi9DbZrvXcvnIsjgJPsIysfcU7J1RoiB5WWqr6X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522361; c=relaxed/simple;
	bh=1Yrpt7uLp4/mmwjODyksQb9FmJFTtOM09wO4ZxIjhOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6HNy2GZTHrnATmyXWinx5FDdkt3H2qVH47N/d04cssvsYcajwXhKtl0P6C4hJoLfDHOXCHy+z1ix4Zc38muK1okfu33wl49vraFoSJdPEomdTH9wHDyt47I5WtPTuVQTcDBRUhxFnosrFlWUNjLQLhC6xTlLEUkT+HzJrEVGmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OcUsCY8E; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JHWTgqpp; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709522359; x=1741058359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Yrpt7uLp4/mmwjODyksQb9FmJFTtOM09wO4ZxIjhOg=;
  b=OcUsCY8EBaynaO4C6oIB09EsJ4awLpyQIlMFk5uHiR5PI8aP20Xp4mLz
   CX+Nb1JENtW/RNwucG7QqJ9KwKKi2zTiuyVjY1D9UbVbc8fWxiNti9lG2
   aNentw1uVVd4e9xuUokSoffcPm3V4jB7QifayHHWFGfYe13v+0bHz0Vb/
   Rw9Ri1czIwRBI88NA6XTCYroyxYeXSN9StvpCcwWwSrz50iX8XpRx9urC
   YoafED7/4v31hwl/dDI26bKnCWtUzc1UVz5ejOlNn1fwuFV9Hwa2kkhA5
   WN4hntfjgAWtq2jlJitm9dNPPewpYcSHJes1S029HyBMHLA8F00PzSm1g
   g==;
X-CSE-ConnectionGUID: XvjBJO0fRgmLnB61QM/DPQ==
X-CSE-MsgGUID: LY087H+uTkOGHpzYaPfd5w==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11303583"
Received: from mail-eastusazlp17013024.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.11.24])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 11:19:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTp8A4Jmb8UjJI0OkcgC1/lFBYRuFub9ZYhJhKKJDXGJSDJA+a8rECwNC1dgYqguAxj1PU+dzlWdCXl2IRB4nybgQNmRBaIgvW60edguA1U4jwlF/xdt7Uc6e6TdM2zn/j4u7wtAcEPR11WFTqhrENbbwmxlmwrAhllAZ4G8SgG3jSel/95OnPsUD5Uu9EcbqU7XARNlHEpBYh3Ek/+zHyEe8PGKZHFONTgzR3JL8MBc+Tt0QJuTTZ1SuhKXcPLjSwFd9b4fgrXC3rkBCppRcsocic4qG34DcoO6vmn047et2W0Wn8sZyEn36/zjz0I4p2bQvsjqQjYoZSqc73B36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKEAI6Ud/zowf16iKCTN9/JsYzQjWQ2VBW7icrCAeww=;
 b=Z/1wN3vz/GwG6s0TaYyhhcjDzp9x/0uN3adOf/i29A0zBobzk9gS9lIS/i1ESJPjMoH9W6A9/xVqLZDje84CYkbjHWXit9TWBfgT/WieF2oUPQAw4Mm5ZqwCHVwHHjy2TogTkRIySaB77aJkYiAa4fS56UCrSAcpv8ZfV0ndvmXBqgYYo3o5KuDRKDPlDMb0VvFW1l+QEtujLARIY5AMzD4lK8MLrkGvksdiJAKwaHbaCF0IcnPnh0FIR2zYmXi9yILmZa0bCAc0bA8CnOMZa+q6Xtg6OEhLDmcJBQs++rDK2cqfX4jtQmEq7tdiQCLNsQb0UHdtX+Li6m11fuP0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKEAI6Ud/zowf16iKCTN9/JsYzQjWQ2VBW7icrCAeww=;
 b=JHWTgqpp676qbS/jaeHEnRG4S2BzfQDenh+Fd9u3u1op01JFXoRL6PnKMkdZrYWmeBuzsWZOBUXINMKOUYtg2fdqy0PAddPxfHCHXdcOF2WBzc7WIwPnKuTix77Fwa2LByRl5dloZMOK2d1QbJDQi3ZHlCewSoVmlMgT74s/X+o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7061.namprd04.prod.outlook.com (2603:10b6:610:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Mon, 4 Mar 2024 03:19:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 03:19:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "danilrybakov249@gmail.com"
	<danilrybakov249@gmail.com>, Lukas Wunner <lukas@wunner.de>, Klara Modin
	<klarasmodin@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Thread-Topic: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Thread-Index: AQHabEDqvjYLP9d8aESjxeYsLpcDnLEkDfgAgABHMYCAAMeNAIABToyAgACBqIA=
Date: Mon, 4 Mar 2024 03:19:06 +0000
Message-ID: <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
 <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
 <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
In-Reply-To: <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7061:EE_
x-ms-office365-filtering-correlation-id: fc2037dd-51dc-4b3d-7617-08dc3bf9d9ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6/QvNUl7FSbK/8uXZWS7QAOh2p+SLvB/6JvpzZcFfmeWqvSl4+s8tQFBjnIWoELc59vyw4OqdKwI/IkGEQ7Vy2VXJ70/CQY3AE7JtX+YSJOgiVsUPxx0nfmtw7oGvpWjaukM77hW+m3C13rhMc3QZCV5bLFXvmn/LBZ+yhRKpON5B1gvgR5MQQxpCUIao0neTGOeHz4mloBtVo0d9Y+FZQsG4tN6a4mWeomTivEza1+fKLOGFSpciidPpjPpRTJ6GUNkDHs85XLdRUDugU6BcCnwKlgWO4mHbV5SKnT6sYGplNUyvaclgqWt/TXt9ph1MtApFQPuHS8qwsW5IooPKnZGQjL/6pUYw3+zyI0Fw7Ig6iPFWL0wH1foM6ICnInLB7h0Oj+MHZy3c6wqrVdqxtOdTHYQ6ZmuJ6rCNJapeNlXzp9tNDOV50fO4rq8Rj6Zr8IGBm2+rC+X8xM0gqRVp3FxSbtVIgtOaGoFeq30hr9OdfmHXC1KB86GUX6XSZUiF8CSdlt4q6OzeBKH4k75XHAiWRPsC+mpcAzYM7koJJSFufdIWZACM4l69+UoNP7iw8ddGa8fcwa2Pug60jLZ4pplERyc2DmW5FHyYOnp/XBCjypLA3T4Yk3aizf8Sb1gmm8L52c7/FtIrAHNzrhhNNNL3kLu3EGDkDEl6YMvZYc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XJwBhKwYc+xlJq9qV4l/LDwRF3hLF7uvndR97XpUDICpSOmf19XyYj+g2o?=
 =?iso-8859-1?Q?+M6H2bCjJ+kldzw4U/uHqFn5z9aHA4wkrm+1icoPqR3rdyN0N38YHlv24s?=
 =?iso-8859-1?Q?qDKXx8NH6RmU5C6ZeNndmukgU/7bPTCqyF5F6K2T3gek7vjbWTVI+KPpWv?=
 =?iso-8859-1?Q?Kk/OtiyiwhLwhxFPHNm8L6RfQx9TLO+BIVIb3koidfjHme9LV7ZeYnb8v7?=
 =?iso-8859-1?Q?u30uAyinSENvioaAc3NB/Ry1zLuNsDTsHHpMyQ60HxhBHM09q0TSg2JCJe?=
 =?iso-8859-1?Q?J2IoT0KaNSYDdpMSUEJtU4utKQXKcPmFRgaUzqZrdzyC8ogKgmzM+MBiBg?=
 =?iso-8859-1?Q?6UQCI7gTtQmT5SBiIQkhGvCl8gbkJ8FzNYZSP4BnBbUgWpkfUFCOI5XTro?=
 =?iso-8859-1?Q?+4JnWZ1fuN90gsbl95wROduKLh9BrGEhnIUWZ6X9uQmCoFeWxsWXwJXYZv?=
 =?iso-8859-1?Q?/47pM26UWvwdtvhD1g1BJnHOpnfs07P0P0TFeTiO23I9HXcu0tHdCL1jYE?=
 =?iso-8859-1?Q?rLyKpUZd189AAW+S0H6922EicZIXHupDovitFblbcUBZsVV/aGDxDIsZIw?=
 =?iso-8859-1?Q?2pLOXe/dfQhGGhWdhEO7WWNi/KCKynvGyBqUla8qpoRd68QvUo9mTFn2EI?=
 =?iso-8859-1?Q?rqXwskg6BSybpoHuspq2lE5iXVN5eAvzx2TvPcGgVcW6N0yAEcIgMW8po+?=
 =?iso-8859-1?Q?jkN3YeDC0j2QK5sYJUKm41mhL8avwpVcUnnlDOiRMDpiXGdUI1Gpv6x3s4?=
 =?iso-8859-1?Q?fflUZWwNfSe3wPWRjdMik4Nfs8bxgipY+oW1/PDN6Y0EyX6C1R99fRXmno?=
 =?iso-8859-1?Q?AH2zrqRBJN88uTywzLgZCef8pka+7YTKsWKdlfuCPEIpto3qY8cLCjKzfj?=
 =?iso-8859-1?Q?dCVH9n3L6qVdwbDei10TqfTLSYx30daAxB56RLL7v/zLUBsjeKLj1bjGGV?=
 =?iso-8859-1?Q?NeapCSBgQNMuy6+e7BsRnrWD0yckkV37MkiJGn/O9k5lFwVHFKVhpf4geQ?=
 =?iso-8859-1?Q?09I7lhzV4H3u8wtYR/ajuecUFnxtOgyG3SEz6uBzYH9CWZQSYEb8jxImU4?=
 =?iso-8859-1?Q?WcpIUINn6woDUf6HNbSd2V7pyyisUUZXdgXMfQosKv8MxfSMyZlz/5wpSq?=
 =?iso-8859-1?Q?/7g+k/xOSxc1N+3hI+ogG7E6AztJbZtl186rxU2kyhHGdpIlO8Ddaoibbv?=
 =?iso-8859-1?Q?J7bMGG1gYnyQ+aRZ0l15+NU0baFYFv351y7c5NMxW3yYnWdY9b85CT3B0O?=
 =?iso-8859-1?Q?8azfad17e8ipXKfZfHWu01Nu94dvhGFGlfwJNMVHeJ6E6QLtLahq0VUhNo?=
 =?iso-8859-1?Q?+e93j+/9g2gTVOr/fGf8lQ0d7ZlewZlF9yqOl1JyWjJMHXfRd2VkZh+h71?=
 =?iso-8859-1?Q?/Pj+fX5pxp3vHNhNVp1HKxR/ZbgJ5ptyiSqldALLdJlE+imJ8smDJLP0AR?=
 =?iso-8859-1?Q?8Aq4c9wvX3Ox3UzZKYsOHh2b0PN9+lbmzbr9w/MRzCIhNj8u5W8KazBbub?=
 =?iso-8859-1?Q?/ntjaanOzzevcqbXqIOzCIHvcoQlZ0TRHtpYSDfh4brhOQ0lxR6uTWm+a0?=
 =?iso-8859-1?Q?VPxnNcYzhnFVfWWBs1C2acwfobSlNFizP9TibBx8pSgNvErsl4CyZweHzB?=
 =?iso-8859-1?Q?oF8CCBISpjfXfYi4c1cDPKUP3t9GGHVUuLlTJk1Ulc4SaWy0vjNm6sNI6T?=
 =?iso-8859-1?Q?unsKopXxKCGNMrLSmFo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0F843DE7765AE146B08A80F797757272@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X16rFc8K08SxTRxqWAcs4nLjjCZmTfQJPTNs+xl44D+Nx1hwmv5xc75RXWQI4alJ7qQpvaMu+1QtIBREKe0uGErA7ql9Ogqv/RtJl5FC4+GT8JhZjT0RU/bCAE9ufL6vAyXuD3/uvUQjvCfzNnCjh/9XAmhgREGo6VQBm5BPdpwlpIOryyZlx1gwZV4oH7Ete7iEQ9spz2ctZD1/cR+zHHnW8y2oZ+O0T8gZga5BW7KfxGthDTgDhDG2DqYHR3JQ5ynmeNk88DDl/HcVPhrKrRdOxcoZpVlREDPPM4VyzRCwgHdO2943LqPZu+fFB71JU1Kvty5aPrMADjMP93XiVwDMivnmUUVRQaTKBflDCgxgJWBtxDfiAL7lYyrGa3wjK3bhubCEoH8AtOhiMNJmLa0K770DXfd9ioF1UgoiwEfvKNOvYqQEElpl0SW3HArk2gHoQPT5TMs6kV8SgaEIsPaZ5o1d9W3rqqozKmUQc06RW7XPCq/YkfqHqdprHjaesxYRptoWhmLgU1rB5OAvjPVSv+by7bK4xFl8atkgXUqofgaQxbQJ3thyWAncyvaysMkOvHk+h9yiWNFZewk5xQDTCAK0qDPZdAFX5/BnMMYg3PtMF/h3A9WKB0E/IMob
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2037dd-51dc-4b3d-7617-08dc3bf9d9ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 03:19:06.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFV+quH9yBWaJ5VIEDPi46uqffbY7FFIxLk0SLVONpmvnTVzoshobpyyPDQ3QVFS7366xFgLwYvCphtsiyK26ODRd1JWHEa/mztnF3lJr+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7061

On Mar 03, 2024 / 20:35, Hans de Goede wrote:
> Hi Shinichiro,
>=20
> On 3/3/24 00:37, Shinichiro Kawasaki wrote:
> > On Mar 02, 2024 / 12:43, Hans de Goede wrote:
>=20
> <snip>
>=20
> >> Can we not simply just skip scanning function 0 all together when
> >> on Goldmont? I don't think any drivers actually ask for the bar
> >> of function 0 on Goldmont ?
> >=20
> > Hi Hans, thank you for the idea. If we can take this appraoch, the fix =
patch
> > will be simpler.
> >=20
> >>
> >> This is likely also why we never had the issue with the old p2sb_bar()
> >> code, because that never touched function 0.
> >>
> >> I think this is actually what you did in one of your first test
> >> patches in the bugzilla, right ?
> >=20
> > To be precise, the first test patch did P2SB scan only for the function=
 2.
> > To make sure your idea works, it's the better to test to scan all the f=
unction
> > numbers except 0, from 1 to 7.
> >=20
> >>
> >> So maybe audit all the callers of p2sb_bar() and see if any
> >> caller asks for function 0 on goldmont ?
> >>
> >> Let me know if you need help with this audit.
> >=20
> > Help for the audit will be appreciated.
> >=20
> > With the quick grep for p2sb_bar() [2], there are five p2sb_bar() calle=
rs:
>=20
> Ack, I have found the same 5 callers, let go over them one by one:
>=20
> >  1) edac/pnd2_edac             devfn =3D 0
>=20
> Hmm, ok so this one binds based on CPU-ids:
>=20
> static const struct x86_cpu_id pnd2_cpuids[] =3D {
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &apl_ops),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,     &dnv_ops),
>         { }
> };
> MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
>=20
> And the 0 passed here will get replaced by PCI_DEVFN(13, 0),
> so there goes my theory of p2sb() never being called for
> function 0.

Thank you very much fot the audit. So, it was clarified that the p2sb_bar()
can be called for function 0 on goldmont.

>=20
> So I have taken a quick look at your latest patch from:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218531
>=20
> I think that skipping the caching at fs_initcall() on goldmont
> is a good idea.
>=20
> But you still cache *all* the bars for goldmont on the first
> p2sb_bar(bus, 0, &res) call .
>=20
> If we delay caching the bars till there first use, why not
> just do that for all the bars and also drop p2sb_scan_and_cache()
> which for non goldmont is equivalent to p2sb_scan_and_cache_devfn()
> but on goldmont caches all the functions.
>=20
> Since you now delay caching (on goldmont) to the first p2sb_bar()
> call I think that you can just drop p2sb_scan_and_cache()
> altogether and just directly call p2sb_scan_and_cache_devfn()
> in its place.
>=20
> This means that on goldmont where both the p2sb devfn
> PCI_DEVFN(13, 0) and the SPI controller PCI_DEVFN(13, 2)
> are used we end up going through p2sb_cache_resources()
> twice, assuming both are actually requested at least once.
> But with your current patch this will also happen when
> PCI_DEVFN(13, 2) gets requested first because then
> p2sb_scan_and_cache() will enter the "not function 0"
> path and only cache the one resource.
>=20
> So I think that it would make things more KISS if
> p2sb_bar() always only caches the requested devfn bar0
> instead of treating function0 special as it does now.

Thank you again for looking into the patch. I agree that the "function 0" p=
ath
in p2sb_scan_and_cache() is not meaningful any more. When I prepare v3 patc=
h,
I will modify the patch to call p2sb_scan_and_cache_devfn() in place of
p2sb_scan_and_cache().

>=20
> Also talking about making things more KISS, how
> about completely dropping the fs_initcall and
> simply always delay the caching of a devfn until
> the first call of p2sb_bar() for that devfn ?
>=20
> That way fixing the issue will also actually reduce /
> simplify the code :)

This will simplify the code more, but it has two drawabacks:

1) It still leaves the rare deadlock scenario. If the drivers which call
   p2sb_bar() are not probed during boot, and if they are probed afterwards=
 by
   sysfs pci bus rescan, pci_rescan_remove_lock causes the deadlock.

2) It triggers lockdep splat for pci_rescan_remove_lock at sysfs pci bus re=
scan,
   even for devices unrelated to p2sb (This is what I regularly observe dur=
ing
   kernel tests for storage sub-system.)

I suggest to limit these drawbacks only on goldmont.

On the other hand, it means that the drawbacks will be still left on goldmo=
nt.
I would like to follow your call. If you think the "no fs_initcall() and al=
ways
delay the caching" is the best, I'm willing to prepare the patch for it.=

