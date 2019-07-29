Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68178964
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfG2KOU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:14:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41174 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:14:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so58007369ljg.8;
        Mon, 29 Jul 2019 03:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Um6ED6I3PME6LFQVQV/8kHAjm+sTMuYfm30McVPwl0=;
        b=muEQwF5sfkPqLXxoJKCwfZTHi6dX/YAQOB9rM1EhQnDv904DPXibUeYBKUFluCo+86
         uGUM1WvkQATgbWednnf5cT7LytrhUHqT5vlZwpRO6vFmUQPTdQZFzFKta1AwpLPhiXm4
         kZlYEoSv+B+lsrpnpCMVL0paFVGlqhoEFUHRGAY8UKGP8a1YKCjlSxEluMb5JriYjJTz
         n9tU1kpIqZJAgGkWn3iXidaYJFEwDEZluXhD5qjaeQO2MRyj/K3nYjhkN/lfdzqTYr1M
         cnMUwEkvpWIbiWzAQtymALRNlXgEZoJqsZxJAexBPwx2miyoLOGnk+gUn9h2FuOp9yc9
         Y6Ig==
X-Gm-Message-State: APjAAAVAyLNKYyU6cWKIf9AnksV2B56V4kiGfLdVV9TNUrlAupcfYF9n
        B/JQdnACvguiNUqELnyLWI4=
X-Google-Smtp-Source: APXvYqzW1ctvjiacKpwN/B8Wf3TwQY8a0G1QokUxEp47Rts8HLz1rJBfR1Qfky77XQ61Z4d7nS9tnA==
X-Received: by 2002:a2e:970d:: with SMTP id r13mr57395760lji.126.1564395257826;
        Mon, 29 Jul 2019 03:14:17 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:17 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] PCI: Convert pci_resource_to_user() to a weak function
Date:   Mon, 29 Jul 2019 13:13:56 +0300
Message-Id: <20190729101401.28068-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Architectures currently define HAVE_ARCH_PCI_RESOURCE_TO_USER if they want
to provide their own pci_resource_to_user() implementation. This could be
simplified if we make the generic version a weak function. Thus,
architecture specific versions will automatically override the generic one.

Changes in v2:
1. Removed __weak from pci_resource_to_user() declaration
2. Fixed typo s/spark/sparc/g

Denis Efremov (5):
  PCI: Convert pci_resource_to_user to a weak function
  microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  sparc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER

 arch/microblaze/include/asm/pci.h |  2 --
 arch/mips/include/asm/pci.h       |  1 -
 arch/powerpc/include/asm/pci.h    |  2 --
 arch/sparc/include/asm/pci.h      |  2 --
 drivers/pci/pci.c                 |  8 ++++++++
 include/linux/pci.h               | 12 ------------
 6 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.21.0

