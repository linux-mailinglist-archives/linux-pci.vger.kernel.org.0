Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328F42ED400
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbhAGQLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 11:11:03 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31259 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbhAGQK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 11:10:58 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210107161015epoutp03f081e9ed734c4f629576e56f6845bba8~X-wtE1ptM1297212972epoutp03F
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 16:10:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210107161015epoutp03f081e9ed734c4f629576e56f6845bba8~X-wtE1ptM1297212972epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610035815;
        bh=uuUvWOFqJZQ4hJc1/kGBf9qGITSHyVmlvTN7W+i4GGQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HDmdlUbiAxkyhsVVVOzJkpfav/vFluy2dLEZwbMJFU1cCqRIC5m5DBEGqIOD6EC55
         Xik7xls4Bs0TOt58n02crUVNZsJ98BbSrFEDa80WYHoZCgCWmDs+Gvu0+M37msuzo3
         kJMgATkI65tUoAAmqZyqplkZdPY0bBmrbkRwNZGU=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210107161014epcas5p3a2ef0cd705917e2d00a00c68e47cb19f~X-wsH93jX1863018630epcas5p3w;
        Thu,  7 Jan 2021 16:10:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.0C.50652.66237FF5; Fri,  8 Jan 2021 01:10:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210107152945epcas5p158e88c757a44e98f4e9a898d3ff5f87c~X-NVo2Ho21966319663epcas5p1k;
        Thu,  7 Jan 2021 15:29:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210107152945epsmtrp24d37acc3040721520f4db4480a46e8d9~X-NVn20W_0276302763epsmtrp2-;
        Thu,  7 Jan 2021 15:29:45 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-f8-5ff732660aad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.1A.08745.9E827FF5; Fri,  8 Jan 2021 00:29:45 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210107152943epsmtip204376ee473fbe0e1a3bab56a121d1785~X-NUMRDCG2046620466epsmtip2L;
        Thu,  7 Jan 2021 15:29:43 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v7 0/5] Add support to handle ZRX-DC Compliant PHYs
Date:   Thu,  7 Jan 2021 20:58:38 +0530
Message-Id: <1610033323-10560-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmhm6a0fd4g5u/FC0+TlvJZHHn+Q1G
        i8u75rBZnJ13nM2i88ssNosnUx6xWhzdGGyxaOsXdovew7UWN9azO3B59G1ZxejxeZNcAFMU
        l01Kak5mWWqRvl0CV8aknbEFn4QqzvYcZ2pg/M/XxcjJISFgItHbPIENxBYS2M0osXKZWBcj
        F5D9iVFi9q3DLBCJz4wSe2+WdjFygDW8O8sOEd7FKLGvhwmivoVJYsGSv2AJNgEticavXcwg
        tohAlMTM7a2sIDYzyIJV79NAbGEBZ4l1WyaCLWYRUJV4N+sWE4jNK+Aq0fR4BSPEcXISN891
        MoMskBBYxy7x5tU3FoiEi8SH29ugioQlXh3fwg5hS0l8freXDcLOl5h64SkLxNEVEst76iDC
        9hIHrswBCzMLaEqs36UPEZaVmHpqHRPEmXwSvb+fMEHEeSV2zIOxlSW+/N0DdYGkxLxjl1kh
        bA+Jaa0TWCFhEiuxY/5i5gmMsrMQNixgZFzFKJlaUJybnlpsWmCUl1quV5yYW1yal66XnJ+7
        iREc6VpeOxgfPvigd4iRiYPxEKMEB7OSCK/FsS/xQrwpiZVVqUX58UWlOanFhxilOViUxHl3
        GDyIFxJITyxJzU5NLUgtgskycXBKNTCtbdz/yf+5zOnppvYX15j/3ca622/+Pa33/7t9NV+v
        mOBT/kQj6MJGbsGr0aIpdRynHzv6bxWRz1CRPt7EcPTMg6upXZ22p7ceZ6ye7MgQ0XCw5kLt
        j6s7rpw4+rkyTnEC07aVFm0pu17nz4l+EOL5x61FzO6Cw8UXcQ95VqV9/3gk/9z5uekfds77
        P/mWvP6vo97nv6jOlZFqfdXvsb646lOU99x9jn8cahd+5ZuWUKhbW6JRc2r1yY1JTnobRc37
        g0Xt+Q+3d0ZFL4ppSKvc8jR/S9Or+2zTZz1Rzcjxfa7C06FVdaJ1W4jxJaE7HcsW2d31vzSh
        fWa8DOcvM1XtMzu23ph+MEj/GG/I4dilSizFGYmGWsxFxYkANE/LYGMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSvO5Lje/xBjtn81l8nLaSyeLO8xuM
        Fpd3zWGzODvvOJtF55dZbBZPpjxitTi6Mdhi0dYv7Ba9h2stbqxnd+Dy6NuyitHj8ya5AKYo
        LpuU1JzMstQifbsEroxJO2MLPglVnO05ztTA+J+vi5GDQ0LAROLdWfYuRi4OIYEdjBLbjzYw
        dzFyAsUlJT5fXMcEYQtLrPz3HKqoiUni4ME3rCAJNgEticavXWANIgIxEuv/3WQFKWIWOMwo
        seL8QrBuYQFniXVbJrKB2CwCqhLvZt0Ci/MKuEo0PV7BCLFBTuLmuU7mCYw8CxgZVjFKphYU
        56bnFhsWGOWllusVJ+YWl+al6yXn525iBIePltYOxj2rPugdYmTiYDzEKMHBrCTCa3HsS7wQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTMKpqVLHnNtm
        fPI+fbRKqEvUfo7wjpvVi3neOP5beezZ34RLpflH1Zty2/dcFGnlWOXQ/d1oy5/C/nscZR99
        xd0XCUm5bfdY71TzrLjppqhca9edp9p++5LKVumy/lwza/9vlQnpQRrqmqLz7t66lrv4wrE8
        I+55C7bpZDxZUTyJb5nS0hhhRqZVZcwL65jmtLWL9BssWnbt+ZV73KKTZ8zY1Ms5a3V/abT2
        vrZ/Re/miS2dE3qt4Vz7ngOWImtUDh9ZfXyXxMreO/WVk8pCcjt97B+UFk7bx5/xRUZy1uFI
        mzWvio27jj5mqWC9Vrj7yherAK/GNWri2YcXX1vDZHU09mXvo0wl8Tt1EqePsCmxFGckGmox
        FxUnAgA5VS2yjgIAAA==
