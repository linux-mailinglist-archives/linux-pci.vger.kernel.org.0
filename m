Return-Path: <linux-pci+bounces-30060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224EADEE99
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E987A3958
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209F2EA753;
	Wed, 18 Jun 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Vpdh2++E"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214F2EA72E
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254982; cv=fail; b=cBgcuQEmUEyQ1cCuCVM6aCvkl54mjhYXvhGMS21Fo/Ni+b5p9ERMWkoSb235pSymabRSAz43+MTTGFeUoMsyH7EHZDEta/8yPywPnZv7f+lB4Fd+/gFGhJOpDay4gFNCWQchSiX0fX6re/ucsvz6kZiktDiZ2Q3DgiQiSQRHFD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254982; c=relaxed/simple;
	bh=QAl5jgSwP0GLAjZJ4TbmjHq7tBeGOYjqfi93jCkinLw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fyJPMYVEpaIMZn5LYkuqd21heAGaTuOauerw8CRC1Tnns5kT0XNG6M0q/b/jRJw0LdtCmLrPE/qpGzMWH3FdAGajVrlL/Ju+eadrrRGmILmR4VZaKIFHcgqTuEGjotKQmw8wOLyvmB7WsnhaS17bxU8TofB+Azjd2oVMZKkTr0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Vpdh2++E; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mytLy7xhYwPWMllaFpYtumQ9lSr5DXVQ1CzpdBC4+T3jb13GxcPwd08iOjE8vmGigv+TxsUsUHgLDMDzpQO1dwrC7jhYR7L0ikpntBVxwT4fHgqFjajEZ6m6ZjMrjyg1BtKrdbE9P1CChvFPtaGcy1eVYZMeUpaja83g/PhWOuY6SjVF2Vbg+eS4A61DZ3/k6CTgYld9qjnM2oRwVaF/PK2mXqrpj7T0EQqre5Oa9SC34RvYgQMsjGcdPWZI5z5Q4Z//qdDKQl4PdUAAWAZaLbTfHAltns9GXLdRim8bf4Nse+VkKvDRpmSKYf55nQBH/3gao8jFM9Ksk83i0pDxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWxX0aHmeehdXMn73Va9KbcklB+KMo744OcVlXD1lhM=;
 b=gI7lNB/dUookzGvpXhMp634rfS9Vk/5Mwmu0pNtpjD26bHVDkYZ8nK8YBrwl5xqRtIB5twcoAKDvJBgZ6Gec3CSq1qYthhvHkqe0iLVS9bGey9wbYDhxeN7bevGE+fPXx2TE4A9Rr0N0faYDR3RBhH+9Ucsz7HjLXPTIUexHkMLEyVNyHifH9RfB6YEjzUMoRtLJlTVzGR6vjyXSDaV0NSWPErrZtH1FYasYrhta/i1oQ+eLo21Zytgepi7w3VL1u644710CrIhLIZ4GuGDB0tYuo0sFqljN983YRHCAO3EDt38VNr+o5BsCWykgJKBxEKk8b+NPPaG39Qb6mIULrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWxX0aHmeehdXMn73Va9KbcklB+KMo744OcVlXD1lhM=;
 b=Vpdh2++EXrnwPYvk1MzWY+2IIOW4o47XN4qwj2D07h6Zb95MFfviUM49cGGK7Sw0CYsSKAhbYcrCpTTobjWJeKl0b3fxXbaFXO7B/dUol5N+Oxz+6KjYaSKf+M69ENmsP9Ztsa9D8PeVNkmVl7yJFi2NKHNaYTit3Bx0whhO1sbUZemyl1WO4j8RTTfApsJ3sLIaSvUn7+w2C2FCyZJPG2z8pkib/jqLn/5Cx9xmovCBFMT0Yhau4H3OmqEQf4XBXB8WX1IyNKoCN0EHHr+Oo9XQnMYdQ64FqfQv2qWennMqb4Pp49/88QMhxzyHa3y9PmUKrYrPZdRcF23U9NjO1Q==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by AM7PR07MB6643.eurprd07.prod.outlook.com (2603:10a6:20b:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Wed, 18 Jun
 2025 13:56:17 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%6]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 13:56:17 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>
CC: Rob Herring <robh@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [v3 PATCH 1/1] PCI: of: fix non-prefetchable region address range
 check.
Thread-Topic: [v3 PATCH 1/1] PCI: of: fix non-prefetchable region address
 range check.
Thread-Index: AdvgWHetQS3k+LLySu6cizU4UuGBiA==
Date: Wed, 18 Jun 2025 13:56:17 +0000
Message-ID:
 <PA4PR07MB88380E01F75CBC2209C23CA0FD72A@PA4PR07MB8838.eurprd07.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|AM7PR07MB6643:EE_
