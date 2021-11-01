Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297AA4418ED
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhKAJxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 05:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233289AbhKAJvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 05:51:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DB5F60F70;
        Mon,  1 Nov 2021 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635759384;
        bh=T88RiQbxwaGniFcc+rnbVb40RHNPCR76NdrF/7VPCME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrWCB0phomgItdYzJVkmmdiLPWPL348dT5ZdLdhW7AKlMoQpbsJ5bWeDgyFdfwH9F
         GOO3//OVGmgPo9Dnj5Hh2IZ4xqYQdPILUNMqEOVWk/wS4arRk1bHgyUKADImZrIOYS
         oTUNhuUivfnG4Rq6q/lIH9qbvwL/iGyXLgLH715/EmkP2KqBP8pr6WPYBzN10c41nR
         0Uu1lH1D1RpZ6cII5Tg5Y4/tdfMlPex9cBhs+dpn+Jv4TQ4pEBTFoHAygK69FTLAAw
         dZ9V04UsEuRPvoX8BjLPLUeMskhABJylRYRzktUCkHWtFFZQ1d2eKaeg8cFAiShu2K
         o/sg0wjYkxBgw==
Date:   Mon, 1 Nov 2021 09:36:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     helgaas@kernel.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, james.morse@arm.com, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
Message-ID: <20211101093618.GA27400@willie-the-truck>
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
 <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
 <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Nov 01, 2021 at 10:18:35AM +0800, Xuesong Chen wrote:
> How about the status of this series, it's really bad, bad and still bad... to wait long
> time for the final judgement, especially you take extremely serious to rework it round
> by round, finaly you receive nothing. Everyone's work should be repected!

I've trimmed the rest of your response as it wasn't especially constructive.
Please can you try to keep things civil, even when you're frustrated? It's
not very pleasant being on the end of a rant.

One likely explanation for you not getting a reply on your patches is that
I've discovered many of your emails have ended up in my spam, for some
reason. I'm using gmail for my inbox so, if Bjorn is doing that as well,
then there's a good chance he hasn't seen them either.

The other thing to keep in mind is that the 5.16 merge window opened today
and you posted the latest version of your patches on Wednesday. That doesn't
really leave enough time for the patches to be reviewed (noting that patch 3
is new in this version and the kernel build robot was still complaining on
Friday), queued and put into linux-next, so I would suspect that this series
is looking more like 5.17 material and therefore not a priority for
maintainers at the moment.

Your best is probably to post a v5, with the kbuild warnings addressed,
when -rc1 is released in a couple of weeks. I'm not sure how to fix the
spam issue though :(

Will
