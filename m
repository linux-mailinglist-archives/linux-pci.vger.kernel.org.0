Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC552EFE8
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351231AbiETQCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 12:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiETQCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 12:02:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56FA54BEB;
        Fri, 20 May 2022 09:02:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id v8so13164467lfd.8;
        Fri, 20 May 2022 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LkSGf2bxH59WTVp83FSY5qiWK4pwS5blQmXLKyjSPY8=;
        b=LzZ6uTIeyrfaKNl5cUwwZFfQvtAC3G4sg2F+8g0tpdPj3a30M7PcedfpSmZG2JQh2V
         QDOHcZN5lPVhVZtsz8VJgniYDuJce1KaaPCM6PLcwNRXpvKzbMSHPs7zuDRRnULQp8NX
         q4FMcsrqiejZ6LmQ5sd08XNREBDUnariDaESgLhDUwnUSAV/qyUavRSgIRzCxQcEEWCM
         uUgkP+XKQ1y1m69r1yHxRoHzHnjpHCdGti/85+RKXrnPdgtowx4e2Yechk9n/ggyb+fq
         Va6w5J5tqm4nQjffYz0tAkCvL/jBpaO1tSu8a5z589JwJUyKO89aQRL7CcFv7nG8h3Pa
         VR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkSGf2bxH59WTVp83FSY5qiWK4pwS5blQmXLKyjSPY8=;
        b=RSu9w2+U8xQ7SApll2fkJkwEy8BlMWve8YXuDRoDN8cDcPLu9qU79GJ3pJzB1NDbxs
         M5X2QNghlxeJTbr/94MsNTSXbgzOJFZFwQ0UroDxXrBnIctw2O5GKPFD0+Tfu2Z9y+Rq
         RS2ueaXl/bICMkrI+tcmuUgd3Yz3jLbTXrBEQtuo8QLdNMGiCltQ5x6C1o42NRTSmvNB
         z0GwYQUjK9i8TKTOM90EhWOK5B2so7xHf8nHek8tRoAyNdr9jOHVBQHrBCeKG2BoLbvd
         CUTi1bTethJLYQ6K5qUQ6+lydKMhLPyvnape3WhUBcB/s6mRB3KZZIx514UU5AwvBPNa
         Km3Q==
X-Gm-Message-State: AOAM5312iarPEUtMH6zmUsxF/IJe/4jXEjpQJWfIMdFdlAVcpQpFOnrE
        2Gh7dxj+RYKOiYdVS49ELq8ZZX22fQKpZA==
X-Google-Smtp-Source: ABdhPJy19kEdrGjfue1GtCczQo4F+DapVsY3piSITa4hnXnRq2NVBcozhD80EXbDIrUP8RV2FvDKXA==
X-Received: by 2002:a19:4303:0:b0:473:f5fb:27b2 with SMTP id q3-20020a194303000000b00473f5fb27b2mr7341009lfa.626.1653062570085;
        Fri, 20 May 2022 09:02:50 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id t5-20020a2e9545000000b00250a19f8b47sm355024ljh.126.2022.05.20.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:02:49 -0700 (PDT)
Date:   Fri, 20 May 2022 19:02:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/17] PCI: dwc: Introduce generic platform clocks and
 resets sets
Message-ID: <20220520160246.guczq52v2ycfgc6c@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-17-Sergey.Semin@baikalelectronics.ru>
 <20220516222920.GC3296584-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516222920.GC3296584-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 05:29:20PM -0500, Rob Herring wrote:
