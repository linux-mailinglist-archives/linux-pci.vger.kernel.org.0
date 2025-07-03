Return-Path: <linux-pci+bounces-31348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C9AF6FAD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8186E1C81F98
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221D2E2EE8;
	Thu,  3 Jul 2025 10:06:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFC2E1C69;
	Thu,  3 Jul 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537171; cv=none; b=n32VckriyCl4czQMQxJbiGmHifAhd3B22oTMh56VAcHZZSaz6XvRVCohKAizyurEXQBl2NSt0VD7mhzWR0wZxcs9oMoD1GguKcZWlgGTAr3Zg3IiMHqYt+8cv01qOrKY6ophSrVwayKIFqQCCbx5JanfdjqtMU8CRQ/lnYmeAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537171; c=relaxed/simple;
	bh=Fpj1uwcH2xla2wofNQJx+8YAitM91souW9TIhCmfFPk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOY9cQOmAOdXVbba8fjHMxDH9sr+05AUWZD+fTjHovP5RmCR1uhUGU7oJ7pinEP8Efe/YZCItoYRnsmNm+allIwYhnyX5uYLCngLH64VeJiDh4Z8jh0MaaGqhfJGldtdnj/WnhY72ErAzaaJJXWkTKtAJkbUd2O2aRA9uK9KDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXspS1C2Xz67Q1Y;
	Thu,  3 Jul 2025 18:05:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D6BAD1402F5;
	Thu,  3 Jul 2025 18:06:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 12:06:04 +0200
Date: Thu, 3 Jul 2025 11:06:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Message-ID: <20250703110602.0000699c@huawei.com>
In-Reply-To: <a76be312-9f27-491a-99d2-79815ed98d3e@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-6-terry.bowman@amd.com>
	<20250627112429.00007155@huawei.com>
	<a76be312-9f27-491a-99d2-79815ed98d3e@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 11:21:20 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 6/27/2025 5:24 AM, Jonathan Cameron wrote:
> > On Thu, 26 Jun 2025 17:42:40 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> > =20
> >> CXL error handling will soon be moved from the AER driver into the CXL
> >> driver. This requires a notification mechanism for the AER driver to s=
hare
> >> the AER interrupt with the CXL driver. The notification will be used
> >> as an indication for the CXL drivers to handle and log the CXL RAS err=
ors.
> >>
> >> First, introduce cxl/core/native_ras.c to contain changes for the CXL
> >> driver's RAS native handling. This as an alternative to dropping the
> >> changes into existing cxl/core/ras.c file with purpose to avoid #ifdef=
s.
> >> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
> >> conditionally compile the new file.
> >>
> >> Add a kfifo work queue to be used by the AER driver and CXL driver. Th=
e AER
> >> driver will be the sole kfifo producer adding work and the cxl_core wi=
ll be
> >> the sole kfifo consumer removing work. Add the boilerplate kfifo suppo=
rt.
> >>
> >> Add CXL work queue handler registration functions in the AER driver. E=
xport
> >> the functions allowing CXL driver to access. Implement registration
> >> functions for the CXL driver to assign or clear the work handler funct=
ion.
> >>
> >> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data.=
 This
> >> will contain the erring device's PCI SBDF details used to rediscover t=
he
> >> device after the CXL driver dequeues the kfifo work. The device redisc=
overy
> >> will be introduced along with the CXL handling in future patches.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com> =20
> > Hi Terry,
> >
> > Whilst it obviously makes patch preparation a bit more time consuming
> > for series like this with many patches it can be useful to add a brief
> > change log to the individual patches as well as the cover letter.
> > That helps reviewers figure out where they need to look again.
> >
> > A few trivial things inline.
> >
> > With those fixed up
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >
> > Jonathan =20
>=20
> Hi Jonathan,
>=20
> Do you have an example you can point me to with a change log in the
> individual patch? I want to make certain I change correctly.
>=20
> =A0
> > =20
> >> ---

You just put it here.  No particular formatting standard for it other than =
making
sure its after the --- so it doesn't end up in the git log.
https://lore.kernel.org/all/2025070138-vigorous-negative-eae7@gregkh/

Is first example I scrolled down to.  This is a single patch series but
the principle is the same.



