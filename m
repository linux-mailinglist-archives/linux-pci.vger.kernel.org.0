Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA26F1E3AA3
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgE0Hby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 03:31:54 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33030 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgE0Hby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2020 03:31:54 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 31FC21C0300
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2020 09:31:52 +0200 (CEST)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 85AED1A157C; Wed, 27 May 2020 09:31:51 +0200 (CEST)
Date:   Wed, 27 May 2020 09:31:51 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] CXL: Capability vendor ID changed
Message-ID: <mj+md-20200527.073144.72636.albireo@ucw.cz>
References: <20200526205628.342438-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526205628.342438-1-sean.v.kelley@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.69
X-Spamd-Result: default: False [-0.69 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SENDER_REP_HAM(0.00)[asn: 51744(0.20), country: CZ(-0.00), ip: 91.219.245.20(-0.52)];
         DMARC_NA(0.00)[ucw.cz];
         AUTH_NA(1.00)[];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-0.162];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-270520,linux-pci=vger.kernel.org];
         R_MIXED_CHARSET(0.11)[subject]
X-Rspamd-Queue-Id: 31FC21C0300
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Update the cap-dvsec-cxl test to match the new vendor ID.

Fine, applied. Thanks!

				Martin
