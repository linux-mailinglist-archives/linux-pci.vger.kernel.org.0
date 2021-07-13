Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41D33C6C39
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhGMIst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhGMIss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 04:48:48 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE1C0613DD;
        Tue, 13 Jul 2021 01:45:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso21720834oty.12;
        Tue, 13 Jul 2021 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T+2TDXF9EDKSZL5Kzj9TJlxPiJ+RmKYPj3eyPe8VGrQ=;
        b=I65UGfx1S64EbyEek5XbLG7ivJH0gzrauClda8uSGEI2CYDLve1rrfbR5bIMZGjT4z
         l8Nlu5DgZkOG0eJTmeMVSdRcn3+i4tFo8ibzmhQTmZO9Sqb4vXD2XJBnxLLeQRLon8vu
         8nZP/tf2MW4ggSiITz9Sc43vjiPv0FhGzw6IHGsnm62oKi8lbtDz1fLi4SxcW/pdvgWN
         bdfH74QqeGcsZp+ta5I0jxL/csIHWj7BxSb0jaWpzH0tCTotr/be2Y5bS2jcbQn8xsEe
         ejVRIy8NZzWi1aXGL/V4zRBpHEGgx8cJm/XeXpvYQglZwpybLxKDFfqO8oLdSP37Btl2
         NNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T+2TDXF9EDKSZL5Kzj9TJlxPiJ+RmKYPj3eyPe8VGrQ=;
        b=i/lPlZFZcOZkuUoMzNTfpwvH+TJl66WfKbQ9K0ZRkdgsg/k469UxaVL1HPC9xPoGgw
         qckAx26yDYzQCbWFfU707+PsZDF6s3DcWc84n/oi12UjELIJqTBTy9AMbhzQQVtAlgVp
         MGyva730X79+XYCQ5cfcwKtJLHXO1HNWQyh5oZS4TkSVChA3TGTMCUlYVAgx7xVVJQjv
         aSPLiC13YW35hjn+eMUqBSfWdRlW9LDMYme+aof79aH4DGXD7iNhG39kgFcKdhP2uRMk
         hJaOZfazNeH+Ku2eOTAyzSs7CAmXAqVEffGundyhZng1g3tbrPndhEepIyL7HZUOrKVP
         iocg==
X-Gm-Message-State: AOAM530BCtxhCZX0LPK1b7LR1kyVeeVJEGeUGuN4vvrGL7PTAt5W7My5
        EnrixE3wAD3MhmvTHwXqfLeAB2q1+W0=
X-Google-Smtp-Source: ABdhPJwL383jZ46QRqsnv972rfzscEbGIbCKaRsojwy9XVvnLFiG6AHJ86qgMxfHcYeyTvBHePMdHg==
X-Received: by 2002:a9d:64cd:: with SMTP id n13mr2730807otl.349.1626165956933;
        Tue, 13 Jul 2021 01:45:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5sm3661034otk.39.2021.07.13.01.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 01:45:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Coalesce host bridge contiguous apertures
 without sorting
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f18e36f7-cb18-1a4a-e7e8-4fbb253581ae@roeck-us.net>
Date:   Tue, 13 Jul 2021 01:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/21 12:57 AM, Kai-Heng Feng wrote:
> Commit 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
> sorts the resources by address so the resources can be swapped.
> 
> Before:
> PCI host bridge to bus 0002:00
> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> 
> And after:
> PCI host bridge to bus 0002:00
> pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> 
> However, the sorted resources make NVMe stops working on QEMU ppc:sam460ex.
> 
> Resources in the original issue are already in ascending order:
> pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> 
> So remove the sorting part to resolve the issue.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 65db04053efe ("PCI: Coalesce host bridge contiguous apertures")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I think the original commit message would make more sense here. This patch
doesn't fix 65db04053efe, it replaces it. The commit message now misses
the point, and the patch coalesces continuous apertures without explaining
the reason.

Guenter

> ---
>   drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 79177ac37880..5de157600466 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -877,11 +877,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>   static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   {
>   	struct device *parent = bridge->dev.parent;
> -	struct resource_entry *window, *n;
> +	struct resource_entry *window, *next, *n;
>   	struct pci_bus *bus, *b;
> -	resource_size_t offset;
> +	resource_size_t offset, next_offset;
>   	LIST_HEAD(resources);
> -	struct resource *res;
> +	struct resource *res, *next_res;
>   	char addr[64], *fmt;
>   	const char *name;
>   	int err;
> @@ -961,11 +961,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>   		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>   
> +	/* Coalesce contiguous windows */
> +	resource_list_for_each_entry_safe(window, n, &resources) {
> +		if (list_is_last(&window->node, &resources))
> +			break;
> +
> +		next = list_next_entry(window, node);
> +		offset = window->offset;
> +		res = window->res;
> +		next_offset = next->offset;
> +		next_res = next->res;
> +
> +		if (res->flags != next_res->flags || offset != next_offset)
> +			continue;
> +
> +		if (res->end + 1 == next_res->start) {
> +			next_res->start = res->start;
> +			res->flags = res->start = res->end = 0;
> +		}
> +	}
> +
>   	/* Add initial resources to the bus */
>   	resource_list_for_each_entry_safe(window, n, &resources) {
> -		list_move_tail(&window->node, &bridge->windows);
>   		offset = window->offset;
>   		res = window->res;
> +		if (!res->end)
> +			continue;
> +
> +		list_move_tail(&window->node, &bridge->windows);
>   
>   		if (res->flags & IORESOURCE_BUS)
>   			pci_bus_insert_busn_res(bus, bus->number, res->end);
> 

