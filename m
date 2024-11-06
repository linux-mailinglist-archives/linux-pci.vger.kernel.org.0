Return-Path: <linux-pci+bounces-16151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C29BF33D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256C0283AE3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88918C006;
	Wed,  6 Nov 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RaZGVFe5"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic314-13.consmr.mail.bf2.yahoo.com (sonic314-13.consmr.mail.bf2.yahoo.com [74.6.132.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C413C67C
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910618; cv=none; b=dE8GWglKz0/KRGZ17U1j01Jz3kb2rF60XyikpPaJhCMCEWGXcQapUB91ziy/FUSzCYoBxRxoz/n/6DJAxWY7KuK0GJwFXVxNOPiTswYzc8HtNjR7p4eO23QZViTfemVfbO7NoXVYSqez0ubOVTS41K6OEFrMGqGJOSt/YgLJVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910618; c=relaxed/simple;
	bh=fvAFf0JaFeBYm+F2wvaYY1CZI8BimVIWOliOUZ1LMAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/nD72WI+Cn/biHvyvqXeKKrONnoWAMK8DkG5yx3FlLv2eKtfDftkDhS4+4pJDtxu7YZCX4XuB5XEmJy4gNRnklbaY1uq2N0n2wrNICHmG9VymlU/6znVei7fMbcI8OitGoh9WvllVI1dicN25CMMCMm7Zf6HZaNFWQ0D1kYWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RaZGVFe5; arc=none smtp.client-ip=74.6.132.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730910609; bh=W0ieKc3ap2ATG+t73oWiPacelFjiXkyZM757F906zV8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RaZGVFe5QGta3h9qs80DqR42kbDiabkMl9CRH+h/WChFQkOZAT0iTrc/7cT6UPAEc/ef+OcKtJmbuYc6rxL+4q4GxnujHLhWgT6vi2Y/AhzF2UZOnMqcey6aDemb7WxVsn75Y4eLTcM497E/gjBb1EjhfMFLqxBzEdz8v0ySlmxAsP3kkuhtPdt1eEJdsWI6ApxsvJinNqgOjyV2PzDT39uLWmprrV8dl0ky8iSU7TGGJEcm6FMJJ1kLkO6J2R3vWMC70f0UIm+qTIvEtuNeAhxShoVJIPeNHb+6wTqATgca4UIvQ/ZkXlU+jQ5ogmp8iiLsXEndvOn5p/MVH9QZBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730910609; bh=xIm/gVHdVbXUTMEEmq4fgNqo6t3oO7kM3lhDfrfrOKn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Y1dQyNEJ5I4/1MFx8hKWteZCpLA6dGdPF0K5SAs1RoGsWcPll++kzkEuAF5GzQFDj8jnGWWDjhByNTEpKPp9PQf2mtdMB2/2+NKE730TRGBz4GnimpJQ4dW+LN1ded5rnQ8haNzcNvJjQT8M2W3CuUC+pT325rt2sQlQr3veXxXVe/GrqRTimw5nnVNEb9xWEKJoYLcAf9Tzpv8L1beHsRLmIGcI3IxKTsEezB5DOJjQff96x7m+Z8HXZ6sTsAYEp6NWEXcH0PxlqP/icW1VK9zGOcwvfa3y2JyqiaCgNVSih9scls8fHSkkAxeSJI9HbpXd2h6o7Hn4dKXBC14j8w==
