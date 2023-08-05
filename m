Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF42770DF9
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 07:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHEF75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 01:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEF74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 01:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6E4ED0;
        Fri,  4 Aug 2023 22:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B9460A1A;
        Sat,  5 Aug 2023 05:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B7C433C7;
        Sat,  5 Aug 2023 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691215194;
        bh=TE1QwwH7vz6EtoxLzHCs+iszGyZ0+fhxjcjhaceK0JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzZSMoSP/tVdazrZpI4sCnjv3tKv6X9iShg+VAK8EegB8gnMpkqTVu1NhLmSIPLfD
         y40poK0owMLEgViHceveY93+yeh3QxANvwGo0fTRxwgDYr+5bJtaAp3EZzG71+qQRE
         ZSPgRXYClENqXNgTccGsJlQAlDfiRAcZ4EkPKp7c=
Date:   Sat, 5 Aug 2023 07:59:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023080553-daringly-raider-0135@gregkh>
References: <20230801121824.174556-1-alistair.francis@wdc.com>
 <2023080152-disobey-widen-65a4@gregkh>
 <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
 <20230801170739.000048cb@Huawei.com>
 <CAKmqyKND01=xaiB-VFVsi3+KRbxu4dBKfh_RhCN-jric5VzNpA@mail.gmail.com>
 <20230802225248.GA19409@wunner.de>
 <CAKmqyKNypBUPNK37wby-0_7G2-10BmZ4f8WQbevVn9uX1mZreQ@mail.gmail.com>
 <20230804160542.GA19120@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804160542.GA19120@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 06:05:42PM +0200, Lukas Wunner wrote:
> On Fri, Aug 04, 2023 at 11:17:59AM -0400, Alistair Francis wrote:
> > On Wed, Aug 2, 2023 at 6:52???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > I kind of like the approach of exposing a list which can be grep'ed,
> > > even though it may go against the rule of having just one datum per
> > > attribute.  I'd prefer a representation that's human-readable though,
> > > e.g. "0001:01" for CMA-SPDM.
> > 
> > Yeah, it's my preferred method as well, but it's not going to be
> > accepted upstream
> 
> How about procfs instead of sysfs?

No, procfs is for "processes", not devices.

> No "single datum per file" rule over there.
> PCI content goes into /proc/bus/pci/.
> Already used by lspci to access config space.

And that is old legacy stuff, please, let us learn from our past
mistakes in api creation, sysfs was created this way for a reason (i.e.
large files in procfs do not work well over time.)

thanks,

greg k-h
