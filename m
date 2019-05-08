Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E9117176
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEHGYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 May 2019 02:24:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEHGYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 May 2019 02:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yd4Wnh9vxeMCyESuNOhTBbsgDnGnCPY1zhBjGYoqdQY=; b=jAUUEfYmfCpe5e8h/svS9coVC8
        TDOWiRHpciwkr9F7GGsRyZdt/hooATI/1MQ5mgItc8rdLTEy7HOw8qY3g33CXcY3c97JFBR8Y9WzU
        TKfiq0Zqx+HF+G23AdT/r60i0S582szfIHjfJG1xFrBRXOK0btXx+xQ/NKLaaVqO7xyxGdNetHIOW
        rd08no5poo8z1cOdFD1AF97c/wtKz1NEntssUpQ3VHknZa8txXqYhQG0OdrAmsmo/aBXfuTi8GC/E
        iIak60hD783FpskXBixeXeMDaV54EIe6g45j5VsHRm0LlOnOXjweAn/b8CPGPE1SW4FDwnhjZtmHK
        3IbMyfOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOG04-0004h5-Nd; Wed, 08 May 2019 06:24:20 +0000
Date:   Tue, 7 May 2019 23:24:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Message-ID: <20190508062420.GD19227@infradead.org>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
 <20190418205726.GB126710@google.com>
 <20190507153117.GA21665@e121166-lin.cambridge.arm.com>
 <20190507174820.381fd56f678609416fd8b617@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507174820.381fd56f678609416fd8b617@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 05:48:20PM +0200, Thomas Bogendoerfer wrote:
> > I had a look and the code is really, really MIPS specific, actually
> > I would be interested in understanding how many platforms it supports,
> > it is not even FW configurable.
> 
> it's MIPS only and used in basically 3 different SGI platforms.

Actually this isn't quite true, this whole infraѕtructure was also
shared by the SGI IA64 systems.

The early SN1 prototypes were basically just IP35 systems with IA64
CPUs glued in, and even the later SN2 that were released as Altix
shared the same xtalk + bridge infrastructure, just with some hardware
updates.  It just turned out SGI at some point decided to hide all that
in firmware.  Linux 2.4 was still accessing this natively, but the code
was a mess.  I tried to consolidate it with the mips version at that
point, but SGI decided that hiding it under firmware calls was easier
as they could just move the messy code there.

So, not it isn't really MIPS only in theory, although in practice it
very much is..
