Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51332EFE5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCEQUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 11:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCEQTx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 11:19:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 327BF65092;
        Fri,  5 Mar 2021 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614961193;
        bh=MBHtkkNBnN9Z2jpagJhsSsgGXlxtptEY2+VM29zPkkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UcVgS+oQlTJH9iASfZpGE1vUzbHUpMKYC6KibDTu993AGeAnFs3zBLxRELkecSTBY
         oIU5rO0mwVWKwv+SBse8v2j3DySK/dl+PhzH6HbrDNZgzRzhmdeV2KEMJx7NkLBuF9
         QE4Lj296W+5QTMKnApnbD0L7R1LXXuv/SoocoU2GLFeYu7NkG78J3QXqI9nVviYxvK
         US854c3WEv/eR5e7C8V+j26/cdL/+mAJg1McppkQrteytQCU1qAQdGYL7lz9qWiS5d
         guZR5eycDHpl61aEFKM6qjN7xvXtreUfNUf1lt2Z9LL56rrthS8XkYXzXsT6yG91aK
         uZ0LXbWYfOcjw==
Received: by mail-ej1-f47.google.com with SMTP id mj10so4573428ejb.5;
        Fri, 05 Mar 2021 08:19:53 -0800 (PST)
X-Gm-Message-State: AOAM532Cg9Bf9N7ej3frAw/DqsV2FGOI6XhGv5xjCqEXWR+XpeRT+J0e
        9SHikzy9f+YjHLRZKEBwgzGVcAymd/bBuy+Fjg==
X-Google-Smtp-Source: ABdhPJwxBMMlAbwPovyVAPSxQCaQny5pxiGdQjE2HT3P9Xio/HPqDQurWt0GxFrJjP4vmPK93eF3g4vEVBEb8owGbu0=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr2884798ejb.359.1614961191876;
 Fri, 05 Mar 2021 08:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20210305025910.9652-1-kishon@ti.com>
In-Reply-To: <20210305025910.9652-1-kishon@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 5 Mar 2021 10:19:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKw-+8nd6N8dXM-ANmaZtq2rokADQVzMY27WZ-G-scDGw@mail.gmail.com>
Message-ID: <CAL_JsqKw-+8nd6N8dXM-ANmaZtq2rokADQVzMY27WZ-G-scDGw@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware-ep: Fix NULL pointer dereference error
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 4, 2021 at 8:59 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> commit 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows") detected
> the number of inbound and outbound windows dynamically at runtime in
> dw_pcie_setup(). However pcie-designware-ep.c accessed the variables
> holding the number of inbound and outbound windows even before
> dw_pcie_setup() was invoked. Fix the sequence here.
>
> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 44 ++++++++++---------
>  1 file changed, 23 insertions(+), 21 deletions(-)

There's already another fix posted. I prodded Bjorn to apply it.

Rob
