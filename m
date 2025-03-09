Return-Path: <linux-pci+bounces-23209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A1A581C1
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE677A3704
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037D818871F;
	Sun,  9 Mar 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Xlt2hNfV"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9137602D;
	Sun,  9 Mar 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509647; cv=fail; b=RSEwo5gX54ynhhiP1WsgS+2wFxdglun+i98OLDw6eNEEEsIlNlSQhzOSHYbOAP39nqzmsoJ2L+pm7904GMFW/QaqPp8jqeRe6ImAOWNulcGocMevEPweg3PJ8hDLSf5uKceEhIVYZVx+/dhfxrOHA4YVU4CmoPdFxg2ivwG37N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509647; c=relaxed/simple;
	bh=prSwlEWlNqKOU0e9C+chgtO8GADmNFTCZIP8Vr3i6YU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cSYcawQkQBoHGbTVISef4p7D/gpbBjGzZqyihr0wtkfOtyhyU0P/GfB86mYIQNgcUcw/X/7MhIiK0ygURjMr9GU2rf7uHQw7UbWsWMkpAjJKwrG/agAIK81l1KCDk1u6HPec6edyICtw+kigp4luzPBmntJt1mZTJzFmosLY3PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Xlt2hNfV; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCjeE/MX4mO5w1ao/nc08BZ1R5fdXYK6Kfmj3g1y07sSY5fNlIGJ8a3+2JOrBm4Zg+13EY4L/4mbXyG4gggg7RQHP9zsVAMLKqXVEoLtItFW5UJOjBrF2ZHCYd7ki5XB6Um9+Pt/pXRLGxtadQECCbxzUMF7iFvH3JqJPnzVSA6Uaia+7I94yhFi4vQOCLeRm/c6waQjiSd6/PfZM5r+17BYXvjWoL6z39lXH3v/xIQQemvJKZ+0BuH3nYwOHZZwngEoOpeBQ5NJVR/S+LGSFUiFmW0q+pGD9yZ4Xpeq1LXlOoaZRjRZmIc349y+X38y+FEt2DgrGtmlaNgydbNeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToDCWbh+s87CABCZ724bxCrQLrIoBBcKQchepkTlAD0=;
 b=GLOuZ+QXxuUrnxP10lJ4U4fpfDCWBw3suaOxGRUPD+u6hkLvsEQtTXH++vLRVQoKYWDegYoNB9hptWX0n3EfoxUkcuwGBzGTdxt93mTirT6TcA0KOJEQcqrpnraofxyjqjxNX8aRsJ0L8dvtzZQ8CUIsBjll4TZ2oxGiLXdFteGBMxHofjk0NxZhOVpDqUturEe6/BW0XeLCWyWsR71cnlnUuYLyTXPVDYN1xdUfeWaLIJDSAi/IXao/u9uZEAUDRWB0R1aYhUuL9x4+Qnxs0TD6glTDh/arwGnV6uzZ5A4G8FHuJbrvQpFWUsVRKg5D7GA6d9bsDMnLugSL3M7rQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToDCWbh+s87CABCZ724bxCrQLrIoBBcKQchepkTlAD0=;
 b=Xlt2hNfVSnPeM9vINdQxXMMHHDWhwov2DBsPUBtKeM6BbWgxUcpQX27jKuECMjM6AaBmSfjt0K/Z9RdNzov/S0yY/szN1X7q5fUpWsI0WUWGWFykvUDLkIyUlIPXDS8lZ0OqkVLwtj1NU+Po5jr9X8QFL7mXfifJEBPEVwCLlAJ9cWe7w6qfsFen48dAvVPHi+ioPyccxwxiXhIDjrW9HG00nUxAxcqaU2NUKHfQyv9psWp3p6Ys/HI0BfxEaelDr4y9XTdRoQ9NT4vNVOFhRGfjoX7S4NaW6zxC4mj5KitIVDMD3FjegtCgER6crUj+64fNq1E8aH/fGVQXNYNqfw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8698.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 08:40:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 08:40:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Aun-Ali Zaidi
	<admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>
Subject: [PATCH RFC] staging: Add driver to communicate with the T2 Security
 Chip
Thread-Topic: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Index: AQHbkM7qRKJmoMMZ+UqXpy+pXj5Xgw==
Date: Sun, 9 Mar 2025 08:40:31 +0000
Message-ID: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8698:EE_
x-ms-office365-filtering-correlation-id: 6751c9a7-e418-41ad-66d6-08dd5ee60d71
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|12121999004|19110799003|8062599003|461199028|7092599003|15080799006|102099032|3412199025|440099028|21061999003|12071999003|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AYI8h6QaFRYyUZ81XL95M5kRybvbfQpDOB8Rd0ggsbWEyoF3WKEJlo6uFTCa?=
 =?us-ascii?Q?PFM7Fu/p0g679AFUa7elbl1acjeJu9vVOliuzqzGjTplnjZw9u588Pwo0R+y?=
 =?us-ascii?Q?T+fGnMafERtFO5Sw7z1N/MZ5sfsvFAja9JtkPLiKXmR5WIRXWwAnskA+4pYr?=
 =?us-ascii?Q?xGgcGHjhgBvNQfhGXs3vkjpFUhG8wqjS5TcFvrOZRSAD8kmuJmJgurgHl91P?=
 =?us-ascii?Q?uKT3uDKUW6TeObDirhWaJzjmTRR2V/7BV+WPN63TFvSKxXeFMGMJuWtIukO6?=
 =?us-ascii?Q?vHMhvkkK5UKfzYmYW+34O8dgvG8ZU8N1VUO7nGWklI4dGj49YdE5l9lK8OSD?=
 =?us-ascii?Q?Vr4go8Vxq8dUpoXW/N6d4BDfpR/P0tyCeGGDag8v/xLRYRIujZI2XTJPU5pW?=
 =?us-ascii?Q?flnghbe6X251Tbpcpimz/Nc8y4u0jEQT3fEpOzIWBwre9W6S7+Sqw02xGnT0?=
 =?us-ascii?Q?YBNReu9dgydczgjUHQP1vb+GVkO6rvL4bCq8hoSrWWWNJ/hPXPkYRzeJp9Zt?=
 =?us-ascii?Q?iOnrgYZlzKh2tfFRFG9P6apcLjoD9hW4SYQsJyh32KDsXOpq5xIHVrc31Y6P?=
 =?us-ascii?Q?52TRIjEug1pmlTNloz28xWtZLt5jcKr0eOzHNYc/QmYhj+01BGIqFWg/C0UY?=
 =?us-ascii?Q?yecO1rdnxEadBo/cnCP3Ek2AEU/k4zHPL16lSGefXH1F4K0BW6LZjXlh1aCW?=
 =?us-ascii?Q?s6uIKOjADtS2fI/4s3gkDtuLAW3MmDUmcjECTs5uGcByCKr2N9SbvONmAI6N?=
 =?us-ascii?Q?J10W8qffHqOrNJaMwyoxln2JkzWgiVIPtq5y0NGwWs+ePb3qMrXckgPxPoxJ?=
 =?us-ascii?Q?OawWcAGF5jzoY6piGlvupbhwSv4WW53yDbOUF1czo0wQxjOrCp7zRhgYqKZV?=
 =?us-ascii?Q?byuHBGxMIMdxODk3owgbM8dNb5XKHELxEPRFIwEVKroTON9jFQKXX6mIx84T?=
 =?us-ascii?Q?qS2Huf+sX/cK5YvHGY+vdoDVtQOgJwE+vQQ8/mSrYpAh2n1aRT0MuS8Rx4pY?=
 =?us-ascii?Q?e4pbW18wUfT0qTpj12qLFiHbpfn50eGJHeL9dWenoNMP5HLFYTK5J0VLWTVw?=
 =?us-ascii?Q?1+bcNzAsBnJIylhopR0pP8EPrtXOz9KM1fASdMuS8c5lv4uumMmiMax0zC9X?=
 =?us-ascii?Q?04QvQaYlruQimaDgrJKsuQJJs0kdcziONddBpl4ZnJ3SIsBIkNja3JupzT9v?=
 =?us-ascii?Q?6ed4I0QyDs4SYYpCnBDeqTz0vnDze5c4wetHjdDo2jO+lkpW3V1KzlwJL2c?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mIgvwLTHvf2EFiC/m3KtGxuLspDSKROtZPeY06IPr54BkQ8YhMKsdpci1CSw?=
 =?us-ascii?Q?kXPvufGHJ9Bq8dl3Iv0pBnbN/r/PYvJ1cPxSTd/mt3gE7HGYgwmxI/Xio28+?=
 =?us-ascii?Q?CzHyHJ5pJIA4XnX55FFVMb4QQl8M6GXJzXdEcgEM+C9qh4VXGn4tAaOfq1Jg?=
 =?us-ascii?Q?Ggv5P6C/zKBj3PsVkBSyPG+hLnNCXrYH1yDwMFIDwR02tozbzUhEcPSHeJaH?=
 =?us-ascii?Q?s80AlY3h/T4d0TwPnkm9dM6ETZHbrJ2EejIgjEHC3Wy0lSq5e5fBuOL3OzWB?=
 =?us-ascii?Q?P/jE3rqXcpa6FYMqrzdCmRGl7w7IX68AbvFAzXHtiZyjJL8et3kdkXAJHCA9?=
 =?us-ascii?Q?PubFq0w7CVc33dqItuV6PzZkcx17rfL+EFqpAVCAj4PRjuUi3JRXm2yOw+P8?=
 =?us-ascii?Q?HFF9Zg/A54uJMvvQ/BAZwyLq5dQfiW1w8W3J592neM7Q2fRzAJAxZFaOQQ77?=
 =?us-ascii?Q?0NOXkl+m92V43undyVmXkDvGtMyXtix5/xEGvSgawlQQMYBrt24odVD2jpDT?=
 =?us-ascii?Q?fZL67dCcysFA9V2RujDekKyJkuOqe+weKTPFEgg2bYGQ/5kTxfJRGMprcTJE?=
 =?us-ascii?Q?p9Y1UXnNh31GASHhGNloiYvQhHKByz2/qhTWfBhT59o1hTp4eihB6o0HDymi?=
 =?us-ascii?Q?5mqBcSsDrIK5Sp+/h4HW459FSKWv+N50Vhea78VC/LOn01scw0SRJ7YAe3rE?=
 =?us-ascii?Q?G72QO7GuHVCN/VyOMu6ktgNGAeliv4i6eIt6ghqm/PzigY6ldJtq+SrwAQVd?=
 =?us-ascii?Q?mc7O4CFwYEtq4hMMAUgi+whjJwFfWGP4UbLVVRpggbS7vn1GAFMm/0N2TAlJ?=
 =?us-ascii?Q?QAasJYQx2nnVSBxy9I4eUtYhFKEVJSkG8G2viRgnQoIYPmDo1NGyHz79ZOHR?=
 =?us-ascii?Q?bDhcVNFgkZp/6qTIo87C13nFCpTfu+jHBEXalgO/6Bw2kWf5QKwAUQ9gfSoH?=
 =?us-ascii?Q?KkCOk+KFfDUuGRz3mvu0IKzDZ2IrQ7kJBJ4S5tQLtipEX7w4bdVw7ydFsjXA?=
 =?us-ascii?Q?K/z98FC9YOuwE5rMXeiqu1XWfXQFfb5GVm9bUMex4ltt4wKytoP/n/kmbFpx?=
 =?us-ascii?Q?VULHs9pJe5DcALwynsOL2a4NfFuFAed+hzGgfI6x7owZPYTbxMTNzPVuEDQX?=
 =?us-ascii?Q?jGT7e3jiBSS+uplXOU0w9u2hr6DN0grPYPZUY7njhBwPj8qiXXz+FqqJD6PB?=
 =?us-ascii?Q?GiG1Hk+R1Tvm1IWNuMAMgXdF3F8xoy5lRiFLJ+YF7IHmtbEmGZSdQQ3Gt9kj?=
 =?us-ascii?Q?vvc2qrwjLxKj6ZoQHZ2/nCY9kuejex3t7aq+sQfF1Hzkr7xhZ15Dju6AtQeV?=
 =?us-ascii?Q?NDcgdcHfPZFkyquZy6TG2Yrg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <033C293052AC374E8CDCFF039976E4FF@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6751c9a7-e418-41ad-66d6-08dd5ee60d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 08:40:31.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8698

From: Paul Pawlowski <paul@mrarm.io>

This patch adds a driver named apple-bce, to add support for the T2
Security Chip found on certain Macs.

The driver has 3 main components:

BCE (Buffer Copy Engine) - this is what the files in the root directory
are for. This estabilishes a basic communication channel with the T2.
VHCI and Audio both require this component.

VHCI - this is a virtual USB host controller; keyboard, mouse and
other system components are provided by this component (other
drivers use this host controller to provide more functionality).

Audio - a driver for the T2 audio interface, currently only audio
output is supported.

Currently, suspend and resume for VHCI is broken after a firmware
update in iBridge since macOS Sonoma.

Signed-off-by: Paul Pawlowski <paul@mrarm.io>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
drivers/staging/Kconfig                       |   2 +
drivers/staging/Makefile                      |   1 +
drivers/staging/apple-bce/Kconfig             |  18 +
drivers/staging/apple-bce/Makefile            |  28 +
drivers/staging/apple-bce/apple_bce.c         | 448 ++++++++++
drivers/staging/apple-bce/apple_bce.h         |  44 +
drivers/staging/apple-bce/audio/audio.c       | 714 ++++++++++++++++
drivers/staging/apple-bce/audio/audio.h       | 128 +++
drivers/staging/apple-bce/audio/description.h |  45 ++
drivers/staging/apple-bce/audio/pcm.c         | 311 +++++++
drivers/staging/apple-bce/audio/pcm.h         |  19 +
drivers/staging/apple-bce/audio/protocol.c    | 350 ++++++++
drivers/staging/apple-bce/audio/protocol.h    | 148 ++++
.../staging/apple-bce/audio/protocol_bce.c    | 229 ++++++
.../staging/apple-bce/audio/protocol_bce.h    |  75 ++
drivers/staging/apple-bce/mailbox.c           | 154 ++++
drivers/staging/apple-bce/mailbox.h           |  56 ++
drivers/staging/apple-bce/queue.c             | 393 +++++++++
drivers/staging/apple-bce/queue.h             | 180 +++++
drivers/staging/apple-bce/queue_dma.c         | 223 +++++
drivers/staging/apple-bce/queue_dma.h         |  53 ++
drivers/staging/apple-bce/vhci/command.h      | 207 +++++
drivers/staging/apple-bce/vhci/queue.c        | 271 +++++++
drivers/staging/apple-bce/vhci/queue.h        |  79 ++
drivers/staging/apple-bce/vhci/transfer.c     | 664 +++++++++++++++
drivers/staging/apple-bce/vhci/transfer.h     |  76 ++
drivers/staging/apple-bce/vhci/vhci.c         | 764 ++++++++++++++++++
drivers/staging/apple-bce/vhci/vhci.h         |  55 ++
28 files changed, 5735 insertions(+)
create mode 100644 drivers/staging/apple-bce/Kconfig
create mode 100644 drivers/staging/apple-bce/Makefile
create mode 100644 drivers/staging/apple-bce/apple_bce.c
create mode 100644 drivers/staging/apple-bce/apple_bce.h
create mode 100644 drivers/staging/apple-bce/audio/audio.c
create mode 100644 drivers/staging/apple-bce/audio/audio.h
create mode 100644 drivers/staging/apple-bce/audio/description.h
create mode 100644 drivers/staging/apple-bce/audio/pcm.c
create mode 100644 drivers/staging/apple-bce/audio/pcm.h
create mode 100644 drivers/staging/apple-bce/audio/protocol.c
create mode 100644 drivers/staging/apple-bce/audio/protocol.h
create mode 100644 drivers/staging/apple-bce/audio/protocol_bce.c
create mode 100644 drivers/staging/apple-bce/audio/protocol_bce.h
create mode 100644 drivers/staging/apple-bce/mailbox.c
create mode 100644 drivers/staging/apple-bce/mailbox.h
create mode 100644 drivers/staging/apple-bce/queue.c
create mode 100644 drivers/staging/apple-bce/queue.h
create mode 100644 drivers/staging/apple-bce/queue_dma.c
create mode 100644 drivers/staging/apple-bce/queue_dma.h
create mode 100644 drivers/staging/apple-bce/vhci/command.h
create mode 100644 drivers/staging/apple-bce/vhci/queue.c
create mode 100644 drivers/staging/apple-bce/vhci/queue.h
create mode 100644 drivers/staging/apple-bce/vhci/transfer.c
create mode 100644 drivers/staging/apple-bce/vhci/transfer.h
create mode 100644 drivers/staging/apple-bce/vhci/vhci.c
create mode 100644 drivers/staging/apple-bce/vhci/vhci.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 075e775d3..e1cc0d60e 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -50,4 +50,6 @@ source "drivers/staging/vme_user/Kconfig"

source "drivers/staging/gpib/Kconfig"

+source "drivers/staging/apple-bce/Kconfig"
+
endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e681e4035..4045c588b 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_GREYBUS)		+=3D greybus/
obj-$(CONFIG_BCM2835_VCHIQ)	+=3D vc04_services/
obj-$(CONFIG_XIL_AXIS_FIFO)	+=3D axis-fifo/
obj-$(CONFIG_GPIB)	 	+=3D gpib/
+obj-$(CONFIG_APPLE_BCE)		+=3D apple-bce/
diff --git a/drivers/staging/apple-bce/Kconfig b/drivers/staging/apple-bce/=
Kconfig
new file mode 100644
index 000000000..fe92bc441
--- /dev/null
+++ b/drivers/staging/apple-bce/Kconfig
@@ -0,0 +1,18 @@
+config APPLE_BCE
+	tristate "Apple BCE driver (VHCI and Audio support)"
+	default m
+	depends on X86
+	select SOUND
+	select SND
+	select SND_PCM
+	select SND_JACK
+	help
+	  VHCI and audio support on Apple MacBooks with the T2 Chip.
+	  This driver is divided in three components:
+	    - BCE (Buffer Copy Engine): which establishes a basic communication
+	      channel with the T2 chip. This component is required by the other t=
wo:
+	      - VHCI (Virtual Host Controller Interface): Access to keyboard, mou=
se
+	        and other system devices depend on this virtual USB host controll=
er
+	      - Audio: a driver for the T2 audio interface.
+	=20
+	  If "M" is selected, the module will be called apple-bce.'
diff --git a/drivers/staging/apple-bce/Makefile b/drivers/staging/apple-bce=
/Makefile
new file mode 100644
index 000000000..8cfbd3f64
--- /dev/null
+++ b/drivers/staging/apple-bce/Makefile
@@ -0,0 +1,28 @@
+modname :=3D apple-bce
+obj-$(CONFIG_APPLE_BCE) +=3D $(modname).o
+
+apple-bce-objs :=3D apple_bce.o mailbox.o queue.o queue_dma.o vhci/vhci.o =
vhci/queue.o vhci/transfer.o audio/audio.o audio/protocol.o audio/protocol_=
bce.o audio/pcm.o
+
+MY_CFLAGS +=3D -DWITHOUT_NVME_PATCH
+#MY_CFLAGS +=3D -g -DDEBUG
+ccflags-y +=3D ${MY_CFLAGS}
+CC +=3D ${MY_CFLAGS}
+
+KVERSION :=3D $(KERNELRELEASE)
+ifeq ($(origin KERNELRELEASE), undefined)
+KVERSION :=3D $(shell uname -r)
+endif
+
+KDIR :=3D /lib/modules/$(KVERSION)/build
+PWD :=3D $(shell pwd)
+
+.PHONY: all
+
+all:
+	$(MAKE) -C $(KDIR) M=3D$(PWD) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=3D$(PWD) clean
+
+install:
+	$(MAKE) -C $(KDIR) M=3D$(PWD) modules_install
diff --git a/drivers/staging/apple-bce/apple_bce.c b/drivers/staging/apple-=
bce/apple_bce.c
new file mode 100644
index 000000000..c66e0c8d5
--- /dev/null
+++ b/drivers/staging/apple-bce/apple_bce.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "apple_bce.h"
+#include <linux/module.h>
+#include <linux/crc32.h>
+#include "audio/audio.h"
+#include <linux/version.h>
+
+static dev_t bce_chrdev;
+static struct class *bce_class;
+
+struct apple_bce_device *global_bce;
+
+static int bce_create_command_queues(struct apple_bce_device *bce);
+static void bce_free_command_queues(struct apple_bce_device *bce);
+static irqreturn_t bce_handle_mb_irq(int irq, void *dev);
+static irqreturn_t bce_handle_dma_irq(int irq, void *dev);
+static int bce_fw_version_handshake(struct apple_bce_device *bce);
+static int bce_register_command_queue(struct apple_bce_device *bce, struct=
 bce_queue_memcfg *cfg, int is_sq);
+
+static int apple_bce_probe(struct pci_dev *dev, const struct pci_device_id=
 *id)
