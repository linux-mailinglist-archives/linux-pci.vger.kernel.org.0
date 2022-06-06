Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0753EEA4
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiFFTc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiFFTcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 15:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BB1A81E;
        Mon,  6 Jun 2022 12:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01EBD6149D;
        Mon,  6 Jun 2022 19:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5CEC34119;
        Mon,  6 Jun 2022 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654543942;
        bh=FWYO48tZzW1QrOl5nlcwP2dPQNnXBzxB9LYsv3bKWLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwpVJetskC5OgVjir8JO7mJjMIZfFcjuffoAszOLlB4mIj7lbQlOt4QCBy+HlGlaV
         RAqO0Oy6DmmIep/UbjHokCoGlyD/t9rkSiNH6b1igIxh//XC8mrRU3R1l67i1W/ARy
         rmp0p4W3TpXAgGdYLBs85zH5IwcE2aErjv+rqjaJPG/aOhxsuzpwG2O2r6ZZiGc6L+
         fPOjR9KCdE2iMCeupIYoW91awGzz3NDRtgugq+O70P8u+poHlNRjrTuuxeSPFWdWCy
         8KHD6uj4jjGjv6ihS4EZBIOgyV/nTyVNyqVqrNTOjlaaRiMtGX50JzkYXcv5Ulgwu1
         zD6BrrOVEF0CQ==
Date:   Mon, 6 Jun 2022 12:32:20 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 9/9] cxl/port: Parse out DSMAS data from CDAT table
Message-ID: <20220606193220.aw7ouwtop7lo2gpc@bwidawsk-mobl5>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605005049.2155874-10-ira.weiny@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-06-04 17:50:49, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL Ports with memory devices attached need the information from the
> Device Scoped Memory Affinity Structure (DSMAS).  This information is
> contained within the CDAT table buffer which is previously read and
> cached in the port device.
> 
> If CDAT data is available, parse and cache DSMAS data from the table.
> Store this data in unmarshaled struct dsmas data structures for ease of
> use later.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V8
> 	Adjust to the cdat data being in cxl_port
> 
> Changes from V7
> 	Rebased on cxl-pending
> 
> Changes from V6
> 	Move to port.c
> 	It is not an error if no DSMAS data is found
> 
> Changes from V5
> 	Fix up sparse warnings
> 	Split out cdat_hdr_valid()
> 	Update cdat_hdr_valid()
> 		Remove revision and cs field parsing
> 			There is no point in these
> 		Add seq check and debug print.
> 	From Jonathan
> 		Add spaces around '+' and '/'
> 		use devm_krealloc() for dmas_ary
> ---
>  drivers/cxl/cdat.h     | 17 +++++++++++
>  drivers/cxl/core/pci.c | 65 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 ++
>  drivers/cxl/cxlmem.h   |  4 +++
>  drivers/cxl/cxlpci.h   |  1 +
>  drivers/cxl/mem.c      |  1 +
>  6 files changed, 90 insertions(+)
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> index 3d8945612511..0a510f73fe6d 100644
> --- a/drivers/cxl/cdat.h
> +++ b/drivers/cxl/cdat.h
> @@ -85,6 +85,23 @@
>  
>  #define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
>  
> +/**
> + * struct cxl_dsmas - host unmarshaled version of DSMAS data
> + *
> + * As defined in the Coherent Device Attribute Table (CDAT) specification this
> + * represents a single DSMAS entry in that table.
> + *
> + * @dpa_base: The lowest Device Physical Address associated with this DSMAD
> + * @length: Length in bytes of this DSMAD
> + * @non_volatile: If set, the memory region represents Non-Volatile memory
> + */
> +struct cxl_dsmas {
> +	u64 dpa_base;
> +	u64 length;
> +	/* Flags */
> +	u8 non_volatile:1;
> +};
> +
>  /**
>   * struct cxl_cdat - CXL CDAT data
>   *
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e68f13e66fcf..9666cc4a67aa 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -673,3 +673,68 @@ void read_cdat_data(struct cxl_port *port)
>  		retries);
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> +
> +void parse_dsmas(struct cxl_memdev *cxlmd, struct cxl_port *port)
> +{
> +	struct device *dev = &port->dev;
> +	struct cxl_dsmas *dsmas_ary = NULL;
> +	u32 *data = port->cdat.table;
> +	int bytes_left = port->cdat.length;
> +	int nr_dsmas = 0;
> +
> +	if (!data) {
> +		dev_info(dev, "No CDAT data available for DSMAS\n");
> +		return;
> +	}
> +
> +	/* Skip header */
> +	data += CDAT_HEADER_LENGTH_DW;
> +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> +
> +	while (bytes_left > 0) {
> +		u32 *cur_rec = data;
> +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> +
> +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
> +			struct cxl_dsmas *new_ary;
> +			u8 flags;
> +
> +			new_ary = devm_krealloc(dev, dsmas_ary,
> +					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
> +					   GFP_KERNEL);
> +			if (!new_ary) {
> +				dev_err(dev,
> +					"Failed to allocate memory for DSMAS data (nr_dsmas %d)\n",
> +					nr_dsmas);
> +				return;
> +			}
> +			dsmas_ary = new_ary;

I don't love the realloc on every loop (though I've done something similar
before). What about allocating enough entries port->cdat.length, and then a
single krealloc to shorten the array upon success? I think krealloc pretty much
always succeeds when you shrink FWIW.

