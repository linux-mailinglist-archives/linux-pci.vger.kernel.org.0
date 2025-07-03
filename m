Return-Path: <linux-pci+bounces-31343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD94AF6F45
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 11:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1587AB17E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE22DFF17;
	Thu,  3 Jul 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SFf2FV+K"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0132E040D;
	Thu,  3 Jul 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536324; cv=fail; b=N3NNHAleF1/72x/MSQEr/DifCmc0Pz2XBqidzxqN1fCaAS4W/BPV75zpVuqASasaLk+3JSFGVMKmkxL6rFuNWQcjQ87S+bo06cIhW7yn36kf1eQmAUFAHrxgJ4glCQrj9+4xNf377gM29j0FjJdIZcWUmL0pq4NrtuI/C5Brq1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536324; c=relaxed/simple;
	bh=y2FbC/1pDaMozH7DaI1rdOrg+XQxGoRH73PMcCSZL/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jec6Ks0CTI9UgBHRc10IxbiNu3aUNyyCETwvmGl2LyGGE7qLnmaBy0oOdiFXekgndT9VVJsGoXON41JdPR9PktsgIY3dbop+TQTV+QGnfxJ/4sisg7iLSexp9utJacARZkw39xX2RrjHLYe0Y6bt+fpQ+9Hzo37Wofd/pi9SHtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SFf2FV+K; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM5XT1EeW7KdgOXIeThhdQzph9Mf7Vx7P0w9kKQ/3+p1qBMN/Db9/Zp2ySciwuU1KUaqakUeUcOHwwhnDmtm8qZ1hoE6+IQTuBiGzo9xcL20G0zHwLlOfD9P2yWAABrmkhW8lDOviSpLRSoYJ10hgqT6zEqtpUB9VzEJsjnXvvA6RUfdgx+ZgX6+whjGIqaveDnjAeVDfOxrqoB2g/tN8duTl16r97/kpXdi3GNqDPsuaOTJyQcyhznv/URZu17NipkYDiAsEfdmvw7EIzc47n7jk1KD+kL+s1rZ7ytpp2iLPnp/pUYCeoYqZTC342stddz+n0P0lzH5OpFrb5CrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t/0nEM02SmrasMEn97Cr7aqfliXjhw2OVkBiG0qUlM=;
 b=WPHrV0UXxT7vTWbs2GRyzTEzGmkjiInf1uylrbHitqyaLPOffXO5qq3cOEyCsBIlw4haFO0aktQRtmC3h7dauHI19Ir7UDoyhks3X6MBRxn+NbDkGKESnpGJTViClcxionyJwr3S/qUabzfyzNyNhoYD5vs2H6KTVneOV3pDo8Z0ma1U3VU1wRprpci8wn3Eumtq9OyxnZZgiFnAGJ6bCKS7rqppjLEmqU4UgJl0daCTIn+3zgQCPqfUguCsWSdsBLJRanRT+/YFjm82r8bAnqfhPlTw5yjvp5nYTA5nt+n3SHW4NCBDQSQEGTt7ybc/JXnlbG/IIvgGkI7i2Yw9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t/0nEM02SmrasMEn97Cr7aqfliXjhw2OVkBiG0qUlM=;
 b=SFf2FV+K/lDAv+gVpSoZDFV8K2sLxbNauCE0n4Z1qJ+7rwxMpp0f7uG6WsqqnunMLLd5oKVqQWjEcBp+qNv78KYEf8w8ynoVN8Xt0M9cia4zol0XnIUw/rNGRtWmVQZBzUN2rpbtj+4Ez5sGkuLCOvCShEuJsA5OT+IZuoppOn8gTDqxxtpPkIHyyAi3WXENC4AmyXA2vQJm5jQWvRgy1ao3KCLwc/IEbKaXQaWyCTb1yWrWbzZgnIbot3hnYYi7EqEqOcSAauyVPou/UCzWsTuvylpqsTB8Q3zDDWbQoPcpnqGLbfFYpw8VtQY2OSW+ex7a1943d4EL5C7biC1XAg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 09:51:58 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 09:51:58 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH RFC v3] pci: report surprise removal event
