Return-Path: <linux-pci+bounces-39747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC4C1E1DB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A15188367F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5A32BEFF6;
	Thu, 30 Oct 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lUX/fcWu"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011008.outbound.protection.outlook.com [52.101.125.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC72DEA90;
	Thu, 30 Oct 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790830; cv=fail; b=N9ORQtwVMEnGia6WunTYe7W3GnwHvxb9aTSPGpRCerHxDvDADyd10pw4S0ijwwwYUz6JRnXKQiS7mBzsRHvS5qv6WECQx/T6v4PGpo0mq/2welIrVAeK1aDN67hZG82/m8iVAWTGRVh05K7v+WGFMZ0OjkMZ8+nreogqMdkqNYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790830; c=relaxed/simple;
	bh=wQUfEr+GzbPq2Bl12q6M0JUPsJD5CZfNjMNzCnxl12E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gyOPa9+YudVDhKckWP/FDxgBsCFEYKqmaeIprQEpTnfdV+RLtbaBz9Q0LUKemTeS/2rkusK9X0igSu0edQHSTZx+Cu/JniNr7ggT2qZQ6bQ6tBYo2JjwrLecMc2xElU+tmHANqY9L7vcLUG4LQ088V8o/Bx8HvIQPK7SowuANKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lUX/fcWu; arc=fail smtp.client-ip=52.101.125.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa6/+W6fxJSimSVlidXNXhEEYpAg8dvmpmvidz/F+N8cczii9aBNe3fth+wjQSGvHQs6gL1n+kCwfZ+WuD7MkCm4skz6GBqntp/Sl6u/hoY7+9AhOvRTkIR9/fnMiJXrzFxO2isUsrMT0AE3HxI+GxOJ9w95zk1CDd9C+fjlubKVd1BewC9MIiGXHYrIMIDHqfYhgLqQfzRXuvY5gWvpeqipG8U+d/Mv+jWI1zvOkteoggwbMaLq9C6wJlzxPUizcmdHlo/OSEDwrnDsDF9F9mqKog3dxgikOZkHr3AzRLWg2Zwkt9agvpgjqBKLliDFc2i9vWsut5a+2cvq7TD/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YrbpGOkpn8Wy94Q6GprNsWUqg9h3YPUqglgQhTdgzw=;
 b=TIbN1qDv33klnXL5YjJs83Od99svqX0K9bxeBgacjjRkZxQwjT1IGWp0pPWkpMYB4LOsIwzhB4QcgH48JRmiHA6sGleWQlgz9PTcDCxAj/ihpuWQZ1tCWpYX3vYNAnP7x7lSp0xhLU+YFS/8i8VHdH2rk2dfZJhChOHZocJhHGPs3dlk3T6fRzz+Nz9VhDRCa2eIOftxMVCeWOQGgz0SqZhQLBafCaIHjmmGjI4h1fvjBQ4j+/zGErjQ+3yQks/l3ZyKgMPkaWnU9l2+K16CY9FjCwRfkO7k1kckTUjcNcSyyYb2jB143bPnAE7s0FylJWvBiqhjN5ervk5yAfsMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YrbpGOkpn8Wy94Q6GprNsWUqg9h3YPUqglgQhTdgzw=;
 b=lUX/fcWuaz4BupfkYmC9yALZPlyMMu0uHxHGVABIfgj0qmcbKb4Npr+IpR1xl1qZTdOSuBvqCDAsvVBy+ek239Tni4aOwyqHS3xAtoGSmerzvwHryEWrhIwLP8Rwmg7BZoP1WoNZo4W94zglDPk+RWCVd/7oPi/+sOKL+fXuNLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYYP286MB2980.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 02:20:25 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 02:20:24 +0000
Date: Thu, 30 Oct 2025 11:20:22 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v2 6/6] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <5qafrtm7qzjcrl5p3j6lovahjaspkehzgjjyvyzchms6dbzksw@hb7hm5uopvh3>
References: <20251029080321.807943-1-den@valinux.co.jp>
 <20251029080321.807943-7-den@valinux.co.jp>
 <aQJGlOIJBY+44Q0v@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJGlOIJBY+44Q0v@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::11) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYYP286MB2980:EE_
