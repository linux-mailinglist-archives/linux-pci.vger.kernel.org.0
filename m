Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5884F93FB
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiDHL22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiDHL2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 07:28:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38C819288
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 04:26:20 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9232D3F369
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649417178;
        bh=TlvQVB5MMhFkpcx7NoQ85ETd+2hV1Om6HXECryb4lPk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Il4Hb1EWNFpOBvNfE4li9XjVslw6C5FptiIJeoTrvUTKkJBpfkFdO9kLzpjA4/tA3
         QKAuNfYkFAqeL7/7R5NaxFPYuXj6wwpSG6MIza5T4bEz1caXyq94RL1ibqvNas+4CA
         FZSxq3vVpmBfI8OCD2vB6HQN952hHjz1hiNYGNieU/s0cKWX2pGC3qskeelxMtejo/
         RRczSP6AXy2XSirCT4bc86etHax59M7N7JVDkKRL3wR+tlUEg82dELMPaU76Ts45fV
         0Bto7+JahbPVXxGvbZfShIBTXlA24WtHH8SXGiNAo2RdQddKtFiNGDY1Dl6Ho7x8zH
         BTJzgkM4H8Wug==
Received: by mail-ot1-f70.google.com with SMTP id t26-20020a0568301e3a00b005af6b88cf12so4243909otr.12
        for <linux-pci@vger.kernel.org>; Fri, 08 Apr 2022 04:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlvQVB5MMhFkpcx7NoQ85ETd+2hV1Om6HXECryb4lPk=;
        b=na8Wr7kCmxbxzdl/iPhNgBByhKxhSpEnOROxK5odXKEnPjSv9xyAsGjEimIQiPyShb
         oq8nflj+pRgSnL9tVuwZobVq6cy5ooiPMYZRn4YxxDmLFHN/WSAVtr0OSvcX5ZPGuh9r
         1GhrVfDNxPhd4EDW7q316WibjspOQ6kc3ugbwJy+hdLqWPd12Wk1IYnrunEAFg2jGk3p
         MA6ZMFErlY5hIyvrQ6CdFhLgrHkq7Cg91VsayyqR3hqvpERSFQsTPT1iQbui5Z2DerUB
         h3rCYYagqsweQK2gFmxWl19Q2sJA8rh1gz9UkHvRi/DUzfw6xJLrf+m5dzlK2a4ljAFw
         2eSA==
X-Gm-Message-State: AOAM533hkkJjcoOTxs+Gf+yRKKax67RTKW0AXg8bfvfwa2lb6KZ3T7D5
        JDFdOBo6GwlZE18+e8dQh4jGlXQowRnfJNyF7NhGuBco7YFMjLScp7vZEBEHojws89w7YDGSV6+
        WwHYoOfIuhKtJ+xCHwqGpl1oPiIF+KUjIuQ6P2XZ5sl/h8zoxtElUhA==
X-Received: by 2002:a9d:6d89:0:b0:5cd:9c48:724c with SMTP id x9-20020a9d6d89000000b005cd9c48724cmr6420754otp.233.1649417177444;
        Fri, 08 Apr 2022 04:26:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMsajOjzOFNsK+hzAS9FaCvNkmkgbhVptrmJvMFP6+orBrWU/UlP3Idkcq6MatULuM4ulcb5ZcQhwL//6oDPc=
X-Received: by 2002:a9d:6d89:0:b0:5cd:9c48:724c with SMTP id
 x9-20020a9d6d89000000b005cd9c48724cmr6420742otp.233.1649417177157; Fri, 08
 Apr 2022 04:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220329083130.817316-1-kai.heng.feng@canonical.com> <009c9c14-7669-9750-a787-1d220414423e@linux.intel.com>
In-Reply-To: <009c9c14-7669-9750-a787-1d220414423e@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 8 Apr 2022 19:26:06 +0800
Message-ID: <CAAd53p50sW8GsetxisisNXM3FTZf73GCPnRXAqYysckKzw_SqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, baolu.lu@linux.intel.com,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 3:40 AM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 3/29/22 1:31 AM, Kai-Heng Feng wrote:
> > On some Intel AlderLake platforms, Thunderbolt entering D3cold can cause
> > some errors reported by AER:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
>
> Include details about in which platform you have seen it and whether
> this is a generic power issue?

_All_ Alder Lake platforms I worked on have this issue. I don't think
have hardware to analyze if it's a power issue though.

>
> >
> > So disable AER service to avoid the noises from turning power rails
> > on/off when the device is in low power states (D3hot and D3cold), as
> > PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
>
> Also include PCIe specification version number.

Will add in next revision.

Kai-Heng

>
> > transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> > with aux power) and L3 (D3cold).
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >   - Remove reference to ACS.
> >   - Wording change.
> >
> > v2:
> >   - Wording change.
> >
> >   drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
> >   1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 9fa1f97e5b270..e4e9d4a3098d7 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >   }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc = get_service_data(dev);
> > +
> > +     aer_disable_rootport(rpc);
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc = get_service_data(dev);
> > +
> > +     aer_enable_rootport(rpc);
> > +     return 0;
> > +}
> > +
> >   /**
> >    * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >    * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >   }
> >
> >   static struct pcie_port_service_driver aerdriver = {
> > -     .name           = "aer",
> > -     .port_type      = PCIE_ANY_PORT,
> > -     .service        = PCIE_PORT_SERVICE_AER,
> > -
> > -     .probe          = aer_probe,
> > -     .remove         = aer_remove,
> > +     .name                   = "aer",
> > +     .port_type              = PCIE_ANY_PORT,
> > +     .service                = PCIE_PORT_SERVICE_AER,
> > +     .probe                  = aer_probe,
> > +     .suspend                = aer_suspend,
> > +     .resume                 = aer_resume,
> > +     .runtime_suspend        = aer_suspend,
> > +     .runtime_resume         = aer_resume,
> > +     .remove                 = aer_remove,
> >   };
> >
> >   /**
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
