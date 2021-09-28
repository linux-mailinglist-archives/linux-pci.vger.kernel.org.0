Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6941BB04
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 01:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbhI1XaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 19:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243273AbhI1XaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 19:30:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB70761368;
        Tue, 28 Sep 2021 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632871705;
        bh=Aj0F5LPnVcUuzJUSV8yvbiS/m7CuZnciB2S9wM6oAZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EUNbeeGpLdIaiqtvxWR9rGTEdh3mG9fPw/efsCNs7w80S50R4767T57C+aLN3Mo+1
         4wT96+eP+DIUZWGRX8so7Y+H7WxBL7eWBEopao1HLx+RsWJKS60k3z0em5vFg/keLP
         gbGjeQVZYyWmAeGo/PN+multiD+4dOdccby883Z9dKWOSjLg2JDagKIT+N7/Hb7UZO
         36Gr0e7gHa5dH4AMIPYRngDBEmYTJQUsao6QzTVLwz8jOi2TBYwqtOCQKmmefGjeWx
         8Zp9KvPUxpj8oootVAkj9KmlXqMeLAHlCO2BxdgPqpEJYH5Z4Jpy9LECU18T72q1tx
         zEz2mM68ooVKw==
Date:   Tue, 28 Sep 2021 18:28:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 0/7] PCI: ACPI: Get rid of struct pci_platform_pm_ops
 and clean up code
Message-ID: <20210928232823.GA748352@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ferry]

On Mon, Sep 20, 2021 at 08:52:19PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> As explained in the changelog of patch [2/7], using struct pci_platform_pm_ops
> for ACPI is not particularly beneficial, so it is better to get rid of it and
> call the functions pointed to by it directly from the PCI core.
> 
> However, struct pci_platform_pm_ops is also used by the Intel MID support code,
> but it is actually better to call the MID PM function directly from the PCI
> core either, which is done in patch [1/7].
> 
> After these changes, patch [3/7] removes struct pci_platform_pm_ops and the
> rest is just cleanups and some code consolidation on top of that.

I like these a lot.  Not sure exactly where everything is after the
conversation with Ferry.  Let me know if I should be doing anything.
