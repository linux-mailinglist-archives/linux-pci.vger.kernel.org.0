Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29984144610
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAUUsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 15:48:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48014 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUUsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 15:48:36 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id DFC5F1C0195
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2020 21:48:33 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id C00251A0561; Tue, 21 Jan 2020 21:48:33 +0100 (CET)
Date:   Tue, 21 Jan 2020 21:48:33 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Reorder Express Root Complex registers to Cap,
 Ctl, Sta
Message-ID: <mj+md-20200121.204523.30463.albireo@ucw.cz>
References: <20190517184022.79914-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517184022.79914-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.80
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.26), country: CZ(-0.00), ip: 91.219.245.20(-0.35)];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         AUTH_NA(1.00)[];
         DMARC_NA(0.00)[ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-0.161];
         R_SPF_NA(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-210120,linux-pci=vger.kernel.org];
         MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: DFC5F1C0195
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Registers in the PCI Express Capability come in sets of three (Capability,
> Control, Status), and we typically print them in that order.  The Root
> Complex-related registers were an exception: we printed them in the
> (Control, Capability, Status) order.
> 
> Decode the RootCap, RootCtl, and RootSta registers in the usual order.

Applied.

It seems that my bear nature took over and I spent a couple
of months by hibernating :-)

I am going to process all patches for pciutils queued in last few months,
make a release and hopefully return to regular maintenance again.

Thanks for the patience.

-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
The computer is mightier than the pen, the sword, and usually, the programmer.
