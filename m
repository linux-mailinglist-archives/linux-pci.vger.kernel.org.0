Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA312297665
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbgJWSF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754268AbgJWSF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Oct 2020 14:05:59 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA5522254;
        Fri, 23 Oct 2020 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603476358;
        bh=ByVUTSWetgwM64oThyZRdvjDVGcSpzWIPHLEr7mvncg=;
        h=Date:From:To:Cc:Subject:From;
        b=wnGI2zMWlXmaRczBdAmXoeKVdKpkEZdR+qvRBn9Ij2q8hTAXYtJmVz1BBnpZXtTV9
         YaqopTFNb0CE4Nkd/1lzf9FXGVsMwQJF6dDYd+GNTx5zB39/b8kBzR12JUncMfd/2w
         hs6Ah4gBU6gomdPnPPyEX28LpzqsAFSuxeTZ4fHE=
Date:   Fri, 23 Oct 2020 13:05:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     vtolkm@googlemail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [Bug 209833] New: BAR error updating
Message-ID: <20201023180556.GA669920@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Fri, 23 Oct 2020 17:17:28 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 209833] New: BAR error updating
Message-ID: <bug-209833-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=209833

            Bug ID: 209833
           Summary: BAR error updating
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.5.19 - 5.9.1
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: vtolkm@googlemail.com
        Regression: No

Created attachment 293153
  --> https://bugzilla.kernel.org/attachment.cgi?id=293153&action=edit
accumulated kernel log messages

device: Turris Omnia (armv7l)

lspci >
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless
Network Adapter (rev ff)
03:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter
(PCI-Express) (rev 01)

----

Since kernel 5.5.x this error exhibits:

BAR 0: error updating

It appears to be a regression from 5.4 where the error does not exhibits -
enclosed accumulated kernel logs. 

It may or may not cause issues for the atheros drivers as mentioned in bug
209751.

I have tried to narrow it further down to a particular commit from the 5.5
branch but unfortunately the kernel does not compile then.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
