Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941F74961DC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 16:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351232AbiAUPPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 10:15:34 -0500
Received: from akamas.n.mff.cuni.cz ([195.113.16.19]:59794 "EHLO
        akamas.troja.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241694AbiAUPPe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 10:15:34 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.kam.mff.cuni.cz [195.113.17.177])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by akamas.troja.mff.cuni.cz (Postfix) with ESMTPS id 04FA540088
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 16:15:33 +0100 (CET)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id EB61E2802E6; Fri, 21 Jan 2022 16:15:32 +0100 (CET)
Date:   Fri, 21 Jan 2022 16:15:32 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 0/5] Support for PROGIF, REVID and SUBSYS
Message-ID: <mj+md-20220121.151403.26105.nikam@ucw.cz>
References: <20220121135718.27172-1-pali@kernel.org>
 <mj+md-20220121.143358.16196.nikam@ucw.cz>
 <20220121151246.3tlf5jdyh6jxeauv@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121151246.3tlf5jdyh6jxeauv@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> How to handle situation when "class+subclass+prog_if" is provided and
> revision is not provided? What should libpci backends set in this case?
> Because on both Linux and Windows systems are these information provided
> separately. On Linux you can chmod 000 revision sysfs file and let class
> sysfs file still readable. Windows can probably decide itself that it
> would not report revision at all...

Read it from the config registers in that case.

> And what to do with subsystem ids? They are not part of
> class/subclass/prog_if/revision fields and different devices have them
> stored on different locations... And for PCI-to-PCI bridges they are
> only optional and does not have to be present at all.

I would prefer a separate PCI_FILL_xxx flag for them.

			Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
"I don't give a damn for a man that can only spell a word one way." -- M. Twain
