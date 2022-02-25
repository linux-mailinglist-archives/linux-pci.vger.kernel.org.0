Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9A4C4DB9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 19:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiBYS2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 13:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiBYS2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 13:28:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929946648
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 10:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tjFFM5OIW5FP9udIkyxf9q8tF4zXDKVYt9jSTVSrx28=; b=KlsQlvGTHXJg50Xx+fdi+nBE3h
        a2N8z46CHeU5S5h4JFnYHtvRVYfeNOvo4SZcTjUZwcm5ANcSneLBoz9WJRWts+oqlTuQq2MaFACvH
        l8qBuWOdwC8DeI2xu5OhtG7eCA+AHKG9MtsPRnkRAG7539HvoRRLrBCSr8/+gLiyXezYNfoVNenZo
        9Rl9vuNeC17f16VjEB4AWU1W9fRbMH451cYqkpZBPNb35PgBSpsCZtdAisRS42XDuh/JzONKfxFIc
        1+f354qQqPGfea7kV8mKGVuOpy//h1xHbtKT2ZkZ3DKDc2QagyaTHTrteoT+4uwYZ6lR9fV+UhIKc
        d4oWRFhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNfJR-0061Q1-0F; Fri, 25 Feb 2022 18:27:29 +0000
Date:   Fri, 25 Feb 2022 18:27:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode PCIe 6.0 Slot Power Limit values
Message-ID: <YhkfkI0WFBiHBT0/@casper.infradead.org>
References: <20220225181209.12642-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225181209.12642-1-pali@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 07:12:09PM +0100, Pali Rohár wrote:
> When the Slot Power Limit Scale field equals 00b (1.0x) and Slot
> Power Limit Value exceeds EFh, the following alternative encodings
> are used:

Looks good to me.  Thanks!
