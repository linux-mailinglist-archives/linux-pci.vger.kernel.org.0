Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6535AE93
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhDJOxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 10:53:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36528 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234708AbhDJOxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 10:53:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 72AF5C011A;
        Sat, 10 Apr 2021 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618066389; bh=pqdx1jkVokdzxGr5Np5HYutupMFR27aY3iSW4+tRfkc=;
        h=From:To:Cc:Subject:Date:From;
        b=SfXUVDCPsEUnglX3iJT58phaWb+5BRCH0yAauAGq3sXk9mvl8L14PbLzh+5dxqNTn
         PWTDKcu1rUolOwU6ODl+kFonGk/RFjqyfR1uzhcA72PrpdA1s/akAfZWtJ7y1IEp1u
         KQo4zQafgNc/5qukQ3ccJhI7tWZypvd1g+DE7kWpU43raasVhPNkLR2R6nRDaRSj2F
         uEjU6nnniYfcD+9MMdcMthmtnggvIjJSK+EfL3W9WVfI50DWtZVdxoWRM0tyjp0KzT
         r0bDrid0eTWcnuKeTkGSc8jGRlwu6rRhl6130tf7SrSpm3hVJKPuRO87rps4REs5gR
         /HXBl1MW9OivQ==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 50712A022E;
        Sat, 10 Apr 2021 14:53:01 +0000 (UTC)
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
Subject: [PATCH v4 0/2] dw-xdata-pcie: Fix documentation build warns
Date:   Sat, 10 Apr 2021 16:52:57 +0200
Message-Id: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The first patch of this series fixes the documentation build warns, such as:
WARNING: Unexpected indentation.
WARNING: Block quote ends without a blank line; unexpected unindent.
WARNING: document isn't included in any toctree.

The second patch updates outdated and improve documentation information.

Changes:
 V2: Added cover-letter
     Added Reported-by, Link, and Fixes tags
 V3: Reformulated patch's text description and title
 V4: Reformulated patch's text description and title
     Rearranged the patches in a logical way, so that the first patch
     goal is to fix the build warns and the second patch goal is to
     update the documentation info.

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
  dw-xdata-pcie: Fix documentation build warns
  dw-xdata-pcie: Update outdated info and improve text format

 Documentation/misc-devices/dw-xdata-pcie.rst | 76 ++++++++++++++++++----------
 Documentation/misc-devices/index.rst         |  1 +
 2 files changed, 51 insertions(+), 26 deletions(-)

-- 
2.7.4

