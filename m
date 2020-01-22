Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E72145324
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAVKyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 05:54:04 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:41352 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVKyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 05:54:04 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 0D1241C013D
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 11:54:02 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 813301A0561; Wed, 22 Jan 2020 11:54:01 +0100 (CET)
Date:   Wed, 22 Jan 2020 11:54:01 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.6.3
Message-ID: <mj+md-20200122.105243.53346.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.60
X-Spamd-Result: default: False [-0.60 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         SENDER_REP_HAM(0.00)[asn: 51744(0.26), country: CZ(-0.00), ip: 91.219.245.20(-0.37)];
         RCPT_COUNT_ONE(0.00)[1];
         AUTH_NA(1.00)[];
         DMARC_NA(0.00)[ucw.cz];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM(-0.00)[-0.687];
         R_SPF_NA(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-220120,linux-pci=vger.kernel.org];
         R_MIXED_CHARSET(0.20)[subject]
X-Rspamd-Queue-Id: 0D1241C013D
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, world!\n

After a long hibernation, I just released pciutils-3.6.3.

At the moment, my patch queue is empty, so if you sent me a patch
over last few months and you did have not received a reply, please
re-send it.

From the changelog:

	* `lspci -t' (tree mode) can be combined with `-s' to show a sub-tree.
	  We also fixed potential buffer overflows in the tree dumper.

	* Cleaned messy code for dumping of I/O, memory, and ROM regions.
	  This helped fixing a bug, which caused some 64-bit regions to be
	  reported as virtual. All flags are now printed after the address
	  (previously, "[virtual]" and "[enhanced]" were before it for no good
	  reason).

	* Added pci_find_cap_nr() to the library, which handles capabilities
	  which occur multiple times in a single device.

	* Minor improvements in printing of PCIe capabilities.

	* We now decode the Multicast and Secondary PCI Express extended
	  capabilities.

	* The list of capability names available to setpci was updated.

	* Minor bugs were fixed in FreeBSD and Solaris ports.

	* We now prefer HTTPS URLs in all documentation

	* The pci.ids file has a man page.

	* As usually, updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
"I don't give a damn for a man that can only spell a word one way." -- M. Twain
