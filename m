Return-Path: <linux-pci+bounces-8107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883648D594A
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 06:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DCB1C2302D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850428DC9;
	Fri, 31 May 2024 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3UzHQyYp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF244384;
	Fri, 31 May 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129592; cv=fail; b=COiQAjDa8BNaXBf6yJtU/BNbOSD5ONgtIL8jbSsJg7PhOE9eo32Vtvs1zLn7CzTtf1QNqbw9qURjyJaVQ4ip4M3y3uLsdeK5zgQky5hSFiqqlErwcIFhDwNS+KsnkIsGaqQtjZA9YGRKmBAeGxguM2l3ALuZxlK4pmQu4zWSBLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129592; c=relaxed/simple;
	bh=eZUkk+3ym9gOMmQfSDzbu9qjKQDyr+sM8Fijzqv3PKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cc/Tr1H6UEEhWGu9tDCc58D64ZJ+KvBijXICo2rvwZMWBvsgf0Vx3Y4/zyT7TODcxJn4k+pkqAGXaGfqwn2iDB52u9k6ZAPqTBZuB/JEFaHTyjBnQWj0lellr+N+9C20zKwtHEOQjPxGdqyuWJkDaPQxQ3/FHM+pDGdIORWeJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3UzHQyYp; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY+25o2MwqD4nSvbgXmCCW3SREVjBEaJTUGB7OtJqXri3vYaGaeggD0CWDyDghsxUCQVrafHdq10t7BownerLESXYrDSbo+AL4Awp7MGy6JKc7L/YcDMvvil52714pyF/z6tmQ3TWfqTQlwwhXpevqM64dQCPOfS+fSzZo67fydO7Vi1vVkJYRyGWL5hXliuCVRElEpWyoumuVUNoop0MNlXdXqpSrTMaqoKqPwSdjbjhZ8qAEwy854GJTP2tf1YkC6pxf4p5ze1QR1N4F3gpPa0zwahl7XZ0dkPVjZztpdhUufcCkIrdnGIxtox6EjM8U7qyaFbFjmvox9uud6HIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ecm3IxR2VHpVYVxiXWjNFPmSiHkI+bfSDNHLUis0Zw=;
 b=XZOcCcEwC/71dsn2oB66BSERBuEM0/NiyZV4LusBoOIlDGPLD7V1zEJ8X4geYFmlt44m5pzUMLeRJRtiifq61HgQ8s3KBj2K3VMRphIrVQ9AJK3kC3Fr/mIsvtKHK9D1wFpKTsxtHnAGnBkIwx4N33IvPE6vnfWB/VTnZeAFMYdb+BIiMoO1WtvHYqKoUHEZrCBCn22eYfB4j//nm3Btm4Va5KQmXYUtXJ6NePesVwCTYBJyCImF2aVZrjpZ4Jm+S1l0U+qE3qOyRoCucS+4dEt+jybW7bepf6SBCPvYo4CHkV4VHBHjW6rUKiEJFWDEiopZ88RRp38jDv+18/AVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ecm3IxR2VHpVYVxiXWjNFPmSiHkI+bfSDNHLUis0Zw=;
 b=3UzHQyYp2BP4yTm8cNuJWgPh1Mhd9TpSmanq9GmkdLrXlifuz1NoZ9LtQZUTIkjJO4YQtxt8yH6FZSWk0yqujAu1KkYnCGNDcUzWx1fzLneO+qLhz/gd+mE1KlzqcwF71fIpI4KM1nQnfPaUKYUarSCaloxCXecUZKxufXMdmCA=
Received: from DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) by
 DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Fri, 31 May 2024 04:26:28 +0000
Received: from DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::bfe4:f407:e431:d81f]) by DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::bfe4:f407:e431:d81f%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 04:26:28 +0000
From: "Chang, HaiJun" <HaiJun.Chang@amd.com>
To: "Shi, Lianjie" <Lianjie.Shi@amd.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>, "Zhang, Andy"
	<Andy.Zhang@amd.com>, "Shi, Lianjie" <Lianjie.Shi@amd.com>
