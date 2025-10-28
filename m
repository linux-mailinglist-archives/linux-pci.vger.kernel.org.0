Return-Path: <linux-pci+bounces-39502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7EDC13511
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 08:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C69AC4F47F6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB361B425C;
	Tue, 28 Oct 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kRWlAGEO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220F7494;
	Tue, 28 Oct 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636858; cv=none; b=f+DRV2nEb+9XvwreHuB0pOx4oqXuvNwJIZKEUJTmW0wZ/snFO47+82B3tb4GIbDnz8EX8TljWJxX0Wwdf3zu1Ol7ozAOuQ1z4bsX+Pu1rWoIIGERJ9AcLMDGb/Dq0BOFvsutv/7qOD9fpaJPDo5l+pR37jqq5VrxRe6KDjZQtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636858; c=relaxed/simple;
	bh=2lTsoyvcbTqiOAETBIyYpfyhJQqBB8MXR4eW/AVdE3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3mJPULQkRPQeRwtDNb4ZW5FWJ/nuD3OQ0v62+IojB21NPsTXVJ+2ZdHRjaBtdmwENbOvTIiUDRyeQ6OruT8/MzS7YRxCTkjODfWaioZGLxviZ7zsqSMptgUonmYDzJc2lqXswOXXNaH323NTZYbJad+rXYtvlPGR+URhrue5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kRWlAGEO; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761636834; x=1762241634; i=markus.elfring@web.de;
	bh=zrCAv39Ush6FhTLmamRXYmaMfCDqXckHHe5ZV3K240A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kRWlAGEOP7Cgq8QHcc9+CljtgeX1L33pq6I1y2lFGvYh+aeXdBDI2Z/SLYqx7oOt
	 ayk15aH/uazhyobxQTY7rEfS6u5+qcBK0lqolLVs6u74DhKJba+ceVuZKdOH+fdwU
	 gKODbDXB8Q0PTEGc4yvAmuhvp9pv69UUe31deQytujJqRLYFDlKza6aIj7yJEyc0s
	 LRiF8UyYhhNKwe+Ptf8yFR6VIBvYprYJUmACFGw1d5yJ5V9P+AOoxMmM8Rg/Pj30g
	 /B3tBH1ppDnW9EyQbaP+gOWruhGjf1nFZHdnJJsezaMrbY1Y4GTBzimG0Or/ujm82
	 /bhIj8ciGBwu+2f3uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxQV-1vRcZe3odH-00Dqqa; Tue, 28
 Oct 2025 08:33:53 +0100
Message-ID: <b715fd29-3e83-4087-951d-4a6ed803c272@web.de>
Date: Tue, 28 Oct 2025 08:33:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/2] PCI: j721e: Use inline reset GPIO assignment and drop
 local variable
