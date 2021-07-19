Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805983CF07B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 02:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGSXXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 19:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1386326AbhGSVb7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 17:31:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4B1761009;
        Mon, 19 Jul 2021 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626732753;
        bh=ywXebz7khwKBuJDP8OJ9Y9f3IjGDiPgo1ZdKMPBv1PA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tQxz58fpz1mY5XX0kdt+dFiv6jbaVWB+56C1EQuXdQjfzBwzfTaqh0NQiDPwYRktK
         Qy+ER9m9hZEhZU3p9ZVqQtkHvpnH9SuW/jMyruW0XVfzQDc0hxQk7Cb/mEYPxFd+b1
         9lk00Kg/cADsH4z6CuerM75C30yY5Huh6MLLhTckJML2/Y6bizBWSRBWMSvhbv9QCK
         77TlqeVrogNTd/tMvqDLSN6P/GjTXZxg9a3akbUUulIVIeS/l1YNOrzjKt1WE/HKtS
         hidAc2d6foYgIjL9lYcO8dns0NjEhw/8bK3uiPmUR9AvRMPZSqBlyrChYlZIoj/ZgA
         CR3YjKjOZG2Lw==
Received: by mail-ej1-f41.google.com with SMTP id qb4so31179229ejc.11;
        Mon, 19 Jul 2021 15:12:33 -0700 (PDT)
X-Gm-Message-State: AOAM533sPr7mwEu7kiPzKk/3zNCRDHv9UOdnDGasSJU8GgR6GG/p2ROI
        14tevMqaV+/QAIMdQDWAEQppY24XUSwgBF6yoQ==
X-Google-Smtp-Source: ABdhPJx7MW96k4Ls+bEI+HqOvpAQG4RH5seAXZmheOFPnHbto076DqoxZowrqK7C8eOSrfU4aPtD+WqCp8H7O1FAh/E=
X-Received: by 2002:a17:906:8158:: with SMTP id z24mr29550707ejw.359.1626732752310;
 Mon, 19 Jul 2021 15:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210719220351.2662758-1-robh@kernel.org>
In-Reply-To: <20210719220351.2662758-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Jul 2021 16:12:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+JjdB_FLe6nB=K+nHzdjsd-KA8-vzzm3oodwRsEu0REQ@mail.gmail.com>
Message-ID: <CAL_Jsq+JjdB_FLe6nB=K+nHzdjsd-KA8-vzzm3oodwRsEu0REQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: intel,lgm-pcie: Add reference to common schemas
To:     devicetree@vger.kernel.org, Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 4:03 PM Rob Herring <robh@kernel.org> wrote:
>
> Add a reference to snps,dw-pcie.yaml (and indirectly pci-bus.yaml) schemas.
> With this, the common bus properties can be dropped from the schema.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dilip Kota <eswara.kota@linux.intel.com>

While at it, I'll change to a non-bouncing address for LGM SoC[1]:
Rahul Tanwar <rtanwar@maxlinear.com>

Rob

[1] https://lkml.org/lkml/2021/3/16/282
