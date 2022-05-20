Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD41C52EA09
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 12:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbiETKhA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 06:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiETKg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 06:36:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE43D1E6;
        Fri, 20 May 2022 03:36:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p4so12196830lfg.4;
        Fri, 20 May 2022 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJ3gaWI7ls+cENHBhyRJBXNyvaYoDTFV2ZamYkNuQtk=;
        b=BOC1E2lE5UsAVwhOHz0x3YJp39K2ujW746Ya3goMOmV9XCG64s40HclxPIvjLXpyHt
         XwTxdMze0EjyKQjeJCeXNY4dQQ82ZpR2vuB9UzYmwt3tLaogQ4SxLk4Lr4OuOwF7hi+f
         SdA52IeSeMYcH1QonwQCmxxNlbG3iUxM9Q11FlVjVLRXkIMm2tjfK/j1WSipkIYpo3H+
         S7v+Op5+STHIY8mivYEjaZM7BmYLE6W57bcBj/zGGaqjKyzidkRSJ0cC6SrbJ1ZIqL66
         iu5T/82R8EuYZVBbNcCBhe+cJQo+v5+8GozV7U+0E8dMr4/81NkGZwXvRWTtebQL3NfV
         N6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJ3gaWI7ls+cENHBhyRJBXNyvaYoDTFV2ZamYkNuQtk=;
        b=ycYwt4Ej1B83NLh1YlsozQsA9IQ1pd5X9816sgLpAjO/moCVrmgJmUSNB3VSb2reHD
         EIFGKAjfmuvgbhk4ocbC22gXChxpQYlfudZ726IRKG1AzhwhjnuXDr7VpaPOIVoAjqU1
         GIVdM+WER23qY/+HDtF1UhI6S2+VXKgPKMVq9bQmgw0mHChIB4VIfCC+fFRR/HD3mThf
         l5ChSuKlYhssOxs7fpTCTD+9cB7eF6tbBU3j03udXxmh7joE3EyxBdbL6vlHJ2+9MxEV
         0TAXZOzdHJcIrz3xbPD4+YcRr9ZXQxhPr1Y9P67J02BBXorjHuNXYylCdc8I3xwFd4cX
         dtFA==
X-Gm-Message-State: AOAM5305RNoUGlbn08HhZRKXdqowUzzKJySp/fneCSK0ehSfsjAiwIMh
        BVwx4QH/HqjnKXZ0H22k4kQ=
X-Google-Smtp-Source: ABdhPJwecc1nic2z9tHROgs5vxB6dyKh3HqMjdx6kvQ2QR53xiVhDVy/U6Wa1UGa7W/Tk6FPnREvwQ==
X-Received: by 2002:a19:2d0c:0:b0:477:b461:2648 with SMTP id k12-20020a192d0c000000b00477b4612648mr6400254lfj.35.1653043015462;
        Fri, 20 May 2022 03:36:55 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id g4-20020a2ea4a4000000b0024f3d1dae97sm271176ljm.31.2022.05.20.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 03:36:54 -0700 (PDT)
Date:   Fri, 20 May 2022 13:36:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/17] PCI: dwc: Check iATU in/outbound ranges setup
 methods status
Message-ID: <20220520103652.37f6fygtwfmre4ot@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-15-Sergey.Semin@baikalelectronics.ru>
 <20220516213506.GA3296584-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516213506.GA3296584-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 04:35:06PM -0500, Rob Herring wrote:
> On Wed, May 04, 2022 at 12:46:35AM +0300, Serge Semin wrote:
> > Let's make the DWC PCIe RC/EP safer and more verbose for the invalid or
> > failed inbound and outbound iATU windows setups. Needless to say that
> > silently ignoring iATU regions setup errors may cause unpredictable
> > errors. For instance if for some reason a cfg or IO window fails to be
> > activated, then any CFG/IO requested won't reach target PCIe devices and
> > the corresponding accessors will return platform-specific random values.
> > 
> > First of all we need to convert dw_pcie_ep_outbound_atu() method to check
> > whether the specified outbound iATU range is successfully setup. That
> > method is called by the pci_epc_ops.map_addr callback. Thus we'll make the
> > EP-specific CPU->PCIe memory mappings saver.
> > 
> > Secondly since the iATU outbound range programming method now returns the
> > operation status, it will be handy to take that status into account in the
> > pci_ops.{map_bus,read,write} methods. Thus any failed mapping will be
> > immediately noticeable by the PCIe CFG operations requesters.
> > 
> > Finally we need to convert the dw_pcie_setup_rc() method to returning the
> > operation status, since the iATU outbound ranges setup procedure may now
> > fail. It will be especially handy in case if the DW PCIe RC DT-node has
> > invalid/unsupported (dma-)ranges property. Note since the suggested
> > modification causes having too wide code indentation, it is reasonable
> > from maintainability and readability points of view to move the outbound
> > ranges setup procedure in the separate function.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |   9 +-
> >  .../pci/controller/dwc/pcie-designware-host.c | 149 ++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.h  |   5 +-
> >  drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-
> 

> I worry that this could regress some platforms that happened to work 
> before. But only one way to find out...

You are right. It may especially in the framework of the outbound iATU
windows setup procedure due to the new alignment constraints added in
the previous patch. But in that case the returned failure is well
justified by the consequences of the improper windows setup. Anyway
let's hope the regression won't happen.

> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

-Sergey

> 
