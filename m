Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C1A0B97
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 22:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1Ues (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 16:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfH1Ues (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 16:34:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18B422CED;
        Wed, 28 Aug 2019 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567024486;
        bh=m18++XIKgvB3hDNAlvvRjgCQvsCS7XqYby0VuKAWQjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pfm3sQn8ORceEyEu8TAVaP0r9CNKytr+G0mcwxv3y+B9ZeliVX+IsGHPIzf/Gbe6r
         sRZ4qd3S05wMwDrpGs5zATXUCFOCM259yBHSro6qXy6RWH5IBdjhMMQu7I9gHKa3Kv
         rb6x2IHfybj/Gz5fwE8c30gBdpYr8IPTCgWEHolE=
Date:   Wed, 28 Aug 2019 15:33:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/ACPI: Rename _HPP to _HPX and move of
 ACPI-specific code from probe.c
Message-ID: <20190828203352.GC7013@google.com>
References: <20190827094951.10613-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827094951.10613-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 11:49:48AM +0200, Krzysztof Wilczynski wrote:
> This series of patches moves the ACPI-specific code currently included
> as part of the drivers/pci/probe.c. First, the ACPI Hot Plug structs
> for Type 0, 1 and 2, and any relevant variable names, structs, function
> names, etc., will have their names changed to reflect that these are
> related to _HPX rather than _HPP.  Second, all of the ACPI-specific
> code will be moved to drivers/pci/pci-acpi.c for better organisation
> and to keep ACPI-related code base together.  Third, remove the
> now obsolete struct hotplug_program_ops from drivers/pci/pci-acpi.c.
> 
> Patches should be preferably merged in order as they build upon
> one-another.

This is always the case; it's one of the main reasons for grouping
patches into a series.

> Related:
>   https://lore.kernel.org/lkml/20190419220220.GI173520@google.com
>   https://lore.kernel.org/lkml/20190307213834.5914-3-mr.nuke.me@gmail.com
>   https://lore.kernel.org/lkml/20190307213834.5914-2-mr.nuke.me@gmail.com
> 
> Krzysztof Wilczynski (3):
>   PCI/ACPI: Rename ACPI Hot Plug structs for Type 0, 1 and 2 from _HPP
>     to _HPX
>   PCI/ACPI: Move ACPI-specific Hot Plug programming functions to
>     pci-acpi.c
>   PCI/ACPI: Remove unnecessary struct hotplug_program_ops from
>     pci-acpi.c
> 
>  drivers/pci/pci-acpi.c      | 410 +++++++++++++++++++++++++++++++++---
>  drivers/pci/pci.h           |   9 +
>  drivers/pci/probe.c         | 278 +-----------------------
>  include/linux/pci_hotplug.h | 100 ---------
>  4 files changed, 389 insertions(+), 408 deletions(-)

I applied these to pci/enumeration for v5.4, thanks!
