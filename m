Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD49E228B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfJWSgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 14:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbfJWSgs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 14:36:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D4820663;
        Wed, 23 Oct 2019 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571855808;
        bh=bLvACf70EtGKQcH7NN0GRa0o2aKKreLYHYMeYrKMqqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JLXWZJ+wJRNqRMcLhgB/ruPlzo1mRE2x91K+2HnY4uW6EGGYE+NNTfBtOzvjoXovY
         qjGDFTV0Bx84IceYhKpmf+5gAHTx5KayDYztn+pZBqTqp/0vAkN9BR7Ckzcm/gUryh
         rQ/75mdGsKj/xjkWEnjtXIaXLXExoGCpvpkFUgpg=
Date:   Wed, 23 Oct 2019 13:36:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v2 0/1] Add support for setting MMIO PREF hotplug bridge
 size
Message-ID: <20191023183646.GA4895@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB018771B6A7F60532F99701A5806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:12:08PM +0000, Nicholas Johnson wrote:
> ...
> It turns out Outlook is causing my encoding issues with git send-email.
> 
> If I get a new email for kernel development, what should it be? Gmail
> works, but looks tackier.

I wish Documentation/process/email-clients.rst said something about
Outlook, but it doesn't and I don't know enough to add anything.

It does say gmail doesn't work for sending patches.  That's certainly
true for the web GUI, but I think it might be possible to use msmtp to
send via the gmail SMTP server, e.g., https://wiki.debian.org/msmtp

Bjorn
