Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36976213AB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKHNws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiKHNw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 08:52:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BB60EBE;
        Tue,  8 Nov 2022 05:52:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p8so21278228lfu.11;
        Tue, 08 Nov 2022 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qj3oIcHyS3qss14Y0kNXWMR5kk6QHMclGVuX5Mg4TU=;
        b=fpu5Yx2ZJcHB7yI+kOC42NrFSMfoP27zZZEGb2ATwOeRtUmN4UxNFwT80MtTpEWUtQ
         RzAu9a0lkUtzy+hkDSI2Vbfgt9Dkf3xufhU/TTDtDE2SgYc58RdygKJbNOB7jMdnblRh
         aqXdouUpidnPIUIAvLqwXINJ5qoqZti8tWPm4VgF0Ox0DFiHH58rfzEy9dsn1QJixO5z
         DWR91LoNDUozHtiC0qpz1AJFy+vVPiG9jVs/W4Lx+b0/LcV9cPDjniDsdQBkQv+dTHa2
         Z5vjPJdzbtuEFZ+M5XEprXGi1pD5kRWKGuA72O2xbYM0KAFcTGkbDI4CFffuZduUzjhR
         WO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qj3oIcHyS3qss14Y0kNXWMR5kk6QHMclGVuX5Mg4TU=;
        b=OG6jeKR0h4VaaVSWI3rG2UVsUQtFk6Y3EWn1V+Eblz1PMflznL1osmpyJyoD+bO0JV
         s2vUG6nHQRgx1YfqolPReGNVZ18XkOSSHB2ojlInQeUdL/XQwB7GsAPTtneMr/FH/sXB
         I+7p/bYd+jvyDToA0bnesjahFoOecgPEzdV2PHFduTUkkP2D2NWmJd0Lgjcm8O8cv4/G
         D9UpRBOCW7xgG2ZzWfeqYvuJq+vIiQwskHj7F1QS+qG9uftJiYqdbC8Au2LgXo3E7gsc
         4EiAY+vfyqmcBjOQWrveZzeVU2vVWpRHoEApXZ+cOBiEb2LMDiTCWukpn6AicXBsHD9/
         fCLw==
X-Gm-Message-State: ACrzQf2gu8TQ9z2qMAdml/7aBJEyhKerLjMe4LMdueTh6YaoKy+buGw+
        xxbvZ/Me7mhssjD7P/yPWIc=
X-Google-Smtp-Source: AMsMyM6EXzypZ307w4b62mG/V7hiB1Dn9cCnFvU1xUqxPaaXebOD/qgopIIWYwjbQZavgrJjiWgqxg==
X-Received: by 2002:a05:6512:64:b0:4ae:2465:192a with SMTP id i4-20020a056512006400b004ae2465192amr18259365lfo.62.1667915541449;
        Tue, 08 Nov 2022 05:52:21 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bi27-20020a0565120e9b00b0049f9799d349sm1782870lfb.187.2022.11.08.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:52:20 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:52:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <20221108135218.v3jsla67372wt7ny@mobilestation>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB5341E18D15BF78FFD6FA9782D83F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341E18D15BF78FFD6FA9782D83F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro

On Tue, Nov 08, 2022 at 12:40:54PM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Tuesday, November 8, 2022 5:49 AM
> > 
> > Currently the 'interrupts' and 'interrupt-names' properties are defined
> > being too generic to really describe any actual IRQ interface. Moreover
> > the DW PCIe End-point devices are left with no IRQ signals. All of that
> > can be fixed by adding the IRQ-related properties to the common DW PCIe
> > DT-schemas in accordance with the hardware reference manual. The DW PCIe
> > common DT-schema will contain the generic properties definitions with just
> > a number of entries per property, while the DW PCIe RP/EP-specific schemas
> > will have the particular number of items and the generic resource names
> > listed.
> > 
> > Note since there are DW PCI-based vendor-specific DT-bindings with the
> > custom names assigned to the same IRQ resources we have no much choice but
> > to add them to the generic DT-schemas in order to have the schemas being
> > applicable for such devices. These names are marked as vendor-specific and
> > should be avoided being used in new bindings in favor of the generic
> > names.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Note without the next dtschema tool fix
> > 
> > --- a/lib.py 2022-09-29 15:17:13.100033810 +0300
> > +++ b/lib.py     2022-09-29 15:19:54.886172794 +0300
> 

> JFYI.
> 
> git am command could not work correctly by this lib.py file:
> ---
> Applying: dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> error: lib.py: does not exist in index
> Patch failed at 0001 dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> ---
> 
> If I used patch command and skipped the lib.py, it could apply this patch correctly.

Got it. Thanks for the note. I'll either drop this part on the next
patchset revision (hopefully Rob will do something about that by then)
or make it less looking like a patch so git am wouldn't be confused.

-Sergey 

> 
> Best regards,
> Yoshihiro Shimoda
> 
