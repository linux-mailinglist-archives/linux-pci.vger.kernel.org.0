Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66C197D35
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgC3Nmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 09:42:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgC3Nmv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 09:42:51 -0400
Received: from zn.tnic (p200300EC2F0676006087085B094249ED.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:7600:6087:85b:942:49ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5188B1EC0C6D;
        Mon, 30 Mar 2020 15:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585575769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PnWQB32YQWUU9apHIIF6hYLEV8g87zpXf+oLOLk+Jn0=;
        b=PI/dqZpHZ37gHwluhR9wtdZV4Bw/kEexbFP9kEs6o79i0Kcfnet4d3taRvyhdQHIDN5jky
        KrG2WJBneEE6xXDld25iy/GPkhpQ/1RAq1pdrLioqLzpEHYCuckioo8mNx4QwA+NbOnV7/
        j8ooSV7dHhWrraIXutWC7flBFVko/Ws=
Date:   Mon, 30 Mar 2020 15:42:49 +0200
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
Message-ID: <20200330134249.GF16242@zn.tnic>
References: <ShijuJose>
 <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com>
 <20200327182214.GD8015@zn.tnic>
 <b180618fb6cb477ea7185979c11c5868@huawei.com>
 <20200330103353.GC16242@zn.tnic>
 <ee79588ee82445dcb76f1fe6c1082fb8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee79588ee82445dcb76f1fe6c1082fb8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 11:55:35AM +0000, Shiju Jose wrote:
> The idea was the error handled field will help the decoding part of
> the rasdaemon to do the appropriate steps for logging the vendor error
> information depending on whether a corresponding kernel driver has
> handled the error or not.

What's the difference for rasdaemon whether the error has been handled
or not?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
