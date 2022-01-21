Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338494962A3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 17:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381749AbiAUQLx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 11:11:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37522 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiAUQLw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 11:11:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2C4CB82067
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 16:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B8EC340E1;
        Fri, 21 Jan 2022 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642781510;
        bh=z1MmIUsTd5gyftevRQ1Uoz07jmjBQNtEqTUB8WShNw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYvyhBnTEOffOfMPu2pyXy3cZhnxQTgtA//Cz3K4bF25hluCERE06hRvlSQPYcJhG
         Wh7PlDcU1YtE+mm6ZAaSYFVLzBPWztG+Zc6oCIHMmtXAiDVDseHhm7IacUGrnxj6Qf
         7va3iPg+A47VRWGu90qRbccG82PI+Qqr7kdku5AOH16PvSreIbZJ2PGAFn9upqkdBA
         HBKTRKhIDuCVaWA0HVLZh3afycqFQLTIM+EzhNmesEVRwq27yRKFI4T1BOyqXXnqml
         RKFIVtOkDpr2/+Lb3Sapk5BxXs5uPbPv5wRX986oq6QLmiHo9702dsBrQp7fKRHTXs
         ilXqop+/qubPg==
Received: by pali.im (Postfix)
        id B3B17857; Fri, 21 Jan 2022 17:11:47 +0100 (CET)
Date:   Fri, 21 Jan 2022 17:11:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/5] libpci: generic: Implement SUBSYS also for
 PCI_HEADER_TYPE_BRIDGE
Message-ID: <20220121161147.n6byckl4rnezfgy6@pali>
References: <20220121135718.27172-1-pali@kernel.org>
 <20220121135718.27172-4-pali@kernel.org>
 <mj+md-20220121.144016.17855.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20220121.144016.17855.nikam@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 21 January 2022 15:40:49 Martin Mareš wrote:
> Hello!
> 
> > +        case PCI_HEADER_TYPE_BRIDGE:
> > +          if (pci_read_word(d, PCI_STATUS) & PCI_STATUS_CAP_LIST)
> > +            {
> > +              byte been_there[256];
> > +              int where, id;
> > +
> > +              memset(been_there, 0, 256);
> > +              where = pci_read_byte(d, PCI_CAPABILITY_LIST) & ~3;
> > +              while (where && !been_there[where]++)
> 
> Please don't. There should be a single implementation of capability list
> walking in libpci, not everybody doing his own.

Current libpci code which walks capability list is in functions
pci_scan_caps() and pci_find_cap(). But pci_find_cap() calls
pci_fill_info() (only with PCI_FILL_CAPS flag). So I'm not sure if it is
a good idea to call pci_find_cap() from pci_generic_fill_info().
