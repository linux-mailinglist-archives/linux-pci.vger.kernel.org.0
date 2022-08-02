Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993A25877C2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiHBHYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiHBHYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 03:24:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A675E481E0
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 00:24:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y15so12662146plp.10
        for <linux-pci@vger.kernel.org>; Tue, 02 Aug 2022 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7CWlA2+lkbubnWGtr6j474HLCnz+upKajwJ7DVrFrZk=;
        b=w70M3FKql12kzWfxf2FSt2qzi3lp2sqrJ0YXLWoBPuvSsqxoqyFJJtfFUK5FZH6Y+I
         6Bz/+uPE1rNq26bhrYjrDdcbIHQFCNL45iTc176kV+0mbTzSKkl70XOBgVYpdunKAWDp
         MrI1cJfPQogKsWvliKQK7FikVh8QY3q8VeSKxmNay3/niMVT4du2za4MKmgY3sYm+I4a
         w9d7xoht5NYCuCAsfPlZn71gZBawq1P1465L9V+cF9uEQtLOcueHYv4Zb9wlNlQkr39R
         j5RVaxHEuHiKNUMI3La7sHhUjlhEEwCbWIzzoUdRy7NqhQJL26/5CcVnfgUmjfA+tdJw
         exXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7CWlA2+lkbubnWGtr6j474HLCnz+upKajwJ7DVrFrZk=;
        b=MdzhnMk40OU7JezGKkTPPZz+2qKliXMUWvxBpOKJCRuv09eMBk8kByl31kDRMPzTdq
         QMf8fVMppMoyIJ1HNO5YcwIwAgyc0rxuDkE+ILVsGk37jI+1pUCELnxlEyUbfel5wQLp
         lK/CgAjnhi6ofI+dZSG+OeJvgQjyVcf1hfL168bErlAZp8hhy8UIP3UYy8ZJccY7xj4a
         zcDrl0aJegT2I9xtrtuxF+F96QsCEp3bGaHOo9L2zNyfBcWRQoBBuwILYMWeTTd3POIY
         TMV/O0fYEEoq3NqYxowPnQHGAgtBS4q6AulQ5Ar2wwkJPKjuMuK1H8TZmUzl9WrNFF2g
         n9+Q==
X-Gm-Message-State: ACgBeo0oCant8gFMRMGSw7ubL3V4Z7fFTo1PPNjw1m722S2LttGlL16x
        z4nGWin3FMh6x8BaDjm8IM/F
X-Google-Smtp-Source: AA6agR7THQxw9Q8u1KXWQ9qP4iHD84X8p9rtlqxZOoUwtwTkmtLt0rSXXK3oJWcqvVaW/ye32hFWvg==
X-Received: by 2002:a17:902:e54c:b0:16d:4c2d:d52b with SMTP id n12-20020a170902e54c00b0016d4c2dd52bmr20365410plf.90.1659425077054;
        Tue, 02 Aug 2022 00:24:37 -0700 (PDT)
Received: from thinkpad ([117.193.215.193])
        by smtp.gmail.com with ESMTPSA id c189-20020a624ec6000000b0052b6ed5ca40sm3805709pfb.192.2022.08.02.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:24:36 -0700 (PDT)
Date:   Tue, 2 Aug 2022 12:54:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220802072426.GA2494@thinkpad>
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas>
 <20220730145025.GA4005@thinkpad>
 <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 02:27:14PM -0600, Rob Herring wrote:
> On Sat, Jul 30, 2022 at 8:50 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Jul 29, 2022 at 05:44:04PM -0500, Bjorn Helgaas wrote:
> > > [+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]
> > >
> > > On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> > > > On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > > > > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > > > > Platforms that cannot support their core initialization without the
> > > > > > reference clock from the host, implement the feature 'core_init_notifier'
> > > > > > to indicate the DesignWare sub-system about when their core is getting
> > > > > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > > > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > > > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > > > > after the core initialization.
> 
> > >   6) What's going on with the CORE_INIT and LINK_UP notifiers?
> > >      dw_pcie_ep_init_notify() is only called by qcom and tegra.
> > >      dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
> > >      As far as I can tell, nobody at all registers to handle those
> > >      events except a test.  I think it's pointless to have that code
> > >      if nobody uses it.
> > >
> >
> > I have submitted an actual driver that makes use of these notifiers:
> > https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/
> 
> Notifiers aren't the best interface in the kernel. I think they are
> best used if there's no real linkage between the sender and receiver.
> For an EPC and EPF that's a fixed interface, so define a proper
> interface.
> 

Fair point! The use of notifiers also suffer from an issue where the notifier
chain in EPC is atomic but the EPF calls some of the functions like
pci_epc_write_header() could potentially sleep.

I'll try to come up with an interface.

Thanks,
Mani

> Rob

-- 
மணிவண்ணன் சதாசிவம்
