Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150DE6B6D94
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 03:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCMCmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Mar 2023 22:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMCmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Mar 2023 22:42:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383CB3B86C;
        Sun, 12 Mar 2023 19:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678675352; x=1710211352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qdm/jfiZDaWQEBwmSVnPVKGRsr/yXOCe4tBu5HDKae4=;
  b=D9+X4eOLDCQSjrAPx/C7ESclZtm+s7n95/TrCS3OtLTLrxI0ifugvZH2
   X4sxle7VjF5DukczaVgrXMOY6mpbzMPwFFlDJJZ+RA47Qsf9h/9k9wO6n
   W1qEsh/nxQsG+VLgd7T3uZqTwYyqUUBq3nazDPXV//fuxUQFh6TCPcf5S
   Q1F/rr8a6QuKrc1YlzS4f1qZiI8nsz0uO6PBYERkKake6hlf0Vsf9Ncrk
   +Oo8hdg1ap+kxfMOo0Rz7vibgquG1sZDCvE8vkolQAEF3X3HusyaCbZUk
   HHM8OtGiAkprH2jNX3KtuzMKxaU04aol9CshDU5f24b6F6VBHzPY0f9jI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="334519468"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="334519468"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 19:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="742694460"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="742694460"
Received: from paulineh-mobl1.amr.corp.intel.com (HELO [10.209.121.144]) ([10.209.121.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 19:42:31 -0700
Message-ID: <db0b9164-09d3-e09d-44fa-948b166e1a1e@linux.intel.com>
Date:   Sun, 12 Mar 2023 19:42:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v4 02/17] cxl/pci: Handle truncated CDAT header
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
References: <cover.1678543498.git.lukas@wunner.de>
 <000e69cd163461c8b1bc2cf4155b6e25402c29c7.1678543498.git.lukas@wunner.de>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <000e69cd163461c8b1bc2cf4155b6e25402c29c7.1678543498.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/11/23 6:40 AM, Lukas Wunner wrote:
> cxl_cdat_get_length() only checks whether the DOE response size is
> sufficient for the Table Access response header (1 dword), but not the
> succeeding CDAT header (1 dword length plus other fields).
> 
> It thus returns whatever uninitialized memory happens to be on the stack
> if a truncated DOE response with only 1 dword was received.  Fix it.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Reported-by: Ming Li <ming4.li@intel.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ming Li <ming4.li@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: stable@vger.kernel.org # v6.0+
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 49a99a84b6aa..87da8c935185 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -510,7 +510,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  		return rc;
>  	}
>  	wait_for_completion(&t.c);
> -	if (t.task.rv < sizeof(__le32))
> +	if (t.task.rv < 2 * sizeof(__le32))
>  		return -EIO;

I think adding a comment about the size requirement would be helpful. But
it is up to you.

>  
>  	*length = le32_to_cpu(t.response_pl[1]);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
