Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1261539368A
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhE0TrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 15:47:25 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:47018 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhE0TrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 15:47:25 -0400
Received: by mail-ot1-f53.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso1294995otl.13;
        Thu, 27 May 2021 12:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w9OW5BGk0FbBfa1Zd9IjOQq7h/ljB9BUlO1jrL78U7w=;
        b=S06xvc4wdfHgegfM4GndrhoYd2Z5cBt0iufHqOgetUUiWIq765J9+AecZ3jyhxGOCO
         3HDHrUThfo/hHeFwcmuwN1n8US/JcJOajjoTwkpuHiGBhp5vZ/ZAW+iSAvpsR8wkcqWL
         gqnecQ2q/4r1nfXL/r31SpOItFHPzImmn7TkCQTWq4OJn689PGs3Sk3KZwZcm3qm8m5/
         koCg3wjrwV8TPbCOqFdL+FJzormNHJ9oWDrWSfoxWoTMt7qKSmeBCgr23xoK98kxzlbr
         +18HafqOVqOIWPuL40r//75sOCHSQMJiCvtD5fDeJgM16Efd85Lv61g3CEmQouFgxEwb
         8S2g==
X-Gm-Message-State: AOAM531vb5UTCoWg1/Ef1UNVXyFQrYaTJptxw4xdtApa30O0b2ouxAqj
        zbZf/9ymzAr1sNNk6vim1jiwDLFAKQ==
X-Google-Smtp-Source: ABdhPJyLn3wb/xTJc66hfU5ZQo3IHQ/Fv39tRVR4q1OO4WZHyxT4H7ygcYENGQoaovGQfvYBc/hWYA==
X-Received: by 2002:a9d:7d8d:: with SMTP id j13mr4122983otn.208.1622144749452;
        Thu, 27 May 2021 12:45:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m74sm665162oig.33.2021.05.27.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:45:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/4] DT address cleanups and refactoring
Date:   Thu, 27 May 2021 14:45:43 -0500
Message-Id: <20210527194547.1287934-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series merges implementations of som PCI and 'regular' DT address 
functions and it simplifies the of_address.h ifdefs a bit.

Rob

Rob Herring (4):
  PCI: Add empty stub for pci_register_io_range()
  of: Merge of_get_address() and of_get_pci_address() implementations
  of: address: Use IS_ENABLED() for !CONFIG_PCI
  of: Merge of_address_to_resource() and of_pci_address_to_resource()
    implementations

 drivers/of/address.c       | 114 +++++++++++++------------------------
 include/linux/of_address.h |  54 +++++++++---------
 include/linux/pci.h        |   4 ++
 3 files changed, 70 insertions(+), 102 deletions(-)

-- 
2.27.0

