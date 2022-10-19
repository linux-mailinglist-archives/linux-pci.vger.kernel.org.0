Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6185603D71
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiJSJCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiJSJAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 05:00:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE17F6A48F;
        Wed, 19 Oct 2022 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666169728; x=1697705728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tluH/Cm9rHuVo1oqk9kZY3xo8Ij2/appO2LxOuExjnw=;
  b=TjxMdgtpg7Kof2qdPkLIEEIc9Fp+Z0IV+xyoa/V89FuDRT/7WcaldT4H
   YtxY5y1gdXvpWMTx9IYwJcWd3ZuTPSlR4rDa3gZ7tfAwXI3E+MBk7LGWv
   +agUWxx0UmKjC+USuDEj/hqVLLFQhH7iHMc+4HPR4f7aWDlWmLJTdCXzS
   joTGmQH96vncOv/45RIcKfqJzQnxYru1x2kxgghYUsqOFowicnsaGWrLc
   cIWWgymNTh9dI95EEJ89oOXac00DPryirAnVnz9Nb2200eIJKZgglXyNg
   BCCHN+8gkP/i/8fulVYZrFCkmn5PFo8xQK2ZoIbuLk8Gqbxzt5FBEGqww
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392651196"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="392651196"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 01:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="629154024"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="629154024"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga002.jf.intel.com with SMTP; 19 Oct 2022 01:54:43 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 19 Oct 2022 11:54:42 +0300
Date:   Wed, 19 Oct 2022 11:54:42 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in
 acpi_get_pci_dev()
Message-ID: <Y0+7Ug9Yh6J6uHVr@intel.com>
References: <12097002.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12097002.O9o76ZdvQC@kreacher>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 18, 2022 at 07:34:03PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()") failed
> to reference count the device returned by acpi_get_pci_dev() as
> expected by its callers which in some cases may cause device objects
> to be dropped prematurely.
> 
> Add the missing get_device() to acpi_get_pci_dev().
> 
> Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")

FYI this (and the rtc-cmos regression discussed in
https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/)
took down the entire Intel gfx CI. I've applied both fixes
into our fixup branch and things are looking much healthier
now.

This one caused i915 selftests to eat a lot of POISON_FREE
in the CI. While bisecting it locally I didn't have
poisoning enabled so I got refcount_t undeflows instead.

https://intel-gfx-ci.01.org/tree/drm-tip/index.html has a lot
of colorful boxes to click if you're interested in any of the
logs. The fixes are included in the CI_DRM_12259 build. Earlier
builds were broken.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/pci_root.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-pm/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/pci_root.c
> +++ linux-pm/drivers/acpi/pci_root.c
> @@ -323,6 +323,7 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
>  
>  	list_for_each_entry(pn, &adev->physical_node_list, node) {
>  		if (dev_is_pci(pn->dev)) {
> +			get_device(pn->dev);
>  			pci_dev = to_pci_dev(pn->dev);
>  			break;
>  		}
> 
> 
> 

-- 
Ville Syrjälä
Intel