Subject: RE: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Thread-Topic: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Thread-Index: AQHarOcBtJrIjaBLckq6krqO8/wYQbGwyqug
Date: Fri, 31 May 2024 04:26:27 +0000
Message-ID:
 <DM6PR12MB49588A7576D6DBE281A4340F81FC2@DM6PR12MB4958.namprd12.prod.outlook.com>
References: <20240523071114.2930804-1-Lianjie.Shi@amd.com>
 <20240523071114.2930804-2-Lianjie.Shi@amd.com>
In-Reply-To: <20240523071114.2930804-2-Lianjie.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ee765cb3-d738-44a1-859e-4f5a2733d7ec;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T04:23:06Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4958:EE_|DS0PR12MB8069:EE_
x-ms-office365-filtering-correlation-id: d0810ff5-bafa-40d9-dfb3-08dc8129d6c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/7j65yb51V/faUHzr3bsBD3KEIMMZtlwaB+WgNtbRdfxSXO1pYtswaVaw4tT?=
 =?us-ascii?Q?Da7NWcEFFoill1TMAyGrSj/qXGggmzzjc8jdw5Q5xYOLzMqfdxENxLhwLu9O?=
 =?us-ascii?Q?Qd02LkCp6WdDjMr1iVYRTfNw6dis9PJtV0m7hj4uFzYeYjy1YF8LdvF+z3yb?=
 =?us-ascii?Q?a596zLmbgHCimV6Q6wuRkWIDlbnpjz90cwuI9O+uWCvE89pO1obluekgJONL?=
 =?us-ascii?Q?P+ZnhOTI9eji3GLesx7EU/2ktEi4N7SSDTgJTNwS/tizqRMtc//q2tURsfKQ?=
 =?us-ascii?Q?PVel6SVnLdl1WmgOMcm35zOp8zUbz/6jw8zvPV1fGR2Iscjfjr/BkwsSsRd3?=
 =?us-ascii?Q?+U0RhEJ+XbPfBMGJXs++S6vh4L6WT5fhxCg53traEwNjie679j9EqGahbDue?=
 =?us-ascii?Q?jgfqS/82bsWLHLW+HE9t/ZKUtx70Rd3FvIDVhGrX3nBSlxOhxsxUwD1GI1vg?=
 =?us-ascii?Q?DTyfK6vK3BgsuYU8xgm48YyiyR3n4hSiJSB1wyXSzCbP6YgdmC+OwWzYuiSU?=
 =?us-ascii?Q?Z+QdOxGvU941ZrAUbTt3pbeXs/DEMn385d486Fy6PXS1R9DCYXZEM2wJtB+U?=
 =?us-ascii?Q?m3kXwPqmLNzXwo00msDJDu4/wZPRDB1b2GHZlp32HhDKTMMrl3HSSTFoU19S?=
 =?us-ascii?Q?dMrXltzYX8rW0O8fqhOqzMpcuNqNLbM+xL+56oLSchBtrlxDWmLIYIKINPMA?=
 =?us-ascii?Q?FcmMow1plVzKZik2F7rlbZVwqGXjIBEPhAETicYYPyj1TKyFVQPvk1ydzPEU?=
 =?us-ascii?Q?rfqMEnxCgdEYQnnAhE65wmV9MmXDGrxc7BuBq8dvaPs/4nN8Lpz2mxrNbCLY?=
 =?us-ascii?Q?J5OhLhssF09YmUv6PZ62tqH4LjZUhq5Z0Cp3for7f8HvjDoqbVbNE4fugmmL?=
 =?us-ascii?Q?YBLmDYVAtOCVfvSzWH9XQPtSogjaINkXvCfP0z5vd5dF2HH0taM2Po766BmQ?=
 =?us-ascii?Q?EA1Ialj63B6ZE8JLAJFpuEM07GckLCGmILGRczqBCCt0Iwoegc2827VnytQc?=
 =?us-ascii?Q?xKlsEqOgZ3Asah3OMu7mmHjmOUCUr6STsr66dj3/BgD/QWR4mRWPOzDjkx5Q?=
 =?us-ascii?Q?TZzpkU0TmuE6wWyTOTWcs/+aGe+K/44iEC9E12x946jbBHuLkJevw4e2MeB7?=
 =?us-ascii?Q?KvohjRqto54Plz4QUMjEd5mVd6K7w1Nt9AlHucLA8o1+W8D6lMC0HLJaBsJ0?=
 =?us-ascii?Q?ZaggeG+9wp3nDPVciLpEb32R2sZG2MyKq/Q8zmjA9pwWAU6Gnq+hNuytdXKt?=
 =?us-ascii?Q?Ox8dXj8Er/Ao6zvpTLmzT16Ptv5hiMfJviX8t+IHpA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4958.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k77o2fXpnfF746G6pnUMz/tEirbyO6saIvLq2IVK8Y4y1EdHPgUBLHKnPguR?=
 =?us-ascii?Q?SYX9RE9KITBl5PrtNXlSVCM7FBU+Eg9foiBhxeMn08TiBJOxguqtU4n3XP4K?=
 =?us-ascii?Q?6Z9XFewweL4FwEw+BouVUz5k5eEqqE/8p/Ue08CimesKYOiOTrWBI1v8KJBS?=
 =?us-ascii?Q?MLsskSrKCtzn739ntvEWQzmO8MRt1+AlTu6HsKHRuGz8OmgHhjIAjinPOv9g?=
 =?us-ascii?Q?lkP5+13bEUlxJm+WoiwS3OUJ8isFiOP5nzzqv9XEVtVRnwrk0knz7PDW2fCX?=
 =?us-ascii?Q?hYvEbpheNYbi8384JMZlS+j0zsi+zX+5SK+voipEnl4XPfPiqtkPlxmtYGQk?=
 =?us-ascii?Q?rh9AMZomp+0hTJazkI243JZsv+6GL6v91s4k9u3aubo3OgOPaaqrn+JPw578?=
 =?us-ascii?Q?vceLHG2gjqDc2wgKiZnCnNd0jy08RvwgLOe0HatGeKPI1EYXsZ3x4zrLWx0x?=
 =?us-ascii?Q?EdqMeLn7HtW2QMZ925gCONIYh12GirVWJQMpVClP4Tf83c+/1/bnGO7sAcw/?=
 =?us-ascii?Q?PUHTk/pzfn2OzkD+9+i+xMXwKnq3SlmqQVT/Rjoo23SiL9dL3rQv2bHLEYY5?=
 =?us-ascii?Q?zBhNyAk0huK0qr1ZsipqIl8JZMUsDwzRtEVexvBr/EXf+nQCIN1IiCNbdjPY?=
 =?us-ascii?Q?cF4+s0P7nj5zcRivJRIj9zh4yTOulAKR7aYhbV67EcPyTSrg4scPXhs8BMA9?=
 =?us-ascii?Q?wG5n5nob96QKXx+LejMupkL5YQ/HjztL6ucDuOxro3rQLLOcSn/Q/Q+tT8K6?=
 =?us-ascii?Q?FHlnN7C4D9of7nP9B8QGKnRY0vzqARKr2ASeGdyi5Jwj7DFK2WPsbiBcBqFA?=
 =?us-ascii?Q?dPewmqQG/K+DUKY8ssamUzeQ0mXsJ/FxupAywEi170TiAzAbRbbhe0wYYkJm?=
 =?us-ascii?Q?D++HQSjxeKoIl3ClbCeCwWfi4/RHS/NISR4TjTPIBEQes5qx9ZmVmKJ7Fc2e?=
 =?us-ascii?Q?dk5TamFz/xZKaOWUxebqe+CRWF+libvPZcgGZJyPIxLJ2PBdBWMAeOF/8ueX?=
 =?us-ascii?Q?gVIiQaSlxnZBv9ngxAKWPA1vZLFiQ71XED6sG6BbbIY+w4Hfk0Ckb8Qmzeqr?=
 =?us-ascii?Q?xLNTVp466yk2T/Ruvb7TJQeyKoMJZEYIl1XWk0eYy9whu4uZEiiTOYwEe2Du?=
 =?us-ascii?Q?csZe+sc1WzSCCSJLIQGPXB7mUD7JdwEEQiq1pbgyEysAg2TKCroDK5cwbKni?=
 =?us-ascii?Q?a0gaK1uin8nVZSM/sGQIMPBmPIvlggP+fROUi90+MWVgQstzHWGSJH+lz2Xx?=
 =?us-ascii?Q?vpF1ycw9zgcbqO7Xg6ssc1mOBRHHLLS248aaVWzwB9LyLjYSapkhQ5oxoyNl?=
 =?us-ascii?Q?bBMmJ97ZAVROmRjSvYI599GSl3xq0ucGEFuBOzqk0wk7ofw5KafmXKNV3ocq?=
 =?us-ascii?Q?KyvGe6t69J3UtcNdQggzNpP+GVen07cfyozQ84cBd0CnSdYR9KKL12Y3j4MQ?=
 =?us-ascii?Q?kjJ04RzITmzy2HuqcJVExnz3BM7hr/Y5H5JcRJ3Q4PDWu8KBaklixi/StNwI?=
 =?us-ascii?Q?R/qBcI4qs5VnOW32PrYUGsbyEtOtkEVZAw8lIS850Wkbei/VsIThudIlG16V?=
 =?us-ascii?Q?pX6yBSGGTzmm6P3QOF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0810ff5-bafa-40d9-dfb3-08dc8129d6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 04:26:27.6047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4H+4g8FyeAktKueqdWSdd1Mmes8ejmqq3MkwJBBdn1sVaIrdEVWA1v9Vamu6IDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

