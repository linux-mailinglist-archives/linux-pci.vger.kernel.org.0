Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FDF786C4B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbjHXJvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjHXJvF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 05:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0DA10C7;
        Thu, 24 Aug 2023 02:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814C561216;
        Thu, 24 Aug 2023 09:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCD2C433C8;
        Thu, 24 Aug 2023 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692870662;
        bh=9Jx0lVj3qzfW3B1hjRBsqUAJlImDihTKFS0HifQopt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeXEpdTAHbEmxGE0OInYqS1CXwTCazHHuBXAwLxH3Gj7/wm9Hkz82gJNsLsOJaFvB
         DNsBUnNZ/0KRWGJ36+QwhQbKFhmSeAxp+GAVQridXrsUm+yZaEdTFcT/xWiK3esaI7
         OMVdjII1Bb+5MJp1fW2S+RBDMVpvjWu26y6RPH23A1wQ716FJYh7stL0WrerCBd6z9
         Yn3AezjFTXGkL6nkNnyHaOmXcVVDRDi6+x2U4P/owBr+5aLTVF6zqtmukrlTfZAwuD
         52/qL2E6REVseu0TqD38R4ZjQEuiXlRLryH+wZlfbtecerP5qbXS2E4xeG0TznlbEC
         vmQrAjomzX3Jw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     frank.li@nxp.com, Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        helgaas@kernel.org, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mani@kernel.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 0/3] dwc general suspend/resume functionality
Date:   Thu, 24 Aug 2023 11:50:54 +0200
Message-Id: <169287064160.65192.2353415497041867559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821184815.2167131-1-Frank.Li@nxp.com>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Aug 2023 14:48:12 -0400, Frank Li wrote:
> Change log
>  - Change from v11 to v12
>    Move exit_l2() to layerscape platform
> 
>  - Change from v10 to v11
>    Fixed two missed dev_err message change base on Mani's feedback
> 
> [...]

Applied to controller/dwc, thanks!

[1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
      https://git.kernel.org/pci/pci/c/e78bd50b4078
[2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
      https://git.kernel.org/pci/pci/c/4774faf854f5
[3/3] PCI: layerscape: Add power management support for ls1028a
      https://git.kernel.org/pci/pci/c/9fda4d09905d

Thanks,
Lorenzo
