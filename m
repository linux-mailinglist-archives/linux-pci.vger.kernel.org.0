Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764578E42A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 06:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfHOEq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 00:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHOEq7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 00:46:59 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D0C2067D;
        Thu, 15 Aug 2019 04:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565844418;
        bh=muop4VkBdxXgt9YydJe41sbU02zM6lsB0q3Ukq8Qzlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLALrF6sJM9KWumiFIrNK6YROHN3WR8rxKA9KpDG5QJkSTWC4Tj/S72almajpspG0
         wCeJFkKS1H9qO/fh3qLi2PMzepCreYJErXpaxP6Iyl96NxumjW8d3bfordtIR4orZh
         HHEJOFZ0s0ejvXtVGeK6Q4jzU4lY/la4HWo+0H9E=
Date:   Wed, 14 Aug 2019 23:46:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Message-ID: <20190815044657.GD253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3dd8c36177ac52d9a87655badb000d11785a5a4a.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd8c36177ac52d9a87655badb000d11785a5a4a.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:05:59PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, PRI Capability checks are repeated across all PRI API's.
> Instead, cache the capability check result in pci_pri_init() and use it
> in other PRI API's. Also, since PRI is a shared resource between PF/VF,
> initialize default values for common PRI features in pci_pri_init().
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c       | 80 ++++++++++++++++++++++++++++-------------
>  include/linux/pci-ats.h |  5 +++
>  include/linux/pci.h     |  1 +
>  3 files changed, 61 insertions(+), 25 deletions(-)
> 

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index cdd936d10f68..280be911f190 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c

> @@ -28,6 +28,8 @@ void pci_ats_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->ats_cap = pos;
> +
> +	pci_pri_init(dev);
>  }
>  
>  /**
> @@ -170,36 +172,72 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>  EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
>  
>  #ifdef CONFIG_PCI_PRI
> +
> +void pci_pri_init(struct pci_dev *pdev)
> +{
> ...
> +}

> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 1a0bdaee2f32..33653d4ca94f 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -6,6 +6,7 @@
>  
>  #ifdef CONFIG_PCI_PRI
>  
> +void pci_pri_init(struct pci_dev *pdev);

pci_pri_init() is implemented and called in drivers/pci/ats.c.  Unless
there's a need to call this from outside ats.c, it should be static
and should not be declared here.

If you can make it static, please also reorder the code so you don't
need a forward declaration in ats.c.

>  int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>  void pci_disable_pri(struct pci_dev *pdev);
>  void pci_restore_pri_state(struct pci_dev *pdev);
> @@ -13,6 +14,10 @@ int pci_reset_pri(struct pci_dev *pdev);
>  
>  #else /* CONFIG_PCI_PRI */
>  
> +static inline void pci_pri_init(struct pci_dev *pdev)
> +{
> +}
> +
>  static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  {
>  	return -ENODEV;
