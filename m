Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6EE7EBD0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 07:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfHBFKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 01:10:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44558 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732470AbfHBFKj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2019 01:10:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so35344407pfe.11
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2019 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GbN+lyQRwWpMrjAi8gZfqiOdoS1ljZVdsyP197ujcJ8=;
        b=CaFMd9XDgrGq6GKFNCs7UtRYd500b5XGKxJVTb4lP31xTeB221PAKxwE5Rtw9+kf/F
         JqKSBJKeNQBFtXNo5hpTDJHZJ6+5pZXBwMVX1eDW6RT9gvRoFOlCq1ljkXAwZFN1Fap+
         yeAOjBs7P28616iB00784HbRgv2nAqloK9jBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GbN+lyQRwWpMrjAi8gZfqiOdoS1ljZVdsyP197ujcJ8=;
        b=U0UCZ02wTbrXymiH9arQR4AmJSLXpE97Xgqb7GHCLouIelO83Ng99GzcCq8Mwl/gxa
         v7B3mH02BiulE2ieSMAwSjXs9WR0q9ps8NI3BbHz/s4MqQjOJ2yKVWhEtv1xjvttWZ+u
         71gP4I/SB/Dam3fD7SMcLdi/c3KaRRW0OZWIx28tVJ1iV1gQoTWGvug9HUOID3Q2baDo
         ZTVsInyM9xH09oTSiM1KmMuIXhLEoz+eRBjZpzaap5blCYpHldxEj9zTs+jbVN2aSXPw
         FLD+fgr9QULPCQ9G1jgXveT3v6vlkqbtoSsPQYmjKTdkNrtL0a+z3kyf9PHg4zf/y9pt
         FBjQ==
X-Gm-Message-State: APjAAAV/6bJ+V2Ms6EhBweItMs8bpnhqAGc4xrmUDaFS4/FAWxudUBXp
        LXLb/IXPakLfuxK3WSbnto0WDA==
X-Google-Smtp-Source: APXvYqw6EY3sCwRr17Ar8Ens5WlgHGNu+SiJE6WNtnZfFauoEO0hqdBcN+DPrzLGoo3MwDmVHhsOBg==
X-Received: by 2002:a65:6281:: with SMTP id f1mr115552688pgv.400.1564722637707;
        Thu, 01 Aug 2019 22:10:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm64733311pfa.141.2019.08.01.22.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 22:10:36 -0700 (PDT)
Date:   Thu, 1 Aug 2019 22:10:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Mark expected switch fall-through
Message-ID: <201908012210.15191EAD5@keescook>
References: <20190802012248.GA22622@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802012248.GA22622@embeddedor>
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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

-- 
Kees Cook
