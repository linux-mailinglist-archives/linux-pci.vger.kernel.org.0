Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98555402BD0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhIGPbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 11:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345158AbhIGPbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 11:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9E9B610D0;
        Tue,  7 Sep 2021 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631028619;
        bh=kp8Q8kJRz0WoYnZlxjaDlmj4GyxqVupLYpX0r3kh5eI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FE6OgWm/fxpyj4FLQwu9LoQuMjKnA94XCfxVDByukq4rictBgJBARDgnsuKZZf51p
         WXTFndXhgPK25xj8rW4dWKHHBd93KkRJMISbXYQeHJ0AMHoyWkddZYiARPkgRcGwBJ
         AT6niJGOnCXNPNvY3lbnqpZz36S29V/LYwGZE4/xaCHHf6512nYdVpZOaJSLMuZUoR
         sM+3SiKS+cOzVNn/u7KymTC8iwDRxTh24dDklEeX8z7qtgA+ZJj3kLfOVv0bv4A6b7
         7vbe+oIWcT0eDqgNzqf+WJuR4rDw+5kM7nUIpdutwsL0sFBHvcbEN7fiD4Vb+EWH86
         LY7D7/lwqLanA==
Date:   Tue, 7 Sep 2021 10:30:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 10/12] xen-pcifront: this module is PV-only
Message-ID: <20210907153017.GA741607@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbfb4191-9e34-53da-f179-4549b10dcfb3@suse.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update subject to follow conventions (use "git log --oneline
drivers/pci/Kconfig").  Should say what this patch does.

Commit log below should also say what this patch does.  Currently it's
part of the rationale for the change, but doesn't say what the patch
does.

On Tue, Sep 07, 2021 at 02:10:41PM +0200, Jan Beulich wrote:
> It's module init function does a xen_pv_domain() check first thing.
> Hence there's no point building it in non-PV configurations.

s/It's/<name of function that calls xen_pv_domain()/   # pcifront_init()?
s/building it/building <name of module>/               # xen-pcifront.o?

I see that CONFIG_XEN_PV is only mentioned in arch/x86, so
CONFIG_XEN_PV=y cannot be set on other arches.  Is the current
"depends on X86" just a reflection of that, or is it because of some
other x86 dependency in the code?

The connection between xen_pv_domain() and CONFIG_XEN_PV is not
completely obvious.

If you only build xen-pcifront.o when CONFIG_XEN_PV=y, and
xen_pv_domain() is true if and only if CONFIG_XEN_PV=y, why bother
calling xen_pv_domain() at all?

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -110,7 +110,7 @@ config PCI_PF_STUB
>  
>  config XEN_PCIDEV_FRONTEND
>  	tristate "Xen PCI Frontend"
> -	depends on X86 && XEN
> +	depends on XEN_PV
>  	select PCI_XEN
>  	select XEN_XENBUS_FRONTEND
>  	default y
> 
