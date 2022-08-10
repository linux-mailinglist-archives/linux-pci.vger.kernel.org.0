Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285758F26F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiHJSf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiHJSfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 14:35:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C013491F2
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 11:35:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id kb4-20020a17090ae7c400b001f783657496so1538928pjb.6
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=305tiOe9oqfqfsuvDZRVuWRx0yktJC9yjMeTcbY7cTg=;
        b=rGd0cdEiDw0KumHSf9F3anHak5lXZZZ8eX+Hg9h1s3Z40zfYDS8FJmqJsz283SHp/P
         3ava8NgnRz18ADKbGPa2joMOIjVsi2HSpSrgOuNAbbMwiWRtrspRTGWoxlyDmsWatJo0
         dEV0DmaFTlWK+HeEzxIIIjWKQPVOFEZ0l1evJPrICGLNy0wpYmQFeNwmPlKccUHhKqlV
         QaqbWjPgpLtHtHPpr5Gd16V+KMoktpgIjeT97kX51u8V8jSFrR48CmsrzkBzXdTnlc7z
         3urzQYGBNfjeiKUtWEGC6YtSkyLizXm85o2UfJGHQv9jFAi/ux3Yun8+QEdgQMQWVvdB
         Ae5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=305tiOe9oqfqfsuvDZRVuWRx0yktJC9yjMeTcbY7cTg=;
        b=zlircALT3inidyxterCi3sWnifiLf704Kp/nwJUfK+niLT/KvtU+3Tt0BoCeSpwFt3
         ar81WFUmOjfysOGvNk+htJmBUkmqqKc+FHXp17tSmeF5YxjCoXOYBlqcn5P8PnTtleE0
         P4qNOx5YY4X6Z61oS9lqWJ9bNnhsMWvxymC7Csnm/kDGJaauNHfSGgeCJXiQFUljUCk/
         wSLSJNaT/XzSFOT/8kiuAOq2rL4DCEF1UvyFvrw4b7kxmnSKpRz+Om4DvWn4jgrhP1OK
         //aZi9OC+IbzBJMp8ioL4eetDHyUAEmZaTmJ9/DwMcA0EJND9k7Vyk2bIqJSkCV9mB+3
         8KmA==
X-Gm-Message-State: ACgBeo0DC9rNeCysN5X6W0VioQqHeJHAmVByXVKY64cvzX9/zEmsP/VZ
        pMIHwpP0GVfzrNhwe7eoRs/g8dasypNBkc7LU4k=
X-Google-Smtp-Source: AA6agR69r+KIfDrtct6TRAUWQieOzXOCYueNDXbGFFMaqGfs64+LonwB5fKF1dJ+v51y3dQNaPmLyxiFv4bcR52NUvw=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:c96:b0:52e:979c:dd63 with
 SMTP id a22-20020a056a000c9600b0052e979cdd63mr28027369pfv.50.1660156545911;
 Wed, 10 Aug 2022 11:35:45 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:35:33 +0000
Message-Id: <20220810183536.1630940-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
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

I have updated the patch series based on the build error reported by the
kernel test robot which found an issues with the new inline function when
PCIE_DW_HOST isn't set. Additionally, I have updated the DMA alloc error
handling for the first patch which was reported to me directly by Isaac
Manjarres. Basically, we don't need to check for a DMA mapping error since
dma_alloc_coherent() will free the memory when a mapping error occurs.

Please take a look and let me know if you have any questions or concerns.

Thanks,
Will

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Will McVicker (2):
  PCI: dwc: drop dependency on ZONE_DMA32
  PCI: dwc: add support for 64-bit MSI target address

v2:
  * Fixed build error caught by kernel test robot
  * Fixed error handling reported by Isaac Manjarres

 .../pci/controller/dwc/pcie-designware-host.c | 37 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c  |  9 +++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 31 insertions(+), 16 deletions(-)


base-commit: d4252071b97d2027d246f6a82cbee4d52f618b47
-- 
2.37.1.559.g78731f0fdb-goog

