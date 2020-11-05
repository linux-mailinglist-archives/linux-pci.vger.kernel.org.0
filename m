Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2F2A89F4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 23:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKEWfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 17:35:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42919 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEWfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 17:35:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id w145so3384702oie.9;
        Thu, 05 Nov 2020 14:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4mlZPU3sPVvtAOd4V6r5fBsZrhdGvTkLIZ2NWUKCS5U=;
        b=fnfFzhY973yj4JwbzgDh05nUl9+ungL7NY9Ap2AKfppoA81YDSvClQCq4qCewVcSVy
         cku/yxXzmiTXiHjKRIxkCKkpNUGnkvjcvGWrslkgJj/TofO0OO5m6pwuPzbDY6TaFj+K
         hPnr7lnMKpsSzk3kKTikMs1WvVXAU1vsUYaGgGweU0pgnpaIKgybo/ZOohtG9LYvxPZ2
         bigenvgAe6kkpsJmIIACYgwcRVjIso9Mx374geZFlT+cCVn5/TEAwJ+VnrfxIuba2DdN
         ICzWXJicHmtOCD0YGx9Grlju1Gzavgkbsc61Aoz/kUwcMueZg2f/E4EHzkncqMF/Vmcn
         DWtw==
X-Gm-Message-State: AOAM531XNkHi7R/7qCWV1HKd/gM5LmNXqB1OZEwHArql4YuIOF5dheaR
        WMOX037uGQq0GZ0hVDTBsg==
X-Google-Smtp-Source: ABdhPJwt3adhhn5DCAed1okfmjhtDZ30W4RQDBnuWl1f5BQkobXXO+SPPjU0QwlqoBgKziEz+j3IOg==
X-Received: by 2002:a05:6808:647:: with SMTP id z7mr1090857oih.76.1604615749414;
        Thu, 05 Nov 2020 14:35:49 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l23sm630405otk.68.2020.11.05.14.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:35:48 -0800 (PST)
Received: (nullmailer pid 1925581 invoked by uid 1000);
        Thu, 05 Nov 2020 22:35:47 -0000
Date:   Thu, 5 Nov 2020 16:35:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, bhelgaas@google.com,
        linux-renesas-soc@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: rcar-pci-host: Convert bindings
 to json-schema
Message-ID: <20201105223547.GA1925483@bogus>
References: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1604455096-13923-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604455096-13923-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 04 Nov 2020 10:58:14 +0900, Yoshihiro Shimoda wrote:
> Convert Renesas PCIe Host controller bindings documentation to
> json-schema. Note that some compatible doesn't contain on
> the original documentation so that incremental patches are required
> for it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-host.yaml     | 113 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 -------------
>  2 files changed, 113 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
