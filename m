Return-Path: <linux-pci+bounces-5150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A3C88B9F0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 06:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D48B23ADD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 05:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A22823C7;
	Tue, 26 Mar 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="brxrq03P"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43A446BA;
	Tue, 26 Mar 2024 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432050; cv=fail; b=OD2I5afIBzvrGCMyHQgfURPDJw9KhyWXZqcifdKsgU0JnrQuPSGc1mjwaiaE6SbtmKlTk101SbhBRS/LcwvUrmQD1YSg9NZw5opqV3ECst5aK35wlrrPpJ2sTwE6qj2YUF9W0ZKVI5Isjc1t677E8kHyBku839jgC5hxB+DTCg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432050; c=relaxed/simple;
	bh=rI1j7VDxYViuOaDZSGsRrMLvtO74ppDHAS+f0PBB0Sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BSXm5o8Ya1uB9Nw42cqiyOk0lfH1Na0iIB0gRcmQ4tkVpyuorlGhN9c9MNH8GiAqEbUhfouLEqHSMRkPLQmhdUQJd3xgaehNhnVGFxGOLWxzSEYXQ4ovmV1GnsD5p+RLdPRNYvIvKydvoXpysIfyNkGWuYKHoryiLMFWc8hmjLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=brxrq03P; arc=fail smtp.client-ip=40.107.113.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfitV85mIim4VqEBrgJaCbLIgwF7+jC38+OLxiaD/l4VXZ+5PdVkeeqyFuaFhH7PwO9AlPsUbW5Q7hQZP0vxMjLxhvMgyeZkGKN6uUuS/paFy76L+F2JeiNE04DcmFiySwju+eqA0ThZL0ZYjpPFrtpzo782KygoIde/z/dPTWUwYka4HcK3kHqcNlvk7kaoatMVqtexmvBDQPM6pZA97nxJzq0BwB7D5cO6HrmpbYK4kqACgqLuFIjJLBxgQdF0vsWOc/LUniLk2/qHQuQaOSHRa5RXcp4sFTZf3Tpubg8pu6uDqWgxGHtxKS2bnMKMTcFLZoXWkJMPPEbFVDWyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/dnzIqe2VKcIHqcgoQHAbM+arceHVFR2c704KOtNC8=;
 b=g6FaUtsBcBakH460+BenLg9ZdLxESVbQf9v1r7zTfTwRaB4p37Lb5Mtjd0EFmnVw64hvphy+M+VxJMimYUX8wcX5cpQcZiq5ZJbjfEv1Bl/elD/OryXe7m2Ywwx6jDAu4L3vtk4ahNh3xAExNUfG9Xz9pSF+zOgqD+s2BguPrkRqIqxAQBXHtPO+iE5ZWlk/mkFycL1vuwl5JNRTehS65/9ujBN17NGicYwDH+FPNO/mZ/YK+07Q0QDGzPNEx3NEpZtPbUNaXt/fDlt3fm+usotsHhkqJjbRC7eToUcNO9DTKnn4sypdVp/iJaRJWvdviiO2Z3YpvxnumFcdsO1pUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/dnzIqe2VKcIHqcgoQHAbM+arceHVFR2c704KOtNC8=;
 b=brxrq03PkLvxc0DvJ+DCdjsHILYONm0WBCQEgVOWHpHjxEAn+KanL7eBXDClXOagTX02r6gjwYXH8WSNvPRT4vHbFU74EvZkvyEiN0STDtBcdwfqZdPuHuL8sR/so68PFH24AGWcm6a4/av9oIcqcICqQ9BEeXsq5hDUpCb7JuU=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB9812.jpnprd01.prod.outlook.com (2603:1096:400:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 05:47:23 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Tue, 26 Mar 2024
 05:47:23 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Frank Li <Frank.li@nxp.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>
Subject: RE: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Thread-Topic: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Thread-Index: AQHafye97ZlAwgf9kU+dZUE2YnHEwrFJWvUAgAAmxiA=
Date: Tue, 26 Mar 2024 05:47:23 +0000
Message-ID:
 <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
 <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
 <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810>
In-Reply-To: <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB9812:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fLgBvJctteeUYE93hXTe0x/KoDuaJ4V7Aq7bO8IXsj/xSO1Js/f1X9Li2yPTt/jfwDQNyQ/mooNw8O/54B/SkCu6ESgAWSo5Q37w68QYW/Ot+qHBuDMWIIuSTnnjYJU0NYnDBH0gQagoyVR/mJLF9UNrPiYlZXFTWj9WDwycDQhlDmwExMK/SWB7qNISZ+AODFZSlID9zX9OczKsVG21dFVEhSs7Gcby1jRx/17w4Bu81zGyOA0zYZJH8+0QHpxSaS5ShXhKT75i4a+dIcNshLo1kk5bcOR+UXj/ys5m+TAIpJm7g72N7bddXmjh69nWD5E+OBF4ndr1OubU3BlsizgsTkyWYLKK2spk9LZeza3W/fM7LntE39bPNT5nvIei7zC2ZwzNugfoJlCTPRgJH+pYjnne3ayGHmeeiju5bNL9AWco2+m0z8bjkFdyh1vA0gOQ1wih5YiuLkAUu969TlRm7/cy3aXFHZpbi7yN9p+JMgqDhw34ZjWccjNYj82ej4/HMKvbak1kTW4qyBRKCogB060VwAhrJPljlvLKWuYz7c5L7Jwpsi8tI37nQfar/tW9jB9I81cezMr/7kS4qC8j/wHRIHb/mjx0OSrBxBhpPyNlvzy/3JCaUdBamH2el7daq9NDgWV9Z1PWUOrbK7wBTySVROo2mNlF/xEn3SU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mTacxfo+h7XDZUVQrykigD/V91dMKIaayFhGTi8pOUv9yiq2TFePQ6Kvou8S?=
 =?us-ascii?Q?an5Vr+iKn41gLnLwYe71zkiEWhy50SYMSPDqFvUUlA0cJkT2IAzPu86h79XO?=
 =?us-ascii?Q?MNCFZ7mMUIeLd3fdH9Pn/CliE/aey5vWyyt8WWPuGIXwuw8uQCaJlohwM2+w?=
 =?us-ascii?Q?+vU+X0skGIE2IU3xieqRtOk/EH3xbdHRjA77VPHJLHNf1YASZQ/yfyKcIBUF?=
 =?us-ascii?Q?v4WLcVsCEbbMwYVEmhtrc6o5BcBl2/h3T+nONxcYCixk6rn1e+9R0hYynhcl?=
 =?us-ascii?Q?guQeb0u2cqO/eS6a7hLfvmIGdKT3XNFEmkKwQXnpjK6uBXeljRah2rEy+s/s?=
 =?us-ascii?Q?9Qyz9pRLw1Wip4d1SZNsPnt4ZxRO9HNNudmFBvYvtkd8nDZ98XVrdlH9Muya?=
 =?us-ascii?Q?VlX+wWvj1UYEciA9d9KkrnpQAPIcBGeHr5J8YOU2QJIsRnqTOrYqVZtecMxY?=
 =?us-ascii?Q?JfZlVqTofMJg+P2npsCLwUlN5RMINgT2lgiba29TXua86vhuDsr9/Fm9SsPz?=
 =?us-ascii?Q?NRzpirUcboBlFC4KoieLcpgpnPM1VfMmwRRKq4Rg80jrIZ5kfIyd0vVd+fPe?=
 =?us-ascii?Q?XT1SBzTYYT7NRy0H54VvMkgK0VOX8aZV4crnSvD4rTyWH1G/Z2TkeGUxZNTV?=
 =?us-ascii?Q?ab9MZJ+DBnw34SsMuMcV2YVb30INWtf+fL6BAgH7RDHRushK0g+/SLiLrIch?=
 =?us-ascii?Q?iEMpoZpmwHOz/lfyMBL62PMQFnwmjRjFW9iMOLKSO/cQWEBvqokfKSoOhfoa?=
 =?us-ascii?Q?48a8OtndgsRN4Miah2MwOPCFHMPqdoAgMkSnxWhrGpXnkWtMAiRB6Vh3aD9+?=
 =?us-ascii?Q?4+yt9S3IPdsJNrXfv9mnXOXQ2TD3NCJDI8XbTJu8Z24IideTtERIH8+uFNrR?=
 =?us-ascii?Q?wHNWOkkcAl4U0JIpvVLMPhrfcIEgfHp9IQDgTtTfdVjMOS3eJKwlBL1OxGaZ?=
 =?us-ascii?Q?iQ5s5ewvVCVezGZH8fNV54A0WSYJsr6cN1HBn7U0dAnf2MkmySBphALXNZGN?=
 =?us-ascii?Q?mROmMZDmYGAFNt8G6j3vU0TMeBGEZJac6GExEl4tG0F3lcVLwdSWcmPIeIPm?=
 =?us-ascii?Q?yRnKOuLSa+bVlYHKlyZgTO/FEnTuH5QASEqp7sXOHDqEYkE61kC5Xi0gwuM+?=
 =?us-ascii?Q?AL6eBRWH7WcyGACsEWRsHtxPTHmQuFmOgwo8mdZqhXUJHBdtv5Pr2LvSggSV?=
 =?us-ascii?Q?RSHmLccBlp/u85HgqWoAC/lBqNlUNhfS70R8x6vHrYAQ6K0j4O/lapNVE+fx?=
 =?us-ascii?Q?pWwEZLMkahenzDZsPDx8cjTvTzcSNQXk0d9pdEamhxbxITAxc4+CAZMOexRi?=
 =?us-ascii?Q?jCArCMVwQOMXW5dnAjRBJRbQuh7MBiehunKPq6SnhdMFij6YF9hMLJ4hClEf?=
 =?us-ascii?Q?zH/p21ga3yzDeHMp7/7BoWech6jTjNbCwalbJzLhVAbJdqKdEAYy6NmKmC3J?=
 =?us-ascii?Q?JNEQDaaIVUo3nmcDeSdIWTR/8orbX/SYOZquZEYeeuLb4RDhMZADvZkaVIdA?=
 =?us-ascii?Q?FF6+QAMLm9qf8pem53gNigeNmXK519lMOW63d+NvEDr84KhQ/llKKejWtUr9?=
 =?us-ascii?Q?lYsDkgy5ce/qGlCrdiCzYd+gZl+fsYdvj7Setgln8wTDqLPd/N+cTrDt2usT?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4088089a-c65e-4cf1-3162-08dc4d5835e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 05:47:23.5980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D/FXeehpzXet7WJh7NtqGIsVtx5Zqw8KiEzwgO3tr/OCTlgVxGssLRF2+lGzelAz4l9mVgz0VPNpYHRKQmR5iIXdSsQWOlS3i5qtipAkeKJIrOeblEM2gfNRXqIoRA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9812

Hi Frank,

> From: Frank Li, Sent: Tuesday, March 26, 2024 12:21 PM
=20
> On Tue, Mar 26, 2024 at 11:45:40AM +0900, Yoshihiro Shimoda wrote:
> > Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
> > can be used for testing PCIe EP on R-Car V4H.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoi=
nt_test.c
> > index c38a6083f0a7..2fa3c6473c7d 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -83,6 +83,7 @@
> >  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
> >  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
> >  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
> > +#define PCI_DEVICE_ID_RENESAS_R8A779G0		0x0030
> >
> >  static DEFINE_IDA(pci_endpoint_test_ida);
> >
> > @@ -1005,6 +1006,9 @@ static const struct pci_device_id pci_endpoint_te=
st_tbl[] =3D {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
> >  	  .driver_data =3D (kernel_ulong_t)&default_data,
> >  	},
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779G0),
> > +	  .driver_data =3D (kernel_ulong_t)&default_data,
> > +	},
>=20
> You use default_data, why need new device_id? I think you can use 0x0031
> to do test.

I thought we can add a new device_id freely like other devices.
Since the PCIe controller's endpoint mode can configure the device id,
I can use 0x0031 to do test though.

If such a reusable entry exists, is adding a new device id into the driver =
prohibited?

Best regards,
Yoshihiro Shimoda

> Frank
>=20
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
> >  	  .driver_data =3D (kernel_ulong_t)&j721e_data,
> >  	},
> > --
> > 2.25.1
> >

