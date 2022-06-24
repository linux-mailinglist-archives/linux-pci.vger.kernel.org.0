Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033B7558F45
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiFXDtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFXDtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 23:49:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E644EDDC;
        Thu, 23 Jun 2022 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656042549; x=1687578549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2jvWXqxqmaqnQRPpCuIEFxUoHlta7PtltN07dgU7hUc=;
  b=W8MEnB0p7s2b7Jm8kepy8EvYZS2SgRsvk2eGwggjByJfiMKz69nqfzbF
   Kw0pVrEewUxjpZ5EQvSsNYbzlsfTS3aommfKrDECL8nqKt4AnFqPiZwmj
   FuhxbsDD4O37O/Pq0J7LfLB/AP2UrH0la3uuWQcrP+2ODfxNlf1cH7Ut/
   zHAGSyJcaag2oT2y2xHWu7rHasq29pkQ5J3xV0rIZeMH+UAB1pLw4lbdF
   Ps+FqdWP9r48ag3Q81klPa2dOe0j4YNDNDXY20rHyzGe0vYY0QRr4UrNz
   XJLzva6IaAWUDJoXtdwt747+JYyLGSqT4ZRnon0fv0xMl5CoEp5JkZkx4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="260731802"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="260731802"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:49:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="645083534"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:49:09 -0700
Date:   Thu, 23 Jun 2022 20:48:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 06/46] cxl/core: Drop is_cxl_decoder()
Message-ID: <20220624034833.GD1558591@alison-desk>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603874340.551046.15491766127759244728.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165603874340.551046.15491766127759244728.stgit@dwillia2-xfh>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:43PM -0700, Dan Williams wrote:
> This helper was only used to identify the object type for lockdep
> purposes. Now that lockdep support is done with explicit lock classes,
> this helper can be dropped.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/port.c |    6 ------
>  drivers/cxl/cxl.h       |    1 -
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b51eb41aa839..13c321afe076 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -271,12 +271,6 @@ bool is_root_decoder(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
>  
> -bool is_cxl_decoder(struct device *dev)
> -{
> -	return dev->type && dev->type->release == cxl_decoder_release;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
> -
>  struct cxl_decoder *to_cxl_decoder(struct device *dev)
>  {
>  	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 35ce17872fc1..6e08fe8cc0fe 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -337,7 +337,6 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
> -bool is_cxl_decoder(struct device *dev);
>  struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  					   unsigned int nr_targets);
>  struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> 
