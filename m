Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1DD7244
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfJOJ1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 05:27:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOJ1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 05:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=THNfWqQBO9Eb7uFaWUwb/79hWPG9oUJfv7mFrWnTReA=; b=W/92WGlak/I9
        3QFvQQcFm4/2gwcMA/iJhxI8BujMqzh1JFroC8HJXpnQsQ22TlyYfz/EHHlH7YIb+dlJcQaFgOzna
        c64RjLRRExnfzUd/I/2VXPpyGPqrhiKrBoJEnB7Y5QBfUwCaxRRt6AC35CwDiuEbNI/VGOe+Z7rXC
        YmW+4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKJ6Y-0001p9-Cf; Tue, 15 Oct 2019 09:26:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CF9B62742905; Tue, 15 Oct 2019 10:26:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        xu_shunji@hoperun.com
Subject: Applied "dt-bindings: spi: sh-msiof: Add r8a774b1 support" to the spi tree
In-Reply-To: <1570178133-21532-3-git-send-email-fabrizio.castro@bp.renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015092657.CF9B62742905@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 10:26:57 +0100 (BST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The patch

   dt-bindings: spi: sh-msiof: Add r8a774b1 support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 97f41c68b83ea5216dbf3ac51fd86b0fbd399a97 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Fri, 4 Oct 2019 09:35:28 +0100
Subject: [PATCH] dt-bindings: spi: sh-msiof: Add r8a774b1 support

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1570178133-21532-3-git-send-email-fabrizio.castro@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 4afaa48c1666..b6c1dd2a9c5e 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -35,6 +35,7 @@ properties:
       - items:
           - enum:
               - renesas,msiof-r8a774a1      # RZ/G2M
+              - renesas,msiof-r8a774b1      # RZ/G2N
               - renesas,msiof-r8a774c0      # RZ/G2E
               - renesas,msiof-r8a7795       # R-Car H3
               - renesas,msiof-r8a7796       # R-Car M3-W
-- 
2.20.1

