Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9F691434
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 00:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjBIXFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 18:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjBIXFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 18:05:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5646C5FB6E;
        Thu,  9 Feb 2023 15:05:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45805B82361;
        Thu,  9 Feb 2023 23:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108BBC433EF;
        Thu,  9 Feb 2023 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675983934;
        bh=bq1jr2TwYgj/HxTIYE1ou9I8l+tmkO0Q6bCaE6mWlo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIeOVs20glJZ5THoPEI15S1uA5MHY61/LHQFHc+5D3VYGlaEj2s2t21YcPASoB2zF
         HNr3xWwx3rYusnVv+9O+gpmo5cRfKRv6RhZqb4k5hVrdzDe+2pstZRGGNvMHvZk2yI
         /PG7BP7VO+Kti7KcSCRXGSgYHZ5P5DIZxs0cdy+d5koMW5jKGjKc4RcLXPU2PaUNER
         aE2M2RAoWN+LrxRo+QHVd7uv/x2I2VLr+cWBsYt374Net77tItKISVK7lzov6Aoqdq
         abzJ/Sv7fNrh/SCyj4+p1Bx2JPIhWKdE9C1aBlCmQQqc0WG3I87SPwQKf42ZWOAZa8
         9EYkUFQ+1BViQ==
Date:   Thu, 9 Feb 2023 16:05:31 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Xinghui Li <korantwork@gmail.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Message-ID: <Y+V8O9kDH5ZXWdBF@kbusch-mbp.dhcp.thefacebook.com>
References: <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
 <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
 <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
 <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
 <9e6cfda1-4309-d1bb-a0cf-404a7fe7d3aa@linux.intel.com>
 <Y+FG2EUpmsmCZqwh@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYWjaVCDFtCCyHrq5vOie4wV5LFn-UVZ5qQbpASxVGy1TA@mail.gmail.com>
 <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c830a68e-014b-ddec-4bab-5db337fc378f@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 07, 2023 at 01:32:20PM -0700, Patel, Nirmal wrote:
> On 2/6/2023 8:18 PM, Xinghui Li wrote:
> > Keith Busch <kbusch@kernel.org> 于2023年2月7日周二 02:28写道：
> >> I suspect bypass is the better choice if "num_active_cpus() > pci_msix_vec_count(vmd->dev)".
> > For this situation, My speculation is that the PCIE nodes are
> > over-mounted and not just because of the CPU to Drive ratio.
> > We considered designing online nodes, because we were concerned that
> > the IO of different chunk sizes would adapt to different MSI-X modes.
> > I privately think that it may be logically complicated if programmatic
> > judgments are made.
> 
> Also newer CPUs have more MSIx (128) which means we can still have
> better performance without bypass. It would be better if user have
> can chose module parameter based on their requirements. Thanks.

So what? More vectors just pushes the threshold to when bypass becomes
relevant, which is exactly why I suggested it. There has to be an empirical
answer to when bypass beats muxing. Why do you want a user tunable if there's a
verifiable and automated better choice?
