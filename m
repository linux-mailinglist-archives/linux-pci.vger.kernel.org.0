Return-Path: <linux-pci+bounces-9010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FD9101D3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122CCB21809
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673821ACE9B;
	Thu, 20 Jun 2024 10:46:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A491ACE79;
	Thu, 20 Jun 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880367; cv=none; b=CDKuiWCFkNEhjmId1DrgfjhTSL7Rzxp6wprh9ElJLUqF0Xgpjc+8nszQldhkMxmAkZVvDG28fJOP7k3M38EeywCG3FnXpIYytVwsy/jA3KLsiBDVhWyjWfK1TrfObIU7/ASwqrcAEMvdA/c+PWOI3lWRmpWQsT6KboTYOoc7AAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880367; c=relaxed/simple;
	bh=3auPvs84nBXS0ErxeIR6tM1pk5EZLzcgu7VOLvDqgrk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHJK4V3y93JP5iHDaHFYaaDHPWuHzaGmDdh4DQ7Kxu1gh/EJ6mK6x/e/w+ovDeKEVjHKKZ+Q6e68ptj2KlpiVVz6QQycHx+Y+DofRCkJznmj37UBkLk8kyIlU6c0zqtfyiHC8jLkHfGfim14bZ+0jNcrVx62ogOoRzty+Y3n+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4cbV5cM7z6JB7h;
	Thu, 20 Jun 2024 18:45:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ADDE140CB1;
	Thu, 20 Jun 2024 18:46:00 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 11:46:00 +0100
Date: Thu, 20 Jun 2024 11:45:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240620114558.0000154d@Huawei.com>
In-Reply-To: <20240618231730.2533819-3-dave.jiang@intel.com>
References: <20240618231730.2533819-1-dave.jiang@intel.com>
	<20240618231730.2533819-3-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 18 Jun 2024 16:16:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current bandwidth calculation aggregates all the targets. This simple
> method does not take into account where multiple targets sharing under
> a switch where the aggregated bandwidth can be less or greater than the
> upstream link of the switch.
>=20
> To accurately account for the shared upstream uplink cases, a new update
> function is introduced by walking from the leaves to the root of the
> hierarchy and adjust the bandwidth in the process. This process is done
> when all the targets for a region are present but before the final values
> are send to the HMAT handling code cached access_coordinate targets.
>=20
> The original perf calculation path was kept to calculate the latency
> performance data that does not require the shared link consideration.
> The shared upstream link calculation is done as a second pass when all
> the endpoints have arrived.
>=20
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.co=
m/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A few trivial things inline. I haven't tested this yet in anger
(as for 'reasons' my test machine is running an emulation of s390 emulating
 x86 this morning and so is a bit busy).

I'll try and get at least some tests done in the near future and the
additional control patches for doing so posted for the QEMU emulation.
Feel free to poke me if I've not given a tested by the end of next week.

In meantime, lgtm.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>=20
> ---
> v5:
> - Fix cxl_memdev_get_dpa_perf() default return. (Jonathan)
> - Direct return dpa_perf_contains(). (Jonathan)
> - Fix incorrect bandwidth member reference. (Jonathan)
> - Direct return error for pcie_link_speed_mbps(). (Jonathan)
> - Remove stray edit. (Jonathan)
> - Adjust calculated bandwidth of RPs sharing same host bridge. (Jonathan)
> - Fix uninit var gp_is_root. (kernel test robot)
> ---
>  drivers/cxl/core/cdat.c   | 411 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/core.h   |   4 +-
>  drivers/cxl/core/pci.c    |  23 +++
>  drivers/cxl/core/port.c   |  20 ++
>  drivers/cxl/core/region.c |   4 +
>  drivers/cxl/cxl.h         |   1 +
>  6 files changed, 446 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index fea214340d4b..72f86bc99750 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c

...

> +static struct cxl_dpa_perf *cxl_memdev_get_dpa_perf(struct cxl_memdev_st=
ate *mds,
> +						    enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
>  	case CXL_DECODER_RAM:
> -		perf =3D &mds->ram_perf;
> -		break;
> +		return &mds->ram_perf;
>  	case CXL_DECODER_PMEM:
> -		perf =3D &mds->pmem_perf;
> -		break;
> +		return &mds->pmem_perf;
>  	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +

Can't get here so delete the below return.

> +	return ERR_PTR(-EINVAL);
> +}

