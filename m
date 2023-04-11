Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242C86DD789
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDKKJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKKJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 06:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B152683;
        Tue, 11 Apr 2023 03:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B3A623A3;
        Tue, 11 Apr 2023 10:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C6C433D2;
        Tue, 11 Apr 2023 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681207772;
        bh=4+yoX4M6EFzK4evMqyoDWLXKtr6ZMcsAr2nKxy77RRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVtG3bBiJFmwy+QRf5IN70L8M62cQvKnEFB5DKIAsEmZprmKpJlhlwqPCEfTnwrBg
         DZvCkZWz6J1amjhEWP2rMTxkVIiKQM4xB6emPC/tKuqXQEMJALZ4PIZuy0VExHDIkp
         BMyaBTP14uFC6YV8ADQ5K5qz0szbJLCXbs1es2RFn0XnUMliGunnAHl2l5UP8ao4tu
         moTLCwshJ30L18CJVWZKK6WreiT373obdKtKtIIQ493ahOi/t0OYIj57tH8S3p7iyP
         RDkm9Of6j7d+JviVUGNtskh20vSRZ+B9djn7MxvFPqpXUmJ/eMzqdJLcjZ3eZko6Rs
         cwg4pzKK60FUw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     andersson@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/13] Add PCIe RC support to Qcom SDX55 SoC
Date:   Tue, 11 Apr 2023 12:09:24 +0200
Message-Id: <168120775114.17750.6718927163638250633.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 08 Mar 2023 13:54:11 +0530, Manivannan Sadhasivam wrote:
> This series adds PCIe RC support to the Qcom SDX55 SoC. The PCIe controller
> in SDX55 can act as both Root Complex and Endpoint but only one mode at a
> time i.e., the mode cannot be switched during runtime.
> 
> This series has been tested on Thundercomm T55 board having QCA6390 WLAN
> chipset connected to the PCIe controller. For powering up the WLAN chipset,
> an out-of-tree patch has been used since we do not have a proper driver in
> mainline to handle the power supplies.
> 
> [...]

Applied to controller/qcom, thanks!

[01/13] dt-bindings: PCI: qcom: Update maintainers entry
        https://git.kernel.org/pci/pci/c/2be28836b281
[02/13] dt-bindings: PCI: qcom: Add iommu-map properties
        https://git.kernel.org/pci/pci/c/3f5ec65040b1
[03/13] dt-bindings: PCI: qcom: Add SDX55 SoC
        https://git.kernel.org/pci/pci/c/e8ce1671127d
[04/13] dt-bindings: PCI: qcom-ep: Fix the unit address used in example
        https://git.kernel.org/pci/pci/c/f6e7fbbe5bca
[13/13] PCI: qcom: Add support for SDX55 SoC
        https://git.kernel.org/pci/pci/c/490789b12332

Thanks,
Lorenzo
