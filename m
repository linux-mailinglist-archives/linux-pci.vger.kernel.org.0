Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931762E8025
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 13:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLaM5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 07:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgLaM5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 07:57:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F431C061573
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:56:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x20so43850928lfe.12
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vZjoGWZedYLbvhemgBlBVpOyf8AcC6M80ix2EkJy5k=;
        b=mvJtCqEHARbrds8vfmwVE8IV0FDzVFVjDsJ+Ly+kOJpx013Bd5Ept7/RxTUd5PmPZv
         ff3FMwlzYQ/x574k7mtyMw0lk0VrQ6oYrdIplqE+NKRjxRIWQ6ut2G4ZI5ZEgwMzrFFW
         GsUn5mjCy/72bJIfWOSzJvZRLc3XyS9T/PeJrMz5POhExysHrq8AJ42ENWxl+W3ReP9T
         FaIRVF/sFqOPzPLubvRh7fA3ii1hDTiXHqpDfpLQxYgZf1NtXpRHGQIoB68vAOEOzTnA
         UNsSwvul8lT1GjgKdKGCLM0Yg+9kg1u80qT4TWVW0uNTMlZXLz1AyJTBsQhMeW0L8y1B
         SKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vZjoGWZedYLbvhemgBlBVpOyf8AcC6M80ix2EkJy5k=;
        b=tbKHlh0A8loYPA6Y+5oCurKdM4spiEm9VFG3yUu4YY5GgWxbaqNnbvfPGDOUzZ43bD
         QhoGUdRaqhxTA5iLGTFGdoxywqIl5Kg/k9rzkGlcW8of7U+nvZRkDGCLoFZ3E7IT/+29
         0gFd/IvR8GRyq9MX7VNtDJdNdge28UkRSYDnLlGrGXK0SpsY4b+tifwqoD4BwNOrTnnC
         YqdRDGUD375DQyqkIgVsM7XdLqYjLirs1PuY8F2jNNtUzbL/OhneY4/plfkP2N+DPNM8
         zlRkGqxxgMLnjhbG5Hoz92CaQZbviRN6djeIXq2Em4dVrc/QMCTP1njaLkmxFcA98JpB
         +eBg==
X-Gm-Message-State: AOAM530Nt8enWJop2SUdFC7+PsdtAhHf7IoO6H/7NcPEG/KVAC2r+5YY
        mBNC23LimgShjUie6/Tqd94=
X-Google-Smtp-Source: ABdhPJzxjGQ5hs2wOpjZ5zeSZkxEF4aK/S7JHO+0Ik9A9Vcne4fX8OAy1TRuY4k78iiNOoOQ6ZJOXA==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr27252228ljp.254.1609419400987;
        Thu, 31 Dec 2020 04:56:40 -0800 (PST)
Received: from localhost.localdomain (85-76-98-107-nat.elisa-mobile.fi. [85.76.98.107])
        by smtp.gmail.com with ESMTPSA id r201sm6230659lff.268.2020.12.31.04.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:56:40 -0800 (PST)
From:   =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 0/3] provide workaround for Rockchip PCIe bus scan crash with optional delay
Date:   Thu, 31 Dec 2020 14:52:11 +0200
Message-Id: <20201231125214.25733-1-nuumiofi@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello all,

This RFC patch provides a workaround for Rockchip PCIe controller crashes
with some devices when PCIe bus is scanned. Both command line parameter and
device tree property are included as ways to set the delay. I'm sending
this as RFC because I don't know which approach, command line and/or device
tree, would be the best considering this is a workaround, not a proper fix.

I feel that at least command line parameter should be provided as it's easy
to edit by end user. Device tree property could be seen as a way for disto
maintainer to provide sane or safe default with kernel but it also extends
the change to touch more files which makes it harder to clean up if a
proper fix to this is found.

Also, I've set delay to 1100 ms for RockPro64 in patch 3 as an example of
safe default. If new device tree property support is accepted maybe the
actual device tree should be left unmodified or delay set to 0 ms so that
users not needing the delay are not affected in any way.

Patch 1 adds the workaround code. Kernel parameter documentation is also
included. Devices used in testing and a log excerpt are included in
changelog.

In addition to devices needing the delay, tested and listed in patch 1
following devices that do not need the delay were tested with no delay and
1000 ms delay and no regression was observed:
- Marvell 88SE9215 and 88SE9230 based SATA controllers
- Samsung 970 EVO Plus NVMe drive

Patches 2 and 3 add dt-bindings and the new property to RockPro64 device as
an example.

All comments about the workaround itself if it's applicable and about both
command line + device tree or only command line approaches are welcome.

Best regards,
Jari Hämäläinen

Jari Hämäläinen (3):
  PCI: rockchip: provide workaround for bus scan crash with optional
    delay
  dt-bindings: PCI: rockchip: document bus-scan-delay-ms workaround
    property
  arm64: dts: rockchip: use bus-scan-delay-ms workaround with RockPro64
    PCIe

 .../admin-guide/kernel-parameters.txt          |  8 ++++++++
 .../bindings/pci/rockchip-pcie-host.txt        |  3 +++
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi    |  1 +
 drivers/pci/controller/pcie-rockchip-host.c    | 18 ++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.c         |  5 +++++
 drivers/pci/controller/pcie-rockchip.h         |  2 ++
 6 files changed, 37 insertions(+)


base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.29.2

