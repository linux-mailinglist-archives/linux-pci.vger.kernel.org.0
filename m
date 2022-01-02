Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB51482D2B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 00:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiABXcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Jan 2022 18:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABXcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jan 2022 18:32:53 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 851E8C061784
        for <linux-pci@vger.kernel.org>; Sun,  2 Jan 2022 15:32:53 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8CEB89200CD; Mon,  3 Jan 2022 00:24:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 868AA9200CC;
        Sun,  2 Jan 2022 23:24:59 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:24:59 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] x86/PCI: SiS PIRQ router updates
Message-ID: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 Reposting as this has gone nowhere.  Regenerated for line changes and 
with Nikolai's Tested-by annotation for 2/2, which now have been verified 
in combination with generic PIRQ router updates posted separately (there's 
no ordering dependency between the two patch series).

 Nikolai has observed the trigger mode not being fixed up once it has been 
incorrectly set by the BIOS for PCI devices, causing all kinds of usual 
issues.  As it turns out we don't have a PIRQ router defined for the 
SiS85C497 southbridge, which Nikolai's system uses, and which is different 
from the SiS85C503 southbridge we have support for.

 As we use the generic `sis' infix (capitalised or not) for the SiS85C503 
southbridge I have prepared this small patch series to first make the 
existing SiS program entities use a more specific `sis503' infix, and then
provide a suitable PIRQ router for the SiS85C497 device.

 See individual change descriptions for further details.

 Please apply.

  Maciej
