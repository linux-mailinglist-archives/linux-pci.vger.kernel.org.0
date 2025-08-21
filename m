Return-Path: <linux-pci+bounces-34483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028D4B300A7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF53418872D1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE06D1FE451;
	Thu, 21 Aug 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CdXms9DS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2E2F6194;
	Thu, 21 Aug 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795640; cv=none; b=GCaEdJ3vwGfSVbNzWLGC3Aj6u5mW/C3pVumPPzy1XMnsybLV8nTcVVaW53CSnqCGCDdTp3nIz2eyA4om0eTopgXb52Z+EfWhbCJ5PHl4ceVtB+hx8SNetMBVUdneocMLualbpLb7kMyDzvI4XDUuEG7A+h4ZRZ8xQNLOp1FsQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795640; c=relaxed/simple;
	bh=1AXiTh8GUd+9TlmwJxkFzdvTKTRfsR7tcqwRPmwA29o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDAngZpKykVgtylQ3J4IywJ3MfXKgSEkssX51aFeaXjqwFxM4CQDII3m6lpWt6MkdzCgvOTuDt2OawWHdnVaGIX9DYm7NP12ZzkqtuoWgHsSPN+LWx1X2R5IFHm/SSNUb0PjqlpsOzJF9osna4MAno4awfLwv3/8H4xtP6UohfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CdXms9DS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755795612; x=1756400412; i=markus.elfring@web.de;
	bh=M+exM0vYdKURluLWW4HXSSDc98neOy/wHYX4vVdg0CY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CdXms9DSMmucZTHdl6MwjmuVs1M+4s76RmmNJ6sw9KNHBrmETDKx2VjKrO1zyD63
	 MO+MX4FPWJw5oksTJUlwPFox6qX38K9c1IoUzUR/OfFOC7srH9k91znK1ycKre76n
	 hi3nQptxQ1Lw79RGcltxIxpcAm8OZtOoh0eRSjEJhuSRtDUNTTGVTW/BKafCKWC/X
	 rIHnLscSgDly90awak4wWEGq4ZhKgwKVmmvSdlnN5hK4Edcn1Fpn+IOWwpyUpVWej
	 DK1pC4yPqvfwxk4XbkCog7xb3uwvE+vf8pAgRxjXR/uAxJ/MdrqqLBca0sI8g3j7H
	 yEImBFmGhEMEQ0GTRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG996-1ulrvT409k-00AAj5; Thu, 21
 Aug 2025 19:00:12 +0200
