Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97768973E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 11:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBCKsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 05:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjBCKsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 05:48:41 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D1925B9B
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 02:48:35 -0800 (PST)
Received: (qmail 23269 invoked from network); 3 Feb 2023 10:48:33 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 3 Feb 2023 10:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=2018; bh=Qd0n3iYKvkqnr1UxBEZH7G+jX
        SuDLdR87rBRGwP8cDU=; b=rc7EwTKYhYzoGyQgW2v1PLAlUPTGu5mQ60uqFN6H2
        ZlvfldDWivzpH8Vs50+ZvviKXKFuC/Mzul9YcSidOkS5ebI7OxTBJaG40gRElkrp
        JGaWoRdprqHdu2sC/9ef4OIW7n39+pKneaawKS19tY6PIzrwqXAiZI6f/mnWVHcD
        y8=
Received: (qmail 10933 invoked from network); 3 Feb 2023 10:48:33 -0000
Received: by simscan 1.4.0 ppid: 10872, pid: 10927, t: 0.6604s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 3 Feb 2023 10:48:32 -0000
From:   equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc, kernel test robot <lkp@intel.com>
Subject: [PATCH v5 0/3] PCI: of: Load extra data only from compatible DT nodes
Date:   Fri,  3 Feb 2023 18:48:19 +0800
Message-Id: <20230203104822.361415-1-equu@openmail.cc>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Edward Chow <equu@openmail.cc>

In order to solve the issue reported in
https://github.com/openwrt/openwrt/pull/11345 , this patchset attempt
to add mechanisms to ckeck whether an OF DT node is compatible to the
PCI device installed on the corresponding location or the driver for
it, and make ath9k and ath10k only load extra data from compatible
nodes.

V4 -> V5:
2, include <linux/pci.h> in ath9k/pci.c.

3, include <linux/pci.h> in ath10k/core.c.

Signed-off-by: Edward Chow <equu@openmail.cc>
Reported-by: kernel test robot <lkp@intel.com>

Edward Chow (3):
  PCI: of: Match pci devices or drivers against OF DT nodes
  wifi: ath9k: stop loading incompatible DT cal data
  wifi: ath10k: only load compatible DT cal data

 drivers/net/wireless/ath/ath10k/core.c |  30 +++
 drivers/net/wireless/ath/ath10k/pci.c  |   2 +-
 drivers/net/wireless/ath/ath10k/pci.h  |   2 +
 drivers/net/wireless/ath/ath9k/ath9k.h |   1 +
 drivers/net/wireless/ath/ath9k/init.c  |  27 +++
 drivers/net/wireless/ath/ath9k/pci.c   |   2 +-
 drivers/pci/of.c                       | 299 +++++++++++++++++++++++++
 drivers/pci/pci-driver.c               |   5 -
 drivers/pci/pci.h                      |  56 +++++
 include/linux/of_pci.h                 |  25 +++
 include/linux/pci.h                    |   6 +
 11 files changed, 448 insertions(+), 7 deletions(-)

-- 
2.39.1

