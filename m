Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B645A699
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhKWPlS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhKWPlR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E4C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j3so1964380wrp.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wm8cas/oVylJimUfqvpwqtG1P5D3viwP+saXuB2ptDU=;
        b=Zx6B0v0mWYPBzFSOencQEo+LUzjfFQyOyZEyubaiKzEBOIdpOS40swCKRNJxRzsDmK
         UF5rOh4ZnvRs/d/u+QnFIIMYQY5vj6GEOL4nnxx+81A/H5JDN8RBccHzQFHAEwsJxaAe
         +N/X8YyYCoewa5hETVXHTOn51t0KMJwmdt8feADsMkYMCUXVQhmHjBYMu1hPQNtjsc7B
         2zZAuu3ulcXbly6iVFVmt8XgVoy7Rvq32Vo2sAu3VfljCkqCNFcRS2KLHlvQlMEG8JU/
         ibntBxjFrcllu11dat/VcMrKEQeaPzUSMYK1h7fKGX+PiKqNLnDLnkDCWGSJJusIjwga
         m8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wm8cas/oVylJimUfqvpwqtG1P5D3viwP+saXuB2ptDU=;
        b=rdgBHDdQPzAkIIMTKSa/US7dgbZnWGiuLCh9uPzHwdMX/fw/ystQYF6KPHGkuMUztf
         9imHfw407SZVo5t77/rprCOSebaDPivcgEh5ERYJ5q1uP+9vCZkMdRnxrfD4/I5jiYb5
         Xd5P180H8t6SWwRnEaRqnGBgc8eFvUrhpt13bsbjquV5yAyDLBhRvF4yBCWoREwAGRKc
         FzD+18h4/FlVmKZm/SUPRKmRBhwYdWvcMKghdM9fTcgOTnz2MUle6AII5cyULilxhSlF
         wk11JEJf4tMtk8K0849KEm2ADeUMBja6ryeno8HZQAkuglHfvEAA7bAApXekeoE6sBDW
         LPzQ==
X-Gm-Message-State: AOAM532/Li2j0V0ak3WTT75qUAgQCTTDXD9OtQCNfgJ9owJ1GQgvasyk
        5m3WSa+3J/TYprXrgIgCzXI=
X-Google-Smtp-Source: ABdhPJzjtw8x3MC6SvRr4EN/7HLCg2zG3/ll8coA+CzvFpVlJAmRTRGigEbUx1jZS0qxK/HjoVjEig==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr8949320wrv.106.1637681887508;
        Tue, 23 Nov 2021 07:38:07 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:07 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/7] PCI: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:37:55 +0100
Message-Id: <cover.1637678103.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some drivers use of_match_device() in probe(), which returns a 
"struct of_device_id *". They need only the of_device_id.data member, so 
replace of_device_get_match_data() with of_match_device().

Fan Fei (7):
  PCI: altera: Prefer of_device_get_match_data() over of_match_device()
  PCI: cadence: Prefer of_device_get_match_data() over of_match_device()
  PCI: kirin: Prefer of_device_get_match_data() over of_match_device()
  PCI: dra7xx: Prefer of_device_get_match_data() over of_match_device()
  PCI: keystone: Prefer of_device_get_match_data() over
    of_match_device()
  PCI: artpec6: Prefer of_device_get_match_data() over of_match_device()
  PCI: dwc: Prefer of_device_get_match_data() over of_device_device()

 drivers/pci/controller/cadence/pcie-cadence-plat.c | 6 ++----
 drivers/pci/controller/dwc/pci-dra7xx.c            | 6 ++----
 drivers/pci/controller/dwc/pci-keystone.c          | 4 +---
 drivers/pci/controller/dwc/pcie-artpec6.c          | 6 ++----
 drivers/pci/controller/dwc/pcie-designware-plat.c  | 6 ++----
 drivers/pci/controller/dwc/pcie-kirin.c            | 6 ++----
 drivers/pci/controller/pcie-altera.c               | 8 ++++----
 7 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.25.1

