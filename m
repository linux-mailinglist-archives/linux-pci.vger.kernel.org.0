Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689C558F2D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 05:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiFXDjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 23:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiFXDjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 23:39:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C612663627;
        Thu, 23 Jun 2022 20:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656041940; x=1687577940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NtFtE7qW+K5DUFG3lDhxsR2HkHFGEJGYMaA9IZdhYVk=;
  b=Iwd3XBgCoSN77GT6585Z+0YoEPJFmuARIr3MmaVtX3W4l6nDcIEH572x
   KSArrxoytf0MSWrwMl7OrH4f1jxHaBRr+RqdvBex/A9bODLt69+ttUr+h
   3Zu+pFbVJPMSlYmp/GAi7jz3BrZ/cVATYHoHh0d1xZ7d5lUTTWJquLxFt
   EyR+okqqeJQd8zaAKRMLeK72DmGOPsCAbjqkH5e6l+Z6c3l9Yz+FEJDVd
   lDMPhyXMXviBSIntQiZWGSjsRJ9uyJIEp5z0yaT+VLSWIa1eCoJZWzi1C
   NKnVMq8z5QxdY778l3Sc5nGFxGgaNoJeQzVH+D+HLjCTaYQIpnXRFrCG0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261339952"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261339952"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:39:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="645080505"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:39:00 -0700
Date:   Thu, 23 Jun 2022 20:38:24 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 03/46] cxl/hdm: Use local hdm variable
Message-ID: <20220624033824.GB1558591@alison-desk>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603872171.551046.913207574344536475.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165603872171.551046.913207574344536475.stgit@dwillia2-xfh>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:21PM -0700, Dan Williams wrote:
> From: Ben Widawsky <bwidawsk@kernel.org>
> 
> Save a few characters and use the already initialized local variable.
> 
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/hdm.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bfc8ee876278..ba3d2d959c71 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -251,8 +251,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			return PTR_ERR(cxld);
>  		}
>  
> -		rc = init_hdm_decoder(port, cxld, target_map,
> -				      cxlhdm->regs.hdm_decoder, i);
> +		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
>  		if (rc) {
>  			put_device(&cxld->dev);
>  			failed++;
> 
