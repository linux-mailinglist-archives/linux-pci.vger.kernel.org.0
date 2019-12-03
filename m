Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658661104F1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLCTTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 14:19:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35828 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLCTTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 14:19:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id k196so4429574oib.2;
        Tue, 03 Dec 2019 11:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VhGuCOSgKbP4988nwTLXWSOEoYXbGs7dSJ2jvNBuhT4=;
        b=gFrPoz3RmIy0EbzRdL0hnjFQ9UL/00ObT7O9bi3dwtJFEOu2y3DwZ7FvqqMG+aV7jP
         6VF2QposcD/tp6/1GKcHxu1THC5wnQdGCwp1tk1WtkQCpgk62SboBFt+IKoiZpAFF9Q2
         ePl+57KVzUUDRV4jSjsn+aGDShR5qUfb1PC4uHGe0rzuvkkU5Kdc+I4eJ+UuOThujjSX
         +oBMVuCQdFiSsLagik6m59YAXpD1GSGzru6/DiZA24HH35mWadmbVqCkexycazznETzx
         I7LEycLDsVyVOAdLwwM6nng6d52HWvNCHjljFGB4WRyMRqsUciNwgWwUxo3vB6GPUXpZ
         /QDw==
X-Gm-Message-State: APjAAAV1XynyQXZ0JqtNWQmG5doANztH5dK1earvFeMSJ6V2+6C6V/Yp
        zTlHhPP2hsNk/aftdFz1tw==
X-Google-Smtp-Source: APXvYqwXMVbFZmRe8QxF27h0Kfw3uND3v8OqThcJ1mrg8to0o6bWBoF0eqOAN8t4mfWgef6ZruT5hA==
X-Received: by 2002:a05:6808:b2d:: with SMTP id t13mr5046037oij.83.1575400754268;
        Tue, 03 Dec 2019 11:19:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y16sm1345750otq.60.2019.12.03.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 11:19:13 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:19:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: pci: Update iProc PCI binding for
 INTx support
Message-ID: <20191203191913.GA20024@bogus>
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575349026-8743-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  3 Dec 2019 10:27:01 +0530, Srinath Mannam wrote:
> From: Ray Jui <ray.jui@broadcom.com>
> 
> Update the iProc PCIe binding document for better modeling of the legacy
> interrupt (INTx) support
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 48 ++++++++++++++++++----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
