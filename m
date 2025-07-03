Return-Path: <linux-pci+bounces-31329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06CDAF694A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 07:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073791C4366F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 05:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E0137923;
	Thu,  3 Jul 2025 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FMzM40Bk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFBF2DE6FC;
	Thu,  3 Jul 2025 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751518943; cv=fail; b=sG243L0Lsa7YgqM0fnmPfScM43hZD15qA5JPPgRrOdiMIub7LHNTsp2PvHQ5vEg1yAC7aEUjSvBLsv1BWsZ/1IY8ceGSNyJwiAZe8M2X5b6Z3OLyjErFEDgZNAIx3MFZLqnkfbk5qXVIaH/S4nPN4p/QrQlgR15sZfU+JO3Sfr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751518943; c=relaxed/simple;
	bh=/Wjid3penuhZIvFjtfz44WUqEC+Zzmgy5dlHdXPPeFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQpTLJF5+C2AgmEUYIs8DKivUDGCZ+/6G7urlNXmbL+duCqOWGzdrSLi4MLM7WZ8qg8d7lDtXEvMs2NUxJ2JNcGLELpCX86r2wrp0r90zFI9g22UG0uoaoIgtYsQOqrVvNdN4M864DlzqbZqvJqQtNbNCi2VXUoNd0MYWAOC6gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FMzM40Bk; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK5Db8uroA7zu4dbuVC1as8eV0Cs+PU3tCxnEu8GJWtRtY6Rlt9+EbmsC9NJ1ARtFhAM9T6zM139gQFmFOuZUonW2eVYJg7pNnwmDlZ/CNZKO5c1QPLE+zjSY9/AxnDMzxvIyoVOEpUG5AxqTLxB/bpPz7164mApe/k95A2VkzczgtrD51O0nyOpR+sHjJIL1CMr9G2okkI66xckDqvFC3fv/qKzVnegk8RgLwK3xVAvaPJtf8kzCvzFUxNkMkLwM9aCiS4ulqhiialmIJVCK/I9QqhGQ34NEIBrxOERLjPOkqFsYt51Va7cOJMY1mqZaR6biPigiQ08f8rO5VLH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og56++tqdztXclDkomzANBIW9vaOSteA8ymL9t7tp84=;
 b=gYwGBlH4d6QV2et3JGg4/2mRovxlhIE3rUMxH7AUSd8nBSkx8EZlprEf/f4x//Xjck+fuEzlaKnzOK21Zg0ziIZyYGWmmrn/UiiRKaDYQE0twksBZsy9RjgVEGN4mOdqGc5VA6Esbg5SnMTYmDnZN0qNbC7yWHbiENIThowfKrwiC9sDIiZgwpmtvfi7Uco1Yx2ZAn9VkYwtOI2YqdmTlrZTPrwwN+bYtFbr8SOXciXsLqXDrRWAtbb2jl/negWpqLLKL9+JqA6Q1t0SVoKvJUqGEd2G3j/ulm4cNOW4XHyesGAnKioE41z0xvbRdJ1O3wgA+4Lvr3Bf1rftrFg4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og56++tqdztXclDkomzANBIW9vaOSteA8ymL9t7tp84=;
 b=FMzM40BkeFqYLobpohlPqqZwfPRu1QrGFSGBS0fZAEJyAm5fcUpS9lNEORymmIGiP80TVpa45b+LVbDsFWa5EL3soncOKELdrmAbNCFGYMLy5Q7gAf3C5Q5fBA0IB940aumzwk389fwb4XAbXeVx8EZtx7Szq6JNrQvdKRuq/EWqZiws/y6kG1uDSeZeXOfXDW/85YWc4Y5N1hZwQxNG9tyYyYafcpJkkrQS4b59Tmtv22p2GxYdbw/Kfq6lHTdBnM5Z1nf4y8/DfATwGLqukZmXHCRWaxXipjAyx1Jr5nD3hJ1M2O/ObnviSSrQErIRnwvVs3fT8fSjYbI8t80tJQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.33; Thu, 3 Jul
 2025 05:02:13 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 05:02:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH RFC v3] pci: report surprise removal event
Thread-Topic: [PATCH RFC v3] pci: report surprise removal event
Thread-Index: AQHb63Ya2qJTaIlBG0ygpVTJgWwo57Qf1MEg
Date: Thu, 3 Jul 2025 05:02:13 +0000
Message-ID:
 <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
 <20250702132314-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250702132314-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB6833:EE_
