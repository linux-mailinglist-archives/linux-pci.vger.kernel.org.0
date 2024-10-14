Return-Path: <linux-pci+bounces-14440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857899C60C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD071C22DB5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D97158533;
	Mon, 14 Oct 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P29jx4ez"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843D157A55
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898879; cv=none; b=DO2cCaUqrjJ3YbPhVG37mjUU9wWGGtArgZFAx7CnbxXTlenhKEb9D1nm3JY1bmzKciMgIqJ/pFllpgDZvFwGIN0PJbiTdkeMUGcqadDys18k/0FTnOTj7Sj42y1Gm0kgoGtmDYOWoIEruPXhqmZpwJ1bn8b9PF6M76gREzajK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898879; c=relaxed/simple;
	bh=eZf7dR74XL6mrzGdl8l8SEYOdtNcaCMB3YOa6+aD6i4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UkwOvU1MoFHEAtobFQMTypyyX78ZvvSTif014fsVzsPA6UQJ941x+veKLHQ5zYq+sL5jEVfsLrBJ2WMlNmAI3ciuVopdLWwbK/f/+xaRgNxWL5E3pOW9WfGA+VQDwddSU2ryhgyn94JQq5M2HeyWE8F15lNds//4/7j4OToW0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P29jx4ez; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20bb39d97d1so33919645ad.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728898876; x=1729503676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGDcajQQA28uSCWg1Uq1p5tTF+iHCeqbkSKa1TTSEnk=;
        b=P29jx4ezLaWksByMxqwRJ6uSftkFFHMUk5EopAlvEsmisfMExbu/54ctyIEp7CQUpw
         mKv8XD7L9XX7gBtwtNfXAm9/8fXELFas+3QzXLWnWOYB8zemd9ZnZg0O56/FYRUvTrGR
         xDdCpYJa2qPQKwpWaQ62czOhh37Ta9ZVf0Y3E2tSwJBl+wbRzLSOQ/TAZj6Dj+lTExck
         qkvkjBj/Z/v1ofSy4vz+RFiS76+PwIqHt/Nt5LMIVSpWbt2BgRAAnvv9SwD2CJ03Pv1C
         jOb167UHZirVtowC/0uQMer7o/UbIuMVTSsUcL+DjY85YxpMwhjroKwYgMnQ9u9bYEOc
         6+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898876; x=1729503676;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGDcajQQA28uSCWg1Uq1p5tTF+iHCeqbkSKa1TTSEnk=;
        b=QpP2ZrMMphFo2PC7t55TZ910xi9ugENe2qSW9ACLS5Ia/f+DAqsvSFL2RZoU3kYY2l
         Zr8HQisEVAklhSFm22YWbJbW763uSdNzHBTCUtA8e2Qj80rtNfLiTwzREHmxw48gniWd
         XbnJKy6YAFWyj5c8ERxSNr1IarzdEokUc4wWiSry4Ny97YGJlxoQASFjYU01O8vc7nvd
         GFalO47wXRM/7EXSJhSgIIf3EqEqyuzvPJAoSVN0dBh7h1riN0zP4o4TNonJErf+qISe
         L8pczvdgshjVMjIHYrvJ6Pg3UE6bHRj00avIweVZCOJkVSK7hIqQMB2sSRgWM246kO58
         4OOw==
X-Forwarded-Encrypted: i=1; AJvYcCU8KvY0x2uGjgPQNrjAsbP7qhBw3BnCCdN48z4+wo0jbyrIl+D9+v9lPFa5iZf/bxDeVYDQrJH+RJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUSu3pEkR3amiSktI6+ITPZ9WOGGn3J9QyXt1Ndnq2zeYB99F
	KHvNWKWwe1AlcgCqlOG4so3CuQuxbVBOlOrIyFumeFOqXzoAGkWuGvgjpahSdA==