X-CMS-MailID: 20210107152945epcas5p158e88c757a44e98f4e9a898d3ff5f87c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107152945epcas5p158e88c757a44e98f4e9a898d3ff5f87c
References: <CGME20210107152945epcas5p158e88c757a44e98f4e9a898d3ff5f87c@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According the PCI Express base specification when PHY does not meet ZRX-DC
specification, after every 100ms timeout the link should transition to
recovery state when the link is in low power states. 

Ports that meet the ZRX-DC specification for 2.5 GT/s while in the L1.Idle
state and are therefore not required to implement the 100 ms timeout and
transition to Recovery should avoid implementing it, since it will reduce
the power savings expected from the L1 state.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

We need to get the PHY property in controller driver. So, we are proposing
a new method phy_property_present() in the phy driver.

PCIe controller platform drivers should populate the phy_zrxdc_compliant
flag, which will be used by generic DesignWare driver.

pci->phy_zrxdc_compliant = phy_property_present(xxxx_ctrl->phy, "phy-zrxdc-compliant");

Patchset v2 can be found at:
- 1/2: https://lkml.org/lkml/2019/11/11/672
- 2/2: https://lkml.org/lkml/2019/10/28/285

Changes w.r.t v2:
- Addressed review comments
- Rebased on latest linus/master

Changes w.r.t v3:
- Added linux-pci@xxxxxxxxxxxxxxx as pointed by Gustavo, Sorry for annoying.

Changes w.r.t v4:
- Addressed review comments from Andrew Murray
- Rebased on latest linus/master

Changes w.r.t v5:
- Added check for NULL pointer

Changes w.r.t v6:
- Rebased on latest linus/master
- Used this feature in nvidia tegra files

Pankaj Dubey (3):
  phy: core: add phy_property_present method
  PCI: dwc: add support to handle ZRX-DC Compliant PHYs
  PCI: tegra: Remove platform driver support for ZRX-DC compliant PHY

Shradha Todi (2):
  dt-bindings: PHY: P2U: Add binding for ZRX-DC PHY property
  arm64: tegra: Add support for ZRX DC PHY property

 .../devicetree/bindings/phy/phy-tegra194-p2u.txt     |  4 ++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi             | 20 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c         |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h         |  4 ++++
 drivers/pci/controller/dwc/pcie-tegra194.c           | 17 ++++++++---------
 drivers/phy/phy-core.c                               | 20 ++++++++++++++++++++
 include/linux/phy/phy.h                              |  6 ++++++
 7 files changed, 68 insertions(+), 9 deletions(-)

-- 
2.7.4

