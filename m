Return-Path: <linux-pci+bounces-16477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F343E9C4719
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB2B2F171
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E81AFB35;
	Mon, 11 Nov 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TIYXOFCT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C251B1D61
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357608; cv=fail; b=fu+7AwqbwgbXcapofDb2Fv1S3a+aLA0LRlp1fFsYKWyIJjdO6yzBEFYcKPbaCdN1Z+7SU8wrdzdwyaDGnTG+HMRzkyr8LJmLGR/Cz8idmyPPPZfzTJZz9YDuKkRQtnb9IByACCR3ZeETmxe6uMWZc8Ab2FnEaLC9ULA7SXhy8qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357608; c=relaxed/simple;
	bh=PoC+ZuofesNWLgDlpoDVO05NJqtKoA0UQsdW4j4Ql/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvHWc+883wf67QNwUXAYeDWzl2ODhZMK6cz+xlPscoV+A5way9oI2fo9I9zv/HHOeO+lXYfW6yh5QKtLi9jh56sGGD5ex4BTbMANkmdsNRyyRVslyjhnJAZlXVNDbmK38sDLqDO/mcSZGAEx7/i7/nSmgfC8W7aMuntVaJkWCCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TIYXOFCT; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9RNAdqX2yq4OIa1sQ0XDaaOZ+FcDgMTWsdyDKP0SIfSyTokG03c2MAycHgm3cAqHXn59VGqv0s5UcJwzf6XKZjdvUqSnDlfPyNzLjAGHNsSsiU1JfoVJ7GRprqeBvHeVJdy5P9SkR1/JGLLEzdEurEevF84XBcikbcxT7p5mnJaC7KMEXJeUmovfSa/wwMf/gFcOFDZuP9Ewe0ZhLL7AXhqiL5GoE1T7EF7sQmMJ3tv44QKicD/o+2Hh/ejn5WYZPe7GxgB9IxjM0SGrl3F7t7fd3BvKKYdevxvGy4+kcGtL9Ctorr+Oi55BQBufhk9NrMctYNS90dZYwbpJrxANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJstBasZKBUsGBYjDEULEr+svJuCtj81fF6f9JNXRvk=;
 b=KHt9v/Izjosyetx+WNga29t6ZNKMB6oRhafZJkQXayltLkvQDnLDRTesjPI7ZQQBQ/HxY2f4vbRwD2E+bq41WoOHJeAx7icPhIwr/QS371Pw5CnMCQo6FW2hCdycQoYZcFuqpOqHQC/jL3IH7UyGNZMtY2UOuBG2Prxma5W+ELvZR3qvwkWxxN9+x+lQeqQTembgYhfRZA+V5xPmokDd3d5OmQqmVAur4DSyeizmsUnW+AuaTMBPBErQYgPSNhKzCT7se6GYty0aFG2f+WWfR+W/tks3NJ6rWP+tbaPB6QmW0znn74PLrB9SmeJ8vNeTXIwk2+kGPbyNz9PCQi2fMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJstBasZKBUsGBYjDEULEr+svJuCtj81fF6f9JNXRvk=;
 b=TIYXOFCT3SjYvX6byFEnqg3HnUrrh188fQ5aGeG/4+zCK3zcE5lR7ABUmI6wgTZQbyiQJL80/UUYi6Kefdki6LNaIjRR1v84F3iimS+Z4wE7THakKXLS070MEhQ08K4yCcmoEmqDwHPrixLVrb/btY5ped/CdfQk+cSML/0xAiY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 20:40:02 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 20:40:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Tal Gilboa <talgi@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: Drop duplicate pcie_get_speed_cap(),
 pcie_get_width_cap() declarations
Thread-Topic: [PATCH] PCI: Drop duplicate pcie_get_speed_cap(),
 pcie_get_width_cap() declarations
Thread-Index: AQHbNHloReuAX+UUOEywD6unUAzjsbKyioqg
Date: Mon, 11 Nov 2024 20:40:02 +0000
Message-ID:
 <BL1PR12MB5144EBE7085B566F15D40C40F7582@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241111203624.1817328-1-helgaas@kernel.org>
