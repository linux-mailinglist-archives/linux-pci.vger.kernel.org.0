Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2629BD19
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 17:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1801845AbgJ0Qkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 12:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1811673AbgJ0Qkf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 12:40:35 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA852076A;
        Tue, 27 Oct 2020 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603816834;
        bh=GeVydqQdmqF4mrnnUV8EoH6D0rgd0GD2fCsWLHqwvO8=;
        h=Date:From:To:Cc:Subject:From;
        b=eajqUrujF1byPf1XOlg/ePW4E5wsgT/qfSk2bJxE4t/Cjo4rPEXZZ+BWgH+6foZNk
         IpmP93XAz9sxEgSn2pgPLLL7+7HIZzdlhrZT1/P2eHjemPsglw8rGf7z3/bq7Zapk9
         GwPXR/v88+dWOHQLKVV1D11PWcv47Fqz7M5xYsH8=
Date:   Tue, 27 Oct 2020 11:40:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yue Wang <yue.wang@Amlogic.com>
Cc:     linux-pci@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: pci-meson covery issue #1442509
Message-ID: <20201027164033.GA184666@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yue,

Please take a look at this issue reported by Coverity:

340 static int meson_pcie_link_up(struct dw_pcie *pci)
341 {
342        struct meson_pcie *mp = to_meson_pcie(pci);
343        struct device *dev = pci->dev;
344        u32 speed_okay = 0;
345        u32 cnt = 0;
346        u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
347
348        do {
349                state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
350                state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
351                smlh_up = IS_SMLH_LINK_UP(state12);
352                rdlh_up = IS_RDLH_LINK_UP(state12);
353                ltssm_up = IS_LTSSM_UP(state12);
354

CID 1442509 (#1 of 1): Operands don't affect result
(CONSTANT_EXPRESSION_RESULT) result_independent_of_operands: ((state17
>> 7) & 1) < PCIE_GEN3 is always true regardless of the values of its
operands. This occurs as the logical operand of if.

355                if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
356                        speed_okay = 1;


"PM" seems like a funny name for a link speed.  It sounds more like
something related to power management, e.g., D0, D3.
