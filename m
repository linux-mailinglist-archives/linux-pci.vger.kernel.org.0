Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27717EE2F9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDO7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 09:59:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfKDO7l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 09:59:41 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A6B421D7F;
        Mon,  4 Nov 2019 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572879580;
        bh=oxFWubMhfxFNkqviug7uMpFZBcHZH5hqYH/tE3uXdbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T9froDd0v/uMpkUCI3pSB0ZHkdhR1M+T/5pJ7IImj3kG33oCdYJIYIYzzneRf/kMn
         +FdYNxJ8rgC4jvKmf8abUqKLPEhmo4sLQrd5tuS35RJSHMYv7HFweOEZHsrRHxuQa+
         eDWTAWUVqJiijItsoYV0cXou8PfKo3ia6C9/aAYg=
Date:   Mon, 4 Nov 2019 08:59:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
Message-ID: <20191104145939.GA93344@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QBN9BigNZfAp0_h6WFpm6oSgBo3tiiN3S87hXZWsN_DNba8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 07:49:55PM +0100, Carlo Pisani wrote:
> > It looks like you're using a v4.4-based kernel, which is 3 1/2 years
> > old.  In general people are not very interested in debugging kernels
> > that old.  It's better if you can reproduce the problem on a current
> > kernel, then backport the fix if you need it in an older kernel.
> 
> as specified in this topic (1), kernel >= v4.11 does not even boot on rb532.
> When tftpboot, the firmware says "out of range", and hangs.

I think the first step is to fix the problem that prevents current
kernels from booting.  It's not really practical to debug v4.4.

It sounds like the firmware fails to even load v4.11?  If that's the
case, it's probably not a problem with the kernel itself, since it
hasn't even started executing.  Possibly a kernel size problem?  Maybe
the v4.11 kernel is larger than v4.4, v4.9, etc?  Does v4.11 boot if
you strip out non-essential drivers?

> (1) http://www.downthebunker.com/reloaded/space/viewtopic.php?f=79&p=2755
