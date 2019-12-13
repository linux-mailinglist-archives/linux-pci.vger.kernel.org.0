Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19F11E462
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfLMNNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 08:13:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38504 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfLMNNf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 08:13:35 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191213131330epoutp044f4bf220419515fc87317e8e7fbc0ce6~f8HwdrczC1233412334epoutp04j
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 13:13:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191213131330epoutp044f4bf220419515fc87317e8e7fbc0ce6~f8HwdrczC1233412334epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576242810;
        bh=96KPzqH2k/XmIwhACmbQJCz/M1oFW9+Tap5Aw04fJ84=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TXsZUe9E77tl14nV6kp41apWKGWUdU7y+ssSA0RfFJbINchWG/N+TV/fzTQ0AB7pt
         QdtLWd2d0tGyQNBJYNULe3rzoiwWb6yzUH4CTQfBu3BnWWQgCgexzhMiaT+9WwAyFR
         4kE02DWe8SDZ7QmvYYkly6rhUefRm3YxvoEvdWfE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191213131329epcas5p231ece6e7556e3bdfb52cb8cd994ccfd5~f8HvJ2d1n0792807928epcas5p2p;
        Fri, 13 Dec 2019 13:13:29 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.BB.20197.87E83FD5; Fri, 13 Dec 2019 22:13:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213131328epcas5p1c6bafae662369c8f8968f5265163d7ad~f8Hull8Xf2315123151epcas5p1l;
        Fri, 13 Dec 2019 13:13:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213131328epsmtrp1a092948ad0c864f5d7450406b9ce2b10~f8HukHDWq0753107531epsmtrp1L;
        Fri, 13 Dec 2019 13:13:28 +0000 (GMT)
X-AuditID: b6c32a4a-769ff70000014ee5-89-5df38e785690
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.5D.10238.87E83FD5; Fri, 13 Dec 2019 22:13:28 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213131326epsmtip2e2a2d51a39eb729b631e6401314dc7e1~f8Hs4nT6H1546215462epsmtip2A;
        Fri, 13 Dec 2019 13:13:26 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v6 0/2] Add support to handle ZRX-DC Compliant PHYs
Date:   Fri, 13 Dec 2019 18:43:18 +0530
Message-Id: <1576242800-23969-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7bCmpm5l3+dYg3UTGC2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DKmLu4l71gN1/F4o1LWRsYz3N3MXJySAiYSDStPMbexcjFISSwm1Hi3pFjTBDOJ0aJjU/m
        Q2W+MUr8nbSdrYuRA6zlwBQ7iPheRokdrT2MEE4Lk8SfxncsIHPZBLQlfh7dyw5iiwhYSxxu
        38IGYjML/GOUeDynAsQWFnCWeNE0jRHEZhFQlZjXt4oZxOYVcJGYvXcDC8R9chI3z3UygyyQ
        EDjAJnFpei8LxBUuEo8eyEPUCEu8Or6FHcKWknjZ3wZl50v03l0KZddITLnbwQhh20scuDIH
        bAyzgKbE+l36EKfxSfT+fsIEMZ1XoqNNCMJUkmibWQ3RKCGxeP5NZgjbQ+LBswtMILaQQKxE
        57Y1zBMYZWYhzFzAyLiKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0L10vOT93EyM4TWh57WBcds7n
        EKMAB6MSDy9DyqdYIdbEsuLK3EOMEhzMSiK8qdqfY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        TmK9GiMkkJ5YkpqdmlqQWgSTZeLglGpgbJiqnSiQETPRnOeO4KkJ8fmBRjeZHgbvl3miGXNS
        Pyh3V/+DLd763EyuwSkXRa0LNV/edLRjURDlWt3tXhsleHjr3ooTWgfzDs+/ZC4TNuvf8lmf
        X0YZLfd9+Xur01fGDSdZlRX+Rd0OTj4TUzdjyr5Hm6/au6s8XqtzN0HiReLCCXffs+6JV2Ip
        zkg01GIuKk4EAPLI9qEPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvG5F3+dYg3cNghbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZn5x1ns3jz+wW7xdLrF5ksFm39wm7RuvcIuwOP
        x5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXps2f+Z0eP4je1MHp83yQVwRHHZpKTmZJalFunb
        JXBlzF3cy16wm69i8calrA2M57m7GDk4JARMJA5Mseti5OIQEtjNKLF17k22LkZOoLiExJe9
        X6FsYYmV/56zQxQ1MUlcOf+HGSTBJqAt8fPoXnYQW0TAVuL+o8msIEXMAl1MEmd+3QcrEhZw
        lnjRNI0RxGYRUJWY17cKLM4r4CIxe+8GFogNchI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzgktTR3MF5eEn+IUYCDUYmHlyHlU6wQa2JZcWXuIUYJDmYlEd5U
        7c+xQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAq7zl2
        3H0T72SHt06bZZZlhVayecX/eFvzwmdpeuYLXsUq5k3xsc1hettXLHO++XZnhsOXe7sfip2T
        /fZIJyaV74btPs9l664knp9wLu5tOzuvwU7vFxErtmtssf4/Mf2H68sQjmSRMt6P7nM19nwP
        mbto6cTXrPO+BR/xWvD3ZLZajfYPLx87JZbijERDLeai4kQA3Y6tHEUCAAA=
X-CMS-MailID: 20191213131328epcas5p1c6bafae662369c8f8968f5265163d7ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191213131328epcas5p1c6bafae662369c8f8968f5265163d7ad
References: <CGME20191213131328epcas5p1c6bafae662369c8f8968f5265163d7ad@epcas5p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According the PCI Express base specification when PHY does not meet
ZRX-DC specification, after every 100ms timeout the link should
transition to recovery state when the link is in low power states. 

Ports that meet the ZRX-DC specification for 2.5 GT/s while in the
L1.Idle state and are therefore not required to implement the 100 ms
timeout and transition to Recovery should avoid implementing it, since
it will reduce the power savings expected from the L1 state.

DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.

We need to get the PHY property in controller driver. So, we are
proposing a new method phy_property_present() in the phy driver.

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
 - Added linux-pci@vger.kernel.org as pointed by Gustavo, Sorry for annoying.

Changes w.r.t v4:
 - Addressed review comments from Andrew Murray
 - Rebased on latest linus/master

Changes w.r.t v5:
 - Added check for NULL pointer

Anvesh Salveru (2):
  phy: core: add phy_property_present method
  PCI: dwc: add support to handle ZRX-DC Compliant PHYs

 drivers/pci/controller/dwc/pcie-designware.c |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 drivers/phy/phy-core.c                       | 20 ++++++++++++++++++++
 include/linux/phy/phy.h                      |  6 ++++++
 4 files changed, 36 insertions(+)

-- 
2.7.4

