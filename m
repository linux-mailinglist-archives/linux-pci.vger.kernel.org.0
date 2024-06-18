Return-Path: <linux-pci+bounces-8913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FAB90CBBB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 14:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFBF1F23E28
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EC4C9A;
	Tue, 18 Jun 2024 12:31:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428F4C62;
	Tue, 18 Jun 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713889; cv=none; b=QqD+XTSP8+x0V47jmHlZcqW6h7xhI1zGugQnenhKNr6kDnPsztvnZcxaQZTGtRfa2bjjaiovQ4GWZuSPX4JprtcznYp8eGbOBkZo2j/GPMdCEU7A+iYwy1EqcZr09uLkJ+xbHl8848c0bTAdvZ9leI58rYvd0DXXxAKnbQJJ7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713889; c=relaxed/simple;
	bh=pbx/8Cs9YS/lsr4349Y5YozD2V0NuVgLwAltcmo/3DI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BU+PNohM+NxWUUNbD9oxHbDHV1Jys5KTV4vwwrzWH2K61Qgz/leY+6FNGd7Gfxt6bTTEK6RlHtuQceRfeE+3rRY/ANNXpg7cxFCbdG9/MozzXi6ADUvZwR1vVoJe3MKLb6fWQJ8B4IXjZ7ycdtZTzBvnoyEVIJuTyGCWLq2GkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W3R1b1YtDz6K75r;
	Tue, 18 Jun 2024 20:30:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 13ED5140B55;
	Tue, 18 Jun 2024 20:31:16 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Jun
 2024 13:31:15 +0100
Date: Tue, 18 Jun 2024 13:31:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v4 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240618133114.00003a6c@Huawei.com>
In-Reply-To: <20240612180046.1810907-3-dave.jiang@intel.com>
References: <20240612180046.1810907-1-dave.jiang@intel.com>
	<20240612180046.1810907-3-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 10:59:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current bandwidth calculation aggregates all the targets. This simple
> method does not take into account where multiple targets sharing under
> a switch where the aggregated bandwidth can be less or greater than the
> upstream link of the switch.
> 
> To accurately account for the shared upstream uplink cases, a new update
> function is introduced by walking from the leaves to the root of the
> hierarchy and adjust the bandwidth in the process. This process is done
> when all the targets for a region are present but before the final values
> are send to the HMAT handling code cached access_coordinate targets.
> 
> The original perf calculation path was kept to calculate the configurations
> without switches and also keep the latency data as that does not require
> special calculation. The shared upstream link calculation is done as a
> second pass when all the endpoints have arrived.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v4:
> - Deal with case of multiple RPs under same HB. (Jonathan)
If I read this right (I haven't tested it yet) the host bridge calculation
for

 *                 CFMWS 0
 *                   |
 *          _________|_________
 *         |                   |
 *     ACPI0017-0          ACPI0017-1
 *  GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
 *     |     |    |        |     |      |
 *    RP0   RP1  RP2      RP3   RP4    RP5
 *     |          |        |           |
 *   SW 0       SW 1     SW 2        SW 3
 *   |   |      |   |    |   |       |   |
 *  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7

Takes into account RP1 and RP4.  I don't think it should.
We are aiming for something analogous to HMAT and that assumes
no other traffic in flight across shared links (that aren't
represented because it is point 2 point - so unloaded bandwidth
measurements.  Therefore we should only care about min BW
through RP0 and RP2 against GP0 BW.

A few other things inline.




>   Change also pass no switch case through the same code path.
> - Update layout graph with ACPI0016 (Alison)
> - Fix over indentation (Jonathan)
> - Move allocated context variable to scope. (Jonathan)
> - Remove unnecessary casting. (Jonathan)
> - Fixup in code comments. (Jonathan)
> ---
>  drivers/cxl/core/cdat.c   | 452 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/core.h   |   4 +-
>  drivers/cxl/core/pci.c    |  23 ++
>  drivers/cxl/core/port.c   |  22 +-
>  drivers/cxl/core/region.c |   4 +
>  drivers/cxl/cxl.h         |   1 +
>  6 files changed, 487 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index fea214340d4b..5bbea2b3c17b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -548,32 +548,450 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  MODULE_IMPORT_NS(CXL);
>  
> -void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> -				    struct cxl_endpoint_decoder *cxled)
> +static void cxl_bandwidth_add(struct access_coordinate *coord,
> +			      struct access_coordinate *c1,
> +			      struct access_coordinate *c2)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct range dpa = {
> -			.start = cxled->dpa_res->start,
> -			.end = cxled->dpa_res->end,
> -	};
> -	struct cxl_dpa_perf *perf;
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		coord[i].read_bandwidth = c1[i].read_bandwidth +
> +					  c2[i].read_bandwidth;
> +		coord[i].write_bandwidth = c1[i].write_bandwidth +
> +					   c2[i].write_bandwidth;
> +	}
> +}
>  
> -	switch (cxlr->mode) {
> +struct cxl_perf_ctx {
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	int active_rps;
> +};
> +
> +static struct cxl_dpa_perf *cxl_memdev_get_dpa_perf(struct cxl_memdev_state *mds,
> +						    enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
>  	case CXL_DECODER_RAM:
> -		perf = &mds->ram_perf;
> -		break;
> +		return &mds->ram_perf;
>  	case CXL_DECODER_PMEM:
> -		perf = &mds->pmem_perf;
> -		break;
> +		return &mds->pmem_perf;
>  	default:
> -		return;
> +		break;
Why not just return here?
>  	}
>  
> -	lockdep_assert_held(&cxl_dpa_rwsem);
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
> +			      struct resource *dpa_res)
> +{
> +	struct range dpa = {
> +		.start = dpa_res->start,
> +		.end = dpa_res->end,
> +	};
>  
>  	if (!range_contains(&perf->dpa_range, &dpa))
> +		return false;
> +
> +	return true;
Could just do

	return range_contains(&perf->dpa_range, &dpa);

> +}


