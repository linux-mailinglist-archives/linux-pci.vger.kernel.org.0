Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8053533CF
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhDCLtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 07:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236412AbhDCLtD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Apr 2021 07:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44EC7610C7;
        Sat,  3 Apr 2021 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617450540;
        bh=PboTugiACcONisqD2kEw0Equyfhc8fFQT1SZ7Yfz2mw=;
        h=Date:From:To:Subject:From;
        b=L7mazIeD3kk4XW9lv2oTqS/IM8b/QbNzQx1udti/AIyIK8JrGaQE8j83kAe4INi4W
         j1Vj3vJ1VIXHyfJiMxo4BKTIZlg/Erj177ADEQO06FzU66DZfWmb/wMMQb082+qrf2
         9eq9fv2iYKCb8fd0Hw76Rdv2zj4aqXAFrgMXE7Qn33GctGvgFE5ajt+mubmjI2Rhfq
         sZGIU+AtU2la4s21lbNkRl4kcPQ0F05XLupdDETsV9B8XrqKQ5IeT7OYot/ejcBes8
         uPXI9y9GOOuBFrbmL18rgA/NC9Jdnee7duMGRZndTElf1DsB85rCMH1FHFfAyoY0p1
         nDplWitWIKSUg==
Received: by pali.im (Postfix)
        id BA39080E; Sat,  3 Apr 2021 13:48:57 +0200 (CEST)
Date:   Sat, 3 Apr 2021 13:48:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: lspci: Slot Power Limit values above EFh
Message-ID: <20210403114857.n3h2wr3e3bpdsgnl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

PCI Express Base Specification rev. 3.0 has the following definition for
the Slot Power Limit Value:

=======================================================================
When the Slot Power Limit Scale field equals 00b (1.0x) and Slot Power
Limit Value exceeds EFh, the following alternative encodings are used:
  F0h = 250 W Slot Power Limit
  F1h = 275 W Slot Power Limit
  F2h = 300 W Slot Power Limit
  F3h to FFh = Reserved for Slot Power Limit values above 300 W
=======================================================================

But the function power_limit() in ls-caps.c does not handle value above
EFh according to this definition.

Here is a simple patch which fixes it for values F0h..F2h. But I'm not
sure how (reserved) values above F2h should be handled.

diff --git a/ls-caps.c b/ls-caps.c
index db56556971cb..bc1eaa15017d 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -659,6 +659,9 @@ static int exp_downstream_port(int type)
 static float power_limit(int value, int scale)
 {
   static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
+  static const int scale0_values[3] = { 250, 275, 300 }; /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
+  if (scale == 0 && value >= 0xF0)
+    value = scale0_values[(value > 0xF2 ? 0xF2 : value) & 0xF];
   return value * scales[scale];
 }
 
