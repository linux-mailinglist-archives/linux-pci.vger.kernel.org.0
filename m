Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29036CC9CB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjC1R5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjC1R5h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4BFF33
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 10:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7715F616D1
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 17:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5ECC433D2;
        Tue, 28 Mar 2023 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680026252;
        bh=N5vafoW1jBG0iAyrtZ3POKJ9Qf49xeXdwNTDMb7g1sc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qxovYh5u3AlK593sgHhY5Sk+BfAnwx9xMB+ox9sRSWwUnIWL8pH+Md1NitekAeP8j
         3qQ9gS6EoCOESAV45pUqyJc4tG1PZvuN7MqSHgQ4vAVSmtVyNE1QME2EE8qdXwMvT+
         4I3NX3q6URlAYv4HfIPB7TZanB3m4uQqTB9ZXGET41CFPf/zr3ntX1aItuRueMeRDc
         PvTTLGOU4Ukxe50KBPsWPE1tDDaoy3uhoMdpbREjcrANp/hEmsS1kQUvVXvgJFeuoq
         h/ahE5z0Siik0MNTyFBbOpmOP9e6sz49EQFOnI1P1ajB9gXoRu1DeZH7MV1Zx7ffq8
         vnetqxC1h6UAw==
Date:   Tue, 28 Mar 2023 12:57:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 00/16] PCI endpoint fixes and improvements
Message-ID: <20230328175731.GA2954411@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 25, 2023 at 04:02:10PM +0900, Damien Le Moal wrote:

>   PCI: endpoint: Automatically create a function specific attributes group
>   PCI: endpoint: Move pci_epf_type_add_cfs() code
>   PCI: epf-test: Fix DMA transfer completion initialization
>   PCI: epf-test: Fix DMA transfer completion detection
>   PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
>   PCI: epf-test: Simplify read/write/copy test functions
>   PCI: epf-test: Simply pci_epf_test_raise_irq()

"Simplify"

>   PCI: epf-test: Simplify IRQ test commands execution
>   PCI: epf-test: Improve handling of command and status registers
>   PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
>   PCI: epf-test: Simplify dma support checks

"DMA"