...

> +static struct xarray *cxl_switch_iterate_coordinates(struct xarray *input_xa,
> +						     bool *parent_is_root)
> +{
> +	struct xarray *res_xa __free(kfree) = kzalloc(sizeof(*res_xa), GFP_KERNEL);
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
> +	*parent_is_root = false;
> +	xa_for_each(input_xa, index, ctx) {
> +		struct cxl_port *parent_port, *port, *gp_port;
> +		struct device *dev = (struct device *)index;
> +		struct cxl_dport *dport;
> +		struct pci_dev *pdev;
> +		bool gp_is_root;
> +
> +		gp_is_root = false;
> +		port = ctx->port;
> +		parent_port = to_cxl_port(port->dev.parent);
> +		if (is_cxl_root(parent_port)) {
> +			*parent_is_root = true;
> +		} else {
> +			gp_port = to_cxl_port(parent_port->dev.parent);
> +			gp_is_root = is_cxl_root(gp_port);
> +		}
> +
> +		dport = port->parent_dport;
> +
> +		/*
> +		 * Create an xarray entry with the key of the upstream
> +		 * port of the upstream switch.
> +		 */
> +		us_index = (unsigned long)parent_port->uport_dev;
> +		us_ctx = xa_load(res_xa, us_index);
> +		if (!us_ctx) {
> +			struct cxl_perf_ctx *n __free(kfree) =
> +				kzalloc(sizeof(*n), GFP_KERNEL);
> +
> +			if (!n)
> +				return ERR_PTR(-ENOMEM);
> +
> +			ptr = xa_store(res_xa, us_index, n, GFP_KERNEL);
> +			if (xa_is_err(ptr))
> +				return ERR_PTR(xa_err(ptr));
> +			us_ctx = no_free_ptr(n);
> +		}
> +
> +		/* Count the active RPs */
> +		if (gp_is_root)
> +			us_ctx->active_rps++;
> +
> +		us_ctx->port = parent_port;
> +		us_ctx->dport = parent_port->parent_dport;
> +
> +		if (*parent_is_root) {
> +			int total_rps = 0;
> +
> +			/* Figure out how many RPs are under the host bridge */
> +			device_for_each_child(dport->dport_dev, &total_rps,
> +					      count_rootport);

Why do we care about the totalRPs?  I think we care about the RPs in being
used for this region only. Analogy is that HMAT only presents bandwidth
with assumption no other traffic going through a shared link etc is
interfering.  So I think this should look just like the link on an switch
upstream port being shared.  Sum all BW below a HB and then find min of
that and the GP BW to that host bridge.  Finally sum across GP values
(i.e. the resulting BWs going to each HB).


> +
> +			if (!total_rps || total_rps < ctx->active_rps)
> +				return ERR_PTR(-EINVAL);
A comment on this condition would be good. I guess this is case of we
haven't found all the expected root ports so will be back later?
> +
> +			/*
> +			 * Determine the actual upstream link bandwidth by the
> +			 * total RPs * active under the HB of the region.

Comment confusing given you divide by total RPS and multiply by active.

> +			 */
> +			for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +				us_ctx->coord[i].read_bandwidth =
> +					us_ctx->coord[i].read_bandwidth +
> +					min(dport->coord[i].read_bandwidth /
> +					    total_rps * ctx->active_rps,
> +					    ctx->coord[i].read_bandwidth);
> +				us_ctx->coord[i].write_bandwidth =
> +					us_ctx->coord[i].read_bandwidth +

read?

> +					min(dport->coord[i].write_bandwidth /
> +					    total_rps * ctx->active_rps,
> +					    ctx->coord[i].write_bandwidth);
> +			}
> +
> +			continue;
> +		}
> +
> +		/* Below is the calculation for another switch upstream */
> +
> +		/*
> +		 * If the device isn't an upstream PCIe port, there's something
> +		 * wrong with the topology.
> +		 */
> +		if (!dev_is_pci(dev))
> +			return ERR_PTR(-EINVAL);
> +
> +		/* Retrieve the upstream link bandwidth */
> +		pdev = to_pci_dev(dev);
> +		rc = cxl_pci_get_bandwidth(pdev, coords);
> +		if (rc)
> +			return ERR_PTR(-ENXIO);
> +
> +		/*
> +		 * Take the min of downstream bandwidth and the upstream link
> +		 * bandwidth.
> +		 */
> +		cxl_coordinates_combine(coords, coords, ctx->coord);
> +		/*
> +		 * Take the min of the calculated bandwdith and the upstream
> +		 * switch SSLBIS bandwidth.
> +		 */
> +		cxl_coordinates_combine(coords, coords, dport->coord);
> +
> +		/*
> +		 * Aggregate the bandwidth based on the upstream switch.
> +		 */
> +		cxl_bandwidth_add(us_ctx->coord, us_ctx->coord, coords);
> +	}
> +
> +	return_ptr(res_xa);
> +}

