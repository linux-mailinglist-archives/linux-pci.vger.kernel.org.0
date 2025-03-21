Return-Path: <linux-pci+bounces-24338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5641A6BAD8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DC318937F0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980E226CF8;
	Fri, 21 Mar 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UI8J5aiW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D1226545;
	Fri, 21 Mar 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560778; cv=fail; b=U1nYT8yJ57XxM/afnO4jZ8ErsV7M6RjkqGvwFn74rQ/AmJZ4YaofXq+ibYipX8Y6TcNpCB811YD6wObXk+vBZnPtXRD89QM0YWekF8LGrIMVEh+XYWUEkEJRkcgVBihfiFurMmTkMJWTBVYo/AtOdnYSZ6qXqRqBAYsFlHCr5Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560778; c=relaxed/simple;
	bh=5WP/Y5hiNzoPLDcpKfxWmrD0YJHaYI7xvdoLdF1CvFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dcszo3QaJ9dNLM1tTNj6uvvoawQzuiLcp5StiPzU76rkCuCjqAhhAaTmXq5U9kYxgqUdywf38b/tBAvZYBnTK2rxQg8F/frMZWsfXfgarUR0MNuQ0TvjGAyM/8ux37mZUPSyGEW0PQxSNWsoGR6gmzuRPexXRaBidr1oT6ImcO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UI8J5aiW; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRJfmCeN+llv7bQqmlNmqSzCCx1giPt/YlB+yy3vjAW0cgdgMbZJnDGhlec8iFZuIhjxFkHrecDPakZz1Y6hoZUaNs/hdxi+E3AdkxVz+o4HpZYIWlGYTV2hc4atv3n1ZpHpkqnwdmLT7j3xYQd7ijMjjcqhPV+1lsooXsdNbzE/3CnPpgLC8utq6G50aXcYCDoqa+0CBIqH5ofgNf9dyH6s1aJtDf3OHQ/kbPFebJyh3CNigctkUzSt/OtiEdxCf+2mzq4mZsEBTlVEwEJ3ev3F6BX3h1ukribW7UdFr266mWsilfdUQ8AS6nClEr1XnurviIwED5uZI5aseZVKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKlONNFDxdIqE8Ndv1QE2geADDmJ/yVzyqFOJNCFtEM=;
 b=EWx7CH+65EfBRLWNvgzcAZi0BaLygCIrCkkwO8MDRuWMJZ6XfzFGYWIUE6pN6o6hnRVGE60Q49ikTxdOAUOeQJ8YdYuC2qw/DU7S3IuJIcohw6vaWx7pIm4g6Q+WZ/TpuHn3BaWmgTqcXyeZ4Q5/yArrzmRbCK/XVW2zDeO7xtRV7orTmBZOZoAdVPxcVntCoFT4UgKyjw7pBj7LR201hN59Z5liawDaNfJ7ybqd2AF1jeZSxlaXvNYJtgoSmA+f+JNLWx0vOyOI9K7CJsvrvJyEwN8FYeizcMCvTdohI0BLEu6OvRWlyCQIwMft/qwxDPcuRm4OnVhDDU/KBLVaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKlONNFDxdIqE8Ndv1QE2geADDmJ/yVzyqFOJNCFtEM=;
 b=UI8J5aiWtftlE/48mivTUwt1cGIP5DHfsurpVkGJywTIUx+9FcgXCzkkFAjxqkIvX3It3h0E/8EtcE6lK7XnecRrho7GdfVertCFZkn0Fqt48aogkqJAvdnx5IxVcd26lOE7t4LRAr2g1ZTsykZTBAJgRh18itUYJ6RQFtCy0zM=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 12:39:31 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 12:39:30 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Thread-Topic: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Thread-Index: AQHbmlZS72oOjqZzdEGn3rPtbJPMDLN9hxRQ
Date: Fri, 21 Mar 2025 12:39:30 +0000
Message-ID:
 <DM4PR12MB61582AD96A788BD9544D973BCDDB2@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
 <20250321114211.2185782-2-sai.krishna.musham@amd.com>
