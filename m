Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4A77471C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjHHTJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjHHTJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641C92FA2B
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CEE9623E4
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 07:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8C8C433C7;
        Tue,  8 Aug 2023 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691478250;
        bh=0kLVYnJCAHrNEd6IC9dxsFc15LPqkFS44LyZ4cxCS0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSB88tEpNsZbn8gqOxe9W3CgFZtxdkO2enG9vqfG8/RIDgsnU89A4kvtQcacVfVc0
         tOGu8C+c4LLIPhl102KCUrO8ZPPMHu0LVsSlnnQL1k77WEtgHs/+KaS2pxnIPUA5Kh
         VT0Q+ExeMeFPCQkqyXo1eY1SXLaiGzjizUOTAvqDUq9aiHKWrfTIpe1UNWl+Y+nuTf
         aeUzieb0/N8tQnxm+bf75KnkwJFzubDXCEIauOwxpLYuWyxGKuZjSQJsJcbUKpEUYi
         Xc8QqEXVoNnLc72odVBQPq9T/l4Gx+OPc/2nNKIATSql2dih6AtHdUkms8jUGJUUy3
         1I0VuKNoWdZUg==
Date:   Tue, 8 Aug 2023 12:33:57 +0530
From:   mani <mani@kernel.org>
To:     Li Chen <me@linux.beauty>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] add __iomem cookie for EPF BAR
Message-ID: <20230808070357.GC4990@thinkpad>
References: <189cff865f3.fc7e71c96186.1411633612292556520@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <189cff865f3.fc7e71c96186.1411633612292556520@linux.beauty>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 07, 2023 at 08:28:30PM +0800, Li Chen wrote:
> Hi All
> 
> Currently, the EPF's bar is allocated by pci_epf_alloc_space, which internally uses dma_alloc_coherent and the caching behavior of dma_alloc_coherent may vary depending on platforms.
> 
> The bar space is exported to RC, which means that RC may modify it without EP being aware of it, so EP still read from the cache and get stalled data. To address this issue, the bar space should be treated as iomem instead and forced to use io read/write APIs, which enforces volatile. 
> 

We already had a similar discussion on using volatile for BAR space and settled
with {WRITE/READ}_ONCE macros in EPF Test driver [1].

Since the BAR space allocated in endpoint is not a MMIO, I don't think it should
be forced as iomem. Rather EPF drivers should use _ONCE macros to access the
fields to avoid coherency issues as suggested by Arnd earlier.

- Mani

[1] https://lore.kernel.org/linux-pci/c49df2f9-9848-45aa-9d64-9e4e9841440f@app.fastmail.com/

> If you agree, I would create patches for existing EPF and EPF/EPC core and submit them for review.
> 
> Regards,
> Li

-- 
மணிவண்ணன் சதாசிவம்
