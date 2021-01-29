Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78173308A51
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 17:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhA2Qf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 11:35:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231642AbhA2Qdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 11:33:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0FC164DFB;
        Fri, 29 Jan 2021 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611937470;
        bh=rX//8lmNsK9ouUWLaFuelzOZswldJFRqZnwM9SrzbmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rIdEcRXyknFPg6vCzipnjyc/WTpKmyVlmoOuN2YwQwtLSqPW+EJuS+WD4+mmtmLKX
         5gwOC0Z/ybiPmQnrOTa5DIRP0EqAkElggSbcll5Mb43sr62i2YUhpexHQULXJat2jy
         t8gzwcPAlLkFM/HjstxhS06O3sImop4QIX3GpQsMvn/XvnpP0qeTH6ccTQeGbsJFiT
         43ospAl2b7n4fvB5j2fjm+yxiWBJePUJtikrT7XbZEOnXC501ZBbw0lCpbTd01mHZG
         8npsCU1Y65UT2PgkQ3xfqqvnU5/rvG4k1Qx5v6xqT3b0Q+eY0XRk4h9Z2RwE7u356y
         534BjZuz4AGww==
Date:   Fri, 29 Jan 2021 10:24:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Fix "ordering" comment typos
Message-ID: <20210129162428.GA85218@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126195042.2909405-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 01:50:42PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix comment typos in "ordering".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/s390/include/asm/facility.h             | 2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> Unless somebody objects, I'll just merge these typo fixes via the PCI tree.

Applied to pci/misc for v5.12 with acks from Kalle and Vasily.

> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
> index 68c476b20b57..91b5d714d28f 100644
> --- a/arch/s390/include/asm/facility.h
> +++ b/arch/s390/include/asm/facility.h
> @@ -44,7 +44,7 @@ static inline int __test_facility(unsigned long nr, void *facilities)
>  }
>  
>  /*
> - * The test_facility function uses the bit odering where the MSB is bit 0.
> + * The test_facility function uses the bit ordering where the MSB is bit 0.
>   * That makes it easier to query facility bits with the bit number as
>   * documented in the Principles of Operation.
>   */
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 6e7f16f4cec7..dab190a547cc 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -141,7 +141,7 @@ static void qxl_drm_release(struct drm_device *dev)
>  
>  	/*
>  	 * TODO: qxl_device_fini() call should be in qxl_pci_remove(),
> -	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
> +	 * reordering qxl_modeset_fini() + qxl_device_fini() calls is
>  	 * non-trivial though.
>  	 */
>  	qxl_modeset_fini(qdev);
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
> index 597bc88479ba..04fbfe5cbeb0 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
> @@ -866,7 +866,7 @@ struct iwl_fw_dbg_trigger_time_event {
>   * tx_bar: tid bitmap to configure on what tid the trigger should occur
>   *	when a BAR is send (for an Rx BlocAck session).
>   * frame_timeout: tid bitmap to configure on what tid the trigger should occur
> - *	when a frame times out in the reodering buffer.
> + *	when a frame times out in the reordering buffer.
>   */
>  struct iwl_fw_dbg_trigger_ba {
>  	__le16 rx_ba_start;
> -- 
> 2.25.1
> 
