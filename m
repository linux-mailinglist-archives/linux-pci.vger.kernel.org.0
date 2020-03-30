Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709A9197957
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 12:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgC3KeD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 06:34:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgC3KeD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 06:34:03 -0400
Received: from zn.tnic (p200300EC2F06760078F8067BD6E9D19D.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:7600:78f8:67b:d6e9:d19d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A60CA1EC0CB7;
        Mon, 30 Mar 2020 12:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585564440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n+yHtTiDVvF6Kro2y++xFDXvA1AQyQV5TZDwHc2h0u4=;
        b=EzKrSctOyBi0y7pUhYWczf7ulg59FKG2JQzt1n94OsNviMQb7jpgyWGTHByA1jIlC/YADk
        wTw+cdZlv9UidunvMI3ri8mGKfeou/EvoxMTKPbjaYDGEmeeoO1YxqTjAj3RXTuAQEMg3l
        ZvO49p+Q0krnpiH+Iolz72gOiuhPps8=
Date:   Mon, 30 Mar 2020 12:33:53 +0200
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
Message-ID: <20200330103353.GC16242@zn.tnic>
References: <ShijuJose>
 <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com>
 <20200327182214.GD8015@zn.tnic>
 <b180618fb6cb477ea7185979c11c5868@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b180618fb6cb477ea7185979c11c5868@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 10:14:20AM +0000, Shiju Jose wrote:
> This field added based on the input from James Morse on v4 patch to
> enable the user space application(rasdaemon) do the decoding and
> logging of the any extra error information shared by the corresponding
> kernel driver to the user space.

How is your error reporting supposed to work?

Your driver is printing error information in dmesg and, at the same
time, you want to report errors with the rasdaemon.

Currently, the kernel does not report any error info if there's a user
agent like rasdaemon registered so you need to think about what exactly
you're trying to achieve here wrt to error handling. Port resetting,
printing error info, etc. Always ask yourself, what can the user do with
the information you're printing. And so on...

> Can you please confirm you want all the existing standard
> errors(memory, ARM, PCIE) in the ghes_do_proc () to be reported
> through the blocking notifier?

Yes, I would very much prefer to have a generic solution instead of
vendor-specific stuff left and right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
