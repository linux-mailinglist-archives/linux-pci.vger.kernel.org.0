Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95958F4B6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 01:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiHJXO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 19:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHJXO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 19:14:57 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A5796AB
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:14:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id h13-20020a056a00000d00b0052de2e258dbso6982513pfk.7
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=cDKfS+mp0bO84lG6a8DTGkxhWYZfDVMaRjD60LzPACw=;
        b=EEkHVaxeQk53Mmu5pqqk6PVceiIK/FzwaqUKxNdvZhL8sYYNtJuzm0i05HC6Xb6pME
         dqvm6jM320OYj3nuFNVkeAsygo3lNfV22dzVBYNPE4TQqhuy9izFuIGJ0Yr6km1TZu/K
         eV5iMlJekdiPZvvccw5LpMTYYD2k3y+HVDQZ32hvldqkbwIEU/sTHyp0MJDzIRQRR6BW
         Rn06XlOstEyjU4uJNjZpndIxGtbZ67W355rgt+o6VGCHtbidJZ/VNhIqUMxBx3lKQBhG
         2iwpoKN34tnuBKx4B1RSuLOgNpiTOZrUjW6MTNBNRGqq22e1IxZijfu3ZQSfJx5FSc7S
         6GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=cDKfS+mp0bO84lG6a8DTGkxhWYZfDVMaRjD60LzPACw=;
        b=FBGrDQqWIaJIy0OnijOASVyFKqcRVl6XFYHf00F2g/jYC8VOoEydOOqAgm0Ua6Y2BM
         7bl8Ll8HL0dB4Gham2AF+ar/Uq/hWxXtOsTNyClAxMiI0SKzdrNRNh3FJc4kia1Iuf7z
         v8PmFJoyH9V/WnWEKM0BIuUAeBq/w6Opj/A9bAUHMQT0rV8CF+ZADGgC/QADjc98KoJp
         I8k1DK3IGI0z1dk4Q9nW1GeQ1O5fgaPe2qTTVCce6XY9fqWzpic/X9O6Dy+xihqW7Iq9
         9OR2YDndrTp2jAnEFWxgNuc+tgxM4TM0Yf4IPxpoYmOvJSBExsD0k8qQX2KS7cThIxBM
         zTFA==
X-Gm-Message-State: ACgBeo1vWxPaiMCiz53G1FqXRpIBhJTOAAUuGf8iBtDgRuD2xYuqAlp7
        s+ItTyQIkwRiwj7pDpP/yClhgG3xcQ8loxQFRh8=
X-Google-Smtp-Source: AA6agR7Y/Yxsc0ACEMgMteDcaHe/3/RkSVhO703co5dj2d9rN9M5F/UDpJGDRqwfaqg+gDW+Bt/ipfB52Y6m5w98qHM=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a63:c1f:0:b0:41a:9b73:a89e with SMTP
 id b31-20020a630c1f000000b0041a9b73a89emr24340253pgl.342.1660173295113; Wed,
 10 Aug 2022 16:14:55 -0700 (PDT)
Date:   Wed, 10 Aug 2022 23:14:42 +0000
Message-Id: <20220810231445.2242126-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
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

Hi All,

I have updated the series based on the reviews to use managed DMA
allocation API. This allows me to drop the msi_page parameter from struct
dw_pcie_rp.  Please take a look and let me know if you have any concerns.

Thanks again for the reviews!

Regards,
Will

Will McVicker (2):
  PCI: dwc: drop dependency on ZONE_DMA32
  PCI: dwc: add support for 64-bit MSI target address

v3:
  * Switched to a managed DMA allocation.
  * Simplified the DMA allocation cleanup.
  * Dropped msi_page from struct dw_pcie_rp.
  * Allocating a u64 instead of a full page.

v2:
  * Fixed build error caught by kernel test robot
  * Fixed error handling reported by Isaac Manjarres

 .../pci/controller/dwc/pcie-designware-host.c | 42 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.c  |  9 ++++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 29 insertions(+), 24 deletions(-)


base-commit: aeb6e6ac18c73ec287b3b1e2c913520699358c13
-- 
2.37.1.559.g78731f0fdb-goog

