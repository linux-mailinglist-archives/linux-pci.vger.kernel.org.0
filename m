Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E316F1C9C50
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGU1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:27:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42634 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGU1B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:27:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id m18so5667095otq.9;
        Thu, 07 May 2020 13:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J7adPtt+VuEoYufYoQK3l2iI8G9mMFdtHEcZQJunprI=;
        b=C0uoZNH51Xs5wXNty4VvJ/oRRTbv8i1voZAzAlhzZFz5eOIL+VptF7l/ItIVHe5y/3
         x0xcDg1bj1KPJj6e1jMejFdblxEKHQkzfbxCoJ7sD9+IEht1MPFu9W0aIozLm0BiVjVD
         Ar/Fsv4O6xAgbOxIpZiZ3tdliFGJ1a3a3GBV4qu/Yo3BpVD0NMEc6dJULu1FFTqFod+m
         tOcE3kzV2fBQzV4cPQcWr5FroXSkT3xJNm2uSSH+tWYRJN4g+BYnfINs3GHsuH79YY87
         pL4Wg4UgMCU+KjRNDTdfaQ6S2CP80w8Zp0NXkQfd7ckU2+LcXc0LpQskHGXsSYtBWfD6
         LC5g==
X-Gm-Message-State: AGi0PuamyQOOzb3j1XkTkSykby1K2nHYwYEHhxSQCo18qoRMM0Ct0VwD
        jGP5RZ2c+sZ4bO0Fn3GemA==
X-Google-Smtp-Source: APiQypJfnyksfN5hPCGCeUvtaQ/E3l61rmqABXV7KNhNjXZO3c0bbWusjg3MEpBIbcTDRWgN8DU5Gw==
X-Received: by 2002:a9d:805:: with SMTP id 5mr12110882oty.111.1588883219925;
        Thu, 07 May 2020 13:26:59 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e18sm1760119oos.19.2020.05.07.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:26:59 -0700 (PDT)
Received: (nullmailer pid 19355 invoked by uid 1000);
        Thu, 07 May 2020 20:26:58 -0000
Date:   Thu, 7 May 2020 15:26:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
Message-ID: <20200507202658.GA29938@bogus>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-3-kishon@ti.com>
 <20200501144645.GB7398@e121166-lin.cambridge.arm.com>
 <dc581c5b-11de-f4b3-e928-208b9293e391@arm.com>
 <2472c182-834c-d2c1-175e-4d73898aef35@ti.com>
 <4f333ceb-2809-c4ae-4ae3-33a83c612cd3@arm.com>
 <cf9c2dcc-57e8-cfa0-e3b4-55ff5113341f@ti.com>
 <da933b0d-ee17-5bca-3763-1d73c7ed6bfc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da933b0d-ee17-5bca-3763-1d73c7ed6bfc@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 08:52:13AM +0530, Kishon Vijay Abraham I wrote:
