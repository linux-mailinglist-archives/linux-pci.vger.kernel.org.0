Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F42E7124
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfJ1MRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 08:17:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:56933 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfJ1MRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 08:17:08 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191028121705epoutp016f06e2973e3f070052bbeaa052554ff6~RzrX7_UFj2879128791epoutp01g
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:17:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191028121705epoutp016f06e2973e3f070052bbeaa052554ff6~RzrX7_UFj2879128791epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572265025;
        bh=HCmBWY/wmqdTa6NcwAcBEvMYHjelpaieBLD7s2kbLLc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DLMODg0IDmjoPy1EpGhrBofzVrD3yux2jFWv4j26upZNMZXJ7QMPufYta1jwklyr6
         uhlSo/mrTaD4OwkJH7ouMGZkuzshIKDOIuOqAT9dhz/P44bXgmk2TusvjO8il1k5Mt
         C+1r0TVNJUxBvkzozxpLzi5Zk94hIzYxYzK3Il5o=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191028121705epcas5p1ebb3eb517f07f7cf08313930f60835b1~RzrXMEPt12885528855epcas5p1Z;
        Mon, 28 Oct 2019 12:17:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.BD.20293.14CD6BD5; Mon, 28 Oct 2019 21:17:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191028121704epcas5p483bf05ccb4cd25b1757cd5645e819d12~RzrWpERt22233722337epcas5p4h;
        Mon, 28 Oct 2019 12:17:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191028121704epsmtrp18be6b80ebca61a809c7b1a377a10fd0d~RzrWoWIaZ3109131091epsmtrp1r;
        Mon, 28 Oct 2019 12:17:04 +0000 (GMT)
X-AuditID: b6c32a49-fe3ff70000014f45-07-5db6dc416e1d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.D9.25663.04CD6BD5; Mon, 28 Oct 2019 21:17:04 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191028121703epsmtip16eb380b6af00f8801e5b65a87d9072c4~RzrVcyiuD2549225492epsmtip1G;
        Mon, 28 Oct 2019 12:17:03 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, pankaj.dubey@samsung.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v2 0/2] Add support to handle ZRX-DC Compliant PHYs
Date:   Mon, 28 Oct 2019 17:46:26 +0530
Message-Id: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmuq7jnW2xBq132SzO7lrIarGkKcNi
        /pFzrBa77nawW6z4MpPd4vKuOUDJecfZLBZt/cLuwOGxc9Zddo8Fm0o9+rasYvTYsv8zo8fn
        TXIBrFFcNimpOZllqUX6dglcGYuvLWEr+MBesf/jReYGxjVsXYycHBICJhKXJ01g6WLk4hAS
        2M0ocf3uKiYI5xOjxMYt5xkhnG+MEht+PGeFaXnz9gZU1V5GiaXLzkL1tzBJfNt+kAmkik1A
        W+Ln0b3sXYwcHCICkRLHG1hBapgFJjJKfO1aC7ZcWMBZYm7bGTCbRUBV4uOV82A2r4CLxLN5
        i5kgtslJ3DzXyQzSLCHQwSYx+dBpFoiEi8SNR51QJwlLvDq+hR3ClpJ42d8GZedL9N5dCmXX
        SEy528EIYdtLHLgyhwXkOGYBTYn1u/RBwswCfBK9v58wgYQlBHglOtqEIEwlibaZ1RCNEhKL
        599khrA9JFY93gA2XEggVuL3jEaWCYwysxBmLmBkXMUomVpQnJueWmxaYJiXWq5XnJhbXJqX
        rpecn7uJERzlWp47GGed8znEKMDBqMTDO+Hytlgh1sSy4srcQ4wSHMxKIrwXzwCFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ805ivRojJJCeWJKanZpakFoEk2Xi4JRqYORo1r8fH2IYmn7kSf//
        z3NY5Leukl1dmadR1nJ9W/fMnzPUk09/utj07kmBF8+iI/92l59TXG32Ml951hcbg0rLoH/q
        6azrM66kHlp73GGxsX+ZvdXntC8XbD6+Cl+uur4nfXNbStC/qumzb0TMuz17/1Kv37f2XYx6
        MDFiXbSvnuQ8buaClEtKLMUZiYZazEXFiQB1YasL7gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTtfhzrZYg1WPpS3O7lrIarGkKcNi
        /pFzrBa77nawW6z4MpPd4vKuOWwWZ+cdZ7NYtPULuwOHx85Zd9k9Fmwq9ejbsorRY8v+z4we
        nzfJBbBGcdmkpOZklqUW6dslcGUsvraEreADe8X+jxeZGxjXsHUxcnJICJhIvHl7g6mLkYtD
        SGA3o0THi7usEAkJiS97v0IVCUus/PecHaKoiUni54tDTCAJNgFtiZ9H9wIlODhEBKIlNrwS
        AqlhFpjKKHFmzwWwGmEBZ4m5bWfABrEIqEp8vHIezOYVcJF4Nm8xE8QCOYmb5zqZJzDyLGBk
        WMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxMWlo7GE+ciD/EKMDBqMTDO+Hytlgh
        1sSy4srcQ4wSHMxKIrwXzwCFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0t
        SC2CyTJxcEo1MK4Ny3PMDko5b+GW+kVijVjLKbtZc3ZM7TCrDTOq/T6NWTY/+PDdcIuQCumL
        fIZyKYJSe0xe5VuFG3PcrT7688/qqkR5FjkT0Yktz8SeNm38fzXp3zrW5PuSLxNO77CxMPE+
        Y8r74Auf+u/i9/M8Z6/aN9Ng2U+Ha9Nv3cgSObc913j7Pz2+hUosxRmJhlrMRcWJAC0bamki
        AgAA
X-CMS-MailID: 20191028121704epcas5p483bf05ccb4cd25b1757cd5645e819d12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028121704epcas5p483bf05ccb4cd25b1757cd5645e819d12
References: <CGME20191028121704epcas5p483bf05ccb4cd25b1757cd5645e819d12@epcas5p4.samsung.com>
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

Anvesh Salveru (2):
  dt-bindings: PCI: designware: Add binding for ZRX-DC PHY property
  PCI: dwc: Add support to handle ZRX-DC Compliant PHYs

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
 drivers/pci/controller/dwc/pcie-designware.c              | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h              | 3 +++
 3 files changed, 12 insertions(+)

-- 
2.17.1

