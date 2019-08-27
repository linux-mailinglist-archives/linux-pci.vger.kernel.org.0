Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923AB9F6D4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfH0XZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0XZA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:25:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7308620856;
        Tue, 27 Aug 2019 23:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566948300;
        bh=hk7TGUZtvzdF0BPvIoD/1I2qm9Ai1d/Yj7zFwZFR2Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmaxEaqy+R/uHzH132+D9Aos5GevG/k0RwgfXJs69dQh7+rU03Yu1h01avhuXo+xa
         cGmWCjNX003PRHIHProDiAuCl/o5cRdIUg3Gjr9wBFUdwMvyQmfFuB5sphPaFeLaSx
         H0sEgyJo7J52GNX4bGtz7g+VLKBRnlLi0+Y/KMT0=
Date:   Tue, 27 Aug 2019 18:24:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Add missing SPDX license header.
Message-ID: <20190827232457.GI9987@google.com>
References: <20190819060624.17305-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819060624.17305-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 08:06:24AM +0200, Krzysztof Wilczynski wrote:
> Add the missing "SPDX-License-Identifier" license header to the
> arch/x86/pci/numachip.c.  Use GPL-2.0 identifier derived using
> the comment mentioning license from the top of the file.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  arch/x86/pci/numachip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
> index 2e565e65c893..b73157e834e0 100644
> --- a/arch/x86/pci/numachip.c
> +++ b/arch/x86/pci/numachip.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License.  See the file "COPYING" in the main directory of this archive

You can remove this license text at the same time as in 8cfab3cf63cf
("PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate").
