Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9567125A7EB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBImw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 04:42:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36874 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBIms (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 04:42:48 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (1024 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 726511C0B96
        for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2020 10:42:46 +0200 (CEST)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id 50E011A0491; Wed,  2 Sep 2020 10:42:46 +0200 (CEST)
Date:   Wed, 2 Sep 2020 10:42:46 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 0/2] lspci: Decode 10-Bit Tag Requester Enable
Message-ID: <mj+md-20200902.084236.48915.albireo@ucw.cz>
References: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.80
X-Spamd-Result: default: False [-0.80 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[99.99%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         SENDER_REP_HAM(0.00)[asn: 51744(0.20), country: CZ(-0.00), ip: 91.219.245.20(-0.50)];
         DMARC_NA(0.00)[ucw.cz];
         AUTH_NA(1.00)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         NEURAL_HAM(-0.00)[-0.269];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-020920,linux-pci=vger.kernel.org]
X-Rspamd-Queue-Id: 726511C0B96
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> This patchset is to:
> 1. Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition to keep the
> same style between the Linux kernel source [1] and lspci.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651
> 
> 2. Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
"Object orientation is in the mind, not in the compiler." -- Alan Cox
