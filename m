Return-Path: <linux-pci+bounces-30236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FCAE14E5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B6119E295B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A783227B81;
	Fri, 20 Jun 2025 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="uLpyKgFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341E21FF40
	for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404478; cv=fail; b=O0IbYh5WnudJemzCw2JfZzSG9QpWxj59urLMksf4zIcwKPBybhNg/6ArOtS6ftJ4Jzwh/+5mC4otHcq4eq34OS4ScI7NWx+sVwHQb2FMP+x2e+2PcCTZ6Iy8jHLif5C8SWj3b84cw05/JaYv8se9DY0bNjOi6Paj1Nq+4F9L2Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404478; c=relaxed/simple;
	bh=OcYIVQ7bVrlQL3nrYhC30vvsi8NbPgiavn9qWhf1T8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qdE0wJhVbr+n4QefTVkwK8vbrg3kYjK3un+HZ2Is1HZDkD0pfGVpfIBGV7Jz4PnPoTNZLcbeLYvoOZD6dz1c7awPMunOgzOqZdxFmx7mQ4WKrMREU+OUADxe69M0Jtkw8K9b5lkK4uQP1swUVMcd0tO5PIY3MUppjFW0Ire0sSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=uLpyKgFa; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbJID9y+uufPLv6IRQ9rakvIBr9j3H/KOulfbnb0BQ7ci2hSqKg6mQ4ssRaz/k7zg4J+FlcO7ku+r9rV7cFeCmNAlQ0v9VYlrqxph7lXU4IkfFwn1HraIKOgMDuD4DP4xmv4GTKtUSrKwQTCZxVz4k5zV7q4OqLmkHPG7FM7x6TF0q5u6K8zWvvurW+lJHw1Ei69EJmhC9OZIzTwyI0BXgLe+CUE1Pu6VggAO8d+9VStAQs6uceU8E+pEQ21S/qr730MQoWSU93DUK+kHHA58Kp5LEIQZSbPAvqda2bq6xA2OfpDzqTYuh6T1fNGWrszlk+69gp3fDRKfrICm2hqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+ms+1jIaCChQWM7rWD0vtk2iiIn/am3F7IHiYTLBug=;
 b=dK8HQmd5hwp1Lw//tqkCBGsRqLeoirpbSeOJWF2kWsA/Nqd7qE5XdY5iKocJW3Bi6WfjwSDb3ENAZ4+GdF1zWxpaLUs41Kh+3KMwv9VHU/rOryVOdgLqRHZdBD2/r1p8K6pw4+srh9PSdMioYLn3wWZen2bACyE28EloReqN2uobMBfG41c39ArHEF+7gnXKVIy+Y4Ra81mr5D2KaHhyJ275lvnFGzTlsHUl1z8RYqDVx11/qZCYp0OeyT50vXOXY69vs2DUlAEGpkgaEFB1TN2o711I1wEuVnAD210c4ZVMYHiKo8oQW2nPW1pQuXaBb+aIw3lnd6Xx/ZaGFtdI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+ms+1jIaCChQWM7rWD0vtk2iiIn/am3F7IHiYTLBug=;
 b=uLpyKgFa/zRCb3V0bnJV+kvGy0D0CUdkSIWoQm1b16PFxZQlodELcOr2sTpOzA36waiFyX3bvDhx9XUGrXPS0EUOOBJUfPUBGiK46k4ehf3LZDF0YgnHx9Jbl2PlumKYcg3EL42LAWAw53L/NtSVD8v3bsFU4obCoLrtZjVKFKw76nwyzCom98XXPxfCzCjZNbUDyy2cWEW3gMkYIat28i69OZw9azO9yh75OAo/5+KAisaYXTVdW8bKfTEKktJEkXmrG2CmxobzgSVsFHqcX85hJd3ZrNFQiKzwJYZf0C49k+sBbLMZ/CWVKbbnHe2rwdRN/1nauUF2/gFSfWRbsA==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by VI1PR0701MB6926.eurprd07.prod.outlook.com (2603:10a6:800:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 07:27:54 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%6]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 07:27:53 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [v3 PATCH 1/1] PCI: of: fix non-prefetchable region address range
 check.
Thread-Topic: [v3 PATCH 1/1] PCI: of: fix non-prefetchable region address
 range check.
Thread-Index: AdvgWHetQS3k+LLySu6cizU4UuGBiAAE4Q6AAFIpd1A=
Date: Fri, 20 Jun 2025 07:27:53 +0000
Message-ID:
 <PA4PR07MB883846668B50ECBE3A283087FD7CA@PA4PR07MB8838.eurprd07.prod.outlook.com>
References:
 <PA4PR07MB88380E01F75CBC2209C23CA0FD72A@PA4PR07MB8838.eurprd07.prod.outlook.com>
 <20250618161353.GA1203949@bhelgaas>
