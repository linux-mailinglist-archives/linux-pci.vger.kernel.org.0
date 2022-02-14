Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CCB4B4556
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiBNJPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 04:15:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiBNJPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 04:15:05 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 01:14:57 PST
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E26007D;
        Mon, 14 Feb 2022 01:14:57 -0800 (PST)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nJWcF-0007ZQ-3a; Mon, 14 Feb 2022 08:21:47 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nJWcE-004vyw-NT;
        Mon, 14 Feb 2022 08:21:46 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        david.abdurachmanov@gmail.com
Subject: fu740 pcie driver fixes
Date:   Mon, 14 Feb 2022 08:21:42 +0000
Message-Id: <20220214082144.1176084-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This pair of patches is currently necessary to allow any PCIe
probe on the SiFive Unmatched board without using U-Boot to
probe the PCIe bus (which does all the setup below). We found
this as we have been network booting kernels onto our boards
for testing.


