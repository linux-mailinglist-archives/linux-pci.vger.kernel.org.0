Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A547431A21
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJRM44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 08:56:56 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:34617 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhJRM4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 08:56:55 -0400
Received: by mail-lf1-f42.google.com with SMTP id t9so66670067lfd.1;
        Mon, 18 Oct 2021 05:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3d/ZodwKf+LfB06q+MpENgtZZXbaLIVI1CL9dS/gAI=;
        b=pMy6YsFcsHCDQD4vhv34AG9PSPyFO3DbeJmKDxP3/O48rOvYdCbcsLxVrNiG+kcPES
         OoZ+0jDdmQeyIVO0RrrBr51nC1BNO/VUhcv8estDzmviAMPz09WPypk8CcHrYjPP/wld
         RaqebDjSb+1bXI9aLokaSzEAR/SWiJNHvK9IF0LehuOJt2FIzlkUni1DaeG6SCO7cgxP
         Sq+QF6kNr8rMjHWcj9GYK7r+6Srctw/F9z6FAz3IgxWD+JxeyznXBURi6zgFHKKCf32w
         sar/LZ5Rc+4/0BR/2Q+TxlbBscg7k5x+T2FesE5nwQm3W7V+NPkFWGgRqRWh2jfZQVcK
         clng==
X-Gm-Message-State: AOAM532g13l6RU4cbF08GAsRcKUD308SWXMCMCukXQk27UUoGHDWceer
        Vu+D1n7inEAPOm6RUO9sgts=
X-Google-Smtp-Source: ABdhPJydxzN1AKhYuskbrzvqZZj+v2XG19n0ixHc6gmpz+aLK+i7JvPUfler6VF6Q/0UODaFtRwDsw==
X-Received: by 2002:a05:6512:2256:: with SMTP id i22mr29177642lfu.158.1634561683621;
        Mon, 18 Oct 2021 05:54:43 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g18sm833372lfu.4.2021.10.18.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:54:43 -0700 (PDT)
Date:   Mon, 18 Oct 2021 14:54:41 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     hch@infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Remove the unused pci wrappers pci_pool_xxx()
Message-ID: <YW1ukUjaFRLdkbNV@rocinante>
References: <20211018124110.214-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211018124110.214-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

[...]
> v1->v2: *Revert the implicit inclusion of dma_pool.h

I wonder how much of a rabbit hole (or a wild goose chase) would be to
remove this include from linux/pci.h and add it where the users are...

Probably not worth the time.

	Krzysztof
