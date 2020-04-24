Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C429D1B8257
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXXKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 19:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXXKE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 19:10:04 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937C420736;
        Fri, 24 Apr 2020 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587769803;
        bh=PKcDmqJNikLgPVx9XOqFdwEmyrGOm/Dt0u+WQR2omNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IuXcmnBHefd7aMWWM9O7FvD2ZAsgusvfcI55sfq2884hl8yhuAs9XW0hDSw31o51T
         jDGfu5TdUsKODPC9hMhOKrhST3iNwvWs4wE92FUNbfSwwmzMEQDs9jEMFi+0IAvDvC
         KtnpyA74GF4/bh3+xjKOjt1zo//ICo0b0fkR5AA8=
Date:   Fri, 24 Apr 2020 18:10:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v1 1/1] PCI/EDR: Change ACPI event message log level
Message-ID: <20200424231002.GA218107@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01afb4e01efbe455de0c445bef6cf3ffc59340d2.1586996350.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 15, 2020 at 05:38:32PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently we have pci_info() message in the beginning of
> edr_handle_event() function, which will be printing
> notification details every-time firmware sends ACPI SYSTEM
> level events. This will pollute the dmesg logs for systems
> that has lot for ACPI system level notifications. So change
> the log-level to pci_dbg, and add a new info log for EDR
> events.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/edr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 594622a6cb16..e346c82559fa 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -148,11 +148,13 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
>  	u16 status;
>  
> -	pci_info(pdev, "ACPI event %#x received\n", event);
> +	pci_dbg(pdev, "ACPI event %#x received\n", event);

I agree this looks excessively verbose.  Do we even need a pci_dbg()
message here?  Maybe a message like that would belong in ACPI?
There is already an ACPI_DEBUG_PRINT() in
acpi_ev_queue_notify_request() that would serve a similar purpose.

>  	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
>  		return;
>  
> +	pci_info(pdev, "EDR event received\n");
> +
>  	/* Locate the port which issued EDR event */
>  	edev = acpi_dpc_port_get(pdev);
>  	if (!edev) {
> -- 
> 2.17.1
> 
