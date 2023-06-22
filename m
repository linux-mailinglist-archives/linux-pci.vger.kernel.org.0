Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91EA73ACB8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjFVWw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVWw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 18:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EE10C
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 15:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 020E66192D
        for <linux-pci@vger.kernel.org>; Thu, 22 Jun 2023 22:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B99EC433C8;
        Thu, 22 Jun 2023 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687474344;
        bh=xhjepokCxvyS6BuPk30WbTTOsaZ/amw6gdG5sknV3l0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Uh3YsSJKY3joSdIJ5PBDmqWImz5eUD221XMKlBtCuB4j5Tw2/w2UQ7PTuJYGrBxbC
         /gWlP40jGI7Pq+yUAthosjZy0jctBjG3GYqXpgwh1z842s40HrvZIE+bKbfIsFVTyy
         TOMKfDzknIiqv13BczAitk02Uhx7Arh/IO90C8E6hf2boRLbjK+X23AddkA1YuKF0N
         G3M5dxFRwb3r7nWYDgxLSTFpruogIQ2WdPE3h2kLoHxlLbuaDfdA3bBTONBAhki/mC
         PmQiEDJqu/On4rR5B+UAZzYoQLm/w3xF9MAOcBr+vYEgk/EK93+xUDazRlgJWHxQIU
         FJfWCCT+2bH5w==
Date:   Thu, 22 Jun 2023 17:52:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, vsethi@nvidia.com,
        jbodner@nvidia.com, kthota@nvidia.com
Subject: Re: Query about setting MaxPayloadSize for the best performance
Message-ID: <20230622225221.GA154188@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bde8aa8-d385-aadb-f60b-9a81e7bf165c@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 11:04:03AM +0530, Vidya Sagar wrote:
> 
> Hi,
> This is about configuring the MPS (MaxPayloadSize) in the PCIe hierarchy
> during enumeration. I would like to highlight the dependency on how the MPS
> gets configured in a hierarchy based on the MPS value already present in the
> root port's DevCtl register.
> 
> Initial root port's configuration (CASE-A):
>     Root port is capable of 128 & 256 MPS, but its MPS is set to "128" in
> its DevCtl register.
> 
> Observation:
>     CASE-A-1:
>         When a device with support for 256MPS is connected directly to this
> root port, only 128MPS is set in its DevCtl register (though both root port
> and endpoint support 256MPS). This results in sub-optimal performance.

Yes.  We could set both to 256.  But I think there's a potential issue
for peer-to-peer transactions, isn't there?  E.g., 

  00:01.0 Root Port to [bus 01], MPSS=256 MPS=256
  00:02.0 Root Port to [bus 02], MPSS=256 MPS=128
  01:00.0 Endpoint, MPSS=256 MPS=256
  02:00.0 Endpoint, MPSS=128 MPS=128

02:00.0 is only capable of MPS=128, so it and 00:02.0 are set to that.
Now 01:00.0 does a DMA write to  02.00.0 and sends a single 256-byte
TLP.

>     CASE-A-2:
>         When a device with only support for 128MPS is connected to the root
> port through a PCIe switch (that has support for up to 256MPS), entire
> hierarchy is configured for 128MPS.
> 
> Initial root port's configuration (CASE-B):
>     Root port is capable of 128 & 256 MPS, but its MPS is set to "256" in
> its DevCtl register.
> 
> Observation:
>     CASE-B-1:
>         When a device with support for 256MPS is connected directly to this
> root port, 256MPS is set in its DevCtl register. This gives the expected
> performance.
>     CASE-B-2:
>         When a device with only support for 128MPS is connected to the root
> port through a PCIe switch (that has support for upto 256MPS), rest of the
> hierarchy gets configured for 256MPS, but since the endpoint behind the
> switch has support for only 128MPS, functionality of this endpoint gets
> broken.
> 
> One solution to address this issue is to leave the DevCtl of RP at 128MPS
> and append 'pci=pcie_bus_perf' to the kernel command line. This would change
> both MPS and MRRS (Max Read Request Size) in the hierarchy in such a way
> that the system offers the best performance.
> 
> I'm not fully aware of the history of various 'pcie_bus_xxxx' options, but,
> since there is no downside to making 'pcie_bus_perf' as the default, I'm
> wondering why can't we just use 'pcie_bus_perf' itself as the default
> configuration instead of the existing default configuration which has the
> issues mentioned in CASE-A-1 and CASE-B-2.

I'm definitely not happy with our MPS configuration.  I guess I should
be glad that at least we don't have build-time config options for it.

Anyway, it would be great if somebody would clean it up and make it
more sensible.

The peer-to-peer thing is a big issue because I don't think the RC is
required or maybe even allowed to split TLPs to accommodate devices
with smaller MPS.

I'm not even sure the RC is required to route TLPs between Root Ports
(see pci_p2pdma_whitelist[]), and I don't think that functionality is
discoverable either directly from PCIe or via a firmware interface.

But there's some new stuff in PCIe r6.0 related to MPS; I haven't
really dug into it, but maybe some of that can help?

You've likely seen "Understanding Performance of PCI Express Systems"
by Jason Lawley, from Oct 28, 2014 [1].  It's a good analysis of MPS,
MRRS, RCB, etc.

Bjorn

[1] https://docs.xilinx.com/v/u/en-US/wp350
