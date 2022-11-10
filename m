Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B40624258
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 13:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKJM0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 07:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKJM0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 07:26:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B105247;
        Thu, 10 Nov 2022 04:26:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so2989200lfk.0;
        Thu, 10 Nov 2022 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBWGKY5TCpH3N2aAaFzNlY4Ec3j6NJwE2FJiVksSqjU=;
        b=KsFjUK6L2YvmLNvcIsZqsenkxt5c7MAETbW0sqIVLJXRaiho8t/rqQ5C4bv3rjIGm1
         KeJChIZKCh9aSqvAVtN8+xAdjmlLn4OF8wwbjKuzhi8ilWbK0hvwGhVu/O0N+/FBGCA8
         wMMGrZHuAaTJ2VWZTz5h0QWkC5HiHBxSK8B5x5MYIWrOV1QQ6Tn5JDaihea+cJdPOJY1
         +GR1rf6sVZyMLL5b33pHlv2DLdEop+tNdInqGAqd2piJc1SOfRLqnrBxtLWrD8Vq4b7N
         atvNaf6VX5/mks426n8Lb1s0jtRSOKV3n4EFWN5E9mBxYoCTJux9RTT5jVXVTgiKNQIp
         6Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBWGKY5TCpH3N2aAaFzNlY4Ec3j6NJwE2FJiVksSqjU=;
        b=VtjzaaH7Uhw2TuYZ3A6Vv1w4eaSOw/ZLp/naZ1SAo2z4Jc1zVfGopOu69r7bU7KtcM
         BDS0M0cHprWw2KoP53X71ku7VkvdofpjvLRBORiroXZ29YMmhgrgWSH9K05drabi4B5r
         QsVhUDHiV+48chFH8HUd7W9JzgxYzFN5SFI9z3eEPBog8nw7EZXNI4jw20KgQFrAdE2K
         JgJeH8MAvFECvdgG+nTXrICEQp1gBB/Vg9Oi3JHrhqEgYoSZuvwUxjg9bc16kjW9WnjG
         YQTD+/+2NJxGjYJKI9303pcIHYG8xcHHdg3gctg4P2Myt9+NLsrAxRIGvjkrJ5vci2oy
         5ixw==
X-Gm-Message-State: ACrzQf37QI5/IZhIoDCGJvXqrgWwoRHWMdyAjOkk1MicN9vU8a/PwKDc
        UFQpC8OEZBhE5wLs6leAg9Maehk/M/5nDA==
X-Google-Smtp-Source: AMsMyM6pAGRiXqJ28AUdihDAzdraAKjZwwLt+ZQ0nsnVwICGWaTOTdw8V/Al69afRI0sMye0LZIDAw==
X-Received: by 2002:a19:660a:0:b0:4aa:9a70:bcca with SMTP id a10-20020a19660a000000b004aa9a70bccamr21009972lfc.520.1668083207733;
        Thu, 10 Nov 2022 04:26:47 -0800 (PST)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id j23-20020a056512345700b00492d064e8f8sm2741049lfr.263.2022.11.10.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 04:26:47 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:26:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Message-ID: <20221110122644.37eopjsjzewy4fvv@mobilestation>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB5341E18D15BF78FFD6FA9782D83F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221108135218.v3jsla67372wt7ny@mobilestation>
 <CAL_JsqLC04=JA6b0ezsm06-SUsEQix=hZLwTgVDuswa_+41qgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLC04=JA6b0ezsm06-SUsEQix=hZLwTgVDuswa_+41qgg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 04:32:22PM -0600, Rob Herring wrote:
> On Tue, Nov 8, 2022 at 7:52 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi Yoshihiro
> >
> > On Tue, Nov 08, 2022 at 12:40:54PM +0000, Yoshihiro Shimoda wrote:
> > > Hi Serge,
> > >
> > > > From: Serge Semin, Sent: Tuesday, November 8, 2022 5:49 AM
> > > >
> > > > Currently the 'interrupts' and 'interrupt-names' properties are defined
> > > > being too generic to really describe any actual IRQ interface. Moreover
> > > > the DW PCIe End-point devices are left with no IRQ signals. All of that
> > > > can be fixed by adding the IRQ-related properties to the common DW PCIe
> > > > DT-schemas in accordance with the hardware reference manual. The DW PCIe
> > > > common DT-schema will contain the generic properties definitions with just
> > > > a number of entries per property, while the DW PCIe RP/EP-specific schemas
> > > > will have the particular number of items and the generic resource names
> > > > listed.
> > > >
> > > > Note since there are DW PCI-based vendor-specific DT-bindings with the
> > > > custom names assigned to the same IRQ resources we have no much choice but
> > > > to add them to the generic DT-schemas in order to have the schemas being
> > > > applicable for such devices. These names are marked as vendor-specific and
> > > > should be avoided being used in new bindings in favor of the generic
> > > > names.
> > > >
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > >
> > > > ---
> > > >
> > > > Note without the next dtschema tool fix
> > > >
> > > > --- a/lib.py 2022-09-29 15:17:13.100033810 +0300
> > > > +++ b/lib.py     2022-09-29 15:19:54.886172794 +0300
> > >
> >
> > > JFYI.
> > >
> > > git am command could not work correctly by this lib.py file:
> > > ---
> > > Applying: dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> > > error: lib.py: does not exist in index
> > > Patch failed at 0001 dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> > > ---
> > >
> > > If I used patch command and skipped the lib.py, it could apply this patch correctly.
> >
> > Got it. Thanks for the note. I'll either drop this part on the next
> > patchset revision (hopefully Rob will do something about that by then)
> > or make it less looking like a patch so git am wouldn't be confused.
> 
> Now fixed in main branch. Thanks for the report.

Ok. I'll drop that chunk from v7 then.

-Sergey

> 
> Rob
