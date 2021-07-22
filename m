Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F83D2A89
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhGVQM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 12:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234736AbhGVQLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 12:11:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 562A360BD3;
        Thu, 22 Jul 2021 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626972746;
        bh=J9XUqkHyCFHYUlF+hyMqP3YjBrb5lfe/9jZQ/WIkq40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NHLQKWeg/m1huryAeDdU6PcoQfY62Zf1Jj2DFApViHg94iwOVVmc6wshyGVOfZiT4
         nzQ8TV7+HTqUEy8ldMvtmpskQMTz29XSTJNmHpx80cNosLQQzS0h9NxPt4dt0z3Uws
         cuDIokKjsd4pnl4NiKU3C2TVQ/pnDTAA74HAQ/aCgnRDA+VXFj02nll6P+ZOPxfEKi
         C6+3slvSWzLjS1n1eEMzyMeRyIZSMTnBw3/JdaDzKPvmJ5qGWkR7diPPR/KamsmLaT
         R8tRB2GldWjSEz576qoyBAy0CseRiKybza6F4NTaRw71P/dr2ak1KvYAksg+s26ewm
         6Fjm/QWcZxOYw==
Date:   Thu, 22 Jul 2021 11:52:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     bhelgaas@google.com, jonathan.derrick@intel.com, kw@linux.com,
        onathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Make use of PCI_DEVICE_XXX() helper function
Message-ID: <20210722165225.GA316118@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722111903.432-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 07:19:01PM +0800, Cai Huoqing wrote:
> Could make use of PCI_DEVICE_XXX() helper function
> 
> Cai Huoqing (2):
>   PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper function
>   PCI: vmd: Make use of PCI_DEVICE_DATA() helper function
> 
>  drivers/pci/controller/vmd.c      | 38 +++++++++++++++----------------
>  drivers/pci/hotplug/cpqphp_core.c | 13 ++---------
>  drivers/pci/search.c              | 14 ++----------
>  include/linux/pci_ids.h           |  2 ++
>  4 files changed, 25 insertions(+), 42 deletions(-)

When you fix the problem below, also:

s/Make use of/Use/

Update commit log to say what the patch does.  See
https://chris.beams.io/posts/git-commit/ for hints.
Add period at end of sentences.

I don't see exactly what's wrong, but this series doesn't apply
cleanly.  I'm using b4 to fetch the series.  b4 is from
https://git.kernel.org/pub/scm/utils/b4/b4.git

  11:47:04 ~/linux (main)$ git checkout -b wip/cai v5.14-rc1
  Switched to a new branch 'wip/cai'
  11:47:17 ~/linux (wip/cai)$ b4 am -om/ 20210722111903.432-1-caihuoqing@baidu.com
  Looking up https://lore.kernel.org/r/20210722111903.432-1-caihuoqing%40baidu.com
  Grabbing thread from lore.kernel.org/linux-pci
  Analyzing 3 messages in the thread
  ---
  Writing m/20210722_caihuoqing_pci_make_use_of_pci_device_xxx_helper_function.mbx
    [PATCH 1/2] PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper function
    [PATCH 2/2] PCI: vmd: Make use of PCI_DEVICE_DATA() helper function
  ---
  Total patches: 2
  ---
  Cover: m/20210722_caihuoqing_pci_make_use_of_pci_device_xxx_helper_function.cover
   Link: https://lore.kernel.org/r/20210722111903.432-1-caihuoqing@baidu.com
   Base: not found (applies clean to current tree)
	 git am m/20210722_caihuoqing_pci_make_use_of_pci_device_xxx_helper_function.mbx
  11:47:45 ~/linux (wip/cai)$ git am m/20210722_caihuoqing_pci_make_use_of_pci_device_xxx_helper_function.mbx
  Applying: PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper function
  error: patch failed: drivers/pci/hotplug/cpqphp_core.c:1357
  error: drivers/pci/hotplug/cpqphp_core.c: patch does not apply
  error: patch failed: drivers/pci/search.c:303
  error: drivers/pci/search.c: patch does not apply
  Patch failed at 0001 PCI: Make use of PCI_DEVICE_SUB/_CLASS() helper function
  hint: Use 'git am --show-current-patch' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

