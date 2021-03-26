Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91434A562
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCZKRZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 06:17:25 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44859 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZKQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 06:16:54 -0400
Received: by mail-lj1-f175.google.com with SMTP id u9so6704624ljd.11
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 03:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OpUz9bJiyFsQLECiLjbpS4JDAF5Mbq0A2LJG0VBJw0k=;
        b=g+29QZO5TBBpudt/2V2uYFgjQsXHCq+1P8Qe5U5ZNOwqwDmpUniBK8lzDVqrUEcGTZ
         k0Jv2GqYLrPsiKvwYbczxeernpVQMUwrlddkmbdwmer4s092U3s6cFBq0U7nelWg0EtY
         C+G0J10XDWVe4+V8yJP84ve7k/H9xNA8YhwW1IBLkrhE30shUncVPcsJ+DuPsboJDy8N
         bNfWnKcMEnxq8wvXdnKtovZqAngWItvomOqHWF8arvkJy6b4iLo2Yamipyf7GQM8snrJ
         saB0H0vDfrzG5ZE/a+cL1dcbDo0gt8L2p4eb9wUTg70oH6uSRyGh+oDr/uWu1vPsHx0g
         UNDg==
X-Gm-Message-State: AOAM532TPmlAqrF9vy4MkObeFkQILL7oVMPQMUEf5mTp3Hk0oy39O/Sl
        ltpLl4cw2KZ8yvWmLE3ofyo=
X-Google-Smtp-Source: ABdhPJyCc6/gKg/ABYeo6/vtXy+bgJwVSNiQyzkmJCpEFGcpxDFN5bb18v+4nM4hA26Rb3PsnCrH6A==
X-Received: by 2002:a2e:9899:: with SMTP id b25mr8521719ljj.376.1616753813364;
        Fri, 26 Mar 2021 03:16:53 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j1sm824783lfb.85.2021.03.26.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:16:52 -0700 (PDT)
Date:   Fri, 26 Mar 2021 11:16:52 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH] PCI/AER: Use consistent format when print PCI device
Message-ID: <YF20lDlJlikTKNkI@rocinante>
References: <1616752057-9720-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616752057-9720-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yicong,

> We use format domain:bus:slot.function when print
> PCI device. Use consistent format in AER messages.

A small nitpick: the commit message and in the subject line it should
probably use "printing" rather than "print".  But I suppose whoever is
going be applying this patch can fix this, so probably no need to send
another version, unless you really want to do it.

[...]
> -			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x:%x\n",
> +			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x.%x\n",
>  			       entry.domain, entry.bus,
>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
[...]
> -		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x:%x\n",
> +		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x.%x\n",
>  		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));

Seems like a good idea!  This BDF-like notation is used at few other
places.  Nice catch.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
