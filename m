Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306F52799B
	for <lists+linux-pci@lfdr.de>; Sun, 15 May 2022 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiEOTr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 May 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiEOTrz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 May 2022 15:47:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E192FFD9;
        Sun, 15 May 2022 12:47:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nqKDW-00064B-3l; Sun, 15 May 2022 21:47:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/5] Enable rk356x PCIe controller
Date:   Sun, 15 May 2022 21:47:48 +0200
Message-Id: <165264375744.2524444.12267282718534665195.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429123832.2376381-1-pgwipeout@gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Apr 2022 08:38:26 -0400, Peter Geis wrote:
> This series enables the DesignWare based PCIe controller on the rk356x
> series of chips. We drop the fallback to the core driver due to
> compatibility issues. We reset the PCIe controller at driver probe to
> prevent issues in the future when firmware / kexec leaves the controller
> in an unknown state. We add support for legacy interrupts for cards that
> lack MSI support (which is partially broken currently). We then add the
> device tree nodes to enable PCIe on the Quartz64 Model A.
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
      commit: c9168492af55bdbc811e05bfc55ae70880bf8ff3
[5/5] arm64: dts: rockchip: Enable PCIe controller on quartz64-a
      commit: 4f4cbbb147b988daaa036dcf34628d93b2e22cd9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
