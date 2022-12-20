Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D42652810
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiLTUtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 15:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTUtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 15:49:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2113F4A
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 12:49:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B094B8169C
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 20:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6483BC433D2;
        Tue, 20 Dec 2022 20:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671569346;
        bh=b1QzGcjyJ0SvKkss0XqmKPLN8odBoTy+KeVrQOrrXK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2D+9hApS5qFTuwdr5pWtGo0CpBAbnAD5jCn6WMhAftx9E3EqFguuIbA53biGX5YU
         MVMvALX6NnqVuWz4YoCJJghO9qNZ7ZuMMBjUKfaGlwa9RzOjcl1xXukpZkfw8pat6V
         d0SbTBn82Egp+5aQ4A4Q0iM6CZHA49TW5PG0Jt1LAUoTPWCtYALqPUckXTpZ8nWCVE
         2CZv2dSLEZiiAYPpLgtoNjLYbTt7FQpRt/4or4KYxdlDLm0vrseuoOi8Bx0Kdxr36q
         B4ho16vYMs+IvXE1gDQMczGwTMZAiBZIs1uehTIg0WlQQ4AvGJyp0sVHIVzW+YfWLO
         RY9IDaFIh/8uQ==
Date:   Tue, 20 Dec 2022 13:49:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <Y6IfwHicoMojJrIB@dev-arch.thelio-3990X>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022 at 06:46:20PM +0200, Alvaro Karsz wrote:
> Hi Nathan,
> 
> > This does not appear to be a false positive but what was the intent
> > here? Should the local name variables increase their length or should
> > the buffer length be reduced?
> 
> You're right, the local name variables and snprintf argument don't match.
> Thanks for noticing.
> I think that we should increase the name variables  to be
> SNET_NAME_SIZE bytes long.
> 
> How should I proceed from here?
> Should I create a new version for this patch, or should I fix it in a
> follow up patch?

That is up to Michael at the end of the day (each maintainer handles
their tree differently) but I would recommend sending a follow up fix,
as it is easy to fold it in if they want to rebase the tree for it or
just take it as a fix.

Thanks for the quick triage and response!

Cheers,
Nathan
