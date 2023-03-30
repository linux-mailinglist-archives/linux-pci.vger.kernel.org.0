Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A298C6D0A57
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 17:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjC3PuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjC3PuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 11:50:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF5CA3D;
        Thu, 30 Mar 2023 08:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72E7B82775;
        Thu, 30 Mar 2023 15:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1D8C433EF;
        Thu, 30 Mar 2023 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680191368;
        bh=Z+ICADVJmBYfbkDQNQ16opLmMYhXD1MFGVFUNtdf/Ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bt9YDLGhvOn7KtJymvLKY+lXNZrY0gmLLUXcW9JkpMFDzmKQgv0QKnWR2ryyPogdf
         pW4stpNRi942rVmHZZvr611dYIsQwwFNgxVSnUErMSb93RsDMRtWHlB3Cn+d085MOA
         X+tl9u5aphpQkhCrNUcf3o5S+MiWUGv4i91lFrPdl17emPVCFX7dp8PsFJVfPOaO4B
         gEtAryLRhAJgBDTmm72RnNCQNOHUMafE72upMgPDfjlVQnGOsSksB6PgjrWkoOzsPQ
         whBd4N4qjQsb//hQAR/sqN64/Va+ii+wBK00VexbZSH+DR8PWvHFfkEIPy+5E3eWWC
         QRdeuPe8GKb5A==
Date:   Thu, 30 Mar 2023 10:49:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [RFC PATCH] PCI: avoid SBR for NVIDIA T4
Message-ID: <20230330154926.GA3150990@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330021016.GA30164@L-PF27918B-1352.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 10:10:16AM +0800, Wu Zongyong wrote:
> On Wed, Mar 29, 2023 at 12:05:15PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 29, 2023 at 07:58:45PM +0800, Wu Zongyong wrote:
> > > Secondary bus reset will fail if NVIDIA T4 card is direct attached to a
> > > root port.
> > 
> > Is this only a problem when direct attached to a Root Port?  Why would
> > that be?  If it's *not* related to being directly under a Root Port,
> > don't mention that at all.
>
> Yes, this problem occurs only when the T4 card is direct attached to a
> Root Port.
> I have test it with a T4 card attached to a PCIe Switch or a PCI Bridge,
> and it works well.

From an electrical and protocol point of view, the device should not
be able to tell the difference, so Lukas' suggestion that it may be
related to reset delays seems very pertinent.

Bjorn
