Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAEF357614
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 22:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhDGUcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 16:32:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35178 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233914AbhDGUcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 16:32:18 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A2F87C0967;
        Wed,  7 Apr 2021 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617827528; bh=n+tLB1zj++nPXAm8QTTakfirI9ncxx2G2P1UH7Z9mNg=;
        h=From:To:Cc:Subject:Date:From;
        b=d/sKPU6VJHMkEG9Nelns5PHFtK5RFnQekLrnwkRu9urOYzs5o5CBZYrpMKMCcySnQ
         AGBe4KEJ5A9W975GStM2JpNYEi6UAFaDVGCRgp9//LLtqkpz+am4onLw5Sxq3VI73k
         LAndwF3MPnHt+So/dXnjBofOlGEXol3Kzg71NTQX3jy2S9FAJLoWuW78BjM9tToeZh
         4DdOrzAiCK6njR3pSOZOa+/w4Qdoy2dGkXUq9pRONaj0HQ27fsjm8r6C6qfwRF9Vn/
         dotJTORWC0b3sRWe7hzSobTI1ExD77dOspzrHodEkUfkeCHbPZrvvlcVtiR3a1wjb/
         R6SeJqDm1pMIA==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 65CDAA022E;
        Wed,  7 Apr 2021 20:32:01 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 0/2] dw-xdata-pcie: Fix documentation build warns
Date:   Wed,  7 Apr 2021 22:31:47 +0200
Message-Id: <cover.1617827290.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes the documentation build warnings, such as:
Documentation/misc-devices/dw-xdata-pcie.rst:20: WARNING: Unexpected
indentation.
Documentation/misc-devices/dw-xdata-pcie.rst:24: WARNING: Unexpected
indentation.
Documentation/misc-devices/dw-xdata-pcie.rst:25: WARNING: Block quote
ends without a blank line; unexpected unindent.
Documentation/misc-devices/dw-xdata-pcie.rst:30: WARNING: Unexpected
indentation.
Documentation/misc-devices/dw-xdata-pcie.rst:34: WARNING: Unexpected
indentation.
Documentation/misc-devices/dw-xdata-pcie.rst:35: WARNING: Block quote
ends without a blank line; unexpected unindent.
Documentation/misc-devices/dw-xdata-pcie.rst:40: WARNING: Unexpected
indentation.
Documentation/misc-devices/dw-xdata-pcie.rst: WARNING: document isn't
included in any toctree

Also fixes some outdated information related to stop file interface
in sysfs.

Changes:
 V2: Added cover-letter
     Added Reported-by, Link, and Fixes tags
 V3: Reformulated patch's text description and title

Cc: linux-doc@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Gustavo Pimentel (2):
  dw-xdata-pcie: Fix documentation build warns and update outdated info
  misc-device: Add dw-xdata-pcie to toctree(index)

 Documentation/misc-devices/dw-xdata-pcie.rst | 62 +++++++++++++++++++---------
 Documentation/misc-devices/index.rst         |  1 +
 2 files changed, 44 insertions(+), 19 deletions(-)

-- 
2.7.4

