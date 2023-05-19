Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949970965A
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjESLVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESLVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 07:21:53 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFB13AD;
        Fri, 19 May 2023 04:21:51 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 62BB992009E; Fri, 19 May 2023 13:21:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5B8CC92009B;
        Fri, 19 May 2023 12:21:50 +0100 (BST)
Date:   Fri, 19 May 2023 12:21:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/PCI: Fix a sanity check in
 pirq_convert_irt_table()
In-Reply-To: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.21.2305190345331.50034@angie.orcam.me.uk>
References: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 6 May 2023, Christophe JAILLET wrote:

> We compare the size in bytes of a struct (and its ending flexible array)
> with the number of elements in a flexible array.

 Incorrect, see the inline documentation for the struct.

> This is wrong and "ir->size < ir->used" is likely to be always false.

 Hopefully, but we've seen all kinds of rubbish in PC BIOS data, and this 
data structure seems available for OEMs to program with a tool called BCP.  
Better safe than sorry.  Therefore, NAK.

  Maciej
