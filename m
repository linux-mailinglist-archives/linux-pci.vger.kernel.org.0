Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93820396990
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEaWM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEaWM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 18:12:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D5C061574;
        Mon, 31 May 2021 15:11:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q25so2083179pfh.7;
        Mon, 31 May 2021 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwgdEN02tOTM3X9OahYK6izrepiauXF6ean9NRJUvFU=;
        b=ImlKs4q89z++GK7D1FezbQBQVbzOxx2eaVQsAJuL8sJHrslfItAQbRkHnNIdR0jPaw
         PeIIRFxbvV7mudYl2wqY8m0GxsGtNCREMrSvjKIOFQa/GMCoiISMLlmdoB5fGjxVsqd7
         LTtrNnWsJ+pblv1avcl08iSiwfxyqZ1e49vlctQl2veMHHZZOUQF+CJedjgYfR1OSskY
         H2rVONyI4jM6NTD40/NfHdr7rhZlUx8nZyL82bnEAXyg7dgtfCOukuJDM+s5tCOC8nG2
         hrS0bQbGYkRtoTGTKwoh+N2bbtPkI8RQF9UXb7B6EcpLmQtXU9oAyuhuYlB758twf7FP
         5vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwgdEN02tOTM3X9OahYK6izrepiauXF6ean9NRJUvFU=;
        b=aoGw7U4q/MFBL/hwkxpOvaTfkewNbrZWARZG8qUm+uBvw/+IdqWmravfM7OQe9AwoY
         dJ5zW5j6FPcZ1TLcY3kXkHtKTKdUiWZeWRNkN7FK6sfd0KpGRHa0N2Wiy7UzEVkIjKjw
         iTyVZ0QbFhbbWJq/yFjBnRtbDn5UJqfHENRXcnyhZcvLMEA8Vrwt9J+I/fC3deZF936P
         SfGhutrdvbjzZLpTfcTfKDzZ/n8qeGiPZQaRJd3BlaSV92vJ2lDDfG+SyelFZlaayI2x
         3HLChMqCmTCHEJKyO5WdadITOc/JTELHO3gdhtNe7ABVATnFD13VSdEvk+xgEkyV7BZo
         gTIQ==
X-Gm-Message-State: AOAM533TcIa+L768IV9iNHIhTr0KHpIk1OjTZ5N6rJ+igGWO6DqjomQn
        9Gl+KOfKAIZObLU7bj8nNF0=
X-Google-Smtp-Source: ABdhPJzQJkV1Ji5I/M9r8VcmSuxcaAidH2Lua6PmnQXIKhhEdgC+6TPnF+a4bUGMaY5BTrQgb/uzXQ==
X-Received: by 2002:a63:fc20:: with SMTP id j32mr24780120pgi.8.1622499078504;
        Mon, 31 May 2021 15:11:18 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 25sm11358267pfh.39.2021.05.31.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:11:17 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 0/4] PCI: of: Improvements to handle 64-bit attribute for non-prefetchable ranges
Date:   Tue,  1 Jun 2021 07:10:53 +0900
Message-Id: <20210531221057.3406958-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Here's an updated version of changes to improve handling of the 64-bit
attribute on non-prefetchable host bridge ranges. Previous version can
be found at [0].

The series addresses Rob and Bjorn's comments on the previous version
and updates the checks for 32-bit non-prefetchable window size to only
apply to non 64-bit ranges.

Thanks,
Punit

Changes:
v2:
* Check ranges PCI / bus addresses rather than CPU addresses
* (new) Restrict 32-bit size warnings on ranges that don't have the 64-bit attribute set
* Refactor the 32-bit size warning to the range parsing loop. This
  change also prints the warnings right after the window mappings are
  logged.


[0] https://lore.kernel.org/linux-arm-kernel/20210527150541.3130505-1-punitagrawal@gmail.com/

Punit Agrawal (4):
  PCI: of: Override 64-bit flag for non-prefetchable memory below 4GB
  PCI: of: Relax the condition for warning about non-prefetchable memory
    aperture size
  PCI: of: Refactor the check for non-prefetchable 32-bit window
  arm64: dts: rockchip: Update PCI host bridge window to 32-bit address
    memory

 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  2 +-
 drivers/pci/of.c                         | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.30.2

