Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C13153675
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 18:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBERaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 12:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgBERaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 12:30:05 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DCF20659;
        Wed,  5 Feb 2020 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580923805;
        bh=MlGZHf6gw5Qy+xvI4b+6regURjW18v1ejXqsGpD3Re0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fjw+5JXIeh309xZoe0M8+hixtDDEYwtc161na1N1gw8xQzHLjW9KOA8Ng9JVfhFKU
         up6j0kG0T/HulXIFjsdUgRjcB9Nq/hhXku7KTPkMyc8zJqGti8pP/rg00Zc8DstbKZ
         VmZWwqlBQoAg5UHakubNuI9ibAkOv8Yw2+tS8blY=
Date:   Wed, 5 Feb 2020 11:30:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com,
        huangdaode@huawei.com
Subject: Re: [PATCH 0/2] PCI: Fix potential deadlock problems
Message-ID: <20200205173002.GA221036@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580894277-20671-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 05:17:57PM +0800, Yicong Yang wrote:
> Currently we use several locks to avoid racing conditions in pci
> framework. When involving more than one lock, the inconsistent
> lock order will lead to deadlock problems. This patchset aims to
> solve the problem by keeping the same lock order in different
> processes.
> 
> Patch_1: fix the potential deadlock caused by pci_dev_lock() and
> VF enable routine.
> Patch_2: fix the deadlock caused by AER and sriov enable routine
> as reported.

If it's possible for you to send these with the patches as responses
to the cover letter (as you did for the Jan 15 link speed patches),
the tools will work better, e.g., patchwork will notice that they all
belong together.

No need to resend this series for that reason, just FYI for the
future.

> Yicong Yang (2):
>   PCI: Change lock order in pci_dev_lock()
>   PCI/AER: Fix deadlock triggered by AER and sriov enable routine
> 
>  drivers/pci/bus.c      |  8 ++++++++
>  drivers/pci/pci.c      | 15 ++++++++-------
>  drivers/pci/pci.h      |  4 ++++
>  drivers/pci/pcie/err.c | 18 +++++-------------
>  4 files changed, 25 insertions(+), 20 deletions(-)
> 
> --
> 2.8.1
> 
