Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289999F5D9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfH0WNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfH0WNZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:13:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D036120679;
        Tue, 27 Aug 2019 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566944004;
        bh=LZPQogWInSb9gqAI/aacGbig10OJaeQDStsJ1k9m4k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qY4Vfyb0VjYNejMGwIgHw25hJrjYFb+65rOtdKARqBjG31pqtDOU7WfU9tXxDjYjo
         jPnwwr5yMWnzW5y6m1+X2akbYC87QcyyGv+tGBnMRnxtfq+6uD1FgObO18DFy7kPw/
         zRECNK84asDwgGcK+jly/EWPp28g+asVgZxD8N1s=
Date:   Tue, 27 Aug 2019 17:13:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Peter Wu <peter@lekensteyn.nl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
Message-ID: <20190827221321.GA9987@google.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <s5hr2567hrd.wl-tiwai@suse.de>
 <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Peter, Mika, Dave]

https://lore.kernel.org/r/20190827134756.10807-1-kai.heng.feng@canonical.com

On Wed, Aug 28, 2019 at 12:58:28AM +0800, Kai-Heng Feng wrote:
> at 23:25, Takashi Iwai <tiwai@suse.de> wrote:
> > On Tue, 27 Aug 2019 15:47:55 +0200,
> > Kai-Heng Feng wrote:
> > > A driver may want to know the existence of _PR3, to choose different
> > > runtime suspend behavior. A user will be add in next patch.
> > > 
> > > This is mostly the same as nouveau_pr3_present().
> > 
> > Then it'd be nice to clean up the nouveau part, too?
> 
> nouveau_pr3_present() may call pci_d3cold_disable(), and my intention is to
> only check the presence of _PR3 (i.e. a dGPU) without touching anything.

It looks like Peter added that code with 279cf3f23870
("drm/nouveau/acpi: use DSM if bridge does not support D3cold").

I don't understand the larger picture, but it is somewhat surprising
that nouveau_pr3_present() *looks* like a simple predicate with no
side-effects, but in fact it disables the use of D3cold in some cases.

If the disable were moved to the caller, Kai-Heng's new interface
could be used both places.
