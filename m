Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1D2857BC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 06:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJGE0a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 7 Oct 2020 00:26:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37459 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGE03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 00:26:29 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQ123-0006gr-Bv
        for linux-pci@vger.kernel.org; Wed, 07 Oct 2020 04:26:27 +0000
Received: by mail-pj1-f72.google.com with SMTP id co16so463670pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2020 21:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YU+/Mqip9pi1qh2oya/xIiVLyxr5PfFOK/MqVxHmKUg=;
        b=ZzKvsM+FCbB+DifUrHUHitYs7XvYUs8N1UserMhoDvg7jPQv4soOE+2q4w5xKUAQTV
         vR9s+HZgi0RVHNXjDYtPl43u56pFsgB8N4h7Y95ypqhRIQKdEsoSVQcKHt+4hJ/wfwRQ
         XjA2jO5SFCo4G+47P0y6sjp/yzlwl/gM2yUrAHkJNgW6T4+HpPE/FiTU2q5ShEovnhAJ
         3A0JxlVrzkTFqSKnIXOvxyZBaQw8In6B6GSYqj8uKoHQ/NfQe0dc7Q0+QFAG99lt3k2H
         7vEJjrBlhizBYJv/9ptvgESQULVPoXI85Fu2teHy00pntjdx4vxOr7DiehFFHvm2xerr
         VFow==
X-Gm-Message-State: AOAM530xj5khNRgY91uJQgDCWCnAd8BjRXt+TBiEGwuY0Rhy7hDVR0J/
        fHbUxb2LZBgxVRrq/ZclgHV2sdPmfznKCsMxtzm+zz8/yuB+bVedPmYTMSAgqrz+pGD40rXDaUL
        YgkkggzDVmnyZxOK/4s1cxlXBp7LuE1d+RHG1Dw==
X-Received: by 2002:a62:f201:0:b029:152:7980:368d with SMTP id m1-20020a62f2010000b02901527980368dmr1234658pfh.45.1602044785982;
        Tue, 06 Oct 2020 21:26:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwg+w7hGRUv2pDliCAKFtsK/PrzYI/rQRAOy1yzxXNgOARDbQRlGS5EE2ddqKGDVZdwaozYQ==
X-Received: by 2002:a62:f201:0:b029:152:7980:368d with SMTP id m1-20020a62f2010000b02901527980368dmr1234635pfh.45.1602044785589;
        Tue, 06 Oct 2020 21:26:25 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id v129sm944314pfc.76.2020.10.06.21.26.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 21:26:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201005191930.GA3031652@bjorn-Precision-5520>
Date:   Wed, 7 Oct 2020 12:26:19 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Kumlien <ian.kumlien@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <902912C5-FEE0-488A-8017-9A59B0398BD1@canonical.com>
References: <20201005191930.GA3031652@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Oct 6, 2020, at 03:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> [+cc Ian, who's also working on an ASPM issue]
> 
> On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
>>> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
>>>> BIOS may not be able to program ASPM for links behind VMD, prevent Intel
>>>> SoC from entering deeper power saving state.
>>> 
>>> It's not a question of BIOS not being *able* to configure ASPM.  I
>>> think BIOS could do it, at least in principle, if it had a driver for
>>> VMD.  Actually, it probably *does* include some sort of VMD code
>>> because it sounds like BIOS can assign some Root Ports to appear
>>> either as regular Root Ports or behind the VMD.
>>> 
>>> Since this issue is directly related to the unusual VMD topology, I
>>> think it would be worth a quick recap here.  Maybe something like:
>>> 
>>> VMD is a Root Complex Integrated Endpoint that acts as a host bridge
>>> to a secondary PCIe domain.  BIOS can reassign one or more Root
>>> Ports to appear within a VMD domain instead of the primary domain.
>>> 
>>> However, BIOS may not enable ASPM for the hierarchies behind a VMD,
>>> ...
>>> 
>>> (This is based on the commit log from 185a383ada2e ("x86/PCI: Add
>>> driver for Intel Volume Management Device (VMD)")).
>> 
>> Ok, will just copy the portion as-is if there's patch v2 :)
>> 
>>> But we still have the problem that CONFIG_PCIEASPM_DEFAULT=y means
>>> "use the BIOS defaults", and this patch would make it so we use the
>>> BIOS defaults *except* for things behind VMD.
>>> 
>>> - Why should VMD be a special case?
>> 
>> Because BIOS doesn't handle ASPM for it so it's up to software to do
>> the job.  In the meantime we want other devices still use the BIOS
>> defaults to not introduce any regression.
>> 
>>> - How would we document such a special case?
>> 
>> I wonder whether other devices that add PCIe domain have the same
>> behavior?  Maybe it's not a special case at all...
> 
> What other devices are these?

Controllers which add PCIe domain.

> 
>> I understand the end goal is to keep consistency for the entire ASPM
>> logic. However I can't think of any possible solution right now.
>> 
>>> - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
>>>   SoC power state problem?
>> 
>> Yes.
>> 
>>> - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?
>> 
>> This will break many systems, at least for the 1st Gen Ryzen
>> desktops and laptops.
>> 
>> All PCIe ASPM are not enabled by BIOS, and those systems immediately
>> freeze once ASPM is enabled.
> 
> That indicates a defect in the Linux ASPM code.  We should fix that.
> It should be safe to use CONFIG_PCIEASPM_POWERSAVE=y on every system.

On those systems ASPM are also not enabled on Windows. So I think ASPM are disabled for a reason.

> 
> Are there bug reports for these? The info we would need to start with
> includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=y).
> If a console log with CONFIG_PCIEASPM_POWERSAVE=y is available, that
> might be interesting, too.  We'll likely need to add some
> instrumentation and do some experimentation, but in principle, this
> should be fixable.

Doing this is asking users to use hardware settings that ODM/OEM never tested, and I think the risk is really high.

Kai-Heng

> 
> Bjorn

