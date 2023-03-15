Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD386BC0FD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 00:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjCOXcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjCOXcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 19:32:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164223A6C;
        Wed, 15 Mar 2023 16:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D794B81F9A;
        Wed, 15 Mar 2023 23:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08614C433A7;
        Wed, 15 Mar 2023 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923130;
        bh=YEs24c3iU6V6MLaAcnGzPLr4tf4jXosEk7JpNXjlX5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkGZU8jeu21PBJ4+Xa6YUetYikfEGNrjoZWkbLgXU5CYoOay+6JhtlV8sYkDKZ4Xm
         PYk5C65chIMNzoC3t+wpi/ilMgC48NqTBobRIxchC0WNpcY0VurjHZYN8wD32bE+US
         8z1nAqBjd6MTr7wOPaYjp43iesMvT/GBydc84nzDNMVtEO6eABiK8V5cJMvv9n1yeV
         GRzY2jbEke3gQZCZel946VdAcV8YYShGAvpqn9Y2c5AdGntTMeiQvh5MjWYxoFbAOF
         pzmZ7sSjSu8kojq89A+uDcS9XQVPmZJ8hizUHOpa3ayeo88+ZcYZ0CPQuyS1UUAAJh
         QQkoVCoArS1Qw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        vkoul@kernel.org, Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v9 00/11] sm8550: Add PCIe HC and PHY support
Date:   Wed, 15 Mar 2023 16:34:39 -0700
Message-Id: <167892332564.4030021.6913004577416128878.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230208180020.2761766-1-abel.vesa@linaro.org>
References: <20230208180020.2761766-1-abel.vesa@linaro.org>
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

On Wed, 8 Feb 2023 20:00:09 +0200, Abel Vesa wrote:
> For changelogs please look at each patch individually.
> 
> Abel Vesa (11):
>   dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
>   phy: qcom-qmp: pcs: Add v6 register offsets
>   phy: qcom-qmp: pcs: Add v6.20 register offsets
>   phy: qcom-qmp: pcs-pcie: Add v6 register offsets
>   phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
>   phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
>   phy: qcom-qmp: qserdes-lane-shared: Add v6 register offsets
>   phy: qcom-qmp-pcie: Add support for SM8550 g3x2 and g4x2 PCIEs
>   dt-bindings: PCI: qcom: Add SM8550 compatible
>   PCI: qcom: Add SM8550 PCIe support
>   arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes
> 
> [...]

Applied, thanks!

[11/11] arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes
        commit: 32734bbd1802efbd60ea4f0c3c1d5500bd0b20fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