x-ms-office365-filtering-correlation-id: 1315a3f3-b1ee-447c-c4e1-08ddae6fe5e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9E+RpYIAId7pwIHPOSSneIXYJQ+Nb+TQUEM3aSaTUtCExLf6/Q689yU9bJco?=
 =?us-ascii?Q?yRDxVqp2Pvau3R/JfnzSjYvyR3fnkK+Cs89zz7yHa6AaaDnnyN+2Re4cionb?=
 =?us-ascii?Q?JoVgPOdI00kZL+npu8UxjPjIRQ3rxHuIaJIjQ5mbMBR35YvgjUonH56fvWAm?=
 =?us-ascii?Q?q6nUrDGcviUv5Ioh+T18FnzuH8RDHdzISBmevPPi+i2po0RABsUNFjMG1OUZ?=
 =?us-ascii?Q?BLKW/P4YMteTHhMGGFQQRFPPJ3+n4Rvnm4RKYedfY6ZI9pRm08huyVOlJHDI?=
 =?us-ascii?Q?ZUt45citNpP7l+E5ro4TAih1dT4IdDykf2URed4Sx/BktCiZbg1YrC+YoSDZ?=
 =?us-ascii?Q?9tvz1cyQUJuI6UqgpXZUHyEXi8XxKCkKm15y9xHgwNCwTUi+RZ23KhNZaohy?=
 =?us-ascii?Q?ley5EPna1YYBlqJOGVycsCNO3/4PtJvw2LwaPIUCSdKOe3rQBcDp0BEud3eG?=
 =?us-ascii?Q?lVuhe+L5nb51zdR14yG+WPZHERnEgwF59JqSyGPg9wT/7zvp8UJLOJNo8qZ8?=
 =?us-ascii?Q?rd17L1NnrKzPN1b4WYIVGRKzuHChU0UccLPR25fnUoZ/lQG1tg2XZtMrjMb2?=
 =?us-ascii?Q?tjQObsvAouRUImhpUUFR2AaQtmy84ftwE5bGCoC/c4KMc5W4gb68QPTO73eF?=
 =?us-ascii?Q?cSnLVbSDRQjP311MfhWQjjBabBmdGIxdF9X3VlvvmUNDIrxsRVzwX+PGhjgZ?=
 =?us-ascii?Q?eAh+HOQ2c6PZn1HTVtYED9l2vqBGwiLp7NtjO7S0TCFNA2SMwrbS2pklTUKc?=
 =?us-ascii?Q?928mTGO/zT5YTh1PZ/dXpvKqUkLo63I3bMaS4sAaV8YXd2FKtmARbymW9abu?=
 =?us-ascii?Q?/wNmNRq3TF4LA+05WloYVaFctOXQ769msijvZ+uUcFxlZZP8rE+R5dskHyB+?=
 =?us-ascii?Q?hTQx4+3tUuXkEBxBRy4YDCazeEx0qvVGmb2+7/P6ElSwFGlebZ6L9+saQE3o?=
 =?us-ascii?Q?mjUC5HhM1ttyrEbO5r0/DjCticqrsO6ujK4/XTKszREETTmRtiaLrlA/CFjj?=
 =?us-ascii?Q?K1aucg4Bs2bjFaLSS2NojbzSLUBKHuhGLV0/dZapYpRSP3zN8D/3z4gFKPVY?=
 =?us-ascii?Q?rtKJ7OHQqtImEGErldlks/5BChkcuH3BLJ4a3noTZICKOhbLxh9oJkKeszpH?=
 =?us-ascii?Q?6zOlLxy351SD06OKt33LjtU6RC+CvjgnUyYCd4LNhgXDq+DoQZqLz0Vn7nh0?=
 =?us-ascii?Q?lPVFKFXXyFOUIwcWWg6VidJvz19c3ClR/yzFDADTZIFvd/d9AqAnia86Zvg9?=
 =?us-ascii?Q?PfNZyVthrpf3sY19CtfTrhBHhd1ewvwgUTGxpP2K6ITMvhJeai7DAqqY53zr?=
 =?us-ascii?Q?JrDj24hZSAKzU5mTlRhrGDPPYYomD8QA0HzlZbrjP/+j4vNVRYCDZ3FkB3w4?=
 =?us-ascii?Q?0+fu6Ah3PBXmDWILwg3aCHbdj2kWr1Ll9r6AjEFCI1vEV/+WDWnYykw3QmIb?=
 =?us-ascii?Q?rv7djuq7DDHtUT4V9I8fg9Yw2HviV8o6KvF/bGmRwqVTHaxZLD9Dlw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?obnDPamhCppkET5/ZH58bb0b8oIogwq+AQh2LruRo11cFGzPJdw3nWJHatAj?=
 =?us-ascii?Q?79j9vrtpU3oSmkSVxabfIVdDv2S3U3cieExUmNG15swygQ9DtHdYGt631ekc?=
 =?us-ascii?Q?79db+GJRymlTFswmPOex/LHIdlaXYW3yb3YEoBqIqSJfc7rMDdY5AvS0M7on?=
 =?us-ascii?Q?QPYyvJC2RkD4lVKmBbl1HfWtS7oKklWoPqcLwuQv6SOm34DDPod+6JLLkfTz?=
 =?us-ascii?Q?Ej9PoyzpCA6FObxRIWMnn9PhrTw1vZDjfb/QwldhhG8bwUMEBzhoKO8+VV6g?=
 =?us-ascii?Q?oG+1hP3cKi+Qq6AuSUuSnTtooqn3t/EOfggOZ7T1yc6UDoONzo06P1bHSe4Y?=
 =?us-ascii?Q?9l4nidbb+KGgkT4A79b9e4CMUS6aPAHpxq7g0fdx30CR3vmPdI5eHEVkZk/t?=
 =?us-ascii?Q?yF2KJg1++QLqvJgnFVvXdr8QmVndifD+gRKfPMoNzOATXZquzLOQcn3boEny?=
 =?us-ascii?Q?I/24HKa28z6p9/PzqEtrhGxTRMmilVc8DsqXpctDkGfMnbQ9cejDuU4jIRdT?=
 =?us-ascii?Q?XZS4Aq0PRjuKG7qd6Tfb+iKkawoc93VupFOy5WwvuAE4JPX1gNoBwXXJk5yv?=
 =?us-ascii?Q?R8o9hHDyKq7Y/ZSWeDr0KPhwV/Z/GBlboM+ACArWkpnxBhTFYInsHp2V6DSw?=
 =?us-ascii?Q?T8OVWCWYdP/sXmqCrSAIPiMJ/XJ7qknJpFCE7BhmT7lE6lrGHlp8U+kYKD51?=
 =?us-ascii?Q?8p8GsiL5ehjqIRDPuc+qb638eH2k7oskD589Z2oMSmbcpUhXORZI6xgScLyw?=
 =?us-ascii?Q?C7g8bAjUGwvot8o9go3dn4VeGPXrWmXby/y0hYmmxov+ldZE/EnffpqAdvGr?=
 =?us-ascii?Q?5sbOUWeEvosu1X6dA52NNY6sha9BXgXBXeDhpdlYu0Qtyt/mhFqxm5yPjExK?=
 =?us-ascii?Q?vS/hrPRFpu/cS3fK+uEX1uUXW20x4G7Vrjx6iIiI4cFeZ7/yzpquiSKFu6Ex?=
 =?us-ascii?Q?+DclthHfyc3NWOzOWJQbpTRimdrH0h96Wp+TB4uJXziQNGFFdyXG7kAxa0xA?=
 =?us-ascii?Q?E6sK1/DT5Cm7FAPCOB4UVOtz98ND/YMXNEf60MZnCwPb5M2MYd7lJTTGj5Ux?=
 =?us-ascii?Q?SDQP5ZAA4J+UGeXfzqTV0QewRhOwAmrzMUGRgiAgdYWM69d3uc+U8a+B4KJM?=
 =?us-ascii?Q?Gs4br9H57xZZL2qoRJYNXqGEf2GkcdneYJPcAHrn2k7ZqQa9urde3Y55R3EC?=
 =?us-ascii?Q?C94RKaoxJkgxLCxSTX/y4r64bwReGlhMlbwws8J5bZ2/P1Pd4nfKCIkbXXPl?=
 =?us-ascii?Q?h5+JdiDSmPjF88Rcvoejy1X6kX8zmipdyRCw3OY5LogAny24/ZcfMTwD/wsi?=
 =?us-ascii?Q?2QPPRldZWOWzbdLR/rqn0flX7u+BWwAfOkGMNYrIFbIYaI9zr/pQ0/PhPKLI?=
 =?us-ascii?Q?bwhk4phih7jPRttFw80OgO9/OB1Kdgw9mLqrfzoRU5yo0Aj91FBC6jl5Rcf/?=
 =?us-ascii?Q?80eljjJo+zXSK3AdVZMuXEA05WVdthnigsmcduoYIWvFlYgWx0jXR/t0QjJe?=
 =?us-ascii?Q?tvnW8kwqp9rZcv+cmDn4YqIMGOTVo0n3dvWDz55YHLNJJ9c/rjTxdFfCZtfe?=
 =?us-ascii?Q?HPEFtgWrHCxM8Gw7cgVcZk6q622g8htGPsPx7She?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1315a3f3-b1ee-447c-c4e1-08ddae6fe5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 13:56:17.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqPFAxqIKRLX9rIzxwpVObYvNbHhFaYIvTjx3+c/qIkKll9Louh+cqV5GtPbECZD6UrumKcJBxqB3mbQVJJkOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6643

[v3 PATCH 1/1] PCI: of: fix non-prefetchable region address range check.

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

v3:
  - Update subject and description + add changelog

v2:
  - Use PCI address range instead of window size to check that window is
    within a 32bit boundary.

---
 drivers/pci/of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..4fffa32c7c3d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -400,6 +400,10 @@ static int devm_of_pci_get_host_bridge_resources(struc=
t device *dev,
 			*io_base =3D range.cpu_addr;
 		} else if (resource_type(res) =3D=3D IORESOURCE_MEM) {
 			res->flags &=3D ~IORESOURCE_MEM_64;
+
+			if (!(res->flags & IORESOURCE_PREFETCH))
+				if (upper_32_bits(range.pci_addr + range.size - 1))
+					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
 		}
=20
 		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
@@ -622,10 +626,6 @@ static int pci_parse_request_of_pci_ranges(struct devi=
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


