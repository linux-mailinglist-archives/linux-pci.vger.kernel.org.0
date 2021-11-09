Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6A44AA88
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 10:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbhKIJ1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 04:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbhKIJ1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 04:27:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24486C061764;
        Tue,  9 Nov 2021 01:24:35 -0800 (PST)
Received: from zn.tnic (p2e584790.dip0.t-ipconnect.de [46.88.71.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D881EC04E4;
        Tue,  9 Nov 2021 10:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636449873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yFqY4ZC+tk+ojUjF553QTrJ3iEB11I0CRzAPXH7XI5c=;
        b=FjQi8y73HoFQWdP5cPsdQNqkvbI7a/EC2n42PgVfs/eH3X1qfGtz8qLblmgwY+u3s1w9Ek
        GgNKHuXDoBFtjv9kDQEpwgKdzXWIqGV+FTqOiomyk19i1lFKM+WgMvclYJWRiZ4QoB/7Wk
        298crZiYiCPJrd1yGYJ7hihIJ4kXQok=
Date:   Tue, 9 Nov 2021 10:22:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Babu Moger <babu.moger@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, clemens@ladisch.de,
        jdelvare@suse.com, linux@roeck-us.net, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and
 (A0h-AFh) PCI IDs
Message-ID: <YYo9zEGr7wSKT8Gk@zn.tnic>
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
 <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 03:51:21PM -0600, Babu Moger wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Add the new PCI Device IDs to support new generation of AMD 19h family of
> processors.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c |    5 +++++
>  include/linux/pci_ids.h  |    1 +
>  2 files changed, 6 insertions(+)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
