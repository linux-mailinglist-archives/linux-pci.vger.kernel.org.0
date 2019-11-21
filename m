Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48E710491D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 04:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUDUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 22:20:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51036 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfKUDUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 22:20:36 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121032032epoutp0138977466d24866347199d09ba7abc552~ZD1wWgQh62939629396epoutp01M
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 03:20:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121032032epoutp0138977466d24866347199d09ba7abc552~ZD1wWgQh62939629396epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574306432;
        bh=ccSkOQg4F6U9pZaBUzz7NJ9wxz842W9I4PHLHZxX2WA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TDUgoqJJpkAJZi3Xd6ri8+WgIxCT0/8k7d5QE/kzYFuKOw7wTdhpbel8Rsn2+UJGu
         zskB07tGQCyhCSpS1qo/4+AswLTsYjZxI2nmlMnrEeIpdh4z9kEnA9Hkk/cVhDy5ZK
         Wprr1tdhJUZQk4m2ghewafLKhn0ezBBpkCEUbOSk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191121032032epcas5p4f088ee297e83e8febb353fbe49e600d8~ZD1vfri9m0464404644epcas5p4O;
        Thu, 21 Nov 2019 03:20:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.41.04078.F7206DD5; Thu, 21 Nov 2019 12:20:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191121032031epcas5p29659e014c9ff4564b24c9b1457d6b0b7~ZD1ukL5zj1591515915epcas5p29;
        Thu, 21 Nov 2019 03:20:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121032031epsmtrp2956f58b5da0d0cf8a3a7f2c760ccda7c~ZD1ujZ4Kw1130011300epsmtrp2M;
        Thu, 21 Nov 2019 03:20:31 +0000 (GMT)
X-AuditID: b6c32a49-605ff70000000fee-fa-5dd6027f4ec5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.BE.03814.E7206DD5; Thu, 21 Nov 2019 12:20:30 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191121032029epsmtip20321a3cb9aebda76e4d5787b127942ff~ZD1s6de2r3029530295epsmtip2c;
        Thu, 21 Nov 2019 03:20:29 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v4 0/2] Add support to handle ZRX-DC Compliant PHYs
Date:   Thu, 21 Nov 2019 08:50:06 +0530
Message-Id: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmum4907VYg/Zj5hbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZn5x1ns3jz+wW7xdLrF5ksFm39wm7RuvcIuwOP
        x5p5axg9ds66y+6xYFOpx6ZVnWwefVtWMXps2f+Z0eP4je1MHp83yQVwRHHZpKTmZJalFunb
        JXBlfFpyk6XgA3/FrudTWRsYn/J0MXJySAiYSLRuf8LSxcjFISSwm1Fi/a5udgjnE6PEqxlP
        WSGcb4wSvdsXscG0dM76ygyR2MsoserSZiinhUni1qdDYFVsAtoSP4/uZQexRQSsJQ63b2ED
        KWIW+McocfXLPMYuRg4OYQFnifn37EBqWARUJa5uvcMMYvMChc8fOcYKsU1O4ua5TrAFEgJ7
        2CRezL/PApFwkZjcvwbKFpZ4dXwLO4QtJfH53V6oU/Mleu8uhYrXSEy528EIYdtLHLgyhwXk
        BmYBTaCn9UHCzAJ8Er2/nzCBhCUEeCU62oQgTCWJtpnVEI0SEovn32SGsD0kDq2+BnaAkECs
        xNK7L9gmMMrMQpi5gJFxFaNkakFxbnpqsWmBYV5quV5xYm5xaV66XnJ+7iZGcKrQ8tzBOOuc
        zyFGAQ5GJR7eDI2rsUKsiWXFlbmHGCU4mJVEePdcvxIrxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nHcS69UYIYH0xJLU7NTUgtQimCwTB6dUA6Pez9sF9ewP27YyL9iw4H/RiS8uvNabrKtcl26+
        7S4hliPpMDdNPdI15kn2Ab+g5x0aQsvdfpi9kpb/ZHDKuubep9vbtuk7V2rqajvaLJQP0NTZ
        uyj1oEPyxAdy1g//Lqrhaww8wiqeGbyULfCVLLfzqeAo7r+6a25snc9ysEAz7cvmpdGejkos
        xRmJhlrMRcWJAMeAlVQRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvG4d07VYg+t3LC2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZLNr6hd2ide8Rdgce
        jzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvTYsv8zo8fxG9uZPD5vkgvgiOKySUnNySxLLdK3
        S+DK+LTkJkvBB/6KXc+nsjYwPuXpYuTkkBAwkeic9ZW5i5GLQ0hgN6PEkndtbBAJCYkve79C
        2cISK/89Z4coamKSOHD9MTtIgk1AW+Ln0b1gtoiArcT9R5NZQYqYBbqYJNae3gKU4OAQFnCW
        mH/PDqSGRUBV4urWO8wgNi9Q+PyRY6wQC+Qkbp7rZJ7AyLOAkWEVo2RqQXFuem6xYYFRXmq5
        XnFibnFpXrpecn7uJkZwSGpp7WA8cSL+EKMAB6MSD2+GxtVYIdbEsuLK3EOMEhzMSiK8e65f
        iRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXAuPYZsxIf
        p/SuWjkBya0/D5+rFVI+3OEvbbPVWX7S9RWb2L3ZZ91WsV1bq9kS8cLzw+FL+XE/Lm5KTeo+
        c7P3xRXdqNJakasanzrZDZPl1yxJ0Ep+kiTP4GPm1C1uu/C3wSzRVB/Zginemx0ezDrlx66/
        SXyDYbqdFoPealHR5V/X9ul/3/xAiaU4I9FQi7moOBEAEVYYmUUCAAA=
X-CMS-MailID: 20191121032031epcas5p29659e014c9ff4564b24c9b1457d6b0b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191121032031epcas5p29659e014c9ff4564b24c9b1457d6b0b7
References: <CGME20191121032031epcas5p29659e014c9ff4564b24c9b1457d6b0b7@epcas5p2.samsung.com>
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

Platform specific phy drivers should implement the callback for
property_present which will return true if the property exists in
the PHY.

static bool xxxx_phy_property_present(struct phy *phy, const char *property)
{
       struct device *dev = &phy->dev;

       return of_property_read_bool(dev->of_node, property);
}

And controller platform driver should populate the phy_zrxdc_compliant
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

Anvesh Salveru (2):
  phy: core: add phy_property_present method
  PCI: dwc: add support to handle ZRX-DC Compliant PHYs

 drivers/pci/controller/dwc/pcie-designware.c |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 drivers/phy/phy-core.c                       | 26 ++++++++++++++++++++++++++
 include/linux/phy/phy.h                      |  8 ++++++++
 4 files changed, 44 insertions(+)

-- 
2.7.4

