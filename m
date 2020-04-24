Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7351F1B7942
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgDXPRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgDXPRX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:17:23 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61AAB206D7;
        Fri, 24 Apr 2020 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587741442;
        bh=+iyR/hJ6vAI70/ZlKPsTby9ZYROa3eEXK8EnAWEX2q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SragEda2u5RhW9ADwlsFtHCTG98ujaVLXuE/inGXq20LTtMuov/gY0f5tO+aly2mx
         zeAZ4OUljfwh2I5hH1+BBV3eBHcqOAt/Qybtg+56mFTtjpJB4ePk/pT0O7e4iJ4JPp
         kbX4X+dBf4KkOZdSeyPq1VwjYYgkmq5z1X+M/oI0=
Date:   Fri, 24 Apr 2020 10:17:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saheed Bolarinwa <refactormyself@gmail.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, bjorn@helgaas.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
Message-ID: <20200424151720.GA134692@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f348edfc-cecc-f732-833d-f99ca64d565c@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 19, 2020 at 07:56:22AM +0200, Saheed Bolarinwa wrote:
> Hello Bjorn and Yicong
> 
> On 4/11/20 4:10 AM, Yicong Yang wrote:
> > Hi Bjorn and Saheed,
> > 
> > Callers use return value(most callers even don't check) of
> > pcie_capability_{read,write}_*() I found lists below. some
> 
> In this patch I have focused only on pcie_capability_read_{word & dword}()
> 
> Do you think the consistency issue is of concern also with
> pcie_capability_write_*()?

Yes.  pcie_capability_write_*() can return either -EINVAL or
PCIBIOS_*, so it has the same consistency problem.  I'd like to fix
all of pcie_capability_read_*() and pcie_capability_write_*() in a
single patch because it's logically the same change and they can all
be reviewed together.

Thanks for the audit of the callers.  I'd include a brief summary in
the commit log, but not the entire thing because it's a little too
detailed for the log.  But it could be useful in a cover letter (which
will be acccessible from the commit via the "Link:
https://lore.kernel.org/r/..." URL).

Bjorn
