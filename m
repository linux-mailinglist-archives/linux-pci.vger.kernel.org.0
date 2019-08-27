Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A799E4C3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfH0Jtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 05:49:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33990 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfH0Jtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 05:49:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so1999955wme.1;
        Tue, 27 Aug 2019 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSocX2YkAd3hERDytZMXxQV7vxeYgbpxXlORSGyl3Lk=;
        b=Pb4G0Ex4dRDrrYJEg/DhfqLtnGMA9FM7KA531lU4D7V26XQVGl54eL0Ye1Fi8N1PUA
         UpF2oZSZqC38KcdTiCGA/TKYpXx1wtSMYlkQpLSvDNKRMhSybqLg1WG0w5lP61Bh9gK9
         Kl35gf47Q/2Nr82BOMtFvmO/l6I66Ac0q8KSZD+4xZeKUuNmiP+VRvB+4uMXi9jyFjje
         uvMhJkAH1yS1U7fIKJFflexFeWSdbfy15N/0PH1cq6EwZ2XI4MU7HdSpgwuFySZd0S+a
         ASFgDthEln4RnnSGsimysA5o5w+tMd99Ub9coMEBYVbCV2JxNPM/pkMzs0JnJT+kYhIg
         wX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XSocX2YkAd3hERDytZMXxQV7vxeYgbpxXlORSGyl3Lk=;
        b=sukgmoxVBI0xQLVv6lx6i4L0NGJKXu0NStZAoHfXEo87PRmcYTpvCseowaUEBvqgXq
         0EYFWAIBxpETB3MUB2RgCrEOLbah/uOxBMgJOnzEurVMMtm/IfsRUsnQNh3MVFLmEw8j
         ENqeTI+KOBO4l7rugR2J5gIC8zxGba212LlnwCKuqTwQZwZ75em3fikY3hlnIJjM1wOU
         JDb+ibt2/5OBWElSkyshrVMZ5Xd6c3xncRaAb5SZBFVRR66R28omr4AnsOINJZnOnon2
         2hYtlrussjNJT0Df1KIDkdmIi8WxGU2JAp/zGPguFDk88w2s0gm9BoMbeYhCxa1DYM4a
         hTmQ==
X-Gm-Message-State: APjAAAUmu6dpEBUA1Cxg2MP7YXOHlHYVN6xgMYHQcdaaGHi/5GlMEGQX
        s7XLbqJyIyeQnkDz8ib4q2jNGitfazTN3Q==
X-Google-Smtp-Source: APXvYqwDJPdifkxz2KNrIC9cDrjhz0X2Vigjh0xpdyM8QZ6pCw159Fq5dNQl02ufWjZLZSrz9GZNQA==
X-Received: by 2002:a1c:f101:: with SMTP id p1mr26719185wmh.62.1566899393269;
        Tue, 27 Aug 2019 02:49:53 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id p10sm2450087wma.8.2019.08.27.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:49:52 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI/ACPI: Rename _HPP to _HPX and move of ACPI-specific code from probe.c
Date:   Tue, 27 Aug 2019 11:49:48 +0200
Message-Id: <20190827094951.10613-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches moves the ACPI-specific code currently included
as part of the drivers/pci/probe.c. First, the ACPI Hot Plug structs
for Type 0, 1 and 2, and any relevant variable names, structs, function
names, etc., will have their names changed to reflect that these are
related to _HPX rather than _HPP.  Second, all of the ACPI-specific
code will be moved to drivers/pci/pci-acpi.c for better organisation
and to keep ACPI-related code base together.  Third, remove the
now obsolete struct hotplug_program_ops from drivers/pci/pci-acpi.c.

Patches should be preferably merged in order as they build upon
one-another.

Related:
  https://lore.kernel.org/lkml/20190419220220.GI173520@google.com
  https://lore.kernel.org/lkml/20190307213834.5914-3-mr.nuke.me@gmail.com
  https://lore.kernel.org/lkml/20190307213834.5914-2-mr.nuke.me@gmail.com

Krzysztof Wilczynski (3):
  PCI/ACPI: Rename ACPI Hot Plug structs for Type 0, 1 and 2 from _HPP
    to _HPX
  PCI/ACPI: Move ACPI-specific Hot Plug programming functions to
    pci-acpi.c
  PCI/ACPI: Remove unnecessary struct hotplug_program_ops from
    pci-acpi.c

 drivers/pci/pci-acpi.c      | 410 +++++++++++++++++++++++++++++++++---
 drivers/pci/pci.h           |   9 +
 drivers/pci/probe.c         | 278 +-----------------------
 include/linux/pci_hotplug.h | 100 ---------
 4 files changed, 389 insertions(+), 408 deletions(-)

-- 
2.22.1

