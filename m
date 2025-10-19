Return-Path: <linux-pci+bounces-38674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE90BEE38F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048201899330
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640B02E6CA2;
	Sun, 19 Oct 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dPL6RzAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECF2E62BE;
	Sun, 19 Oct 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760872353; cv=none; b=LmNjIXJNrrs1Wlj3MG44qctNow5uXUHU7QcUW+IKUvs/uP7oz+5zEud8SsL1TohObd7Wh409cV7Q7nIFhbr4SIPzWOOkVU/9KWemPsX/J4hTgujEQQ8uUelk9bPaCiNajOFCb73qwtyDVhGuy7DNHgeyTm34uCwlSoUmZS3X0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760872353; c=relaxed/simple;
	bh=1paPyNj04xoI6ha9hU/vt29fUuulXWhJpWDYQejClt8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kkN32MfD6DBhqoW+L97BAmCx/JdNxJSZybW+8Qtu5EU8vQe37qWcBwP+WBEsDIiz5PDk+ZAILAE0M+qpl3bAEFX9QNeEzfjXktRHot7YCnQYYDVLYqaqEXpxtATiezjqV51ufCxqZk1T7RC7wRCmJou0UvDH+goEzEgkQx7QJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dPL6RzAy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760872334; x=1761477134; i=markus.elfring@web.de;
	bh=QF+J3sTNdj7X3xzkQck6o9geEOA7NGWyFJ0esyAMLGc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dPL6RzAykKO9vyz2kyLRmH4l/aNDWk0AYkBlNc4daCXDHw11m0juyn1Bz0hTa4Ch
	 WoG0Z4AKjtl+N86V5d+WdCyr9oxIFqXlN77CucKKCv7egH85Gz2lpMxdK58+l1uFJ
	 V0G7oTPySzoGeEoZGygTGk5fTMY4iCALiohQ8dXdTxPnJVRGZzAMAQTQT5bRZZiAR
	 +VdcCpH/3QTz8EPXcgE58v3wCZPUThwMkCVmkSCp/4b/GfDSIZ08RfwkNIu/bJTPk
	 ctXLi7okxX6vT2I6kYRDLCOmFHor2l36Ua41+pJ0ZFKCc72ESTAbbNJC7gp/eCHvZ
	 Nwi3TPw5uX9jrTEnvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3Yg-1uJR8f3mL2-01243O; Sun, 19
 Oct 2025 13:12:13 +0200
Message-ID: <55920694-04e2-480f-a67c-c0dc1604a4b8@web.de>
Date: Sun, 19 Oct 2025 13:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [1/3] PCI: j721e: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-omap@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20251014113234.44418-2-linux.amoon@gmail.com>
 <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
 <cf656a57-bb2f-447e-ac6c-0ab118606dc9@web.de>
 <CANAwSgT0jSQ3pFR3MQo-ENziqrm=yn-rFBTdHegmknMeFd44OQ@mail.gmail.com>
