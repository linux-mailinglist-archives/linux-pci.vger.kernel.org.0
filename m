Return-Path: <linux-pci+bounces-42239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D71C90E0F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 06:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181533AC5F3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 05:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05BC2AD3D;
	Fri, 28 Nov 2025 05:15:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D43168BD;
	Fri, 28 Nov 2025 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764306957; cv=none; b=Sjy1iQYl63S66itTmxNUWO1Y8YMIFB99DBpKJRn3/me1kFSTd6XhjnX7As3Xz8ehyR0e20YmMGT3+/5KoHe4sS/cYSBkhsXphyfq24EowqXblwD85xEizQkMX2NCY5g+kfdyr2egY0RJ2Iqp0uz87XGXgrcCAbO9ip93Y0Sne/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764306957; c=relaxed/simple;
	bh=yKhMpqKNIaoHU0/7o1QhgGEnTWDqfaMrkvyzRPoPoSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhNF/9ifOLH03DRtBg5yk8CxILd1pwchwZU89p2I8GPVnaA/1C8j1q6Oo5VWiGOdu+NpePPgvQuxWCHfgaff/+qzJt4rQ6s7ooA6nbc0Spbk9BewZT4e12oI0UjJ1YoKSb8QEREsHrclJGSipP55axo1O6/S0jZCZIs3cM74Eew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1764306931t09c9b483
X-QQ-Originating-IP: xUrhIoZX/6tn9sXRO/7GnvHddUx4UhJcB3arw2WWo4s=
Received: from [IPV6:240f:10b:7440:1:54db:6346 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Nov 2025 13:15:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11110066794902672146
Message-ID: <585D6D29DF1A6436+9b5db091-8d6e-42a5-ab8f-4b152f82ac54@radxa.com>
Date: Fri, 28 Nov 2025 14:15:28 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <aSRli_Mb6qoQ9TZO@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MF9wS9BzufCcp0dsOaH1dsjD9dyixROn/YHo8YgdFFw5v/81Rt+qfc/b
	p9Y0hAgQWbcoGQTV6aFIj5lQVCoWCrtcnhjaRZx3xfVRseiAtyvqDtXfIvoo6GweIxBSDZp
	XcHpBNf5FYVQ6TAF7A2hgedA4YWNB4ZhDJBGGpWPTaONChmS6ueFClHRK6JbSYXJN/FR7z1
	+ap/5pCFbm/yqthfdoRR036WHfGn5miVxeFbs7ZPwpQE7d3/TaeV1sMyc7eG9ZXNupk40/t
	soDaY/lQwVkVzPsMUu+F7Giw8lS+Bf8wGIolFT3LZ9YSFV9BtoEqOqchjbu6/mqOFH8eJxk
	OEltwmxh6iBt2frzQt9Mn+PdaIdTGNB9oKk1Cw/aDksUM1NU07wpXN0BG6JTuJiKmiSlgUA
	o/0cKBFhWqGGc5GukDFTEMiDW0XwIr4Go1JHNJIgtzwXuM6la1aqmcvhwyurs0cpBSIQ+T8
	oE42dTv6uexg+oG6TDJ63S7VK+SViBpEojqTW/XYjfz5j5hvUe9VuejmONN18iqDScmvMvI
	v4pLdN7a/VkZW9z7Um13DHOAZoT6Xxm0Ipqc/huf+6f1ZRnR5cbeAxfmfGCeHjO+lAjcJ2+
	+t8SHf0I7/Grbe6riqcc6tIGC/Crv7aimLKWoKaOMHclkp0dqQam8VKN5YOU7PUk7DtlSlf
	UGe3jaPdv1b9YHnI2NfbxKjxG9F7APJ271DrABHz2VOf9rFfeeD4JcjSzg+qfzkFH3AHl5/
	4VfNneXrRC3EmDKpshtqWSQOt/rFlrVK5kzICbfDnt2bhfosPGhkExS6giGvya6klYnE+QT
	Elov+RnOuEcFE/gD/lDZAetE2kpyZZiikjvTad5YH3QtJ4TfYj7BcNi8AYrqazeV3+vQEHg
	dOymaOudK1nGE4pIaeXVF0ae1rOkbQURAuWeaYQZcOzAoYt2wtCedJ54DVQxki9i+77y0ga
	cuoHBhQraO5msz0xATSi+bH4K28NHo7UfAiiTRDvVzI9D7IKY2bwcurMBHpnWF5GmAHXKtp
	ZjzkDutq/oUEKHjk5fxH2nSYMrS+M=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi Niklas,

On 11/24/25 23:02, Niklas Cassel wrote:
> On Mon, Nov 24, 2025 at 06:07:44PM +0530, Manivannan Sadhasivam wrote:
>> While I suggested to revert the link up IRQ patch for rockchip earlier, I didn't
>> expect to drop the support for Qcom. The reason is, on Qcom SoCs, we have not
>> seen a case where people connect a random PCIe switch and saw failures. Most of
>> the Qcom usecases were around the M.2 and other proprietary connectors. There is
>> only one in-house PCIe switch that is being actively used in our products, but
>> so far, none of the bootloaders have turned them ON before kernel booting. So
>> kernel relies on the newly merged pwrctrl driver to do the job. Even though it
>> also suffers from the same resource allocation issue, this series won't help in
>> any way as pwrctrl core performs rescan after the switch power ON, and by that
>> time, it will be very late anyway.
>>
>> So I'm happy to take the rockhip patches from this series as they fix the real
>> issue that people have reported. But once the pwrctrl rework series gets merged,
>> and the rockchip drivers support them, we can bring back the reverted changes.
> 
> FUKAUMI Naoki, just to confirm:

Should I try
  "PCI: dwc: Make Link Up IRQ logic handle already powered on PCIe switches"
  https://lore.kernel.org/r/20251127134318.3655052-2-cassel@kernel.org

instead of below approaches/patches?

> Neither my suggested approach:
> https://lore.kernel.org/linux-pci/aRHdeVCY3rRmxe80@ryzen/
> 
> nor Shawn's suggested approach:
> https://lore.kernel.org/linux-pci/dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com/
> 
> worked for you?
> 
> 
> If so, I don't see many alternative but for Mani to apply patch 1 and
> patch 2 from this series.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Kind regards,
> Niklas
> 



