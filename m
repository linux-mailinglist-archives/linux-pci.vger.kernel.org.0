Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5580C43
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2019 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfHDTxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Aug 2019 15:53:08 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49435 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfHDTxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Aug 2019 15:53:08 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D0DCD100D9411;
        Sun,  4 Aug 2019 21:53:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 88F281EC0; Sun,  4 Aug 2019 21:53:06 +0200 (CEST)
Date:   Sun, 4 Aug 2019 21:53:06 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: pciehp: Do not disable interrupt twice on
 suspend
Message-ID: <20190804195306.gm4livsxkrleaciv@wunner.de>
References: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 03:50:50PM +0300, Mika Westerberg wrote:
> @@ -313,10 +332,12 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
>  	.remove		= pciehp_remove,
>  
>  #ifdef	CONFIG_PM
> +#ifdef	CONFIG_PM_SLEEP
>  	.suspend	= pciehp_suspend,
>  	.resume_noirq	= pciehp_resume_noirq,
> +#endif
>  	.resume		= pciehp_resume,
> -	.runtime_suspend = pciehp_suspend,
> +	.runtime_suspend = pciehp_runtime_suspend,
>  	.runtime_resume	= pciehp_runtime_resume,
>  #endif	/* PM */
>  };

Hm, why isn't ".resume" part of the "#ifdef CONFIG_PM_SLEEP" section?

Otherwise LGTM.

Thanks,

Lukas
