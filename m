Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460E7A44E7
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 10:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjIRIiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbjIRIiA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 04:38:00 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB891
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 01:37:54 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 85719300002D0;
        Mon, 18 Sep 2023 10:37:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7B4DFCC610; Mon, 18 Sep 2023 10:37:52 +0200 (CEST)
Date:   Mon, 18 Sep 2023 10:37:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Message-ID: <20230918083752.GA26918@wunner.de>
References: <20230918053041.1018876-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918053041.1018876-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> Mark Blakeney reported that when suspending system with a Thunderbolt
> dock connected and then unplugging the dock before resume (which is
> pretty normal flow with laptops), resuming takes long time.
> 
> What happens is that the PCIe link from the root port to the PCIe switch
> inside the Thunderbolt device does not train (as expected, the link is
> upplugged):
> 
> [   34.903158] pcieport 0000:00:07.2: restoring config space at offset 0x24 (was 0x3bf12001, writing 0x3bf12001)
> [   34.903231] pcieport 0000:00:07.0: waiting 100 ms for downstream link
> [   36.140616] pcieport 0000:01:00.0: not ready 1023ms after resume; giving up
> 
> However, at this point we still try the resume the devices below that
> unplugged link:
> 
> [   36.140741] pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> ...
> [   36.142235] pcieport 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
> ...
> [   36.144702] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation
> 
> And this is the link from PCIe switch downstream port to the xHCI on the
> dock:
> 
> [   38.380618] xhci_hcd 0000:03:00.0: not ready 1023ms after resume; waiting
> [   39.420587] xhci_hcd 0000:03:00.0: not ready 2047ms after resume; waiting
> [   41.527250] xhci_hcd 0000:03:00.0: not ready 4095ms after resume; waiting
> [   45.793957] xhci_hcd 0000:03:00.0: not ready 8191ms after resume; waiting
> [   54.113950] xhci_hcd 0000:03:00.0: not ready 16383ms after resume; waiting
> [   71.180576] xhci_hcd 0000:03:00.0: not ready 32767ms after resume; waiting
> ...
> [  105.313963] xhci_hcd 0000:03:00.0: not ready 65535ms after resume; giving up
> [  105.314037] xhci_hcd 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
> [  105.315640] xhci_hcd 0000:03:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
> ...
> 
> This ends up slowing down the resume time considerably. For this reason
> mark these devices as disconnected if the link above them did not train
> properly.
> 
> Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
> Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
