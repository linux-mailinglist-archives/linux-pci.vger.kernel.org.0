Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A873BA79B
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 08:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGCGvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 02:51:25 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50049 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhGCGvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 02:51:25 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 14F42280161D5;
        Sat,  3 Jul 2021 08:48:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 08A11429BE6; Sat,  3 Jul 2021 08:48:48 +0200 (CEST)
Date:   Sat, 3 Jul 2021 08:48:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Krzysztof Wilczy??ski <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: hotplug: Fix kernel-doc formatting and add
 missing documentation
Message-ID: <20210703064848.GA24279@wunner.de>
References: <20210702231541.1671875-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702231541.1671875-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 02, 2021 at 11:15:41PM +0000, Krzysztof Wilczy??ski wrote:
> Fix kernel-doc formatting and add missing documentation for the
[...]
>   drivers/pci/hotplug/pciehp.h:110: warning: Function parameter or member 'inband_presence_disabled' not described in 'controller'
[...]
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 4fd200d8b0a9..c8b2b1e046e8 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -44,38 +44,54 @@ extern int pciehp_poll_time;
>  #define SLOT_NAME_SIZE 10
>  
>  /**
> - * struct controller - PCIe hotplug controller
> - * @pcie: pointer to the controller's PCIe port service device
> - * @slot_cap: cached copy of the Slot Capabilities register
> - * @slot_ctrl: cached copy of the Slot Control register
[...]
> + * struct controller - PCIe hotplug controller.
> + * @pcie:			Pointer to the controller's PCIe port service
> + *				device.
> + * @slot_cap:			Cached copy of the Slot Capabilities register.

Is it really necessary to change the indentation and add the trailing
period *everywhere*?  What value does that add?

Changes like this make it more difficult to determine the commit from
which a certain line originates.

I respectfully submit that the formatting is fine and there's nothing
to be "fixed" here (as the commit message claims).


> + * @inband_presence_disabled:	Flag to used to track whether the in-band
> + *				presence detection is disabled.

That's not proper English and also not very useful because the documentation
merely repeats what the flag's name says.  I'd suggest something along the
lines of:

 * @inband_presence_disabled: whether In-Band Presence Detect Disable is
 *	supported by the controller and disabled per spec recommendation
 *	(PCIe r5.0, appendix I implementation note)

Thanks,

Lukas
