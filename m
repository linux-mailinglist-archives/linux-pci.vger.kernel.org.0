Return-Path: <linux-pci+bounces-31034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA4AED32E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF3B3AFFB2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1418B464;
	Mon, 30 Jun 2025 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WH7OABv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751134C6C;
	Mon, 30 Jun 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256481; cv=fail; b=bQ5cb49kax4m7jdXf870VpUrFoDAhuu17Hl27vbLVpoDpT9A1wayC7n+zmo6CrAErRjD/neWSJYwyMDaV+86Oyz0iN+8Gj7cXi6AmTfYMeScIorToqfG4CoRqpvhBqUB4iKFMuNvL8dAQZa8xEw8Jq0bglDxUFtJOs0CEj2CSnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256481; c=relaxed/simple;
	bh=O5KyMlgkqUnjRbNXN1xnaPsvJnKeNP22d0FOfVubU5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmxvVUBAEF8qezEiwDKZ6nchI+jja63nram6RGn7IR0nfNxagFJYontTN85Vgeb7fGtAfk0iKNZnw7oO4+WimekFuUxHcmcyeM7y8ASGoOvXkCbmM0QoE3qTefTg1AbxvjMbR1iyr/EGVeJwXg8XkQtKqnQA4iozhgPRLJfKRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WH7OABv7; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTbGe2aZuTpbdqnHRKm4n8Cxe3c8/Uygnh1T4ipOrnsfYoWfbea693j4X3pwNSsepd3xvodVkkIkhQcip/okzmcnyZKVQu9a2tt3NULvGYNgwOMIJ2sV7hOdUNgfVnTcjrS1zoS10lFqn3RyKpAWoh3Iv7tgeU6hCYVp6lyRVwOO//HhH0d1rqWtmfQJ59ZGOjtma7ZfL53UNEdz9QpB64XgkkaARJxr4MYnyrzJVxHYqmHGtUeuMFo2KvCX9LjElZoYDgsS4LU2J1HKgToAqD9m8Fnf+gyq/QVWbNscugiUw7iQ7dQiD4OhvCTsQVbKgVXukJPxle7FUABMVO/u2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5KyMlgkqUnjRbNXN1xnaPsvJnKeNP22d0FOfVubU5Y=;
 b=RCZG8lKCTnOtez7Wyprp1c1QXK+j2aH6PiRqVzF22nwm3nYNUJIzhcEyAH06LKjxqSwG6yHw/tf5DIuFT/2kb+Z8FLSzCGzdOeUJERHMxO99Y8JCyi4ZyUrEBerZgNQHno7NUqFDESTre+EMxG8U5mQknK0w/N2zJphCs03TvGfN+1KxqOXPzDpDvy/5ATg2fJeyXlxN381hXmES5B+Jqfdo0PRjyTNOlIetzDyHEg/LgQIY9dMOuIn6Tn6X2uQSNY7dIXGF5dLr/cfhaR0ynsOOMwtbJtT+oqzBgYcTqaqKTCLlODrTqWA/oEk49HZ4qKwWaBixbqfcfA3ovm/0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5KyMlgkqUnjRbNXN1xnaPsvJnKeNP22d0FOfVubU5Y=;
 b=WH7OABv747FHvC195FWOns7/b7veLj+U8AOGC0HAyx4DI7nVInRyDkkripmisuX2FfdkoYqvqMYhkZjTHnQ3hkm7oP76jV/2Q0H9meg0aBNrqhIn0Ll1Wqqad6o0IZy8QJ63z7AMt+BzB0fk4EOwaPW65/vfimo/xY88f0d4ffG59y3cu+AXZ7Acupf1afcotACg1C9ZWsIlHele8vwdbSFBtuUzxpwustojj5fIsBVqhy8E1ebgUR8x0TezRbvnPw9LzHq+Uz+7bsbfIkfeDFXyzfN9OStCW1ZqDIW0lGYUmqxJra6vDGBqeY5jVpp9ZJEWdPze3u5XRtnkvGdRig==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 04:07:55 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Mon, 30 Jun 2025
 04:07:55 +0000
