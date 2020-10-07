Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC90286522
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 18:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgJGQqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 12:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgJGQqK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 12:46:10 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349AC206FC;
        Wed,  7 Oct 2020 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602089169;
        bh=qYpMzqtsjrMMyezfget5SScdy07//sseqBRdxccpfOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nujV02s3Ysb0QSClSvUD2TcWeztSBkfBGzPQeZ6TqFzFc7xXFVMSyy/tWquSTXT23
         YR96KWfVKcaAn1TwfPb4N+ogjlSakBAGGFesUFpon79l4H0RtRAtiBBYLzRyPnMiY8
         7Ge1jg8/9+BBkOqYQmVIbx1knEK0f2B3DKeBti7I=
Date:   Wed, 7 Oct 2020 09:46:07 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: spammy dmesg about fluctuating pcie bandwidth on 5.9
Message-ID: <20201007164607.GB961537@dhcp-10-100-145-180.wdl.wdc.com>
References: <CAHmME9r_cNx04yuUN+TPPY=xDHuDxRrLb8KqR7C69YtXMajAJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r_cNx04yuUN+TPPY=xDHuDxRrLb8KqR7C69YtXMajAJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 06:09:06PM +0200, Jason A. Donenfeld wrote:
> Since 5.9 I've been seeing lots of the below in my logs. I'm wondering
> if this is a case of "ASPM finally working properly," or if I'm
> actually running into aberrant behavior that I should look into
> further. I run with `pcie_aspm=force pcie_aspm.policy=powersave` on my
> command line. But I wasn't seeing these messages in 5.8.
 
> [79960.801929] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)

A x63 gen5 capable link?! No such encoding exists, so something is
definitely wrong. Looks like all 1's was returned when reading the link
capabilities register, as that equals the mask's 0x3f value. The code
ought to skip reporting a device returning all 1's.
