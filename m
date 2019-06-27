Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6B58AE0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 21:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0TSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 15:18:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46438 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0TSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 15:18:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so8109281edr.13;
        Thu, 27 Jun 2019 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9/DvrSm1tuMxgh9gCPc5feOBQeRzRI5OCgy1Wf79Gk=;
        b=gecuNsfA+4DkKar9EsBNVwySmvxGtn5QjxCfGe0pL3C8P5PP1Xy2qhhhZDcoqqpsMt
         o6a5PIeN7eNQMIhzmvUeQoUvUM6ihzgxXWIq70u7fu9iVoHK0FzMDxAxRgwfjJ4Y/0Np
         eAncgvXBOQ0xmiVv1lecus3bfWyVdHk5VwzGFxCT2/GbeqlKb/P18E1rbb80hy5diF/H
         4YdJAru4bKV8H2mbVgheU4JQmdx7/dddyh73C9Mp5lr4a6BOUu8eCcrxqeIzo0SKJiFZ
         5sPJgJAVAr2Bwv73DAJQk97UYRN7q89boMhZV+hgUVehyd/t4CV8IjUq7W/y3RK4iS23
         l2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9/DvrSm1tuMxgh9gCPc5feOBQeRzRI5OCgy1Wf79Gk=;
        b=TP+oXsWK9wC0B3f6/oM6FMEKVdaf7abZmk6PpmmArXpRLFar6AygTpJfa2GlzqUZ8+
         am2lC4cQwvPp9OvFT/jpek6JwQ5UwKbPEi+BoyCwOsXvAHWo9CJWlmOHzvjVjN+DMLXf
         3K6xbQldBZi9gIsUR3nYIG7HBXY4mPPwqbHQDIW6Hc/fXK0RHWPnYcqqjWkfEkxz2fUK
         Ul4N+qpehdDaPo0BVjWgurzS7pExxQk3Oe3tR2ArDctMUNIv1gEX44B1Cad+Pq/EQkpT
         vxlxBA0iewrIHuAfYnyWUXg66rUNNYYyg/ocX+EJ4ClwrfMPUr+fK3GeqZrx5Jq43fdP
         VJsQ==
X-Gm-Message-State: APjAAAWkrxL/xlwj60944GO6mM6IlJ1MUYSybiMYMjLICpOBr22PiR7G
        cLj078D7b8Q9eigZMr4OZwHZ7ob2F4c87g==
X-Google-Smtp-Source: APXvYqzo3o22jNRP11IR4sgG0M1LkCQD4a9v4DkJtwgfurt3ukcs5ifOVNN2Vcr8awUGY9pHnFRL3A==
X-Received: by 2002:a50:a56d:: with SMTP id z42mr6430929edb.241.1561663119763;
        Thu, 27 Jun 2019 12:18:39 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id bs5sm575800ejb.10.2019.06.27.12.18.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 12:18:39 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:18:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Message-ID: <20190627191837.GA111331@archlinux-epyc>
References: <20190603174323.48251-1-natechancellor@gmail.com>
 <20190603221157.58502-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603221157.58502-1-natechancellor@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 03, 2019 at 03:11:58PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, clang warns:
> 
> drivers/pci/hotplug/rpaphp_core.c:243:14: warning: variable 'fndit' is
> used uninitialized whenever 'for' loop exits because its condition is
> false [-Wsometimes-uninitialized]
>         for (j = 0; j < entries; j++) {
>                     ^~~~~~~~~~~
> drivers/pci/hotplug/rpaphp_core.c:256:6: note: uninitialized use occurs
> here
>         if (fndit)
>             ^~~~~
> drivers/pci/hotplug/rpaphp_core.c:243:14: note: remove the condition if
> it is always true
>         for (j = 0; j < entries; j++) {
>                     ^~~~~~~~~~~
> drivers/pci/hotplug/rpaphp_core.c:233:14: note: initialize the variable
> 'fndit' to silence this warning
>         int j, fndit;
>                     ^
>                      = 0
> 
> fndit is only used to gate a sprintf call, which can be moved into the
> loop to simplify the code and eliminate the local variable, which will
> fix this warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/504
> Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Eliminate fndit altogether by shuffling the sprintf call into the for
>   loop and changing the if conditional, as suggested by Nick.
> 
>  drivers/pci/hotplug/rpaphp_core.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..c3899ee1db99 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	struct of_drc_info drc;
>  	const __be32 *value;
>  	char cell_drc_name[MAX_DRC_NAME_LEN];
> -	int j, fndit;
> +	int j;
>  
>  	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>  	if (info == NULL)
> @@ -245,17 +245,13 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  
>  		/* Should now know end of current entry */
>  
> -		if (my_index > drc.last_drc_index)
> -			continue;
> -
> -		fndit = 1;
> -		break;
> +		/* Found it */
> +		if (my_index <= drc.last_drc_index) {
> +			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
> +				my_index);
> +			break;
> +		}
>  	}
> -	/* Found it */
> -
> -	if (fndit)
> -		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
> -			my_index);
>  
>  	if (((drc_name == NULL) ||
>  	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&
> -- 
> 2.22.0.rc3
> 

Gentle ping, can someone pick this up?

Cheers,
Nathan
