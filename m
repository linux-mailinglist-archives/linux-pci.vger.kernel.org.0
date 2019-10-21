Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134AFDEC6C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfJUMlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 08:41:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:40882 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 08:41:14 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191021124112epoutp04a9f17012b4181676afbe1404e7503116~PqfbGwtTy2929329293epoutp04s
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 12:41:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191021124112epoutp04a9f17012b4181676afbe1404e7503116~PqfbGwtTy2929329293epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571661672;
        bh=HCmBWY/wmqdTa6NcwAcBEvMYHjelpaieBLD7s2kbLLc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sjBPb0PVc5ExCYjVLYCThKjOUi62fTcmiFLZks6sY3ZvxieS0Y5/xpIBIIer/qWqk
         jEBkw43NLa+ATivl5vPDrpdzT1kz438CkOPbxrORIUqKLYeWKi624RS8TL2UYXbWYB
         5ggvK6hpSGqd6LvZDoVDDbH2qWag/xS4n4jx6t9Q=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191021124111epcas5p40b32797f8aff520345abeabe031c6f9a~PqfZ7o10F0262402624epcas5p4y;
        Mon, 21 Oct 2019 12:41:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.68.04660.667ADAD5; Mon, 21 Oct 2019 21:41:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191021124110epcas5p3151840dbc666756f8499c7a9719f3d51~PqfZjZBc20476204762epcas5p3F;
        Mon, 21 Oct 2019 12:41:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191021124110epsmtrp1d2c062cbb0fe054cdad869c1a825a666~PqfZii9wl1237012370epsmtrp16;
        Mon, 21 Oct 2019 12:41:10 +0000 (GMT)
X-AuditID: b6c32a4a-60fff70000001234-a2-5dada7660964
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.F0.04081.667ADAD5; Mon, 21 Oct 2019 21:41:10 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191021124108epsmtip2fa6c549d40205e0e7b4d46040e6f5ed8~PqfXxgJDY2247622476epsmtip2m;
        Mon, 21 Oct 2019 12:41:08 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, pankaj.dubey@samsung.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH 0/2] Add support to handle ZRX-DC Compliant PHYs
Date:   Mon, 21 Oct 2019 18:10:45 +0530
Message-Id: <1571661645-30454-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSXUhTcRjG+e+cnXM2XJyOgm8zFBdS01L7goNISRgdIiKoixLFhp7UcnNs
        flbQmGZqmRpepIjfWfkZm0udraUpC8GRmIrY7sJSCz/Lcki5nUl3v/d5nvf/Phd/CmM2cTmV
        ocnmdRpVpoKQ4q/fKw8eufG8Kyl6zR3DFv7tE7Pj1iYx22pMZxtGnGLW6ioh2RcbNSQ7aa0j
        2PF6B8F+d38j2WczEyK22bJBsvdtI2ScH9dZ34m4gVoXyTWacjhTeynBPe5tR1yvfR1x66bg
        S2SCNDaVz8zI5XVRp65L01umWwntCplvX53ADKiTKEMSCugTYDYYRWVISjH0IAKXsxAXhjUE
        H/sqfM4vBHNFDnJ3pW6gSiwYNgS231OkMBSJYPDDW+RJEXQE/Bm17RgUFUBfA4fBu4DRywhe
        tTi8uj8dB+bxIE8cp8Ogo3rJe0BGx8OisR4XjgXDrLMUE7ifgEelGoHjYcbejQT2h0VHr6+c
        HBYqin2cBeWuZz6+C9WuEl/+NLz7VId7KmC0EnqsUR4Zo/dAufuLyCMDLYOSYkZABRTX3BEW
        AVoaZn1lOOgzr4k9zNBJYGlyiSrR/tr/bzYi1I728Vq9Oo3Xn9Qe0/B5kXqVWp+jSYtMyVKb
        kPc7hJ/vR23OC8OIppDCT6Zt7kpixKpcfYF6GAGFKQJkn6N3JFmqquA2r8tK1uVk8vphFETh
        ikDZE/FUIkOnqbL5Wzyv5XW7roiSyA3ontvwcjTksDxai+N+KV+Tm90Xq7qtbdtbkvywyUAi
        YkLaTA8x7JxGLTozuGCc+fHmONPxdF45NLZ3tdtSO2ZmposdV8uUMSs/N82y0A5uMPGQxZIa
        +GB+O/ZKvr0n5CFItpqwJXNXRujl+bMHbrasnmvdLu8eslkra5YT8hS4Pl11NBzT6VX/AB8+
        IJYKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSvG7a8rWxBotXyFs0/9/OanF210JW
        iyVNGRbzj5xjtdh1t4PdYsWXmewWl3fNYbM4O+84m8Wb3y/YLZZev8hksWjrF3aL1r1H2B14
        PNbMW8PosXPWXXaPBZtKPTat6mTz6NuyitFjy/7PjB6fN8kFsEdx2aSk5mSWpRbp2yVwZSy+
        toSt4AN7xf6PF5kbGNewdTFyckgImEjM2TmRtYuRi0NIYDejxOW3ZxkhEhISX/Z+hSoSllj5
        7zk7RFETk8TkxbOYQRJsAtoSP4/uBUpwcIgIREtseCUEUsMs8JNR4kb7OWaQuLCAg8Tms9Ig
        5SwCqhKrp7xmB7F5BVwkXjXNY4GYLydx81wn8wRGngWMDKsYJVMLinPTc4sNCwzzUsv1ihNz
        i0vz0vWS83M3MYLDUEtzB+PlJfGHGAU4GJV4eE8sWRsrxJpYVlyZe4hRgoNZSYT3jgFQiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsa16yYmfDsyq+8+
        1/5Xe+9tytm59sPRMy9/bjTZfEOjdH/ggzVxv5nPZAaV/HMO0ObuPjJxee1kTXXDNtN9q+YL
        uAo3Z0a/12T5cVTN6GBuUHTIqzknY3Qm/WZh9Fje+0Ke2TDjXUeHocX2aYnZf05r3BJtv3zo
        IRf3EX0XU0GZSb65K4OPLulRYinOSDTUYi4qTgQAsHxy/T8CAAA=
X-CMS-MailID: 20191021124110epcas5p3151840dbc666756f8499c7a9719f3d51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191021124110epcas5p3151840dbc666756f8499c7a9719f3d51
References: <CGME20191021124110epcas5p3151840dbc666756f8499c7a9719f3d51@epcas5p3.samsung.com>
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

