Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F5617948
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 10:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKCJAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiKCJAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 05:00:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FC0B5583;
        Thu,  3 Nov 2022 02:00:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8DxPLc9g2Nj5TAEAA--.2861S3;
        Thu, 03 Nov 2022 17:00:45 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOI4g2NjSJMLAA--.33260S3;
        Thu, 03 Nov 2022 17:00:45 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, liupeibao@loongson.cn,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: PCI: loongson: Add skip-scan property for child node
Date:   Thu,  3 Nov 2022 17:00:40 +0800
Message-Id: <20221103090040.836-2-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221103090040.836-1-liupeibao@loongson.cn>
References: <20221103090040.836-1-liupeibao@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxoOI4g2NjSJMLAA--.33260S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQATCmNiXeMWaAAAsZ
X-Coremail-Antispam: 1Uk129KBjvdXoWrZr1fJw48Xw1fKr1DZw17trb_yoW3XrbE9a
        4xAFn5CFs8JF1Fgws0vr48tF15Z3yI93WkuFn5JF1kCa4IvrZ8KF97A3s8CF47Cr4UuF15
        u397GrWDAFsrGjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        A7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j
        6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the newly added "skip-scan" property for child node.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
 Documentation/devicetree/bindings/pci/loongson.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
index a8324a9bd002..5c2fe9bf2c78 100644
--- a/Documentation/devicetree/bindings/pci/loongson.yaml
+++ b/Documentation/devicetree/bindings/pci/loongson.yaml
@@ -32,6 +32,13 @@ properties:
     minItems: 1
     maxItems: 3
 
+  child-node:
+    type: object
+    properties:
+      skip-scan:
+        description: avoid scanning this device.
+        type: boolean
+
 
 required:
   - compatible
-- 
2.20.1

