Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946E47C54D0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjJKNHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjJKNHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 09:07:32 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1293;
        Wed, 11 Oct 2023 06:07:30 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c88b467ef8so45229235ad.0;
        Wed, 11 Oct 2023 06:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029650; x=1697634450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0MrRBxfAhqGAQTUMB5VLqymynVU/TEY2Oqb3Pi6N1c=;
        b=C+v4TVcXXziCnSmUnUEFlkw+6Xksj4qA6uG2pIFdpMfx52O9/8ytwJBPBxz34VEVLH
         g2CXhYRafSaX+W8vYvkdrBssuNllWJQX38aqbXwL/LrguZPQuM9P/tlzgjcvU++2Dtf7
         VA3rzjqu0B5cgzQrHmDt8SVge6zdh40yGZr/hYh/YZSvotf+Vxq/arlZyhVHJ7RUwKQ3
         aKKI2W95KA2QrSruHY3GyMNT0rEcqOOC9axIQk90mLdS7p6v7HQPWhXaxcglysyhWypk
         kM1I5pvmBwfYK1zFSChe2tnfWwlLhXBjLDDC02Dy3VBORs452AkJJKDXocPeZDhEvbV4
         GTPQ==
X-Gm-Message-State: AOJu0Yw2vakUKSekVCNHFfi9NDmtUjgTGgjtaWaHHKvEiCh26UNOML68
        oUCXFTl0X0u9C/HezuUhAmw=
X-Google-Smtp-Source: AGHT+IEJIy71flEHPki78IbAWF5VJM+itNO5nzN83g85UTiG4j2qUwI4ZjUwXBXjQyROiro3kpcJug==
X-Received: by 2002:a17:902:db0d:b0:1c9:9573:69b3 with SMTP id m13-20020a170902db0d00b001c9957369b3mr9269803plx.30.1697029650150;
        Wed, 11 Oct 2023 06:07:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b8baa83639sm13847477plo.200.2023.10.11.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:07:29 -0700 (PDT)
Date:   Wed, 11 Oct 2023 22:07:27 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Message-ID: <20231011130727.GA3722793@rocinante>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
 <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
 <abf65z7xxsnd7adkg523mneccudwenvdzcw7jpblafqzvhca5n@lbpsch7ztxsn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf65z7xxsnd7adkg523mneccudwenvdzcw7jpblafqzvhca5n@lbpsch7ztxsn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > +	/*
> > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > +	 * Rev.5.20a,
> 
> and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a.

OK.  I can fix this citation later.

> > +      ... we should disable two BARs to avoid unnecessary memory
> > +	 * assignment during device enumeration.
> > +	 */
> > +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
> > +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
> > +
> 
> What's the point in doing this
> 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
> 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>         ...
>         dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> afterward?
> 
> I guess if the BARs are disabled there is no need in having them
> touched. Am I wrong?
> 
> BTW I failed to understand why the BARs inits was originally needed:
> first merging the BAR0 and BAR1 into a single 64-bit BAR, then
> switching it back to two 32-bit BARs. Moreover here is what prior DW
> PCIe RC v5.x databooks say about the BARs:
> 
> "3.5.6 BAR Details
> Base Address Registers (Offset: 0x10-x14)
> The Synopsys core does not implement the optional BARs for the RC
> product. This is based on the assumption that the RC host probably has
> registers on some other internal bus and has knowledge and setup
> access to these registers already."
> 
> I am not sure I fully understand what it means, but it seems as DW
> PCIe cores didn't have anything behind the RC BARs even back then. So
> it seems to me that the BARs manipulation was the Exinos PCIe host
> specific, from which driver they are originating - commit 340cba6092c2
> ("pci: Add PCIe driver for Samsung Exynos").

Would any of the above be something we need to address before this series
can be successfully merged?  I am asking if this is a show stopper,
something we can fix later, or even something I could address once I take
this series again.

Thoughts?

> * BTW Yoshihiro, I am sorry to see your patchset is still under review...(

Yes, we need to draw a line somewhere. :)  I am happy to take this series
so we don't miss another merge window.  We can always fix other bits and
pieces later and iron out any kinks that might have fallen through the
cracks, so to speak.

	Krzysztof