In-Reply-To: <20250618161353.GA1203949@bhelgaas>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|VI1PR0701MB6926:EE_
x-ms-office365-filtering-correlation-id: fb59e1f0-2b24-451e-f85d-08ddafcbf881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?62v1hKrwCuOqrHz/JFhh5XliEA057dcRywb2YxWhiTqYECNLYQs1PMykk/w2?=
 =?us-ascii?Q?MBA0/YMs7eJ2TlSJ77CRJND+ZejEyOARtTFAex6Fl3Gggs5DbeAa7meOHAaq?=
 =?us-ascii?Q?kMq/lHn0sF2fL/kAtU/kCe+sDuUHq5aIOdH56qo96by+ntNFB/fkUMGqi7Uj?=
 =?us-ascii?Q?R0nxdyn/iQZBOZp72V2IwTPIis0Sts+S8KddU9TcLxKUSIqMgqYeD52qIaM/?=
 =?us-ascii?Q?jQ+6z2xwRvXkr6AzurBAu5rx6/WbLwZ7yDhS62FFb7W/r2zjNbbHBQBvN4Aw?=
 =?us-ascii?Q?igV2x/a7eq28VuNnpInxBKKkfYWhBm1C8UZMdKivuUs/a9WOHv5b0nF2I0Lf?=
 =?us-ascii?Q?hE/9Fd7Sau3CbupGi8tGExLknogOkP807Hpq2EJD/VdlOvLVzVkxxST1szws?=
 =?us-ascii?Q?LfVH0ge1IMvnZw3M/mR/A8x5oIWw9ZSFBK/izCHsNpuKiizUSCUhpr09cURH?=
 =?us-ascii?Q?zl3eWkexOubl0zomG0tmcTHms0NB24wI4yzNHRpnfQGzUl0ZzTPAIoBpGgZZ?=
 =?us-ascii?Q?bvFufShG5ZvHhj5JUtL6tXmg2H/YBdDUkvdkIUSn5lGPm4AoGMb61HXt9Rs6?=
 =?us-ascii?Q?qgO2e2a+CjnmhA11IBiQzOXKIoM6BdBIgj+MvyaZxRvvdHaZrebPI6DrM4gw?=
 =?us-ascii?Q?dZIEZrnoQjM7KIOT1MYCr/eRCpkde0ggKbP00x15MtpYZxJPG+ZSwmlughmO?=
 =?us-ascii?Q?Ce1iWC2AeRnj1zN9kw+ALcbnXoJU5bmvSoyv/SJZqaNiIonZDyVTu4mMISnH?=
 =?us-ascii?Q?YCYrT489fCad6i8hg5eM96QpfutQeCBUhITBF2ELPAp3dG24cXEBWa/anCwN?=
 =?us-ascii?Q?/13kC+Y1yiL7nOowkS1OQVaLgJyTIrUZnJsksWPMhU8IPu8O3ytVmH6OzWjO?=
 =?us-ascii?Q?F6jDH2qOMoSAJ8wwntQykVsvN4e+NkVd6dHlX6xvnkMrgx27c+jznUSRVRis?=
 =?us-ascii?Q?Z9eY86sbrQTzp2zlHFhRjAEazcgy8ae3UgyNgt89A7YR+pLgTymHa95RZJhi?=
 =?us-ascii?Q?G9jVUtYvjCPJw+Wi3gLCFj5mMRJN/zs2PfkTzlGLwPQ0CDTdHPfpV5fi/fKa?=
 =?us-ascii?Q?iHo5TBTpzGHxD+qdRhk+iI11AAbZew8vJd6N0Tx5Saoqu1ZVo9J0/s40blbA?=
 =?us-ascii?Q?jMnB+gkK0psVfXJ3NDuLCJlBXnGZr+i8HLTTCUC9bZ2VTsbRGXA1F/upmtBr?=
 =?us-ascii?Q?MKHYeaXcRzmSqQHxnqX92gSv5AhI85dTmyuI392MFCE5KPfw3B+EoZsrhTR0?=
 =?us-ascii?Q?XfBhJZ5P/JXE9hNZmOhowsWIjkzGcqg+7QIef1I8UlmiEPbuqYD+QzTixVgH?=
 =?us-ascii?Q?ng79eEBvf3fqj9U6N6azulWQmAghC9igbJWyskmVFSNKOEBUg31E/vGRerDA?=
 =?us-ascii?Q?TyGQqku60dUIP3VyTafI+/9UUj2Xh6BP2YKTZcghz1LX99NkUOzU01VpcRoc?=
 =?us-ascii?Q?WbMWxuoZ7hb5aeGYunswOLAO/emzcTDjIZlorMvh/KduYokKwAFq2lkyBLoe?=
 =?us-ascii?Q?GVLgO+qL/WCJcVQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/6wH8Y1sp2BH08c34eVwz4fKgMPh7Yd9YU8zqqMytsL0QoOBMbGjTnPSaJmk?=
 =?us-ascii?Q?BP1uLDRCWpIPCCEy3FlZudvuI99D6PibrQ+nYz6LZj0v5l7rERAfJ7r0GJKv?=
 =?us-ascii?Q?Ca2UuxZqaV1mYBjnZauOpW7zQ2H16dNdvDJfUsTnKNqYFtZewFUfEumEF+Js?=
 =?us-ascii?Q?ZKLp/oPmFjCh1Qj+I69b7ksR2wOMd0FN8ag45K9y6Zxqj0OLy0xiHi7xu+Kf?=
 =?us-ascii?Q?X8tOUHaP08QS6sAb4rELL7neQ4iD9WWYXFybW+f8eC+EpSHscAWD2h62iZrd?=
 =?us-ascii?Q?rdtXQyc2kBqekv1A4hxJoG42NDbB5Mw6GIU3iB1WB2wmw199FlAkHkeMNmir?=
 =?us-ascii?Q?F2+MSjlChA63iOPAYJwvxoq1FLldU5bvVHheVLqhI5D4oT/lWlETw6fCWUrO?=
 =?us-ascii?Q?M6UfbZtFHI9lLQiM1A3Qm4Xzg/rHQe2Keejx7lx0IOKivm3Up1oYnL+l4u2D?=
 =?us-ascii?Q?tc9YBBqisSuEM5jSBBe+NP5KAyg9f5P6T04QykYELrJtHAvoQOxCh8ODqNRh?=
 =?us-ascii?Q?zznGIk7OK6/yt+fXCCx97l7WwwDh2e+hkmGW5cJepq+P2hNsPkyCPOKeLdB7?=
 =?us-ascii?Q?PaloEkX0jjOSKmjjIrMosz8RCg7ZDYIAH0OYgNQUY77R6gI70/QMmX7iNdZq?=
 =?us-ascii?Q?BToEbJ+jRPP4LNERBe1Wvyh94Z2+6qGg1zmbZiGVnlinPOFfB6+Roy8b5Jhd?=
 =?us-ascii?Q?cZ9eflJluofu/JDRArxQCU5maOUTpxGC6xoZ2dPYKNZcQTRVzV4E7/Vgp3EJ?=
 =?us-ascii?Q?n3wh7kZXPyNv4TRRiPbIj6e7Lf/TMTr5V0F2L1PutB2pgjCnDhF1PcOxePwd?=
 =?us-ascii?Q?PJPkx1MmbIelbWpDU6eIAXHuE7nTX4S4WdHZckHHAyy4XpiB3MXenZKjvEs9?=
 =?us-ascii?Q?qhGiPwrOfSyWqC64P2jH27PMBDUhPnX7C06BmKUuGv+EozJ93S4GGFotgBmB?=
 =?us-ascii?Q?6Wv+fxZmkuZSYFnbXI+nhGo13HByv7iMy+zKtb3/5Og+xlKrtXJfI5wekILl?=
 =?us-ascii?Q?+FFtyTE2UmnXBshOnvM3B5i59CCVQeTmcl66L2D42Ei/2eF9dC0kCbzkmI/i?=
 =?us-ascii?Q?F7tajCEAqb6GXKnbKYiGs5735K42z1D6eGaF2+gVOXb135699z3HipruQmms?=
 =?us-ascii?Q?L7Jjs6vvWTJzP27b2xkpRCAm0Djc9GWHUqtIQfvZ7mvOpJRyYt1WjDJm8bZu?=
 =?us-ascii?Q?OOTMnZbakOpeWt0WrowysGOR2mEZNHAY4coaxl7b5mXU2HpDuGnRs16KbQWv?=
 =?us-ascii?Q?uZ/Z940QZzSE+biyQhpWaeD3z8vPjnrtt3iw7V2tP9vOoKG+H6GgHR+AhSH7?=
 =?us-ascii?Q?0T1PapiV3VCcd5xJ/xwN6U4njPl93GmU6u+dvaPsGS4lKX1CqrHecTMYdh7i?=
 =?us-ascii?Q?TOVJzMRx3mcFU63GgsotP9TdoemX9gHoe+CczJKfKRC7A5PHb3weCPzePda/?=
 =?us-ascii?Q?6BQuDzm1XH8F4VPt0KE5lULMNLcf/iKeOThFQYgwWViJejMr4CaHhdwCqjGi?=
 =?us-ascii?Q?XNaGoHEuWNGCnX6w0cI1ikS2fuqWe2ThLpKGA9TFCHZj3qx4VeVoS5vpVsXc?=
 =?us-ascii?Q?4E0smF7bpXuMITMsLra+jKspj7yfzj83BxBE/f5D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb59e1f0-2b24-451e-f85d-08ddafcbf881
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 07:27:53.8377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqTz+EWXwUKD2lgn7nKhfbmZaS52+R+BqWc+70bo+EDm4xSiew1ypVGnLqw4QFQGG1hzKzwVqM/X+vWgPtLi9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6926

> > +                     if (!(res->flags & IORESOURCE_PREFETCH))
> > +                             if (upper_32_bits(range.pci_addr + range.=
size - 1))
> > +                                     dev_warn(dev, "Memory resource
> > + size exceeds max for 32 bits\n");
>=20
> Seems mostly right to me.  I think we should update the message to talk a=
bout
> the *address* instead of the size, since that's the real problem.  Also w=
ould be
> nice to include the resource (%pR) and the corresponding bus addresses as=
 we
> do in pci_register_host_bridge().
>=20

I agree. I will update the message and send out a new patch for review. Tha=
nks for taking the time to have a look!

Kind regards

Wannes