[AMD Official Use Only - AMD Internal Distribution Only]

Hi, Bjorn and pci driver maintainers

Could you review the VF resizable BAR patch?

Thanks,
HaiJun

-----Original Message-----
From: Lianjie Shi <Lianjie.Shi@amd.com>
Sent: Thursday, May 23, 2024 3:11 PM
To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas =
<bhelgaas@google.com>
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Jiang, Jerry (SW) <Jerry.Jiang@am=
d.com>; Zhang, Andy <Andy.Zhang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com=
>
Subject: [PATCH 1/1][v2] PCI: Support VF resizable BAR

Add support for VF resizable BAR PCI extended cap.
Similar to regular BAR, drivers can use pci_resize_resource() to resize an =
IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is resized, but the =
total resource size of the IOV resource should not exceed its original size=
 upon init.

Based on following patch series:
Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/

Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
---
 drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index e5f243dd4..12f86e0=
0a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1867,6 +1867,42 @@ static void pci_restore_rebar_state(struct pci_dev *=
pdev)
        }
 }

+static void pci_restore_vf_rebar_state(struct pci_dev *pdev) { #ifdef
+CONFIG_PCI_IOV
+       unsigned int pos, nbars, i;
+       u32 ctrl;
+       u16 total;
+
+       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
+       if (!pos)
+               return;
+
+       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+       nbars =3D FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+       for (i =3D 0; i < nbars; i++, pos +=3D 8) {
+               struct resource *res;
+               int bar_idx, size;
+               u64 tmp;
+
+               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+               bar_idx =3D ctrl & PCI_REBAR_CTRL_BAR_IDX;
+               total =3D pdev->sriov->total_VFs;
+               if (!total)
+                       return;
+
+               res =3D pdev->resource + bar_idx + PCI_IOV_RESOURCES;
+               tmp =3D resource_size(res);
+               do_div(tmp, total);
+               size =3D pci_rebar_bytes_to_size(tmp);
+               ctrl &=3D ~PCI_REBAR_CTRL_BAR_SIZE;
+               ctrl |=3D FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+               pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+       }
+#endif
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with @@ -1882,6 +1918,7 @@ void pci=
_restore_state(struct pci_dev *dev)
        pci_restore_ats_state(dev);
        pci_restore_vc_state(dev);
        pci_restore_rebar_state(dev);
+       pci_restore_vf_rebar_state(dev);
        pci_restore_dpc_state(dev);
        pci_restore_ptm_state(dev);

@@ -3677,10 +3714,18 @@ void pci_acs_init(struct pci_dev *dev)
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)  {
+       int cap =3D PCI_EXT_CAP_ID_REBAR;
        unsigned int pos, nbars, i;
        u32 ctrl;

-       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+#ifdef CONFIG_PCI_IOV
+       if (bar >=3D PCI_IOV_RESOURCES) {
+               cap =3D PCI_EXT_CAP_ID_VF_REBAR;
+               bar -=3D PCI_IOV_RESOURCES;
+       }
+#endif
+
+       pos =3D pci_find_ext_capability(pdev, cap);
        if (!pos)
                return -ENOTSUPP;

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c index c6d933=
ddf..d978a2ccf 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -427,13 +427,32 @@ void pci_release_resource(struct pci_dev *dev, int re=
sno)  }  EXPORT_SYMBOL(pci_release_resource);

