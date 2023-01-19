Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE57672D3B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 01:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjASAFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 19:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjASAFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 19:05:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A32D4ABDA;
        Wed, 18 Jan 2023 16:05:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E047361AA0;
        Thu, 19 Jan 2023 00:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1985DC433D2;
        Thu, 19 Jan 2023 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086700;
        bh=XFj3V77eBnU3VzKi4DgSZePbZGDbcn3G9qKgGyp2XD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QVfae5fKfNKNTnr1w12VRmIl8UEoSNkrqGkPAfAs96RiVpacw3sxfePzEuP6ybjmv
         6b3dP/jyE9f62SAearEiXwl76+14iyGEgVcIlTvnt6O5TPGbBWEHcJhjhPQhURi/YO
         ytLUKXCIOt0px7hs6EPrz8C++ng8Ad2QLFedYmqFadDQAVoK+5ZmO/0JtjcDWFqlrm
         DQnpP7MN+O3QeV/NGG22YuniDx4m6J4C9zILlujpyo1SLe4mZ4+gXAJCL2Es2Yh+VN
         dwoNXP6O/sAjKEjYfu/cZ6DMw9jOCe0eU01U88SGvdT1Eny/ElHT1mRNKk5kKOKnwV
         Q9gjXZbxPmZjw==
Date:   Wed, 18 Jan 2023 18:04:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Moreira-Guedes <brunodout.dev@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
Message-ID: <20230119000458.GA275446@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOkhzLW+1z58681zBV7LT=Lw=tcT9EgVPEbKx8YGsa+EJyxUSw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Fri, Jan 06, 2023 at 05:42:33PM +0100, Zeno Davatz wrote:
> On Fri, Dec 30, 2022 at 7:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Dec 28, 2022 at 12:42:34PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 28, 2022 at 06:42:38PM +0100, Zeno Davatz wrote:
> > > > On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > > >
> > > > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > > > >     Kernel Version: 6.1-rc1
> > > > > > ...
> > > > >
> > > > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > > > see attachments.
> > > > > >
> > > > > > The enumeration works fine with Kernel 6.0 and below.
> > > > > >
> > > > > > Same problem still exists with v6.1. and v6.2.-rc1
> > > > >
> > > > > Thank you very much for your report, Zeno!
> > > > >
> > > > > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > > > > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > > > > when it hangs?
> > > >
> > > > I will try this after Januar 7th 2023.
> 
> I updated the issue:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216859
> 
> I booted with the option: "ignore_loglevel initcall_debug"

Thanks!  There's so much pcie output in that picture that we can't see
any of the initcall logging.  Can you capture another movie, but use
kernel parameters like "ignore_loglevel initcall_debug boot_delay=100"
to slow things down?  The full-speed boot is too fast for the camera
to capture all the output.  You can do this on any convenient kernel
that hangs.

There might be more we can do with the bisection, too, but I don't
have any suggestions for that yet.  Maybe Krzysztof does.

Bjorn
