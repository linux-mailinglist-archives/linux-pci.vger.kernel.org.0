Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C05675C1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 19:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiGERab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiGERaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 13:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DAA140FF;
        Tue,  5 Jul 2022 10:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ABFEB8182F;
        Tue,  5 Jul 2022 17:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5DEC341C7;
        Tue,  5 Jul 2022 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657042172;
        bh=YWrrUA+ZThEqJgkFRhkW+/fP3qDvkLvBDTNmHnf+Kj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V3UNQaCys/fZ8TeQRh+T/nkFart0HNbdzKiF9R4VXHbQeuNVoG/x0s+6Fe+NAUyRl
         /QNFr6IDn37Doi78svWdWvatIgRJkGtaMmdrEed4EymcJXzjav939BdcBW6ObiI0c9
         2Aa0uKVZGNj0RnOEjGlbuOBo2bBJ5R3Qi++45uiP5AH+7+ceJDmZrOlajD6mp/CA1x
         iYIKuwxASCRMR/kxskgbEeEpjFyZeXuYIu13S8cHKeC8jQ1O9p7tMLojasIEB1BKZ+
         JRHV4j3rMR0k2G2TJt3up7MzKaCjUvRbg1crQi5d8pwvYRKzZmI4gF2jGYxEzCQ3LL
         PW7yQufXg8jdQ==
Date:   Tue, 5 Jul 2022 12:29:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH RESEND v1 1/2] ACPI/PCI: Make _SRS optional for link
 device
Message-ID: <20220705172931.GA71865@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701161624.2844305-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 06:16:23PM +0200, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> In ACPI 6.4, s6.2.13 "_PRT (PCI Routing Table)", PCI legacy
> interrupts can be described though a link device (first model).
> From s6.2.16 "_SRS (Set Resource Settings)":
> "This optional control method [...]"
> 
> Make it optional to have a _SRS method for link devices.

I think it would be helpful to outline the reason for wanting these
changes in the commit log.  Otherwise we don't know the benefit and
it's harder to justify making the change since it's not an obvious
cleanup.

IIRC from [1] there *is* a good reason: you need to use Interrupt Link
devices so you can specify "level triggered, active high".

Without an Interrupt Link, you would get the default "level triggered,
active low" setting, which apparently isn't compatible with GICv2.

I assume this fixes a device that previously didn't work correctly,
but I don't see the details of that in the bugzilla.  I'm a little
confused about this.  Isn't GICv2 widely used already?  How are things
working now?  Or are there just a lot of broken devices?

[1] https://lore.kernel.org/r/e2ae06ba-de8f-2cae-60fa-fe9a215d779b@arm.com

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215560
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/pci_link.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 58647051c948..129e3e7e80ee 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -288,6 +288,13 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>  	if (!irq)
>  		return -EINVAL;
>  
> +	if (!acpi_has_method(handle, METHOD_NAME__SRS)) {
> +		if (link->irq.active == irq)
> +			return 0;
> +		acpi_handle_err(handle, "Unable to set IRQ %d: No _SRS.\n", irq);
> +		return -ENODEV;
> +	}
> +
>  	resource = kzalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
>  	if (!resource)
>  		return -ENOMEM;
> -- 
> 2.25.1
> 
