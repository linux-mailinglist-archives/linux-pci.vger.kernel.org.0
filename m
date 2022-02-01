Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D274A6163
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 17:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiBAQa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 11:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiBAQa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 11:30:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80CC061714;
        Tue,  1 Feb 2022 08:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F4546172E;
        Tue,  1 Feb 2022 16:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7693C340EB;
        Tue,  1 Feb 2022 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643733057;
        bh=/yT1JZvegKW1MyKD91MJ9p4u5BE7z3ofyXc/9/K/Ktg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rD1j4jKioal/7gTCvwwEHY10EsDwjLXX97TBL84SR/bOZtmevYIKvZOMPYn7Z7t6w
         4qmYz38C7xdddgYUipGFZag4D2FkQS1wYGXqKWrCIdYLEQUY2v+0Zpx66sKgZNTlnV
         JVvgDcTNwDFgXzQcVWvvFVccR/FMgBXfFuAznNbp3Ai89PZbUFABqHMMmQ0Zf3YNC9
         fg4nU4gsg81IvGn+geFssfBDXaD+f4n2Zfdy01zxxIKGnamoBTQvdFuTUpGAsEWfhM
         inT9C9nPYNkne6QZiup1M9Wlu5l+ZIzNVwKXRwEQFh0vfZX1uqb4uaTRu5kSqCP3X6
         kZYB0lIaksAfg==
Date:   Tue, 1 Feb 2022 08:30:54 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     rafael.j.wysocki@intel.com, keith.busch@intel.com, hch@lst.de,
        bhelgaas@google.com, mmaddireddy@nvidia.com, kthota@nvidia.com,
        sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
Message-ID: <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
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

Since platform makers can't converge on how to let a driver know what
it's supposed to do, I suggest we default to the simple shutdown suspend
all the time. We can add a module parameter to let a user request nvme
power management if they really want it. No matter what we do here,
someone is going to complain, but at least simple shutdown is safe...
