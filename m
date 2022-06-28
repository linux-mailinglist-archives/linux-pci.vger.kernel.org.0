Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1457055E640
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347884AbiF1Pg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346821AbiF1Pg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 11:36:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB6344FA;
        Tue, 28 Jun 2022 08:36:26 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXT9f3xLvz6H78J;
        Tue, 28 Jun 2022 23:32:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 17:36:23 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 16:36:23 +0100
Date:   Tue, 28 Jun 2022 16:36:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 07/46] cxl: Introduce cxl_to_{ways,granularity}
Message-ID: <20220628163621.00000005@Huawei.com>
In-Reply-To: <165603875016.551046.17236943065932132355.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603875016.551046.17236943065932132355.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:45:50 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Interleave granularity and ways have CXL specification defined encodings.
> Promote the conversion helpers to a common header, and use them to
> replace other open-coded instances.
> 
> Force caller to consider the error case of the conversion as well.

What was the reasoning behind not just returning the value (rather
than the extra *val parameter)?  Negative values would be errors
still. Plenty of room to do that in an int.

I don't really mind, just feels a tiny bit uglier than it could be.

Also, there is one little unrelated type change in here.

> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c     |   34 +++++++++++++++++++---------------
>  drivers/cxl/core/hdm.c |   35 +++++++++--------------------------
>  drivers/cxl/cxl.h      |   26 ++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 951695cdb455..544cb10ce33e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,10 +9,6 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> -/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> -#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> -#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
> -
>  static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
> @@ -34,7 +30,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  static int cxl_acpi_cfmws_verify(struct device *dev,
>  				 struct acpi_cedt_cfmws *cfmws)
>  {
> -	int expected_len;
> +	unsigned int expected_len, ways;

Type change for expected_len seems fine but isn't mentioned in the patch description.

> +	int rc;
>  
>  	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
>  		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
> @@ -51,14 +48,14 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	if (CFMWS_INTERLEAVE_WAYS(cfmws) > CXL_DECODER_MAX_INTERLEAVE) {
> -		dev_err(dev, "CFMWS Interleave Ways (%d) too large\n",
> -			CFMWS_INTERLEAVE_WAYS(cfmws));
> +	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
> +	if (rc) {
> +		dev_err(dev, "CFMWS Interleave Ways (%d) invalid\n",
> +			cfmws->interleave_ways);
>  		return -EINVAL;
>  	}
>  
> -	expected_len = struct_size((cfmws), interleave_targets,
> -				   CFMWS_INTERLEAVE_WAYS(cfmws));
> +	expected_len = struct_size(cfmws, interleave_targets, ways);
>  
>  	if (cfmws->header.length < expected_len) {
>  		dev_err(dev, "CFMWS length %d less than expected %d\n",
> @@ -87,7 +84,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	struct device *dev = ctx->dev;
>  	struct acpi_cedt_cfmws *cfmws;
>  	struct cxl_decoder *cxld;
> -	int rc, i;
> +	unsigned int ways, i, ig;
> +	int rc;
>  
>  	cfmws = (struct acpi_cedt_cfmws *) header;
>  
> @@ -99,10 +97,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  	}
>  
> -	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
> +	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
> +	if (rc)
> +		return rc;
> +	rc = cxl_to_granularity(cfmws->granularity, &ig);
> +	if (rc)
> +		return rc;
> +	for (i = 0; i < ways; i++)
>  		target_map[i] = cfmws->interleave_targets[i];
>  
> -	cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
> +	cxld = cxl_root_decoder_alloc(root_port, ways);
>  	if (IS_ERR(cxld))
>  		return 0;
>  
> @@ -112,8 +116,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
>  	};
> -	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
> -	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> +	cxld->interleave_ways = ways;
> +	cxld->interleave_granularity = ig;
>  
>  	rc = cxl_decoder_add(cxld, target_map);
>  	if (rc)
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 5c070c93b07f..46635105a1f1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -128,33 +128,12 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
>  
> -static int to_interleave_granularity(u32 ctrl)
> -{
> -	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> -
> -	return 256 << val;
> -}
> -
> -static int to_interleave_ways(u32 ctrl)
> -{
> -	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> -
> -	switch (val) {
> -	case 0 ... 4:
> -		return 1 << val;
> -	case 8 ... 10:
> -		return 3 << (val - 8);
> -	default:
> -		return 0;
> -	}
> -}
> -
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which)
>  {
>  	u64 size, base;
> +	int i, rc;
>  	u32 ctrl;
> -	int i;
>  	union {
>  		u64 value;
>  		unsigned char target_id[8];
> @@ -183,14 +162,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
>  	}
> -	cxld->interleave_ways = to_interleave_ways(ctrl);
> -	if (!cxld->interleave_ways) {
> +	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &cxld->interleave_ways);
> +	if (rc) {
>  		dev_warn(&port->dev,
>  			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
>  			 port->id, cxld->id, ctrl);
> -		return -ENXIO;
> +		return rc;
>  	}
> -	cxld->interleave_granularity = to_interleave_granularity(ctrl);
> +	rc = cxl_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +				&cxld->interleave_granularity);
> +	if (rc)
> +		return rc;
>  
>  	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
>  		cxld->target_type = CXL_DECODER_EXPANDER;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6e08fe8cc0fe..fd02f9e2a829 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -64,6 +64,32 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  	return val ? val * 2 : 1;
>  }
>  
> +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> +static inline int cxl_to_granularity(u16 ig, unsigned int *val)
> +{
> +	if (ig > 6)
> +		return -EINVAL;
> +	*val = 256 << ig;
> +	return 0;
> +}
> +
> +/* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
> +static inline int cxl_to_ways(u8 eniw, unsigned int *val)
> +{
> +	switch (eniw) {
> +	case 0 ... 4:
> +		*val = 1 << eniw;
> +		break;
> +	case 8 ... 10:
> +		*val = 3 << (eniw - 8);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> 

