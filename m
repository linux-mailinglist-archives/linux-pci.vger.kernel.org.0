Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEB76F067
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjHCRNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHCRNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D981BF0
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691082766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEzhPRdTD+fDuYbhKrYmZSEqpZqahW5WFlqeU5TqQQU=;
        b=GhWWnAU73mF4UlVnKoVGhy2HCAkhV1R7GF39p3ZDgGGjb1cch8PhKIkkmntFEUumWyPLBS
        WEBQXX3UApShaGC9j1m6lFaQZ8IHyonr89KKC/ekW1VqQ7qxRBNJQjlDhSTM3gRmSQPSdk
        f7JsUU2WJtGJ7OaIO/3krOzSeJKgBOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Wa-CLyNiNTm7cACxcz5cOA-1; Thu, 03 Aug 2023 13:12:43 -0400
X-MC-Unique: Wa-CLyNiNTm7cACxcz5cOA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E838286801E;
        Thu,  3 Aug 2023 17:12:42 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1284021C9;
        Thu,  3 Aug 2023 17:12:42 +0000 (UTC)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     bhelgaas@google.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com
Subject: [PATCH v2 0/2] PCI: Protect VPD and PME accesses from power management
Date:   Thu,  3 Aug 2023 11:12:31 -0600
Message-Id: <20230803171233.3810944-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since v5.19, vfio-pci makes use of runtime power management on devices.
This has the effect of potentially putting entire sub-hierarchies into
lower power states, which has exposed some gaps in the PCI subsystem
around power management support.

The first issue is that lspci accesses the VPD sysfs interface, which
does not provide the same power management wrappers as general config
space.

The next covers PME, where we attempt to skip devices based on their PCI
power state, but don't protect changes to that state or look at the
overall runtime power management state of the device.

This latter patch addresses the issue noted by Eric in the follow-ups to
v1 linked below.

These patches are logically independent, but only together resolve an
issue on Eric's system where a pair of endpoints bound to vfio-pci and
unused by userspace drivers trigger faults through lspci and PME
polling.  Thanks,

Alex 

v1: https://lore.kernel.org/all/20230707151044.1311544-1-alex.williamson@redhat.com/

Alex Williamson (2):
  PCI/VPD: Add runtime power management to sysfs interface
  PCI: Fix runtime PM race with PME polling

 drivers/pci/pci.c | 23 ++++++++++++++++-------
 drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.40.1

