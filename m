Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA24C1848
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 17:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiBWQOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 11:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiBWQOf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 11:14:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E1B717B;
        Wed, 23 Feb 2022 08:14:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F25E3CE1BC1;
        Wed, 23 Feb 2022 16:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E93C340E7;
        Wed, 23 Feb 2022 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645632844;
        bh=RDlGUXhVMQjdPD7pgZi9YzuzAu6QlwjIsVRe2uzVobQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuRdXmLcgPNMJOHk2OcUAFhYE945oDsoDg7DM3GMhKgfUK1j41IsKB+fndP08kJo4
         gzaN4PQN0gv2/GE7I2q8KHSeuSpesGHqmJkTUgohUjN7BGWERSGBUX3R9tofkAWSTL
         DnwC9fmCiPywK+lZ2RguXtZLuSlD3aj3j+s3f1nwHfaEx1A23ePpyBZt53vYSHepKX
         uMaIpUZnGNGidvIl0L6eypjeWQDFuCw1SmRsVlHVxmhaIvA5M/tV41F0wObT/hDLtq
         TCQOQDZ5OvLIM17zzD3bXG/xYIHbYjclOpl7sLsEY9bg26pO4Flij+civl7k0yjHsy
         EJKrixSBvFVEg==
Date:   Thu, 24 Feb 2022 00:06:09 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix integrated MSI Receiver mask reg setting
 during resume
Message-ID: <YhZbcU3yNuuBDXm/@xhacker>
References: <20211226074019.2556-1-jszhang@kernel.org>
 <Ye1D4lYAIpDe7qAN@xhacker>
 <20220223114622.GA27645@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220223114622.GA27645@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 23, 2022 at 11:46:22AM +0000, Lorenzo Pieralisi wrote:
> On Sun, Jan 23, 2022 at 08:02:42PM +0800, Jisheng Zhang wrote:
> > On Sun, Dec 26, 2021 at 03:40:19PM +0800, Jisheng Zhang wrote:
> > > If the host which makes use of the IP's integrated MSI Receiver losts
> > > power during suspend, we call dw_pcie_setup_rc() to reinit the RC. But
> > > dw_pcie_setup_rc() always set the pp->irq_mask[ctrl] as ~0, so the mask
> > > register is always set as 0xffffffff incorrectly, thus the MSI can't
> > > work after resume.
> > > 
> > > Fix this issue by moving pp->irq_mask[ctrl] initialization to
> > > dw_pcie_host_init(), so we can correctly set the mask reg during both
> > > boot and resume.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > Hi all,
> > 
> > This patch can still be applied to the latest linus tree. Do you want
> > me to rebase and send out a new version?
> > 
> > Without this patch, dwc host MSI interrupt(if use the IP's integrated
> > MSI receiver) can't work after resume. Could it be picked up as a fix
> > for v5.17?
> 
> The tricky bit with this patch is that it is not clear what piece of
> logic is lost on power down and what not. IIUC MSI interrupt controller
> logic is kept so it does not need to be saved/restored (but in

You may mean the external MSI interrupt controller case, but here the
focus is the integrated MSI Receiver in the IP. Normally, after
suspending to ram, the dwc IP would lost power, so the integrated MSI
Receiver also lost power.

> dw_pcie_setup_rc() we overwrite PCIE_MSI_INTR0_ENABLE even if it
> is not needed on resume - actually, it can even be destructive).
> 

For the integrated MSI Receiver case, since the entire IP power is lost,
so the PCIE_MSI_INTR0_MASK|ENABLE setting is lost, we need to resume the
mask to the one before suspending. For PCIE_MSI_INTR0_ENABLE register(s),
since it's always 0xffffffff, so current code is fine.

> Maybe we need to write suspend/resume hooks for the dwc core instead
> of moving code around to fix these bugs ?
> 

Even with suspend/resume hooks, we still need to fix the
PCIE_MSI_INTR0_MASK wrong setting with always ~0. After the fix, msi works
so we don't need suspend/resume hooks any more.

Thanks
