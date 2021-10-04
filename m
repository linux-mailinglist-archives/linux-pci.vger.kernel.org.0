Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0BF4215D8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhJDSCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhJDSC3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:02:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DD1C061745;
        Mon,  4 Oct 2021 11:00:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w14so464495pll.2;
        Mon, 04 Oct 2021 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/kZ/G80MyWYhdKVpqBk0C55lIN/V+L/Ury6/lN0H48=;
        b=Iw7vxd3nbj0C1OKCrJ5xQgex0PG/Kc/CV2C7tPUsGeWawiJ+Az940Wzu2Uy5AmVN11
         PYgVr1uisn3pGX1qacas8hTyKYIt8VOmZwZVG1gre/RBFwd13kU/cyjkN896O6+kWsOz
         aqNCYiEUv+Mql1+gA+oauHx8b4gKZ+g+6JhBQ6JHyELV/qC0+trpinxN3/Si0Y/WpNZt
         2otRHBRlasP0qjST8dSK+oXvQx3KF5hIWf8ATarS/AlOYRJtC3LVY4fzb8BFgrY3fyCZ
         NIsIQLmwRkYPqoZj9GvQx7bJRDS0HPeBuGYOOlPlfaxJXhpXhK3AX18GgU/JfHwFGscp
         c11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/kZ/G80MyWYhdKVpqBk0C55lIN/V+L/Ury6/lN0H48=;
        b=RjMFsfANAT220KfibGYWZuCCW2mMx43YSJgSwuAnSJb5WBrC1ZDqbUWD2nTZxuRhxA
         aK1FXFXLOJyMyPcPZY3hU1niOcdmg8wRt6LZOeb73ZtJ6bF3pxf9Jhh+8b66S2uMecwv
         SK7FZx6voXOu83+932ivIMzmMg4M+K86H/CeQ8HkvWSvQAZblKKX3fzovl/s1xuPQM+e
         WBj7I2CQUHAeAYmQJkS3c01t25Eve9Yt2tvFrBY1KkTIgVQqK8UlQ8a+5OsTuOaddhte
         C2crFhe+ELdrg48o+49udEYLu1IVgbyhweEWzNKaGZ+RY5b1lPbtb1qwMarCkZvMRO5w
         A1xg==
X-Gm-Message-State: AOAM533SW3SDG9zDJOT2HIHnyigg+Dh30ypoBJKlgPdei7gvLxJKDE1a
        bnJGYbvmTTc85EkjB5Zwos4=
X-Google-Smtp-Source: ABdhPJyjTQaAGxBR0yMHdOdR1pG5uX4ZqXJGgnNSDIvUGtfqSnjkdKem5NcrSNhG6aWIO723rBkbDw==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr32152882pjg.17.1633370439363;
        Mon, 04 Oct 2021 11:00:39 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id z2sm3641004pfe.210.2021.10.04.11.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:00:38 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, tsbogend@alpha.franken.de, ruscur@russell.cc,
        oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] MIPS: OCTEON: Remove redundant AER code 
Date:   Mon,  4 Oct 2021 23:29:26 +0530
Message-Id: <cover.1633369560.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

e8635b484f64 ("MIPS: Add Cavium OCTEON PCI support.") added MIPS
specific code to enable PCIe and AER error reporting (*irrespective
of CONFIG_PCIEAER value*) because PCI core didn't do that at the time.

But currently, the PCI core clears and enables the AER status registers.
So it's redundant for octeon code to do so. This patch series removes
the redundant code from the pci-octeon.c

Currently, the correctable and uncorrectable AER mask registers are not
set to their default value when AER service driver is loaded. This
defect is also fixed in the "[PATCH 1/6]" in the series.

Please note that "Patch 4/6" is dependent on "Patch 1/6".

Thanks,
Naveen Naidu

Naveen Naidu (6):
 [PATCH 1/6] PCI/AER: Enable COR/UNCOR error reporting in set_device_error_reporting()
 [PATCH 2/6] MIPS: OCTEON: Remove redundant clearing of AER status registers
 [PATCH 3/6] MIPS: OCTEON: Remove redundant enable of PCIe normal error reporting
 [PATCH 4/6] MIPS: OCTEON: Remove redundant enable of COR/UNCOR error
 [PATCH 5/6] MIPS: OCTEON: Remove redundant ECRC Generation Enable
 [PATCH 6/6] MIPS: OCTEON: Remove redundant enable of RP error reporting

 arch/mips/pci/pci-octeon.c | 50 --------------------------------------
 drivers/pci/pcie/aer.c     | 13 +++++++++-
 2 files changed, 12 insertions(+), 51 deletions(-)

-- 
2.25.1

