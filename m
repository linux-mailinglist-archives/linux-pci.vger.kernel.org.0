Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AB6E27E0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDNQBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjDNQBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8EB773
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E983648D8
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7F5C433D2;
        Fri, 14 Apr 2023 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681488048;
        bh=KhdMjjlRDgagvn1RcZRaswXrTbBVuoGj2+3TLTJOLq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cAkHwb6DB5j8bdH0n+DILUZbvDRZBj/XtcDh9hMciyhu+7LMp6m4VMaRRUCnHI+Eo
         SLGztZRV9EUTDHZUm8074WvJAraGKOagQTnAd/og1KaZgT/MbPPZci8gjjT9SLkln6
         YztVRW1zeRJLoD/HuU0870qijuZokOVc6fmPQmrAI1DTtf1e8uKx5lSRNViUbUvuUi
         PVYUnKpScto+2+de27Lorf4omKZL8qCJ93ga3KuW+FdJ9PSEhNizMwJq03f4HGFaT+
         SbDSVeEHA9lU4quPVCBm6gA96h2KM4HCppqVVdZ5WnRrJOVPDFKosvWK58P+K6zZrm
         u84vkUksUE3qA==
Date:   Fri, 14 Apr 2023 11:00:47 -0500
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
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Message-ID: <20230414160047.GA197214@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:44PM +0900, Damien Le Moal wrote:
> pci_epf_test_data_transfer() and pci_epf_test_dma_callback() are not
> handling DMA transfer completion correctly, leading to completion
> notifications to the RC side that are too early. This problem can be
> detected when the RC side is running an IOMMU with messages such as:
> 
> pci-endpoint-test 0000:0b:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x001c address=0xfff00000 flags=0x0000]

Indent quoted material two spaces.  This looks like the original
message was a single line.  I'd keep it that way in the commit log to
make it easier to grep rot.

> When running the pcitest.sh tests: the address used for a previous
> test transfer generates the above error while the next test transfer is
> running.
> 
> Fix this by testing the dma transfer status in
> pci_epf_test_dma_callback() and notifying the completion only when the
> transfer status is DMA_COMPLETE or DMA_ERROR. Furthermore, in
> pci_epf_test_data_transfer(), be paranoid and check again the transfer
> status and always call dmaengine_terminate_sync() before returning.

s/the dma transfer/the DMA transfer/
