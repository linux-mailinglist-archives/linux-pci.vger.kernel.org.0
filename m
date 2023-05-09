Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D836FCA5C
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjEIPjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEIPjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 11:39:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694119A4;
        Tue,  9 May 2023 08:39:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f42b984405so7014235e9.3;
        Tue, 09 May 2023 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646748; x=1686238748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAP6y9vENbOGTUMhyFaj/H50h+Cw78KTsgpA0Rfk0rk=;
        b=MufmtxbdxskYNVPPTGC4wvh5lnaRXX5HH8PFcWRPdIDNo5A5tuqVl1P7E/DC2oqNvn
         bXbUuYsN9QmwXlKoS8aSxKjfaEI2l0DchyG2G1HsZeQjFD8jp2zv6Nsyq5M3uUvMAjM0
         qjKoRkVK3vdJ54iePMleWGLCzvbKZa7L7VFcHjBdxA7Nszp8fcrKy40YzqCxklOPpD+k
         uQrfNZTBDx0hkpiNxq6PUcwpdIkDToBDoeBwfGGYVHMgkn7NYRo0/QIe7oZQPkwbQdhc
         9e435yLIw5Zy2bPFrZp3DvZDVkubxvzA5VwbPoTDYZ/TAPc4HjsdpxGmJrDAUzrdIwFQ
         UXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646748; x=1686238748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAP6y9vENbOGTUMhyFaj/H50h+Cw78KTsgpA0Rfk0rk=;
        b=TsxAQNzvv5PgoC5EFd4/Rx5Axzwr9MtvwublpuuQl4FWvzlb839uhDxzE+L2FtWT2O
         WHFhiIAmi4fUBrTqkUuPLJVjegjWYhqXUovGM70fuDk1XYxrXGxEteoxJMUengRUIrg0
         SUPQmVGIuTEA1hTooLfFi5GDKEB8wnEtftu0k6IJJF5N1ifKfw492UlMX2k23XZGRjBT
         zcrmzyTdFWtNehednZ8SwAEI43sd2suvHJUmon+I2cEeq8FhVYv1t1W6JD4lGuNTqOho
         y84JuHs++nIHY2Da95i7ChiiGwvbgo2e+z3aiermNxonEWPoMX33unBNSR1kw+UMW9dX
         aI6Q==
X-Gm-Message-State: AC+VfDyBNigIRf6QWbG68DjK3BC/qTUdzXTe9bxLe+RrG0FKp5ki8pSf
        pYN9lwm0woaeNNglYenvihQNMD+WJBKc6Jdo2XQ=
X-Google-Smtp-Source: ACHHUZ4aKda1ezxfuzftb1TPzU+2RoACFlSNYWggFpqk8qP96GfUNv2pmL5E+0OyroVm0hmVFu9jeQ==
X-Received: by 2002:a5d:4c49:0:b0:306:2c16:8361 with SMTP id n9-20020a5d4c49000000b003062c168361mr10045612wrt.22.1683646747911;
        Tue, 09 May 2023 08:39:07 -0700 (PDT)
Received: from localhost.localdomain ([146.70.132.238])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d6b52000000b002ff2c39d072sm14743147wrw.104.2023.05.09.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:39:07 -0700 (PDT)
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org,
        skhan@linuxfoundation.org, shawn.lin@rock-chips.com,
        lpieralisi@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [PATCH v1 0/1] Add configurable sleep for pcie-rockchip-host
Date:   Tue,  9 May 2023 17:39:02 +0200
Message-Id: <20230509153902.515106-1-vincenzopalazzodev@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am submitting a patch to add a configurable sleep for the
Rockchip PCIe driver in the hope of resolving a persistent
issue with old ARM platforms.

It has been observed that the driver requires an extra
sleep before probing the device, particularly on some older ARM
devices like Pine64 RockPro64. While an original patch was deployed
in Manjaro ARM, the issue still persists with the upstream kernel.

This patch introduces a module parameter "bus_scan_delay" which allows users
to configure the delay before probing the device. I have tested this patch
on several platforms and it has proven to be effective.

I hope that by starting this discussion, we can collaborate and
find a more robust upstream solution for this issue.

P.S: I sent again this because I forget to add some people to the list
of cc.

Cheers!

Vincent.
-------
Vincenzo Palazzo (1):
  drivers: pci: introduce configurable delay for Rockchip PCIe bus scan

 .../admin-guide/kernel-parameters.txt         |  8 +++++
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  3 +-
 drivers/pci/controller/pcie-rockchip-host.c   | 29 +++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.c        |  5 ++++
 drivers/pci/controller/pcie-rockchip.h        |  9 ++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

--
2.40.1

