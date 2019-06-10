Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C03B410
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 13:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbfFJLfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 07:35:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58697 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389285AbfFJLfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 07:35:34 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id e76860d1a224c297; Mon, 10 Jun 2019 13:35:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Do not poll for PME if the device is in D3cold
Date:   Mon, 10 Jun 2019 13:35:31 +0200
Message-ID: <3028909.nFgamlJ2Fy@kreacher>
In-Reply-To: <20190605145820.37169-3-mika.westerberg@linux.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com> <20190605145820.37169-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, June 5, 2019 4:58:19 PM CEST Mika Westerberg wrote:
> PME polling does not take into account that a device that is directly
> connected to the host bridge may go into D3cold as well. This leads to a
> situation where the PME poll thread reads from a config space of a
> device that is in D3cold and gets incorrect information because the
> config space is not accessible.
> 
> Here is an example from Intel Ice Lake system where two PCIe root ports
> are in D3cold (I've instrumented the kernel to log the PMCSR register
> contents):
> 
>   [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
>   [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff
> 
> Since 0xffff is interpreted so that PME is pending, the root ports will
> be runtime resumed. This repeats over and over again essentially
> blocking all runtime power management.
> 
> Prevent this from happening by checking whether the device is in D3cold
> before its PME status is read.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 87a1f902fa8e..720da09d4d73 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2060,6 +2060,13 @@ static void pci_pme_list_scan(struct work_struct *work)
>  			 */
>  			if (bridge && bridge->current_state != PCI_D0)
>  				continue;
> +			/*
> +			 * If the device is in D3cold it should not be
> +			 * polled either.
> +			 */
> +			if (pme_dev->dev->current_state == PCI_D3cold)
> +				continue;
> +
>  			pci_pme_wakeup(pme_dev->dev, NULL);
>  		} else {
>  			list_del(&pme_dev->list);
> 




