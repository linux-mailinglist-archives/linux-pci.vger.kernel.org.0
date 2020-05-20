Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488951DC0A9
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgETUzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:55:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38191 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETUzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 16:55:53 -0400
Received: by mail-io1-f66.google.com with SMTP id d7so4925179ioq.5;
        Wed, 20 May 2020 13:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4A/urJgTNEik3nS9K/zxpMsr2xy3JDn7D0tTt4UYL6Q=;
        b=Rur735Aji85VKw1WifgT+44gMYMVhme71U7nNDI+g1QcQbAsjB5UCwZak639jEMrf0
         yLxSKLvJfJ6keAXvq6L8g15o1vlSqyKjbpk9xop3LW1rSW3XEDxfw3GYw0V6lgqteKdm
         od21vI3xYJCX5Az5f5moP83JhPgJGOCUR9FkTILW9h3VTcmrXcme9mJltsiBBRmlGIYY
         kb1Kwt0OO5jQ0O6SJcesX7jd6g0nU3djNZpvvvsjPo9E2ApfQs9PW8xjNEF6U8tEoJ+r
         +wSZLSOjYr7cYQhgfMBfFrUtquVKJz57z+Dhz9I+s/Acqux0QyquTGGGGjkcmE34/3Ab
         y3qA==
X-Gm-Message-State: AOAM532tpw0Ev3h0Qlpu1zLA6aej1yUTQRPjXil9loGo0pEH7XavniNQ
        +6uEpKG0zVKj1GOQSLD16w==
X-Google-Smtp-Source: ABdhPJwigL7tJ5oCpu3QdChue1KmFStUm7ZG2QUpfZDltiWiLyWIOcTfTB38/xTVoi9tfZr5b8RGhg==
X-Received: by 2002:a05:6638:224d:: with SMTP id m13mr942236jas.100.1590008151814;
        Wed, 20 May 2020 13:55:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k5sm1912408ilg.55.2020.05.20.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:55:51 -0700 (PDT)
Received: (nullmailer pid 558817 invoked by uid 1000);
        Wed, 20 May 2020 20:55:50 -0000
Date:   Wed, 20 May 2020 14:55:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 1/5] PCI: Don't disable decoding when mmio_always_on
 is set
Message-ID: <20200520205550.GA558730@bogus>
References: <20200428011429.1852081-1-jiaxun.yang@flygoat.com>
 <20200428011429.1852081-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428011429.1852081-2-jiaxun.yang@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Apr 2020 09:14:16 +0800, Jiaxun Yang wrote:
> Don't disable MEM/IO decoding when a device have both non_compliant_bars
> and mmio_always_on.
> 
> That would allow us quirk devices with junk in BARs but can't disable
> their decoding.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
