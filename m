Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F01437918
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhJVOgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhJVOgs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 10:36:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4EA60EBD;
        Fri, 22 Oct 2021 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634913270;
        bh=MLWXQ6hUQsgTEzy98KOzfvOMHE4mKkzCkHTij0gPRCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+O1INs+3Nu538GbjhQdOASEO2kI+QqCiyfyA2xPuiG8G8IvtLZqv/v4BZRi/sp0f
         zXLdJQsYg1jhi9E7cw692HKOD6b14Rguv85/ObC/HCNZdKEvIIrwy3mh5EmT1HJOyl
         ENuZ7w0QrlDylHPfFft6YWGjzg5ds2A4wWm2uaPI=
Date:   Fri, 22 Oct 2021 16:34:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Rajat Jain <rajatja@google.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Claire Chang <tientzu@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/6] PCI: allow for callback to prepare nascent subdev
Message-ID: <YXLL8IPz2LcNqEj4@kroah.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022140714.28767-3-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 10:06:55AM -0400, Jim Quinlan wrote:
> We would like the Broadcom STB PCIe root complex driver to be able to turn
> off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> the drivers of these endpoint devices are stock Linux drivers that are not
> aware that these regulator(s) exist and must be turned on for the driver to
> be probed.  The simple solution of course is to turn these regulators on at
> boot and keep them on.  However, this solution does not satisfy at least
> three of our usage modes:
> 
> 1. For example, one customer uses multiple PCIe controllers, but wants the
> ability to, by script, turn any or all of them by and their subdevices off
> to save power, e.g. when in battery mode.
> 
> 2. Another example is when a watchdog script discovers that an endpoint
> device is in an unresponsive state and would like to unbind, power toggle,
> and re-bind just the PCIe endpoint and controller.
> 
> 3. Of course we also want power turned off during suspend mode.  However,
> some endpoint devices may be able to "wake" during suspend and we need to
> recognise this case and veto the nominal act of turning off its regulator.
> Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
> end-point device needs to be kept powered on in order to receive network
> packets and wake-up the system.
> 
> In all of these cases it is advantageous for the PCIe controller to govern
> the turning off/on the regulators needed by the endpoint device.  The first
> two cases can be done by simply unbinding and binding the PCIe controller,
> if the controller has control of these regulators.
> 
> This commit solves the "chicken-and-egg" problem by providing a callback to
> the RC driver when a downstream device is "discovered" by inspecting its
> DT, and allowing said driver to allocate the device object prematurely in
> order to get the regulator(s) and turn them on before the device's ID is
> read.
> 
> [1] These regulators typically govern the actual power supply to the
>     endpoint chip.  Sometimes they may be a the official PCIe socket
>     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
>     the regulator(s) that supply power to the EP chip.
> 
> [2] The 99% configuration of our boards is a single endpoint device
>     attached to the PCIe controller.  I use the term endpoint but it could
>     possible mean a switch as well.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/base/core.c    |  5 +++++
>  drivers/pci/probe.c    | 47 ++++++++++++++++++++++++++++++++----------
>  include/linux/device.h |  3 +++
>  include/linux/pci.h    |  3 +++
>  4 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 249da496581a..62d9ac123ae5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2864,6 +2864,10 @@ static void klist_children_put(struct klist_node *n)
>   */
>  void device_initialize(struct device *dev)
>  {
> +	/* Return if this has been called already. */
> +	if (dev->device_initialized)
> +		return;
> +

Ick, no!  Who would ever be calling this function more than once?  That
"should" be impossible.

This function should only be called by a bus when it first creates the
structure and before anything is done with it.  As the bus itself
controls the creation, it already "knows" when the structure was
initialzed so it should not have to be called again.

Please fix the bus logic that requires this, it is broken.

Consider this a NACK for this patch, sorry.

greg k-h