In-Reply-To: <20250321114211.2185782-2-sai.krishna.musham@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6bdfacac-44f7-49cc-9e28-591ab5d5fd5e;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-21T12:36:33Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|SJ2PR12MB9116:EE_
x-ms-office365-filtering-correlation-id: a6567510-8f7f-4869-367c-08dd68756d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3zCqWN82bPpWjr9eSAnq/C3JnOlP9fkkLElm5db1yNRi0zAsbAMXvycOYm2r?=
 =?us-ascii?Q?ZPG4eeVU/GFkYOtEh+Ik2plu9GjGLCdzkmthkIBFDUQSfklp3OO034WxfxrC?=
 =?us-ascii?Q?v29m0gHNDxBH3IuC1AvGoCqtmIymRQh118mS/wjR+0Z/SY7JRjVkQsXlvE4G?=
 =?us-ascii?Q?oDtQf2NxH+R2rtPCzKwuhoudKXuGzZ5zmOfzsjFHvTRmk8rQeG9JPOwkOjPY?=
 =?us-ascii?Q?fmpV5ORijkbHMO7KBP8Fjfk9H46sbEgnOyESxhljhSHIMODSz/gYU3NnyYco?=
 =?us-ascii?Q?+cBx/SmJ59eAoYTf78L8prvFEQtqtzKtoWm1BXw31jpgxI4ofRShpfcVD19t?=
 =?us-ascii?Q?TTo9abi2anO6RzNDTqzYTMpOwKy2uiF/STRbB/tSOIrqwaj3DCyonwb9TQBq?=
 =?us-ascii?Q?AoInaQvg3bO8IokMYaR+l9OYsqH5RunX8mkOXG97YbXHwU6XEd2hLxQNZ5YJ?=
 =?us-ascii?Q?9pfMZ/pBZ3jdkrgFIsUl/mj2PjgBodizecSXmHOn3CIRJEZI8F4WzQciXDrt?=
 =?us-ascii?Q?Ca986VNYIr16U0+5LyIVSApr+ceLSSVMEPb6P3gRElGG7JZvPx4xvyGvjBaj?=
 =?us-ascii?Q?qRZ8Pb8yWoqAp02C+y+lFY9Ep8yyaFrfiuBFnJapBOTpqT0eqrbS+f0bO7K8?=
 =?us-ascii?Q?SnOPhuA6Ku2myfeZKw1SERlq63/ccXJKqCRR3cmkzqr59cg8hsPXtICUWILs?=
 =?us-ascii?Q?YhjZaT0IoZ/pLp6KF3ZkWYjfCyG9sEgVJwCxVmtec2LXNdR1JQSl2lVwH4v1?=
 =?us-ascii?Q?8BRFoJQkbySTLGECxptEIR9pt4O4VUA3kp6OHKLHwLBiEqeNCe25C9JNXZaQ?=
 =?us-ascii?Q?3Bqe3D0rt+dNwmireO0RJqF1AR6ItYXABK8CMlFtqie/qD0Xc68EtClzxJaT?=
 =?us-ascii?Q?t8x5eO63lKndTKl3otE8GGYf+HYWMQCb1SAXvG4vHxHHPj2ZtSASXQ+J+l05?=
 =?us-ascii?Q?7bV7gDuVtn63CwbxXbQGnbgPuiiHm9JE4inWO5lTVuuOREwto+h3VJivOZkh?=
 =?us-ascii?Q?a4Af0zbe0nyHYz8mO1MqOog3YRLlXfgh9nfDfYOBxY2Lo1iHHG7JD9K8P+ra?=
 =?us-ascii?Q?leE6jEMhUFYAD/BA5Qy8fzkc5MBQ1JGgi11bbHWIKGC51Rm1i+RlSvcNMXIt?=
 =?us-ascii?Q?+tgcR7DyhWUtx/2DXHMJ8EhRHOLJgpLhAj5d7s7LnorfjtmG+mC5IujuyxBl?=
 =?us-ascii?Q?yxvuNz9VHB5OT1cCIIlJXUQKcfthpjSwnBHYaUn7R0szcSKUqxcwMV2A8sux?=
 =?us-ascii?Q?7zZNlXO+X/cVBoh86I5SOxKSbwmnKT1Fv0FuHf+OK8xbNQNCZu6tLInVHcvJ?=
 =?us-ascii?Q?RKQs95teY4inUbhU+mQ6G0w1R82qFMCTw6UeEWP8G5XnS09yGqotToS2ekn6?=
 =?us-ascii?Q?qsQcdvrLZ4aBV25OFJmlZxCIzZpVQxElWKJiZK0ix1rwu5QkPedRbvH7GRoX?=
 =?us-ascii?Q?UtQeaSdwCIS+0IY03q/pxXz+R/fCR/00diqZPNMQkddVwW4Sz7pnCw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7XD61ZADw4Ir7BZkdkakGbOjkSTLHYl51FJ1KFAxQAeYmAobIRbVZbXhdHBP?=
 =?us-ascii?Q?cJIREZ0XnTF0Gyl1rPV+VqVkbjTmngLFS1yCJnnhHjhIigsSOfTX+lV6ujM8?=
 =?us-ascii?Q?CrRySHkbso+1y7QWq3VejXhG39Huf4wiwEkIMhHFiBFtA6XLuQ3SW27ci9tb?=
 =?us-ascii?Q?K1CM+NpLlmyRdhiqzpA2SOK+vs0FJ7NNwyzpOxXGY7lVq+5YU+sjH+/HlGO0?=
 =?us-ascii?Q?2O4as3wsNdCZaRoCxMpnwR+KrgdNafZZnE08jEJvqzuFsPKz6Wc0jRnE0SeP?=
 =?us-ascii?Q?dhp/CyaFrhFsd/VSMv+4R7bbJPwiZ4H1Nh80C7fwVbL5QIFFPCk3ftgNDPco?=
 =?us-ascii?Q?jqVUu4n8IKeAwTBkWBQ1Mc5tZnpOCysCcrYUaV76DdtN1j3aeICaYTGGzuzI?=
 =?us-ascii?Q?+zpgDAnRcZlwW80fEFGUDJuNrFrkFFc4vrsvA9QdybbOLQ5ZGpARi+6bWr0N?=
 =?us-ascii?Q?GCG0iNZzyRFCwHRmVCgpclRp0bsRZVhxHsWubJO9r2947ftke5j1y3KK16PI?=
 =?us-ascii?Q?l2KC4oT2FKAX1uFb9Og0Lmn4ZxoNmiZcerihO9q5cdEM3FwI846RQrpCZuAY?=
 =?us-ascii?Q?xAftPBfIT7nTVycmktRLBQ6asEWeqS8naKdk8pUJ1GLb2BsaeOUAXA0Lhbmn?=
 =?us-ascii?Q?MUTIeryPBZb3MMwteCZlP4aHePasO6lOS6vefR9SaC4/HP6E02bU2kWyJlWW?=
 =?us-ascii?Q?Yok+DkNUHYTyuSb9lJWQMTy1BcozKhdgaRvmKMtxonyVR6gfIpRRmUtWKUb8?=
 =?us-ascii?Q?fwaA7jwnONTe0fmqYrNOys5miI85P2QfagkaVFqxB2qKuBv2Ff5MmqYDa+cL?=
 =?us-ascii?Q?yfwgA7//D8cRNy1IgAXUYkOR4MtOEU7ZOZG0kR4ouVCNMDnY88oxoPSuGYtT?=
 =?us-ascii?Q?vyZwAhwlpwS5I0Jp+fGb0efANeZ97KJgDVixogDWU7gsGRaDRqD+GnUK/T6n?=
 =?us-ascii?Q?Zuf7OUaIlFUzzp17ls+Ahkll9i9FbMv718RVy8hq/gedXnq31Ucm+TtFBYJG?=
 =?us-ascii?Q?vY/757lbT15y32FGQ3TcX/9nAkX7zPPaNm5F6eBiKyjimP9J5Mnmmc5MV3bC?=
 =?us-ascii?Q?5VY0XM3fd7nLY/qIjh846Mo/apF/rIAcpr6P/NrHHv8yANkM5dRxiCAGhWR6?=
 =?us-ascii?Q?ZPcFYI7F+Cz7LZm48pkVzlYhF8Xb/rUSmxFd6GhidgJArRSJXXX7KIYBMgaW?=
 =?us-ascii?Q?iexvCNUkj9rxFvjWhAvuEuDj8VSEt35KzwbuO7NcB4keS6HbUB2+lJ3gR44P?=
 =?us-ascii?Q?2XgoWiCfHVUYXmUjrPOfDpy0nmcKjUpU93rTsepxyP/am+r6hPeRUlERhsjc?=
 =?us-ascii?Q?+WNtKspA65neCOt/sfM8FTvQ4gSFGiYMFO9ntgSqydgL75bNEgoGUdO08KBB?=
 =?us-ascii?Q?CgMM0Q7ENf8jDXTk2qaKfZ7ILNrG320NYyVgqiSFWznzQFhCpk1O6NyLgXYP?=
 =?us-ascii?Q?bq9mBBzi0DIuJyH26YjJ6oWcw5VUMq2a+IU7FnB7v/AY2IlnA5r/iLqhhoH/?=
 =?us-ascii?Q?jC5KHXtaSQOakph8al8PSnsjvu5Q8RdVAMNRebO3SAcxR1WZITXOOIDYjaPw?=
 =?us-ascii?Q?Jc1Arv8fMHyrExv6V5Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6567510-8f7f-4869-367c-08dd68756d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 12:39:30.5753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWNj8+0GakxyEagRbZBlZksownD7y0PY5vi6Kei26tfh/uWax945XqRiyGgdd0YTa0CDx6IqRbWXlTO8Rzt4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,
