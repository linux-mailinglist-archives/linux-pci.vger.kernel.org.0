Return-Path: <linux-pci+bounces-9495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D0691D6C2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B771C213DE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 04:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E703CF9F8;
	Mon,  1 Jul 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FvDKtw6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2067.outbound.protection.outlook.com [40.107.113.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F71FA5;
	Mon,  1 Jul 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719806835; cv=fail; b=SpXDQxQtM1mzk4tU/Gai8srvWBWHXNcEbo7C7QBUWagS75WZl2NVXPk9OHp9zYlptgd0FMsligE51ULBYCfm7zkU0Tj6jtpv5PJvJ+Qw9Re9GuNbLLopdMIblqa3wiMA+KzENn4upnSSu5I+K2E+FFB2Bh0lMjQPi0am3l5ohoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719806835; c=relaxed/simple;
	bh=IolEg/EdvraKgaQ4J1qWGlwFtOq/ovJqV2iFIoNNm8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+Hqak5fLnZ2s/aBZFGKZSFzjZOHwDnW/LbpKDfXtbwx1JoEwtaecicxzthj2w2J/g87GGe87BYywEQfyJ9LsVh62jxe+facT52+GQVEBOvZPcfqNoU1tUrG5hG3Lzp8fjI6tRjHfGrmg5NcBvqu3oW0AVDiRmwLr4XqWTLu0Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FvDKtw6y; arc=fail smtp.client-ip=40.107.113.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZZXQI/GdLJNfYegKinA7AnbeE7e3sIlJJ85dkdS3o9Qkwb+CqJteEKP+9IkS8YTGXnrQrYm3Bikj8dkSpRsRlSM+xc1gB1kA8ooRdstk6CG6Sak8iiDWiK5+cqulhTUKI5Zp6ueZNzIoNCcDpjbj1qdEpJUhQ8MekjeFcKZhbl8whanf1arNKr9B890/xF8SjEF4gQL7NDT5lQ+m+lRgovWy8bVgSSx+lI500iOZt/Xg+fIJIcGlu+/MHw4LlX7GbolZkqAi04ndRbMHh7/cpblR35Wgs20Fl9SlLWIxWVb1KDj7nQBjU0eguYddLLZAyW5uLvFeEgRdn3dpuhUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NyX7LUd2qQl+KrRZGoZeCLpqi+0DgVE66LAJutpkZw=;
 b=la5r6B4m17n5iLqLqRbGIn7ciMfYO0xAW/WbiqFmV0SgWtn2hgTdt/mRxrB0JULWNGaDwqzhS73dDwQg0mwXhlxAJaW3wmWWKnuY044YM2fBKNnXCB9+c+rzat0pRFx5jhW2+CWKzwJsWLBKkoMPNWCoJDbQza8AvONRklERHovWoj4RRssmLlEz7RcReXAH2lup9fr4j5b8BcOwuJysZoZd50hcSdfkj2si9hKbgBYEFfn64+aCqBWh5K27Wzsd80N7pPA9Box2j3spTN6oBFl5ffZNoxcDth+b6/ytCaO8o8oBnNqhJcNL7YEZQGXKw+FAHaRjKMrMLnNhKMiUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NyX7LUd2qQl+KrRZGoZeCLpqi+0DgVE66LAJutpkZw=;
 b=FvDKtw6yPLXky2KP0jVcqmuaO6TO57VFXZk+QRWWZzPiNNyJNG2HlH9cNy33qfpCj62jbzvPoErzf8MN/drPIedQ0c7DQjMHrzXN74RMVbHFMKTawAKn99mLV3In7tFoIRIg5mhLzFrauVA7SNwuiA5lScFidGXxchs3xYQQxZg=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB8087.jpnprd01.prod.outlook.com (2603:1096:400:100::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 04:07:10 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 04:07:09 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHau/4H2Ue+Yvqse06eFL/aaE81cLHfRNCAgAIafiA=
Date: Mon, 1 Jul 2024 04:07:09 +0000
Message-ID:
 <TYCPR01MB1104021C193620D3E02D32BB9D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240629195615.GC2249818@rocinante>
In-Reply-To: <20240629195615.GC2249818@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB8087:EE_
x-ms-office365-filtering-correlation-id: 3351651f-6d65-4775-c949-08dc9983477b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?A7GxchEXgLgKhv7Gyigcf6jt37dHVrHBYxEEYt7/HlCcIMMfEO0HouDS+d?=
 =?iso-8859-2?Q?rYNIyguvHXCI+oOX/MFLLc3uUrp3hnUmIjoSl7HgQ9r/QlIda2fxXFfY3r?=
 =?iso-8859-2?Q?O+MjnSzuQBmmTjEE6tnPEbfzKU8roUu45H17M4jB5gnpllhTW5PylwySOJ?=
 =?iso-8859-2?Q?iMG+Z7e6EycwOs9aezqfh1xyQOJYQ0P0tCBdi3/HVTmgJvRBsQECqVggwP?=
 =?iso-8859-2?Q?PQPRxZTqeAnOlpnyjrUefsxAvTET4UhdrwkNn9x4wRtqMLdUfFKfwn8wjA?=
 =?iso-8859-2?Q?YqOiH0j/MoPII84aa6c5I59nAcMtW3wn9CFGR7Wr3kruS1LQSsxIReXfGr?=
 =?iso-8859-2?Q?qNQU8Nkf/6sQxVT0qWI1QLyacfWFzaDWzul9t2HKX4Jn0MS4FKv4Uw4Xqf?=
 =?iso-8859-2?Q?deyS3yFTzxSltjx9sE+m5lyRSZWfz3PjiYyVawOnaa3RlqUAqPeLsVwTa3?=
 =?iso-8859-2?Q?sN4Do4H9X2F+GGTh9Ipnp9cINUbHLQhO2V0cDA+R7lSDD9oP003epyrlcB?=
 =?iso-8859-2?Q?/1JPWr/aurJRM5nmIAs4Ms1I54Q0vOLCg6HjI+pJJJva3Rg+cdoA3yosM3?=
 =?iso-8859-2?Q?ttkX9vN1WTo0uBv/ojmzEtWqQffKsxR+9Er8+ZiA7Tc5AxFECNdVm+hMxq?=
 =?iso-8859-2?Q?hVJCNyC3wPUU/Hw1ee8jNNrUZ6I1RWtZ+D4en+yUA3gKLaNF7AonI8KTJi?=
 =?iso-8859-2?Q?Rjq8Kzlzeld6G9J+1OxgVfwgzP3YHNGUA8Wg72v2dGl64XlbghjfRTKVVI?=
 =?iso-8859-2?Q?ovOhw5sNGz6sZkhRBK6n5NOCmT0le5hCpeWJ8M9qC72lO6UfRZGu3q1g5g?=
 =?iso-8859-2?Q?Owg3ELBtSj7z+Cnr7Xya8IKPuq+DCw0k8WmToOrq03VAWJ1yFLDQh22DfR?=
 =?iso-8859-2?Q?Sx8kd18dguovdV+6Xv+KzBEZj5TgbSsMIBOcRhdL9lOkRgneYLkqa9eEHG?=
 =?iso-8859-2?Q?TzLqImKovIXQK2LfGq8Cxns3jgD4XI6ItCiYB8fVeumkFj8M0K1AaDaDIp?=
 =?iso-8859-2?Q?U/vtIDxD0hT2fJTfbVM4V27g29k4RVeL/sAYUI7XTpEIzFrIPoRRSHzpEW?=
 =?iso-8859-2?Q?E+sOfcOyDkXyqrgjCewuM+x3zFDeUBwl503Ifl5Km6NfIqZHwxjkMkeCBq?=
 =?iso-8859-2?Q?hJynauPqZ4V0nwDwLNIHpcrMTXBGgvodEWxPXwOXn+HEnYVbndB8gNiD5y?=
 =?iso-8859-2?Q?45iT+iYGFzl/BjfZWiONKfsgnOngH0k8wUwXUQmfC4FTvFAfW18zeF2onv?=
 =?iso-8859-2?Q?HxuBAyYS54geOb9jsEDiMnFL4WV3XmmdldtZVJivQLEfs3ySigLKTQC1Kq?=
 =?iso-8859-2?Q?yZy2I87dzn/YBaJbpOSTuva05Hs8zG1+QDWxuxFhReNdbRgWeuZM9OQQ+h?=
 =?iso-8859-2?Q?L7Xv0qbQ/Icd/CCTmg9CpmqyqNLYB9LMX1clQjU19/syye/S0N1qdmnYn6?=
 =?iso-8859-2?Q?I6WsBGqLEfkwF5Fd+u//y1Pf99HZnP3MEbINcQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?6lYK/VOVG7vncNvMvxW9qXjilp/d3CfoS50hZoIL+r0b3vxofVDC+0Z7ZI?=
 =?iso-8859-2?Q?VYaBMm+N0Go/J4Qrlcq1ZcR548ILBugKhiXeIJKHglKR/jzT60xm64E7UB?=
 =?iso-8859-2?Q?yx5wsOehdamNIXgMFPsYnmBU7bEotZNKsx+qpYjTgpQ1wLfzpTD1Mfl4XL?=
 =?iso-8859-2?Q?1mXkRYtu5/3d4Afd+PjbRu6e8gADiPeqbLYWo0bpCTlE09MmxDdBe+XCyy?=
 =?iso-8859-2?Q?xZABHzUYU/Q+fErYAZ+DtfOincRBRp2Xiq6bJLRfGlT/y58wRw7yWPLYD9?=
 =?iso-8859-2?Q?S9WsdXnWR76t6ronTgB5iSTIYetrc3gwCex40G4f3XT20K8u96Bx/PG/iQ?=
 =?iso-8859-2?Q?1z4HVAlPXCc8E3EB1moIAoYC2kigt+4HiyQmzuijpN1BPdDNcAM3JCaX6/?=
 =?iso-8859-2?Q?0M4dazWs4BpbtzsE2uba25iRUAF6S8QdaRldcfvu10scpMx5Rd7sl3fmEc?=
 =?iso-8859-2?Q?trsKG5YzN7LctNOzJC9lDnhPPPOIN1tv7D0aYoKLRISXALZIolN5UyYw1a?=
 =?iso-8859-2?Q?iYsY3GPko0yisYpvx9+xLXmnizok/MnzAKh1tAFakF5GnnsRdyAy72n9lW?=
 =?iso-8859-2?Q?gXSR8ouVtEy3hSjvhh2chOjhgPOz0RLUJZ0WHNsqztBV4n9/mKXijUq6Wh?=
 =?iso-8859-2?Q?QSXxwzZ4xkinwzY8ADUoTfoEjHZhiEkKzUPExPtJAtqMpbaRXgkd2hHl/1?=
 =?iso-8859-2?Q?8aDjhSg/rds1PO2s51EITVrbnEt8Ycz+rHv8D26K7a/FjXa9jZtwEhY1de?=
 =?iso-8859-2?Q?GC2uKE+W4K2nPo+mSsp+AAfrti/jBbUJmA0XkUTyJxc9iwVnfzNkc5mJbd?=
 =?iso-8859-2?Q?1NH6/Yi+B1onDIUq4OE/uneiuIohO3CEPtK7OgY7XRm9p4IbY6ly0GAuII?=
 =?iso-8859-2?Q?FQpOAbQs5BZOeOPwFLiSRxMzJOs3ik8Mx61+FpVDKhYwA2UWT7mfyyifFa?=
 =?iso-8859-2?Q?JxJYQOzhL5GGGTJy9jVwXE5WCO1tVZtaJDqg//vuts52SoxvhzhXxlfluv?=
 =?iso-8859-2?Q?jJ/0mtMrl8sw+vTg+ppkZJsGnEYfE8/o6AoknkfORHlU9TW0kTKU/IF42Y?=
 =?iso-8859-2?Q?fEV+C9vrJY74zaMl2qo0hbXm1YTXlSAppVv/AR2f4VUQKU1nxHzagYSXsH?=
 =?iso-8859-2?Q?uJMzBTHqGemQ51MYiQwLJQhNYKLFA1q3ldKGsw8IqIN5yo4FggBUsWI9X9?=
 =?iso-8859-2?Q?v/0fQGgLfNTjlNkz5zT71IdsQhkqGScodOdN/wLonp05A+jAIEK7+1AZsn?=
 =?iso-8859-2?Q?LWQn8zlBgTRTCldhZpO2tI3gp3JB1owHN+Jnf78HYDUjMq3+LdMpvRNV1P?=
 =?iso-8859-2?Q?4WHkP+L+ZBR1vx4O8pVjea09N5nZla+ebSfV1eTlAtQS0f+ZrEYOnqTkRg?=
 =?iso-8859-2?Q?Jf+FSfRYX5XdH/pPNVlInxJBbr4CNRGNvp7Vu3drXuq3jmlL2wEVN5GC8m?=
 =?iso-8859-2?Q?CgvYk9X3eGAyIN0KkPvqCHk7NVjNtgHWRKyzXR8jlmBePBkzBlU69o9b5W?=
 =?iso-8859-2?Q?M8KHsLSKJGR6niKRSOY961CjAjJJCgrrP3yIBMbwtM79eZo2UJcSRDQmQb?=
 =?iso-8859-2?Q?9/O9qg0GNr+YPWcB8f8kh5DRmuBfEmTtvs2nvTC5ylgQIpVpsX2ByWmoKY?=
 =?iso-8859-2?Q?WibEHMARaZWDSHN/upqxIz1l0NzTwdI5wUll2aEueTEyv6CiTG0PRB2OMe?=
 =?iso-8859-2?Q?/b3kNGtd43uHQ88HvGjGzzVCH3CvLDABTM2sw0dxm0ddwKNRqalS5M5LB4?=
 =?iso-8859-2?Q?TvrA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3351651f-6d65-4775-c949-08dc9983477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 04:07:09.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Mk5trA1ytBBExdtJxjth3ch2CVcmfUIGmZUgDtckWmw8ZH9iZ7SM5KKfh3PKkn1303XRZAiB26AMIA4atTrI4jkHXfgDMnMcLSQI3HK3gVneztMPaSxMHT2AYdxr/c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8087

Hello Krzysztof-san,

> From: Krzysztof Wilczy=F1ski, Sent: Sunday, June 30, 2024 4:56 AM
>=20
> Hello,
>=20
> [...]
> > +/*
> > + * The attached firmware file "104_PCIe_fw_addr_data_ver1.05.txt" in
> > + * the datasheet is a text file. But, Renesas is not able to distribut=
e
> > + * the firmware freely. So, we require converting the text file
> > + * to a binary before the driver runs by using the following script:
> > + *
> > + * $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
> > + *      { print substr($2,5,2) substr($2,3,2) }' \
> > + *      104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
> > + *      rcar_gen4_pcie.bin
> > + *    $ sha1sum rcar_gen4_pcie.bin
> > + *      1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
> > + */
>=20
> I moved this comment to the top of the file, since it serves as more of
> a documentation bit for the controller itself, and is not specific to the
> function it was attached to, strictly speaking.

I got it. Thank you.

> That said, I wonder if we should include this at all?  The file name migh=
t
> and most likely will eventually change, as the datasheet gets updated to
> include new revisions and erratas, etc.
>=20
> So, I wonder if this is simply better to be included in the datasheet
> itself, or some product guide and such, where Renesas can keep this up to
> date and the users appraised of what they need to do to convert the
> firmware correctly.

I understood it. I'll consider it somehow...

> Users who do not have the datasheet and are not licensed wouldn't care.

Yes. If so, it's convenient.

Best regards,
Yoshihiro Shimoda

> 	Krzysztof

