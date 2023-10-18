Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD977CDB63
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjJRMPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjJRMPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 08:15:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFBB11D;
        Wed, 18 Oct 2023 05:15:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c50b7c36so1668631e87.3;
        Wed, 18 Oct 2023 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631340; x=1698236140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXfWPnvyYyEdw9XP4045dFhjhZGSgOa2FC+PwC10OoU=;
        b=BcjEIrG41qXVp1pJDbzXLr5mNTAo9K1G9ymQmQQTXTx69RxT0fwZyP1L5GdEPUGda+
         FQYy+PiOps6pe6nFijnPgaj1MmAGD5WZ8Tt3bwybiVUbTPUpQ95WfrteJcKy47qg79RU
         ufwwr2LXGsiV/CT+pS7eh2zE0KLMj4UJGRBonBioOAUT7+vi6MKMps+uU7YE3x0Ib4g9
         En9/pEzZmW0poDObNcEuSCueod6LvqCkOzOK+COEgL/tas+F4iaishaTTQ9lI/St5jFV
         Khvn8UZ8d9og4D1sekoVhMJY04BejLfDAzYWyPvPO4K8DBgwJLehrIS44HkV3h36PenZ
         dOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631340; x=1698236140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXfWPnvyYyEdw9XP4045dFhjhZGSgOa2FC+PwC10OoU=;
        b=VrV+JVFwfy4lxA3w9si3MM73+qPSN0yzOl2hJPR88YrTbOjjH6jpIQ4fF0Dc+rvfKE
         79xuEnCQ/eHr7l0mceNdipN13E/o9nHZxXH2PdgVseVdKglL+sb0auaF4Ea7MBAgPgB2
         33EhPC4gul2iktHI8qlITgPmMH7pAOHcloNUCJDVh4/3h/1E44iX/MuSA8rfb1RJbz0K
         O0izM/zk5HSH3E4zxheibHzrDnjiUJh6B+PiuPdtzQGSBERz9UytkzGIcLEabWVDRzhj
         MeoPtYZUP589Dic+y8Imi8H8Dyh2o/3OhHY8ssb3SQFTkhvNY01IAPSIeRE0K+8Ip15P
         FleA==
X-Gm-Message-State: AOJu0Yxr9epbS23yDx2LVzMwJSMwxH5+K3ogBYutKbwdyhXTn2sU+KMR
        JSrs9QSrKyxBg8sHJX133P4=
X-Google-Smtp-Source: AGHT+IFX/ugXGrNsrcRQKJdr2EBK1pzY+w3+VcOPNocw5pvAWIgHNsZOCK1dn+4gLkiDBSXLVenNMg==
X-Received: by 2002:ac2:5df5:0:b0:507:b17a:709e with SMTP id z21-20020ac25df5000000b00507b17a709emr3836704lfq.1.1697631340201;
        Wed, 18 Oct 2023 05:15:40 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h9-20020ac24da9000000b0050331960776sm679964lfe.34.2023.10.18.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:15:39 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:15:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Message-ID: <bdsnykgehrgc75cw6rlaog25tuyivj57nwpjh5727fb4yjdrj5@ad3zoftu37bt>
References: <20231018075038.2740534-1-s-vadapalli@ti.com>
 <zje5t7zbaisyzwgvkdxnqwlcadsyegipxbhsxxpbqlnuu45ria@4sqxpgieoig2>
 <6b74d547-bdaf-41e3-8046-ce295a0ecf03@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b74d547-bdaf-41e3-8046-ce295a0ecf03@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 05:26:53PM +0530, Siddharth Vadapalli wrote:
