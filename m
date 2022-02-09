Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79024AFE6F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiBIU0n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 15:26:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBIU0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 15:26:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FCFC1DC17A;
        Wed,  9 Feb 2022 12:26:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66058B82103;
        Wed,  9 Feb 2022 20:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42677C340E7;
        Wed,  9 Feb 2022 20:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644438402;
        bh=wlcycksblxHxIZsXzEsS0Ma9TIvWPN0qfiPXFmk0ycg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ola3+B6W2O6iaW/23E1kjacEf/ZdIgMbwWLbapwd25q7j/KKHMxHBRJT50Un/eEru
         FYJFj+IX5tgpBuZtI1YQMV298kOlUoIsemIeB5GY2ywrdXc4CbFmwDnCwGPcXPgZ1z
         yelL3hdUXkoAVkttiKa0Si9QTdztL7GoikjCpiEbA83ScpJmQwhfT9vQiESEWMj3DH
         OJKBwguSaXCiQ5jgd6cS6NmVmrvFII5c3OLGgoN1Wi11/xdQT/Ce1Osx2H6XlbkIyD
         8KNMosrj7lkYrSA/dvxJ9iNXJ9PGmSFWSAJuMahUYvdjMaZPSTdXHQHTAdxbOrhUx2
         v3FvjYwSRYYSQ==
Date:   Wed, 9 Feb 2022 12:26:39 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     rafael.j.wysocki@intel.com, keith.busch@intel.com, hch@lst.de,
        bhelgaas@google.com, mmaddireddy@nvidia.com, kthota@nvidia.com,
        sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
Message-ID: <20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
> Hi Rafael & Christoph,
> My query is regarding the comment and the code that follows after it at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
> What I understood from it is that, there is an underlying assumption
> that the power to the devices is not removed during the suspend call.
> In the case of device-tree based platforms like Tegra194, power is
> indeed removed to the devices during suspend-resume process. Hence, the
> NVMe devices need to be taken through the shutdown path irrespective of
> whether the ASPM states are enabled or not.
> I would like to hear from you the best method to follow to achieve this.

Christoph prefers to append quirks for platforms that need full device
shutdown on s2idle instead of changing the driver default.

We use dmi matching for our current platform quirk list. I do not know
what the equivalent is for device-tree based platforms. Do you know?
