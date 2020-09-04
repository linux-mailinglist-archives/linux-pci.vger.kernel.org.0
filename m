Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942125E1A7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgIDSzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 14:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDSzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 14:55:10 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C483206B7
        for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2020 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599245710;
        bh=i8O7u3HqWp1gqN3thqoJWvEdSlSh2vSIHRzh1/oKX9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gu1EuGsloz83y8fKjLqPKOCQXpdTwXOUeUElDOYQsiZLPeh6z3Wo9qD+9zDH2S6nG
         1zs6DclhjZl95Cy59mYbUQQ1WblJ7KoZYNPDp0kn9bwouSv7HP+MWurRzUyiCkVXhy
         mu5Ruic7aFFN3R2YqtxznIsgpEGJF7NiH3c0sdaE=
Received: by mail-oi1-f181.google.com with SMTP id w16so7483950oia.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2020 11:55:10 -0700 (PDT)
X-Gm-Message-State: AOAM533NTGVs2D+xTBajJ7NUmms88no/xxRT0cq5uiVbHTBxTzAc31Kr
        6x8+mfalca7FiDlvrZ6YLOqB8XwEzAYQZpP32w==
X-Google-Smtp-Source: ABdhPJxuIOuSQjWModMalFgqxXPB0QIQz9a2SuXzhvdHMYgV5RX3YmToPpqoM9Zo/G9j8nH7clnd7ou5pkNLCHDBHSg=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr6328397oia.147.1599245709496;
 Fri, 04 Sep 2020 11:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200904140904.944-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200904140904.944-1-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Sep 2020 12:54:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+CcY-50NgwyF9Mh2uvgLF_rd0pfjyo=v=X0JAGJcs++A@mail.gmail.com>
Message-ID: <CAL_Jsq+CcY-50NgwyF9Mh2uvgLF_rd0pfjyo=v=X0JAGJcs++A@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Fix bus checks in rockchip_pcie_valid_device()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 4, 2020 at 8:09 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> The root bus checks rework in:
>
> commit d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
>
> caused a regression whereby in rockchip_pcie_valid_device() if
> the bus parameter is the root bus and the dev value == 0 the
> function should return 1 (ie true) without checking if the
> bus->parent pointer is a root bus because that triggers a NULL
> pointer dereference.
>
> Fix this by streamlining the root bus detection.
>
> Fixes: d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Even better than my broken version.

Reviewed-by: Rob Herring <robh@kernel.org>
