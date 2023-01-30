Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD36814C5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 16:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjA3PVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 10:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjA3PVR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 10:21:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7623C2A8
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 07:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94FA8B811DD
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 15:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C528C433EF;
        Mon, 30 Jan 2023 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675092073;
        bh=dqeaUxrfJ+mcQITtQN4PuLnm7Acxsx/f4rPkJwjLVwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a1g6i4H4tu2NIhKGSo6CamIiAfY1LYX7fh+23WGEE7jh/8NuF1B505ACEkP2M3BOw
         kz0giIx8k9serZ1z46o5Jd3hcNhonbQrb11GSI+rVSsWOTbBvbN/3TQxZcfSxDk3gG
         XWAlCxwBEV93npYYNaJpK0vv+d/1mRhW5D+xxa6uVKZgcmEoMMAT4aquMwU+oVIT3b
         lTh/ssoeGad4/EnhNxa2IgyI9V+Xk67j3gbSoRKMUYBE5cePtEmthPJJdwLLnorKYD
         qcGQuCeooeBUVyGtBHoRoNU9OZAVSZU6eLp5tfaE3XFZcS7JkIRKX78HkIkUiJdtDi
         KumIjzcvthQ3g==
Date:   Mon, 30 Jan 2023 09:21:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Message-ID: <20230130152111.GA1673431@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128013951.523247-1-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mario, Shyam, Brijesh]

On Sat, Jan 28, 2023 at 10:39:51AM +0900, Damien Le Moal wrote:
> PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
> guest OS fails to correctly probe devices attached to the controller due
> to FIS communication failures. 

What does a FIS communication failure look like?  Can we include a
line or two of dmesg output here to help users find this fix?

AMD folks: Can you confirm/deny that this is a hardware erratum in
this device?  Do you know of any other devices that need a similar
workaround?

> Forcing the "bus" reset method before
> unbinding & binding the adapter to the vfio-pci driver solves this
> issue. I.e.:
> 
> echo "bus" > /sys/bus/pci/devices/<ID>/reset_method
> 
> gives a working guest OS, thus indicating that the default flr reset
> method is defective, resulting in the adapter not being reset correctly.
> 
> This patch applies the no_flr quirk to AMD FCH AHCI devices to
> permanently solve this issue.
> 
> Reported-by: Niklas Cassel <niklas.cassel@wdc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 285acc4aaccc..20ac67d59034 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5340,6 +5340,7 @@ static void quirk_no_flr(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  
> -- 
> 2.39.1
> 
