Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B825A14867
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 12:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEFKh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 May 2019 06:37:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfEFKh2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 06:37:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D08FBAD33;
        Mon,  6 May 2019 10:37:26 +0000 (UTC)
Date:   Mon, 6 May 2019 12:37:24 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Message-Id: <20190506123724.5c78bcff04f722ae92e7f6a8@suse.de>
In-Reply-To: <20190418205726.GB126710@google.com>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
        <20190418205726.GB126710@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 Apr 2019 15:57:26 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Hi Thomas,
> 
> On Tue, Mar 19, 2019 at 04:47:49PM +0100, Thomas Bogendoerfer wrote:
> > SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
> > architecture and share some hardware (ioc3/bridge). To share
> > the software parts this patchset reworks SGI IP27 interrupt
> > and pci bridge code. By using features Linux gained during the
> > many years since SGI IP27 code was integrated this even results
> > in code reduction and IMHO cleaner code.
> > 
> > Tests have been done on a two module O200 (4 CPUs) and an
> > Origin 2000 (8 CPUs).
> 
> Thanks for doing all this work!  It seems like it basically converts
> some of the SGI PCI code to the structure typical of current host
> controller drivers and moves it to drivers/pci/controller, which all
> seems great to me.
> 
> The patches were kind of in limbo as far as Patchwork.  Lorenzo
> handles the native host controller drivers, so I just delegated them
> to him, so now they should be on his radar.

Is there a chance to still get this into v5.2 ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
