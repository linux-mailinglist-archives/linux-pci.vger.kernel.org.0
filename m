Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAAA264CB9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIJSV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:21:57 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41930 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgIJSUy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 14:20:54 -0400
Received: by mail-il1-f194.google.com with SMTP id f82so1926967ilh.8;
        Thu, 10 Sep 2020 11:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nm+cpWqF/0w8fPRtUs5YT9BMbNN+qWhAn3urvKoqdsQ=;
        b=asTBWdmTyIOn/eTV69q4+7ozP1Kt3gB2GR7ad7TMIDKhP86AGlY1wZnHpXbzlKe0Vf
         jGcsB6KZfXeNC6cXMJL/4841NpsAfmT05ubDPT4CNs2cpY4xmkats+vBxI2sDqHknBtW
         S2o0/ZXERVwiCH8oJum8ND3WODXaMMJGWMK0Q2W4D4ZmaAI/lr7L9/c6vE8RIxGudJRJ
         KqUh4tpA3CPhbhBHjC9u7E4zwZGpHrPHRK4IwbLmIQ+IL/JL0Ifhf5r0RFy1jRQQ0Uw/
         AmEAWHLnGmQsWIA9zxz0ln72N3ohLirdw+umemApbVjWn0pEBe2/+hlqe8yj5nWfBBJS
         b0dg==
X-Gm-Message-State: AOAM532+a+RQxwxutpbEIYHIGjYKXFcyVsi0qeEDBpXChsNPvpDVbgYL
        Z39LP8c4c7WnUEo9nRZ6Gg==
X-Google-Smtp-Source: ABdhPJzqhhjaHzYvYkjaNFzZT4HCADVFhWy5EKa/cO2kMKG2i/3FrZl2iswxcaos80RAbzMBsKOuNA==
X-Received: by 2002:a92:6f11:: with SMTP id k17mr9527739ilc.178.1599762044394;
        Thu, 10 Sep 2020 11:20:44 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z18sm3709635ill.1.2020.09.10.11.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:20:43 -0700 (PDT)
Received: (nullmailer pid 626172 invoked by uid 1000);
        Thu, 10 Sep 2020 18:20:42 -0000
Date:   Thu, 10 Sep 2020 12:20:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v6 2/6] PCI: dwc: Add msi_host_isr() callback
Message-ID: <20200910182042.GA626124@bogus>
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1596795922-705-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596795922-705-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 07 Aug 2020 19:25:18 +0900, Kunihiko Hayashi wrote:
> This adds msi_host_isr() callback function support to describe
> SoC-dependent service triggered by MSI.
> 
> For example, when AER interrupt is triggered by MSI, the callback function
> reads SoC-dependent registers and detects that the interrupt is from AER,
> and invoke AER interrupts related to MSI.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
