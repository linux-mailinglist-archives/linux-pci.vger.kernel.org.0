Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA976A9C9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjHAHPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 03:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHAHO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 03:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799141736;
        Tue,  1 Aug 2023 00:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F4E614A3;
        Tue,  1 Aug 2023 07:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062ABC433C8;
        Tue,  1 Aug 2023 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690874097;
        bh=gPwAbo86LLQU6U1a8yUG1H5lS0lBmxDkHINKahtp7dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hipvex/JUh2IqzRD7YQx3cOihcKrpYjMvDIamQZp08wLDO2FysHNlgTTvhbCeqQqp
         srW5ttcbmRh5x0BbPyJ/jQd+Z00FCu+oEo3RImBLxjtu321BRpcdZoOkklawrcn1x0
         HaXcc+iT43c60luRRCrb4BW9+PyEOc8u5G8oVXwq59vL6yXEOi5oiFNHMLCSumFMOa
         C3T6DLtmE0L+IbBONZrn5BjcwaP5aY9oi4ora089nU8OFgKmsT40IS4MlMNzK8Biv2
         pazbd0wBnPiMLjFjH40oh5bJFoZ5UU1InYmJUD9KtP9gNsCNqIXYXj3KBK/yZD2mh5
         /M5yp/n+ANNgw==
Received: by pali.im (Postfix)
        id 13405AB2; Tue,  1 Aug 2023 09:14:54 +0200 (CEST)
Date:   Tue, 1 Aug 2023 09:14:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kevin Xie <kevin.xie@starfivetech.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230801071453.afaulygpczpyhopk@pali>
References: <20230731231223.GA14721@bhelgaas>
 <79e417ee-ef47-3e4b-6b51-bd7f10ac3643@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e417ee-ef47-3e4b-6b51-bd7f10ac3643@starfivetech.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 01 August 2023 15:05:46 Kevin Xie wrote:
