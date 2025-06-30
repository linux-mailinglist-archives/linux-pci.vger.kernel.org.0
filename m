Return-Path: <linux-pci+bounces-31081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC6AEDF9D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347643BBC57
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E5286D70;
	Mon, 30 Jun 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O69R+JIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551D125B2;
	Mon, 30 Jun 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291550; cv=fail; b=WZMl3xzETR/tAZe+6sJWN3NkWxbFYkD4rvFORfZSAWYDunFeIHNFDHhmXXMlmq0ISwNHnSPepvbzGzkiOCTIcEYC5fak8+GTyx9OP6P0IKlr/CJP6kApj+cdbFjqIoRHEtRssH2laYLG731IoT73WCxpwSNHLsrb1EU2q7UEug0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291550; c=relaxed/simple;
	bh=6H8c4qw82cAUBxTJXMpgT/vF/7pq9p09OdmGYx1h4NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfuY3GSBfCYEZVzua/9oDPUx/RkAerZh493m9hvwrm4au+wLJ5zAakAqzRF9NZsIIxsgLiotsTUIayXBKSHUfDJi4K//W5v34W37X4ce9WSFbzBWu3omM0H/pUJTFiesIsRhW8CMUhheVNe8vkSZeU3N3CRhzjPY+smhSf77xD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O69R+JIq; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xajQuAGU4OooXu+HdXXhNAcXXDpnDLHMHpGxDPooZwHp4MhnKu3pCie8DrMwhMVYu66/sh1JU0+WRS/G+EtebyjLlgAFa8t+sC8EMe/UTBjudsCJzdJkhMuxEuV8Ig3Od5ZPvQCCJpA9MtJY8rZKpDPF8nkL7JC3XKVZ70BwDoXR/lI6yfgatJwS4YXob+wM38Xkc7tR+3SVqsUjKi9sREQ9qmgBoL4O+YrJtrCuGcU7QExR7rSLIAhIfeOmu7nO+MfzB48bgHyDvXXrG5opS33VlGU3rBJ1cKfHvCKO8OA9USFZSde/4PinZ28kNaRvOeXdOfYYOMmOtJ0F4TAqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H8c4qw82cAUBxTJXMpgT/vF/7pq9p09OdmGYx1h4NQ=;
 b=t/rIykNTo0YKgcH40R1lkQhFL52rMXpsGZ1Luq1s+E7QqAStXnesHlzRMCCHS7eklYFwyr+QLr4YFxJvmqvgNlN21Do5ZV7szEVCMRjUvqgeeMb8lCg5nNB6yeSDomcXtpxzJm2K9hAyoPt+ogny544C2gRTw/dmdWuoABwLHEc+Nn3CbGdMsF/Cw9BuYTg1e3V3+he7R4BHJJ/cIcQd2Otm/bhWozXU3ljWHD+AMuTzMQyovIKIuEUPU+Gl4JV4ci39vasCzdkqChtkWjRaxFGLWRupxgtcuFj3m7sORac+xRasA+TbqCCz/heyWscULYr98bF2J80t9jbxVvXDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H8c4qw82cAUBxTJXMpgT/vF/7pq9p09OdmGYx1h4NQ=;
 b=O69R+JIqjNAAhorxBcXp8uzUmRsUtpuupCt3bsdGDTgIMHWx2/bnkBinf7sOdsAUIhCENvG9ovfWiSJjlan7KDSJTJQxTbqakpHmwqJjRIX+GiBj4+qaDpilKsGoa4B5g6GsImsHwgHYLe/TNAhPPgT77vTVYtoCd34E/YEObywKbA2ZwxS2MkpW5v9VgiNBiBnwl3l/4rpUu1tvxu10vYvqmNsyU6oSk9/oXwexn7O+81GeJJrNIZ6v6dVCpkBlgLES/B4DwBi3cYwOj5nMfpGqy3c+ob29TU/8dlWc4piVcwLSy7po/t3dXCgUzuZZ+FET+K0xp5zeW+RuRf1QWw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 13:52:26 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 13:52:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: RE: [PATCH RFC] pci: report surprise removal events
