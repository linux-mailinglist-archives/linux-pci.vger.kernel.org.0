Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C341B053F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDTJJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 05:09:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:21720 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgDTJJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 05:09:17 -0400
IronPort-SDR: ElH6xDf5DxsOdPkWVAl+H9V9kHotBBkT2rAy3WLqifdbdQevjJ22ywLNkPfwx8zS2zDKTEElFo
 ca83FF/yb0RA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 02:09:17 -0700
IronPort-SDR: biERhZ+vFcl9j2ypAfG9Cj5s8s/G8aPIX5fOvx4nYwFDXVv7iTLkOesiftFWSe4KcNyh1fKyaX
 gJxCXzW62XuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="364944929"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Apr 2020 02:09:14 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 20 Apr 2020 12:09:13 +0300
Date:   Mon, 20 Apr 2020 12:09:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org, ani@anirban.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Cleanup unused HP_SUPR_RM macro
Message-ID: <20200420090913.GV2586@lahna.fi.intel.com>
References: <1587303383-37819-1-git-send-email-ani@anisinha.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587303383-37819-1-git-send-email-ani@anisinha.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 19, 2020 at 07:06:20PM +0530, Ani Sinha wrote:
> We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
> Consequently HP_SUPR_RM() macro is not used in the kernel source anymore.
> Let's clean it up.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

BTW, there seem to be other macros like EMI() that is not used anymore
so maybe worth removing them as well.

> ---
>  drivers/pci/hotplug/pciehp.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index ae44f46..5747967 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -148,7 +148,6 @@ struct controller {
>  #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
>  #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>  #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> -#define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
>  #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> -- 
> 2.7.4
