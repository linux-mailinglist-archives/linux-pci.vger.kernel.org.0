Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3151DE1BE
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgEVIXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgEVIXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 04:23:35 -0400
Received: from galileo.doth.eu (unknown [IPv6:2a01:4f8:a0:9e00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5AC061A0E
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 01:23:34 -0700 (PDT)
From:   Klaus Doth <kdlnx@doth.eu>
Subject: [PATCH] misc: rtsx: Add short delay after exit from ASPM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, rui_feng@realsil.com.cn
References: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
 <20200521085211.GA2732409@kroah.com>
Autocrypt: addr=kdlnx@doth.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b966d133-4e1e-f050-f1ca-67aa7eaf0ca7@doth.eu>
Date:   Fri, 22 May 2020 10:23:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521085211.GA2732409@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Klaus Doth <kdlnx@doth.eu>

DMA transfers to and from the SD card stall for 10 seconds and run into
timeout on RTS5260 card readers after ASPM was enabled.

Adding a short msleep after disabling ASPM fixes the issue on several
Dell Precision 7530/7540 systems I tested.

This function is only called when waking up after the chip went into
power-save after not transferring data for a few seconds. The added
msleep does therefore not change anything in data transfer speed or
induce any excessive waiting while data transfers are running, or the
chip is sleeping. Only the transition from sleep to active is affected.

Signed-off-by: Klaus Doth <kdlnx@doth.eu>
---
 drivers/misc/cardreader/rtsx_pcr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c
b/drivers/misc/cardreader/rtsx_pcr.c
index 06038b325b02..8b0799cd88c2 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -141,6 +141,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
     struct rtsx_cr_option *option = &pcr->option;
 
     rtsx_disable_aspm(pcr);
+    msleep(1);
 
     if (option->ltr_enabled)
         rtsx_set_ltr_latency(pcr, option->ltr_active_latency);

-- 
2.26.2