Thread-Topic: [PATCH RFC v3] pci: report surprise removal event
Thread-Index: AQHb63Ya2qJTaIlBG0ygpVTJgWwo57Qf1MEggAAafYCAADiEgA==
Date: Thu, 3 Jul 2025 09:51:57 +0000
Message-ID:
 <CY8PR12MB719536EDBEDCEA5866F37037DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
 <20250702132314-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250703022224-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250703022224-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MW6PR12MB8867:EE_
x-ms-office365-filtering-correlation-id: c3b6845d-b922-46d0-f05b-08ddba174038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v+3MM5Fcq+o0sYwiBIk5z5/SCW1S2+GPMZfbQmhWiu3939jA06gLG3hpCly1?=
 =?us-ascii?Q?OikA+v/Cz2xXikZmsfexpudyhc/3v9XAqcEOe2TVTWaa1vzCzmkqIfw85JBF?=
 =?us-ascii?Q?Sip7chLhQUgDZTcB6AdKTkQLTj7zmYRd0mOXtWx3rLk+clN9HQwdDKE0/r82?=
 =?us-ascii?Q?U7iLvSjyLvVH1Q2SXMUm9Vpp4CnXWyqnCzle7y8OTX9kEXQPdbjEEQ2Ibkfm?=
 =?us-ascii?Q?Qy164Pqm3jRHnk8Tf3Yq6Ch9QM7NFfQIEAwWXopqP68DMmO8IKrqHDvdM4lc?=
 =?us-ascii?Q?+YekihOIqob85VJEhz6VK2cp+JUbHwgBPydMkf1r33fbahJYdkkVOiAufB/G?=
 =?us-ascii?Q?5QlGfL7FvOZao8bnmWxX+yVTlMdsq07cHQ3cDbh4diIoYvUjznSPchMtW5UJ?=
 =?us-ascii?Q?XkF4cOjw9psklF5pgxPQIF3IToEAswwnmAXPim/KT4NcEGc2opDmM0JuGY1t?=
 =?us-ascii?Q?CPUbGkxc3DXb/pzB+C8bn0nealztcCymMOXC78GI71q/yJm21ihXyTwkVZux?=
 =?us-ascii?Q?KrCbXMVUt1joDkTFTD09Dnshej6V2bfgOpMQw/NiOtApycp1wfRMuCNaAe3v?=
 =?us-ascii?Q?cQmlaRCoPv6Y3zV1oWvWMmXeV1OzxAY7LknPAaZEpWy2uL2QraBGXGzscK0Y?=
 =?us-ascii?Q?rhAuIff4vgQRymWB2j4YYfZEmH2KfZsIsxuLGDnH1NcSnXgZLqbQq6N6YjCA?=
 =?us-ascii?Q?kEArfju4f6UVo6w1ZGX4RvjZYGmNa9zHLNwLq2ORH3WX+QFhvZE1G5Oieoaf?=
 =?us-ascii?Q?P8/agtGhYrjIBw/wE5K3XefGXPVlpWwx0leTIdOBkj4OOndhhfYMVCpCRW1H?=
 =?us-ascii?Q?r1UARN+h+Ai6lFavIgCPKaO2hnYKt7HDRN/HEtQvj3DYoQuYD+IULBJ+Hivi?=
 =?us-ascii?Q?G/V+Ao5wfDaRiSkMMZnwyxJkmVMUT8xtPFhmD9O4E84qWn3aqer7Y4LOsXa1?=
 =?us-ascii?Q?u3beeqJiL9QbQK3OP8NF5cC6lG/lLob4nPdhnJUtwvUMwI41/2qT303UdHGe?=
 =?us-ascii?Q?qpG9qZoe5GBqWoQGdP2QiBLzCepq33ERkmXU1wRjx2uKCvrN18aoDRRtfkbO?=
 =?us-ascii?Q?Dge9nXqw1ydFm+McfPCDaKDpFfe1DzM/lWr71/YW+J2ZgSmmMOAr9rRprVMA?=
 =?us-ascii?Q?HF3x6yFtR5zsoEmDiVMabsMg/a7fEIka810Y6Cyv0+7DzGV5fhJ+m7jxxDUz?=
 =?us-ascii?Q?6p99KJlUc6l7JRRZWhv1mq0UKedCk6THDCUdQSC4yo1WhddU+QUFVmqNGtr5?=
 =?us-ascii?Q?5jlgMklWXus+GgVeqzFwet2Tcw+o4FHFtRgeKQZzDzSeXeAw3fjovwRuH1mA?=
 =?us-ascii?Q?1RHyH2Wa8Vs4D/h1bAFkFdVnOmOw/sw0Z8kPsBFV/dNPz9/H9ws/jhCT+F5B?=
 =?us-ascii?Q?nE53/iPy63kpBnOszcGh9tCU2V4pf9Nr09oSNsLhIBsl2iD0nNo8KFCE8ldL?=
 =?us-ascii?Q?lviIuuFh9V1/hHMVSMY9aR5Cdl8B1VT2Ku1lfiONBUr48TlY34r9+0nIAXci?=
 =?us-ascii?Q?1gwe0VE9X6s9ub8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wJcdAqOcG1Be5CYvTh8g8DANCdzvr5jT0i+/nUcgpAGO6DpEqTT8nKjDvNkP?=
 =?us-ascii?Q?9nDR18yvN26W/1H4Z7foFHQd6r74wnynW/iYUPtUcm0ZP0X+tXGmsJmrLBzJ?=
 =?us-ascii?Q?AGYIed4Um54ooPF4/4jipDIPympnJ5kjWI1rqRNqyUxtzxOrHMHBv6CPF7Nk?=
 =?us-ascii?Q?+8bCbQwpzSF7cBNrVvKlvqSXmxQh2swRMaMzEB+SkHuDeJILguUqsn4obmrq?=
 =?us-ascii?Q?lzTxK9rm3y+5qomYHHxOuopZvRvYPqiPJ7RxV3GOd8l107F49GjzyQEDg3nv?=
 =?us-ascii?Q?yorS1rYgfawsKPpJT2N6e55hRrvFDj4Qor9UBlGjRakxGAoRKzrdXvs4NFiy?=
 =?us-ascii?Q?jwkQfk9c+0wK80t8Yx2KxfrO5VOqZbThkvHj66kViwUpZr1dmgq++fiCrjwV?=
 =?us-ascii?Q?QYY6BXGi5Uoi+03ILslCsGVNARe01ZdL/DUF0IpS4uH/Xk9dj6OMts5AzN8y?=
 =?us-ascii?Q?w9qmkNbN5iqcC0DItGsNjxOCnA/JmNpVzMXO9mx7Ho3kPWr2AXxJTPtuirfK?=
 =?us-ascii?Q?98qsNiGwgECP+NAzcapRTf0p/no+928aZmP1VQDxW6RNG+e+R27+/lXFY3mL?=
 =?us-ascii?Q?X/rwZKbcf2R8nrXuqNsJomy8okmrqyw9Mixl7J3ANrf2/zlvuy1K0Jw5IGUy?=
 =?us-ascii?Q?Qqrqn5ZDBCY8BibZE2qxJhdJnjGUfQ6dzoxSHBcnCvhhllkI2NZyySer7djf?=
 =?us-ascii?Q?1RbrMgCFPvNHKVbzw8iAbC3GUfGR3gU0G60Cj8+pVReLW+rXYg1HRzVSU1QQ?=
 =?us-ascii?Q?cDhaMT1NCH+akStdSbHTDs213gWts1LuDluHBNR+30Md7pH+PAH0pZmvJqYg?=
 =?us-ascii?Q?RstaERx7NiQ//4E+Am6WetiL1MU0c7WCKiinDRWU4J0HP34ve4+vY3Velmoc?=
 =?us-ascii?Q?C0n4h8sB+mVzAsbV6WTvZLcTVP+4LgZ2De61F2J0iv4s0FGxjlFXKlUfBnTL?=
 =?us-ascii?Q?maAlVbXFddzppsnUmAyWeBdkVodMAAMyRadXnih0aDJaYTXtqjeAG/SEnFdA?=
 =?us-ascii?Q?/3twESm5FSNy2/9PtxiF+YUL6X/Jzmxak9Cu8IRzavhvIn8amAVbyJ/N3/an?=
 =?us-ascii?Q?Ho6wzAfKolNcXb29RdX3cfXw9pd65h/U/0jB75xuSB30IFrO7/UWKS78GmDm?=
 =?us-ascii?Q?0f4LBgvQuNs32OBeHeUcMBbNq14A0+lzpK10bWwE430deb8TaitdJWaXp4TJ?=
 =?us-ascii?Q?sCSwgmjiy/6LpvX08v7RwkZrIJKzUwz+/RWF5hfV3v0cvvqMQ+TKdVRWtHXH?=
 =?us-ascii?Q?dz1UbsORqUee26ZYtVr0oaUlzL5Lid/WVf4HBaOZ6m7hH6sqBtZrP9fWfRM5?=
 =?us-ascii?Q?aJAkMpCI4RjnsrYrTLdV/wRDmzXF/xm9ikD7ugD2PbzBk/6hnb4mwkqqS+Pz?=
 =?us-ascii?Q?pw+kwexgKNHETBo2pNDm3zBDh0wauiDs9YGO4CJdI8rknH8L4BhWX//GHJwl?=
 =?us-ascii?Q?ORQKKzHxfRqwGv0TqFXnnQa4EJIapEbX/YhlhmtIvRIOeIhEPiJCrQVZT9pK?=
 =?us-ascii?Q?t9N24mN1H/gyjYbTkLRXhbws73Aw1vmcyNrxXyLhKai/hqcHWzSnZ2rck4ZJ?=
 =?us-ascii?Q?PUgRbRLCN+Rzt6tjMJmI97QEw8o6tvgsQdzXTwap2VY4SMdREGG1ILKrxfaF?=
 =?us-ascii?Q?6n8hsWtNqlpKtJqlHxice6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b6845d-b922-46d0-f05b-08ddba174038
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 09:51:57.9996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6I1rY/jLJ18MUeSMUsQueJHAYL65dRQU5XqwVI/i4rjTWG6HU4O6AcFUCcw1MqFNJR0dZZoCOYa9b1aTji7GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 03 July 2025 11:54 AM
>=20
> On Thu, Jul 03, 2025 at 05:02:13AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 02 July 2025 10:54 PM
> > >
> > > On Wed, Jul 02, 2025 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > > > At the moment, in case of a surprise removal, the regular remove
> > > > callback is invoked, exclusively.  This works well, because
> > > > mostly, the cleanup would be the same.
> > > >
> > > > However, there's a race: imagine device removal was initiated by a
> > > > user action, such as driver unbind, and it in turn initiated some
> > > > cleanup and is now waiting for an interrupt from the device. If
> > > > the device is now surprise-removed, that never arrives and the
> > > > remove callback hangs forever.
> > > >
> > > > For example, this was reported for virtio-blk:
> > > >
> > > > 	1. the graceful removal is ongoing in the remove() callback, where
> disk
> > > > 	   deletion del_gendisk() is ongoing, which waits for the requests=
 +to
