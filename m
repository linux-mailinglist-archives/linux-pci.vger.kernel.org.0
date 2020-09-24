Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D255277BA7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIXWc4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 18:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIXWc4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 18:32:56 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377ED208C7;
        Thu, 24 Sep 2020 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600986776;
        bh=qznelRNh8swUzfC1Zo9BZVtoXVeCpe3/kJhSXzn33fM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Kcc9jzdnz4BUiXJhpBAHE1MmTMR0r11pHKc+aJt/ndq5nztk/rlrrrLNbJ1++TsP4
         tk706Eiwz1NFQzu1hZcVf7PNtFWi71bvHpJwK0G9RuLOXp6aIhAgNbz9I5W1rLea7a
         QWD49zW2W+O7qDK09F+VcHI5GtgGm3lJ1IDuPCYs=
Date:   Thu, 24 Sep 2020 17:32:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/7] PCI/ASPM: Cache device's ASPM link capability in
 struct pci_dev
Message-ID: <20200924223255.GA2366095@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924142443.260861-2-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 04:24:37PM +0200, Saheed O. Bolarinwa wrote:
> pcie_get_aspm_reg() reads LNKCAP to learn whether the device supports
> ASPM L0s and/or L1 and L1 substates.
> 
> If we cache the entire LNKCAP word early enough, we may be able to
> use it in other places that read LNKCAP, e.g. pcie_get_speed_cap(),
> pcie_get_width_cap(), pcie_init(), etc.
> 
>  - Add struct pci_dev.lnkcap (u32)
>  - Read PCI_EXP_LNKCAP in set_pcie_port_type() and save it
>    in pci_dev.lnkcap
>  - Use pdev->lnkcap instead of reading PCI_EXP_LNKCAP

I think we might as well go ahead and use the cached copy in these
other places in this patch, i.e.,

  pcie_init
  pcie_get_speed_cap
  pcie_get_width_cap
  pcie_link_bandwidth_notification_supported
