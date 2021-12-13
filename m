Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6184734CA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 20:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhLMTSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 14:18:20 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37690 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhLMTST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 14:18:19 -0500
Received: by mail-oi1-f182.google.com with SMTP id bj13so24526648oib.4;
        Mon, 13 Dec 2021 11:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/zNofg9s1DxdI5VeTHZvff8L4CaAo1nQD16KrTGNeo=;
        b=xfWbCDbMkLPxjauAS2rFgE0Jc7ECFyH2cLsNKd6rQon+zEhXpSJZBiHyzGcKAquN1Q
         U25t7tKKicxlhb31XBa4IvNRxaWVK7bf9EnwXF8RnicLSWl+zqw6N5ByiSm7fm94Cl60
         ERH4jD6kDySJrPQBISj4gF6sZ4674QIiCNL3m+94JSBDDz4XfjtnWfGhszf3fWtYRRZk
         1mOzBjnGNmf1URvimDF6VEYRIPJf/Wem10NnkeqaiH9xLfGL77b3r7RxFHhlNyR79yWv
         NjadocXZUjBNqbLsFQePm9E1gnpowO2sB5wOKVVls1yHR+RgHM1dh9+JaY6yUpISdIb5
         8usA==
X-Gm-Message-State: AOAM533wwY1IU7kWhnKL7OijAO5B4HsfY8OIBqKfD2vPnvOqBgvoP9oO
        sjvQOeOENKrAolBQbHUCFQ==
X-Google-Smtp-Source: ABdhPJxgR3bMAASLLVa1GRLK96PgQv2XYW3WIaufufWwqdTssF9f7ALWr0YgiR70uVViS38+5kzRVQ==
X-Received: by 2002:a05:6808:2016:: with SMTP id q22mr475655oiw.81.1639423098988;
        Mon, 13 Dec 2021 11:18:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v20sm2286544otj.27.2021.12.13.11.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:18 -0800 (PST)
Received: (nullmailer pid 1410569 invoked by uid 1000);
        Mon, 13 Dec 2021 19:18:17 -0000
Date:   Mon, 13 Dec 2021 13:18:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: pci: layerscape-pci: define AER/PME
 interrupts
Message-ID: <YbececugsiFdOh0H@robh.at.kernel.org>
References: <20211202004636.5276-1-leoyang.li@nxp.com>
 <20211202004636.5276-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202004636.5276-5-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 01 Dec 2021 18:46:36 -0600, Li Yang wrote:
> Different platforms using this controller are using different numbers of
> interrupt lines and the routing of events to these interrupt lines are
> different too.  So instead of trying to define names for these interrupt
> lines, we define the more specific AER/PME events that are routed to
> these interrupt lines.
> 
> For platforms which only has a single interrupt line for miscellaneous
> controller events, we can keep using the original "intr" name for
> backward compatibility.
> 
> Also change the example from ls1021a to ls2088a for better representation.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../bindings/pci/layerscape-pci.txt           | 40 +++++++++++--------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
