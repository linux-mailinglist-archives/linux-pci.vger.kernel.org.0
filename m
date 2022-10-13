Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E15FE2B9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJMTcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 15:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJMTcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 15:32:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAA1793AB;
        Thu, 13 Oct 2022 12:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 361D0B81CFB;
        Thu, 13 Oct 2022 19:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C3FC433D6;
        Thu, 13 Oct 2022 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665689541;
        bh=QRHJL54V4S+kCLjW93BfWGU2baP8jx0V5SQp/NcSw0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a0SLipyrNd8Pu5E9veuvvZHo3oXt+0QSxV3MduFng+9AoRMb1GvVuWkj1nqZxW++2
         FACMSrFaVEdAnBSseCORqlBTfQTGjBMzGX38fEZzsRVylT2lzQ3JBU16WesclEhCfh
         qjB2f0dg5Uadxrs13N/krLCc9DL+Qt7IZXLII4t3H2leFUoFicIzlK8Ng2K90soquo
         ubMzwmnyeM48X2GOlXPBWEDiH0Jxuk0c7smPb2BTXFWke1x/3FMRCGsl7RcAsya6Qh
         aS5aTwAfLMszMhLcJneALp2P3ebtXxoihXm2J8zce8XLNu0nXwixL88yT/TYmdU0j4
         C9f14XtBFU+QQ==
Date:   Thu, 13 Oct 2022 14:32:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dominic Rath <dominic.rath@ibv-augsburg.de>,
        krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
Message-ID: <20221013193219.GA3282648@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013191249.GA38183-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 02:12:49PM -0500, Rob Herring wrote:
> On Thu, Oct 13, 2022 at 08:26:47AM +0200, Dominic Rath wrote:
> > From: Alexander Bahle <bahle@ibv-augsburg.de>
> > 
> > Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
> > setting the PCIe PHY latencies.
> > The properties expect a list of uint32 PHY latencies in picoseconds for
> > every supported speed starting at PCIe Gen1, e.g.:
> > 
> >   max-link-speed = <2>;
> >   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
> >   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> ... 

> If PTM is a standard PCIe thing, then I don't think these should be 
> Cadence specific. IOW, drop 'cdns'. 

PTM is definitely a standard PCIe thing.  I had the same question.