From: Parav Pandit <parav@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Lukas Wunner <lukas@wunner.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>
Subject: RE: [PATCH RFC] pci: report surprise removal events
Thread-Topic: [PATCH RFC] pci: report surprise removal events
Thread-Index: AQHb6F617i3JOnV0fEygiRap3Duq4bQaJOKAgABAvACAAGfjAIAASb6w
Date: Mon, 30 Jun 2025 04:07:55 +0000
Message-ID:
 <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de> <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
In-Reply-To: <aGHOzj3_MQ3x7hAD@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA3PR12MB8810:EE_
x-ms-office365-filtering-correlation-id: 87c71089-b304-4768-acad-08ddb78bb110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?osnjggwWv273ADSmQtKwQa1lfPiGoji7bCM+bce6mJVhPmsMl5iQlR4Hx5zL?=
 =?us-ascii?Q?Da2y+EY1LUNjRKwZzZ5j8ZsMK4iNwUxdbGlNlX8jhG9wf61cqHPyUjoLXy3s?=
 =?us-ascii?Q?AZq7EKORCG455S4ykv9sNk3CmJgievfNFOwk61atxfwah1t9cWjhlAfQ97LK?=
 =?us-ascii?Q?GbYDVBQ1C5negeTPFWKNb7KO6rKDD7laxgkGsVnTR8hAxGfOb1VamUszD++h?=
 =?us-ascii?Q?L6Vxl1E/rWNwsMEn9YQ4wiw4pj465UyER5sXdSj587gsy+dXjmjfzau7iWz9?=
 =?us-ascii?Q?Alq/sJxd64kT6bhwBBjyEFsMTM2Q3EJT7o4OloD1q11axzOIVCFmOBgvg5br?=
 =?us-ascii?Q?3+ZlYwkZ6s/cGIG7xqqc6AYPwSbi41nFTDCEzv0Z9czAvoQP6ClDvrAHv/Xp?=
 =?us-ascii?Q?lmroopLSm+orpGYX/AOiYIPHL1e7m3OFmUbmEOFPf9RkgLLWRzXgSeG8ZZkq?=
 =?us-ascii?Q?DfKALH7sOXAF99rNpyZ1KgNhYmJiIcOwlbw3qH+SfE7ZWUXbnl6UoWubrPJ0?=
 =?us-ascii?Q?UkIWGG854a+3HQd97meCRgAfK9Q2yN61swBomjR7QA1RTj6G/Ogt28Az17AA?=
 =?us-ascii?Q?Def+qlE++Z2BthbQAKTXYYMf+e7wWKYG8Ip6nDdm6MrkUlKbdbEKm6wedckj?=
 =?us-ascii?Q?YuqFlXyEoFjtLdxFKdgtD4/zGAwEIxUXEjc+nkDppsvEPz+1GUQL+x+WcbAh?=
 =?us-ascii?Q?b7wz76KryO4nPQayiYSOHw24HoHT95SuArtD2VKPX73B7X2FxdFFjbtQjZne?=
 =?us-ascii?Q?eN5SCpXz6G8eiWQaHZNnLm3ZoZS+gogXOHjknpBjfJmBKsen7srQRzanuZri?=
 =?us-ascii?Q?4HJNfgivI4yUxVhQBnoAiOlyKY3XnbZMhiRlHv5ceKZ2wEJfLLk4FZFQEpRe?=
 =?us-ascii?Q?KQBNVgP2aDT/qqiTowfi8cSPjQx2+OCjjq+tbBoexmv/EUVVE/EfbfYwuDXz?=
 =?us-ascii?Q?aK+uostkALoKIjOLwOj3jn4gBfXXPbf3FKNY7D/YpxcH2ZkxfNwPdM3EHGTG?=
 =?us-ascii?Q?Tpb8Ko+MNshWMEhSjwDDG9EUlH/6Eep4Cj3nxFdcfas76jB00De3CfoLdFoa?=
 =?us-ascii?Q?YnF94hULfCUwJYa0ohc59ADgMu8CBWpMINAcnxDHJkrYfmgGaGQ7cHXmVhcn?=
 =?us-ascii?Q?RKImk6XAP/Oq4pnd5ERqwMVngAF4ADupUaTzNCll5YqCAgHKcDHxTOZ+z3EM?=
 =?us-ascii?Q?vMOrYnXuRaxThVVy/tS5P0NKFG92O6kyY2t82F8bd1CmN/mhmhjYn/klhRW4?=
 =?us-ascii?Q?Qc3xyzAVk/1JQPskzESQqY2azdtJaL1l2oy+N9z5vJSdgG+r8hnh9yEvk0jV?=
 =?us-ascii?Q?5a6GYfUTjQok0P5DwrCICPveWw6oJZqeTYJ4wlULDcPX688xJKvP+5C3mUKy?=
 =?us-ascii?Q?OeMvxgKanX11UHdT+fHTpoWIIOmWaufHOiCx4GbtBYjY6zfCsPv0ey5My+Pc?=
 =?us-ascii?Q?ckxcjGsnHPUBERrm0OKp5wKkCts2E9b7I3vJyMkG0SO+Jcw6Vdf0F4hlt3j3?=
 =?us-ascii?Q?YUnc9vwx4dc+BRg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pwswwuKzCLmaHRv0CJUCa5In1mLaBaIdy/1OCRN7eYe3aWcVqmsb9fVhwGej?=
 =?us-ascii?Q?n/ccHkB4FXPwYU+NRFuJoUQ06Fwfrp4TCl+h11fHyljJpdP8kVv0/ClPPOhO?=
 =?us-ascii?Q?pYcPkIFMPOR1P5Qz0H1Kz+3y2swyy8INTz1HSA+A2F3l6bU92MNAYTLcQHlh?=
 =?us-ascii?Q?d4mxelkOu1GPiPC6nXTKpD2Hb0mRvhS5BGJFerJNtHBLNO/9zvu9OUSyT18B?=
 =?us-ascii?Q?ZXiisYa4vPmy8DbGmLnhH5FQ+WYxT83x4ps1KMWaGBd/65khfmQZp6jHnhVb?=
 =?us-ascii?Q?U31pzDnsTJ3OV78kTxiXLbxMmTpmnBc8MhmrjIHtiL47GxZWEQU2u4EnZyEY?=
 =?us-ascii?Q?kJbApheApW1WPqTlsA8wVXdOcc5MVzs4qFBsN74QpfGDM0VThLrG4na2s6iC?=
 =?us-ascii?Q?keNx/q4tiT0ubKbqmpDk1je/1OGoQ5cjAvs+BGmiJK02LHUTTbh+I29110PZ?=
 =?us-ascii?Q?QNm6cZ/Z08D8qFEPlX4uayW+mUMAW/+sgXYX9aFk+h4pv94l3NebU+8yOK+r?=
 =?us-ascii?Q?fZ13o9KDJ9V9y17ucWWkhT0x1Gcl2p0ZJrjYUsxl2kZcYYDv/j3ygTrhso3J?=
 =?us-ascii?Q?iBpDX+IlYV8x/F9V3Q+L3lkCWz6PnRYtL7cUxmuTs1IXYl3gwgq/MW1sX2T/?=
 =?us-ascii?Q?zCRIxLDVtABgVfZFAU8UF/3+C4O+nNQoSXOdJFnX0KqFBVBtsu6AHbFDjVFa?=
 =?us-ascii?Q?krKoH99EaFbQvwNKiks7aHfq0e2t0CdjFty8QBhRG8SpFztl3FhrcTHF515G?=
 =?us-ascii?Q?7WCkG9A2t07utcu/bMluk+WgDuUUfZc+TUAZ21f8T0ZRIkEWFcaOYnD016ph?=
 =?us-ascii?Q?RB6bYEk4cGIPZRAKNaNsQgi/Wo7zqWRqzckdt7YDa5BFh/2Vbp552Wypdip8?=
 =?us-ascii?Q?Re9b2B72tiGUFbPbAKTs+fhHdwYvRGsCSjLv7HGGlq650mo+f1u1kQGs3zBC?=
 =?us-ascii?Q?WkaIkLEdwd3jpVNsvrpp+DSrsoIVr3GdGQxQevlD+B+03YOJv01jJY+AR6mZ?=
 =?us-ascii?Q?mHAxZNJlHQZXnxfy87wovCQAePoOYe4auOtiGuKFEi39H+ysNT+Dc/LPWcQM?=
 =?us-ascii?Q?E2Qd5aZN5n7w/9pS/SwynZA73kLCblX+JpJesVohu2XCycoYSEBWDsUlelM4?=
 =?us-ascii?Q?WyTJeNl9qSd57SaCxF/WYahqJkUHNlYcU3vrlm7nWM9w9Vv+C+zj5eL+4bbB?=
 =?us-ascii?Q?0lKAfhVXpuv/weTZMzdA9aAt6EGrYP26RD6nH0YAxiH0A2XPIUyfxdG/ZZ7u?=
 =?us-ascii?Q?zBAMIi9MNhgim0jEYpPoJ0zSxGJ0sQI+GsjOrKM1jMbSYvBda+X9lS5L9kws?=
 =?us-ascii?Q?l+CigtINP/XT6BdLB0q1E1OTU+67J5PwFUHt8aiJhH8svj1OsEoHsYFNp/hW?=
 =?us-ascii?Q?u0q2Hd1rDSPLNkZXluF2EW/ROsFow1Jq4JAnU0N9k6f5mOnDdFZPnag4bDw/?=
 =?us-ascii?Q?5cCCbuEYlKjuenUCr6Oe81QIlQCTOr9PtS8v9Qj0ElcDlSPftCHbD3YLLMNS?=
 =?us-ascii?Q?IhSLdDecxYJ3gF1y9dJH5GqEyaH2mgh5DbQc5ocwymW6YkL6ql5VEbRkEezM?=
 =?us-ascii?Q?uCxdUnajmFGKrBQEz+Jqzvfza8d8KnQKKO/A70R8BDldyqwz6Swjq2oLfj8+?=
 =?us-ascii?Q?/v0pniYKqH5x8r/wo7UFjTHjtKDiFIeax/8pvreWb3Nv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c71089-b304-4768-acad-08ddb78bb110
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 04:07:55.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HS99VQ78JoqWIa7ge9V7H2hdE9srXhm1iVGl8QdzQ232fdrkCmyhWvYDlq/rWmrKlw0XhNFmTDqe+ugkggHaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810