x-ms-office365-filtering-correlation-id: e5d08de3-c968-4d3f-22e6-08ddb9eec63e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C0qKlreaoB0cGu1w0snGZlenB/ponkU2Q4rNPDxfzWqGikKcfJYACMd6mreL?=
 =?us-ascii?Q?JO89xM6Et0w+iWXSaUqD4C/niR2vxDe2eM1iYtf5PizLb86nrHrpXXI0zi2M?=
 =?us-ascii?Q?icq0BdTgS2M2tSfXCLX/gQb6Eqh9ZOQnxy6r7IOHbzr2oZ/bbq1rPFx1KMCM?=
 =?us-ascii?Q?u6Yh+SouI+wRU3sibh6gBYEMMdA6qasL29Sdi75C9ldbrT+oQAFLMd95wrEh?=
 =?us-ascii?Q?1JUAViMTzBRG9ZUUSHDAdZ5tB4T/3el2JBMgSKC3Gz/uuj3rimgEYV0Kf68K?=
 =?us-ascii?Q?25LFm88gNJF52AcYIwzvGlWznytvigBzBR0GB2DyrMu3xzUXgrKxAqKHucWr?=
 =?us-ascii?Q?nsdpm9ZgLB7J1QX4NIlBl1XJdriQjYt90wiLt4Wd+GqwvITZpgwtcmUQOxbe?=
 =?us-ascii?Q?4lQCd8nDVSKViz628QJyNWJbYDYfkGGMXpsTCdi9IMUYnRMtpY/L4S9FAiFm?=
 =?us-ascii?Q?P5UXSckDs9+IqfP51KekzB+oJ/XzHIc4FHGlYxykrb6jCJo/nmnqZECu64Eq?=
 =?us-ascii?Q?LfbMV492WXw/fJdHjv7zIorDQY3jwJgVUgTDssDNehg1960A6BeNBdCQt3Cn?=
 =?us-ascii?Q?eh8/O92FDa+OEQ68z9wQ5XWXX8Xb9Vs6ymRx/5YeQlCG7lspBeSYmO6q6m5w?=
 =?us-ascii?Q?VGjcOcF2NKoNFRg/Id5fIpicVMdOVTCOr01s8RR/0/XBIZbJtBKm70avCsBC?=
 =?us-ascii?Q?y5Em2lS8f13L6OdcO7tXBtdE86JZlOR05+XuohwzmBj1OqNIduNdmY3nNakn?=
 =?us-ascii?Q?Fq0R+ULocT4mAmEkH8Rtyu9GOQQLh5+oibA4W8Y36MIQ1Cevh3JCHXht8tn6?=
 =?us-ascii?Q?q6XX6LSD8f5h2OW5pDiUIQqYh+m516LJfANuEsYa0jVXp878zjFpyajPtOue?=
 =?us-ascii?Q?gCctBUOcpo98dzzkUGBjkh9yp05+fbCZ5iuM1ZlWGwIxJuKxv8NPdMSUQNDE?=
 =?us-ascii?Q?EjKSRLY1YQafPPDbelBi86MF0zc43RwxyHVn/L0kstmD1hmT1rXPgbiIHcVt?=
 =?us-ascii?Q?Di0OEpMimv9KHHss5yURsRAnj+WTlSgVH/vLNR025t6XOrgWX0Sob4hQAX1w?=
 =?us-ascii?Q?677szHq2j4zwQ7uhxvRUZulGVcuYJdCSJdnNqMYdeozbx42W/IkI8UONC7hr?=
 =?us-ascii?Q?6JV+J0zsgrtKF66nDIlK4KnWJQREmTOQnXCNczNp+sB79J4grz0IechvvJpA?=
 =?us-ascii?Q?r3mfkrFuMWdrx8jMrUvRJ20xI9OGFQyzrg0mKg7QS5/XJFucIBixa5K8Fszc?=
 =?us-ascii?Q?esnzrRXmwJL29uogMov/wi+xdsoZNvTibUqOz6FLFDMvKTI61/2Cg0gdv9il?=
 =?us-ascii?Q?egLihoICCXwDx8hLjP9+YRO3rciO17b/yDNohVWzNOlI5W4hBjTsF6Gmi14R?=
 =?us-ascii?Q?HxjqtsEKNauwN9+X+tWikzZiSmsGWFUdvQu8BLnbhxrVRnJQIF5uQ86DeyJl?=
 =?us-ascii?Q?0vjUQNNRzL9L555uu6prIf9Ks0l7PNcq1y0sdKBoqKYU5FcYHRyIWCcaQH22?=
 =?us-ascii?Q?5jdlz1EbVqCfy+A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lQexSonU+t77LuPr1yD8aa5PSbg+yT0pMMjV8eA/i3DKWREIBgvD9+6fySC1?=
 =?us-ascii?Q?qekNPn3aAyPbbktz1cWTXguxlfCSa37tunTzsCH25SzrXFs7zsedvxo479pJ?=
 =?us-ascii?Q?ddroydfjjBbQRYI8D/AEmia/gYeUq6Mqyc4lnlunDfYvZBy5N2zOV1y9iToL?=
 =?us-ascii?Q?70bH7rNcDq+uWh6mr1dQmm+8u/ZvYsEvddEZUVOYHPDMyh5eqxqkp9amRC7P?=
 =?us-ascii?Q?QWKsf4rvsMXp8Spn47AYOEXkZymwrDW884yQarBdrEQkikg+pFWKSg0wclAc?=
 =?us-ascii?Q?mGcgRXEkCa/jAyhq3SRnADKTUkV+cJelQxFl3JyZWqs9CuyelYkjmBgvaQKa?=
 =?us-ascii?Q?NSYr3bDANRMaF6hZjC8ihUJ100rlE4/13/3qURPxsDDBOMnkIJ5N3pE4xBDC?=
 =?us-ascii?Q?AFKzW76MwCpoUAEvM9/4gQhZHITJBv22Yrdj08HTzLaGYgVr3gezd8k3/9gf?=
 =?us-ascii?Q?nqPh6YKnPtADF65He6XJv+V6oRmx8wSOI068Ia34ivrHcd7HZA/WHjZxQc8s?=
 =?us-ascii?Q?J4ft8bgfV3lu7V8SIqXy+rQUVnSA247cOr19N93qnOepXTRZBtCJwwmWPpKm?=
 =?us-ascii?Q?0c3DLANDGeb1DGX+PP0K+mXpBKGEXFTPm+iIeJZZsLTMeGLE9zgDnGvuXqpl?=
 =?us-ascii?Q?YEpdlEweDzLxGjcm4Riy+KXUKzsRQKdyPpgx566x7l9DDHh1RyGyFr1mx8NK?=
 =?us-ascii?Q?ENug6PbGUZV7vAjxEadoitPGKziaOYGGMFna7uyYOrrMuYmLXPsdR56eAkNs?=
 =?us-ascii?Q?kTUsiG6N75tfOdCIQxWmPfjy9sZQDeQvIR5BVbpoqtbHxQVH8jeZH6F+WYE1?=
 =?us-ascii?Q?PyibtHSdsY7aU/7XDza+MnYtc9dRg6sm6kPrAK0u7LBnibcZehWYSPJAqMd6?=
 =?us-ascii?Q?GwBZzGk+cWNoB1Jwr1BVNaZdHAeD9E0nopMnct8INwmvkIAuRV/Vsq9iEsBi?=
 =?us-ascii?Q?FxTFYDfQ6uhgBNYBnPA56CvOYewrr/1KPPrx/aKLnoFEQQXA2DeYatEyHO+/?=
 =?us-ascii?Q?EuEOFcbLAqwa9kLWV+omE337ZdhtDdHBhA0/uMAO6qrh2j+K385fa+Dwz51j?=
 =?us-ascii?Q?dErUPtj6t+RD6WdhYFeRcrUz3yEHT/1CoI5khfhBcAzprmrUjAt7w39vuXGM?=
 =?us-ascii?Q?qwSZe3gvglR7w519r3iTmz5SEtD9KGDeUZaZz0GN8jZyDro+mmZ0Wq++XqSU?=
 =?us-ascii?Q?uns0jahT7///HUBcF2VHmW8h1doXKqslGAMTepAbpEReRhO7rBhlqQmtvivq?=
 =?us-ascii?Q?1EWWqd5ZTsCzYZTh3fhCwsweHR99LHAChGlVfe2HTMK+EjOJRYyKfWLTdsSH?=
 =?us-ascii?Q?RX5kOdGuHNkict7rE2zuOKkYKDxW9WSeee0YTeOiFaYOYOTVJ6+TjxEiwArf?=
 =?us-ascii?Q?MP17zv6TQOYXM1pbnhQW9dibTcRFZGH/waJbwa2TSdWJ/KqiYlQaCUmbMpzF?=
 =?us-ascii?Q?IeCiMYh5acz9D6gpj3Q4cZZ0NaA1qvmm/7YRUKiqiZy79Or9qUxwBZLSlJ5d?=
 =?us-ascii?Q?IO4Bj/r06KGOVeC8GiWvOajw8VxBAUVC9960AaK+vWS9n8QMN+SUGsn9yQ22?=
 =?us-ascii?Q?lud7T4suujqJxNMstvQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d08de3-c968-4d3f-22e6-08ddb9eec63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 05:02:13.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kl3VD8lnymAjcpKKnblJWPr/MtD+QPU9bH0n1jWD6gIAuaWkQfuEkhG5TP8WyPlxvHSolXqvmn3rrPsCwc5bIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 02 July 2025 10:54 PM