Thread-Topic: [PATCH RFC] pci: report surprise removal events
Thread-Index:
 AQHb6F617i3JOnV0fEygiRap3Duq4bQaJOKAgABAvACAAGfjAIAASb6wgACiIACAAABb8A==
Date: Mon, 30 Jun 2025 13:52:26 +0000
Message-ID:
 <CY8PR12MB7195583E429203129577B51ADC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de> <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
 <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <aGKUqsudjfk8wCHI@kbusch-mbp>
In-Reply-To: <aGKUqsudjfk8wCHI@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB8476:EE_
x-ms-office365-filtering-correlation-id: 60454032-a082-441a-e42c-08ddb7dd58d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v4VjT3psBqTVZ4e74pVMHUm1Uv/kUjKNVuARidJ9xlcyrr3LWfd0wg2FNrB2?=
 =?us-ascii?Q?2XVHGOctgClpfTb9aO+nJml+D6OotQtoIZvEvpyf7janHIUtX9ibPe6Y3d3H?=
 =?us-ascii?Q?ObphlaUdAqYMVVWzfGnNOoHq32/wqZxquTbqxCLf0AwaFmZp432IH75J57eA?=
 =?us-ascii?Q?yY7WcwGuAc5hJ9z8HdlNqOcHOdOJa7mtEwVam1mmUidbkOC40Y8QnEvN+j0o?=
 =?us-ascii?Q?pmQPMU6zDnjoZmbC68KRKFeF/96EDkn/r437em0UgzQv4jxSxPAIu8XlB3cK?=
 =?us-ascii?Q?pqgT54Ga7yxP8IPcUMltA9MS6ZEtR3BXtR+i194Oq7POFVju333/od3/hfru?=
 =?us-ascii?Q?2lgPS11YhLe4ovNXQFLUZqhQU3P9t0MJ0mC9r27iEgR/4SALjHA4GcEx/lsW?=
 =?us-ascii?Q?L844+NzajT80WVM4fT0BxhVr26rjgebWJMZURYxPLwgqU+iQXGQgZLdSJu9h?=
 =?us-ascii?Q?8yho1o61/FT9NvK1JlCH/yGB9wi1NutjY3G+fKawwrAcGkOC9LkEtEUnokYi?=
 =?us-ascii?Q?QDHfcSyK8nAD3FsMsJplfFZIeoSJI+nKp3Uf+Vd4vg7b0Flhp0+ZUQl9ybiA?=
 =?us-ascii?Q?vqACwkUU/8wFA5M5dPNZK3NawiA31vVRXMRFQK4kYcERcw4HQnyhBq9nynJX?=
 =?us-ascii?Q?RMDDU7Xo42irGD/J2aepjWvtCJk68aRt/+459B/52LMzwaBZcBy2FEmjIyBm?=
 =?us-ascii?Q?MJ0s/ZwX5LwzHxVYuebnR6MPWyBGnPRHJfdILqOFHDvW6iY/8X2se7GMvYpm?=
 =?us-ascii?Q?aaKdXOPiEr+oGyFSoLBnnhEntwwR/wr3LmsgPPuCTLoQdmnHKJMECOEKpvvU?=
 =?us-ascii?Q?dZyh7x7elstVRarr2QPkEBIGcYTRH9tUOOqREF/h2NS+kqNHr5vBRIET1Xy0?=
 =?us-ascii?Q?/dn5VsDAD27lKByyvgwrbGYyhUa5oe8Qi37jtRAJnvxrKs2HN7Ulkksdbhen?=
 =?us-ascii?Q?mxw8pOx1rUkX+wzx5AYiLraLlCZDMq51MeAY4YicVLkBn6iN7/15M2dSQn+W?=
 =?us-ascii?Q?eVznu5EsRXEe2EpaFb83P8PbatQIGA2/rr+lCT8vz26uCc61pC/GzHvLquq8?=
 =?us-ascii?Q?qmw+UBdvh4hAvhG+FsGpXJ2AW4fui+sugx4qgie2d9INS9dmO+YM3DRReUMm?=
 =?us-ascii?Q?y/QqhfmmpeD/swav5VpyAJ1KqCGhDSXp2BqA9tssLLlP4G7LYu8CbagtxicW?=
 =?us-ascii?Q?1oO9fGyd0NO613lxJXefuCmNlG920oVNTrcwpQ6G95J4ntMDQJz2MTZL9YpE?=
 =?us-ascii?Q?9WPPHV3s1jJNezNQSjMqi1mqyKuwn/bTpdz8wO1ph/X0c/OutG1IrS8HiipX?=
 =?us-ascii?Q?pdw7DsacyWlXX0jh2qXDqRAMkK3LEbAglMlPqCWurQPpeTSutZO6oSZlYKdg?=
 =?us-ascii?Q?tPre9vIbhn/MyiqY8TNw1vDAYO/GEzjYFPVrSrua7BCrHEWPgHK9KuquNT1+?=
 =?us-ascii?Q?PtxwhaHmhC2gKh0UMDrkCqySniJmjIy9neej7aKEBi7NA0HR8twkvYRRYaNr?=
 =?us-ascii?Q?eK7f6lok/SWP6Xk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H/HRnpGT0FsvFB07nKZ1LV/92T/zAfMmzXRxm2PeLpSVOm8W/+a+njDK8wO6?=
 =?us-ascii?Q?y0Ae9WRt7JMBI99JFkEjL4Xn8EtZLBS8Bqq+uks1OD9PaqwakX4p5dmpjtYZ?=
 =?us-ascii?Q?lsO11wUMu4r+0LMGuW65LlbBQ3r1OxGKNhhnWyd+M19F2kGRWNA5+fMERgJD?=
 =?us-ascii?Q?/a5FOO+dHWYTvnQC0ZL98ZEnHipnQdHoZXK2KbCeipYzyWMyxvqdc54eI4ZP?=
 =?us-ascii?Q?kwQIlgmNkhFvtYL++uOeM4/4/Ga4M8Q7wb0OzoNTyPG40ksboc/l4NrnMLKP?=
 =?us-ascii?Q?p0dOnvHvCF76zC8un6bJLoPI+j3hkzIwRx9KS1hqa2rIMr2qKe6P5pODrall?=
 =?us-ascii?Q?vHUKgsvhMasaCPruoLv232wNmUwv8e9cPF1IoGCcdXPk8ACwKAnQdMXa8QJE?=
 =?us-ascii?Q?dkU5oeiSRSmWdc1D7NWa394M2Yn/H3xwjdCscU6W2tQWf2ykuHEJRNuDvgr3?=
 =?us-ascii?Q?cZuyanIN9YGfTfBEetwyP6afGV2Nw2VAmqUEK9gEJ4MPbzynM7TEjOKPuCSH?=
 =?us-ascii?Q?mxy5S0zGUqmy6tctEFXfyj2ZhNCgwRpe1x/HZW9KXwg1ubt13uJXj3Mfcc7c?=
 =?us-ascii?Q?mE/ZWFx00XlHorkr64K24J5gg+aaB2RYglpPbj0PsOAdHwE+mBeY5BL4b3v8?=
 =?us-ascii?Q?nYXbko4+H3HFA4hAd1UJnFOT0AFPzj+w39SyWCCga7VFZuFSzufcwxKVgMYr?=
 =?us-ascii?Q?4m12zz2HJ954Wedg5wq6SdhVJ87yVObE7ev6FaqLXcuRvzgSYGpG3vnb7ecr?=
 =?us-ascii?Q?B1+3wKXaKm4/zQU/i8dwTzTjoBkLH7Uir/HttDXxTVHnuGKSgyXMvdt9jhAp?=
 =?us-ascii?Q?gP51I5f8rbw9QZG14h4YWL5Z0Cfo5wvy+r7WCOG04FvZYtq+hj38O75oZ5zw?=
 =?us-ascii?Q?XhUxnAikrLBWUUQfoZGBQHQZWQRpFET2WRjUYWbDyXjM+m1KLjUeYJGLbL6r?=
 =?us-ascii?Q?QJngUinMxk4L9ie8KyIQ/ZFm+BykKl6PQqugxGycuc2KD1UIDKS6GKXKA0PW?=
 =?us-ascii?Q?lTxqlMLEmMGbGP7uU7i1X5lXTQNjLLZxVochFKHD7cL6Y/p7ZA/4kyh1tG4X?=
 =?us-ascii?Q?rXNnAonsGR86diZ5qqHFCJr+Mx7sMldhR2TsBZ9GBr+yrNbu25dmQsck1QYC?=
 =?us-ascii?Q?wVMLefgzatsn+/AjaLjUe16qMvyRgS+kM45RB5j6kjc/z19A5k1HoRbqTzWN?=
 =?us-ascii?Q?NjtZaoDE9ja+bgAbvm9z7H/9b6v7le0TB7vetjhKZzhFdgGNK+T+Z9PR717u?=
 =?us-ascii?Q?yf/xm6DKx36RJmMflG45jTs4UJK5A4Miki+vLWaWebmPZo/vkK+DobV8NX8t?=
 =?us-ascii?Q?PgTaJvWeVPYCvO60QxT1kML71N08UHf3CqL/qDalu3JjRBpwZxqqGtSB02Pr?=
 =?us-ascii?Q?v1z1tpNZYRPoazpp7sDAS1BWuUiXK/9jgwo/bRma8LBfJ5nMZRlsZT9eUTYf?=
 =?us-ascii?Q?2joi5644TcZoYvVYRb3+DOgGMHl5M8xRwY1xPbY8eytTOwrYUBVv8ilrjvx6?=
 =?us-ascii?Q?+48LNl1nSFRgK4kKPwxwQEI/79+2tl1mAm11qno90KY2GIFq+538cybKbjAC?=
 =?us-ascii?Q?MIuplrRLAz55PmOOyOU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60454032-a082-441a-e42c-08ddb7dd58d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 13:52:26.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vS7UasgEUYTOQOHktFYTY3/R4/rAFJvGeg1HUxjBPE0mOa8rxK+leluPr6E+5usLu6op+1++YYl4icw4nQeUZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476


