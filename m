Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6B456DF4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 12:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhKSLKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 06:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSLKY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 06:10:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2CCC061574;
        Fri, 19 Nov 2021 03:07:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i12so9100716pfd.6;
        Fri, 19 Nov 2021 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ng8l4wsQzx4FyhspTcTbEghmGNKsvxAsvNHV4AmOCM4=;
        b=kwlBwdtHtIA5uGGdZqmEgUdYyt8G1rr8m3w7P2n3XQNNdqbheivwlu3QGRD24/ffE1
         Akfd4EtfB7NK9F668PZXMoCvZ4PCdO+BeTQZgf1dM5iq1vKym4c5LJdR32vCm+QXMqW4
         oVin56heQxqgfVHmAt+asxQGhUIHPJZvWqOUKtVRaWrQQenAAPwBmGLKFM22PUIomwiN
         Gge0dXF3hBHGoDSBRUyLzlPeXzaNNbeNY1RlqePbgh22zF6DShJAcfZtc7nLBUblhUCF
         OniieqSdAtXs4GqVIQaZvweoQFu85yedOlj3FhpOcO60qYhH+/KrVKy0a0bnaFtBeo+O
         LQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ng8l4wsQzx4FyhspTcTbEghmGNKsvxAsvNHV4AmOCM4=;
        b=ySdkQ6GqG8psBmIzLa+PxMJiaJr46TfsckIevy8WZ/jbYOpylhQKJzSykvEu0bIenw
         Z5Rt9JW9ikWqZB3NAu0HkI/C5OU/UAfwCkVKfbmGEpPUKQvyfGTY1KBEt102oBKZ2u24
         p1wjvsT7vaT8HDPma29+nkyU7axi0n3CAGxfrMwJoWgxqA2exqpQ1bnTD9t3gwCzAkdq
         YbdQa7PtSLQVy0IlOraPEGpKRKAY8r8L8Sk3ZVManFXIIvQaeZpByXmcMEpeZEi32VrF
         eivYjIrC9d2vMTuZRyXog+V72r/h3CbAEqaMV/QKeta5J9ke6Wyq3A/o/vjlk912MUpz
         11BQ==
X-Gm-Message-State: AOAM531BekhDheE18kh7+RH1XEIDfzdC5T69BByV+kQbe9TjXf1Ygu9d
        nrFNdEFiKDDI7gztRLiUR8o=
X-Google-Smtp-Source: ABdhPJxwBKk+vMnQ3lECFETlnGOjmmzm038+PS3pNbOX2tQZMAPHTTo4LYcoIe1EapXzblpX+a1ZuA==
X-Received: by 2002:aa7:9d9e:0:b0:4a0:25d0:a06f with SMTP id f30-20020aa79d9e000000b004a025d0a06fmr22760213pfq.82.1637320042290;
        Fri, 19 Nov 2021 03:07:22 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:da89:58f9:fd04:7bf9])
        by smtp.gmail.com with ESMTPSA id ne7sm10515484pjb.36.2021.11.19.03.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:07:21 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v4 0/1] PCI: Initial KUnit test fixture for resource assignment
Date:   Fri, 19 Nov 2021 16:37:06 +0530
Message-Id: <cover.1637319848.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently it's hard to deubg issues in the resource assignment code of
the PCI because of the long reproduction cycles between the developer
trying to fix the code and the user testing it due to the lack of
hardware device with the developer [1].

[1]:
https://lore.kernel.org/all/20210621123714.GA3286648@bjorn-Precision-5520/

Bjorn, suggested that it would be really good if we could have a test
fixture for debugging/testing resource assignment. 

The patch attached along with the cover letter is an attempt to lay the
foundation and also have a proof of concept to show that it is possible 
to have a test fixture to debug the resource assignment code.

Since there are a lot of things which happens during the resource
assignement phase, the first version only tests the __pci_read_base()
function since that was the most easiest to set up.

Hopefully, in the future patches I'll be able to write more KUnit tests
for the other parts responsible during the resource assignment phase and
get closer to the goal of having a complete test fixtures :)

Thanks,
Naveen

Changelog
=========
v4:
    - Fix datatypes of the global variables and the fields of data
      structures.
    - Fix code formatting
v3:
    - Rename init_registers to init_test_registers 
v2:
    - Add test cases to test resource assignment for Type 1 devices
    - Fix a error (a function was not static) found by Kernel Test Robot

Naveen Naidu (1):
  [PATCH v4 1/1] PCI: Add KUnit tests for __pci_read_base()

 drivers/pci/Kconfig              |   4 +
 drivers/pci/Makefile             |   3 +
 drivers/pci/pci-read-base-test.c | 795 +++++++++++++++++++++++++++++++
 3 files changed, 802 insertions(+)
 create mode 100644 drivers/pci/pci-read-base-test.c

-- 
2.25.1

