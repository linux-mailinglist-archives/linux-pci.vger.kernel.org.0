Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64696A9EE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfGPN7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 09:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPN7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jul 2019 09:59:25 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5341020880;
        Tue, 16 Jul 2019 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563285564;
        bh=axm9oREaOJv1cVVP68RVtcE55RfxdvIVdg8ysfbSH3Y=;
        h=Date:From:To:Cc:Subject:From;
        b=k7xbINaffR/KPZSMMRTCcPaMdONAeBGql3Q1D9AmKlfzx2nzngqR5fRSZyQBTypu4
         QJTMMOrnAwL6xTb9RWTrZdJcY4q6qPjfxGe6tGrGmd2b4ecEIGzgLaUNqHrmTo5aD5
         Ab10fEFBa1/A5oF1pjGB3KBd9mqZhDuerxgfsNJg=
Date:   Tue, 16 Jul 2019 08:59:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: PCI: dra7xx: PCI_EXP_LNKCTL2 usage
Message-ID: <20190716135923.GA4470@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ab5fe4f4d31e ("PCI: dra7xx: Add support to force RC to work in GEN1 mode")
added this:

  +       dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
  +                        2, &reg);
  +       if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
  +               reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
  +               reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
  +               dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
  +                                 PCI_EXP_LNKCTL2, 2, reg);
  +       }

This probably works as intended, but it *looks* wrong because it uses
LNKCAP_* symbols on LNKCTL2 register values.  We do have
PCI_EXP_LNKCTL2_* symbols, so I think it would be better if we used
used those.

Bjorn
