Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3773DDC5E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 17:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhHBP0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 11:26:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:16606 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhHBP0X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 11:26:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213205256"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="213205256"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:26:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="466334018"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:26:09 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Aug 2021 18:26:07 +0300
Date:   Mon, 2 Aug 2021 18:26:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] thunderbolt: Fix adapter init handling during switch
 add
Message-ID: <YQgOj7elfCp7l4OO@lahna>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-4-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627909100-83338-4-git-send-email-Sanju.Mehta@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 02, 2021 at 07:58:19AM -0500, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Adapter0 (Port0) is the control adapter on the AMD USB4 host router.
> As per USB4 spec in "Section 1.8", Control Adapters do not
> have an Adapter Configuration Space".
> 
> The read requests on Adapter0 time's out and driver initialization fails.
> 
> Hence Disabling the Adapter in case of read-request timeout and continuing
> the driver init.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/thunderbolt/switch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 83b1ef3..effbfe4 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -2747,8 +2747,9 @@ int tb_switch_add(struct tb_switch *sw)
>  			}
>  			ret = tb_init_port(&sw->ports[i]);
>  			if (ret) {
> +				sw->ports[i].disabled = true;
>  				dev_err(&sw->dev, "failed to initialize port %d\n", i);
> -				return ret;
> +				continue;

Instead of this, would it work if we start the loop at 1? In case of the
control adapter (0) tb_port_init() does not do anything useful anyway
and it actually would simplify that function too if we get rid of the
special casing.

>  			}
>  		}
>  
> -- 
> 2.7.4
