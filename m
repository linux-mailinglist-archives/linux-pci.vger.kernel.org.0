Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3416FA105
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjEHH3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjEHH3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 03:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B21FCA;
        Mon,  8 May 2023 00:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFAD6143D;
        Mon,  8 May 2023 07:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8311C433EF;
        Mon,  8 May 2023 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683530976;
        bh=QYoiTNHFZEqGybwhKo05B4+WWkeOYZmiAXiX9c5mJYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJikfTEhYskTkvFyoBP74TbFieq87m7BqjNeVLegvApmsBERBa7b4X9zvLcYgoeS8
         gTc4f58aIAZf4ha9GumNFydU+c7JJOqcE3KTkPiIn9xcQ0ZiXYNplUTrHAQWDMvAxf
         XAVw86wToN62MBjfcnkTB6eca2cAATFMS79psrEAwaHoIlJSK7UNgnmw60MJQXwR/v
         pQrSrjun7Qg6GA2gurw5iM5eLe3+oqeujLeVB8II9w0VLso74YQOqK6Lx2evmvBTdd
         k0dKwkdxXu+D9XPrFT9HDRn5ysiJMCO8y5Gb+H04kB2WSuUyueZ3YWC9W1Vi0w5aMl
         eN6Fz0F1qZZXQ==
Date:   Mon, 8 May 2023 09:29:28 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Damien Le Moal <dlemoal@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [GIT PULL] PCI changes for v6.4
Message-ID: <ZFik2MWYanYEAuUH@lpieralisi>
References: <20230427032816.GA18461@wunner.de>
 <20230427035322.GA213435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427035322.GA213435@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 10:53:22PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 27, 2023 at 05:28:16AM +0200, Lukas Wunner wrote:
> > Hi Bjorn,
> > 
> > On Tue, Apr 25, 2023 at 03:09:36PM -0500, Bjorn Helgaas wrote:
> > > The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> > > 
> > >   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-changes
> > > 
> > > for you to fetch changes up to 09a8e5f01dfb30667a8f05e35c1cc073cb4fd134:
> > > 
> > >   Merge branch 'pci/controller/kconfig' (2023-04-20 16:19:37 -0500)
> > 
> > Just a heads-up that this pull request doesn't include the following
> > topic branches in pci.git:
> > 
> >     controller/endpoint
> >     controller/cadence
> >     controller/vmd
> > 
> > ... as well as the following commit on the controller/dt branch:
> > 
> >     661a7e9aa551 ("dt-bindings: PCI: qcom: Add SDX65 SoC")
> 
> Yeah, thanks, this was unfortunate timing.  I did the last updates for
> the v6.4 pull request on Apr 20, left for a long weekend, and Lorenzo
> merged the branches you mentioned on Apr 21.
> 
> If they were critical, maybe a second pull request could work, but I
> don't plan on that because they haven't had any time in -next yet.
> 
> I'll try not to delete them before v6.5; here are the heads in case I
> forget:
> 
>   eac223e85208 remotes/pci/controller/cadence
>   661a7e9aa551 remotes/pci/controller/dt
>   604de32d55a2 remotes/pci/controller/endpoint
>   e06720c1d9e1 remotes/pci/controller/vmd

I rebased these branches on top of v6.4-rc1 and pushed them out.

Thanks,
Lorenzo
