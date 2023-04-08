Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE16DB91B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 07:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDHFsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Apr 2023 01:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHFsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Apr 2023 01:48:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046C6580;
        Fri,  7 Apr 2023 22:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0jyxWvhRi8PsR9ZNOz5sQyf1hJj8kmeSWr0G1CjZyag=; b=hrtG831MRckNOfGuWmZUnF0T06
        j+/uMcvlA6pRytvBL3j020Iuv2WYOWdAYUfbcfWz7nUEz+mi3uzbkIRD1ADPK7Rjcx88/eB92b+zU
        uxQqwJBxlwZlhvIDBSSoR65epwn1mpKK/4/gxkid6QvWBVN9gVs8e9KPmY3IkTfqyvAl4XVdetwCc
        /6Ryv9Jlu9LxwgGJcAppeJ/ubv8X1RrUIgngyOP9kuBMYcFQxwREK6alwLh5HvLroNTQBavmAHVWv
        +kgwi0n+b7+6mSVNLmoVF9kosTirjAkoEK9cM6nt9iXTrs7J3mQZrl6JqwKiHUQzJnLrpx3ZrV6Tj
        aLoJJyXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pl1Qd-00Bn87-2S;
        Sat, 08 Apr 2023 05:47:59 +0000
Date:   Fri, 7 Apr 2023 22:47:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Convert SiFive drivers from SOC_FOO dependencies
 to ARCH_FOO
Message-ID: <ZDEAD5aWhvMxAj8F@infradead.org>
References: <20230406-undertake-stowing-50f45b90413a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406-undertake-stowing-50f45b90413a@spud>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 06, 2023 at 09:57:46PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> RISC-V's SOC_FOO symbols for micro-archs are going away, and being
> replaced with the more common ARCH_FOO pattern that is used by other
> archs (and by vendors with a history outside of RISC-V).

And this is still the wrong way around.  This ARCH_ madness must not
spread.  NAK.

