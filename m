Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C91991D3
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 11:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgCaJVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 05:21:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731473AbgCaJJg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 05:09:36 -0400
Received: from zn.tnic (p200300EC2F0C09003D11AEAD23413CBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:900:3d11:aead:2341:3cbd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 65EE11EC0CBD;
        Tue, 31 Mar 2020 11:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585645774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IAjq8vkgmuwy5aDCdanAPTga8JYTa70hGlJvTK2iieo=;
        b=mJDZC8MHDaOJXLbCV9bY6OQtS+NMQtl8VJzFy9IxXRsNRFMmcDI1hXEW3sx9fvxViwZqQ+
        zaRUoDDBCBBARpOWZbSW+AgNfMQqetampHH+3rfhgtHcGFWgTYHep2T2a9mrqIZgRdtN0o
        EPV1nJxi4h/xiUcIxBrPv7zKPSEclJw=
Date:   Tue, 31 Mar 2020 11:09:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
Subject: Re: [PATCH v6 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200331090929.GB29131@zn.tnic>
References: <ShijuJose>
 <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com>
 <20200327182214.GD8015@zn.tnic>
 <b180618fb6cb477ea7185979c11c5868@huawei.com>
 <20200330103353.GC16242@zn.tnic>
 <ee79588ee82445dcb76f1fe6c1082fb8@huawei.com>
 <20200330134249.GF16242@zn.tnic>
 <613133075a174454a88312448b9b333c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <613133075a174454a88312448b9b333c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 03:44:29PM +0000, Shiju Jose wrote:
> 1. rasdaemon need not to print the vendor error data reported by the firmware if the 
>     kernel driver already print those information. In this case rasdaemon will only need to store
>     the decoded vendor error data to the SQL database.

Well, there's a problem with this:

rasdaemon printing != kernel driver printing

Because printing in dmesg would need people to go grep dmesg.

Printing through rasdaemon or any userspace agent, OTOH, is a lot more
flexible wrt analyzing and collecting those error records. Especially
if you are a data center admin and you want to collect all your error
records: grepping dmesg simply doesn't scale versus all the rasdaemon
agents reporting to a centrallized location.

> 2. If the vendor kernel driver want to report extra error information through
>     the vendor specific data (though presently we do not have any such use case) for the rasdamon to log. 
>     I think the error handled status useful to indicate that the kernel driver has filled the extra information and
>     rasdaemon to decode and log them after extra data specific validity check.

The kernel driver can report that extra information without the kernel
saying that the error was handled.

So I still see no sense for the kernel to tell userspace explicitly that
it handled the error. There might be a valid reason, though, of which I
cannot think of right now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