In-Reply-To: <20241111203624.1817328-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a747c55d-ec2a-4c9d-8028-cdef404906be;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-11T20:39:10Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: cc98728d-e017-4455-37e5-08dd02910484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZrGltBFSms+NydLSGLtUrxQeSN9tkF6i/en58Wv8uGxx8cE6RwvhrvBGSH4D?=
 =?us-ascii?Q?P0QMG8+wbKAgWblZXrGIGFGlLroYWCV8M9XBQKtvgKb0Zgu1jppi17Z9qAlL?=
 =?us-ascii?Q?f8jI/FgSXv5OgG6CEznV5K+aSeJyG5DtsXVF6jjecuB3ixTxAoI+/JPcrq+Q?=
 =?us-ascii?Q?6ZU2K18JfQ2tPIvJzd2kL0KGV35rrIYK1An/u5rHHH8u7nBs7MYqOLtH5vNX?=
 =?us-ascii?Q?50M7zNjeFXLsFlm7a0z0AN+Kh/Okp68Yp+UYS3/HwM4UjZYThrBCT/kBQ3WI?=
 =?us-ascii?Q?Mes5u9bAKWfgBA6mdFQsDjtV/8BwteEjgyGjnuFGwWI+6uMfhgrrsjfJN0sd?=
 =?us-ascii?Q?aQQHhIJ2qCEC9YJ/uoKAoUnVlnei9R3ThONbprRFbseZ4CIVpNDUDnAhY4md?=
 =?us-ascii?Q?f8A8sKoUk27Cc7t2PVXCyFRR5IuGoZF9bctuuWH/7+GTpyuMaaa/uAv3/l7M?=
 =?us-ascii?Q?sV5820gUIB3lSxx54Y+DUR344wT+vUpuTVcGHw27DYY3XHA9N3pEoY0ppli3?=
 =?us-ascii?Q?4qYRGE6IZ+PMV0sexsZb96CnDhoAQMn0IwkmftZsChlG7QBD7K6naxTbPciM?=
 =?us-ascii?Q?U0sgLkQ6z+MFhXLq23VTmPZmiVeUv15JJtH2UDCrVyA/3X7WNbhnMudpikUB?=
 =?us-ascii?Q?fxNNJHbsUzYvzZZQOpIes4VNVJLZMvCDUGEB2TLPHZCd5s+Qr33Vu6aIpOOb?=
 =?us-ascii?Q?JJ4Z0V0bcxaGuIRgOjZGOt2Z/GGDVftdpPqihX/xJxvwvOhOnTz0dWsxHNLV?=
 =?us-ascii?Q?CKLQNV7U/S/O4oK8Qg7A5fI35GT6Oq1vo0gW2RYhFe0gwtZOOGXqmWjxp+yP?=
 =?us-ascii?Q?WxYYW2MtVXwFKKzJRlVpRDBI/JpgPavjWnvqOvLy6ApT5tijNaLJhiMhRpM1?=
 =?us-ascii?Q?tJ0ZjTBmcAYj3xnyU5Nwn33Viwvg+jQvY7RaIQ4qLC1T4YwaZKnIwQVbB4ZQ?=
 =?us-ascii?Q?VF/7NwemR5jyK9ENSxdhygO/a17AlhXeAgCwe0m1upNsxNk2kvv/iEKLhZcc?=
 =?us-ascii?Q?T8cfMlql7Q4sDfA5CDEWg9ukUM+/YXG1K4GGS7jgY5aIN8KgcpyUhe/O42k3?=
 =?us-ascii?Q?NvETYXyzq+R+T0ba0BOHI9SjKwAWbAGbhkqKsNBAdinWSLd5xfRDDm909YtR?=
 =?us-ascii?Q?HlpbHO/Ambi23YH3VbYh9Cyx6CDbgK1oxRSlqCJazkcJ4v8nsvjAUG6cbpSb?=
 =?us-ascii?Q?VjDlj2c558oyNEV9gPKu7lE1xM+ahw0ZAbBvF4D/VhMcShEJF3S3iMNbOCCf?=
 =?us-ascii?Q?5/90oReePOtl2fPUtw0wbdvL2mJ8bdhmhY4gu+wuOezF5fRsZjqwcPv0Sgt0?=
 =?us-ascii?Q?ydF/sHmtaRdetwwl9zchQhPum+Rzr6pniyWwumKer8Jm/L+AoX3d8D/Mtw8q?=
 =?us-ascii?Q?+UxeAX8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Xry4cNERfkAUVF/Bh54erxwQfa9hsQUqJjB1BGBIWdHFLnJNOnWT+n0bJcuC?=
 =?us-ascii?Q?qUYoloW45ZgAFLZoO95d0gs49ndpk9h8S8EEDDxz8P9R78c4ZdAwzT/NW1qZ?=
 =?us-ascii?Q?mPlIoPnk72EezBXmOv/U6wtEOpGKBjfuHt+HCPUgptDemMzoA+q3sLM9LUlE?=
 =?us-ascii?Q?mQ9ph97d5mpIgoisJIv0IWeNgepVwWNsKfpto7yHxaRKwIGpDjWDeXXeRXQt?=
 =?us-ascii?Q?nSiBYfVO2SAtADzD3kJxfo3e35TWJ+TG9xtZcGbStlfeUt/jVV4XwcXurgi7?=
 =?us-ascii?Q?ClA2lqJAOpeKEUh/YfsN2E7ZgSAm9pvuU4CCNKXkkTYPKHHvBLkqqyy3vGma?=
 =?us-ascii?Q?kcW6TKsbrPMFGE1m2PLQP5XRC2CfZVEtMETh1sSn7Q1NLDmMKlezWwk+hxea?=
 =?us-ascii?Q?mqKKYVyIwBRtAXG0W2G6E5OXFhC07y+tq1bRkp9aqArw4dkBu89tkKO5/k6g?=
 =?us-ascii?Q?eDNfYGjORjBsGz0QUpJimZenNcMAnYj065ckI47ft1yphRR5o2Mb44CIB14F?=
 =?us-ascii?Q?vUlQmvrlgaUVwrWz/ZBNQwz2kPiQXnJmZLgry94+XgINctx1jXYzyGDaTZFq?=
 =?us-ascii?Q?toewkkSvE+Ol6a3JLotUJi1m+3e9c+E9EED5HIMHEIL/iGhOsAocFzLb7H5G?=
 =?us-ascii?Q?HeKD7sazrnD0b4R7fBpiZ2FZsmDyJhOxyb3tomEGqsoEFsYQdAjBJ7f8qRUU?=
 =?us-ascii?Q?cIlmwNJl2CJAgK8GSVQUVuOcmwJHFfHfxd83/7Jc23/VerYtpCPToQSbcXp9?=
 =?us-ascii?Q?QfhyqYtmEDC4bDU34P/WidPbno92YEbCB9xa6J9XTrerIbppPjTR+c5HPOwG?=
 =?us-ascii?Q?HgcCbCV5r1LytLn9TUKxsxSo0uvBVkPOpNBIgAog8AyAey+1E5wgnnyeeTDB?=
 =?us-ascii?Q?K9YTmZvJuu2nMoyOVwltISJyhCA2ytBkeN7vlTtqpBS/rFrhOVroV1lPNsK0?=
 =?us-ascii?Q?yHV0GSz/YfH1W6q+9VmMnmo87SGYHx9Qu6Brd0xkSKVuiasmWCjYWJBlFQVT?=
 =?us-ascii?Q?05QeltinGy6238DtpAX2G2O3twMBNNptFobehwnGk/oZEv62fQK/+0VJlQ2z?=
 =?us-ascii?Q?ZYmyXpcHnAlsIV0Jss4UeCp53hh7VCaxiGpqpeCKA5VVNYtRFXN/cCFXcgWp?=
 =?us-ascii?Q?5YyP1Ckzim1iXSkk7U49afZSK1pNoGEct+WVHoA2wagwvlpSVExOhroIRP7p?=
 =?us-ascii?Q?ekhMSNO3IKzvCE+gixc9j/5owmBIRIFb9FUYksue7+rTz8T15CintkNV++fn?=
 =?us-ascii?Q?yueYU7Vo6aCZv/Tim7RyNGpDe5rzAjaxlQFhsiKAmDHwjnIgvOOu7tKvanRp?=
 =?us-ascii?Q?rA5Rzsbs6H9k+G/q2u+MDZc6J0JDO3nI9qo33/VH5+IwaLW2pJ6gni6DhL14?=
 =?us-ascii?Q?N4zWxfJykCNILdPMZxVcmEUGBk0oX/deq8B1x5iZU7grCmpLEiDUuc02jWji?=
 =?us-ascii?Q?k++qetu0z2VcywS+0/0u17ddfXnit9mYbvWrS1rC+fPJN4puA22NzWmh1Vad?=
 =?us-ascii?Q?U6ciuoxhPTgO9px+Ogrr0tlLffslQhUcchVbqQVqz0ueJBjAgPFQ8TePr86I?=
 =?us-ascii?Q?dTlU8V+Uu7g+MR7VXKA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc98728d-e017-4455-37e5-08dd02910484
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 20:40:02.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkrg8SBPlHcrHIWE84xgrBipzuWy9ssipJJQPSZoU3vb43qaTLVOkU4npSkRLzGR3Lm8ewNmADMAsq+Vn3FlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

