Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC85F2C87
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJCI4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJCI4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 04:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796A5C9D3;
        Mon,  3 Oct 2022 01:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A2760FC0;
        Mon,  3 Oct 2022 08:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09C1C433C1;
        Mon,  3 Oct 2022 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664786441;
        bh=/72HYQ4Xpa9TtMOw5Y3/gFdD6e6O+zWTVjPUxsv/VDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSBCBJV0kXy7Eybc6K+Somp7rSCqtIwWajAA1Gk58OqOZs4O2Lu05azHglbkMkkH2
         cg9mnVOfX5BKdJIK5s/BKTfJ5Vaj3VI9phnOreC62iLOylPjLQNYOT04ycl4ZkzMGC
         y3Gx712/ErjIoLXQeNDISliyS9Ke9cVwcANhDoGpWSGKIUQMZSiKwD+7Ugg83CRArs
         O371WfEoc9DRyY85yOMVG8VZGaAy6hRf47PXlj6UblX4wMO4crcCJMf90wKwqUYa5J
         UvUyjuj1YN6uGB8lpPHT8Sk/pcICrg++zAOFksP1VwtVZMJblJzA2lGqtS9yCgJWWr
         WwEpRhv28kBww==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     robh@kernel.org, andersson@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 00/12] Improvements to the Qcom PCIe Endpoint driver
Date:   Mon,  3 Oct 2022 10:40:33 +0200
Message-Id: <166478640812.604066.7033054100784388835.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
References: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
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

On Wed, 14 Sep 2022 13:23:38 +0530, Manivannan Sadhasivam wrote:
> This series contains improvements to the Qualcomm PCIe Endpoint controller
> driver. The major improvements are the addition of SM8450 SoC support and
> debugfs interface for exposing link transition counts.
> 
> This series has been tested on SM8450 based dev board.
> 
> NOTE: Since the bindings are ACKed, the whole series could be merged to the
> PCI tree.
> 
> [...]

Applied to pci/qcom, thanks!

[01/12] PCI: qcom-ep: Add kernel-doc for qcom_pcie_ep structure
        https://git.kernel.org/lpieralisi/pci/c/f1bfbd000f3b
[02/12] PCI: qcom-ep: Rely on the clocks supplied by devicetree
        https://git.kernel.org/lpieralisi/pci/c/e2efd31465b1
[03/12] PCI: qcom-ep: Make use of the cached dev pointer
        https://git.kernel.org/lpieralisi/pci/c/9cf4843e1acf
[04/12] PCI: qcom-ep: Disable IRQs during driver remove
        https://git.kernel.org/lpieralisi/pci/c/cf0adac4baee
[05/12] PCI: qcom-ep: Expose link transition counts via debugfs
        https://git.kernel.org/lpieralisi/pci/c/d48d1bd912a2
[06/12] PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS
        https://git.kernel.org/lpieralisi/pci/c/0d47c6b2c9ea
[07/12] PCI: qcom-ep: Disable Master AXI Clock when there is no PCIe traffic
        https://git.kernel.org/lpieralisi/pci/c/928decbb22c4
[08/12] dt-bindings: PCI: qcom-ep: Make PERST separation optional
        https://git.kernel.org/lpieralisi/pci/c/f5b366f4d1f2
[09/12] PCI: qcom-ep: Make PERST separation optional
        https://git.kernel.org/lpieralisi/pci/c/1085b53e3bad
[10/12] dt-bindings: PCI: qcom-ep: Define clocks per platform
        https://git.kernel.org/lpieralisi/pci/c/2c744cd7e7e5
[11/12] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
        https://git.kernel.org/lpieralisi/pci/c/0b0c3ff8de93
[12/12] PCI: qcom-ep: Add support for SM8450 SoC
        https://git.kernel.org/lpieralisi/pci/c/e5107be15bef

Thanks,
Lorenzo