> From: Keith Busch <kbusch@kernel.org>
> Sent: 30 June 2025 07:14 PM
>=20
> On Mon, Jun 30, 2025 at 04:07:55AM +0000, Parav Pandit wrote:
> >
> > > From: Keith Busch <kbusch@kernel.org>
> > > Sent: 30 June 2025 05:10 AM
> > >
> > > On Sun, Jun 29, 2025 at 01:28:08PM -0400, Michael S. Tsirkin wrote:
> > > > On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> > > > > On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrot=
e:
> > > > >
> > > > > 1/ The device_lock() will reintroduce the issues solved by
> 74ff8864cc84.
> > > >
> > > > I see. What other way is there to prevent dev->driver from going
> > > > away, though? I guess I can add a new spinlock and take it both
> > > > here and when
> > > > dev->driver changes? Acceptable?
> > >
> > > You're already holding the pci_bus_sem here, so the final device 'put=
'
> > > can't have been called yet, so the device is valid and thread safe
> > > in this context. I think maintaining the desired lifetime of the
> > > instantiated driver is just a matter of reference counting within you=
r driver.
> > >
> > > Just a thought on your patch, instead of introducing a new callback,
> > > you could call the existing '->error_detected()' callback with the
> > > previously set 'pci_channel_io_perm_failure' status. That would
> > > totally work for nvme to kick its cleanup much quicker than the
> > > blk_mq timeout handling we currently rely on for this scenario.
> >
> > error_detected() callback is also called while holding the device_lock(=
) by
> report_error_detected().
> > So when remove() callback is ongoing for graceful removal and driver
> > is waiting for the request completions,
> >
> > If the error_detected() will be stuck on device lock.
>=20
> But I didn't suggest calling error_detected from report_error_detected.
> Just call it directly without device_lock. It's not very feasible to enfo=
rce a non-
> blocking callback, though, if speed is really a concern here.
Yeah, it would better to either always call a callback with or without the =
lock.
In some flows with lock and in some flows without lock would likely be
very bad as one cannot establish a sane locking order.

For time efficiency, large part of the processing is
happening in the individual driver itself as opposed to the core place.
So as long as individual driver can reliably know about error, and act swif=
tly, it should be good enough.

