Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85825A7E6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBIlc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 04:41:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36760 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBIlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 04:41:31 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (1024 bits) client-digest SHA256)
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 454F91C0B7F
        for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2020 10:41:29 +0200 (CEST)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 7AC951A0491; Wed,  2 Sep 2020 10:41:28 +0200 (CEST)
Date:   Wed, 2 Sep 2020 10:41:28 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] pciutils: Add decode support for RCECs
Message-ID: <mj+md-20200902.084105.48579.albireo@ucw.cz>
References: <20200624223940.240463-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624223940.240463-1-sean.v.kelley@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.80
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.20), country: CZ(-0.00), ip: 91.219.245.20(-0.49)];
         DMARC_NA(0.00)[ucw.cz];
         AUTH_NA(1.00)[];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-0.271];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-020920,linux-pci=vger.kernel.org]
X-Rspamd-Queue-Id: 454F91C0B7F
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Root Complex Event Collectors provide support for terminating error
> and PME messages from RCiEPs.  This patch provides basic decoding for
> the lspci RCEC Endpoint Association Extended Capability. See PCIe 5.0-1,
> sec 7.9.10 for further details.

Applied.

Thanks and sorry for the delay.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
A Bash poem: time for echo in canyon; do echo $echo $echo; done