Content-Language: en-GB, de-DE
In-Reply-To: <CANAwSgT0jSQ3pFR3MQo-ENziqrm=yn-rFBTdHegmknMeFd44OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JP+0ZCKMYOjR8aO1oTsJPEz86qXToNlpnCsO4IX9JCEs5JYrmBp
 2dL/tnFt2kFigzJ8jLxDdT4BGjU6hRSc4N1vuNhrNRioQr9krKPE7AN/QVieicESqyC+sb5
 wReBFp6p4ti7pWpQWBn+9nRjSPsQ2jWTbnMQ2SRaXgaYun7xENwJAh81nQUfHCIPOKtkwqR
 wR5wWfcsg8NNOPxxS1JWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yrJ98Oku78I=;qkEjbJmoDEDsERfZ28/Ij7VzFZQ
 Ut2nQv1BbpvXEgDnYfZvy4JKBcDPIPsfS6orEOuoUH1eq+YrGKqBLzWAtK+unbr5pR0GeDf2a
 JFa1J3FL7ZIOE8CPXO2LSdWF9YUmhspqJh9NsD2yX7gSMQ6pSsskAIJL1hOwx3TLpk/Jms3YV
 jsWtxYs8dlevsTYxjcCm+dcAxA2ygrSstN8q7yOeTMtl4inB8gEENLBZ7PQ+h1G/bWg94xOZ2
 p5EkY9thr8pcMtTaDqIXFn90pJop6olOBv7t+t2hvbYcvOh4sE9dG8KX3dBA/gp3D5qON6bzB
 XE6OVowUHqGDNgE7UCe5dDidfS8eA7gBXlmQ0iTD7rkcIVB138H4KiY+aCYckKnYr+05GPFV3
 xkJe5xQBJJtykV1x7O1Ht1Izhhg4eePVb2EeLo2wVmWCFpQ/OQonEjCCBgqscDc/8kNS7YYid
 nXSfx2fal9cupd33pz+PXbKqHmxvYgZtms4ZA3KH6LvwVMFbfxzFZvU+eOCyNuBTBSVJMbSAD
 yQFuupvzDvKJTvDn3+tPrNJs1B8dOpSpZWX0/dGIpLGlB2qW0TwE42bWat6l7a6onB9rOFxVp
 MtOIDSa5SDuAeY+FcJaGoU3bo+S3mnjFChRY165EpZ6vCg3bQurEoKNIdwWrRwmShMmBjjZZi
 wXekXi0c7no1/0TqRYKsX4LS/X3AFF5AUG6ohVywmRp8E6lM2vUh9h2ORmFs1AYkEZdVTOWzo
 RKr40xrxwlLKeO6kQ0scUl8G6qk09hN5LeCsJghT9iKwkyoYKAoxI0VVm92DQUD+sAy1hWYyE
 mw1OPQ0dj/9wSs+q5FDt/0uYRZScHARYlRXDv7Yd1omvk2Q+h9hBC8wCWW+ZsI4yVxmWX37ZX
 7K6a+sn9kcNBdELiZvvERG6sJi0OBIez0mcYzb70MqObGBf/sOVid+Hyixy0wMR+zokKwDB+A
 4GptKzDanaJP4F1JdQMm5j3h4P2QyH/9FJjl/C73sT01UMhD0oMy/eHhXu6GusOPaYN/rCXXQ
 i0bI2RGVp0auhc9qC14gMRl1/rBk0EQTDOwyIShfEamWV3Pon7/3+I577FXnXu6xUVtAXe48X
 ZPoyBzRHnw6I5qQq77dMBsf8zb7wfP0NPAr/4tauZujaeyJv9oJBV7KdeV8Ino9CTKEXrSBRY
 Kf92D0WkjqxBtTuG9Gh92V4euomoa4nkc6kg658ct44xPJH7xwwMGUhgzz25V1QpznPMHbCtq
 q8LSaTJwsZxtnjE74NMhnMZMqvGbxpKsGf0g3htdF+9Ze0cQVqIlkmkuwUB+pf++r6q7UIr5d
 VBAsgK9gBFoSdmvZLnCmHgovdSRD5DGRepA997agfKo9M/+CSboiS07HQBXCbfvipqWLYA9EW
 k/JAYifMkUdFiSj+NKiMwDDRJimITk6+UJ3ppMXpRBfxgu5bpWHcIN3kUpcuX+kKQ6+fFgmng
 vkwLGke7p0KgZIXg7BlTiEom0UKA+VgrnlxqO1VRhGSJpodVoZ2HSS1ewHIu0wHTR4GnZhkk4
 fTog9CK7roB4TaKGOXdRNb+NYg/6ydkz1bnP7vHpnk1eooiisEnjs/TGWPnBhEeQ4yPvEF4Lz
 9uairvEVV5akjJ0wFupOgyDTWNfnTn4Wn757HoPrDZyiw8hLH59+KM+B1xhHUJdEEof95o9Vw
 pfIexhNzg3WQ/+QC+fvYZEWUTybi5ROuo2kVIumsJTMfYt6nPn/qjkIobKqljI51w4AcHtPTr
 9IkuW7kWYXrDktcBT06ZqkaIEmXfZbLY8i0ZJbPfWlqImC9r1WASAe8loU+su9otQEUQhyZIl
 dKLHhNDAPwgbGTYWenT9UOtbJiHdw2VBrIVdv3dkSSOVFbz7F99uGUgamMnRdmJbs7T0r7DG/
 Sswy8yD838sZ3iR5DJdnbbJ0ZvoFGEjs6WzzLnKZLrf4RpA9LZgGsFd54r/G6vWm3BZqt8ao0
 UuLIYVQL0tRGvofhHAhxjl87UgVUV5vV9SO1i6f4OAAMyI5XNz/ZBOeKjMDyVM9FtJ4MFSJaH
 /jRMRo6ChGm5arkJOVlQS0VulNnLYr5NmcLlr+VJeUcSD4+JZKkVH9FLKPtQmkgeM4c4ANP29
 FMSDwG6v0OcIBOh9lRejblCX3p3Ra15248nyEa+iT2V1KuDhJsGch6htarQsfkBOv5YKkD+P5
 6KbHexxw9+KBQXEbqqT/jE2imBLxT7aeTEaBFLWnroYzsa93NJUdHQpK9YImMZWxdGrOb3csz
 sZZaMh5R68cwa7UPJ0vVHf5At/63PZRyWB0OutlPQuZzx35jTZrsCqYxmyxB3rrGwjWZHvzv6
 YhywS3BcBJbCXWqvjcu9O9FUFM5y2WAt9GdJUrqhcT78Drty72l4KIfMerdJ0FrNRFLs48UX3
 /dGtR3bP+qaZ/QXQeNl+YbQslBI5Cg9oUeWAS3C9q/+tV8NVxge0OySrUHOpX0dvVoEnr/q+E
 WXQSeRX2MrD+L3M5YwE9gcQ/fOe/7oVPSWB8bgcqeFfOl1ddUvUiDT/UuNncufv1p1UFQk+4n
 2aibMe42mmf7AhASoSsKidiweDxlbH7WISq/0IoXmTn/I3RWPwAGhzfp5Nrykpp+NX+LmFpRA
 bVgEobZAKDtBnHjA0hrZjK9PsOgA1t12h2Us1sQo9AZUUMq4wZ3yfQqj6FY7EgnTwhB8VEnYS
 mEbLISmSMr+PiQFvqfrZ5eclg190BHBWJSVh8NaLmM2JkNlk8uLQ7JoGFWl2qMNOv6Eovnq0C
 ypcroL/prLO/utF92KGR7s3v9/5iaPsJowwe+MsbvvVeoR5JpYglF8tVwAr2sThn8eccBG72y
 VxLnA+JvPUcNa7AEDf0bvJy6izaGfGvJP95ulkS9GTKXNv3oCZDK64/U7aFz9M7DA3CqRJkO0
 LLVSQE2InC2C8Me4QM5lxKAAvagXHn7ehSA6U9XnKVsm1KLiB0YS7deU0fuaCepY94giAiUz9
 JhKQyomYAFofOsKuvbVq/Xmuvx9yRtvuLkXyQYIwlN8blktSH5zucc5YhIugnuSYiaJK3BZqq
 DucXkpX7K6/Z1d3f8eudbuBOf59O7L4lzcroPZ00Zx5HyJ1Mg9qifNTevLph3b6QFiANvK0MO
 8TtAPSpCw+a2Ojm+F0hHmxXNSBnw1YefBAXL1AEH6jGJ8zR0iQmu6YN85GMYpdz5bKLaK/m7I
 29H3fVVrSkKN0Uqf3y2Gbr4r9P1+BibbHMWe7n2zlnOAs4pd1uGIKjiZyni4SF0r/FYvxSbAj
 7HFTJZtmZQDRVhllloLobdDtrlwVWYS3oYvuoecaePO2STdLZ19xqwse4K0+4tVC/jDlokIRV
 BM/lELWwNwksOb14E6cxF9811GuOZN+HyIEIjxRkbEjYeGO28WK3XT9fdhay0UYWOwWXv2zVW
 K+nKD87/277zyN35+cFuf68ADCD1r1veuwXeeaPZPmB6NEuqrxiuwT2jlJKAWeNUGnkZ67bPT
 GLXdiIJK3K8+BkipXd/1EXsP8/EErU7ClgSDkzX7RuxwqEHERqTmHvbnLGW/K1HrywwYKlwxI
 bIkD6MiaVbqLhLO1ETXEXSzT0OfD5YpFHR+MCmbMY7DTg4Oqbxqb8T7gyrH68lPAs2PzIhse5
 lpvRDgovF7d3yf02FVs4l+yB8Yc60IQE0J0WzxmtviaJ5OcIS4RbBMhabVos1bFpyvJKtDwZa
 QjBB5VwJJl2ojPV/EDGEQpPpjOsSRdedm/3t9me+xvrps1e4KaPIVPksRtOh74Invhq+m5bip
 IuxdKNqhCZNq9Jsp732sVdVIOdjgHoMpkzZY13+7rJJq9nOS24j7E7Uf6oFgNLbFuUYeLHeEe
 /UQ/vXrEyEsr7cYY//AyIif2c9XnZ0OMg+VJZzVwIUZYVwcjOt7KNVdEgbnt9vlBlUocALn9l
 1v6sk84+hKVTD/XeKwgCXsj7rMO9hAytq4vSheM7pHRuN+zPl+Cact7s9RCoZsEmPWF2JBON0
 plfEgV99gin0FR9Wvl7EPytHgmIFzbXOJHK6QAkgUQEQuqwMHyVPLJlHdxO837rf97XaRU87L
 v889DBVsH2EQfn3X7dwPZZZest0bJx4Oa7uU+2phvpkWaMwpwLzuVxkQiYEU18xze7oBz4uX9
 k1Z+EKVJFrMIKgmJ32H/YWFA3SLNl9ZwsrEeaEpvM7AbngSs2amwb5J6PaLIEdFtOvFZU0U4/
 9iuhFjN9u2NJjziVpBbzxt5narHHHUlHiJfgaLl6VrRvyJDKmofNo1ZRAKiy1dIIxvrD3QaoR
 GPYJ+F+G2zHa6zhsdV+Cuy/SFV7PfFuHIOwkVb0b2zLRB10AavZv85M3Ap5uT9zPf7H/x8gwe
 m+p2H9K7sfyLx1E9PjJIV7H7ebKYiQSyPYozLEaf6c7LkY+nVYH+QTWkJwTLl/3GQVFN+O6pK
 JFgmjkxiaavzp1rytNPxnNykQL8eQGSI4rcuRTsqaLUCVvjCNcbdfSPuxoveF68G6rnucjw7W
 ydli/+kn+MjhbukYv9kAyf0Bo/tMp0QuC5CClXRW5jQPQbhhraN52gb+Pr+q2ChfsImm8d4nS
 fXSxTp1K2r7NaYsEZu+cR0t8mFvCUJlc4RuC8ZWL96qOh95b4hfLrt6C0OZpk28epEAF+koCI
 O6RG4isO/d+c++oIuQaWGupHa6q4adI/Buh7nZpAfmnwudq9BZGIMT+jOVpXZT8QBMLjuXBDE
 dIFRvKkgcToS8EaB5q1ZYXK45nV83CeGnTKa9rtgBGk7cTrM37h8kLPiJBdIuyat5Y+Tz2WhW
 aqU71rkqx03LDTOAJ9F8nSEVqXeoBwaGl7GO0QkRXRo792S0Wn/Pz2xAbC5mQpghltFOtd6r9
 3ywWFPI0AVeVDSeKA8DXvr4qvVMRiKpfUl+/3EbwzdbDbkq4K9v977YAsoWxuBwMaEshQiOxI
 uTv4L6ts/XuvEwRvxoV3crzJVcGZTIVxZRXRaPJB2O7+dFcb8skBk0PQsmktjIXQnRuNprQ83
 oxyUAAV8S7dKZ3bEbh8LnaowA1fg3CaTN2o=

>>>> I propose to take another source code transformation approach better =
into account.
>>>> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L=
5031-L5075
>>>>
>>>> Example:
>>>> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controlle=
r/cadence/pci-j721e.c#L444-L636
>>>>
>>>>         ret =3D dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie)=
, "Failed to init phy\n");
>>>>         if (ret)
>>>>                 goto err_get_sync;
>>>>
>>> No, the correct code ensures that dev_err_probe() is only called when
>>> an actual error
>>> has occurred, providing a clear and accurate log entry. =E2=80=A6
>>
>> Where do you see undesirable technical differences?
>=20
> The primary issue I wanted to confirm was the function execution order.

The desired control flow can be clarified in some ways.


> since cdns_pcie_init_phy within dev_err_probe function

One function should be executed before its return value will be directly p=
assed
to a subsequent function call, shouldn't it?


> If other developers agree with the approach, I will modify this in a
> separate patch

There might be special coding style preferences involved (for a while).

Regards,
Markus

