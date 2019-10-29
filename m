Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40CE9117
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 21:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJ2Uy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 16:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfJ2Uy7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 16:54:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8023208E3;
        Tue, 29 Oct 2019 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572382498;
        bh=fRWKdzlU8j22o6ENaferL47IJRTpabXJT7Vi/Zm4l18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rRmkEDjO0yLpFVt5jxGAENCOvzR5c9Dy49qE0aW2lx6ZWFh8vjxFd9o/6el3tOvdl
         BidOizYA7LQtqklw8WId8awtY5O4U7TI3FnHRZf8tJ3uVOoq929ua7Vx7p+tXi4foZ
         tIPme/KPz+gAUMFbNhABnvcQVYd70dfNi8gh1kbU=
Date:   Tue, 29 Oct 2019 15:54:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191029205456.GA100782@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004123947.11087-3-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 03:39:47PM +0300, Mika Westerberg wrote:
> Currently Linux does not follow PCIe spec regarding the required delays
> after reset. A concrete example is a Thunderbolt add-in-card that
> consists of a PCIe switch and two PCIe endpoints:
> ...

> @@ -1025,15 +1025,11 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  	if (state == PCI_D0) {
>  		pci_platform_power_transition(dev, PCI_D0);
>  		/*
> -		 * Mandatory power management transition delays, see
> -		 * PCI Express Base Specification Revision 2.0 Section
> -		 * 6.6.1: Conventional Reset.  Do not delay for
> -		 * devices powered on/off by corresponding bridge,
> -		 * because have already delayed for the bridge.
> +		 * Mandatory power management transition delays are handled
> +		 * in pci_pm_runtime_resume() of the corresponding
> +		 * downstream/root port.
>  		 */
>  		if (dev->runtime_d3cold) {
> -			if (dev->d3cold_delay && !dev->imm_ready)
> -				msleep(dev->d3cold_delay);

This removes the only use of d3cold_delay.  I assume that's
intentional?  If we no longer need it, we might as well remove it from
the pci_dev and remove the places that set it.  It'd be nice if that
could be a separate patch, even if we waited a little longer than
necessary at that one bisection point.

It also removes one of the three uses of imm_ready, leaving only the
two in FLR.  I suspect there are other places we should use imm_ready,
e.g., transitions to/from D1 and D2, but that would be beyond the
scope of this patch.

> +	/*
> +	 * For PCIe downstream and root ports that do not support speeds
> +	 * greater than 5 GT/s need to wait minimum 100 ms. For higher
> +	 * speeds (gen3) we need to wait first for the data link layer to
> +	 * become active.
> +	 *
> +	 * However, 100 ms is the minimum and the PCIe spec says the
> +	 * software must allow at least 1s before it can determine that the
> +	 * device that did not respond is a broken device. There is
> +	 * evidence that 100 ms is not always enough, for example certain
> +	 * Titan Ridge xHCI controller does not always respond to
> +	 * configuration requests if we only wait for 100 ms (see
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
> +	 *
> +	 * Therefore we wait for 100 ms and check for the device presence.
> +	 * If it is still not present give it an additional 100 ms.
> +	 */
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> +		return;

Shouldn't this be:

  if (!pcie_downstream_port(dev))
    return

so we include PCI/PCI-X to PCIe bridges?