X-MS-Office365-Filtering-Correlation-Id: f101e4e0-667c-48c5-7312-08de175ae21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YBUk3pAxrt9gVJN52Qm7nQeWHPl5FnpRAacaqn7iUOH/DE5UFjNrksl4KZBQ?=
 =?us-ascii?Q?QXBipVrgkupYygoiY7ULYGBUcVo+yv3amTnASfvdB8VS4DJ0Tc7WOmSP1krz?=
 =?us-ascii?Q?Dn5vn94vaBTrQ4RiOILQLfQGQqmWY0/mI2/3HeWempMqvAsVTcBJ1KMwcROH?=
 =?us-ascii?Q?evNLOariiVtmzOE3arNCQLrVKpenSx2pe3yufzPtI7Of7x8xGMVfL9rGyjCZ?=
 =?us-ascii?Q?RRA812ybprFkPyTnW5+L9AFJNykDvxu2DU2owRuO0kCoSfrjEwSGaXuwEm1b?=
 =?us-ascii?Q?hlro9etITc/WFvN1H8W1Y3m68k9FEV+yethBRtOuq8ozI0UdvSQK/0jEWmQx?=
 =?us-ascii?Q?qFYFdcjzXmNvsNprScQUrNCRtOxZEsAEXOc3hMSLTYOdAzBb3/pLiRVmO4C0?=
 =?us-ascii?Q?oBb8wC6cxFt3YYuK45Wq+YV+IEpeWKrac68IXo6WUXlT+uXxRjyhqrFH8zm1?=
 =?us-ascii?Q?HWj+BN19qisBn2WGggwGb4F9DddJEUE0I7Ww91wTCDVNPevFr7/4x5bF+syN?=
 =?us-ascii?Q?pRIkahfJzgtAsAOwWnVZ7gmM4SQQzXL168QvsLyJ+PcsRt6KFbLm3KL22BGJ?=
 =?us-ascii?Q?wxsNqNAP9sgoYotAwnWP55Bi1VdIw/9GO4CFwiNbwLYO1nm5P0hS2WMLiw74?=
 =?us-ascii?Q?0whT4tARumdj3nD0BSaESOL3kUcqTs3TCEvzslnoJoiuZM0EUwErZlYBtOTQ?=
 =?us-ascii?Q?QfOwFY1Te4qM45QTuJdWXvTi0WePP+oBSoCAcZrqcKVCM4HoxhwQDHEpG1L7?=
 =?us-ascii?Q?BxAgwDhVF7vlaoVKlQSqwbh8n1mMB8JBC+vQXI7RY6gpH6VQ+vqwmXNUjm/K?=
 =?us-ascii?Q?/RVJvOprovpaBXYOTClwE3nINFBGO7VmrkaXmhROZsuXCArez/pAfuUSPLrv?=
 =?us-ascii?Q?v1hbRjB2PIY6rPpz4H7YAq5d+Hj7jYyixBF6wa7fsGn8XriIDvo9mRIbNvjl?=
 =?us-ascii?Q?Zm6gw1BlXEbegm3vvLPDtEJMBPr2PwBU9R0wouR0FClJiVe14cv9l5+1BnC+?=
 =?us-ascii?Q?JLDvF2JoMBipCan8HGyw951gYfjjDLDwJ1//25057LQN44UXyOZgEb1vbA2y?=
 =?us-ascii?Q?UqR0QXt9DeUzY8m0/13R7YEohGlk8sud3Pvq/pZ8xuhrMluI0qxGsMP2My7D?=
 =?us-ascii?Q?PqrFea1YmxvGC6AbslqUlGcc1qF0omRGmmNHlHryxrPkyFmHZI1n4eoFltxq?=
 =?us-ascii?Q?JG8qSkHg7l7O/wesc1pzgw0xAsTswtbuLIlluSjdBQfzyW8/Z6rLC/ZE1zeh?=
 =?us-ascii?Q?Dlz6UQXYDckDKFt0rL6QBbJmq2NN6VijY4ZpcT9Xfs+k9SzIMQl5c4A5a0ZP?=
 =?us-ascii?Q?shvO8JAuY7MjcWh3cOnUhiSKv8X0VtrACHmtMOL+hxf5HM+7upx86KC+F/DW?=
 =?us-ascii?Q?zNvrMTh3LrQxyLz1eBNW+N8oewm8LXXkys+7oQM7nBgq3ZmXAQvNqPHgNYpi?=
 =?us-ascii?Q?blSrpsXOfJGe/vjj+Eosk17LrRkC4K3p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTj5Qa5GzCU5MI7fdGC0NUxRDySaoKroxX5Lt0gw1fDqYgOIflJ6C3fz+qTh?=
 =?us-ascii?Q?Z7lX9QqalPrf3yYvOLP59o4fnYs9kvxrAtMx/AmSrZujw7tBkhC+lI7qZ/LV?=
 =?us-ascii?Q?CPP9rbwHNnd83Bz2HN/DboTrngf+ql01fLGBBge5pEZmMz/XH95i9o9+i1Nd?=
 =?us-ascii?Q?zwJfx4UozJeJ82hQpw5sNfhxK9ICIBUNLgPQJHTJMLVD/8h5u0CdTBNVh8PK?=
 =?us-ascii?Q?Npolkt7oAib4JPzoxQ1feBTLqVTGcToiebUy+9jMwYyjXvUTs/73e4spYMlF?=
 =?us-ascii?Q?Kf6DTfb4JS2Cn9ssSXwfllS+x+IaIuz7E+gRiwkdK4oqjfHgsY0CmZW2z3VR?=
 =?us-ascii?Q?1lAEx2lGLkDe/sPDIAT5hBOfrHJ859YAXy9DCyoS6Nj1OB0KecqkN6gMu5sV?=
 =?us-ascii?Q?qFZnT4EbRbSfbuCLPdga2tmtIY31sGUcKrbyNgt+LB/lwk5+YxM/VDHqTEaW?=
 =?us-ascii?Q?LxjKkZ0GXkUjJEd3181fjRNbiO5ETB0mAE8YCkTnycBiIQS0CLZqEB6+bt9V?=
 =?us-ascii?Q?Td/DXUf6kj0jWWn0YH+ZR48H/cWRvR8aGvgx/jC5uEYzswRjEs1xLgYEc9aT?=
 =?us-ascii?Q?nx28HS8s9PaQIKMpWAiUL3z9IbJh9rGct4IaCTGaMcMWGU7pgt6+1JPO2UGg?=
 =?us-ascii?Q?e7uagiCvKMZcqsYOiMj7HgIXX4adV862rPPUQmaBI6HrRwVqlzmXxigU0FBP?=
 =?us-ascii?Q?bhR/Asun0qzi15ZwRxWpNhLWllo5ILlV3ipjuTXWvRQC3o9p+nU+CCl/5NGO?=
 =?us-ascii?Q?zC6D2aumyubBwkplPgvzu9dZGIbYaHlg7fSEQhm2B3AynCp+wtAPYRUJAgwG?=
 =?us-ascii?Q?0E9CQFHoIRxjdaxX2Rtqdd8DIUPMFpyqfJpoKmNA0wCxJ7XsAA6/Ygqbxcin?=
 =?us-ascii?Q?CaCgVCjiOBLTPT+yPLUW21wKBsPXFPWXOXBfLWMaU5rrdZqrNQHtuhhP92L6?=
 =?us-ascii?Q?U6Y6FYAKzNLH+pfQHbk7oJtsDXpHAkhejII1BL65yc1bYbJXMvSE3y2uYPzh?=
 =?us-ascii?Q?bw4nkpddBkLlZhNVYHtt3jj2nyRMKLB04r0/5EKJLEsOke2gl59ZxQMX95Io?=
 =?us-ascii?Q?nIhj9Gu0A2xgC3XpRr9jX13TSQnIQ3IJhIugTY3X6+aSaif+621I3jDX+LPH?=
 =?us-ascii?Q?c7opY2MeiIQAOyZbP3xEO5/cotv32G0WJMDmvBEchh39/+bOYJIB9u2/v9/2?=
 =?us-ascii?Q?KVHvYHi6nv2iXG5tW3apnandzCTm+IS/0FgsAQhQ8DEbk2nO1gYbD1ze5BXm?=
 =?us-ascii?Q?J53y8gBxD/hrnmc38SJC6zjvFHSKWrfc+WdpVT6liWPov+UnRx8ENZ49cTTJ?=
 =?us-ascii?Q?TJRsUJrp1Xe9fE/JYU2+up86y9iDzP/JSRQ/gKIglWIy4r30FuMm2PpjrIMo?=
 =?us-ascii?Q?HFn2er90HL6iJRLphv13b2Etq0DqMa8MBW4l1jmWsgbspK6RhLw4lTffWSRE?=
 =?us-ascii?Q?EQ+TGOMaygGEe7O7ZUXSVszqb44c3X3Qup7Am6caiAwDUOTvEoPjGWSjHcON?=
 =?us-ascii?Q?G34ALtMNbWgSTccs/Qj0+l7htaZYY24XJiyxglFQq0AIIy0S5vyo8+QSTvX7?=
 =?us-ascii?Q?TQukDeU2jZkYbEDATnzcxEdpV+fLUPPi+0gozkwKyGqNyKpegTHaVyUm5M3f?=
 =?us-ascii?Q?q6so8Uey2/2kHET4RVEyynQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f101e4e0-667c-48c5-7312-08de175ae21c
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 02:20:24.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YTQrlpF/cW1DesEcGLN0KRlIAmy/8HJY0q5XQZzo95pr5B3680agFHBJsF7w8mjKEFkvFgxJKyR7Lk90BTL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2980

