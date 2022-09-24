Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61D45E906A
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 01:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiIXXVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiIXXVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 19:21:54 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734682AC44
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 16:21:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28ONLkC7124329;
        Sat, 24 Sep 2022 18:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664061706;
        bh=v3lCVtkq6BEwNFbBeBeKgPZwfN6yjcH4TCyVEWbvL5c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ANKbLcae3FJoOOvFhRU5QXZnWl0MOcdzgFc+5xi67NO7vUhpIiatvXfNaWKbKSHSz
         8Oc1md3tei951ueKlD43lI2fe1LAtAkRJNtNBKzA+y1vJSUpOGlCbeEjstrZ6i6FZu
         fsIBbvzI/4sd+Pj7FpY+KOG90bd9dJP5L1ovit5Q=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28ONLkA1114073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Sep 2022 18:21:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sat, 24
 Sep 2022 18:21:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sat, 24 Sep 2022 18:21:46 -0500
Received: from ubuntu (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with SMTP id 28ONLfx1111346;
        Sat, 24 Sep 2022 18:21:43 -0500
Date:   Sat, 24 Sep 2022 16:21:41 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tjoseph@cadence.com>,
        <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] PCI: j721e: Add PCIe 4x lane selection support
Message-ID: <Yy+RBVc8tvFop/Jv@ubuntu>
References: <20220909201607.3835-1-mranostay@ti.com>
 <20220909201607.3835-2-mranostay@ti.com>
 <ce9bf8e3-bfb7-5f38-39ac-3a80da2c3839@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce9bf8e3-bfb7-5f38-39ac-3a80da2c3839@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 02:50:19PM +0530, Kishon Vijay Abraham I wrote:
> Hi Matt,
> 
> On 10/09/22 1:46 am, Matt Ranostay wrote:
> > Increase LANE_COUNT_MASK to two-bit field that allows selection of
> > 4x lane PCIe which was previously limited to 2x lane support.
> > 
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > ---
> >   drivers/pci/controller/cadence/pci-j721e.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index a82f845cc4b5..62c2c70256b8 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -43,7 +43,7 @@ enum link_status {
> >   };
> >   #define J721E_MODE_RC			BIT(7)
> > -#define LANE_COUNT_MASK			BIT(8)
> > +#define LANE_COUNT_MASK			GENMASK(9, 8)
> 
> The MASK value as well has to be specific to platforms. For J721E, it is 1
> bit only.
>

Noted. Will revise in next version of the patchset.

- Matt

> Thanks,
> Kishon
> 
> >   #define LANE_COUNT(n)			((n) << 8)
> >   #define GENERATION_SEL_MASK		GENMASK(1, 0)
> > 
