Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4FB6FA29C
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 10:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjEHIxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjEHIxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 04:53:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A491E98B;
        Mon,  8 May 2023 01:53:05 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8CA71EC03CA;
        Mon,  8 May 2023 10:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683535983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hlh/0E7Q4CdHlZhbiQKpJN0ADMtYynZ5fuJZeTP4DJU=;
        b=CxBF7YhrLnTGndPBNdaro/UfEQ9q97287hu0HOdmTusH/AauqwTm3uMnN3vQ38sMj4nC2B
        pHICRCTLsRhcOZb2vTyHkMrLSBu48LRMRa8vBcQ+9C0uqLeNvdb6Qq4hJutJy67u4B8a8t
        9yvIt3agS0IJ/Vc7xLGfwOT77q0ztaE=
Date:   Mon, 8 May 2023 10:52:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <20230508085258.GAZFi4ahlTvuPKxz0Y@fat_crate.local>
References: <20230427053338.16653-2-mario.limonciello@amd.com>
 <20230427164816.GA255750@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427164816.GA255750@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 11:48:16AM -0500, Bjorn Helgaas wrote:
> Grudgingly, because this really isn't a maintainable strategy:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h

I was wondering whether that define should even go into pci_ids.h  but
there's a patch 2 which uses it and which is *not* in my mbox.

Mario, please CC everybody on all patches in the future.

I'll take the k10temp one too so that there's no cross-tree deps.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