> Hi Robin,
> 
> On 5/4/2020 6:23 PM, Kishon Vijay Abraham I wrote:
> > Hi Robin,
> > 
> > On 5/4/2020 4:24 PM, Robin Murphy wrote:
> >> On 2020-05-04 9:44 am, Kishon Vijay Abraham I wrote:
> >>> Hi Robin,
> >>>
> >>> On 5/1/2020 9:24 PM, Robin Murphy wrote:
> >>>> On 2020-05-01 3:46 pm, Lorenzo Pieralisi wrote:
> >>>>> [+Robin - to check on dma-ranges intepretation]
> >>>>>
> >>>>> I would need RobH and Robin to review this.
> >>>>>
> >>>>> Also, An ACK from Tom is required - for the whole series.
> >>>>>
> >>>>> On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
> >>>>>> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
> >>>>>> property to configure the number of bits passed through from PCIe
> >>>>>> address to internal address in Inbound Address Translation register.
> >>>>>>
> >>>>>> However standard PCI dt-binding already defines "dma-ranges" to
> >>>>>> describe the address range accessible by PCIe controller. Parse
> >>>>>> "dma-ranges" property to configure the number of bits passed
> >>>>>> through from PCIe address to internal address in Inbound Address
> >>>>>> Translation register.
> >>>>>>
> >>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>>>> ---
> >>>>>>    drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
> >>>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>>>> b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>>>> index 9b1c3966414b..60f912a657b9 100644
> >>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>>>> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >>>>>>        struct device *dev = rc->pcie.dev;
> >>>>>>        struct platform_device *pdev = to_platform_device(dev);
> >>>>>>        struct device_node *np = dev->of_node;
> >>>>>> +    struct of_pci_range_parser parser;
> >>>>>>        struct pci_host_bridge *bridge;
> >>>>>>        struct list_head resources;
> >>>>>> +    struct of_pci_range range;
> >>>>>>        struct cdns_pcie *pcie;
> >>>>>>        struct resource *res;
> >>>>>>        int ret;
> >>>>>> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >>>>>>        rc->max_regions = 32;
> >>>>>>        of_property_read_u32(np, "cdns,max-outbound-regions",
> >>>>>> &rc->max_regions);
> >>>>>>    -    rc->no_bar_nbits = 32;
> >>>>>> -    of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
> >>>>>> +    if (!of_pci_dma_range_parser_init(&parser, np))
> >>>>>> +        if (of_pci_range_parser_one(&parser, &range))
> >>>>>> +            rc->no_bar_nbits = ilog2(range.size);
> >>>>
> >>>> You probably want "range.pci_addr + range.size" here just in case the bottom of
> >>>> the window is ever non-zero. Is there definitely only ever a single inbound
> >>>> window to consider?
> >>>
> >>> Cadence IP has 3 inbound address translation registers, however we use only 1
> >>> inbound address translation register to map the entire 32 bit or 64 bit address
> >>> region.
> >>
> >> OK, if anything that further strengthens the argument for deprecating a single
> >> "number of bits" property in favour of ranges that accurately describe the
> >> window(s). However it also suggests that other users in future might have some
> >> expectation that specifying "dma-ranges" with up to 3 entries should work to
> >> allow a more restrictive inbound configuration. Thus it would be desirable to
> >> make the code a little more robust here - even if we don't support multiple
> >> windows straight off, it would still be better to implement it in a way that
> >> can be cleanly extended later, and at least say something if more ranges are
> >> specified rather than just silently ignoring them.
> > 
> > I looked at this further in the Cadence user doc. The three inbound ATU entries
> > are for BAR0, BAR1 in RC configuration space and the third one is for NO MATCH
> > BAR when there is no matching found in RC BARs. Right now we always configure
> > the NO MATCH BAR. Would it be possible describe at BAR granularity in dma-ranges?
> 
> I was thinking if I could use something like
> dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x00000 0x0>, //For BAR0 IB mapping
> 	     <0x02000000 0x0 0x0 0x0 0x0 0x00000 0x0>, //For BAR1 IB mapping
> 	     <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>; //NO MATCH BAR
> 
> This way the driver can tell the 1st tuple is for BAR0, 2nd is for BAR1 and
> last is for NO MATCH. In the above case both BAR0 and BAR1 is just empty and
> doesn't have valid values as we use only the NO MATCH BAR.
> 
> However I'm not able to use for_each_of_pci_range() in Cadence driver to get
> the configuration for each BAR, since the for loop gets invoked only once since
> of_pci_range_parser_one() merges contiguous addresses.

NO_MATCH_BAR could just be the last entry no matter how many? Who cares 
if they get merged? Maybe each BAR has max size and dma-ranges could 
exceed that, but if so you have to handle that and split them again.

> Do you think I should extend the flags cell to differentiate between BAR0, BAR1
> and NO MATCH BAR? Can you suggest any other alternatives?

If you just have 1 region, then just 1 entry makes sense to me. Why 
can't you use BAR0 in that case?

Rob
