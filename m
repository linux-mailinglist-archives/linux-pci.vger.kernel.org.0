Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCA495F61
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbiAUNDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:03:46 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:41538 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiAUNDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:03:46 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (1024 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 2D86E1C0BA9
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:03:45 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 02F4A1A1627; Fri, 21 Jan 2022 14:03:44 +0100 (CET)
Date:   Fri, 21 Jan 2022 14:03:44 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 0/2] lspci: Decode VF 10-Bit Tag Requester
Message-ID: <mj+md-20220121.130325.38277.albireo@ucw.cz>
References: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 2D86E1C0BA9
X-Spam-Status: No, score=-1.49
X-Spamd-Bar: -
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
X-Spamd-Result: default: False [-1.49 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[ucw.cz];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         SENDER_REP_HAM(-0.69)[asn: 51744(-0.18), country: CZ(-0.01), ip: 91.219.245.20(-0.51)];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         AUTH_NA(1.00)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         NEURAL_HAM(-0.00)[-0.999];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-210122,linux-pci=vger.kernel.org]
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> The patchset is to decode VF 10-Bit Tag Requester and
> update the tests files.
> 
> V1->V2: Fix comments suggested by Krzysztof Wilczyński.
> 
> Dongdong Liu (2):
>   lspci: Decode VF 10-Bit Tag Requester
>   lspci: Update tests files with VF 10-Bit Tag Requester
> 
>  lib/header.h        | 2 ++
>  ls-ecaps.c          | 8 ++++----
>  tests/cap-dvsec-cxl | 4 ++--
>  tests/cap-ea-1      | 4 ++--
>  tests/cap-pcie-2    | 4 ++--
>  5 files changed, 12 insertions(+), 10 deletions(-)

Applied, sorry for the delay.

					Martin
