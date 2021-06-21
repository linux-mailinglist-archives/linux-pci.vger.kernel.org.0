Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF15C3AF9D0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 01:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFUXz3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 19:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhFUXz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 19:55:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10EC061574
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 16:53:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t9so15453930pgn.4
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n91GfziZ5syAC28F6UjBolJ+M+YVU4V/73A7TE0XUb0=;
        b=SUyoFV/+KdCNo/00LCnOAUpTOHYgzf0cSORstuKQbNiRU4V1vUrGu4QetCpbQBYc1W
         GAxBENYZAxru0gINenfaFo3ipVEzhLwv0U2eNgFcJ2cPC7dG4++rrl8IkdEXEecTnwhe
         LSHANxMj999/UFOJcme3BmijnH7TMuu4qQkCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n91GfziZ5syAC28F6UjBolJ+M+YVU4V/73A7TE0XUb0=;
        b=cYG0+kBArcvOi8yOrcf7hIqY9H+swMa0Vjs/j3CceM9hdQqtLsVAdUXseZuHNfmIMj
         EKykXSRMV7ZbNLg0l6vu5mnkMx08vFr7rqWuceMvl9VCJnMLRw5UuCwGLmYukTOD3b5B
         d9Z0zws8te/A5Ic6uOPsHVf+J6cRXMuXlSl/ojL6MzN9ZVSC1JKIsKYeh8sLc+zO5mcu
         V9tElaAsC70gNyoRxsFEhQmmKFxCJMlO6lycUHtLbpWRIdwUOFDRM7QAw+lTNLUIXYws
         HoxACzi5QxoIrqGS0DW9iPx1DuiCffuY1hoRD9aYz7C/9N9wgV6PQ9CQrVKD0kpGj64d
         Otfg==
X-Gm-Message-State: AOAM532z32RMQnJaW15b3VZ2twMjHH//ogwF8K5Q3n8RqZfH7KkyteEO
        sDP/LsLNtq3BryN6Lg9nJz4fyA==
X-Google-Smtp-Source: ABdhPJxZEK+bTs68KqckxQkGsSx8yLSwQ1E3xNiGaYMPOkRx7NyxIeuHTI/Mz9yWdTNtGbeL+DqgvQ==
X-Received: by 2002:a62:2601:0:b029:300:bd5a:9268 with SMTP id m1-20020a6226010000b0290300bd5a9268mr718024pfm.1.1624319588586;
        Mon, 21 Jun 2021 16:53:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] iommu: Enable devices to request non-strict DMA, starting with QCom SD/MMC
Date:   Mon, 21 Jun 2021 16:52:42 -0700
Message-Id: <20210621235248.2521620-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


This patch attempts to put forward a proposal for enabling non-strict
DMA on a device-by-device basis. The patch series requests non-strict
DMA for the Qualcomm SDHCI controller as a first device to enable,
getting a nice bump in performance with what's believed to be a very
small drop in security / safety (see the patch for the full argument).

As part of this patch series I am end up slightly cleaning up some of
the interactions between the PCI subsystem and the IOMMU subsystem but
I don't go all the way to fully remove all the tentacles. Specifically
this patch series only concerns itself with a single aspect: strict
vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
to talk about / reason about for more subsystems compared to overall
deciding what it means for a device to be "external" or "untrusted".

If something like this patch series ends up being landable, it will
undoubtedly need coordination between many maintainers to land. I
believe it's fully bisectable but later patches in the series
definitely depend on earlier ones. Sorry for the long CC list. :(


Douglas Anderson (6):
  drivers: base: Add the concept of "pre_probe" to drivers
  drivers: base: Add bits to struct device to control iommu strictness
  PCI: Indicate that we want to force strict DMA for untrusted devices
  iommu: Combine device strictness requests with the global default
  iommu: Stop reaching into PCIe devices to decide strict vs. non-strict
  mmc: sdhci-msm: Request non-strict IOMMU mode

 drivers/base/dd.c             | 10 +++++--
 drivers/iommu/dma-iommu.c     |  2 +-
 drivers/iommu/iommu.c         | 56 +++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci-msm.c  |  8 +++++
 drivers/pci/probe.c           |  4 ++-
 include/linux/device.h        | 11 +++++++
 include/linux/device/driver.h |  9 ++++++
 include/linux/iommu.h         |  2 ++
 8 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

