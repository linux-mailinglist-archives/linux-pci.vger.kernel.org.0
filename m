Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB53DF7C2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhHCWXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 18:23:08 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:39646 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHCWXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 18:23:07 -0400
Received: by mail-io1-f53.google.com with SMTP id f6so221670ioc.6;
        Tue, 03 Aug 2021 15:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vjGdtgOlhKD6T/Y7y+vqQm8JON196rARUlkKY8t6Xc=;
        b=sap1TsKD5gcb5wKFplVtoM6hueg59GZdOzmGb/YOVTa3G0AwiMvGvXi5UAheQEffmq
         WpJUogkD+P6pJASAqFYJA/FKjjx3XHbypOvu7h5aVmbr6vS6+mwmGuZbg6buW0l/7VO6
         eBRhvHy3aHfuWvosrxCmhk4Z48uJGJPvp+Be5TnwzgSytqBdstPocvmMaLDV3TjD4f09
         Cwyra9xyYC51wOI0k55heeNurNiRv/Qk+bDOTnvQNGYMdg6rxTSCKSaZ9EP2Wzz7a8Lu
         9l0bNZS4OJ7TtcqLRj2wgA6I5iKp1dSqSCH2OHuY8aQdcm0AaMKqchK5CqjAq+xN6Osr
         lZ3w==
X-Gm-Message-State: AOAM5301GSiYJYUJlKyFKs9/dORQB6OuYFw51RCq2011apsx0p9f1uy0
        zlpaIEnZpMPWIMpdasJofqNULGbsZg==
X-Google-Smtp-Source: ABdhPJyKKzVfEwjBGSMSfFidncWQsibFwTzulMUmOpTrvtt9JIlwsG2TDBPZI3CK0+hyN+cuB7hKwQ==
X-Received: by 2002:a5d:925a:: with SMTP id e26mr698551iol.195.1628029375748;
        Tue, 03 Aug 2021 15:22:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l5sm249272ion.44.2021.08.03.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:22:55 -0700 (PDT)
Received: (nullmailer pid 3835626 invoked by uid 1000);
        Tue, 03 Aug 2021 22:22:53 -0000
Date:   Tue, 3 Aug 2021 16:22:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: kirin: Fix compatible string
Message-ID: <YQnBvbXK6p9t7jxh@robh.at.kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <3e3e29a88f8e71eb228edf33d70cbe70db431408.1627965261.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3e29a88f8e71eb228edf33d70cbe70db431408.1627965261.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 03 Aug 2021 06:38:55 +0200, Mauro Carvalho Chehab wrote:
> The pcie-kirin driver doesn't declare a hisilicon,kirin-pcie.
> Also, remove the useless comment after the description, as other
> compat will be supported by the same driver in the future.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/kirin-pcie.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