+static int pci_memory_decoding(struct pci_dev *dev, int resno) {
+       u16 cmd;
+
+#ifdef CONFIG_PCI_IOV
+       if (resno >=3D PCI_IOV_RESOURCES) {
+               pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL,=
 &cmd);
+               if (cmd & PCI_SRIOV_CTRL_MSE)
+                       return -EBUSY;
+               else
+                       return 0;
+       }
+#endif
+       pci_read_config_word(dev, PCI_COMMAND, &cmd);
+       if (cmd & PCI_COMMAND_MEMORY)
+               return -EBUSY;
+
+       return 0;
+}
+
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)  {
        struct resource *res =3D dev->resource + resno;
        struct pci_host_bridge *host;
        int old, ret;
        u32 sizes;
-       u16 cmd;

        /* Check if we must preserve the firmware's resource assignment */
        host =3D pci_find_host_bridge(dev->bus); @@ -444,9 +463,9 @@ int pc=
i_resize_resource(struct pci_dev *dev, int resno, int size)
        if (!(res->flags & IORESOURCE_UNSET))
                return -EBUSY;

-       pci_read_config_word(dev, PCI_COMMAND, &cmd);
-       if (cmd & PCI_COMMAND_MEMORY)
-               return -EBUSY;
+       ret =3D pci_memory_decoding(dev, resno);
+       if (ret)
+               return ret;

        sizes =3D pci_rebar_get_possible_sizes(dev, resno);
        if (!sizes)
@@ -463,19 +482,31 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
        if (ret)
                return ret;

-       res->end =3D res->start + pci_rebar_size_to_bytes(size) - 1;
+#ifdef CONFIG_PCI_IOV
+       if (resno >=3D PCI_IOV_RESOURCES)
+               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] =3D pci_rebar_=
size_to_bytes(size);
+       else
+#endif
+               res->end =3D res->start + pci_rebar_size_to_bytes(size) - 1=
;

        /* Check if the new config works by trying to assign everything. */
        if (dev->bus->self) {
                ret =3D pci_reassign_bridge_resources(dev->bus->self, res->=
flags);
-               if (ret)
+               if (ret && ret !=3D -ENOENT)
                        goto error_resize;
        }
        return 0;

 error_resize:
        pci_rebar_set_size(dev, resno, old);
-       res->end =3D res->start + pci_rebar_size_to_bytes(old) - 1;
+
+#ifdef CONFIG_PCI_IOV
+       if (resno >=3D PCI_IOV_RESOURCES)
+               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] =3D pci_rebar_=
size_to_bytes(old);
+       else
+#endif
+               res->end =3D res->start + pci_rebar_size_to_bytes(old) - 1;
+
        return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h =
index a39193213..a66b90982 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -738,6 +738,7 @@
 #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM     0x1F    /* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR        0x24    /* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
--
2.34.1


