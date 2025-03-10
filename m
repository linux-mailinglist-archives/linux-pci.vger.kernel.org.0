Return-Path: <linux-pci+bounces-23302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07AA59047
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD15D16C1DE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38382253E1;
	Mon, 10 Mar 2025 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="HA6TY1pe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA61224B01
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600269; cv=fail; b=eO/mQP438u5dtGfyKjzlbbVV23Eb946Y9Fb9kO6Hq0Jz5dUH2aT8S1WdMhsw55mCMiBgHK5JJ4idgzolHpe0ZkkaELBjYExwQSycim1LaHyBTU9g1a68Iv4hVHoeX8G0j4mYjRFcyaGHfyAxs42db+jRj1bPXYH+8hEJnpwxMts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600269; c=relaxed/simple;
	bh=QAljpDuNshRvth4huRTzHCs4uyZrz8FK420MEQNl1R8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ovXYuDKPlbdCdFEGEXd72TdzfftkEAkcZMs594g++5e6p8ymWFfXFuGVCBiUmBRbWK4dhAmrRvSZaMs00akfbLM9fO1/yBfPnxp0qiRlnzoRG/9XDuEWW0xCqMrw5b4Ps9X2kEpxRv0C7SXnsWCXWXMy6qRR1WylFaTVlJKw85A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=HA6TY1pe; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jwu8B7jg47+Sx2HtHG+mSJv/c006mfiNxUSZYT+7oddUbOQbiymaCQbBPwWBpRIKkWddSTq4k6Ux1lE3DlTq9On+5Mgabdve6mf2v6TbqLxeDQNuKuE+ZPHtWF56gmAbRXh2OJJul/00gNcKvczbCkIQMg9hR0Dr/TJ4oelLcUdhZ3u9lMaBMOdCgGxq8vfO9qMSE5G2Yxndy2SYr/NXU0iiXqeSLVno0pqKpqJ6NwZEZWIiDBtuc/10aySz8/vuOLElVoDQrCMWBrY/5taIlXqtcjg4ouuo6jOoSasa5uICywMnnyVVnjojju0vEt6U9MWFPiispfpelq0WVzyN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZZlKHo2ATjduutOg2YMy8LV5Oj47xf6O4yvvqoN4kk=;
 b=ceZpDJsfkjHWEfI/LFpYZH9irZ3LMa7pdgPqzq/onozVUT4C8WyXuWaPBQqk0ThbiieaSbwX2ftwfmJ+1EQul3/lTn5mEZ2tnj/JwAZ+8luBfFoewyW6hM3T/ABp4vPHtsu2FjnXVOaPNnfBujwBt8fYU0DBGObSTXxZxQAfgUjP2Rl3ymB8iLRYnod2oz2d+KmSP0PwS9C9b2LEMYLGeIZcTkRAPOumhkz8sRaW5fkLHV+Ox3OyGwtNMYpr1iUDGFwexNg9L6veyYeTjVF/wRKQojbpnuYOEazU5dklcM5Jo06EfKCLYMgnqtqd3zFHjZCSfAJySzEcRJy6UUOxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZZlKHo2ATjduutOg2YMy8LV5Oj47xf6O4yvvqoN4kk=;
 b=HA6TY1pe5nahrfxKfBhtKuaPRRgksJ+QipOfeJ1FxsMdleelKQOtU1v+jExRzchK7b0aVjSxedpofhCQpautD2TJ4kI5UlJjK3HvO32wIqSdO3fByLyYzAimGWj0cu75qvHYyPU4fMPQhejfIdZG50VCi4susJseLp7tyZ/EWkT60tlJGCzWrefRXl73w+PMwOxPFyEupywZnaKOvTR3/kbD2H99lKsB7YQPQCFjOnEr8JxRVbgMLMrs9cZ2o9Ijo2D6UCsPrasp17Cb1vzlxu8n5KoB/cgPt1uBrzN3wXiyl9N9qEjf4IPmIGf/eJGBtrsYIT6F4zPxMNsW7B7nqg==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by VI1PR07MB9948.eurprd07.prod.outlook.com (2603:10a6:800:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:51:03 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:51:03 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Rob Herring <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable windows.
Thread-Topic: Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable windows.
Thread-Index: AduRobXJsAHUjsNzR1qfymrMhkfNeA==
Date: Mon, 10 Mar 2025 09:51:03 +0000
Message-ID:
 <PA4PR07MB8838163AF4B32E0BF74BDFD3FDD62@PA4PR07MB8838.eurprd07.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|VI1PR07MB9948:EE_
x-ms-office365-filtering-correlation-id: 235fb529-7f1a-4a1d-cf6c-08dd5fb91250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CZg9Hxxm43sgeUP9n1cSl8Fz/7LUKp7CUTp3dWS9pK+ltqAVhf4/Vrp8wds7?=
 =?us-ascii?Q?J1dIFLeRG+qRdRXQGaoHeG3T0SCfpTZZVctUBD2fjJVmN6dQ4lOT8iynDyM5?=
 =?us-ascii?Q?nm6u7GFWWDfYVEHOKMmZTOROqmhJhAfI0ehkHJMA+MYu7VOc+FVzJskytoKR?=
 =?us-ascii?Q?DYfkK1Igqu62N2JMb8u/+SfaRV+Q38jP5EpLIyPt0LWT6vCOT+qF6ZxIlsWH?=
 =?us-ascii?Q?b7jf10aqisnZEEEEFexGG5PrKFqGtyTTXdfO+xLY/XNhng313JJfKAOTQyNM?=
 =?us-ascii?Q?ZDWcRY3n/pZI90gENP38/I0u6HEQduc0RMeqHSLTPeOohUCK/kI3829ea+0N?=
 =?us-ascii?Q?YSdyzW82pzre1+2op0K/k1e+nPLupgXLeNyz28nho4ToaizegZZKjIZmXtR3?=
 =?us-ascii?Q?+QJ5oZz8Q3dM7PjP33UilZW1Gk7DXVZHgtRXT2D0WkwEkLRl+Bd3P8HQnuGL?=
 =?us-ascii?Q?LF9CHzclCY0vMZ2VrMUjkiBOsYfrgi8Mrf09UIb4Gdj0cnowRg74q+KaTssG?=
 =?us-ascii?Q?AWtcSI7yElRLoaDaFrq2caDpV6/fvR7ISnqzEfOLYpd2TXDQqtJhi8swKUbE?=
 =?us-ascii?Q?L4R2lC+eJjbinzQKMr3FbhQslTZLWNH1MOyUNXc4iQgpwjArFJd/n7hYQnm0?=
 =?us-ascii?Q?uCciLP7uUl0uNqvqY8vaGIoDFAnn3bBpkJJbpPAzwyMiQcTX4ho1/zIgi04V?=
 =?us-ascii?Q?44c3uHG4GO6hsA9UzokyXlBhuY/CtHoYJX2+W6iDJQqp2N6AFjrJIlPMqCGl?=
 =?us-ascii?Q?cDSFEAtbQjcUuX4YYeH73t9SSLVTFfm4dLvFsPA3gREu/U20w4wQAgqDdDpM?=
 =?us-ascii?Q?Q996mHjn1Idz06Vta5n15dTdjGdYGoCqf6eAIcsgc7Yg0fXt53yeyXMbe6ls?=
 =?us-ascii?Q?W8Y42oNbwvfNV6nixiyHvq2zXj5Xfyb+7kxnQIdQ/Pd7zeoekweQRY9H3ul2?=
 =?us-ascii?Q?KcP+em3NKJFYaOv6bJxa4g2asSv2Xezizwip6LmMuAQaqtgdhXms0DimRQSc?=
 =?us-ascii?Q?HM6RnKP3ZXZTDKDthsykwKYQMH0VHR6SbP4HoF7ocuv8z3DQUbJhzeaJ1OIj?=
 =?us-ascii?Q?/iHMTrtfCgEfgaDKlsR11ciC/JeKFDcXGVNYKkU6Em5znOLvlxi9flLmYRDB?=
 =?us-ascii?Q?g5eZG1H/xF5z4hLT9XA0qIkg1vvB/uZ/aiMpgDx+B4GM2UH4rH2uWRUuSvVF?=
 =?us-ascii?Q?drbMKKPpx5Ws+ojlAnzg+SiseB8XkrTbzl1gRK9GX+dRpFah0b6lki06kss8?=
 =?us-ascii?Q?UUsp3q/qZVKMLN+z673iPxJ/3It42KJrljeSspQI5dwUterA5r9n9V+Xr4Af?=
 =?us-ascii?Q?uBTDkLN/BS/rYlRDsmSnS2LEB+eQLtuuFysdW259LNknSTXf5xqU687CC8QQ?=
 =?us-ascii?Q?XVSIgDYBp+YApHJnz/shXNn/xEPVansg1lxtfKj4H2LR8CjmKymaXk5DJkKh?=
 =?us-ascii?Q?HFoZ6mockfMhJzGUXac/qS1ImLjdWx5J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ju2VbQWT3e8jm+GcVNpQAB82+FMbq39Zhl+QceAZoQIYwCcBunwCjXrSpfHj?=
 =?us-ascii?Q?dEkn+sfrL0RGxwnXUGlpSw1scn4HnNmcumPyyZyIMgEl4PwOcgs16A0weHEk?=
 =?us-ascii?Q?sMX+N9fwOu+64jjaWfZtBUs92XNzoLo3Qfnk6DaZbbGGpt51eaKWmD0i6V6T?=
 =?us-ascii?Q?z0lQhMRE5pTpJfO3kj8jxdpytxsebKNO75ACQK4CPQGEuVPtXmeN7Qa5AD71?=
 =?us-ascii?Q?p+1gR6dA6w5fGESfx49Q6TxHr8YFyGmbdpp7V1DDob7pfpzexzQ22aiS+eWI?=
 =?us-ascii?Q?t95Mm6JDZEOawbCCZxn4Xy4MVUsx74xIEAdII0PmiL20AHp+S4vvM3GVkabZ?=
 =?us-ascii?Q?UCjdF+beTut1A26+ae/ogJ6oOkjy9iGPAqfyYkuizql2tdTGQoIBObmcxsae?=
 =?us-ascii?Q?5bL+ufOpCHPCQz+uam/WYsAQbMIFm9JePv53+1GgWG/9bDuWj1TWoWReldbs?=
 =?us-ascii?Q?4BoCQ9PjAQMSu5az99x8b86rSuM+3yV2e1Lf3gQKHa1F+3OV4+E1pwLaitt4?=
 =?us-ascii?Q?+MpQ8wO4+L+CpLHwffDgdAaFBnIidcpALUpBn1owPZBBbxs3gVUzYywq7MTt?=
 =?us-ascii?Q?PNxuNOmspQLZ32S3HkHs8/QbNrrRbDG8Ci9Z8VRWw5Anq+3s0aoNbXHsAkT+?=
 =?us-ascii?Q?99uKRLTw4Fz7sAsz9KEXbb/az0zRX4b+s3VAnPLBvZqr9k5NWS5yADxahgrL?=
 =?us-ascii?Q?RR74CgaWWgENk/2h3v1w6N/ucwtSt7gI9/UjRXjYF8MIWq2EtqhXq9gOnGeU?=
 =?us-ascii?Q?cgYOPoV3IPlVfTfUFdTc17QEudkgvhews7gaWXXvb9RbPI9GGnK1fHjltWHS?=
 =?us-ascii?Q?yA4Mw+YytvFxD1jGMWuLfPCgu74RyVrzeVVXQTJGzOt/x7scH0to1RwyOpGu?=
 =?us-ascii?Q?bLXm46qAg2OzWsD0y+gLRC3xnhTOcN8aDHiLM/3LS6gI7NoJZ3Jcco04uEO0?=
 =?us-ascii?Q?y9PY+P9glcu3+CLfGVk+CcenllRRPtS/8yMicMp3dQMnffqyhPpiyQY+VE8J?=
 =?us-ascii?Q?qiyycVihYMEYdvqZXvxYpGsQdFbAfhdq4FE5S+xwceldH+31czVAR3DufFb5?=
 =?us-ascii?Q?9HW4C/jA5IS1b4O/O+wWBr8FrQUYv+oDq8HBR7Tj5NzTWfpg78rLcbe4zTU/?=
 =?us-ascii?Q?Lf0w+mUckybYbgnqqut5r5CL/kL8HWTYf1pNRYAeiryX/wpIdxOkyQxjz2v4?=
 =?us-ascii?Q?PN1SQHG+WOU3JDfkjS3Bcvd6xMhOTWF5/vUMuo3kbnjOKTXP3h/oR6TRBl45?=
 =?us-ascii?Q?rHNoRDievY9w+OHYspc5WXYTcc52xPEeH3BRW1TWzQtkLaOL/oZ2HmG3aqNx?=
 =?us-ascii?Q?7+NhBy3WJO7i21FmcnQF7NZ//rC0sHVHFiImJk5tSv9Jj/vhZoBqBdYnvv8u?=
 =?us-ascii?Q?13WFUyf3mCcmhmjqBnZGJ6Td3EHaMIi5WOg363y6tdDVda+/WDnPnEAovme5?=
 =?us-ascii?Q?cuxXv+fqhqkcNpz+n8PZXQiLxsibb0c+jsRMSOIuBOPbrO5zndRom53yuWQq?=
 =?us-ascii?Q?+NfpCnR7/XU9lPpPaAc44Kh4IZYSWdQuhRoyesVsahPzOWYlr/D0aZKMIlrK?=
 =?us-ascii?Q?6dOwnTQJtVTMmKHi8k2lQkZGeaL2RH/yXUDa9UVn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8838.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235fb529-7f1a-4a1d-cf6c-08dd5fb91250
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 09:51:03.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7k6kQAN5cLDL/lPyLhYNUKnwZAwiJ61gBck/y4Z+bJlNf7fn3ZmWpv27FUsZpwnCzhYb68MK05fGJejmEdYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9948

Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable w=
indows.

According to the PCIe spec (PCIe r6.3, sec 7.5.1.3.8), non-prefetchable mem=
ory
supports only 32-bit host bridge windows (both base address as limit addres=
s).

In the kernel there is a check that prints a warning if a
non-prefetchable resource's size exceeds the 32-bit limit.

The check currently checks the size of the resource, while actually the
check should be done on the PCIe end address of the non-prefetchable
window.

Move the check to devm_of_pci_get_host_bridge_resources() where the PCIe
addresses are available and use the end address instead of the size of
the window to avoid warnings for 4 GiB windows.

Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
---
 drivers/pci/of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d20..6523b6dabaa7 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -400,6 +400,10 @@ static int devm_of_pci_get_host_bridge_resources(struc=
t device *dev,
            *io_base =3D range.cpu_addr;
        } else if (resource_type(res) =3D=3D IORESOURCE_MEM) {
            res->flags &=3D ~IORESOURCE_MEM_64;
+
+           if (!(res->flags & IORESOURCE_PREFETCH))
+               if (upper_32_bits(range.pci_addr + range.size - 1))
+                   dev_warn(dev, "Memory resource size exceeds max for 32 =
bits\n");
        }
=20
        pci_add_resource_offset(resources, res, res->start - range.pci_addr=
);
@@ -619,10 +623,6 @@ static int pci_parse_request_of_pci_ranges(struct devi=
ce *dev,
        case IORESOURCE_MEM:
            res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
=20
-           if (!(res->flags & IORESOURCE_PREFETCH))
-               if (upper_32_bits(resource_size(res)))
-                   dev_warn(dev, "Memory resource size exceeds max for 32 =
bits\n");
-
            break;
        }
    }
--=20
2.39.3

