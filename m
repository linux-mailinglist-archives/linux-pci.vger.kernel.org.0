Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3874341F9D0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 06:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhJBEez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 00:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJBEey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 00:34:54 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE13C061775;
        Fri,  1 Oct 2021 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=4JZ3mZOgBHzk6nQXM49sVSof9RiCWY+oRRqCmLztV7c=; b=B8VFt1gKCr0laPhHKBw/a8qcFa
        FYoY2bPrjr2ia3s33zbZrbXC4pWjSB9xRgqYS4KC4UyRJOea7z9u9+0uQMXW6z2Nrp+C9TUk40YAc
        fzYhg1Wane037hxX0eW9aiOeQL9P0bgxw3hPeEC0rtip6Px531AIUkRNFrgWNTi1eYlF29thWnA+w
        jwg7FnHMeJgH6HfP9Hgr/VczlQSOx+T26eoIkBddOi5cxa/p2rGynujcboZlZQYhcNCLMLej1bxvp
        WuB/9c9TtJHM5ggATe/cMtc7u0N/hXRu+DpI38qK6Cw2yWZBoFrw68a5Eq0aKOqXNdadlWBu95fuZ
        ArG87Mkw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWWhv-001mSP-P3; Sat, 02 Oct 2021 04:33:07 +0000
Subject: Re: Recommended way to do kernel-development for static modules
To:     Ajay Garg <ajaygargnsit@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <CAHP4M8V6b-su=bpM-qMg5pnDKfvh-Ks_3bFfeK7p4hA2RqQw+Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a4471053-a4e3-42ac-6177-056bfe371c70@infradead.org>
Date:   Fri, 1 Oct 2021 21:33:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHP4M8V6b-su=bpM-qMg5pnDKfvh-Ks_3bFfeK7p4hA2RqQw+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/1/21 8:31 PM, Ajay Garg wrote:
> Hello All,
> 
> Let's say, I want to make a simple printk change to drivers/pci/bus.c,
> compile it, load it, test it.
> 
> Now, since bus.o is built as a result of CONFIG_PCI=y in
> drivers/pci/Makefile, so this module is statically built, and as a
> result doing a "make M=drivers/pci" does-not-pick-up-the-change /
> have-any-effect.
> 
> Doing a simple "make" takes too long, everytime for even a trivial change.
> 
> 
> So, what is the recommended way to do kernel-development for static modules?
> 
> 
> Will be grateful for pointers.

Just to build drivers/pci/bus.o, you do
$ make drivers/pci/bus.o

That will tell you if you have any build errors/warnings.

For run-time testing, AFAIK you don't have any choice but to
build a full kernel and boot it.

-- 
~Randy
