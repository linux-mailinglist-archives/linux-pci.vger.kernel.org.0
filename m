Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535D24339EA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJSPPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 11:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhJSPPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 11:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55DD760FD8;
        Tue, 19 Oct 2021 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656380;
        bh=4YzZkOiFi4XZ+CR6Qd/pNGRdUTCx6OBisb3nvJ/50Pc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bY2ZejplpTQvQJw1FU3h9lX6KkjvLF2GqQYiZV0M5cPqi6lQxiYNQWiESysA6amQ6
         5aODPXKFN4Fs5+lipuh2vvx2NXv+VDdE0JANEnixHS/49Y0PECfA2NKiFecGNA3BAP
         ghzSaPEo3/pNvRXHoiNI8+ieKL5iczB843BgUgyUgqxV0NdtEbihX/WdHEfpO35VjR
         dKrSUAl0WLFSTvrBfoAZmmkCvcJklFD9TawdTdRD8NnGX291Uwf8jTB/crvzAcR7eu
         JrX2Lthpy+pzDBQMJUUPESQ8xw/yXt9f8z+LDrTR1VV65CLkATGCedt4GYd3rxCll2
         QLYOLD4TCL4oA==
Date:   Tue, 19 Oct 2021 10:12:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI MCFG consolidation and APEI resource filterin
Message-ID: <20211019151258.GA2336650@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 12:49:16PM +0800, Xuesong Chen wrote:
> Hello All,
> 
> The idea of this patch set is very strainforward, it's somehow a refactor
> of the original codes to share some ones that they should do. Based on that,
> we can resolve the MCFG address access issue in APEI module on x86 in a 
> command way instead of the current arch-dependent one, while this issue also
> does happen on ARM64 platform.
> 
> The logic of the series is very clear(IMO it's even time-wasting to explain that):

If you want people to look at and care about your changes, it is never
a waste of time to explain them.

> Patch #1: Escalating the 'pci_mmcfg_list' and 'pci_mmcfg_region' to the
> pci.[c,h] which will shared by all the arches. A common sense, in some degree.
> 
> Patch #2: Since the 'pci_mmcfg_list' now can be shared across all arches,
> the arch-specific fix method can be replaced by the new solution naturally.
> 
> Now the v3 patch has been finalized, can we move forward to the next step? -
> either give the concerns/objections or pick it up.

It's helpful to your reviewers if you include a note about changes
between v2 and v3, as you did in your v2 0/2 cover letter.

It's also helpful if you thread the series with patches 1 and 2 as
responses to the cover letter.  That makes it easy to download the
patches using b4.  Here's a little more background:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v5.14#n320

> Xuesong Chen (2):
>   PCI: MCFG: Consolidate the separate PCI MCFG table entry list
>   ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method
> 
>  arch/x86/include/asm/pci_x86.h | 17 +---------------
>  arch/x86/pci/mmconfig-shared.c | 30 ----------------------------
>  drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
>  drivers/acpi/pci_mcfg.c        | 34 ++++++++++++-------------------
>  drivers/pci/pci.c              |  2 ++
>  include/linux/pci.h            | 17 ++++++++++++++++
>  6 files changed, 63 insertions(+), 82 deletions(-)
> 
> -- 
> 1.8.3.1
> 
