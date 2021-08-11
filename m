Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21D43E9AF0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhHKW3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 18:29:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:21342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbhHKW3d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 18:29:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202400426"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="202400426"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 15:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="517014040"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2021 15:29:08 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 0AE415808D9;
        Wed, 11 Aug 2021 15:29:08 -0700 (PDT)
Message-ID: <ad6902e0065ee3f44912184a16718f2e7c7448b7.camel@linux.intel.com>
Subject: Re: [PATCH] pci: ptm: remove error message at boot
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Jakub Kicinski <kuba@kernel.org>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com
Date:   Wed, 11 Aug 2021 15:29:07 -0700
In-Reply-To: <20210811185955.3112534-1-kuba@kernel.org>
References: <20210811185955.3112534-1-kuba@kernel.org>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-08-11 at 11:59 -0700, Jakub Kicinski wrote:
> Since commit 39850ed51062 ("PCI/PTM: Save/restore Precision
> Time Measurement Capability for suspend/resume") devices
> which have PTM capability but don't enable it see this
> message on calls to pci_save_state():
> 
>   "no suspend buffer for PTM"
> 
> Drop the message, it's perfectly fine not to use a capability.

Ack. Thanks.

> 
> Fixes: 39850ed51062 ("PCI/PTM: Save/restore Precision Time
> Measurement Capability for suspend/resume")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/pci/pcie/ptm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 95d4eef2c9e8..4810faa67f52 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -60,10 +60,8 @@ void pci_save_ptm_state(struct pci_dev *dev)
>                 return;
>  
>         save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> -       if (!save_state) {
> -               pci_err(dev, "no suspend buffer for PTM\n");
> +       if (!save_state)
>                 return;
> -       }
>  
>         cap = (u16 *)&save_state->cap.data[0];
>         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);


