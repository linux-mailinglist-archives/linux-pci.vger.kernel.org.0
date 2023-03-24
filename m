Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F16C80BE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 16:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjCXPKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCXPKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 11:10:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3CCA12;
        Fri, 24 Mar 2023 08:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4FF64CE262F;
        Fri, 24 Mar 2023 15:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67801C433D2;
        Fri, 24 Mar 2023 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679670603;
        bh=JjFUDtlSpyXkfaKckOHXsPeEPUuVG9X7e7z+NznlM0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhE1HO9VAEG5ndphxpS+ot6u+4optUI1Pkj+vr7etTp+Hjyh4f24XXCJ79GT9cmnG
         1ITWZzKZWi3Hq3QiNfkOEIb4y97YuTDX1vDX5608gKzOcaSis+WaRUCumJu4fzBhNC
         QuMwXabrtfGfZ/Q+eXeEhucI1z0u9U4LOOd3CEXJgLfySQE/xzHz4dfnBWepZ8cwIl
         ps4OZ441NGK3ATk6KILfDBeTkKVQM9kfbhfMKd+MoZbPTyFFGyQxKLISaCQrbAeeky
         oAtaIX1myABCyEvGij6bSv/yIp+53xS4Ewn6Ud7r9GQwo5SzXhj3BB6zVP8mYOrr+X
         Eo4u98sm73DGw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH v2] PCI: imx6: install the fault handler only if we are really running on a compatible device
Date:   Fri, 24 Mar 2023 16:09:55 +0100
Message-Id: <167967057940.21604.4343970035491906830.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <e1bcfc3078c82b53aa9b78077a89955abe4ea009.1678380991.git.hns@goldelico.com>
References: <e1bcfc3078c82b53aa9b78077a89955abe4ea009.1678380991.git.hns@goldelico.com>
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

On Thu, 09 Mar 2023 17:56:31 +0100, H. Nikolaus Schaller wrote:
> commit bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
> added a fault hook to this driver in the probe function. So it was only
> installed if needed.
> 
> commit bde4a5a00e76 ("PCI: imx6: Allow probe deferral by reset GPIO")
> moved it from probe to driver init which installs the hook unconditionally
> as soon as the driver is compiled into a kernel.
> 
> [...]

Applied to controller/dwc, thanks!

[1/1] PCI: imx6: install the fault handler only if we are really running on a compatible device
      https://git.kernel.org/pci/pci/c/5f5ac460dfe7

Thanks,
Lorenzo
