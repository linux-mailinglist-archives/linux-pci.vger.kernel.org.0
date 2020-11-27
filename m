Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB32C5E92
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 02:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392137AbgK0Brv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 20:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgK0Bru (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 20:47:50 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E3C0613D4;
        Thu, 26 Nov 2020 17:47:50 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so5421390ejb.3;
        Thu, 26 Nov 2020 17:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TH1ugCiizifOLOya1BWGmhh3l5zdn0yT/6/5FRCAhqM=;
        b=LsycItdgqAudg+ZZyX4TzvWnfqwoBxg5TiM7PFZbr7EVt+T0mze5yYEi1tvqwPpNqk
         2cB+6xwRR4H2oNK3lbLxHwuVC7uVJspP5Z4tl23P1LayAMbqqA8WX4tgB3n6Q4luH9e6
         J5xWyn3MLgx4KuwNA4ema750bSJ0GJR0FMzbq656+CRehO2iSR5GTVRu5QNdgLskpjKq
         OFPXyOOYlngIVFRT8G5syxQgYAyShH+Xnmj1RG1sop14W4pIts+fFz0AUnVow15aV5Ic
         D0LRtgbEi+0WwGopFl5ZGmS2Fu2mYyQmHKlvm1jVrqudsyG22qGfjdUUzZ1awTlQgjCF
         fG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH1ugCiizifOLOya1BWGmhh3l5zdn0yT/6/5FRCAhqM=;
        b=U/woaoeFwzogZwQ2LEJOydtNATfbjRhenBA7X2vCQhBA/rmekzaq88qXMEtdQ0uFyu
         sakNW/0g2QQFp7eM8PA8deeTGcu80A68UZCBS8JDQIsMHnzdcQB+RZWNaS1Vz++KYyC0
         jkP4CKkS97rejQgvY6NmBmc+5m6uyM3UWNpo+hrRwKGbcXLDnMMjUyRgyhAGM53JBbCa
         8Odn1Y/zc59R3r61wWAZrbHdX1jwoNWUh/N4sgEd3aX7UhSTMfVdFliqJI8KhoMtOkGp
         yx1yRMYB6toplZTgYDyWb1JjbSjpZwiWmJMpJsUAkh1vdwG++WcXExTdDfIDncusNco5
         eIAg==
X-Gm-Message-State: AOAM530jZr10AB2lXr8sXf6Fn0lhwEdE7hPgFZDhUXDvvAJrB69mGxSR
        7cb8HsPmlrFEnUR1BeI2OrbS6cTCHzn25cH8VN0=
X-Google-Smtp-Source: ABdhPJzQATMFG/XfORq7/Zk2KQzfa7mmP89oZeVU4Vs6Fq5jyM8zgUdiaPNGHBYzVpGYEwYughHTEvtUDQoDO6MEGTg=
X-Received: by 2002:a17:906:94ca:: with SMTP id d10mr3805902ejy.62.1606441669237;
 Thu, 26 Nov 2020 17:47:49 -0800 (PST)
MIME-Version: 1.0
References: <6349d22f-cf49-bab4-ad0f-a928e65622af@canonical.com>
In-Reply-To: <6349d22f-cf49-bab4-ad0f-a928e65622af@canonical.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Fri, 27 Nov 2020 09:47:37 +0800
Message-ID: <CAKF3qh11ZO75verB+SqefvCfPDPjee3f-1=GJZoR3CdkAtzH_g@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, knsathya@kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Sinan Kaya <okaya@kernel.org>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        chris.newcomer@canonical.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 2:47 AM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> Hi Kuppuswamy Sathyanarayanan (and all involved here), thanks for the
> patch! I'd like to ask what is the status of this patchset - I just
> "parachuted" in the issue, and by tracking the linux-pci ML, I found
> this V7 (and all previous versions since V2). Also, noticed that Jay's
> email might have gotten lost in translation (he's not CCed in latest
> versions of the patchset).
>
> I was able to find even another interesting thread that might be
> related, Ethan's patchset. So, if any of the developers can clarify the

Thank you for asking.

> current status of this patchset or if the functionality hereby proposed
> ended-up being implemented in another patch, I appreciate a lot.
>
> Thanks in advance! Below, some references to lore archives.
> Cheers,
>
>
> Guilherme
>
>
> References:
>
> This V7 link:
> https://lore.kernel.org/linux-pci/546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>
> V6:
> https://lore.kernel.org/linux-pci/546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com/#t
>
> V5:
> https://lore.kernel.org/linux-pci/162495c76c391de6e021919e2b69c5cd2dbbc22a.1602632140.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>
> V4:
> https://lore.kernel.org/linux-pci/5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>
> V3:
> https://lore.kernel.org/linux-pci/cbba08a5e9ca62778c8937f44eda2192a2045da7.1595617529.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>
> V2:
> https://lore.kernel.org/linux-pci/ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com/#t
>
> Ethan's related(?) patchset, V8 :
> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/#t

This patchset I think need more discussion and maintainer's (Bjorn's)
suggestion or advice.
You are welcome to try it and give me the feedback.

Thanks,
Ethan

>
