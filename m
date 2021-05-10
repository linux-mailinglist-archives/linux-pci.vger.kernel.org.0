Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A40379717
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEJSgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 14:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEJSgl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 14:36:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF75D61483;
        Mon, 10 May 2021 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620671736;
        bh=B9SXyeC+hysLQ0q10lFZazvUoImWnEYseqN99FaOPq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G+UO8N2jvQH03gPeXoaM3Qsqo1k+W0p0ZTu4enq4CfX60YFMGXMtYHhgg7ZedukxU
         JvLD4na+1Z7SrnUOZOQQgo9K3OYPOitN6v+gk7gt0ZBBRiEf9NM1TO5+QvAlLkqfH6
         MPr6rzTcZH7npPdpGjjXx9AJ9eQnNCLlGG6AYwAcmFLTmp7yEvfT4nO7mFAhhLJZzD
         RAGKmo50zoZuzd8OAGGPBTKkiwg5022DcP0gXvgMOSpF/4m0gb1ypyAzNTL9oWCCNs
         LZG9pRTFT7+00duB5kvlxLN9ltw4T7rEEBP46ueZW3zFRWgt/Th+i4egTjJGEus81R
         wqByp652Fdi0Q==
Date:   Mon, 10 May 2021 13:35:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pci: convert faraday,ftpci100 to yaml
Message-ID: <20210510183529.GA2289311@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbQvvcyrXP9fFwvppDRiJOxxESRVkodqSKc7CoO3Bm00Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 07, 2021 at 12:51:39PM +0200, Linus Walleij wrote:
> On Thu, May 6, 2021 at 10:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > I think it's nicer when content changes are in a separate patch from
> > format conversion patches.  Otherwise it's really hard to see the
> > content changes in the patch.
> >
> > Maybe a preliminary patch could fix whatever is actually broken?
> >
> > Rob suggested a bunch of things that could be dropped.  Maybe those
> > could be removed in a second preliminary patch before the conversion?
> > Or maybe the removals are only possible *because* of the conversion?
> > I'm not a yaml expert.
> 
> A bit of taste is involved. The old .txt bindings are for processing
> by human brain power. Those lack regular syntax and strictness
> because brains are designed for evolved natural languages.
> 
> The YAML on the other hand is a chomsky type-3 strict regular
> language and the .yaml file (and includes) defines this strict regular
> grammar and as such admits less mistakes. The upside is that
> it enforces some order.
> 
> In the process of moving to YAML we often discover a slew of
> mistakes and the initiative often comes with the ambition to add
> or modernize something.
> 
> In this case I wouldn't care with stepwise fixing because the
> platform is modernized by a handful of people who all know
> what is going on, so there is noone to confuse other than the
> subsystem maintainer and the result will end up in the same
> kernel release anyway.

Haha, I'm in that large majority of people who lack deep knowledge
of what's going on, so it definitely confuses me :)

I think the stepwise fix would be helpful in making the patches more
accessible to us non-experts, and I know it would save me time in
reviewing.

It may also be useful to people converting other bindings to YAML
because it's more obvious what mistakes need to be fixed in the
process.

Also helpful: changing the subject line to match the existing
convention, e.g.,

  dt-bindings: PCI: ftpci100: Convert faraday,ftpci100 to YAML

Bjorn