>=20
> On Wed, Jul 02, 2025 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular remove
> > callback is invoked, exclusively.  This works well, because mostly,
> > the cleanup would be the same.
> >
> > However, there's a race: imagine device removal was initiated by a
> > user action, such as driver unbind, and it in turn initiated some
> > cleanup and is now waiting for an interrupt from the device. If the
> > device is now surprise-removed, that never arrives and the remove
> > callback hangs forever.
> >
> > For example, this was reported for virtio-blk:
> >
> > 	1. the graceful removal is ongoing in the remove() callback, where dis=
k
> > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > 	   complete,
> >
> > 	2. Now few requests are yet to complete, and surprise removal started.
> >
> > 	At this point, virtio block driver will not get notified by the driver
> > 	core layer, because it is likely serializing remove() happening by
> > 	+user/driver unload and PCI hotplug driver-initiated device removal.
> So
> > 	vblk driver doesn't know that device is removed, block layer is waitin=
g
> > 	for requests completions to arrive which it never gets.  So
> > 	del_gendisk() gets stuck.
> >
> > Drivers can artificially add timeouts to handle that, but it can be
> > flaky.
> >
> > Instead, let's add a way for the driver to be notified about the
> > disconnect. It can then do any necessary cleanup, knowing that the
> > device is inactive.
> >
> > Since cleanups can take a long time, this takes an approach of a work
> > struct that the driver initiates and enables on probe, and tears down
> > on remove.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
>=20
> Parav what do you think of this patch?=20
The async notification part without holding the device lock is good part of=
 this patch.

