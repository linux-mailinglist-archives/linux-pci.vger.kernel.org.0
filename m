Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACDA496215
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381538AbiAUP3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:29:50 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:60158 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1381578AbiAUP3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:29:45 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id 3905840089
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 16:29:44 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 30F3D2802E6; Fri, 21 Jan 2022 16:29:44 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:29:44 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <mj+md-20220121.152905.30983.nikam@ucw.cz>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
 <20220121151246.3tlf5jdyh6jxeauv@pali>
 <mj+md-20220121.151403.26105.nikam@ucw.cz>
 <20220121152657.xsq5f5u6odsumbwp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121152657.xsq5f5u6odsumbwp@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Linux "class+subclass+prog_if" can be different than what is in
> config registers and the purpose of this patch series with new fields is
> to allow user to see difference in lspci.
> 
> On Windows access to real config space is not available for non-system
> users.

Sure, I meant to read it from the config registers only if the back-end
is unable to supply it.

> > > And what to do with subsystem ids? They are not part of
> > > class/subclass/prog_if/revision fields and different devices have them
> > > stored on different locations... And for PCI-to-PCI bridges they are
> > > only optional and does not have to be present at all.
> > 
> > I would prefer a separate PCI_FILL_xxx flag for them.
> 
> So like PCI_FILL_SUBSYS flag in this patch series?

Yes, that part was OK.

			Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
Not all rumors are as misleading as this one.
