Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2B355DC1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbhDFVS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 17:18:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34792 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343556AbhDFVS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 17:18:26 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 854C3C008D;
        Tue,  6 Apr 2021 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617743898; bh=vGBK5U+o+ZHgapDyTLygfAiRN0XZJ6pSVSoGE1cYj2o=;
        h=From:To:Cc:Subject:Date:From;
        b=T/+jMF0T+CkZvPnxwAeZ6tbTqEmuAS4ET84NdwDmr2m1D/d2B39wIWohHd7JEokPt
         1wsSTskB4naPs6toUK5J+H26GQOarOMVWb3coTyeub6m6h+cKd0z1Pg50LDWgKsBQm
         3ZbBnCCLzmla3Xp8s68d3Kxcz3kgnE+GGKs9+dhcHC8xqVn28RM8YZQE5aUF+DXAfo
         5Tf2no3eoknLYXmjyegkwrhHP+r6ziim15sle4FbjOYS1LFgsmvIzfPGj+jPqsseP0
         qwROxaQmPEo6xUyPa1emS5JlhV+xgynk8U92J9q6g8dXgJRUVUSBMBFdP7V7ITALdl
         KGdGWwMsPxFmA==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id BC738A022E;
        Tue,  6 Apr 2021 21:18:12 +0000 (UTC)
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
Subject: [PATCH v2 0/2] Documentation: misc-devices: Fix documentation issues (indentation, text format, toc) and outdated information
Date:   Tue,  6 Apr 2021 23:17:47 +0200
Message-Id: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes the documentation issues reported by doing
*make htmldocs*, such as:
 - indentation
 - text formatting
 - missing entry on the table of content related to dw-xdata-pcie misc
 driver index

Besides these warnings also fixes some outdated information related to
stop file interface in sysfs.

Changes:
 V2: Added cover-letter
     Added Reported-by, Link, and Fixes tags

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
  Documentation: misc-devices: Fix indentation, formatting, and update
    outdated info
  Documentation: misc-devices: Add missing entry on the table of content
    related to dw-xdata-pcie

 Documentation/misc-devices/dw-xdata-pcie.rst | 62 +++++++++++++++++++---------
 Documentation/misc-devices/index.rst         |  1 +
 2 files changed, 44 insertions(+), 19 deletions(-)

-- 
2.7.4

