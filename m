Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85659895E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiHRQwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345085AbiHRQwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 12:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19966373;
        Thu, 18 Aug 2022 09:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DAB461627;
        Thu, 18 Aug 2022 16:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73517C433D6;
        Thu, 18 Aug 2022 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660841542;
        bh=gGL2JUYPqmg3fi0Eh9tTE9J3b6f1xNz40EMWivm1IQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TrNF3DLkjnGp4cXVbN7UvLZQTH1Ha/KzL4JjJPIE7hRQ3/dJ/vE2Sa791lxl6LmmH
         6XWyH+mPIca2nSNomhloGT4QkCN91foSqP314FJQBY9p0pL7Ngo2gxpF5to6gg1Lah
         /ejmI6iEfMGiBZhlZLZsrYw8ZtaPvIL+vD9uMqQdyvbwD7nzfZAo19nAokEzZqtc4W
         MUCtvysYmH8CEe+YRItfLVu3FAC+pCUVY6DQ+LsUm8iDA2g1NDZ1mQ+UTCLCLlnizT
         Wm6OTmf735kvheDLw969JsLnKjvXkJNv4uzReAQ54qQb2gmezgMuUAz58/3vba9tot
         mZD51ZzrsNWkQ==
Date:   Thu, 18 Aug 2022 11:52:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Message-ID: <20220818165220.GA2378685@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818163756.qmyopspdn5xywe5s@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 06:37:56PM +0200, Pali Rohár wrote:
> On Thursday 18 August 2022 16:59:33 Andrew Lunn wrote:
> > On Thu, Aug 18, 2022 at 03:50:09PM +0200, Pali Rohár wrote:
> > > PING?
> > 
> > Pretty much anything sent during the merge window, and just before the
> > merge window gets thrown away. Please rebase onto the current pci tree
> > and repost.
> 
> Please write it pretty clear that you are not interested in those
> patches, and not hiding this info behind asking me after month of
> waiting for another work of rebase with sending them at eight o'clock
> during full moon. It is pretty ridiculous how to say "go away". Thanks.

Nobody is saying "go away".  I apologize that I haven't had time to
look at this yet.

It's still in patchwork [1], and if it still applies cleanly to
v6.0-rc1, you don't need to do anything.  If it requires rebasing to
apply cleanly, it will expedite things if you do that.

Bjorn

[1] https://patchwork.kernel.org/project/linux-pci/patch/20220714184130.5436-1-pali@kernel.org/
