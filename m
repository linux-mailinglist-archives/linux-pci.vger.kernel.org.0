Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622A44B0C0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhKIP5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236618AbhKIP5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:57:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EADBF6023F;
        Tue,  9 Nov 2021 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636473287;
        bh=HmHBIpNVSQ5ZZUsjMFao/Uho+Q2az12sWmYZpMNBeVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O4PdNNmJBiLWfAZdd/ukI26fl4dKr/dI5S66hCPSDoHLMSRyEbvAFfu7cwzkF2ZiS
         luOVtS4yMVgMagFr9Cjyk0/wNYawZsIFrHBgAG872h1b+TyAwaTWYvbPyIyFjgv/D2
         934uF9pkGFW/KeBIKWb9xvdXciAvX18JFiKkyp6uDuT+U90j8OHdgkzW8JUSjaavst
         hiMdQpyEwYPIXBLAoD6yu89oV9un7tWViGuGaFO+nTWVFFxZvKWkMDSGiUtr/LaF8i
         9muwk5MMNf3p69nGai68eGf0WlWwBDgxRC5IBRyOe0TnAfdIsSSLu4LyjqBa8U8Jr5
         ceOWMQ+u3tr9Q==
Date:   Tue, 9 Nov 2021 09:54:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Clean up domain before enumeration
Message-ID: <20211109155445.GA1149564@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b560b632-6fdd-ff53-5d99-76ac50be5d73@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 09, 2021 at 08:32:37AM -0700, Patel, Nirmal wrote:
> On 10/25/2021 11:29 AM, Nirmal Patel wrote:
> > During VT-d pass-through, the VMD driver occasionally fails to
> > enumerate underlying NVMe devices when repetitive reboots are
> > performed in the guest OS. The issue can be resolved by resetting
> > VMD root ports for proper enumeration and triggering secondary bus
> > reset which will also propagate reset through downstream bridges.
> >
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>

> Gentle ping. Please let me know if you are okay with these changes
> (with Jon's Reviewed-by). Thanks.

We're in the middle of the merge window now.  We'll start applying
patches after -rc1 is tagged, which will probably happen Nov 14.
