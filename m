Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2294F6E2B16
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 22:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDNU1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDNU1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 16:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12640DF;
        Fri, 14 Apr 2023 13:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25E8A60BBF;
        Fri, 14 Apr 2023 20:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAB6C433EF;
        Fri, 14 Apr 2023 20:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681504042;
        bh=mGto9gKSSTTM0gjfPcNOwu+t1VdaM4q/g495do+Uqt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NvptJXJfYZg8rRDRCNDqhhIXYMXWrNT6H/HO3Adt5dsfOmgNJDBm4RxAjf1RfS/c4
         XzKK7VN/DJow762nJWUJh1ECAEVuljiC1xdR64Z5T4YNrT5R9cMjedIcWsJHO5eZBr
         0x0rL2c8pf4fLTcAeHUkXmnrQ8HM/AjxDXo6HxQYg5jq49mSX3utwdWL0odxkt4n+2
         gnPwFo65d1LHJsEjImH5PZcJt1KqE2B5+QUkofBHcOgZIPfrdPwkLpg2cz9ZCYqPDq
         y5cegzB+mg5DN9vK6TF35erBUchLXLC2YltXCwOlkiC4kAwLpIwHZc3+ryoa3JHff6
         v0hTSj+rCxYdg==
Date:   Fri, 14 Apr 2023 15:27:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Message-ID: <20230414202720.GA215111@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411165919.23955-3-jim2101024@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This subject line no verb.  Can you add a leading verb to suggest what
this patch does?

s/accomodations/accommodations/

On Tue, Apr 11, 2023 at 12:59:17PM -0400, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
> deliberately set by the probe() into one of three mutually exclusive modes:
> 
>   (a) No CLKREQ# expected or required, refclk is always available.
>   (b) CLKREQ# is expected to be driven by downstream device when needed.
>   (c) Bidirectional CLKREQ# for L1SS capable devices.
> 
> Previously, only (b) was supported by the driver, as almost all STB/CM
> boards operate in this mode.  But now there is interest in activating L1SS
> power savings from STB/CM customers, and also interest in accomodating mode
> (a) for designs such as the RPi CM4 with IO board.

accommodating

> The HW+driver is able to tell us when mode (a) mode is needed.  But there
> is no easy way to tell if L1SS mode should be configured.  In certain
> situations, getting this wrong may cause a panic during boot time.  So we
> rely on the DT prop "brcm,enable-l1ss" to tell us when mode (c) is desired.
> Using this mode only makes sense when the downstream device is L1SS-capable
> and the OS has been configured to activate L1SS
> (e.g. policy==powersupersave).

I'm really concerned about the user experience here.  I assume users
do not want to edit the DT based on what device they plug in.  They
shouldn't need to (and probably won't) know whether the device
supports L1SS.

I hate kernel/module parameters, but I think even that would be better
then having to edit the DT.

There's obviously a period of time when L1SS is supported but not yet
enabled, so I'm *guessing* the "OS has been configured to activate
L1SS" is not actually a requirement, and choosing (c) really just
opens the possibility that L1SS can be used?

Would be nice to have a hint (maybe a line or two of the panic
message) to help users find the fix for a problem they're seeing.

Obviously the ideal would be if we could use (c) in all cases, so I
assume that's where a panic might happen.  What situation would that
be?  An endpoint that doesn't support L1SS?  One that supports L1SS
but it's not enabled?  Maybe if L1SS isn't configured correctly, e.g.,
LTR values programmed wrong?

Bjorn
