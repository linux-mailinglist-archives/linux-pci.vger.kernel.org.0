Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D3717D32
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjEaK2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjEaK2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 06:28:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E949FB3;
        Wed, 31 May 2023 03:28:01 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dxd_EwIXdkE+8CAA--.6608S3;
        Wed, 31 May 2023 18:28:00 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx77MtIXdk+juCAA--.15700S2;
        Wed, 31 May 2023 18:27:57 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>
Cc:     Li Yi <liyi@loongson.cn>, linux-pci@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] PCI: Add dummy implement for pci_clear_master() function
Date:   Wed, 31 May 2023 18:27:44 +0800
Message-Id: <20230531102744.2354313-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx77MtIXdk+juCAA--.15700S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7CryUGr15Xw4UKr1xurWxZwb_yoW8Aw4rpa
        98AFyrCrW8GFy8Gw4UJFyIvF1ag39xZ34Sy3y7Kwn09a9Fya4rtFnYkF17Arn3JrWvkFy3
        Ww17Ka1DWw4YyFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bh8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
        6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2gyCDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
call pci_clear_master() without config_pci guard can not pass compile test.

   drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
   In function 'etnaviv_gpu_pci_fini':
>> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
   error: implicit declaration of function 'pci_clear_master';
   did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
      32 |         pci_clear_master(pdev);
         |         ^~~~~~~~~~~~~~~~
         |         pci_set_master
   cc1: some warnings being treated as errors

[1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1

V2:
	* Adjust commit log style to meet the convention and add Fixes tag

Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d0c19ff0c958..71c85380676c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
-- 
2.25.1

