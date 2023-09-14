Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17067A0FD0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 23:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjINV0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 17:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjINV0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 17:26:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A61FD2;
        Thu, 14 Sep 2023 14:26:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso23029361fa.1;
        Thu, 14 Sep 2023 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694726760; x=1695331560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMF1sMMODWcbgwT3pjH1uzXCcj9xNGEpLdRLCBrFrJQ=;
        b=cmu42MFN2adM3nuknTtkg/iPg74QXm77WyUphNziYcaXwM1AYxr3Ynng9DBFsBdtfC
         dBK2LbCIvbu05zbRMehg8oFzeZT8A2xRskrhPVx+FEP4fIOZrmHY41UhyffCgn97Tf0D
         a7JCbvgVMt1gOtOrMgtxfRsyBx8TCKf4nJXDF/z5sgbBONpGNOiyBdetlunB9Bufnc2e
         uSZ95JHb6GuVVOVWwJAMXLSFuI3LEa6tQlBhLUROxiya5287dtx10c/V56/4TQw3RnfR
         pbzOfIg/6Zs+5+EAB4vNGrTcyOtr5vMLBZHQv5HxgHQYiuHXagD/afBOBOvcJP2RFLE/
         HXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726760; x=1695331560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMF1sMMODWcbgwT3pjH1uzXCcj9xNGEpLdRLCBrFrJQ=;
        b=OB/Crm1yPU0O2XFn0egCyaYTIsvNhQ960UORmAGrCCHc/9TSliewmjK3vDcdMed+6x
         Izm8eRCj+wj08E9GnblSN3PjOgY8yB1kIvqp8YriOTijjD0kLRz5yJjYim1ll5xL0wOg
         //JGvbMu0o8husE4eJPA1wDOJiCrPG9rTpNYoyApP4AgmaHP9hHQVy3vqZRoISNoufa2
         pCEPem5ZXw+KnNTsJoXAMDuLzjGosPrgVFV8nX5RTc/5E1bP6GIbYFyAENgSf8f5fFAW
         hBNffaITEqAzqhfPfhXMzdK1cEzObuNJTrj9RIL4TcGthpGM0vwqnNqt/OiHHdXKA4A+
         Hu4A==
X-Gm-Message-State: AOJu0YwQX6UkCvKp01fQavLj3D+WXmKWGKBC24ud4k6Raipmdd0nK3xG
        Y1Rcu1Hq2rivYRVDYR9QVp8=
X-Google-Smtp-Source: AGHT+IGeoMqy4vLAoSY2X/w+GA/HPMA45WiFFOP5RvQWLM6JvhicB+XTUCofBtivl+Hy1N1PeJ/JQw==
X-Received: by 2002:a2e:94c9:0:b0:2bc:cc1a:139c with SMTP id r9-20020a2e94c9000000b002bccc1a139cmr6834ljh.11.1694726759634;
        Thu, 14 Sep 2023 14:25:59 -0700 (PDT)
Received: from mobilestation ([95.79.219.206])
        by smtp.gmail.com with ESMTPSA id q7-20020a2e8747000000b002b787442f03sm437834ljj.88.2023.09.14.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:25:59 -0700 (PDT)
Date:   Fri, 15 Sep 2023 00:25:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 07/19] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW
 handling
Message-ID: <3fg7k3lr3yrghyek3eepxojpziso7w3j2jbyjcw4m7lh23ruce@clnpbrz7nuoc>
References: <notuqnugfnmu7ep7rvnerix7hvgqt5b4wdrirjjgggjsxfc7lz@pismsfnlenu4>
 <20230914205906.GA79508@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914205906.GA79508@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 03:59:06PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 14, 2023 at 11:48:39PM +0300, Serge Semin wrote:
> > On Thu, Sep 14, 2023 at 11:00:58AM -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 25, 2023 at 06:32:07PM +0900, Yoshihiro Shimoda wrote:
> > > > Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> > > > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > > > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > > > field there is another one which needs to be updated. It's
> > > > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > > > the very least the maximum link-width capability CSR won't expose
> > > > the actual maximum capability.
> > > > 
> > > > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > >     Version 4.60a, March 2015, p.1032
> > > > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > >     Version 4.70a, March 2016, p.1065
> > > > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > >     Version 4.90a, March 2016, p.1057
> > > > ...
> > > > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
> > > >       Version 5.40a, March 2019, p.1396
> > > > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> > > >       Version 5.40a, March 2019, p.1266
> > 
> > > Is there value in keeping all four of these Root Port citations?  I
> > > assume that if you have the most recent one (X+1), it completely
> > > obsoletes the older ones, so you should never have to look at the
> > > older ones?
> > 
> > In general the procedure may differ from one device version to
> > another. Though it doesn't concern DW PCIe IP-cores. So by citing all
> > these manuals I implied that all DW PCIe controllers expect the same
> > link-width initialization procedure. Keeping that in mind I guess the
> > text could be indeed simplified by keeping only two citations (note
> > [X] and [X+1] refer to the Root Port and End-point HW databooks of the
> > same IP-core version) and noting in the text that the procedure is
> > common for the older DW PCIe controllers too.
> > 
> > In anyway I wouldn't say that new IP-core databooks obsolete the
> > old one since the driver supports all old and new controllers. So
> > before introducing a generic procedure we need to make sure that it
> > will work for all the known to be supported devices. From that
> > perspective citing all the available databooks gets to make sense.
> 

> You mean that instead of merely *adding* new details about new
> devices, v5.40a might OMIT details specific to older devices covered
> by v4.60a?  That sounds like ... kind of an unhelpful way to manage
> the spec, but if so, I see your point.

Right. I can't say for all the Synopsys IP-core documents but for
instance DW PCIe, DW uMCTL2 DDRC, DW *MAC docs tend to omit a lot of
changes history info. The most extensive list of changes is available
in the release notes provided as a separate document.

-Serge(y)

> 
> Bjorn
