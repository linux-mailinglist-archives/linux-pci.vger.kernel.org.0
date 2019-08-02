Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9B7FB7D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfHBNsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 09:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbfHBNsD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 09:48:03 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB5A21726;
        Fri,  2 Aug 2019 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564753682;
        bh=4iyFp3nxxcgWx4F9Y7pzUkBtSH9YEP6qmfh9a+6HKW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7AjOhrbuHUU3S7qTwJIDv+cj/TPwsihgyZx5wZiqBX7l4XR9h/N3nJqB+Fwct/sK
         MbSg/HwLELKa+aWkKep5eWxtP9zRjTuYL3CF2WOSizGzhvtsE2BF6WCyA+VFNWT7NL
         024wiyagXsobyy76ci31cOpFiGXqo3MjvWaxuoig=
Date:   Fri, 2 Aug 2019 08:48:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PCI: Mark expected switch fall-through
Message-ID: <20190802134801.GK151852@google.com>
References: <20190802012248.GA22622@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802012248.GA22622@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 08:22:48PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: allmodconfig i386):
> 
> drivers/pci/hotplug/ibmphp_res.c: In function ‘update_bridge_ranges’:
> drivers/pci/hotplug/ibmphp_res.c:1943:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>        function = 0x8;
>        ~~~~~~~~~^~~~~
> drivers/pci/hotplug/ibmphp_res.c:1944:6: note: here
>       case PCI_HEADER_TYPE_MULTIBRIDGE:
>       ^~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied with Kees' reviewed-by to pci/misc for v5.4, thanks, Gustavo!

> ---
>  drivers/pci/hotplug/ibmphp_res.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
> index 5e8caf7a4452..1e1ba66cfd1e 100644
> --- a/drivers/pci/hotplug/ibmphp_res.c
> +++ b/drivers/pci/hotplug/ibmphp_res.c
> @@ -1941,6 +1941,7 @@ static int __init update_bridge_ranges(struct bus_node **bus)
>  						break;
>  					case PCI_HEADER_TYPE_BRIDGE:
>  						function = 0x8;
> +						/* Fall through */
>  					case PCI_HEADER_TYPE_MULTIBRIDGE:
>  						/* We assume here that only 1 bus behind the bridge
>  						   TO DO: add functionality for several:
> -- 
> 2.22.0
> 
