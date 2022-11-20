Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CC6313E2
	for <lists+linux-pci@lfdr.de>; Sun, 20 Nov 2022 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKTMXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 07:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKTMXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 07:23:46 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA829CB1
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 04:23:45 -0800 (PST)
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (1024 bits) client-digest SHA256)
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id D12291C09ED
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 13:23:42 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id AB3631A0F29; Sun, 20 Nov 2022 13:23:42 +0100 (CET)
Date:   Sun, 20 Nov 2022 13:23:42 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.9.0 released
Message-ID: <mj+md-20221120.122204.21924.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D12291C09ED
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spamd-Result: default: False [-3.28 / 15.00];
        BAYES_HAM(-2.98)[99.89%];
        HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
        IP_REPUTATION_HAM(-0.91)[asn: 51744(-0.27), country: CZ(-0.00), ip: 91.219.245.20(-0.64)];
        NEURAL_HAM(-0.70)[-0.701];
        HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
        MIME_GOOD(-0.10)[text/plain];
        DMARC_POLICY_SOFTFAIL(0.10)[ucw.cz : No valid SPF, No valid DKIM,none];
        R_SPF_NA(0.00)[no SPF record];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        TAGGED_FROM(0.00)[f-201122,linux-pci=vger.kernel.org];
        R_DKIM_NA(0.00)[];
        ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
        RCVD_TLS_LAST(0.00)[];
        RCPT_COUNT_ONE(0.00)[1];
        R_MIXED_CHARSET(0.00)[subject];
        ARC_NA(0.00)[];
        TO_DN_ALL(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        FROM_HAS_DN(0.00)[];
        RCVD_COUNT_TWO(0.00)[2]
X-Spamd-Bar: ---
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        spf=none (jabberwock.ucw.cz: domain of "mj+f-201122+linux-pci=vger.kernel.org@ucw.cz" has no SPF policy when checking 91.219.245.20) smtp.mailfrom="mj+f-201122+linux-pci=vger.kernel.org@ucw.cz";
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=ucw.cz (policy=none)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, world!

I just released version 3.9.0 of the PCI Utilities.

(The tarball at kernel.org is not updated yet, since I'm having some problems
with signature verification.)

From the changelog:

	* We decode Compute Express Link (CXL) capabilities.

	* The tree mode of lspci is now compatible with filtering options.

	* When setpci is used with a named register, it checks whether
	  the register is present in the particular header type.

	* Linux: The intel-conf[12] back-ends prefer to use ioperm() instead
	  of iopl() to gain access to I/O ports.

	* Windows: We have two new back-ends thanks to Pali Rohár.
	  One uses the NT SysDbg interface, the other uses kldbgdrv.sys
	  (which is a part of the Microsoft WinDbg tool).

	* Windows: We support building libpci as a DLL. Also, Windows
	  binaries now include meta-data with version.

	* Hurd: The Hurd back-end works again.

	* mmio-conf1(-ext): Added a new back-end implementing the intel-conf1
	  interface over MMIO. This is useful on some ARM machines, but it
	  requires manual configuration of the MMIO addresses.

	* As usually, updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
