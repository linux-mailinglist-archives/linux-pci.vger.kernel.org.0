Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772BD26011E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbgIGQ7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 12:59:13 -0400
Received: from foss.arm.com ([217.140.110.172]:41378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731120AbgIGQ7M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 12:59:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B22E31B;
        Mon,  7 Sep 2020 09:59:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C09B53F66E;
        Mon,  7 Sep 2020 09:59:10 -0700 (PDT)
Date:   Mon, 7 Sep 2020 17:59:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Update VMD PM to correctly use generic PCI
 PM
Message-ID: <20200907165908.GC10272@e121166-lin.cambridge.arm.com>
References: <20200806210017.5654-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806210017.5654-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 06, 2020 at 05:00:17PM -0400, Jon Derrick wrote:
> The pci_save_state() call in vmd_suspend() can be performed by
> pci_pm_suspend_irq(). This also allows VMD to benefit from the call into
> pci_prepare_to_sleep().
> 
> The pci_restore_state() call in vmd_resume() was restoring state after
> pci_pm_resume()::pci_restore_standard_config() had already restored
> state. It's also been suspected that the config state should have been
> restored before re-requesting IRQs instead of afterwards.
> 
> This patch removes the pci_save_state()/pci_restore_state() calls in
> vmd_suspend()/vmd_resume() in order to allow proper flow through generic
> PCI core Power Management code.
> 
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> v1->v2: Commit message cleanup
> 
>  drivers/pci/controller/vmd.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to pci/vmd, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 76d8acbee7d5..15c1d85d8780 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -719,7 +719,6 @@ static int vmd_suspend(struct device *dev)
>  	for (i = 0; i < vmd->msix_count; i++)
>  		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
>  
> -	pci_save_state(pdev);
>  	return 0;
>  }
>  
> @@ -737,7 +736,6 @@ static int vmd_resume(struct device *dev)
>  			return err;
>  	}
>  
> -	pci_restore_state(pdev);
>  	return 0;
>  }
>  #endif
> -- 
> 2.18.1
> 
