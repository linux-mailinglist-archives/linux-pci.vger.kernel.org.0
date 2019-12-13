Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6111E3D1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 13:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLMMsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 07:48:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:60449 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLMMr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 07:47:58 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213124755epoutp02bbd198507a8400d0ea189de2061b0572~f7xao0KPj0997309973epoutp02V
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 12:47:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213124755epoutp02bbd198507a8400d0ea189de2061b0572~f7xao0KPj0997309973epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576241275;
        bh=FOYvzOc4ArubhpGFdauhxPXlGf36MVaORJdD5vDBn/0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=u+hhLRm0qdGhoUDYoIFPPz0ZPUhWhy+4CwzGxiOkO99JdtDNqTm/kseTFEI4fk6yd
         jdTCV1U9DxfDjHGxDQ2OmLQ2hApqqjIzHKqRdVPPC9bXSvX2NUJ7wziucQ5oeTFCAG
         IokgzQA4zvQq8SII97JfEY51UuXUsB9WePgHPWzk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191213124754epcas5p3077458c986795a5d2a7a68f97ae74f54~f7xaFaTAb1146911469epcas5p3e;
        Fri, 13 Dec 2019 12:47:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.59.19726.A7883FD5; Fri, 13 Dec 2019 21:47:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213124754epcas5p156ab383641794e026b15902d00fc5dc6~f7xZvuuVH0234602346epcas5p1T;
        Fri, 13 Dec 2019 12:47:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213124754epsmtrp1e6a7b59bcaf828c0db1c12b4eb985a10~f7xZu-vHR2978729787epsmtrp1R;
        Fri, 13 Dec 2019 12:47:54 +0000 (GMT)
X-AuditID: b6c32a49-7c1ff70000014d0e-c5-5df3887a3497
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.BC.10238.A7883FD5; Fri, 13 Dec 2019 21:47:54 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213124752epsmtip2cf93c915081ef7cf39f251e1712dae03~f7xYG3EQK0417104171epsmtip2e;
        Fri, 13 Dec 2019 12:47:52 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v5 0/2] Add support to handle ZRX-DC Compliant PHYs
Date:   Fri, 13 Dec 2019 18:17:41 +0530
Message-Id: <1576241263-23817-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmum5Vx+dYgxUfZS2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DK2PdHtaCJr2L3qj2sDYxLuLsYOTkkBEwk2n6eYOti5OIQEtjNKLHl8GJ2COcTo8TmaU+h
        nG+MEivOrWWCaXnT+pYVIrGXUWLh1yUsEE4Lk8TMU4fYQKrYBLQlfh7dyw5iiwhYSxxu3wIW
        Zxb4xyjxeE5FFyMHh7CAs8TUDYkgJouAqsT2fUYgFbwCLhIvv3QzQuySk7h5rpMZZLyEwB42
        iQfPf7CA1EsAFXXMVYeoEZZ4dXwLO4QtJfGyvw3KzpfovbsUyq6RmHK3A2qmvcSBK3PAxjAL
        aEqs36UPcRifRO/vJ0wQ03klOtqEIEwlibaZ1RCNEhKL599khrA9JNpu9LGA2EICsRKzP09n
        nMAoMwth5gJGxlWMkqkFxbnpqcWmBYZ5qeV6xYm5xaV56XrJ+bmbGMEpQstzB+Oscz6HGAU4
        GJV4eFckfooVYk0sK67MPcQowcGsJMKbqv05Vog3JbGyKrUoP76oNCe1+BCjNAeLkjjvJNar
        MUIC6YklqdmpqQWpRTBZJg5OqQbGHrOOfSVrJLOi3ig22Fx1lBJhE2Xha9q99bf1ywfT9/L+
        SpR5sDB2WmO8f/+yzT+4bbL3v7rXfLfB4Ut77tXFy2+49MxP9tjN+eaTfG/7vSdCRzYt5g78
        GjE/5Eqy4inby4Yy24Vqf95QZWv/xq7aEjFlyhp9ft9UidotGrsviwlG7BBnmsyqxFKckWio
        xVxUnAgAuPje4Q0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvG5Vx+dYg6nnOS2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DK2PdHtaCJr2L3qj2sDYxLuLsYOTkkBEwk3rS+Ze1i5OIQEtjNKNH9fQ8zREJC4sver2wQ
        trDEyn/P2SGKmpgkuhuus4Ak2AS0JX4e3csOYosI2ErcfzQZbBKzQBeTxJlf94EmcXAICzhL
        TN2QCGKyCKhKbN9nBFLOK+Ai8fJLNyPEfDmJm+c6mScw8ixgZFjFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREcjlqaOxgvL4k/xCjAwajEw8uQ8ilWiDWxrLgy9xCjBAezkghvqvbn
        WCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYcz5dmbrH
        PetNpPEvpXruqX1Pvp4xW1zFM+f96ZdOEZsNn7+qYX4bfaN8Xsr3snbV5tAq+w/+TRNPbHnn
        /OLD/cD3n5ZdPfOnclfbnxffX/X7rYl6Xyx2reYVXxKPn8+ua8/NKldqCHFE6b/7cH4Rh8ae
        7kU3b8am3Xi9u0d9jbsM04y+cyzs05RYijMSDbWYi4oTAVht2ftDAgAA
X-CMS-MailID: 20191213124754epcas5p156ab383641794e026b15902d00fc5dc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191213124754epcas5p156ab383641794e026b15902d00fc5dc6
References: <CGME20191213124754epcas5p156ab383641794e026b15902d00fc5dc6@epcas5p1.samsung.com>
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

Anvesh Salveru (2):
  phy: core: add phy_property_present method
  PCI: dwc: add support to handle ZRX-DC Compliant PHYs

 drivers/pci/controller/dwc/pcie-designware.c |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 drivers/phy/phy-core.c                       | 17 +++++++++++++++++
 include/linux/phy/phy.h                      |  6 ++++++
 4 files changed, 33 insertions(+)

-- 
2.7.4

