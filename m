Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA8E7128
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfJ1MRw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 08:17:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20536 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfJ1MRv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 08:17:51 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191028121750epoutp0255be1e5f9424a1219d1eeb191f176a28~RzsBAqXiR2838428384epoutp02F
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:17:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191028121750epoutp0255be1e5f9424a1219d1eeb191f176a28~RzsBAqXiR2838428384epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572265070;
        bh=bqPCk7isSSDBIwHRP7eJ0wqkj9JI3FTjuzBEeX//hVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C90wuwARSWL6MmbjAhzjUjRX44V5tVBHx/hJWtnA+QMuwPOtjxfnFFPtykq4iujOU
         rnS3ZHcelyXm59XAUzWzNR0p/oOgu0IDns1XRWqlDFF8xrxxANcgrkd0iZz7br+NMo
         zeC7ojkZ7Sx7euX72x81rMP/V8wILno1Q7FIjGoc=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191028121749epcas5p2d5af76e11de8bc4a7cfb3cfbcb6fe5e3~RzsALSrHH2252722527epcas5p2j;
        Mon, 28 Oct 2019 12:17:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.BD.20293.D6CD6BD5; Mon, 28 Oct 2019 21:17:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191028121748epcas5p3054c9583c14a2edde9f725d005895a04~Rzr-iBd6X1929519295epcas5p31;
        Mon, 28 Oct 2019 12:17:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191028121748epsmtrp2cd56628acd17354f7d532f83ecff1ad0~Rzr-hSDdm1489714897epsmtrp2c;
        Mon, 28 Oct 2019 12:17:48 +0000 (GMT)
X-AuditID: b6c32a49-ffbff70000014f45-46-5db6dc6d613b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.D9.25663.C6CD6BD5; Mon, 28 Oct 2019 21:17:48 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191028121746epsmtip163d78dc76de65e3ee93ad059261c6a4c~Rzr9a5foJ2500125001epsmtip1Q;
        Mon, 28 Oct 2019 12:17:46 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, pankaj.dubey@samsung.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for ZRX-DC
 PHY property
Date:   Mon, 28 Oct 2019 17:46:27 +0530
Message-Id: <1572264988-17455-2-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCmum7unW2xBqs2sVic3bWQ1WJJU4bF
        /CPnWC123e1gt1jxZSa7xeVdc9gszs47zmax9PpFJotFW7+wW7TuPcLuwOWxZt4aRo+ds+6y
        eyzYVOqxaVUnm0ffllWMHlv2f2b0+LxJLoA9issmJTUnsyy1SN8ugSvjy8efTAX3uSsuLZ7G
        1sDYytXFyMkhIWAisezjSXYQW0hgN6NE62rLLkYuIPsTo8Tbt1sZIZxvjBKr/i5jgunYcvQM
        E0RiL6NE34zNzBDtLUwSjfc8QGw2AW2Jn0f3Ao3l4BARiJQ43sAKUs8scAto0OHprCA1wgLR
        Ems2b2MBqWERUJXYd0wYJMwr4CJxfs8TVohdchI3z3WCjecUcJX4fXYVG8gcCYEDbBJP9sxl
        gyhykVhy7B6ULSzx6vgWdghbSuLzu71Q8XyJ3rtLoeI1ElPudjBC2PYSB67MAbuBWUBTYv0u
        fZAwswCfRO/vJ0wgYQkBXomONiEIU0mibWY1RKOExOL5N5khbA+Ju0u7WCAhMoNR4ti5TrYJ
        jLKzEIYuYGRcxSiZWlCcm55abFpgmJdarlecmFtcmpeul5yfu4kRnCC0PHcwzjrnc4hRgINR
        iYd3wuVtsUKsiWXFlbmHGCU4mJVEeC+eAQrxpiRWVqUW5ccXleakFh9ilOZgURLnncR6NUZI
        ID2xJDU7NbUgtQgmy8TBKdXA2Cia6u+05qNhclh+XTi75bZbnzac5X5wZIM/U6TbWwVr1bXx
        0xMrJ5qdFVqiwO7jty6/Mbyft3TurydFkyepip5T1/jydpb/7f1LdpwpP91SpDHFd8b7Ujs7
        vqwPDLFOH1+sy1wwYX/i0R195yuXVPFMsNpivNpq/1ozw8vpM83UVrYIZWx2UWIpzkg01GIu
        Kk4EABBeOJwMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnG7OnW2xBudbRS3O7lrIarGkKcNi
        /pFzrBa77nawW6z4MpPd4vKuOWwWZ+cdZ7NYev0ik8WirV/YLVr3HmF34PJYM28No8fOWXfZ
        PRZsKvXYtKqTzaNvyypGjy37PzN6fN4kF8AexWWTkpqTWZZapG+XwJXx5eNPpoL73BWXFk9j
        a2Bs5epi5OSQEDCR2HL0DFMXIxeHkMBuRoktTdeZIRISEl/2fmWDsIUlVv57zg5R1MQksW33
        BHaQBJuAtsTPo3uBbA4OEYFoiQ2vhEBqmAUeMEr8+jyVEaRGWCBSYt/GKUwgNSwCqhL7jgmD
        hHkFXCTO73nCCjFfTuLmuU6wvZwCrhK/z64C2ysEVLPi7A7WCYx8CxgZVjFKphYU56bnFhsW
        GOWllusVJ+YWl+al6yXn525iBIeoltYOxhMn4g8xCnAwKvHwTri8LVaINbGsuDL3EKMEB7OS
        CO/FM0Ah3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjKxF
        3Fdnr+9bcORVUm7oB+2MXwofHAtmPXU7UrJ0rfYhpcrFqfb1imVP2GZMOmPxvj1jTo7WuQDT
        JVL8BprJPn/LpBS5L74Jz528YcMOrZW/MrZYesy88qZorcPVVQEH1wRknV78L97m7NROnrS4
        h8azHT49918cllasVGjTvOS48r784ydy5ZRYijMSDbWYi4oTASzTXm9NAgAA
X-CMS-MailID: 20191028121748epcas5p3054c9583c14a2edde9f725d005895a04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028121748epcas5p3054c9583c14a2edde9f725d005895a04
References: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191028121748epcas5p3054c9583c14a2edde9f725d005895a04@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for ZRX-DC compliant PHYs. If PHY is not compliant to ZRX-DC
specification, then after every 100ms link should transition to recovery
state during the low power states which increases power consumption.

Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
property in DesignWare controller DT node.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change in v2: None

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 78494c4050f7..9507ac38ac89 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -38,6 +38,8 @@ Optional properties:
    for data corruption. CDM registers include standard PCIe configuration
    space registers, Port Logic registers, DMA and iATU (internal Address
    Translation Unit) registers.
+- snps,phy-zrxdc-compliant: This property is needed if phy complies with the
+  ZRX-DC specification.
 RC mode:
 - num-viewport: number of view ports configured in hardware. If a platform
   does not specify it, the driver assumes 2.
-- 
2.17.1

