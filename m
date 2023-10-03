Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA87B7B6F48
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjJCRJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRJh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 13:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C69B
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 10:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAA5C433C7;
        Tue,  3 Oct 2023 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352973;
        bh=vnSqSV90e5l0+qDz3FJaXR3W3AtJA8jqQa4z4xU8cag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rabXCXVE1ECP5sF0+TRV4yaDSYaDtQqCvrfIwdTYb4BKeopVshO2/ga6yviDhwghu
         r7EKKlNh+6grZrmcjcqUJwnOUx/wMmjHbJv19JwQeGeQo5GW6VwsC/A+tiS+s16Clv
         hd8sFoUIqwfLVU2hjEE5cr8m0UKntRHrwrdWyuBRNT7eogYpyhvjUyo2ypD/xf+d6J
         9q7P6UkndZDnB4oa29GbYukIyClJudZiDLaOkyCpSD60xa/fyoA58nrJqDfiTbrmia
         YmrItrZrwmppBRAPNh5PBsKJw2/7E39zyXLcqGNGYKP0W/SAKlSf4Fpi16RAWDdM1H
         sdP5S65rig4dQ==
Date:   Tue, 3 Oct 2023 12:09:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20231003170930.GA678318@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1560d56-881b-4f86-b25f-63f351d10b8d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 29, 2023 at 09:05:55PM -0500, Mario Limonciello wrote:
> On 9/29/2023 14:44, Bjorn Helgaas wrote:
> ...

> > This is a lot of hassle to look for USB4 devices below the Root Port.
> > You said earlier that these Root Ports *only* connect to xHCI and
> > USB4 [1].
> 
> That's correct, but the part that I believe you're missing is that there are
> multiple "instances" of this PCI device ID on a failing system.
> 
> On an OEM Phoenix laptop in front of me I see 3 instances of 1022:14eb:
> 00:08.1, 00:08.2, and 00:08.3.
> 
> > If that's the case, why even bother with the search?
> > Why not just clear PCI_PM_CAP_PME_D3hot and PCI_PM_CAP_PME_D3cold
> > unconditionally, e.g., the possible patch below?
> 
> Only the one with the USB4 controller (in this system it's at 00:08.3) has
> the problem.
> 
> So I believe the proposal you have below will apply the policy to too many
> ports.

Ah, thanks for clearing that up; I've been laboring under that
misapprehension for a long time.

Bjorn
