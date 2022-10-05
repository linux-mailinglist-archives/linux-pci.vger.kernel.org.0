Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7C5F5AB3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJETno (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJETnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 15:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF147CB76;
        Wed,  5 Oct 2022 12:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E331EB81F3A;
        Wed,  5 Oct 2022 19:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E397C433D6;
        Wed,  5 Oct 2022 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664999019;
        bh=epayr2GoDHtYX0BIuBJ5J+rd1FUYks1xkQARebFSwdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuIkCTLRHCBxlgxNCzNecEKzbqHqAjOPq/2u9wGxHZZyR0EDpkZ/YKw16qF5NhRFb
         EhmXfodlJEUSoufI+96I06mJ6X4TByLypGNFeDlQTwVWZrGqoR1UUwxNRYejJVXnzX
         4Wnezwq1ZOOdwIA4d3m6rTWjnxmhpccC7qhikHZsTX9beTsPnjP7gwQr1wsjH6eAZG
         /S5yYB276MaEkzzziFq5isjJEsGMri+kiCTKIbPjgrauuzQbwkNJ3i0F3GlqmxW3As
         g00qAH3koZCNk8YmDkejrG4Uv+Nr3nAtanYDhh2VTOoMvoFlnVegpYReYfUl142VSl
         8ifVfkwrFQSng==
Received: by pali.im (Postfix)
        id 5D77E772; Wed,  5 Oct 2022 21:43:36 +0200 (CEST)
Date:   Wed, 5 Oct 2022 21:43:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Update comment about config space
Message-ID: <20221005194336.gdnu4vfzkudedjw5@pali>
References: <20220911113216.14892-1-pali@kernel.org>
 <YzRcYwQYlawV10QS@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzRcYwQYlawV10QS@orome>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 28 September 2022 16:38:27 Thierry Reding wrote:
> On Sun, Sep 11, 2022 at 01:32:16PM +0200, Pali Rohár wrote:
> > Like many other ARM PCIe controllers, it uses old PCI Configuration
> > Mechanism #1 from PCI Local Bus for accessing PCI config space.
> > It is not PCIe ECAM in any case.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Perhaps this should be rolled into the PCI_CONF1_EXT_ADDRESS patch?

Well, I split documentation change and PCI_CONF1_EXT_ADDRESS usage into
two patches as those are two different / separate things. Documentation
change is a fix (because documentation is wrong) and PCI_CONF1_EXT_ADDRESS
is an improvement - code cleanup. And in case if there is a issue with
"cleanup" patch it can be reverted without need to revert also "fix"
part. This is just information how I looked at these changes and why I
decided to split them.

> On
> the other hand there's really no use in keeping this comment around
> after that other patch because the documentation for the new macro lays
> out the details already.
> 
> Thierry

Ok, whether documentation is needed or not - it is your maintainer
decision. Maybe really obvious things do not have to be documented.
Also another look at this problem can be that if somebody wrote wrong
documentation for it, maybe it is not too obvious? I do not have opinion
on this, so choose what is better :-)

In any case, wrong documentation (which is the current state) should be
fixed (and removal in most case is also proper fix).
