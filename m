Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F159A60D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350641AbiHSTHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiHSTHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 15:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC2109A3F
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 12:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1466F61269
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 19:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A461C433D7;
        Fri, 19 Aug 2022 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936047;
        bh=2UVM2XRE/FUVni8pkK9U/xFm+6EJj9n/Nk1XLei+yrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p5KUZ3UIWfHWlrYI+m5He+oj3Z8798pH+5PNGjp3qY9Hhh/dtkNnzalX2/2569W1s
         Va0gEopXhqHFNmemr0vcQl6lSGpx0jdxup/mcZ3UDT97I9sz1y3aTam9q9W3VkJCXT
         +gYKMVy3g+XLbfTSbFQN778PSqzunkMrmtGuncIWFvK+FtmwD+L6Ifdf06jCFeZ4N4
         aVeSoGMNnFM7tyAgb4RSyXygU1JeRL0VS+rjf3Uzk1gEA3+4Z13/D/7ToDN15RDUnz
         XxKegXIJUfuf4/htyosggBkbhEr6QJZczEsroB/nrVXUslRzVKGMWPJMdfGLcx7zox
         OHp8ssXnrNzSQ==
Date:   Fri, 19 Aug 2022 14:07:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     Lijo Lazar <lijo.lazar@amd.com>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stefan Roese <sr@denx.de>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Message-ID: <20220819190725.GA2499154@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819171303.GA2491617@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 12:13:03PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 18, 2022 at 03:38:12PM -0500, Bjorn Helgaas wrote:
> > [Adding amdgpu folks]
> > 
> > On Wed, Aug 17, 2022 at 11:45:15PM +0000, bugzilla-daemon@kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216373
> > > 
> > >             Bug ID: 216373
> > >            Summary: Uncorrected errors reported for AMD GPU
> > >     Kernel Version: v6.0-rc1
> > >         Regression: No
> 
> Tom, thanks for trying out "pci=noaer".  Hopefully we won't need the
> workaround for long.
> 
> Could I trouble you to try the debug patch below and see if we get any
> stack trace clues in dmesg when the error happens?  I'm sure the
> experts would have a better approach, but I'm amdgpu-illiterate, so 
> this is all I can do :)

Thanks for doing this, Tom!  For everybody else, Tom attached a dmesg
log to the bugzilla: https://bugzilla.kernel.org/attachment.cgi?id=301606

Lots of traces of the form:

  amdgpu_device_wreg.part.0.cold+0xb/0x17 [amdgpu]
  amdgpu_gart_invalidate_tlb+0x22/0x60 [amdgpu]
  gmc_v10_0_hw_init+0x44/0x180 [amdgpu]

  amdgpu_device_wreg.part.0.cold+0xb/0x17 [amdgpu]
  gmc_v10_0_hw_init+0xa8/0x180 [amdgpu]

  amdgpu_device_wreg.part.0.cold+0xb/0x17 [amdgpu]
  gmc_v10_0_flush_gpu_tlb+0x35/0x280 [amdgpu]
  amdgpu_gart_invalidate_tlb+0x46/0x60 [amdgpu]
  gmc_v10_0_hw_init+0x44/0x180 [amdgpu]

I tried connecting the dots but I gave up chasing all the function
pointers.
