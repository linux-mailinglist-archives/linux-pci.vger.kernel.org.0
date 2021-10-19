Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8094339AA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhJSPGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 11:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhJSPGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 11:06:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7236115A;
        Tue, 19 Oct 2021 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634655847;
        bh=32/zovTwFvkouc5ENTCs/No8X0J+VVtCWoVWVN/axmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iVieWef4zRJ55PGvCXzCgoZ15DMW3c4x6eUSJHyoDEnTHZpJARctM/82MuAIPp3is
         v5pyHzulp6iaq7Rrd8CSjMCZzbvigsR+rGlqkau36HC2vttzNkLvloO8E32g/7T2W3
         YEJ8ZcNHDlCEiZyc0s2OeE6ZEH0w8VDymDxirkkfKtLTCZBDYsomFv9pKQlzjGTu58
         oPvd5K9NOpdVFb3c1dBeG5F4WZNy0BZ2KVlm8t75yy7NImAkokLqZbkFFkpsSa0Z+c
         JqYmsYG338e/4dU7QOoCEnSxfQo42KvFCxwIE0s1ctaAVEnT3+59U/REyN1UbHNBJM
         Jb0E3qzfn/S6A==
Date:   Tue, 19 Oct 2021 10:04:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ACPI: APEI: Filter the PCI MCFG address with an
 arch-agnostic method
Message-ID: <20211019150405.GA2338201@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW5OmSBM4mO1lDHs@Dennis-MBP.local>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
> The commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
> level") fixes the issue that the ACPI/APEI can not access the PCI MCFG
> address on x86 platform, but this issue can also happen on other
> architectures, for instance, we got below error message on arm64 platform:
> ...
> APEI: Can not request [mem 0x50100000-0x50100003] for APEI EINJ Trigger registers
> ...
> 
> This patch will try to handle this case in a more common way instead of the
> original 'arch' specific solution, which will be beneficial to all the
> APEI-dependent platforms after that.
> 
> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
> Reported-by: kernel test robot <lkp@intel.com>

The purpose of this patch is not to fix a problem reported by the
kernel test robot, so remove this tag.

I know the robot found a problem with a previous version of this
patch, but we treat that the same as a code review comment.  We
normally don't explicitly credit reviewers unless it was something
major, and then it would go in the commit log, not a "Reported-by"
tag.

It makes sense to credit the kernel test robot for things found in
Linus' tree, but it's a little too aggressive about suggesting the tag
for problems with unmerged changes.

> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

This tag can only be added when Lorenzo explicitly supplies it
himself.  I do not see that on the mailing list, so please remove this
tag as well.  After Lorenzo supplies it, you can include it in future
postings as long as you don't make significant changes to the patch.

Bjorn
