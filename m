Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9C4233B9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhJEWr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 18:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhJEWr0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 18:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F67C61152;
        Tue,  5 Oct 2021 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633473935;
        bh=l6ZN1daYF9vGPfycj/H0ZhjwhZozbcSDkRId3+PgLVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GW/EelDlQS9Dxr3eECavUuBprqSLPPANJF35G9LfGvTh/rpmBSEthLc+k4/2PwwoK
         iFhHhuwF+3O3hYnxOa2UuVzom4OFPdtwWfVY6jHk2R5weEMmZ4SWJEtg5kmcRwnSXg
         pLLx4LBrWNVo+5BDVVX67PPM7rZ4U8Ny8UQZt09FkAtZ6KGi2LLHNGXGsz/UatstH6
         BtBmZ87zHB168z2DWXLSs7PTsyOyWi4I0Nq6ssw7PIcfLcBZZKfkXS6rjJsZo7NuBn
         VWJ/6lyev9jt4+l3xevsgtxEY2/EX86o7eCuJE6GGCiILI9pioHAhWEk9F5b8eBcqc
         YtUanw5V3XdNA==
Date:   Wed, 6 Oct 2021 00:45:31 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 09/13] PCI: aardvark: Implement re-issuing config
 requests on CRS response
Message-ID: <20211006004531.42aace4d@thinkpad>
In-Reply-To: <20211005192826.GA1111810@bhelgaas>
References: <20211004121938.546d8f73@thinkpad>
        <20211005192826.GA1111810@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 Oct 2021 14:28:26 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> My claim is that the spec allows root complexes that retry zero times,
> so we must assume such a root complex exists and we cannot rely on any
> retries.  If such a root complex exists, this patch might fix a
> problem, but only for aardvark.  It would be better to fix the problem
> in a way that works for all PCIe controllers.
> 
> I'm playing devil's advocate here, and it's quite possible that I'm
> interpreting the spec incorrectly.  Maybe the Marvell card is a way to
> test this in the real world.
> 
> Bjorn

Hello Bjorn,

this is what I understand from Pali's explanation, please correct me if 
something is wrong

- If HW supports CRSSVE bit, OS can ask HW to switch from HW-retry to 
SW-retry mode by setting this CRSSVE bit.

- If HW does not support CRSSVE bit, it means that HW supports only 
HW-retry.

- By default CRSSVE is disabled, and it is optional, so HW is required 
to support HW-retry.

- Linux' PCI core supports handling CRSSVE in probe.c: when HW says it 
supports it, PCI core enables it and retries on 0xffff0001 in function 
pci_bus_wait_crs().

- Aardvark controller violates specification: it does not support 
HW-retry even if it is mandatory. Pali is solving this in his patch by 
doing the retry in the driver when CRSSVE is disabled. He is able to do 
this because he gets the information about CRS from another channel 
(another register).

- You are talking about wanting to implement an abstraction for what 
Pali's patch does in PCI core, so that if CRSSVE is not set and someone 
reads PCI_VENDOR_ID, you want to make PCI core doing this retry.

Am I correct here?

This could be done by changing Pali's patch so that instead of 
retrying, the pci_ops->read() method would instead return a value 
indicating that a retry should be done (this would be a new value, 
PCIBIOS_CRS), and then in access.c in the pci_bus_read_config_dword() 
(and pci_user_read_config_dword()), if the pci_ops->read() method 
returns this PCIBIOS_CRS value, the function will retry reading the 
register.

Is this what you mean?

It would make sense to do this, if there are other controllers where 
HW-retry does not work and instead informs about it via side-channel 
even when CRSSVE is disabled.

Marek

PS: Btw, looking at the code, why do we use these PCIBIOS_* macros? And 
then sometimes convert them to error codes with pcibios_err_to_errno()? 
Is this some legacy thing? Should this be converted to errno?
