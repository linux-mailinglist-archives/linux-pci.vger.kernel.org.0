Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9244F66C
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 05:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhKNE1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 23:27:15 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36802 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKNE1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Nov 2021 23:27:14 -0500
Received: by mail-ed1-f52.google.com with SMTP id o8so55351901edc.3;
        Sat, 13 Nov 2021 20:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7rlmuPdMhnVMN0EKqqXPhzO5LaYq5KpGdQ9/F9AAtXk=;
        b=rWIIQI0vG/Y+cmgaabdAov5JxhBqJGPQhIbzpqzvRznRiyqTm0em7vQA2NMSRapWNw
         /8ssbLWxuSYahWJfAz8b8NsTbus3DMjOvo21PNnsLnLPJfxXldt3sapdymTgHT8LZfVa
         CqFWqNdO46tMcGqmL0m/w5JNlRl57LvN78WMiAwvGHlu0LIfo6BrvRRYjmqyqhpJ9/mS
         qebW2T9oU9whhCfEq1rGlX3rJzZRv90PU6euDAzSHhUuX0cR6wsgwM1CHG2wZreKgdbl
         EDj6BoYD0VKAqtagN7vsseUPpnRamBuxAKocHzBpjrbpt5Iy0T9AtIwCP0htUCbPcifI
         FKog==
X-Gm-Message-State: AOAM530GbFCO/VOE3ENuqUljgVLyrfnW/OxAP31SSjhqV2P0mnFllFbF
        Xkue6aozZuqMb1e7Bji8GYU=
X-Google-Smtp-Source: ABdhPJxHbWT7hGwsTqiFFmicf/NGrbVWQCk+BHGG5FWyoaakDMeNU0yM7d/Ws4csvPpIcXr7q1UsVQ==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr36043847eju.485.1636863860300;
        Sat, 13 Nov 2021 20:24:20 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g21sm5495555edb.89.2021.11.13.20.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 20:24:19 -0800 (PST)
Date:   Sun, 14 Nov 2021 05:24:18 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
Message-ID: <YZCPcusrcCIJvYdn@rocinante>
References: <ab80164f4d5b32f9e6240aa4863c3a147ff9c89f.1635974126.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab80164f4d5b32f9e6240aa4863c3a147ff9c89f.1635974126.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe,

Thank you for another nice patch!

> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.

If possible, we should explain why are we using this new API, especially
since percpu_ref_tryget_live_rcu() is a relatively new addition [1], so
it's obvious that its users already manage the RCU lock accordingly, and
that there is no need to hold the RCU read lock again (which can in turn
lead to performance improvement), which is what the percpu_ref_tryget_live()
does internally.

What do you think?

1. 3b13c168186c ("percpu_ref: percpu_ref_tryget_live() version holding RCU")

>  	if (!ret)
>  		goto out;
>  
> -	if (unlikely(!percpu_ref_tryget_live(ref))) {
> +	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
>  		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
>  		ret = NULL;
>  		goto out;

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
