Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694246DCFC1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDKCgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 22:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDKCgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 22:36:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90626B2;
        Mon, 10 Apr 2023 19:36:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h12so3662402lfj.8;
        Mon, 10 Apr 2023 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681180594; x=1683772594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryXtbfRI/jstwh7DoB7ytVR8A4UxPsGFr890Bq2wcsw=;
        b=Fs5DzYjPDnocAKCDNiD3JWo3tpGPaB3GrE9UZJokrnPBHpaBE/07CH2AXiTOaJ/OQS
         7NOQJvU1xuuZ9bzqbVyy6Pv9NdV76x+Fw/rAI/2zlSjeTtUJK4RWJWdibP+9kLbR0T04
         iMxP4WoV7Ar4HjbHrVcIP+DalirmK4amqrHdEjT7dP8RF02PVLhcRDlBP1tegOgmNYuw
         KfahlM37LQTuFX8TXxaCVdC9C+hMqFlz5E+GCqOK9jUo0OoWEK4bnKVkVYsMr2OhmUp/
         0SWO8yaU9driTfWmAraoXak4vl2vLNIi8s0YjX4ToOecI7DMya+e8U0EL1wv6gSAQHiG
         8OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681180594; x=1683772594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryXtbfRI/jstwh7DoB7ytVR8A4UxPsGFr890Bq2wcsw=;
        b=3hViuPDZl2zo1eFKQ09fjC5nYMAwsK15eHyAduHrAwswv2VQf3CWAtw/OXCEfE6aU/
         i35H0gy002veoW9s4B8CLA2lHhIbbPFbNRUD8ioYuHsHj1jzckatdXn1CAk0PaKiYfcA
         KZbcK9eMTTT+fwtKsU++R1zcHFl39aRY4CwpwFyBzlVlOln64b7CUdiz9edMFO6/lT27
         TsN14DwbRQQUN7BSu340z538iPTLHC6coknoXfwAeeKdA6EF+FPhdSIZopGrPydASBBN
         9oRfvFWW4Bpu0eXB5/tPVKm2uPRiNgxTzKltuRKt8BB+yve/hS6vHtfZeeOW+ikkEg0I
         rTuA==
X-Gm-Message-State: AAQBX9fp3lNk8FVcpvz0VHtm3vPSUKscDEvxhF7BMIdPCxeKP8b0gM76
        G8pjyd9aLwnz0Uj9k1li7f4=
X-Google-Smtp-Source: AKy350bsFHTiFElDI8LjkPIhUS1yq/z4Zcc/dQLQe3pSWHfUqlWAPWjMVTzYlehrO1zaO/ZhcCtaRw==
X-Received: by 2002:a19:f617:0:b0:4eb:982:adf with SMTP id x23-20020a19f617000000b004eb09820adfmr2942231lfe.26.1681180593693;
        Mon, 10 Apr 2023 19:36:33 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004e9b307d2c8sm2331899lfi.238.2023.04.10.19.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 19:36:33 -0700 (PDT)
Date:   Tue, 11 Apr 2023 05:36:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20230411023631.3g7oom3mj6sp27k4@mobilestation>
References: <AS8PR04MB8676EC48C27C8A0DF8B35B648CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20230317222436.GA1978818@bhelgaas>
 <AS8PR04MB86765E47FE7AAECC121838188C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZB3I0gpds8OH2+gx@lpieralisi>
 <AS8PR04MB8676A79C4C4F43627D8FE4BC8C8B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZC2aBGlQRYHHDBqi@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2aBGlQRYHHDBqi@lpieralisi>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 05:55:48PM +0200, Lorenzo Pieralisi wrote:
> [+Cc Sergey]
> 

Hi Lorenzo

[nip]

