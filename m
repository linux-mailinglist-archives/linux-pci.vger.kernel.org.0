Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D421214462A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 22:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAUVAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 16:00:43 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48816 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgAUVAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 16:00:43 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 1FF221C036F
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2020 22:00:42 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id E899F1A0561; Tue, 21 Jan 2020 22:00:41 +0100 (CET)
Date:   Tue, 21 Jan 2020 22:00:41 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com
Subject: Re: [PATCH 0/2] lspci: Add lspci support to decode AIDA64 and dmesg
 log files
Message-ID: <mj+md-20200121.205559.30897.albireo@ucw.cz>
References: <20190704000819.25050-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190704000819.25050-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=0.70
X-Spamd-Result: default: False [0.70 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         SENDER_REP_HAM(0.00)[asn: 51744(0.26), country: CZ(-0.00), ip: 91.219.245.20(-0.37)];
         RCPT_COUNT_FIVE(0.00)[5];
         DMARC_NA(0.00)[ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         AUTH_NA(1.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-0.409];
         R_SPF_NA(0.00)[];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-210120,linux-pci=vger.kernel.org];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 1FF221C036F
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Add lspci support to decode AIDA64 log files and dmesg log files with
> "pci=earlydump" parameter to output PCI configuration space information.
> 
> 	Patch 1: Add lspci support to decode AIDA64 log file.
> 
> 	AIDA64 log file included in patch for testing. Use the following
> 	command to run:
> 
> 		lspci -F tests/aida64-dump
> 
> 
> 	Patch 2: Add lspci support to decode dmesg log file with
> 	"pci=earlydump" parameter.
> 
> 	dmesg log file with "pci=earlydump" included in patch for
> 	testing. Use the following command to run:
> 
>                 lspci -F tests/dmesg-dump

Generally, I like the idea of adding these two file formats
to the dump back-end.

However, combining parsers of all three formats to a single block
of code looks pretty scary. With a couple of formats more, this would
become an unmaintable mess.

I would prefer separate parsers and explicit selection of input format.
If you want any help with how to integrate that to libpci/lspci, please
let me know.

Also, please document which formats are supported.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
"I think it's a new feature.  Don't tell anyone it was an accident. :-)" -- Larry Wall