However, large part of the systems and use cases does not involve pci hot p=
lug removal.
An average system that I came across using has 150+ pci devices, and none o=
f them uses hotplug.

So increasing pci dev struct for rare hot unplug, that too for the race con=
dition does not look the best option.

I believe the intent of async notification without device lock can be achie=
ved by adding a non-blocking async notifier callback.
This can go in the pci ops struct.

Such callback scale far better being part of the ops struct instead of pci_=
dev struct.

> This you can try using this in virtio blk to
> address the hang you reported?
>
The hang I reported was not the race condition between remove() and hotunpl=
ug during remove.
It was the simple remove() as hot-unplug issue due to commit 43bb40c5b926.

The race condition hang is hard to reproduce as_is.
I can try to reproduce by adding extra sleep() etc code in remove() with v4=
 of this version with ops callback.

However, that requires lot more code to be developed on top of current prop=
osed fix [1].

[1] https://lore.kernel.org/linux-block/20250624185622.GB5519@fedora/

I need to re-arrange the hardware with hotplug resources. Will try to arran=
ge on v4.

> > Compile tested only.
> >
> > Note: this minimizes core code. I considered a more elaborate API that
> > would be easier to use, but decided to be conservative until there are
> > multiple users.
> >
> > changes from v2
> > 	v2 was corrupted, fat fingers :(
> >
> > changes from v1:
> >         switched to a WQ, with APIs to enable/disable
> >         added motivation
> >
> >
> >  drivers/pci/pci.h   |  6 ++++++
> >  include/linux/pci.h | 27 +++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > b81e99cd4b62..208b4cab534b 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -549,6 +549,12 @@ static inline int pci_dev_set_disconnected(struct
> pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >
> > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > +		/* Make sure work is up to date. */
> > +		smp_rmb();
> > +		schedule_work(&dev->disconnect_work);
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > 51e2bd6405cd..b2168c5d0679 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -550,6 +550,10 @@ struct pci_dev {
> >  	/* These methods index pci_reset_fn_methods[] */
> >  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> >
> > +	/* Report disconnect events */
> > +	u8 disconnect_work_enable;
> > +	struct work_struct disconnect_work;
> > +

> >  #ifdef CONFIG_PCIE_TPH
> >  	u16		tph_cap;	/* TPH capability offset */
> >  	u8		tph_mode;	/* TPH mode */
> > @@ -2657,6 +2661,29 @@ static inline bool pci_is_dev_assigned(struct
> pci_dev *pdev)
> >  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) =3D=3D
> > PCI_DEV_FLAGS_ASSIGNED;  }
> >
> > +/*
> > + * Caller must initialize @pdev->disconnect_work before invoking this.
> > + * Caller also must check pci_device_is_present afterwards, since
> > + * if device is already gone when this is called, work will not run.
> > + */
> > +static inline void pci_set_disconnect_work(struct pci_dev *pdev) {
> > +	/* Make sure WQ has been initialized already */
> > +	smp_wmb();
> > +
> > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1); }
> > +
> > +static inline void pci_clear_disconnect_work(struct pci_dev *pdev) {
> > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> > +
> > +	/* Make sure to stop using work from now on. */
> > +	smp_wmb();
> > +
> > +	cancel_work_sync(&pdev->disconnect_work);
> > +}
> > +
> >  /**
> >   * pci_ari_enabled - query ARI forwarding status
> >   * @bus: the PCI bus
> > --
> > MST


