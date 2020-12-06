Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15AE2D068B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Dec 2020 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLFSqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 13:46:48 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42438 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgLFSqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 13:46:48 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (1024 bits) client-digest SHA256)
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 0CE311C0B7F
        for <linux-pci@vger.kernel.org>; Sun,  6 Dec 2020 19:45:50 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id AD9411A0889; Sun,  6 Dec 2020 19:45:49 +0100 (CET)
Date:   Sun, 6 Dec 2020 19:45:49 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] lspci: Add PCIe 6.0 data rate (64 GT/s) support
Message-ID: <mj+md-20201206.184541.56867.albireo@ucw.cz>
References: <ad286025549e42030bc75ef9f99af9c92071a205.1605740212.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad286025549e42030bc75ef9f99af9c92071a205.1605740212.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 0CE311C0B7F
X-Spam-Status: No, score=-0.80
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.11), country: CZ(-0.00), ip: 91.219.245.20(-0.53)];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         AUTH_NA(1.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DMARC_NA(0.00)[ucw.cz];
         NEURAL_HAM(-0.00)[-0.992];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-061220,linux-pci=vger.kernel.org]
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
X-Spamd-Bar: /
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> This enables "lspci" to show PCIe 6.0 data rate (64 GT/s) properly
> according to the contents in register PCI_EXP_LNKCAP, PCI_EXP_LNKSTA
> and PCI_EXP_LNKCTL2.

Thanks, applied.

				Martin
