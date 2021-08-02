Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3362D3DDDEF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhHBQtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 12:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhHBQtD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 12:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6F5761102
        for <linux-pci@vger.kernel.org>; Mon,  2 Aug 2021 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627922934;
        bh=EkUi9SSb64en+93fJfS/M/JfFfsrtJooBuaIIsIupHo=;
        h=Date:From:To:Subject:From;
        b=N+xKlb6zd19ZXpQDLhtcnBADfSJjAIn371bxepU1/WambkR6DcrblJnH6SOSfsUMP
         yWFXla4/dMrwtlNucie39JmclgoXEfiY0DLCoRai9xTdMnFDQRoA4BghUpAW2EkVV0
         dWcH2avgQO9L9r81YUyAg+U+ADrdAteOLE8qddVinB6Fsb9lFw4bUf/k4lbcr0YC3t
         pn/0fMtORIcvb+axR4E+9poZDVL9bWzKWNj2Lci3n5SgmCdopP99DAqDUqH89NrPCs
         ioeF5l3NSsRuVxQFJKtViJsSoGToLhB7Z23qzcU5fOF9f+r8qvZ2Eke7UK3/mijDsk
         O1bqpxiKjwqXw==
Date:   Mon, 2 Aug 2021 11:48:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 213945] New: Unable to
 power off iMac16,2]
Message-ID: <20210802164852.GA5017@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Mon, 02 Aug 2021 16:02:47 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bjorn@helgaas.com
Subject: [Bug 213945] New: Unable to power off iMac16,2
Message-ID: <bug-213945-41252@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=213945

            Bug ID: 213945
           Summary: Unable to power off iMac16,2
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.4.0
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: kevo@gatorgraphics.com
        Regression: No

Created attachment 298155
  --> https://bugzilla.kernel.org/attachment.cgi?id=298155&action=edit
dmesg

I believe this bug is very similar if not the same to
https://bugzilla.kernel.org/show_bug.cgi?id=103211.

I have managed to work around it and have the computer power off by using the
two setpci commands from comment 298 in bug report 103211 in a systemd shutdown
script placed in /lib/systemd/system-shutdown.

#!/bin/sh

case $1 in
        poweroff)
        setpci -s1c.0 0x20.l=0xf011f001
        setpci -s1c.0 0x24.l=0xf031f021
        ;;
esac

Without the script the computer will just hang at shutdown. It also will not
suspend properly. It looks like it does, but then it will not wake up and I
have to hard power it down by holding the power button for 10 seconds before I
can turn it back on again.

I am attaching the output of dmesg, lspci, dmidecode and /proc/iomem and
/proc/ioports to aid in possibly extending the quirk fix from the previous bug
report. Hopefully the issue is similar enough that it will be a quick fix.

I do believe I am running the latest BIOS (427.140.8.0.0 06/13/2021) which I
believe was installed when I installed Big Sur.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
