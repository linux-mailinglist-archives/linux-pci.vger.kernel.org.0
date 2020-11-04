Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6F2A6807
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 16:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgKDPsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 10:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgKDPsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 10:48:14 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC3C0613D3;
        Wed,  4 Nov 2020 07:48:13 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id p93so22926893edd.7;
        Wed, 04 Nov 2020 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hJScwyKL9t98e1Usi+6UUO0Yc3DoEIs7VZlQIPy1XQ=;
        b=Cujtjf4MsDnP/w988NRU1mvmUq1qYOVDOUALaXAI/UMDmNSRpd5FzSdCSunRiHIQVK
         vO/CEliBhUv4Lej1eK9tcmtK3uacnboS+bsBc//dWkjVUE2yDQgfM6c/v3F18ZYqMLQf
         1QOkTuvxyOZZY/rncIrctfc1lPHwaBbshtpGwt3S5CQLAzCN6SOVRQGnZCwE7RqT0nrT
         3qjJqfip689eox8SPf/RKYwAbRQCIo2IoIlXHeogaQymOmQpfIoTuZfK/SpM26q/Nb8n
         A1IE5gzuVEhPh9kxs1N34F+p86FKa9JAAlgxIASTYmm44jq/vVnPx1puTpINm/CHn543
         l9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3hJScwyKL9t98e1Usi+6UUO0Yc3DoEIs7VZlQIPy1XQ=;
        b=XbkIisMmz2YD+xPNUeNpUAJZHNT7NZNQhTzHG+Gmp69kjSUBnnPRrj6G0Q4+qj/xb4
         0qMgYMrUgyOspjDjZQeDsvH04I95xl8ozrwcDuaM7wbgywf+jrAdL59XKcw5HSB24EvP
         PkuSnZdtxHdL5cunqonXrG7bNhL0d3qIUp1ZOzyQSTPW2z34jTFKWS8AP2nJdQBflzab
         wZyQFs52imKVPzlhfeHNhuWIZ9c/Rd1lYH4+Gw7IdDtTQGN7sAGW661dS8H2YjfcqVYm
         m0wWYIS0gPv25YY0Fhx7nT2fmi4fBMUst9baKo8h3U4grZOLcfc7206b4jry/Tp0YwQU
         5sRw==
X-Gm-Message-State: AOAM5337xqsmk66bKA66YKjoln0r6qE/zOLds11l4/O3X1NQqpSML9Bz
        RmrF9ycqlQay+G+Vp90YayOzWY7gZxc=
X-Google-Smtp-Source: ABdhPJx3LWyW3wNwOotfwU1dLKsLBN3EaAxvHPvd6cPKcVuS9kBtKrhaBeO96sYWEcm5Bn3coOaqUA==
X-Received: by 2002:a50:ed90:: with SMTP id h16mr26593520edr.255.1604504891925;
        Wed, 04 Nov 2020 07:48:11 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a482.dip0.t-ipconnect.de. [217.229.164.130])
        by smtp.gmail.com with ESMTPSA id ds7sm1198438ejc.83.2020.11.04.07.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:48:10 -0800 (PST)
Subject: Re: [PATCH] ACPI: Remove trailing whitespace
To:     Joe Perches <joe@perches.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201103211259.GA265488@bjorn-Precision-5520>
 <c92703e3-c964-b4a6-e3df-c4c0c28b44c1@gmail.com>
 <6e392d099bd8aaba14223aa770361dbdeeab271b.camel@perches.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <6d888eb0-bfc5-28ff-c62f-9e769f77bc1f@gmail.com>
Date:   Wed, 4 Nov 2020 16:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6e392d099bd8aaba14223aa770361dbdeeab271b.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/4/20 6:13 AM, Joe Perches wrote:

[...]

>> Yes. I scanned drivers/acpi for trailing whitespaces after I noticed a
>> couple of them. I did not explicitly scan for other stuff like spaces
>> where there should be tabs, mostly because I haven't found a quick and
>> reliable solution for that. I only noticed an inconsistent indentation
>> when committing, so I fixed that too.
> 
> You could try:
> 
> $ git ls-files -- 'drivers/acpi/*.[ch]' | \
>    xargs ./scripts/checkpatch.pl -f --fix-inplace --types=CODE_INDENT

Thanks, that indeed looks like a decent solution.

> Right now that produces:
> ---

[...]

> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 46a64e9fa716..46be80976a03 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -89,7 +89,7 @@ struct acpi_ac {
>   #define to_acpi_ac(x) power_supply_get_drvdata(x)
>   
>   /* --------------------------------------------------------------------------
> -                               AC Adapter Management
> +			       AC Adapter Management
>      -------------------------------------------------------------------------- */

I'm not too sure about the comments, but I can find the time to look
over the output and adjust that if that's something you'd want me to do.

Regards,
Max
