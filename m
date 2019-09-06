Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6694BABB61
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 16:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbfIFOuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 10:50:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbfIFOuj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 10:50:39 -0400
Received: from zn.tnic (p200300EC2F0B9E005D980F871595326F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:5d98:f87:1595:326f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EBE11EC026F;
        Fri,  6 Sep 2019 16:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567781437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=neVdSvXZgCbhFLuEiEibEAFt6fu4+I4KkBYLe8mb8pQ=;
        b=o34Rh9M49TPF8JD/FIh42+VF4EABxqLTr9990hTI40F5zBYOvPg7CfyKqqcx1Se3l+QP2K
        2gjQJoMoeQnqNjFhkkTxbLCo3Fe+BRrUbuuQhFW0iZzFx7WqQAJG+Jzsz2StndUSvWZ7ha
        umgwNYLGMlQigkMfrlq9Rp6/1NAOO+k=
Date:   Fri, 6 Sep 2019 16:50:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Message-ID: <20190906145030.GD19008@zn.tnic>
References: <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905070917.GA19246@zn.tnic>
 <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905135408.GE19246@zn.tnic>
 <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
 <20190906091250.GB19008@zn.tnic>
 <20190906130206.GB7255@roeck-us.net>
 <6B3FCC26-7A2F-438F-B442-EA665DDD0569@alien8.de>
 <B08C8E54-43FA-4E29-8D7D-5F9C4AF20CCF@Knights.ucf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B08C8E54-43FA-4E29-8D7D-5F9C4AF20CCF@Knights.ucf.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 02:05:35PM +0000, Isaac Vaughn wrote:
> They seem to have already covered the changes to hwmon and amd_nb, so
> the difference is probably the changes to amd64_edac.

Yeah, then you can send me only those changes against edac-for-next.
The driver won't load on Zen2 before the amd_nb.c changes have landed
upstream but that's fine - it's not like it did load before.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
