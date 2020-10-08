Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EA286D87
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 06:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgJHETp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 8 Oct 2020 00:19:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42356 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgJHETo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 00:19:44 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kQNP3-0003qD-QU
        for linux-pci@vger.kernel.org; Thu, 08 Oct 2020 04:19:42 +0000
Received: by mail-pf1-f198.google.com with SMTP id r128so2859151pfr.8
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 21:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VuWj2i6KcL2jy+KmnP+wwsOTUedW69kz5MxpZCeQ3As=;
        b=fnGCSO2EYuxTs0W3aHKMwd+YvyISKavI3iWejNYL7PotbpqEYSQM4ws5b2To/gqa0L
         J8ca9r1/fQq/no/g8RjTp6TVl/q11huSF20InPtBsTzkbMimBC+rT7jWKN2XUIhw53Y9
         WtVRI5fHL55c1ESDZTL5akHZdWeY4FeKxMIwFnl4p60g9IX218Cy1BVzb6S9izLWHFMj
         nrQXIZGOpsuttyGd3PaPPXMinECHu6G/vN/Sjvb2oA4kqZ45ReiCU1fO0G40bDGrOLDR
         Aa7wlwFoE/YAx1oVKnWKc9ktLVVB6UvB7MuZEQ+W8/lqUy+TZeKjTLl/xMzst8AdkTlm
         SByw==
X-Gm-Message-State: AOAM531stAfhCW7fJpImarPWMKvetAML0caWHpw1DiBN2RO8sDRrImkh
        36ez9sPidhyQfuY5nBKbU6y6aUMIzTD4Iv4WJz33TaiQRVCjJl8wJhq+JJP+3W+rZYiRcXrv/zf
        8JMkmHtwx7Vy8cYoqxikyJvfzvvz2ywPJVQX6cA==
X-Received: by 2002:a17:90a:67cb:: with SMTP id g11mr6156727pjm.56.1602130780162;
        Wed, 07 Oct 2020 21:19:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm49SJyKEIaZaA0/A/HiuoE0d3igXpZ46QjFDuhCIpUL3xFEVMAQCQII9OHBbRxVym+wDVWg==
X-Received: by 2002:a17:90a:67cb:: with SMTP id g11mr6156701pjm.56.1602130779714;
        Wed, 07 Oct 2020 21:19:39 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id d1sm4479846pjk.38.2020.10.07.21.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 21:19:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201007133002.GA3236436@bjorn-Precision-5520>
Date:   Thu, 8 Oct 2020 12:19:35 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Kumlien <ian.kumlien@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2C086FFC-28F5-42BB-933E-0C1C4FDC738B@canonical.com>
References: <20201007133002.GA3236436@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Oct 7, 2020, at 21:30, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Wed, Oct 07, 2020 at 12:26:19PM +0800, Kai-Heng Feng wrote:
>>> On Oct 6, 2020, at 03:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
>>>>> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
> 
> ...
>>>> I wonder whether other devices that add PCIe domain have the same
>>>> behavior?  Maybe it's not a special case at all...
>>> 
>>> What other devices are these?
>> 
>> Controllers which add PCIe domain.
> 
> I was looking for specific examples, not just a restatement of what
> you said before.  I'm just curious because there are a lot of
> controllers I'm not familiar with, and I can't think of an example.
> 
>>>> I understand the end goal is to keep consistency for the entire ASPM
>>>> logic. However I can't think of any possible solution right now.
>>>> 
>>>>> - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
>>>>>  SoC power state problem?
>>>> 
>>>> Yes.
>>>> 
>>>>> - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?
>>>> 
>>>> This will break many systems, at least for the 1st Gen Ryzen
>>>> desktops and laptops.
>>>> 
>>>> All PCIe ASPM are not enabled by BIOS, and those systems immediately
>>>> freeze once ASPM is enabled.
>>> 
>>> That indicates a defect in the Linux ASPM code.  We should fix that.
>>> It should be safe to use CONFIG_PCIEASPM_POWERSAVE=y on every system.
>> 
>> On those systems ASPM are also not enabled on Windows. So I think
>> ASPM are disabled for a reason.
> 
> If the platform knows ASPM needs to be disabled, it should be using
> ACPI_FADT_NO_ASPM or _OSC to prevent the OS from using it.  And if
> CONFIG_PCIEASPM_POWERSAVE=y means Linux enables ASPM when it
> shouldn't, that's a Linux bug that we need to fix.

Yes that's a bug which fixed by Ian's new patch.

> 
>>> Are there bug reports for these? The info we would need to start with
>>> includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=y).
>>> If a console log with CONFIG_PCIEASPM_POWERSAVE=y is available, that
>>> might be interesting, too.  We'll likely need to add some
>>> instrumentation and do some experimentation, but in principle, this
>>> should be fixable.
>> 
>> Doing this is asking users to use hardware settings that ODM/OEM
>> never tested, and I think the risk is really high.
> 
> What?  That's not what I said at all.  I'm asking for information
> about these hangs so we can fix them.  I'm not suggesting that you
> should switch to CONFIG_PCIEASPM_POWERSAVE=y for the distro.

Ah, I thought your suggestion is switching to CONFIG_PCIEASPM_POWERSAVE=y, because I sense you want to use that to cover the VMD ASPM this patch tries to solve.

Do we have a conclusion how to enable VMD ASPM with CONFIG_PCIEASPM_DEFAULT=y?

> 
> Let's back up.  You said:
> 
>  CONFIG_PCIEASPM_POWERSAVE=y ... will break many systems, at least
>  for the 1st Gen Ryzen desktops and laptops.
> 
>  All PCIe ASPM are not enabled by BIOS, and those systems immediately
>  freeze once ASPM is enabled.
> 
> These system hangs might be caused by (1) some hardware issue that
> causes a hang when ASPM is enabled even if it is configured correctly
> or (2) Linux configuring ASPM incorrectly.

It's (2) here.

> 
> For case (1), the platform should be using ACPI_FADT_NO_ASPM or _OSC
> to prevent the OS from enabling ASPM.  Linux should pay attention to
> that even when CONFIG_PCIEASPM_POWERSAVE=y.
> 
> If the platform *should* use these mechanisms but doesn't, the
> solution is a quirk, not the folklore that "we can't use
> CONFIG_PCIEASPM_POWERSAVE=y because it breaks some systems."

The platform in question doesn't prevent OS from enabling ASPM.

> 
> For case (2), we should fix Linux so it configures ASPM correctly.
> 
> We cannot use the build-time CONFIG_PCIEASPM settings to avoid these
> hangs.  We need to fix the Linux run-time code so the system operates
> correctly no matter what CONFIG_PCIEASPM setting is used.
> 
> We have sysfs knobs to control ASPM (see 72ea91afbfb0 ("PCI/ASPM: Add
> sysfs attributes for controlling ASPM link states")).  They can do the
> same thing at run-time as CONFIG_PCIEASPM_POWERSAVE=y does at
> build-time.  If those knobs cause hangs on 1st Gen Ryzen systems, we
> need to fix that.

Ian's patch solves the issue, at least for the systems I have.

Kai-Heng

> 
> Bjorn

