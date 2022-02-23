Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BA4C0CA4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiBWGli (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 01:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiBWGlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 01:41:37 -0500
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066EF6D847
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 22:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1645598469; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dcI7g8qwjxiuHyenfs4KbzobcSagSIcq5mgrBJTym6U7piuVNnk+r4ofk4zcP/RD7QM+EdMp3po3RQxVoQRXkhiKPr2x2xCfhptXb07X0PPLR8saF3h/8jGgxMof3pvoZFMmU1Rh58ZbblXSvsmpmdqrs40FASDi/Bh68J0a7ew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1645598469; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vNIl/EX8KuO2HccVac7joy56UrcfppTp3DTguES5Th4=; 
        b=B6TBSZlj/s/A9idmU4pajSVqsVlJy2raDK09UMOMFmKxXcx+bhH0lBCiApEd39ZQSAx4ZSp2v3OkCT8uvscnEq/p7aKxSBT6KMI0DSOyUo3yIzB4obCa7eDfeJRf0i8iMlpiLlj4ubotii27QCTIxYCHPMcNjrcrogAoThtHWs4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1645598469;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=vNIl/EX8KuO2HccVac7joy56UrcfppTp3DTguES5Th4=;
        b=llAr9oFfrKYC6UAA5cZkVgxqrnaFMzclLsUrTnWh+JQZq8F18ECmJvk9KJr9LV8D
        QanPBNxGvETRRpWIo9xCGKPmGIpsckVa5f+5EtUepOORZFI4/PnAXj6MfB3fukMAqKw
        63ho4dlGHZoP2Qehc/IvQCFAoYy02yFKEse5VyNg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1645598468415994.7128459791436; Tue, 22 Feb 2022 22:41:08 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Tue, 22 Feb 2022 22:41:08 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:41:08 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <17f254fe922.fab4a6ef195546.3071922961546334690@zohomail.com>
In-Reply-To: <17f21d8f75b.cd205cfe182723.8713720915614530205@zohomail.com>
References: <17f21d8f75b.cd205cfe182723.8713720915614530205@zohomail.com>
Subject: Re: [Question] Is it safe to use ioremap_cache for EPF' BAR mem?
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From my test result:
        // return ioremap_cache(start, size); // Serror
	// return ioremap_wc(start, size); // Internal error: synchronous external abort: 96000410 [#1] PREEMPT SMP
	// return memremap(start, size, MEMREMAP_WB); // SError
	// return memremap(start, size, MEMREMAP_WT); // works, but as slow as non-cachaeble ioremap
	// return memremap(start, size, MEMREMAP_WC); // Internal error: synchronous external abort: 96000410 [#1] PREEMPT SMP

It's not safe.

Regards,
Li
 ---- On Tue, 22 Feb 2022 22:32:21 +0800 Li Chen <lchen.firstlove@zohomail.com> wrote ----
 > Hi all,
 > 
 > Say that I have one controller run under EP-mode and its bar 2 is mapped into a large DRAM area actually.  pci_ioremap and its friends just use ioremap internally and are non-cachable by default, so the speed is really slow(in my case write 28m/s and read 3m/d). I wonder is it safe to use ioremap_cache for this bar?
 > 
 > 
 > Regards,
 > Li
 > 
