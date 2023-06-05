Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56402721F76
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjFEHYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 03:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFEHYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 03:24:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD098;
        Mon,  5 Jun 2023 00:24:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso1915573e87.0;
        Mon, 05 Jun 2023 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685949879; x=1688541879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FWApuY+B9aXevY6tmi8mta/TlQZ2QdsjckzPaOn34c=;
        b=EPv8fYFOoVFhuAe6JmxU2w0SIcvH7tWeu1BzfoN0D3vQ0oGTXIRXOLJmaeG0Zsngjy
         ecvB8nB1D2qlLc+MNTTrQ8+sghyv9WBZB/XNr3HbjWprtznEOMsVSmSTs73m21P109mo
         7o99/PddBOLbAfP0v+vwiWkfnaUH+U/AR/LyIuN+l3m7mb5rPxTJHM+odTNkaAAKBv2C
         hRfXLBtd+33V51aqU6HhVCjFDAd60S9dL6+bQlydzLDriwieygUBOqy01biPqr3sXljZ
         JmUROdlWMk9RfijcuyBbfyjylyPPx5aLctlQ4XbzdNEbnwei7Lorvxheddfr0yZroTGi
         zayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685949879; x=1688541879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FWApuY+B9aXevY6tmi8mta/TlQZ2QdsjckzPaOn34c=;
        b=YwDFyaeedj+yJM/M5MuZYf6f5R093LJb4/WX04RJX6MNxdPPGgv+mr6iHzWdBAJqIy
         QYODCXVJauipWZmxRAVscA+ajKkncP/qEwcz4Hk73J6P9ziHPlu/CPrsoUK04hCK6HvE
         gcm3Gq8rG7+Yma7kwhGue+0hTGKpBAdxA0i7J2NLcaRwhLIwP9XyBwvthBpyDNILyatm
         oqk7WLLL6npedfH6/da1ICVkC96NeL3/RCU0EISYjbSnIdy8KNP/q+GPNMDq1FxinyVU
         PG2DizHukIUVHTLwkZXiqci90B785+RmZDAMxh7Ryphp3Vhdnc0phNIvv3HXcEHOlzhH
         RXKg==
X-Gm-Message-State: AC+VfDwKN0y9hvv6BX39wM6AHDqh8omlBn/DsQESshYlyGOGrSuvWJoY
        iSY+3eR5/X5pO0jyMRtay5Y=
X-Google-Smtp-Source: ACHHUZ5J3TmXgT3f4nPXEydWu31eXL/ayexIOpu8zbbaXovMxmdjGIaI8giUYZh7w/PNiCzvo2iHmA==
X-Received: by 2002:ac2:47e4:0:b0:4f4:b783:8556 with SMTP id b4-20020ac247e4000000b004f4b7838556mr4149900lfp.66.1685949879012;
        Mon, 05 Jun 2023 00:24:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id c7-20020a197607000000b004f38411f148sm1030208lff.84.2023.06.05.00.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:24:38 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:24:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Message-ID: <20230605072435.2hpb73qllzhez3uv@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-4-yoshihiro.shimoda.uh@renesas.com>
 <20230604230740.criuymkykrq54oln@mobilestation>
 <TYBPR01MB5341BD012D7BE2390CBA2075D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341BD012D7BE2390CBA2075D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 02:10:14AM +0000, Yoshihiro Shimoda wrote:
> Hello Serge,
> 
> > From: Serge Semin, Sent: Monday, June 5, 2023 8:08 AM
> > 
> > On Wed, May 10, 2023 at 03:22:15PM +0900, Yoshihiro Shimoda wrote:
> > > Add "Message Routing" and "INTx Mechanism Messages" macros to send
> > > a message by a PCIe driver.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/pci/pci.h | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 2475098f6518..67badc40e90b 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -11,6 +11,24 @@
> > >
> > >  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> > >
> > 
> > > +/* Message Routing */
> > 
> > Call it "Implicit Message Routing (r[2:0])" as per the specification.
> 
> I got it.
> 
> > > +#define PCI_MSG_ROUTING_RC	0
> > > +#define PCI_MSG_ROUTING_ADDR	1
> > > +#define PCI_MSG_ROUTING_ID	2
> > > +#define PCI_MSG_ROUTING_BC	3
> > > +#define PCI_MSG_ROUTING_LOCAL	4
> > > +#define PCI_MSG_ROUTING_GATHER	5
> > 
> > IMO prefix like this PCI_MSG_TYPE_R_{RC,ADDR,ID,BC,...} would be a bit
> > better since it would indicate that this routing flags are a sub-field of
> > the Message Type field. Bjorn?
> 
> I got it. I'll rename them.
> 
> > > +
> > > +/* INTx Mechanism Messages */
> > > +#define PCI_CODE_ASSERT_INTA	0x20
> > > +#define PCI_CODE_ASSERT_INTB	0x21
> > > +#define PCI_CODE_ASSERT_INTC	0x22
> > > +#define PCI_CODE_ASSERT_INTD	0x23
> > > +#define PCI_CODE_DEASSERT_INTA	0x24
> > > +#define PCI_CODE_DEASSERT_INTB	0x25
> > > +#define PCI_CODE_DEASSERT_INTC	0x26
> > > +#define PCI_CODE_DEASSERT_INTD	0x27
> > 
> > IMO Prefix PCI_MSG_CODE_... would be a bit more descriptive since per
> > the specification the respective message field is called "Message
> > Code" and not just "Code". Bjorn?
> 
> I got it. I'll rename them.

I would suggest to wait for Bjorn' opinion about this for sometime
since the macros will be defined in the PCIe common header file.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > > +
> > >  extern const unsigned char pcie_link_speed[];
> > >  extern bool pci_early_dump;
> > >
> > > --
> > > 2.25.1
> > >
