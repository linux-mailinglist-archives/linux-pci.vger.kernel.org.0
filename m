Return-Path: <linux-pci+bounces-17085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25209D2CD7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F381F2344B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787514A615;
	Tue, 19 Nov 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NX5dpf0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic302-3.consmr.mail.bf2.yahoo.com (sonic302-3.consmr.mail.bf2.yahoo.com [74.6.135.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D61D131B
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038200; cv=none; b=d57ELJ/NyuNC8GDi7on+3xDtKRDczhhbCBHWSdIBrR+wMMu5IvuHNQcIK6xKFst3GGel5HX2s0o6B1f9HtqEBF8i0M92n5gqE4M5EUaGuWVnajiJcHOkdqAYj0iPJlrWv80HzreQvh1raT19Ar0xDTQm0Hn7KDgWq2cBu9spkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038200; c=relaxed/simple;
	bh=pc6jAK/Qn1t68e2aPmO7D6eGGqmP3kBwuKcCJNgOvtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqDyJKIWjceeTZn9TKKk/1TE8JT0bARdtLJcvmYqsutqF1xoyVrTKw7BueiwKe8ztswDgW5v3HxymcX0Z1yUDntzvqo4TlHXcHo8he87AifmIzxnfO/kzXuSZ+tZUv+IU+Z5tXIZcR2qHlZIDaLoIAN4zTOENd96LZciWKUITLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NX5dpf0s; arc=none smtp.client-ip=74.6.135.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732038192; bh=WvceoVO9DYAyKd9mNnEFklY4ncAkWeMaTdEktOZe1as=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NX5dpf0s9vUZFE+iOZNHqk8K6Rh1QXWbirfodD2owkokBoRH4iT9BGIpLqvhbeSd/3ykevTaLOwfTEmbOF20kPpR2A/ci+xfIelJ0qX+GOocAZqSymQPGvz0IN9nz3jyhVqSpzjnyppab3FSLu5EI9/sZA52lsyjPy/20raFSKVXQfVo/JjBAqbD0SkhQxNiSt1TZIbO05hVtqPcprI+Y1u7iZYUkTmOzDsJyp79akL1g4wSau0KZ3e7zcrw6a9hMmJcb4f8dQJhbodb+YRCa/AxsrjcTuuNBFfiRxxb53GfPHqEzinCbS21K4tU00GHgqGi2aMSV6KNZBd/Lgne5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732038192; bh=Jl6V++YFTe2JcpiQbbVRcUXBSsyMMKFYc29yK7LIdaP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=keMZSIHG+Z78F3DvYUDWvotVUCDwh8yqt8GW3ZTC/Gjm52JbLgRZwzlLArRu1c4zZmDWhTiuzA3Yh5/YsfeBVYfQFb9ApKIavF3MnPmmsAQwFl4P/+BCeULCwQ7QlVaNhdxkPynBfihgb7MTOJc1AVRgCZW7Qga0pCvD0XkQRVa0h4qGTk6Zcn/eelOuNscisrWNDCEzb0fvbn8YeJ8gw0+liU+OWeIsfes7isC+eGY9L3dmM9VEPQ8tY34OTtYlzLyRi9zBmjcMY92VwVHM2onJMhauderglNmgB4++jhTUlYqmMpL0OKwfRDn/TLtdQ9r9asJQD2b4xCW5QccUhA==
X-YMail-OSG: UAsbR08VM1n27JAAqgk_Z5Y5.vsmsReb9LDx67fx5Z2iimuHWRCTXkTmDpECSZK
 W_ek28IsFOohgJSNVXxxqpyjf8.FoMLgXT_uQhjSTOOUuKGUPdgZC1fbWY5g3.SBeQyllcQ5jzMq
 7St_Bf8vSuRGqFbZiRbfnQLwfjZtvfrvdoVrj5RrHnwULl6IHrCFbpwC3LV9bbRjVJoxzy.n3eNX
 QBvlKVvQTIq_FpX.Xsqk.tPgTEN2JKPNxsRww2HRmVGDBEFCLbanJgG63IWUjp7HJ0t9uX2S2jVP
 0e06eKogCC5WXqtbJ5kTM.J6k32XMO9scMcBP7ixaNLrXxMq5w7HkpOWzWF0lAjClwQZxAh6oLbn
 GVC1vtOqPqu1HfltpWdpzPHhXCN9Uqc6TneeZWdPglUJmtZGkZqTIEflawhBkQBxlfGKr5pHJ566
 AU3Oera_MNR3TzgCAbSnp2Ql2mk1ZCw2ympOMvdwU7rDf6O97ww6xmiUE4dtYRNBikyWjzj3kLIW
 nvtB8yyggzAGoMnK_hqifwALSFhAvntv4H.I3W3aVYQGfBGwCM.AY3mvL58mQBtg0UnE7uGKaFMU
 euqz9xi_vi1ioXlgJS98mkLl5QSR8DpD1QSlfsrksmwn31UJmVwGwyBMlZ_Ng_kqrl6a8AwUnMth
 aWIozRItJaRhU48rHrcKB64P2sk5kBEb5BX1GwWf2PimiKVOlOnrWJ4L6ZrF_Y.ZLivuJItqSqPU
 igeqwUKL1U_owuft7y_zG0O.WsaGSXKd7Ci2T079xrJZFxww7cGiSdovBi_n5Pg4vK0hu0GsseZz
 BUqsM82BvUdwdo4vFBU6z4pe_3Wqp12WbTOV03fmciBB8.GfFTazp3J..EAhbEEcw4ouIJjkLuQx
 21ap44tAXKCPDfawyw9sRUVuEp2uutJIH_3gj3P3XS1gtO_Oq0gr_ZEoWITwDEY.SaufYqkquirs
 XD6AiLxQowKx6Wxa7HA7bjVRgSlT5YnDdOdrTtCwtQC77cagwXTBMjikUvJqdaQ9bUk.dUYE3Aaf
 HWII4jov3ZzQQ7TPoeVm5i01LOs8c6Q37OF71hUUHpTGnpu6hASthgjBc59R.LqDoM_uQVRnH749
 CWh5iOoxVEB9nIehh7QXtgqD2RquneUZPCnTDavTun6fvJEVbCxp9eT22uR6NAm7y5l51T4nPOag
 oguB9RkHnTnyFVxAPaKF63eZNRMljYcr9J9yyKmEUeLDxx.KvdXOBrDWpxlaU1lVHLfZ6lSNnO1S
 ecrq2iG.T46BpdeFfrzs0RvTtP5UPvmFUrwUVXGrH6vyUzUJfOG1sJSkUsY939f4M_CRLZjlGHPd
 6wXx7lnQZWTsjTPZ5vYCBFzB10SwS765mdg6pU5byKivDH9fnrVsDnudGkjbZRBIbHX1P48_o69Y
 pM1ix0M0eFiyQplSK06yW71JzocVLd1TTNfjjPffYU.6JBj6Kwr5Xa06ujUAPm3t7SY2cOfLEJwj
 fnmls1gZQivjeoo7vE.G215gUnCDcfdnO7dY4CL.g5bHgXgjVpvbzTxHbtMq.0c6vBAKyqv4PfWh
 8QixEa.SSYT2rjj7oAKDMQsWejwnFz9DqceKzjHINNK5DVAtdFdzWvIaiyzUFUQsKk3OnyS9Fn89
 vzQQzVa2_N5IddMbYuQDRP99Ch9WsVtftZmyhNjNRcuSQ67QwsKduRA110Ldags1GoV7TJc7wZ4M
 o3W3Bn4SbjyWxpFvnRkchyxglrgDtPl8BtFa5_vcVj4bis4__04uqewFq9sFBiK1lA9WrcCuyNXo
 E8STgDiqdR0xstHEvl1EamS5q0ONGIa9CdokVRYUzo1_5k1rSnFCCJu5XLsPsutQtZiz7rT8lLga
 iB1Q_C41FdwRcSgdEHO5Hg7GWeL9Nng.QxlU1IFvcAXmi8m2Fkd73POFGac9PQ9o08kWpHeMrq1O
 Vj2aYY3D8RR8JwfEy02ZXX6YY_vUpBHBnCtj405E7j4Mep4fwCvVWoXmrYqGWMgAqSSd7NsT_vZd
 k6nLm7PkSAJNiZcsEEpWA2UstYAQZH_UsWLn6y7Wd3kDcfNbSIPBSPJUk_efbi2DlsiTOmzHHHFG
 dPbTLveqme4oO1W27O.eiWhhziVjnlZOzKNiXPEiVM7A93ex9zrJY79Y3ccrS.sQNWS.9rKqqXKd
 qc5pobIWKXNIqB9L4MdVcv.cOkuw66xxsjk60SKR6uK6tmuCiSIEi3aIUOa.Slv5SuqRqefPooWP
 diQJqnTr3r0ON311cxR1mBAE.MkpxMhCWyN2FScVJzc.PpcpCuLw-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 7bad037c-06d8-44ab-b298-8495bec16968
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Tue, 19 Nov 2024 17:43:12 +0000
Received: by hermes--production-ne1-bfc75c9cd-4757t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f54d83f8bfa11db1667492a71bc94421;
          Tue, 19 Nov 2024 17:12:44 +0000 (UTC)
Message-ID: <52410459-d15b-4e18-a978-0c069f9cd292@yahoo.com>
Date: Tue, 19 Nov 2024 10:57:26 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219513] New: PCIe drivers do not bind
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <bug-219513-41252@https.bugzilla.kernel.org/>
 <20241119140434.GA2260828@bhelgaas>
 <CACMJSesxsADzGQyzi13QDGh-VwEO+mgyyGmSNEyyBiL6QRAWZw@mail.gmail.com>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <CACMJSesxsADzGQyzi13QDGh-VwEO+mgyyGmSNEyyBiL6QRAWZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo



On 11/19/24 08:16, Bartosz Golaszewski wrote:
> On Tue, 19 Nov 2024 at 15:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Tue, Nov 19, 2024 at 12:55:36PM +0000, bugzilla-daemon@kernel.org wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=219513
>>>
>>>           Hardware: Sparc64
>>>           Priority: P3
>>>           Reporter: dullfire@yahoo.com
>>>         Regression: No
>>>
>>> Created attachment 307241
>>>   --> https://bugzilla.kernel.org/attachment.cgi?id=307241&action=edit
>>> debug info (some shell commands to check the PCIe devices and drivers)
>>>
>>> In linux-next (next-20241118), since
>>> commit 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed
>>> before the PCI client drivers")
>>> PCIe drivers no longer bind (at least on the tested SPARCv9 system).
>>>
>>> It appears a "supplier" devlink is created, however it is are dormant. see
>>> attached "bug-info.txt"
>>
>> Thanks for the report.  It sounds like you bisected this to
>> 03cfe0e05650?  Can you attach a complete dmesg log to the bugzilla?
>>
>> This commit is queued for v6.13, and the merge window is now open, so
>> if it's a regression, we need to resolve it or drop it ASAP.
> 
> Dullfire: is the DTS for this platform publicly available? If not, can
> you at least post the PCI host controller and all its children nodes
> here?
> 
> Bart

Bart: I attached to the bug report a dts extracted from the system.

Just a FYI: SPARC systems (including linux) get their device tree from the
open firmware, which likely dynamically generates at least parts of it, so
there is not a discrete source for it.

Regards,
Jonathan Currier

