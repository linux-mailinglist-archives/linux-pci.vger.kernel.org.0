Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D037D6C98
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbjJYNAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJYNAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 09:00:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80B90
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 06:00:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5859d13f73dso3666852a12.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238836; x=1698843636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFTOgl/kJhR2WRDXW1Ma6mhbjE5SivocVIxvRqaPado=;
        b=QTZwXkih+fea6Z7i4YkQAN9CxV4DCNBm/o3WVzQ+VTI0SwddPgG46gnhsJjAHosQ0L
         /XMmUIKUEL/j9R3ay4vjpmQ2vuLyQ7eUPS3y9qvsyZj/p51RQ5FlL4yq56hKcS6I5Mrl
         nPTr9yGYmQy7cJQ1mkTQntnCzqz0UGDlhBebJeLwUxP4ZXrw432qzy+PbIscaWBOIPit
         jrtDbiIgO9sHC2hmSlDs8yKT/c0ytMn/CCQWXL2IqyDzss3nLREE+6E1BwpajHAsFMfo
         o316QyEOrOBCCAe5E+m11TcCx9NMVjtp31ZcQfg+ddtv1kPkZVvdhYp9yR68bxZWbOUP
         7D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238836; x=1698843636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFTOgl/kJhR2WRDXW1Ma6mhbjE5SivocVIxvRqaPado=;
        b=JHiofFMTq91PtTpzwgFLW4tbF4+acyZiwjwJRmNq7uXJE8y6QLoGUqCf2jFCOyjxlA
         A0oytZPG/lb93RqryFgaCM0ez8Fkt81AIFV1VS3Gda4/0Ylxmm94ZShd8nwhpKPsWEoU
         TdDLqNNSelIrCK+VUoIBs2TmhOOdtYFduaqBAMv5b8AaVe0PIKiKzoKlsCs0SIch6+33
         U6I5vNmwMhTMbgoQO8RUyVMXSSpmuaHqIDY4WjHTdELVyLgWT3KHhZhaVj60gxefVjOq
         SLQv94fLDmBb2K/R3TZzsvdYMCMQ3p3F/Rdf+AAECB9hWkFQAJ254pgz3Ej01V6g6I/9
         uUgA==
X-Gm-Message-State: AOJu0YywsIdCM+zJvWXef2kEgnod6l38duZ+IDk8uPOeiAlG5qOP1Ci9
        MBL9M4OoqnAPeDgJG2DgYR6H
X-Google-Smtp-Source: AGHT+IEudHKYUj3MJXEN3XChwf3bhzwEfzV/STKSvMT9BgtyJjMhMeMJfpMlzb3DojkWAtUc1eZArQ==
X-Received: by 2002:a05:6a20:3c90:b0:17a:fcda:4a6b with SMTP id b16-20020a056a203c9000b0017afcda4a6bmr6495949pzj.13.1698238835866;
        Wed, 25 Oct 2023 06:00:35 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.120])
        by smtp.gmail.com with ESMTPSA id n11-20020aa7984b000000b00690d4464b95sm9616304pfq.16.2023.10.25.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:00:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_bjorande@quicinc.com,
        fancer.lancer@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/1] PCI: qcom-ep: Fix the BAR size programming
Date:   Wed, 25 Oct 2023 18:30:28 +0530
Message-Id: <20231025130029.74693-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series fixes the issue seen on Qcom EP platforms implementing the DWC
core while setting the BAR size. Currently, whatever the BAR size getting
programmed through pci_epc_set_bar() on the EP side is not reflected on the
host side during enumeration.

Debugging that issue revealed that the DWC Spec mandates asserting the DBI
CS2 register in addition to DBI CS while programming some read only and
shadow registers. So on the Qcom EP platforms, the driver needs to assert
DBI_CS2 in ELBI region before writing DBI2 registers and deassert it once
done.

This is done by implementing the write_dbi2() callback exposed by the DWC
core driver in the Qcom PCIe EP driver.

This series has been tested on Qcom SM8450 based development platform.

- Mani

Changes in v2:

- Switch to write_dbi2() callback as suggested by Sergey

Manivannan Sadhasivam (1):
  PCI: qcom-ep: Implement write_dbi2() callback for writing DBI2
    registers properly

 drivers/pci/controller/dwc/pcie-qcom-ep.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.25.1