+{
+	struct apple_bce_device *bce =3D NULL;
+	int status =3D 0;
+	int nvec;
+
+	pr_info("apple-bce: capturing our device\n");
+
+	if (pci_enable_device(dev))
+		return -ENODEV;
+	if (pci_request_regions(dev, "apple-bce")) {
+		status =3D -ENODEV;
+		goto fail;
+	}
+	pci_set_master(dev);
+	nvec =3D pci_alloc_irq_vectors(dev, 1, 8, PCI_IRQ_MSI);
+	if (nvec < 5) {
+		status =3D -EINVAL;
+		goto fail;
+	}
+
+	bce =3D kzalloc(sizeof(struct apple_bce_device), GFP_KERNEL);
+	if (!bce) {
+		status =3D -ENOMEM;
+		goto fail;
+	}
+
+	bce->pci =3D dev;
+	pci_set_drvdata(dev, bce);
+
+	bce->devt =3D bce_chrdev;
+	bce->dev =3D device_create(bce_class, &dev->dev, bce->devt, NULL, "apple-=
bce");
+	if (IS_ERR_OR_NULL(bce->dev)) {
+		status =3D PTR_ERR(bce_class);
+		goto fail;
+	}
+
+	bce->reg_mem_mb =3D pci_iomap(dev, 4, 0);
+	bce->reg_mem_dma =3D pci_iomap(dev, 2, 0);
+
+	if (IS_ERR_OR_NULL(bce->reg_mem_mb) || IS_ERR_OR_NULL(bce->reg_mem_dma)) =
{
+		dev_warn(&dev->dev, "apple-bce: Failed to pci_iomap required regions\n")=
;
+		goto fail;
+	}
+
+	bce_mailbox_init(&bce->mbox, bce->reg_mem_mb);
+	bce_timestamp_init(&bce->timestamp, bce->reg_mem_mb);
+
+	spin_lock_init(&bce->queues_lock);
+	ida_init(&bce->queue_ida);
+
+	if ((status =3D pci_request_irq(dev, 0, bce_handle_mb_irq, NULL, dev, "bc=
e_mbox")))
+		goto fail;
+	if ((status =3D pci_request_irq(dev, 4, NULL, bce_handle_dma_irq, dev, "b=
ce_dma")))
+		goto fail_interrupt_0;
+
+	if ((status =3D dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(37)))) =
{
+		dev_warn(&dev->dev, "dma: Setting mask failed\n");
+		goto fail_interrupt;
+	}
+
+	/* Gets the function 0's interface. This is needed because Apple only acc=
epts DMA on our function if function 0
+	   is a bus master, so we need to work around this. */
+	bce->pci0 =3D pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+#ifndef WITHOUT_NVME_PATCH
+	if ((status =3D pci_enable_device_mem(bce->pci0))) {
+		dev_warn(&dev->dev, "apple-bce: failed to enable function 0\n");
+		goto fail_dev0;
+	}
+#endif
+	pci_set_master(bce->pci0);
+
+	bce_timestamp_start(&bce->timestamp, true);
+
+	if ((status =3D bce_fw_version_handshake(bce)))
+		goto fail_ts;
+	pr_info("apple-bce: handshake done\n");
+
+	if ((status =3D bce_create_command_queues(bce))) {
+		pr_info("apple-bce: Creating command queues failed\n");
+		goto fail_ts;
+	}
+
+	global_bce =3D bce;
+
+	bce_vhci_create(bce, &bce->vhci);
+
+	return 0;
+
+fail_ts:
+	bce_timestamp_stop(&bce->timestamp);
+#ifndef WITHOUT_NVME_PATCH
+	pci_disable_device(bce->pci0);
+fail_dev0:
+#endif
+	pci_dev_put(bce->pci0);
+fail_interrupt:
+	pci_free_irq(dev, 4, dev);
+fail_interrupt_0:
+	pci_free_irq(dev, 0, dev);
+fail:
+	if (bce && bce->dev) {
+		device_destroy(bce_class, bce->devt);
+
+		if (!IS_ERR_OR_NULL(bce->reg_mem_mb))
+			pci_iounmap(dev, bce->reg_mem_mb);
+		if (!IS_ERR_OR_NULL(bce->reg_mem_dma))
+			pci_iounmap(dev, bce->reg_mem_dma);
+
+		kfree(bce);
+	}
+
+	pci_free_irq_vectors(dev);
+	pci_release_regions(dev);
+	pci_disable_device(dev);
+
+	if (!status)
+		status =3D -EINVAL;
+	return status;
+}
+
+static int bce_create_command_queues(struct apple_bce_device *bce)
+{
+	int status;
+	struct bce_queue_memcfg *cfg;
+
+	bce->cmd_cq =3D bce_alloc_cq(bce, 0, 0x20);
+	bce->cmd_cmdq =3D bce_alloc_cmdq(bce, 1, 0x20);
+	if (bce->cmd_cq =3D=3D NULL || bce->cmd_cmdq =3D=3D NULL) {
+		status =3D -ENOMEM;
+		goto err;
+	}
+	bce->queues[0] =3D (struct bce_queue *) bce->cmd_cq;
+	bce->queues[1] =3D (struct bce_queue *) bce->cmd_cmdq->sq;
+
+	cfg =3D kzalloc(sizeof(struct bce_queue_memcfg), GFP_KERNEL);
+	if (!cfg) {
+		status =3D -ENOMEM;
+		goto err;
+	}
+	bce_get_cq_memcfg(bce->cmd_cq, cfg);
+	if ((status =3D bce_register_command_queue(bce, cfg, false)))
+		goto err;
+	bce_get_sq_memcfg(bce->cmd_cmdq->sq, bce->cmd_cq, cfg);
+	if ((status =3D bce_register_command_queue(bce, cfg, true)))
+		goto err;
+	kfree(cfg);
+
+	return 0;
+
+err:
+	if (bce->cmd_cq)
+		bce_free_cq(bce, bce->cmd_cq);
+	if (bce->cmd_cmdq)
+		bce_free_cmdq(bce, bce->cmd_cmdq);
+	return status;
+}
+
+static void bce_free_command_queues(struct apple_bce_device *bce)
+{
+	bce_free_cq(bce, bce->cmd_cq);
+	bce_free_cmdq(bce, bce->cmd_cmdq);
+	bce->cmd_cq =3D NULL;
+	bce->queues[0] =3D NULL;
+}
+
+static irqreturn_t bce_handle_mb_irq(int irq, void *dev)
+{
+	struct apple_bce_device *bce =3D pci_get_drvdata(dev);
+	bce_mailbox_handle_interrupt(&bce->mbox);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bce_handle_dma_irq(int irq, void *dev)
+{
+	int i;
+	struct apple_bce_device *bce =3D pci_get_drvdata(dev);
+	spin_lock(&bce->queues_lock);
+	for (i =3D 0; i < BCE_MAX_QUEUE_COUNT; i++)
+		if (bce->queues[i] && bce->queues[i]->type =3D=3D BCE_QUEUE_CQ)
+			bce_handle_cq_completions(bce, (struct bce_queue_cq *) bce->queues[i]);
+	spin_unlock(&bce->queues_lock);
+	return IRQ_HANDLED;
+}
+
+static int bce_fw_version_handshake(struct apple_bce_device *bce)
+{
+	u64 result;
+	int status;
+
+	if ((status =3D bce_mailbox_send(&bce->mbox, BCE_MB_MSG(BCE_MB_SET_FW_PRO=
TOCOL_VERSION, BC_PROTOCOL_VERSION),
+			&result)))
+		return status;
+	if (BCE_MB_TYPE(result) !=3D BCE_MB_SET_FW_PROTOCOL_VERSION ||
+		BCE_MB_VALUE(result) !=3D BC_PROTOCOL_VERSION) {
+		pr_err("apple-bce: FW version handshake failed %x:%llx\n", BCE_MB_TYPE(r=
esult), BCE_MB_VALUE(result));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int bce_register_command_queue(struct apple_bce_device *bce, struct=
 bce_queue_memcfg *cfg, int is_sq)
+{
+	int status;
+	int cmd_type;
+	u64 result;
+	// OS X uses an bidirectional direction, but that's not really needed
+	dma_addr_t a =3D dma_map_single(&bce->pci->dev, cfg, sizeof(struct bce_qu=
eue_memcfg), DMA_TO_DEVICE);
+	if (dma_mapping_error(&bce->pci->dev, a))
+		return -ENOMEM;
+	cmd_type =3D is_sq ? BCE_MB_REGISTER_COMMAND_SQ : BCE_MB_REGISTER_COMMAND=
_CQ;
+	status =3D bce_mailbox_send(&bce->mbox, BCE_MB_MSG(cmd_type, a), &result)=
;
+	dma_unmap_single(&bce->pci->dev, a, sizeof(struct bce_queue_memcfg), DMA_=
TO_DEVICE);
+	if (status)
+		return status;
+	if (BCE_MB_TYPE(result) !=3D BCE_MB_REGISTER_COMMAND_QUEUE_REPLY)
+		return -EINVAL;
+	return 0;
+}
+
+static void apple_bce_remove(struct pci_dev *dev)
+{
+	struct apple_bce_device *bce =3D pci_get_drvdata(dev);
+	bce->is_being_removed =3D true;
+
+	bce_vhci_destroy(&bce->vhci);
+
+	bce_timestamp_stop(&bce->timestamp);
+#ifndef WITHOUT_NVME_PATCH
+	pci_disable_device(bce->pci0);
+#endif
+	pci_dev_put(bce->pci0);
+	pci_free_irq(dev, 0, dev);
+	pci_free_irq(dev, 4, dev);
+	bce_free_command_queues(bce);
+	pci_iounmap(dev, bce->reg_mem_mb);
+	pci_iounmap(dev, bce->reg_mem_dma);
+	device_destroy(bce_class, bce->devt);
+	pci_free_irq_vectors(dev);
+	pci_release_regions(dev);
+	pci_disable_device(dev);
+	kfree(bce);
+}
+
+static int bce_save_state_and_sleep(struct apple_bce_device *bce)
+{
+	int attempt, status =3D 0;
+	u64 resp;
+	dma_addr_t dma_addr;
+	void *dma_ptr =3D NULL;
+	size_t size =3D max(PAGE_SIZE, 4096UL);
+
+	for (attempt =3D 0; attempt < 5; ++attempt) {
+		pr_debug("apple-bce: suspend: attempt %i, buffer size %li\n", attempt, s=
ize);
+		dma_ptr =3D dma_alloc_coherent(&bce->pci->dev, size, &dma_addr, GFP_KERN=
EL);
+		if (!dma_ptr) {
+			pr_err("apple-bce: suspend failed (data alloc failed)\n");
+			break;
+		}
+		BUG_ON((dma_addr % 4096) !=3D 0);
+		status =3D bce_mailbox_send(&bce->mbox,
+				BCE_MB_MSG(BCE_MB_SAVE_STATE_AND_SLEEP, (dma_addr & ~(4096LLU - 1)) | =
(size / 4096)), &resp);
+		if (status) {
+			pr_err("apple-bce: suspend failed (mailbox send)\n");
+			break;
+		}
+		if (BCE_MB_TYPE(resp) =3D=3D BCE_MB_SAVE_RESTORE_STATE_COMPLETE) {
+			bce->saved_data_dma_addr =3D dma_addr;
+			bce->saved_data_dma_ptr =3D dma_ptr;
+			bce->saved_data_dma_size =3D size;
+			return 0;
+		} else if (BCE_MB_TYPE(resp) =3D=3D BCE_MB_SAVE_STATE_AND_SLEEP_FAILURE)=
 {
+			dma_free_coherent(&bce->pci->dev, size, dma_ptr, dma_addr);
+			/* The 0x10ff magic value was extracted from Apple's driver */
+			size =3D (BCE_MB_VALUE(resp) + 0x10ff) & ~(4096LLU - 1);
+			pr_debug("apple-bce: suspend: device requested a larger buffer (%li)\n"=
, size);
+			continue;
+		} else {
+			pr_err("apple-bce: suspend failed (invalid device response)\n");
+			status =3D -EINVAL;
+			break;
+		}
+	}
+	if (dma_ptr)
+		dma_free_coherent(&bce->pci->dev, size, dma_ptr, dma_addr);
+	if (!status)
+		return bce_mailbox_send(&bce->mbox, BCE_MB_MSG(BCE_MB_SLEEP_NO_STATE, 0)=
, &resp);
+	return status;
+}
+
+static int bce_restore_state_and_wake(struct apple_bce_device *bce)
+{
+	int status;
+	u64 resp;
+	if (!bce->saved_data_dma_ptr) {
+		if ((status =3D bce_mailbox_send(&bce->mbox, BCE_MB_MSG(BCE_MB_RESTORE_N=
O_STATE, 0), &resp))) {
+			pr_err("apple-bce: resume with no state failed (mailbox send)\n");
+			return status;
+		}
+		if (BCE_MB_TYPE(resp) !=3D BCE_MB_RESTORE_NO_STATE) {
+			pr_err("apple-bce: resume with no state failed (invalid device response=
)\n");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	if ((status =3D bce_mailbox_send(&bce->mbox, BCE_MB_MSG(BCE_MB_RESTORE_ST=
ATE_AND_WAKE,
+			(bce->saved_data_dma_addr & ~(4096LLU - 1)) | (bce->saved_data_dma_size=
 / 4096)), &resp))) {
+		pr_err("apple-bce: resume with state failed (mailbox send)\n");
+		goto finish_with_state;
+	}
+	if (BCE_MB_TYPE(resp) !=3D BCE_MB_SAVE_RESTORE_STATE_COMPLETE) {
+		pr_err("apple-bce: resume with state failed (invalid device response)\n"=
);
+		status =3D -EINVAL;
+		goto finish_with_state;
+	}
+
+finish_with_state:
+	dma_free_coherent(&bce->pci->dev, bce->saved_data_dma_size, bce->saved_da=
ta_dma_ptr, bce->saved_data_dma_addr);
+	bce->saved_data_dma_ptr =3D NULL;
+	return status;
+}
+
+static int apple_bce_suspend(struct device *dev)
+{
+	struct apple_bce_device *bce =3D pci_get_drvdata(to_pci_dev(dev));
+	int status;
+
+	bce_timestamp_stop(&bce->timestamp);
+
+	if ((status =3D bce_save_state_and_sleep(bce)))
+		return status;
+
+	return 0;
+}
+
+static int apple_bce_resume(struct device *dev)
+{
+	struct apple_bce_device *bce =3D pci_get_drvdata(to_pci_dev(dev));
+	int status;
+
+	pci_set_master(bce->pci);
+	pci_set_master(bce->pci0);
+
+	if ((status =3D bce_restore_state_and_wake(bce)))
+		return status;
+
+	bce_timestamp_start(&bce->timestamp, false);
+
+	return 0;
+}
+
+static struct pci_device_id apple_bce_ids[  ] =3D {
+		{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x1801) },
+		{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, apple_bce_ids);
+
+static const struct dev_pm_ops apple_bce_pci_driver_pm =3D {
+		.suspend =3D apple_bce_suspend,
+		.resume =3D apple_bce_resume
+};
+static struct pci_driver apple_bce_pci_driver =3D {
+		.name =3D "apple-bce",
+		.id_table =3D apple_bce_ids,
+		.probe =3D apple_bce_probe,
+		.remove =3D apple_bce_remove,
+		.driver =3D {
+			.pm =3D &apple_bce_pci_driver_pm
+		}
+};
+
+
+static int __init apple_bce_module_init(void)
+{
+	int result;
+	if ((result =3D alloc_chrdev_region(&bce_chrdev, 0, 1, "apple-bce")))
+		goto fail_chrdev;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,4,0)
+	bce_class =3D class_create(THIS_MODULE, "apple-bce");
+#else
+	bce_class =3D class_create("apple-bce");
+#endif
+	if (IS_ERR(bce_class)) {
+		result =3D PTR_ERR(bce_class);
+		goto fail_class;
+	}
+	if ((result =3D bce_vhci_module_init())) {
+		pr_err("apple-bce: bce-vhci init failed");
+		goto fail_class;
+	}
+
+	result =3D pci_register_driver(&apple_bce_pci_driver);
+	if (result)
+		goto fail_drv;
+
+	aaudio_module_init();
+
+	return 0;
+
+fail_drv:
+	pci_unregister_driver(&apple_bce_pci_driver);
+fail_class:
+	class_destroy(bce_class);
+fail_chrdev:
+	unregister_chrdev_region(bce_chrdev, 1);
+	if (!result)
+		result =3D -EINVAL;
+	return result;
+}
+static void __exit apple_bce_module_exit(void)
+{
+	pci_unregister_driver(&apple_bce_pci_driver);
+
+	aaudio_module_exit();
+	bce_vhci_module_exit();
+	class_destroy(bce_class);
+	unregister_chrdev_region(bce_chrdev, 1);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("MrARM");
+MODULE_DESCRIPTION("Apple BCE Driver");
+MODULE_VERSION("0.01");
+module_init(apple_bce_module_init);
+module_exit(apple_bce_module_exit);
+
diff --git a/drivers/staging/apple-bce/apple_bce.h b/drivers/staging/apple-=
bce/apple_bce.h
new file mode 100644
index 000000000..417ae029a
--- /dev/null
+++ b/drivers/staging/apple-bce/apple_bce.h
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef APPLEBCE_H
+#define APPLEBCE_H
+
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include "mailbox.h"
+#include "queue.h"
+#include "vhci/vhci.h"
+
+#define BC_PROTOCOL_VERSION 0x20001
+#define BCE_MAX_QUEUE_COUNT 0x100
+
+#define BCE_QUEUE_USER_MIN 2
+#define BCE_QUEUE_USER_MAX (BCE_MAX_QUEUE_COUNT - 1)
+
+struct apple_bce_device {
+	struct pci_dev *pci, *pci0;
+	dev_t devt;
+	struct device *dev;
+	void __iomem *reg_mem_mb;
+	void __iomem *reg_mem_dma;
+	struct bce_mailbox mbox;
+	struct bce_timestamp timestamp;
+	struct bce_queue *queues[BCE_MAX_QUEUE_COUNT];
+	struct spinlock queues_lock;
+	struct ida queue_ida;
+	struct bce_queue_cq *cmd_cq;
+	struct bce_queue_cmdq *cmd_cmdq;
+	struct bce_queue_sq *int_sq_list[BCE_MAX_QUEUE_COUNT];
+	bool is_being_removed;
+
+	dma_addr_t saved_data_dma_addr;
+	void *saved_data_dma_ptr;
+	size_t saved_data_dma_size;
+
+	struct bce_vhci vhci;
+};
+
+extern struct apple_bce_device *global_bce;
+
+#endif //APPLEBCE_H
+
diff --git a/drivers/staging/apple-bce/audio/audio.c b/drivers/staging/appl=
e-bce/audio/audio.c
new file mode 100644
index 000000000..72520715f
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/audio.c
@@ -0,0 +1,714 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/jack.h>
+#include "audio.h"
+#include "pcm.h"
+#include <linux/version.h>
+
+static int aaudio_alsa_index =3D SNDRV_DEFAULT_IDX1;
+static char *aaudio_alsa_id =3D SNDRV_DEFAULT_STR1;
+
+static dev_t aaudio_chrdev;
+static struct class *aaudio_class;
+
+static int aaudio_init_cmd(struct aaudio_device *a);
+static int aaudio_init_bs(struct aaudio_device *a);
+static void aaudio_init_dev(struct aaudio_device *a, aaudio_device_id_t de=
v_id);
+static void aaudio_free_dev(struct aaudio_subdevice *sdev);
+
+static int aaudio_probe(struct pci_dev *dev, const struct pci_device_id *i=
d)
+{
+	struct aaudio_device *aaudio =3D NULL;
+	struct aaudio_subdevice *sdev =3D NULL;
+	int status =3D 0;
+	u32 cfg;
+
+	pr_info("aaudio: capturing our device\n");
+
+	if (pci_enable_device(dev))
+		return -ENODEV;
+	if (pci_request_regions(dev, "aaudio")) {
+		status =3D -ENODEV;
+		goto fail;
+	}
+	pci_set_master(dev);
+
+	aaudio =3D kzalloc(sizeof(struct aaudio_device), GFP_KERNEL);
+	if (!aaudio) {
+		status =3D -ENOMEM;
+		goto fail;
+	}
+
+	aaudio->bce =3D global_bce;
+	if (!aaudio->bce) {
+		dev_warn(&dev->dev, "aaudio: No BCE available\n");
+		status =3D -EINVAL;
+		goto fail;
+	}
+
+	aaudio->pci =3D dev;
+	pci_set_drvdata(dev, aaudio);
+
+	aaudio->devt =3D aaudio_chrdev;
+	aaudio->dev =3D device_create(aaudio_class, &dev->dev, aaudio->devt, NULL=
, "aaudio");
+	if (IS_ERR_OR_NULL(aaudio->dev)) {
+		status =3D PTR_ERR(aaudio_class);
+		goto fail;
+	}
+	device_link_add(aaudio->dev, aaudio->bce->dev, DL_FLAG_PM_RUNTIME | DL_FL=
AG_AUTOREMOVE_CONSUMER);
+
+	init_completion(&aaudio->remote_alive);
+	INIT_LIST_HEAD(&aaudio->subdevice_list);
+
+	/* Init: set an unknown flag in the bitset */
+	if (pci_read_config_dword(dev, 4, &cfg))
+		dev_warn(&dev->dev, "aaudio: pci_read_config_dword fail\n");
+	if (pci_write_config_dword(dev, 4, cfg | 6u))
+		dev_warn(&dev->dev, "aaudio: pci_write_config_dword fail\n");
+
+	dev_info(aaudio->dev, "aaudio: bs len =3D %llx\n", pci_resource_len(dev, =
0));
+	aaudio->reg_mem_bs_dma =3D pci_resource_start(dev, 0);
+	aaudio->reg_mem_bs =3D pci_iomap(dev, 0, 0);
+	aaudio->reg_mem_cfg =3D pci_iomap(dev, 4, 0);
+
+	aaudio->reg_mem_gpr =3D (u32 __iomem *) ((u8 __iomem *) aaudio->reg_mem_c=
fg + 0xC000);
+
+	if (IS_ERR_OR_NULL(aaudio->reg_mem_bs) || IS_ERR_OR_NULL(aaudio->reg_mem_=
cfg)) {
+		dev_warn(&dev->dev, "aaudio: Failed to pci_iomap required regions\n");
+		goto fail;
+	}
+
+	if (aaudio_bce_init(aaudio)) {
+		dev_warn(&dev->dev, "aaudio: Failed to init BCE command transport\n");
+		goto fail;
+	}
+
+	if (snd_card_new(aaudio->dev, aaudio_alsa_index, aaudio_alsa_id, THIS_MOD=
ULE, 0, &aaudio->card)) {
+		dev_err(&dev->dev, "aaudio: Failed to create ALSA card\n");
+		goto fail;
+	}
+
+	strcpy(aaudio->card->shortname, "Apple T2 Audio");
+	strcpy(aaudio->card->longname, "Apple T2 Audio");
+	strcpy(aaudio->card->mixername, "Apple T2 Audio");
+	/* Dynamic alsa ids start at 100 */
+	aaudio->next_alsa_id =3D 100;
+
+	if (aaudio_init_cmd(aaudio)) {
+		dev_err(&dev->dev, "aaudio: Failed to initialize over BCE\n");
+		goto fail_snd;
+	}
+
+	if (aaudio_init_bs(aaudio)) {
+		dev_err(&dev->dev, "aaudio: Failed to initialize BufferStruct\n");
+		goto fail_snd;
+	}
+
+	if ((status =3D aaudio_cmd_set_remote_access(aaudio, AAUDIO_REMOTE_ACCESS=
_ON))) {
+		dev_err(&dev->dev, "Failed to set remote access\n");
+		return status;
+	}
+
+	if (snd_card_register(aaudio->card)) {
+		dev_err(&dev->dev, "aaudio: Failed to register ALSA sound device\n");
+		goto fail_snd;
+	}
+
+	list_for_each_entry(sdev, &aaudio->subdevice_list, list) {
+		struct aaudio_buffer_struct_device *dev =3D &aaudio->bs->devices[sdev->b=
uf_id];
+
+		if (sdev->out_stream_cnt =3D=3D 1 && !strcmp(dev->name, "Speaker")) {
+			struct snd_pcm_hardware *hw =3D sdev->out_streams[0].alsa_hw_desc;
+
+			snprintf(aaudio->card->driver, sizeof(aaudio->card->driver) / sizeof(ch=
ar), "AppleT2x%d", hw->channels_min);
+		}
+	}
+
+	return 0;
+
+fail_snd:
+	snd_card_free(aaudio->card);
+fail:
+	if (aaudio && aaudio->dev)
+		device_destroy(aaudio_class, aaudio->devt);
+	kfree(aaudio);
+
+	if (!IS_ERR_OR_NULL(aaudio->reg_mem_bs))
+		pci_iounmap(dev, aaudio->reg_mem_bs);
+	if (!IS_ERR_OR_NULL(aaudio->reg_mem_cfg))
+		pci_iounmap(dev, aaudio->reg_mem_cfg);
+
+	pci_release_regions(dev);
+	pci_disable_device(dev);
+
+	if (!status)
+		status =3D -EINVAL;
+	return status;
+}
+
+
+
+static void aaudio_remove(struct pci_dev *dev)
+{
+	struct aaudio_subdevice *sdev;
+	struct aaudio_device *aaudio =3D pci_get_drvdata(dev);
+
+	snd_card_free(aaudio->card);
+	while (!list_empty(&aaudio->subdevice_list)) {
+		sdev =3D list_first_entry(&aaudio->subdevice_list, struct aaudio_subdevi=
ce, list);
+		list_del(&sdev->list);
+		aaudio_free_dev(sdev);
+	}
+	pci_iounmap(dev, aaudio->reg_mem_bs);
+	pci_iounmap(dev, aaudio->reg_mem_cfg);
+	device_destroy(aaudio_class, aaudio->devt);
+	pci_free_irq_vectors(dev);
+	pci_release_regions(dev);
+	pci_disable_device(dev);
+	kfree(aaudio);
+}
+
+static int aaudio_suspend(struct device *dev)
+{
+	struct aaudio_device *aaudio =3D pci_get_drvdata(to_pci_dev(dev));
+
+	if (aaudio_cmd_set_remote_access(aaudio, AAUDIO_REMOTE_ACCESS_OFF))
+		dev_warn(aaudio->dev, "Failed to reset remote access\n");
+
+	pci_disable_device(aaudio->pci);
+	return 0;
+}
+
+static int aaudio_resume(struct device *dev)
+{
+	int status;
+	struct aaudio_device *aaudio =3D pci_get_drvdata(to_pci_dev(dev));
+
+	if ((status =3D pci_enable_device(aaudio->pci)))
+		return status;
+	pci_set_master(aaudio->pci);
+
+	if ((status =3D aaudio_cmd_set_remote_access(aaudio, AAUDIO_REMOTE_ACCESS=
_ON))) {
+		dev_err(aaudio->dev, "Failed to set remote access\n");
+		return status;
+	}
+
+	return 0;
+}
+
+static int aaudio_init_cmd(struct aaudio_device *a)
+{
+	int status;
+	struct aaudio_send_ctx sctx;
+	struct aaudio_msg buf;
+	u64 dev_cnt, dev_i;
+	aaudio_device_id_t *dev_l;
+
+	if ((status =3D aaudio_send(a, &sctx, 500,
+							  aaudio_msg_write_alive_notification, 1, 3))) {
+		dev_err(a->dev, "Sending alive notification failed\n");
+		return status;
+	}
+
+	if (wait_for_completion_timeout(&a->remote_alive, msecs_to_jiffies(500)) =
=3D=3D 0) {
+		dev_err(a->dev, "Timed out waiting for remote\n");
+		return -ETIMEDOUT;
+	}
+	dev_info(a->dev, "Continuing init\n");
+
+	buf =3D aaudio_reply_alloc();
+	if ((status =3D aaudio_cmd_get_device_list(a, &buf, &dev_l, &dev_cnt))) {
+		dev_err(a->dev, "Failed to get device list\n");
+		aaudio_reply_free(&buf);
+		return status;
+	}
+	for (dev_i =3D 0; dev_i < dev_cnt; ++dev_i)
+		aaudio_init_dev(a, dev_l[dev_i]);
+	aaudio_reply_free(&buf);
+
+	return 0;
+}
+
+static void aaudio_init_stream_info(struct aaudio_subdevice *sdev, struct =
aaudio_stream *strm);
+static void aaudio_handle_jack_connection_change(struct aaudio_subdevice *=
sdev);
+
+static void aaudio_init_dev(struct aaudio_device *a, aaudio_device_id_t de=
v_id)
+{
+	struct aaudio_subdevice *sdev;
+	struct aaudio_msg buf =3D aaudio_reply_alloc();
+	u64 uid_len, stream_cnt, i;
+	aaudio_object_id_t *stream_list;
+	char *uid;
+
+	sdev =3D kzalloc(sizeof(struct aaudio_subdevice), GFP_KERNEL);
+
+	if (aaudio_cmd_get_property(a, &buf, dev_id, dev_id, AAUDIO_PROP(AAUDIO_P=
ROP_SCOPE_GLOBAL, AAUDIO_PROP_UID, 0),
+			NULL, 0, (void **) &uid, &uid_len) || uid_len > AAUDIO_DEVICE_MAX_UID_L=
EN) {
+		dev_err(a->dev, "Failed to get device uid for device %llx\n", dev_id);
+		goto fail;
+	}
+	dev_info(a->dev, "Remote device %llx %.*s\n", dev_id, (int) uid_len, uid)=
;
+
+	sdev->a =3D a;
+	INIT_LIST_HEAD(&sdev->list);
+	sdev->dev_id =3D dev_id;
+	sdev->buf_id =3D AAUDIO_BUFFER_ID_NONE;
+	strncpy(sdev->uid, uid, uid_len);
+	sdev->uid[uid_len + 1] =3D '\0';
+
+	if (aaudio_cmd_get_primitive_property(a, dev_id, dev_id,
+			AAUDIO_PROP(AAUDIO_PROP_SCOPE_INPUT, AAUDIO_PROP_LATENCY, 0), NULL, 0, =
&sdev->in_latency, sizeof(u32)))
+		dev_warn(a->dev, "Failed to query device input latency\n");
+	if (aaudio_cmd_get_primitive_property(a, dev_id, dev_id,
+			AAUDIO_PROP(AAUDIO_PROP_SCOPE_OUTPUT, AAUDIO_PROP_LATENCY, 0), NULL, 0,=
 &sdev->out_latency, sizeof(u32)))
+		dev_warn(a->dev, "Failed to query device output latency\n");
+
+	if (aaudio_cmd_get_input_stream_list(a, &buf, dev_id, &stream_list, &stre=
am_cnt)) {
+		dev_err(a->dev, "Failed to get input stream list for device %llx\n", dev=
_id);
+		goto fail;
+	}
+	if (stream_cnt > AAUDIO_DEIVCE_MAX_INPUT_STREAMS) {
+		dev_warn(a->dev, "Device %s input stream count %llu is larger than the s=
upported count of %u\n",
+				sdev->uid, stream_cnt, AAUDIO_DEIVCE_MAX_INPUT_STREAMS);
+		stream_cnt =3D AAUDIO_DEIVCE_MAX_INPUT_STREAMS;
+	}
+	sdev->in_stream_cnt =3D stream_cnt;
+	for (i =3D 0; i < stream_cnt; i++) {
+		sdev->in_streams[i].id =3D stream_list[i];
+		sdev->in_streams[i].buffer_cnt =3D 0;
+		aaudio_init_stream_info(sdev, &sdev->in_streams[i]);
+		sdev->in_streams[i].latency +=3D sdev->in_latency;
+	}
+
+	if (aaudio_cmd_get_output_stream_list(a, &buf, dev_id, &stream_list, &str=
eam_cnt)) {
+		dev_err(a->dev, "Failed to get output stream list for device %llx\n", de=
v_id);
+		goto fail;
+	}
+	if (stream_cnt > AAUDIO_DEIVCE_MAX_OUTPUT_STREAMS) {
+		dev_warn(a->dev, "Device %s input stream count %llu is larger than the s=
upported count of %u\n",
+				 sdev->uid, stream_cnt, AAUDIO_DEIVCE_MAX_OUTPUT_STREAMS);
+		stream_cnt =3D AAUDIO_DEIVCE_MAX_OUTPUT_STREAMS;
+	}
+	sdev->out_stream_cnt =3D stream_cnt;
+	for (i =3D 0; i < stream_cnt; i++) {
+		sdev->out_streams[i].id =3D stream_list[i];
+		sdev->out_streams[i].buffer_cnt =3D 0;
+		aaudio_init_stream_info(sdev, &sdev->out_streams[i]);
+		sdev->out_streams[i].latency +=3D sdev->in_latency;
+	}
+
+	if (sdev->is_pcm)
+		aaudio_create_pcm(sdev);
+	/* Headphone Jack status */
+	if (!strcmp(sdev->uid, "Codec Output")) {
+		if (snd_jack_new(a->card, sdev->uid, SND_JACK_HEADPHONE, &sdev->jack, tr=
ue, false))
+			dev_warn(a->dev, "Failed to create an attached jack for %s\n", sdev->ui=
d);
+		aaudio_cmd_property_listener(a, sdev->dev_id, sdev->dev_id,
+				AAUDIO_PROP(AAUDIO_PROP_SCOPE_OUTPUT, AAUDIO_PROP_JACK_PLUGGED, 0));
+		aaudio_handle_jack_connection_change(sdev);
+	}
+
+	aaudio_reply_free(&buf);
+
+	list_add_tail(&sdev->list, &a->subdevice_list);
+	return;
+
+fail:
+	aaudio_reply_free(&buf);
+	kfree(sdev);
+}
+
+static void aaudio_init_stream_info(struct aaudio_subdevice *sdev, struct =
aaudio_stream *strm)
+{
+	if (aaudio_cmd_get_primitive_property(sdev->a, sdev->dev_id, strm->id,
+			AAUDIO_PROP(AAUDIO_PROP_SCOPE_GLOBAL, AAUDIO_PROP_PHYS_FORMAT, 0), NULL=
, 0,
+			&strm->desc, sizeof(strm->desc)))
+		dev_warn(sdev->a->dev, "Failed to query stream descriptor\n");
+	if (aaudio_cmd_get_primitive_property(sdev->a, sdev->dev_id, strm->id,
+			AAUDIO_PROP(AAUDIO_PROP_SCOPE_GLOBAL, AAUDIO_PROP_LATENCY, 0), NULL, 0,=
 &strm->latency, sizeof(u32)))
+		dev_warn(sdev->a->dev, "Failed to query stream latency\n");
+	if (strm->desc.format_id =3D=3D AAUDIO_FORMAT_LPCM)
+		sdev->is_pcm =3D true;
+}
+
+static void aaudio_free_dev(struct aaudio_subdevice *sdev)
+{
+	size_t i;
+	for (i =3D 0; i < sdev->in_stream_cnt; i++) {
+		if (sdev->in_streams[i].alsa_hw_desc)
+			kfree(sdev->in_streams[i].alsa_hw_desc);
+		if (sdev->in_streams[i].buffers)
+			kfree(sdev->in_streams[i].buffers);
+	}
+	for (i =3D 0; i < sdev->out_stream_cnt; i++) {
+		if (sdev->out_streams[i].alsa_hw_desc)
+			kfree(sdev->out_streams[i].alsa_hw_desc);
+		if (sdev->out_streams[i].buffers)
+			kfree(sdev->out_streams[i].buffers);
+	}
+	kfree(sdev);
+}
+
+static struct aaudio_subdevice *aaudio_find_dev_by_dev_id(struct aaudio_de=
vice *a, aaudio_device_id_t dev_id)
+{
+	struct aaudio_subdevice *sdev;
+	list_for_each_entry(sdev, &a->subdevice_list, list) {
+		if (dev_id =3D=3D sdev->dev_id)
+			return sdev;
+	}
+	return NULL;
+}
+
+static struct aaudio_subdevice *aaudio_find_dev_by_uid(struct aaudio_devic=
e *a, const char *uid)
+{
+	struct aaudio_subdevice *sdev;
+	list_for_each_entry(sdev, &a->subdevice_list, list) {
+		if (!strcmp(uid, sdev->uid))
+			return sdev;
+	}
+	return NULL;
+}
+
+static void aaudio_init_bs_stream(struct aaudio_device *a, struct aaudio_s=
tream *strm,
+		struct aaudio_buffer_struct_stream *bs_strm);
+static void aaudio_init_bs_stream_host(struct aaudio_device *a, struct aau=
dio_stream *strm,
+		struct aaudio_buffer_struct_stream *bs_strm);
+
+static int aaudio_init_bs(struct aaudio_device *a)
+{
+	int i, j;
+	struct aaudio_buffer_struct_device *dev;
+	struct aaudio_subdevice *sdev;
+	u32 ver, sig, bs_base;
+
+	ver =3D ioread32(&a->reg_mem_gpr[0]);
+	if (ver < 3) {
+		dev_err(a->dev, "aaudio: Bad GPR version (%u)", ver);
+		return -EINVAL;
+	}
+	sig =3D ioread32(&a->reg_mem_gpr[1]);
+	if (sig !=3D AAUDIO_SIG) {
+		dev_err(a->dev, "aaudio: Bad GPR sig (%x)", sig);
+		return -EINVAL;
+	}
+	bs_base =3D ioread32(&a->reg_mem_gpr[2]);
+	a->bs =3D (struct aaudio_buffer_struct *) ((u8 *) a->reg_mem_bs + bs_base=
);
+	if (a->bs->signature !=3D AAUDIO_SIG) {
+		dev_err(a->dev, "aaudio: Bad BufferStruct sig (%x)", a->bs->signature);
+		return -EINVAL;
+	}
+	dev_info(a->dev, "aaudio: BufferStruct ver =3D %i\n", a->bs->version);
+	dev_info(a->dev, "aaudio: Num devices =3D %i\n", a->bs->num_devices);
+	for (i =3D 0; i < a->bs->num_devices; i++) {
+		dev =3D &a->bs->devices[i];
+		dev_info(a->dev, "aaudio: Device %i %s\n", i, dev->name);
+
+		sdev =3D aaudio_find_dev_by_uid(a, dev->name);
+		if (!sdev) {
+			dev_err(a->dev, "aaudio: Subdevice not found for BufferStruct device %s=
\n", dev->name);
+			continue;
+		}
+		sdev->buf_id =3D (u8) i;
+		dev->num_input_streams =3D 0;
+		for (j =3D 0; j < dev->num_output_streams; j++) {
+			dev_info(a->dev, "aaudio: Device %i Stream %i: Output; Buffer Count =3D=
 %i\n", i, j,
+					 dev->output_streams[j].num_buffers);
+			if (j < sdev->out_stream_cnt)
+				aaudio_init_bs_stream(a, &sdev->out_streams[j], &dev->output_streams[j=
]);
+		}
+	}
+
+	list_for_each_entry(sdev, &a->subdevice_list, list) {
+		if (sdev->buf_id !=3D AAUDIO_BUFFER_ID_NONE)
+			continue;
+		sdev->buf_id =3D i;
+		dev_info(a->dev, "aaudio: Created device %i %s\n", i, sdev->uid);
+		strcpy(a->bs->devices[i].name, sdev->uid);
+		a->bs->devices[i].num_input_streams =3D 0;
+		a->bs->devices[i].num_output_streams =3D 0;
+		a->bs->num_devices =3D ++i;
+	}
+	list_for_each_entry(sdev, &a->subdevice_list, list) {
+		if (sdev->in_stream_cnt =3D=3D 1) {
+			dev_info(a->dev, "aaudio: Device %i Host Stream; Input\n", sdev->buf_id=
);
+			aaudio_init_bs_stream_host(a, &sdev->in_streams[0], &a->bs->devices[sde=
v->buf_id].input_streams[0]);
+			a->bs->devices[sdev->buf_id].num_input_streams =3D 1;
+			wmb();
+
+			if (aaudio_cmd_set_input_stream_address_ranges(a, sdev->dev_id)) {
+				dev_err(a->dev, "aaudio: Failed to set input stream address ranges\n")=
;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void aaudio_init_bs_stream(struct aaudio_device *a, struct aaudio_s=
tream *strm,
+								  struct aaudio_buffer_struct_stream *bs_strm)
+{
+	size_t i;
+	strm->buffer_cnt =3D bs_strm->num_buffers;
+	if (bs_strm->num_buffers > AAUDIO_DEIVCE_MAX_BUFFER_COUNT) {
+		dev_warn(a->dev, "BufferStruct buffer count %u exceeds driver limit of %=
u\n", bs_strm->num_buffers,
+				AAUDIO_DEIVCE_MAX_BUFFER_COUNT);
+		strm->buffer_cnt =3D AAUDIO_DEIVCE_MAX_BUFFER_COUNT;
+	}
+	if (!strm->buffer_cnt)
+		return;
+	strm->buffers =3D kmalloc_array(strm->buffer_cnt, sizeof(struct aaudio_dm=
a_buf), GFP_KERNEL);
+	if (!strm->buffers) {
+		dev_err(a->dev, "Buffer list allocation failed\n");
+		return;
+	}
+	for (i =3D 0; i < strm->buffer_cnt; i++) {
+		strm->buffers[i].dma_addr =3D a->reg_mem_bs_dma + (dma_addr_t) bs_strm->=
buffers[i].address;
+		strm->buffers[i].ptr =3D a->reg_mem_bs + bs_strm->buffers[i].address;
+		strm->buffers[i].size =3D bs_strm->buffers[i].size;
+	}
+
+	if (strm->buffer_cnt =3D=3D 1) {
+		strm->alsa_hw_desc =3D kmalloc(sizeof(struct snd_pcm_hardware), GFP_KERN=
EL);
+		if (aaudio_create_hw_info(&strm->desc, strm->alsa_hw_desc, strm->buffers=
[0].size)) {
+			kfree(strm->alsa_hw_desc);
+			strm->alsa_hw_desc =3D NULL;
+		}
+	}
+}
+
+static void aaudio_init_bs_stream_host(struct aaudio_device *a, struct aau=
dio_stream *strm,
+		struct aaudio_buffer_struct_stream *bs_strm)
+{
+	size_t size;
+	dma_addr_t dma_addr;
+	void *dma_ptr;
+	size =3D strm->desc.bytes_per_packet * 16640;
+	dma_ptr =3D dma_alloc_coherent(&a->pci->dev, size, &dma_addr, GFP_KERNEL)=
;
+	if (!dma_ptr) {
+		dev_err(a->dev, "dma_alloc_coherent failed\n");
+		return;
+	}
+	bs_strm->buffers[0].address =3D dma_addr;
+	bs_strm->buffers[0].size =3D size;
+	bs_strm->num_buffers =3D 1;
+
+	memset(dma_ptr, 0, size);
+
+	strm->buffer_cnt =3D 1;
+	strm->buffers =3D kmalloc_array(strm->buffer_cnt, sizeof(struct aaudio_dm=
a_buf), GFP_KERNEL);
+	if (!strm->buffers) {
+		dev_err(a->dev, "Buffer list allocation failed\n");
+		return;
+	}
+	strm->buffers[0].dma_addr =3D dma_addr;
+	strm->buffers[0].ptr =3D dma_ptr;
+	strm->buffers[0].size =3D size;
+
+	strm->alsa_hw_desc =3D kmalloc(sizeof(struct snd_pcm_hardware), GFP_KERNE=
L);
+	if (aaudio_create_hw_info(&strm->desc, strm->alsa_hw_desc, strm->buffers[=
0].size)) {
+		kfree(strm->alsa_hw_desc);
+		strm->alsa_hw_desc =3D NULL;
+	}
+}
+
+static void aaudio_handle_prop_change(struct aaudio_device *a, struct aaud=
io_msg *msg);
+
+void aaudio_handle_notification(struct aaudio_device *a, struct aaudio_msg=
 *msg)
+{
+	struct aaudio_send_ctx sctx;
+	struct aaudio_msg_base base;
+	if (aaudio_msg_read_base(msg, &base))
+		return;
+	switch (base.msg) {
+		case AAUDIO_MSG_NOTIFICATION_BOOT:
+			dev_info(a->dev, "Received boot notification from remote\n");
+
+			/* Resend the alive notify */
+			if (aaudio_send(a, &sctx, 500,
+					aaudio_msg_write_alive_notification, 1, 3)) {
+				pr_err("Sending alive notification failed\n");
+			}
+			break;
+		case AAUDIO_MSG_NOTIFICATION_ALIVE:
+			dev_info(a->dev, "Received alive notification from remote\n");
+			complete_all(&a->remote_alive);
+			break;
+		case AAUDIO_MSG_PROPERTY_CHANGED:
+			aaudio_handle_prop_change(a, msg);
+			break;
+		default:
+			dev_info(a->dev, "Unhandled notification %i", base.msg);
+			break;
+	}
+}
+
+struct aaudio_prop_change_work_struct {
+	struct work_struct ws;
+	struct aaudio_device *a;
+	aaudio_device_id_t dev;
+	aaudio_object_id_t obj;
+	struct aaudio_prop_addr prop;
+};
+
+static void aaudio_handle_jack_connection_change(struct aaudio_subdevice *=
sdev)
+{
+	u32 plugged;
+	if (!sdev->jack)
+		return;
+	/* NOTE: Apple made the plug status scoped to the input and output stream=
s. This makes no sense for us, so I just
+	 * always pick the OUTPUT status. */
+	if (aaudio_cmd_get_primitive_property(sdev->a, sdev->dev_id, sdev->dev_id=
,
+			AAUDIO_PROP(AAUDIO_PROP_SCOPE_OUTPUT, AAUDIO_PROP_JACK_PLUGGED, 0), NUL=
L, 0, &plugged, sizeof(plugged))) {
+		dev_err(sdev->a->dev, "Failed to get jack enable status\n");
+		return;
+	}
+	dev_dbg(sdev->a->dev, "Jack is now %s\n", plugged ? "plugged" : "unplugge=
d");
+	snd_jack_report(sdev->jack, plugged ? sdev->jack->type : 0);
+}
+
+void aaudio_handle_prop_change_work(struct work_struct *ws)
+{
+	struct aaudio_prop_change_work_struct *work =3D container_of(ws, struct a=
audio_prop_change_work_struct, ws);
+	struct aaudio_subdevice *sdev;
+
+	sdev =3D aaudio_find_dev_by_dev_id(work->a, work->dev);
+	if (!sdev) {
+		dev_err(work->a->dev, "Property notification change: device not found\n"=
);
+		goto done;
+	}
+	dev_dbg(work->a->dev, "Property changed for device: %s\n", sdev->uid);
+
+	if (work->prop.scope =3D=3D AAUDIO_PROP_SCOPE_OUTPUT && work->prop.select=
or =3D=3D AAUDIO_PROP_JACK_PLUGGED) {
+		aaudio_handle_jack_connection_change(sdev);
+	}
+
+done:
+	kfree(work);
+}
+
+void aaudio_handle_prop_change(struct aaudio_device *a, struct aaudio_msg =
*msg)
+{
+	/* NOTE: This is a scheduled work because this callback will generally ne=
ed to query device information and this
+	 * is not possible when we are in the reply parsing code's context. */
+	struct aaudio_prop_change_work_struct *work;
+	work =3D kmalloc(sizeof(struct aaudio_prop_change_work_struct), GFP_KERNE=
L);
+	work->a =3D a;
+	INIT_WORK(&work->ws, aaudio_handle_prop_change_work);
+	aaudio_msg_read_property_changed(msg, &work->dev, &work->obj, &work->prop=
);
+	schedule_work(&work->ws);
+}
+
+#define aaudio_send_cmd_response(a, sctx, msg, fn, ...) \
+	if (aaudio_send_with_tag(a, sctx, ((struct aaudio_msg_header *) msg->data=
)->tag, 500, fn, ##__VA_ARGS__)) \
+		pr_err("aaudio: Failed to reply to a command\n");
+
+void aaudio_handle_cmd_timestamp(struct aaudio_device *a, struct aaudio_ms=
g *msg)
+{
+	ktime_t time_os =3D ktime_get_boottime();
+	struct aaudio_send_ctx sctx;
+	struct aaudio_subdevice *sdev;
+	u64 devid, timestamp, update_seed;
+	aaudio_msg_read_update_timestamp(msg, &devid, &timestamp, &update_seed);
+	dev_dbg(a->dev, "Received timestamp update for dev=3D%llx ts=3D%llx seed=
=3D%llx\n", devid, timestamp, update_seed);
+
+	sdev =3D aaudio_find_dev_by_dev_id(a, devid);
+	aaudio_handle_timestamp(sdev, time_os, timestamp);
+
+	aaudio_send_cmd_response(a, &sctx, msg,
+			aaudio_msg_write_update_timestamp_response);
+}
+
+void aaudio_handle_command(struct aaudio_device *a, struct aaudio_msg *msg=
)
+{
+	struct aaudio_msg_base base;
+	if (aaudio_msg_read_base(msg, &base))
+		return;
+	switch (base.msg) {
+		case AAUDIO_MSG_UPDATE_TIMESTAMP:
+			aaudio_handle_cmd_timestamp(a, msg);
+			break;
+		default:
+			dev_info(a->dev, "Unhandled device command %i", base.msg);
+			break;
+	}
+}
+
+static struct pci_device_id aaudio_ids[  ] =3D {
+		{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x1803) },
+		{ 0, },
+};
+
+static const struct dev_pm_ops aaudio_pci_driver_pm =3D {
+		.suspend =3D aaudio_suspend,
+		.resume =3D aaudio_resume
+};
+static struct pci_driver aaudio_pci_driver =3D {
+		.name =3D "aaudio",
+		.id_table =3D aaudio_ids,
+		.probe =3D aaudio_probe,
+		.remove =3D aaudio_remove,
+		.driver =3D {
+				.pm =3D &aaudio_pci_driver_pm
+		}
+};
+
+
+int aaudio_module_init(void)
+{
+	int result;
+	if ((result =3D alloc_chrdev_region(&aaudio_chrdev, 0, 1, "aaudio")))
+		goto fail_chrdev;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,4,0)
+	aaudio_class =3D class_create(THIS_MODULE, "aaudio");
+#else
+	aaudio_class =3D class_create("aaudio");
+#endif
+	if (IS_ERR(aaudio_class)) {
+		result =3D PTR_ERR(aaudio_class);
+		goto fail_class;
+	}
+=09
+	result =3D pci_register_driver(&aaudio_pci_driver);
+	if (result)
+		goto fail_drv;
+	return 0;
+
+fail_drv:
+	pci_unregister_driver(&aaudio_pci_driver);
+fail_class:
+	class_destroy(aaudio_class);
+fail_chrdev:
+	unregister_chrdev_region(aaudio_chrdev, 1);
+	if (!result)
+		result =3D -EINVAL;
+	return result;
+}
+
+void aaudio_module_exit(void)
+{
+	pci_unregister_driver(&aaudio_pci_driver);
+	class_destroy(aaudio_class);
+	unregister_chrdev_region(aaudio_chrdev, 1);
+}
+
+struct aaudio_alsa_pcm_id_mapping aaudio_alsa_id_mappings[] =3D {
+		{"Speaker", 0},
+		{"Digital Mic", 1},
+		{"Codec Output", 2},
+		{"Codec Input", 3},
+		{"Bridge Loopback", 4},
+		{}
+};
+
+module_param_named(index, aaudio_alsa_index, int, 0444);
+MODULE_PARM_DESC(index, "Index value for Apple Internal Audio soundcard.")=
;
+module_param_named(id, aaudio_alsa_id, charp, 0444);
+MODULE_PARM_DESC(id, "ID string for Apple Internal Audio soundcard.");
+
diff --git a/drivers/staging/apple-bce/audio/audio.h b/drivers/staging/appl=
e-bce/audio/audio.h
new file mode 100644
index 000000000..1ce31d8a9
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/audio.h
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef AAUDIO_H
+#define AAUDIO_H
+
+#include <linux/types.h>
+#include <sound/pcm.h>
+#include "../apple_bce.h"
+#include "protocol_bce.h"
+#include "description.h"
+
+#define AAUDIO_SIG 0x19870423
+
+#define AAUDIO_DEVICE_MAX_UID_LEN 128
+#define AAUDIO_DEIVCE_MAX_INPUT_STREAMS 1
+#define AAUDIO_DEIVCE_MAX_OUTPUT_STREAMS 1
+#define AAUDIO_DEIVCE_MAX_BUFFER_COUNT 1
+
+#define AAUDIO_BUFFER_ID_NONE 0xffu
+
+struct snd_card;
+struct snd_pcm;
+struct snd_pcm_hardware;
+struct snd_jack;
+
+struct __attribute__((packed)) __attribute__((aligned(4))) aaudio_buffer_s=
truct_buffer {
+	size_t address;
+	size_t size;
+	size_t pad[4];
+};
+struct aaudio_buffer_struct_stream {
+	u8 num_buffers;
+	struct aaudio_buffer_struct_buffer buffers[100];
+	char filler[32];
+};
+struct aaudio_buffer_struct_device {
+	char name[128];
+	u8 num_input_streams;
+	u8 num_output_streams;
+	struct aaudio_buffer_struct_stream input_streams[5];
+	struct aaudio_buffer_struct_stream output_streams[5];
+	char filler[128];
+};
+struct aaudio_buffer_struct {
+	u32 version;
+	u32 signature;
+	u32 flags;
+	u8 num_devices;
+	struct aaudio_buffer_struct_device devices[20];
+};
+
+struct aaudio_device;
+struct aaudio_dma_buf {
+	dma_addr_t dma_addr;
+	void *ptr;
+	size_t size;
+};
+struct aaudio_stream {
+	aaudio_object_id_t id;
+	size_t buffer_cnt;
+	struct aaudio_dma_buf *buffers;
+
+	struct aaudio_apple_description desc;
+	struct snd_pcm_hardware *alsa_hw_desc;
+	u32 latency;
+
+	bool waiting_for_first_ts;
+
+	ktime_t remote_timestamp;
+	snd_pcm_sframes_t frame_min;
+	int started;
+};
+struct aaudio_subdevice {
+	struct aaudio_device *a;
+	struct list_head list;
+	aaudio_device_id_t dev_id;
+	u32 in_latency, out_latency;
+	u8 buf_id;
+	int alsa_id;
+	char uid[AAUDIO_DEVICE_MAX_UID_LEN + 1];
+	size_t in_stream_cnt;
+	struct aaudio_stream in_streams[AAUDIO_DEIVCE_MAX_INPUT_STREAMS];
+	size_t out_stream_cnt;
+	struct aaudio_stream out_streams[AAUDIO_DEIVCE_MAX_OUTPUT_STREAMS];
+	bool is_pcm;
+	struct snd_pcm *pcm;
+	struct snd_jack *jack;
+};
+struct aaudio_alsa_pcm_id_mapping {
+	const char *name;
+	int alsa_id;
+};
+
+struct aaudio_device {
+	struct pci_dev *pci;
+	dev_t devt;
+	struct device *dev;
+	void __iomem *reg_mem_bs;
+	dma_addr_t reg_mem_bs_dma;
+	void __iomem *reg_mem_cfg;
+
+	u32 __iomem *reg_mem_gpr;
+
+	struct aaudio_buffer_struct *bs;
+
+	struct apple_bce_device *bce;
+	struct aaudio_bce bcem;
+
+	struct snd_card *card;
+
+	struct list_head subdevice_list;
+	int next_alsa_id;
+
+	struct completion remote_alive;
+};
+
+void aaudio_handle_notification(struct aaudio_device *a, struct aaudio_msg=
 *msg);
+void aaudio_handle_prop_change_work(struct work_struct *ws);
+void aaudio_handle_cmd_timestamp(struct aaudio_device *a, struct aaudio_ms=
g *msg);
+void aaudio_handle_command(struct aaudio_device *a, struct aaudio_msg *msg=
);
+
+int aaudio_module_init(void);
+void aaudio_module_exit(void);
+
+extern struct aaudio_alsa_pcm_id_mapping aaudio_alsa_id_mappings[];
+
+#endif //AAUDIO_H
+
diff --git a/drivers/staging/apple-bce/audio/description.h b/drivers/stagin=
g/apple-bce/audio/description.h
new file mode 100644
index 000000000..eae011ed0
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/description.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef AAUDIO_DESCRIPTION_H
+#define AAUDIO_DESCRIPTION_H
+
+#include <linux/types.h>
+
+struct aaudio_apple_description {
+	u64 sample_rate_double;
+	u32 format_id;
+	u32 format_flags;
+	u32 bytes_per_packet;
+	u32 frames_per_packet;
+	u32 bytes_per_frame;
+	u32 channels_per_frame;
+	u32 bits_per_channel;
+	u32 reserved;
+};
+
+enum {
+	AAUDIO_FORMAT_LPCM =3D 0x6c70636d  // 'lpcm'
+};
+
+enum {
+	AAUDIO_FORMAT_FLAG_FLOAT =3D 1,
+	AAUDIO_FORMAT_FLAG_BIG_ENDIAN =3D 2,
+	AAUDIO_FORMAT_FLAG_SIGNED =3D 4,
+	AAUDIO_FORMAT_FLAG_PACKED =3D 8,
+	AAUDIO_FORMAT_FLAG_ALIGNED_HIGH =3D 16,
+	AAUDIO_FORMAT_FLAG_NON_INTERLEAVED =3D 32,
+	AAUDIO_FORMAT_FLAG_NON_MIXABLE =3D 64
+};
+
+static inline u64 aaudio_double_to_u64(u64 d)
+{
+	u8 sign =3D (u8) ((d >> 63) & 1);
+	s32 exp =3D (s32) ((d >> 52) & 0x7ff) - 1023;
+	u64 fr =3D d & ((1LL << 52) - 1);
+	if (sign || exp < 0)
+		return 0;
+	return (u64) ((1LL << exp) + (fr >> (52 - exp)));
+}
+
+#endif //AAUDIO_DESCRIPTION_H
+
diff --git a/drivers/staging/apple-bce/audio/pcm.c b/drivers/staging/apple-=
bce/audio/pcm.c
new file mode 100644
index 000000000..224f30eeb
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/pcm.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "pcm.h"
+#include "audio.h"
+
+static u64 aaudio_get_alsa_fmtbit(struct aaudio_apple_description *desc)
+{
+	if (desc->format_flags & AAUDIO_FORMAT_FLAG_FLOAT) {
+		if (desc->bits_per_channel =3D=3D 32) {
+			if (desc->format_flags & AAUDIO_FORMAT_FLAG_BIG_ENDIAN)
+				return SNDRV_PCM_FMTBIT_FLOAT_BE;
+			else
+				return SNDRV_PCM_FMTBIT_FLOAT_LE;
+		} else if (desc->bits_per_channel =3D=3D 64) {
+			if (desc->format_flags & AAUDIO_FORMAT_FLAG_BIG_ENDIAN)
+				return SNDRV_PCM_FMTBIT_FLOAT64_BE;
+			else
+				return SNDRV_PCM_FMTBIT_FLOAT64_LE;
+		} else {
+			pr_err("aaudio: unsupported bits per channel for float format: %u\n", d=
esc->bits_per_channel);
+			return 0;
+		}
+	}
+#define DEFINE_BPC_OPTION(val, b) \
+	case val: \
+		if (desc->format_flags & AAUDIO_FORMAT_FLAG_BIG_ENDIAN) { \
+			if (desc->format_flags & AAUDIO_FORMAT_FLAG_SIGNED) \
+				return SNDRV_PCM_FMTBIT_S ## b ## BE; \
+			else \
+				return SNDRV_PCM_FMTBIT_U ## b ## BE; \
+		} else { \
+			if (desc->format_flags & AAUDIO_FORMAT_FLAG_SIGNED) \
+				return SNDRV_PCM_FMTBIT_S ## b ## LE; \
+			else \
+				return SNDRV_PCM_FMTBIT_U ## b ## LE; \
+		}
+	if (desc->format_flags & AAUDIO_FORMAT_FLAG_PACKED) {
+		switch (desc->bits_per_channel) {
+			case 8:
+			case 16:
+			case 32:
+				break;
+			DEFINE_BPC_OPTION(24, 24_3)
+			default:
+				pr_err("aaudio: unsupported bits per channel for packed format: %u\n",=
 desc->bits_per_channel);
+				return 0;
+		}
+	}
+	if (desc->format_flags & AAUDIO_FORMAT_FLAG_ALIGNED_HIGH) {
+		switch (desc->bits_per_channel) {
+			DEFINE_BPC_OPTION(24, 32_)
+			default:
+				pr_err("aaudio: unsupported bits per channel for high-aligned format: =
%u\n", desc->bits_per_channel);
+				return 0;
+		}
+	}
+	switch (desc->bits_per_channel) {
+		case 8:
+			if (desc->format_flags & AAUDIO_FORMAT_FLAG_SIGNED)
+				return SNDRV_PCM_FMTBIT_S8;
+			else
+				return SNDRV_PCM_FMTBIT_U8;
+		DEFINE_BPC_OPTION(16, 16_)
+		DEFINE_BPC_OPTION(24, 24_)
+		DEFINE_BPC_OPTION(32, 32_)
+		default:
+			pr_err("aaudio: unsupported bits per channel: %u\n", desc->bits_per_cha=
nnel);
+			return 0;
+	}
+}
+int aaudio_create_hw_info(struct aaudio_apple_description *desc, struct sn=
d_pcm_hardware *alsa_hw,
+		size_t buf_size)
+{
+	uint rate;
+	alsa_hw->info =3D (SNDRV_PCM_INFO_MMAP |
+					 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+					 SNDRV_PCM_INFO_MMAP_VALID |
+					 SNDRV_PCM_INFO_DOUBLE);
+	if (desc->format_flags & AAUDIO_FORMAT_FLAG_NON_MIXABLE)
+		pr_warn("aaudio: unsupported hw flag: NON_MIXABLE\n");
+	if (!(desc->format_flags & AAUDIO_FORMAT_FLAG_NON_INTERLEAVED))
+		alsa_hw->info |=3D SNDRV_PCM_INFO_INTERLEAVED;
+	alsa_hw->formats =3D aaudio_get_alsa_fmtbit(desc);
+	if (!alsa_hw->formats)
+		return -EINVAL;
+	rate =3D (uint) aaudio_double_to_u64(desc->sample_rate_double);
+	alsa_hw->rates =3D snd_pcm_rate_to_rate_bit(rate);
+	alsa_hw->rate_min =3D rate;
+	alsa_hw->rate_max =3D rate;
+	alsa_hw->channels_min =3D desc->channels_per_frame;
+	alsa_hw->channels_max =3D desc->channels_per_frame;
+	alsa_hw->buffer_bytes_max =3D buf_size;
+	alsa_hw->period_bytes_min =3D desc->bytes_per_packet;
+	alsa_hw->period_bytes_max =3D desc->bytes_per_packet;
+	alsa_hw->periods_min =3D (uint) (buf_size / desc->bytes_per_packet);
+	alsa_hw->periods_max =3D (uint) (buf_size / desc->bytes_per_packet);
+	pr_debug("aaudio_create_hw_info: format =3D %llu, rate =3D %u/%u. channel=
s =3D %u, periods =3D %u, period size =3D %lu\n",
+			alsa_hw->formats, alsa_hw->rate_min, alsa_hw->rates, alsa_hw->channels_=
min, alsa_hw->periods_min,
+			alsa_hw->period_bytes_min);
+	return 0;
+}
+
+static struct aaudio_stream *aaudio_pcm_stream(struct snd_pcm_substream *s=
ubstream)
+{
+	struct aaudio_subdevice *sdev =3D snd_pcm_substream_chip(substream);
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+		return &sdev->out_streams[substream->number];
+	else
+		return &sdev->in_streams[substream->number];
+}
+
+static int aaudio_pcm_open(struct snd_pcm_substream *substream)
+{
+	pr_debug("aaudio_pcm_open\n");
+	substream->runtime->hw =3D *aaudio_pcm_stream(substream)->alsa_hw_desc;
+
+	return 0;
+}
+
+static int aaudio_pcm_close(struct snd_pcm_substream *substream)
+{
+	pr_debug("aaudio_pcm_close\n");
+	return 0;
+}
+
+static int aaudio_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int aaudio_pcm_hw_params(struct snd_pcm_substream *substream, struc=
t snd_pcm_hw_params *hw_params)
+{
+	struct aaudio_stream *astream =3D aaudio_pcm_stream(substream);
+	pr_debug("aaudio_pcm_hw_params\n");
+
+	if (!astream->buffer_cnt || !astream->buffers)
+		return -EINVAL;
+
+	substream->runtime->dma_area =3D astream->buffers[0].ptr;
+	substream->runtime->dma_addr =3D astream->buffers[0].dma_addr;
+	substream->runtime->dma_bytes =3D astream->buffers[0].size;
+	return 0;
+}
+
+static int aaudio_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	pr_debug("aaudio_pcm_hw_free\n");
+	return 0;
+}
+
+static void aaudio_pcm_start(struct snd_pcm_substream *substream)
+{
+	struct aaudio_subdevice *sdev =3D snd_pcm_substream_chip(substream);
+	struct aaudio_stream *stream =3D aaudio_pcm_stream(substream);
+	void *buf;
+	size_t s;
+	ktime_t time_start, time_end;
+	bool back_buffer;
+	time_start =3D ktime_get();
+
+	back_buffer =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK);
+
+	if (back_buffer) {
+		s =3D frames_to_bytes(substream->runtime, substream->runtime->control->a=
ppl_ptr);
+		buf =3D kmalloc(s, GFP_KERNEL);
+		memcpy_fromio(buf, (__force void __iomem *)substream->runtime->dma_area,=
 s);
+		time_end =3D ktime_get();
+		pr_debug("aaudio: Backed up the buffer in %lluns [%li]\n", ktime_to_ns(t=
ime_end - time_start),
+				substream->runtime->control->appl_ptr);
+	}
+
+	stream->waiting_for_first_ts =3D true;
+	stream->frame_min =3D stream->latency;
+
+	aaudio_cmd_start_io(sdev->a, sdev->dev_id);
+	if (back_buffer)
+		memcpy_toio((__force void __iomem *)substream->runtime->dma_area, buf, s=
);
+
+	time_end =3D ktime_get();
+	pr_debug("aaudio: Started the audio device in %lluns\n", ktime_to_ns(time=
_end - time_start));
+}
+
+static int aaudio_pcm_trigger(struct snd_pcm_substream *substream, int cmd=
)
+{
+	struct aaudio_subdevice *sdev =3D snd_pcm_substream_chip(substream);
+	struct aaudio_stream *stream =3D aaudio_pcm_stream(substream);
+	pr_debug("aaudio_pcm_trigger %x\n", cmd);
+
+	/* We only supports triggers on the #0 buffer */
+	if (substream->number !=3D 0)
+		return 0;
+	switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+			aaudio_pcm_start(substream);
+			stream->started =3D 1;
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			aaudio_cmd_stop_io(sdev->a, sdev->dev_id);
+			stream->started =3D 0;
+			break;
+		default:
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static snd_pcm_uframes_t aaudio_pcm_pointer(struct snd_pcm_substream *subs=
tream)
+{
+	struct aaudio_stream *stream =3D aaudio_pcm_stream(substream);
+	ktime_t time_from_start;
+	snd_pcm_sframes_t frames;
+	snd_pcm_sframes_t buffer_time_length;
+
+	if (!stream->started || stream->waiting_for_first_ts) {
+		pr_warn("aaudio_pcm_pointer while not started\n");
+		return 0;
+	}
+
+	/* Approximate the pointer based on the last received timestamp */
+	time_from_start =3D ktime_get_boottime() - stream->remote_timestamp;
+	buffer_time_length =3D NSEC_PER_SEC * substream->runtime->buffer_size / s=
ubstream->runtime->rate;
+	frames =3D (ktime_to_ns(time_from_start) % buffer_time_length) * substrea=
m->runtime->buffer_size / buffer_time_length;
+	if (ktime_to_ns(time_from_start) < buffer_time_length) {
+		if (frames < stream->frame_min)
+			frames =3D stream->frame_min;
+		else
+			stream->frame_min =3D 0;
+	} else {
+		if (ktime_to_ns(time_from_start) < 2 * buffer_time_length)
+			stream->frame_min =3D frames;
+		else
+			stream->frame_min =3D 0; /* Heavy desync */
+	}
+	frames -=3D stream->latency;
+	if (frames < 0)
+		frames +=3D ((-frames - 1) / substream->runtime->buffer_size + 1) * subs=
tream->runtime->buffer_size;
+	return (snd_pcm_uframes_t) frames;
+}
+
+static struct snd_pcm_ops aaudio_pcm_ops =3D {
+		.open =3D		aaudio_pcm_open,
+		.close =3D	   aaudio_pcm_close,
+		.ioctl =3D	   snd_pcm_lib_ioctl,
+		.hw_params =3D   aaudio_pcm_hw_params,
+		.hw_free =3D	 aaudio_pcm_hw_free,
+		.prepare =3D	 aaudio_pcm_prepare,
+		.trigger =3D	 aaudio_pcm_trigger,
+		.pointer =3D	 aaudio_pcm_pointer,
+		.mmap	=3D	 snd_pcm_lib_mmap_iomem
+};
+
+int aaudio_create_pcm(struct aaudio_subdevice *sdev)
+{
+	struct snd_pcm *pcm;
+	struct aaudio_alsa_pcm_id_mapping *id_mapping;
+	int err;
+
+	if (!sdev->is_pcm || (sdev->in_stream_cnt =3D=3D 0 && sdev->out_stream_cn=
t =3D=3D 0)) {
+		return -EINVAL;
+	}
+
+	for (id_mapping =3D aaudio_alsa_id_mappings; id_mapping->name; id_mapping=
++) {
+		if (!strcmp(sdev->uid, id_mapping->name)) {
+			sdev->alsa_id =3D id_mapping->alsa_id;
+			break;
+		}
+	}
+	if (!id_mapping->name)
+		sdev->alsa_id =3D sdev->a->next_alsa_id++;
+	err =3D snd_pcm_new(sdev->a->card, sdev->uid, sdev->alsa_id,
+			(int) sdev->out_stream_cnt, (int) sdev->in_stream_cnt, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data =3D sdev;
+	pcm->nonatomic =3D 1;
+	sdev->pcm =3D pcm;
+	strcpy(pcm->name, sdev->uid);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &aaudio_pcm_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &aaudio_pcm_ops);
+	return 0;
+}
+
+static void aaudio_handle_stream_timestamp(struct snd_pcm_substream *subst=
ream, ktime_t timestamp)
+{
+	unsigned long flags;
+	struct aaudio_stream *stream;
+
+	stream =3D aaudio_pcm_stream(substream);
+	snd_pcm_stream_lock_irqsave(substream, flags);
+	stream->remote_timestamp =3D timestamp;
+	if (stream->waiting_for_first_ts) {
+		stream->waiting_for_first_ts =3D false;
+		snd_pcm_stream_unlock_irqrestore(substream, flags);
+		return;
+	}
+	snd_pcm_stream_unlock_irqrestore(substream, flags);
+	snd_pcm_period_elapsed(substream);
+}
+
+void aaudio_handle_timestamp(struct aaudio_subdevice *sdev, ktime_t os_tim=
estamp, u64 dev_timestamp)
+{
+	struct snd_pcm_substream *substream;
+
+	substream =3D sdev->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (substream)
+		aaudio_handle_stream_timestamp(substream, dev_timestamp);
+	substream =3D sdev->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	if (substream)
+		aaudio_handle_stream_timestamp(substream, os_timestamp);
+}
+
diff --git a/drivers/staging/apple-bce/audio/pcm.h b/drivers/staging/apple-=
bce/audio/pcm.h
new file mode 100644
index 000000000..e659657dc
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/pcm.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef AAUDIO_PCM_H
+#define AAUDIO_PCM_H
+
+#include <linux/types.h>
+#include <linux/ktime.h>
+
+struct aaudio_subdevice;
+struct aaudio_apple_description;
+struct snd_pcm_hardware;
+
+int aaudio_create_hw_info(struct aaudio_apple_description *desc, struct sn=
d_pcm_hardware *alsa_hw, size_t buf_size);
+int aaudio_create_pcm(struct aaudio_subdevice *sdev);
+
+void aaudio_handle_timestamp(struct aaudio_subdevice *sdev, ktime_t os_tim=
estamp, u64 dev_timestamp);
+
+#endif //AAUDIO_PCM_H
+
diff --git a/drivers/staging/apple-bce/audio/protocol.c b/drivers/staging/a=
pple-bce/audio/protocol.c
new file mode 100644
index 000000000..8c5f8f731
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/protocol.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "protocol.h"
+#include "protocol_bce.h"
+#include "audio.h"
+
+int aaudio_msg_read_base(struct aaudio_msg *msg, struct aaudio_msg_base *b=
ase)
+{
+	if (msg->size < sizeof(struct aaudio_msg_header) + sizeof(struct aaudio_m=
sg_base) * 2)
+		return -EINVAL;
+	*base =3D *((struct aaudio_msg_base *) ((struct aaudio_msg_header *) msg-=
>data + 1));
+	return 0;
+}
+
+#define READ_START(type) \
+	size_t offset =3D sizeof(struct aaudio_msg_header) + sizeof(struct aaudio=
_msg_base); (void)offset; \
+	if (((struct aaudio_msg_base *) ((struct aaudio_msg_header *) msg->data +=
 1))->msg !=3D type) \
+		return -EINVAL;
+#define READ_DEVID_VAR(devid) *devid =3D ((struct aaudio_msg_header *) msg=
->data)->device_id
+#define READ_VAL(type) ({ offset +=3D sizeof(type); *((type *) ((u8 *) msg=
->data + offset - sizeof(type))); })
+#define READ_VAR(type, var) *var =3D READ_VAL(type)
+
+int aaudio_msg_read_start_io_response(struct aaudio_msg *msg)
+{
+	READ_START(AAUDIO_MSG_START_IO_RESPONSE);
+	return 0;
+}
+
+int aaudio_msg_read_stop_io_response(struct aaudio_msg *msg)
+{
+	READ_START(AAUDIO_MSG_STOP_IO_RESPONSE);
+	return 0;
+}
+
+int aaudio_msg_read_update_timestamp(struct aaudio_msg *msg, aaudio_device=
_id_t *devid,
+		u64 *timestamp, u64 *update_seed)
+{
+	READ_START(AAUDIO_MSG_UPDATE_TIMESTAMP);
+	READ_DEVID_VAR(devid);
+	READ_VAR(u64, timestamp);
+	READ_VAR(u64, update_seed);
+	return 0;
+}
+
+int aaudio_msg_read_get_property_response(struct aaudio_msg *msg, aaudio_o=
bject_id_t *obj,
+		struct aaudio_prop_addr *prop, void **data, u64 *data_size)
+{
+	READ_START(AAUDIO_MSG_GET_PROPERTY_RESPONSE);
+	READ_VAR(aaudio_object_id_t, obj);
+	READ_VAR(u32, &prop->element);
+	READ_VAR(u32, &prop->scope);
+	READ_VAR(u32, &prop->selector);
+	READ_VAR(u64, data_size);
+	*data =3D ((u8 *) msg->data + offset);
+	/* offset +=3D data_size; */
+	return 0;
+}
+
+int aaudio_msg_read_set_property_response(struct aaudio_msg *msg, aaudio_o=
bject_id_t *obj)
+{
+	READ_START(AAUDIO_MSG_SET_PROPERTY_RESPONSE);
+	READ_VAR(aaudio_object_id_t, obj);
+	return 0;
+}
+
+int aaudio_msg_read_property_listener_response(struct aaudio_msg *msg, aau=
dio_object_id_t *obj,
+		struct aaudio_prop_addr *prop)
+{
+	READ_START(AAUDIO_MSG_PROPERTY_LISTENER_RESPONSE);
+	READ_VAR(aaudio_object_id_t, obj);
+	READ_VAR(u32, &prop->element);
+	READ_VAR(u32, &prop->scope);
+	READ_VAR(u32, &prop->selector);
+	return 0;
+}
+
+int aaudio_msg_read_property_changed(struct aaudio_msg *msg, aaudio_device=
_id_t *devid, aaudio_object_id_t *obj,
+		struct aaudio_prop_addr *prop)
+{
+	READ_START(AAUDIO_MSG_PROPERTY_CHANGED);
+	READ_DEVID_VAR(devid);
+	READ_VAR(aaudio_object_id_t, obj);
+	READ_VAR(u32, &prop->element);
+	READ_VAR(u32, &prop->scope);
+	READ_VAR(u32, &prop->selector);
+	return 0;
+}
+
+int aaudio_msg_read_set_input_stream_address_ranges_response(struct aaudio=
_msg *msg)
+{
+	READ_START(AAUDIO_MSG_SET_INPUT_STREAM_ADDRESS_RANGES_RESPONSE);
+	return 0;
+}
+
+int aaudio_msg_read_get_input_stream_list_response(struct aaudio_msg *msg,=
 aaudio_object_id_t **str_l, u64 *str_cnt)
+{
+	READ_START(AAUDIO_MSG_GET_INPUT_STREAM_LIST_RESPONSE);
+	READ_VAR(u64, str_cnt);
+	*str_l =3D (aaudio_device_id_t *) ((u8 *) msg->data + offset);
+	/* offset +=3D str_cnt * sizeof(aaudio_object_id_t); */
+	return 0;
+}
+
+int aaudio_msg_read_get_output_stream_list_response(struct aaudio_msg *msg=
, aaudio_object_id_t **str_l, u64 *str_cnt)
+{
+	READ_START(AAUDIO_MSG_GET_OUTPUT_STREAM_LIST_RESPONSE);
+	READ_VAR(u64, str_cnt);
+	*str_l =3D (aaudio_device_id_t *) ((u8 *) msg->data + offset);
+	/* offset +=3D str_cnt * sizeof(aaudio_object_id_t); */
+	return 0;
+}
+
+int aaudio_msg_read_set_remote_access_response(struct aaudio_msg *msg)
+{
+	READ_START(AAUDIO_MSG_SET_REMOTE_ACCESS_RESPONSE);
+	return 0;
+}
+
+int aaudio_msg_read_get_device_list_response(struct aaudio_msg *msg, aaudi=
o_device_id_t **dev_l, u64 *dev_cnt)
+{
+	READ_START(AAUDIO_MSG_GET_DEVICE_LIST_RESPONSE);
+	READ_VAR(u64, dev_cnt);
+	*dev_l =3D (aaudio_device_id_t *) ((u8 *) msg->data + offset);
+	/* offset +=3D dev_cnt * sizeof(aaudio_device_id_t); */
+	return 0;
+}
+
+#define WRITE_START_OF_TYPE(typev, devid) \
+	size_t offset =3D sizeof(struct aaudio_msg_header); (void) offset; \
+	((struct aaudio_msg_header *) msg->data)->type =3D (typev); \
+	((struct aaudio_msg_header *) msg->data)->device_id =3D (devid);
+#define WRITE_START_COMMAND(devid) WRITE_START_OF_TYPE(AAUDIO_MSG_TYPE_COM=
MAND, devid)
+#define WRITE_START_RESPONSE() WRITE_START_OF_TYPE(AAUDIO_MSG_TYPE_RESPONS=
E, 0)
+#define WRITE_START_NOTIFICATION() WRITE_START_OF_TYPE(AAUDIO_MSG_TYPE_NOT=
IFICATION, 0)
+#define WRITE_VAL(type, value) { *((type *) ((u8 *) msg->data + offset)) =
=3D value; offset +=3D sizeof(value); }
+#define WRITE_BIN(value, size) { memcpy((u8 *) msg->data + offset, value, =
size); offset +=3D size; }
+#define WRITE_BASE(type) WRITE_VAL(u32, type) WRITE_VAL(u32, 0)
+#define WRITE_END() { msg->size =3D offset; }
+
+void aaudio_msg_write_start_io(struct aaudio_msg *msg, aaudio_device_id_t =
dev)
+{
+	WRITE_START_COMMAND(dev);
+	WRITE_BASE(AAUDIO_MSG_START_IO);
+	WRITE_END();
+}
+
+void aaudio_msg_write_stop_io(struct aaudio_msg *msg, aaudio_device_id_t d=
ev)
+{
+	WRITE_START_COMMAND(dev);
+	WRITE_BASE(AAUDIO_MSG_STOP_IO);
+	WRITE_END();
+}
+
+void aaudio_msg_write_get_property(struct aaudio_msg *msg, aaudio_device_i=
d_t dev, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size)
+{
+	WRITE_START_COMMAND(dev);
+	WRITE_BASE(AAUDIO_MSG_GET_PROPERTY);
+	WRITE_VAL(aaudio_object_id_t, obj);
+	WRITE_VAL(u32, prop.element);
+	WRITE_VAL(u32, prop.scope);
+	WRITE_VAL(u32, prop.selector);
+	WRITE_VAL(u64, qualifier_size);
+	WRITE_BIN(qualifier, qualifier_size);
+	WRITE_END();
+}
+
+void aaudio_msg_write_set_property(struct aaudio_msg *msg, aaudio_device_i=
d_t dev, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *data, u64 data_size, void *qualifier=
, u64 qualifier_size)
+{
+	WRITE_START_COMMAND(dev);
+	WRITE_BASE(AAUDIO_MSG_SET_PROPERTY);
+	WRITE_VAL(aaudio_object_id_t, obj);
+	WRITE_VAL(u32, prop.element);
+	WRITE_VAL(u32, prop.scope);
+	WRITE_VAL(u32, prop.selector);
+	WRITE_VAL(u64, data_size);
+	WRITE_BIN(data, data_size);
+	WRITE_VAL(u64, qualifier_size);
+	WRITE_BIN(qualifier, qualifier_size);
+	WRITE_END();
+}
+
+void aaudio_msg_write_property_listener(struct aaudio_msg *msg, aaudio_dev=
ice_id_t dev, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop)
+{
+	WRITE_START_COMMAND(dev);
+	WRITE_BASE(AAUDIO_MSG_PROPERTY_LISTENER);
+	WRITE_VAL(aaudio_object_id_t, obj);
+	WRITE_VAL(u32, prop.element);
+	WRITE_VAL(u32, prop.scope);
+	WRITE_VAL(u32, prop.selector);
+	WRITE_END();
+}
+
+void aaudio_msg_write_set_input_stream_address_ranges(struct aaudio_msg *m=
sg, aaudio_device_id_t devid)
+{
+	WRITE_START_COMMAND(devid);
+	WRITE_BASE(AAUDIO_MSG_SET_INPUT_STREAM_ADDRESS_RANGES);
+	WRITE_END();
+}
+
+void aaudio_msg_write_get_input_stream_list(struct aaudio_msg *msg, aaudio=
_device_id_t devid)
+{
+	WRITE_START_COMMAND(devid);
+	WRITE_BASE(AAUDIO_MSG_GET_INPUT_STREAM_LIST);
+	WRITE_END();
+}
+
+void aaudio_msg_write_get_output_stream_list(struct aaudio_msg *msg, aaudi=
o_device_id_t devid)
+{
+	WRITE_START_COMMAND(devid);
+	WRITE_BASE(AAUDIO_MSG_GET_OUTPUT_STREAM_LIST);
+	WRITE_END();
+}
+
+void aaudio_msg_write_set_remote_access(struct aaudio_msg *msg, u64 mode)
+{
+	WRITE_START_COMMAND(0);
+	WRITE_BASE(AAUDIO_MSG_SET_REMOTE_ACCESS);
+	WRITE_VAL(u64, mode);
+	WRITE_END();
+}
+
+void aaudio_msg_write_alive_notification(struct aaudio_msg *msg, u32 proto=
_ver, u32 msg_ver)
+{
+	WRITE_START_NOTIFICATION();
+	WRITE_BASE(AAUDIO_MSG_NOTIFICATION_ALIVE);
+	WRITE_VAL(u32, proto_ver);
+	WRITE_VAL(u32, msg_ver);
+	WRITE_END();
+}
+
+void aaudio_msg_write_update_timestamp_response(struct aaudio_msg *msg)
+{
+	WRITE_START_RESPONSE();
+	WRITE_BASE(AAUDIO_MSG_UPDATE_TIMESTAMP_RESPONSE);
+	WRITE_END();
+}
+
+void aaudio_msg_write_get_device_list(struct aaudio_msg *msg)
+{
+	WRITE_START_COMMAND(0);
+	WRITE_BASE(AAUDIO_MSG_GET_DEVICE_LIST);
+	WRITE_END();
+}
+
+#define CMD_SHARED_VARS_NO_REPLY \
+	int status =3D 0; \
+	struct aaudio_send_ctx sctx;
+#define CMD_SHARED_VARS \
+	CMD_SHARED_VARS_NO_REPLY \
+	struct aaudio_msg reply =3D aaudio_reply_alloc(); \
+	struct aaudio_msg *buf =3D &reply;
+#define CMD_SEND_REQUEST(fn, ...) \
+	if ((status =3D aaudio_send_cmd_sync(a, &sctx, buf, 500, fn, ##__VA_ARGS_=
_))) \
+		return status;
+#define CMD_DEF_SHARED_AND_SEND(fn, ...) \
+	CMD_SHARED_VARS \
+	CMD_SEND_REQUEST(fn, ##__VA_ARGS__);
+#define CMD_DEF_SHARED_NO_REPLY_AND_SEND(fn, ...) \
+	CMD_SHARED_VARS_NO_REPLY \
+	CMD_SEND_REQUEST(fn, ##__VA_ARGS__);
+#define CMD_HNDL_REPLY_NO_FREE(fn, ...) \
+	status =3D fn(buf, ##__VA_ARGS__); \
+	return status;
+#define CMD_HNDL_REPLY_AND_FREE(fn, ...) \
+	status =3D fn(buf, ##__VA_ARGS__); \
+	aaudio_reply_free(&reply); \
+	return status;
+
+int aaudio_cmd_start_io(struct aaudio_device *a, aaudio_device_id_t devid)
+{
+	CMD_DEF_SHARED_AND_SEND(aaudio_msg_write_start_io, devid);
+	CMD_HNDL_REPLY_AND_FREE(aaudio_msg_read_start_io_response);
+}
+int aaudio_cmd_stop_io(struct aaudio_device *a, aaudio_device_id_t devid)
+{
+	CMD_DEF_SHARED_AND_SEND(aaudio_msg_write_stop_io, devid);
+	CMD_HNDL_REPLY_AND_FREE(aaudio_msg_read_stop_io_response);
+}
+int aaudio_cmd_get_property(struct aaudio_device *a, struct aaudio_msg *bu=
f,
+		aaudio_device_id_t devid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size, void =
**data, u64 *data_size)
+{
+	CMD_DEF_SHARED_NO_REPLY_AND_SEND(aaudio_msg_write_get_property, devid, ob=
j, prop, qualifier, qualifier_size);
+	CMD_HNDL_REPLY_NO_FREE(aaudio_msg_read_get_property_response, &obj, &prop=
, data, data_size);
+}
+int aaudio_cmd_get_primitive_property(struct aaudio_device *a,
+		aaudio_device_id_t devid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size, void =
*data, u64 data_size)
+{
+	int status;
+	struct aaudio_msg reply =3D aaudio_reply_alloc();
+	void *r_data;
+	u64 r_data_size;
+	if ((status =3D aaudio_cmd_get_property(a, &reply, devid, obj, prop, qual=
ifier, qualifier_size,
+			&r_data, &r_data_size)))
+		goto finish;
+	if (r_data_size !=3D data_size) {
+		status =3D -EINVAL;
+		goto finish;
+	}
+	memcpy(data, r_data, data_size);
+finish:
+	aaudio_reply_free(&reply);
+	return status;
+}
+int aaudio_cmd_set_property(struct aaudio_device *a, aaudio_device_id_t de=
vid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size, void =
*data, u64 data_size)
+{
+	CMD_DEF_SHARED_AND_SEND(aaudio_msg_write_set_property, devid, obj, prop, =
data, data_size,
+			qualifier, qualifier_size);
+	CMD_HNDL_REPLY_AND_FREE(aaudio_msg_read_set_property_response, &obj);
+}
+int aaudio_cmd_property_listener(struct aaudio_device *a, aaudio_device_id=
_t devid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop)
+{
+	CMD_DEF_SHARED_AND_SEND(aaudio_msg_write_property_listener, devid, obj, p=
rop);
+	CMD_HNDL_REPLY_AND_FREE(aaudio_msg_read_property_listener_response, &obj,=
 &prop);
+}
+int aaudio_cmd_set_input_stream_address_ranges(struct aaudio_device *a, aa=
udio_device_id_t devid)
+{
+	CMD_DEF_SHARED_AND_SEND(aaudio_msg_write_set_input_stream_address_ranges,=
 devid);
+	CMD_HNDL_REPLY_AND_FREE(aaudio_msg_read_set_input_stream_address_ranges_r=
esponse);
+}
+int aaudio_cmd_get_input_stream_list(struct aaudio_device *a, struct aaudi=
o_msg *buf, aaudio_device_id_t devid,
+		aaudio_object_id_t **str_l, u64 *str_cnt)
+{
+	CMD_DEF_SHARED_NO_REPLY_AND_SEND(aaudio_msg_write_get_input_stream_list, =
devid);
+	CMD_HNDL_REPLY_NO_FREE(aaudio_msg_read_get_input_stream_list_response, st=
r_l, str_cnt);
+}
+int aaudio_cmd_get_output_stream_list(struct aaudio_device *a, struct aaud=
io_msg *buf, aaudio_device_id_t devid,
+		aaudio_object_id_t **str_l, u64 *str_cnt)
+{
+	CMD_DEF_SHARED_NO_REPLY_AND_SEND(aaudio_msg_write_get_output_stream_list,=
 devid);
+	CMD_HNDL_REPLY_NO_FREE(aaudio_msg_read_get_output_stream_list_response, s=
tr_l, str_cnt);
+}
+int aaudio_cmd_set_remote_access(struct aaudio_device *a, u64 mode)
+{
+	CMD_DEF_SHARED_AND_SEND(aaudio_msg_write_set_remote_access, mode);
+	CMD_HNDL_REPLY_AND_FREE(aaudio_msg_read_set_remote_access_response);
+}
+int aaudio_cmd_get_device_list(struct aaudio_device *a, struct aaudio_msg =
*buf,
+		aaudio_device_id_t **dev_l, u64 *dev_cnt)
+{
+	CMD_DEF_SHARED_NO_REPLY_AND_SEND(aaudio_msg_write_get_device_list);
+	CMD_HNDL_REPLY_NO_FREE(aaudio_msg_read_get_device_list_response, dev_l, d=
ev_cnt);
+}
+
diff --git a/drivers/staging/apple-bce/audio/protocol.h b/drivers/staging/a=
pple-bce/audio/protocol.h
new file mode 100644
index 000000000..780a2a65f
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/protocol.h
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef AAUDIO_PROTOCOL_H
+#define AAUDIO_PROTOCOL_H
+
+#include <linux/types.h>
+
+struct aaudio_device;
+
+typedef u64 aaudio_device_id_t;
+typedef u64 aaudio_object_id_t;
+
+struct aaudio_msg {
+	void *data;
+	size_t size;
+};
+
+struct __attribute__((packed)) aaudio_msg_header {
+	char tag[4];
+	u8 type;
+	aaudio_device_id_t device_id; // Idk, use zero for commands?
+};
+struct __attribute__((packed)) aaudio_msg_base {
+	u32 msg;
+	u32 status;
+};
+
+struct aaudio_prop_addr {
+	u32 scope;
+	u32 selector;
+	u32 element;
+};
+#define AAUDIO_PROP(scope, sel, el) (struct aaudio_prop_addr) { scope, sel=
, el }
+
+enum {
+	AAUDIO_MSG_TYPE_COMMAND =3D 1,
+	AAUDIO_MSG_TYPE_RESPONSE =3D 2,
+	AAUDIO_MSG_TYPE_NOTIFICATION =3D 3
+};
+
+enum {
+	AAUDIO_MSG_START_IO =3D 0,
+	AAUDIO_MSG_START_IO_RESPONSE =3D 1,
+	AAUDIO_MSG_STOP_IO =3D 2,
+	AAUDIO_MSG_STOP_IO_RESPONSE =3D 3,
+	AAUDIO_MSG_UPDATE_TIMESTAMP =3D 4,
+	AAUDIO_MSG_GET_PROPERTY =3D 7,
+	AAUDIO_MSG_GET_PROPERTY_RESPONSE =3D 8,
+	AAUDIO_MSG_SET_PROPERTY =3D 9,
+	AAUDIO_MSG_SET_PROPERTY_RESPONSE =3D 10,
+	AAUDIO_MSG_PROPERTY_LISTENER =3D 11,
+	AAUDIO_MSG_PROPERTY_LISTENER_RESPONSE =3D 12,
+	AAUDIO_MSG_PROPERTY_CHANGED =3D 13,
+	AAUDIO_MSG_SET_INPUT_STREAM_ADDRESS_RANGES =3D 18,
+	AAUDIO_MSG_SET_INPUT_STREAM_ADDRESS_RANGES_RESPONSE =3D 19,
+	AAUDIO_MSG_GET_INPUT_STREAM_LIST =3D 24,
+	AAUDIO_MSG_GET_INPUT_STREAM_LIST_RESPONSE =3D 25,
+	AAUDIO_MSG_GET_OUTPUT_STREAM_LIST =3D 26,
+	AAUDIO_MSG_GET_OUTPUT_STREAM_LIST_RESPONSE =3D 27,
+	AAUDIO_MSG_SET_REMOTE_ACCESS =3D 32,
+	AAUDIO_MSG_SET_REMOTE_ACCESS_RESPONSE =3D 33,
+	AAUDIO_MSG_UPDATE_TIMESTAMP_RESPONSE =3D 34,
+
+	AAUDIO_MSG_NOTIFICATION_ALIVE =3D 100,
+	AAUDIO_MSG_GET_DEVICE_LIST =3D 101,
+	AAUDIO_MSG_GET_DEVICE_LIST_RESPONSE =3D 102,
+	AAUDIO_MSG_NOTIFICATION_BOOT =3D 104
+};
+
+enum {
+	AAUDIO_REMOTE_ACCESS_OFF =3D 0,
+	AAUDIO_REMOTE_ACCESS_ON =3D 2
+};
+
+enum {
+	AAUDIO_PROP_SCOPE_GLOBAL =3D 0x676c6f62, // 'glob'
+	AAUDIO_PROP_SCOPE_INPUT  =3D 0x696e7074, // 'inpt'
+	AAUDIO_PROP_SCOPE_OUTPUT =3D 0x6f757470  // 'outp'
+};
+
+enum {
+	AAUDIO_PROP_UID		  =3D 0x75696420, // 'uid '
+	AAUDIO_PROP_BOOL_VALUE   =3D 0x6263766c, // 'bcvl'
+	AAUDIO_PROP_JACK_PLUGGED =3D 0x6a61636b, // 'jack'
+	AAUDIO_PROP_SEL_VOLUME   =3D 0x64656176, // 'deav'
+	AAUDIO_PROP_LATENCY	  =3D 0x6c746e63, // 'ltnc'
+	AAUDIO_PROP_PHYS_FORMAT  =3D 0x70667420  // 'pft '
+};
+
+int aaudio_msg_read_base(struct aaudio_msg *msg, struct aaudio_msg_base *b=
ase);
+
+int aaudio_msg_read_start_io_response(struct aaudio_msg *msg);
+int aaudio_msg_read_stop_io_response(struct aaudio_msg *msg);
+int aaudio_msg_read_update_timestamp(struct aaudio_msg *msg, aaudio_device=
_id_t *devid,
+		u64 *timestamp, u64 *update_seed);
+int aaudio_msg_read_get_property_response(struct aaudio_msg *msg, aaudio_o=
bject_id_t *obj,
+		struct aaudio_prop_addr *prop, void **data, u64 *data_size);
+int aaudio_msg_read_set_property_response(struct aaudio_msg *msg, aaudio_o=
bject_id_t *obj);
+int aaudio_msg_read_property_listener_response(struct aaudio_msg *msg,aaud=
io_object_id_t *obj,
+		struct aaudio_prop_addr *prop);
+int aaudio_msg_read_property_changed(struct aaudio_msg *msg, aaudio_device=
_id_t *devid, aaudio_object_id_t *obj,
+		struct aaudio_prop_addr *prop);
+int aaudio_msg_read_set_input_stream_address_ranges_response(struct aaudio=
_msg *msg);
+int aaudio_msg_read_get_input_stream_list_response(struct aaudio_msg *msg,=
 aaudio_object_id_t **str_l, u64 *str_cnt);
+int aaudio_msg_read_get_output_stream_list_response(struct aaudio_msg *msg=
, aaudio_object_id_t **str_l, u64 *str_cnt);
+int aaudio_msg_read_set_remote_access_response(struct aaudio_msg *msg);
+int aaudio_msg_read_get_device_list_response(struct aaudio_msg *msg, aaudi=
o_device_id_t **dev_l, u64 *dev_cnt);
+
+void aaudio_msg_write_start_io(struct aaudio_msg *msg, aaudio_device_id_t =
dev);
+void aaudio_msg_write_stop_io(struct aaudio_msg *msg, aaudio_device_id_t d=
ev);
+void aaudio_msg_write_get_property(struct aaudio_msg *msg, aaudio_device_i=
d_t dev, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size);
+void aaudio_msg_write_set_property(struct aaudio_msg *msg, aaudio_device_i=
d_t dev, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *data, u64 data_size, void *qualifier=
, u64 qualifier_size);
+void aaudio_msg_write_property_listener(struct aaudio_msg *msg, aaudio_dev=
ice_id_t dev, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop);
+void aaudio_msg_write_set_input_stream_address_ranges(struct aaudio_msg *m=
sg, aaudio_device_id_t devid);
+void aaudio_msg_write_get_input_stream_list(struct aaudio_msg *msg, aaudio=
_device_id_t devid);
+void aaudio_msg_write_get_output_stream_list(struct aaudio_msg *msg, aaudi=
o_device_id_t devid);
+void aaudio_msg_write_set_remote_access(struct aaudio_msg *msg, u64 mode);
+void aaudio_msg_write_alive_notification(struct aaudio_msg *msg, u32 proto=
_ver, u32 msg_ver);
+void aaudio_msg_write_update_timestamp_response(struct aaudio_msg *msg);
+void aaudio_msg_write_get_device_list(struct aaudio_msg *msg);
+
+
+int aaudio_cmd_start_io(struct aaudio_device *a, aaudio_device_id_t devid)=
;
+int aaudio_cmd_stop_io(struct aaudio_device *a, aaudio_device_id_t devid);
+int aaudio_cmd_get_property(struct aaudio_device *a, struct aaudio_msg *bu=
f,
+		aaudio_device_id_t devid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size, void =
**data, u64 *data_size);
+int aaudio_cmd_get_primitive_property(struct aaudio_device *a,
+		aaudio_device_id_t devid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size, void =
*data, u64 data_size);
+int aaudio_cmd_set_property(struct aaudio_device *a, aaudio_device_id_t de=
vid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop, void *qualifier, u64 qualifier_size, void =
*data, u64 data_size);
+int aaudio_cmd_property_listener(struct aaudio_device *a, aaudio_device_id=
_t devid, aaudio_object_id_t obj,
+		struct aaudio_prop_addr prop);
+int aaudio_cmd_set_input_stream_address_ranges(struct aaudio_device *a, aa=
udio_device_id_t devid);
+int aaudio_cmd_get_input_stream_list(struct aaudio_device *a, struct aaudi=
o_msg *buf, aaudio_device_id_t devid,
+		aaudio_object_id_t **str_l, u64 *str_cnt);
+int aaudio_cmd_get_output_stream_list(struct aaudio_device *a, struct aaud=
io_msg *buf, aaudio_device_id_t devid,
+		aaudio_object_id_t **str_l, u64 *str_cnt);
+int aaudio_cmd_set_remote_access(struct aaudio_device *a, u64 mode);
+int aaudio_cmd_get_device_list(struct aaudio_device *a, struct aaudio_msg =
*buf,
+		aaudio_device_id_t **dev_l, u64 *dev_cnt);
+
+#endif //AAUDIO_PROTOCOL_H
+
diff --git a/drivers/staging/apple-bce/audio/protocol_bce.c b/drivers/stagi=
ng/apple-bce/audio/protocol_bce.c
new file mode 100644
index 000000000..dc2e42532
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/protocol_bce.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "protocol_bce.h"
+
+#include "audio.h"
+
+static void aaudio_bce_out_queue_completion(struct bce_queue_sq *sq);
+static void aaudio_bce_in_queue_completion(struct bce_queue_sq *sq);
+static int aaudio_bce_queue_init(struct aaudio_device *dev, struct aaudio_=
bce_queue *q, const char *name, int direction,
+								 bce_sq_completion cfn);
+void aaudio_bce_in_queue_submit_pending(struct aaudio_bce_queue *q, size_t=
 count);
+
+int aaudio_bce_init(struct aaudio_device *dev)
+{
+	int status;
+	struct aaudio_bce *bce =3D &dev->bcem;
+	bce->cq =3D bce_create_cq(dev->bce, 0x80);
+	spin_lock_init(&bce->spinlock);
+	if (!bce->cq)
+		return -EINVAL;
+	if ((status =3D aaudio_bce_queue_init(dev, &bce->qout, "com.apple.BridgeA=
udio.IntelToARM", DMA_TO_DEVICE,
+			aaudio_bce_out_queue_completion))) {
+		return status;
+	}
+	if ((status =3D aaudio_bce_queue_init(dev, &bce->qin, "com.apple.BridgeAu=
dio.ARMToIntel", DMA_FROM_DEVICE,
+			aaudio_bce_in_queue_completion))) {
+		return status;
+	}
+	aaudio_bce_in_queue_submit_pending(&bce->qin, bce->qin.el_count);
+	return 0;
+}
+
+int aaudio_bce_queue_init(struct aaudio_device *dev, struct aaudio_bce_que=
ue *q, const char *name, int direction,
+		bce_sq_completion cfn)
+{
+	q->cq =3D dev->bcem.cq;
+	q->el_size =3D AAUDIO_BCE_QUEUE_ELEMENT_SIZE;
+	q->el_count =3D AAUDIO_BCE_QUEUE_ELEMENT_COUNT;
+	/* NOTE: The Apple impl uses 0x80 as the queue size, however we use 21 (i=
n fact 20) to simplify the impl */
+	q->sq =3D bce_create_sq(dev->bce, q->cq, name, (u32) (q->el_count + 1), d=
irection, cfn, dev);
+	if (!q->sq)
+		return -EINVAL;
+
+	q->data =3D dma_alloc_coherent(&dev->bce->pci->dev, q->el_size * q->el_co=
unt, &q->dma_addr, GFP_KERNEL);
+	if (!q->data) {
+		bce_destroy_sq(dev->bce, q->sq);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void aaudio_send_create_tag(struct aaudio_bce *b, int *tagn, char t=
ag[4])
+{
+	char tag_zero[5];
+	b->tag_num =3D (b->tag_num + 1) % AAUDIO_BCE_QUEUE_TAG_COUNT;
+	*tagn =3D b->tag_num;
+	snprintf(tag_zero, 5, "S%03d", b->tag_num);
+	*((u32 *) tag) =3D *((u32 *) tag_zero);
+}
+
+int __aaudio_send_prepare(struct aaudio_bce *b, struct aaudio_send_ctx *ct=
x, char *tag)
+{
+	int status;
+	size_t index;
+	void *dptr;
+	struct aaudio_msg_header *header;
+	if ((status =3D bce_reserve_submission(b->qout.sq, &ctx->timeout)))
+		return status;
+	spin_lock_irqsave(&b->spinlock, ctx->irq_flags);
+	index =3D b->qout.data_tail;
+	dptr =3D (u8 *) b->qout.data + index * b->qout.el_size;
+	ctx->msg.data =3D dptr;
+	header =3D dptr;
+	if (tag)
+		*((u32 *) header->tag) =3D *((u32 *) tag);
+	else
+		aaudio_send_create_tag(b, &ctx->tag_n, header->tag);
+	return 0;
+}
+
+void __aaudio_send(struct aaudio_bce *b, struct aaudio_send_ctx *ctx)
+{
+	struct bce_qe_submission *s =3D bce_next_submission(b->qout.sq);
+#ifdef DEBUG
+	pr_debug("aaudio: Sending command data\n");
+	print_hex_dump(KERN_DEBUG, "aaudio:OUT ", DUMP_PREFIX_NONE, 32, 1, ctx->m=
sg.data, ctx->msg.size, true);
+#endif
+	bce_set_submission_single(s, b->qout.dma_addr + (dma_addr_t) (ctx->msg.da=
ta - b->qout.data), ctx->msg.size);
+	bce_submit_to_device(b->qout.sq);
+	b->qout.data_tail =3D (b->qout.data_tail + 1) % b->qout.el_count;
+	spin_unlock_irqrestore(&b->spinlock, ctx->irq_flags);
+}
+
+int __aaudio_send_cmd_sync(struct aaudio_bce *b, struct aaudio_send_ctx *c=
tx, struct aaudio_msg *reply)
+{
+	struct aaudio_bce_queue_entry ent;
+	DECLARE_COMPLETION_ONSTACK(cmpl);
+	ent.msg =3D reply;
+	ent.cmpl =3D &cmpl;
+	b->pending_entries[ctx->tag_n] =3D &ent;
+	__aaudio_send(b, ctx); /* unlocks the spinlock */
+	ctx->timeout =3D wait_for_completion_timeout(&cmpl, ctx->timeout);
+	if (ctx->timeout =3D=3D 0) {
+		/* Remove the pending queue entry; this will be normally handled by the =
completion route but
+		 * during a timeout it won't */
+		spin_lock_irqsave(&b->spinlock, ctx->irq_flags);
+		if (b->pending_entries[ctx->tag_n] =3D=3D &ent)
+			b->pending_entries[ctx->tag_n] =3D NULL;
+		spin_unlock_irqrestore(&b->spinlock, ctx->irq_flags);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static void aaudio_handle_reply(struct aaudio_bce *b, struct aaudio_msg *r=
eply)
+{
+	const char *tag;
+	int tagn;
+	unsigned long irq_flags;
+	char tag_zero[5];
+	struct aaudio_bce_queue_entry *entry;
+
+	tag =3D ((struct aaudio_msg_header *) reply->data)->tag;
+	if (tag[0] !=3D 'S') {
+		pr_err("aaudio_handle_reply: Unexpected tag: %.4s\n", tag);
+		return;
+	}
+	*((u32 *) tag_zero) =3D *((u32 *) tag);
+	tag_zero[4] =3D 0;
+	if (kstrtoint(&tag_zero[1], 10, &tagn)) {
+		pr_err("aaudio_handle_reply: Tag parse failed: %.4s\n", tag);
+		return;
+	}
+
+	spin_lock_irqsave(&b->spinlock, irq_flags);
+	entry =3D b->pending_entries[tagn];
+	if (entry) {
+		if (reply->size < entry->msg->size)
+			entry->msg->size =3D reply->size;
+		memcpy(entry->msg->data, reply->data, entry->msg->size);
+		complete(entry->cmpl);
+
+		b->pending_entries[tagn] =3D NULL;
+	} else {
+		pr_err("aaudio_handle_reply: No queued item found for tag: %.4s\n", tag)=
;
+	}
+	spin_unlock_irqrestore(&b->spinlock, irq_flags);
+}
+
+static void aaudio_bce_out_queue_completion(struct bce_queue_sq *sq)
+{
+	while (bce_next_completion(sq)) {
+		//pr_info("aaudio: Send confirmed\n");
+		bce_notify_submission_complete(sq);
+	}
+}
+
+static void aaudio_bce_in_queue_handle_msg(struct aaudio_device *a, struct=
 aaudio_msg *msg);
+
+static void aaudio_bce_in_queue_completion(struct bce_queue_sq *sq)
+{
+	struct aaudio_msg msg;
+	struct aaudio_device *dev =3D sq->userdata;
+	struct aaudio_bce_queue *q =3D &dev->bcem.qin;
+	struct bce_sq_completion_data *c;
+	size_t cnt =3D 0;
+
+	mb();
+	while ((c =3D bce_next_completion(sq))) {
+		msg.data =3D (u8 *) q->data + q->data_head * q->el_size;
+		msg.size =3D c->data_size;
+#ifdef DEBUG
+		pr_debug("aaudio: Received command data %llx\n", c->data_size);
+		print_hex_dump(KERN_DEBUG, "aaudio:IN ", DUMP_PREFIX_NONE, 32, 1, msg.da=
ta, min(msg.size, 128UL), true);
+#endif
+		aaudio_bce_in_queue_handle_msg(dev, &msg);
+
+		q->data_head =3D (q->data_head + 1) % q->el_count;
+
+		bce_notify_submission_complete(sq);
+		++cnt;
+	}
+	aaudio_bce_in_queue_submit_pending(q, cnt);
+}
+
+static void aaudio_bce_in_queue_handle_msg(struct aaudio_device *a, struct=
 aaudio_msg *msg)
+{
+	struct aaudio_msg_header *header =3D (struct aaudio_msg_header *) msg->da=
ta;
+	if (msg->size < sizeof(struct aaudio_msg_header)) {
+		pr_err("aaudio: Msg size smaller than header (%lx)", msg->size);
+		return;
+	}
+	if (header->type =3D=3D AAUDIO_MSG_TYPE_RESPONSE) {
+		aaudio_handle_reply(&a->bcem, msg);
+	} else if (header->type =3D=3D AAUDIO_MSG_TYPE_COMMAND) {
+		aaudio_handle_command(a, msg);
+	} else if (header->type =3D=3D AAUDIO_MSG_TYPE_NOTIFICATION) {
+		aaudio_handle_notification(a, msg);
+	}
+}
+
+void aaudio_bce_in_queue_submit_pending(struct aaudio_bce_queue *q, size_t=
 count)
+{
+	struct bce_qe_submission *s;
+	while (count--) {
+		if (bce_reserve_submission(q->sq, NULL)) {
+			pr_err("aaudio: Failed to reserve an event queue submission\n");
+			break;
+		}
+		s =3D bce_next_submission(q->sq);
+		bce_set_submission_single(s, q->dma_addr + (dma_addr_t) (q->data_tail * =
q->el_size), q->el_size);
+		q->data_tail =3D (q->data_tail + 1) % q->el_count;
+	}
+	bce_submit_to_device(q->sq);
+}
+
+struct aaudio_msg aaudio_reply_alloc(void)
+{
+	struct aaudio_msg ret;
+	ret.size =3D AAUDIO_BCE_QUEUE_ELEMENT_SIZE;
+	ret.data =3D kmalloc(ret.size, GFP_KERNEL);
+	return ret;
+}
+
+void aaudio_reply_free(struct aaudio_msg *reply)
+{
+	kfree(reply->data);
+}
+
diff --git a/drivers/staging/apple-bce/audio/protocol_bce.h b/drivers/stagi=
ng/apple-bce/audio/protocol_bce.h
new file mode 100644
index 000000000..2f92673dd
--- /dev/null
+++ b/drivers/staging/apple-bce/audio/protocol_bce.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef AAUDIO_PROTOCOL_BCE_H
+#define AAUDIO_PROTOCOL_BCE_H
+
+#include "protocol.h"
+#include "../queue.h"
+
+#define AAUDIO_BCE_QUEUE_ELEMENT_SIZE 0x1000
+#define AAUDIO_BCE_QUEUE_ELEMENT_COUNT 20
+
+#define AAUDIO_BCE_QUEUE_TAG_COUNT 1000
+
+struct aaudio_device;
+
+struct aaudio_bce_queue_entry {
+	struct aaudio_msg *msg;
+	struct completion *cmpl;
+};
+struct aaudio_bce_queue {
+	struct bce_queue_cq *cq;
+	struct bce_queue_sq *sq;
+	void *data;
+	dma_addr_t dma_addr;
+	size_t data_head, data_tail;
+	size_t el_size, el_count;
+};
+struct aaudio_bce {
+	struct bce_queue_cq *cq;
+	struct aaudio_bce_queue qin;
+	struct aaudio_bce_queue qout;
+	int tag_num;
+	struct aaudio_bce_queue_entry *pending_entries[AAUDIO_BCE_QUEUE_TAG_COUNT=
];
+	struct spinlock spinlock;
+};
+
+struct aaudio_send_ctx {
+	int status;
+	int tag_n;
+	unsigned long irq_flags;
+	struct aaudio_msg msg;
+	unsigned long timeout;
+};
+
+int aaudio_bce_init(struct aaudio_device *dev);
+int __aaudio_send_prepare(struct aaudio_bce *b, struct aaudio_send_ctx *ct=
x, char *tag);
+void __aaudio_send(struct aaudio_bce *b, struct aaudio_send_ctx *ctx);
+int __aaudio_send_cmd_sync(struct aaudio_bce *b, struct aaudio_send_ctx *c=
tx, struct aaudio_msg *reply);
+
+#define aaudio_send_with_tag(a, ctx, tag, tout, fn, ...) ({ \
+	(ctx)->timeout =3D msecs_to_jiffies(tout); \
+	(ctx)->status =3D __aaudio_send_prepare(&(a)->bcem, (ctx), (tag)); \
+	if (!(ctx)->status) { \
+		fn(&(ctx)->msg, ##__VA_ARGS__); \
+		__aaudio_send(&(a)->bcem, (ctx)); \
+	} \
+	(ctx)->status; \
+})
+#define aaudio_send(a, ctx, tout, fn, ...) aaudio_send_with_tag(a, ctx, NU=
LL, tout, fn, ##__VA_ARGS__)
+
+#define aaudio_send_cmd_sync(a, ctx, reply, tout, fn, ...) ({ \
+	(ctx)->timeout =3D msecs_to_jiffies(tout); \
+	(ctx)->status =3D __aaudio_send_prepare(&(a)->bcem, (ctx), NULL); \
+	if (!(ctx)->status) { \
+		fn(&(ctx)->msg, ##__VA_ARGS__); \
+		(ctx)->status =3D __aaudio_send_cmd_sync(&(a)->bcem, (ctx), (reply)); \
+	} \
+	(ctx)->status; \
+})
+
+struct aaudio_msg aaudio_reply_alloc(void);
+void aaudio_reply_free(struct aaudio_msg *reply);
+
+#endif //AAUDIO_PROTOCOL_BCE_H
+
diff --git a/drivers/staging/apple-bce/mailbox.c b/drivers/staging/apple-bc=
e/mailbox.c
new file mode 100644
index 000000000..0a1b3ec36
--- /dev/null
+++ b/drivers/staging/apple-bce/mailbox.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "mailbox.h"
+#include <linux/atomic.h>
+#include "apple_bce.h"
+
+#define REG_MBOX_OUT_BASE 0x820
+#define REG_MBOX_REPLY_COUNTER 0x108
+#define REG_MBOX_REPLY_BASE 0x810
+#define REG_TIMESTAMP_BASE 0xC000
+
+#define BCE_MBOX_TIMEOUT_MS 200
+
+void bce_mailbox_init(struct bce_mailbox *mb, void __iomem *reg_mb)
+{
+	mb->reg_mb =3D reg_mb;
+	init_completion(&mb->mb_completion);
+}
+
+int bce_mailbox_send(struct bce_mailbox *mb, u64 msg, u64* recv)
+{
+	u32 __iomem *regb;
+
+	if (atomic_cmpxchg(&mb->mb_status, 0, 1) !=3D 0) {
+		return -EEXIST; // We don't support two messages at once
+	}
+	reinit_completion(&mb->mb_completion);
+
+	pr_debug("bce_mailbox_send: %llx\n", msg);
+	regb =3D (u32 __iomem *) ((u8 __iomem *) mb->reg_mb + REG_MBOX_OUT_BASE);
+	iowrite32((u32) msg, regb);
+	iowrite32((u32) (msg >> 32), regb + 1);
+	iowrite32(0, regb + 2);
+	iowrite32(0, regb + 3);
+
+	wait_for_completion_timeout(&mb->mb_completion, msecs_to_jiffies(BCE_MBOX=
_TIMEOUT_MS));
+	if (atomic_read(&mb->mb_status) !=3D 2) { // Didn't get the reply
+		atomic_set(&mb->mb_status, 0);
+		return -ETIMEDOUT;
+	}
+
+	*recv =3D mb->mb_result;
+	pr_debug("bce_mailbox_send: reply %llx\n", *recv);
+
+	atomic_set(&mb->mb_status, 0);
+	return 0;
+}
+
+static int bce_mailbox_retrive_response(struct bce_mailbox *mb)
+{
+	u32 __iomem *regb;
+	u32 lo, hi;
+	int count, counter;
+	u32 res =3D ioread32((u8 __iomem *) mb->reg_mb + REG_MBOX_REPLY_COUNTER);
+	count =3D (res >> 20) & 0xf;
+	counter =3D count;
+	pr_debug("bce_mailbox_retrive_response count=3D%i\n", count);
+	while (counter--) {
+		regb =3D (u32 __iomem *) ((u8 __iomem *) mb->reg_mb + REG_MBOX_REPLY_BAS=
E);
+		lo =3D ioread32(regb);
+		hi =3D ioread32(regb + 1);
+		ioread32(regb + 2);
+		ioread32(regb + 3);
+		pr_debug("bce_mailbox_retrive_response %llx\n", ((u64) hi << 32) | lo);
+		mb->mb_result =3D ((u64) hi << 32) | lo;
+	}
+	return count > 0 ? 0 : -ENODATA;
+}
+
+int bce_mailbox_handle_interrupt(struct bce_mailbox *mb)
+{
+	int status =3D bce_mailbox_retrive_response(mb);
+	if (!status) {
+		atomic_set(&mb->mb_status, 2);
+		complete(&mb->mb_completion);
+	}
+	return status;
+}
+
+static void bc_send_timestamp(struct timer_list *tl);
+
+void bce_timestamp_init(struct bce_timestamp *ts, void __iomem *reg)
+{
+	u32 __iomem *regb;
+
+	spin_lock_init(&ts->stop_sl);
+	ts->stopped =3D false;
+
+	ts->reg =3D reg;
+
+	regb =3D (u32 __iomem *) ((u8 __iomem *) ts->reg + REG_TIMESTAMP_BASE);
+
+	ioread32(regb);
+	mb();
+
+	timer_setup(&ts->timer, bc_send_timestamp, 0);
+}
+
+void bce_timestamp_start(struct bce_timestamp *ts, bool is_initial)
+{
+	unsigned long flags;
+	u32 __iomem *regb =3D (u32 __iomem *) ((u8 __iomem *) ts->reg + REG_TIMES=
TAMP_BASE);
+
+	if (is_initial) {
+		iowrite32((u32) -4, regb + 2);
+		iowrite32((u32) -1, regb);
+	} else {
+		iowrite32((u32) -3, regb + 2);
+		iowrite32((u32) -1, regb);
+	}
+
+	spin_lock_irqsave(&ts->stop_sl, flags);
+	ts->stopped =3D false;
+	spin_unlock_irqrestore(&ts->stop_sl, flags);
+	mod_timer(&ts->timer, jiffies + msecs_to_jiffies(150));
+}
+
+void bce_timestamp_stop(struct bce_timestamp *ts)
+{
+	unsigned long flags;
+	u32 __iomem *regb =3D (u32 __iomem *) ((u8 __iomem *) ts->reg + REG_TIMES=
TAMP_BASE);
+
+	spin_lock_irqsave(&ts->stop_sl, flags);
+	ts->stopped =3D true;
+	spin_unlock_irqrestore(&ts->stop_sl, flags);
+	del_timer_sync(&ts->timer);
+
+	iowrite32((u32) -2, regb + 2);
+	iowrite32((u32) -1, regb);
+}
+
+static void bc_send_timestamp(struct timer_list *tl)
+{
+	struct bce_timestamp *ts;
+	unsigned long flags;
+	u32 __iomem *regb;
+	ktime_t bt;
+
+	ts =3D container_of(tl, struct bce_timestamp, timer);
+	regb =3D (u32 __iomem *) ((u8 __iomem *) ts->reg + REG_TIMESTAMP_BASE);
+	local_irq_save(flags);
+	ioread32(regb + 2);
+	mb();
+	bt =3D ktime_get_boottime();
+	iowrite32((u32) bt, regb + 2);
+	iowrite32((u32) (bt >> 32), regb);
+
+	spin_lock(&ts->stop_sl);
+	if (!ts->stopped)
+		mod_timer(&ts->timer, jiffies + msecs_to_jiffies(150));
+	spin_unlock(&ts->stop_sl);
+	local_irq_restore(flags);
+}
+
diff --git a/drivers/staging/apple-bce/mailbox.h b/drivers/staging/apple-bc=
e/mailbox.h
new file mode 100644
index 000000000..239089207
--- /dev/null
+++ b/drivers/staging/apple-bce/mailbox.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCE_MAILBOX_H
+#define BCE_MAILBOX_H
+
+#include <linux/completion.h>
+#include <linux/pci.h>
+#include <linux/timer.h>
+
+struct bce_mailbox {
+	void __iomem *reg_mb;
+
+	atomic_t mb_status; // possible statuses: 0 (no msg), 1 (has active msg),=
 2 (got reply)
+	struct completion mb_completion;
+	uint64_t mb_result;
+};
+
+enum bce_message_type {
+	BCE_MB_REGISTER_COMMAND_SQ =3D 0x7,			// to-device
+	BCE_MB_REGISTER_COMMAND_CQ =3D 0x8,			// to-device
+	BCE_MB_REGISTER_COMMAND_QUEUE_REPLY =3D 0xB,   // to-host
+	BCE_MB_SET_FW_PROTOCOL_VERSION =3D 0xC,		// both
+	BCE_MB_SLEEP_NO_STATE =3D 0x14,				// to-device
+	BCE_MB_RESTORE_NO_STATE =3D 0x15,			  // to-device
+	BCE_MB_SAVE_STATE_AND_SLEEP =3D 0x17,		  // to-device
+	BCE_MB_RESTORE_STATE_AND_WAKE =3D 0x18,		// to-device
+	BCE_MB_SAVE_STATE_AND_SLEEP_FAILURE =3D 0x19,  // from-device
+	BCE_MB_SAVE_RESTORE_STATE_COMPLETE =3D 0x1A,   // from-device
+};
+
+#define BCE_MB_MSG(type, value) (((u64) (type) << 58) | ((value) & 0x3FFFF=
FFFFFFFFFFLL))
+#define BCE_MB_TYPE(v) ((u32) (v >> 58))
+#define BCE_MB_VALUE(v) (v & 0x3FFFFFFFFFFFFFFLL)
+
+void bce_mailbox_init(struct bce_mailbox *mb, void __iomem *reg_mb);
+
+int bce_mailbox_send(struct bce_mailbox *mb, u64 msg, u64* recv);
+
+int bce_mailbox_handle_interrupt(struct bce_mailbox *mb);
+
+
+struct bce_timestamp {
+	void __iomem *reg;
+	struct timer_list timer;
+	struct spinlock stop_sl;
+	bool stopped;
+};
+
+void bce_timestamp_init(struct bce_timestamp *ts, void __iomem *reg);
+
+void bce_timestamp_start(struct bce_timestamp *ts, bool is_initial);
+
+void bce_timestamp_stop(struct bce_timestamp *ts);
+
+#endif //BCEDRIVER_MAILBOX_H
+
diff --git a/drivers/staging/apple-bce/queue.c b/drivers/staging/apple-bce/=
queue.c
new file mode 100644
index 000000000..9e86ca164
--- /dev/null
+++ b/drivers/staging/apple-bce/queue.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "queue.h"
+#include "apple_bce.h"
+
+#define REG_DOORBELL_BASE 0x44000
+
+struct bce_queue_cq *bce_alloc_cq(struct apple_bce_device *dev, int qid, u=
32 el_count)
+{
+	struct bce_queue_cq *q;
+	q =3D kzalloc(sizeof(struct bce_queue_cq), GFP_KERNEL);
+	q->qid =3D qid;
+	q->type =3D BCE_QUEUE_CQ;
+	q->el_count =3D el_count;
+	q->data =3D dma_alloc_coherent(&dev->pci->dev, el_count * sizeof(struct b=
ce_qe_completion),
+			&q->dma_handle, GFP_KERNEL);
+	if (!q->data) {
+		pr_err("DMA queue memory alloc failed\n");
+		kfree(q);
+		return NULL;
+	}
+	return q;
+}
+
+void bce_get_cq_memcfg(struct bce_queue_cq *cq, struct bce_queue_memcfg *c=
fg)
+{
+	cfg->qid =3D (u16) cq->qid;
+	cfg->el_count =3D (u16) cq->el_count;
+	cfg->vector_or_cq =3D 0;
+	cfg->_pad =3D 0;
+	cfg->addr =3D cq->dma_handle;
+	cfg->length =3D cq->el_count * sizeof(struct bce_qe_completion);
+}
+
+void bce_free_cq(struct apple_bce_device *dev, struct bce_queue_cq *cq)
+{
+	dma_free_coherent(&dev->pci->dev, cq->el_count * sizeof(struct bce_qe_com=
pletion), cq->data, cq->dma_handle);
+	kfree(cq);
+}
+
+static void bce_handle_cq_completion(struct apple_bce_device *dev, struct =
bce_qe_completion *e, size_t *ce)
+{
+	struct bce_queue *target;
+	struct bce_queue_sq *target_sq;
+	struct bce_sq_completion_data *cmpl;
+	if (e->qid >=3D BCE_MAX_QUEUE_COUNT) {
+		pr_err("Device sent a response for qid (%u) >=3D BCE_MAX_QUEUE_COUNT\n",=
 e->qid);
+		return;
+	}
+	target =3D dev->queues[e->qid];
+	if (!target || target->type !=3D BCE_QUEUE_SQ) {
+		pr_err("Device sent a response for qid (%u), which does not exist\n", e-=
>qid);
+		return;
+	}
+	target_sq =3D (struct bce_queue_sq *) target;
+	if (target_sq->completion_tail !=3D e->completion_index) {
+		pr_err("Completion index mismatch; this is likely going to make this dri=
ver unusable\n");
+		return;
+	}
+	if (!target_sq->has_pending_completions) {
+		target_sq->has_pending_completions =3D true;
+		dev->int_sq_list[(*ce)++] =3D target_sq;
+	}
+	cmpl =3D &target_sq->completion_data[e->completion_index];
+	cmpl->status =3D e->status;
+	cmpl->data_size =3D e->data_size;
+	cmpl->result =3D e->result;
+	wmb();
+	target_sq->completion_tail =3D (target_sq->completion_tail + 1) % target_=
sq->el_count;
+}
+
+void bce_handle_cq_completions(struct apple_bce_device *dev, struct bce_qu=
eue_cq *cq)
+{
+	size_t ce =3D 0;
+	struct bce_qe_completion *e;
+	struct bce_queue_sq *sq;
+	e =3D bce_cq_element(cq, cq->index);
+	if (!(e->flags & BCE_COMPLETION_FLAG_PENDING))
+		return;
+	mb();
+	while (true) {
+		e =3D bce_cq_element(cq, cq->index);
+		if (!(e->flags & BCE_COMPLETION_FLAG_PENDING))
+			break;
+		// pr_info("apple-bce: compl: %i: %i %llx %llx", e->qid, e->status, e->d=
ata_size, e->result);
+		bce_handle_cq_completion(dev, e, &ce);
+		e->flags =3D 0;
+		cq->index =3D (cq->index + 1) % cq->el_count;
+	}
+	mb();
+	iowrite32(cq->index, (u32 __iomem *) ((u8 __iomem *) dev->reg_mem_dma +  =
REG_DOORBELL_BASE) + cq->qid);
+	while (ce) {
+		--ce;
+		sq =3D dev->int_sq_list[ce];
+		sq->completion(sq);
+		sq->has_pending_completions =3D false;
+	}
+}
+
+
+struct bce_queue_sq *bce_alloc_sq(struct apple_bce_device *dev, int qid, u=
32 el_size, u32 el_count,
+		bce_sq_completion compl, void *userdata)
+{
+	struct bce_queue_sq *q;
+	q =3D kzalloc(sizeof(struct bce_queue_sq), GFP_KERNEL);
+	q->qid =3D qid;
+	q->type =3D BCE_QUEUE_SQ;
+	q->el_size =3D el_size;
+	q->el_count =3D el_count;
+	q->data =3D dma_alloc_coherent(&dev->pci->dev, el_count * el_size,
+								 &q->dma_handle, GFP_KERNEL);
+	q->completion =3D compl;
+	q->userdata =3D userdata;
+	q->completion_data =3D kzalloc(sizeof(struct bce_sq_completion_data) * el=
_count, GFP_KERNEL);
+	q->reg_mem_dma =3D dev->reg_mem_dma;
+	atomic_set(&q->available_commands, el_count - 1);
+	init_completion(&q->available_command_completion);
+	atomic_set(&q->available_command_completion_waiting_count, 0);
+	if (!q->data) {
+		pr_err("DMA queue memory alloc failed\n");
+		kfree(q);
+		return NULL;
+	}
+	return q;
+}
+
+void bce_get_sq_memcfg(struct bce_queue_sq *sq, struct bce_queue_cq *cq, s=
truct bce_queue_memcfg *cfg)
+{
+	cfg->qid =3D (u16) sq->qid;
+	cfg->el_count =3D (u16) sq->el_count;
+	cfg->vector_or_cq =3D (u16) cq->qid;
+	cfg->_pad =3D 0;
+	cfg->addr =3D sq->dma_handle;
+	cfg->length =3D sq->el_count * sq->el_size;
+}
+
+void bce_free_sq(struct apple_bce_device *dev, struct bce_queue_sq *sq)
+{
+	dma_free_coherent(&dev->pci->dev, sq->el_count * sq->el_size, sq->data, s=
q->dma_handle);
+	kfree(sq);
+}
+
+int bce_reserve_submission(struct bce_queue_sq *sq, unsigned long *timeout=
)
+{
+	while (atomic_dec_if_positive(&sq->available_commands) < 0) {
+		if (!timeout || !*timeout)
+			return -EAGAIN;
+		atomic_inc(&sq->available_command_completion_waiting_count);
+		*timeout =3D wait_for_completion_timeout(&sq->available_command_completi=
on, *timeout);
+		if (!*timeout) {
+			if (atomic_dec_if_positive(&sq->available_command_completion_waiting_co=
unt) < 0)
+				try_wait_for_completion(&sq->available_command_completion); /* consume=
 the pending completion */
+		}
+	}
+	return 0;
+}
+
+void bce_cancel_submission_reservation(struct bce_queue_sq *sq)
+{
+	atomic_inc(&sq->available_commands);
+}
+
+void *bce_next_submission(struct bce_queue_sq *sq)
+{
+	void *ret =3D bce_sq_element(sq, sq->tail);
+	sq->tail =3D (sq->tail + 1) % sq->el_count;
+	return ret;
+}
+
+void bce_submit_to_device(struct bce_queue_sq *sq)
+{
+	mb();
+	iowrite32(sq->tail, (u32 __iomem *) ((u8 __iomem *) sq->reg_mem_dma + REG=
_DOORBELL_BASE) + sq->qid);
+}
+
+void bce_notify_submission_complete(struct bce_queue_sq *sq)
+{
+	sq->head =3D (sq->head + 1) % sq->el_count;
+	atomic_inc(&sq->available_commands);
+	if (atomic_dec_if_positive(&sq->available_command_completion_waiting_coun=
t) >=3D 0) {
+		complete(&sq->available_command_completion);
+	}
+}
+
+void bce_set_submission_single(struct bce_qe_submission *element, dma_addr=
_t addr, size_t size)
+{
+	element->addr =3D addr;
+	element->length =3D size;
+	element->segl_addr =3D element->segl_length =3D 0;
+}
+
+static void bce_cmdq_completion(struct bce_queue_sq *q);
+
+struct bce_queue_cmdq *bce_alloc_cmdq(struct apple_bce_device *dev, int qi=
d, u32 el_count)
+{
+	struct bce_queue_cmdq *q;
+	q =3D kzalloc(sizeof(struct bce_queue_cmdq), GFP_KERNEL);
+	q->sq =3D bce_alloc_sq(dev, qid, BCE_CMD_SIZE, el_count, bce_cmdq_complet=
ion, q);
+	if (!q->sq) {
+		kfree(q);
+		return NULL;
+	}
+	spin_lock_init(&q->lck);
+	q->tres =3D kzalloc(sizeof(struct bce_queue_cmdq_result_el*) * el_count, =
GFP_KERNEL);
+	if (!q->tres) {
+		kfree(q);
+		return NULL;
+	}
+	return q;
+}
+
+void bce_free_cmdq(struct apple_bce_device *dev, struct bce_queue_cmdq *cm=
dq)
+{
+	bce_free_sq(dev, cmdq->sq);
+	kfree(cmdq->tres);
+	kfree(cmdq);
+}
+
+void bce_cmdq_completion(struct bce_queue_sq *q)
+{
+	struct bce_queue_cmdq_result_el *el;
+	struct bce_queue_cmdq *cmdq =3D q->userdata;
+	struct bce_sq_completion_data *result;
+
+	spin_lock(&cmdq->lck);
+	while ((result =3D bce_next_completion(q))) {
+		el =3D cmdq->tres[cmdq->sq->head];
+		if (el) {
+			el->result =3D result->result;
+			el->status =3D result->status;
+			mb();
+			complete(&el->cmpl);
+		} else {
+			pr_err("apple-bce: Unexpected command queue completion\n");
+		}
+		cmdq->tres[cmdq->sq->head] =3D NULL;
+		bce_notify_submission_complete(q);
+	}
+	spin_unlock(&cmdq->lck);
+}
+
+static __always_inline void *bce_cmd_start(struct bce_queue_cmdq *cmdq, st=
ruct bce_queue_cmdq_result_el *res)
+{
+	void *ret;
+	unsigned long timeout;
+	init_completion(&res->cmpl);
+	mb();
+
+	timeout =3D msecs_to_jiffies(1000L * 60 * 5); /* wait for up to ~5 minute=
s */
+	if (bce_reserve_submission(cmdq->sq, &timeout))
+		return NULL;
+
+	spin_lock(&cmdq->lck);
+	cmdq->tres[cmdq->sq->tail] =3D res;
+	ret =3D bce_next_submission(cmdq->sq);
+	return ret;
+}
+
+static __always_inline void bce_cmd_finish(struct bce_queue_cmdq *cmdq, st=
ruct bce_queue_cmdq_result_el *res)
+{
+	bce_submit_to_device(cmdq->sq);
+	spin_unlock(&cmdq->lck);
+
+	wait_for_completion(&res->cmpl);
+	mb();
+}
+
+u32 bce_cmd_register_queue(struct bce_queue_cmdq *cmdq, struct bce_queue_m=
emcfg *cfg, const char *name, bool isdirout)
+{
+	struct bce_queue_cmdq_result_el res;
+	struct bce_cmdq_register_memory_queue_cmd *cmd =3D bce_cmd_start(cmdq, &r=
es);
+	if (!cmd)
+		return (u32) -1;
+	cmd->cmd =3D BCE_CMD_REGISTER_MEMORY_QUEUE;
+	cmd->flags =3D (u16) ((name ? 2 : 0) | (isdirout ? 1 : 0));
+	cmd->qid =3D cfg->qid;
+	cmd->el_count =3D cfg->el_count;
+	cmd->vector_or_cq =3D cfg->vector_or_cq;
+	memset(cmd->name, 0, sizeof(cmd->name));
+	if (name) {
+		cmd->name_len =3D (u16) min(strlen(name), (size_t) sizeof(cmd->name));
+		memcpy(cmd->name, name, cmd->name_len);
+	} else {
+		cmd->name_len =3D 0;
+	}
+	cmd->addr =3D cfg->addr;
+	cmd->length =3D cfg->length;
+
+	bce_cmd_finish(cmdq, &res);
+	return res.status;
+}
+
+u32 bce_cmd_unregister_memory_queue(struct bce_queue_cmdq *cmdq, u16 qid)
+{
+	struct bce_queue_cmdq_result_el res;
+	struct bce_cmdq_simple_memory_queue_cmd *cmd =3D bce_cmd_start(cmdq, &res=
);
+	if (!cmd)
+		return (u32) -1;
+	cmd->cmd =3D BCE_CMD_UNREGISTER_MEMORY_QUEUE;
+	cmd->flags =3D 0;
+	cmd->qid =3D qid;
+	bce_cmd_finish(cmdq, &res);
+	return res.status;
+}
+
+u32 bce_cmd_flush_memory_queue(struct bce_queue_cmdq *cmdq, u16 qid)
+{
+	struct bce_queue_cmdq_result_el res;
+	struct bce_cmdq_simple_memory_queue_cmd *cmd =3D bce_cmd_start(cmdq, &res=
);
+	if (!cmd)
+		return (u32) -1;
+	cmd->cmd =3D BCE_CMD_FLUSH_MEMORY_QUEUE;
+	cmd->flags =3D 0;
+	cmd->qid =3D qid;
+	bce_cmd_finish(cmdq, &res);
+	return res.status;
+}
+
+
+struct bce_queue_cq *bce_create_cq(struct apple_bce_device *dev, u32 el_co=
unt)
+{
+	struct bce_queue_cq *cq;
+	struct bce_queue_memcfg cfg;
+	int qid =3D ida_simple_get(&dev->queue_ida, BCE_QUEUE_USER_MIN, BCE_QUEUE=
_USER_MAX, GFP_KERNEL);
+	if (qid < 0)
+		return NULL;
+	cq =3D bce_alloc_cq(dev, qid, el_count);
+	if (!cq)
+		return NULL;
+	bce_get_cq_memcfg(cq, &cfg);
+	if (bce_cmd_register_queue(dev->cmd_cmdq, &cfg, NULL, false) !=3D 0) {
+		pr_err("apple-bce: CQ registration failed (%i)", qid);
+		bce_free_cq(dev, cq);
+		ida_simple_remove(&dev->queue_ida, (uint) qid);
+		return NULL;
+	}
+	dev->queues[qid] =3D (struct bce_queue *) cq;
+	return cq;
+}
+
+struct bce_queue_sq *bce_create_sq(struct apple_bce_device *dev, struct bc=
e_queue_cq *cq, const char *name, u32 el_count,
+		int direction, bce_sq_completion compl, void *userdata)
+{
+	struct bce_queue_sq *sq;
+	struct bce_queue_memcfg cfg;
+	int qid;
+	if (cq =3D=3D NULL)
+		return NULL; /* cq can not be null */
+	if (name =3D=3D NULL)
+		return NULL; /* name can not be null */
+	if (direction !=3D DMA_TO_DEVICE && direction !=3D DMA_FROM_DEVICE)
+		return NULL; /* unsupported direction */
+	qid =3D ida_simple_get(&dev->queue_ida, BCE_QUEUE_USER_MIN, BCE_QUEUE_USE=
R_MAX, GFP_KERNEL);
+	if (qid < 0)
+		return NULL;
+	sq =3D bce_alloc_sq(dev, qid, sizeof(struct bce_qe_submission), el_count,=
 compl, userdata);
+	if (!sq)
+		return NULL;
+	bce_get_sq_memcfg(sq, cq, &cfg);
+	if (bce_cmd_register_queue(dev->cmd_cmdq, &cfg, name, direction !=3D DMA_=
FROM_DEVICE) !=3D 0) {
+		pr_err("apple-bce: SQ registration failed (%i)", qid);
+		bce_free_sq(dev, sq);
+		ida_simple_remove(&dev->queue_ida, (uint) qid);
+		return NULL;
+	}
+	spin_lock(&dev->queues_lock);
+	dev->queues[qid] =3D (struct bce_queue *) sq;
+	spin_unlock(&dev->queues_lock);
+	return sq;
+}
+
+void bce_destroy_cq(struct apple_bce_device *dev, struct bce_queue_cq *cq)
+{
+	if (!dev->is_being_removed && bce_cmd_unregister_memory_queue(dev->cmd_cm=
dq, (u16) cq->qid))
+		pr_err("apple-bce: CQ unregister failed");
+	spin_lock(&dev->queues_lock);
+	dev->queues[cq->qid] =3D NULL;
+	spin_unlock(&dev->queues_lock);
+	ida_simple_remove(&dev->queue_ida, (uint) cq->qid);
+	bce_free_cq(dev, cq);
+}
+
+void bce_destroy_sq(struct apple_bce_device *dev, struct bce_queue_sq *sq)
+{
+	if (!dev->is_being_removed && bce_cmd_unregister_memory_queue(dev->cmd_cm=
dq, (u16) sq->qid))
+		pr_err("apple-bce: CQ unregister failed");
+	spin_lock(&dev->queues_lock);
+	dev->queues[sq->qid] =3D NULL;
+	spin_unlock(&dev->queues_lock);
+	ida_simple_remove(&dev->queue_ida, (uint) sq->qid);
+	bce_free_sq(dev, sq);
+}
+
diff --git a/drivers/staging/apple-bce/queue.h b/drivers/staging/apple-bce/=
queue.h
new file mode 100644
index 000000000..8d6c7ddfc
--- /dev/null
+++ b/drivers/staging/apple-bce/queue.h
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCE_QUEUE_H
+#define BCE_QUEUE_H
+
+#include <linux/completion.h>
+#include <linux/pci.h>
+
+#define BCE_CMD_SIZE 0x40
+
+struct apple_bce_device;
+
+enum bce_queue_type {
+	BCE_QUEUE_CQ, BCE_QUEUE_SQ
+};
+struct bce_queue {
+	int qid;
+	int type;
+};
+struct bce_queue_cq {
+	int qid;
+	int type;
+	u32 el_count;
+	dma_addr_t dma_handle;
+	void *data;
+
+	u32 index;
+};
+struct bce_queue_sq;
+typedef void (*bce_sq_completion)(struct bce_queue_sq *q);
+struct bce_sq_completion_data {
+	u32 status;
+	u64 data_size;
+	u64 result;
+};
+struct bce_queue_sq {
+	int qid;
+	int type;
+	u32 el_size;
+	u32 el_count;
+	dma_addr_t dma_handle;
+	void *data;
+	void *userdata;
+	void __iomem *reg_mem_dma;
+
+	atomic_t available_commands;
+	struct completion available_command_completion;
+	atomic_t available_command_completion_waiting_count;
+	u32 head, tail;
+
+	u32 completion_cidx, completion_tail;
+	struct bce_sq_completion_data *completion_data;
+	bool has_pending_completions;
+	bce_sq_completion completion;
+};
+
+struct bce_queue_cmdq_result_el {
+	struct completion cmpl;
+	u32 status;
+	u64 result;
+};
+struct bce_queue_cmdq {
+	struct bce_queue_sq *sq;
+	struct spinlock lck;
+	struct bce_queue_cmdq_result_el **tres;
+};
+
+struct bce_queue_memcfg {
+	u16 qid;
+	u16 el_count;
+	u16 vector_or_cq;
+	u16 _pad;
+	u64 addr;
+	u64 length;
+};
+
+enum bce_qe_completion_status {
+	BCE_COMPLETION_SUCCESS =3D 0,
+	BCE_COMPLETION_ERROR =3D 1,
+	BCE_COMPLETION_ABORTED =3D 2,
+	BCE_COMPLETION_NO_SPACE =3D 3,
+	BCE_COMPLETION_OVERRUN =3D 4
+};
+enum bce_qe_completion_flags {
+	BCE_COMPLETION_FLAG_PENDING =3D 0x8000
+};
+struct bce_qe_completion {
+	u64 result;
+	u64 data_size;
+	u16 qid;
+	u16 completion_index;
+	u16 status; // bce_qe_completion_status
+	u16 flags;  // bce_qe_completion_flags
+};
+
+struct bce_qe_submission {
+	u64 length;
+	u64 addr;
+
+	u64 segl_addr;
+	u64 segl_length;
+};
+
+enum bce_cmdq_command {
+	BCE_CMD_REGISTER_MEMORY_QUEUE =3D 0x20,
+	BCE_CMD_UNREGISTER_MEMORY_QUEUE =3D 0x30,
+	BCE_CMD_FLUSH_MEMORY_QUEUE =3D 0x40,
+	BCE_CMD_SET_MEMORY_QUEUE_PROPERTY =3D 0x50
+};
+struct bce_cmdq_simple_memory_queue_cmd {
+	u16 cmd; // bce_cmdq_command
+	u16 flags;
+	u16 qid;
+};
+struct bce_cmdq_register_memory_queue_cmd {
+	u16 cmd; // bce_cmdq_command
+	u16 flags;
+	u16 qid;
+	u16 _pad;
+	u16 el_count;
+	u16 vector_or_cq;
+	u16 _pad2;
+	u16 name_len;
+	char name[0x20];
+	u64 addr;
+	u64 length;
+};
+
+static __always_inline void *bce_sq_element(struct bce_queue_sq *q, int i)=
 {
+	return (void *) ((u8 *) q->data + q->el_size * i);
+}
+static __always_inline void *bce_cq_element(struct bce_queue_cq *q, int i)=
 {
+	return (void *) ((struct bce_qe_completion *) q->data + i);
+}
+
+static __always_inline struct bce_sq_completion_data *bce_next_completion(=
struct bce_queue_sq *sq) {
+	struct bce_sq_completion_data *res;
+	rmb();
+	if (sq->completion_cidx =3D=3D sq->completion_tail)
+		return NULL;
+	res =3D &sq->completion_data[sq->completion_cidx];
+	sq->completion_cidx =3D (sq->completion_cidx + 1) % sq->el_count;
+	return res;
+}
+
+struct bce_queue_cq *bce_alloc_cq(struct apple_bce_device *dev, int qid, u=
32 el_count);
+void bce_get_cq_memcfg(struct bce_queue_cq *cq, struct bce_queue_memcfg *c=
fg);
+void bce_free_cq(struct apple_bce_device *dev, struct bce_queue_cq *cq);
+void bce_handle_cq_completions(struct apple_bce_device *dev, struct bce_qu=
eue_cq *cq);
+
+struct bce_queue_sq *bce_alloc_sq(struct apple_bce_device *dev, int qid, u=
32 el_size, u32 el_count,
+		bce_sq_completion compl, void *userdata);
+void bce_get_sq_memcfg(struct bce_queue_sq *sq, struct bce_queue_cq *cq, s=
truct bce_queue_memcfg *cfg);
+void bce_free_sq(struct apple_bce_device *dev, struct bce_queue_sq *sq);
+int bce_reserve_submission(struct bce_queue_sq *sq, unsigned long *timeout=
);
+void bce_cancel_submission_reservation(struct bce_queue_sq *sq);
+void *bce_next_submission(struct bce_queue_sq *sq);
+void bce_submit_to_device(struct bce_queue_sq *sq);
+void bce_notify_submission_complete(struct bce_queue_sq *sq);
+
+void bce_set_submission_single(struct bce_qe_submission *element, dma_addr=
_t addr, size_t size);
+
+struct bce_queue_cmdq *bce_alloc_cmdq(struct apple_bce_device *dev, int qi=
d, u32 el_count);
+void bce_free_cmdq(struct apple_bce_device *dev, struct bce_queue_cmdq *cm=
dq);
+
+u32 bce_cmd_register_queue(struct bce_queue_cmdq *cmdq, struct bce_queue_m=
emcfg *cfg, const char *name, bool isdirout);
+u32 bce_cmd_unregister_memory_queue(struct bce_queue_cmdq *cmdq, u16 qid);
+u32 bce_cmd_flush_memory_queue(struct bce_queue_cmdq *cmdq, u16 qid);
+
+
+/* User API - Creates and registers the queue */
+
+struct bce_queue_cq *bce_create_cq(struct apple_bce_device *dev, u32 el_co=
unt);
+struct bce_queue_sq *bce_create_sq(struct apple_bce_device *dev, struct bc=
e_queue_cq *cq, const char *name, u32 el_count,
+		int direction, bce_sq_completion compl, void *userdata);
+void bce_destroy_cq(struct apple_bce_device *dev, struct bce_queue_cq *cq)=
;
+void bce_destroy_sq(struct apple_bce_device *dev, struct bce_queue_sq *sq)=
;
+
+#endif //BCEDRIVER_MAILBOX_H
+
diff --git a/drivers/staging/apple-bce/queue_dma.c b/drivers/staging/apple-=
bce/queue_dma.c
new file mode 100644
index 000000000..64e1cc48a
--- /dev/null
+++ b/drivers/staging/apple-bce/queue_dma.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "queue_dma.h"
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include "queue.h"
+
+static int bce_alloc_scatterlist_from_vm(struct sg_table *tbl, void *data,=
 size_t len);
+static struct bce_segment_list_element_hostinfo *bce_map_segment_list(
+		struct device *dev, struct scatterlist *pages, int pagen);
+static void bce_unmap_segement_list(struct device *dev, struct bce_segment=
_list_element_hostinfo *list);
+
+int bce_map_dma_buffer(struct device *dev, struct bce_dma_buffer *buf, str=
uct sg_table scatterlist,
+		enum dma_data_direction dir)
+{
+	int cnt;
+
+	buf->direction =3D dir;
+	buf->scatterlist =3D scatterlist;
+	buf->seglist_hostinfo =3D NULL;
+
+	cnt =3D dma_map_sg(dev, buf->scatterlist.sgl, buf->scatterlist.nents, dir=
);
+	if (cnt !=3D buf->scatterlist.nents) {
+		pr_err("apple-bce: DMA scatter list mapping returned an unexpected count=
: %i\n", cnt);
+		dma_unmap_sg(dev, buf->scatterlist.sgl, buf->scatterlist.nents, dir);
+		return -EIO;
+	}
+	if (cnt =3D=3D 1)
+		return 0;
+
+	buf->seglist_hostinfo =3D bce_map_segment_list(dev, buf->scatterlist.sgl,=
 buf->scatterlist.nents);
+	if (!buf->seglist_hostinfo) {
+		pr_err("apple-bce: Creating segment list failed\n");
+		dma_unmap_sg(dev, buf->scatterlist.sgl, buf->scatterlist.nents, dir);
+		return -EIO;
+	}
+	return 0;
+}
+
+int bce_map_dma_buffer_vm(struct device *dev, struct bce_dma_buffer *buf, =
void *data, size_t len,
+						  enum dma_data_direction dir)
+{
+	int status;
+	struct sg_table scatterlist;
+	if ((status =3D bce_alloc_scatterlist_from_vm(&scatterlist, data, len)))
+		return status;
+	if ((status =3D bce_map_dma_buffer(dev, buf, scatterlist, dir))) {
+		sg_free_table(&scatterlist);
+		return status;
+	}
+	return 0;
+}
+
+int bce_map_dma_buffer_km(struct device *dev, struct bce_dma_buffer *buf, =
void *data, size_t len,
+						  enum dma_data_direction dir)
+{
+	/* Kernel memory is continuous which is great for us. */
+	int status;
+	struct sg_table scatterlist;
+	if ((status =3D sg_alloc_table(&scatterlist, 1, GFP_KERNEL))) {
+		sg_free_table(&scatterlist);
+		return status;
+	}
+	sg_set_buf(scatterlist.sgl, data, (uint) len);
+	if ((status =3D bce_map_dma_buffer(dev, buf, scatterlist, dir))) {
+		sg_free_table(&scatterlist);
+		return status;
+	}
+	return 0;
+}
+
+void bce_unmap_dma_buffer(struct device *dev, struct bce_dma_buffer *buf)
+{
+	dma_unmap_sg(dev, buf->scatterlist.sgl, buf->scatterlist.nents, buf->dire=
ction);
+	bce_unmap_segement_list(dev, buf->seglist_hostinfo);
+}
+
+
+static int bce_alloc_scatterlist_from_vm(struct sg_table *tbl, void *data,=
 size_t len)
+{
+	int status, i;
+	struct page **pages;
+	size_t off, start_page, end_page, page_count;
+	off		=3D (size_t) data % PAGE_SIZE;
+	start_page =3D (size_t) data  / PAGE_SIZE;
+	end_page   =3D ((size_t) data + len - 1) / PAGE_SIZE;
+	page_count =3D end_page - start_page + 1;
+
+	if (page_count > PAGE_SIZE / sizeof(struct page *))
+		pages =3D vmalloc(page_count * sizeof(struct page *));
+	else
+		pages =3D kmalloc(page_count * sizeof(struct page *), GFP_KERNEL);
+
+	for (i =3D 0; i < page_count; i++)
+		pages[i] =3D vmalloc_to_page((void *) ((start_page + i) * PAGE_SIZE));
+
+	if ((status =3D sg_alloc_table_from_pages(tbl, pages, page_count, (unsign=
ed int) off, len, GFP_KERNEL))) {
+		sg_free_table(tbl);
+	}
+
+	if (page_count > PAGE_SIZE / sizeof(struct page *))
+		vfree(pages);
+	else
+		kfree(pages);
+	return status;
+}
+
+#define BCE_ELEMENTS_PER_PAGE ((PAGE_SIZE - sizeof(struct bce_segment_list=
_header)) \
+							   / sizeof(struct bce_segment_list_element))
+#define BCE_ELEMENTS_PER_ADDITIONAL_PAGE (PAGE_SIZE / sizeof(struct bce_se=
gment_list_element))
+
+static struct bce_segment_list_element_hostinfo *bce_map_segment_list(
+		struct device *dev, struct scatterlist *pages, int pagen)
+{
+	size_t ptr, pptr =3D 0;
+	struct bce_segment_list_header theader; /* a temp header, to store the in=
itial seg */
+	struct bce_segment_list_header *header;
+	struct bce_segment_list_element *el, *el_end;
+	struct bce_segment_list_element_hostinfo *out, *pout, *out_root;
+	struct scatterlist *sg;
+	int i;
+	header =3D &theader;
+	out =3D out_root =3D NULL;
+	el =3D el_end =3D NULL;
+	for_each_sg(pages, sg, pagen, i) {
+		if (el >=3D el_end) {
+			/* allocate a new page, this will be also done for the first element */
+			ptr =3D __get_free_page(GFP_KERNEL);
+			if (pptr && ptr =3D=3D pptr + PAGE_SIZE) {
+				out->page_count++;
+				header->element_count +=3D BCE_ELEMENTS_PER_ADDITIONAL_PAGE;
+				el_end +=3D BCE_ELEMENTS_PER_ADDITIONAL_PAGE;
+			} else {
+				header =3D (void *) ptr;
+				header->element_count =3D BCE_ELEMENTS_PER_PAGE;
+				header->data_size =3D 0;
+				header->next_segl_addr =3D 0;
+				header->next_segl_length =3D 0;
+				el =3D (void *) (header + 1);
+				el_end =3D el + BCE_ELEMENTS_PER_PAGE;
+
+				if (out) {
+					out->next =3D kmalloc(sizeof(struct bce_segment_list_element_hostinfo=
), GFP_KERNEL);
+					out =3D out->next;
+				} else {
+					out_root =3D out =3D kmalloc(sizeof(struct bce_segment_list_element_h=
ostinfo), GFP_KERNEL);
+				}
+				out->page_start =3D (void *) ptr;
+				out->page_count =3D 1;
+				out->dma_start =3D DMA_MAPPING_ERROR;
+				out->next =3D NULL;
+			}
+			pptr =3D ptr;
+		}
+		el->addr =3D sg->dma_address;
+		el->length =3D sg->length;
+		header->data_size +=3D el->length;
+	}
+
+	/* DMA map */
+	out =3D out_root;
+	pout =3D NULL;
+	while (out) {
+		out->dma_start =3D dma_map_single(dev, out->page_start, out->page_count =
* PAGE_SIZE, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, out->dma_start))
+			goto error;
+		if (pout) {
+			header =3D pout->page_start;
+			header->next_segl_addr =3D out->dma_start;
+			header->next_segl_length =3D out->page_count * PAGE_SIZE;
+		}
+		pout =3D out;
+		out =3D out->next;
+	}
+	return out_root;
+
+	error:
+	bce_unmap_segement_list(dev, out_root);
+	return NULL;
+}
+
+static void bce_unmap_segement_list(struct device *dev, struct bce_segment=
_list_element_hostinfo *list)
+{
+	struct bce_segment_list_element_hostinfo *next;
+	while (list) {
+		if (list->dma_start !=3D DMA_MAPPING_ERROR)
+			dma_unmap_single(dev, list->dma_start, list->page_count * PAGE_SIZE, DM=
A_TO_DEVICE);
+		next =3D list->next;
+		kfree(list);
+		list =3D next;
+	}
+}
+
+int bce_set_submission_buf(struct bce_qe_submission *element, struct bce_d=
ma_buffer *buf, size_t offset, size_t length)
+{
+	struct bce_segment_list_element_hostinfo *seg;
+	struct bce_segment_list_header *seg_header;
+
+	seg =3D buf->seglist_hostinfo;
+	if (!seg) {
+		element->addr =3D buf->scatterlist.sgl->dma_address + offset;
+		element->length =3D length;
+		element->segl_addr =3D 0;
+		element->segl_length =3D 0;
+		return 0;
+	}
+
+	while (seg) {
+		seg_header =3D seg->page_start;
+		if (offset <=3D seg_header->data_size)
+			break;
+		offset -=3D seg_header->data_size;
+		seg =3D seg->next;
+	}
+	if (!seg)
+		return -EINVAL;
+	element->addr =3D offset;
+	element->length =3D buf->scatterlist.sgl->dma_length;
+	element->segl_addr =3D seg->dma_start;
+	element->segl_length =3D seg->page_count * PAGE_SIZE;
+	return 0;
+}
+
diff --git a/drivers/staging/apple-bce/queue_dma.h b/drivers/staging/apple-=
bce/queue_dma.h
new file mode 100644
index 000000000..01f9552e5
--- /dev/null
+++ b/drivers/staging/apple-bce/queue_dma.h
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCE_QUEUE_DMA_H
+#define BCE_QUEUE_DMA_H
+
+#include <linux/pci.h>
+
+struct bce_qe_submission;
+
+struct bce_segment_list_header {
+	u64 element_count;
+	u64 data_size;
+
+	u64 next_segl_addr;
+	u64 next_segl_length;
+};
+struct bce_segment_list_element {
+	u64 addr;
+	u64 length;
+};
+
+struct bce_segment_list_element_hostinfo {
+	struct bce_segment_list_element_hostinfo *next;
+	void *page_start;
+	size_t page_count;
+	dma_addr_t dma_start;
+};
+
+
+struct bce_dma_buffer {
+	enum dma_data_direction direction;
+	struct sg_table scatterlist;
+	struct bce_segment_list_element_hostinfo *seglist_hostinfo;
+};
+
+/* NOTE: Takes ownership of the sg_table if it succeeds. Ownership is not =
transferred on failure. */
+int bce_map_dma_buffer(struct device *dev, struct bce_dma_buffer *buf, str=
uct sg_table scatterlist,
+		enum dma_data_direction dir);
+
+/* Creates a buffer from virtual memory (vmalloc) */
+int bce_map_dma_buffer_vm(struct device *dev, struct bce_dma_buffer *buf, =
void *data, size_t len,
+		enum dma_data_direction dir);
+
+/* Creates a buffer from kernel memory (kmalloc) */
+int bce_map_dma_buffer_km(struct device *dev, struct bce_dma_buffer *buf, =
void *data, size_t len,
+						  enum dma_data_direction dir);
+
+void bce_unmap_dma_buffer(struct device *dev, struct bce_dma_buffer *buf);
+
+int bce_set_submission_buf(struct bce_qe_submission *element, struct bce_d=
ma_buffer *buf, size_t offset, size_t length);
+
+#endif //BCE_QUEUE_DMA_H
+
diff --git a/drivers/staging/apple-bce/vhci/command.h b/drivers/staging/app=
le-bce/vhci/command.h
new file mode 100644
index 000000000..46a73913e
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/command.h
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCE_VHCI_COMMAND_H
+#define BCE_VHCI_COMMAND_H
+
+#include "queue.h"
+#include <linux/jiffies.h>
+#include <linux/usb.h>
+
+#define BCE_VHCI_CMD_TIMEOUT_SHORT msecs_to_jiffies(2000)
+#define BCE_VHCI_CMD_TIMEOUT_LONG msecs_to_jiffies(30000)
+
+#define BCE_VHCI_BULK_MAX_ACTIVE_URBS_POW2 2
+#define BCE_VHCI_BULK_MAX_ACTIVE_URBS (1 << BCE_VHCI_BULK_MAX_ACTIVE_URBS_=
POW2)
+
+typedef u8 bce_vhci_port_t;
+typedef u8 bce_vhci_device_t;
+
+enum bce_vhci_command {
+	BCE_VHCI_CMD_CONTROLLER_ENABLE =3D 1,
+	BCE_VHCI_CMD_CONTROLLER_DISABLE =3D 2,
+	BCE_VHCI_CMD_CONTROLLER_START =3D 3,
+	BCE_VHCI_CMD_CONTROLLER_PAUSE =3D 4,
+
+	BCE_VHCI_CMD_PORT_POWER_ON =3D 0x10,
+	BCE_VHCI_CMD_PORT_POWER_OFF =3D 0x11,
+	BCE_VHCI_CMD_PORT_RESUME =3D 0x12,
+	BCE_VHCI_CMD_PORT_SUSPEND =3D 0x13,
+	BCE_VHCI_CMD_PORT_RESET =3D 0x14,
+	BCE_VHCI_CMD_PORT_DISABLE =3D 0x15,
+	BCE_VHCI_CMD_PORT_STATUS =3D 0x16,
+
+	BCE_VHCI_CMD_DEVICE_CREATE =3D 0x30,
+	BCE_VHCI_CMD_DEVICE_DESTROY =3D 0x31,
+
+	BCE_VHCI_CMD_ENDPOINT_CREATE =3D 0x40,
+	BCE_VHCI_CMD_ENDPOINT_DESTROY =3D 0x41,
+	BCE_VHCI_CMD_ENDPOINT_SET_STATE =3D 0x42,
+	BCE_VHCI_CMD_ENDPOINT_RESET =3D 0x44,
+
+	/* Device to host only */
+	BCE_VHCI_CMD_ENDPOINT_REQUEST_STATE =3D 0x43,
+	BCE_VHCI_CMD_TRANSFER_REQUEST =3D 0x1000,
+	BCE_VHCI_CMD_CONTROL_TRANSFER_STATUS =3D 0x1005
+};
+
+enum bce_vhci_endpoint_state {
+	BCE_VHCI_ENDPOINT_ACTIVE =3D 0,
+	BCE_VHCI_ENDPOINT_PAUSED =3D 1,
+	BCE_VHCI_ENDPOINT_STALLED =3D 2
+};
+
+static inline int bce_vhci_cmd_controller_enable(struct bce_vhci_command_q=
ueue *q, u8 busNum, u16 *portMask)
+{
+	int status;
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_CONTROLLER_ENABLE;
+	cmd.param1 =3D 0x7100u | busNum;
+	status =3D bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIM=
EOUT_LONG);
+	if (!status)
+		*portMask =3D (u16) res.param2;
+	return status;
+}
+static inline int bce_vhci_cmd_controller_disable(struct bce_vhci_command_=
queue *q)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_CONTROLLER_DISABLE;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_LONG);
+}
+static inline int bce_vhci_cmd_controller_start(struct bce_vhci_command_qu=
eue *q)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_CONTROLLER_START;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_LONG);
+}
+static inline int bce_vhci_cmd_controller_pause(struct bce_vhci_command_qu=
eue *q)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_CONTROLLER_PAUSE;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_LONG);
+}
+
+static inline int bce_vhci_cmd_port_power_on(struct bce_vhci_command_queue=
 *q, bce_vhci_port_t port)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_POWER_ON;
