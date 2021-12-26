Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914D047F93B
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhLZWNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:13:13 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53310 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhLZWNM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:13:12 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (1024 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id A9E801C0B88
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 23:13:11 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 83CEB1A1FC4; Sun, 26 Dec 2021 23:13:11 +0100 (CET)
Date:   Sun, 26 Dec 2021 23:13:11 +0100
From:   Martin =?iso-8859-2?Q?Mare=B9?= <mj@ucw.cz>
To:     Pali =?iso-8859-2?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?iso-8859-2?Q?Wilczy=F1ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/4] libpci: Add support for filling bridge
 resources
Message-ID: <mj+md-20211226.221209.62509.albireo@ucw.cz>
References: <20211220155448.1233-1-pali@kernel.org>
 <20211220155448.1233-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220155448.1233-3-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: A9E801C0B88
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
         DMARC_NA(0.00)[ucw.cz];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         SENDER_REP_HAM(-0.74)[asn: 51744(-0.17), country: CZ(-0.00), ip: 91.219.245.20(-0.56)];
         RCPT_COUNT_FIVE(0.00)[5];
         AUTH_NA(1.00)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
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

> +      else if (i < 7+6+4)
> +        {
> +          /*
> +           * If kernel was compiled without CONFIG_PCI_IOV option then after
> +           * the ROM line for configured bridge device (that which had set
> +           * subordinary bus number to non-zero value) are four additional lines
> +           * which describe resources behind bridge. For PCI-to-PCI bridges they
> +           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
> +           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
> +           * there is no additional line after the ROM line. If kernel was
> +           * compiled with CONFIG_PCI_IOV option then after the ROM line and
> +           * before the first bridge resource line are six additional lines
> +           * which describe IOV resources. Read all remaining lines in resource
> +           * file and based on the number of remaining lines (0, 4, 6, 10) parse
> +           * resources behind bridge.
> +           */
> +          lines[i-7].flags = flags;
> +          lines[i-7].base_addr = start;
> +          lines[i-7].size = size;
> +        }
> +    }
> +  if (i == 7+4 || i == 7+6+4)

This looks crazy: is there any other way how to tell what the bridge entries mean?
Checking the number of entries looks very brittle.

				Martin
