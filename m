Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47C0520DEF
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiEJGnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 02:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiEJGna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 02:43:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BA21935A
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 23:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IXtMUjjy/yDrUHHOkYL3yQuCrqMPgU/ofvpGQfIZ2qg=; b=wXs7t8zmncZSHWFsgV9E+t1mm/
        XJ0rWpe5BkRbtU9Iokm/bvCZSZm3SLmam72lmpzkbOhkfp7ZY75ii0VljW+AM1rXGCcDomw0hDcfX
        yZCGaBcadyWWFX6tPZ/cpwhJ8asnN6L/RUzpkO724rIsiIo06Qw7TLqH/jy3wzmWTuICUUM2nUxbg
        RWQAjbz2a8XJ4XmeXZSm/5gjhZB5DFYQReAyv2BtxW6i0NOgFAN9U9XNElB08cRT2fAYa6QCrpxAI
        TgZnL9hQpTe+CaAgGVkGtyZS0L8fIc97RCImF/khhSaLojEGjV5f7cHcOPFRJTdbcVmraWo8szvbg
        bTvn7qGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noJWs-000BcQ-7c; Tue, 10 May 2022 06:39:30 +0000
Date:   Mon, 9 May 2022 23:39:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <YnoIossyu7KQ8xmC@infradead.org>
References: <87ee14l1tx.fsf@epam.com>
 <20220509164929.GA602900@bhelgaas>
 <20220509105857.6399cc22.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509105857.6399cc22.alex.williamson@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 10:58:57AM -0600, Alex Williamson wrote:
> is_physfn = 0, is_virtfn = 0: A non-SR-IOV function
> is_physfn = 1, is_virtfn = 0: An SR-IOV PF
> is_physfn = 0, is_virtfn = 1: An SR-IOV VF
> 
> As implemented with bit fields this is 2 bits, which is more space
> efficient than an enum.  Thanks,

A two-bit bitfield with explicit constants for the values would probably
still much eaiser to understand.

And there is some code that seems to intepret is_physfn a bit odd, e.g.:

arch/powerpc/kernel/eeh_sysfs.c:        np = pci_device_to_OF_node(pdev->is_physfn ? pdev : pdev->physfn);
arch/powerpc/kernel/eeh_sysfs.c:        np = pci_device_to_OF_node(pdev->is_physfn ? pdev : pdev->physfn);

