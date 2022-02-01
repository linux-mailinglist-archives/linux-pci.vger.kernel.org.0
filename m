Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E74A644D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiBAS4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:56:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:8469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbiBAS4m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 13:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643741802; x=1675277802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuDZ6FPmRuWvBu/he2gXnn3o7JnM46ZE0jP/1sEdyE0=;
  b=NWkzHVxx+0PrXweh3941CmCzBMN/0AkX8UFZ4fg5Ib7SZXeX5NwI9R/F
   eKELASEOqj9osTspQr9qc2+PhBi5LHH1uVc2mO2zZ+eHS2z+09pthC0+7
   Gq4rXpJkjNjJxIDZzqm7MtqEx6U3OsbNO1pejRTaF7NR7JKLf/UBJvIjH
   22PuRnGotha6APrW2ReVrrlqaA1VYooXTFwJcd+4vyJ4Q75zVzr4bXkqf
   8GmrWg+GsRq+FXm2ey9X/lpOgsWC4pR22gYJykud5xbGqsz0IIB/iEWHR
   RmjchQ3fXaz5Avsj+W0ztn1o/iYFCmg7y2PqVAQV6tfaXuRsYvhpzMKCB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245356898"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="245356898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:56:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="771203856"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:56:41 -0800
Date:   Tue, 1 Feb 2022 10:56:40 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 08/10] cxl/cdat: Introduce cdat_hdr_valid()
Message-ID: <20220201185640.4kc5v66vsxd3cial@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201071952.900068-9-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 23:19:50, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CDAT data is protected by a checksum which should be checked when
> the CDAT is read to ensure it is valid.  In addition the lengths
> specified should be checked.
> 
> Introduce cdat_hdr_valid() to check the checksum.  While at it check and
> store the sequence number.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V5
> 	New patch, split out
> 	Update cdat_hdr_valid()
> 		Remove revision and cs field parsing
> 			There is no point in these
> 		Add seq check and debug print.
> ---
>  drivers/cxl/cdat.h |  2 ++
>  drivers/cxl/pci.c  | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> index 4722b6bbbaf0..a7725d26f2d2 100644
> --- a/drivers/cxl/cdat.h
> +++ b/drivers/cxl/cdat.h
> @@ -88,10 +88,12 @@
>   *
>   * @table: cache of CDAT table
>   * @length: length of cached CDAT table
> + * @seq: Last read Sequence number of the CDAT table
>   */
>  struct cxl_cdat {
>  	void *table;
>  	size_t length;
> +	u32 seq;
>  };
>  
>  #endif /* !__CXL_CDAT_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 28b973a9e29e..c362c75feed2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -586,6 +586,35 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +static bool cxl_cdat_hdr_valid(struct device *dev, struct cxl_cdat *cdat)
> +{
> +	u32 *table = cdat->table;
> +	u8 *data8 = cdat->table;
> +	u32 length, seq;
> +	u8 check;
> +	int i;
> +
> +	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, table[0]);
> +	if (length < CDAT_HEADER_LENGTH_BYTES)
> +		return false;
> +
> +	if (length > cdat->length)
> +		return false;
> +
> +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
> +
> +	/* Store the sequence for now. */
> +	if (cdat->seq != seq) {
> +		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
> +		cdat->seq = seq;
> +	}

If sequence hasn't changed you could short-circuit the checksum.

> +
> +	for (check = 0, i = 0; i < length; i++)
> +		check += data8[i];
> +
> +	return check == 0;
> +}
> +
>  #define CDAT_DOE_REQ(entry_handle)					\
>  	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
>  		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> @@ -658,6 +687,9 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
>  
>  	} while (entry_handle != 0xFFFF);
>  
> +	if (!cxl_cdat_hdr_valid(cxlds->dev, cdat))
> +		return -EIO;
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 
