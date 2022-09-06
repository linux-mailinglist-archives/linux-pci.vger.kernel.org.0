Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6E5AEF0C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiIFPkq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiIFPkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 11:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDEF857D9;
        Tue,  6 Sep 2022 07:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC668B8164A;
        Tue,  6 Sep 2022 14:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485DEC433D6;
        Tue,  6 Sep 2022 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475847;
        bh=IWYwNU18G9PTGfD+4nqLzyhb3k5q7mA/RA7vnU/IXHU=;
        h=Date:From:To:Cc:Subject:From;
        b=Uzy/5s1hgpoOJsBlO5KS7ndSsoM/jWofjiZFoFoc4IV+vlJYIfP/bpAIdDgftB85G
         5JCx6BAsmD/yLH70mv9EbRBb3jhNyeSJmzy7u1/YPmBWfsVyRsDtmN957rjo90Edds
         y+HQHz8IvNkzW7EdusjiOZhup4ynBW6FhFeBsVYmwiWMzj7mw4wFEUGZF/9s3B3Eiy
         Asbas0toxzs9aEvqPUQwME8UhlHrxE5cQ8Ac9CUnwZ5WULvD9T4SXqllA1OVtTl8WY
         e3fdQS+uaQpdgUoiZsUi/JXbREBEk6ni4ZqjWvNpw1AbyGKwHk/mIzMNRAr+DJwcW4
         eUweX+lmF+Kew==
Date:   Tue, 6 Sep 2022 09:50:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 216448] New: AMD USB4 pciehp can't
 detect external PCIe devices]
Message-ID: <20220906145045.GA6927@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few details so far, but bugzilla has lspci and dmesg.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Mon, 05 Sep 2022 06:51:52 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 216448] New: AMD USB4 pciehp can't detect external PCIe devices
Message-ID: <bug-216448-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=216448

            Bug ID: 216448
           Summary: AMD USB4 pciehp can't detect external PCIe devices
           Product: Drivers
           Version: 2.5
    Kernel Version: mainline, linux-next
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: kai.heng.feng@canonical.com
        Regression: No

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
