Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3E6598AA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiL3NXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiL3NXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 08:23:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF81D1AD9C;
        Fri, 30 Dec 2022 05:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4878061172;
        Fri, 30 Dec 2022 13:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFC8C433D2;
        Fri, 30 Dec 2022 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672406624;
        bh=NqmqGbk5hNMzGGcEm4dJNpuxoV4wFsE7sNHS+ETbSqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jO61gvfKtXf+0r3Va55qQpluFxWwsQ/h/hi6h5D31HrsyUkm0FRcX9BU4gKmfaThg
         cl7n+oAnzEWMq+3pW6lOlIL+1Id1yJstOrpABJYr6U/032CQJaLwnVbGLsr1iTi+8Q
         I7x/gcmobqcsIYB8M3zXttLV+vnn5CXdRP5mJhThKunawto9a0j7l5VWFZEmRu9caY
         QUL8qPVq9d8drPJxWL2VkEZZsH/gIHkNMf2jLAz2sTfFplu4jlVz3w/acrSAHvYZwr
         oplcFo7WdZagkGFrxLdRyPKwNkRGb/2CwBzd6jcmVMvLt97PLeKbLOXkQS1p0TOd0v
         DTBQRgzstEk8A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: adjust to recent removal of PCI_MSI_IRQ_DOMAIN
Date:   Fri, 30 Dec 2022 14:23:38 +0100
Message-Id: <167240660288.752172.35470572785572794.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215103452.23131-1-lukas.bulwahn@gmail.com>
References: <20221215103452.23131-1-lukas.bulwahn@gmail.com>
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

On Thu, 15 Dec 2022 11:34:52 +0100, Lukas Bulwahn wrote:
> Commit a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN") removes the
> config PCI_MSI_IRQ_DOMAIN and makes all previous references to that config
> then refer to PCI_MSI instead.
> 
> Commit ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
> adds the config PCIE_BT1, which following the previous default pattern
> depends on the config PCI_MSI_IRQ_DOMAIN.
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: adjust to recent removal of PCI_MSI_IRQ_DOMAIN
      https://git.kernel.org/lpieralisi/pci/c/3c9686173220

Thanks,
Lorenzo
