Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2443120031
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLPIro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 03:47:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLPIrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 03:47:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so6162911wrw.8
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2019 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UCb1aLRLTzlVhWNMjZXZKGwuML6x7jOTgc2nDzZf58E=;
        b=Mspx/K+QfHmNRZPHL6k5AJMceeZwtVPDzqXbxtrPfcHZCmPaxeuVIFSA4Rgd3YhD76
         fT1t/dd8PunfVmAPihW8z0V8ypiLOnVwMbhLN4+gap6qinf7YXJvcPpIeGJRt3jqvGMP
         3L8w5kf1WLsdAvw1jjEl1qSFmI63h9J4n93J7R3Y0Qvg/KFDNSb2eFhUeaKcTUaB1jsa
         zEIaqTjvq2F8nfDEBLolbmA+4K+N1iHBaF7kroMNF6OpMRIEiSp934EJ5jmxrXlU4ZUS
         D9xcCyfF7GBak9VY4qWm+AmbxpIupPIY1r/KSd43sD5ioVrT3JoOFBgx4Zsazft7dbYf
         dssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UCb1aLRLTzlVhWNMjZXZKGwuML6x7jOTgc2nDzZf58E=;
        b=gVOJt6PqvotJoBcaplOZWTxd6FmIoXxMFhNpIW+CAbGpJuWpXiAw47CT/sL6zxERfz
         M1zPUNC7iJ424E6lidJhR21n2mGc8XG86y9ASau8ErjAPBv4+6xAqOTrNssxQ+700Caw
         /WxrVM6YeZMP1bf9yRhLb2unCpxwd+MmhFtKaWECzoGvVAtPiWPMpBN/QqwZdS1nfM2r
         fY5snv8KVgM7ML8hFVeCoXZ9/7wv3T3AwJt0whd/zL9IuOVhGnOOJhK1D5D2iTToq+ZH
         x7iZLn5uDQ9p8Wf/NO+7JPFxSLenRTfJP7uIiC3O6q9FZ2y5WmYKB//UetCPWRhpzh7B
         hdEg==
X-Gm-Message-State: APjAAAVPMJZICRZ2bTVVNIjyjYUXgmvJLWeYFum6enIFtXqJp+70xqGh
        qfJPpm8YthWynkLhI07e1/k3QQ==
X-Google-Smtp-Source: APXvYqyLnlEaVpkiF1HI78n8G1vzJZongnJIMYz+ifesrg0LxQphKWK8bFoJHiH4Wxje2YoxtG06rw==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr29498932wrr.306.1576486061156;
        Mon, 16 Dec 2019 00:47:41 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id z18sm19958406wmf.21.2019.12.16.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 00:47:40 -0800 (PST)
References: <20191208210320.15539-1-repk@triplefau.lt> <1jpngxew6l.fsf@starbuckisacylon.baylibre.com> <20191215113634.GB7304@voidbox>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: amlogic: Make PCIe working reliably on AXG platforms
In-reply-to: <20191215113634.GB7304@voidbox>
Date:   Mon, 16 Dec 2019 09:47:39 +0100
Message-ID: <1jsglkbqs4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Sun 15 Dec 2019 at 12:36, Remi Pommarel <repk@triplefau.lt> wrote:

> On Mon, Dec 09, 2019 at 09:32:18AM +0100, Jerome Brunet wrote:
>> 
>> On Sun 08 Dec 2019 at 22:03, Remi Pommarel <repk@triplefau.lt> wrote:
>> 
>> > PCIe device probing failures have been seen on some AXG platforms and were
>> > due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
>> > solved the problem. After being contacted about this, vendor reported that
>> > this bit was linked to PCIe PLL CML output.
>> 
>> Thanks for reporting the problem.
>> 
>> As Martin pointed out, the CML outputs already exist in the AXG clock
>> controller but are handled using HHI_PCIE_PLL_CNTL6. Although
>> incomplete, it seems to be aligned with the datasheet I have (v0.9)
>> 
>> According to the same document, HHI_MIPI_CNTL0 belong to the MIPI Phy.
>> Unfortunately bit 26 is not documented
>> 
>> AFAICT, the clock controller is not appropriate driver to deal with this
>> register/bit
>> 
>
> Regarding both @Martin's and your remark.
>
> Unfortunately the documentation I have and vendor feedback are a bit
> vague to me. I do agree that CLKID_PCIE_PLL_CML_ENABLE is not a proper
> name for this bit because this register is MIPI related.
>
> Here is the information I got from the vendor [1]. As you can see
> HHI_MIPI_CNTL0[29] and HHI_MIPI_CNTL0[26] are related together, and
> HHI_MIPI_CNTL0[29] is implemented in the clock controller as
> axg_mipi_enable which is why I used this driver for HHI_MIPI_CNTL0[26].
>

Seems I should have paid more attention when axg_mipi_enable.
Bit 29 is yet another undocumented bit

> So maybe I could rename this bit to something MIPI related ?

This register region is simply not part of the main clock
controller. The bits in it are not related to this controller but the
MIPI PHY. It should not have been mapped in this way to begin with.

I can see how it would be convient to model this with a gate to just
flip the bit when needed but it is just wrong.

The documentation says the register are for the MIPI analog PHY, it
should be implemented as such and used by the PCIe as needed.

Of course, fixing this (remapping the region and removing
axg_mipi_enable) will be a bit messy. If you want to make that MIPI Phy
driver, I can help you with the clock part.

>
>> >
>> > This serie adds a way to set this bit through AXG clock gating logic.
>> > Platforms having this kind of issue could make use of this gating by
>> > applying a patch to their devicetree similar to:
>> >
>> >                 clocks = <&clkc CLKID_USB
>> >                         &clkc CLKID_MIPI_ENABLE
>> >                         &clkc CLKID_PCIE_A
>> > -                       &clkc CLKID_PCIE_CML_EN0>;
>> > +                       &clkc CLKID_PCIE_CML_EN0
>> > +                       &clkc CLKID_PCIE_PLL_CML_ENABLE>;
>> >                 clock-names = "pcie_general",
>> >                                 "pcie_mipi_en",
>> >                                 "pcie",
>> > -                               "port";
>> > +                               "port",
>> > +                               "pll_cml_en";
>> >                 resets = <&reset RESET_PCIE_PHY>,
>> >                         <&reset RESET_PCIE_A>,
>> >                         <&reset RESET_PCIE_APB>;
>> 
>> A few remarks for your future patches:
>> 
>> * You need to document any need binding you introduce:
>>   It means that there should have been a patch in
>>   Documentation/devicetree/... before using your newclock name in the
>>   pcie driver. As Martin pointed out, dt-bindings should be dealt with
>>   in their own patches
>> 
>> >
>> >
>> > Remi Pommarel (2):
>> >   clk: meson: axg: add pcie pll cml gating
>> 
>> Whenever possible, patches intended for different maintainers should be
>> sent separately (different series)
>
> Thanks, will do both of the above remarks.
>
>> 
>> >   PCI: amlogic: Use PCIe pll gate when available
>> >
>> >  drivers/clk/meson/axg.c                | 3 +++
>> >  drivers/clk/meson/axg.h                | 2 +-
>> >  drivers/pci/controller/dwc/pci-meson.c | 5 +++++
>> >  include/dt-bindings/clock/axg-clkc.h   | 1 +
>> >  4 files changed, 10 insertions(+), 1 deletion(-)
>> 
>
> Thanks for reviewing this.
>
> [1] https://i.snipboard.io/bHMPeq.jpg

