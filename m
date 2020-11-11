Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45E32AEC71
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgKKIx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 03:53:58 -0500
Received: from mout02.posteo.de ([185.67.36.66]:43753 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgKKIx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 03:53:58 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0541F2400FF
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 09:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1605084836; bh=cyRXEXqsJJVQFwh++7+ClOEJKVCiYZJ1Uf3vhIKvCfE=;
        h=To:Cc:From:Subject:Date:From;
        b=YAdZOQTyCiYcWj444nOShpj21WuIHzG//dIOPvZUOcTwtldKzhvx/YY7PnJmgMZ8B
         aVcgo6X1HKMiqb3J/4qO0doLsAkv7pwO3RfBMWHE29VENwndqMRahLCovfIB2jXrYb
         i17BT/xopB3NItoIbaIvSUjFcFsIAZiU1JH386H28BDmD+uvokznyE/13vwYJPNALG
         GYB/e4VKa6vt7p7sK09OWLXxieyq9yv0LmgWN1w/t1ewMughp7DG5wk/IKLQwlY1rW
         nko7zxm7i2oaq7h2F2GABJFC3tTX4JN0OCTmfHgwM/28GOLR1WkAWNdA3lNKTd5e6s
         F6HBKybWL/pgA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CWJS04gnLz6tmL;
        Wed, 11 Nov 2020 09:53:52 +0100 (CET)
To:     Kalle Valo <kvalo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>, ath11k@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Stefani Seibold <stefani@seibold.net>
References: <20201103160838.GA246433@bjorn-Precision-5520>
 <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
 <87mtzxkus5.fsf@nanos.tec.linutronix.de> <87wnz0hr9k.fsf@codeaurora.org>
 <87ft5hehlb.fsf@codeaurora.org>
From:   Thomas Krause <thomaskrause@posteo.de>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
Message-ID: <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
Date:   Wed, 11 Nov 2020 09:53:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <87ft5hehlb.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Am 10.11.20 um 09:33 schrieb Kalle Valo:
>
>> I was told that on Dell XPS 15 (with a working QCA6390 setup) there's =
a
>> separate "Virtualisation" setting in BIOS. See if you have that and tr=
y
>> enabling it.
> I was informed about another setting to test: try disabling "Enable
> Secure Boot" in the BIOS. I don't know yet why it would help, but that'=
s
> what few people have recommended.
>
> Please let me know how it goes.
>
I have two options under "Virtualization" in the BIOS: "Enable Intel=20
Virtualization Technology (VT)" and "VT for Direct I/O". Both were=20
enabled. Secure boot was also turned off. BIOS version is also at the=20
most current version 1.1.1. Because of the dmesg errors Thomas Gleixner=20
mentioned, I assume it would be best to contact Dell directly (even if=20
I'm not sure if and how fast they will respond). If the driver would=20
manage to work with only 1 vector, I assume this would also make it work =

on my configuration, even with possible performance hits.

Best,

Thomas


