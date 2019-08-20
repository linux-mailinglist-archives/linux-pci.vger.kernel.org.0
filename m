Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B395BE6
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfHTKCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 06:02:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTKCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 06:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=190nv5pbKYvf/J/6UXApkbgUkAaCOeHNZQDIpZXE85o=; b=UuMWCOG1dtWq2LfoNQtHwDqWD
        4Ik/COkoBGNNo1cDN/LhL4YCwcgUtEqgLqOlbHXFVeaFTZSEfJXiGdUIUSNkbQ0heKOp6hnJWb4Pb
        iXncnp+950eon0Clg4i00nFI7UzXFz8gkpo6L4XFadhb4/EJmBGfPjLStqTnugnGnhoa2oP9enG91
        SRum1g3F3y55zMCew0gjaBHbsm+ehSahNJLrKjyOJKev0Vt3ugNY4TeNRVJ2k0FYH+kbnRfaux0OK
        gwT9GUbCIudfdfVFFQhMBI1rBPC8is3uHHw0TIjmlas2Nrd2H09S52PxmWenFmzBw/9giTwUNuJKy
        zvmU8vKdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i00yY-00017a-O3; Tue, 20 Aug 2019 10:02:50 +0000
Date:   Tue, 20 Aug 2019 03:02:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Prasad Koya <prasad@arista.com>
Cc:     fred@fredlawl.com, linux-pci@vger.kernel.org
Subject: Re: reverting c37e627f9565368ed7bd1f3cf59a2d223ddba85a
Message-ID: <20190820100250.GA30608@infradead.org>
References: <CAKh1g55iiUjJiTsUQPQkvAkiHf4fwMG1cpwt0kDjGdTgMSg_gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKh1g55iiUjJiTsUQPQkvAkiHf4fwMG1cpwt0kDjGdTgMSg_gA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 10:15:08PM -0700, Prasad Koya wrote:
> hi Frederick
> 
> At Arista Networks, we have a service driver for AER as a loadable
> module. The reasons for having Arista's own module and not enabling
> in-built aer driver (CONFIG_PCIEAER) is for the reasons below:

And as long as that isn't upstream no one is going to care for it,
and most certainly not reverting useful kernel improvements for it.
