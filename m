Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52848710FAB
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjEYPd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjEYPd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 11:33:57 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 08:33:56 PDT
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F62D8;
        Thu, 25 May 2023 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1685028836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FXbmH67vlk1ZslsVcFKkeP9jHQ12gqPMkF+FEgaa2jA=;
  b=HQG55yWLi9e9wPc7tTHvtj+WVo7GD93Op+k1snKXRxUOVqFONQhfB7dv
   4nZwKZx8gPHMBU/jleatI7Xfzm0U3s8GncX2vwaz8cJ5vhuRhPE20tBlL
   7ULjonTJmNxdxBN07dF+TH1/97GCDr9hZXSkt4q9Lcb3lbcP+aPkIBZur
   M=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 110823932
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:4T++xal2YBO981LnvP4aVKDo5gy8JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOCj/SbKmOM2OgL98laou0oBsEusDTz9IyHFZtpHsyHyMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5KyaVA8w5ARkPqgW5gKGzhH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 aQSGDQrRD6Evsiz4vWkUOBSmMoOAvC+aevzulk4pd3YJfMvQJSFSKTW/95Imjw3g6iiH96HO
 ZBfM2A2Kk2dPVsWYAx/5JEWxY9EglHldCZD7lacqqct/GHXyCR60aT3McqTcduPLSlQth/B/
 jKcpDWiWHn2MvSgkT+Y1EvwmtXLhCT7VJ0VT+OC+PVD1Qj7Kms7V0RNCArTTeOCokq/Xc9Pb
 k8Z4CwjqYAs+0GxCNrwRRu1pDiDpBF0c95RFfAqrRmGy4LK7AuDQGsJVDhMbJohrsBebTYq2
 1uGltryLTNot7KRRDSW8bL8hTC7OG4VIGkNIyEJSwQt6NDlp4cyhRvLCN1kFcaIYsbdQG+qh
 WrQ9W5n2utV1JRQv0mmwbzZq2qmlpzvZCAy3y/SfCW69ApHeoCISbX9vDA38s18BIqeS1CAu
 l0NlM6f8P0CAPmxqcCdfAkeNOr3vqjYaVUwlXYqRsB8rGr1pxZPaKgKuFlDyFFV3tHokNMDS
 Gvaoktv6ZBaJxNGhocnMtvqW6zGIUUNfOkJt8w4jPIUOvCdlyfdpkmCgHJ8OEiz+HXAaYllZ
 f+mnT+EVB7285hPwjusXPs62rQ23C04zm67bcmln0j2jOHEPyTMFO9t3L6yggcRtfnsneko2
 4wHa5viJ+t3C4USnRU7AaZMdAtXfBDX9Lj9qtBNd/7rHzeK7FoJUqeLqZt4ItwNokigvruQl
 p1LchMCmQWXaLyuAVniV02Pn5u+Bc8h8yphZUTB/z+AghAeXGpm149HH7NfQFXt3LULISJcJ
 xXdR/i9Pw==
IronPort-HdrOrdr: A9a23:7hFbx6vlKNLnW8uKukIyJoyH7skDstV00zEX/kB9WHVpm6yj+v
 xG/c5rsCMc7Qx6ZJhOo7+90cW7L080lqQFg7X5X43DYOCOggLBQL2KhbGI/9SKIVycygcy78
 Zdm6gVMqyLMbB55/yKnTVRxbwbsaW6GKPDv5ag8590JzsaD52Jd21Ce36m+ksdfnggObMJUK
 Cyy+BgvDSadXEefq2AdwI4t7iqnaysqHr+CyR2fiIa1A==
X-Talos-CUID: 9a23:gblOT21ga868H7LQD4hZQLxfQsoVdlv34nDpCUqaTnlzQYOLR3K+wfYx
X-Talos-MUID: 9a23:3DDZ/ARrwfXsWvHGRXTT3DR/Ev40/56qEUcNnYoB4Je+OydZbmI=
X-IronPort-AV: E=Sophos;i="6.00,191,1681185600"; 
   d="scan'208";a="110823932"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <linux-kernel@vger.kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] PCI: Release coalesced resource
Date:   Thu, 25 May 2023 16:32:48 +0100
Message-ID: <20230525153248.712779-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When contiguous windows are coalesced, the resource is invalidated and
consequently not added to the bus. However, it remains in the resource
hierarchy:

...
  ef2fff00-ef2fffff : 0000:00:13.2
    ef2fff00-ef2fffff : ehci_hcd
00000000-00000000 : PCI Bus 0000:00
f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f0000000-f3ffffff : Reserved
...

In some cases (e.g. the Xen scratch region), this causes future calls to
allocate_resource() to choose an inappropriate location which the caller
cannot handle. Fix by releasing the resource and removing from the
hierarchy.

Fixes: 7c3855c423b1 ("PCI: Coalesce host bridge contiguous apertures")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2826c4a832..00ed20ac0dd6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -997,8 +997,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		offset = window->offset;
 		res = window->res;
-		if (!res->flags && !res->start && !res->end)
+		if (!res->flags && !res->start && !res->end) {
+			release_resource(res);
 			continue;
+		}
 
 		list_move_tail(&window->node, &bridge->windows);
 
-- 
2.31.1

