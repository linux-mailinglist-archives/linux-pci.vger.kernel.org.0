Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DD74FCDF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGLBy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 21:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGLByZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 21:54:25 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13718171E
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 18:54:23 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R114k1DkYzBR5CM
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 09:54:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689126853; x=1691718854; bh=QDt5V1qbtA8v+foDitLWQlDYCUM
        5+ZnoES/3BD6Zv4M=; b=rGtdHWimvmzvqSZzjoBHOwAO71rX2dqnAALOTv8ZTH6
        nrGAMp9pil1LMsf3yPCpWfjkBGBmEa4krl1Ney7PkPb30Fxktq++/ab6dHJn/vnP
        nhlbk6V0LBb960wYyyC4zFkLszTO2FsL/xeCQsZqqGrXW3F0dbuLLIcCkxfkEWvb
        fN0QhO1pyt1JI0NUZybCgbDz76kitLuQmrACGC2mJf+nyb1o4LA5xLm1Jf5WJ8Zh
        AHEcxFAEvvypM5Wyu4IWROXdtV14OfOitLV7QHmTG45isEQ2NJyNu0afER0mCzZB
        JwU4nx+CsHkNcJkCslRP6fqu7sX/+sZkrmrU31CuLTQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0zeH_8OmV82I for <linux-pci@vger.kernel.org>;
        Wed, 12 Jul 2023 09:54:13 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R114j3LdHzBHXhY;
        Wed, 12 Jul 2023 09:54:13 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 09:54:13 +0800
From:   shijie001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: [PATCH] x86/pci:Fix errors in ce4100.c
In-Reply-To: <tencent_9BFBD2DD48250CEC69579ED53FF756022B05@qq.com>
References: <tencent_9BFBD2DD48250CEC69579ED53FF756022B05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d96ed681c938934e87beb65a6108d2a9@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following checkpatch errors are removed:
ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  arch/x86/pci/ce4100.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
index 87313701f069..0ffb6563e429 100644
--- a/arch/x86/pci/ce4100.c
+++ b/arch/x86/pci/ce4100.c
@@ -113,7 +113,7 @@ static struct sim_dev_reg bus1_fixups[] = {
      DEFINE_REG(8, 0, 0x10, (1*MB), reg_init, reg_read, reg_write)
      DEFINE_REG(8, 1, 0x10, (64*KB), reg_init, reg_read, reg_write)
      DEFINE_REG(8, 2, 0x10, (64*KB), reg_init, reg_read, reg_write)
-    DEFINE_REG(9, 0, 0x10 , (1*MB), reg_init, reg_read, reg_write)
+    DEFINE_REG(9, 0, 0x10, (1*MB), reg_init, reg_read, reg_write)
      DEFINE_REG(9, 0, 0x14, (64*KB), reg_init, reg_read, reg_write)
      DEFINE_REG(10, 0, 0x10, (256), reg_init, reg_read, reg_write)
      DEFINE_REG(10, 0, 0x14, (256*MB), reg_init, reg_read, reg_write)
