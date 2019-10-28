Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0286CE71AE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 13:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfJ1Mmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 08:42:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25183 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389201AbfJ1Mmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 08:42:44 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191028124239epoutp026a8c3e168291eae748a9a94066402a47~R0BrybRF11285612856epoutp02b
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:42:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191028124239epoutp026a8c3e168291eae748a9a94066402a47~R0BrybRF11285612856epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572266559;
        bh=HiuklP0cYH3jIvujolcAfEAhpwjfw+PqhX1kaOGJoFE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cIMk0XHUdzsA9aRaijkUMmrR//RkvQQo8RJQULsJ08zZFkUHkDF7wofFWoNm5nEJy
         IeZuATC01O7CpnsYY39Us8s4jNyZJwZCt78XEeGqlB+VlO7NCgfhaQ2nRCkNijnhIM
         ucqp0ZgodgmbLg7U9PnCF6BhES5wZuuog+yKL5bI=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191028124238epcas5p38ba9fff1728d661c230ec319ca46cc0e~R0BrP_r_r1784817848epcas5p3U;
        Mon, 28 Oct 2019 12:42:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.7F.20245.E32E6BD5; Mon, 28 Oct 2019 21:42:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191028124238epcas5p451c77e6f4b37e4db69c87f839bd25574~R0Bq2QFnG0725707257epcas5p4h;
        Mon, 28 Oct 2019 12:42:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191028124238epsmtrp249e1c59749d9de0b4acbd9f8d3bfe704~R0Bq1kGyA2925729257epsmtrp2Z;
        Mon, 28 Oct 2019 12:42:38 +0000 (GMT)
X-AuditID: b6c32a4b-fa1ff70000014f15-34-5db6e23eb4b1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.0A.24756.D32E6BD5; Mon, 28 Oct 2019 21:42:37 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191028124236epsmtip2ca97c20a4519b88e7a6b1d9e1a9dc300~R0BpnL7YO0999809998epsmtip2l;
        Mon, 28 Oct 2019 12:42:36 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH 0/2] Add support for ZRX-DC phy property
Date:   Mon, 28 Oct 2019 18:12:18 +0530
Message-Id: <1572266540-17626-1-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCmuq7do22xBk3nZS3O7lrIajH/yDlW
        i5ZZi1gsLu+aw2Zxdt5xNovOL7PYLBZt/cJu8XPXPBYHDo+ds+6ye/Q2v2Pz6NuyitHj8ya5
        AJYoLpuU1JzMstQifbsErozTV7ewFvxlqVj2ezJbA2MPSxcjJ4eEgInEg1l3gWwuDiGB3YwS
        aw/cZIZwPjFKrGpogXK+MUpc67/DCNOyZ95KVojEXkaJHz0HoapamCSOb2sAq2IT0Jb4eXQv
        O4gtIlAmMavpClicWaBUomv+RDYQW1jAQmL9gnYwm0VAVaKhbRYTiM0r4CKx/t52VohtchI3
        z3UyQ9h/WSW+zEmCsF0k7l6fBxUXlnh1fAs7hC0l8fndXjYIO1+i9+5SqHiNxJS7HVAf2Esc
        uDIH6GkOoHs0Jdbv0oc4jU+i9/cTJpCwhACvREebEISpJNE2sxqiUUJi8fybUEs9JO6d3sgG
        UiIkECtx+A/3BEaZWQgjFzAyrmKUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vOz93ECI5tLe8d
        jJvO+RxiFOBgVOLhnXB5W6wQa2JZcWXuIUYJDmYlEd6LZ4BCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeSexXo0REkhPLEnNTk0tSC2CyTJxcEo1MFbtyPm4hClrRc1SSWt/q/D7Cs+M895OvyoQ
        t/PzoolVi59EHpet3dx0sWrarTPdTRs85cI+rdpxMm3lH4tEldzC5sK6E76FBVu/isTF5i3w
        l2Nvrjnmceh38O8F73tsRK4t5dRMfH1OMzFu5hpPKfbrP2skTq6249HS3uF/2/DAytYTXmf2
        H1diKc5INNRiLipOBADSj04G6QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJXtfu0bZYg0eCFmd3LWS1mH/kHKtF
        y6xFLBaXd81hszg77zibReeXWWwWi7Z+Ybf4uWseiwOHx85Zd9k9epvfsXn0bVnF6PF5k1wA
        SxSXTUpqTmZZapG+XQJXxumrW1gL/rJULPs9ma2BsYeli5GTQ0LARGLPvJWsXYxcHEICuxkl
        1v16zwaRkJD4svcrlC0ssfLfc3aIoiYmiZYf/8ESbALaEj+P7mUHsUUEqiQOdPSBTWUWqJS4
        3vGQCcQWFrCQWL+gHayeRUBVoqFtFlicV8BFYv297awQC+Qkbp7rZJ7AyLOAkWEVo2RqQXFu
        em6xYYFhXmq5XnFibnFpXrpecn7uJkZwEGlp7mC8vCT+EKMAB6MSD++Lq9tihVgTy4orcw8x
        SnAwK4nwXjwDFOJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNT
        qoFxmpLplm+7PIsUo72a5/Y25DQf1HpV7ZG9uCR90l3j2qWO8QzqWe1bJJeJVJoZRi9kntTl
        cbb3YEnSWftQ1432mfYOAiu3ePLnsvPkq/0pdU171xrdJLwzu2Ceicj2NVl1TbKXl8zUu/5u
        5q1TcwLs1PuVeJwad//PaHvs2XJmneraxV8UfiuxFGckGmoxFxUnAgAmgzw/HgIAAA==
X-CMS-MailID: 20191028124238epcas5p451c77e6f4b37e4db69c87f839bd25574
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028124238epcas5p451c77e6f4b37e4db69c87f839bd25574
References: <CGME20191028124238epcas5p451c77e6f4b37e4db69c87f839bd25574@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare controller driver provides the support to handle the PHYs which
are compliant to ZRX-DC specification based on "snps,phy-zrxdc-compliant"
DT property. So, add "snps,phy-zrxdc-compliant" property in tegra pcie
controller DT nodes and remove platform specific code from platform driver.

Anvesh Salveru (2):
  PCI: tegra: Remove support for ZRX-DC compliant PHY from platform
    driver
  arm64: tegra: Add support for ZRX-DC phy property

 arch/arm64/boot/dts/nvidia/tegra194.dtsi   | 6 ++++++
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.17.1

