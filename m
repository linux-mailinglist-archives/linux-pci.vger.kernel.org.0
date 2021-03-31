Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D813E3508D5
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 23:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhCaVIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 17:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232207AbhCaVIr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 17:08:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C54561056;
        Wed, 31 Mar 2021 21:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617224926;
        bh=YCB+fX2HMscEE/1zf6bDbsOvsLoFXezcqPV+qdKPTKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B0F1phdgR2YSmzO5+/n6msLT2yJhy0ACKFiND7siEwJDmGwygr4JTCLabo3cnaoHE
         x50dLB8lMDXFXwm3g6pCPCvUhER58aquGK9BVhvJC4bAbipjD3ZyNd2FHSE+63EsDu
         iALnOdq3x6PzT3n5LPxy6a9NrT6E5KtIbfEje1IqABLIxxPGoG67fNymVR3vVbbKH0
         jTIpUWhGu9CQN2dkhQRP1hG0zw4NWsuPdXGhXYWarSk3YPBmWvxnKiUtjd69hsWp9L
         3BTeYwbVdKFlXJHADpFJSmvGPuzrhyEwKFptpt5pfPQ6E8hcKoEzZq1qtSkz/5rNuK
         swt5gjnHtXOeQ==
Date:   Wed, 31 Mar 2021 16:08:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: ACPI: PM: Fix debug message in
 acpi_pci_set_power_state()
Message-ID: <20210331210845.GA1422864@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4319486.LvFx2qVVIh@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 07:57:51PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If PCI_D3cold is passed to acpi_pci_set_power_state() as the second
> argument and there is no ACPI D3cold support for the given device,
> the debug message printed by that function will state that the
> device power state has been changed to D3cold, while in fact it
> will be D3hot, because acpi_device_set_power() falls back to D3hot
> automatically if D3cold is not supported without returning an error.
> 
> To address this issue, modify the debug message in question to print
> the current power state of the target PCI device's ACPI companion
> instead of printing the target power state which may not reflect
> the real final power state of the device.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied with Krzysztof's reviewed-by to pci/pm for v5.13, thanks!

Let me know if you have nearby or related changes that you'd rather
take via your tree.

> ---
>  drivers/pci/pci-acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1021,7 +1021,7 @@ static int acpi_pci_set_power_state(stru
>  
>  	if (!error)
>  		pci_dbg(dev, "power state changed by ACPI to %s\n",
> -			 acpi_power_state_string(state_conv[state]));
> +		        acpi_power_state_string(adev->power.state));
>  
>  	return error;
>  }
> 
> 
> 
