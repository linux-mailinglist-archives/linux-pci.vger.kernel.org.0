Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D426B3D19
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 12:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCJLAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 06:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJLAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 06:00:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6569079E;
        Fri, 10 Mar 2023 02:59:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6456661383;
        Fri, 10 Mar 2023 10:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BA6C433D2;
        Fri, 10 Mar 2023 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678445996;
        bh=6HNYmPSJ53e5recOteBLDrR//Q6H9ztqrpDz+ZdxIZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY2mrrC7snf0967lhtOTrr7oHSkmUs/i2L8OHTR4PL1rwC8tGZwq+dYYUy1IDCt/V
         OHbDHluEC8J/Dc9AZvJw4tlAslf4BgA/xSxj6CFTxBx7cVeq9FQNTcDvruU5YHsqKe
         sshXjlE85gxIBTi67mtZxDlZ8B78w8ubqR2WzVVxoh0/Et/cSvNA59yPEpraHRK3YE
         +mEitmB3TWdU/+OvcuJu7tRXqNGpDe6x1nqGcOV9TY4PhBHEIOeVTkHpP0s4D6Nt3Q
         MNrMSyrfGKYy2RyL33Pb84ya8EJ8HSM4oFGpEN8eEmJ4cNMnrLrxO4dN/DZO0inXhS
         SmeqWBLn1yfPw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v4 0/5] dt-bindings: first batch of dt-schema conversions for Amlogic Meson bindings
Date:   Fri, 10 Mar 2023 11:59:47 +0100
Message-Id: <167844597212.1217818.3420848199619883504.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 08 Mar 2023 14:27:28 +0100, Neil Armstrong wrote:
> Batch conversion of the following bindings:
> - amlogic-efuse.txt
> - amlogic-meson-mx-efuse.txt
> - meson-wdt.txt
> - meson-ir.txt
> - rtc-meson.txt
> - amlogic,meson6-timer.txt
> - amlogic,meson-pcie.txt
> 
> [...]

Applied to controller/dt, thanks!

[5/5] dt-bindings: PCI: convert amlogic,meson-pcie.txt to dt-schema
      https://git.kernel.org/pci/pci/c/b80b848bdf56

Thanks,
Lorenzo
