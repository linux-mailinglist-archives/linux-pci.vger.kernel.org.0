Return-Path: <linux-pci+bounces-43206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A627BCC8B6F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C889330DEE4F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E863346791;
	Wed, 17 Dec 2025 15:57:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EB32D0E2;
	Wed, 17 Dec 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987046; cv=none; b=DpG1dToOA8zMknYbzOcV+yyPUBqW/3PwvUkw+DsChQwWtqtOpO+UXbvb2cwyFbkKzcxXX8u/RsiZ17TPJkR2Os7f3g1yV28MwRCrKhRUiaUdX0mwMyiUeYKo9f3GV0nb9DchBuOhxdJ7cHmohCluXvfXygg463PzSFscN9tqODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987046; c=relaxed/simple;
	bh=XEC0sw1lKGw+ejH2oVBrq3vyudUIVNaaYISf01uiF6U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9has+2UjoAmv7A0ZBn4N4I9Kli6EoNRukZTnAtroa7CAtQtNrYaIkTImLG/KnyqUCu18W0qaU0BftOsqInohc42n+q0/aqDA/UzTF905VBIjaGw3g9w9Xxr1Yn0oH8iRCcmYGpOBbgUfLDl1u3fXdCiYsimhpM0T6j6Ibnu1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWdhd1kBWzHnH4s;
	Wed, 17 Dec 2025 23:56:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AEB0040570;
	Wed, 17 Dec 2025 23:57:14 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 15:57:14 +0000
Date: Wed, 17 Dec 2025 15:57:12 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
Message-ID: <20251217155712.000012da@huawei.com>
In-Reply-To: <20251216005616.3090129-7-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
	<20251216005616.3090129-7-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 15 Dec 2025 16:56:16 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Unlike the cxl_pci class driver that opportunistically enables memory
> expansion with no other dependent functionality, CXL accelerator drivers
> have distinct PCIe-only and CXL-enhanced operation states. If CXL is
> available some additional coherent memory/cache operations can be enabled,
> otherwise traditional DMA+MMIO over PCIe/CXL.io is a fallback.
>=20
> Allow for a driver to pass a routine to be called in cxl_mem_probe()
> context. This ability is inspired by and mirrors the semantics of
> faux_device_create(). It allows for the caller to run CXL-topology
> attach-dependent logic on behalf of the caller.

This seems confusing.  The caller is running logic for the caller?
It can do that whenever it likes!  One of those is presumably callee



>=20
> The probe callback runs after the port topology is successfully attached
> for the given memdev.
>=20
> Additionally the presence of @cxlmd->attach indicates that the accelerator
> driver be detached when CXL operation ends. This conceptually makes a CXL
> link loss event mirror a PCIe link loss event which results in triggering
> the ->remove() callback of affected devices+drivers. A driver can re-atta=
ch
> to recover back to PCIe-only operation. Live recovery, i.e. without a
> ->remove()/->probe() cycle, is left as a future consideration. =20
>=20
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com> (=E2=9C=93 DKIM/intel.com)

Have we started adding DKIM stuff to tags?

> Tested-by: Alejandro Lucero <alucerop@amd.com> (=E2=9C=93 DKIM/amd.com)
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One trivial thing on function naming inline.  Either way.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

To me this looks good to start building the other stuff on top of.
Thanks for unblocking this stuff (hopefully)

Jonathan

> ---
>  drivers/cxl/cxlmem.h         | 12 ++++++++++--
>  drivers/cxl/core/memdev.c    | 33 +++++++++++++++++++++++++++++----
>  drivers/cxl/mem.c            | 20 ++++++++++++++++----
>  drivers/cxl/pci.c            |  2 +-
>  tools/testing/cxl/test/mem.c |  2 +-
>  5 files changed, 57 insertions(+), 12 deletions(-)

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 63da2bd4436e..3ab4cd8f19ed 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c


> @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(st=
ruct cxl_memdev *cxlmd)
>  {
>  	int rc;
> =20
> +	/*

The general approach is fine but is the function name appropriate for this
new stuff?  Naturally I'm not suggesting the bikeshed should be any particu=
lar
alternative color just maybe not the current blue.


> +	 * If @attach is provided fail if the driver is not attached upon
> +	 * return. Note that failure here could be the result of a race to
> +	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
> +	 * succeeded and then cxl_mem unbound before the lock is acquired.
> +	 */
> +	guard(device)(&cxlmd->dev);
> +	if (cxlmd->attach && !cxlmd->dev.driver) {
> +		cxl_memdev_unregister(cxlmd);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	rc =3D devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregiste=
r,
>  				      cxlmd);
>  	if (rc)