[Public]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, November 11, 2024 3:36 PM
> To: linux-pci@vger.kernel.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tal Gilboa
> <talgi@mellanox.com>; Bjorn Helgaas <bhelgaas@google.com>
> Subject: [PATCH] PCI: Drop duplicate pcie_get_speed_cap(), pcie_get_width=
_cap()
> declarations
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link
> speed") and c70b65fb7f12 ("PCI: Add pcie_get_width_cap() to find max supp=
orted
> link width") added declarations to drivers/pci/pci.h.
>
> 576c7218a154 ("PCI: Export pcie_get_speed_cap and pcie_get_width_cap")
> subsequently added duplicates to include/linux/pci.h.
>
> Remove the originals from drivers/pci/pci.h.  Both interfaces are used by=
 amdgpu,
> so they must be in include/linux/pci.h.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/pci.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index 7573f81f58c4..1d=
5c519e19b1
> 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -395,8 +395,6 @@ static inline int pcie_dev_speed_mbps(enum
> pci_bus_speed speed)
>
>  u8 pcie_get_supported_speeds(struct pci_dev *dev);  const char
> *pci_speed_string(enum pci_bus_speed speed); -enum pci_bus_speed
> pcie_get_speed_cap(struct pci_dev *dev); -enum pcie_link_width
> pcie_get_width_cap(struct pci_dev *dev);  void __pcie_print_link_status(s=
truct
> pci_dev *dev, bool verbose);  void pcie_report_downtraining(struct pci_de=
v *dev);
>
> --
> 2.34.1


