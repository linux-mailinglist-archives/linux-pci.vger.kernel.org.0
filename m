Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1572847F931
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhLZWFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:05:24 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52266 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhLZWFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:05:23 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (1024 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 418791C0B88
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 23:05:22 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 3A3971A1FC4; Sun, 26 Dec 2021 23:05:22 +0100 (CET)
Date:   Sun, 26 Dec 2021 23:05:22 +0100
From:   Martin =?iso-8859-2?Q?Mare=B9?= <mj@ucw.cz>
To:     Pali =?iso-8859-2?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?iso-8859-2?Q?Wilczy=F1ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 pciutils] lspci: Print buses of multibus PCI domain in
 ascending order
Message-ID: <mj+md-20211226.220511.62016.albireo@ucw.cz>
References: <mj+md-20211226.215722.61425.albireo@ucw.cz>
 <20211226220403.18063-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226220403.18063-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 418791C0B88
X-Spam-Status: No, score=-1.54
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.54 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         SENDER_REP_HAM(-0.74)[asn: 51744(-0.17), country: CZ(-0.00), ip: 91.219.245.20(-0.56)];
         RCPT_COUNT_FIVE(0.00)[5];
         AUTH_NA(1.00)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DMARC_NA(0.00)[ucw.cz];
         NEURAL_HAM(-0.00)[-1.000];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-261221,linux-pci=vger.kernel.org]
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> Currently PCI domains are printed in ascending order. Devices on each PCI
> bus are also printed in ascending order. PCI buses behind PCI-to-PCI
> bridges are also printed in ascending order.
> 
> But buses of PCI domain are currently printed in descending order because
> function new_bus() puts newly created bus at the beginning of linked list.
> 
> In most cases PCI domain contains only one (top level) bus, so in most
> cases it is not visible this inconsistency.
> 
> Multibus PCI domains (where PCI domain contains more independent top level
> PCI buses) are available on ARM devices.
> 
> This change fixes print order of multibus PCI domains, so also top level
> PCI buses are printed in ascending order, like PCI buses behind PCI-to-PCI
> bridges.

Thanks, applied.

					Martin