Message-ID: <0185a58e-9211-4c10-bcf2-bbf2f566323e@web.de>
Date: Thu, 21 Aug 2025 19:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, D Scott Phillips <scott@os.amperecomputing.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rio Liu <rio@r26.me>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
References: <20250630142641.3516-2-ilpo.jarvinen@linux.intel.com>
 <8e9936e5-d720-4ded-8961-b9475aeb2ac7@web.de>
 <21e11870-f125-e9e7-04f3-ade94d6be6b1@linux.intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <21e11870-f125-e9e7-04f3-ade94d6be6b1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8oLA+mmkBygwao9p72ovdCNmXmySN/qmjBz+S0JFUrfxCYt7P0L
 SLj59PjlMgn2lXSeSPZBYarYEVpxN+GIz3FuF1znX13ezZgXmQ0crFXfX/mWV0jg1yvmVOz
 7jsmNaI0xLGOsDUJbvDh1TLA3HJ5fJpY0Cj+1dTysPNGRtqcEvHc9lgmufdCIfnuvv8+UEU
 nEGWA0EmtPhRFlYlJU3Vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5UFdCSzmd0E=;2CmpoYf8PUQXCEpZZm8Z0PoXO/u
 wW6RJNl6CW0zoWfbffT+OyiCTUxYmz0ENpgwnguVDyQIfSMpe8gpGRJK2y3XjkYtuiFb1RCW/
 S9E7YIE1dXWkTW/l8sxXL3WfHRDYzaJNEMPLrA92P6wCOTOqK1i+SniWE7DduPR3DAO+lHwv7
 S9aPyerwNZfV80FmRdiaNJNGrFl1TcieVu+BotTd7J10L8PXHwkGWUp1mvDLNZlv0MlxTWJlB
 OPPTgLnSZqCTRSoSaayIjvqL1R1Xdd+lV/LkOiJXOOCgFhu1o2+9YHAibDPGFGmXpuXwp4SyN
 2PoAwRREdLM/9SPY0zdgCqrivKVHSZvnFu24/s1WbyxiV2xSK225sBHxBFZMVP1C8cuv5V5dv
 G6xTy80bsCDkqBmhdlWHR5GHuP+m+CG5poVIW3m/jLna4kAIh8sgKFffCAVySXiiOXQSUZt6T
 VCtfleResOhpFuocWbhFBeQAeL6EtZqcMsagLGWhf1u38s5cgKmKWP22REQcmYc77yBXyZFIz
 4BYRF/rftcWGPjcNMEFKih2v1SzQtTnJwQTifXJoEsltSQUjUk62+qGXK/0Ldc5Z1APPpJ1IU
 2LfHVMJQNbZ0u0Yj65G53JeJxnq/JWfa9K18aSL29aqWEBsvgWEjdg0FONWNgUE3GLwEKCljN
 aZhgFTeq32lrHY3kdrGCMZSEwA4z1qgkSugnF7Hy124nbIjJVb4efxPoRH3E5rdkr1xwz3TVe
 MfoHkY5DPF9Jk2JxfiwAEt3dmc5nB0iqKzz7cSZSVVWr6a/JP+eV9fEhFFD/G+FWqcmMspad0
 RH3xXdrz8+JWGvg9EJiHt2mEtpjwui63BceiH0bwHGzLxcmTLt46NQiBE8KTiHrU/XU683K+0
 qtAmxs/RIiUZUEYhHFfTixjzNFdVbOFWX6TVpGdLKuNUuTR4J/RX8NzuGtsSJvPnG9r2pPbWd
 ajXreNcVhezS+8/u7xFdGY2BvODpIPwoiYMcKrn8eOCfErCkDzcHUwuBJG7mUWztm0/oa6Oae
 onyzowMmAEHU2oc85/JrYGfAKeEb16WFnn9EyURyOQQQ7+MrL33YCFrGHVdW4CGGsaINLFr0z
 me+4R3pZwkgqwfDjszXBI6mTk+4FcNS5FY47hHU58vx9GzMsPJmTjv95hYjNEueWo2KqhVVKc
 spJVR9JDBZi/SsnUP7NHddnEBcjaDZf8cOyflQi9pCHgiUEjRn0ESOXMfbxcV7EDYeLzeoB9a
 vFzYuMJtf9wL3GKmoEYnow1SxqWG5mLwXteFu6Qw6PtDm3hD/WJGMexub4F6ilfTec/LdbL9o
 4stMJlX08UyLaVI9e3IF1QjtEzN1D1L/gWqdBgZ8wgin/oJY1uHTZ0v5lWiQiU+zrJFjGSNFH
 n5mFxAWgxkJkMYFEaMmUT2Ad0YuG/lulwXgRLHibCo0D3hgXxHNwy6QMcCej8U+ru/Kt7Mp4A
 8Vi3oF2NNCHD+lljB7HuyTdF5mr7uDQCTuu9qOuEvZflw25SGI/Auxb5V/l7MjEbDPEYO6zTE
 W54/8QkstAHGKQO6UR+MXw735lstaIHJJ/GHVjYy0o74QIU+AYoLgInlMzjI1r9nrFirnjt5L
 8vDCYBb5y+9s5smKQBhY3wOTrpJVTsDHzo2cNAIGqvYVmDgw0tCMa9ZBFcJjP8NjxAwVLwDYN
 SJ/Zegu3HfZOl7DltsqVGmOkN+zAc5DMfQOsfwoKOb4mhcC1QNJQZ61X6WjNyhOZ+YaTKELBs
 d+cxlUc/sSm5qu1r0UQcb/3ATGe5nvNAHD5QvgusuBu8gJHpLG1+kC6fEfOCgbGL6Mp7ty7fQ
 Lv8a+O4Axap9UMqz4zZBdUCc1j1LYicw/5+i1+ALfBNJChkiFvJlXMYS6f/7H3n/fHoACJOGa
 aFkVnXLAuOpA2E5iYUs4jie9sWgfl3vOpBm5z0g4TsascvqwwdRYY4HGdltkP4HeehVtBLUx8
 kmfM2Mp4vlY69pFQGrCgd1b2Dlw9RiwXfTXk+SGNshrDQq6w9v3OF9+xqDbVLgHgGpUQ8qfjN
 CY1kXzPVNZOO7TNPJvsQUY5c6BDhqlk6rgJoT5i/lS4a5PdUWq9w3WzIjMhj7Gp9OBC/s+Mh5
 oHPdtTyhu/YadAhmCSbxDqjkdC2Jb5lKqeqsqD/LD1Kxu1p3erh558hVXz+LCzUY9Tlj46FJ6
 KomqrhQenniniI4a82YDcpVFsKwKqDBSfjihP3VRsf7mDOU6lRJoHY7n5q0z4KwyjXm32IZ1T
 VBm1XI67Cb617xoxsaJyRKt9pHHMee4ywyC7EkGu47ehvfL9UhQlrn72gjJr8CmwBmBbmdjiN
 3em8h6dTvxoEiVz2EqGMHDeso4y8ZvY9XlZCCIujtt+xhuKyknz7VZR76Q5KZR4JLCaIiKXST
 ujXOnH6Mv2CGrRcWEjbN/pj7OSc+57YBqMpPtmNDZCbGT7C5b+HVVqOUvqNJDdL329JZ2/OB5
 4LgYxKaTn6gN0SZsBSCARNkBBNN7ebWD9KUmRh8hyy+z2Vkgsj28rZt/3hQtJg/XeK1BMpopu
 IwAWfmvPPacxtToF6L9Wd2GE91ylD/X/kdUiNqbpa4RRqduAJ+ZtNPZ80sh2ZB+JzSw0qcjPe
 /4AZODtl0nCrKq/D1uvO14wdWwMO+Nw29g6EX+TbZwVhsmqQ+R/q7DVAoBWeL74PpmTWftz4c
 QEL+Cs+iFHautaKDlm+2I7fzFBKg1xMBa6dVG44GcCfnP7r5RGak8OvKcvdp8n5Y4ryhESvJy
 OoCxfM7zqjAdpldjZBgUVEjfy5bXAcApqDv1AWa321orEKuol5DfhFoSdbmaH2azMyRXl7mrd
 k/nn3ttRW6bb8tUM3hyAXB0+LCwPLszBYYSyZsjJA3IU3eclyw2SsnizOvm5mf2L2y79OhYGK
 oojNQbp4W8PvFeuFvYqA2tEpBMAvVJtvr6RymSpTRgmXgwwI0bln87oRIwRZ/sEe3AJdRSOil
 QnG6GRLMBbV2QuNl37QbSaddyWpuEQ20cgdKyYH6Q7Tj3YOGQRI4dUfyDq/nkptNP0DdutZYF
 7TNu3Pu14zZLCXhyOvZxAj9gvvLnb+QAUcTOh/nAE71r1f5KgnW1jawbo2OZVyBuCW9AD2bwD
 SvK2CwNZJx8BlYZzXgUn9GU9lMaGnFTF3PfJs9YmHBv5nqC1+UR4iQW+GFqfY4Zw1VU1DvVVW
 yUDOi50/+iDtYxvxQOWLJKZ3c5Tc0w9TM3szO1fvpg2bDLWy8tmmz1f4diBvABpvOphw1ljYg
 FZBUQt+eeTcuq8N9SolkUNScf6AgeWn73nBLAotWlWDmiZoMgsBREpF28O9uUL6BjMgtQw795
 m2ClgNXc07knSFAZ3uk8YvxIqHUfFGKwkST+v23sKf7XAuGmF1YPXWBvOa3XlH/aS8CAtf1h6
 3gTWCdWlf0uAmSY1jTrq7m0uGsWdnav58dMwGf/xs4eApPX3N75j3nVFe+5j4zP+J11JmEfeM
 VFSN9Kfklif48P4iMepxMyk1c83kcusNayVeBTaYyMeKjt4FYHXQ4JtlxGXxfIMTT7iPq7kS5
 /Rc32ZYjOzLLicbzp8TIN5PDfIGoYD7tz8T+3DGga/RTkNmhEowIWTe3C3LScHhfgt3spArKI
 s4WDn6Og7CLtMWLPkE8r79rPOgFk9c7mNKwP48fmhCcLgK2tsI8/tUiFHZpv8lKe2Ix0YI6X/
 N5Fw7h+r03rZ5MZ6l8IPf/oL5EpPW8Kh6+IVrVWsZwO0o94sM7b56nVjgZ9ZX1N7qBwNF9WuG
 +wApv0+opmaZfNbcEJx1Gfazh6IOBSGLQ+xmsMA9ZLYNuyNdBR2gQ8KKfZKp8fESmWmtbfC8b
 hPxLOhNsyIRyfZL2pJP6WYRgAwENutLbe19wua1I4Y13+iczaoJCBsnW/zCSncWXPoBvyHNiT
 Is86ZeJf2urjL8zlubB826eSRDyhEFrrx1xdtDDJAv7gVtFwgIcfBSh4HX8pnIpx2BeQd57jK
 6KmlXXZTYmKG9Kg2166GHySsd2OHQdVTdc7uiwrll68NgyRbut/DKhUJqCH8X3UVEZzpZpE3r
 6LnxlylthKpUJ9OhyFcRcqsA1RGBJNsYtJ6UMEA04DBcFEcrZLz13OYXq0Bb1ljDyHq1jAX5m
 WW23dwTrjzFq4t7FWK0OByJ7zmQAQ306gV2u2xVuqGNz2YxRUrVL9bSnh3bZQdM8AoCh/m2xp
 Vx+1kv1UUOu9VBEt7fQpb3gneTifinGTto+APDPf4Vye5mVe4Q36V+LdHKMSV1Vm1Zn7V957c
 c4a8Y5mQYtIJLSUpoDFs2579bJO6OaAHp0SLF6Sr6sPrdgdkeZm5JX6Ly8P49B+drEfoR2Yak
 ozccQ5RrHwb4PoZfOcf7kvJXGmzUYlJajGWVhuczU5ekYlYw2+vaAxtKe+e3yrmJjjylhgIbl
 WOVaiEgXuxmJgjoUuoG+5oJIlNp3fCl3IrH3+lACXUMEZarhvMmpSC47uyVpQ1/AHaZGCBWeY
 22OKbHC8rIMy+A7hexi7R4I5P8UcO7/xWoekM0wKb31N8YZOM0PjS4Zk+JuL/aKLBw8kkxI6J
 4k590zmXMVFsCaxd94/ti8ryZALsiBdK4si8SzjceK3w4cKB3yighnsj6j/7oQHBgQ3Y6CGxZ
 ednv4Yo34z2lmR2/E5uXYQrhLAAl6IMjFLIgrKG8A9HidLhIL0G8ZuFag1cstYu1x8jxMzNyH
 9tpBJ7BcO31tJnQjH1R3DlxE3horqYDZV+AXncVs2xQVhw8TJnyxYJ90Etsh9NOKmJoCWrg=

>> =E2=80=A6
>> +++ b/drivers/pci/setup-bus.c
>> =E2=80=A6
>> @@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
>>  		if (bus->self && size1 &&
>>  		    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, =
type,
>>  						   size1, add_align)) {
>> -			min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
>> -			min_align =3D max(min_align, win_align);
>> +			relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
>> +			relaxed_align =3D max(min_align, win_align);
>> =E2=80=A6
>>
>> I wonder why a variable content would be overwritten here
>> without using the previous value.
>> https://cwe.mitre.org/data/definitions/563.html
=E2=80=A6> This looks a very good catch. I think it too should have been:
>=20
> relaxed_align =3D max(relaxed_align, win_align);
>=20
> ...like in the other case.

Did any known source code analysis tools point such a questionable impleme=
ntation detail out
for further development considerations?

Regards,
Markus

