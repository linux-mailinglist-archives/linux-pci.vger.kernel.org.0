Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2B6F0BF1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 20:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbjD0Sau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbjD0Sao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 14:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C6C469A;
        Thu, 27 Apr 2023 11:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260A063F0A;
        Thu, 27 Apr 2023 18:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B61C433EF;
        Thu, 27 Apr 2023 18:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682620242;
        bh=NiPVASGTL10NsQ2t5nKmx3Y9actc0pulKd/ynk55T3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mmg5Z4peeCtCbta+mpL3brQO89VZ8CbOpm4Iy47TehE8T9qb8QsCTWUbYeRTkUwFF
         1L3mkekbJT2VaDNNaHUzzZkcyYIWPLfR4VG6n9r82kx3Lw35pa9WP9RgY6VW9KJiPU
         DxwivkgxeMF6ntqRZ8p6rXH1zt95K1ngQJYAGM+stk6bXk+fLtE6xEVpjCyb54YPh7
         W4qiFzEzN+2GKh2K8qoMNb2+5Up3cchUvTLpENbGpOb1ETX8zbflvP/ENh9vSyolNi
         yY4GWZf/ayLT0X9i1f6PaZTT5uYENDK4Hi28yAMg5EQwkFFPV6xd9LLNfzbGU18eAy
         rgzo7rSKyze9w==
Date:   Thu, 27 Apr 2023 13:30:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dominic Rath <rath@ibv-augsburg.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com, bhelgaas@google.com, lpieralisi@kernel.org,
        nm@ti.com, vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        christian.gmeiner@gmail.com, bahle@ibv-augsburg.de
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency
 properties
Message-ID: <20230427183040.GA263395@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427055032.85015-2-rath@ibv-augsburg.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 07:50:30AM +0200, Dominic Rath wrote:
> From: Alexander Bahle <bahle@ibv-augsburg.de>
> 
> Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
> setting the PCIe PHY latencies.
> The properties expect a list of uint32 PHY latencies in picoseconds for
> every supported speed starting at PCIe Gen1, e.g.:
> 
>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */

Are these things that could/should be described in a more generic
place?  They don't look necessarily Cadence-specific.

Bjorn
