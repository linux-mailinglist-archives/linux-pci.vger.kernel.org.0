Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B997CE24B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbjJRQJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344983AbjJRQI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91553118;
        Wed, 18 Oct 2023 09:08:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8377C433C7;
        Wed, 18 Oct 2023 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645335;
        bh=8EMrUpmQ/dxu9t4g0dBXpSoSTH19mpxuaSMVEHOy7uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwE6lqA/QH5gFXvA3/4JqY9co+femAvkLjU6T7h5Ds3s+2107qsqc2j96aAPbNSyB
         IiTy5E3UBxVgUTuOxiiNHWcwqj9a46kJEUJrVKqf61T48eIKaCetDghQ42HIi6sk0C
         GVc4KGWKRkhx3PbVA2oCjehgAAh4XI7P8IIO94GpcGbffVRCugowCqYpwVLqCw1OnY
         EeqP7TW2aKX2sGxxNQIWtjXX/ADr+pdVTyDlp5XCSypsZqmbyobwbMiChBSwe5fOSq
         UMKJeg3mvsgpfq00v7/cW0rCDbbxJEi9m9zku0MqzfxAovltYuWhb/1v5PlnK21UQV
         uMyrr92gW+yTQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 8/8] setpci: Fix man page typo
Date:   Wed, 18 Oct 2023 11:08:36 -0500
Message-Id: <20231018160836.1361510-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018160836.1361510-1-helgaas@kernel.org>
References: <20231018160836.1361510-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

"Several ways how to identity a register" doesn't read correctly and
misspells "identify".  Reword as "several ways to identify a register".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 setpci.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setpci.man b/setpci.man
index 9e4e1d8a6c44..fd4495f4d1b4 100644
--- a/setpci.man
+++ b/setpci.man
@@ -135,7 +135,7 @@ are hexadecimal numbers. In the latter case, only the bits corresponding to bina
 ones in the \fImask\fP are changed (technically, this is a read-modify-write operation).
 
 .PP
-There are several ways how to identity a register:
+There are several ways to identify a register:
 .IP \(bu
 Tell its address in hexadecimal.
 .IP \(bu
-- 
2.34.1