+	cmd.param1 =3D port;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+static inline int bce_vhci_cmd_port_power_off(struct bce_vhci_command_queu=
e *q, bce_vhci_port_t port)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_POWER_OFF;
+	cmd.param1 =3D port;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+static inline int bce_vhci_cmd_port_resume(struct bce_vhci_command_queue *=
q, bce_vhci_port_t port)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_RESUME;
+	cmd.param1 =3D port;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_LONG);
+}
+static inline int bce_vhci_cmd_port_suspend(struct bce_vhci_command_queue =
*q, bce_vhci_port_t port)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_SUSPEND;
+	cmd.param1 =3D port;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_LONG);
+}
+static inline int bce_vhci_cmd_port_reset(struct bce_vhci_command_queue *q=
, bce_vhci_port_t port, u32 timeout)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_RESET;
+	cmd.param1 =3D port;
+	cmd.param2 =3D timeout;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+static inline int bce_vhci_cmd_port_disable(struct bce_vhci_command_queue =
*q, bce_vhci_port_t port)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_DISABLE;
+	cmd.param1 =3D port;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+static inline int bce_vhci_cmd_port_status(struct bce_vhci_command_queue *=
q, bce_vhci_port_t port,
+		u32 clearFlags, u32 *resStatus)
+{
+	int status;
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_PORT_STATUS;
+	cmd.param1 =3D port;
+	cmd.param2 =3D clearFlags & 0x560000;
+	status =3D bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIM=
EOUT_SHORT);
+	if (status >=3D 0)
+		*resStatus =3D (u32) res.param2;
+	return status;
+}
+
+static inline int bce_vhci_cmd_device_create(struct bce_vhci_command_queue=
 *q, bce_vhci_port_t port,
+		bce_vhci_device_t *dev)
+{
+	int status;
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_DEVICE_CREATE;
+	cmd.param1 =3D port;
+	status =3D bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIM=
EOUT_SHORT);
+	if (!status)
+		*dev =3D (bce_vhci_device_t) res.param2;
+	return status;
+}
+static inline int bce_vhci_cmd_device_destroy(struct bce_vhci_command_queu=
e *q, bce_vhci_device_t dev)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_DEVICE_DESTROY;
+	cmd.param1 =3D dev;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_LONG);
+}
+
+static inline int bce_vhci_cmd_endpoint_create(struct bce_vhci_command_que=
ue *q, bce_vhci_device_t dev,
+		struct usb_endpoint_descriptor *desc)
+{
+	struct bce_vhci_message cmd, res;
+	int endpoint_type =3D usb_endpoint_type(desc);
+	int maxp =3D usb_endpoint_maxp(desc);
+	int maxp_burst =3D usb_endpoint_maxp_mult(desc) * maxp;
+	u8 max_active_requests_pow2 =3D 0;
+	cmd.cmd =3D BCE_VHCI_CMD_ENDPOINT_CREATE;
+	cmd.param1 =3D dev | ((desc->bEndpointAddress & 0x8Fu) << 8);
+	if (endpoint_type =3D=3D USB_ENDPOINT_XFER_BULK)
+		max_active_requests_pow2 =3D BCE_VHCI_BULK_MAX_ACTIVE_URBS_POW2;
+	cmd.param2 =3D endpoint_type | ((max_active_requests_pow2 & 0xf) << 4) | =
(maxp << 16) | ((u64) maxp_burst << 32);
+	if (endpoint_type =3D=3D USB_ENDPOINT_XFER_INT)
+		cmd.param2 |=3D (desc->bInterval - 1) << 8;
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+static inline int bce_vhci_cmd_endpoint_destroy(struct bce_vhci_command_qu=
eue *q, bce_vhci_device_t dev, u8 endpoint)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_ENDPOINT_DESTROY;
+	cmd.param1 =3D dev | (endpoint << 8);
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+static inline int bce_vhci_cmd_endpoint_set_state(struct bce_vhci_command_=
queue *q, bce_vhci_device_t dev, u8 endpoint,
+		enum bce_vhci_endpoint_state newState, enum bce_vhci_endpoint_state *ret=
State)
+{
+	int status;
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_ENDPOINT_SET_STATE;
+	cmd.param1 =3D dev | (endpoint << 8);
+	cmd.param2 =3D (u64) newState;
+	status =3D bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIM=
EOUT_SHORT);
+	if (status !=3D BCE_VHCI_INTERNAL_ERROR && status !=3D BCE_VHCI_NO_POWER)
+		*retState =3D (enum bce_vhci_endpoint_state) res.param2;
+	return status;
+}
+static inline int bce_vhci_cmd_endpoint_reset(struct bce_vhci_command_queu=
e *q, bce_vhci_device_t dev, u8 endpoint)
+{
+	struct bce_vhci_message cmd, res;
+	cmd.cmd =3D BCE_VHCI_CMD_ENDPOINT_RESET;
+	cmd.param1 =3D dev | (endpoint << 8);
+	return bce_vhci_command_queue_execute(q, &cmd, &res, BCE_VHCI_CMD_TIMEOUT=
_SHORT);
+}
+
+
+#endif //BCE_VHCI_COMMAND_H
+
diff --git a/drivers/staging/apple-bce/vhci/queue.c b/drivers/staging/apple=
-bce/vhci/queue.c
new file mode 100644
index 000000000..bfce340af
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/queue.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "queue.h"
+#include "vhci.h"
+#include "../apple_bce.h"
+
+
+static void bce_vhci_message_queue_completion(struct bce_queue_sq *sq);
+
+int bce_vhci_message_queue_create(struct bce_vhci *vhci, struct bce_vhci_m=
essage_queue *ret, const char *name)
+{
+	int status;
+	ret->cq =3D bce_create_cq(vhci->dev, VHCI_EVENT_QUEUE_EL_COUNT);
+	if (!ret->cq)
+		return -EINVAL;
+	ret->sq =3D bce_create_sq(vhci->dev, ret->cq, name, VHCI_EVENT_QUEUE_EL_C=
OUNT, DMA_TO_DEVICE,
+							bce_vhci_message_queue_completion, ret);
+	if (!ret->sq) {
+		status =3D -EINVAL;
+		goto fail_cq;
+	}
+	ret->data =3D dma_alloc_coherent(&vhci->dev->pci->dev, sizeof(struct bce_=
vhci_message) * VHCI_EVENT_QUEUE_EL_COUNT,
+								   &ret->dma_addr, GFP_KERNEL);
+	if (!ret->data) {
+		status =3D -EINVAL;
+		goto fail_sq;
+	}
+	return 0;
+
+fail_sq:
+	bce_destroy_sq(vhci->dev, ret->sq);
+	ret->sq =3D NULL;
+fail_cq:
+	bce_destroy_cq(vhci->dev, ret->cq);
+	ret->cq =3D NULL;
+	return status;
+}
+
+void bce_vhci_message_queue_destroy(struct bce_vhci *vhci, struct bce_vhci=
_message_queue *q)
+{
+	if (!q->cq)
+		return;
+	dma_free_coherent(&vhci->dev->pci->dev, sizeof(struct bce_vhci_message) *=
 VHCI_EVENT_QUEUE_EL_COUNT,
+					  q->data, q->dma_addr);
+	bce_destroy_sq(vhci->dev, q->sq);
+	bce_destroy_cq(vhci->dev, q->cq);
+}
+
+void bce_vhci_message_queue_write(struct bce_vhci_message_queue *q, struct=
 bce_vhci_message *req)
