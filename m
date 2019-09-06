Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33ECABD9C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfIFQWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 12:22:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfIFQWg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 12:22:36 -0400
Received: from zn.tnic (p200300EC2F0B9E0090E54EFB2576D755.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:90e5:4efb:2576:d755])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05E8D1EC02FE;
        Fri,  6 Sep 2019 18:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567786955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hfQU7FovUUTVC4pcRa6r89QWSM4r+G6hlEG2jo1Y1Qg=;
        b=Kq+CspxyU1zZqv5oGP9VRP9+Dg0IYLGNE+wBuXnDxlhrA6X4zl3C8aVvAMPWDO4fx1LRJp
        8Duf+uI5jmbKl/QH8qSbvRTOmS9mq+kSDp6CWbjdW/YVvomi+qCXDJ+oEk6KLDIw38+QmZ
        D+XpSpSLu0Oy1j3Pb3fuX9mSXtC/6gY=
Date:   Fri, 6 Sep 2019 18:22:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Message-ID: <20190906162233.GI19008@zn.tnic>
References: <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905070917.GA19246@zn.tnic>
 <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905135408.GE19246@zn.tnic>
 <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
 <20190906091250.GB19008@zn.tnic>
 <20190906130206.GB7255@roeck-us.net>
 <6B3FCC26-7A2F-438F-B442-EA665DDD0569@alien8.de>
 <20190906161140.GB25316@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906161140.GB25316@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 09:11:40AM -0700, Guenter Roeck wrote:
> 12163cfbfc0f ("hwmon: (k10temp) Add support for AMD family 17h, model 70h CPUs")
> af4e1c5eca95 ("x86/amd_nb: Add PCI device IDs for family 17h, model 70h")

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
