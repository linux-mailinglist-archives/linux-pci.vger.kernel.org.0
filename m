Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225C7CE324
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjJRQrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRQrf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E4EAB;
        Wed, 18 Oct 2023 09:47:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C32C433C7;
        Wed, 18 Oct 2023 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697647653;
        bh=7DxP+VzAPrpmHrHz9hsz4GlUetrZemXQgLSBXuzIZcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fT3vrmc3d8oRWFwdz2RG3CQg4HjjnhUByGGFLAXgqHKfXeIbYuX/BCemBrMEXe8rs
         tHdCUrDG4efTyMzz9CfxETwf3aWfUxPyDmnW3l9kGJ1ZHDiJtsIRAbg0X4H/MK7pzJ
         srtKYetYZeE+BsWnuSw/he8oXv+2dfBBntDCl4IAbKEkEqZ18ra2K8TWdXTE5qksRU
         8qRUfJT798KY5c8bTG74vk9l3wI98kLG/3erO6//UDfgYzoyz/ziRTWel4uogZW0Kn
         /d7yc1zMVV4ma2ykkUhS73h6TH0YGwDrjxKlJmM1mD6J/D/e8FfJqaLu2knqslDL/J
         GASyDqQvTJtxA==
Date:   Wed, 18 Oct 2023 11:47:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add host_post_init() callback
Message-ID: <20231018164731.GA1365588@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017075952.GC5274@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 01:29:52PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 16, 2023 at 03:58:49PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 10, 2023 at 09:29:13PM +0530, Manivannan Sadhasivam wrote:
> > > This callback can be used by the platform drivers to do configuration once
> > > all the devices are scanned. Like changing LNKCTL of all downstream devices
> > > to enable ASPM etc...
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
> > >  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index a7170fd0e847..7991f0e179b2 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -502,6 +502,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	if (ret)
> > >  		goto err_stop_link;
> > >  
> > > +	if (pp->ops->host_post_init)
> > > +		pp->ops->host_post_init(pp);
> > 
> > I know we talked about this a little bit in the context of enabling
> > ASPM for devices below qcom 1.9.0 controllers at
> > https://lore.kernel.org/r/20231011050058.GC3508@thinkpad
> > 
> > But I didn't realize at the time that this callback adds a fundamental
> > difference between devices present at boot-time (these devices can be
> > affected by this callback) and any devices hot-added later (we never
> > run this callback again, so anything done by .host_post_init() never
> > applies to them).
> > 
> > We merged this for now, and it helps enable ASPM for builtin devices
> > on qcom, but I don't feel good about this from a larger DWC
> > perspective.  If other drivers use this and they support hot-add, I
> > think we're going to have problems.
> 
> If someone is going to add same ASPM code in host_post_init()
> callback, they will most likely aware of the hotplug issue. I see
> this as an interim solution overall and we should fix the PCI core
> to handle this. But I do not see any straightforward way to enable
> ASPM by default in PCI core as the misbehaving devices can pull the
> system down (atleast in some x86 cases).

Definitely an interim solution, but the interim is going to be long :)

I don't see the PCI core ASPM issue being resolved very soon; it's
been this way ever since the beginning.  I guess there's no point in
me whining without any proposals.

Bjorn
