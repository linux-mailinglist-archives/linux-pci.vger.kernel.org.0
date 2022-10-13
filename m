Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F845FE286
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 21:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJMTNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJMTMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 15:12:52 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1F5DCADA;
        Thu, 13 Oct 2022 12:12:51 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1324e7a1284so3415548fac.10;
        Thu, 13 Oct 2022 12:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvmLPN93NfeChb0w/5z2OoxfJl3mK9CvpEnFPiEEs9U=;
        b=GF9VxDVZ+PiFMI5at6MVKntBr4Xr7ICReWIATw8ORB0fV35X7FGmg/myHQEIbA8zOb
         aRCs4fxyHfMxGnkahdDl7RjY7yisRBw0voCfOj3uvPZ055KLj02n/CQp/dQMff8QuFy0
         x3mW3h3XRr3epXh1I1dV/Na9a9lNYkWYpZCs5nl1BFD3KjMNYOzwxSsgV2rnLRisS8wn
         YeVoc7qMAMqzjlKZs8nv/jzgfdpaeAI0/v1xpohvgjylP0uXmPntO8dVsUjTlfBNiicR
         ChKMwH+u+yPUtl6Oxe4fqIR3YjFiZVy/d0/kYzrQ9SvA9+X8dZb3UiRBHHZ9rSI86gFK
         /IaQ==
X-Gm-Message-State: ACrzQf1v3W6JxVE0pDuxVK8JgV077AFuANlO0AbiIZbEmtSSX1jWqONH
        m+VTSoF5QmqTvucriLGdqw==
X-Google-Smtp-Source: AMsMyM5/4v34VXqkJgTLfj8HVFqk28z3MMw69mGHEpX6fWU990QrSM4bLDCozBV/m0BU3AHt9fR4IQ==
X-Received: by 2002:a05:6870:608e:b0:12b:c0de:bc9d with SMTP id t14-20020a056870608e00b0012bc0debc9dmr731014oae.52.1665688370538;
        Thu, 13 Oct 2022 12:12:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x3-20020a4ae783000000b004807de5c302sm107810oov.17.2022.10.13.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:12:49 -0700 (PDT)
Received: (nullmailer pid 92150 invoked by uid 1000);
        Thu, 13 Oct 2022 19:12:49 -0000
Date:   Thu, 13 Oct 2022 14:12:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dominic Rath <dominic.rath@ibv-augsburg.de>
Cc:     krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
Message-ID: <20221013191249.GA38183-robh@kernel.org>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
 <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 08:26:47AM +0200, Dominic Rath wrote:
> From: Alexander Bahle <bahle@ibv-augsburg.de>
> 
> Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
> setting the PCIe PHY latencies.
> The properties expect a list of uint32 PHY latencies in picoseconds for
> every supported speed starting at PCIe Gen1, e.g.:
> 
>   max-link-speed = <2>;
>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */

These are a property of the PHY or PCI host? Sounds like PHY to me and 
that should be in the PHY node. No reason the PCI driver can't go read 
PHY node properties.

If PTM is a standard PCIe thing, then I don't think these should be 
Cadence specific. IOW, drop 'cdns'. 

Rob