> +/*
> + * cxl_region_shared_upstream_perf_update - Recalculate the access coordinates
> + * @cxl_region: the cxl region to recalculate
> + *
> + * For certain region construction with endpoints behind CXL switches,
> + * there is the possibility of the total bandwdith for all the endpoints
> + * behind a switch being less or more than the switch upstream link. The
> + * algorithm assumes the configuration is a symmetric topology as that
> + * maximizes performance.
> + *
> + * There can be multiple switches under a RP. There can be multiple RPs under
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
> + * Min (GP0 to CPU BW / total RPs * active RPs,
> + *      Min(SW 0 Upstream Link to RP0 BW,
> + *          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
> + *          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
> + *      Min(SW 1 Upstream Link to RP1 BW,
> + *          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
> + *          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
> + * Min (GP1 to CPU BW / total RPs * active RPs,
> + *      Min(SW 2 Upstream Link to RP2 BW,
> + *          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
> + *          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
> + *      Min(SW 3 Upstream Link to RP3 BW,
> + *          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
> + *          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
> + */
> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr)
> +{
> +	struct xarray *usp_xa, *iter_xa, *working_xa;
> +	bool is_root;
> +	int rc;
> +
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);
> +	if (!usp_xa)
> +		return;
> +
> +	xa_init(usp_xa);
> +
> +	/*
> +	 * Collect aggregated endpoint bandwidth and store the bandwidth in
> +	 * an xarray indexed by the upstream port of the switch or RP. The
> +	 * bandwidth is aggregated per switch. Each endpoint consists of the
> +	 * minimum of bandwidth from DSLBIS from the endpoint CDAT, the endpoint
> +	 * upstream link bandwidth, and the bandwidth from the SSLBIS of the
> +	 * switch CDAT for the switch upstream port to the downstream port that's
> +	 * associated with the endpoint. If the device is directly connected to
> +	 * a RP, then no SSLBIS is involved.
> +	 */
> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
> +
> +		rc = cxl_endpoint_gather_coordinates(cxlr, cxled, usp_xa);
> +		if (rc) {
> +			free_perf_xa(usp_xa);
> +			return;
> +		}
> +	}
> +
> +	iter_xa = usp_xa;
> +	usp_xa = NULL;
> +	/*
> +	 * Iterate through the components in the xarray and aggregate any
> +	 * component that share the same upstream link from the switch.
> +	 * The iteration takes consideration of multi-level switch
> +	 * hierarchy.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the grandparent
> +	 * upstream is a root port, it updates the bandwidth in the
> +	 * xarray by taking the min of the provided bandwidth and
> +	 * the bandwidth from the generic port (divided by the total
> +	 * RPs and multiplied by the number of involved RPs). is_root
> +	 * is set if the parent port is the cxl root.
> +	 */
> +	do {
> +		working_xa = cxl_switch_iterate_coordinates(iter_xa, &is_root);
> +		if (IS_ERR(working_xa))
> +			goto out;
> +		free_perf_xa(iter_xa);
> +		iter_xa = working_xa;
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
> +
> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> +				    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf;
> +
> +	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
> +	if (IS_ERR(perf))
> +		return;
> +
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
>  		return;
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 625394486459..c72a7b9f5e21 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -103,9 +103,11 @@ enum cxl_poison_trace_type {
>  };
>  
>  long cxl_pci_get_latency(struct pci_dev *pdev);
> -
> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
>  bool cxl_need_node_perf_attrs_update(int nid);
> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> +					struct access_coordinate *c);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..d5cca493bb20 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1074,3 +1074,26 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  				     __cxl_endpoint_decoder_reset_detected);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
> +{
> +	int speed, bw;
> +	u16 lnksta;
> +	u32 width;
> +
> +	speed = pcie_link_speed_mbps(pdev);
> +	if (speed < 0)
> +		return -ENXIO;

return speed?  It might be more useful error code.
If there is a reason it needs to be -ENXIO here maybe a comment would
avoid confusion in future.

> +	speed /= BITS_PER_BYTE;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +	bw = speed * width;
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		c[i].read_bandwidth = bw;
> +		c[i].write_bandwidth = bw;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..2d55843e63bf 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2196,7 +2196,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  		},
>  	};
>  	struct cxl_port *iter = port;
> -	struct cxl_dport *dport;
> +	struct cxl_dport *dport = port->parent_dport;

Seems an odd change. Stray?

>  	struct pci_dev *pdev;
>  	struct device *dev;
>  	unsigned int bw;
> @@ -2259,6 +2259,26 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
>  
> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> +					struct access_coordinate *c)
> +{
> +	struct cxl_dport *dport = port->parent_dport;
> +
> +	/* Check this port is connected to a switch DSP and not an RP */
> +	if (parent_port_is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return -ENODEV;
> +
> +	if (!coordinates_valid(dport->coord))
> +		return -EINVAL;
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		c[i].read_bandwidth = dport->coord[i].read_bandwidth;
> +		c[i].write_bandwidth = dport->coord[i].write_bandwidth;
> +	}
> +
> +	return 0;
> +}
> +
>  /* for user tooling to ensure port disable work has completed */
>  static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>  {