> 
> 
> On 2023/8/1 7:12, Bjorn Helgaas wrote:
> > [+cc Pali, Marek because I used f76b36d40bee ("PCI: aardvark: Fix link
> > training") as an example]
> > 
> > On Mon, Jul 31, 2023 at 01:52:35PM +0800, Kevin Xie wrote:
> >> On 2023/7/28 5:40, Bjorn Helgaas wrote:
> >> > On Tue, Jul 25, 2023 at 03:46:35PM -0500, Bjorn Helgaas wrote:
> >> >> On Mon, Jul 24, 2023 at 06:48:47PM +0800, Kevin Xie wrote:
> >> >> > On 2023/7/21 0:15, Bjorn Helgaas wrote:
> >> >> > > On Thu, Jul 20, 2023 at 06:11:59PM +0800, Kevin Xie wrote:
> >> >> > >> On 2023/7/20 0:48, Bjorn Helgaas wrote:
> >> >> > >> > On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
> >> >> > >> >> Add StarFive JH7110 SoC PCIe controller platform
> >> >> > >> >> driver codes.
> >> >> 
> >> >> > >> However, in the compatibility testing with several NVMe SSD, we
> >> >> > >> found that Lenovo Thinklife ST8000 NVMe can not get ready in 100ms,
> >> >> > >> and it actually needs almost 200ms.  Thus, we increased the T_PVPERL
> >> >> > >> value to 300ms for the better device compatibility.
> >> >> > > ...
> >> >> > > 
> >> >> > > Thanks for this valuable information!  This NVMe issue potentially
> >> >> > > affects many similar drivers, and we may need a more generic fix so
> >> >> > > this device works well with all of them.
> >> >> > > 
> >> >> > > T_PVPERL is defined to start when power is stable.  Do you have a way
> >> >> > > to accurately determine that point?  I'm guessing this:
> >> >> > > 
> >> >> > >   gpiod_set_value_cansleep(pcie->power_gpio, 1)
> >> >> > > 
> >> >> > > turns the power on?  But of course that doesn't mean it is instantly
> >> >> > > stable.  Maybe your testing is telling you that your driver should
> >> >> > > have a hardware-specific 200ms delay to wait for power to become
> >> >> > > stable, followed by the standard 100ms for T_PVPERL?
> >> >> > 
> >> >> > You are right, we did not take the power stable cost into account.
> >> >> > T_PVPERL is enough for Lenovo Thinklife ST8000 NVMe SSD to get ready,
> >> >> > and the extra cost is from the power circuit of a PCIe to M.2 connector,
> >> >> > which is used to verify M.2 SSD with our EVB at early stage.
> >> >> 
> >> >> Hmm.  That sounds potentially interesting.  I assume you're talking
> >> >> about something like this: https://www.amazon.com/dp/B07JKH5VTL
> >> >> 
> >> >> I'm not familiar with the timing requirements for something like this.
> >> >> There is a PCIe M.2 spec with some timing requirements, but I don't
> >> >> know whether or how software is supposed to manage this.  There is a
> >> >> T_PVPGL (power valid to PERST# inactive) parameter, but it's
> >> >> implementation specific, so I don't know what the point of that is.
> >> >> And I don't see a way for software to even detect the presence of such
> >> >> an adapter.
> >> > 
> >> > I intended to ask about this on the PCI-SIG forum, but after reading
> >> > this thread [1], I don't think we would learn anything.  The question
> >> > was:
> >> > 
> >> >   The M.2 device has 5 voltage rails generated from the 3.3V input
> >> >   supply voltage
> >> >   -------------------------------------------
> >> >   This is re. Table 17 in PCI Express M.2 Specification Revision 1.1
> >> >   Power Valid* to PERST# input inactive : Implementation specific;
> >> >   recommended 50 ms
> >> > 
> >> >   What exactly does this mean ?
> >> > 
> >> >   The Note says
> >> > 
> >> >     *Power Valid when all the voltage supply rails have reached their
> >> >     respective Vmin.
> >> > 
> >> >   Does this mean that the 50ms to PERSTn is counted from the instant
> >> >   when all *5 voltage rails* on the M.2 device have become "good" ?
> >> > 
> >> > and the answer was:
> >> > 
> >> >   You wrote;
> >> >   Does this mean that the 50ms to PERSTn is counted from the instant
> >> >   when all 5 voltage rails on the M.2 device have become "good" ?
> >> > 
> >> >   Reply:
> >> >   This means that counting the recommended 50 ms begins from the time
> >> >   when the power rails coming to the device/module, from the host, are
> >> >   stable *at the device connector*.
> >> > 
> >> >   As for the time it takes voltages derived inside the device from any
> >> >   of the host power rails (e.g., 3.3V rail) to become stable, that is
> >> >   part of the 50ms the host should wait before de-asserting PERST#, in
> >> >   order ensure that most devices will be ready by then.
> >> > 
> >> >   Strictly speaking, nothing disastrous happens if a host violates the
> >> >   50ms. If it de-asserts too soon, the device may not be ready, but
> >> >   most hosts will try again. If the host de-asserts too late, the
> >> >   device has even more time to stabilize. This is why the WG felt that
> >> >   an exact minimum number for >>Tpvpgl, was not valid in practice, and
> >> >   we made it a recommendation.
> >> > 
> >> > Since T_PVPGL is implementation-specific, we can't really base
> >> > anything in software on the 50ms recommendation.  It sounds to me like
> >> > they are counting on software to retry config reads when enumerating.
> >> > 
> >> > I guess the delays we *can* observe are:
> >> > 
> >> >   100ms T_PVPERL "Power stable to PERST# inactive" (CEM 2.9.2)
> >> >   100ms software delay between reset and config request (Base 6.6.1)
> >> 
> >> Refer to Figure2-10 in CEM Spec V2.0, I guess this two delays are T2 & T4?
> >> In the PATCH v2[4/4], T2 is the msleep(100) for T_PVPERL,
> >> and T4 is done by starfive_pcie_host_wait_for_link().
> > 
> > Yes, I think "T2" is T_PVPERL.  The CEM r2.0 Figure 2-10 note is
> > "2. Minimum time from power rails within specified tolerance to
> > PERST# inactive (T_PVPERL)."
> > 
> > As far as T4 ("Minimum PERST# inactive to PCI Express link out of
> > electrical idle"), I don't see a name or a value for that parameter,
> > and I don't think it is the delay required by PCIe r6.0, sec 6.6.1.
> > 
> > The delay required by sec 6.6.1 is a minimum of 100ms following exit
> > from reset or, for fast links, 100ms after link training completes.
> > 
> > The comment at the call of advk_pcie_wait_for_link() [2] says it is
> > the delay required by sec 6.6.1, but that doesn't seem right to me.
> > 
> > For one thing, I don't think 6.6.1 says anything about "link up" being
> > the end of a delay.  So if we want to do the delay required by 6.6.1,
> > "wait_for_link()" doesn't seem like quite the right name.
> > 
> > For another, all the *_wait_for_link() functions can return success
> > after 0ms, 90ms, 180ms, etc.  They're unlikely to return after 0ms,
> > but 90ms is quite possible.  If we avoided the 0ms return and
> > LINK_WAIT_USLEEP_MIN were 100ms instead of 90ms, that should be enough
> > for slow links, where we need 100ms following "exit from reset."
> > 
> > But it's still not enough for fast links where we need 100ms "after
> > link training completes" because we don't know when training
> > completed.  If training completed 89ms into *_wait_for_link(), we only
> > delay 1ms after that.
> > 
> 
> That's the point, we will add a extra 100ms after PERST# de-assert
> in the patch-v3 according to Base Spec r6.0 - 6.6.1:
>         msleep(100);
>         gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> 
> +       /* As the requirement in PCIe base spec r6.0, system must wait a
> +        * minimum of 100 ms following exit from a Conventional Reset
> +        * before sending a Configuration Request to the device.*/
> +       msleep(100);
> +
>         if (starfive_pcie_host_wait_for_link(pcie))
>                 return -EIO;
> 

Maybe this information can be useful here:
https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/

> >> > The PCI core doesn't know how to assert PERST#, so the T_PVPERL delay
> >> > definitely has to be in the host controller driver.
> >> > 
> >> > The PCI core observes the second 100ms delay after a reset in
> >> > pci_bridge_wait_for_secondary_bus().  But this 100ms delay does not
> >> > happen during initial enumeration.  I think the assumption of the PCI
> >> > core is that when the host controller driver calls pci_host_probe(),
> >> > we can issue config requests immediately.
> >> > 
> >> > So I think that to be safe, we probably need to do both of those 100ms
> >> > delays in the host controller driver.  Maybe there's some hope of
> >> > supporting the latter one in the PCI core someday, but that's not
> >> > today.
> >> > 
> >> > Bjorn
> >> > 
> >> > [1] https://forum.pcisig.com/viewtopic.php?f=74&t=1037
> > 
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-aardvark.c?id=v6.4#n433
