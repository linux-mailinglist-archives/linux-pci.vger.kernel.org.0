Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4739BD8030
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 21:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfJOTZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 15:25:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45908 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfJOTZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 15:25:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so17979879oti.12;
        Tue, 15 Oct 2019 12:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGcPWV+a3flesjj4mbDC6c0zlcD6MWrmIaFVWNKrxv8=;
        b=RbCZ51114p98bZDl1nBqp70LCGm/OWBxOpeLQlX34680N69zPq1N5yuJDNt1yYhiVZ
         1ebrJ9tMa8EQVoIwcz5mWfu17qy6LYtR+pGpwIoWWbHqBP2DIQJ5QBdN7l264LryIPTD
         4tv1jyT2aLDaoGWXO+8Flk71Aw3OJXpKI6kHV16m2sIVrukRdsHfIzjGuQZfs0fNNsrm
         mKktOQ9LerVQH4Zs3EGfDkV7rDKO0fr9aYW1vBG3ra5ihhG7CSi4L7wcD/tBl6QawF2+
         K69QTaJavfLWJdLyqM83YWhxHifnzIzDpsIUvM9I2beNRkAJv0f/ISjII7FtRD2H+KZy
         NbNg==
X-Gm-Message-State: APjAAAUdFi7YwuEMMV5ABMl/3hMvIn59/zT4ImTckQtWVVZWOIjG+G5f
        gpKpusIHPjEt/nBffVfArQ==
X-Google-Smtp-Source: APXvYqwzb/cAnrXU5arNN28F0oXmazdVgAUawVvNKIfx6DNM+H5v1g+C5k2gwX/8EP5dl/+KZVzOOg==
X-Received: by 2002:a05:6830:45b:: with SMTP id d27mr7145687otc.367.1571167540551;
        Tue, 15 Oct 2019 12:25:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 13sm6309372oij.25.2019.10.15.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:25:39 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:25:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Subject: Re: [PATCH 3/7] dt-bindings: PCI: rcar: Add device tree support for
 r8a774b1
Message-ID: <20191015192539.GA1694@bogus>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570178133-21532-4-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  4 Oct 2019 09:35:29 +0100, Fabrizio Castro wrote:
> Add PCIe support for the RZ/G2N (a.k.a. R8A774B1).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
