Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9523CC3C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHEQdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 12:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgHEQcO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:14 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1004E23331;
        Wed,  5 Aug 2020 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596640149;
        bh=sPumNH+oDoCzxUA5VIDgnxFfDkZJNi+1DpPmcSaIfwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FbL0plJtfqfeN5VA0D4tbXcmeCt69ocMqiUhZU9QJeQa2XplPXMt45lDLdXiGL1nl
         eY446fqyJSmJEJc9Hi0TUclDF4zfANMwKxa8DcUpitPaIYyUCiWDTbCVl39UNoFh4v
         547h/kv6xIqoNoDx/KAzm2Nic99A4oP9JWbiI79c=
Date:   Wed, 5 Aug 2020 10:09:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Message-ID: <20200805150907.GA510270@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731171544.6155-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Vaibhav, Rafael for suspend/resume question]

On Fri, Jul 31, 2020 at 01:15:44PM -0400, Jon Derrick wrote:
> The pci_save_state call in vmd_suspend can be performed by
> pci_pm_suspend_irq. This allows the call to pci_prepare_to_sleep into
> ASPM flow.

Add "()" after function names so they don't look like English words.

What is this "ASPM flow"?  The only ASPM-related code should be
configuration (enable/disable ASPM) (which happens at
enumeration-time, not suspend/resume time) and save/restore if we turn
the device off and we have to reconfigure it when we turn it on again.

> The pci_restore_state call in vmd_resume was restoring state after
> pci_pm_resume->pci_restore_standard_config had already restored state.
> It's also been suspected that the config state should be restored before
> re-requesting IRQs.
> 
> Remove the pci_{save,restore}_state calls in vmd_{suspend,resume} in
> order to allow proper flow through PCI core power management ASPM code.
> 
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 76d8acbee7d5..15c1d85d8780 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -719,7 +719,6 @@ static int vmd_suspend(struct device *dev)
>  	for (i = 0; i < vmd->msix_count; i++)
>  		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
>  
> -	pci_save_state(pdev);

The VMD driver uses generic PM, not legacy PCI PM, so I think removing
the save/restore state from your suspend/resume functions is the right
thing to do.  You should only need to do VMD-specific things there.

I'm not even sure you need to free/request the IRQs in your
suspend/resume.  Maybe Rafael or Vaibhav know.

I just think the justification in the commit log is wrong.

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
