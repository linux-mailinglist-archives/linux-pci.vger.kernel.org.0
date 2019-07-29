Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B6379B60
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 23:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfG2VoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 17:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfG2VoN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jul 2019 17:44:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BD52067D;
        Mon, 29 Jul 2019 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564436652;
        bh=xFVffMPuzVWewGk2CIxesrHebyRDvumYUACktm8P19E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLgG2ouhZw5043ZZXQje0IdhgzWcHgRz4rgee5YbBRV0J2o9U/Do0HRmyGjfXVxM7
         ml2wJBJCqFBrb5UpquJI5OeKWVBzSA8a9sbl1DZxy70VRuVWf4HO8uY76UihEGQr2J
         Nw++joScR295zEJeTPYFpLyJ8t3ZBFiXPfRVuIzY=
Date:   Mon, 29 Jul 2019 16:44:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2 01/11] PCI: Move #define
 PCI_PM_* lines to drivers/pci/pci.h
Message-ID: <20190729214405.GG203187@google.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-2-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724233848.73327-2-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Rafael, author of commits mentioned below]

On Wed, Jul 24, 2019 at 05:38:38PM -0600, Kelsey Skunberg wrote:
> The #define PCI_PM_* lines are only used within drivers/pci/ and they do
> not need to be seen by the rest of the kernel. Move #define PCI_* to
> drivers/pci/pci.h
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/pci/pci.h   | 5 +++++
>  include/linux/pci.h | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1be03a97cb92..708413632429 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -39,6 +39,11 @@ int pci_probe_reset_function(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  
> +#define PCI_PM_D2_DELAY         200
> +#define PCI_PM_D3_WAIT          10
> +#define PCI_PM_D3COLD_WAIT      100
> +#define PCI_PM_BUS_WAIT         50

Unrelated to *this* patch, but while reviewing, I noticed this a few
lines below:

  static inline void pci_wakeup_event(struct pci_dev *dev)
  {
    /* Wait 100 ms before the system can be put into a sleep state. */
    pm_wakeup_event(&dev->dev, 100);
  }

I'm curious about what this 100ms is and whether it's related to
something in the PCIe spec.  E.g., is this another way of writing
PCI_PM_D3COLD_WAIT?

This constant was added to drivers/pci/pci.c as PCI_WAKEUP_COOLDOWN by
c125e96f0444 ("PM: Make it possible to avoid races between wakeup and
system sleep") and then moved to drivers/pci/pci.h and the name
removed by b6e335aeeb11 ("PCI/PM: Use pm_wakeup_event() directly for
reporting wakeup events").

>  /**
>   * struct pci_platform_pm_ops - Firmware PM callbacks
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9f28..238449460210 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -145,11 +145,6 @@ static inline const char *pci_power_name(pci_power_t state)
>  	return pci_power_names[1 + (__force int) state];
>  }
>  
> -#define PCI_PM_D2_DELAY		200
> -#define PCI_PM_D3_WAIT		10
> -#define PCI_PM_D3COLD_WAIT	100
> -#define PCI_PM_BUS_WAIT		50
> -
>  /**
>   * typedef pci_channel_state_t
>   *
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
