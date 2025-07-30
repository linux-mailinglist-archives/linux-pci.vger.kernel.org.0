Return-Path: <linux-pci+bounces-33170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D5BB15E63
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1C5189B17D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8158328313D;
	Wed, 30 Jul 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="evOs+sUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8E26CE1D;
	Wed, 30 Jul 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872087; cv=none; b=Rl1zU4z3UhN7N5T/MxrSt6IK6fli9c//AVQrs6EJbDUFJFX8Zg4EWNk+LSBaHEfhqnSPnoWp8Y4sAjXgwUcuJwscI+WgIm76wFXAkm9RqFnIGIEfewWzdLH+f4H/7ZdonG+yxvcCypxIIJjOctRpa1XR0qw5ZSNPy/7M6YQJWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872087; c=relaxed/simple;
	bh=udELr8i7MKBg+40QMi0znw8LgSQipPGw8KbLrBcK2oA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWhfgsL/JApxSM8exXmVXi0F+3CNRO1XvC45jOgaI9Olv2UXpYb6h1ZOXNx4MmGAwGrlMRJY02Gzyyp6pP803vc6KdHLp5Jc+qK0IbQEL32KItOj+PBzUkZnjps+nJh4EW9LuXJC6unyEMQlQu08UX22DL0PpTEJG7JGqrzSECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=evOs+sUA; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7Vxid69zRfL2ebFFVMcUyZ2ZAjzALw8kkMHPdwmzWMc=;
	b=evOs+sUAw6peOsbDefxFubI0yUyAT+MLdvPSgjTQ5rjBizTE2SYw+PMVHk2j/P5MmGeoqUzI+
	WkYWolLFf/JT5uytenE1/nop0XHYpEs6m/56t7Ogq5/96i+TFjsXSbkWkgvHSweI+kduLylYUQ/
	+4FyS5drV648YRaxKeFN+m0=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsSxg12tSzN0MS;
	Wed, 30 Jul 2025 18:24:22 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsSx90Vb6z6L50d;
	Wed, 30 Jul 2025 18:23:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A2921402F4;
	Wed, 30 Jul 2025 18:25:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 12:25:51 +0200
Date: Wed, 30 Jul 2025 11:25:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform
 device driver
Message-ID: <20250730112549.00003e7d@huawei.com>
In-Reply-To: <yq5ao6t29hrk.fsf@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-13-aneesh.kumar@kernel.org>
	<20250729182244.00002f4f@huawei.com>
	<yq5ao6t29hrk.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 14:28:55 +0530
Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>=20
> > On Mon, 28 Jul 2025 19:21:49 +0530
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> > =20
>=20
> ...
>=20
> >> +
> >> +#include "rmm-da.h"
> >> +
> >> +/* Number of streams that we can support at the hostbridge level */
> >> +#define CCA_HB_PLATFORM_STREAMS 4
> >> +
> >> +/* Total number of stream id supported at root port level */
> >> +#define MAX_STREAM_ID	256
> >> +
> >> +DEFINE_FREE(vfree, void *, if (!IS_ERR_OR_NULL(_T)) vfree(_T))
> >> +static struct pci_tsm *cca_tsm_pci_probe(struct pci_dev *pdev)
> >> +{
> >> +	int rc;
> >> +	struct pci_host_bridge *hb;
> >> +	struct cca_host_dsc_pf0 *dsc_pf0 __free(vfree) =3D NULL; =20
> >
> > Read the stuff in cleanup.h and work out why this needs
> > changing to be inline below and not use this NULL pattern here
> > (unless you like grumpy Linus ;)
> >
> > Note that with the err_out, even if you do that you'll still be
> > breaking with the guidance doc (and actually causing undefined
> > behavior :)  Get rid of those gotos if you want to use __free()
> >
> > =20
>=20
> I=E2=80=99ve already fixed up similar cases by removing the goto based on=
 cleanup.h
> docs in other functions.I must have missed this one.
>=20
> By the way, isn't using the `NULL` pattern acceptable when there are
> no additional lock variables involved (ie, unwind order doesn't matter)?
> Or should we always follow the pattern below regardless?
>=20
> 	struct cca_host_dsc_pf0 *dsc_pf0 __free(vfree) =3D
> 		vcalloc(sizeof(*dsc_pf0), GFP_KERNEL);

Always do this.  It's not really about what happens today but
more what we might break by failing to notice a future patch causes
problems.  Keeping the unwind ordering tightly couple with setup
means we basically can't get it wrong (famous last words ;)

Jonathan


>=20
> -aneesh


