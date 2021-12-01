Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D49465896
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353202AbhLAVy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhLAVyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:54:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9AAC061574;
        Wed,  1 Dec 2021 13:51:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j3so55361172wrp.1;
        Wed, 01 Dec 2021 13:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DX2ga5YEZ7pQITxRdnzgB23jvyNbXnpWAo2XxfRd5Kw=;
        b=mxoOLflFLSRdalRBq5p0dGpppQigio+qYm6bH+Losq6tiUZsIMm0kP9SjU4ZyeEmJU
         Huo8ApFO4FDudVBhgegU66gzREWq5EfArgFIwai0UA7nQKa0f4P+OnzNeyz3ccZq0v9K
         VbjVj6aqcE9oDqqpoPQDr8vnDTS+lFwXUeV+6KO5bilAQ2L8JjlnEtgNQo7ADELavPPi
         5tvi+68dxALZyuFtYiEDcbu8ncVpK+GKb1YKF5IV27TCZiTjFMoV4KipADiBbhjFJPWF
         FntPYQm3ljFoUMRTX0+YKy/lxvix8eModMpUthry/DvzYQRFBgOIHIyFKZVLIUv0gNky
         3fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DX2ga5YEZ7pQITxRdnzgB23jvyNbXnpWAo2XxfRd5Kw=;
        b=7yOwekpVmEN643uKYWk7VE9BgA9HoxFCsNjSUQ7UirAAcNxPYLbdcoHtI1gJKAb6gX
         S3BJPgIysZKrseG45HWQPz9Ol6KFeUCzWjyKuE40PjlY82FzER/5kCAI+gyU2lZ5gqGR
         2Pd0Utj8JRqOUrK9X2Aw3eBixx9y2Lgt/2mkrUTS+ivV1Ex4Q+1eQf0JX8MJ4ijiHNyk
         XsPDJJwUUnh0KFuMfcj+Q3GW2Sud2Vj+ifKdMNl4O2ri3ZUFhku4uW7eD7rXbxaVqJur
         pfU6WsVhy/FhrGTn9Is2CGTzL1CLcN7xWUJKF2Kkv72DJ8R7U9KJAurOC1uhpjzxGRAS
         fTPQ==
X-Gm-Message-State: AOAM533A1nX6GZb/p35LsKOT4+RP+JzzSCJji9pt6pYZdR0kB9uFrIzv
        Hvf8anwCGiTS7bsBo6KwwpD9C+Bv78U=
X-Google-Smtp-Source: ABdhPJzQqTLzBm2R/MWnDF1D8Q8zLBQiaLSj0iDpJEMAmByCh1OoG3TgFkFL8/A3GTrf/U67l3FxPA==
X-Received: by 2002:adf:d844:: with SMTP id k4mr9851656wrl.622.1638395490242;
        Wed, 01 Dec 2021 13:51:30 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id c10sm877879wrb.81.2021.12.01.13.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:51:29 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] PCI: mt7621: Remove specific MIPS code from driver
Date:   Wed,  1 Dec 2021 22:51:22 +0100
Message-Id: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
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
- Remove MIPS conditional code from Kconfig.

This patchset also fix some errors reported by Kernel Test Robot about
implicit mips functions used in driver code and fix errors in driver when
is compiled as a module [1] (mips:allmodconfig).

There was an ongoing discussion about this here [0] but I preferred to send
my proposal for better review and understanding.

Changes in v2:
 - Collect Acked-by from Arnd Bergmann for PATCH 1.
 - Collect Reviewed-by from Krzysztof Wilczyński for PATCH 4.
 - Adjust some patches commit subject and message as pointed out by Bjorn in review of v1 of the series[2]. 

This patchset is the good way of properly compile driver as a module removing
all MIPS specific code into arch ralink mt7621 place. To avoid mips:allmodconfig reported
problems for v5.16 the following patch has been sent [3]. This patch should be reverted
for properly add this series.

[0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
[1]: https://lkml.org/lkml/2021/11/14/436
[2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@gmail.com
[3]: https://lore.kernel.org/linux-pci/20211201214343.23307-1-sergio.paracuellos@gmail.com/T/#u

Thanks in advance for your time.

Best regards,
   Sergio Paracuellos

Sergio Paracuellos (5):
  PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
  MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
  PCI: mt7621: Avoid custom MIPS code in driver code
  PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
  PCI: mt7621: Kconfig: Allow COMPILE_TEST for all arches

 arch/mips/ralink/mt7621.c            | 30 +++++++++++++++++++++
 drivers/pci/controller/Kconfig       |  2 +-
 drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
 drivers/pci/probe.c                  |  4 +--
 4 files changed, 35 insertions(+), 40 deletions(-)

-- 
2.33.0