> > > > 	   complete,
> > > >
> > > > 	2. Now few requests are yet to complete, and surprise removal
> started.
> > > >
> > > > 	At this point, virtio block driver will not get notified by the dr=
iver
> > > > 	core layer, because it is likely serializing remove() happening by
> > > > 	+user/driver unload and PCI hotplug driver-initiated device remova=
l.
> > > So
> > > > 	vblk driver doesn't know that device is removed, block layer is wa=
iting
> > > > 	for requests completions to arrive which it never gets.  So
> > > > 	del_gendisk() gets stuck.
> > > >
> > > > Drivers can artificially add timeouts to handle that, but it can
> > > > be flaky.
> > > >
> > > > Instead, let's add a way for the driver to be notified about the
> > > > disconnect. It can then do any necessary cleanup, knowing that the
> > > > device is inactive.
> > > >
> > > > Since cleanups can take a long time, this takes an approach of a
> > > > work struct that the driver initiates and enables on probe, and
> > > > tears down on remove.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >
> > >
> > > Parav what do you think of this patch?
> > The async notification part without holding the device lock is good par=
t of
> this patch.
> >
> > However, large part of the systems and use cases does not involve pci h=
ot
> plug removal.
> > An average system that I came across using has 150+ pci devices, and no=
ne
> of them uses hotplug.
> >
> > So increasing pci dev struct for rare hot unplug, that too for the race
> condition does not look the best option.
> >
> > I believe the intent of async notification without device lock can be a=
chieved
> by adding a non-blocking async notifier callback.
> > This can go in the pci ops struct.
> >
> > Such callback scale far better being part of the ops struct instead of =
pci_dev
> struct.
>=20
> Sorry, I don't see a way to achieve that, as the driver can go away while
> hotunplug happens.
>=20
Well without device lock, driver can go away anyway.
In other words when schedule_work() is called by the core in this patch, wh=
at prevents driver to not get unloaded?

