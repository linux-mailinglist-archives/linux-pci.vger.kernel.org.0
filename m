Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A736CA9E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 19:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhD0Rwc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0Rwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 13:52:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2280C061574;
        Tue, 27 Apr 2021 10:51:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y62so9269467pfg.4;
        Tue, 27 Apr 2021 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a/5CsXBnVimZy8HnpUcxEPFFOPqaMrP+1LxMMqVDo5A=;
        b=NiD+DxYp4gyiGQt3ICe7L6JDCnUMARVG+ajmTQyDznI1ulpO8GLGMq/pACk75qm4Ae
         A0Gt3jxbCDujtj/oh2cRPKyZGF76Cg6UkK84Z7ugC7zubLcrp+n/9EzbxPRXWMFYMg3H
         LQUAUJl5/bQjQqe0xAXQ5wtQ9Fo3auhPAg4L1YwetOPc12pbaIsNss1OuRRg7u0UnYWD
         OAeQV1R1ngBLLbggspOwgObMZhJ1LXdXmknBRs+qTLct6/yRZIidnpOORNnVOCHxEW/3
         mtoz2zLAA7zuJ6bhvCHSHA0djno6JZLcAcXl3iPfr9aSuyqpQzMoh4VCO9Ofc5WR+ERl
         pYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a/5CsXBnVimZy8HnpUcxEPFFOPqaMrP+1LxMMqVDo5A=;
        b=LpW8nzQscQ83sHR/qutwUbnAfJ17YTbKU47svIrL2y4oqghBEdoMtTMsXCFicvgm5f
         FlRyZkfVWcCsIUKfzRYsdq6iUiI9YK/MDOomHSm+RRm7YTHeZsVsa71Kd0XuAmnjjNwy
         xB3+n6myUqPOQWUR9E19QLDr13dSxtgS8q1lPHr0Tu0GFI8vPddXSBoGVrFQRjiFTZo9
         f7NpOuGqu+VlcpawyvsfI6YZYEnoOkuIygp+uaKUVLpxKdSUWFi9uwBzhdTxKo7qBHad
         mDW3GG0GG97meUkjz8udCMnRxj5gk8VtnzuXhxHMsYg+vJng8XO1Wp0IU8IQooOa5C2Q
         vRdg==
X-Gm-Message-State: AOAM531cOio0ZmE1F887X5S82GN3vMaYrzQFk7QpAMfJ3G6rYUPJz9TR
        +MwUVFIJzgQkGpXPV+tpC0AMqbKmlR0=
X-Google-Smtp-Source: ABdhPJzlpctZCi186q7X4+olIf7dZ/AjbaRCgLWw6YfXUHoqWWxCvfupkP9pEHJXiBMtZNUYZliw6g==
X-Received: by 2002:aa7:9af8:0:b029:25b:7027:9992 with SMTP id y24-20020aa79af80000b029025b70279992mr23889196pfp.12.1619545906333;
        Tue, 27 Apr 2021 10:51:46 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h21sm2456833pfo.211.2021.04.27.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:51:45 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v1 0/4] PCI: brcmstb: Add panic handler and shutdown func
Date:   Tue, 27 Apr 2021 13:51:35 -0400
Message-Id: <20210427175140.17800-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v1 -- These commits were part of a previous pullreq but have
      been split off because they are unrelated to said pullreq's
      other more complex commits.

Jim Quinlan (4):
  PCI: brcmstb: Check return value of clk_prepare_enable()
  PCI: brcmstb: Give 7216 SOCs their own config type
  PCI: brcmstb: Add panic/die handler to RC driver
  PCI: brcmstb: add shutdown call to driver

 drivers/pci/controller/pcie-brcmstb.c | 145 +++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 2 deletions(-)

-- 
2.17.1

