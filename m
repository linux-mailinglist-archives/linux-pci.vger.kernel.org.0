Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC85F3923
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 00:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJCWfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJCWfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 18:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23D2B1A2;
        Mon,  3 Oct 2022 15:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7FFA61207;
        Mon,  3 Oct 2022 22:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F30C433C1;
        Mon,  3 Oct 2022 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664836502;
        bh=/HyUGvOdy05y8ZqPqeV3/QxVPa0YOiDKBVhKygIm+gs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N7xbFDcN2WZiJY3eoRrAwi3O+8rwWa1HXthDTMayS/PqwxChXbJkl65W3EMk6i/4f
         mOXiAv0eZbG4njVFGFE/OKa1LcIARAswPqtTFu2ffK6Didiew2hgyhexBcmQn7Ew++
         rxP/F/LtdnMvIYmYewc5jmkbG9LidtnqRXs8M1xYB3QcKkOlK/ThmqSMGmjCbFV16W
         Fzs41NHN8AKkCXoJcVgIMPgXRYGgz6ieSHhEewm5QT4sHsCqQo0AdGdCfmCSTzo0Vp
         qFxiUv7blSHM8I/L4Ye6vCwe2tdylL/8jrjSj16NxO4+8Qe1LLDCG8BvoDm7dRjRQa
         Fk/yuiTK8YUnQ==
Date:   Mon, 3 Oct 2022 17:35:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Rogalski <rrogalski@tutanota.com>
Cc:     Linux Pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: SPARC64: getting "no compatible bridge window" errors :/
Message-ID: <20221003223500.GA2124698@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926171104.GA1605932@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 12:11:06PM -0500, Bjorn Helgaas wrote:
> [+cc Alex, David, sparclinux, LKML]
> 
> On Sun, Sep 25, 2022 at 06:59:23PM +0200, Richard Rogalski wrote:
> > I hope this is the right place for this.
> 
> This is great, thanks a lot for your report!  Is this a regression?
> If so, what's the most recent kernel that worked?  
> 
> > In my dmesg output, I get things like:
> > 
> > pci 0000:04:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window
> > pci 0000:06:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window
> > pci 0000:06:00.1: can't claim BAR 0 [mem 0x84110200000-0x84110203fff 64bit]: no compatible bridge window
> > 
> > I opened a bug for amdgpu [here](https://gitlab.freedesktop.org/drm/amd/-/issues/2169) but looking further into it I think it is caused by deeper PCIe problems :\
> > 
> > https://gitlab.freedesktop.org/drm/amd/uploads/cbf47807972c8a990bb2a8cdbb39ad9e/8C7CA9QNG dmesg log
> > https://gitlab.freedesktop.org/drm/amd/uploads/6a799425dea50febd82f8bc11e54433a/ll.txt lspci -vv
> > https://gitlab.freedesktop.org/drm/amd/uploads/7d4a794b1f7d67a1ffcdee5dfdec3ad6/config.txt kernel .config
> 
> Your error output attachment [1] contains an address that looks like
> it's in 06:00.0 BAR 5:
> 
>   pci 0000:06:00.0: reg 0x24: [mem 0x84001200000-0x8400123ffff]
>   NON-RESUMABLE ERROR: insn effective address [0x0000084001201410]
> 
> This looks like an amdgpu issue.  There have been recent changes like
> c1c39032a074 ("drm/amdgpu: make sure to init common IP before gmc")
> and dd6aeb4e5f59 ("drm/amdgpu: Don't enable LTR if not supported")
> that could be related.
> 
> The PCI "no compatible bridge window" warnings are definitely an
> issue, but I don't think they're related to the amdgpu crash:
> 
>   pci@400: PCI MEM64 [mem 0x84100000000-0x84dffffffff] offset 80000000000
>   pci_bus 0000:00: root bus resource [mem 0x84100000000-0x84dffffffff] (bus address [0x4100000000-0x4dffffffff])
>   pci 0000:09:00.0: can't claim BAR 0 [mem 0x84120000000-0x8412007ffff 64bit]: no compatible bridge window
> 
> Those and this from lspci:
> 
>   0000:01:00.0 bridge to [bus 02-09] window [mem 0x4100000000-0x412fffffff pref]
>   0000:02:0c.0 bridge to [bus 09]    window [mem 0x4120000000-0x412fffffff pref]
>   0000:09:00.0 Intel 82599ES NIC Region 0: Memory at 0x84120000000
> 
> are telling us there's something wrong with how the resource-to-bus
> offset is being applied.  It looks like the offset was applied to the
> NIC BAR, but didn't get applied to the bridge windows.
> 
> Could you start a new thread here (linux-kernel@vger.kernel.org,
> linux-pci@vger.kernel.org, and sparclinux@vger.kernel.org) for this
> issue and attach the dmesg log when booting with "ofpci_debug=1"?

Any chance you could collect a dmesg log with "ofpci_debug=1"?

I'd like to look at the resource-to-bus offset issue.

> Do the devices we complain about (NICs and storage HBAs 09:00.0,
> 09:00.1, 0d:00.0, 0d:00.1, 0e:00.0, 0f:00.0, 0001:03:00.0,
> 0001:03:00.1, 0001:0:00.0, 0001:0a:00.1) work?
> 
> Bjorn
> 
> [1] https://gitlab.freedesktop.org/drm/amd/uploads/b51f4d6783eeebf90de9a400525d07d6/qq
