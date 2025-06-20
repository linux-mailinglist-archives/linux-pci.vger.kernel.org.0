Return-Path: <linux-pci+bounces-30250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A6AE179A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F77189EAB4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A13284B56;
	Fri, 20 Jun 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="D4h+8Jw/"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012014.outbound.protection.outlook.com [52.101.71.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D368266561
	for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411959; cv=fail; b=JUSKXS00gQDa6/Nh6rSjQseHK/DF8B4HECMhUDKCjLzt0ql5hf0M41xAzw+Iqwf/OSW53qqmMa0GSLOGsIO+fx14AHAtKtnU8eWaqLBnROjyWJ2O9Ld7QfAPR7W1VP/AzsMxC7QbZ3DNHRJwmrjlDMtz9TozpKz4DBW8oYklhZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411959; c=relaxed/simple;
	bh=/S/EMc8vYZpdfcxVMXMUuoWfE7cWnnup9SIAqtucn/s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DamQLwaQFbG6OPYdF8XRse6mxJnmO+9oUv8TMXvafbvcd7+wN5+QzawSd3AgD6aJLMkg4q5yyk7BVCYE7nkvUeY6KMWeEgZUX3mVeFGNtFgRDngTk8dbaf45vmsNbkyqHlgLKmfjKzKhwqVhyEqn54CDX4VRTVM6wzpygnp0yac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=D4h+8Jw/; arc=fail smtp.client-ip=52.101.71.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXslWpQZguSEH/7limf7fITCCuOwF9IHl6ihiBZPv6RcEE/LeAVpx5ujleLVHTVqL4h6mXBHsd3aaaJkm4xEySnYrl/uq7RBLXWg0glJrfMlgO7e2UFYe2qwdFqHyG3CvAZub42lB6zbhgQ3ZDzj1oATge/Tg8J4+DlwgIihFqTPI4BLnlOFRtyMTMBaSmo/8TbfyCPUmjk/vFs7gGbJb90c8afu2ZCguT57itCjOGqlKE0Ocl2GQ6KyFNjwWQBOCu2TnyHbqBfordL9cniWVWhAypAyJriYJysTj3U0hWF21FUPBfWTCnpb04NTTyQlpumJPCWUhy6/gHufizJFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSlWGH1fYeQAtrw11rUonROUOx4Bgu9dWsH70e8A+U0=;
 b=u6OfmoWcUakRKOFwm47iRRC08uWKrlwsoG/yVs24P6qG6tSO5+rhSqF4mrEx1AqM/QtAsfoHroEwzKN8a+CgqjAHZEBZk/t64zmT05Jp9JbYEACYCaVrDRyUdWXf/xfDY17MR3z0eJ7w4GyDPvsLuHtFLOHKz9W+O082wXBfR+gfjtd2oPdrJYYFuVyvbBh3bmhIVY5y9FvNWJpmnI/k46kh/2RICjzil2ZGSFVBZZKqqtRFOJotreVTLnsQ/oe1W0AER8CI+d4DkDBAlYiXqyXCGAuHxSU9miU+jWzEwmncq2Re6VAvohAALVxHfeoP2Ho/zkXGkcQbgZtIZPYwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSlWGH1fYeQAtrw11rUonROUOx4Bgu9dWsH70e8A+U0=;
 b=D4h+8Jw/Kh3ZLKomVNvnVbaqYX9YkkjgMFhr08MAitreto2QygiTmMhZP0dhd1SpxOixpTEUZg3x+guG5EIiNe8CBCV/cMlSLZ2EF6cfw1q9+jZMd6IIJGodg4fXyiN5XVh5+iZfNdmv52NHIOz6gfuS1EL0UqE/MfFwBI73G9vbw+Uu+Gf0pzKlVVASGsh1qmyFbzjWVHJhYUZBwSIYH+bJi+zrJ4cMdSKL9Uu9IAzq00L468B5vcvPUynl57YCtSncWhv/o4/W8pYAqRHq0ibUZv4MAt1AOKX6Ry1KUXaIWcFErtGivKDeEJ6K8XMlL/hJWo6mkbhIO02uNSBUgA==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by AS2PR07MB9080.eurprd07.prod.outlook.com (2603:10a6:20b:547::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 09:32:35 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%6]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 09:32:35 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>
CC: Rob Herring <robh@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address range
 check.
Thread-Topic: [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address
 range check.
Thread-Index: AdvhxgLgWgpdWuT/RTeY5PDrhwzraw==
Date: Fri, 20 Jun 2025 09:32:35 +0000
Message-ID:
 <PA4PR07MB883887374D2E7B59E33A0861FD7CA@PA4PR07MB8838.eurprd07.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|AS2PR07MB9080:EE_
x-ms-office365-filtering-correlation-id: 84a90965-8ce3-4332-9081-08ddafdd63c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kg47YSbxJUZNhrgZde90Uo4ozQcOjHQrZNPPZyKs9gtQs0hW7gk4oubN911o?=
 =?us-ascii?Q?pWtOMxcVP6GVW7mMlGcKaaoPSMZgO7GadMAo93LPUsdWjzAVKIz+MbprQmFm?=
 =?us-ascii?Q?b6GKgCspKqGtP6hPqS1jsdb1+pneu58WT6RHb/ZNlbg73PRZisswPDRtspk2?=
 =?us-ascii?Q?/0sT6zc/ts4hP2qic/j7LFE2hwNB5nx92sHuc/50wJiExkD2J365SvLa0sa2?=
 =?us-ascii?Q?D/mBnJxm7TV2elzP2d7+qZcv75Cl+pC33IDfemiK9CedY5+F3IMLfn2wpF8I?=
 =?us-ascii?Q?oQiVGqF9Z9j8dFIVbm4SzKCI6PBJzyRghKh8pwtwwWf+di7SJROfktOgcIKj?=
 =?us-ascii?Q?CQRnhlY8I/RHyL2xsUljMXvqnqCZowNJL9DJhofxdM7F5/zNTV9CfyaR3URg?=
 =?us-ascii?Q?CyTCxkE8HbGB5lCcMAlwhUYnlEDkq9SpO1H21M9G9aWBBy7LU4Qtkt/+BzSZ?=
 =?us-ascii?Q?6z8DKXKMg19WxTmzQTnCkWwU6CS2gY0kdLqKXpXHMttDen5PsWX1vTgnsLAN?=
 =?us-ascii?Q?EcLkeFT+mI1RxFeYPur/8/Ovfq7wcvwOQHz9pPIfQNvM6sgmA1F/0znOR7ac?=
 =?us-ascii?Q?sVgdVUzAh9DL194/ZKv5SEq/VonhieyWjLCDfzo4OnVrdnEldQiaABeZuqZN?=
 =?us-ascii?Q?G2disqvwR3Sc0EKoSqVQN8tjFFdjh0Vy/Otm81Xv6hyU41EwXe5fFouSGiTI?=
 =?us-ascii?Q?NFB6fRRMpglErhERub89J5vxqQC/ymuqAiTb1v72QhWM49u1GcLB9g/L6sH9?=
 =?us-ascii?Q?f/K5G43X97y4Ml0593F0C2uCTDs3kfhHCXlu9HeNPTQbkJigkvIwZwnlqv9F?=
 =?us-ascii?Q?8jdg3iDVXE4yrGSX8y9cnKjJU/mLghHwJXJAiAeRP9EHswujIu1Alj4Tt9Zb?=
 =?us-ascii?Q?Fw37969XhaKvTovEpTznk9KpYFuLOonQkH8ppUoTfNwY8rFaF3TGoT8pR6PI?=
 =?us-ascii?Q?pZ9gl785oabxN+kTNuJ4jqQ5NKEgAvRWkIM2EK/p4HPvx7/W89U9nM5F+lCk?=
 =?us-ascii?Q?pDl/Spj2jFuTQ23v2XnyzlvuluNscniBO/JACvTJIJwY4/BnMAHmQe2fitkN?=
 =?us-ascii?Q?g4et77KOL+j30kNOohdd+9CC7vSSslUmTMQmNNS2/0jszFRCAGtx+lVoBYoj?=
 =?us-ascii?Q?D6rLOaqvgcfqkB0Lm5EVmYgfWUrl2u1JCLWx5zRP0DKUIUAOQEIJ66lPJOQu?=
 =?us-ascii?Q?R/QRjmeb7iEFDREkQv+v2ZQSAjN1w15DKwIxQZAFzX9F9Cz4/Ho34wiXGYDX?=
 =?us-ascii?Q?PWV+jHuMA+/8fUCJbKvMJZW1dzWROGd8S6EfZ57zPQX3GeF06K0wKjXwI38F?=
 =?us-ascii?Q?5o2MCsZVpX/PP75SeQnXLsObFfHH7iUt4LccyTModps+GHWu/eoMpAK9oc03?=
 =?us-ascii?Q?gTivFijsgyWVefb7csnIRQ7UXB7zykm40urPK9jNav54v78dkb7+iR+/YfVb?=
 =?us-ascii?Q?32zmIMCZXCqrcsjk0MorFQjMpiDGbxQD3XVL75Mdm+M/OpGYh/MtIbPIMpWi?=
 =?us-ascii?Q?Y3OS2yp+axIRXeY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O5b6kvlo/i2GvqgL1IUD0ecr8boVB3mOeOgGZx/qSft48EnTKVGtB3mermgD?=
 =?us-ascii?Q?LHzEXs7VaS5hh4XMtRE1gtZvZUtZ5g+CWREm69d1rpWj8d0rmpiE0kvJ02CD?=
 =?us-ascii?Q?RO0uFccAXwoG2cxpq62/Xzl2h3837RdIQffDFQa243X3M31cNqn4skZg9QV1?=
 =?us-ascii?Q?XIclyOIj9O9JKPZIHgZ3EsbGtPSv9ihLtHZyvhgdqozgNbIXbssOHzN8mesn?=
 =?us-ascii?Q?IhoE2KyHLEfH5jBd9Q7LgHjjDjMbSW0Pspp81zWsESIVHTKP3wOKY7vG908O?=
 =?us-ascii?Q?KdluOnlO9SnOkbjOGgtG1XGgQ2uWEpFLNK5fIsa6qxHjk2Zv/okZ/56crZNU?=
 =?us-ascii?Q?j6pXcs9MVlQu/R72pAJfmDekFTv1KdgePmUl+BsBVGRQG8/q0bKfgTGiivzL?=
 =?us-ascii?Q?f1DZTWQn1QwqW2ekGOFWalwzBfVhF5TUHnNQVgGgUQAWXTcGZFF8MuEzwmEO?=
 =?us-ascii?Q?pTQ60/e1MhPDMAsqMShD8c/QUK5qMEGNzFnoqWRSe0CFvnQoQb0osaicOE5S?=
 =?us-ascii?Q?xsYdCJaenk2DeB5DGNpMr1C2LwBy4BAb6R2jORGfzVK0gUvQPCrWJ8SCySkc?=
 =?us-ascii?Q?4c+pYiaWMH4XAdfOB0xjolkEitQxd0I0n5o3FA2sH00npGqEvQqN+nBW4sK+?=
 =?us-ascii?Q?uQ7ApHr7fOkEjtPCJyfZ54qxB7l4XlyIjhl1Q4Kp1Dabaquice+oKPsR6YkQ?=
 =?us-ascii?Q?hw13I3dgbFWMFh/JWRJqYTpPTVQqnydjW/D4Pl5gCfxlYAEEYoQ8XJViLifW?=
 =?us-ascii?Q?LjIVM2eiU5SGdW144LRGSXfuZ1Bz7rCDxODG8/3dIW7FKXDX5udxdv7irtR4?=
 =?us-ascii?Q?00v9nTA7/lRDM6AjS/YvCQR3cVqN/o6MbD68Px4U85Duzm6W4uOvGRjmdF/1?=
 =?us-ascii?Q?OUP37A3uDbyZgjJbOvk4sj/XVFG3YEln7YK30euAp2SzN3AOeZtB6C4VB9cS?=
 =?us-ascii?Q?SzpPgZQ5tBF8hcmmxNEimsAsGbX21Q/yBTZftXeAtpQv/hI51tYaNtx2iEYu?=
 =?us-ascii?Q?A5keXv5ufLuWhPpyuMxFNgSYhR13k+/Tum4+8MKJ4vnDsXDXJXbvK9RkDA9F?=
 =?us-ascii?Q?2FS9Qqed4OZmS960dxa+V1Fre9IPXMk26krj3M3c3rpn6N1WuLdrIU45eW19?=
 =?us-ascii?Q?4ziyRrgS6KmZDTvpAJAZKtypdDQKxlK83s1xd67uWkEldMEHUIbLxIPqlLQ4?=
 =?us-ascii?Q?e+fUjq0xgbZnvLjnYmB3J5Jf3UAyw4p82xK9zSqsaTGSFS7irt2D3OICVeIU?=
 =?us-ascii?Q?aAyn7mUWlFnCHx/fyZHTcC/okPc2430bLKARYsplK+KblrV8+Fqr8M6GaHuj?=
 =?us-ascii?Q?o06mV7F8vZ2JChiRuCG4/wToNyYAQ7EM/+qbFDhWQ8rDZ9pmw3jdGIP++sCm?=
 =?us-ascii?Q?mcOHMApE8oW96UsySeA+uK6dPhypa6wRw6zPiX/YkjdksgjQ4LlfyzHa/chb?=
 =?us-ascii?Q?Egt2TEMDCr3Ye4s3q0+S0eJ/ztrKAHC5Io2F8sDzZluif4ej/CJHUgTGfqVi?=
 =?us-ascii?Q?F2a2FxegZ+y1NXl4ITPVJIGzAV1ZyCaoB+nSrnuVMarAq7xC1dO2RJIWiZw8?=
 =?us-ascii?Q?n8S2hiX5dLn5VkNFxUFp1D+e41/CaMbOdj7A1M0x?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a90965-8ce3-4332-9081-08ddafdd63c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 09:32:35.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zku5JskKGjc7bxJjNT3m77KDXM2JuR6q6M+H1R/L2dg/foLGgtf2VdFDUHM0JT/ff2XEe20KRj+5AqlVQo+SAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9080

=20
[v4 PATCH 1/1] PCI: of: fix non-prefetchable region address range check.

According to the PCIe spec (PCIe r6.3, sec 7.5.1.3.8), non-prefetchable
memory supports only 32-bit host bridge windows (both base address as
limit address).

In the kernel there is a check that prints a warning if a
non-prefetchable resource's size exceeds the 32-bit limit.

The check currently checks the size of the resource, while actually the
check should be done on the PCIe end address of the non-prefetchable
window.

Move the check to devm_of_pci_get_host_bridge_resources() where the PCIe
addresses are available and use the end address instead of the size of
the window.

Fixes: fede8526cc48 (PCI: of: Warn if non-prefetchable memory aperture
size is > 32-bit)
Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
---

v4:
  - Update warning text

v3:
  - Update subject and description + add changelog

v2:
  - Use PCI address range instead of window size to check that window is
    within a 32bit boundary.

---
 drivers/pci/of.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..16405985a53a 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -400,6 +400,13 @@ static int devm_of_pci_get_host_bridge_resources(struc=
t device *dev,
 			*io_base =3D range.cpu_addr;
 		} else if (resource_type(res) =3D=3D IORESOURCE_MEM) {
 			res->flags &=3D ~IORESOURCE_MEM_64;
+
+			if (!(res->flags & IORESOURCE_PREFETCH))
+				if (upper_32_bits(range.pci_addr + range.size - 1))
+					dev_warn(dev,
+						"host bridge non-prefetchable window: pci range end address exceeds =
32 bit boundary %pR"
+						" (pci address range [%#012llx-%#012llx])\n",
+						res, range.pci_addr, range.pci_addr + range.size - 1);
 		}
=20
 		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
@@ -622,10 +629,6 @@ static int pci_parse_request_of_pci_ranges(struct devi=
ce *dev,
 		case IORESOURCE_MEM:
 			res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
=20
-			if (!(res->flags & IORESOURCE_PREFETCH))
-				if (upper_32_bits(resource_size(res)))
-					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
-
 			break;
 		}
 	}
--=20
2.43.5

