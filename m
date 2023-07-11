Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873174F07D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGKNoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGKNoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:44:12 -0400
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C8AB4
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 06:44:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689083049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BJjdG6L2gUz3XSLb7iaT/clDAQ8Xpf2Z0wejyVjNYKA=;
        b=K2rdUN/fcLEq8g88AHQm079daO5ptlE0mWmpIkhQAXbzQNz2rDvJsIDItYXY5fwkwo42rd
        EA7FSYO4OhTUz9XKm5Ve98+WfdkwLz674o7PON301Tld15jp0Uza8vNvuNpS2K6apihHgV
        yVUD+YDDU9fSTcK8kPMxF0DEruaJRPg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sui@vger.kernel.org,
        Jingfeng@loongson.cn
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 0/6] PCI/VGA: Fix typos, comments and copyright
Date:   Tue, 11 Jul 2023 21:43:48 +0800
Message-Id: <20230711134354.755966-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Various improve.

Sui Jingfeng (6):
  PCI/VGA: Use unsigned type for the io_state variable
  PCI/VGA: Deal with PCI VGA compatible devices only
  PCI/VGA: drop the inline of vga_update_device_decodes() function
  PCI/VGA: Move the new_state assignment out the loop
  PCI/VGA: Tidy up the code and comment format
  PCI/VGA: Replace full MIT license text with SPDX identifier

 drivers/pci/vgaarb.c   | 168 ++++++++++++++++++++++-------------------
 include/linux/vgaarb.h |  27 +------
 2 files changed, 96 insertions(+), 99 deletions(-)

-- 
2.25.1

