Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6D1E0AEB
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 11:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbgEYJm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 05:42:59 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60794 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389517AbgEYJm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 05:42:59 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 8DBCB1C02C2
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 11:42:57 +0200 (CEST)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 1D7F71A073D; Mon, 25 May 2020 11:42:57 +0200 (CEST)
Date:   Mon, 25 May 2020 11:42:57 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] lspci: Decode PCIe Link Capabilities 2
Message-ID: <mj+md-20200525.094222.61770.albireo@ucw.cz>
References: <20200521224030.1193617-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521224030.1193617-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.80
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.20), country: CZ(-0.00), ip: 91.219.245.20(-0.52)];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         AUTH_NA(1.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DMARC_NA(0.00)[ucw.cz];
         NEURAL_HAM(-0.00)[-0.277];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-250520,linux-pci=vger.kernel.org]
X-Rspamd-Queue-Id: 8DBCB1C02C2
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Decode Link Capabilities 2, including the Supported Link Speeds Vector,
> and expand the decoding of Link Status 2.
> 
> Bjorn Helgaas (2):
>   lspci: Decode PCIe Link Capabilities 2, expand Link Status 2
>   lspci: Use commas more consistently

Thanks, applied.

				Martin
