Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A37244C59
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHNPzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNPzh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 11:55:37 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E9520768;
        Fri, 14 Aug 2020 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597420535;
        bh=zoa+ut1WbMyFnWgB8xhbbBgiPvLBJ5ASa6+HjTkjJeA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ktAcEr0h9wBlewT2JRHzwBHJHhvjfoOjpsgwy8Kogce6wyc4D0FayGMDsLWYQ4U7E
         d7sCDHHEpcLeS6qlKJdso617e951RzH0pmAfwOUhRu6tJfZyZfqvX8YjTR1iIWwDTe
         IlysCOkzGFNHfdPTb3lUP1E8dkI3gswkIeyJqG48=
Received: by mail-qk1-f173.google.com with SMTP id b14so8770174qkn.4;
        Fri, 14 Aug 2020 08:55:35 -0700 (PDT)
X-Gm-Message-State: AOAM532XvmnV/tqwcZVZWm9tFJAO8aFZGKRSo44+/57KJTLB65S6Rv+T
        vsJ8XmS8EhHzfiaI37OJcwVh78J+NazOSuVUIg==
X-Google-Smtp-Source: ABdhPJzQn5hvqDdVbAUx/i7n0mBCBw6qmaHAQRSOghi9ECkbVZ+694cX3OUNz/opcd5rfswo01laJxkQkN1JbM64SZo=
X-Received: by 2002:a37:84c:: with SMTP id 73mr2596374qki.464.1597420534748;
 Fri, 14 Aug 2020 08:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <eb2abaa7fc97a6e700a7c4ed37182820803414c3.camel@microchip.com> <4bcbacfb4b117dfde38a57541dd37b02b887a318.camel@microchip.com>
In-Reply-To: <4bcbacfb4b117dfde38a57541dd37b02b887a318.camel@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Aug 2020 09:55:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKeXDB-4N1_-EutEKiH34cDcXE6tkaGY8Gc4WB-xcVjFA@mail.gmail.com>
Message-ID: <CAL_JsqKeXDB-4N1_-EutEKiH34cDcXE6tkaGY8Gc4WB-xcVjFA@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
To:     Daire McNamara <Daire.McNamara@microchip.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 7, 2020 at 7:23 AM <Daire.McNamara@microchip.com> wrote:
>
>
> Add device tree bindings for the Microchip PolarFire PCIe controller
> when configured in host (Root Complex) mode.
>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