> From: Keith Busch <kbusch@kernel.org>
> Sent: 30 June 2025 05:10 AM
>=20
> On Sun, Jun 29, 2025 at 01:28:08PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> > > On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > >
> > > 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc=
84.
> >
> > I see. What other way is there to prevent dev->driver from going away,
> > though? I guess I can add a new spinlock and take it both here and
> > when
> > dev->driver changes? Acceptable?
>=20
> You're already holding the pci_bus_sem here, so the final device 'put'
> can't have been called yet, so the device is valid and thread safe in thi=
s
> context. I think maintaining the desired lifetime of the instantiated dri=
ver is
> just a matter of reference counting within your driver.
>=20
> Just a thought on your patch, instead of introducing a new callback, you =
could
> call the existing '->error_detected()' callback with the previously set
> 'pci_channel_io_perm_failure' status. That would totally work for nvme to
> kick its cleanup much quicker than the blk_mq timeout handling we current=
ly
> rely on for this scenario.

error_detected() callback is also called while holding the device_lock() by=
 report_error_detected().
So when remove() callback is ongoing for graceful removal and driver is wai=
ting for the request completions,

If the error_detected() will be stuck on device lock.

We likely need async notification from driver kernel core without holding t=
he device lock, so driver can initiate cleanup in this corner case.