On Wed, Oct 29, 2025 at 12:53:40PM -0400, Frank Li wrote:
> On Wed, Oct 29, 2025 at 05:03:21PM +0900, Koichiro Den wrote:
> > Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> > or stopping controller and linking or unlinking functions as you want.
> > In fact, re-linking and re-starting is not possible with the embedded
> > design and leads to oopses.
> >
> > Allocate ntb_dev with devm and add a .remove callback to the pci driver
> > that calls ntb_unregister_device(). This allows a fresh device to be
> > created on the next .bind call.
> >
> > With these changes, the controller can now be stopped, a function
> > unlinked, configfs settings updated, and the controller re-linked and
> > restarted without rebooting the endpoint, as long as the underlying
> > pci_epc_ops .stop() operation is non-destructive, and .start() can
> > restore normal operations.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 66 +++++++++++++++----
> >  1 file changed, 52 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 750a246f79c9..3059ed85a955 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
> >  } __packed;
> >
> >  struct epf_ntb {
> > -	struct ntb_dev ntb;
> > +	struct ntb_dev *ntb;
> >  	struct pci_epf *epf;
> >  	struct config_group group;
> >
> > @@ -144,10 +144,16 @@ struct epf_ntb {
> >  	void __iomem *vpci_mw_addr[MAX_MW];
> >
> >  	struct delayed_work cmd_handler;
> > +
> > +	struct pci_bus *vpci_bus;
> >  };
> >
> >  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> > -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> > +
> > +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> > +{
> > +	return (struct epf_ntb *)ntb->pdev->sysdata;
> > +}
> >
> >  static struct pci_epf_header epf_ntb_header = {
> >  	.vendorid	= PCI_ANY_ID,
> > @@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  	else
> >  		ntb->reg->link_status &= ~LINK_STATUS_UP;
> >
> > -	ntb_link_event(&ntb->ntb);
> > +	ntb_link_event(ntb->ntb);
> >  	return 0;
> >  }
> >
> > @@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  	for (i = 1; i < ntb->db_count; i++) {
> >  		if (ntb->epf_db[i]) {
> >  			ntb->db |= 1 << (i - 1);
> > -			ntb_db_event(&ntb->ntb, i);
> > +			ntb_db_event(ntb->ntb, i);
> >  			ntb->epf_db[i] = 0;
> >  		}
> >  	}
> > @@ -1097,12 +1103,24 @@ static int vpci_scan_bus(void *sysdata)
> >  {
> >  	struct pci_bus *vpci_bus;
> >  	struct epf_ntb *ndev = sysdata;
> > -
> > -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > +	LIST_HEAD(resources);
> > +	static struct resource busn_res = {
> > +		.start = 0,
> > +		.end = 255,
> > +		.flags = IORESOURCE_BUS,
> > +	};
> > +
> > +	pci_add_resource(&resources, &ioport_resource);
> > +	pci_add_resource(&resources, &iomem_resource);
> > +	pci_add_resource(&resources, &busn_res);
> > +
> > +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> > +				     &vpci_ops, sysdata, &resources);
> 
> look this part is not belong to this patch. just change API
> pci_scan_bus() to pci_scan_root_bus()?

To make things work symmetrically and avoid crashes (when unlinking),
pci_scan_bus() needed to be switched to pci_scan_root_bus() to set the
parent device, like no longer existing pci_scan_bus_parented(). Otherwise,
pci_epf_unbind()->epf_ntb_unbind()->pci_remove_root_bus()->pci_bus_release_domain_nr()
would crash.

Perhaps I should've added an explanation for this in the git commit message?

Thanks for reviewing.

-Koichiro

> 
> Frank
> 
> >  	if (!vpci_bus) {
> >  		pr_err("create pci bus failed\n");
> >  		return -EINVAL;
> >  	}
> > +	ndev->vpci_bus = vpci_bus;
> >
> >  	pci_bus_add_devices(vpci_bus);
> >
> > @@ -1147,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	int ret;
> >  	struct device *dev;
> >
> > -	dev = &ntb->ntb.dev;
> > +	dev = &ntb->ntb->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> >  	epf_bar->phys_addr = addr;
> > @@ -1247,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> >  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> >  				PCI_IRQ_MSI, interrupt_num + 1);
> >  	if (ret)
> > -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> > +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
> >
> >  	return ret;
> >  }
> > @@ -1334,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> >  	struct device *dev = &pdev->dev;
> >
> > -	ndev->ntb.pdev = pdev;
> > -	ndev->ntb.topo = NTB_TOPO_NONE;
> > -	ndev->ntb.ops =  &vntb_epf_ops;
> > +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> > +	if (!ndev->ntb)
> > +		return -ENOMEM;
> > +	ndev->ntb->pdev = pdev;
> > +	ndev->ntb->topo = NTB_TOPO_NONE;
> > +	ndev->ntb->ops = &vntb_epf_ops;
> >
> >  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >  	if (ret) {
> > @@ -1344,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  		return ret;
> >  	}
> >
> > -	ret = ntb_register_device(&ndev->ntb);
> > +	ret = ntb_register_device(ndev->ntb);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to register NTB device\n");
> >  		return ret;
> > @@ -1354,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	return 0;
> >  }
> >
> > +static void pci_vntb_remove(struct pci_dev *pdev)
> > +{
> > +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> > +
> > +	if (!ndev || !ndev->ntb)
> > +		return;
> > +
> > +	ntb_unregister_device(ndev->ntb);
> > +	ndev->ntb = NULL;
> > +}
> > +
> >  static struct pci_device_id pci_vntb_table[] = {
> >  	{
> >  		PCI_DEVICE(0xffff, 0xffff),
> > @@ -1365,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
> >  	.name           = "pci-vntb",
> >  	.id_table       = pci_vntb_table,
> >  	.probe          = pci_vntb_probe,
> > +	.remove         = pci_vntb_remove,
> >  };
> >
> >  /* ============ PCIe EPF Driver Bind ====================*/
> > @@ -1447,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
> >  {
> >  	struct epf_ntb *ntb = epf_get_drvdata(epf);
> >
> > +	pci_unregister_driver(&vntb_pci_driver);
> > +
> > +	pci_lock_rescan_remove();
> > +	pci_stop_root_bus(ntb->vpci_bus);
> > +	pci_remove_root_bus(ntb->vpci_bus);
> > +	pci_unlock_rescan_remove();
> > +
> >  	epf_ntb_epc_cleanup(ntb);
> >  	epf_ntb_config_spad_bar_free(ntb);
> > -
> > -	pci_unregister_driver(&vntb_pci_driver);
> >  }
> >
> >  // EPF driver probe
> > --
> > 2.48.1
> >

