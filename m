Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735FC66BAC7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjAPJpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAPJpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 04:45:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DCF14E82;
        Mon, 16 Jan 2023 01:45:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC6E8B80DC7;
        Mon, 16 Jan 2023 09:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45F6C433D2;
        Mon, 16 Jan 2023 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673862319;
        bh=IErqy72fWGEyGg5hdpkN3ppofTEo7PnQJT5cOsOKvm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHgKyPKYIgqEMoIVatH9p/4iERtqC93oeW8sprIPuwYQVJnvGkxk5QvDe3MDB2SbM
         tc7FhG0YzDz+kRpja1HDPyWPTJrGnstMoyp3Mp9WpAJQqlTplptPiuJZQt5FuglG17
         X1Wi+DxUdHIIZRjjek9cs4wkp29aNvaYgZsNYUKUjLmhTpWW2QVZX7WlvRUowVUcRN
         jHROf4lsxiAkWEwcp5ph5yWOEny2StO9Eu5dMzSUuQSd6g4Fqb/lrt88dXsyrGh1Yo
         hI4ufx69zc6BUtA2990xizH0UgWYqB/hv8rhplvr4ZqXfMn4psg16TVe9aG7T3UGg/
         4rO/YHNEX/3sw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     bhelgaas@google.com, kw@linux.com, robh+dt@kernel.org,
        shawnguo@kernel.org, frank.li@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        l.stach@pengutronix.de, kishon@ti.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: (subset) [PATCH v5 0/14] Add i.MX PCIe EP mode support
Date:   Mon, 16 Jan 2023 10:45:10 +0100
Message-Id: <167386225326.10305.6865038680474291144.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
References: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
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

On Mon, 16 Jan 2023 13:41:10 +0800, Richard Zhu wrote:
> i.MX PCIe controller is one dual mode PCIe controller, and can work either
> as RC or EP.
> 
> This series add the i.MX PCIe EP mode support. And had been verified on
> i.MX8MQ EVK, i.MX8MM EVK and i.MX8MP EVK boards.
> 
> In the verification, one EVK board used as RC, the other one used as EP.
> Use the cross TX/RX differential cable connect the two PCIe ports of these
> two EVK boards.
> 
> [...]

dts changes should go via the platform tree.

Applied to pci/imx6, thanks!

[01/14] dt-bindings: imx6q-pcie: Add i.MX8MM PCIe EP mode compatible string
        https://git.kernel.org/lpieralisi/pci/c/1af5ea1dc2df
[02/14] dt-bindings: imx6q-pcie: Add i.MX8MQ PCIe EP mode compatible string
        https://git.kernel.org/lpieralisi/pci/c/dea44b629ae1
[03/14] dt-bindings: imx6q-pcie: Add i.MX8MP PCIe EP mode compatible string
        https://git.kernel.org/lpieralisi/pci/c/2dd6dc57d2da
[10/14] misc: pci_endpoint_test: Add i.MX8 PCIe EP device support
        https://git.kernel.org/lpieralisi/pci/c/01ea5ede4197
[11/14] PCI: imx6: Add i.MX PCIe EP mode support
        https://git.kernel.org/lpieralisi/pci/c/75c2f26da03f
[12/14] PCI: imx6: Add i.MX8MQ PCIe EP support
        https://git.kernel.org/lpieralisi/pci/c/530ba41250b6
[13/14] PCI: imx6: Add i.MX8MM PCIe EP support
        https://git.kernel.org/lpieralisi/pci/c/fb3217e2cfc6
[14/14] PCI: imx6: Add i.MX8MP PCIe EP support
        https://git.kernel.org/lpieralisi/pci/c/c435669a41dd

Thanks,
Lorenzo
