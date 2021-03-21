Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2C343357
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCUQJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 12:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhCUQJJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Mar 2021 12:09:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9239461928;
        Sun, 21 Mar 2021 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616342948;
        bh=nFxN/wkBgWOt8pEiGVpNyE5EFSgfFgjPGJ+nXUDgqbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbAk6A8SHCEV5SNBlWd8uiK/BcVfvXjcb+TLsmjnp2mUNR1jQ2NMqBCg5I32ac1fT
         EUtBC8r8z/QLwugCkaQGT7uZ5gVKiDdxd4MdsaaLyemPc45VHP6p8tAxeDVziKDWwV
         4fgB9TLwVj7Mh8Mr41ct6cqIFbaCF2yktTWwySyI340TELn6aNiyq4P8khJqwK4nJm
         r6PxTbl/7sJG7d/DeM1evwX1SOfToLpBdiBiFRCEglYBWMH2zK3ZMP/uP0L2vvuMOC
         2oC6o4ZFbFb8r49BsbmLZgjhjtQ8XvCZzgZS+4Owf75nXlbV0ZZOHMxdRMLfRLtASK
         tRLbhiChM/nFA==
Received: by pali.im (Postfix)
        id 3F6E4F97; Sun, 21 Mar 2021 17:09:05 +0100 (CET)
Date:   Sun, 21 Mar 2021 17:09:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Martin Mares <mj@ucw.cz>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] lspci: Don't report PCIe link downgrades for downstream
 ports
Message-ID: <20210321160905.gwmkkwhofdx657mp@pali>
References: <20210318170244.151240-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318170244.151240-1-helgaas@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 March 2021 12:02:44 Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> After b47b5bd408e1 ("lspci: Report if the PCIe link speed/width is full or
> downgraded"), we report "downgraded" or "ok" for PCIe links operating at
> lower speed or width than they're capable of:
> 
>   LnkCap: Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <16us
>   LnkSta: Speed 5GT/s (downgraded), Width x1 (ok)
> 
> Previously we did this for both ends of the link, but I don't think it's
> very useful for Downstream Ports (the upstream end of the link) because we
> claim the link is downgraded even if (1) there's no device on the other end
> or (2) the other device doesn't support anything faster/wider.

If there is no device under Root or Downstream port then PCIe Bridge
reports initial speed (2.5 GT/s) independently of the maximal speed. So
I agree that we should not report "downgraded" state in this case as the
link is not technically downgraded. For hotplugging PCIe Bridge it is
just waiting until some PCIe card is inserted back.


Different thing is when you have Gen2 PCIe Bridge which can operate at
5 GT/s but you connect only Gen1 PCIe card under it (which operates only
at 2.5 GT/s).

In this case Root or Downstream port of PCIe Bridge is running at lower
"downgraded" speed but card (on the upstream end of the link) is running
at maximal speed (not downgraded).

So in this case proposed patch does not report "downgraded" state
neither on Root/Downstream Bridge part nor on card part.

Is it correct? Should not lspci report in this case _somewhere_ that
link is downgraded and is not running at the full speed?

I can image even more complicated PCIe topology with two PCIe packet
switches and one WiFi card where information about "downgraded" state
with proposed change would not be reported too:

     CPU / Host
         |
         |
    Root 8 GT/s --> Upstream 8 GT/s
                          |
                          |
                          v
                  Downstream 5 GT/s --> Upstream 5 GT/s
                                               |
                                               |
                                               v
                                   Downstream 2.5 GT/s --> WiFi card 2.5 GT/s

If we do not report "downgraded" state in Downstream or Root part then
in this topology no node would be marked as "downgraded" even when Host
or Root Bridge is capable of 8 GT/s and WiFi card is slow and its
maximal speed is just 2.5 GT/s.

I'm not sure but I think it could be possible to create somehow very
complicated topology with more PCIe to PCI Bridges and PCI to PCIe
bridges where information about "downgraded" state is lost when lspci
would not report "downgraded" state for Downstream parts of the link.

> Drop the "downgraded" reporting for Downstream Ports.  If there is a device
> below, we'll still complain at that end if it supports a faster/wider link
> than is available.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  ls-caps.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/ls-caps.c b/ls-caps.c
> index db56556..dd17c6b 100644
> --- a/ls-caps.c
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
>  
>  static char *aspm_support(int code)
> @@ -837,11 +840,11 @@ static void cap_express_link(struct device *d, int where, int type)
>    w = get_conf_word(d, where + PCI_EXP_LNKSTA);
>    sta_speed = w & PCI_EXP_LNKSTA_SPEED;
>    sta_width = (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
> -  printf("\t\tLnkSta:\tSpeed %s (%s), Width x%d (%s)\n",
> +  printf("\t\tLnkSta:\tSpeed %s%s, Width x%d%s\n",
>  	link_speed(sta_speed),
> -	link_compare(sta_speed, cap_speed),
> +	link_compare(type, sta_speed, cap_speed),
>  	sta_width,
> -	link_compare(sta_width, cap_width));
> +	link_compare(type, sta_width, cap_width));
>    printf("\t\t\tTrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
>  	FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
>  	FLAG(w, PCI_EXP_LNKSTA_TRAIN),
> -- 
> 2.25.1
> 
