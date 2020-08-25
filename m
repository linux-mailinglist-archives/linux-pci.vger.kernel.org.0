Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF7250ED6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 04:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHYCQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 22:16:16 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37313 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgHYCQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 22:16:16 -0400
Received: by mail-il1-f194.google.com with SMTP id v2so9130890ilq.4;
        Mon, 24 Aug 2020 19:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPkJ+m1LOAYIdHymWXUXlICN2oA4OY85j0tsHxzDNhk=;
        b=p7CKQOsppOkwFiU4Gf1/MmtgFatDEZJ8BQIuZDqVyvcmyRjOxCZHQUXh7AL1vJYpXR
         qgnRHYrxBCMOsbqGtRsZi1+cRtlz9HteLh/nsITbkbjleX1kEFGxD1NjncNYeVkmZNwT
         39BPBXqBgqsTzUiERwawn/3q7sLsy8g3Or2EIRzvbrhVriSAsN1ZkkVVU2T4o92Afciw
         P06KYzGMxDC+8d8XJC8VPibUQev/wYhQCiwdZXW4CCVv/XG3hrSIqu+ZiwKxEmEvN5ct
         PPmg5pGjHyvJ3n9dOSTB452yitr3QE6nC8rzqOa+Zu+KRFzWc36tCgJkaLqrCQhHBS1+
         gSmg==
X-Gm-Message-State: AOAM532aRgClBlEncYThGxuywHVZN3DdB4C52g42HypvP3+aoLbdF+cj
        IxCjP/eZ0u3/feRbatLFTA==
X-Google-Smtp-Source: ABdhPJzqxSWvJoZa/eK22RW6Ysg8V0J9ZDaeHkgSCF8dASDbdqNMA91c/N2qetMENr1xgNOFd2UlrQ==
X-Received: by 2002:a92:cb12:: with SMTP id s18mr7766563ilo.13.1598321774989;
        Mon, 24 Aug 2020 19:16:14 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id k18sm4427512ils.42.2020.08.24.19.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:16:14 -0700 (PDT)
Received: (nullmailer pid 3800007 invoked by uid 1000);
        Tue, 25 Aug 2020 02:16:10 -0000
Date:   Mon, 24 Aug 2020 20:16:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and
 r8a774b1
Message-ID: <20200825021610.GA3799949@bogus>
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 14 Aug 2020 18:30:33 +0100, Lad Prabhakar wrote:
> Document the support for R-Car PCIe EP on R8A774A1 and R8A774B1 SoC
> devices.
> 
> Also constify "renesas,rcar-gen3-pcie-ep" so that it can be used as
> fallback compatible string for R-Car Gen3 and RZ/G2 devices as the
> PCIe module is identical.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
