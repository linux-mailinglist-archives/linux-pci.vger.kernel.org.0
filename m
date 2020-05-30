Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2D1E9438
	for <lists+linux-pci@lfdr.de>; Sun, 31 May 2020 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgE3WZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 May 2020 18:25:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55378 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgE3WZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 May 2020 18:25:38 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (1024 bits) client-digest SHA256)
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id ED5911C0BD2
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2020 00:25:36 +0200 (CEST)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id C47761A103F; Sun, 31 May 2020 00:25:36 +0200 (CEST)
Date:   Sun, 31 May 2020 00:25:36 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.7.0 released
Message-ID: <mj+md-20200530.222433.78612.albireo@ucw.cz>
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
         SENDER_REP_HAM(0.00)[asn: 51744(0.22), country: CZ(-0.00), ip: 91.219.245.20(-0.52)];
         DMARC_NA(0.00)[ucw.cz];
         AUTH_NA(1.00)[];
         RCPT_COUNT_ONE(0.00)[1];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         TO_DN_ALL(0.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-0.475];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-310520,linux-pci=vger.kernel.org];
         R_MIXED_CHARSET(0.20)[subject]
X-Rspamd-Queue-Id: ED5911C0BD2
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello world!\n

I released version 3.7.0 of the pciutils.

From the changelog:

	* Released as 3.7.0.

	* Added or improved the following capabilities: Designated Vendor-Specific,
	  Compute eXpress Link, Resizable BARs, VF Resizable BARs, Link
	  Capabilities 2, Link Status 2.

	* On Linux, lspci can show IOMMU groups.

	* setpci can be asked to skip bus scan and operate on a device
	  completely specified by its domain/bus/dev/func address. This
	  involved major internal cleanup.

	* The above feature of setpci uses the pci_get_dev() function,
	  which obtains a struct pci_dev without doing a bus scan. This was
	  always possible, but apparently little used, because back-ends
	  frequently choked when operating on such devices. Fixed a lot
	  of minor bugs related to this.

	* Also, back-ends which do not support domains now correctly fail when
	  trying to access devices outside domain 0.

	* Semantics of pci_fill_info() and pci_dev->known_fields was underspecified,
	  which lead to inconsistencies between back-ends. Improved documentation
	  to give a more precise definition and updated all back-ends to conform
	  to it. Most importantly, pci_dev->known_fields shows all fields requested
	  over the lifetime of the pci_dev, but never those which are not supported
	  by the back-end.

	* As usually, updated pci.ids to the current snapshot of the database.

If you are aware of a patch which was not merged, please let me know.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
And God said: E = 1/2mv^2 - Ze^2/r ...and there *was* light!