> On Wed, May 04, 2022 at 12:46:37AM +0300, Serge Semin wrote:
> > Currently almost each platform driver uses its own resets and clocks
> > naming in order to get the corresponding descriptors. It makes the code
> > harder to maintain and comprehend especially seeing the DWC PCIe core main
> > resets and clocks signals set hasn't changed much for about at least one
> > major IP-core release. So in order to organize things around these signals
> > we suggest to create a generic interface for them in accordance with the
> > naming introduced in the DWC PCIe IP-core reference manual:
> > 
> > Clocks:
> > - DBI - data bus interface clock (on some DWC PCIe platforms it's
> >   referred as "pclk", "pcie", "sys", "ahb", "cfg", "iface", "gio", "reg",
> >   "pcie_apb_sys");
> > - MSTR - AXI-bus master interface clock (some DWC PCIe glue drivers refer
> >   to this clock as "port", "bus", "pcie_bus",
> >   "bus_master/master_bus/axi_m", "pcie_aclk");
> > - SLV - AXI-bus slave interface clock (also called as "port", "bus",
> >   "pcie_bus", "bus_slave/slave_bus/axi_s", "pcie_aclk",
> >   "pcie_inbound_axi");
> > - PIPE - Core-PCS PIPE interface clock coming from external PHY (it's
> >   normally named by the platform drivers as just "pipe")
> > - CORE - primary clock of the controller (none of the platform drivers
> >   declare such a clock but in accordance with the ref. manual the devices
> >   may have it separately specified);
> > - AUX - Auxiliary PMC domain clock (it is named by some platforms as
> >   "pcie_aux" and just "aux")
> > - REF - Generic reference clock (it is a generic clock source, which can
> >   be used as a signal source for multiple interfaces, some platforms call
> >   it as "ref", "general", "pcie_phy", "pcie_phy_ref").
> > 
> > Application resets:
> > - DBI - Data-bus interface reset (it's CSR interface clock and is normally
> >   called as "apb" though technically it's not APB but DWC PCIe-specific
> >   interface);
> >   apb, sys,
> > - MSTR -AXI-bus master reset (some platforms call it as "port", "apps",
> >   "bus", "axi_m");
> > - SLV - ABI-bus slave reset (some platforms call it as "port", "apps",
> >   "bus", "axi_s").
> > 
> > Core resets:
> > - NON_STICKY - Non-sticky CSR flags reset;
> > - STICKY - sticky CSR flags reset;
> > - PIPE - PIPE-interface (Core-PCS) logic reset (some platforms call it
> >   just "pipe");
> > - CORE - controller primary reset (resets everything except PMC module,
> >   some platforms refer to this signal as "soft", "pci");
> > - PHY - PCS/PHY block reset (strictly speaking it is normally connected to
> >   the out of the external block, but the reference manual says it must be
> >   available for the PMC working correctly, some existing platforms call it
> >   as "pciephy", "phy", "link");
> > - HOT - PMC hot reset signal (also called as sleep");
> > - PWR - cold reset signal (can be referred as "pwr", "turnoff").
> > 
> > As you can see each platform uses it's own naming for basically the same
> > set of the signals. In the framework of this commit we suggest to add a
> > set of the clocks and signals identifiers and corresponding names for each
> > denoted entity. The platforms will be able to use them to define local
> > mapping tables between the generic identifiers and the available set of
> > the clocks and resets. The tables can be then utilized to create the
> > corresponding bulk-arrays, which in its turn can be passed to the
> > clock/reset-bulk API methods to easily get/enable/disable/put,
> > get/reset/assert/deassert/put all the handlers at once or, if it's
> > required, manipulate with the handlers individually.
> 

> No doubt there is way to much variation here (ummm, Qcom!). Some 
> standardization of names in (new) bindings would be good. That's where 
> we should be defining names IMO.

That's what my patchset starts from. See the {reset,clock,reg}-names
properties definitions in the snps,dw-pcie-common.yaml schema being added
in the framework of the patch
[PATCH v2 01/17] dt-bindings: PCI: dwc: Define common and native DT bindings
in this series.

> 
> On the driver side, I'd like to see the DW core handle clocks/resets/phys 
> at least for the easy cases of just turn on/off all the clocks and 
> toggle all resets. Perhaps even more minimally, move the clk/reset 
> struct pointers to the DWC core.


If it was that easy I would have done that in the first place.) Even
though there is well defined set of the clocks and resets a normal DW
PCIe RP/EP controller can have (see the list in the patch log), the
way they are toggled and the signal sources due to the controller
complexity in the most of the cases is platform-dependent.  Just
enabling and de-asserting all of them likely will never work. So such
function would be just useless. In addition to that there are signals
like app_ltssm_enable or phy/link reset request which needs to be
checked at some point of the reset procedure. The way these signals
are available in the system is also platform-dependent (syscon,
additional CSRs blocks, etc). Thirdly there can be PHY viewport CSRs
available in the DW PCIe Port Logic CSRs which can be used on the
platforms to tune the PHY settings up during the cold reset process.
Finally the platform-specific timings between the reset signals
assertion/de-assertion need to be preserved. Taking all of that into
account would cause having a very complicated generic clock/reset
handling procedure.

Synopsys provides a Verilog module called DWC_pcie_clkrst.v/CLK_RST.v
which can be used by the platform engineers to implement the clocks
generation and cold/hot reset without much software interference. But
it isn't always possible to predict the timings being required on the
real silicon. So the hw engineers mainly omit such module and rely on the
software to implement the proper reset procedure, which due to many
reasons (PHY settings, timings, etc) mostly differs from SoC-to-SoC.

So to speak I don't think that we can (should?) create some truly
generic at least cold start procedure due to too many variables at
stake (though the one implemented in my Baikal-T1 PCIe driver, last
patch in the series, follows the cold procedure described in the hw
reference manual). At least IMO it won't be possible without many
hooks inside such method with platform-dependent signals checking and
delays. So the only generic thing that we can indeed implement is to
have the clock and reset structure pointers inside the DWC core and
create a generic platform resources request/release methods. Even in
that case these methods can't be called from the generic
host/end-point probe procedure and need to be invoked from the
platform-specific host_init/host_deinit methods by the platforms
themself. It's because there are so many platforms already
implemented. If I try to consolidate all their resource
request/release parts in a single method, it most likely cause the
regression.

What do you think if I would just create the arrays with pointers to the
generic clk/reset structures in the DWC private data, implement their
request (release won't be required due to devm-methods utilization)
procedure and use it in the framework of my driver only for now?

> 
> IOW, I'm not sure this patch is really helpful without some of the above 
> happening.

Well, I've provided a driver (the last patch in this series) which
design can be used as a reference to implement the clocks/reset
request procedure with a help of the submitted in this patch tables.
But if you are agree with creating a generic resource request method,
the clocks/reset request part of it can be re-designed, simplified
and moved to that method.

-Sergey

> 
> Rob
