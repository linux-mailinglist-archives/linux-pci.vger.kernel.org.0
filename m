Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04948340BEC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCRReJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhCRRdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081EC06174A
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g9Fdqqrn2E7eJQyJmkmEHHk98x5Wf7OPugDcGnEMI4w=; b=s5sdxUYTWVZ1R/ElbpCE51YBVD
        xJLC79juLwHoEBVSPuVbMSFssi4gjN1ganZ8wzYpMLzuvCY3GknNX2Lf9GbTVMgKmUIPAiscJcI55
        M2YELDgC9qdQwYt2P6mjMoe+3g0tyVgACmkXgc2ZIK4Uwhy+Z3/cEnZwx49HD9qiKrcVMruu7bfV4
        Wt+aaAFyeQiZDfl6bKydpZ7wPQU7LkMopg+D5pk4hgqwq1roLXCp4Xw1D09uFAb+IutT7ajP6pqgC
        5kM60NKmKf/4l9d5HtEk7uk2tA1Gm1AnbyFC227Ym9TEfxsCEvFnsg89StdJ4JBYknUBiJfcOKau8
        4EIVXNlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwWT-003Hya-Ns; Thu, 18 Mar 2021 17:33:28 +0000
Date:   Thu, 18 Mar 2021 17:33:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Martin Mares <mj@ucw.cz>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] lspci: Don't report PCIe link downgrades for downstream
 ports
Message-ID: <20210318173325.GR3420@casper.infradead.org>
References: <20210318170244.151240-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318170244.151240-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 12:02:44PM -0500, Bjorn Helgaas wrote:
> Drop the "downgraded" reporting for Downstream Ports.  If there is a device
> below, we'll still complain at that end if it supports a faster/wider link
> than is available.

This makes sense, but I think we should still report if training has
gone horribly wrong.  Maybe something like this ...

> +++ b/ls-caps.c
> @@ -758,13 +758,16 @@ static char *link_speed(int speed)
>      }
>  }
>  
> -static char *link_compare(int sta, int cap)
> +static char *link_compare(int type, int sta, int cap)
>  {
> +  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_DOWNSTREAM) ||
> +      (type == PCI_EXP_TYPE_PCIE_BRIDGE))
> +    return "";
>    if (sta < cap)
> -    return "downgraded";
> +    return " (downgraded)";
>    if (sta > cap)
> -    return "strange";
> -  return "ok";
> +    return " (strange)";
> +  return " (ok)";
>  }

{
  if (sta > cap)
    return " (overdriven)";
  if (sta == cap)
    return "";
  if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
      ((type == PCI_EXP_TYPE_DOWNSTREAM) ||
      ((type == PCI_EXP_TYPE_PCIE_BRIDGE))
    return "";
  return " (downgraded)";
}

(i don't know if the PCIe spec has a better word than overdriven for this
situation, but i don't like "strange".  "invalid", maybe?)

The reason i say we should report it on the downstream port is that
we probably can't get to the config data on the upstream port/device,
so this may be our best chance to find out what's wrong.
