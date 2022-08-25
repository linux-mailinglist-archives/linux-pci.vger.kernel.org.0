Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482685A1821
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiHYRsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiHYRst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 13:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35764B99F9
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 10:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A131961CCB
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 17:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A7C433D6;
        Thu, 25 Aug 2022 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661449728;
        bh=MuO0G7kA4cdfTUAOgzrWCmVBOK+fExAHtWKQ1fba/FM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XNfU30dcGEujUTlo4b1cyYc5VAQijYBRJCYtibn4j6Dn/x1S4RJv91HAXJz2BhDET
         UpClEATz25bH8nU2xmdLLjO7okVTmf9thb9exVYF8ZFyOj7ff7xMnhf8Gcy8qhgzKR
         OUNVs9ikRDfz/EqApJ+Qn50J6CuCXGjSKPgB14JWqz5qG4r+Z3h4po0VuBdL8UzU7X
         a9KtKw9xqkHHKxmAn8X4IbjRjmy23wZ3hrsOYUJbgjTwtYI5cfFI1O7PdPmlEgEYKB
         WlQJ3OmzpNf8gode1DwpF6jqSR1KDyEgefgr5u09woXg0AxkW8rkUmNfRyBRAXtcdf
         bYXW1reThzqKg==
Date:   Thu, 25 Aug 2022 12:48:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "Lazar, Lijo" <lijo.lazar@amd.com>, Stefan Roese <sr@denx.de>,
        Tom Seewald <tseewald@gmail.com>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Message-ID: <20220825174845.GA2857385@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0444020d-e7e6-2fe9-e94e-413c8d3bab38@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 10:18:28AM +0200, Christian König wrote:
> Am 25.08.22 um 09:54 schrieb Lazar, Lijo:
> > On 8/25/2022 1:04 PM, Christian König wrote:
> > > Am 25.08.22 um 08:40 schrieb Stefan Roese:
> > > > On 24.08.22 16:45, Tom Seewald wrote:
> > > > > On Wed, Aug 24, 2022 at 12:11 AM Lazar, Lijo
> > > > > <lijo.lazar@amd.com> wrote:
> > > > > > Unfortunately, I don't have any NV platforms to test. Attached is an
> > > > > > 'untested-patch' based on your trace logs.
> > > > > ...
> > > > 
> > > > I did not follow this thread in depth, but FWICT the bug is solved now
> > > > with this patch. So is it correct, that the now fully enabled AER
> > > > support in the PCI subsystem in v6.0 helped detecting a bug in the AMD
> > > > GPU driver?
> > > 
> > > It looks like it, but I'm not 100% sure about the rational behind it.
> > > 
> > > Lijo can you explain more on this?
> > 
> > From the trace, during gmc hw_init it takes this route -
> > 
> > gart_enable -> amdgpu_gtt_mgr_recover -> amdgpu_gart_invalidate_tlb ->
> > amdgpu_device_flush_hdp -> amdgpu_asic_flush_hdp (non-ring based HDP
> > flush)
> > 
> > HDP flush is done using remapped offset which is MMIO_REG_HOLE_OFFSET
> > (0x80000 - PAGE_SIZE)
> > 
> > WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
> > KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
> > 
> > However, the remapping is not yet done at this point. It's done at a
> > later point during common block initialization. Access to the unmapped
> > offset '(0x80000 - PAGE_SIZE)' seems to come back as unsupported request
> > and reported through AER.
> 
> That's interesting behavior. So far AER always indicated some kind of
> transmission error.
> 
> When that happens as well on unmapped areas of the MMIO BAR then we need to
> keep that in mind.

AER can log many different kinds of errors, some related to hardware
issues and some related to software.

PCI writes are normally posted and get no response, so AER is the main
way to find out about writes to unimplemented addresses.

Reads do get a response, of course, and reads to unimplemented
addresses cause errors that most hardware turns into a ~0 data return
(in addition to reporting via AER if enabled).

Bjorn
