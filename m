Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2F380A12
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 15:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhENNER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:04:17 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42709 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhENNEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 09:04:16 -0400
Received: by mail-wr1-f51.google.com with SMTP id x8so7691795wrq.9
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 06:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gH0jgRuNGlPIJh+K8kUuEJj28OFOzDhSXZi/oa72FhQ=;
        b=E21B55mpqw1CVY6llRyvvGjIa40AppLc+FxBTIktYGwR/YVOayfoKNc+L1mWe9dXXr
         /+hofh22Jum/RvOy6pN2MgAfqFYYJ7Wi7L+vU+hD+K5+zX+HjGi+okLt3ORJ2H0RbTFs
         oOZCiRrfJ5+U4H7YP5FceiUJccMV/mvpH0VNQ7L21Ty5bjgpIfwVD1eigc6nFTCU4P+y
         lsq3f/5iWqQ4P/LcRzKx4W6wOHUyBdLQ6C96NJel7sBegyLXra12MzQQFWYyJ5/riCyk
         d4FJDs5U21HDkB+SbAiAtoQ+PWxUIkpPqzDMoCFHQRUMaRcqiILkxHuWGjVAQW5K0kfd
         HKMg==
X-Gm-Message-State: AOAM533zYn1NwSglHtREPHXy6UDbJSfXUiL7GUS21EdRicPXJqK7hOGT
        vcfmGmpA1CsXjDCnTD3PtTc=
X-Google-Smtp-Source: ABdhPJzcAkVfdaNrBdQaIZrhN9UGxfhWLXz02xhvhtc6Fma+T/2pJc85gmeuipeA9XapOQwv4bZHiw==
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr58252532wrn.238.1620997384673;
        Fri, 14 May 2021 06:03:04 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r17sm11759056wmh.25.2021.05.14.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:03:04 -0700 (PDT)
Date:   Fri, 14 May 2021 15:03:03 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210514130303.GD9537@rocinante.localdomain>
References: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stuart,

> The pcieport driver can fail to attach to a downstream port that doesn't
> support bandwidth notification.  This can happen when, in
> pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
> set up a bandwidth notification IRQ for a device that doesn't support it.
> 
> This patch changes get_port_device_capability() to look at the link
> bandwidth notification capability bit in the link capabilities register of
> the port, instead of assuming that all downstream ports have that
> capability.
[...]

Thank you for fixing this!

I was wondering - is this fix connected to an issue filled in Bugzilla
or does it fix a known commit that introduced this problem?  Basically,
I am trying to see whether a "Fixes:" would be in order.

Krzysztof
