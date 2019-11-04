Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91948EE455
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfKDP6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 10:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDP6Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 10:58:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E8620869;
        Mon,  4 Nov 2019 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572883104;
        bh=65dL2XWYSAggQt+5nA0WasvgqhqiKw9RypmcX0SKzMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gRO2STCjtgjhtwkMe17wnUGRHmR0uvILwio/dO8HaQRAKg9p7DX8sRsgn6ipm7L5w
         3/lZ56cvhkJsujOBZRhx6bD2C13D8ptSWX/eCxSRz7oiwYL8OAMIWIK/77pe4kEmex
         U6QSGogqcU0q+cIEnv0Gfx7vBMhY/O3AIYdZRqRI=
Date:   Mon, 4 Nov 2019 09:58:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
Message-ID: <20191104155822.GA106911@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QBN9AzXHifP4=F1O1jjbGP0yNxBZeTPgPJvpcKFb9Z4f30KA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci (please keep the list copied so others can
contribute/benefit and it's searchable via list archives)]

On Mon, Nov 04, 2019 at 04:25:02PM +0100, Carlo Pisani wrote:
> > I think the first step is to fix the problem that prevents current
> > kernels from booting.  It's not really practical to debug v4.4.
> 
> does anyone have a modern kernel working for rb532?
> because I suspect Linux is in regressing regarding this point.

I have no idea what rb532 is or whether Linux is regressing on it.
Any platform that isn't tested occasionally does tend to regress over
time.

> > It sounds like the firmware fails to even load v4.11?  If that's the
> > case, it's probably not a problem with the kernel itself, since it
> > hasn't even started executing.  Possibly a kernel size problem?  Maybe
> > the v4.11 kernel is larger than v4.4, v4.9, etc?  Does v4.11 boot if
> > you strip out non-essential drivers?
> 
> I do not know, and I don't understand. The rb532 manual doesn't say a
> word regarding the maximal size of the kernel, which in our case is
> less than 8Mbyte

Is the v4.11 kernel image bigger than the v4.4 kernel that boots?

> We tried to strip extra functions out of the kernel v5.*, but no dice
> 
> hence, first we need to fix kernel 4.4 which boots and work, then we
> can try to understand what is wrong with kernel v5.*
> 
> our time is limited, and we have to complete a project rather than
> play with the kernel

Sorry, I should have been more clear.  I don't think it's practical
*for me* to debug something on v4.4.  It may well be practical for you
because you have different constraints than I do.

Bjorn
