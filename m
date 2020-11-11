Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31882AFBF8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 02:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKLBbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 20:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgKKWnI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 17:43:08 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B3A208B3;
        Wed, 11 Nov 2020 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605134587;
        bh=ziz9AD0L9QbcwYEV2l2JNVkufhqr9h+LE7Fz/YEme5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wy6TcWFvc+0oeRRsXdgQ7pdaOrmNpp0S9B9tyiyhRfDKo3Ys5o4pqbsF7Bzk8r7I3
         ckMiWEQBhGkHXcZdZD61c+v9iLXT8DUSJrQLb85WgvqlT6ur0dx+PS2lATpjaMlkiQ
         VZkJ+ZKPKwpbQOHugkPf8T5KCZjFmRCX3lRNVgPQ=
Date:   Wed, 11 Nov 2020 16:43:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
Message-ID: <20201111224305.GA977584@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:43:47PM -0800, Ben Widawsky wrote:
> ...
> Ben Widawsky (5):
>   cxl/mem: Map memory device registers
>   cxl/mem: Find device capabilities
>   cxl/mem: Initialize the mailbox interface
>   cxl/mem: Implement polled mode mailbox
>   MAINTAINERS: Add maintainers of the CXL driver
> 
> Dan Williams (2):
>   cxl/mem: Add a driver for the type-3 mailbox

To include important words first and use "Type 3" as in spec:

  cxl/mem: Add Type 3 mailbox driver

>   cxl/mem: Register CXL memX devices
> 
> Vishal Verma (2):
>   cxl/acpi: Add an acpi_cxl module for the CXL interconnect
>   cxl/acpi: add OSC support

For consistency:

  cxl/acpi: Add _OSC support

It's conventional in drivers/acpi and drivers/pci to capitalize the
"ACPI" and "PCI" initialisms except in actual C code.   Seems like
you're mostly doing the same with "CXL", except in the subject lines
above.  Since you're making a new directory, I guess you get to
choose.

I use "PCIe" (not "PCIE" or "PCI-E"; you have a mix) because that
seems to be the official abbreviation.
