Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6163B60A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiK1XjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 18:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiK1XjH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 18:39:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226A1401D
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669678745; x=1701214745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dOW6qCQQ50/Kt9jynMl+xW0QldWfV0F/xgT7P3ROwfU=;
  b=Dd3SzjjqeJQ9VGIw+V0vzGrmt2FcYglaCYnP//3xz1hKV2mWaOgVz0Up
   j5Q09GQw8FEGZMdihxZH3VbxZ+zhDCRzxk88rkncP/z+9/Im9RLLlH5XW
   3+HDe9xTkb/jm2ZZv4ptu50qUEzQQewID8rU9Rw1wlP30DmFJwM7zj6Bj
   kmaJPj2Cfi2KcBYDRG+K/CBCAZsg9uMdfo+MENtmrkRenN2RkdIDzU1Ha
   3PaVUm5aUWH8ts5ELvzqnMMY2PkMc4WOgq6fbeGi9GeFFwsxUO3XXgr+C
   iBW/+6iKRrUD8Wxn9d9nhZ+9W51zlGpNLcUp2rOHcYfhtiUGMvqQhu1ye
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="302559019"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="302559019"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:39:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="637399228"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="637399228"
Received: from fmmunozr-mobl1.amr.corp.intel.com (HELO [10.212.145.95]) ([10.212.145.95])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:39:03 -0800
Message-ID: <ea3fe84c-ec76-86d9-5ec6-22bf73c47756@linux.intel.com>
Date:   Mon, 28 Nov 2022 15:38:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3] PCI: vmd: Fix secondary bus reset for Intel bridges
To:     helgaas@kernel.org, alex.williamson@redhat.com,
        myron.stowe@redhat.com
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
References: <20221103201407.3158-1-francisco.munoz.ruiz@linux.intel.com>
Content-Language: en-US
From:   "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
In-Reply-To: <20221103201407.3158-1-francisco.munoz.ruiz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/3/2022 1:14 PM, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> 
> The reset was never applied in the current implementation because Intel
> Bridges owned by VMD are parentless. Internally, pci_reset_bus() applies
> a reset to the parent of the PCI device supplied as argument, but in this
> case it failed because there wasn't a parent.
> 
> In more detail, this change allows the VMD driver to enumerate NVMe devices
> in pass-through configurations when guest reboots are performed. Commit id
> 6aab5622296b ("PCI: vmd: Clean up domain before enumeration") attempted to
> fix this, but later we discovered that the code inside pci_reset_bus() wasn’t
> triggering secondary bus resets.  Therefore, we updated the parameters passed
> to it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
> VT-d pass-through scenarios.
> 
> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> ---
> V3:
>     - Add WARN_ON
>     - Include Jonathan as reviewer
>     - Update commit message
> V2:
>     - Update commit message
> 
>  drivers/pci/controller/vmd.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..2406be6644f3 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -859,8 +859,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);
> -	list_for_each_entry(child, &vmd->bus->children, node)
> -		pci_reset_bus(child->self);
> +
> +	list_for_each_entry(child, &vmd->bus->children, node) {
> +		if (!list_empty(&child->devices)) {
> +			ret = pci_reset_bus(list_first_entry(&child->devices,
> +							     struct pci_dev,
> +							     bus_list));
> +			WARN_ON(ret);
> +			break;
> +		}
> +	}
> +
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	/*


Hi,

Just a gentle reminder for this one

Best wishes,
Francisco.
