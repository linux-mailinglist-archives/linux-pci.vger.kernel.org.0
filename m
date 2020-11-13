Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81D22B2908
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKMXPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 18:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMXPt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 18:15:49 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10B622256;
        Fri, 13 Nov 2020 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605309349;
        bh=QLHbnrw7NAqe+KHTop1kfdlhe7KKlEh1r4VuRGbB64g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TqCIm5KKHDXvDY0NCaX3WIO68XNMdYgKcIMgbLmdn4sgW6zHTHzvnhzOjT2/IM8A+
         wU81kvi771eUW3tCcJyc6y9aeuyJCczALzjFrroh/4Mb5+JClpZxDCp2UAqD3EZC1K
         JHj5BvSlbq34lsKcV88ZO7doCjVoqb+SCBT7LqG4=
Date:   Fri, 13 Nov 2020 17:15:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Tom Rix <trix@redhat.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] PCI: ibmphp: Remove unneeded break
Message-ID: <20201113231547.GA1141260@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105150222.498674-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 09:02:22AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> A break is not needed if it is preceded by a return.
> 
> Based on Tom Rix's treewide patch; this instance extracted from Joe
> Perches' list.
> 
> Link: https://lore.kernel.org/r/20201017160928.12698-1-trix@redhat.com
> Link: https://lore.kernel.org/r/f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches
> .com
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Joe Perches <joe@perches.com>

Applied to pci/hotplug for v5.11.

> ---
>  drivers/pci/hotplug/ibmphp_pci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
> index e22d023f91d1..754c3f23282e 100644
> --- a/drivers/pci/hotplug/ibmphp_pci.c
> +++ b/drivers/pci/hotplug/ibmphp_pci.c
> @@ -294,7 +294,6 @@ int ibmphp_configure_card(struct pci_func *func, u8 slotno)
>  				default:
>  					err("MAJOR PROBLEM!!!!, header type not supported? %x\n", hdr_type);
>  					return -ENXIO;
> -					break;
>  			}	/* end of switch */
>  		}	/* end of valid device */
>  	}	/* end of for */
> @@ -1509,7 +1508,6 @@ static int unconfigure_boot_card(struct slot *slot_cur)
>  				default:
>  					err("MAJOR PROBLEM!!!! Cannot read device's header\n");
>  					return -1;
> -					break;
>  			}	/* end of switch */
>  		}	/* end of valid device */
>  	}	/* end of for */
> -- 
> 2.25.1
> 
