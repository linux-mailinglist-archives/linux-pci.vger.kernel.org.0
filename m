Return-Path: <linux-pci+bounces-20142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A891A16C9A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1083A689E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0E1DFE29;
	Mon, 20 Jan 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aU4fQmq7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic307-1.consmr.mail.bf2.yahoo.com (sonic307-1.consmr.mail.bf2.yahoo.com [74.6.134.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040B1DFE16
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377816; cv=none; b=Q5MxeArK5nXsEuwsmM90dNuLMJoHImynF4jhsvhutKtPJJ0WQVoo36fEUAoc3ecQefELT4Xry2ONAC/tBc9ao5DJ8a+2A+g1u9njW7QReZtTziE0qHYtha7RHgtqj4eTICrQseyQWtcFd2AQuhvRJ+jvwoi2COBdxbkYI6uwXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377816; c=relaxed/simple;
	bh=awoA4f9sL5W63XhDxfMWAOf9cG6/2ina8dOwCzpXbXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzES0+HrpdyoRW48H/22BKiN8crz6pEGZc4Q6DsTZRdbZSHLDAKuErIic4WWwuIfB9pbXTCrXJhWNQsNI3DhrsduBf3L9ICw7s7ASJntqNLtO6sj8lMAzSS7A8/RRBspAmiDKSPHrwCwySHFwqyNfDqbmrf2m5w+1WxBxjc69cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aU4fQmq7; arc=none smtp.client-ip=74.6.134.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737377808; bh=fQYkZCImzzOwlRwH2mZG/bc5/vHITdYcTTfQQ26okDU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aU4fQmq7eGK9Xu2UlQ5RHwmYWgMWqnD5rNVZWr2p3YzFIGnaw5imtyET6iIoNdGQAiWJ1nNA8zvbQx2Ij6yGPBaaiDpOzNrPQv9onSmBiqHKP18lETO6h5MId8pjZj55RduWAWXOYwk7mZpEVEU4Ub5/gC8juULRjW82zmuVZQex2n5O1qXNPVSDoV/6RawCI3Gj3tw5TKwA7bjezIGOs1ru+/mTcY+1npkvcgrTNoyuRj2bOVHLRNviEMZLGgz+4swsoQh63u4cRyZH+lS1vElhe0cmQSE+HD9U8zukb6KeBy+7S3clzXdzj1/pOP3ifUCW2cdHNqUD+aBl71kZwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737377808; bh=ZjQDT8hxV8LNQHPUbjURxRLBPiM93Or0brglODveL8Z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Wg8+xibHRoNtuJk8FXDS/ddgnWDPhYp4JWjRTia+tmbOJB6q+lmDrI8jkUa1ktV30+MhVLoDtWaG5PHkufkyTtXvqQc59ogHGPavrAH3Vf2UYXK5ADG1OXimglzCYk/q3wnmA2jTgumSC2yg61VMKx/bP9v6b1OsVw1facOVTS3lhqrbU6lyjILnKgkWOSLxjixjmFWlsVM3XvNYGQFVVqjTDdp8lIQmZ+G1V+R7XdDj4E/6ZwsqMLtl3qIriGgWzk0JIIwM+9uo9kgkiXSeZUDRRt5Zo+UrYVWymDXu7FHlbA2C2tJ3fDbSv33yhcabkG6rjDQFsMY0Q0Lsojbyyw==
X-YMail-OSG: 69vWWBoVM1liWpYkcOO4Cc8dWfv6BCtEjW5TeGi_O_nxoD2tZkrJ7HZWWVBU7Td
 DDIbwqCpXvAFXl8j5InDgVC.95zE23z1rTIim3PmoX.zpSNb1uRmK99x4Y7NwC20WXaEnqqaneHE
 JondmTQCeZ0AJP1LqsejZOPP0ViqrdyXZ3GZR96Kp2FaWnHHaRobTpMcMsPObTaPl8cZyLacOr2P
 fo2eYWMBwnjKbTKaoxf7amu09bk7VC9634RGWftXYIRhntS5LmIe_x50qMTzfML7ktZ0Tbx7_1nL
 yvh0jYhJhLTaeMlVyu_lK3C8a142TRirRZPb..TYHRvZ11fS2CKtu6f2f0HQEQUyvTqVuasXJLNT
 g298xaABbXQ_Bl4JwloXlwvtffS6Ta.sR7R4Y2W8Kw5jL5ZtzXabz32xZcoPs66anQLuhrThq.hA
 KOx6dpSP0e9AgxIpPH.Wiqph1OdAiCnHdEqOviZzt2ZpIvOHiv4R0lUhxerMkN8r_CJJG.jChaIL
 fg5Ph0Kefe7TP7wytxlM.swELmBnjnfxT0mGdaBrz57o9Z1CFHqcH7NqXRDEb6NclR1xgCzsN5rp
 ohLzxBn9OnRJtL0DTFZHr7IojC_PeODDsktCEZFP_Ub73jye3ySyl.L07JE0Zi3ahgmkMJwSDHtW
 XZi0Nu4.WZn41afkSIjr3U3d8xQ_TaqID__VWKCDiAZXcoyg2VGiLRjbiJsX09mMGCF2SeUhYsln
 gvxh5xbAWmaR3RW.MSYUobyeZ8oDa00MBasyAHkp7x0jOPNio2dI_viiHD3nXuzgdR0mdjH9a0XE
 0QwEBdYmEk24UqmFAYmgYdkMwAVTOVYQ0k9QPoGxBLePyPUaI8w1DXSKArUtR083JXxrrfOUFK7b
 4kzuUPDeyQ2u.IQsk8IHGzD6Iu9gdGVQEr6_wh4vpPdIIGh_fuyC92AKQoqJl0RSCGUwg6V9Fr6g
 .ScYqmcxEiBmCYSrG8xMa_Y3LGBeYvuAA72geqJQ.jHS0hwe2sH_CtH.uIct_72V7veIHXqKs9TX
 3Py6a14.RwILO2FJWX4PtnLxRggvYqsaAQAYrxP_q1az3S8Q6oY3jgSVIFSndR1W2iE3w9XvYfgh
 5yGdD1RZJMb6VGsWor1r_gUqNLzaIM3kOp6d6YQVv5c6TGBFoM2C2SNcqXTDRbmtIfJHooHdc1I3
 RQR88ZzkuFjyVpohIawdecaE0ZOdsTNKwwQedjgUngZUZTPar17u94omoLnSjn2bx9l7Wn5KmXe5
 vd38LcmXdDoFtWlYdSsk2X3GpoUJZMYtN5ac6s81LEeDhaAUBcq9yKNC7WA_VEwKxH9JimI9TdXR
 qPsXjYwgkWJIoh0OBRzXWpgSO2nAPLHW6bltAYgVD5ObalJoI494caDuTXc1Cqphy1ZM9W41mnXR
 ZdCpnUyeNTfj_Oag18lqz7CxP7v4Ahey4oE_pUfdtuFrdPnJJiga2RsgD4JJralTVVGl8zWrLOZB
 2PyA8Dczidx_4YPFEYoRH0DVsPvpPkVlIVqORCLpAA3NrbYvm.dTJoXafSAcV57jwNnyMOYMiimU
 g0mIAe_lJCuwFiSed3aoTwUL9SAoE99J0rOfCl13eF9CVv1NkKXP_4O6S_QrAqXeeLWMcMWQsXum
 2zfsfy7l15Z.8WvwlW_JlKk.LCkNKQ6WwbFculTlaP0CfzGTIOfEgU7HeOMqXPftWgoQiU4zcilY
 ajqhf5H5vWPPckRydbFZ0oKymtne8AkmX9TQ7eTMehPKYWcMZGOzm3mb9kk5tTnZybGBJBhPVxeT
 fF5aSk0mwdX_3XoVveS_29satTwFWg_Iuq4wK92jTJEsNp33EcjWlqOqYFy8Wnp4xLJ7fUNMicI0
 gs8eC1c5o6QFxpoJKaK.usrAZbrVGvi7rkUnqcL6yaTWqK6o7kdfG9Yk3fS2JE3UbvR2c3eqoGTO
 sf6lELZLQOiiLKaOngPlmokg8c0THfH_F14Coru8euLDeNKKarxaJKrQDxEB8s7x6aMVa4Vrrti5
 nhSzN0uUEMOhoNNoxXFQFXuWHTxFjUINvnJOyj0o7FbbUA91NGfMDz.GJWETCruWS36.MzPfIu.L
 wjw3jalqbJTnf6nYeqSht6sJiConcDZX9iDTZbOHAPhreUg2OB0LDpumhJfRByqntTgmxPG7F.SP
 CyRc_zrbFSHLpAWmtFWWi5qYQ2RtVcr6cLwEwQzgUIbr.DiNK7o65OKV.g2U_a0nApbdBX1U9a_Q
 EsBcZWecjxK.dJPwy_TET8X0omoMIoMugMUphcLejbCWZMPrPOcWejpI5vt40VqXZ
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: ef09f872-6111-460c-81c7-1702da353bc6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 20 Jan 2025 12:56:48 +0000
Received: by hermes--production-ne1-bfc75c9cd-scmkf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 288457ee09884436370c264f9119b1d1;
          Mon, 20 Jan 2025 12:56:46 +0000 (UTC)
Message-ID: <5a580609-aa5e-4153-b8dd-a6751af72685@yahoo.com>
Date: Mon, 20 Jan 2025 06:38:19 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
 <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 11/21/24 04:28, Paolo Abeni wrote:
> On 11/21/24 10:22, Dullfire wrote:
>> On 11/21/24 02:55, Paolo Abeni wrote:
>>> On 11/18/24 00:48, dullfire@yahoo.com wrote:
>>>> From: Jonathan Currier <dullfire@yahoo.com>
>>>>
>>>> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
>>>> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
>>>> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
>>>> chips, the niu module, will cause an error and/or fatal trap if any MSIX
>>>> table entry is read before the corresponding ENTRY_DATA field is written
>>>> to. This patch adds an optional early writel() in msix_prepare_msi_desc().
>>> Why the issue can't be addressed into the relevant device driver? It
>>> looks like an H/W bug, a driver specific fix looks IMHO more fitting.
>>
>> I considered this approach, and thus asked about it in the mailing lists here:
>> https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/
> 
> I forgot about such thread, thank you for the reminder. Since the more
> hackish code is IRQ specific, if Thomas is fine with that, I'll not oppose.
> 
>>> A cross subsystem series, like this one, gives some extra complication
>>> to maintainers.
> 
> The niu driver is not exactly under very active development, I guess the
> whole series could go via the IRQ subsystem, if Thomas agrees.
> 
> Cheers,
> 
> Paolo
> 

Thomas, does this work for you, or is there something else you would to see in this series?


Sincerely,
Jonathan Currier

