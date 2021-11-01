Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B6441B15
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhKAMZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhKAMZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 08:25:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3554C061714;
        Mon,  1 Nov 2021 05:23:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cfa00ec4efdd1c18768d4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fa00:ec4e:fdd1:c187:68d4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2464F1EC0372;
        Mon,  1 Nov 2021 13:23:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635769383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aOWJ/xWRA0KQY6ubEa2Bhf55JdIZ4Fz4oQrfWNl+tj4=;
        b=dcatoeFJAnA20lMUZJRKvn0cbBBsIc3RoG3IC3+Xf0OHOQuZ0xiJqcAMv/wgzNXvu4b9DA
        K19aVqVWqNSU3qieYv5/SEzpB2oq6eaZrg8JWNQ92f9Z/pFUL9cb1UjUvrOW/BkqXEmi4c
        KDhjMwUs1dmiyXsqRDD1tNM+8gVu9K0=
Date:   Mon, 1 Nov 2021 13:22:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, helgaas@kernel.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, rafael@kernel.org, tony.luck@intel.com,
        mingo@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
Message-ID: <YX/cIhZDgUGI3FKd@zn.tnic>
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
 <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
 <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
 <20211101093618.GA27400@willie-the-truck>
 <286ac625-e712-d7e9-2f5d-923f1572b5d1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <286ac625-e712-d7e9-2f5d-923f1572b5d1@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 08:12:15PM +0800, Xuesong Chen wrote:
> I'm very sorry about the non-constructived response, and I'd like to
> take this chance to withdraw them entirely... personally this is not a
> good example in terms of the mood or the way of expression.

Good idea. There are other maintainers who would ignore you indefinitely
for uncalled for explosions like that. And then you would have achieved
the opposite of what you were aiming for, with that rant.

To Will's point, you can always read Documentation/process/ while
waiting for your patches to get reviewed - there the whole process is
explained and what the best ways and times are to send a patchset.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
