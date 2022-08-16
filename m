Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB09596344
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiHPTkF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 15:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiHPTj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 15:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89136FA10
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660678794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=99qO0Nf8VtqkK4bGjYnLFMxes7rr79fkz1N2fUj7ysY=;
        b=aQQRX4hjGy++P6yc6F66//73ULzuLd5oHt0VEAQeFN2PufqGdHG6ib81h7wKhhuH4qYKMu
        1Gj9ckSMiov+N9hkLsTCUf0GNPmAEXLk6xFn1zojg0FkQck449a2dGJR8NWbjCWDSkvC7t
        bVE3a8sgumNlegBtWYPrinAlCbh2uXw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-Gy9LF_6lNzG3WC6NufBPUg-1; Tue, 16 Aug 2022 15:39:51 -0400
X-MC-Unique: Gy9LF_6lNzG3WC6NufBPUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48F6B1C04B66;
        Tue, 16 Aug 2022 19:39:51 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4147945DD;
        Tue, 16 Aug 2022 19:39:50 +0000 (UTC)
Subject: [PATCH 0/3] PCI: Expose resource resizing through sysfs
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 13:39:50 -0600
Message-ID: <166067824399.1885802.12557332818208187324.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have a couple graphics drivers making use of PCIe Resizable BARs
now, but I've been trying to figure out how we can make use of such
features for devices assigned to a VM.  This is a proposal for a
rather basic interface in sysfs such that we have the ability to
pre-enable larger BARs before we bind devices to vfio-pci and
attach them to a VM.

Along the way I found a double-free in the error path of creating
resource attributes, that can certainly be pulled separately (1/).

I'm using an RTX6000 for testing, which unexpectedly only supports
REBAR with smaller than default sizes, which led me to question
why we have such heavy requirements for shrinking resources (2/).

The final patch proposes the sysfs interface and I'll leave the
discussion there for whether this is a good approach.  Thanks,

Alex
---

Alex Williamson (3):
      PCI: Fix double-free in resource attribute error path
      PCI: Skip reassigning bridge resources if reducing BAR size
      PCI: Expose PCIe Resizable BAR support via sysfs


 Documentation/ABI/testing/sysfs-bus-pci |  27 +++++
 drivers/pci/pci-sysfs.c                 | 126 +++++++++++++++++++++++-
 drivers/pci/setup-res.c                 |   2 +-
 include/linux/pci.h                     |   1 +
 4 files changed, 154 insertions(+), 2 deletions(-)

