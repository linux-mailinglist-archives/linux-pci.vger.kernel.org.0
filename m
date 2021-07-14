Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838963C929C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGNU67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 16:58:59 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:43933 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhGNU64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 16:58:56 -0400
Received: by mail-io1-f47.google.com with SMTP id k16so3798791ios.10;
        Wed, 14 Jul 2021 13:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EnXGA3+YFuTeU9FgBeezkUFsCLztW7qvPFMTFHbshIE=;
        b=geiflgiHlgWYlABVSNxupNF5PEQju3Gkn9EuC8hy4z+aUrb5U21OF9rxRHXegQqvCt
         1SdFSJhuPvuLeIhnBE3oBXnF2V+96NWbXOBrzwe2LHovJP8w7Sy8y4PZz70lbq4BbYni
         G79QGsijJ/dfSs+4ZYcJqW9rhzVBvURYLq0p1yWrKSHPI/tlHj7sz2g8JMSdtLYFmFp0
         3ddYrGd3NFE6ffkE4fpBbqHQhDRWhbUNhhEjcvodOWZt01c/qAU1oNfQ1VSpmUkwwQWX
         nDdhhGNCSsidqWmWl2Fggc7PWgHv1hwQZJSlomV7Dz78FgYn6rkrd7V8xQgNOVdMK++u
         1Wtg==
X-Gm-Message-State: AOAM5315INXpfNYMPBv4OYpHiA9HctEaPQXZ4ZO0lwYCsUmmTdcaQGi3
        weyI6bk1P05XMFewD4suFQ==
X-Google-Smtp-Source: ABdhPJw0iescfn8O25Yt7XsiSUUqM/GRNh7g3KtGLFJc/07iO22Wlyt6LTh+CH9Qvxaegp7wOQhRcA==
X-Received: by 2002:a6b:7619:: with SMTP id g25mr25255iom.151.1626296163599;
        Wed, 14 Jul 2021 13:56:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i14sm1714108ilu.71.2021.07.14.13.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:56:03 -0700 (PDT)
Received: (nullmailer pid 3507153 invoked by uid 1000);
        Wed, 14 Jul 2021 20:56:02 -0000
Date:   Wed, 14 Jul 2021 14:56:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: PCI: ftpci100: convert faraday,ftpci100
 to YAML
Message-ID: <20210714205602.GA3507072@robh.at.kernel.org>
References: <20210628193508.2826903-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628193508.2826903-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Jun 2021 19:35:08 +0000, Corentin Labbe wrote:
> Converts pci/faraday,ftpci100.txt to yaml.
> Some change are also made:
> - example has wrong interrupts place
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixed issues reported by Rob Herring https://patchwork.kernel.org/project/linux-pci/patch/20210503185228.1518131-1-clabbe@baylibre.com/
> - moved comment as asked by Linus Walleij
> 
> Changes since v2:
> - fixed issues reported by Rob Herring https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210510203041.4024411-1-clabbe@baylibre.com/
> 
>  .../bindings/pci/faraday,ftpci100.txt         | 135 --------------
>  .../bindings/pci/faraday,ftpci100.yaml        | 176 ++++++++++++++++++
>  2 files changed, 176 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
> 

Applied, thanks!