X-Google-Smtp-Source: AGHT+IG5QpPcViQF4f0Xw3WtPhXc81C6M52HaQ2+YsN4SPnIJxZOkXsW8b58YYaVxfzSsSpYyoxERA==
X-Received: by 2002:a17:902:d510:b0:20c:b0c7:92c9 with SMTP id d9443c01a7336-20cb0c79859mr120943595ad.34.1728898875836;
        Mon, 14 Oct 2024 02:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21d953sm62321315ad.214.2024.10.14.02.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:41:15 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:11:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
 quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, kw@linux.com,
 lpieralisi@kernel.org, neil.armstrong@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_3/8=5D_dt-bindings=3A_PCI=3A_qc?=
 =?US-ASCII?Q?om=2Cpcie-x1e80100=3A_Add_=27global=27_interrupt?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ea7c1390-7ead-4c17-9ae3-cdcc9866332a@kernel.org>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com> <20241011104142.1181773-4-quic_qianyu@quicinc.com> <eyxkgcmgv5mejjifzsevkzm2yqdknilizrvhwryd745pkfalgk@kau4lq4cd7g3> <4802B12B-BAC1-4E99-BDFE-A2340F4A8F24@linaro.org> <3d1d0822-da66-44c8-a328-69804210123c@kernel.org> <65B34B14-76C3-491D-8A58-6D0887889018@linaro.org> <df6379c6-662a-4b35-a919-13c695a869c7@kernel.org> <20241014090251.r4sfaaxtasokv4oi@thinkpad> <ea7c1390-7ead-4c17-9ae3-cdcc9866332a@kernel.org>
Message-ID: <B716D0B8-2B9C-4FA2-94F3-038F1C634244@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 14, 2024 2:56:58 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
>On 14/10/2024 11:02, Manivannan Sadhasivam wrote:
>> On Fri, Oct 11, 2024 at 06:06:02PM +0200, Krzysztof Kozlowski wrote:
>>> On 11/10/2024 17:51, Manivannan Sadhasivam wrote:
>>>>
>>>>
>>>> On October 11, 2024 9:14:31 PM GMT+05:30, Krzysztof Kozlowski <krzk@k=
ernel=2Eorg> wrote:
>>>>> On 11/10/2024 17:42, Manivannan Sadhasivam wrote:
>>>>>>
>>>>>>
>>>>>> On October 11, 2024 8:03:58 PM GMT+05:30, Krzysztof Kozlowski <krzk=
@kernel=2Eorg> wrote:
>>>>>>> On Fri, Oct 11, 2024 at 03:41:37AM -0700, Qiang Yu wrote:
>>>>>>>> Document 'global' SPI interrupt along with the existing MSI inter=
rupts so
>>>>>>>> that QCOM PCIe RC driver can make use of it to get events such as=
 PCIe
>>>>>>>> link specific events, safety events, etc=2E
>>>>>>>
>>>>>>> Describe the hardware, not what the driver will do=2E
>>>>>>>
>>>>>>>>
>>>>>>>> Though adding a new interrupt will break the ABI, it is required =
to
>>>>>>>> accurately describe the hardware=2E
>>>>>>>
>>>>>>> That's poor reason=2E Hardware was described and missing optional =
piece
>>>>>>> (because according to your description above everything was workin=
g
>>>>>>> fine) is not needed to break ABI=2E
>>>>>>>
>>>>>>
>>>>>> Hardware was described but not completely=2E 'global' IRQ let's the=
 controller driver to handle PCIe link specific events like Link up, Link d=
own etc=2E=2E=2E They improve user experience like the driver can use those=
 interrupts to start bus enumeration on its own=2E So breaking the ABI for =
good in this case=2E
>>>>>>
>>>>>>> Sorry, if your driver changes the ABI for this poor reason=2E
>>>>>>>
>>>>>>
>>>>>> Is the above reasoning sufficient?=20
>>>>>
>>>>> I tried to look for corresponding driver change, but could not, so m=
aybe
>>>>> there is no ABI break in the first place=2E
>>>>
>>>> Here it is:
>>>>
>>>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2E=
git/commit/?id=3D4581403f67929d02c197cb187c4e1e811c9e762a
>>>>
>>>>  Above explanation is good, but
>>>>> still feels like improvement and device could work without global cl=
ock=2E
>>>
>>> So there is no ABI break in the first place=2E=2E=2E Commit is mislead=
ing=2E
>>>
>>=20
>> It increases the 'minItems' to 9 from 8, how come it is not an ABI brea=
k?
>
>Interface changed but all known users are still working, right? "Break"
>means something does not work, something is affected=2E=20

Hmm=2E I thought you were referring to the DTS warnings (for old DTS) that=
 come out of these changes=2E But for kernel ABI, yes there is no breakage=
=2E

Sorry for the confusion=2E

- Mani

> I might be missing
>here something, of course, but I simply do not see any affected user here=
=2E
>
>Best regards,
>Krzysztof
>
>

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

