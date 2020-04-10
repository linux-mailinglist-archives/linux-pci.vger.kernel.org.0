Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3BB1A3D76
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 02:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgDJArt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 20:47:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38795 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgDJArt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 20:47:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5so556966edq.5;
        Thu, 09 Apr 2020 17:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AaXKqqNhWwXTEhyoNjhEC/wZ5IBgda9BijmlHrsyAzs=;
        b=rlX6YEU9uaIFZ8ZG6zqSY97HPpxFwjg8LybI2X+embhgop3KgGzATQRsGQwNSfDQ7a
         VZu9Eh8ZQtzQ+O7iooYPpAsdzCgUvQ9uqz83rrrhC7DOGgejll1BoyqsB4/ttHFCmGgP
         8fUyKOkmEzER5DlcJpUfau8Hh4gBy46CktuIR1nSXmI4s4zC3oXHHPKZU30Q1XO63rVk
         YrgfBJPbZwdYhuu4G4qCtXV7gmoStSKSemfQCt2kM4ks1UzMJI04G7CeVAjV0uguRA9Z
         DVrZZoZRM8RTidVfCzcc0m1ypTJNYBrLdVaMrsHffulpw1xNU0U2CCxRpaECGy/KbGXS
         3ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AaXKqqNhWwXTEhyoNjhEC/wZ5IBgda9BijmlHrsyAzs=;
        b=DkQsQQQsiEt+12/erGS7CQ+Niv3xTTHcXJrI7of1mHlpQgjBNL9nQvR8soCjGA46B1
         cCaw4tAUnGNCKO00/VyVUf0HekALPvxGN97y/E96kdyNXV9qx7NfTOw64JJUHJRNd0xt
         jnwOi9qWI5AkeyzaHxClpNGiWUoYZ/bgiR17qqYYZcJK36wEFsZ+alje9+vJgfQIX1ze
         6LJK5mL1OfxfLr5V/DZhV1VEMHiyYFcfz9N12/q4OUoDULrYANGx3B+H36r/vUxNGE3x
         Rt0/vECGx+kzc/hkc3yJtKvpxIO1qHBe+y1LWPwNYweX1hfGFZsNc0xWj3KMyh5Y8yJ8
         4hdg==
X-Gm-Message-State: AGi0Pub5bg8EKDKGeQl7EQmDuDcckzTwcxEb4Qdyh+qQV7vooNzmmv65
        mgAPLLEYmv9N8jQMcoMfvj4Uhcd6UVPa2CF9
X-Google-Smtp-Source: APiQypIDgPP5SYnSGNGLtJlzJvRK3ujDA4LiVyVvMnB5ny2rpXt+EMRELOoEoRsm95Z4o7IVoL/mEA==
X-Received: by 2002:aa7:c893:: with SMTP id p19mr2597008eds.19.1586479666469;
        Thu, 09 Apr 2020 17:47:46 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.googlemail.com with ESMTPSA id z16sm30523edm.52.2020.04.09.17.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:47:45 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Move tx-deempth and tx swing to pci.txt
Date:   Fri, 10 Apr 2020 02:47:34 +0200
Message-Id: <20200410004738.19668-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pushing some fixes to pcie qcom driver, one of the patch had to make
some fixes to tx deempth and tx swing. It was suggested to propose this
to the generic pci.txt as they are actually standard parameter than can
be tuned per board. I also notice these property are already used in
imx6 driver so this would also help to generalize it.

Ansuel Smith (4):
  devicetree: bindings: pci: document tx-deempth tx swing and rx-eq
    property
  drivers: pci: dwc: pci-imx6: update binding to generic name
  arm: dts: imx6: update pci binding to generic name
  devicetree: bindings: pci: fsl,imx6q-pcie: rename tx deemph and swing

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt | 12 ++++++------
 Documentation/devicetree/bindings/pci/pci.txt  | 18 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-ba16.dtsi              |  4 ++--
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi        |  4 ++--
 arch/arm/boot/dts/imx7d.dtsi                   |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c          | 12 ++++++------
 6 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.25.1