Typo in commit message, corrected here, I will update in v6 patch.
> Add `cpm_crx` property between `cfg` and `cpm_csr` as required. Presence =
of this
> property results in an ABI break.

- Sai Krishna

> -----Original Message-----
> From: Sai Krishna Musham <sai.krishna.musham@amd.com>
> Sent: Friday, March 21, 2025 5:12 PM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; cassel@kernel.org
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>; Musham, Sai Krishna
> <sai.krishna.musham@amd.com>
> Subject: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for=
 PCIe RP
> PERST#
>
> Introduce `reset-gpios` property to enable GPIO-based control of the PCIe=
 RP
> PERST# signal, generating assert and deassert signals.
>
> Traditionally, the reset was managed in hardware and enabled during initi=
alization.
> With this patch set, the reset will be handled by the driver. Consequentl=
y, the `reset-
> gpios` property must be explicitly provided to ensure proper functionalit=
y.
>
> Add CPM clock and reset control registers base (`cpm_crx`) to handle PCIe=
 IP reset
> along with PCIe RP PERST# to avoid Link Training errors.
>
> Add `cpm_crx` property between `cfg` and `cpm_csr` as required. Presence =
of this
> property results in an ABI break.
>
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v5:
> - Remove `reset-gpios` property from required as it is already present
>   in pci-bus-common.yaml
> - Update commit message
> Changes for v4:
> - Add CPM clock and reset control registers base to handle PCIe IP
>   reset.
> - Update commit message.
>
> Changes for v3:
> - None
>
> Changes for v2:
> - Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
> - Update commit message
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml         | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index d674a24c8ccc..293df91d4e74 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -24,15 +24,17 @@ properties:
>      items:
>        - description: CPM system level control and status registers.
>        - description: Configuration space region and bridge registers.
> +      - description: CPM clock and reset control registers.
>        - description: CPM5 control and status registers.
> -    minItems: 2
> +    minItems: 3
>
>    reg-names:
>      items:
>        - const: cpm_slcr
>        - const: cfg
> +      - const: cpm_crx
>        - const: cpm_csr
> -    minItems: 2
> +    minItems: 3
>
>    interrupts:
>      maxItems: 1
> @@ -76,6 +78,7 @@ unevaluatedProperties: false
>
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>
>      versal {
>                 #address-cells =3D <2>;
> @@ -98,8 +101,10 @@ examples:
>                                  <0x43000000 0x80 0x00000000 0x80 0x00000=
000 0x0
> 0x80000000>;
>                         msi-map =3D <0x0 &its_gic 0x0 0x10000>;
>                         reg =3D <0x0 0xfca10000 0x0 0x1000>,
> -                             <0x6 0x00000000 0x0 0x10000000>;
> -                       reg-names =3D "cpm_slcr", "cfg";
> +                             <0x6 0x00000000 0x0 0x10000000>,
> +                             <0x0 0xfca00000 0x0 10000>;
> +                       reg-names =3D "cpm_slcr", "cfg", "cpm_crx";
> +                       reset-gpios =3D <&gpio1 38 GPIO_ACTIVE_LOW>;
>                         pcie_intc_0: interrupt-controller {
>                                 #address-cells =3D <0>;
>                                 #interrupt-cells =3D <1>; @@ -126,8 +131,=
10 @@ examples:
>                         msi-map =3D <0x0 &its_gic 0x0 0x10000>;
>                         reg =3D <0x00 0xfcdd0000 0x00 0x1000>,
>                               <0x06 0x00000000 0x00 0x1000000>,
> +                             <0x00 0xfcdc0000 0x00 0x10000>,
>                               <0x00 0xfce20000 0x00 0x1000000>;
> -                       reg-names =3D "cpm_slcr", "cfg", "cpm_csr";
> +                       reg-names =3D "cpm_slcr", "cfg", "cpm_crx", "cpm_=
csr";
> +                       reset-gpios =3D <&gpio1 38 GPIO_ACTIVE_LOW>;
>
>                         pcie_intc_1: interrupt-controller {
>                                 #address-cells =3D <0>;
> --
> 2.44.1


