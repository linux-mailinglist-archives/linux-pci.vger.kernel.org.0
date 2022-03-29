Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0F4EB33A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 20:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiC2SUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbiC2SUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 14:20:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96B4BFC4;
        Tue, 29 Mar 2022 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dwPiklxwIDd6Hnn9pYPT3IhHBR6iBdcAZBRuxb27yzs=; b=TPqUvAFf71ZhaeEBn5OpCgcIem
        sA1o2L4aprQjailc0yBgY1kr/dY3bHoKZASd9DOOciaUINCjlwUDa9WDWs95tVKKRdd0uu1/J3Buj
        YeUdR9RusMrd4OdKZS4nFri6O7DBX5sKJKEXv+ialVYM+WZFqdxkvqoDFFah/hNQJFcMlsdDwEo7H
        qCQiu5Mq39gZVl7irc5C5rPydQsqQXVbRoSXXT8sEkjh4LIyW5jQPzUhWC3nL/J9Lh/Wzi73mFDHE
        d9Dk6xZZtqp7purBmqWI+6VGGw9h/FFicfhcytMHn4PZepd3F5LdYZOyBjMJxQyBcZ/br6jHNZRpm
        l2HE8E/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZGPr-00DDx7-Un; Tue, 29 Mar 2022 18:18:03 +0000
Date:   Tue, 29 Mar 2022 11:18:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
        akpm@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
Message-ID: <YkNNWy649S9i6Vbd@infradead.org>
References: <20220310170445.GA163749@bhelgaas>
 <20220310173022.GA166412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310173022.GA166412@bhelgaas>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 10, 2022 at 11:30:22AM -0600, Bjorn Helgaas wrote:
> Christoph mentioned several other trees that this depends on, and
> those would likely be in linux-next, but not yet in Linus' tree.  The
> above poking around is from the tip of Linus' tree, which was the
> wrong place for me to look.
> 
> But I did the same in current linux-next, 71941773e143 ("Add
> linux-next specific files for 20220310"), and still found quite a few
> uses.  Some are in comments, printks, coccinelle scripts, etc.  I
> would assume we'd want to remove them all?

I'm not sure there is much of a point to clean up the historic
comments, but it would be a nice cleanup.  I'd very much like to
queue up this patch now that all the actual symbol references
are gone now.  Are you ok with that?
