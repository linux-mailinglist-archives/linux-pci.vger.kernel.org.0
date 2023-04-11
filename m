Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300A46DD6F8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDKJfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDKJfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 05:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3F44B5;
        Tue, 11 Apr 2023 02:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D9DF62354;
        Tue, 11 Apr 2023 09:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31E2C4339B;
        Tue, 11 Apr 2023 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681205669;
        bh=XiRL1XsjOgYxxmz+rJpn/mTqJrArcWXq2XQJOxr8tzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fgvbi951V+gZAC7GnkKC3fwbtNuibkxLU74LnmFv0R27BRYB93FAlU0zIKLqN2oiy
         cZG2545AXwJEJfLFCddbtGWvB2GVZaG7OPbkepSMmYMXDXGL04Nb7Z02hzb9niUZIv
         mqR16OxIcvsz8F6HeOpiHTPHzQhB9bj6qbJUP6Tp9wCu0K+TF0SinatKUxDpps624H
         2G8GhaSUmAaYqPxmN23Gooq69EeI/p0wvmfCOZTtkD7j72RT2d/AIryOcpiDy0aRUT
         iB8hVQkvKY9orRfdxCz747U3mTLRVisLsUxV+OPDuDKzWiV/Tf3P6EQl8j2NbRBYgv
         f/i9Tr3H25Y7Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     andersson@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: (subset) [PATCH v5 00/19] Qcom PCIe cleanups and improvements
Date:   Tue, 11 Apr 2023 11:34:23 +0200
Message-Id: <168120564704.14983.16177525029938219266.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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

On Thu, 16 Mar 2023 13:40:58 +0530, Manivannan Sadhasivam wrote:
> This series brings in several code cleanups and improvements to the
> Qualcomm PCIe controller drivers (RC and EP). The cleanup part mostly
> cleans up the bitfield definitions and transitions to bulk APIs for clocks,
> and resets. The improvement part adds the debugfs entries to track link
> transition counts in RC driver.
> 
> Testing
> -------
> 
> [...]

Applied to controller/qcom, thanks!

[01/19] PCI: qcom: Fix the incorrect register usage in v2.7.0 config
        https://git.kernel.org/pci/pci/c/2542e16c3925
[02/19] PCI: qcom: Remove PCIE20_ prefix from register definitions
        https://git.kernel.org/pci/pci/c/39171b33f652
[03/19] PCI: qcom: Sort and group registers and bitfield definitions
        https://git.kernel.org/pci/pci/c/769e49d87b15
[04/19] PCI: qcom: Use bitfield definitions for register fields
        https://git.kernel.org/pci/pci/c/57eddec8dc30
[05/19] PCI: qcom: Add missing macros for register fields
        https://git.kernel.org/pci/pci/c/17804668ca54
[06/19] PCI: qcom: Use lower case for hex
        https://git.kernel.org/pci/pci/c/94ebd232dbc8
[07/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
        https://git.kernel.org/pci/pci/c/383215dd2fd7
[08/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
        https://git.kernel.org/pci/pci/c/5d4ffe5ec5e9
[09/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
        https://git.kernel.org/pci/pci/c/5329bcc4a1e7
[10/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
        https://git.kernel.org/pci/pci/c/b699ed9b03de
[11/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
        https://git.kernel.org/pci/pci/c/157fecca3558
[12/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
        https://git.kernel.org/pci/pci/c/fb0eacb2972e
[13/19] PCI: qcom: Use macros for defining total no. of clocks & supplies
        https://git.kernel.org/pci/pci/c/656a08820e7b
[14/19] PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
        https://git.kernel.org/pci/pci/c/1f70939871b2
[15/19] dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
        https://git.kernel.org/pci/pci/c/0f80edf8447d
[19/19] PCI: qcom: Expose link transition counts via debugfs
        https://git.kernel.org/pci/pci/c/05f464640962

Thanks,
Lorenzo