> > > 
> > > That's because a PCI root complex is not a PCI device (and this is not an MSI
> > > capability, which lives in PCI config space).
> > > 
> > > I will reword it (and the commit log with it) and merge it in the coming weeks for
> > > v6.4
> > Hi Lorenzo:
> > Thanks a lot for your kindly help.
> 
> I am getting back to this since I am still not convinced and I want to
> understand this once for all.
> 
> We do use dw_pcie_find_capability() in most DWC drivers to find and
> peek/poke at eg PCI express capability of the *Root port* (?),
> 
> eg dw_pcie_wait_for_link()
> 
> so I assume that for iMX6 dw_pcie_find_capability() does just the same,
> which would mean that we are poking the "Message Control" field of the
> Root port MSI capability.

Absolutely right. Besides of the standard PCIe config space which is
filled with the various PCIe capability registers, the DW PCIe Root
Port has the "Port Logic" CSR space with the DW PCIe-specific
settings: GENx Link control and lanes tuning stuff, iMSI-Rx engine,
iATU/eDMA, etc. Some of the capabilities are utilized by their direct
functionality (like the PCI Express capability) meanwhile some are
left unused even though they can be activated during the IP-core
synthesize stage. I don't know why the HW designers left them being
optionally enabled and then available for some setups, DW PCIe RC
HW-manual doesn't have their functionality description. The MSI
capability is one of such PCIe capabilities. It's described in the DW
PCIe RC registers space HW-manual and the DW PCIe RC IP-core
parameters, but the rest of the manual text has nothing about it.

Also note even though the DW PCIe RC HW-manual has _RC_ in the name it
actually describes the PCIe Root Port with the attention remark: "The
Synopsys PCI Express IP does not implement a full root complex."

So from what I can see there can be several reasons of such
configuration:
1. It simplifies the dual-mode device design for the HW-engineers.
Though IMO Synopsys at least should have dropped the unused
capabilities from the RP HW-manual.
2. Synopsys may imply that these capabilities can be used somehow
for the vendor-specific true Root Complex designs. Though they don't
specifically say about that. Instead there is a note: "To implement a
full root complex, you must add your application logic (connected to
the application client interface or AXI interface) and other support
logic (including clock and reset generation)."

> 
> Either that (which would mean that iMX6 has a HW bug because the RP
> Message Control field does not control the delivery of MSIs from
> endpoints but just for the root port itself )

I wouldn't call it a HW bug seeing the MSI capability registers are
actually unused by the RP controllers. So it looks more like the
iMX6-specific feature. See a short explanation in the commit
75cb8d20c112 ("PCI: imx: Enable MSI from downstream components").

Normally MSI event delivery to the CPU doesn't depend on the actual
MSI capability CSRs state in DW PCIe RPs. Instead the MSI is
configured via the Port Logic iMSI-RX registers. That's what is done
in the DW PCIe host driver (see pcie-designware-host.c).

> or all DWC controllers
> modelled the root complex MMIO space as a set of PCI/PCIe capabilities
> that are NOT necessarily mappable to PCI specifications defined ones.

Basically you are right though as I noted above Synopsys doesn't
provide a complete RC solution. It's just a single RP with the MMIO
(DBI) CSRs looking as the PCIe TYPE1 config space.

-Serge(y)

> 
> Can anyone please shed some light on this ? I don't have DWC HW, we need
> to know before merging this code.
> 
> Thanks,
> Lorenzo
> 
> > 
> > Best Regards
> > Richard Zhu
> > > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > +        *
> > > > +        * The MSI_EN bit of MSI control register contained in this MSI-CAP
> > > > +        * is used control the MSI delivery of MSI interrupts from components
> > > > +        * below the Root Port.
> > > > +        *
> > > > +        * Find it by PCI_CAP_ID_MSI here, and assert the MSI_EN bit to
> > > allow
> > > > +        * the MSI delivery below the Root Port, if the PCI MSI is enabled.
> > > > +        */
> > > >         if (pci_msi_enabled()) {
> > > >                 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > > >                 dw_pcie_dbi_ro_wr_en(pci); Best Regards Richard Zhu
> > > > >
> > > > > Bjorn
> 