> 
> 
> On 18/10/23 16:41, Serge Semin wrote:
> > On Wed, Oct 18, 2023 at 01:20:38PM +0530, Siddharth Vadapalli wrote:
> >> The ks_pcie_v3_65_add_bus() member of "ks_pcie_ops" was added for
> >> platforms using DW PCIe IP-core version 3.65a. The AM654x SoC uses
> >> DW PCIe IP-core version 4.90a and ks_pcie_v3_65_add_bus() is not
> >> applicable to it.
> > 
> > I'll copy my message from v1 regarding the IP-core version. Are you
> > really sure that it's 4.90a? Here is what my DW PCIe RC
> 
> The HW databook I have is named:
> "PCI Express DM Controller Databook"
> and has the following footnote on every page of the databook:
> 4.90a
> December 2016
> 
> > _v4.90_ HW databook says about the BARs:
> > 
> > "Base Address Registers (Offset: 0x10-x14) The Synopsys core does not
> > implement the optional BARs for the RC product. This is based on the
> > assumption that the RC host probably has registers on some other
> > internal bus and has knowledge and setup access to these registers
> > already."
> > 
> > You cited the next text:
> > 
> > "3.5.7.2 RC Mode. Two BARs are present but are not expected to be
> > used. You should disable them or else they will be unnecessarily
> > assigned memory during device enumeration. If you do use a BAR, then
> > you should program it to capture TLPs that are targeted to your local
> > non-application memory space residing on TRGT1, and not for the
> > application on TRGT1. The BAR range must be outside of the three
> > Base/Limit regions."
> 
> The above text is present in the "PCI Express DM Controller Databook" I
> mentioned above that I have with me which I have cited as-is. I am certain that
> the Databook version I have with me is v4.90a. Additionally, please refer to the
> commit which added support to the PCI Keystone driver for AM654x Platform:
> https://github.com/torvalds/linux/commit/18b0415bc802#diff-1a6482b4ef0eddbe6238232ad346930283832b99270ebabd67385571a619c267R977
> On line 977 in the diff:
> .version = 0x490A,
> 
> > 
> > AFAICS from the v5.20a, v5.30a, v5.40a databooks, it resides in the
> > _v5.x_ databooks only meanwhile the older ones (v4.21, v4.60a, v4.70a
> > and _v4.90a_) describe the BARs as I cited earlier. It makes my
> > thinking that in your case the IP-core isn't of 4.90a version. Could
> > you please clarify how did you detect the version? Did you use the
> > PCIE_VERSION_NUMBER_OFF register available in the PORT_LOGIC CSRs
> 
> The value of the register PCIE_RC_PCIE_VERSION_NUMBER_OFF is:
> 3439302a
> which in ASCII is 490*
> The value of the register PCIE_RC_PCIE_VERSION_TYPE_OFF is:
> 6c703039
> which in ASCII is lp09.
> 
> So I am certain that the Controller is actually version 4.90.

Ok. Thanks for clarification. Then the semantic of the BARs in DW PCIe
RCs only has been changed since v5.10a. Dial-mode controllers had the
BARs available even in the older IP-cores. Good to know discovery
actually.

