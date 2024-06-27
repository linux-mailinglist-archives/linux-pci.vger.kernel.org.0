Return-Path: <linux-pci+bounces-9388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73D91AE9F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 19:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FB6281B62
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4E19AA42;
	Thu, 27 Jun 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAo31k1T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5F19A2BB;
	Thu, 27 Jun 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511031; cv=none; b=D+TWgvYprT0E72OTiKKArYnuOT/t5Bg51X4e2Dl1ThZ34WEaEB++UWEjV2em1Er/2Ti5ukjNynEP2DvJ0Y/b9YB8Twg+3x2JKvtAZGiHUQIal8X0tXtVrWCR23+gHV+TUXqSk6g0eXex+SVaIxWF8NzM5n7mB1yujYWn/PSmft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511031; c=relaxed/simple;
	bh=8w36D1uha9AAR++PInMuFWxvA+Mm6QUYNE6wXhg0eYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEKFngnLobPjIEAr8R8cD8eceRf6YD7pmxcrmEVHaAlxAjf+2Uay7AjRiOJy+YQnGWtRaPsOK8QzdRWXigtEVygxcwKc521XuXuDSRdvN/XJVjZFRD2vTzLSAQ3WMFa2uM1M1Jt97PZRCQTBsaEoHxbIk9O9b/tQ72tVRawHyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAo31k1T; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719511029; x=1751047029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8w36D1uha9AAR++PInMuFWxvA+Mm6QUYNE6wXhg0eYs=;
  b=JAo31k1TqiiqX4udUAPL+z9xeB7xA1IMeATe3yWXlm8pcupiIuRTlY4g
   xoQ45I3S0ufc0y3a5SENPxf9qhQQN+/OfiI24fchSDN79cwOg8ib4xkG8
   JETET95V1lTyWnYud7GS8p/VUhyWOhIaZ/+J2pkstnimm5oOYyyV4FM0O
   ra4HhIIeIyIFWwAckEl6nRp52OAV0f9Rn9Nl9p9NzHEq6mOJS2UFe7XdQ
   LTFpBXy/0GyUUBVNe6Pm7A5ot17VEQxk7IoqyB8bahwq69VcKJ4KbS7xI
   siSo4sPBv2lN0OmqRmvKi/+Oas/QTrFZ5nNoGSVfGE5Gb74am8i8moa2K
   g==;
X-CSE-ConnectionGUID: jjRGQ8u8T1SDTc9hQNNiwA==
X-CSE-MsgGUID: TQXYArLRQz+RrD/piho8NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27285470"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="27285470"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 10:57:09 -0700
X-CSE-ConnectionGUID: 6eztmD27R+a6IeXfrNAZgQ==
X-CSE-MsgGUID: +zh2WN0+Sx2UUaU5O0dLNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44526871"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.45]) ([10.125.110.45])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 10:57:08 -0700
Message-ID: <7bb708b9-d47e-4244-90a7-dd5dcd01fb63@intel.com>
Date: Thu, 27 Jun 2024 10:57:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240618231730.2533819-1-dave.jiang@intel.com>
 <20240618231730.2533819-3-dave.jiang@intel.com>
 <667d8a3a4cdd2_2ccbfb294e4@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <667d8a3a4cdd2_2ccbfb294e4@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/24 8:50 AM, Ira Weiny wrote:
