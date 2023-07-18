Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE347573E7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGRGQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 02:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjGRGQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 02:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED51986;
        Mon, 17 Jul 2023 23:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B1956146F;
        Tue, 18 Jul 2023 06:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD86C433C7;
        Tue, 18 Jul 2023 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689660936;
        bh=pIDYFv2ZkJ4bRQ7wTGYVbgGEKPWGKq3xt9sih1qj7QM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NpTtlamI7m1trWo+6u3KW79p3V9twD1Crf6/L9cvZGFm8JCRz6UUUZ/4v61wmGyBS
         cw0nCmLkRjZyea4e7+AZ70d+3LZ5g4VPS2NF/r31EFnCWCV1DekXqlTqYbIsivsPb8
         aoT5IDQavozjtDXfjXkdUlejoa1m81Kov+fLwCK0SmKalgacoczQp+XXWJcsLRb1TE
         26cFnTi4LiIP2lAIOi8q021LXKDC5mrN3SzH/rKwObP1KCGQg0vFXlrN/2LMBaUwg7
         Egerw7XB0SQLmyb//29uRlV4Z9FfewBYDrQvTREIK7MnqjS92cyMFo0hBFEJ86a3at
         gx0c5zrpULfuw==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
In-Reply-To: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
Subject: Re: (subset) [PATCH v2 0/6] arm64: qcom: sa8775p: add support for
 PCIe
Message-Id: <168966092968.340315.2461852657981161685.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 11:45:29 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 14 Jul 2023 10:38:32 +0530, Mrinmay Sarkar wrote:
> Update the relavent DT bindings for PCIe, add new config to the phy
> driver add pcie and phy nodes to the .dtsi file and enable then in
> board .dts file for the sa8775p-ride platform.
> 
> v1 -> v2:
> - correct indentationand sort compatible in qcom,pcie binding
> - correct clock name entry and sort compatible in pcie-phy binding
> - sort compatible and change commit message in qcom pcie driver
> - change offset name, added tx2 and rx2 offsets and sort compatible
>   in qmp pcie phy driver
> - correct ranges property, added MSI, dma-coherent, cpu-pcie property
>   removed iommus property moved pinctrl and gpio property to board dts
>   and correct the allignment in pcie dtsi nodes
> - added pinctrl and gpio property in board dts
> 
> [...]

Applied, thanks!

[2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
      commit: fd2d4e4c19864fdd400d961de899163323ab7fa9
[4/6] phy: qcom-qmp-pcie: add support for sa8775p
      commit: a05b6d5135ec3e65520ae0eaa1b24d4c6549424e

Best regards,
-- 
~Vinod


