Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A433E71FC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 13:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfJ1Mo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 08:44:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:55415 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbfJ1MnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 08:43:03 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191028124300epoutp04f5087a555c43a9a7aa702a59fbfb9cce~R0CADHc_a2623126231epoutp04j
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191028124300epoutp04f5087a555c43a9a7aa702a59fbfb9cce~R0CADHc_a2623126231epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572266580;
        bh=vEAQRf/wh565Rw7rBpYNNdZRxUwK7S8rj9InQtZqQqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVrCVE3AzSuEkA+8Wl0qy8spIHMxXDNISB7PpGNPJ1ruTNoJXoaJ+oWcFsBFoYw0E
         mHQWC7qXt4gz42lGVb4vQMdP5rENWQaTsiRMbRf/PryN9m86f562I/d4+JZAVxmURc
         SQWyGnG45cVO6YN7RfYhnOavELcZ03J7d9gx/NVc=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191028124259epcas5p2177e882f82bc55bbb79adfafb8479beb~R0B_g_NtK0456504565epcas5p2g;
        Mon, 28 Oct 2019 12:42:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.F1.48302.352E6BD5; Mon, 28 Oct 2019 21:42:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191028124258epcas5p17861f4fdb40385a184fc397f45c898a5~R0B93U1UM3227132271epcas5p1W;
        Mon, 28 Oct 2019 12:42:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191028124258epsmtrp14b635cca4841f1ace78daa7a9aabdf62~R0B92kGhc1231112311epsmtrp15;
        Mon, 28 Oct 2019 12:42:58 +0000 (GMT)
X-AuditID: b6c32a4a-33fff7000001bcae-58-5db6e253847e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.0A.24756.252E6BD5; Mon, 28 Oct 2019 21:42:58 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191028124256epsmtip2f768a74d043118782800f048892c4c13~R0B8Y8WqL1066510665epsmtip2r;
        Mon, 28 Oct 2019 12:42:56 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     pankaj.dubey@samsung.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Anvesh Salveru <anvesh.s@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm64: tegra: Add support for ZRX-DC phy property
Date:   Mon, 28 Oct 2019 18:12:20 +0530
Message-Id: <1572266540-17626-3-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572266540-17626-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmhm7wo22xBl1XOCzO7lrIajH/yDlW
        i5ZZi1gsLu+aw2Zxdt5xNovOL7PYLJZev8hksWjrF3aL1r1H2C1+7prH4sDlsWbeGkaPnbPu
        sntsWtXJ5tHb/I7No2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDIO/drBWDBXsuLP/BeMDYw7
        RboYOTkkBEwkvs58xNjFyMUhJLCbUaL7SRMzhPOJUeLa6x/sEM43RolnvxcwwbQ0LDvLBpHY
        yygx/eBvqKoWJokl1/8yglSxCWhL/Dy6lx3EFhEok5jVdAVsCbPAPkaJKTPOgSWEBdwkjve8
        ZQWxWQRUJT70bWcDsXkFXCR2bb/LArFOTuLmuU5mEJtTwFWie+sjFpBBEgI72CT+959lhChy
        kVj88jUrhC0s8er4FnYIW0riZX8blJ0v0Xt3KZRdIzHlbgdUr73EgStzgIZyAF2nKbF+lz5I
        mFmAT6L39xMmkLCEAK9ER5sQhKkk0TazGqJRQmLx/JvMELaHROufTdBwmMEo0fXmKvMERtlZ
        CEMXMDKuYpRMLSjOTU8tNi0wykst1ytOzC0uzUvXS87P3cQIThFaXjsYl53zOcQowMGoxMM7
        4fK2WCHWxLLiytxDjBIczEoivBfPAIV4UxIrq1KL8uOLSnNSiw8xSnOwKInzTmK9GiMkkJ5Y
        kpqdmlqQWgSTZeLglGpgVHx68OrGR5EiynccGJSDyl8Y/i64lKU90c3qn4xYusO3+3ccBWa/
        Cl53oqY16PK8X1kXz4vmPGqJrfWYy3c9Vu7uwYW5wYHLsj+y+ljOKv259vae4AAGm23Sv/Mu
        7Axx33et+vHVF5N2nty6YPFLfi/fLatMF2S2+Wds6ZAKycx7kxZu8dhHXImlOCPRUIu5qDgR
        AD7CnfYNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvG7Qo22xBnf/iluc3bWQ1WL+kXOs
        Fi2zFrFYXN41h83i7LzjbBadX2axWSy9fpHJYtHWL+wWrXuPsFv83DWPxYHLY828NYweO2fd
        ZffYtKqTzaO3+R2bR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGUc+rWDsWCuZMWf+S8YGxh3
        inQxcnJICJhINCw7y9bFyMUhJLCbUWLLrzMsEAkJiS97v7JB2MISK/89Z4coamKSWPN6HStI
        gk1AW+Ln0b3sILaIQJXEgY4+FpAiZoEjjBI/br0A6xYWcJM43vMWrIFFQFXiQ992sDivgIvE
        ru13obbJSdw818kMYnMKuEp0b30EFhcCqmn6+4p5AiPfAkaGVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwQGqpbmD8fKS+EOMAhyMSjy8L65uixViTSwrrsw9xCjBwawkwnvxDFCI
        NyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxvaU/g3Rf6Xt
        Gy7tStB7ezp3zuQ7YVKvrpc/XLD0ZefXuIPuqcJr/HU0mE//6H787/V+J41DPZ8OlT8s8/58
        SHyb0g6niZ7veO3/S8lObS/4fflMwrfL5ZYbNzQZSMuKCdyeecGn29p1l39/yFPVN76XWdyl
        +sq8FQ9xlbyZosG93udKziMWKyWW4oxEQy3mouJEANVhKEpMAgAA
X-CMS-MailID: 20191028124258epcas5p17861f4fdb40385a184fc397f45c898a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028124258epcas5p17861f4fdb40385a184fc397f45c898a5
References: <1572266540-17626-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191028124258epcas5p17861f4fdb40385a184fc397f45c898a5@epcas5p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DesignWare controller driver provides the support to handle the PHYs which
are compliant to ZRX-DC specification based on "snps,phy-zrxdc-compliant"
DT property. So, add "snps,phy-zrxdc-compliant" property in tegra pcie
controller DT nodes.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Depends on the following patch:
https://patchwork.kernel.org/patch/11215241/
https://patchwork.kernel.org/patch/11215239/

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 3c0cf54f0aab..bf2dbf84c8c9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1194,6 +1194,7 @@
 		ranges = <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000   /* downstream I/O (1MB) */
 			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
 			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		snps,phy-zrxdc-compliant;
 	};
 
 	pcie@14120000 {
@@ -1240,6 +1241,7 @@
 		ranges = <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000   /* downstream I/O (1MB) */
 			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
 			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		snps,phy-zrxdc-compliant;
 	};
 
 	pcie@14140000 {
@@ -1286,6 +1288,7 @@
 		ranges = <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000   /* downstream I/O (1MB) */
 			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
 			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		snps,phy-zrxdc-compliant;
 	};
 
 	pcie@14160000 {
@@ -1332,6 +1335,7 @@
 		ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
 			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		snps,phy-zrxdc-compliant;
 	};
 
 	pcie@14180000 {
@@ -1378,6 +1382,7 @@
 		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
 			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		snps,phy-zrxdc-compliant;
 	};
 
 	pcie@141a0000 {
@@ -1428,6 +1433,7 @@
 		ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
 			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		snps,phy-zrxdc-compliant;
 	};
 
 	sysram@40000000 {
-- 
2.17.1