> 
> 
> > space? If your judgment was based on the Keyston PCIe driver code,
> > then the driver might get to be wrong in that matter.
> > 
> >>
> >> The commit which added support for the AM654x SoC has reused majority
> >> of the functions with the help of the "is_am6" flag to handle AM654x
> >> separately where applicable. Thus, make use of the "is_am6" flag and
> >> change ks_pcie_v3_65_add_bus() to no-op for AM654x SoC.
> >>
> >> Fixes: 18b0415bc802 ("PCI: keystone: Add support for PCIe RC in AM654x Platforms")
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> ---
> >> Hello,
> >>
> >> This patch is based on linux-next tagged next-20231018.
> >>
> >> The v1 of this patch is at:
> >> https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/
> >>
> >> While there are a lot of changes since v1 and this patch could have been
> >> posted as a v1 patch itself, I decided to post it as the v2 of the patch
> >> mentioned above since it aims to address the issue described by the v1
> >> patch and is similar in that sense. However, the solution to the issue
> >> described in the v1 patch appears to be completely different from what
> >> was implemented in the v1 patch. Thus, the commit message and subject of
> >> this patch have been modified accordingly.
> >>
> >> Changes since v1:
> >> - Updated patch subject and commit message.
> >> - Determined that issue is not with the absence of Link as mentioned in
> >>   v1 patch. Even with Link up and endpoint device connected, if
> >>   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
> >>   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
> >>   AER and PME services. The all Fs return value indicates that the MSI-X
> >>   configuration is failing even if Endpoint device is connected. This is
> >>   because the ks_pcie_v3_65_add_bus() function is not applicable to the
> >>   AM654x SoC which uses DW PCIe IP-core version 4.90a.
> >>
> >> Regards,
> >> Siddharth.
> >>
> >>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index 0def919f89fa..3abd59335574 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -459,7 +459,7 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
> >>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> >>  
> > 
> >> -	if (!pci_is_root_bus(bus))
> >> +	if (!pci_is_root_bus(bus) || ks_pcie->is_am6)
> > 
> > 1. IMO defining two versions of the pci_ops struct instances would look
> > more readable:
> > static struct pci_ops ks_pcie_v3_65_ops = {
> >         .map_bus = dw_pcie_own_conf_map_bus,
> >         .read = pci_generic_config_read,
> >         .write = pci_generic_config_write,
> >         .add_bus = ks_pcie_v3_65_add_bus,
> > };
> > 
> > static struct pci_ops ks_pcie_ops = {
> >         .map_bus = dw_pcie_own_conf_map_bus,
> >         .read = pci_generic_config_read,
> >         .write = pci_generic_config_write,
> > };
> > 
> > 2. In case of 1. implemented, ks_pcie_ops will look the same as
> > ks_child_pcie_ops, so the later could be dropped.
> > 
> > 3. I'm not that fluent in the PCIe core details, but based on the
> > pci_host_bridge.child_ops and pci_host_bridge.ops names, the first
> > ones will be utilized for the child PCIe buses, meanwhile the later
> > ones - for the root bus only (see pci_alloc_child_bus()). Bjorn?
> > If so then the pci_is_root_bus() check can be dropped from the
> > ks_pcie_v3_65_add_bus() method. After doing that I would have also
> > changed the name to ks_pcie_v3_65_add_root_bus(). In anyway I would
> > double-check the suggestion first.
> 
> Please note that irrespective of anything else, with no dependence on any prior
> discussions, what remains true is that commit 6ab15b5e7057:
> PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
> introduced a bug. Therefore, I believe that the fix will be to attempt to
> restore the driver's state back to what it was prior to commit 6ab15b5e7057, as
> gracefully as possible, without having to revert commit 6ab15b5e7057.
> 
> In the process of converting .scan_bus() callbacks to .add_bus(),
> .scan_bus method was removed from:
> static const struct dw_pcie_host_ops ks_pcie_host_ops = {
> 	.host_init = ks_pcie_host_init,
> 	.msi_host_init = ks_pcie_msi_host_init,
> 	.scan_bus = ks_pcie_v3_65_scan_bus,
> };
> 
> and added as a .add_bus method to:
> static struct pci_ops ks_pcie_ops = {
> 	.map_bus = dw_pcie_own_conf_map_bus,
> 	.read = pci_generic_config_read,
> 	.write = pci_generic_config_write,
> 	.add_bus = ks_pcie_v3_65_add_bus,
> };
> in addition to renaming the method.
> 
> Even before commit 6ab15b5e7057, with support for AM654x (using version 4.90a
> DWC PCIe IP-core) already present, ks_pcie_ops was being used for AM654x. This
> indicates that prior to commit 6ab15b5e7057, the ks_pcie_ops was applicable to
> AM654x and there's no problem. However, when commit 6ab15b5e7057 converted the
> .scan_bus() method in ks_pcie_host_ops (which wasn't used for AM654x) to
> .add_bus(), it added the method within the shared ks_pcie_ops structure which
> implicitly, *mistakenly*, assumes that a function named "ks_pcie_v3_65_add_bus"
> is also applicable to other controller versions (4.90a in this case). Paying
> attention to the name of the function, it becomes clear that it was added for
> controller version "3.65", hence the name "...v3_65...". The assumption that the
> function/method is applicable to other controller versions as well, was
> incorrect which led to the current issue that can be observed. The commit
> 6ab15b5e7057 ended up adding a new method for a controller version which *never*
> used the method. This therefore is a bug.
> 

> The simplest fix I see is that of exiting ks_pcie_v3_65_add_bus() if:
> ks_pcie->is_am6 is set, since such checks have been scattered throughout the
> same driver prior to the addition of commit 6ab15b5e7057 as well.
> 
> I am open to other implementations of fixing this issue as well. Kindly let me
> know in case of any suggestions.

A simplest fix isn't always the best one. As you said yourself the
ks_pcie_v3_65_add_bus() implies having it called for v3.65. Calling it
for the newer controllers was a mistake causing the bug. Thus having
the ks_pcie_ops utilized for both old and new controllers was also a
mistake. Therefor my suggestion to fix the problem by defining the two
pci_ops structure instances would be more correct at least from the
code readability point of view. It would make the
ks_pcie_v3_65_add_bus() function body and name coherent.

Meanwhile your fix look more like a workaround. The
ks_pcie_v3_65_add_bus() function will be still called for the AM6x
v4.90 controllers, which based on its semantic would be and will be
wrong in any case. So instead of noop-ing the function it would be
better to just drop it being called for the new controllers.

-Serge(y)

> 
> > 
> > -Serge(y)
> > 
> >>  		return 0;
> >>  
> >>  	/* Configure and set up BAR0 */
> >> -- 
> >> 2.34.1
> >>
> 
> -- 
> Regards,
> Siddharth.
