Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC759446D9B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 12:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhKFL3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 07:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFL3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 07:29:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DDFC061570
        for <linux-pci@vger.kernel.org>; Sat,  6 Nov 2021 04:26:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q126so6655876pgq.13
        for <linux-pci@vger.kernel.org>; Sat, 06 Nov 2021 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4GWAz9b/VAzIovNzOWJ+VfGLyAgKyAlp1rLinGXn/+M=;
        b=fd+LZ96eRcUQ0rBQulHodKAJ3tUkXmT0Hll9mEGpdUA3VdLKUmg58A0WEsbcTFNth1
         8RhQBz1qXiALVoDl2DBrsscIPWEc/X+lGfc0jtM3mWcO2bbk9Ougt9vZmaIMptQh+L/1
         /619hHFwBkuoquXKxaHAqWLIsi4tg0/Tj++1Ey7/GEkgC5AXTdBisOUNoN3TUucmkcVc
         rFgRGNxWo8FcMoXd0+N/fUQVTHCszPtvhBXVrulZ0xZyW3H2JZiR0Fv0XIcIcc63g2t1
         BKaypmU22SxZuI7idPvlLSp30+HGInAos0mTIpH4h0JxvnTxX10xbgx5eLjWjqjVW5sE
         Ce6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4GWAz9b/VAzIovNzOWJ+VfGLyAgKyAlp1rLinGXn/+M=;
        b=nD14LdJgVLOFnVmjyksVdGf/qZxVWrK5XZtN/umDPBaWaV0/YiY6oBngIbgUQSiEkF
         80CozSz9A6n3gWlnlTBPH3qihog6qYKjSjokbslNsSKFmeoJyz7Et3ABRfhcKMnSFcNn
         y/sV91DSR8EEvOF71WmlhSC5j0vIHC/tyaDA1gyHNxamaS7pLRKAVVpEiS9ZswgKuCUL
         0tJpQEBGwLHQnxaqDYhOWMRLXoEwUPyOYgnFpnqkQW85HX7NJDGv/cUu9SUMNlPaw+24
         B6RrCqaTIxfYIl0CgZLfcafdQRwVhYFzuPB3FGf1TRapQ+2/ZFcu4FnD601+R3pmQtem
         NCDg==
X-Gm-Message-State: AOAM532VZwSAFk2/EpVuyychpn67vB86VLtPRHe+UeCzBZxElwFKzK6W
        Ck0be6V1RzXuHIMdve0R490=
X-Google-Smtp-Source: ABdhPJxOCeK0Ugjw0jI7ftOzTtI9C+G/q57FyMISxnAXPMA6mWdy1qhOcl6EmY/fj7oQu61mM6o7Bg==
X-Received: by 2002:a65:5b45:: with SMTP id y5mr38594288pgr.279.1636197983143;
        Sat, 06 Nov 2021 04:26:23 -0700 (PDT)
Received: from localhost.localdomain ([124.253.6.45])
        by smtp.googlemail.com with ESMTPSA id c21sm10971037pfl.15.2021.11.06.04.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:26:20 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 0/2] PCI: Update BAR #/window messages
Date:   Sat,  6 Nov 2021 16:56:04 +0530
Message-Id: <20211106112606.192563-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The log messages in the PCI subsystem print the register offsets of the
BARs that can't be easily understood. At some places it prints the BAR
numbers. These should all be more meaningful, e.g., "BAR 0", "I/O window"
,"Prefetchable MMIO window", etc.

The first patch in this series adds a helper function that returns the
name of the PCI resource when called with index of the resource.
The second patch uses this function and updates the messages in one of
the places.

Many more messages have to be updated to make this a uniform process, I
will be sending subsequent patches that do the same.

Puranjay Mohan (2):
  PCI: Update BAR # and window messages
  PCI: Use resource names in PCI log messages

 drivers/pci/pci.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c | 20 ++++++++++---------
 3 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.30.1