+{
+	int sidx;
+	struct bce_qe_submission *s;
+	sidx =3D q->sq->tail;
+	s =3D bce_next_submission(q->sq);
+	pr_debug("bce-vhci: Send message: %x s=3D%x p1=3D%x p2=3D%llx\n", req->cm=
d, req->status, req->param1, req->param2);
+	q->data[sidx] =3D *req;
+	bce_set_submission_single(s, q->dma_addr + sizeof(struct bce_vhci_message=
) * sidx,
+			sizeof(struct bce_vhci_message));
+	bce_submit_to_device(q->sq);
+}
+
+static void bce_vhci_message_queue_completion(struct bce_queue_sq *sq)
+{
+	while (bce_next_completion(sq))
+		bce_notify_submission_complete(sq);
+}
+
+
+
+static void bce_vhci_event_queue_completion(struct bce_queue_sq *sq);
+
+int __bce_vhci_event_queue_create(struct bce_vhci *vhci, struct bce_vhci_e=
vent_queue *ret, const char *name,
+								  bce_sq_completion compl)
+{
+	ret->vhci =3D vhci;
+
+	ret->sq =3D bce_create_sq(vhci->dev, vhci->ev_cq, name, VHCI_EVENT_QUEUE_=
EL_COUNT, DMA_FROM_DEVICE, compl, ret);
+	if (!ret->sq)
+		return -EINVAL;
+	ret->data =3D dma_alloc_coherent(&vhci->dev->pci->dev, sizeof(struct bce_=
vhci_message) * VHCI_EVENT_QUEUE_EL_COUNT,
+								   &ret->dma_addr, GFP_KERNEL);
+	if (!ret->data) {
+		bce_destroy_sq(vhci->dev, ret->sq);
+		ret->sq =3D NULL;
+		return -EINVAL;
+	}
+
+	init_completion(&ret->queue_empty_completion);
+	bce_vhci_event_queue_submit_pending(ret, VHCI_EVENT_PENDING_COUNT);
+	return 0;
+}
+
+int bce_vhci_event_queue_create(struct bce_vhci *vhci, struct bce_vhci_eve=
nt_queue *ret, const char *name,
+		bce_vhci_event_queue_callback cb)
+{
+	ret->cb =3D cb;
+	return __bce_vhci_event_queue_create(vhci, ret, name, bce_vhci_event_queu=
e_completion);
+}
+
+void bce_vhci_event_queue_destroy(struct bce_vhci *vhci, struct bce_vhci_e=
vent_queue *q)
+{
+	if (!q->sq)
+		return;
+	dma_free_coherent(&vhci->dev->pci->dev, sizeof(struct bce_vhci_message) *=
 VHCI_EVENT_QUEUE_EL_COUNT,
+					  q->data, q->dma_addr);
+	bce_destroy_sq(vhci->dev, q->sq);
+}
+
+static void bce_vhci_event_queue_completion(struct bce_queue_sq *sq)
+{
+	struct bce_sq_completion_data *cd;
+	struct bce_vhci_event_queue *ev =3D sq->userdata;
+	struct bce_vhci_message *msg;
+	size_t cnt =3D 0;
+
+	while ((cd =3D bce_next_completion(sq))) {
+		if (cd->status =3D=3D BCE_COMPLETION_ABORTED) { /* We flushed the queue =
*/
+			bce_notify_submission_complete(sq);
+			continue;
+		}
+		msg =3D &ev->data[sq->head];
+		pr_debug("bce-vhci: Got event: %x s=3D%x p1=3D%x p2=3D%llx\n", msg->cmd,=
 msg->status, msg->param1, msg->param2);
+		ev->cb(ev, msg);
+
+		bce_notify_submission_complete(sq);
+		++cnt;
+	}
+	bce_vhci_event_queue_submit_pending(ev, cnt);
+	if (atomic_read(&sq->available_commands) =3D=3D sq->el_count - 1)
+		complete(&ev->queue_empty_completion);
+}
+
+void bce_vhci_event_queue_submit_pending(struct bce_vhci_event_queue *q, s=
ize_t count)
+{
+	int idx;
+	struct bce_qe_submission *s;
+	while (count--) {
+		if (bce_reserve_submission(q->sq, NULL)) {
+			pr_err("bce-vhci: Failed to reserve an event queue submission\n");
+			break;
+		}
+		idx =3D q->sq->tail;
+		s =3D bce_next_submission(q->sq);
+		bce_set_submission_single(s,
+								  q->dma_addr + idx * sizeof(struct bce_vhci_message), sizeof(stru=
ct bce_vhci_message));
+	}
+	bce_submit_to_device(q->sq);
+}
+
+void bce_vhci_event_queue_pause(struct bce_vhci_event_queue *q)
+{
+	unsigned long timeout;
+	reinit_completion(&q->queue_empty_completion);
+	if (bce_cmd_flush_memory_queue(q->vhci->dev->cmd_cmdq, q->sq->qid))
+		pr_warn("bce-vhci: failed to flush event queue\n");
+	timeout =3D msecs_to_jiffies(5000);
+	while (atomic_read(&q->sq->available_commands) !=3D q->sq->el_count - 1) =
{
+		timeout =3D wait_for_completion_timeout(&q->queue_empty_completion, time=
out);
+		if (timeout =3D=3D 0) {
+			pr_err("bce-vhci: waiting for queue to be flushed timed out\n");
+			break;
+		}
+	}
+}
+
+void bce_vhci_event_queue_resume(struct bce_vhci_event_queue *q)
+{
+	if (atomic_read(&q->sq->available_commands) !=3D q->sq->el_count - 1) {
+		pr_err("bce-vhci: resume of a queue with pending submissions\n");
+		return;
+	}
+	bce_vhci_event_queue_submit_pending(q, VHCI_EVENT_PENDING_COUNT);
+}
+
+void bce_vhci_command_queue_create(struct bce_vhci_command_queue *ret, str=
uct bce_vhci_message_queue *mq)
+{
+	ret->mq =3D mq;
+	ret->completion.result =3D NULL;
+	init_completion(&ret->completion.completion);
+	spin_lock_init(&ret->completion_lock);
+	mutex_init(&ret->mutex);
+}
+
+void bce_vhci_command_queue_destroy(struct bce_vhci_command_queue *cq)
+{
+	spin_lock(&cq->completion_lock);
+	if (cq->completion.result) {
+		memset(cq->completion.result, 0, sizeof(struct bce_vhci_message));
+		cq->completion.result->status =3D BCE_VHCI_ABORT;
+		complete(&cq->completion.completion);
+		cq->completion.result =3D NULL;
+	}
+	spin_unlock(&cq->completion_lock);
+	mutex_lock(&cq->mutex);
+	mutex_unlock(&cq->mutex);
+	mutex_destroy(&cq->mutex);
+}
+
+void bce_vhci_command_queue_deliver_completion(struct bce_vhci_command_que=
ue *cq, struct bce_vhci_message *msg)
+{
+	struct bce_vhci_command_queue_completion *c =3D &cq->completion;
+
+	spin_lock(&cq->completion_lock);
+	if (c->result) {
+		*c->result =3D *msg;
+		complete(&c->completion);
+		c->result =3D NULL;
+	}
+	spin_unlock(&cq->completion_lock);
+}
+
+static int __bce_vhci_command_queue_execute(struct bce_vhci_command_queue =
*cq, struct bce_vhci_message *req,
+		struct bce_vhci_message *res, unsigned long timeout)
+{
+	int status;
+	struct bce_vhci_command_queue_completion *c;
+	struct bce_vhci_message creq;
+	c =3D &cq->completion;
+
+	if ((status =3D bce_reserve_submission(cq->mq->sq, &timeout)))
+		return status;
+
+	spin_lock(&cq->completion_lock);
+	c->result =3D res;
+	reinit_completion(&c->completion);
+	spin_unlock(&cq->completion_lock);
+
+	bce_vhci_message_queue_write(cq->mq, req);
+
+	if (!wait_for_completion_timeout(&c->completion, timeout)) {
+		/* we ran out of time, send cancellation */
+		pr_debug("bce-vhci: command timed out req=3D%x\n", req->cmd);
+		if ((status =3D bce_reserve_submission(cq->mq->sq, &timeout)))
+			return status;
+
+		creq =3D *req;
+		creq.cmd |=3D 0x4000;
+		bce_vhci_message_queue_write(cq->mq, &creq);
+
+		if (!wait_for_completion_timeout(&c->completion, 1000)) {
+			pr_err("bce-vhci: Possible desync, cmd cancel timed out\n");
+
+			spin_lock(&cq->completion_lock);
+			c->result =3D NULL;
+			spin_unlock(&cq->completion_lock);
+			return -ETIMEDOUT;
+		}
+		if ((res->cmd & ~0x8000) =3D=3D creq.cmd)
+			return -ETIMEDOUT;
+		/* reply for the previous command most likely arrived */
+	}
+
+	if ((res->cmd & ~0x8000) !=3D req->cmd) {
+		pr_err("bce-vhci: Possible desync, cmd reply mismatch req=3D%x, res=3D%x=
\n", req->cmd, res->cmd);
+		return -EIO;
+	}
+	if (res->status =3D=3D BCE_VHCI_SUCCESS)
+		return 0;
+	return res->status;
+}
+
+int bce_vhci_command_queue_execute(struct bce_vhci_command_queue *cq, stru=
ct bce_vhci_message *req,
+								   struct bce_vhci_message *res, unsigned long timeout)
+{
+	int status;
+	mutex_lock(&cq->mutex);
+	status =3D __bce_vhci_command_queue_execute(cq, req, res, timeout);
+	mutex_unlock(&cq->mutex);
+	return status;
+}
+
diff --git a/drivers/staging/apple-bce/vhci/queue.h b/drivers/staging/apple=
-bce/vhci/queue.h
new file mode 100644
index 000000000..cb8badd56
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/queue.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCE_VHCI_QUEUE_H
+#define BCE_VHCI_QUEUE_H
+
+#include <linux/completion.h>
+#include "../queue.h"
+
+#define VHCI_EVENT_QUEUE_EL_COUNT 256
+#define VHCI_EVENT_PENDING_COUNT 32
+
+struct bce_vhci;
+struct bce_vhci_event_queue;
+
+enum bce_vhci_message_status {
+	BCE_VHCI_SUCCESS =3D 1,
+	BCE_VHCI_ERROR =3D 2,
+	BCE_VHCI_USB_PIPE_STALL =3D 3,
+	BCE_VHCI_ABORT =3D 4,
+	BCE_VHCI_BAD_ARGUMENT =3D 5,
+	BCE_VHCI_OVERRUN =3D 6,
+	BCE_VHCI_INTERNAL_ERROR =3D 7,
+	BCE_VHCI_NO_POWER =3D 8,
+	BCE_VHCI_UNSUPPORTED =3D 9
+};
+struct bce_vhci_message {
+	u16 cmd;
+	u16 status; // bce_vhci_message_status
+	u32 param1;
+	u64 param2;
+};
+
+struct bce_vhci_message_queue {
+	struct bce_queue_cq *cq;
+	struct bce_queue_sq *sq;
+	struct bce_vhci_message *data;
+	dma_addr_t dma_addr;
+};
+typedef void (*bce_vhci_event_queue_callback)(struct bce_vhci_event_queue =
*q, struct bce_vhci_message *msg);
+struct bce_vhci_event_queue {
+	struct bce_vhci *vhci;
+	struct bce_queue_sq *sq;
+	struct bce_vhci_message *data;
+	dma_addr_t dma_addr;
+	bce_vhci_event_queue_callback cb;
+	struct completion queue_empty_completion;
+};
+struct bce_vhci_command_queue_completion {
+	struct bce_vhci_message *result;
+	struct completion completion;
+};
+struct bce_vhci_command_queue {
+	struct bce_vhci_message_queue *mq;
+	struct bce_vhci_command_queue_completion completion;
+	struct spinlock completion_lock;
+	struct mutex mutex;
+};
+
+int bce_vhci_message_queue_create(struct bce_vhci *vhci, struct bce_vhci_m=
essage_queue *ret, const char *name);
+void bce_vhci_message_queue_destroy(struct bce_vhci *vhci, struct bce_vhci=
_message_queue *q);
+void bce_vhci_message_queue_write(struct bce_vhci_message_queue *q, struct=
 bce_vhci_message *req);
+
+int __bce_vhci_event_queue_create(struct bce_vhci *vhci, struct bce_vhci_e=
vent_queue *ret, const char *name,
+		bce_sq_completion compl);
+int bce_vhci_event_queue_create(struct bce_vhci *vhci, struct bce_vhci_eve=
nt_queue *ret, const char *name,
+		bce_vhci_event_queue_callback cb);
+void bce_vhci_event_queue_destroy(struct bce_vhci *vhci, struct bce_vhci_e=
vent_queue *q);
+void bce_vhci_event_queue_submit_pending(struct bce_vhci_event_queue *q, s=
ize_t count);
+void bce_vhci_event_queue_pause(struct bce_vhci_event_queue *q);
+void bce_vhci_event_queue_resume(struct bce_vhci_event_queue *q);
+
+void bce_vhci_command_queue_create(struct bce_vhci_command_queue *ret, str=
uct bce_vhci_message_queue *mq);
+void bce_vhci_command_queue_destroy(struct bce_vhci_command_queue *cq);
+int bce_vhci_command_queue_execute(struct bce_vhci_command_queue *cq, stru=
ct bce_vhci_message *req,
+		struct bce_vhci_message *res, unsigned long timeout);
+void bce_vhci_command_queue_deliver_completion(struct bce_vhci_command_que=
ue *cq, struct bce_vhci_message *msg);
+
+#endif //BCE_VHCI_QUEUE_H
+
diff --git a/drivers/staging/apple-bce/vhci/transfer.c b/drivers/staging/ap=
ple-bce/vhci/transfer.c
new file mode 100644
index 000000000..2f7408293
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/transfer.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "transfer.h"
+#include "../queue.h"
+#include "vhci.h"
+#include "../apple_bce.h"
+#include <linux/usb/hcd.h>
+
+static void bce_vhci_transfer_queue_completion(struct bce_queue_sq *sq);
+static void bce_vhci_transfer_queue_giveback(struct bce_vhci_transfer_queu=
e *q);
+static void bce_vhci_transfer_queue_remove_pending(struct bce_vhci_transfe=
r_queue *q);
+
+static int bce_vhci_urb_init(struct bce_vhci_urb *vurb);
+static int bce_vhci_urb_update(struct bce_vhci_urb *urb, struct bce_vhci_m=
essage *msg);
+static int bce_vhci_urb_transfer_completion(struct bce_vhci_urb *urb, stru=
ct bce_sq_completion_data *c);
+
+static void bce_vhci_transfer_queue_reset_w(struct work_struct *work);
+
+void bce_vhci_create_transfer_queue(struct bce_vhci *vhci, struct bce_vhci=
_transfer_queue *q,
+		struct usb_host_endpoint *endp, bce_vhci_device_t dev_addr, enum dma_dat=
a_direction dir)
+{
+	char name[0x21];
+	INIT_LIST_HEAD(&q->evq);
+	INIT_LIST_HEAD(&q->giveback_urb_list);
+	spin_lock_init(&q->urb_lock);
+	mutex_init(&q->pause_lock);
+	q->vhci =3D vhci;
+	q->endp =3D endp;
+	q->dev_addr =3D dev_addr;
+	q->endp_addr =3D (u8) (endp->desc.bEndpointAddress & 0x8F);
+	q->state =3D BCE_VHCI_ENDPOINT_ACTIVE;
+	q->active =3D true;
+	q->stalled =3D false;
+	q->max_active_requests =3D 1;
+	if (usb_endpoint_type(&endp->desc) =3D=3D USB_ENDPOINT_XFER_BULK)
+		q->max_active_requests =3D BCE_VHCI_BULK_MAX_ACTIVE_URBS;
+	q->remaining_active_requests =3D q->max_active_requests;
+	q->cq =3D bce_create_cq(vhci->dev, 0x100);
+	INIT_WORK(&q->w_reset, bce_vhci_transfer_queue_reset_w);
+	q->sq_in =3D NULL;
+	if (dir =3D=3D DMA_FROM_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL) {
+		snprintf(name, sizeof(name), "VHC1-%i-%02x", dev_addr, 0x80 | usb_endpoi=
nt_num(&endp->desc));
+		q->sq_in =3D bce_create_sq(vhci->dev, q->cq, name, 0x100, DMA_FROM_DEVIC=
E,
+								 bce_vhci_transfer_queue_completion, q);
+	}
+	q->sq_out =3D NULL;
+	if (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL) {
+		snprintf(name, sizeof(name), "VHC1-%i-%02x", dev_addr, usb_endpoint_num(=
&endp->desc));
+		q->sq_out =3D bce_create_sq(vhci->dev, q->cq, name, 0x100, DMA_TO_DEVICE=
,
+								  bce_vhci_transfer_queue_completion, q);
+	}
+}
+
+void bce_vhci_destroy_transfer_queue(struct bce_vhci *vhci, struct bce_vhc=
i_transfer_queue *q)
+{
+	bce_vhci_transfer_queue_giveback(q);
+	bce_vhci_transfer_queue_remove_pending(q);
+	if (q->sq_in)
+		bce_destroy_sq(vhci->dev, q->sq_in);
+	if (q->sq_out)
+		bce_destroy_sq(vhci->dev, q->sq_out);
+	bce_destroy_cq(vhci->dev, q->cq);
+}
+
+static inline bool bce_vhci_transfer_queue_can_init_urb(struct bce_vhci_tr=
ansfer_queue *q)
+{
+	return q->remaining_active_requests > 0;
+}
+
+static void bce_vhci_transfer_queue_defer_event(struct bce_vhci_transfer_q=
ueue *q, struct bce_vhci_message *msg)
+{
+	struct bce_vhci_list_message *lm;
+	lm =3D kmalloc(sizeof(struct bce_vhci_list_message), GFP_KERNEL);
+	INIT_LIST_HEAD(&lm->list);
+	lm->msg =3D *msg;
+	list_add_tail(&lm->list, &q->evq);
+}
+
+static void bce_vhci_transfer_queue_giveback(struct bce_vhci_transfer_queu=
e *q)
+{
+	unsigned long flags;
+	struct urb *urb;
+	spin_lock_irqsave(&q->urb_lock, flags);
+	while (!list_empty(&q->giveback_urb_list)) {
+		urb =3D list_first_entry(&q->giveback_urb_list, struct urb, urb_list);
+		list_del(&urb->urb_list);
+
+		spin_unlock_irqrestore(&q->urb_lock, flags);
+		usb_hcd_giveback_urb(q->vhci->hcd, urb, urb->status);
+		spin_lock_irqsave(&q->urb_lock, flags);
+	}
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+}
+
+static void bce_vhci_transfer_queue_init_pending_urbs(struct bce_vhci_tran=
sfer_queue *q);
+
+static void bce_vhci_transfer_queue_deliver_pending(struct bce_vhci_transf=
er_queue *q)
+{
+	struct urb *urb;
+	struct bce_vhci_list_message *lm;
+
+	while (!list_empty(&q->endp->urb_list) && !list_empty(&q->evq)) {
+		urb =3D list_first_entry(&q->endp->urb_list, struct urb, urb_list);
+
+		lm =3D list_first_entry(&q->evq, struct bce_vhci_list_message, list);
+		if (bce_vhci_urb_update(urb->hcpriv, &lm->msg) =3D=3D -EAGAIN)
+			break;
+		list_del(&lm->list);
+		kfree(lm);
+	}
+
+	/* some of the URBs could have been completed, so initialize more URBs if=
 possible */
+	bce_vhci_transfer_queue_init_pending_urbs(q);
+}
+
+static void bce_vhci_transfer_queue_remove_pending(struct bce_vhci_transfe=
r_queue *q)
+{
+	unsigned long flags;
+	struct bce_vhci_list_message *lm;
+	spin_lock_irqsave(&q->urb_lock, flags);
+	while (!list_empty(&q->evq)) {
+		lm =3D list_first_entry(&q->evq, struct bce_vhci_list_message, list);
+		list_del(&lm->list);
+		kfree(lm);
+	}
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+}
+
+void bce_vhci_transfer_queue_event(struct bce_vhci_transfer_queue *q, stru=
ct bce_vhci_message *msg)
+{
+	unsigned long flags;
+	struct bce_vhci_urb *turb;
+	struct urb *urb;
+	spin_lock_irqsave(&q->urb_lock, flags);
+	bce_vhci_transfer_queue_deliver_pending(q);
+
+	if (msg->cmd =3D=3D BCE_VHCI_CMD_TRANSFER_REQUEST &&
+		(!list_empty(&q->evq) || list_empty(&q->endp->urb_list))) {
+		bce_vhci_transfer_queue_defer_event(q, msg);
+		goto complete;
+	}
+	if (list_empty(&q->endp->urb_list)) {
+		pr_err("bce-vhci: [%02x] Unexpected transfer queue event\n", q->endp_add=
r);
+		goto complete;
+	}
+	urb =3D list_first_entry(&q->endp->urb_list, struct urb, urb_list);
+	turb =3D urb->hcpriv;
+	if (bce_vhci_urb_update(turb, msg) =3D=3D -EAGAIN) {
+		bce_vhci_transfer_queue_defer_event(q, msg);
+	} else {
+		bce_vhci_transfer_queue_init_pending_urbs(q);
+	}
+
+complete:
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	bce_vhci_transfer_queue_giveback(q);
+}
+
+static void bce_vhci_transfer_queue_completion(struct bce_queue_sq *sq)
+{
+	unsigned long flags;
+	struct bce_sq_completion_data *c;
+	struct urb *urb;
+	struct bce_vhci_transfer_queue *q =3D sq->userdata;
+	spin_lock_irqsave(&q->urb_lock, flags);
+	while ((c =3D bce_next_completion(sq))) {
+		if (c->status =3D=3D BCE_COMPLETION_ABORTED) { /* We flushed the queue *=
/
+			pr_debug("bce-vhci: [%02x] Got an abort completion\n", q->endp_addr);
+			bce_notify_submission_complete(sq);
+			continue;
+		}
+		if (list_empty(&q->endp->urb_list)) {
+			pr_err("bce-vhci: [%02x] Got a completion while no requests are pending=
\n", q->endp_addr);
+			continue;
+		}
+		pr_debug("bce-vhci: [%02x] Got a transfer queue completion\n", q->endp_a=
ddr);
+		urb =3D list_first_entry(&q->endp->urb_list, struct urb, urb_list);
+		bce_vhci_urb_transfer_completion(urb->hcpriv, c);
+		bce_notify_submission_complete(sq);
+	}
+	bce_vhci_transfer_queue_deliver_pending(q);
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	bce_vhci_transfer_queue_giveback(q);
+}
+
+int bce_vhci_transfer_queue_do_pause(struct bce_vhci_transfer_queue *q)
+{
+	unsigned long flags;
+	int status;
+	u8 endp_addr =3D (u8) (q->endp->desc.bEndpointAddress & 0x8F);
+	spin_lock_irqsave(&q->urb_lock, flags);
+	q->active =3D false;
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	if (q->sq_out) {
+		pr_err("bce-vhci: Not implemented: wait for pending output requests\n");
+	}
+	bce_vhci_transfer_queue_remove_pending(q);
+	if ((status =3D bce_vhci_cmd_endpoint_set_state(
+			&q->vhci->cq, q->dev_addr, endp_addr, BCE_VHCI_ENDPOINT_PAUSED, &q->sta=
te)))
+		return status;
+	if (q->state !=3D BCE_VHCI_ENDPOINT_PAUSED)
+		return -EINVAL;
+	if (q->sq_in)
+		bce_cmd_flush_memory_queue(q->vhci->dev->cmd_cmdq, (u16) q->sq_in->qid);
+	if (q->sq_out)
+		bce_cmd_flush_memory_queue(q->vhci->dev->cmd_cmdq, (u16) q->sq_out->qid)=
;
+	return 0;
+}
+
+static void bce_vhci_urb_resume(struct bce_vhci_urb *urb);
+
+int bce_vhci_transfer_queue_do_resume(struct bce_vhci_transfer_queue *q)
+{
+	unsigned long flags;
+	int status;
+	struct urb *urb, *urbt;
+	struct bce_vhci_urb *vurb;
+	u8 endp_addr =3D (u8) (q->endp->desc.bEndpointAddress & 0x8F);
+	if ((status =3D bce_vhci_cmd_endpoint_set_state(
+			&q->vhci->cq, q->dev_addr, endp_addr, BCE_VHCI_ENDPOINT_ACTIVE, &q->sta=
te)))
+		return status;
+	if (q->state !=3D BCE_VHCI_ENDPOINT_ACTIVE)
+		return -EINVAL;
+	spin_lock_irqsave(&q->urb_lock, flags);
+	q->active =3D true;
+	list_for_each_entry_safe(urb, urbt, &q->endp->urb_list, urb_list) {
+		vurb =3D urb->hcpriv;
+		if (vurb->state =3D=3D BCE_VHCI_URB_INIT_PENDING) {
+			if (!bce_vhci_transfer_queue_can_init_urb(q))
+				break;
+			bce_vhci_urb_init(vurb);
+		} else {
+			bce_vhci_urb_resume(vurb);
+		}
+	}
+	bce_vhci_transfer_queue_deliver_pending(q);
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	return 0;
+}
+
+int bce_vhci_transfer_queue_pause(struct bce_vhci_transfer_queue *q, enum =
bce_vhci_pause_source src)
+{
+	int ret =3D 0;
+	mutex_lock(&q->pause_lock);
+	if ((q->paused_by & src) !=3D src) {
+		if (!q->paused_by)
+			ret =3D bce_vhci_transfer_queue_do_pause(q);
+		if (!ret)
+			q->paused_by |=3D src;
+	}
+	mutex_unlock(&q->pause_lock);
+	return ret;
+}
+
+int bce_vhci_transfer_queue_resume(struct bce_vhci_transfer_queue *q, enum=
 bce_vhci_pause_source src)
+{
+	int ret =3D 0;
+	mutex_lock(&q->pause_lock);
+	if (q->paused_by & src) {
+		if (!(q->paused_by & ~src))
+			ret =3D bce_vhci_transfer_queue_do_resume(q);
+		if (!ret)
+			q->paused_by &=3D ~src;
+	}
+	mutex_unlock(&q->pause_lock);
+	return ret;
+}
+
+static void bce_vhci_transfer_queue_reset_w(struct work_struct *work)
+{
+	unsigned long flags;
+	struct bce_vhci_transfer_queue *q =3D container_of(work, struct bce_vhci_=
transfer_queue, w_reset);
+
+	mutex_lock(&q->pause_lock);
+	spin_lock_irqsave(&q->urb_lock, flags);
+	if (!q->stalled) {
+		spin_unlock_irqrestore(&q->urb_lock, flags);
+		mutex_unlock(&q->pause_lock);
+		return;
+	}
+	q->active =3D false;
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	q->paused_by |=3D BCE_VHCI_PAUSE_INTERNAL_WQ;
+	bce_vhci_transfer_queue_remove_pending(q);
+	if (q->sq_in)
+		bce_cmd_flush_memory_queue(q->vhci->dev->cmd_cmdq, (u16) q->sq_in->qid);
+	if (q->sq_out)
+		bce_cmd_flush_memory_queue(q->vhci->dev->cmd_cmdq, (u16) q->sq_out->qid)=
;
+	bce_vhci_cmd_endpoint_reset(&q->vhci->cq, q->dev_addr, (u8) (q->endp->des=
c.bEndpointAddress & 0x8F));
+	spin_lock_irqsave(&q->urb_lock, flags);
+	q->stalled =3D false;
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	mutex_unlock(&q->pause_lock);
+	bce_vhci_transfer_queue_resume(q, BCE_VHCI_PAUSE_INTERNAL_WQ);
+}
+
+void bce_vhci_transfer_queue_request_reset(struct bce_vhci_transfer_queue =
*q)
+{
+	queue_work(q->vhci->tq_state_wq, &q->w_reset);
+}
+
+static void bce_vhci_transfer_queue_init_pending_urbs(struct bce_vhci_tran=
sfer_queue *q)
+{
+	struct urb *urb, *urbt;
+	struct bce_vhci_urb *vurb;
+	list_for_each_entry_safe(urb, urbt, &q->endp->urb_list, urb_list) {
+		vurb =3D urb->hcpriv;
+		if (!bce_vhci_transfer_queue_can_init_urb(q))
+			break;
+		if (vurb->state =3D=3D BCE_VHCI_URB_INIT_PENDING)
+			bce_vhci_urb_init(vurb);
+	}
+}
+
+
+
+static int bce_vhci_urb_data_start(struct bce_vhci_urb *urb, unsigned long=
 *timeout);
+
+int bce_vhci_urb_create(struct bce_vhci_transfer_queue *q, struct urb *urb=
)
+{
+	unsigned long flags;
+	int status =3D 0;
+	struct bce_vhci_urb *vurb;
+	vurb =3D kzalloc(sizeof(struct bce_vhci_urb), GFP_KERNEL);
+	urb->hcpriv =3D vurb;
+
+	vurb->q =3D q;
+	vurb->urb =3D urb;
+	vurb->dir =3D usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	vurb->is_control =3D (usb_endpoint_num(&urb->ep->desc) =3D=3D 0);
+
+	spin_lock_irqsave(&q->urb_lock, flags);
+	status =3D usb_hcd_link_urb_to_ep(q->vhci->hcd, urb);
+	if (status) {
+		spin_unlock_irqrestore(&q->urb_lock, flags);
+		urb->hcpriv =3D NULL;
+		kfree(vurb);
+		return status;
+	}
+
+	if (q->active) {
+		if (bce_vhci_transfer_queue_can_init_urb(vurb->q))
+			status =3D bce_vhci_urb_init(vurb);
+		else
+			vurb->state =3D BCE_VHCI_URB_INIT_PENDING;
+	} else {
+		if (q->stalled)
+			bce_vhci_transfer_queue_request_reset(q);
+		vurb->state =3D BCE_VHCI_URB_INIT_PENDING;
+	}
+	if (status) {
+		usb_hcd_unlink_urb_from_ep(q->vhci->hcd, urb);
+		urb->hcpriv =3D NULL;
+		kfree(vurb);
+	} else {
+		bce_vhci_transfer_queue_deliver_pending(q);
+	}
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+	pr_debug("bce-vhci: [%02x] URB enqueued (dir =3D %s, size =3D %i)\n", q->=
endp_addr,
+			usb_urb_dir_in(urb) ? "IN" : "OUT", urb->transfer_buffer_length);
+	return status;
+}
+
+static int bce_vhci_urb_init(struct bce_vhci_urb *vurb)
+{
+	int status =3D 0;
+
+	if (vurb->q->remaining_active_requests =3D=3D 0) {
+		pr_err("bce-vhci: cannot init request (remaining_active_requests =3D 0)\=
n");
+		return -EINVAL;
+	}
+
+	if (vurb->is_control) {
+		vurb->state =3D BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_REQUEST;
+	} else {
+		status =3D bce_vhci_urb_data_start(vurb, NULL);
+	}
+
+	if (!status) {
+		--vurb->q->remaining_active_requests;
+	}
+	return status;
+}
+
+static void bce_vhci_urb_complete(struct bce_vhci_urb *urb, int status)
+{
+	struct bce_vhci_transfer_queue *q =3D urb->q;
+	struct bce_vhci *vhci =3D q->vhci;
+	struct urb *real_urb =3D urb->urb;
+	pr_debug("bce-vhci: [%02x] URB complete %i\n", q->endp_addr, status);
+	usb_hcd_unlink_urb_from_ep(vhci->hcd, real_urb);
+	real_urb->hcpriv =3D NULL;
+	real_urb->status =3D status;
+	if (urb->state !=3D BCE_VHCI_URB_INIT_PENDING)
+		++urb->q->remaining_active_requests;
+	kfree(urb);
+	list_add_tail(&real_urb->urb_list, &q->giveback_urb_list);
+}
+
+int bce_vhci_urb_request_cancel(struct bce_vhci_transfer_queue *q, struct =
urb *urb, int status)
+{
+	struct bce_vhci_urb *vurb;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&q->urb_lock, flags);
+	if ((ret =3D usb_hcd_check_unlink_urb(q->vhci->hcd, urb, status))) {
+		spin_unlock_irqrestore(&q->urb_lock, flags);
+		return ret;
+	}
+
+	vurb =3D urb->hcpriv;
+	/* If the URB wasn't posted to the device yet, we can still remove it on =
the host without pausing the queue. */
+	if (vurb->state !=3D BCE_VHCI_URB_INIT_PENDING) {
+		pr_debug("bce-vhci: [%02x] Cancelling URB\n", q->endp_addr);
+
+		spin_unlock_irqrestore(&q->urb_lock, flags);
+		bce_vhci_transfer_queue_pause(q, BCE_VHCI_PAUSE_INTERNAL_WQ);
+		spin_lock_irqsave(&q->urb_lock, flags);
+
+		++q->remaining_active_requests;
+	}
+
+	usb_hcd_unlink_urb_from_ep(q->vhci->hcd, urb);
+
+	spin_unlock_irqrestore(&q->urb_lock, flags);
+
+	usb_hcd_giveback_urb(q->vhci->hcd, urb, status);
+
+	if (vurb->state !=3D BCE_VHCI_URB_INIT_PENDING)
+		bce_vhci_transfer_queue_resume(q, BCE_VHCI_PAUSE_INTERNAL_WQ);
+
+	kfree(vurb);
+
+	return 0;
+}
+
+static int bce_vhci_urb_data_transfer_in(struct bce_vhci_urb *urb, unsigne=
d long *timeout)
+{
+	struct bce_vhci_message msg;
+	struct bce_qe_submission *s;
+	u32 tr_len;
+	int reservation1, reservation2 =3D -EFAULT;
+
+	pr_debug("bce-vhci: [%02x] DMA from device %llx %x\n", urb->q->endp_addr,
+			 (u64) urb->urb->transfer_dma, urb->urb->transfer_buffer_length);
+
+	/* Reserve both a message and a submission, so we don't run into issues l=
ater. */
+	reservation1 =3D bce_reserve_submission(urb->q->vhci->msg_asynchronous.sq=
, timeout);
+	if (!reservation1)
+		reservation2 =3D bce_reserve_submission(urb->q->sq_in, timeout);
+	if (reservation1 || reservation2) {
+		pr_err("bce-vhci: Failed to reserve a submission for URB data transfer\n=
");
+		if (!reservation1)
+			bce_cancel_submission_reservation(urb->q->vhci->msg_asynchronous.sq);
+		return -ENOMEM;
+	}
+
+	urb->send_offset =3D urb->receive_offset;
+
+	tr_len =3D urb->urb->transfer_buffer_length - urb->send_offset;
+
+	spin_lock(&urb->q->vhci->msg_asynchronous_lock);
+	msg.cmd =3D BCE_VHCI_CMD_TRANSFER_REQUEST;
+	msg.status =3D 0;
+	msg.param1 =3D ((urb->urb->ep->desc.bEndpointAddress & 0x8Fu) << 8) | urb=
->q->dev_addr;
+	msg.param2 =3D tr_len;
+	bce_vhci_message_queue_write(&urb->q->vhci->msg_asynchronous, &msg);
+	spin_unlock(&urb->q->vhci->msg_asynchronous_lock);
+
+	s =3D bce_next_submission(urb->q->sq_in);
+	bce_set_submission_single(s, urb->urb->transfer_dma + urb->send_offset, t=
r_len);
+	bce_submit_to_device(urb->q->sq_in);
+
+	urb->state =3D BCE_VHCI_URB_WAITING_FOR_COMPLETION;
+	return 0;
+}
+
+static int bce_vhci_urb_data_start(struct bce_vhci_urb *urb, unsigned long=
 *timeout)
+{
+	if (urb->dir =3D=3D DMA_TO_DEVICE) {
+		if (urb->urb->transfer_buffer_length > 0)
+			urb->state =3D BCE_VHCI_URB_WAITING_FOR_TRANSFER_REQUEST;
+		else
+			urb->state =3D BCE_VHCI_URB_DATA_TRANSFER_COMPLETE;
+		return 0;
+	} else {
+		return bce_vhci_urb_data_transfer_in(urb, timeout);
+	}
+}
+
+static int bce_vhci_urb_send_out_data(struct bce_vhci_urb *urb, dma_addr_t=
 addr, size_t size)
+{
+	struct bce_qe_submission *s;
+	unsigned long timeout =3D 0;
+	if (bce_reserve_submission(urb->q->sq_out, &timeout)) {
+		pr_err("bce-vhci: Failed to reserve a submission for URB data transfer\n=
");
+		return -EPIPE;
+	}
+
+	pr_debug("bce-vhci: [%02x] DMA to device %llx %lx\n", urb->q->endp_addr, =
(u64) addr, size);
+
+	s =3D bce_next_submission(urb->q->sq_out);
+	bce_set_submission_single(s, addr, size);
+	bce_submit_to_device(urb->q->sq_out);
+	return 0;
+}
+
+static int bce_vhci_urb_data_update(struct bce_vhci_urb *urb, struct bce_v=
hci_message *msg)
+{
+	u32 tr_len;
+	int status;
+	if (urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_TRANSFER_REQUEST) {
+		if (msg->cmd =3D=3D BCE_VHCI_CMD_TRANSFER_REQUEST) {
+			tr_len =3D min(urb->urb->transfer_buffer_length - urb->send_offset, (u3=
2) msg->param2);
+			if ((status =3D bce_vhci_urb_send_out_data(urb, urb->urb->transfer_dma =
+ urb->send_offset, tr_len)))
+				return status;
+			urb->send_offset +=3D tr_len;
+			urb->state =3D BCE_VHCI_URB_WAITING_FOR_COMPLETION;
+			return 0;
+		}
+	}
+
+	/* 0x1000 in out queues aren't really unexpected */
+	if (msg->cmd =3D=3D BCE_VHCI_CMD_TRANSFER_REQUEST && urb->q->sq_out !=3D =
NULL)
+		return -EAGAIN;
+	pr_err("bce-vhci: [%02x] %s URB unexpected message (state =3D %x, msg: %x=
 %x %x %llx)\n",
+			urb->q->endp_addr, (urb->is_control ? "Control (data update)" : "Data")=
, urb->state,
+			msg->cmd, msg->status, msg->param1, msg->param2);
+	return -EAGAIN;
+}
+
+static int bce_vhci_urb_data_transfer_completion(struct bce_vhci_urb *urb,=
 struct bce_sq_completion_data *c)
+{
+	if (urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_COMPLETION) {
+		urb->receive_offset +=3D c->data_size;
+		if (urb->dir =3D=3D DMA_FROM_DEVICE || urb->receive_offset >=3D urb->urb=
->transfer_buffer_length) {
+			urb->urb->actual_length =3D (u32) urb->receive_offset;
+			urb->state =3D BCE_VHCI_URB_DATA_TRANSFER_COMPLETE;
+			if (!urb->is_control) {
+				bce_vhci_urb_complete(urb, 0);
+				return -ENOENT;
+			}
+		}
+	} else {
+		pr_err("bce-vhci: [%02x] Data URB unexpected completion\n", urb->q->endp=
_addr);
+	}
+	return 0;
+}
+
+
+static int bce_vhci_urb_control_check_status(struct bce_vhci_urb *urb)
+{
+	struct bce_vhci_transfer_queue *q =3D urb->q;
+	if (urb->received_status =3D=3D 0)
+		return 0;
+	if (urb->state =3D=3D BCE_VHCI_URB_DATA_TRANSFER_COMPLETE ||
+		(urb->received_status !=3D BCE_VHCI_SUCCESS && urb->state !=3D BCE_VHCI_=
URB_CONTROL_WAITING_FOR_SETUP_REQUEST &&
+		urb->state !=3D BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_COMPLETION)) {
+		urb->state =3D BCE_VHCI_URB_CONTROL_COMPLETE;
+		if (urb->received_status !=3D BCE_VHCI_SUCCESS) {
+			pr_err("bce-vhci: [%02x] URB failed: %x\n", urb->q->endp_addr, urb->rec=
eived_status);
+			urb->q->active =3D false;
+			urb->q->stalled =3D true;
+			bce_vhci_urb_complete(urb, -EPIPE);
+			if (!list_empty(&q->endp->urb_list))
+				bce_vhci_transfer_queue_request_reset(q);
+			return -ENOENT;
+		}
+		bce_vhci_urb_complete(urb, 0);
+		return -ENOENT;
+	}
+	return 0;
+}
+
+static int bce_vhci_urb_control_update(struct bce_vhci_urb *urb, struct bc=
e_vhci_message *msg)
+{
+	int status;
+	if (msg->cmd =3D=3D BCE_VHCI_CMD_CONTROL_TRANSFER_STATUS) {
+		urb->received_status =3D msg->status;
+		return bce_vhci_urb_control_check_status(urb);
+	}
+
+	if (urb->state =3D=3D BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_REQUEST) {
+		if (msg->cmd =3D=3D BCE_VHCI_CMD_TRANSFER_REQUEST) {
+			if (bce_vhci_urb_send_out_data(urb, urb->urb->setup_dma, sizeof(struct =
usb_ctrlrequest))) {
+				pr_err("bce-vhci: [%02x] Failed to start URB setup transfer\n", urb->q=
->endp_addr);
+				return 0; /* TODO: fail the URB? */
+			}
+			urb->state =3D BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_COMPLETION;
+			pr_debug("bce-vhci: [%02x] Sent setup %llx\n", urb->q->endp_addr, urb->=
urb->setup_dma);
+			return 0;
+		}
+	} else if (urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_TRANSFER_REQUEST ||
+			   urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_COMPLETION) {
+		if ((status =3D bce_vhci_urb_data_update(urb, msg)))
+			return status;
+		return bce_vhci_urb_control_check_status(urb);
+	}
+
+	/* 0x1000 in out queues aren't really unexpected */
+	if (msg->cmd =3D=3D BCE_VHCI_CMD_TRANSFER_REQUEST && urb->q->sq_out !=3D =
NULL)
+		return -EAGAIN;
+	pr_err("bce-vhci: [%02x] Control URB unexpected message (state =3D %x, ms=
g: %x %x %x %llx)\n", urb->q->endp_addr,
+			urb->state, msg->cmd, msg->status, msg->param1, msg->param2);
+	return -EAGAIN;
+}
+
+static int bce_vhci_urb_control_transfer_completion(struct bce_vhci_urb *u=
rb, struct bce_sq_completion_data *c)
+{
+	int status;
+	unsigned long timeout;
+
+	if (urb->state =3D=3D BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_COMPLETION) =
{
+		if (c->data_size !=3D sizeof(struct usb_ctrlrequest))
+			pr_err("bce-vhci: [%02x] transfer complete data size mistmatch for usb_=
ctrlrequest (%llx instead of %lx)\n",
+				   urb->q->endp_addr, c->data_size, sizeof(struct usb_ctrlrequest));
+
+		timeout =3D 1000;
+		status =3D bce_vhci_urb_data_start(urb, &timeout);
+		if (status) {
+			bce_vhci_urb_complete(urb, status);
+			return -ENOENT;
+		}
+		return 0;
+	} else if (urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_TRANSFER_REQUEST ||
+			   urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_COMPLETION) {
+		if ((status =3D bce_vhci_urb_data_transfer_completion(urb, c)))
+			return status;
+		return bce_vhci_urb_control_check_status(urb);
+	} else {
+		pr_err("bce-vhci: [%02x] Control URB unexpected completion (state =3D %x=
)\n", urb->q->endp_addr, urb->state);
+	}
+	return 0;
+}
+
+static int bce_vhci_urb_update(struct bce_vhci_urb *urb, struct bce_vhci_m=
essage *msg)
+{
+	if (urb->state =3D=3D BCE_VHCI_URB_INIT_PENDING)
+		return -EAGAIN;
+	if (urb->is_control)
+		return bce_vhci_urb_control_update(urb, msg);
+	else
+		return bce_vhci_urb_data_update(urb, msg);
+}
+
+static int bce_vhci_urb_transfer_completion(struct bce_vhci_urb *urb, stru=
ct bce_sq_completion_data *c)
+{
+	if (urb->is_control)
+		return bce_vhci_urb_control_transfer_completion(urb, c);
+	else
+		return bce_vhci_urb_data_transfer_completion(urb, c);
+}
+
+static void bce_vhci_urb_resume(struct bce_vhci_urb *urb)
+{
+	int status =3D 0;
+	if (urb->state =3D=3D BCE_VHCI_URB_WAITING_FOR_COMPLETION) {
+		status =3D bce_vhci_urb_data_transfer_in(urb, NULL);
+	}
+	if (status)
+		bce_vhci_urb_complete(urb, status);
+}
+
diff --git a/drivers/staging/apple-bce/vhci/transfer.h b/drivers/staging/ap=
ple-bce/vhci/transfer.h
new file mode 100644
index 000000000..75774ef99
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/transfer.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCEDRIVER_TRANSFER_H
+#define BCEDRIVER_TRANSFER_H
+
+#include <linux/usb.h>
+#include "queue.h"
+#include "command.h"
+#include "../queue.h"
+
+struct bce_vhci_list_message {
+	struct list_head list;
+	struct bce_vhci_message msg;
+};
+enum bce_vhci_pause_source {
+	BCE_VHCI_PAUSE_INTERNAL_WQ =3D 1,
+	BCE_VHCI_PAUSE_FIRMWARE =3D 2,
+	BCE_VHCI_PAUSE_SUSPEND =3D 4,
+	BCE_VHCI_PAUSE_SHUTDOWN =3D 8
+};
+struct bce_vhci_transfer_queue {
+	struct bce_vhci *vhci;
+	struct usb_host_endpoint *endp;
+	enum bce_vhci_endpoint_state state;
+	u32 max_active_requests, remaining_active_requests;
+	bool active, stalled;
+	u32 paused_by;
+	bce_vhci_device_t dev_addr;
+	u8 endp_addr;
+	struct bce_queue_cq *cq;
+	struct bce_queue_sq *sq_in;
+	struct bce_queue_sq *sq_out;
+	struct list_head evq;
+	struct spinlock urb_lock;
+	struct mutex pause_lock;
+	struct list_head giveback_urb_list;
+
+	struct work_struct w_reset;
+};
+enum bce_vhci_urb_state {
+	BCE_VHCI_URB_INIT_PENDING,
+
+	BCE_VHCI_URB_WAITING_FOR_TRANSFER_REQUEST,
+	BCE_VHCI_URB_WAITING_FOR_COMPLETION,
+	BCE_VHCI_URB_DATA_TRANSFER_COMPLETE,
+
+	BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_REQUEST,
+	BCE_VHCI_URB_CONTROL_WAITING_FOR_SETUP_COMPLETION,
+	BCE_VHCI_URB_CONTROL_COMPLETE
+};
+struct bce_vhci_urb {
+	struct urb *urb;
+	struct bce_vhci_transfer_queue *q;
+	enum dma_data_direction dir;
+	bool is_control;
+	enum bce_vhci_urb_state state;
+	int received_status;
+	u32 send_offset;
+	u32 receive_offset;
+};
+
+void bce_vhci_create_transfer_queue(struct bce_vhci *vhci, struct bce_vhci=
_transfer_queue *q,
+		struct usb_host_endpoint *endp, bce_vhci_device_t dev_addr, enum dma_dat=
a_direction dir);
+void bce_vhci_destroy_transfer_queue(struct bce_vhci *vhci, struct bce_vhc=
i_transfer_queue *q);
+void bce_vhci_transfer_queue_event(struct bce_vhci_transfer_queue *q, stru=
ct bce_vhci_message *msg);
+int bce_vhci_transfer_queue_do_pause(struct bce_vhci_transfer_queue *q);
+int bce_vhci_transfer_queue_do_resume(struct bce_vhci_transfer_queue *q);
+int bce_vhci_transfer_queue_pause(struct bce_vhci_transfer_queue *q, enum =
bce_vhci_pause_source src);
+int bce_vhci_transfer_queue_resume(struct bce_vhci_transfer_queue *q, enum=
 bce_vhci_pause_source src);
+void bce_vhci_transfer_queue_request_reset(struct bce_vhci_transfer_queue =
*q);
+
+int bce_vhci_urb_create(struct bce_vhci_transfer_queue *q, struct urb *urb=
);
+int bce_vhci_urb_request_cancel(struct bce_vhci_transfer_queue *q, struct =
urb *urb, int status);
+
+#endif //BCEDRIVER_TRANSFER_H
+
diff --git a/drivers/staging/apple-bce/vhci/vhci.c b/drivers/staging/apple-=
bce/vhci/vhci.c
new file mode 100644
index 000000000..fc934513b
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/vhci.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "vhci.h"
+#include "../apple_bce.h"
+#include "command.h"
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/module.h>
+#include <linux/version.h>
+
+static dev_t bce_vhci_chrdev;
+static struct class *bce_vhci_class;
+static const struct hc_driver bce_vhci_driver;
+static u16 bce_vhci_port_mask =3D U16_MAX;
+
+static int bce_vhci_create_event_queues(struct bce_vhci *vhci);
+static void bce_vhci_destroy_event_queues(struct bce_vhci *vhci);
+static int bce_vhci_create_message_queues(struct bce_vhci *vhci);
+static void bce_vhci_destroy_message_queues(struct bce_vhci *vhci);
+static void bce_vhci_handle_firmware_events_w(struct work_struct *ws);
+static void bce_vhci_firmware_event_completion(struct bce_queue_sq *sq);
+
+int bce_vhci_create(struct apple_bce_device *dev, struct bce_vhci *vhci)
+{
+	int status;
+
+	spin_lock_init(&vhci->hcd_spinlock);
+
+	vhci->dev =3D dev;
+
+	vhci->vdevt =3D bce_vhci_chrdev;
+	vhci->vdev =3D device_create(bce_vhci_class, dev->dev, vhci->vdevt, NULL,=
 "bce-vhci");
+	if (IS_ERR_OR_NULL(vhci->vdev)) {
+		status =3D PTR_ERR(vhci->vdev);
+		goto fail_dev;
+	}
+
+	if ((status =3D bce_vhci_create_message_queues(vhci)))
+		goto fail_mq;
+	if ((status =3D bce_vhci_create_event_queues(vhci)))
+		goto fail_eq;
+
+	vhci->tq_state_wq =3D alloc_ordered_workqueue("bce-vhci-tq-state", 0);
+	INIT_WORK(&vhci->w_fw_events, bce_vhci_handle_firmware_events_w);
+
+	vhci->hcd =3D usb_create_hcd(&bce_vhci_driver, vhci->vdev, "bce-vhci");
+	if (!vhci->hcd) {
+		status =3D -ENOMEM;
+		goto fail_hcd;
+	}
+	vhci->hcd->self.sysdev =3D &dev->pci->dev;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
+	vhci->hcd->self.uses_dma =3D 1;
+#endif
+	*((struct bce_vhci **) vhci->hcd->hcd_priv) =3D vhci;
+	vhci->hcd->speed =3D HCD_USB2;
+
+	if ((status =3D usb_add_hcd(vhci->hcd, 0, 0)))
+		goto fail_hcd;
+
+	return 0;
+
+fail_hcd:
+	bce_vhci_destroy_event_queues(vhci);
+fail_eq:
+	bce_vhci_destroy_message_queues(vhci);
+fail_mq:
+	device_destroy(bce_vhci_class, vhci->vdevt);
+fail_dev:
+	if (!status)
+		status =3D -EINVAL;
+	return status;
+}
+
+void bce_vhci_destroy(struct bce_vhci *vhci)
+{
+	usb_remove_hcd(vhci->hcd);
+	bce_vhci_destroy_event_queues(vhci);
+	bce_vhci_destroy_message_queues(vhci);
+	device_destroy(bce_vhci_class, vhci->vdevt);
+}
+
+struct bce_vhci *bce_vhci_from_hcd(struct usb_hcd *hcd)
+{
+	return *((struct bce_vhci **) hcd->hcd_priv);
+}
+
+int bce_vhci_start(struct usb_hcd *hcd)
+{
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	int status;
+	u16 port_mask =3D 0;
+	bce_vhci_port_t port_no =3D 0;
+	if ((status =3D bce_vhci_cmd_controller_enable(&vhci->cq, 1, &port_mask))=
)
+		return status;
+	vhci->port_mask =3D port_mask;
+	vhci->port_power_mask =3D 0;
+	if ((status =3D bce_vhci_cmd_controller_start(&vhci->cq)))
+		return status;
+	port_mask =3D vhci->port_mask;
+	while (port_mask) {
+		port_no +=3D 1;
+		port_mask >>=3D 1;
+	}
+	vhci->port_count =3D port_no;
+	return 0;
+}
+
+void bce_vhci_stop(struct usb_hcd *hcd)
+{
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	bce_vhci_cmd_controller_disable(&vhci->cq);
+}
+
+static int bce_vhci_hub_status_data(struct usb_hcd *hcd, char *buf)
+{
+	return 0;
+}
+
+static int bce_vhci_reset_device(struct bce_vhci *vhci, int index, u16 tim=
eout);
+
+static int bce_vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wVal=
ue, u16 wIndex, char *buf, u16 wLength)
+{
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	int status;
+	struct usb_hub_descriptor *hd;
+	struct usb_hub_status *hs;
+	struct usb_port_status *ps;
+	u32 port_status;
+	// pr_info("bce-vhci: bce_vhci_hub_control %x %i %i [bufl=3D%i]\n", typeR=
eq, wValue, wIndex, wLength);
+	if (typeReq =3D=3D GetHubDescriptor && wLength >=3D sizeof(struct usb_hub=
_descriptor)) {
+		hd =3D (struct usb_hub_descriptor *) buf;
+		memset(hd, 0, sizeof(*hd));
+		hd->bDescLength =3D sizeof(struct usb_hub_descriptor);
+		hd->bDescriptorType =3D USB_DT_HUB;
+		hd->bNbrPorts =3D (u8) vhci->port_count;
+		hd->wHubCharacteristics =3D cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM | HUB_CH=
AR_INDV_PORT_OCPM);
+		hd->bPwrOn2PwrGood =3D 0;
+		hd->bHubContrCurrent =3D 0;
+		return 0;
+	} else if (typeReq =3D=3D GetHubStatus && wLength >=3D sizeof(struct usb_=
hub_status)) {
+		hs =3D (struct usb_hub_status *) buf;
+		memset(hs, 0, sizeof(*hs));
+		hs->wHubStatus =3D 0;
+		hs->wHubChange =3D 0;
+		return 0;
+	} else if (typeReq =3D=3D GetPortStatus && wLength >=3D 4 /* usb 2.0 */) =
{
+		ps =3D (struct usb_port_status *) buf;
+		ps->wPortStatus =3D 0;
+		ps->wPortChange =3D 0;
+
+		if (vhci->port_power_mask & BIT(wIndex))
+			ps->wPortStatus |=3D cpu_to_le16(USB_PORT_STAT_POWER);
+
+		if (!(bce_vhci_port_mask & BIT(wIndex)))
+			return 0;
+
+		if ((status =3D bce_vhci_cmd_port_status(&vhci->cq, (u8) wIndex, 0, &por=
t_status)))
+			return status;
+
+		if (port_status & 16)
+			ps->wPortStatus |=3D cpu_to_le16(USB_PORT_STAT_ENABLE | USB_PORT_STAT_H=
IGH_SPEED);
+		if (port_status & 4)
+			ps->wPortStatus |=3D cpu_to_le16(USB_PORT_STAT_CONNECTION);
+		if (port_status & 2)
+			ps->wPortStatus |=3D cpu_to_le16(USB_PORT_STAT_OVERCURRENT);
+		if (port_status & 8)
+			ps->wPortStatus |=3D cpu_to_le16(USB_PORT_STAT_RESET);
+		if (port_status & 0x60)
+			ps->wPortStatus |=3D cpu_to_le16(USB_PORT_STAT_SUSPEND);
+
+		if (port_status & 0x40000)
+			ps->wPortChange |=3D cpu_to_le16(USB_PORT_STAT_C_CONNECTION);
+
+		pr_debug("bce-vhci: Translated status %x to %x:%x\n", port_status, ps->w=
PortStatus, ps->wPortChange);
+		return 0;
+	} else if (typeReq =3D=3D SetPortFeature) {
+		if (wValue =3D=3D USB_PORT_FEAT_POWER) {
+			status =3D bce_vhci_cmd_port_power_on(&vhci->cq, (u8) wIndex);
+			/* As far as I am aware, power status is not part of the port status so=
 store it separately */
+			if (!status)
+				vhci->port_power_mask |=3D BIT(wIndex);
+			return status;
+		}
+		if (wValue =3D=3D USB_PORT_FEAT_RESET) {
+			return bce_vhci_reset_device(vhci, wIndex, wValue);
+		}
+		if (wValue =3D=3D USB_PORT_FEAT_SUSPEND) {
+			/* TODO: Am I supposed to also suspend the endpoints? */
+			pr_debug("bce-vhci: Suspending port %i\n", wIndex);
+			return bce_vhci_cmd_port_suspend(&vhci->cq, (u8) wIndex);
+		}
+	} else if (typeReq =3D=3D ClearPortFeature) {
+		if (wValue =3D=3D USB_PORT_FEAT_ENABLE)
+			return bce_vhci_cmd_port_disable(&vhci->cq, (u8) wIndex);
+		if (wValue =3D=3D USB_PORT_FEAT_POWER) {
+			status =3D bce_vhci_cmd_port_power_off(&vhci->cq, (u8) wIndex);
+			if (!status)
+				vhci->port_power_mask &=3D ~BIT(wIndex);
+			return status;
+		}
+		if (wValue =3D=3D USB_PORT_FEAT_C_CONNECTION)
+			return bce_vhci_cmd_port_status(&vhci->cq, (u8) wIndex, 0x40000, &port_=
status);
+		if (wValue =3D=3D USB_PORT_FEAT_C_RESET) { /* I don't think I can transf=
er it in any way */
+			return 0;
+		}
+		if (wValue =3D=3D USB_PORT_FEAT_SUSPEND) {
+			pr_debug("bce-vhci: Resuming port %i\n", wIndex);
+			return bce_vhci_cmd_port_resume(&vhci->cq, (u8) wIndex);
+		}
+	}
+	pr_err("bce-vhci: bce_vhci_hub_control unhandled request: %x %i %i [bufl=
=3D%i]\n", typeReq, wValue, wIndex, wLength);
+	dump_stack();
+	return -EIO;
+}
+
+static int bce_vhci_enable_device(struct usb_hcd *hcd, struct usb_device *=
udev)
+{
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	struct bce_vhci_device *vdev;
+	bce_vhci_device_t devid;
+	pr_info("bce_vhci_enable_device\n");
+
+	if (vhci->port_to_device[udev->portnum])
+		return 0;
+
+	/* We need to early address the device */
+	if (bce_vhci_cmd_device_create(&vhci->cq, udev->portnum, &devid))
+		return -EIO;
+
+	pr_info("bce_vhci_cmd_device_create %i -> %i\n", udev->portnum, devid);
+
+	vdev =3D kzalloc(sizeof(struct bce_vhci_device), GFP_KERNEL);
+	vhci->port_to_device[udev->portnum] =3D devid;
+	vhci->devices[devid] =3D vdev;
+
+	bce_vhci_create_transfer_queue(vhci, &vdev->tq[0], &udev->ep0, devid, DMA=
_BIDIRECTIONAL);
+	udev->ep0.hcpriv =3D &vdev->tq[0];
+	vdev->tq_mask |=3D BIT(0);
+
+	bce_vhci_cmd_endpoint_create(&vhci->cq, devid, &udev->ep0.desc);
+	return 0;
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,8,0)
+static int bce_vhci_address_device(struct usb_hcd *hcd, struct usb_device =
*udev)
+#else
+static int bce_vhci_address_device(struct usb_hcd *hcd, struct usb_device =
*udev, unsigned int timeout_ms) //TODO: follow timeout
+#endif
+{
+	/* This is the same as enable_device, but instead in the old scheme */
+	return bce_vhci_enable_device(hcd, udev);
+}
+
+static void bce_vhci_free_device(struct usb_hcd *hcd, struct usb_device *u=
dev)
+{
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	int i;
+	bce_vhci_device_t devid;
+	struct bce_vhci_device *dev;
+	pr_info("bce_vhci_free_device %i\n", udev->portnum);
+	if (!vhci->port_to_device[udev->portnum])
+		return;
+	devid =3D vhci->port_to_device[udev->portnum];
+	dev =3D vhci->devices[devid];
+	for (i =3D 0; i < 32; i++) {
+		if (dev->tq_mask & BIT(i)) {
+			bce_vhci_transfer_queue_pause(&dev->tq[i], BCE_VHCI_PAUSE_SHUTDOWN);
+			bce_vhci_cmd_endpoint_destroy(&vhci->cq, devid, (u8) i);
+			bce_vhci_destroy_transfer_queue(vhci, &dev->tq[i]);
+		}
+	}
+	vhci->devices[devid] =3D NULL;
+	vhci->port_to_device[udev->portnum] =3D 0;
+	bce_vhci_cmd_device_destroy(&vhci->cq, devid);
+	kfree(dev);
+}
+
+static int bce_vhci_reset_device(struct bce_vhci *vhci, int index, u16 tim=
eout)
+{
+	struct bce_vhci_device *dev =3D NULL;
+	bce_vhci_device_t devid;
+	int i;
+	int status;
+	enum dma_data_direction dir;
+	pr_info("bce_vhci_reset_device %i\n", index);
+
+	devid =3D vhci->port_to_device[index];
+	if (devid) {
+		dev =3D vhci->devices[devid];
+
+		for (i =3D 0; i < 32; i++) {
+			if (dev->tq_mask & BIT(i)) {
+				bce_vhci_transfer_queue_pause(&dev->tq[i], BCE_VHCI_PAUSE_SHUTDOWN);
+				bce_vhci_cmd_endpoint_destroy(&vhci->cq, devid, (u8) i);
+				bce_vhci_destroy_transfer_queue(vhci, &dev->tq[i]);
+			}
+		}
+		vhci->devices[devid] =3D NULL;
+		vhci->port_to_device[index] =3D 0;
+		bce_vhci_cmd_device_destroy(&vhci->cq, devid);
+	}
+	status =3D bce_vhci_cmd_port_reset(&vhci->cq, (u8) index, timeout);
+
+	if (dev) {
+		if ((status =3D bce_vhci_cmd_device_create(&vhci->cq, index, &devid)))
+			return status;
+		vhci->devices[devid] =3D dev;
+		vhci->port_to_device[index] =3D devid;
+
+		for (i =3D 0; i < 32; i++) {
+			if (dev->tq_mask & BIT(i)) {
+				dir =3D usb_endpoint_dir_in(&dev->tq[i].endp->desc) ? DMA_FROM_DEVICE =
: DMA_TO_DEVICE;
+				if (i =3D=3D 0)
+					dir =3D DMA_BIDIRECTIONAL;
+				bce_vhci_create_transfer_queue(vhci, &dev->tq[i], dev->tq[i].endp, dev=
id, dir);
+				bce_vhci_cmd_endpoint_create(&vhci->cq, devid, &dev->tq[i].endp->desc)=
;
+			}
+		}
+	}
+
+	return status;
+}
+
+static int bce_vhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device=
 *udev)