> +
> +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);

Does it make sense to test length/bytes_left before reading cur_rec[1]?

> +
> +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> +			dsmas_ary[nr_dsmas].length = CDAT_DSMAS_DPA_LEN(cur_rec);
> +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> +
> +			dev_dbg(dev, "DSMAS %d: %llx:%llx %s\n",
> +				nr_dsmas,
> +				dsmas_ary[nr_dsmas].dpa_base,
> +				dsmas_ary[nr_dsmas].dpa_base +
> +					dsmas_ary[nr_dsmas].length,
> +				(dsmas_ary[nr_dsmas].non_volatile ?
> +					"Persistent" : "Volatile")
> +				);
> +
> +			nr_dsmas++;
> +		}
> +
> +		data += (length / sizeof(u32));
> +		bytes_left -= length;
> +	}
> +
> +	dev_dbg(dev, "Found %d DSMAS entries\n", nr_dsmas);
> +	cxlmd->dsmas_ary = dsmas_ary;
> +	cxlmd->nr_dsmas = nr_dsmas;
> +}
> +EXPORT_SYMBOL_NS_GPL(parse_dsmas, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 531b77d296c7..4d779a8fb807 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -10,6 +10,8 @@
>  #include <linux/io.h>
>  #include "cdat.h"
>  
> +#include "cdat.h"
> +
>  /**
>   * DOC: cxl objects
>   *
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4d2764b865ab..ce5b00f3ebcb 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -36,6 +36,8 @@
>   * @cxlds: The device state backing this device
>   * @detach_work: active memdev lost a port in its ancestry
>   * @id: id number of this memdev instance.
> + * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
> + * @nr_dsmas: Number of entries in dsmas_ary

Personally don't think it's necessary to append "_ary". Up to you.

>   */
>  struct cxl_memdev {
>  	struct device dev;
> @@ -43,6 +45,8 @@ struct cxl_memdev {
>  	struct cxl_dev_state *cxlds;
>  	struct work_struct detach_work;
>  	int id;
> +	struct cxl_dsmas *dsmas_ary;
> +	int nr_dsmas;
>  };
>  
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 71009a167a92..44d1c2b83aab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -76,4 +76,5 @@ struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
>  void cxl_cache_cdat_mb(struct cxl_port *port);
>  void read_cdat_data(struct cxl_port *port);
> +void parse_dsmas(struct cxl_memdev *cxlmd, struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c310f1fd3db0..a8768df4ae38 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -35,6 +35,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);
>  
> +	parse_dsmas(cxlmd, endpoint);
>  	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
>  
>  	if (!endpoint->dev.driver) {
> -- 
> 2.35.1
> 
