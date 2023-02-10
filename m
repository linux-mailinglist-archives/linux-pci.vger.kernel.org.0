Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBE6915DB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 01:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBJAro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 19:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBJArn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 19:47:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C536953C;
        Thu,  9 Feb 2023 16:47:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6D77B82395;
        Fri, 10 Feb 2023 00:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB35CC433EF;
        Fri, 10 Feb 2023 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675990059;
        bh=ukUcmvJZMjG33lSo3oansFJtQTNqfCcgGTUPCoG4ivk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9tTiwjPGPiw3d48v9Vj46z/SqCJcxeV2DdkL+9AOlFffv7LRyHIhPoRzlIDJLR7O
         L2UroC5TwDCDUgBjakCn4aSAZaUCNl0TnuI+sDUVMleXuzNBb6dQY5dK7NzJuhiphv
         DuH84/Lmad0n+XhEiN2TAW1aTH262eJhQMtw4GMpOywF93NGWZ0EVuarOahgZuPJJ9
         ac28nLZUg9lL8F1G6nnAeIOFC8iM5LSzA+RhK/5XuQuSrnjo7VTbjlrdj130k1tQEJ
         DbNWrzEFvcY0lw9lV65tK42JeIj4VgAWSGAv6DB7liNzXAVU5qF9OdPC3BbGgKTQLI
         pBuM1pUJ3mtEA==
Date:   Thu, 9 Feb 2023 17:47:35 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Xinghui Li <korantwork@gmail.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Message-ID: <Y+WUJ/qeyVRxYUhN@kbusch-mbp.dhcp.thefacebook.com>
References: <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
 <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
 <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com>
 <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
 <Y+V8O9kDH5ZXWdBF@kbusch-mbp.dhcp.thefacebook.com>
 <68b40228-d2e6-c63c-751b-972bfea93f41@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68b40228-d2e6-c63c-751b-972bfea93f41@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 09, 2023 at 04:57:59PM -0700, Patel, Nirmal wrote:
> On 2/9/2023 4:05 PM, Keith Busch wrote:
> > On Tue, Feb 07, 2023 at 01:32:20PM -0700, Patel, Nirmal wrote:
> >> On 2/6/2023 8:18 PM, Xinghui Li wrote:
> >>> Keith Busch <kbusch@kernel.org> 于2023年2月7日周二 02:28写道：
> >>>> I suspect bypass is the better choice if "num_active_cpus() > pci_msix_vec_count(vmd->dev)".
> >>> For this situation, My speculation is that the PCIE nodes are
> >>> over-mounted and not just because of the CPU to Drive ratio.
> >>> We considered designing online nodes, because we were concerned that
> >>> the IO of different chunk sizes would adapt to different MSI-X modes.
> >>> I privately think that it may be logically complicated if programmatic
> >>> judgments are made.
> >> Also newer CPUs have more MSIx (128) which means we can still have
> >> better performance without bypass. It would be better if user have
> >> can chose module parameter based on their requirements. Thanks.
> > So what? More vectors just pushes the threshold to when bypass becomes
> > relevant, which is exactly why I suggested it. There has to be an empirical
> > answer to when bypass beats muxing. Why do you want a user tunable if there's a
> > verifiable and automated better choice?
> 
> Make sense about the automated choice. I am not sure what is the exact
> tipping point. The commit message includes only two cases. one 1 drive
> 1 CPU and second 12 drives 6 CPU. Also performance gets worse from 8
> drives to 12 drives.

That configuration's storage performance overwhelms the CPU with interrupt
context switching. That problem probably inverts when your active CPU count
exceeds your VMD vectors because you'll be funnelling more interrupts into
fewer CPUs, leaving other CPUs idle.

> One the previous comments also mentioned something about FIO changing
> cpus_allowed; will there be an issue when VMD driver decides to bypass
> the remapping during the boot up, but FIO job changes the cpu_allowed?

No. Bypass mode uses managed interrupts for your nvme child devices, which sets
the best possible affinity.
