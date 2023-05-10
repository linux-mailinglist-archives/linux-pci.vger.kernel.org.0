Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36936FE5FC
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjEJVMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJVMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 17:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBDE53;
        Wed, 10 May 2023 14:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C74356358F;
        Wed, 10 May 2023 21:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1710C433EF;
        Wed, 10 May 2023 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683753130;
        bh=HizRoK5fj7AB/DRhebcy+ie0+Ty6tdVrnKdXSa4wsjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pGqgAfOa2dGWGZoJHS1lFroIibP2K6fxBIvBd+qM9kAnQR7Z9RJk7NSrK09c1DZcD
         5TrjP2IkYOVMmv/OOAn/Cac2i9uWDMaR2iBqvK4EetkMjQ4MatOjfWnMBLKuFRAr9d
         tynbPwoBMRFMWws0nMSOOb/lvhedrRQGqMBvbFSe/xg9+cS0rm6nvBv7pQfsnYAFFS
         Bv5lKlRaySTU+4VIYHETHrP78FwDcbw6l7WbpurBfnskH66piJA/ydlS0UkoNB+3C7
         hhXNDzmPsxQBgGx+gcouNL6HOSfR4IvMVFGq6XoCIRdXnruDM9l48vr5aagBOlxwXZ
         +wMEwQU7sChQQ==
Date:   Wed, 10 May 2023 16:12:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dominic Rath <rath@ibv-augsburg.de>,
        krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency
 properties
Message-ID: <ZFwIqBRj8in1CaGB@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a36a4ad-6d46-4e4e-1724-ed27513a72ef@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 09:08:39AM +0200, Krzysztof Kozlowski wrote:
> On 09/05/2023 23:57, Bjorn Helgaas wrote:
> > On Tue, May 09, 2023 at 05:31:19PM +0200, Christian Gmeiner wrote:
> >>> On Thu, Apr 27, 2023 at 07:50:30AM +0200, Dominic Rath wrote:
> >>>> From: Alexander Bahle <bahle@ibv-augsburg.de>
> >>>>
> >>>> Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
> >>>> setting the PCIe PHY latencies.
> >>>> The properties expect a list of uint32 PHY latencies in picoseconds for
> >>>> every supported speed starting at PCIe Gen1, e.g.:
> >>>>
> >>>>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
> >>>>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
> >>>
> >>> Are these things that could/should be described in a more generic
> >>> place?  They don't look necessarily Cadence-specific.
> >>
> >> As there is currently no generic binding, would you like to see a new
> >> yaml binding
> >> added (Documentation/devicetree/bindings/phy/phy.yaml) that contains just the
> >> two phy properties?
> > 
> > The whole thing is more a question for Rob.
> 
> For which you might wait a bit currently.
> 
> If the question is only about location of the properties - device schema
> or something generic - then for now you can keep it here. Moving to
> generic schema is always easy later.
> 
> Better to have proper names for properties.

Good point.  The current names seem fine to me since the names
themselves aren't Cadence-specific.

Bjorn
