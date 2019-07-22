Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA81A6F742
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2019 04:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfGVCnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Jul 2019 22:43:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51782 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfGVCnS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Jul 2019 22:43:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so33596853wma.1;
        Sun, 21 Jul 2019 19:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCIw0Vy9KSLKWPzknfpX/7qQ/M+ZYVeRzfb1AdszhK8=;
        b=Xp2/lYdri2nLJDOlJfb211oI7elKKCL7sv3olg1Vg53EBJdF8zXcHEjoMwEYKORhJ9
         G9c8gBRAJkUBPoVtHDNKhod7PSDLP7q1j/bhEKpcIyM/Ll9TMeag8Uca/4SaXABE2358
         4TCbeHhOFh6ClxCvpR2MKU0ecVGRHIqEKkMB3Wq/GD/B6+uwE/DWDyRWN6ccHegZXz+j
         /NcCtOj5uhCQyQ5e5tLRkBW1eMw+/BNrQ/JIDwdf3PdPOpOGYD4NU0piXolynZn/pF46
         tYRysmQ6XKiEUN7JE/jCBX3vXMutKXEPrp8EGG2Pq8Yd32/uHs2DGGOoOqo7qwiqWbiR
         3kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCIw0Vy9KSLKWPzknfpX/7qQ/M+ZYVeRzfb1AdszhK8=;
        b=LSGhigIyXipIuYDNywnqN9g5zFkC5/UxZKEYwQ7KRIzq3SSic7gw6ntr5wqQXYtabD
         pMvnjHvLSuNXHgyi+m0AVglPglLDC2Z6Xj0g7IlSprbSLewfc4oueW7HuAurcTBofyFm
         HiPpRsJzun/r+yocr9kWSyJVQwJVUWwGNk6zhZqyy4lodpsDNlnWNqu+2g4JtVBdMb8c
         2JqSdexdYSUiHiE79kSGtQbWpkT+5bPfy/rXkcnoI/K6KqF2dFWwBCWbh/vXLu9NAWqL
         ZLVb3sBL+YEKR0uGyCyWxJ4tOWlVhbMBRRGG2eZKk39vT/kE7O4bcB7vlH+qZAEszspR
         FsUw==
X-Gm-Message-State: APjAAAV77oQchC69gIehnTQXO1lWOKWxEqpJPQ7MrbdQslmxg7GJsoIM
        3cM9NrFHSDmfYL5509BOnqs=
X-Google-Smtp-Source: APXvYqwLGEAu9/+LcJntGKJF6CScFDMheye52JHREJd6cZFZp7tdNkOE+88+DP4iTwTXAkSiLobYuA==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr30063516wmh.141.1563763395957;
        Sun, 21 Jul 2019 19:43:15 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id 91sm80347851wrp.3.2019.07.21.19.43.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 19:43:15 -0700 (PDT)
Date:   Sun, 21 Jul 2019 19:43:13 -0700
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
Message-ID: <20190722024313.GB55142@archlinux-threadripper>
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

Hi all,

Could someone please pick this up?

Thanks,
Nathan
