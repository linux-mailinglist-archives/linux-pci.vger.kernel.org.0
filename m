Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5804FEB7F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 01:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiDLXZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiDLXY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 19:24:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196897CDCF
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 15:43:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so276367ybg.8
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AMvt99Ex3LWgVMSklCg5XNF3Fu8kmLTfCLQjqVndY6w=;
        b=RazfDvaD5aj8XVU4guL9lnFicByqFFYKMKgI9ETIiiTeEWVsXQiUmC4r9d+KA7NlGz
         SMpX/oUt8RqMU0SPyZhXdqUQDx8LQQUHQ6iD3GKz8/G7FOVI0743NRajKeuQyq4Oxk4W
         eFksHyrtSZwa3mmURayx+lMlxJJVuTmYVWEbV46ZNxN8Mx+pyDt8lkTgCjOVXGBWGHCm
         yHyM2NQPx3xwEvLMhtxV4Jxn4NYyIPvlfVHF1PJ8ypg4N4dqW624dI5Z07Dr/nvsczuy
         CXbA2dXFHKpoD+vUdHIKSREFJjDiBl/oozVwp9T6RVdmqMsulQamDI0WhVn3V2vcxJvy
         OjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AMvt99Ex3LWgVMSklCg5XNF3Fu8kmLTfCLQjqVndY6w=;
        b=2z5JJES7Ylfpq7K/szxVQ0sZIGfMBhQOkInf2pKRPv+uwn5Ppx7uZvI2z7qHk76xSk
         zMfkcUilOAlJ+GonULE4U/mN7yBC0jqRsUxqW0RHCs8qguy+TGLN2G7IVnoIMmnlt8OG
         67lqZV50v6GEjn8XjDKvWjAeqXZyvhBUsNhdfjc200z74z2qK9GKm+cWm72RPmsf19QB
         AZzscyxZSxRG1I9uGWKnCxoacXlw/CB4S96sw614GI9mS1K54DIrRNaFuk5PBDizFzma
         J1/q15/mFVq64804gPug0HgoJ/TMf/l9UE4YKZfOR9n9+MISKfGNPfSkZCXBYvt6+fX+
         7+TQ==
X-Gm-Message-State: AOAM531/So7dOs0rqf6mNaFnVFZS4foiDWPQLMhAIjYVWjbPQmlqtqPP
        PWGZdQrEwHC3vjADjcfQQIceQVU4I3yIwyk=
X-Google-Smtp-Source: ABdhPJxCd0bNO7tLDwtDjUMz0mlBl45zHQLJLdIutO0p8cCHIr5/4Sb9YUXg6f/qhNMrRWACrr9iOa0pZYfPhJM=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:8573:aa64:c3e8:ebc])
 (user=tansuresh job=sendgmr) by 2002:a25:d34f:0:b0:641:3dcc:c2de with SMTP id
 e76-20020a25d34f000000b006413dccc2demr11259325ybf.547.1649803435313; Tue, 12
 Apr 2022 15:43:55 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:43:45 -0700
Message-Id: <20220412224348.1038613-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 0/3] Asynchronous shutdown interface and example implementation
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changelog:

v2: - Replaced the shutdown_pre & shutdown_post entry point names with the
      recommended names (async_shutdown_start and asynch_shutdown_end).

    - Comment about ordering requirements between bridge shutdown versus
      leaf/endpoint shutdown was agreed to be different when calling
      async_shutdown_start and async_shutdown_end. Now this implements the
      same order of calling both start and end entry points.

Tanjore Suresh (3):
  driver core: Support asynchronous driver shutdown
  PCI: Support asynchronous shutdown
  nvme: Add async shutdown support

 drivers/base/core.c        | 38 +++++++++++++++++-
 drivers/nvme/host/core.c   | 28 +++++++++----
 drivers/nvme/host/nvme.h   |  8 ++++
 drivers/nvme/host/pci.c    | 80 ++++++++++++++++++++++++--------------
 drivers/pci/pci-driver.c   | 20 ++++++++--
 include/linux/device/bus.h | 12 ++++++
 include/linux/pci.h        |  4 ++
 7 files changed, 149 insertions(+), 41 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

