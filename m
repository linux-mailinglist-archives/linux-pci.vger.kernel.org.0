Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02B5BFD06
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIULkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIULkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 07:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F226719B6
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 04:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3376662434
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 11:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B465C433D6;
        Wed, 21 Sep 2022 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663760422;
        bh=nCLcK4RpoqPHMRTvtnV7/6oJqfc3tjwJfuB+YTf+AQI=;
        h=Date:From:To:Cc:Subject:From;
        b=arnAA4DlCG8aTlYbqyakk0y4oyToge6ijlcYbW3itBCNwgiXwiR/2PsUS1mU73YeZ
         9RGLx7DUNO0Ih0S3TWc2OPxFbzx1H6xEO4fBvzpr/r43SKgjP6V9OugTREXqJP/Mco
         /cS1JUv5i7bzHzSMXMFIxbBe/5o46RFkoTDr5PNhqRrUJk9f9XLB2hgB0rj36iG/sB
         jetAJ6Eg2c6jf58ic9kq9PWAG4N2VsX0/QKi6vG6rD46d3a7j9AKWjvAkpHVIC+L5n
         kdw64nU1wpeBU+zUhsvK0u3NguGvz8qxEYixwYLOjOgFLYjX5a9UBB54s5lcDjS2vw
         XiKJr1vVTIxPQ==
Date:   Wed, 21 Sep 2022 06:40:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Cc:     Richard Weinberger <richard@nod.at>
Subject: [bugzilla-daemon@kernel.org: [Bug 216511] New: Spurious
 PCI_EXP_SLTSTA_DLLSC when hot plugging]
Message-ID: <20220921114020.GA1191462@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Wed, 21 Sep 2022 11:30:47 +0000
From: bugzilla-daemon@kernel.org
To: bjorn@helgaas.com
Subject: [Bug 216511] New: Spurious PCI_EXP_SLTSTA_DLLSC when hot plugging
Message-ID: <bug-216511-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=216511

            Bug ID: 216511
           Summary: Spurious PCI_EXP_SLTSTA_DLLSC when hot plugging
           Product: Drivers
           Version: 2.5
    Kernel Version: Any
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: richard@nod.at
        Regression: No

Created attachment 301842
  --> https://bugzilla.kernel.org/attachment.cgi?id=301842&action=edit
full dmesg while hotplugging two nvmes and spurious link change

A x86_64 machine has a PCI switch (PEX 8747) with four ports, on two of them
NVMe disks are attachable.
Using a vendor specific tool I can power on/off each port.
When I power on both ports, hot plugging a NVMe into any port, it works
perfectly fine,
but as soon I plug a second one, *both* ports receive a PCI_EXP_SLTSTA_DLLSC
event.
As consequence the previously attached NVMe will be detached and only device
remains, or the previously attached NVMe gets detached and immediately
reattached but all IO fails later.

To me it seems very wrong that both ports see PCI_EXP_SLTSTA_DLLSC.

The problem can be observed with any kernel so far.
Could this be a firmware issue? What debug further methods do you suggest?

Thanks,
//richard

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
