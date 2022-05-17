Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E952ADD2
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 00:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiEQWIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 18:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiEQWIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 18:08:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB32377FD
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fed274f3fbso4266687b3.17
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X9rd48IcOQMlJI4fL1LiOmaxrjRg+Q4uXQPcsoEgV+k=;
        b=FlPd4Ema1RTlqOmUDneIdv1KEKzfvy5j81NCIQeDPZybHktJlCFTbLL4ZkCjfGPLVC
         nMHR9eGulo22rP5seemivgemqbsWdMosN/8jIZz+5WRGX7iR97kNyjmLjJacDnOJnsdn
         L+Rhi1RJ/5Vk2i2KnaG7WO10vJsTNBLaN4eITTnEPWFkpEzMB8yYbbm8Q3GEMOzVP5MQ
         3HSQqqhUCeOpRHu4aKeQ6HDtK32bZIUNT2zL/+Kj+9UEztN8TtaM/gqYK841nJ9TcN5g
         GMI5o9E8QNXP+KkedPoVP3OeQsAjzD9IDLkczE0Iu+oj9bEqvQO47sCQW8NfvLUrFFVE
         NZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X9rd48IcOQMlJI4fL1LiOmaxrjRg+Q4uXQPcsoEgV+k=;
        b=v4qVIP0mpeLfDzF+NFa54RMNjVtgUS/8zPuc9HpPQhwYD8NYGpoEJdtSxH2pUdSWNG
         vOIutLA9Tc+Pbqvi1r+TuGe8bENHdvQg2ZkS9HfwrAHSRa5me0g8ccrNyGBQExgD26eh
         yw16ZJyQEzdYTSf97f4nIjJgQFVRmoE1dkb1wIgtdQGiNuLV8S2dFxNsULGVFWnVQAks
         qE9CJDZ3o1wIoPGf8UNjYgUmLeoTL+ip6Ary1MpAXnuFxbRhsDunT+UHOAmAxaqXveq7
         Pv7DmGPF3hK4SO3Bq2uhABvoL71Yw9eWTotU7HsnposVLzMV0tfnErDTXE+AgcFwLXq2
         RyAg==
X-Gm-Message-State: AOAM533nqb/12jCMP2VVt21CZQyJFP2+TBqTxNRr6/b+AB34Dj08+SAU
        rmzDKP1JWZIdijPi1IXMXl5pTGMxO53PujA=
X-Google-Smtp-Source: ABdhPJyAvSIgyxv8X2AWvhlPaUJR0PhTeRsTDBvxqVMgCBrF0GHmO5hdx8s6AygIcKEcbgRoxQnJXpmt/P1nufI=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a05:6902:84:b0:63d:4a3d:eb5 with SMTP id
 h4-20020a056902008400b0063d4a3d0eb5mr24596845ybs.145.1652825302496; Tue, 17
 May 2022 15:08:22 -0700 (PDT)
Date:   Tue, 17 May 2022 15:08:13 -0700
Message-Id: <20220517220816.1635044-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/3] Asynchronous shutdown interface and example implementation
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

Changelog:

v2: - Replaced the shutdown_pre & shutdown_post entry point names with the
      recommended names (async_shutdown_start and asynch_shutdown_end).

    - Comment about ordering requirements between bridge shutdown versus
      leaf/endpoint shutdown was agreed to be different when calling
      async_shutdown_start and async_shutdown_end. Now this implements the
      same order of calling both start and end entry points.

v3: - This notes clarifies why power management framework was not
      considered for implementing this shutdown optimization.
      There is no code change done. This change notes clarfies
      the reasoning only.

      This patch is only for shutdown of the system. The shutdown
      entry points are traditionally have different requirement
      where all devices are brought to a quiescent state and then
      system power may be removed (power down request scenarios)
      and also the same entry point is used to shutdown all devices
      and re-initialized and restarted (soft shutdown/reboot
      scenarios).

      Whereas, the device power management (dpm)  allows the device
      to bring down any device configured in the system that may be
      idle to various low power states that the device may support
      in a selective manner and based on transitions that device
      implementation allows. The power state transitions initiated
      by the system can be achieved using 'dpm' interfaces already
      specified.

      Therefore the request to use the 'dpm' interface to achieve
      this shutdown optimization is not the right approach as the
      suggested interface is meant to solve an orthogonal requirement
      and have historically been kept separate from the shutdown entry
      points defined and its associated semantics.

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
2.36.0.550.gb090851708-goog

