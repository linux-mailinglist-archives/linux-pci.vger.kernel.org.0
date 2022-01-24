Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0316497DF2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 12:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiAXLaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 06:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiAXLaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 06:30:08 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677EC06173B;
        Mon, 24 Jan 2022 03:30:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v123so22696582wme.2;
        Mon, 24 Jan 2022 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tlvu1ap4CjjfExPOQsh+nU9XQRiDNncMg8d5FrHUtQ=;
        b=DHX54ML31aatDTsfr1KBCwwCyilFrQ6V+F7qbWI8YMQ1NnjCKPbxtR5FHpuC9plPoh
         zuZifAetBY3PwBGyEUXftdlRUGwSgw8DdL9nwGBLGnrXRaEBPoKRLN+DnXGgoCFF73l8
         aj2HJozYtNymn70RBdEq5ut3RpPXzmPiujry4nj4k8JAzVvv/KdALdiAuBtgoSZ3nDVH
         jvEYQt1vCM2i8ff7UKFcqi908zE0WMu1o4MI4sF+lIgc54oGlG7DNqR8+x+NaqGGszWd
         Fgsgb2uW1ePafl++wVulhf7NFtqdAVyrl8Ag8ZHuSmOkC+Z8gJ/2MoTZ7DCQKxg0n9uD
         jLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tlvu1ap4CjjfExPOQsh+nU9XQRiDNncMg8d5FrHUtQ=;
        b=2d6KLv7yiPrip9rkLJtWKykZ71cKVGZOMRLns0W6dHG+ptaoS9EJjVJn6u1ZqRv1Kv
         pkJy3PT5Kels32Pb4zGtBZjJRGh0Va1ZdwP1g8n9aEy6IDXmr3kOC2utpcUoxhVBhMlD
         4NGjMn7lNxKF8+W9k1jfWO3ith2e8IyxacDLoUxVKjAD/sBYqIJClN49BAqaeMGY/9ju
         m6pPRVbAC1jo5fpAXNcmag7fz3yAOn6ORMlfDyvLkfZUx8UoQGN5ms9DsNDb+4XUZ4Up
         TQKa2UJ5zOXpUjijOXqq/iQyvoVI7Wnl+3OVfO+e8YFW7v8puShWnetxYcBgKrmfozwn
         CDGQ==
X-Gm-Message-State: AOAM53069VMw0LbZhSNjeeGXLfrb0qdfBrv6CdNOIDIjjk51ICmyc90w
        zjM9iKcG7WS+3azEG+9SGf7E2bGaX6hnwA==
X-Google-Smtp-Source: ABdhPJwRhzxfHia5pHGQiPY/RbbszZ77nTqjw1azdwX2wbyx6hiosUK2qaj1ZsF0e6PLJli/8LYagQ==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr1427429wmh.185.1643023805981;
        Mon, 24 Jan 2022 03:30:05 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id y15sm3328927wrd.51.2022.01.24.03.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 03:30:05 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: mt7621: address some kernel test robot reported warnings
Date:   Mon, 24 Jan 2022 12:30:01 +0100
Message-Id: <20220124113003.406224-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kernel test robot complains about two things here[0]:
- pcie_rmw() [-Wunused-function]
- 'mt7621_pcie_ids' [-Wunused-const-variable]

Address this two warnings in this small two patches.

Best regards,
    Sergio Paracuellos

[0]: https://lkml.org/lkml/2022/1/24/264

Sergio Paracuellos (2):
  PCI: mt7621: drop 'of_match_ptr' to fix -Wunused-const-variable
  PCI: mt7621: remove unused function pcie_rmw()

 drivers/pci/controller/pcie-mt7621.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

-- 
2.25.1

