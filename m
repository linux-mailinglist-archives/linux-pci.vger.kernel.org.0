Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4975B525F2E
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379193AbiEMJhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 05:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358822AbiEMJg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 05:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D02878CF;
        Fri, 13 May 2022 02:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38E29620B3;
        Fri, 13 May 2022 09:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925B6C34100;
        Fri, 13 May 2022 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652434614;
        bh=rZo8vvi6BPIEbRqh0B0UPtp/MPESNnejSpdsZczGo/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJvNS3BUkN2iSBwFNCQ2k/QwSIfCePIph/rKSBcz+PSC2sYg32D0Q+HDHGHjApppe
         LR4ByWRFXEDGylFL6Yx3R0qabDI4AAbs37N3ngR2bqXFtUhwW2MsQZEoJGMJUcdpi9
         A2MkyXXfOiB7dGiZ/+aUnQCi9SJEqqhb+q/wZUjDesqMAKCxMqHVc1QL8zfxR6cz2C
         68Ju3FCderldZKlX3PolPI1Fev0pwZq4Zjk4OJNb1ptORpQqUdGYyfewGa5oQBfokH
         G+RS8m2gPoMxc3fLlXuwhfu1LREZfTULe3+3xxyZXMiY9WniATx/AnIe16ECOokepq
         lwgJe3ycLBxtw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npRj9-0007uE-7J; Fri, 13 May 2022 11:36:51 +0200
Date:   Fri, 13 May 2022 11:36:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 00/10] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <Yn4ms7dKIzeAqt7A@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <Yn4dvpgezdrKmSro@hovoldconsulting.com>
 <CAA8EJppzx5nkyk3gCcgFd2G_QewU0Z6q6DAKb-Lyj9yZyMo_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppzx5nkyk3gCcgFd2G_QewU0Z6q6DAKb-Lyj9yZyMo_AA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 12:28:40PM +0300, Dmitry Baryshkov wrote:
> On Fri, 13 May 2022 at 11:58, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, May 12, 2022 at 01:45:35PM +0300, Dmitry Baryshkov wrote:
> > > I have replied with my Tested-by to the patch at [2], which has landed
> > > in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> > > Add support for handling MSIs from 8 endpoints"). However lately I
> > > noticed that during the tests I still had 'pcie_pme=nomsi', so the
> > > device was not forced to use higher MSI vectors.
> > >
> > > After removing this option I noticed that hight MSI vectors are not
> > > delivered on tested platforms. After additional research I stumbled upon
> > > a patch in msm-4.14 ([1]), which describes that each group of MSI
> > > vectors is mapped to the separate interrupt. Implement corresponding
> > > mapping.
> > >
> > > The first patch in the series is a revert of  [2] (landed in pci-next).
> > > Either both patches should be applied or both should be dropped.
> > >
> > > Patchseries dependecies: [3] (for the schema change).
> > >
> > > Changes since v7:
> > >  - Move code back to the dwc core driver (as required by Rob),
> > >  - Change dt schema to require either a single "msi" interrupt or an
> > >    array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
> > >    part of the array (the DT should specify the exact amount of MSI IRQs
> > >    allowing fallback to a single "msi" IRQ),
> >
> > Why this new constraint?
> >
> > I've been using your v7 with an sc8280xp which only has four IRQs (and
> > hence 128 MSIs).
> >
> > Looks like this version of the series would not allow that anymore.
> 
> It allows it, provided that you set pp->num_vectors correctly (to 128
> in your case).
> The main idea was to disallow mistakes in the platform configuration.
> If the platform says that it supports 256 vectors (and 8 groups),
> there must be 8 groups. Or a single backwards-compatible group.

But you also added 

+        - properties:
+            interrupts:
+              minItems: 8
+            interrupt-names:
+              minItems: 8
+              items:
+                - const: msi0
+                - const: msi1
+                - const: msi2
+                - const: msi3
+                - const: msi4
+                - const: msi5
+                - const: msi6
+                - const: msi7

which means that I can no longer describe the four interrupts in DT.

I didn't check the implementation, but it seems you should derive the
number of MSIs based on the devicetree as I guess you did in v7.

Johan
