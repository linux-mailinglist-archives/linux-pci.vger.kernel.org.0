Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78A765979E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 12:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiL3L2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 06:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiL3L2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 06:28:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE371AD9B;
        Fri, 30 Dec 2022 03:28:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABE8AB81BCE;
        Fri, 30 Dec 2022 11:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE979C433EF;
        Fri, 30 Dec 2022 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672399682;
        bh=W7YVzAO2mDuYN8n742hVF6/sjZKRdGp2qmdWhfD7pHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=do70DYj28a0bbgOeoAasB5LC5Y+qLgYm10Rfby4djmnm96ENUiptyeyOqu2Qcn0sz
         TZllCbG+jXWc9eN/WAzUcpzxNmKj6RkJR2u1AgHv0XKHiukj4xWj6VGHEKYx7yfoy5
         2S9gfZy9YsMWJrMdZ/WRrLtwP1xyxe8+kKqKoh1ZMCppqXmzFe16GuGFhFG5osluXj
         793e4jpH8uO6PxqVo4581Bkd1aYAV1g0fMpMynxJQDr1yuKIcEXrUb2TWQo+cVnru0
         PEwg4uux/4m43h2l7nyKSWV5L46uCSO6ZdhsSoCSqiaWvqmh51740M0uy2DfAezfjr
         pZZREgw8zHN7w==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: (subset) [PATCH v4 0/8] PCI/phy: Add support for PCI on sm8350 platform
Date:   Fri, 30 Dec 2022 12:27:53 +0100
Message-Id: <167239965740.745771.6371707855803359101.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
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

On Sat, 19 Nov 2022 01:32:34 +0200, Dmitry Baryshkov wrote:
> SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.
> Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.
> 
> Note: the PCIe0 table is based on the lahaina-v2.1.dtsi file, so it
> might work incorrectly on earlier SoC revisions.
> 
> Dependencies:
> - phy/next (for PHY patches only)
> 
> [...]

Applied to pci/qcom, thanks!

[3/8] PCI: qcom: Add support for SM8350
      https://git.kernel.org/lpieralisi/pci/c/a39fb9fabdb7

Thanks,
Lorenzo
