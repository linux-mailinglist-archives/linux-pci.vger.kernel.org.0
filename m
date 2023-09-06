Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A8793AB9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIFLI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjIFLI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 07:08:58 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD8CF1;
        Wed,  6 Sep 2023 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1693998531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EjoL1liNmMORk3s/gwWZ5XM6fEQ6JOyB1f/12zKspDI=;
  b=U75GZguwXHzSWQrxzKPmyPplEjopfpKxCUhu+vwOnG4jGx7z9om2HfqJ
   Ufc3CVGbHjQ8jvmmomqfbTOsMBZhXYuDPjHfgqCRvP9XuP3h1fIFJn+sg
   DsZpS0b5Z3/n1CrBijvGoVL95wJkvkx16GB04Q9o+2o+5ob3H0t+RI1hg
   M=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 124515739
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:rWFnfqLk+bzNBpLJFE+R4JUlxSXFcZb7ZxGr2PjKsXjdYENShjAHy
 mVJDGqOOPjZZDahLtEga9mwo0xQvJLXndc2SQdlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrZwP9TlK6q4mhA7wRgPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5lWmtL/
 +EVBgoVYyGJ2uWk5eiVRPdV05FLwMnDZOvzu1llxDDdS/0nXYrCU+PB4towMDUY354UW6yEP
 oxANGQpNU6bC/FMEg5/5JYWhuCznT/7ejJVsk2coa4f6GnP1g1hlrPqNbI5f/TTH5kIxxvH/
 TOuE2LRKCEVd/eH9z6/wmvrm+rdwgPyZrsWG+jtnhJtqALKnTFCYPEMbnOxofS9hUe3QPpQL
 Esb/idopq83nGSoUND5WDW7rWSCsxpaXMBfe8U+6QeQ2u/M6AexGGcJVHhCZcYguctwQiYlv
 neSg9rjATFHrrKYUzSe+62SoDf0PjIaRVLufgddE1FDuYO65thu0FSWFI0L/LOJYsPdC2r6x
 jqXoQYEn7gih5MMxYDh017Zumf5znTWdTId6gLSV2Ojywp2Yo+5eoClgWTmAeZ8wJWxFQfY4
 iVd8ySKxKVXVMzWynTRKAkYNOvxj8tpJgEwlrKG83MJ0z22s0CucolLiN2VDBc4a51UEdMFj
 aK6hO+w2HOxFCH6BUOUS9jrYyjP8UQHPY2+Ps04lvIUPvBMmPavpUmCn3K40WH3i1QLmqoiI
 5qdesvEJS9EWP82l2roF7lGiuBDKsUCKYX7H8uTI/OPi+f2WZJoYe1dbAvmgh4RsstoXzk5A
 /4AbpDXmn2zocX1YzXN8J57ELz5BSFTOHwCkOQOLrTrClM/SAkc5wr5netJl3pNw/4EyY8lP
 xiVBidl9bYIrSGddF/TOy84OdsCn/9X9BoGAMDlBn7ws1BLXGplxP53m0cfFVX/yNFe8A==
IronPort-HdrOrdr: A9a23:qt3OuqzEJPG5QmFUVHuVKrPwIL1zdoMgy1knxilNoRw8SKKlfq
 eV7ZAmPH7P+VAssR4b+exoVJPtfZq+z+8R3WByB8bAYOCOggLBR+sO0WKL+UyGJ8SUzI9gPM
 lbHJSWcOeAb2RHsQ==
X-Talos-CUID: 9a23:wPGEoWM1vftNZe5DSnJt8UQJF+4fanDsxirXMWriJ2h3cejA
X-Talos-MUID: 9a23:s0SKQgT95U3iOQ8KRXTGtD4hH99W556eEQcQlIdZm8C6DCh/bmI=
X-IronPort-AV: E=Sophos;i="6.02,231,1688443200"; 
   d="scan'208";a="124515739"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Kalle Valo <kvalo@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] PCI: Free released resource
Date:   Wed, 6 Sep 2023 12:08:46 +0100
Message-ID: <20230906110846.225369-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

release_resource() doesn't actually free the resource or resource list
entry so free the resource list entry to avoid a leak.

Fixes: e54223275ba1 ("PCI: Release resource invalidated by coalescing")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reported-by: Kalle Valo <kvalo@kernel.org>
Closes: https://lore.kernel.org/r/878r9sga1t.fsf@kernel.org/
Tested-by: Kalle Valo <kvalo@kernel.org>
Cc: stable@vger.kernel.org      # v5.16+
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ab2a4a3a4c06..795534589b98 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -997,6 +997,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		res = window->res;
 		if (!res->flags && !res->start && !res->end) {
 			release_resource(res);
+			resource_list_destroy_entry(window);
 			continue;
 		}
 
-- 
2.41.0

