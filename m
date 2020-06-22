Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F76203080
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgFVHRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 03:17:08 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:56736 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgFVHRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 03:17:08 -0400
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 7AA56282585; Mon, 22 Jun 2020 09:17:05 +0200 (CEST)
Date:   Mon, 22 Jun 2020 09:17:05 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Re: Linux v5.8-rc1, pci.c, __pci_enable_wake() bug in checking the
 ret/error value
Message-ID: <mj+md-20200622.071630.42474.nikam@ucw.cz>
References: <CAJGKYO5apMp0bDuomks6x2RRHaApmzyb4WG1avm7RKj59CwA=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJGKYO5apMp0bDuomks6x2RRHaApmzyb4WG1avm7RKj59CwA=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

I'm no longer maintaining the kernel PCI code, so I am forwarding your bug
report to the linux-pci list.

				Martin

>  I was reading the pci.c code and I notice that there is a possible bug on
> Linux v5,8-rc1 (5.6, as well) in __pci_enable_wake function. Reading at
> line 2328:
> 
> error = platform_pci_set_wakeup(dev, true);
> if (ret)
> ret = error;
> if (!ret)
> dev->wakeup_prepared = true;
> 
>  the value of ret is set at the beginning of function to zero and not used
> previously. I think this is a possible bug and it would be fixed by the
> following:
> 
> error = platform_pci_set_wakeup(dev, true);
> if (error)
> ret = error;
> else
> dev->wakeup_prepared = true;
> 
>  The source code I was reading is made available by bootlin trough elixir
> web interface
> 
> https://elixir.bootlin.com/linux/v5.8-rc1/source/drivers/pci/pci.c#L2322
> 
>  I hope this help.
> 
>  Best regards,
> -- 
> Roberto A. Foglietta
> +39.349.33.30.697
