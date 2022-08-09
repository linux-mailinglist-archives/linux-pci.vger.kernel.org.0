Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93458DD96
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 20:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbiHISBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344343AbiHISBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 14:01:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9DC26573
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 11:00:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4450c963so106925217b3.19
        for <linux-pci@vger.kernel.org>; Tue, 09 Aug 2022 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=OLEpCC27T32C/7NrBkt44Xp3IZO7vGnlk4eYOP8rEvo=;
        b=ryFUKd5uBQ2+aNk7sYR9KZZ74RoKc9IpQDLCinEpIuhwQtE4vRxUzUmVSy+0Y2/o5J
         TxfoLNb2zgM2SZFuDyV0Gvmg6Dwgexrp/ozaojZecEs0UdhV2i9dwqZojJbkyaoIM1W9
         U/3XYnW7/YJruCZNxSVoUQYNoLisjP8IGY6VxNypLiN/B6io8fFuFZITM2ij6Oic0dLt
         9i1VIxDwyZ8jhai0uhD82HpDxU1rIRD0redZv1ccFsj0OZ5fFKfVx9nqUToMVFs9r2+s
         EmcY3IT63/5MTFcw+AX61DUHeb/BSEuT5QaSDYVTIixNcmWLtlZ4ZbMn2roH2L3s7LAt
         qkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=OLEpCC27T32C/7NrBkt44Xp3IZO7vGnlk4eYOP8rEvo=;
        b=nLUFZQ71TDg+Xpo4qWNYtubwhzlIgZj4OK5iYesl7kh9AsGLmsFobwAiWawuclwPSU
         fy7p9gCDvvc9FFEgHi+ePefFGgeoukZQpCdStJ4jGNgHfTwt6sF1yG08g0l54C88JLBQ
         poZUEFxJadHC6aYO42zXeYnIuNyFlUI6dbFsWL9IO891rAbvonb0m0y/3CoDGFbcSBtR
         YX6nTlVB/j9q03tYEfzEZBZiRT0O+n2CXt0zew7EBqQWJ458l87exh0/vrMYEFkI1U68
         1LpukDIpYMJOOu6PRYMdlUoyxxqeMNp3dt9TrfXLRzZVLDwDwPgcragqhcLLo6MYHiwU
         rSDw==
X-Gm-Message-State: ACgBeo3r+z1/htB5mAn8bg0VmS3ZgB1oGhdjBWX/IvLPJgA+QBlA3VR9
        IvbApHBOkh+vwzRf34xCsSCqoMtolJk/etcfKa8=
X-Google-Smtp-Source: AA6agR57Z1i4kogUXRKNHuKcHf6sYzxvP+vQ7Oxz1ol7dAF+yL2j38ufc3C70qxHvegDyd/L/1N0tFLaCF5E+uKEajE=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a0d:ebc9:0:b0:31f:474a:4264 with SMTP
 id u192-20020a0debc9000000b0031f474a4264mr24550636ywe.269.1660068056405; Tue,
 09 Aug 2022 11:00:56 -0700 (PDT)
Date:   Tue,  9 Aug 2022 18:00:48 +0000
Message-Id: <20220809180051.1063653-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I have two patches that address a couple of issues I've run into with the
PCIe DWC host driver:
  (1) the host driver fails to probe when ZONE_DMA32 is disabled.
  (2) the host driver will fail to probe if a 32-bit address is not
      available even on devices that support 64-bit target addresses.

I have addressed both of these issues with the two patches (details can
found in each of the patch commit messages). Please take a look and let
me know your thoughts.

With regards to testing, I have verified them on Android with a Pixel 6
device on the 5.19 + pci-v5.20-changes kernel. My testing included running
with both ZONE_DMA32 and swiotlb disabled.

Thanks,
Will

Will McVicker (2):
  PCI: dwc: drop dependency on ZONE_DMA32
  PCI: dwc: add support for 64-bit MSI target address

 .../pci/controller/dwc/pcie-designware-host.c | 42 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c  |  9 ++++
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
 3 files changed, 41 insertions(+), 16 deletions(-)

-- 
2.37.1.559.g78731f0fdb-goog

