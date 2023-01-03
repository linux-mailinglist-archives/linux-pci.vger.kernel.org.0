Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B365C7D7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjACUGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 15:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjACUGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 15:06:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A8F12;
        Tue,  3 Jan 2023 12:06:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07ABAB810FB;
        Tue,  3 Jan 2023 20:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB4C433F1;
        Tue,  3 Jan 2023 20:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672776363;
        bh=9625wY2U5dr79783vx/w/dXrSwzOePF3VKlSe0vb1+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UJzutdaWMxWMmQxEjcqVzgUGfTFyXNPT2SVesZ5lD5asxoFddmE8BMwTToFZU1Di0
         gItd68C2GjW2QvMuYQ8justZU0eEtC4rIwVuZKZkRvinP6x7uLIXQgab45Cah79o9e
         4rD6BjcgkIB0eeDXISTJYhG/DYfDvhZom4daFuzNpzuTI5cAQmy1kSScX3iB+ghDwg
         0+LEn5Fz6lVccpPLBdicakJZ0P3IjIP5Neka9wUFJo0Qaqb8osj/xXqkgD5kY/rW+a
         f4ZjTO6lHZyal8xeYxq8VCKqkom5Ur2v8ljCNv4hQ2ZjlILaXA6e+s9WSzgLfhmzYU
         lnrT/33g4pmFQ==
Date:   Tue, 3 Jan 2023 14:06:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: adjust to recent removal of PCI_MSI_IRQ_DOMAIN
Message-ID: <20230103200601.GA1017153@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167240660288.752172.35470572785572794.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 30, 2022 at 02:23:38PM +0100, Lorenzo Pieralisi wrote:
> On Thu, 15 Dec 2022 11:34:52 +0100, Lukas Bulwahn wrote:
> > Commit a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN") removes the
> > config PCI_MSI_IRQ_DOMAIN and makes all previous references to that config
> > then refer to PCI_MSI instead.
> > 
> > Commit ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
> > adds the config PCIE_BT1, which following the previous default pattern
> > depends on the config PCI_MSI_IRQ_DOMAIN.
> > 
> > [...]
> 
> Applied to pci/dwc, thanks!
> 
> [1/1] PCI: dwc: adjust to recent removal of PCI_MSI_IRQ_DOMAIN
>       https://git.kernel.org/lpieralisi/pci/c/3c9686173220

Since both commits appeared in v6.2-rc1, I cherry-picked the fix to
for-linus so we can get it in v6.2.

Lorenzo, can you drop it from your pci/dwc branch so we don't end up
with a duplicate?

Bjorn
