Return-Path: <linux-pci+bounces-9718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8892585F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C91FB20E2F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C0E13D2BE;
	Wed,  3 Jul 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="KLeYmVdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010064.outbound.protection.outlook.com [52.101.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957F143743;
	Wed,  3 Jul 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002222; cv=fail; b=CrG9aKoQjHh7eYZvY6qrBlRHFV/HaBI2ln+obW6WbpK4bfuhnHPaWLrIID2Xg0+i5c6JJ/6X+/Fu2BH2WQlIeQNJdovNu8EjVpRC16lRgzQ625cHEu5Mgk/ojb42ovArm5yZFigf0wzFFKlr6pxLMFcWX5xn97Et90wHUE6mvAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002222; c=relaxed/simple;
	bh=pVA0uD55tttzO05UA7KUa99B45LUSKonAEaY/JE1hro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j32Qdzwhz2MYuho7pgUJAJ/oz736BJ5DX/roNtaGctUsQOEuyg/jA0wwAEZrvWvfBzwT62LdEy4cykWaTeEzDZBQQfYIr79z7lQ//tHmQTfHWst/b/WNS132by2V4Qsk/KrR335T7OJQM6YPhSMMbYCpA1MblmVP+clBncjrmeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=KLeYmVdi; arc=fail smtp.client-ip=52.101.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElZMo41CDzbmAMjFu6JsVbx4XTrc1/O+2FgCfFbSI1VKnh4b+d78xmtr+FEk0PIR6HzXZDoqdDuZCACiLx6ClLA+ZJYYXpVWUB5JT42Iw0uYgyJgKeU2C3cZEYz1PAJMDXJ7q4jHT1TuLamLjDBl5rpikClTSCl+QllkyPjvcbiWtnVScfyPyrktxFp92ktjlhToWNqOWyZ5UXIfJckjYjasIMYjikDuXOgno9TepELhbKxD1U0JXNOC4aPPK9pymmIq+jWebSzHIydKIM1kQ89mD3SPbD01WV8haDkJAYVpnJ1iqK6/RA2FFg35C3i9BW0OfbyKDmzeODyiT7l0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApvAd66LJeVf4lkqQJXRGjy1BR6pIn0Wxxl12r1b38U=;
 b=ZJm0mMuNC9sDMKueqI1Ro5PEPPkv3d9fRIR3OzbRtWQpNEMEDjLrKrsEp7wpR3/i+wJe2Ta0VLoeSMCFOWCzSEujBfQbkyE5CM1JLGeBNh6ePej43EJIpKJMfO5UHkt09PqaLGG/k+MCT7pmPPauFH/7YJdlySz/PZneV57ktlOidVTkTDtVOlCVG/0l/0GEP6mpTZHu6LXh6Tgw70zzVOEdJK7meqXDTmBIIZY6dcXSTK+mDGh58cvfrT/9ivoO0i5P44oJq837ggz6wXTRgIZu/mF67h5Bc9mGOmTWS2IJNk4k+8VEVNXkwEBSHvZJW/UeQRkJcNpskZVohOJ+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApvAd66LJeVf4lkqQJXRGjy1BR6pIn0Wxxl12r1b38U=;
 b=KLeYmVdio06nh4iu6/sXojcml+ttGEXm6uTHGOFQjokv54G8DGjGwXA5NbnhC11dq1RHOzQtWcaPleFKcsd4V4rdBoLR4rt+27Kj7LV8oz1AjaDBDhAjMBhuhJR6sUhoFp6FhTrAUSSRGkxqhfn04lXXjG/aEZyGaFBYBop+SsM=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYWPR01MB11050.jpnprd01.prod.outlook.com (2603:1096:400:396::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Wed, 3 Jul
 2024 10:23:36 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 10:23:36 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>
CC: "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar-gen4: Add a document about the firmware
Thread-Topic: [PATCH] PCI: rcar-gen4: Add a document about the firmware
Thread-Index: AQHazTGPJHh+Hp5rnUODEo5TSuYR2LHky0YAgAAAMlA=
Date: Wed, 3 Jul 2024 10:23:36 +0000
Message-ID:
 <TYCPR01MB110406A48DD15C88F3CF680F3D8DD2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240703101243.1403231-1-yoshihiro.shimoda.uh@renesas.com>
 <ed614880-e765-5048-cc6b-c5ecfb156aec@gmail.com>
In-Reply-To: <ed614880-e765-5048-cc6b-c5ecfb156aec@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYWPR01MB11050:EE_
x-ms-office365-filtering-correlation-id: 8f243718-b9cb-4459-78d8-08dc9b4a3312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TGNAlvmJh9rO6f4dPCm6f509xBbJXh/V7PO6Cx4CRXML7WQAqCwq3Mg57P1r?=
 =?us-ascii?Q?oKbA8br8g6duGlz+ITHEut5P1/I5zy13RMbrhgtxiOyAtTbLPLzhMmiYPhA0?=
 =?us-ascii?Q?gApGU45X5jnypZJnxMFb48bmWRLxipqY6Q+luDniva3EwKmfmp4nxruAL6Va?=
 =?us-ascii?Q?+YL6pZBAb4c28KEL9T8AZu3ezIlAMhBp8Ada3gdhv9WKhErQV+aNLIovO5mE?=
 =?us-ascii?Q?lSxuL+mwuOU16gJz+wkh1purutnerhqCMDo03Tq3+ZMCOWi/TlsDiyIlJgPc?=
 =?us-ascii?Q?Gpg+HtCNkeAWpBqGqHfVW3Bh+xQkMTwsLeSHpBz/UuFTMCq17nkWrenKmBVi?=
 =?us-ascii?Q?cvBG+S7qSextQmFbCH3LDAfmUKxvxPzOxf0gEJFhdHtrcc+1q5gfcZz4Sr0b?=
 =?us-ascii?Q?6rI7sz73z4zDqCvnU9nq69sCA6ZsJuGxytXQiLFJ3gSBm1DI6SlmTM9UKc9W?=
 =?us-ascii?Q?P++p4VkrN/rL5v/JZJ1VuN3JzoeaAWrgmn99rIDW6eEtvCRew7MtceWRsBRA?=
 =?us-ascii?Q?BE3SOM7x5t+G9fGb0N0lw+i4YUcD+7l0nWhVScECaP2QcUGcOvJOmrm77eSy?=
 =?us-ascii?Q?WxF5hsKPeuThOfqqYKvAhV8z1IbZXBZJOoNaaGCLpd+Y0UJQeP3WynbmD78U?=
 =?us-ascii?Q?Y4Jome/gJy86pSzXHhbu4Q3GimTGxBOG7L9WngDKeU49pirnRTM3iDTiZpCZ?=
 =?us-ascii?Q?WXYbxYxnFVmxbJVkiCtOKXc6zzYsdbYP4jeO+Eo/NwZwN5CSFI71z+Xo4QWz?=
 =?us-ascii?Q?eECRkn5WtE63VcDO1VmYhM2gn1bUAHEi1VGm10F5Qi4r/AtuIxcrm2FIiPR/?=
 =?us-ascii?Q?ap/wOq2ps6M/3sB6ycLCs94vnqp29/Bu54dbiZjziMhomUZUNosqH+3o5rnp?=
 =?us-ascii?Q?CN1HZK32GZTRfheJpwHD0HcDSbObAKQMQ4ZZ/3WRiQkLMyqtNL0C6qM7q0c1?=
 =?us-ascii?Q?NLS5DhU+CSbzWmZwU0U8ntZIXAglsgmrf4MeCYGHreTY9wPNjfXIVuJZc37m?=
 =?us-ascii?Q?Iu7eLMkeipqPZqlYjISIJbAG2NWO8WSxHNmXNnEDSe0qzUY/Ja0a7xk/QDad?=
 =?us-ascii?Q?Yr5dMb50a7AFAKbOFWaOOp9isBxE0HuNZwIAt4PTbx3opyPRqh9xQaRjigbB?=
 =?us-ascii?Q?FA2Y+UjfUywo+T6poWsThMOj+Zl8EbBrEY744Dd9KBJlFKV5ROnjGmeIOiCm?=
 =?us-ascii?Q?ljEry774bAguIDUbnglzTXMTd9oI+82lk4XpRGnLoB5K+DmjQvTRpHVeZGmC?=
 =?us-ascii?Q?w2Aq6Bh8bIyg2BvK7Vz8OXeEtOx16PNGpdsCV+GlaAELAzpqxYjROaGXheTb?=
 =?us-ascii?Q?3aoyYTp07QjNw3n9rsQTCS4wZX7oL9Dmx1gvzzE9qe3vNYS3v/6wzbkkE1EQ?=
 =?us-ascii?Q?a+5jVuc7eT2H1wW0Jygn+5cGQcCW9M0Qw+zLo6RR+8lQzDLr4g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gHL/gg2sSjvCT76bMG1bBMO26GY/8dICdQptepMsV4AZm/PwlPZF9u4lGGee?=
 =?us-ascii?Q?27k9pNvyk0wD3q8HZVkVR40E2Zh4eYsggzGvjaEmzN097m5Qx8awuoDROph7?=
 =?us-ascii?Q?4u/a645nTwXIi+gf3ZMzVT9iMxO8n1aG90qIDnHSzZotbWOu467q/WPI+SDh?=
 =?us-ascii?Q?l5n/1QxueFGkv8sK1T5X2e4/DYS3QTojW56jjHrY1j55NygnidJ7LK3UZ9cO?=
 =?us-ascii?Q?iN0fmqVSE+qX0rETO39l+yoiC7mnuyDyaPV6P3WRLvxHRmSpYJipOXtQRzZI?=
 =?us-ascii?Q?9JVmY3UXpYiJV+x/ywcKRJgdePW5tt7IB+eOLK/fFeu6JVBmKvUiLbk8dyQ6?=
 =?us-ascii?Q?l7nk6o3ejor5Kj81imuFzoXhKNfQBFjJa2b2bzKCSOK+C+VoDJh/r60mqnjI?=
 =?us-ascii?Q?HfaVaCinMgKSqPN4/VPrduXsbFmy1l4vaKGwgCBMDX8HPWtyaQiX2rWVhZC9?=
 =?us-ascii?Q?ZV/7TJulkFfyOfXaZR8u1gftM+HJzCg0wx4V71UcQX4zWyA3TRohRgpaewxO?=
 =?us-ascii?Q?W89wclcOY/cCZSjlcSb3QGuwQ+ClDZDSo2mxovJk5NM62uIAfx2Uq2oCYctr?=
 =?us-ascii?Q?ka5n5WUVyjih4QQbHi8A+eVvAxwu7KUTMS6xGjspt3YMPM4T9ZvWCssPUVDQ?=
 =?us-ascii?Q?4XlARfvalGjXeEBxzKPIRxMbTsUasuupP+EOF5PWYFIbnBXM1j/o7fEw1USO?=
 =?us-ascii?Q?q21dqpSg3s6UlzN0Y1bttnlvngkJWnZbVS0tGZ8xiLpqXEafTKSYElo57xIn?=
 =?us-ascii?Q?TyZqMNccikl4xX4D/U6Frt/g2o7dMObE8DBN+KpIw9co63fX/AKmLsO78PHj?=
 =?us-ascii?Q?mkdtPWvsBB8lwBKi2ZpKAObS7Hmd6tZ9fnN1MXxgkUswOVxiIl2reEjlAjtx?=
 =?us-ascii?Q?oYXmFBPzhAE/FnmzDSntpNJQbbSPrM8c1UI2sUInWJZpRsMLyRxSqtT884VH?=
 =?us-ascii?Q?2VyE+VLyeTyWtPa3YXZnPzjvmfodBKN5isj4HKlfpMuXI6AH0PhXvQnVCFsV?=
 =?us-ascii?Q?8ozz4ojeeWRgrl40h9lxzZxM1WtPRdfwmDCOZAk2E7As3j7m/ImskVCt2X4l?=
 =?us-ascii?Q?cCFZQyiJTRS1XbxUTdN9LQXa1mAlYCHkg8BQqSQOxRQwmN19Q0EORiSHLv5W?=
 =?us-ascii?Q?3tm5lqqwJQn42k6jURd7BQB5+WU2NQ13v6ds1Vhno0hUWsowTfvEG/MX3t/z?=
 =?us-ascii?Q?XT5AuyJ3quaSMXv40LvULDzmEa4GkH4SUHZ642MDvXBhXrEZHkeL03qJQ7Bj?=
 =?us-ascii?Q?5J/ua2yv6n4tyVddhP2o9U7B/HISO7k3fjC9b4jpr8ovwm3S0hf8IWwqz3pX?=
 =?us-ascii?Q?iPfZZrm8VUbN7rmOJjOBVAQhSoD+t3r3foKcI7BF337zHBQdegxlO+VZiGlW?=
 =?us-ascii?Q?VJukfSvvBTI/LI30LnWxMr5/dVpRNdKSzbqUS4wJkGMcxihCo/cjEG3A55ja?=
 =?us-ascii?Q?JUBTHK4B/KmuUB9IwQlkFQIR45OBjc2N46SDE44Ygt0D46hQVTnX8IsA4Nuw?=
 =?us-ascii?Q?yh843IxrzNAbxfEyuSX2qDHLlUzzbWPSsO3s5uM5RyZxcqXbX1y8vF0AauuU?=
 =?us-ascii?Q?KCSvBbeV+AI62KDWhSSQUey9fu83qgqsxsKG7kVY06UsKZkyeeLwuFWFHBPv?=
 =?us-ascii?Q?zQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f243718-b9cb-4459-78d8-08dc9b4a3312
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 10:23:36.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fy9egO1rtEfwmSnDZ4bhrnZ7iJRok0z92ZFnwqT34fe4o2eUIjbnYFYmX6shpKGIPOvCggxH4urSgwyR/bIopsn8+jMFwtqtHxbjGi1GYoAvq+71Si0nNMeduRyivyus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11050

Hello Sergei,

> From: Sergei Shtylyov, Sent: Wednesday, July 3, 2024 7:22 PM
>=20
> On 7/3/24 1:12 PM, Yoshihiro Shimoda wrote:
>=20
> > Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> > specific firmwre downloading. So, add a document about the firmware
>=20
>    Firmware. :-)
<snip>
> > +Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires spec=
ific
> > +firmwre downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.=
txt"
>=20
>    Again, firmware...

Oops. I'll fix them soon.

Best regards,
Yoshihiro Shimoda

> [...]
>=20
> MBR, Sergey