To: Anand Moon <linux.amoon@gmail.com>, linux-omap@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251027090310.38999-1-linux.amoon@gmail.com>
 <20251027090310.38999-3-linux.amoon@gmail.com>
 <f36a77b1-79ce-4bd4-ba4a-b9260bae7f11@web.de>
 <CANAwSgT43rsi+DxaMF3T-gsVoAAGSSDEL6s+TE2yZ+q+W3bRsQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgT43rsi+DxaMF3T-gsVoAAGSSDEL6s+TE2yZ+q+W3bRsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O24eJhkwZW4LnBuNwZ+VwlHDFh06Nb+lLsUu9Mmb4fjiDS12qQN
 FIDJF0kYfUWzw9D7gGMB0Uq4Wu/pWQvxVrJeDmWRVAaOS4XB4z22SYKTHOOaxDKGqn2R0uF
 Ow5qkCsOm8bmUC/Y3ZalMUTJDGEXaSpumhOgPpfn1nhE1+DSDZx5FoxfvkbIdxkUQ208QR8
 RIig6nUTVQqEz58omhDOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L73BP8/G06M=;tg8lfMyVxtgZi+mqix7sZc4ckIV
 ZJLVaYauNYXjwSqVP6fiABYmNJdlxpW9DRovoDHF9Z7PF+9r4NTUKERzYAIIO7BzcVhrnGsGG
 o2h1ws69r5NdoDyPmsHgJxyO12iadCGdyRaekhi/tKjL2YXZtq0J4OsV/cF68EJqqrylWXe4g
 2l98cCvMpOXBHeRuUlNNZzUqUhTor+kcZNv6uFNM7+MlezxM50doUFGoUbTea64Pfpg+cCnEa
 oPQ91OAzRcJ9FRjvXn2GI6k5htW8qXNtfO+4Der3ueMnn5+BDo+pV4yhm1yPafBLnmoT2m1oX
 ttKikf0JPwXUkCgV0D1WW81+UYB3QnYjz+bRrTosHa7htZTNJlSy8wbsOAxdK19weigR4JPuG
 q4mRNxmez2xVxX3BRlH2kcsK9NzyvQ0+WWttFWf/hIiGgMsFfARJxwiG0uvgSVm6sudHdh86g
 uprT7Xiwh7I0qn98pnL6v2fGpW2VXvwSD0Uy3fHz9nT2s6HRDhyxHFS8FrolCxJyV2Tu+zQHW
 WQXQYgTR/FE4nuf+ddmrsYihR86IZ0AQ+dQHpW///7Y6pjY4y3S2Mp2161+QiIHFqPybPaeUl
 wz7nDBnGEt7GnXjV2wMEzg2K9Qj83B2lLMGL84PRQKFKunBMQL3/+HMWXMWU0AgKIZJIX6+h6
 DrapXVwrqloMhZ0Hb/Uge1lKCKif79gj9HcFFcZm5leThB2e2Tpbc3i9XFzP3SxOghX/CP9vh
 FztcQnwW+kHMLKmmjqFZc1Eofb4mCKX8hSR0VQwx7AsLKSeB/wMmpnw9M6Kr0ylioTLW4puSZ
 drj1RqfkRBPGYjjYq0t+v2HyD6kP2m2LAx4rdHp76ievM3lybSc2Iv4WFtDT6Jh2XEg2iV3Ug
 7d6BqaQDK56fMZ1s4eU0YXMeKvNx/CkKC3PB+khUpJr47nvaaRoIVqphT3OPYEwEF6JpiPLe+
 8gC0+YcgcG80L4lNe3zQ+g/+KRHPXdOI1+qlKRbjqIc2C+FctJU2NSiE8p2YD7B73ccAZRQZC
 o38AfJ0tJPUY6jDfTHj556Bxc918m7C0gRo5oHZ6GkQ5Ly9L1fRvAKgHFR4TnkHNP2KJWw7qw
 pFTAdqcQP2sajbHgD2k6e6tykB6t6w12JPB6kQsznKsEY9OUuBTyGCRWYaw2U9uFk4uH8fgUG
 Uov7LvIJ4NDlxwUByT1DqT6AwptDc6eVIUxoENsuzybzwsNHscSzloLonhS0GtNdGzglA3fta
 BIxmgmAMSoBnz68BNYuGKpkXC/7mbpaEC7cwCQCDz83/4XnJ42VdyH+DqD3bsrXoM/0PWZ4T7
 JPhSzUq1a5x5bf342BkTj1cDF2zz0zD+eAcZoMqW2RxKg2IoSW/taYXu/eT53VylowSf1z2An
 2fRF40zPSr6dYu/yDotE2jjuRDmsBIeByfv7E/v8UjA78ZvMyQUyCjp933RZKgAkqc5fTz7vh
 DlvVGelX0G3E7jBw6uSur6f3ZVnPUAJ2/8L93B7A/SteVzCxgDaYUnwkRRYOszESvVvgG/HTJ
 3iE3WsTzaP7N7SRI1poRXu2R5vGwJxrGTuWdII+m29zs3EPKA/5Y8wS74aqQN/Yc4p5En/y1m
 BjsuE2GAkGn+0GgAxL1bb91x+TK8WR/3g/b+MhsB7QhLbS+qpZSEwe7ZivECX6qYNZFIvqT7i
 +EwkveVo7T5pEZB8ihh5Kzodbn9BSLg9ymLP3/FdmyJDXlas/uiELsSdMMQqB4+bKWdjPVB4Z
 kZ90cmjgeGw8UnX2KE/b/YqmY5Evya7IVxtpfoB97K/CjNdpmpviHft4uk+mMn0NfgfL7Miph
 Yw6MflHxh0HPUb2ghp4C96S2hMqWubaVFI/hJb/IcMAxhUbR+FpgrM+DBcOr+ghvH32Bfpcag
 w2LM9rzecwCFnaBy7FOpnzghqma6H2T5nfc6G9mj5bq9udILrG2D9iDl3G3hqjCMQ5rzGDogv
 vDeYIUHeCteZxkAq5rLYK7XRBJwKZHNFRtADVGu7wJxrP+vrcIyi7GZCyLtsB6Uvl018b2gr+
 frvUX315VRYYvZyin+JViw4LeEgepptjcIOb/MojHYFLzdaO2+2QTCYag3BsGsz0AlP1NhmpJ
 EHNUlxH+xm0ZaVbh8O7seZDd6/RTyvUUsdYG4v44vCpBGfDDO34EzTQOMiC3qFH1S58UEANtM
 U2dtB6C53MDkRFaZH+GnpLvgjmtAF3lLWbhYQ1agZHXsRJC37q65sHI6/F+d5POcMMiSPM1v/
 Y7CDSMXZO2qL1jCJZKkY+t9BYca51e883Cc9wXO3pqerEFfBMDu7R+rv4X0BJWvs3i0ELclNE
 CYwY8E48njD5ehfeZ39VekB4wfpdoQhKqOXVf1TlkR1ePX7cbXAcTSz22kisB9vBgFrS+NH+q
 K5Eu4ZP+XsU64A5NkFs4lcogIByW5v+EEwWWjbXAb39ScPmncRSn8+bnCH7tTjgEMBm/afUtM
 tTU/ozInGTsNW35xhxSoAcZDun9UDzqzWKHyrsAIlB52wF9JPGe6kiWTvZrltIqzZ+dzviG1t
 y9lzA1ZUl+aM5Zgyr48MRA5FmKIWat98Z2IKeb+ppBya71/C8W9Cks2UqjUT7ZwVVX5YpQlNX
 fkefWudhD1ZRawPkaIGvEiJ0RtQ2lnALJulZLYflsKzIe4okolJAdEBzWM8JrmT1JxlbmAyWQ
 jCk//OARAL3c3PjTCV7AN7bIMNew3qAIIK3dWTNLxN4UJFfBaOFF5zfY4p2GmSIrnnr4zH2A6
 STqVCWvOEnVIcMa9YSw48afRgO43lAlYjxRzXVyxcnRRRu/IzcqcyWAjF6Qi+hdue4fOeBj5M
 3kloecsVtL3YCrD0IDZaQv0ESqB3D8k9k+t36cllF3LEXVcOLMRh8UqXMWFfVam4tAMnUnacX
 L2dfFzSkpdemHYM7766mDMBJIbhBYWiJf9IY1MLmKo25Gy2zKkZQD/A8BudTd6oJrpNuWwYDl
 r28g5ychgDYVqhzh5jhN2Tmyh6j+1J2qBSVl6I18YQ4J/GMcQQX/wRdVM/T5JPV7PmHTDFXBX
 KqKBqTgseAeGxwaZso5duGqL4YcJb7lvFCatxGKbyGwEvBHQbz5M8d/uUT1hQAWavSa8dYnlg
 UDGf1mUc04tk+VABVGaP4N7RoTxoQWPEycpuH8Qk40h/js8z1L2nWe7+0CwkWE5xHT6h6Imzd
 zxag8S2hr6nJvquvc4zzG9kEATd3OBg0JT77I/lY07YKxLhUMcF5eLQBj8V5SA5caYfW1J2IE
 JbTMz5Vh2KlN3gCKC2AZHzE8iRkYrX+jAfTkbrIoQngMzcaSTyfSFbci4Ou5PfL6pci3tSaCG
 GHiN3gtMM16gr1UNb2UxYgvsK07HhTmJy+hBhgf/UNNA41GJxndPxyxXBfAGD7WKXMvMXPS5E
 t2bNzFrBvPu+0CVJE4srLhECXDCu+tvQTL1vP6veFB+rKGXf+qs5TVzr4vK3/J7fZH1cAkGuX
 t6js8G5YXLg6L/ydhPTQEWTwpiHi0lgzXrg80G9hpksbc2tyhibfyMksk6/DlCPw1lFUR0EyP
 Ddu6+qKyg9TQrQWYxRRd0thsSA+zn3C8oZkgKTy/snddnW++s3BdJxFBNhXmgJLr73NCAasx2
 V/ZqbCuHU/s2+My+iSua+zhDYb/jqJz5OX0Umj5T4jR1WRBYRu/fGbAzgOjvFmYoxDE2VEwLc
 kLNvbQonBg8ysLOB+spY1UcY00O38vZYmhe5fOtb4R1en4E5GEk3Eb//Vn1RQvp6hsRhocxke
 SH0J5fokwqlDQnv8HcmwhSIBB0/1Hfc2evIxgOWiFDS0aBPkR6U61DSCq41ngK6LyySSinNc0
 EbZ/ll552QKPTLnuU5q/FrXiFzZYwOPjguBTukh+zqTlgUiBxJvVlaxlMdLHY4uf6o5+pbtn/
 iexSEbuybUPCdj3m3n2wjEV7HfiSyNBG7RlnvMLtiofBAFL3sU+PMsNhCG2f6D95w4C4RfYv2
 mw7VScCh+q6mq0QD3oFWjj5jlnDDeesoOghHrs/Cd/oBBjyinHijcIKRyW1+HX2NfJ5xfdR3M
 QIhy3pwmat1xK+SEG8D5HN1ca/mZsi8AEON9EOIPawIRATvFr+mArtbGfyEtZzRiTGndha/Hj
 eOFkVska+p5l+u1Orie3A8j5aKhCS+oChboWs8lp6WqAfA9Nv9JvCvtf8DF6ngdaV29eHl/ym
 vxeOegfb8TrnRAt+T1YJiBSi9WRwZEt0Wg/vIBkHfs2OKxLwDzg3hSnbJ65JaxCpbfVup8bpq
 M+eEw08SoXcye9buKhZrhOpOFjIqyNV1aenSxGld5T/E/1vjSA03ePHamK8tL7xYbumfo1beo
 X4EK+WOBA8O5KFnWa2qyjkcaK3WA8yFCgJO3X/cYywj7BWxzrK5Ku9k9S46LFtZj+QB6IeySp
 Hl7+S2SFC0zcGRnU3vSquPaDXbGJJaqnprqVaNwMPbvnRrkiuaONi9/CUBXrRjDgDDNWH/iKf
 nPN2jQiw8sY8SorTTpYaTxf35n6xML3b09RZSWng0QNw8bNARKY2sGKKzOD+GW6CQvGMVfCOw
 wRT9DyaJyvWRTEe4d8RzZyX6yTrelTNUGh2pPai60qmrWSy/iPs1w25TzbMrGjFuBIhrFd+Bd
 domilgq9COZgBHPlar6g5yssXIS8L/nP64mYKvxCZiaTH+SlucEbJakQOua+Jr3DIUMiSrvrG
 pW7oFOBn3A3v6akhdLQVS9Hq/ibl78tGjOi3LrFiQkknDfsxK4HnplPQEmITX5+BSiZr82iWL
 S5KRHGWWKyaWVbiO6jpG96Gpm5LRUj4cuvuMyZI28gdGnrk5n0mcDN9hRaTLmWD/h5M9D/kB3
 +hJjNywJ082TY9buag6CH4AAlYB11sNoSOnhr0r1M3eUDWRCMf1NIPNtB/ukCfRUMhqbGX3Ak
 yGUY90f0l8/Qf1Nsucifh8FxlXoMAdUa6z8mMC+pOSdBrZpz75f0tPaBauj84zzzXPyGYKOJY
 hbNzVzlapboJWvvYevaLlujr+OWMsz+O2MzD3EAS7VuOlwEhGC5C4vVaGoO0IMOUqOfURvme+
 DStJA==

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.18-rc3#n94
>>
> Assign the result of devm_gpiod_get_optional() directly to pcie->reset_g=
pio.

                       a =E2=80=A6                       call?


> This removes a superfluous local variable, improving code clarity withou=
t

  Thus remove?                             . Improve?


> altering the driver's behavior.
=E2=80=A6

Regards,
Markus

