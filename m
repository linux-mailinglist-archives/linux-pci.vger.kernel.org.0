Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF67D6A1E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfJNT3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 15:29:54 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46625 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfJNT3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 15:29:54 -0400
X-Originating-IP: 90.76.216.45
Received: from windsurf.home (lfbn-1-2159-45.w90-76.abo.wanadoo.fr [90.76.216.45])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CA804FF808;
        Mon, 14 Oct 2019 19:29:39 +0000 (UTC)
Date:   Mon, 14 Oct 2019 21:29:38 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20191014212938.14516102@windsurf.home>
In-Reply-To: <20190522213351.21366-2-repk@triplefau.lt>
References: <20190522213351.21366-2-repk@triplefau.lt>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4git47 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Remi,

On Wed, 22 May 2019 23:33:50 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> When configuring pcie reset pin from gpio (e.g. initially set by
> u-boot) to pcie function this pin goes low for a brief moment
> asserting the PERST# signal. Thus connected device enters fundamental
> reset process and link configuration can only begin after a minimal
> 100ms delay (see [1]).
> 
> Because the pin configuration comes from the "default" pinctrl it is
> implicitly configured before the probe callback is called:
> 
> driver_probe_device()
>   really_probe()
>     ...
>     pinctrl_bind_pins() /* Here pin goes from gpio to PCIE reset
>                            function and PERST# is asserted */
>     ...
>     drv->probe()
> 
> [1] "PCI Express Base Specification", REV. 4.0
>     PCI Express, February 19 2014, 6.6.1 Conventional Reset
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

It is always a bit annoying to add another 100ms in the boot path, but
I don't see an easy alternative solution, so:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