> Dave Jiang wrote:
>> The current bandwidth calculation aggregates all the targets. This simple
>> method does not take into account where multiple targets sharing under
>> a switch where the aggregated bandwidth can be less or greater than the
>> upstream link of the switch.
>>
>> To accurately account for the shared upstream uplink cases, a new update
>> function is introduced by walking from the leaves to the root of the
>> hierarchy and adjust the bandwidth in the process. This process is done
>> when all the targets for a region are present but before the final values
>> are send to the HMAT handling code cached access_coordinate targets.
>>
>> The original perf calculation path was kept to calculate the latency
>> performance data that does not require the shared link consideration.
>> The shared upstream link calculation is done as a second pass when all
>> the endpoints have arrived.
>>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v5:
>> - Fix cxl_memdev_get_dpa_perf() default return. (Jonathan)
>> - Direct return dpa_perf_contains(). (Jonathan)
>> - Fix incorrect bandwidth member reference. (Jonathan)
>> - Direct return error for pcie_link_speed_mbps(). (Jonathan)
>> - Remove stray edit. (Jonathan)
>> - Adjust calculated bandwidth of RPs sharing same host bridge. (Jonathan)
>> - Fix uninit var gp_is_root. (kernel test robot)
>> ---
>>  drivers/cxl/core/cdat.c   | 411 ++++++++++++++++++++++++++++++++++++--
>>  drivers/cxl/core/core.h   |   4 +-
>>  drivers/cxl/core/pci.c    |  23 +++
>>  drivers/cxl/core/port.c   |  20 ++
>>  drivers/cxl/core/region.c |   4 +
>>  drivers/cxl/cxl.h         |   1 +
>>  6 files changed, 446 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index fea214340d4b..72f86bc99750 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -548,32 +548,411 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>  
>>  MODULE_IMPORT_NS(CXL);
>>  
>> -void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>> -				    struct cxl_endpoint_decoder *cxled)
>> +static void cxl_bandwidth_add(struct access_coordinate *coord,
>> +			      struct access_coordinate *c1,
>> +			      struct access_coordinate *c2)
>>  {
>> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> -	struct range dpa = {
>> -			.start = cxled->dpa_res->start,
>> -			.end = cxled->dpa_res->end,
>> -	};
>> -	struct cxl_dpa_perf *perf;
>> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>> +		coord[i].read_bandwidth = c1[i].read_bandwidth +
>> +					  c2[i].read_bandwidth;
>> +		coord[i].write_bandwidth = c1[i].write_bandwidth +
>> +					   c2[i].write_bandwidth;
>> +	}
>> +}
>>  
>> -	switch (cxlr->mode) {
>> +struct cxl_perf_ctx {
>> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>> +	struct cxl_port *port;
>> +};
>> +
>> +static struct cxl_dpa_perf *cxl_memdev_get_dpa_perf(struct cxl_memdev_state *mds,
>> +						    enum cxl_decoder_mode mode)
>> +{
>> +	switch (mode) {
>>  	case CXL_DECODER_RAM:
>> -		perf = &mds->ram_perf;
>> -		break;
>> +		return &mds->ram_perf;
>>  	case CXL_DECODER_PMEM:
>> -		perf = &mds->pmem_perf;
>> -		break;
>> +		return &mds->pmem_perf;
>>  	default:
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>> +			      struct resource *dpa_res)
>> +{
>> +	struct range dpa = {
>> +		.start = dpa_res->start,
>> +		.end = dpa_res->end,
>> +	};
>> +
>> +	return range_contains(&perf->dpa_range, &dpa);
>> +}
>> +
>> +static int cxl_endpoint_gather_coordinates(struct cxl_region *cxlr,
>> +					   struct cxl_endpoint_decoder *cxled,
>> +					   struct xarray *usp_xa)
>> +{
>> +	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct cxl_port *parent_port, *gp_port;
>> +	struct cxl_perf_ctx *perf_ctx;
>> +	struct cxl_dpa_perf *perf;
>> +	bool gp_is_root = false;
>> +	unsigned long index;
>> +	void *ptr;
>> +	int rc;
>> +
>> +	if (cxlds->rcd)
>> +		return -ENODEV;
>> +
>> +	parent_port = to_cxl_port(endpoint->dev.parent);
>> +	gp_port = to_cxl_port(parent_port->dev.parent);
>> +	if (is_cxl_root(gp_port))
>> +		gp_is_root = true;
>> +
>> +	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
>> +	if (IS_ERR(perf))
>> +		return PTR_ERR(perf);
>> +
>> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The index for the xarray is the upstream port device of the upstream
>> +	 * CXL switch.
>> +	 */
>> +	index = (unsigned long)parent_port->uport_dev;
>> +	perf_ctx = xa_load(usp_xa, index);
>> +	if (!perf_ctx) {
>> +		struct cxl_perf_ctx *c __free(kfree) =
>> +			kzalloc(sizeof(*perf_ctx), GFP_KERNEL);
>> +
>> +		if (!c)
>> +			return -ENOMEM;
>> +		ptr = xa_store(usp_xa, index, c, GFP_KERNEL);
>> +		if (xa_is_err(ptr))
>> +			return xa_err(ptr);
>> +		perf_ctx = no_free_ptr(c);
>> +	}
>> +
>> +	/* Direct upstream link from EP bandwidth */
>> +	rc = cxl_pci_get_bandwidth(pdev, pci_coord);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/*
>> +	 * Min of upstream link bandwidth and Endpoint CDAT bandwidth from
>> +	 * DSLBIS.
>> +	 */
>> +	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);
>> +
>> +	/*
>> +	 * If grandparent port is root, then there's no switch involved and
>> +	 * the endpoint is connected to a root port.
>> +	 */
>> +	if (!gp_is_root) {
>> +		/*
>> +		 * Retrieve the switch SSLBIS for switch downstream port
>> +		 * associated with the endpoint bandwidth.
>> +		 */
>> +		rc = cxl_port_get_switch_dport_bandwidth(endpoint, sw_coord);
>> +		if (rc)
>> +			return rc;
>> +
>> +		/*
>> +		 * Min of the earlier coordinates with the switch SSLBIS
>> +		 * bandwidth
>> +		 */
>> +		cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);
>> +	}
>> +
>> +	/*
>> +	 * Aggregate the computed bandwidth with the current aggregated bandwidth
>> +	 * of the endpoints with the same switch upstream port.
>> +	 */
>> +	cxl_bandwidth_add(perf_ctx->coord, perf_ctx->coord, ep_coord);
>> +	perf_ctx->port = parent_port;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct xarray *cxl_switch_iterate_coordinates(struct xarray *input_xa,
>> +						     bool *parent_is_root)
>> +{
>> +	struct xarray *res_xa __free(kfree) = kzalloc(sizeof(*res_xa), GFP_KERNEL);
>> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
>> +	struct cxl_perf_ctx *ctx, *us_ctx;
>> +	unsigned long index, us_index;
>> +	void *ptr;
>> +	int rc;
>> +
>> +	if (!res_xa)
>> +		return ERR_PTR(-ENOMEM);
>> +	xa_init(res_xa);
>> +
>> +	*parent_is_root = false;
>> +	xa_for_each(input_xa, index, ctx) {
>> +		struct cxl_port *parent_port, *port, *gp_port;
>> +		struct device *dev = (struct device *)index;
>> +		struct cxl_dport *dport;
>> +		struct pci_dev *pdev;
>> +		bool gp_is_root;
>> +
>> +		gp_is_root = false;
>> +		port = ctx->port;
>> +		parent_port = to_cxl_port(port->dev.parent);
>> +		if (is_cxl_root(parent_port)) {
>> +			*parent_is_root = true;
>> +		} else {
>> +			gp_port = to_cxl_port(parent_port->dev.parent);
>> +			gp_is_root = is_cxl_root(gp_port);
>> +		}
>> +
>> +		dport = port->parent_dport;
>> +
>> +		/*
>> +		 * Create an xarray entry with the key of the upstream
>> +		 * port of the upstream switch.
>> +		 */
>> +		us_index = (unsigned long)parent_port->uport_dev;
>> +		us_ctx = xa_load(res_xa, us_index);
> 
> Does this handle unbalanced topologies?

No, it does not handle unbalanced topology. Given that such a topology would unbalance the performance, the hope is people would not create such topology regions.

> 
> For example in the first iteration given the following topology:
> 
>        CFMWS 0
>         |
>         |
>         |
>     ACPI0017-0
>  GP0/HB0/ACPI0016-0
>     |       |    |
>    RP0     RP1  RP2
>     |       |    |   <== these ctx's are in usp_xa right?
>   SW 0     EP2  EP3
>   |   |
>  EP0 EP1
> 
> I'm not seeing where those contexts are carried to res_xa.
> 
> 
>> +		if (!us_ctx) {
>> +			struct cxl_perf_ctx *n __free(kfree) =
>> +				kzalloc(sizeof(*n), GFP_KERNEL);
>> +
>> +			if (!n)
>> +				return ERR_PTR(-ENOMEM);
>> +
>> +			ptr = xa_store(res_xa, us_index, n, GFP_KERNEL);
>> +			if (xa_is_err(ptr))
>> +				return ERR_PTR(xa_err(ptr));
>> +			us_ctx = no_free_ptr(n);
>> +		}
>> +
>> +		us_ctx->port = parent_port;
>> +
>> +		/*
>> +		 * Take the min of the downstream aggregated bandwdith and the
>> +		 * GP provided bandwidth if parent is CXL root.
>> +		 */
>> +		if (*parent_is_root) {
>> +			cxl_coordinates_combine(us_ctx->coord, ctx->coord, dport->coord);
>> +			continue;
>> +		}
>> +
>> +		/* Below is the calculation for another switch upstream */
>> +		if (!gp_is_root) {
>> +			/*
>> +			 * If the device isn't an upstream PCIe port, there's something
>> +			 * wrong with the topology.
>> +			 */
>> +			if (!dev_is_pci(dev))
>> +				return ERR_PTR(-EINVAL);
>> +
>> +			/* Retrieve the upstream link bandwidth */
>> +			pdev = to_pci_dev(dev);
>> +			rc = cxl_pci_get_bandwidth(pdev, coords);
>> +			if (rc)
>> +				return ERR_PTR(-ENXIO);
>> +
>> +			/*
>> +			 * Take the min of downstream bandwidth and the upstream link
>> +			 * bandwidth.
>> +			 */
>> +			cxl_coordinates_combine(coords, coords, ctx->coord);
>> +
>> +			/*
>> +			 * Take the min of the calculated bandwdith and the upstream
>> +			 * switch SSLBIS bandwidth.
>> +			 */
>> +			cxl_coordinates_combine(coords, coords, dport->coord);
>> +
>> +			/*
>> +			 * Aggregate the calculated bandwidth common to an upstream
>> +			 * switch.
>> +			 */
>> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord, coords);
>> +		} else {
>> +			/*
>> +			 * Aggregate the bandwidth common to an upstream switch.
>> +			 */
>> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord,
>> +					  ctx->coord);
>> +		}
>> +	}
>> +
>> +	return_ptr(res_xa);
>> +}
>> +
>> +static void cxl_region_update_access_coordinate(struct cxl_region *cxlr,
>> +						struct xarray *input_xa)
>> +{
>> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>> +	struct cxl_perf_ctx *ctx;
>> +	unsigned long index;
>> +
>> +	memset(coord, 0, sizeof(coord));
>> +	xa_for_each(input_xa, index, ctx)
>> +		cxl_bandwidth_add(coord, coord, ctx->coord);
>> +
>> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>> +		cxlr->coord[i].read_bandwidth = coord[i].read_bandwidth;
>> +		cxlr->coord[i].write_bandwidth = coord[i].write_bandwidth;
>> +	}
>> +}
>> +
>> +static void free_perf_xa(struct xarray *xa)
>> +{
>> +	struct cxl_perf_ctx *ctx;
>> +	unsigned long index;
>> +
>> +	if (!xa)
>> +		return;
>> +
>> +	xa_for_each(xa, index, ctx)
>> +		kfree(ctx);
>> +	xa_destroy(xa);
>> +	kfree(xa);
>> +}
>> +
>> +/*
>> + * cxl_region_shared_upstream_perf_update - Recalculate the access coordinates
>> + * @cxl_region: the cxl region to recalculate
>> + *
>> + * For certain region construction with endpoints behind CXL switches,
>> + * there is the possibility of the total bandwdith for all the endpoints
>> + * behind a switch being less or more than the switch upstream link. The
>> + * algorithm assumes the configuration is a symmetric topology as that
>> + * maximizes performance.
>> + *
>> + * There can be multiple switches under a RP. There can be multiple RPs under
>> + * a HB.
>> + *
>> + * An example hierarchy:
>> + *
>> + *                 CFMWS 0
>> + *                   |
>> + *          _________|_________
>> + *         |                   |
>> + *     ACPI0017-0          ACPI0017-1
>> + *  GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
>> + *     |          |        |           |
>> + *    RP0        RP1      RP2         RP3
>> + *     |          |        |           |
>> + *   SW 0       SW 1     SW 2        SW 3
>> + *   |   |      |   |    |   |       |   |
>> + *  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
>> + *
>> + * Computation for the example hierarchy:
>> + *
>> + * Min (GP0 to CPU BW,
>> + *      Min(SW 0 Upstream Link to RP0 BW,
>> + *          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
>> + *          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
>> + *      Min(SW 1 Upstream Link to RP1 BW,
>> + *          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
>> + *          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
>> + * Min (GP1 to CPU BW,
>> + *      Min(SW 2 Upstream Link to RP2 BW,
>> + *          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
>> + *          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
>> + *      Min(SW 3 Upstream Link to RP3 BW,
>> + *          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
>> + *          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
>> + */
>> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr)
>> +{
>> +	struct xarray *usp_xa, *iter_xa, *working_xa;
>> +	bool is_root;
>> +	int rc;
>> +
>> +	lockdep_assert_held(&cxl_dpa_rwsem);
>> +
>> +	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);
>> +	if (!usp_xa)
>>  		return;
>> +
>> +	xa_init(usp_xa);
>> +
>> +	/*
>> +	 * Collect aggregated endpoint bandwidth and store the bandwidth in
>> +	 * an xarray indexed by the upstream port of the switch or RP. The
>> +	 * bandwidth is aggregated per switch. Each endpoint consists of the
>> +	 * minimum of bandwidth from DSLBIS from the endpoint CDAT, the endpoint
>> +	 * upstream link bandwidth, and the bandwidth from the SSLBIS of the
>> +	 * switch CDAT for the switch upstream port to the downstream port that's
>> +	 * associated with the endpoint. If the device is directly connected to
>> +	 * a RP, then no SSLBIS is involved.
>> +	 */
>> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
>> +		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
>> +
>> +		rc = cxl_endpoint_gather_coordinates(cxlr, cxled, usp_xa);
>> +		if (rc) {
>> +			free_perf_xa(usp_xa);
>> +			return;
>> +		}
>>  	}
>>  
>> +	iter_xa = usp_xa;
>> +	usp_xa = NULL;
>> +	/*
>> +	 * Iterate through the components in the xarray and aggregate any
>> +	 * component that share the same upstream link from the switch.
>> +	 * The iteration takes consideration of multi-level switch
>> +	 * hierarchy.
>> +	 *
>> +	 * When cxl_switch_iterate_coordinates() detect the grandparent
>> +	 * upstream is a cxl root, it aggregates the bandwidth under
>> +	 * the host bridge. A RP does not have SSLBIS nor does it have
>> +	 * upstream PCIe link.
>> +	 *
>> +	 * When cxl_switch_iterate_coordinates() detect the parent upstream
>> +	 * is a cxl root, it takes the min() of the aggregated RP perfs and
>> +	 * the bandwidth from the Generic Port (GP). 'is_root' is set at this
>> +	 * point as well.
>> +	 */
>> +	do {
>> +		working_xa = cxl_switch_iterate_coordinates(iter_xa, &is_root);
>> +		if (IS_ERR(working_xa))
>> +			goto out;
>> +		free_perf_xa(iter_xa);
>> +		iter_xa = working_xa;
>> +	} while (!is_root);
>> +
>> +	/*
>> +	 * Aggregate the bandwidths in the xarray (for all the HBs) and update
>> +	 * the region bandwidths with the newly calculated bandwidths.
>> +	 */
>> +	cxl_region_update_access_coordinate(cxlr, iter_xa);
>> +
>> +out:
>> +	free_perf_xa(iter_xa);
>> +}
>> +
>> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>> +				    struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>> +	struct cxl_dpa_perf *perf;
>> +
>> +	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
>> +	if (IS_ERR(perf))
>> +		return;
>> +
>>  	lockdep_assert_held(&cxl_dpa_rwsem);
>>  
>> -	if (!range_contains(&perf->dpa_range, &dpa))
>> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
>>  		return;
>>  
>>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 625394486459..c72a7b9f5e21 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -103,9 +103,11 @@ enum cxl_poison_trace_type {
>>  };
>>  
>>  long cxl_pci_get_latency(struct pci_dev *pdev);
>> -
>> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>>  int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>>  				       enum access_coordinate_class access);
>>  bool cxl_need_node_perf_attrs_update(int nid);
>> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>> +					struct access_coordinate *c);
>>  
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 8567dd11eaac..23b3d59c470d 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1074,3 +1074,26 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>  				     __cxl_endpoint_decoder_reset_detected);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>> +
>> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>> +{
>> +	int speed, bw;
>> +	u16 lnksta;
>> +	u32 width;
>> +
>> +	speed = pcie_link_speed_mbps(pdev);
>> +	if (speed < 0)
>> +		return speed;
>> +	speed /= BITS_PER_BYTE;
>> +
>> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
>> +	bw = speed * width;
>> +
>> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>> +		c[i].read_bandwidth = bw;
>> +		c[i].write_bandwidth = bw;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 887ed6e358fb..054b0db87f6d 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2259,6 +2259,26 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
>>  
>> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>> +					struct access_coordinate *c)
>> +{
>> +	struct cxl_dport *dport = port->parent_dport;
>> +
>> +	/* Check this port is connected to a switch DSP and not an RP */
>> +	if (parent_port_is_cxl_root(to_cxl_port(port->dev.parent)))
>> +		return -ENODEV;
>> +
>> +	if (!coordinates_valid(dport->coord))
>> +		return -EINVAL;
>> +
>> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>> +		c[i].read_bandwidth = dport->coord[i].read_bandwidth;
>> +		c[i].write_bandwidth = dport->coord[i].write_bandwidth;
> 
> Does latency need to be included here?

No. Latencies are calculated in the first pass already and does not need special consideration. In the shared upstream link calculation latencies are not considered and only bandwidths are updated.

> 
> Ira
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /* for user tooling to ensure port disable work has completed */
>>  static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>>  {
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3c2b6144be23..e8b8635ae8ce 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3281,6 +3281,10 @@ static int cxl_region_probe(struct device *dev)
>>  		goto out;
>>  	}
>>  
>> +	down_read(&cxl_dpa_rwsem);
>> +	cxl_region_shared_upstream_perf_update(cxlr);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>>  	/*
>>  	 * From this point on any path that changes the region's state away from
>>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 603c0120cff8..34e83a6c55a1 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -891,6 +891,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  				      struct access_coordinate *coord);
>>  void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>>  				    struct cxl_endpoint_decoder *cxled);
>> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr);
>>  
>>  void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
>>  
>> -- 
>> 2.45.1
>>
> 
> 

