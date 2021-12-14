Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A988474DCD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhLNWQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:16:21 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36582 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhLNWQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:16:21 -0500
Received: by mail-ot1-f42.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so22560620otl.3;
        Tue, 14 Dec 2021 14:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkBF7tydZwe3fLlVXfrJFUDv8byIIpiRtg0fOn9bNSs=;
        b=fvfRjFh5BPebItfpu0cOolETc3aUXJNjw4m/I5k8yM6HDslbMwROXh3i91AG9vslDN
         fpPEf5Gh+OJ0x63t0Oo4uT/aoXYyGbQfXjYFHwlwiJwYDVaP+IExqHE/L5HYWMRoSnfJ
         VyUemkX6D57OBRs5Tdd5HEHQHN183XcNeK5UWl0xUeZESyPGO6CCqMQ7ys/BiL0O3hDH
         zaosPAyk5OS48fGgBr2xOrS/jpzUOJ1rC8ipVUc29CSmb62OaPsgWEpf5ziFT42EYpYB
         XDPPcmxqYvFOgakZoNaOP1M+0KGaReO0keMBfxJSFv5ptbesREdgnfjjjEAaEwVlhPt2
         4HMw==
X-Gm-Message-State: AOAM530oaAqsFIOaTzg7rR9yglAhr7IxaQcpJCt1BNWOaNXvLmT/BjLe
        FAwblaApqbhJP+8jsxVhdQ==
X-Google-Smtp-Source: ABdhPJx2Hc+FIgHvYG+4ZLNFwAPXAdhIOSokQMhZeHGaeFWA5xFzSrgvzHNUDyfKiQY0sjkEkUd25w==
X-Received: by 2002:a9d:ef8:: with SMTP id 111mr6560601otj.218.1639520180718;
        Tue, 14 Dec 2021 14:16:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k8sm48010oon.2.2021.12.14.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:16:20 -0800 (PST)
Received: (nullmailer pid 4052745 invoked by uid 1000);
        Tue, 14 Dec 2021 22:16:19 -0000
Date:   Tue, 14 Dec 2021 16:16:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: cdns-ep: Fix 'unevaluatedProperties'
 warnings
Message-ID: <YbkXs6x/nyBe6YOO@robh.at.kernel.org>
References: <20211206194413.2469643-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206194413.2469643-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Dec 2021 13:44:13 -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the TI j721e endpoint
> binding example has a warning:
> 
> Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.example.dt.yaml: pcie-ep@d000000: Unevaluated properties are not allowed ('max-link-speed', 'num-lanes', 'max-functions' were unexpected)
> 
> Adjust where pci-ep.yaml is referenced so that ti,j721e-pci-ep.yaml will
> include it.
> 
> Cc: Tom Joseph <tjoseph@cadence.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml | 1 -
>  Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml      | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
