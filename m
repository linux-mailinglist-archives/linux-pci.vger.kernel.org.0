Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844C1698E01
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 08:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBPHrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 02:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBPHq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 02:46:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED473D0B5;
        Wed, 15 Feb 2023 23:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A986561E9B;
        Thu, 16 Feb 2023 07:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A972C433D2;
        Thu, 16 Feb 2023 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676533616;
        bh=+zie8DFIW086ciac+xBLGHQtfLEE2mebhKoZUUc3aGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCOQ4+MXazvsQMFJRVy+maqrEGE9X6jkTr2pA/aWhfbBmvuVtfsnS2mZn+y03mgfM
         chhfleytQW5kGJUu0M+RD+ezD2Pl//aC7VHybrtlkc3bq8+R1CZdcvslCF6lINsSSE
         5tKPI4e2KFHb8VA0ZrWKxIufRC+JWnTG3In9/PKY9vCpAy/Fj7X4+XVhmilJN3ecPm
         9g1VYNTv6z/VJJJo3Y34Vq5l/8kEtOMltYSwtRCQliclIsOqH9FdSUZq5BPN3SMIAe
         9LYyGQmnMYgQvmYcohC4a+10hz+Sdqh0s8aR0z2ccQGmT4gRKyATnSOJYrZvIlZwXG
         Wl2AYv14epu2A==
Date:   Thu, 16 Feb 2023 09:46:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+3fa/3HC1vsLRXa@unreal>
References: <Y+ksmNWJdWNkGAU9@unreal>
 <20230215205726.GA3213227@bhelgaas>
 <Y+3al/a3HPrvfNgh@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3al/a3HPrvfNgh@unreal>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 09:26:15AM +0200, Leon Romanovsky wrote:
> On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
> > [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
> > 
> > On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
> > > On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> > > > As per PCIe specification(section 10.5), If a VF implements an
> > > > ATS capability, its associated PF must implement an ATS capability.
> > > > The ATS Capabilities in VFs and their associated PFs are permitted to
> > > > be enabled independently.
> > > > Also, it states that the Smallest Translation Unit (STU) for VFs must be
> > > > hardwired to Zero and the associated PF's value applies to VFs STU.
> > > > 
> > > > The current code allows to enable ATS on VFs only if it is already
> > > > enabled on associated PF, which is not necessary as per the specification.
> > > > 
> > > > It is only required to have valid STU programmed on PF to enable
> > > > ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> > > > when PFs ATS is not enabled.
> > >
> > > Can you please add here quotes from the spec and its version? I don't see
> > > anything like this in my version of PCIe specification.
> > 
> > See PCIe r6.0, sec 10.5.1.
> 
> Awesome, I have old versions.

OK, where should I read about this sentence?

"It is only required to have valid STU programmed on PF to enable
 ATS on VFs. Adding code to write the first VFs STU to a PF's STU
 when PFs ATS is not enabled."

From spec:
"Smallest Translation Unit (STU) - This value indicates to the Function the minimum number of
4096-byte blocks that is indicated in a Translation Completions or Invalidate Requests. This is a power of
2 multiplier and the number of blocks is 2STU. A value of 0 0000b indicates one block and a value of
1 1111b indicates 231 blocks (or 8 TB total)

For VFs, this field must be hardwired to Zero. The associated PF's value applies.
Default value is 0 0000b"

And enable bit doesn't have any sentence about STU.

Thanks
