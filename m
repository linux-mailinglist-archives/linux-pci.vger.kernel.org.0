Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E3946B970
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhLGKw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLGKw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 05:52:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8CBC061574;
        Tue,  7 Dec 2021 02:49:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so28587116wrw.4;
        Tue, 07 Dec 2021 02:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXAwO6eoQFE08QT+TXCtgtOQ5swxwDw6whv/IXQdugk=;
        b=LIRKc5n0K2TRpQZJKcM5M2ITTflQ5fp2vsd0kbeU8ulx2w2r7PzIXD7R9Wd/mi/7ws
         Ukyz4W3QzPfdXujC8zaTtTmLy51aCI+qRLG36ZKzu6+ZSgHgHC28vxLaPs4BqW0xNc5z
         P2OfRNdS7phko09MaUIzBy+mt4Q8kiMkxI632QQp1+oC19CIlSUc7Rhxg4EiRccnHDWX
         u7at51XPcPTWx1oaMhnQsyweBJFHuULtpb0wAbknXJ17LYbDgVpveQXLmWVW1O8mFrOM
         XglBEmKAVyREVhTA8GYa7bAGIbU+wRN2Rf4vcG2pohYm4jjRWqtCb0Dc8kDa3yugUPMe
         hMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXAwO6eoQFE08QT+TXCtgtOQ5swxwDw6whv/IXQdugk=;
        b=qDRXXC0WsKCtCOPikj0lMy1w7BcYe2cpSFY87iUENT4Xh1jkrf1WbZGai+pTma57yX
         L10crrvyMt5dp6b1sWEFdtm9A/jKlMjKrZoY6yQsttMBJiKCznZiR5aF09xvwSyAq8Zi
         Ca1eJgH4RxQgPW48ladCGiYhSZCIgCogSM9UdIrdBKYbrhrTwJCDZ+FbdWyhN0+QWYFf
         6CLxBpD5TwyoIDq6arPoPKxe2lBpoCvSM3odNbESDJrmcVDoJZ+yVX1KlR+f1k+ewHQG
         vGMo79wpbXWZMOvkaHQSwJpiq9I1htWWRqLSaCCYBo0pr1JuBirhj14T0hnnFFXBjApw
         SpyA==
X-Gm-Message-State: AOAM532vMKAhhoDWBjEmi6wwC2vklKmADhwtM/ID9RU4biIJwxL0B1jY
        r5ocqpDXw8JFEH3nrNmoGz+yEu2wjbg=
X-Google-Smtp-Source: ABdhPJxlWoIiNY0QstMH6PV5+GhVGQ7+QOTO7lupZIsNZhLp/RB/xab4GZ7lg0b8n4sYqAB/ppKHJg==
X-Received: by 2002:adf:c146:: with SMTP id w6mr51798083wre.541.1638874167369;
        Tue, 07 Dec 2021 02:49:27 -0800 (PST)
Received: from localhost.localdomain (27.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.27])
        by smtp.gmail.com with ESMTPSA id z6sm13958561wrm.93.2021.12.07.02.49.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:49:26 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
Date:   Tue,  7 Dec 2021 11:49:19 +0100
Message-Id: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

MIPS specific code can be removed from driver and put into ralink mt7621
instead which is a more accurate place to do this. To make this possible
we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepare()'
which has been implemented for ralink mt7621 platform (there is no real
need to implement this for any other platforms since those ones haven't got
I/O coherency units). This also allow us to properly enable this driver to
completely be enabled for COMPILE_TEST. This patchset appoarch:
- Move windows list splice in 'pci_register_host_bridge()' after function
  'pcibios_root_bridge_prepare()' is called.
- Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
- Avoid custom MIPs code in pcie-mt7621 driver.
- Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile test
  module compilation to complain (already sent patch from Yanteng Si that
  I have rewrite commit message and long description a bit.
- Remove MIPS conditional code from Kconfig and mark driver as 'tristate'.

This patchset is a real fix for some errors reported by Kernel Test Robot about
implicit mips functions used in driver code and fix errors in driver when
is compiled as a module [1] (mips:allmodconfig).

Changes in v3:
 - Rebase the series on the top of the temporal fix sent for v5.16[3] for
   the module compilation problem.
 - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
    - Address TODO in comment about the hardware does not allow zeros
      after 1s for the mask and WARN_ON if that's happend.
    - Be sure mask is real valid upper 16 bits.

Changes in v2:
 - Collect Acked-by from Arnd Bergmann for PATCH 1.
 - Collect Reviewed-by from Krzysztof Wilczyński for PATCH 4.
 - Adjust some patches commit subject and message as pointed out by Bjorn in review of v1 of the series[2]. 

This patchset is the good way of properly compile driver as a module removing
all MIPS specific code into arch ralink mt7621 place. To avoid mips:allmodconfig reported
problems for v5.16 the following patch has been sent[3]. This series are rebased onto this patch to provide
a real fix for this problem.

[0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
[1]: https://lkml.org/lkml/2021/11/14/436
[2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@gmail.com
[3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.paracuellos@gmail.com/T/#u

Thanks in advance for your time.

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (5):
  PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
  MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
  PCI: mt7621: Avoid custom MIPS code in driver code
  PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
  PCI: mt7621: Allow COMPILE_TEST for all arches

 arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
 drivers/pci/controller/Kconfig       |  4 +--
 drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
 drivers/pci/probe.c                  |  4 +--
 4 files changed, 37 insertions(+), 41 deletions(-)

-- 
2.33.0

