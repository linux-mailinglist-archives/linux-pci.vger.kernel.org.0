Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF9D558F2C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 05:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiFXDje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 23:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiFXDjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 23:39:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2654FA6;
        Thu, 23 Jun 2022 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656041933; x=1687577933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6fjM5CEJLI9NuNDC02gzwjelwB6yZ3iOyrgm5Ruo8X8=;
  b=Bcd4KXuLIe5yktfWgDnO/iWW6VEaMjapi+ght1gbdHkLPUqA+Gged/43
   KWp6rEUvMZvXP7RHaN9+noJkqqKfsNJzF9ERqoKK05JAG8zUaQb1KcOsn
   ogNBIQhsSWfTbnXAI/qVAwFDyqLTnLuONVf3NBNeKzZxEror5upwStIYZ
   du8dm00kTj2Or0dtT2QIacK/Ug+Z4EZ5Ajv7W8RwgpQvZ6L549EvtIIa6
   /TVyJOymir2/FszUElqUBmUSBfNirVPFAywzP3ltqxrsNR5JC92bdJDsC
   q5kDS1tap6Oo2sexUtM/iXp6gLxcQYr1JduMjhx7YY/ZvAMFCXN+wHBeg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="263950251"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="263950251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:38:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="593031487"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 20:38:35 -0700
Date:   Thu, 23 Jun 2022 20:37:59 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 02/46] cxl/port: Keep port->uport valid for the entire
 life of a port
Message-ID: <20220624033759.GA1558591@alison-desk>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 07:45:14PM -0700, Dan Williams wrote:
> The upcoming region provisioning implementation has a need to
> dereference port->uport during the port unregister flow. Specifically,
> endpoint decoders need to be able to lookup their corresponding memdev
> via port->uport.
> 
> The existing ->dead flag was added for cases where the core was
> committed to tearing down the port, but needed to drop locks before
> calling device_unregister(). Reuse that flag to indicate to
> delete_endpoint() that it has no "release action" work to do as
> unregister_port() will handle it.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/port.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index dbce99bdffab..7810d1a8369b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -370,7 +370,7 @@ static void unregister_port(void *_port)
>  		lock_dev = &parent->dev;
>  
>  	device_lock_assert(lock_dev);
> -	port->uport = NULL;
> +	port->dead = true;
>  	device_unregister(&port->dev);
>  }
>  
> @@ -857,7 +857,7 @@ static void delete_endpoint(void *data)
>  	parent = &parent_port->dev;
>  
>  	device_lock(parent);
> -	if (parent->driver && endpoint->uport) {
> +	if (parent->driver && !endpoint->dead) {
>  		devm_release_action(parent, cxl_unlink_uport, endpoint);
>  		devm_release_action(parent, unregister_port, endpoint);
>  	}
> 
