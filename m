Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47788FC0BE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 08:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfKNH3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 02:29:51 -0500
Received: from verein.lst.de ([213.95.11.211]:37959 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfKNH3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 02:29:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE71E68AFE; Thu, 14 Nov 2019 08:29:47 +0100 (CET)
Date:   Thu, 14 Nov 2019 08:29:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>, rubini@gnudd.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/PCI: sta2x11: use default DMA address
 translation
Message-ID: <20191114072947.GA26546@lst.de>
References: <20191107150646.13485-1-nsaenzjulienne@suse.de> <20191107150646.13485-3-nsaenzjulienne@suse.de> <20191113185420.GC1647@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113185420.GC1647@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 07:54:20PM +0100, Borislav Petkov wrote:
> Ok, I have only 2/2 in my mbox so in the future, when sending a whole
> set, make sure you Cc everybody on all the patches so that people can
> see the whole thing.
> 
> Then, I went and read back all the discussion about this cleanup and
> how it is hard to test it because it is not in PCs but in automotive
> installations...
> 
> Long story, short, I like patches with negative diffstats :) so I could
> take it through tip unless Christoph has different plans for this.

I've already queued this up in the dma-mapping tree.
