Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0A7D3039
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjJWKnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWKnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 06:43:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF6B6;
        Mon, 23 Oct 2023 03:43:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a0907896so4600939e87.2;
        Mon, 23 Oct 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698057779; x=1698662579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oEiT384bGfkbjOjNt2CoYZj5lBBBSQEywEOVJHqhpw=;
        b=DY1yu2TnYWTYzR0/H3kd0SzaVjYuBApuDpqUmwyLeNviSh7nnhiW+yXYVdkqk/hlv7
         ZfdXxwUSeaqZBovcIzNHgcBBA8A3wuXnRKLOhKjak8bFmi6/piTQqTgzhVlEZidIGNXa
         Wdw8Xyu4PffMkpB+XuK/f8GdZTSgJystcrIztsqmxW+g33RGRLEwyadMr9eqyUU8D2rn
         AgDKSi6+aA8m/ytCMl+APChH/ExI4zWalfrIKWA6f1DFq3stgFBfleGKpukA4lxKG4up
         z2pHNXhtQipOuTatfa6y0zrLKSz3AUbTQ1c6cExVgaWThqY+sDDUOluNUxWesNqoPiJ6
         +RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698057779; x=1698662579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oEiT384bGfkbjOjNt2CoYZj5lBBBSQEywEOVJHqhpw=;
        b=UI3KiqIcARqwMlzac6Dun5soM8USRacMSZm3dNDpCkIvIRWcyVYp8KWz7OthH6edF9
         4+Zicy5kjzseeW/m+8nHpmeOCkf0VGEB2B9bfjhU1FrwqtRtXYSaNqg0JMHRK1z0MVrn
         ASmZDbgewRy7zoLcDMc234Y5Zt45/43xXR/RWdDzNWpScgwlRLBxhXOvilg+z2g7KMIC
         3rZ+78DS508LBbypoRNrfPT9UXjkSxpJJ0i3UguwSdKVgJXBjE2oQy80Xw7hbe24HZ0X
         uXGLjXjhPxN1YXOZfsvHoExOX4B87xf7c9RvIE2tXVRynURfhJFgOgg9peqF9JKjuM7c
         i3fg==
X-Gm-Message-State: AOJu0Yww8kLFcbelKBRQCmDa/pVxgwPw13SS1RW+lS+NU6fUeOycD6OG
        g06hpdEtmLyU1JXFl4oCLPI=
X-Google-Smtp-Source: AGHT+IFmErRT7kPm8fR7QM0cdFzvI30w0pMop68J0yAKr7kldxFvyb5Q4FPwrxv/Rb7JZDZml7S4pA==
X-Received: by 2002:a19:7613:0:b0:504:7cc6:1ad7 with SMTP id c19-20020a197613000000b005047cc61ad7mr6239748lff.1.1698057778716;
        Mon, 23 Oct 2023 03:42:58 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm1647543lfs.21.2023.10.23.03.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:42:58 -0700 (PDT)
Date:   Mon, 23 Oct 2023 13:42:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <7itgyqntgmjcqh4yk2j76af5h6i6lwpcita7syxxtyi4dhb6up@2qix56u3g4kg>
References: <nw5myorissautj3uzhe2h32imu5v7bycjo3studma7v7dt37g6@tffgtog7x3j5>
 <20231019220847.GA1413474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019220847.GA1413474@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 05:08:47PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 19, 2023 at 01:05:24PM +0300, Serge Semin wrote:
