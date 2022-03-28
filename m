Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43A04EA35C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiC1XB5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiC1XB4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 19:01:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC062459A
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 16:00:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so11971250ybg.8
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4i1l9AwTfFdRqUE9mxnbmrk0dHwvz4ZAenZccJvB6o4=;
        b=qhQZecwTYMf+9F7yNoTpRhQqYlOzBbcyLmOjLGZ+2DfFLnN01ArsyEc9L7i4fW5gIW
         wrxurOmtOwKxa22NDpX1WjFuENaqRudK5KYX4o5DTCZDzvB1ApjdSVEqdraxxjyLCAH8
         F2CdZhA5eh6qpyE2sFKVxh9A2/F1rO1MbiqNhzvrAYNt6IXbe+iWvWzawNcppFFX1gDN
         QEy5IaxY4b4XhR+DUb22pzXMedvHOcdcg1P3m53/ejxgDotSV8vSMW9g5YicsNVmNd5w
         TbMLzukw8r0a8bwmSzuyzT7T3BcIqEbgNIWtEq6FCjEqb0bm8g7kXPzcd73diH9jL9TW
         MjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4i1l9AwTfFdRqUE9mxnbmrk0dHwvz4ZAenZccJvB6o4=;
        b=faHqEcrZSO8/pYFiG6r8DcLTJOlYE6ejSHCQ9oW6imKq3G48Y1Ith+JHDLrrdlAv3d
         zTvW3hTKeiunTE0o4gC3wkZH8MIWpRYpLNOfWYu0y999ZCTXiSBAR1rj+sWj30dHRalP
         XzgP/iyAdI0WMdFmUZSvoHZkfqOVRva+X2I9/5AL4SNGg5wf2DHpHwwl+RlkiCEP0ErX
         Iiro1P4KqjeEDy2qBFvabAouscrJz2sqHqlm2XsJHwP6UocLe10WAj4dY9sCeH8k3CSC
         B64Dq6IooIvWLUeYSIrXQ79/0/GsjHd6/HtR6xYoa/E1BBj13MnUqQOWO/CF1WjxpfUr
         cDLg==
X-Gm-Message-State: AOAM533K5oKDx0v1NgYZywpXW8iKrwAghMT6MLncPoHPbR/UZ+5/x1RB
        KY6y5TI5qb63248ZazAjWA5mDyXYAxpLXR0=
X-Google-Smtp-Source: ABdhPJwQazt4139wX1tGxlX7XgKb6/VZvyzPRdIhufvuYPe+Sy8H/VS5jPEanUTEUA+sCU5Vw6ybWDF1XyuZkCg=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3dbb:6bbc:98be:a31e])
 (user=tansuresh job=sendgmr) by 2002:a25:e30c:0:b0:633:6081:d44b with SMTP id
 z12-20020a25e30c000000b006336081d44bmr25995917ybd.523.1648508413391; Mon, 28
 Mar 2022 16:00:13 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:00:05 -0700
Message-Id: <20220328230008.3587975-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v1 0/3] Asynchronous shutdown interface and example implementation
From:   Tanjore Suresh <tansuresh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Problem:

Some of our machines are configured with  many NVMe devices and
are validated for strict shutdown time requirements. Each NVMe
device plugged into the system, typicaly takes about 4.5 secs
to shutdown. A system with 16 such NVMe devices will takes
approximately 80 secs to shutdown and go through reboot.

The current shutdown APIs as defined at bus level is defined to be
synchronous. Therefore, more devices are in the system the greater
the time it takes to shutdown. This shutdown time significantly
contributes the machine reboot time.

Solution:

This patch set proposes an asynchronous shutdown interface at bus level,
modifies the core driver, device shutdown routine to exploit the
new interface while maintaining backward compatibility with synchronous
implementation already existing (Patch 1 of 3) and exploits new interface
to enable all PCI-E based devices to use asynchronous interface semantics
if necessary (Patch 2 of 3). The implementation at PCI-E level also works
in a backward compatible way, to allow exiting device implementation
to work with current synchronous semantics. Only show cases an example
implementation for NVMe device to exploit this asynchronous shutdown
interface. (Patch 3 of 3).

Tanjore Suresh (3):
  driver core: Support asynchronous driver shutdown
  PCI: Support asynchronous shutdown
  nvme: Add async shutdown support

 drivers/base/core.c        | 39 ++++++++++++++++++-
 drivers/nvme/host/core.c   | 28 +++++++++----
 drivers/nvme/host/nvme.h   |  8 ++++
 drivers/nvme/host/pci.c    | 80 ++++++++++++++++++++++++--------------
 drivers/pci/pci-driver.c   | 17 ++++++--
 include/linux/device/bus.h | 10 +++++
 include/linux/pci.h        |  2 +
 7 files changed, 144 insertions(+), 40 deletions(-)

-- 
2.35.1.1021.g381101b075-goog

