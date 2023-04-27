Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8EE6EFFF8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 05:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjD0Dx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbjD0DxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 23:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA77C3C13;
        Wed, 26 Apr 2023 20:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6685F63A86;
        Thu, 27 Apr 2023 03:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DE3C433D2;
        Thu, 27 Apr 2023 03:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682567603;
        bh=w0aJ5bRyb08z3UT31OdjqHLRVUCYRSys1DzKqmUscL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hFZjcRQ/BpMxnPEQ8wJzW38dljXtz7cVvbbgVcyuzT0F6ZTjuVvSqg/ZH4AlQ0Qct
         NaoCJh6NkT9Qm0yqB0MTBo5ES3aiO+a7dMN7K6DxZjjAsU4zFtPN4i+UDsa7mUdQVR
         1ClqGiWSRkwCOn4/y8alMCxnOgt7ODhcp7NgcMvca30HWrusnpI3i5HDgb9eAe6lan
         9ve/kqkKbjDEhX2AqXxWCNiANU1juSiCKpDxMSvG+gOSh18JzdTSNXKw4/H4161ZOS
         fR5kD9I3R4ONsxnUyQCx9MGcBxj8apgXKRpJV/6PYtkTw+Z9UiS/3rjO7EsZDf3+Ba
         EJy/p9O22auEg==
Date:   Wed, 26 Apr 2023 22:53:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20230427035322.GA213435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427032816.GA18461@wunner.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 05:28:16AM +0200, Lukas Wunner wrote:
> Hi Bjorn,
> 
> On Tue, Apr 25, 2023 at 03:09:36PM -0500, Bjorn Helgaas wrote:
> > The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> > 
> >   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-changes
> > 
> > for you to fetch changes up to 09a8e5f01dfb30667a8f05e35c1cc073cb4fd134:
> > 
> >   Merge branch 'pci/controller/kconfig' (2023-04-20 16:19:37 -0500)
> 
> Just a heads-up that this pull request doesn't include the following
> topic branches in pci.git:
> 
>     controller/endpoint
>     controller/cadence
>     controller/vmd
> 
> ... as well as the following commit on the controller/dt branch:
> 
>     661a7e9aa551 ("dt-bindings: PCI: qcom: Add SDX65 SoC")

Yeah, thanks, this was unfortunate timing.  I did the last updates for
the v6.4 pull request on Apr 20, left for a long weekend, and Lorenzo
merged the branches you mentioned on Apr 21.

If they were critical, maybe a second pull request could work, but I
don't plan on that because they haven't had any time in -next yet.

I'll try not to delete them before v6.5; here are the heads in case I
forget:

  eac223e85208 remotes/pci/controller/cadence
  661a7e9aa551 remotes/pci/controller/dt
  604de32d55a2 remotes/pci/controller/endpoint
  e06720c1d9e1 remotes/pci/controller/vmd

Bjorn
