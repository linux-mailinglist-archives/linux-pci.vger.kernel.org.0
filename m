Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FB5F70E2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiJFWDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiJFWDe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:03:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184AC1142F6;
        Thu,  6 Oct 2022 15:03:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u21so4684965edi.9;
        Thu, 06 Oct 2022 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEU5L7Lgeequ7kmAnpC/Drq1f+6FpFdrDYIlUxJuPZ4=;
        b=NDfRAiQ6Ju1pQVxBzwiDNz8YyPRMrX9T3ldpLClFG1heSXl8pYz35a3hQjOXC5KN9J
         KIiBsnaDhBtgrDgGze5oDJnJSWrp1IdNEpCXgUx2XCWSKUsbQzk6jAH0JzdNFUXsDFza
         /y/vVo08T7rgO5WexrlspvKeodTNdEBsw5maHQ3tJxEj5vN+0hOLwEtHIUay+I2caxKr
         T/zIG871sTwGrd64+6HUIjSBt9hlNXnAiK9aSkTJR0mF0frmY5w2hFrATkX3fykn0dJ/
         uUzkqgez6IJ9QfFY+OEcPbNsi0KpElXH6+2P9+Do46ecFdBKJjI6PFt5d+rBMIv4jxkX
         Pe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEU5L7Lgeequ7kmAnpC/Drq1f+6FpFdrDYIlUxJuPZ4=;
        b=TAea+/hrdEayfcv2J2KHY+1+jNpADCxiIN1I76bLZqfEz+JPBrCDuzXLSQMWLzkpW3
         cRJFYSgIxhhE44Tggch8Nlv2GFTvBlqXCihBYCAjYmZJLbaxhaTGcIa2ruC0xV+e3sHv
         4tuhnwhadpjyCnd4pvB0TjdSdpKZLSSsoIGNHpRsK2BHlUZ9S8IJmtC3hnZIiroeK2DY
         6HUp1IQodk2dV3xZJi2wg1dXaRzOqea9KLWWoDDtv+EG1T/kDkCjaFWj+n9d8Izy5ju6
         5pZDOaS6iTpqEpe//Z1niB0nxoc5V6WGV4VpbOZH/zteXACCoijwzlXKzvhPnQ1I1EDH
         snFg==
X-Gm-Message-State: ACrzQf1Eh4kx631cjlkkqKaXflarUUH9v0AGrE2DTPxSB9sl1vmcNgPL
        arGlCvRLq7T1nX2MCjTbQbgJPk4M5P4=
X-Google-Smtp-Source: AMsMyM5ybTN/a8943Uk5lZg1yU510DysceUCRQBzghW1i48KLqk0czK/Qaaufz9xHvhBbm4Y/dXFuQ==
X-Received: by 2002:a05:6402:ca5:b0:459:3fb0:c157 with SMTP id cn5-20020a0564020ca500b004593fb0c157mr1729428edb.389.1665093808278;
        Thu, 06 Oct 2022 15:03:28 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0078246b1360fsm241484ejf.131.2022.10.06.15.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:03:26 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [PATCH v1 0/5] PCI: brcmstb: Add Multi-MSI and some improvements
Date:   Thu,  6 Oct 2022 18:03:16 -0400
Message-Id: <20221006220322.33000-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One commit brings Multi-MSI functionality to the Broadcom STB PCIe.
The other four commits are unrelated minor improvements.

Jim Quinlan (5):
  PCI: brcmstb: Enable Multi-MSI
  PCI: brcmstb: Wait for 100ms following PERST# deassert
  PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
  PCI: brcmstb: Functions needlessly specified as "inline"
  PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits

 drivers/pci/controller/pcie-brcmstb.c | 85 +++++++++++++++------------
 1 file changed, 48 insertions(+), 37 deletions(-)


base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.17.1