X-YMail-OSG: Itp9kHgVM1mb1p7LBBg2BiXephJb3Ielz00JP7e28KGT05Kw.7.hRs6rEqV26Hq
 L3vssA6zBOOcHeAicnDpij40x3Uned20II46HK_mmbROrW2sgjnKtQjX9mxMOIEXfgOZNxXu5JoI
 JJsmuVnqORUUp465NbzIgTmS0P78De7YgJLM8MOh49HZ0ZhWx.kNjgUbkRLMBnblhfEAHtQJGRGl
 k4Q7YjuN.0Sw88eMMXNcXG70XGw53D.ctV42bDC6_bi5U8RAZRBiLWSlrCuiDGcCbIaxLtZ4gA.7
 llRQdKlij70oOUdOTem1YYC6.iubp.6uSmwhxHavxPXSGtnlYmb7CoDd_lWC7O9ulYI3l1b8170m
 Et8S8WNymmeA9_8aSv5MFVUdAWo9jMztPlf89Een6o_YscuwtiObSMeNIZZG.FscoMe_Jsxd6Rkh
 55QT6nLIgkDRKhgb76wLwpX29hGyNojlfFBIAyQavEw3xgMq0L6p7EpflsAtP14CECDZ0fiprxGo
 hKLEIPL51aJKEy0i6zXQXboWLBRkqzyV0s.dFLXld4CI8hxysVxB7myK6TDpoEjTrPaDCgz5NkwH
 8z2SuxW2kDDm9f_ZFvMAXrj893YvoXQlay9NxfFuVhUgGYibE8icLJPigqM0SGLA70mg2aPrBtsw
 .QiPBdIMdavndblI6aLZvkdqQHNPnZqWTfJba8KCEPeiCpOZADH6C5JGyg6EByDE3W9_KIwSMPg0
 DaxAZ0fSn4pDSasgqAce3nMPMfeBVAmKBJJWCwM.XoRRiS0JzhDxl9m4SH332Hk8aleGJe.IE8Be
 _nMsw_Ttmhzyho8IPPOmQSdK8EdfGxamepHAA95rovcjoGMn1Jy08ljjTIoYugWIvBLhTDVin2Eh
 fiAcj0uRrSkp2.CoIB6GsQUogCj1qpwKamf0a3XhK1uHGM5msH1I8xchOElubos1iSfp.eNycOTs
 EL8nxn7rwxou0ft_chooUAhmtQX.aC8c5CV5FsvU1OkP9eiJQv6aCvfX9tvAnTZ5rVlqnCQcDSWy
 iSIKZ4VFhlMfz_U0fcZgLjG3.BB1huYkxpm3AcfP8xfuMHxCYyu9iwI.xGQKCVbEeM7TE6yPJsHy
 F3D7VfqdiESlDe9Q98vNYzRHcCNhIuXCB5uBQvHmC3E9HRtUd0bOjQYq3NR5RWQQfSe5ZpOxpKR5
 WUe0j4WT01X3BZwtnUOdlxL16p619iPB7No.mC7FGJJNii8lwcUTlYXF1wOna7yOqgGomR1JbNwv
 oSRUGbaG_jDDsXbdwn2DR9X7d1vpWs1.OE6V95_DOu.SyD8rqG20mbJ59EtKOq.QCpKFCcVEIU.B
 ti3GaZ.YxqFQVym52Y9_hQd4Gu4XM_EtCl8sCQLUKfEO_.waGTYKHk_1SutQrksXquAuflquVrUZ
 AGgLLjqDv5aSQsMtELkPmKFETm1YWuBmqktilY4jwOfMF82bHZwaIxUNh4S8HdJlZVT65E_v4D23
 izxFxagQyPR95zZXAZs8toVfFb0gD5rU.JOYivWuxTGYkpqL_w2_7VUsz0JnsrZG5fREvb9QNeOV
 oOad9CEWNfZ_Rq4jcwv_3ENYj4oxFnau7wDZ3dECZPnGoo3GTVMaQm35h2h3ICIRBTeorlZ6K176
 fnn4pKiYD7EBGLNngkFE.4JVJF.g.pMPpxHgHvYeZfJoe3DWPtuEal2uDWple6ztCKq0zciMOuzX
 9xYTqozvI9yb5M9prbRtRaggntygIul5_jVLqv9x63UjOkikXsNHJvc591CIjTaDMJMdhMN111ey
 fBcaNaDDUqyDD6la5yIcDdLYehCH5BbmCVLek0jw21sEcSaaSfgUiRJsBp58aUuB4uRmdjpPYo4s
 IS8FsQHoUVCJIhNjFpbCb5HRGdY3baMOK0VYF98c8ALjhrZqEpBAPjHczBLJ1M.ZYLtBheq_L7Ul
 Et2LL8SEuItwXW0XTbM9b6r2ViW77pkA4CSdK0vKCie0OApbF1_qF6RbxS3zKiLeGd6dd3K.6V5g
 YaPg8NkJdeK_2H._GVf53BsaWzDfFXh6Rr3MRbPxKKdEfhFMJPhFUFqKupCtdVYP1HRVg9uZ0YlQ
 JxmxvXprBK4uGfzo_pffDZFm__j3.XYGaViZZ7Q8q1Ge1PmGR4L2wenbTEfmwocUse4sYTUU0DLJ
 W2AHLIkuiDKkAIhmHN1z3xZsMhMX4jG5aUI2i7N_qrKW9rww2UjCv3LkZQVdsJ4XAGiTEpc467xw
 SFhQr4ZYir_N2R_4GWlWTldhL5eRTM.Z187WeWpOoWX_UDqkC30n14jDyBiZ3
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: b8509b16-6bc8-4ea9-8dc9-b2f922c1dad1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 6 Nov 2024 16:30:09 +0000
Received: by hermes--production-ne1-bfc75c9cd-rq64s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9ac2812bfb1d027bbae0833a8fb18759;
          Wed, 06 Nov 2024 16:19:58 +0000 (UTC)
Message-ID: <973e2e20-51d9-4fe4-a361-0e07bcf95bab@yahoo.com>
Date: Wed, 6 Nov 2024 10:04:40 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic with niu module
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20241104234412.GA1446170@bhelgaas> <87fro4pe6i.ffs@tglx>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <87fro4pe6i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

> 7d5ec3d36123 had the mask_all() invocation _before_ setting up the the
> entries and reading back the descriptors. So that commit cannot break
> the niu device when your problem analysis is correct.

In 7d5ec3d36123 (and later) msix_mask_all() only writes to
PCI_MSIX_ENTRY_VECTOR_CTRL. I have tried all the MSIX registers, and only 
writes to PCI_MSIX_ENTRY_DATA were able to prevent a fatal trap on a read.
However the only write to PCI_MSIX_ENTRY_DATA I see is in
__pci_write_msi_msg() for 7d5ec3d36123, or pci_write_msg_msix(), in 6.11.5.

> 83dbf898a2d4 moved the mask_all() invocation after setting up MSI-X into
> the success path to handle a bonkers Marvell NVME device. That then
> matches your problem desription as the read proceeds the write.
>
> I've never heard of a similiar problem, so I'm pretty sure that's truly
> niu specific.
>
> Thanks,
>
>         tglx


Regards,
Jonathan Currier

