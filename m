Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166922F900F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jan 2021 02:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbhAQBcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jan 2021 20:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbhAQBb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jan 2021 20:31:59 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529BC061757
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 17:31:19 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m25so18892035lfc.11
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 17:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgrrXakk2wkUcccPIIETRayv90ANawKfzC1o+Sh4pvk=;
        b=SsabWPSoNhCziOtR0apqH4EuHh755sYk7LVbEoHUB3uK2Etlf1iI0VqiNn4i7OR01u
         Bzm24ca985E2l9v5fQAGjdOgDlaJnAik/5AXq1FGJtiCrxIvt4SBBZREN1/mrfKiAG4c
         pWIFJJ0hDVcYIoEvOltsYrhpqwVUFK/Sj5cPCygnqXmM9M3jb0crhljLGz4/NPq5dCBA
         wS4+fcIIJujquP+SfiqGMZ7nZSlXlQtTVGRf6xx+s27DgW7AjlZRkGjrYJBGX06LUsJV
         zlFd1gWNSFgmLJ7NqIbuZxFMR29WOb+w0nQI8pfRLmCtY4DwccpyayPYVYJ90YTzJf5o
         HNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgrrXakk2wkUcccPIIETRayv90ANawKfzC1o+Sh4pvk=;
        b=p50j2xlazpOt8LGLVLplh5NAkr4RGDoRI1KdOWqETLKNwwelAJ5zbgbZgUTCyOlD4I
         neK/VLeuv4lWi5jHcoLwJnVOixnO79PcwWr2curl1PNwHZIvRJts/F767T833h0W62m5
         FxUBapJ/aBB7nxurEZco3TLR0HlEiSwskee/K5KEJPMXkFNHOc8p5jT9RfpO8H0iypdD
         Z8XeHiMN9KGm1aZx9FxDFAEkMesZHLN5r2BUK8yTI9PyZMbGJo4zXXeNqE6x15bZUAsW
         dCi1PJUphdZLr0ccU5O21qw/bG4YHy2d47VQQNaTaabem2fdR/AELbS/Ir1/WTf7fzI/
         f2Rg==
X-Gm-Message-State: AOAM533+NmB/Set7zAN91rZ55SBIXPnXdAC4CgXsAYwyB7QzL12/OIgB
        tZ0D8s2X7BxY1uuUYTIEU5nmxw==
X-Google-Smtp-Source: ABdhPJxmOz/fxatwEqI/IgLJF+mpfCv6cMn7WkmK+RLzVosyrgAI+FAlB31YEOahpZa6UoikBLQTig==
X-Received: by 2002:a19:641:: with SMTP id 62mr8396812lfg.424.1610847077521;
        Sat, 16 Jan 2021 17:31:17 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.101])
        by smtp.gmail.com with ESMTPSA id c1sm1286298ljd.117.2021.01.16.17.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 17:31:17 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 0/2] PCI: qcom: fix PCIe support on sm8250
Date:   Sun, 17 Jan 2021 04:31:12 +0300
Message-Id: <20210117013114.441973-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SM8250 platform requires additional clock to be enabled for PCIe to
function. In case it is disabled, PCIe access will result in IOMMU
timeouts. Add device tree binding and driver support for this clock.

Canges since v4:
 - Remove QCOM_PCIE_2_7_0_MAX_CLOCKS define and has_sf_tbu variable.

Changes since v3:
 - Merge clock handling back into qcom_pcie_get_resources_2_7_0().
   Define res->num_clks to the amount of clocks used for this particular
   platform.

Changes since v2:
 - Split this clock handling from qcom_pcie_get_resources_2_7_0()
 - Change comment to point that the clock is required rather than
   optional

Changes since v1:
 - Added Fixes: tags, as respective patches have hit the upstream Linux
   tree.


