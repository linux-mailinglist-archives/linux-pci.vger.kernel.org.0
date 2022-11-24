Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2C637330
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 08:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKXH7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 02:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXH7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 02:59:01 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D721C5620
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 23:59:00 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AO7wgjY024962;
        Thu, 24 Nov 2022 01:58:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669276722;
        bh=iPLh6/TVZRHRHNZkSQE3CgXmizLDXq3NYSh1QwG6W8Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=omVG6GJbBac4AEFBJjFZljdHDKqUGy2yTqN7WZ3HAljyK9OVzaw4FhCnSvPWQgHE1
         tV/2wJlP3jaAMjfkPeHppEWrAOTvnb9ujDpRnc2H8jGQoM9lwqwQslaFetLnhl1QTF
         5Ra4uQtWRcLpkxB2j60gw3MQbvSDQBGwSCbZpuuc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AO7wg40011744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Nov 2022 01:58:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 24
 Nov 2022 01:58:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 24 Nov 2022 01:58:41 -0600
Received: from ubuntu (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id 2AO7wWAK009188;
        Thu, 24 Nov 2022 01:58:34 -0600
Date:   Wed, 23 Nov 2022 23:58:31 -0800
From:   Matt Ranostay <mranostay@ti.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Message-ID: <Y38kJ0nEBf+Mztpe@ubuntu>
References: <20221115150335.501502-1-mranostay@ti.com>
 <20221115150335.501502-2-mranostay@ti.com>
 <36a9ac00-669d-08ae-558d-c85fd9715cb3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36a9ac00-669d-08ae-558d-c85fd9715cb3@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 23, 2022 at 05:04:15PM +0100, Krzysztof Kozlowski wrote:
> On 15/11/2022 16:03, Matt Ranostay wrote:
> > Add num-lanes schema checks based on compatible string on available
> > lanes for that platform.
> > 
> > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > ---
> >  .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
> >  .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
> >  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You miss not only people but also lists, meaning this will not be
> automatically tested.
>

Noted. Reran script with --git as well and it picked up a few additional people
to Cc.

Will resend with commit message wordwrapping fixes

- Matt

> So: NAK
> 
> Best regards,
> Krzysztof
> 
