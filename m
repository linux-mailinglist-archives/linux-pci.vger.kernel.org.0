Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41DA5F661C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJFMbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 08:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJFMbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 08:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF3D6243;
        Thu,  6 Oct 2022 05:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F73F61912;
        Thu,  6 Oct 2022 12:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1BC433C1;
        Thu,  6 Oct 2022 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665059510;
        bh=qBB40RhNZZef+X0NR2nmNND2hfKC19kCVVV44L/TaaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwZiOIFq049pfooSE6MKrACtd5DV/+7cDblLsBgE831XpG6PsimKdUbuqvS8Co55c
         /AkxpWb+E78ukE2OLYCEItLrhDj/ClkSf3kfPgcKmGfrN3tJJ01zGoPE55GQBZjidO
         4GpO1DH5WFhQcWrkRGQah9Bhq5RR5yhiZVLQx/iGIAWhOQPjYa62sjkh5/Dexgwf8k
         D1X02UXgy2Cuhq15H53EXL3SZCFllp8AOkTp5DTUx1gFA3qec8QkC2FOhOnU0KiiP8
         Ww40Ogm4VWaUCTNBRqvgYDLltkqJF4o/t3uq4mC1kXoHcxOQlMZAo4uEpgc0gxjqFb
         nyR+qpqeJ2JUQ==
Date:   Thu, 6 Oct 2022 14:31:44 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Update comment about config space
Message-ID: <Yz7KsHGyctceNf+T@lpieralisi>
References: <20220911113216.14892-1-pali@kernel.org>
 <YzRcYwQYlawV10QS@orome>
 <20221005194336.gdnu4vfzkudedjw5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005194336.gdnu4vfzkudedjw5@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 05, 2022 at 09:43:36PM +0200, Pali Rohár wrote:

[...]

> > On
> > the other hand there's really no use in keeping this comment around
> > after that other patch because the documentation for the new macro lays
> > out the details already.
> > 
> > Thierry
> 
> Ok, whether documentation is needed or not - it is your maintainer
> decision. Maybe really obvious things do not have to be documented.
> Also another look at this problem can be that if somebody wrote wrong
> documentation for it, maybe it is not too obvious? I do not have opinion
> on this, so choose what is better :-)
> 
> In any case, wrong documentation (which is the current state) should be
> fixed (and removal in most case is also proper fix).

I agree. I would apply this patch if Thierry is still OK with it.

Lorenzo
