Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C6734F25
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFSJHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFSJHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 05:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF507B4;
        Mon, 19 Jun 2023 02:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441AA60B42;
        Mon, 19 Jun 2023 09:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A63C433C8;
        Mon, 19 Jun 2023 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687165653;
        bh=14J4WS+8yy469joEoEVl33nkw3ghjN+BWRbdAbpGaU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9tlb1O7jbTOkBZh0+L/dMVuqQVsH5U+Wy/XX47i0cD6T/QRklmp/GNNT2/XtMP80
         3YL4FQgWuyrs5jvAHOJ9wyD+9N8FSJuWyY9WB3ZBjYaGpF8NfjjoXsl0p/SNP+aHXg
         kVtja0B7ictQY+Ue96WUtQmr2jmfLVjdQ5uYIVO/bSWuuJb/TjurGkOd+Qg++4JSfz
         tiRGlwp/7c9UF6/tOnLRgds404eejjbY3Vu6zAP7SfsZdJUeHKHyyX6eQx/9U/peRZ
         3hH4JYTMV8EfDtL2desisfGwrWGJKryttrAQEFp/VLXW3nsV5en8Q+KXKzc1Ez9XMa
         gNs3HBK7H8XlQ==
Date:   Mon, 19 Jun 2023 11:07:24 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
 suspend and resume
Message-ID: <ZJAazCtc0jx3NDbM@lpieralisi>
References: <AS8PR04MB8676EC48C27C8A0DF8B35B648CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20230317222436.GA1978818@bhelgaas>
 <AS8PR04MB86765E47FE7AAECC121838188C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZB3I0gpds8OH2+gx@lpieralisi>
 <AS8PR04MB8676A79C4C4F43627D8FE4BC8C8B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZC2aBGlQRYHHDBqi@lpieralisi>
 <AS8PR04MB8676740A3B1F3159B8EC2DD78C959@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676740A3B1F3159B8EC2DD78C959@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 10, 2023 at 06:48:48AM +0000, Hongxing Zhu wrote:

[...]

> > I am getting back to this since I am still not convinced and I want to understand
> > this once for all.
> > 
> > We do use dw_pcie_find_capability() in most DWC drivers to find and peek/poke
> > at eg PCI express capability of the *Root port* (?),
> > 
> > eg dw_pcie_wait_for_link()
> > 
> > so I assume that for iMX6 dw_pcie_find_capability() does just the same, which
> > would mean that we are poking the "Message Control" field of the Root port MSI
> > capability.
> > 
> > Either that (which would mean that iMX6 has a HW bug because the RP Message
> > Control field does not control the delivery of MSIs from endpoints but just for the
> > root port itself ) or all DWC controllers modelled the root complex MMIO space as
> > a set of PCI/PCIe capabilities that are NOT necessarily mappable to PCI
> > specifications defined ones.
> > 
> > Can anyone please shed some light on this ? I don't have DWC HW, we need to
> > know before merging this code.
> Hi Lorenzo:
> Regarding my understanding, DWC HW has the PCI/PCIe capability map when
>  it works in RC mode and Spec doesn’t specify these Caps for host controller.
> And, there are comments describe these callbacks already in pcie-designware.c.
> ...
> /*
>  * These interfaces resemble the pci_find_*capability() interfaces, but these
>  * are for configuring host controllers, which are bridges *to* PCI devices but
>  * are not PCI devices themselves.
>  */
> static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>                                   u8 cap)
> ...
> 
> 

I still believe this is an integration bug, more so after reading the
commit Serge pointed out:

75cb8d20c112 ("PCI: imx: Enable MSI from downstream components").

The commit above implies that if you have CONFIG_PCIEPORTBUS enabled,
you would not need to set the MSI enable bit explicitly because that's
done by the port driver while requesting RP services.

This means that it is _seen_ by the PCI core as a capability register
and it also means that if you have CONFIG_PCIEPORTBUS enabled and that
the port driver disables MSIs, all downstream MSIs are disabled, not
only the RP ones (as it should be according to the PCI specs).

So, this is a HW bug I am afraid - I will merge this patch but AFAICS
the HW integration bug is there regardless, however we slice it.

Thanks,
Lorenzo
