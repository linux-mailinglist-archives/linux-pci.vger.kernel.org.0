Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846DC6E0F31
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjDMNtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDMNtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 09:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BBE900F;
        Thu, 13 Apr 2023 06:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F057463EB9;
        Thu, 13 Apr 2023 13:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85363C433EF;
        Thu, 13 Apr 2023 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681393776;
        bh=PIQWxC9aTPIf5rBky0brQiHVlrCXX748Hlc0qxobWWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssbDb/ROcuAm1lbADBnLEOxZ36OxR1HvuPA7vufkKTMh7dVHBN21dNyd1wjTTlj9i
         tIk1B1bFxpgUr77LDJ2BzuTsGKsS/KeI25HuF8pGbii4YJPTMl0w2pyKxZRfYBEFkA
         n9zs07dhFigJJBJKJV9wL9AJLcigMIDtqBRlWyESwHs9JZD2UigsL06MFKUn4I1oFj
         sPogYgWbE+6mLu9nac0AZAhuxmObCJ12UUPqfCGaz6lde1d36zuqsEhLq/QIwTnXt9
         10BQnh+JOdJ35LsdtYzwMcA2KNui53jnvbGgpYYMbzucJTwPYsgICkfAl77oICevxB
         TcJgwPClp/8mA==
Date:   Thu, 13 Apr 2023 15:49:26 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint
 controller driver
Message-ID: <ZDgIZmCgLoC/uieX@lpieralisi>
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
 <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
 <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
 <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com>
 <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
 <CAAEEuhoB2LqL=B_BQ0X2T-E+Yt83kPUiv-R9dgU0O-f22ukcWg@mail.gmail.com>
 <CAAEEuhp5WTkaPDRLa8frc9Sc43A3HwApW647v-E9Bse6p5Df5Q@mail.gmail.com>
 <15208569-b3d7-b9f7-6676-9d9122cac84a@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15208569-b3d7-b9f7-6676-9d9122cac84a@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 17, 2023 at 07:09:04AM +0900, Damien Le Moal wrote:
> On 3/17/23 01:34, Rick Wertenbroek wrote:
> >>> By the way, enabling the interrupts to see the error notifications, I do see a
> >>> lot of retry timeout and other recoverable errors. So the issues I am seeing
> >>> could be due to my PCI cable setup that is not ideal (bad signal, ground loops,
> >>> ... ?). Not sure. I do not have a PCI analyzer handy :)
> > 
> > I have enabled the IRQs and messages thanks to your patches but I don't get
> > messages from the IRQs (it seems no IRQs are fired). My PCIe link seems stable.
> > The main issue I face is still that after a random amount of time, the BARs are
> > reset to 0, I don't have a PCIe analyzer so I cannot chase config space TLPs
> > (e.g., host writing the BAR values to the config header), but I don't think that
> > the problem comes from a TLP issued from the host. (it might be).
> 
> Hmmm... I am getting lots of IRQs, especially the ones signaling "replay timer
> timed out" and "replay timer rolled over after 4 transmissions of the same TLP"
> but also some "phy error detected on receive side"... Need to try to rework my
> cable setup I guess.
> 
> As for the BARs being reset to 0, I have not checked, but it may be why I see
> things not working after some inactivity. Will check that. We may be seeing the
> same regarding that.
> 
> > I don't think it's a buffer overflow / out-of-bounds access by kernel
> > code for two reasons
> > 1) The values in the config space around the BARs is coherent and unchanged
> > 2) The bars are reset to 0 and not a random value
> > 
> > I suspect a hardware reset of those registers issued internally in the
> > PCIe controller,
> > I don't know why (it might be a link related event or power state
> > related event).
> > 
> > I have also experienced very slow behavior with the PCI endpoint test driver,
> > e.g., pcitest -w 1024 -d would take tens of seconds to complete. It seems to
> > come from LCRC errors, when I check the "LCRC Error count register"
> > @0xFD90'0214 I can see it drastically increase between two calls of pcitest
> > (when I mean drastically it means by 6607 (0x19CF) for example).
> > 
> > The "ECC Correctable Error Count Register" @0xFD90'0218 reads 0 though.
> > 
> > I have tried to shorten the cabling by removing one of the PCIe extenders, that
> > didn't change the issues much.
> > 
> > Any ideas as to why I see a large number of TLPs with LCRC errors in them ?
> > Do you experience the same ? What are your values in 0xFD90'0214 when
> > running e.g., pcitest -w 1024 -d (note: you can reset the counter by writing
> > 0xFFFF to it in case it reaches the maximum value of 0xFFFF).
> 
> I have not checked. But I will look at these counters to see what I have there.

Hi,

checking where are we with this thread and whether there is something to
consider for v6.4, if testing succeeds.

Thanks,
Lorenzo
