Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1502AEDF5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 10:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKKJjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 04:39:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgKKJjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 04:39:24 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605087562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mad9oc1GQI68WciDhCRof8Ar/lJJ2rRBYu2A7e49Ucc=;
        b=PpVJMcUCnXoqsDlnJMzPb0ayF+sv3nvDTCQjyh0XEGntFJSPkQxKe69jD/3s089Nd9D3Bs
        P19Xk9dUKgq4pPO08cJTmJJHTVx1+plynkN6tVZSOZVWiIaoHxylCIKkp9ncCRrej1hHvL
        UvnByjJZk+n7ZD9T7uu9GcExFsFSOvhk/iufbRluMtuIX/ZHausU9ae1b++qu/y5J7Um3s
        UKd8XVwpLRss9HXNsF1LfY2hylwJ/TbTJidGqbPWi5i/4ol6RNgzfsej3ZDDhbfR6EW+qg
        RwelcEXHSWgiJu4T/nbgHiiGhCuawtHUkTy8IhZYvdO3c7/+mMeNooaIMTNxPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605087562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mad9oc1GQI68WciDhCRof8Ar/lJJ2rRBYu2A7e49Ucc=;
        b=w8m2NrwjkqajMLTUEXUUJCivLTF8vuJeGXK11KaE6I0E62lo4Vu5uYkAAEecuBKyCzYj4D
        8Tq211pizW9i/dBg==
To:     Thomas Krause <thomaskrause@posteo.de>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>, ath11k@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Stefani Seibold <stefani@seibold.net>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
In-Reply-To: <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de> <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de> <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org> <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
Date:   Wed, 11 Nov 2020 10:39:22 +0100
Message-ID: <87r1p0fd11.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11 2020 at 09:53, Thomas Krause wrote:
> Am 10.11.20 um 09:33 schrieb Kalle Valo:
>>> I was told that on Dell XPS 15 (with a working QCA6390 setup) there's a
>>> separate "Virtualisation" setting in BIOS. See if you have that and try
>>> enabling it.
>> I was informed about another setting to test: try disabling "Enable
>> Secure Boot" in the BIOS. I don't know yet why it would help, but that's
>> what few people have recommended.
>>
>> Please let me know how it goes.
>>
> I have two options under "Virtualization" in the BIOS: "Enable Intel 
> Virtualization Technology (VT)" and "VT for Direct I/O". Both were

VT for Direct I/O enables the IOMMU and the interrupt remapping unit,
but the kernel can't use it because the ACPI tables are busted.

> enabled. Secure boot was also turned off. BIOS version is also at the 
> most current version 1.1.1. Because of the dmesg errors Thomas Gleixner 
> mentioned, I assume it would be best to contact Dell directly (even if 
> I'm not sure if and how fast they will respond). If the driver would

Good luck.

Thanks,

        tglx
