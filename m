Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9866666FB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 00:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjAKXKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 18:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjAKXKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 18:10:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B232255;
        Wed, 11 Jan 2023 15:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55F861ED6;
        Wed, 11 Jan 2023 23:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04C6C433EF;
        Wed, 11 Jan 2023 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673478635;
        bh=++uluPFMowPrY8s1xfgmEUXDgen39mn6C1pbnUZ2MU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kBqcCXiYgbOo0fz6xo/YOGVM2XLI/TGaRt6I6q6PjPGZghKE/om05zyqfQApLqDYT
         jmtXbxl6mYgeTjvYJzO/uS6FXr7Jtgv4Vt9rxojdIH0almjY/NGOnq8M98oF8kwfKv
         mCwqtmnaMLXuy53tHGIvRSpO6jJpLEDBsKoIBdgEktC94gHq4mrfugdJv1Tl6xx0Op
         Kf2NLycwahihsEOlR2wzo34lyCEDQAN00QCHEvDa7CZKU+ikaJv0Sg+J3cVXJ9bOw8
         YdLlhfDNoHLfjF0ARFO6qKNG2/37bTKDikGli5xn/eqK7HJNGt8MYp2vc2UsdDCZZn
         X5NH/nGhjaa4A==
Date:   Wed, 11 Jan 2023 17:10:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, treding@nvidia.com,
        jonathanh@nvidia.com, mmaddireddy@nvidia.com, kthota@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vsethi@nvidia.com, linuxppc-dev@lists.ozlabs.org,
        sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI/AER: Configure ECRC only AER is native
Message-ID: <20230111231033.GA1714672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9126d49-6e98-956c-f4a3-699cc86d8b11@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 01:42:21PM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 1/11/23 12:31 PM, Vidya Sagar wrote:
> > As the ECRC configuration bits are part of AER registers, configure
> > ECRC only if AER is natively owned by the kernel.
> 
> ecrc command line option takes "bios/on/off" as possible options. It
> does not clarify whether "on/off" choices can only be used if AER is
> owned by OS or it can override the ownership of ECRC configuration 
> similar to pcie_ports=native option. Maybe that needs to be clarified.

Good point, what do you think of an update like this:

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..f7b40a439194 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4296,7 +4296,9 @@
 				specified, e.g., 12@pci:8086:9c22:103c:198f
 				for 4096-byte alignment.
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
-				end-to-end CRC checking).
+				end-to-end CRC checking).  Only effective
+				if OS has native AER control (either granted by
+				ACPI _OSC or forced via "pcie_ports=native").
 				bios: Use BIOS/firmware settings. This is the
 				the default.
 				off: Turn ECRC off

I don't know whether the "ecrc=" parameter is really needed.  If we
were adding it today, I would ask "why not enable ECRC wherever it is
supported?"  If there are devices where it's broken, we could always
add quirks to disable it on a case-by-case basis.

But I think the patch below is the right thing to do for now.  Vidya,
did you trip over an issue because of this, e.g., a conflict between
firmware use of AER and Linux use of it?  If so, maybe we could
mention a symptom on the commit log.  But my guess is you probably
found this by inspection.

Bjorn

> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >  drivers/pci/pcie/aer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index e2d8a74f83c3..730b47bdcdef 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -184,6 +184,9 @@ static int disable_ecrc_checking(struct pci_dev *dev)
> >   */
> >  void pcie_set_ecrc_checking(struct pci_dev *dev)
> >  {
> > +	if (!pcie_aer_is_native(dev))
> > +		return;
> > +
> >  	switch (ecrc_policy) {
> >  	case ECRC_POLICY_DEFAULT:
> >  		return;
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
