Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4360832FE4B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 02:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCGBSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Mar 2021 20:18:18 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43156 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCGBSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 20:18:05 -0500
Received: by mail-qt1-f172.google.com with SMTP id l14so2185207qtr.10;
        Sat, 06 Mar 2021 17:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2b25z/IaYQj4qXr6EBnNHfy1oGsb8L5IXw+1eFrXEk=;
        b=XTP4IOcwoXIxOSTQuW0ZpPuIVWmZ4lK7dEAy7BAWlIYo+5RZ7a5JHlorIozbMKTplE
         HEZfAiOxi8OV17vlKSQc7YZQ6hc/4eYL5CrQ3kH4sZyb4cWA+7CqH9uQniugvrjM3nWP
         SyFBUW1nNPVCFK5P2PEKeXhEKL859bDNeqWWXPNA7EE4d/JZYZZl54t++07zkPb8Ib72
         gu4tbCR26nV2hNKuwjb1g+YZOrkpAj+1v+hlqHggzVgCsxLp+mlWDJPw8TVab63owwOY
         B02ehUIQ8JzY9+Hr8XND4kHi6HgkfCiylkDbF/kpkJ6NxYjGYqnaZVoANuA4EWUY9PP7
         M3PA==
X-Gm-Message-State: AOAM531R8x4dUFUgkS/K8e7Cqmiu2NqDHbuy6Dh2DqGfZbvLnrhjSPen
        FMgvI4bnggoh78sMBwKPg/k+KoARMrJsZYEW
X-Google-Smtp-Source: ABdhPJy5UpugTBIUvUPYV+bKOYYknMsymvxTPXUqPw3z+eGIJp30YlXptyA+8RfSAwhv2ay9u7DmGQ==
X-Received: by 2002:ac8:b4b:: with SMTP id m11mr15714636qti.254.1615079884953;
        Sat, 06 Mar 2021 17:18:04 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r67sm4799808qkd.93.2021.03.06.17.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 17:18:04 -0800 (PST)
Date:   Sun, 7 Mar 2021 02:18:01 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: acpiphp:  Fixed coding style
Message-ID: <YEQpyWPgAI8az5gO@rocinante>
References: <20210301072145.19018-1-chakravarthikulkarni2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210301072145.19018-1-chakravarthikulkarni2021@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patch over.  Few suggestions below.

There seem to be an extra space in the subject line.

> In this commit fixed coding style for braces and comments.

Where these coding style changes suggested by a tool?  For example, was it
something like checkpatch.pl?  If so, then it would be prudent to
mention that the script found these for future reference.

[...]
> -	struct list_head funcs;		/* one slot may have different
> -					   objects (i.e. for each function) */
> +	struct list_head funcs;		/* one slot may have different */
> +					/* objects (i.e. for each function) */
[...]

Above would be a single line commit that has been made to with within
the line length rules, as otherwise the line would be too long.

This is not necessarily something that we ought to fix, see for example:
  https://elixir.bootlin.com/linux/v5.11.3/source/include/linux/pci.h

[...]
> -struct acpiphp_attention_info
> -{
> +struct acpiphp_attention_info {
>  	int (*set_attn)(struct hotplug_slot *slot, u8 status);
>  	int (*get_attn)(struct hotplug_slot *slot, u8 *status);
>  	struct module *owner;
[...]

Nice catch!

Generally, you would also need to your full name when providing your
"Signed-off-by:" following the style that has been widely accepted.  See
git log for how it would normally look like, and also have a look at the
following for some general guidance on how to submit patches:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Krzysztof