> +static int cxl_endpoint_gather_coordinates(struct cxl_region *cxlr,
> +					   struct cxl_endpoint_decoder *cxled,
> +					   struct xarray *usp_xa)
> +{
> +	struct cxl_port *endpoint =3D to_cxl_port(cxled->cxld.dev.parent);
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
> +	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
> +	struct cxl_port *parent_port, *gp_port;
> +	struct cxl_perf_ctx *perf_ctx;
> +	struct cxl_dpa_perf *perf;
> +	bool gp_is_root =3D false;
> +	unsigned long index;
> +	void *ptr;
> +	int rc;
> +
> +	if (cxlds->rcd)
> +		return -ENODEV;
> +
> +	parent_port =3D to_cxl_port(endpoint->dev.parent);
> +	gp_port =3D to_cxl_port(parent_port->dev.parent);
> +	if (is_cxl_root(gp_port))
> +		gp_is_root =3D true;

	gp_is_root =3D is_cxl_root(gp_port);
and drop the initialization at declaration.
Or just use is_cxl_root(gp_port) at the check below.

Could set all these at declaration though I guess a few lines
would be a bit long.

> +
> +	perf =3D cxl_memdev_get_dpa_perf(mds, cxlr->mode);
> +	if (IS_ERR(perf))
> +		return PTR_ERR(perf);
> +
> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
> +		return -EINVAL;
> +
> +	/*
> +	 * The index for the xarray is the upstream port device of the upstream
> +	 * CXL switch.
> +	 */
> +	index =3D (unsigned long)parent_port->uport_dev;
> +	perf_ctx =3D xa_load(usp_xa, index);
> +	if (!perf_ctx) {
> +		struct cxl_perf_ctx *c __free(kfree) =3D
> +			kzalloc(sizeof(*perf_ctx), GFP_KERNEL);
> +
> +		if (!c)
> +			return -ENOMEM;
> +		ptr =3D xa_store(usp_xa, index, c, GFP_KERNEL);
> +		if (xa_is_err(ptr))
> +			return xa_err(ptr);
> +		perf_ctx =3D no_free_ptr(c);
> +	}
> +
> +	/* Direct upstream link from EP bandwidth */
> +	rc =3D cxl_pci_get_bandwidth(pdev, pci_coord);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Min of upstream link bandwidth and Endpoint CDAT bandwidth from
> +	 * DSLBIS.
> +	 */
> +	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);
> +
> +	/*
> +	 * If grandparent port is root, then there's no switch involved and
> +	 * the endpoint is connected to a root port.
> +	 */
> +	if (!gp_is_root) {
> +		/*
> +		 * Retrieve the switch SSLBIS for switch downstream port
> +		 * associated with the endpoint bandwidth.
> +		 */
> +		rc =3D cxl_port_get_switch_dport_bandwidth(endpoint, sw_coord);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * Min of the earlier coordinates with the switch SSLBIS
> +		 * bandwidth
> +		 */
> +		cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);
> +	}
> +
> +	/*
> +	 * Aggregate the computed bandwidth with the current aggregated bandwid=
th
> +	 * of the endpoints with the same switch upstream port.
> +	 */
> +	cxl_bandwidth_add(perf_ctx->coord, perf_ctx->coord, ep_coord);
> +	perf_ctx->port =3D parent_port;
> +
> +	return 0;
> +}
> +
> +static struct xarray *cxl_switch_iterate_coordinates(struct xarray *inpu=
t_xa,
> +						     bool *parent_is_root)
> +{
> +	struct xarray *res_xa __free(kfree) =3D kzalloc(sizeof(*res_xa), GFP_KE=
RNEL);
> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> +	struct cxl_perf_ctx *ctx, *us_ctx;
> +	unsigned long index, us_index;
> +	void *ptr;
> +	int rc;
> +
> +	if (!res_xa)
> +		return ERR_PTR(-ENOMEM);
> +	xa_init(res_xa);
> +
> +	*parent_is_root =3D false;
> +	xa_for_each(input_xa, index, ctx) {
> +		struct cxl_port *parent_port, *port, *gp_port;
> +		struct device *dev =3D (struct device *)index;
> +		struct cxl_dport *dport;
> +		struct pci_dev *pdev;
> +		bool gp_is_root;
> +
> +		gp_is_root =3D false;
> +		port =3D ctx->port;
> +		parent_port =3D to_cxl_port(port->dev.parent);

Maybe set those at declaration?

> +		if (is_cxl_root(parent_port)) {
> +			*parent_is_root =3D true;
> +		} else {
> +			gp_port =3D to_cxl_port(parent_port->dev.parent);
> +			gp_is_root =3D is_cxl_root(gp_port);
> +		}

=46rom a pure code organization point of view, this could be moved
below the upstream port section to where these are first used.
However I can see some advantage in gathering all the 'who am I'
stuff in one place, even if it costs a few lines of code.
So I'm fine with this if you prefer it.

> +
> +		dport =3D port->parent_dport;
> +
> +		/*
> +		 * Create an xarray entry with the key of the upstream
> +		 * port of the upstream switch.
> +		 */
> +		us_index =3D (unsigned long)parent_port->uport_dev;
> +		us_ctx =3D xa_load(res_xa, us_index);
> +		if (!us_ctx) {
> +			struct cxl_perf_ctx *n __free(kfree) =3D
> +				kzalloc(sizeof(*n), GFP_KERNEL);
> +
> +			if (!n)
> +				return ERR_PTR(-ENOMEM);
> +
> +			ptr =3D xa_store(res_xa, us_index, n, GFP_KERNEL);
> +			if (xa_is_err(ptr))
> +				return ERR_PTR(xa_err(ptr));
> +			us_ctx =3D no_free_ptr(n);
> +		}
> +
> +		us_ctx->port =3D parent_port;
> +
> +		/*
> +		 * Take the min of the downstream aggregated bandwdith and the

bandwidth

> +		 * GP provided bandwidth if parent is CXL root.
> +		 */
> +		if (*parent_is_root) {
> +			cxl_coordinates_combine(us_ctx->coord, ctx->coord, dport->coord);
> +			continue;
> +		}
> +
> +		/* Below is the calculation for another switch upstream */
> +		if (!gp_is_root) {
> +			/*
> +			 * If the device isn't an upstream PCIe port, there's something
> +			 * wrong with the topology.
> +			 */
> +			if (!dev_is_pci(dev))
> +				return ERR_PTR(-EINVAL);
> +
> +			/* Retrieve the upstream link bandwidth */
> +			pdev =3D to_pci_dev(dev);
> +			rc =3D cxl_pci_get_bandwidth(pdev, coords);

might as well combine these 2 lines and drop the pdev local variable
(which otherwise could have been scoped to this if() block

			rc =3D cxl_pci_get_bandwidth(to_pci_dev(dev), coords);

> +			if (rc)
> +				return ERR_PTR(-ENXIO);
> +
> +			/*
> +			 * Take the min of downstream bandwidth and the upstream link
> +			 * bandwidth.
> +			 */
> +			cxl_coordinates_combine(coords, coords, ctx->coord);
> +
> +			/*
> +			 * Take the min of the calculated bandwdith and the upstream
> +			 * switch SSLBIS bandwidth.
> +			 */
> +			cxl_coordinates_combine(coords, coords, dport->coord);
> +
> +			/*
> +			 * Aggregate the calculated bandwidth common to an upstream
> +			 * switch.
> +			 */
> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord, coords);
> +		} else {
> +			/*
> +			 * Aggregate the bandwidth common to an upstream switch.
> +			 */
> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord,
> +					  ctx->coord);
> +		}
> +	}
> +
> +	return_ptr(res_xa);
> +}
> +
> +static void cxl_region_update_access_coordinate(struct cxl_region *cxlr,
> +						struct xarray *input_xa)
> +{
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_perf_ctx *ctx;
> +	unsigned long index;
> +
> +	memset(coord, 0, sizeof(coord));
> +	xa_for_each(input_xa, index, ctx)
> +		cxl_bandwidth_add(coord, coord, ctx->coord);
> +
> +	for (int i =3D 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		cxlr->coord[i].read_bandwidth =3D coord[i].read_bandwidth;
> +		cxlr->coord[i].write_bandwidth =3D coord[i].write_bandwidth;
> +	}
> +}
> +
> +static void free_perf_xa(struct xarray *xa)
> +{
> +	struct cxl_perf_ctx *ctx;
> +	unsigned long index;
> +
> +	if (!xa)
> +		return;
> +
> +	xa_for_each(xa, index, ctx)
> +		kfree(ctx);
> +	xa_destroy(xa);
> +	kfree(xa);
> +}
> +
> +/*
> + * cxl_region_shared_upstream_perf_update - Recalculate the access coord=
inates
> + * @cxl_region: the cxl region to recalculate
> + *
> + * For certain region construction with endpoints behind CXL switches,
> + * there is the possibility of the total bandwdith for all the endpoints
> + * behind a switch being less or more than the switch upstream link. The
> + * algorithm assumes the configuration is a symmetric topology as that
> + * maximizes performance.
> + *
> + * There can be multiple switches under a RP. There can be multiple RPs =
under
> + * a HB.
> + *
> + * An example hierarchy:
> + *
> + *                 CFMWS 0
> + *                   |
> + *          _________|_________
> + *         |                   |
> + *     ACPI0017-0          ACPI0017-1
> + *  GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
> + *     |          |        |           |
> + *    RP0        RP1      RP2         RP3
> + *     |          |        |           |
> + *   SW 0       SW 1     SW 2        SW 3
> + *   |   |      |   |    |   |       |   |
> + *  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> + *
> + * Computation for the example hierarchy:
> + *
> + * Min (GP0 to CPU BW,
> + *      Min(SW 0 Upstream Link to RP0 BW,
> + *          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Li=
nk) +
> + *          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream li=
nk)) +
> + *      Min(SW 1 Upstream Link to RP1 BW,
> + *          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Li=
nk) +
> + *          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream li=
nk))) +
> + * Min (GP1 to CPU BW,
> + *      Min(SW 2 Upstream Link to RP2 BW,
> + *          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Li=
nk) +
> + *          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream li=
nk)) +
> + *      Min(SW 3 Upstream Link to RP3 BW,
> + *          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Li=
nk) +
> + *          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream li=
nk))))
> + */
> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr)
> +{
> +	struct xarray *usp_xa, *iter_xa, *working_xa;
> +	bool is_root;
> +	int rc;
> +
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	usp_xa =3D kzalloc(sizeof(*usp_xa), GFP_KERNEL);
> +	if (!usp_xa)
>  		return;
> +
> +	xa_init(usp_xa);
> +
> +	/*
> +	 * Collect aggregated endpoint bandwidth and store the bandwidth in
> +	 * an xarray indexed by the upstream port of the switch or RP. The
> +	 * bandwidth is aggregated per switch. Each endpoint consists of the
> +	 * minimum of bandwidth from DSLBIS from the endpoint CDAT, the endpoint
> +	 * upstream link bandwidth, and the bandwidth from the SSLBIS of the
> +	 * switch CDAT for the switch upstream port to the downstream port that=
's
> +	 * associated with the endpoint. If the device is directly connected to
> +	 * a RP, then no SSLBIS is involved.
> +	 */
> +	for (int i =3D 0; i < cxlr->params.nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled =3D cxlr->params.targets[i];
> +
> +		rc =3D cxl_endpoint_gather_coordinates(cxlr, cxled, usp_xa);
> +		if (rc) {
> +			free_perf_xa(usp_xa);
> +			return;
> +		}
>  	}
> =20
> +	iter_xa =3D usp_xa;
> +	usp_xa =3D NULL;
> +	/*
> +	 * Iterate through the components in the xarray and aggregate any
> +	 * component that share the same upstream link from the switch.
> +	 * The iteration takes consideration of multi-level switch
> +	 * hierarchy.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the grandparent
> +	 * upstream is a cxl root, it aggregates the bandwidth under
> +	 * the host bridge. A RP does not have SSLBIS nor does it have
> +	 * upstream PCIe link.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the parent upstream
> +	 * is a cxl root, it takes the min() of the aggregated RP perfs and
> +	 * the bandwidth from the Generic Port (GP). 'is_root' is set at this
> +	 * point as well.
> +	 */
> +	do {
> +		working_xa =3D cxl_switch_iterate_coordinates(iter_xa, &is_root);
> +		if (IS_ERR(working_xa))
> +			goto out;
> +		free_perf_xa(iter_xa);
> +		iter_xa =3D working_xa;
> +	} while (!is_root);
> +
> +	/*
> +	 * Aggregate the bandwidths in the xarray (for all the HBs) and update
> +	 * the region bandwidths with the newly calculated bandwidths.
> +	 */
> +	cxl_region_update_access_coordinate(cxlr, iter_xa);
> +
> +out:
> +	free_perf_xa(iter_xa);
> +}