May be driver refcount can be taken conditionally before invoking the callb=
ack?

> You would be welcome to try but you mentioned you have no plans to do so.
>=20
As I explained you can see that the support is needed at multiple modules.
Presently I couldn't spend cycles on this corner case race condition.
IMHO, if we want to fix, first fix should be for the most common case condi=
tion, for which the proposed fix exists.

Followed by that your second patch of device reset should also be done.

Next should be corner case fix that possibly nvme can benefit too.=20

But if you have better ideas, should be fine too.

>=20
> > > This you can try using this in virtio blk to address the hang you
> > > reported?
> > >
> > The hang I reported was not the race condition between remove() and
> hotunplug during remove.
> > It was the simple remove() as hot-unplug issue due to commit
> 43bb40c5b926.
> >
> > The race condition hang is hard to reproduce as_is.
> > I can try to reproduce by adding extra sleep() etc code in remove() wit=
h v4
> of this version with ops callback.
> >
> > However, that requires lot more code to be developed on top of current
> proposed fix [1].
> >
> > [1] https://lore.kernel.org/linux-block/20250624185622.GB5519@fedora/
> >
> > I need to re-arrange the hardware with hotplug resources. Will try to
> arrange on v4.
> >
> > > > Compile tested only.
> > > >
> > > > Note: this minimizes core code. I considered a more elaborate API
> > > > that would be easier to use, but decided to be conservative until
> > > > there are multiple users.
> > > >
> > > > changes from v2
> > > > 	v2 was corrupted, fat fingers :(
> > > >
> > > > changes from v1:
> > > >         switched to a WQ, with APIs to enable/disable
> > > >         added motivation
> > > >
> > > >
> > > >  drivers/pci/pci.h   |  6 ++++++
> > > >  include/linux/pci.h | 27 +++++++++++++++++++++++++++
> > > >  2 files changed, 33 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > > > b81e99cd4b62..208b4cab534b 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -549,6 +549,12 @@ static inline int
> > > > pci_dev_set_disconnected(struct
> > > pci_dev *dev, void *unused)
> > > >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> > > >  	pci_doe_disconnected(dev);
> > > >
> > > > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > > > +		/* Make sure work is up to date. */
> > > > +		smp_rmb();
> > > > +		schedule_work(&dev->disconnect_work);
> > > > +	}
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > > 51e2bd6405cd..b2168c5d0679 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -550,6 +550,10 @@ struct pci_dev {
> > > >  	/* These methods index pci_reset_fn_methods[] */
> > > >  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order
> */
> > > >
> > > > +	/* Report disconnect events */
> > > > +	u8 disconnect_work_enable;
> > > > +	struct work_struct disconnect_work;
> > > > +
> >
> > > >  #ifdef CONFIG_PCIE_TPH
> > > >  	u16		tph_cap;	/* TPH capability offset */
> > > >  	u8		tph_mode;	/* TPH mode */
> > > > @@ -2657,6 +2661,29 @@ static inline bool
> > > > pci_is_dev_assigned(struct
> > > pci_dev *pdev)
> > > >  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) =3D=3D
> > > > PCI_DEV_FLAGS_ASSIGNED;  }
> > > >
> > > > +/*
> > > > + * Caller must initialize @pdev->disconnect_work before invoking t=
his.
> > > > + * Caller also must check pci_device_is_present afterwards, since
> > > > + * if device is already gone when this is called, work will not ru=
n.
> > > > + */
> > > > +static inline void pci_set_disconnect_work(struct pci_dev *pdev) {
> > > > +	/* Make sure WQ has been initialized already */
> > > > +	smp_wmb();
> > > > +
> > > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1); }
> > > > +
> > > > +static inline void pci_clear_disconnect_work(struct pci_dev *pdev)=
 {
> > > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> > > > +
> > > > +	/* Make sure to stop using work from now on. */
> > > > +	smp_wmb();
> > > > +
> > > > +	cancel_work_sync(&pdev->disconnect_work);
> > > > +}
> > > > +
> > > >  /**
> > > >   * pci_ari_enabled - query ARI forwarding status
> > > >   * @bus: the PCI bus
> > > > --
> > > > MST


