Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD406F315F
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 15:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjEANDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjEANDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 09:03:46 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B88192
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 06:03:42 -0700 (PDT)
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (1024 bits) client-digest SHA256)
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 3A83F1C0E58
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 15:03:40 +0200 (CEST)
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=ucw.cz (policy=none);
        spf=none (jabberwock.ucw.cz: domain of "mj+f-010523+linux-pci=vger.kernel.org@ucw.cz" has no SPF policy when checking 91.219.245.20) smtp.mailfrom="mj+f-010523+linux-pci=vger.kernel.org@ucw.cz"
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id DD9C51A0A2A; Mon,  1 May 2023 15:03:39 +0200 (CEST)
Date:   Mon, 1 May 2023 15:03:39 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils 3.10.0 released
Message-ID: <mj+md-20230501.130215.83088.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Rspamd-Queue-Id: 3A83F1C0E58
X-Spamd-Result: default: False [-1.79 / 15.00];
        BAYES_HAM(-2.55)[97.99%];
        HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
        IP_REPUTATION_HAM(-0.89)[asn: 51744(-0.24), country: CZ(-0.00), ip: 91.219.245.20(-0.65)];
        NEURAL_SPAM(0.36)[0.359];
        HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
        MIME_GOOD(-0.10)[text/plain];
        DMARC_POLICY_SOFTFAIL(0.10)[ucw.cz : No valid SPF, No valid DKIM,none];
        R_MIXED_CHARSET(0.00)[subject];
        RCVD_TLS_LAST(0.00)[];
        TO_DN_ALL(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        RCPT_COUNT_ONE(0.00)[1];
        R_SPF_NA(0.00)[no SPF record];
        BLOCKLISTDE_FAIL(0.00)[91.219.245.20:server fail];
        R_DKIM_NA(0.00)[];
        FROM_HAS_DN(0.00)[];
        ARC_NA(0.00)[];
        ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
        FROM_EQ_ENVFROM(0.00)[];
        TAGGED_FROM(0.00)[f-010523,linux-pci=vger.kernel.org];
        RCVD_COUNT_TWO(0.00)[2];
        MID_RHS_MATCH_FROM(0.00)[];
        MIME_TRACE(0.00)[0:+]
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, world!\n

I released pciutils 3.10.0. Thus quoth the changelog:

    * Released as 3.10.0.

    * Fixed bug in definition of versioned symbol aliases
      in shared libpci, which made compiling with link-time
      optimization fail.

    * Filters now accept "0x..." syntax for backward compatibility.

    * Windows: The cfgmgr32 back-end which provides the list of devices
      can be combined with another back-end which provides access
      to configuration space.

    * ECAM (Enhanced Configuration Access Mechanism), which is defined
      by the PCIe standard, is now supported. It requires root privileges,
      access to physical memory, and also manual configuration on some
      systems.

    * lspci: Tree view now works on multi-domain systems. It now respects
      filters properly.

    * Last but not least, pci.ids were updated to the current snapshot
      of the database. This includes overall cleanup of entries with
      non-ASCII characters in their names -- such characters are allowed,
      but only if they convey interesting information (e.g., umlauts
      in German company names, but not the "registered trade mark" sign).

Thanks to all contributors, most importantly Pali Rohár.

			Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
Wanted: Schroedinger Cat. Dead or Alive.
