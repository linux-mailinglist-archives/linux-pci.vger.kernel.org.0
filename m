Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A737532B4B
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiEXN2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiEXN2d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 09:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1CD99685
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 06:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE5E361556
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 13:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAFBC385AA;
        Tue, 24 May 2022 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653398911;
        bh=2BtObpwkMOqBWAjqNin64BShlsz8K20u2yG/Lk+i7Nc=;
        h=From:To:Cc:Subject:Date:From;
        b=fJb+hvwcQMRGTO74fiMOjSx93KQxk0nKSumS/2fglUhYN66ulr89QKOgY7kNUKIKi
         KuHs6GEkuTdErkdKlqqyUYzY5lbBZiZLQ2EBtnbtGMXvXVYqPOqKR/3Pt6QO8brp4P
         TPzEhlphvPwub/TloCC74WSpLMJs+GF+amfA9HSD+Cd/mZ8abqG6VMy5slNNRPvMsL
         M1/PqzUXl0mDyv+GqXf7N2j61CFxDyEapmK046ZiWhxRMXMeKQuvsRIEelb4BmqUmy
         MhYaesa7br6gYrfkq+6p4lHvuc7I0cDK8yeu5e7V/nSSHitC8huEvpkfurb64PHPJC
         AHN26MxX8yNRg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 0/2] PCI: aardvark controller changes BATCH 5 (subset)
Date:   Tue, 24 May 2022 15:28:25 +0200
Message-Id: <20220524132827.8837-1-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

since Lorenzo is AFK but gave his review for patches 3 and 5 of fifth
batch of Aardvark changes, and you only requested to use FIELD_PREP [1]
in order to avoid adding new _SHIFT macros, I am now sending these two
patches to you. Could we get this merged?

Thanks.

Marek

Changes since v1:
- dropped all patches but 3 and 5
- changed patch 5 to use FIELD_PREP instead of _SHIFT macro

[1] https://lore.kernel.org/linux-arm-kernel/20220518202729.GA4606@bhelgaas/

Pali Rohár (2):
  PCI: aardvark: Add support for AER registers on emulated bridge
  PCI: aardvark: Fix reporting Slot capabilities on emulated bridge

 drivers/pci/controller/pci-aardvark.c | 110 +++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 9 deletions(-)

-- 
2.35.1

