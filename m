Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6C3E33ED
	for <lists+linux-pci@lfdr.de>; Sat,  7 Aug 2021 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhHGHYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Aug 2021 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhHGHYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Aug 2021 03:24:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD6C0613D3;
        Sat,  7 Aug 2021 00:24:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c16so13966164wrp.13;
        Sat, 07 Aug 2021 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOfa29VAz1NlQekE8P7/3E01ehCcTCDdZpc8rzXu9+8=;
        b=TGhhO0/U6iy8CTCCnuKpidFV3bVAKGjyFHC08l2wtYLPab/r+yk5oD6fGhXCHbLxd2
         K2mn2qSorYg4FB7W+sJa00dDlVJOmNvoXX2o9BtaigdrFSWBPnInrQEPNkC9CWXmxyf5
         eXNYN2U3yR/rtSJwa4swc8BmqYcThmrXA0xaw60tFy3Gm4dqy4Y7nZe7mqLwTowW/ieB
         DDSQwdVNPQvRSMZPIwKUd+Fh4uz+GnBK279vVNfniD6CpE7jBghKmazPZyUtH2nBckTr
         nHoRNxAXvDt6Co/QwN8BChk/ahEMkys+pzqjE0KNphbfblh/lqUDOUocZ3MSd+10wcqr
         VsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOfa29VAz1NlQekE8P7/3E01ehCcTCDdZpc8rzXu9+8=;
        b=bJ/9TaA5+Pule6+C0jIGdp9vYufaBqbPAbudFciD3m1dEbwdXJ+EFBrQ+r7lI4yQhG
         UFwHUmOESaDQit85sRYgDdu68Z8+u9Knwpwks/rYY0cZT8ynr/3vrFMEG2R5es9Ot86c
         VqKmT7P6rT90uA+3QB5/7FA3x2Kf4W76kTwvdFHyj/KOG2iSVNd8CBi9jQOzc8fIqVz/
         PBfxkDz/+me/nAvmJaOEzD8JyKEnSALBwldsmnz0rA/XrqKEzPGYoHWhhur+9ut5yG2k
         9PzWj8wNzsYf30HFsrQ7hqlh1NtcR4pBn60KhjoQi6tYkIS7UJC6JSf/1Sg8C2eWNgev
         MY7g==
X-Gm-Message-State: AOAM5308s4uUa/lP+6h5vf9aP5wVxCdfyw5pLyz8XDCc2xCc3JOJb5AB
        xcBObRNiT45WYx9etbbvhPE=
X-Google-Smtp-Source: ABdhPJysQAP0lK1qriodegnx5Hj0BurpjgKvd5yHBxHmXA0OugHLV7iTq7mxtI17CdFLqvJKir5NSw==
X-Received: by 2002:adf:f383:: with SMTP id m3mr14107000wro.81.1628321052848;
        Sat, 07 Aug 2021 00:24:12 -0700 (PDT)
Received: from localhost.localdomain (10.red-83-57-27.dynamicip.rima-tde.net. [83.57.27.10])
        by smtp.gmail.com with ESMTPSA id g5sm13915017wmh.31.2021.08.07.00.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:24:12 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT
Date:   Sat,  7 Aug 2021 09:24:07 +0200
Message-Id: <20210807072409.9018-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
References: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defining PCI_IOBASE results in pci resource handling working but the
addresses generated for IO accesses are wrong since the ioremap in the pci
core function 'pci_parse_request_of_pci_ranges' tries to remap to a fixed
virtual address (PC_IOBASE) which can't work for KSEG1 addresses. To get
it working this way, we would need to put PCI_IOBASE somewhere into KSEG2
which will result in creating TLB entries for IO addresses, which most of
the time isn't needed on MIPS because of access via KSEG1. So avoid to
define PCI_IOBASE and increase IO_SPACE_LIMIT resource for ralink MIPS
platform instead, to get valid IO addresses for resources from pci core
'pci_address_to_pio' function.

Fixes: 222b27713d7f ("MIPS: ralink: Define PCI_IOBASE)
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/spaces.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index 87d085c9ad61..31a3525213cf 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -2,9 +2,7 @@
 #ifndef __ASM_MACH_RALINK_SPACES_H_
 #define __ASM_MACH_RALINK_SPACES_H_
 
-#define PCI_IOBASE	_AC(0xa0000000, UL)
-#define PCI_IOSIZE	SZ_16M
-#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
+#define IO_SPACE_LIMIT	0x1fffffff
 
 #include <asm/mach-generic/spaces.h>
 #endif
-- 
2.25.1

