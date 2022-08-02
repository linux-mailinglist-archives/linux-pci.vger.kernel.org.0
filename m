Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D485877D8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiHBHbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHBHbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 03:31:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015311167
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 00:31:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d20so5378199pfq.5
        for <linux-pci@vger.kernel.org>; Tue, 02 Aug 2022 00:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Oz4pyVolo+7EocETp6RPHwTxAVjyx7EAwXvBqZK2TEk=;
        b=Yq1RxDelFYMxpGFBpY90jH//emjw/Amk7Exgr+6EjDUFo+wD2lQUatG2wfLn9nNzYr
         cYJ+3fYLUaYpNmI8rYkkAsoyTRZAyFGP6Hfa+hHAdCpJ+WROXAH52v5kF7zdKkfcyQQD
         pgQPfgFtzBVglBCx47edP6Gjax4ELIZzNu9sIqMIb77R8Nq6Xj723KV2TjxTPBmtoiwm
         DtiBX0z4wKJDkSYscJJiOHE9v2fPrINfVNLu+axlRZ8l1riqldWWVMYq/X+wphDevaIL
         VVAAGVwuL6I93daY5nYrduO5fb36qYpYcUvo/NtarjXXbdSt4NWfkw5NIe9ZqCG8BHul
         sO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Oz4pyVolo+7EocETp6RPHwTxAVjyx7EAwXvBqZK2TEk=;
        b=IrnmhdpfhbJvM9xFgv1QxtxpeBVfqRAbS8po0bj9GYMsdJDYiKSzmm+Tva7ALygZza
         PwC5kPARvmdpDiudDk0IdPpKJ6emmmuwaXjNmZ7TSxWoJqd5aqsxrFDHR9kiOf37wewh
         +cdQnou/BVR+GhsBsPUuip6IhlkCNxeGlFn87Dl8mi3mcnynDsWBnf34jOIuopKkaaH7
         Rcr7/sUAEMKcYOjxwrODhMlziiSdETZhBdc9JOGBr5aOWUseEZzgRayC00CeH/gJIKRD
         Tw+RPp3c2ljSAOueVLPVENvD4kOiy35YHWM1ZfBgTT/5tzISc2nMJt3paphcQfYuUs14
         OvFw==
X-Gm-Message-State: AJIora9zv/+N1ONbcOjJNDKROoAYmDpUjQ9GeBPrM6Z6PAZfwv2f0qIB
        O5fLXQAZOL80Ol+m1EtW0sDZ
X-Google-Smtp-Source: AGRyM1vbOHIYB4UFSLFge9JzQ5/mJ4EhdQ5f6vclz1JLLTBqFFbYcUjVSNAiGGyjYRh4bT2MuGZ32A==
X-Received: by 2002:a63:d90b:0:b0:41a:ff05:4808 with SMTP id r11-20020a63d90b000000b0041aff054808mr16315270pgg.159.1659425501914;
        Tue, 02 Aug 2022 00:31:41 -0700 (PDT)
Received: from thinkpad ([117.193.215.193])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0016c09a0ef87sm3002132ple.255.2022.08.02.00.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:31:41 -0700 (PDT)
Date:   Tue, 2 Aug 2022 13:01:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 04/15] PCI: dwc: Add IP-core version detection
 procedure
Message-ID: <20220802073133.GB2494@thinkpad>
References: <20220801131219.GD93763@thinkpad>
 <20220801200606.GA622066@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801200606.GA622066@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 03:06:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 01, 2022 at 06:42:19PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jun 24, 2022 at 05:39:36PM +0300, Serge Semin wrote:
> > > Since DWC PCIe v4.70a the controller version and version type can be read
> > > from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
> > > registers respectively. Seeing the generic code has got version-dependent
> > > parts let's use these registers to find out the controller version.  The
> > > detection procedure is executed for both RC and EP modes right after the
> > > platform-specific initialization. We can't do that earlier since the
> > > glue-drivers can perform the DBI-related setups there including the bus
> > > reference clocks activation, without which the CSRs just can't be read.
> > > 
> > > Note the CSRs content is zero on the older DWC PCIe controller. In that
> > > case we have no choice but to rely on the platform setup.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > > @@ -711,6 +711,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	ep->phys_base = res->start;
> > >  	ep->addr_size = resource_size(res);
> > >  
> > > +	dw_pcie_version_detect(pci);
> > > +
> > 
> > There is still an ongoing debate about moving all DBI accesses to
> > init_complete. But this is fine atm.
> 
> Well, if I understand it correctly, e966f7390da9 ("PCI: dwc: Refactor
> core initialization code for EP mode") claims that all DBI accesses
> should be in dw_pcie_ep_init_complete(), so it's not so much a debate
> as a discussion about how best to achieve that.
> 

Glad to know that we are on the same page. Let's continue the discussion in
that thread.

Thanks,
Mani

> But you're right, we can fix that up later if necessary.
> 
> > >  	dw_pcie_iatu_detect(pci);

-- 
மணிவண்ணன் சதாசிவம்
