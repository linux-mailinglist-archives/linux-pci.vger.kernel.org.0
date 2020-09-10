Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C47264CD3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIJSZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:25:52 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39200 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgIJSYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 14:24:42 -0400
Received: by mail-il1-f196.google.com with SMTP id u20so6632102ilk.6;
        Thu, 10 Sep 2020 11:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ruc06lsfRVERcSDxNB2fAhTkJv2X63wPXUzyD97ULN8=;
        b=Sfz6Buih9nOnMA3Zzk/mpbGme296f72xeGt/356NfxwrxZnda9j2e7V8ZgsPZm2Lai
         1svcgXI4AzXQY4TUZforiPWuVisFAbiI3Kt8ToNkz11kuMZZzt8+LXOVdANopf0mS/5L
         6h08HQr4RSIz+JwUSS9knXl3A1M5Txn9nEyyz7Hsn/C/7jWJCksC0vM4XTqaDMGrDkzE
         6KWZJxU9z+FzSQlx7y7EVj19qsLxCs7ezB8wN5ULI6SW4ZKcn6+SOuJJLSVxHA2HG3+y
         FdWAOX9dLjFEHgGUntLqHLTjrgTlHJCvbw84NLs8ocT5u4AuMj17C678QDJu0LGLKfAh
         UybQ==
X-Gm-Message-State: AOAM5323J+MTTMNRZ9J7KeMgNIDCyVodE9mML2a2lX5g9kH8Iih3961V
        Q74VZlvd2nbThX0UaQS3dA==
X-Google-Smtp-Source: ABdhPJylVxfTh7SN41FPrdfTYFYOn2PGCxv3gdukB/jAYoB9si69LFWM0c7m/iT5duHJ6q98EYibnQ==
X-Received: by 2002:a92:d184:: with SMTP id z4mr7038898ilz.181.1599762280913;
        Thu, 10 Sep 2020 11:24:40 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a11sm3485910ilh.20.2020.09.10.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:24:40 -0700 (PDT)
Received: (nullmailer pid 631588 invoked by uid 1000);
        Thu, 10 Sep 2020 18:24:36 -0000
Date:   Thu, 10 Sep 2020 12:24:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-pci@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: uniphier: Add error message when failed to
 get phy
Message-ID: <20200910182436.GA631540@bogus>
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1596795922-705-7-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596795922-705-7-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 07 Aug 2020 19:25:22 +0900, Kunihiko Hayashi wrote:
> Even if phy driver doesn't probe, the error message can't be distinguished
> from other errors. This displays error message caused by the phy driver
> explicitly.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
