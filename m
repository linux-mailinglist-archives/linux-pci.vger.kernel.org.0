Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BEC277C0E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 00:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIXWxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 18:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIXWxv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 18:53:51 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5610A2344C;
        Thu, 24 Sep 2020 22:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600988030;
        bh=WAPzekMBNAgUu+UeHy7T9NMEl/2vV2ASYKDd9t/1FtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=naYFmLk9RsnDxFbh7C9ThSh8x7E7gqx+/GUFP1jf3w7ID/H1pIjh0js7QwbCU7K1v
         78cs5dT8ZpiNvwsUC1RxMW9z19NsMBGEno/au9zIIjsCKM/LmQ3FXwUsd7W2PKlV3p
         0kt1YTvTqO9QBAtUysX2AnFnoZXzZvLGbX2C1Ytg=
Date:   Thu, 24 Sep 2020 17:53:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/7] PCI/ASPM: Cache device's ASPM link capability in
 struct pci_dev
Message-ID: <20200924225347.GA2367309@bjorn-Precision-5520>
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

I think we need to be a little careful here because there's a note in
the spec (PCIe r5.0, sec 7.5.3.6):

  Note that exit latencies may be influenced by PCI Express reference
  clock configuration depending upon whether a component uses a common
  or separate reference clock.

So if we change the common clock configuration, e.g., in
pcie_aspm_configure_common_clock() or anything else that writes
PCI_EXP_LNKCTL_CCC, I think we will need to update pdev->lnkcap.
