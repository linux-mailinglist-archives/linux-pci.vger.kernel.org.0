Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB624FF8C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 04:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfFXCyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jun 2019 22:54:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:51988 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfFXCyW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jun 2019 22:54:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O2sHRv010257;
        Sun, 23 Jun 2019 21:54:18 -0500
Message-ID: <3fb672e0e1aedd4943722912a2f9165d90d7b585.camel@kernel.crashing.org>
Subject: Two approaches for resources survey...
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Date:   Mon, 24 Jun 2019 12:54:17 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn (and others interested) !

So I've gone back on my (still incomplete) series for factoring the
resource management, and decided to try a different approach.

You can see both variants here:

 1) 
https://git.kernel.org/pub/scm/linux/kernel/git/benh/pci.git/log/?h=previous

The previous variant where I pass a policy argument to
pci_host_resource_survey()

 2) https://git.kernel.org/pub/scm/linux/kernel/git/benh/pci.git/log/

The "new" variant where the policy is set in the host bridge instead

Both variants use the PCI flags (PROBE_ONLY etc...) to establish a
default policy.

I tend to prefer variant 2 because in variant 1, I didn't manage to
clarify the interaction between the resource policy and the new
"preserve_config" flag we added for _DSM #5.

It does mean I now have 4 instead of 3 policies to match the various
behaviours but I think it's overall cleaner.

Another advantage of variant 2 is that the policy is now established
earlier (before we scan), which means we'll be able to take it into
account during the scan.

This will be useful if/when we try again to revive Lorenzo old patch to
call pci_read_bridge_bases during probing instead of doing it from the
archs pcibios_bus_fixup(). That consolidation will be needed to bring
x86 and powerpc into the fold.

We'll need to know the policy so we can avoid reading the bridge bases
when doing a full reallocation, thus avoiding tripping on the "don't
shrink" test that Yinghai added to the bus window sizing code, which
breaks platforms that try to reassign everything (Note: we should
understand why that was added btw, I can't make sense of it).

Anyway, have a quick look, it's not well tested yet, may not even build
on most archs, I'd just like to know which of the two approaches is
preferred before I invest much more time one way or another.

Cheers,
Ben.


