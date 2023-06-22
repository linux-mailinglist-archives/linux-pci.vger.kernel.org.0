Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF43739778
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFVGbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 02:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 02:31:11 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D9199B;
        Wed, 21 Jun 2023 23:31:07 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A08CB100DE9CC;
        Thu, 22 Jun 2023 08:31:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6D020182012; Thu, 22 Jun 2023 08:31:05 +0200 (CEST)
Date:   Thu, 22 Jun 2023 08:31:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230622063105.GA624@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 21, 2023 at 06:51:52PM +0000, Smita Koralahalli wrote:
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -102,6 +102,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  
>  	pci_lock_rescan_remove();
>  
> +	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_DEVCTL2,
> +				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ |
> +				    PCI_EXP_DEVCTL2_TAG_REQ_EN));
> +

Hm, this will clear the bits while the device may still be present.
Note that the subsequent pci_stop_and_remove_bus_device() will unbind
the driver and may thus cause communication with the device.
Can clearing those bits in the hotplug port hamper communication with
the device?

I'd recommend avoiding that issue altogether by clearing the bits at
the end of the function after the call to pci_unlock_rescan_remove(),
so that negotiated state of the hotplug port gets cleared after all
subordinate devices are de-enumerated.

The commit message doesn't point out that PCI_EXP_DEVCTL2_ARI is
already being taken care of on enumeration of future subordinate
devices in pci_configure_ari() and is only cleared here for good
measure.  If you intend to configure 10 bit tags and atomic ops
on enumeration in future patches, I'd recommend omitting
PCI_EXP_DEVCTL2_ARI here and clearing each of the other two bits
in the future patches which configure them on enumeration.

You don't need braces around the "or" operation for the bits.

Thanks,

Lukas

>  	/*
>  	 * Stopping an SR-IOV PF device removes all the associated VFs,
>  	 * which will update the bus->devices list and confuse the
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index dc2000e0fe3a..6fbc47f23d52 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -668,6 +668,7 @@
>  #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
>  #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
>  #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
> +#define  PCI_EXP_DEVCTL2_TAG_REQ_EN	0x1000  /* Allow 10 Tags for Requester */
>  #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
>  #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
>  #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
> -- 
> 2.17.1
