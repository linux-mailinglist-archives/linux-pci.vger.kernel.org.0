Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1835A5F5972
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJER5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJER5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 13:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108C78BCD;
        Wed,  5 Oct 2022 10:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7707C6178F;
        Wed,  5 Oct 2022 17:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8553BC433D6;
        Wed,  5 Oct 2022 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664992665;
        bh=hYC0opATC0Nmx1bPQMzQLWCcT3yhZpfxCXEFJN/s3qI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NONKl8qqujs2rlwAFWW3Swq1nuYiRytwvRiPDf0qjoTgSUOcWmzqDp+MLsJg5zKMR
         ao3se269USLlTI6/XVXDff8SPS8zOnF2JmHYUzuuKukZ241biXtUnLiTNhOgwWgUmS
         LP3V1P/ECZSU1XV++t31gXFq2jXt+qJXIbuK4TZDjVs/pB+xwBIDdaEacEsa9RHnCx
         25Au5tWo4oJs+/ofjj9hcOZjaxU5cQ9wJnNlFQ38nbxVH5+YINEMclONuZFxlA+HWt
         FbEen/WYSMqoqk9lnobC6x4VPxsCuLiBGPYMR445ZX0AbZQzEpBkRdy2KyFTAHiu19
         rQT10nG1cE3ig==
Date:   Wed, 5 Oct 2022 12:57:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI/ASPM: Fix L1SS issues
Message-ID: <20221005175744.GA2382840@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca836507-50ca-13bc-ef88-7f69b1333c99@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 04, 2022 at 08:28:07PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 10/4/22 7:58 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This is really late, but I think we have two significant issues with L1SS:
> > 
> >   1) pcie_aspm_cap_init() reads from the L1SS capability even when it
> >   doesn't exist, so it reads PCI_COMMAND and PCI_STATUS instead and treats
> >   those as an L1SS Capability value.
> > 
> >   2) encode_l12_threshold() encodes LTR_L1.2_THRESHOLD as smaller than
> >   requested, so ports may enter L1.2 when they should not.
> > 
> > These patches are intended to fix both issues.
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks a lot for taking a look at these!  I put them on pci/aspm for
v6.1.

> > Bjorn Helgaas (3):
> >   PCI/ASPM: Factor out L1 PM Substates configuration
> >   PCI/ASPM: Ignore L1 PM Substates if device lacks capability
> >   PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation
> > 
> >  drivers/pci/pcie/aspm.c | 155 +++++++++++++++++++++++-----------------
> >  1 file changed, 90 insertions(+), 65 deletions(-)
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
