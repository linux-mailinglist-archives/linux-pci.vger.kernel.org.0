Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA85ED48A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiI1GQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI1GQ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 02:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E91114ED;
        Tue, 27 Sep 2022 23:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9991C61D05;
        Wed, 28 Sep 2022 06:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02370C433D6;
        Wed, 28 Sep 2022 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664345788;
        bh=LJ9f0Td4pC/PwOOx+1Koup4UTrM2b9rxSdN1wHR8l7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUcoEH0L4QtFW691ED3O7SySHUiXfrmEPPDpjrftf3wUe/TTnq/T8WmeZUYKToDnB
         DTWKAXV+Bx1LzEQCsZhPrEHQr7Xmz89mlGxGXZc913XWIM0ApBW3k0Soh7uPm97tsB
         Tt66bE6234qsiquPfWPxd99eRRsV2f/2H6j8eSQKAKGYZW1D/OYBMzCKHSES5OzYyI
         vFVXQOjWmubwad4C8RiUxovNH0o16Vxikin8T5i1TjEBmoyXKrD7WaSF5/6dmLEFnd
         yICv5GnXhvVSO0DHUL9zcmZSg1ZD5gtPNoLOItCO2Rjwe//nFsIMNZwI43SIB5oWcZ
         UyEJXhcuix0+w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odQMz-0005ku-LX; Wed, 28 Sep 2022 08:16:33 +0200
Date:   Wed, 28 Sep 2022 08:16:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Add support for modular builds
Message-ID: <YzPmwWeSu9OVWwMf@hovoldconsulting.com>
References: <20220721064720.10762-1-johan+linaro@kernel.org>
 <Yyl+PNcbtSwzlgvh@hovoldconsulting.com>
 <YzL6aS6mktksLnqn@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzL6aS6mktksLnqn@lpieralisi>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 03:28:09PM +0200, Lorenzo Pieralisi wrote:
> On Tue, Sep 20, 2022 at 10:47:56AM +0200, Johan Hovold wrote:
> > Hi Lorenzo,
> > 
> > On Thu, Jul 21, 2022 at 08:47:20AM +0200, Johan Hovold wrote:
> > > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > > is useful for multi-platform kernels as well as during development.
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > > 
> > > Changes in v2
> > >  - rebase on next-20220720 (adjust context)
> > >  - add Rob and Mani's reviewed-by tags
> > 
> > Have you had a change to look at this one since you got back from
> > vacation?
> > 
> > I believe this should be uncontroversial as we already have other
> > modular dwc drivers and there's no mapping of legacy INTx interrupts
> > involved.
> 
> Sincere apologies for the delay.
> 
> I am afraid it does look controversial - I need some time to go through
> the full discussion and make up my mind, unfortunately we are late in
> the cycle and I am dealing with the patch backlog, I believe this may
> end up being a discussion targeting the v6.2 merge window I am afraid.

No worries. Thanks for taking a look.

Johan
