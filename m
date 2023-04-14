Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D46E2831
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNQRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNQRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 12:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B06D59C0
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 09:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8057648DE
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 16:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC7C433EF;
        Fri, 14 Apr 2023 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681489063;
        bh=9tpfPLC5YQZTNAONS1JXmhxJYozGPzvWjKty4Acduhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fSq9lvtAULc/qL/TzVLRJA0d08PNOEOgXsg/sLeLTZDBEFBvNz1ORNHYmm8MipoVn
         9GHTVgnoa40u4X4eDwKH4QaWt1wZqSkEKHcDr7muYR9nqrpAoIqq+XP5kmGbXwrFc6
         0EgzFTgqAS73tyForPSeEf89BXj+3IwbMh0GfS3S5WbnPzDuQT+ONkpisfbUopYWVM
         FNybyiXxBxZX9TZ9J1XRsRZ9WXnHbo/1WjnLuiElDSxUeQdKSf6XbsXc6AhCNZ8Yrl
         x0GmMTV5gQxD9fzgqwT7NU60jWKtdu6F74akO2yacxeJqfsM5Fx9unhUGRFYqntv6i
         F0UuShztn1Eqw==
Date:   Fri, 14 Apr 2023 11:17:41 -0500
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
Subject: Re: [PATCH v4 14/17] misc: pci_endpoint_test: Free IRQs before
 removing the device
Message-ID: <20230414161741.GA198661@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-15-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:54PM +0900, Damien Le Moal wrote:
> In pci_endpoint_test_remove(), freeing the IRQs after removing the
> device creates a small race window for IRQs to be received with the test
> device memory already released, causing the IRQ handler to access
> invalid memory, resulting in an oops.
> 
> Free the device IRQs before removing the device to avoid this issue.

Perfect!
