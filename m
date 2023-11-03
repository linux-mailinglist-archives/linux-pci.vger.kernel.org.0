Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8987E08D1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjKCTGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbjKCTGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 15:06:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D7D45
        for <linux-pci@vger.kernel.org>; Fri,  3 Nov 2023 12:06:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574ACC433C8;
        Fri,  3 Nov 2023 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699038360;
        bh=WB2VBqP4FkYf+CscKwUu2G4wXteadNUWiyWAeVnE6Y0=;
        h=Date:From:To:Cc:Subject:From;
        b=aiuDs9fxiDE5NDcJmzuI2+oDp6YdVzMINf2oz03byC1aR8XlXHQayLap8/bnVRQVW
         Z7wChHQ9LSSlnyGunj9RCuFZVUdAv9pBYfwbbeSGm2XaUXPY7jBVMjgf6+N+dMxz5p
         LybxaGiFYlIEB5htQ0KtHYAqrxH7X3it3PdYbcddKuAWzkjHT+36x1MIlaDnf3SorZ
         jH6DMmAEjOK9ZcbAkVzIsJxxXBTYQj/qrp+vbYJVx6wFtRQ9sYBQPNmr65NKSl+XYS
         UppPuN9BZTIZCYO8jnzg2tolQUYerxyG6uE+hftWJ/EBjs8b9tNsB8n2eC46m+GAf5
         XuGWVUEga54Yw==
Date:   Fri, 3 Nov 2023 14:05:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joyce Ooi <joyce.ooi@intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Altera PCIe driver, email address check
Message-ID: <20231103190558.GA164012@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joyce,

You're listed at the maintainer of the Altera PCIe driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS?id=v6.6#n16287
but I just got a bounce when emailing to
"Joyce Ooi <joyce.ooi@intel.com>":

  <joyce.ooi@intel.com>: host mgamail-in.intel.com[134.134.136.20] said: 550
    #5.1.0 Address rejected. (in reply to RCPT TO command)

So I'm just checking to see (1) whether the email address is still
valid, and (2) if not, how should we update MAINTAINERS?

Maybe this driver is orphaned?

Bjorn
