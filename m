Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D611C2380
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 08:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBGPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 May 2020 02:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgEBGPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 May 2020 02:15:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B5821775;
        Sat,  2 May 2020 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588400139;
        bh=P1G9XTk6/zTFJDfUeyPIvBiffh6K8okBFUBHJ5TkZvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDu3tcE8yBlXCT4EEkbq6EGPGsc+QaWK+l5JsE7CT1KqGrux/+91GpomWgneZBDGI
         TlaMW6qgHqlCY8eFJaFoc5Z/1nIYSkSgSfYKSV/HqWK1hrlMWyLY9KuEXslxnW4NgZ
         s/BaJy30d8q5L0xLnyVKnmAgWfboXCsNp7jqkUAY=
Date:   Sat, 2 May 2020 08:15:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] driver core: platform: Clarify that IRQ 0 is
 invalid
Message-ID: <20200502061537.GA2527384@kroah.com>
References: <20200501224042.141366-1-helgaas@kernel.org>
 <20200501224042.141366-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501224042.141366-2-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 05:40:41PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> These interfaces return a negative error number or an IRQ:
> 
>   platform_get_irq()
>   platform_get_irq_optional()
>   platform_get_irq_byname()
>   platform_get_irq_byname_optional()
> 
> The function comments suggest checking for error like this:
> 
>   irq = platform_get_irq(...);
>   if (irq < 0)
>     return irq;
> 
> which is what most callers (~900 of 1400) do, so it's implicit that IRQ 0
> is invalid.  But some callers check for "irq <= 0", and it's not obvious
> from the source that we never return an IRQ 0.
> 
> Make this more explicit by updating the comments to say that an IRQ number
> is always non-zero and adding a WARN() if we ever do return zero.  If we do
> return IRQ 0, it likely indicates a bug in the arch-specific parts of
> platform_get_irq().

I worry about adding WARN() as there are systems that do panic_on_warn()
and syzbot trips over this as well.  I don't think that for this issue
it would be a problem, but what really is this warning about that
someone could do anything with?

Other than that minor thing, this looks good to me, thanks for finally
clearing this up.

greg k-h