+{
+	return 0;
+}
+
+static int bce_vhci_get_frame_number(struct usb_hcd *hcd)
+{
+	return 0;
+}
+
+static int bce_vhci_bus_suspend(struct usb_hcd *hcd)
+{
+	int i, j;
+	int status;
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	pr_info("bce_vhci: suspend started\n");
+
+	pr_info("bce_vhci: suspend endpoints\n");
+	for (i =3D 0; i < 16; i++) {
+		if (!vhci->port_to_device[i])
+			continue;
+		for (j =3D 0; j < 32; j++) {
+			if (!(vhci->devices[vhci->port_to_device[i]]->tq_mask & BIT(j)))
+				continue;
+			bce_vhci_transfer_queue_pause(&vhci->devices[vhci->port_to_device[i]]->=
tq[j],
+					BCE_VHCI_PAUSE_SUSPEND);
+		}
+	}
+
+	pr_info("bce_vhci: suspend ports\n");
+	for (i =3D 0; i < 16; i++) {
+		if (!vhci->port_to_device[i])
+			continue;
+		bce_vhci_cmd_port_suspend(&vhci->cq, i);
+	}
+	pr_info("bce_vhci: suspend controller\n");
+	if ((status =3D bce_vhci_cmd_controller_pause(&vhci->cq)))
+		return status;
+
+	bce_vhci_event_queue_pause(&vhci->ev_commands);
+	bce_vhci_event_queue_pause(&vhci->ev_system);
+	bce_vhci_event_queue_pause(&vhci->ev_isochronous);
+	bce_vhci_event_queue_pause(&vhci->ev_interrupt);
+	bce_vhci_event_queue_pause(&vhci->ev_asynchronous);
+	pr_info("bce_vhci: suspend done\n");
+	return 0;
+}
+
+static int bce_vhci_bus_resume(struct usb_hcd *hcd)
+{
+	int i, j;
+	int status;
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	pr_info("bce_vhci: resume started\n");
+
+	bce_vhci_event_queue_resume(&vhci->ev_system);
+	bce_vhci_event_queue_resume(&vhci->ev_isochronous);
+	bce_vhci_event_queue_resume(&vhci->ev_interrupt);
+	bce_vhci_event_queue_resume(&vhci->ev_asynchronous);
+	bce_vhci_event_queue_resume(&vhci->ev_commands);
+
+	pr_info("bce_vhci: resume controller\n");
+	if ((status =3D bce_vhci_cmd_controller_start(&vhci->cq)))
+		return status;
+
+	pr_info("bce_vhci: resume ports\n");
+	for (i =3D 0; i < 16; i++) {
+		if (!vhci->port_to_device[i])
+			continue;
+		bce_vhci_cmd_port_resume(&vhci->cq, i);
+	}
+	pr_info("bce_vhci: resume endpoints\n");
+	for (i =3D 0; i < 16; i++) {
+		if (!vhci->port_to_device[i])
+			continue;
+		for (j =3D 0; j < 32; j++) {
+			if (!(vhci->devices[vhci->port_to_device[i]]->tq_mask & BIT(j)))
+				continue;
+			bce_vhci_transfer_queue_resume(&vhci->devices[vhci->port_to_device[i]]-=
>tq[j],
+					BCE_VHCI_PAUSE_SUSPEND);
+		}
+	}
+
+	pr_info("bce_vhci: resume done\n");
+	return 0;
+}
+
+static int bce_vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_=
t mem_flags)
+{
+	struct bce_vhci_transfer_queue *q =3D urb->ep->hcpriv;
+	pr_debug("bce_vhci_urb_enqueue %i:%x\n", q->dev_addr, urb->ep->desc.bEndp=
ointAddress);
+	if (!q)
+		return -ENOENT;
+	return bce_vhci_urb_create(q, urb);
+}
+
+static int bce_vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int =
status)
+{
+	struct bce_vhci_transfer_queue *q =3D urb->ep->hcpriv;
+	pr_debug("bce_vhci_urb_dequeue %x\n", urb->ep->desc.bEndpointAddress);
+	return bce_vhci_urb_request_cancel(q, urb, status);
+}
+
+static void bce_vhci_endpoint_reset(struct usb_hcd *hcd, struct usb_host_e=
ndpoint *ep)
+{
+	struct bce_vhci_transfer_queue *q =3D ep->hcpriv;
+	pr_debug("bce_vhci_endpoint_reset\n");
+	if (q)
+		bce_vhci_transfer_queue_request_reset(q);
+}
+
+static u8 bce_vhci_endpoint_index(u8 addr)
+{
+	if (addr & 0x80)
+		return (u8) (0x10 + (addr & 0xf));
+	return (u8) (addr & 0xf);
+}
+
+static int bce_vhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *u=
dev, struct usb_host_endpoint *endp)
+{
+	u8 endp_index =3D bce_vhci_endpoint_index(endp->desc.bEndpointAddress);
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	bce_vhci_device_t devid =3D vhci->port_to_device[udev->portnum];
+	struct bce_vhci_device *vdev =3D vhci->devices[devid];
+	pr_debug("bce_vhci_add_endpoint %x/%x:%x\n", udev->portnum, devid, endp_i=
ndex);
+
+	if (udev->bus->root_hub =3D=3D udev) /* The USB hub */
+		return 0;
+	if (vdev =3D=3D NULL)
+		return -ENODEV;
+	if (vdev->tq_mask & BIT(endp_index)) {
+		endp->hcpriv =3D &vdev->tq[endp_index];
+		return 0;
+	}
+
+	bce_vhci_create_transfer_queue(vhci, &vdev->tq[endp_index], endp, devid,
+			usb_endpoint_dir_in(&endp->desc) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	endp->hcpriv =3D &vdev->tq[endp_index];
+	vdev->tq_mask |=3D BIT(endp_index);
+
+	bce_vhci_cmd_endpoint_create(&vhci->cq, devid, &endp->desc);
+	return 0;
+}
+
+static int bce_vhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *=
udev, struct usb_host_endpoint *endp)
+{
+	u8 endp_index =3D bce_vhci_endpoint_index(endp->desc.bEndpointAddress);
+	struct bce_vhci *vhci =3D bce_vhci_from_hcd(hcd);
+	bce_vhci_device_t devid =3D vhci->port_to_device[udev->portnum];
+	struct bce_vhci_transfer_queue *q =3D endp->hcpriv;
+	struct bce_vhci_device *vdev =3D vhci->devices[devid];
+	pr_info("bce_vhci_drop_endpoint %x:%x\n", udev->portnum, endp_index);
+	if (!q) {
+		if (vdev && vdev->tq_mask & BIT(endp_index)) {
+			pr_err("something deleted the hcpriv?\n");
+			q =3D &vdev->tq[endp_index];
+		} else {
+			return 0;
+		}
+	}
+
+	bce_vhci_cmd_endpoint_destroy(&vhci->cq, devid, (u8) (endp->desc.bEndpoin=
tAddress & 0x8Fu));
+	vhci->devices[devid]->tq_mask &=3D ~BIT(endp_index);
+	bce_vhci_destroy_transfer_queue(vhci, q);
+	return 0;
+}
+
+static int bce_vhci_create_message_queues(struct bce_vhci *vhci)
+{
+	if (bce_vhci_message_queue_create(vhci, &vhci->msg_commands, "VHC1HostCom=
mands") ||
+		bce_vhci_message_queue_create(vhci, &vhci->msg_system, "VHC1HostSystemEv=
ents") ||
+		bce_vhci_message_queue_create(vhci, &vhci->msg_isochronous, "VHC1HostIso=
chronousEvents") ||
+		bce_vhci_message_queue_create(vhci, &vhci->msg_interrupt, "VHC1HostInter=
ruptEvents") ||
+		bce_vhci_message_queue_create(vhci, &vhci->msg_asynchronous, "VHC1HostAs=
ynchronousEvents")) {
+		bce_vhci_destroy_message_queues(vhci);
+		return -EINVAL;
+	}
+	spin_lock_init(&vhci->msg_asynchronous_lock);
+	bce_vhci_command_queue_create(&vhci->cq, &vhci->msg_commands);
+	return 0;
+}
+
+static void bce_vhci_destroy_message_queues(struct bce_vhci *vhci)
+{
+	bce_vhci_command_queue_destroy(&vhci->cq);
+	bce_vhci_message_queue_destroy(vhci, &vhci->msg_commands);
+	bce_vhci_message_queue_destroy(vhci, &vhci->msg_system);
+	bce_vhci_message_queue_destroy(vhci, &vhci->msg_isochronous);
+	bce_vhci_message_queue_destroy(vhci, &vhci->msg_interrupt);
+	bce_vhci_message_queue_destroy(vhci, &vhci->msg_asynchronous);
+}
+
+static void bce_vhci_handle_system_event(struct bce_vhci_event_queue *q, s=
truct bce_vhci_message *msg);
+static void bce_vhci_handle_usb_event(struct bce_vhci_event_queue *q, stru=
ct bce_vhci_message *msg);
+
+static int bce_vhci_create_event_queues(struct bce_vhci *vhci)
+{
+	vhci->ev_cq =3D bce_create_cq(vhci->dev, 0x100);
+	if (!vhci->ev_cq)
+		return -EINVAL;
+#define CREATE_EVENT_QUEUE(field, name, cb) bce_vhci_event_queue_create(vh=
ci, &vhci->field, name, cb)
+	if (__bce_vhci_event_queue_create(vhci, &vhci->ev_commands, "VHC1Firmware=
Commands",
+			bce_vhci_firmware_event_completion) ||
+		CREATE_EVENT_QUEUE(ev_system,	   "VHC1FirmwareSystemEvents",	   bce_vhci=
_handle_system_event) ||
+		CREATE_EVENT_QUEUE(ev_isochronous,  "VHC1FirmwareIsochronousEvents",  bc=
e_vhci_handle_usb_event) ||
+		CREATE_EVENT_QUEUE(ev_interrupt,	"VHC1FirmwareInterruptEvents",	bce_vhci=
_handle_usb_event) ||
+		CREATE_EVENT_QUEUE(ev_asynchronous, "VHC1FirmwareAsynchronousEvents", bc=
e_vhci_handle_usb_event)) {
+		bce_vhci_destroy_event_queues(vhci);
+		return -EINVAL;
+	}
+#undef CREATE_EVENT_QUEUE
+	return 0;
+}
+
+static void bce_vhci_destroy_event_queues(struct bce_vhci *vhci)
+{
+	bce_vhci_event_queue_destroy(vhci, &vhci->ev_commands);
+	bce_vhci_event_queue_destroy(vhci, &vhci->ev_system);
+	bce_vhci_event_queue_destroy(vhci, &vhci->ev_isochronous);
+	bce_vhci_event_queue_destroy(vhci, &vhci->ev_interrupt);
+	bce_vhci_event_queue_destroy(vhci, &vhci->ev_asynchronous);
+	if (vhci->ev_cq)
+		bce_destroy_cq(vhci->dev, vhci->ev_cq);
+}
+
+static void bce_vhci_send_fw_event_response(struct bce_vhci *vhci, struct =
bce_vhci_message *req, u16 status)
+{
+	unsigned long timeout =3D 1000;
+	struct bce_vhci_message r =3D *req;
+	r.cmd =3D (u16) (req->cmd | 0x8000u);
+	r.status =3D status;
+	r.param1 =3D req->param1;
+	r.param2 =3D 0;
+
+	if (bce_reserve_submission(vhci->msg_system.sq, &timeout)) {
+		pr_err("bce-vhci: Cannot reserve submision for FW event reply\n");
+		return;
+	}
+	bce_vhci_message_queue_write(&vhci->msg_system, &r);
+}
+
+static int bce_vhci_handle_firmware_event(struct bce_vhci *vhci, struct bc=
e_vhci_message *msg)
+{
+	unsigned long flags;
+	bce_vhci_device_t devid;
+	u8 endp;
+	struct bce_vhci_device *dev;
+	struct bce_vhci_transfer_queue *tq;
+	if (msg->cmd =3D=3D BCE_VHCI_CMD_ENDPOINT_REQUEST_STATE || msg->cmd =3D=
=3D BCE_VHCI_CMD_ENDPOINT_SET_STATE) {
+		devid =3D (bce_vhci_device_t) (msg->param1 & 0xff);
+		endp =3D bce_vhci_endpoint_index((u8) ((msg->param1 >> 8) & 0xff));
+		dev =3D vhci->devices[devid];
+		if (!dev || !(dev->tq_mask & BIT(endp)))
+			return BCE_VHCI_BAD_ARGUMENT;
+		tq =3D &dev->tq[endp];
+	}
+
+	if (msg->cmd =3D=3D BCE_VHCI_CMD_ENDPOINT_REQUEST_STATE) {
+		if (msg->param2 =3D=3D BCE_VHCI_ENDPOINT_ACTIVE) {
+			bce_vhci_transfer_queue_resume(tq, BCE_VHCI_PAUSE_FIRMWARE);
+			return BCE_VHCI_SUCCESS;
+		} else if (msg->param2 =3D=3D BCE_VHCI_ENDPOINT_PAUSED) {
+			bce_vhci_transfer_queue_pause(tq, BCE_VHCI_PAUSE_FIRMWARE);
+			return BCE_VHCI_SUCCESS;
+		}
+		return BCE_VHCI_BAD_ARGUMENT;
+	} else if (msg->cmd =3D=3D BCE_VHCI_CMD_ENDPOINT_SET_STATE) {
+		if (msg->param2 =3D=3D BCE_VHCI_ENDPOINT_STALLED) {
+			tq->state =3D msg->param2;
+			spin_lock_irqsave(&tq->urb_lock, flags);
+			tq->stalled =3D true;
+			spin_unlock_irqrestore(&tq->urb_lock, flags);
+			return BCE_VHCI_SUCCESS;
+		}
+		return BCE_VHCI_BAD_ARGUMENT;
+	}
+	pr_warn("bce-vhci: Unhandled firmware event: %x s=3D%x p1=3D%x p2=3D%llx\=
n",
+			msg->cmd, msg->status, msg->param1, msg->param2);
+	return BCE_VHCI_BAD_ARGUMENT;
+}
+
+static void bce_vhci_handle_firmware_events_w(struct work_struct *ws)
+{
+	size_t cnt =3D 0;
+	int result;
+	struct bce_vhci *vhci =3D container_of(ws, struct bce_vhci, w_fw_events);
+	struct bce_queue_sq *sq =3D vhci->ev_commands.sq;
+	struct bce_sq_completion_data *cq;
+	struct bce_vhci_message *msg, *msg2 =3D NULL;
+
+	while (true) {
+		if (msg2) {
+			msg =3D msg2;
+			msg2 =3D NULL;
+		} else if ((cq =3D bce_next_completion(sq))) {
+			if (cq->status =3D=3D BCE_COMPLETION_ABORTED) {
+				bce_notify_submission_complete(sq);
+				continue;
+			}
+			msg =3D &vhci->ev_commands.data[sq->head];
+		} else {
+			break;
+		}
+
+		pr_debug("bce-vhci: Got fw event: %x s=3D%x p1=3D%x p2=3D%llx\n", msg->c=
md, msg->status, msg->param1, msg->param2);
+		if ((cq =3D bce_next_completion(sq))) {
+			msg2 =3D &vhci->ev_commands.data[(sq->head + 1) % sq->el_count];
+			pr_debug("bce-vhci: Got second fw event: %x s=3D%x p1=3D%x p2=3D%llx\n"=
,
+					msg->cmd, msg->status, msg->param1, msg->param2);
+			if (cq->status !=3D BCE_COMPLETION_ABORTED &&
+				msg2->cmd =3D=3D (msg->cmd | 0x4000) && msg2->param1 =3D=3D msg->param=
1) {
+				/* Take two elements */
+				pr_debug("bce-vhci: Cancelled\n");
+				bce_vhci_send_fw_event_response(vhci, msg, BCE_VHCI_ABORT);
+
+				bce_notify_submission_complete(sq);
+				bce_notify_submission_complete(sq);
+				msg2 =3D NULL;
+				cnt +=3D 2;
+				continue;
+			}
+
+			pr_warn("bce-vhci: Handle fw event - unexpected cancellation\n");
+		}
+
+		result =3D bce_vhci_handle_firmware_event(vhci, msg);
+		bce_vhci_send_fw_event_response(vhci, msg, (u16) result);
+
+
+		bce_notify_submission_complete(sq);
+		++cnt;
+	}
+	bce_vhci_event_queue_submit_pending(&vhci->ev_commands, cnt);
+	if (atomic_read(&sq->available_commands) =3D=3D sq->el_count - 1) {
+		pr_debug("bce-vhci: complete\n");
+		complete(&vhci->ev_commands.queue_empty_completion);
+	}
+}
+
+static void bce_vhci_firmware_event_completion(struct bce_queue_sq *sq)
+{
+	struct bce_vhci_event_queue *q =3D sq->userdata;
+	queue_work(q->vhci->tq_state_wq, &q->vhci->w_fw_events);
+}
+
+static void bce_vhci_handle_system_event(struct bce_vhci_event_queue *q, s=
truct bce_vhci_message *msg)
+{
+	if (msg->cmd & 0x8000) {
+		bce_vhci_command_queue_deliver_completion(&q->vhci->cq, msg);
+	} else {
+		pr_warn("bce-vhci: Unhandled system event: %x s=3D%x p1=3D%x p2=3D%llx\n=
",
+				msg->cmd, msg->status, msg->param1, msg->param2);
+	}
+}
+
+static void bce_vhci_handle_usb_event(struct bce_vhci_event_queue *q, stru=
ct bce_vhci_message *msg)
+{
+	bce_vhci_device_t devid;
+	u8 endp;
+	struct bce_vhci_device *dev;
+	if (msg->cmd & 0x8000) {
+		bce_vhci_command_queue_deliver_completion(&q->vhci->cq, msg);
+	} else if (msg->cmd =3D=3D BCE_VHCI_CMD_TRANSFER_REQUEST || msg->cmd =3D=
=3D BCE_VHCI_CMD_CONTROL_TRANSFER_STATUS) {
+		devid =3D (bce_vhci_device_t) (msg->param1 & 0xff);
+		endp =3D bce_vhci_endpoint_index((u8) ((msg->param1 >> 8) & 0xff));
+		dev =3D q->vhci->devices[devid];
+		if (!dev || (dev->tq_mask & BIT(endp)) =3D=3D 0) {
+			pr_err("bce-vhci: Didn't find destination for transfer queue event\n");
+			return;
+		}
+		bce_vhci_transfer_queue_event(&dev->tq[endp], msg);
+	} else {
+		pr_warn("bce-vhci: Unhandled USB event: %x s=3D%x p1=3D%x p2=3D%llx\n",
+				msg->cmd, msg->status, msg->param1, msg->param2);
+	}
+}
+
+static const struct hc_driver bce_vhci_driver =3D {
+		.description =3D "bce-vhci",
+		.product_desc =3D "BCE VHCI Host Controller",
+		.hcd_priv_size =3D sizeof(struct bce_vhci *),
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
+		.flags =3D HCD_USB2,
+#else
+		.flags =3D HCD_USB2 | HCD_DMA,
+#endif
+
+		.start =3D bce_vhci_start,
+		.stop =3D bce_vhci_stop,
+		.hub_status_data =3D bce_vhci_hub_status_data,
+		.hub_control =3D bce_vhci_hub_control,
+		.urb_enqueue =3D bce_vhci_urb_enqueue,
+		.urb_dequeue =3D bce_vhci_urb_dequeue,
+		.enable_device =3D bce_vhci_enable_device,
+		.free_dev =3D bce_vhci_free_device,
+		.address_device =3D bce_vhci_address_device,
+		.add_endpoint =3D bce_vhci_add_endpoint,
+		.drop_endpoint =3D bce_vhci_drop_endpoint,
+		.endpoint_reset =3D bce_vhci_endpoint_reset,
+		.check_bandwidth =3D bce_vhci_check_bandwidth,
+		.get_frame_number =3D bce_vhci_get_frame_number,
+		.bus_suspend =3D bce_vhci_bus_suspend,
+		.bus_resume =3D bce_vhci_bus_resume
+};
+
+
+int __init bce_vhci_module_init(void)
+{
+	int result;
+	if ((result =3D alloc_chrdev_region(&bce_vhci_chrdev, 0, 1, "bce-vhci")))
+		goto fail_chrdev;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,4,0)
+	bce_vhci_class =3D class_create(THIS_MODULE, "bce-vhci");
+#else
+	bce_vhci_class =3D class_create("bce-vhci");
+#endif
+	if (IS_ERR(bce_vhci_class)) {
+		result =3D PTR_ERR(bce_vhci_class);
+		goto fail_class;
+	}
+	return 0;
+
+fail_class:
+	class_destroy(bce_vhci_class);
+fail_chrdev:
+	unregister_chrdev_region(bce_vhci_chrdev, 1);
+	if (!result)
+		result =3D -EINVAL;
+	return result;
+}
+void __exit bce_vhci_module_exit(void)
+{
+	class_destroy(bce_vhci_class);
+	unregister_chrdev_region(bce_vhci_chrdev, 1);
+}
+
+module_param_named(vhci_port_mask, bce_vhci_port_mask, ushort, 0444);
+MODULE_PARM_DESC(vhci_port_mask, "Specifies which VHCI ports are enabled")=
;
+
diff --git a/drivers/staging/apple-bce/vhci/vhci.h b/drivers/staging/apple-=
bce/vhci/vhci.h
new file mode 100644
index 000000000..d4ded905b
--- /dev/null
+++ b/drivers/staging/apple-bce/vhci/vhci.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef BCE_VHCI_H
+#define BCE_VHCI_H
+
+#include "queue.h"
+#include "transfer.h"
+
+struct usb_hcd;
+struct bce_queue_cq;
+
+struct bce_vhci_device {
+	struct bce_vhci_transfer_queue tq[32];
+	u32 tq_mask;
+};
+struct bce_vhci {
+	struct apple_bce_device *dev;
+	dev_t vdevt;
+	struct device *vdev;
+	struct usb_hcd *hcd;
+	struct spinlock hcd_spinlock;
+	struct bce_vhci_message_queue msg_commands;
+	struct bce_vhci_message_queue msg_system;
+	struct bce_vhci_message_queue msg_isochronous;
+	struct bce_vhci_message_queue msg_interrupt;
+	struct bce_vhci_message_queue msg_asynchronous;
+	struct spinlock msg_asynchronous_lock;
+	struct bce_vhci_command_queue cq;
+	struct bce_queue_cq *ev_cq;
+	struct bce_vhci_event_queue ev_commands;
+	struct bce_vhci_event_queue ev_system;
+	struct bce_vhci_event_queue ev_isochronous;
+	struct bce_vhci_event_queue ev_interrupt;
+	struct bce_vhci_event_queue ev_asynchronous;
+	u16 port_mask;
+	u8 port_count;
+	u16 port_power_mask;
+	bce_vhci_device_t port_to_device[16];
+	struct bce_vhci_device *devices[16];
+	struct workqueue_struct *tq_state_wq;
+	struct work_struct w_fw_events;
+};
+
+int __init bce_vhci_module_init(void);
+void __exit bce_vhci_module_exit(void);
+
+int bce_vhci_create(struct apple_bce_device *dev, struct bce_vhci *vhci);
+void bce_vhci_destroy(struct bce_vhci *vhci);
+int bce_vhci_start(struct usb_hcd *hcd);
+void bce_vhci_stop(struct usb_hcd *hcd);
+
+struct bce_vhci *bce_vhci_from_hcd(struct usb_hcd *hcd);
+
+#endif //BCE_VHCI_H
+
--=20
2.43.0


