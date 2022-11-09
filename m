Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CE622F1B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKIPfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKIPfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 10:35:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590BFF7;
        Wed,  9 Nov 2022 07:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F97E61B7A;
        Wed,  9 Nov 2022 15:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD11C433D6;
        Wed,  9 Nov 2022 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668008145;
        bh=LhZ+WjU7cSTCcqle6TSdTZQmNC7lZrjyrwVVzROOAoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3fQ3ICluA9Zcx34dPXCyRlAAVIQNROlvfRQHOH0VmfSD/l3RwoPvXLq76a9KJUAX
         wCfL829a2E3baedcfG6gzEkrlmvj0y/v1KNkXBLWVCaVvEdpbAMRsXvbry7besDYrv
         tAqLavWVeFqSKr2A7JqiMCUSNeglwoH+pjXZVO6TlG42t8GA8OtOfnrlDYSsmRMVD8
         2YHG783DGRAoaNBUCt8i923oPMSfGtW/a/fxMtmtQPw8vIS1xw9xi7MXoXueYuON5A
         p9Xp6Fms/X0vo8TpFxQqfXTu3pmgHsZoy9vjV5J5KqslKXJ1O5oIKSyzMV+s/PQyMH
         iGKr8VI8SkAsg==
Date:   Wed, 9 Nov 2022 21:05:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Message-ID: <20221109153533.GA46277@thinkpad>
References: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
 <20221003180949.GA2104321@bhelgaas>
 <20221003182147.jp5gn2jpnf4gucdl@pali>
 <364fc93d-a4b5-59cb-c62a-8e3b32507523@nvidia.com>
 <9210e81f-15ee-6c54-bfbb-1188da48dd68@nvidia.com>
 <38c1d688-1488-3ecb-422e-fbc47106c144@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38c1d688-1488-3ecb-422e-fbc47106c144@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 08:16:06AM +0530, Vidya Sagar wrote:
> 
> 
> On 10/10/2022 11:44 AM, Vidya Sagar wrote:
> > 
> > 
> > On 10/4/2022 9:34 AM, Vidya Sagar wrote:
> > > 
> > > 
> > > On 10/3/2022 11:51 PM, Pali Rohár wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Monday 03 October 2022 13:09:49 Bjorn Helgaas wrote:
> > > > > On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
> > > > > > On 10/1/2022 10:20 AM, Pali Rohár wrote:
> > > > > > ...
> > > > > 
> > > > > > > Would not it better to rather synthesise PCIe Slot
> > > > > > > Capabilities support
> > > > > > > in your PCIe Root Port device (e.g. via
> > > > > > > pci-bridge-emul.c) and then let
> > > > > > > existing PCI hotplug code to take care for hotplugging? Because it
> > > > > > > already implements all required stuff for
> > > > > > > re-scanning, registering and
> > > > > > > unregistering PCIe devices for Root Ports with Slot
> > > > > > > Capabilities. And I
> > > > > > > think that there is no need to have just another (GPIO based)
> > > > > > > implementation of PCI hotplug.
> > > > > > 
> > > > > > I did that a few years ago (rejected), but can attest to
> > > > > > the robustness of
> > > > > > the pcie hotplug code on non-hotplug slots.
> > > > > > https://lwn.net/Articles/811988/
> > > > > 
> > > > > I think the thread is here:
> > > > > https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
> > > > > 
> > > > > and I'm sorry that my response came across as "rejected".  I intended
> > > > > it as "this is good ideas and good work and we should keep going".
> > > > > 
> > > > > Bjorn
> > > > 
> > > > Nice! So we have consensus that this is a good idea. Anyway, if you need
> > > > help with designing something here, please let me know as I have good
> > > > understanding of all (just two) consumers of pci-bridge-emul.c driver.
> > > > 
> > > 
> > > Thanks all for your comments.
> > > 
> > > I would like to hear from Bjorn / Lorenzo if the design of the
> > > current patch series is fine at a high level or I should explore
> > > emulating the root port's configuration space to fake slot
> > > config/control registers (which in turn depend on the hotplug GPIO
> > > interrupt & state to update Presence Detect related bits in Slot
> > > status register) and use the PCIe native Hot-plug framework itself
> > > to carry out with enabling the Hot-plug functionality?
> > 
> > Bjorn / Lorenzo,
> > Could you please take time to comment on the discussion happened here
> > and the right approach to be followed?
> 
> I'm really sorry to bug you on this, but would like to hear your comments on
> the approach to be taken. So, I would really like to hear your take on this.
> 

Since Bjorn already expressed his good will about the approach, I think you
can just proceed with the emulation layer. I don't think there will be any
controversy.

Thanks,
Mani

> Thanks,
> Vidya Sagar
> 
> > 
> > Thanks,
> > Vidya Sagar
> > 
> > > 
> > > Thanks,
> > > Vidya Sagar
> > > 
> > > 

-- 
மணிவண்ணன் சதாசிவம்
