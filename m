Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0B2B8642
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKRVFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 16:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKRVFT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 16:05:19 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE9322201;
        Wed, 18 Nov 2020 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733518;
        bh=5C5bEY+DL1ajImtxJCjy6ztNOGvMs4VuL3KEnsvaNuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S7vc3UyU7jkYzPtyuPMZfQxF2kmU3r/lzlPDcchA+1j/P0sSl/eNsttrf+ByA3JP6
         uwnMU2iuy7rqXDGfdm25JP5uP204UG9k+imVWjbMi+haLlDOaWHmxPlzSk0ZTk+hPK
         ZtkISZMA42yM2mS3DkKumxgXbSZxfAgin69KZFFc=
Date:   Wed, 18 Nov 2020 15:05:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201118210516.GA76543@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 09:04:07AM -0300, Guilherme Piccoli wrote:

> Also, taking here the opportunity to clarify my understanding about
> the limitations of that approach: Bjorn, in our reproducer machine we
> had 3 parents in the PCI tree (as per lspci -t), 0000:00, 0000:ff and
> 0000:80 - are those all under "segment 0" as per your verbiage?

Yes.  The "0000" is the PCI segment (or "domain" in the Linux PCI core).
It's common on x86 to have multiple host bridges in segment 0000.
