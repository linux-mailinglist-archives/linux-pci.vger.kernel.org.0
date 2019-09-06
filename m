Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7AAB8EB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392821AbfIFNJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 09:09:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52202 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392815AbfIFNJZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 09:09:25 -0400
Received: from [10.137.222.223] (unknown [46.114.38.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B7361EC094F;
        Fri,  6 Sep 2019 15:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567775359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGuDj5mjeN9dXBrdNX4jmqchedIpI5QK6YO+nkumStE=;
        b=FTv1yVyKhR4FkemGZ7IMPFayXusamHoXvS8q2bQ7id59nJfgTTVWKgCYOc3/l+wW7imJCs
        ysCNpJhMjqCmUSHWQbng2tvg0e+3TOlu1dJlub3S1zHsKCqLAojlOcNZAgKtNxOw3o1NoU
        ZlGspO3HZ0w63o3UrZyZ/tgng/fbKHw=
Date:   Fri, 06 Sep 2019 15:09:16 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190906130206.GB7255@roeck-us.net>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com> <20190904215308.GA12374@zn.tnic> <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com> <20190905070917.GA19246@zn.tnic> <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com> <20190905135408.GE19246@zn.tnic> <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu> <20190906091250.GB19008@zn.tnic> <20190906130206.GB7255@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
From:   Boris Petkov <bp@alien8.de>
Message-ID: <6B3FCC26-7A2F-438F-B442-EA665DDD0569@alien8.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On September 6, 2019 3:02:06 PM GMT+02:00, Guenter Roeck <linux@roeck-us=2E=
net> wrote:
>Also, how is this patch different to the patches already in linux-next
>?

Which are those? Care to share their linux-next commit IDs with us?=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