> > On Thu, Oct 19, 2023 at 01:43:30PM +0530, Siddharth Vadapalli wrote:
> > > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > > to controller version 3.65a, while the .add_bus() method had been added
> > > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > > ks_pcie_v3_65_add_bus() method are applicable to the controller version
> > > 4.90a which is present in AM654x SoCs.
> > > 
> > > Thus, fix this by creating ks_pcie_am6_ops for the AM654x SoC which uses DW
> > > PCIe IP-core version 4.90a controller and omitting the .add_bus() method
> > > which is not applicable to the 4.90a controller. Update ks_pcie_host_init()
> > > accordingly in order to set the pci_ops to ks_pcie_am6_ops if the platform
> > > is AM654x SoC and to ks_pcie_ops otherwise, by making use of the "is_am6"
> > > flag.
> > > 
> > > Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > LGTM. Thanks!
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > One more note is further just to draw attention to possible driver
> > simplifications.
> > 
> > > ---
> > > Hello,
> > > 
> > > This patch is based on linux-next tagged next-20231018.
> > > 
> > > The v2 of this patch is at:
> > > https://lore.kernel.org/r/20231018075038.2740534-1-s-vadapalli@ti.com/
> > > 
> > > Changes since v2:
> > > - Implemented Serge's suggestion of adding a new pci_ops structure for
> > >   AM654x SoC using DWC PCIe IP-core version 4.90a controller.
> > > - Created struct pci_ops ks_pcie_am6_ops for AM654x SoC without the
> > >   .add_bus method while retaining other ops from ks_pcie_ops.
> > > - Updated ks_pcie_host_init() to set pci_ops to ks_pcie_am6_ops if the
> > >   platform is AM654x and to ks_pcie_ops otherwise by making use of the
> > >   already existing "is_am6" flag.
> > > - Combined the section:
> > > 	if (!ks_pcie->is_am6)
> > >  		pp->bridge->child_ops = &ks_child_pcie_ops;
> > >   into the newly added ELSE condition.
> > > 
> > > The v1 of this patch is at:
> > > https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/
> > > 
> > > While there are a lot of changes since v1 and this patch could have been
> > > posted as a v1 patch itself, I decided to post it as the v2 of the patch
> > > mentioned above since it aims to address the issue described by the v1
> > > patch and is similar in that sense. However, the solution to the issue
> > > described in the v1 patch appears to be completely different from what
> > > was implemented in the v1 patch. Thus, the commit message and subject of
> > > this patch have been modified accordingly.
> > > 
> > > Changes since v1:
> > > - Updated patch subject and commit message.
> > > - Determined that issue is not with the absence of Link as mentioned in
> > >   v1 patch. Even with Link up and endpoint device connected, if
> > >   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
> > >   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
> > >   AER and PME services. The all Fs return value indicates that the MSI-X
> > >   configuration is failing even if Endpoint device is connected. This is
> > >   because the ks_pcie_v3_65_add_bus() function is not applicable to the
> > >   AM654x SoC which uses DW PCIe IP-core version 4.90a.
> > > 
> > > Regards,
> > > Siddharth.
> > > 
> > >  drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > > index 49aea6ce3e87..66341a0b6c6b 100644
> > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > @@ -487,6 +487,12 @@ static struct pci_ops ks_pcie_ops = {
> > >  	.add_bus = ks_pcie_v3_65_add_bus,
> > >  };
> > >  
> > > +static struct pci_ops ks_pcie_am6_ops = {
> > > +	.map_bus = dw_pcie_own_conf_map_bus,
> > > +	.read = pci_generic_config_read,
> > > +	.write = pci_generic_config_write,
> > > +};
> > > +
> > >  /**
> > >   * ks_pcie_link_up() - Check if link up
> > >   * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
> > > @@ -804,9 +810,12 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> > >  	int ret;
> > >  
> > > -	pp->bridge->ops = &ks_pcie_ops;
> > > -	if (!ks_pcie->is_am6)
> > > +	if (ks_pcie->is_am6) {
> > > +		pp->bridge->ops = &ks_pcie_am6_ops;
> > > +	} else {
> > 
> > > +		pp->bridge->ops = &ks_pcie_ops;
> > >  		pp->bridge->child_ops = &ks_child_pcie_ops;
> > 
> > Bjorn, could you please clarify the next suggestion? I'm not that
> > fluent in the PCIe core details, but based on the
> > pci_host_bridge.child_ops and pci_host_bridge.ops names, the first ops
> > will be utilized for the child (non-root) PCIe buses, meanwhile the
> > later ones - for the root bus only (see pci_alloc_child_bus()). Right?
> 
> I think so.  07e292950b93 ("PCI: Allow root and child buses to have
> different pci_ops") says:
> 
>   PCI host bridges often have different ways to access the root and child
>   bus config spaces. The host bridge drivers have invented their own
>   abstractions to handle this. Let's support having different root and
>   child bus pci_ops so these per driver abstractions can be removed.
> 
> https://git.kernel.org/linus/07e292950b93
> 
> > If so then either the pci_is_root_bus() check can be dropped from the
> > ks_pcie_v3_65_add_bus() method since the ops it belong to will be
> > utilized for the root bus anyway, or the entire ks_child_pcie_ops
> > instance can be dropped since the ks_pcie_v3_65_add_bus() method will
> > be no-op for the child buses anyway meanwhile ks_child_pcie_ops
> > matches to ks_pcie_ops in the rest of the ops. After doing that I
> > would have also changed the ks_pcie_v3_65_add_bus name to
> > ks_pcie_v3_65_add_root_bus() in anyway. Am I right?
> 
> Probably so.
> 
> But I don't think this code should be in an .add_bus() method in the
> first place.  Ideally I think the content of ks_pcie_v3_65_add_bus()
> would move to the ks_pcie_host_init() path so we wouldn't need the
> .add_bus() hook at all.
> 
> I think it was added as ks_dw_pcie_v3_65_scan_bus() by 0c4ffcfe1fbc
> ("PCI: keystone: Add TI Keystone PCIe driver"), which doesn't explain
> why doing this after scanning the secondary bus is needed.
> 
> The .scan_bus() hook was added by b14a3d1784a9 ("PCI: designware: Add
> support for v3.65 hardware"), which says:
> 
>   3. MSI interrupt generation requires EP to write to the RC's
>      application register.  So enhance the driver to allow setup of
>      inbound access to MSI IRQ register as a post scan bus API callback.
> 
> That's not a convincing argument for why the BAR setup has to be done
> *after* enumerating the endpoints, but presumably there was some
> reason.

Ok. Thank you very much for clarification. From that perspective
indeed it would be better to move the ks_pcie_v3_65_add_bus() method
invocation to the host_init() callback.

Siddharth, if it won't be that much bother and you have an access to
the v3.65-based Keystone PCIe device, could you please have a look
whether it's possible to implement what Bjorn suggested? *

* it's irrespective to this patch. This fix looks good. If Bjorn
and/or Mani are ok with it, I guess it can be already merged in.

-Serge(y)

> 
> Bjorn
