Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97902809EF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 00:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgJAWRn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 18:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgJAWRn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 18:17:43 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9025420738;
        Thu,  1 Oct 2020 22:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601590662;
        bh=QgsY8jGyViSfTb9WzhX4gU2yFRvsgIiYaDpuYDHqOkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pm4oPWJF6gCSJpkpCEQr2Fdkjz+KChBeZq/me6zL5rQfJOrVOKqnXfHM3iGq6a+MT
         7Sm3OxDhRc2AKOrJ7eKo4BsfAR62LDAVDXfsBlf3AtrL9gOaZgtlXx+qmrA/tAuR9a
         aHQCKwBkYpmtYa5C3ZbBGPeGWBEIpnyeY3bWhQnY=
Date:   Thu, 1 Oct 2020 17:17:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v6 2/2] PCI/ASPM: Add support for
 LTR _DSM
Message-ID: <20201001221741.GA2737641@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001214436.2735412-3-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 04:44:36PM -0500, Bjorn Helgaas wrote:
> From: Puranjay Mohan <puranjay12@gmail.com>
> 
> Latency Tolerance Reporting (LTR) is required for the ASPM L1.2 PM
> substate.  Devices with Upstream Ports (Endpoints and Switches) may support
> the optional LTR Capability.  When LTR is enabled, devices transmit LTR
> messages containing Snoop and No-Snoop Latencies upstream.  The L1.2
> substate may be entered if the most recent LTR values are greater than or
> equal to the LTR_L1.2_THRESHOLD from the L1 PM Substates Control 1
> register.
> 
> Add a new function pci_ltr_init() which will be called from
> pci_init_capabilities() to initialize every PCIe device's LTR values.
> Add code in probe.c to evaluate LTR _DSM and save the latencies in pci_dev.

> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2106,6 +2106,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	/* Read latency values (if any) from platform */
> +	pci_acpi_evaluate_ltr_latency(dev);
> +
>  	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>  	if (!(cap & PCI_EXP_DEVCAP2_LTR))
>  		return;
> @@ -2400,6 +2403,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_ptm_init(dev);		/* Precision Time Measurement */
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
> +	pci_ltr_init(dev);		/* Latency Tolerance Reporting */

I don't think we're doing this in quite the right order.  If I
understand correctly, we have this:

  pci_device_add
    pci_configure_device
      pci_configure_ltr
        pci_acpi_evaluate_ltr_latency
          acpi_evaluate_dsm(DSM_PCI_LTR_MAX_LATENCY)
        pcie_capability_set_word(PCI_EXP_DEVCTL2_LTR_EN)  <-- enable LTR
    pci_init_capabilities
      pci_ltr_init
        pci_write_config_word(PCI_LTR_MAX_SNOOP_LAT)  <-- set LTR msg content

So we enable LTR messages before we set the latency values in the LTR
capability.  I think we need to set the values *first*.

>  	pcie_report_downtraining(dev);
