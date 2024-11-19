Return-Path: <linux-pci+bounces-17091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDA9D2DA9
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF121F26E30
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD01D1519;
	Tue, 19 Nov 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ps2nGElN"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B791AA1F8
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040003; cv=none; b=jpyk32Rc3m7+5vaXtwHUOpsVEgynF3dT5bNjFjg+vdfHtY/W99svQjL1Z9+rQ1jHQDuY9jTqj0sYhjliHWaJflRk3gD3UOwwZioZ4LSfj1K3hhDFpuMw/nHlgbeEofvn7TE+YOHnsO/G34MzPmLXFHXglGHpzdVQZzVj5fjs1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040003; c=relaxed/simple;
	bh=0HJkN7+2u50/YehdRvmh47pLWH7VrHO0R2G7yc3J3As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR1Arjph+Et/qVdnixloSOH36GzG1wcAN01MhNcs1Awxz3IMOP7yDYvWbJlqbxzxEKu6ENOkP0ZeAZruTrYeWWOwtS2dOsFjCFtvi0+kzRYOZreBqAv71fTjSaWijxaeSiMRAeNMftbJdvlJvDrVGxefY/UWsdjT/OPgwvjOSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ps2nGElN; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732040000; bh=GJwydUuPh/N93fZMFloFRLM9kTfuMhVAKo3jBCp3xJI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ps2nGElNmfmMPKWFK1OdQK1ADtFduX3UJvLtwynjBQs7NsjYcpEV5Op97A7+3MEiRd+ZZ67ZCaEwdnTgilgsBM8TXuXkkWITTJ1aT+NN4X9DVbu1badc2DyeDmb5woGJD77x6B0iz+zkBmLPKA7Fkv/dkHi2IyUoLxIKMCukcnqOCav+wYp48kpXLf6Gm6SE7q+K399xSo0TUyjED7he/BYuZGu8ngqRztNyTJ9Ovv5wK/N0o8IIsYAw9JM3NfVHxBhg8kVzry02bSANwpycJljWM3wvrwYvM8TFs8FmeNaT03+C5Wo9HksbOH2TRWXLyjm23D/zEV5MQ0hEaVAevA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732040000; bh=mRw/yEA0mAgcBlHpozVIeMzQpnENQAKF20YaU8NxteW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=I+Yyu4DvkoVlkhI1V1wuOy30Zg+H6LfTXKg1omiXT8PAbC6r/lcVAh00YzN5QzIc6y4hjD5FANCyl2s0DJIYVGDYevgW2JMNNwq9jcQ2T+r+OX0EfI1I7EXrY6RqQ3YwQX8rVq0UD4JCuMVpGglDn5XnHYVo38IknadaKZH9VaK+/hxHWVPWUuRTKmDnI3wuYz0icCGjXf2SaElNE6MJx2liCP9XGFEfrS9T86VS1PEjhPJ6/l1Edwng0KRjfGQNxbniSDXDUhhbnmoGdwc316YXoQkWqJ/0pdaQslnq1rN2S5GG6sbGyoDhcfuf9+8+SkJ7jimMxlMWfN2Q2+b05w==
X-YMail-OSG: p_RJr1oVM1lwCDw4b6KBWYTwFUL5XOl0eMaurC5Gpa4Mivq7n39mqi_GGdjHBoU
 NANGldV1zVixbo.xBDnev9lW3ZFcQGBLdh7J5oF0HG9hFMt6A76tQ3AMKMKDuM74PzuEoSv.OkOw
 fNTvcQGQDUEtV0k14qpOA97zUB2FnMmz6cHsYVdkqaAimtYSHDTK3wHX.hBDzoDWLjY142pTufjT
 55VoBDWOKG9a2H51RtOIeZ73dEfGj683m.EfmvkonZLmuN0vYLqxJhmshiByT1R.xLArYwcxKUzG
 uFXZmh3Jyl1wZU.Wh8K8sAaFE72iuZLB3VxeMV2LxoU3mlBKjY_YjhE4jmFJ9HtAvL_dvUG1HI9Q
 YrZN7UdJlueA_YqHEhEOeCR84w9kylH384LFv3Z8SC3JVeOpHXmSsjxedfIgoP9j9QRZ7Gp7yFFC
 p55rNSjQe1dxHXPxxVXZMAcU8ojkMbAlfiS4_PEAUyw_XSpjsvSJKYxp8uaKV7f3KDdqtwfduXfj
 0TroyFMPx6TOiNn9l3kBSrAXNmFlYF3TPGSubH1NGQCW6FgeDxzc562qBlLXk7Um8O7sLi16QK2O
 uCavvJE.R1dkJBkEA8a.P6pga2inK_GV4a5vixaAOav06QpZmDS_cmOI9dZzlkRY0jZu76XdI1Cv
 ucK9vlJsKwdbXukzg15z7ZM6fp5HV.GdPw4QH72K9oBUYQrllbcD0_09zuIBIAY0wYSHW3v7TNR0
 2iON5dwMseSqoAyl8aUfS4cwnQu8vIdt_AInrbJUwIFznhGK.9GZQ_hOkXbuuC0eslE6KNtzioHQ
 gt3MxFISzWtz7s38KdWDXCNZG4._GCUCcgAXUyyH5.Mzs1djrQttYSXINNFdt8QrqUcJt0X4OvKG
 PEi7zcaz6tbO51mVzZ_QtuAdDKD95NPL6WC75ZF2x3jB9p2VmH1umPhajhwEAPnkG4GSfJKq7qWO
 l00MapNa_GqICmygBSzV9WJhxUJnY1tsAVOO2MEwWeB75H5omX_1cOzyaaGJOLvIy99gkYnbedV3
 BJa8QfUYFSr8sUcuknxxwBfpw5Rux_cg7kW1Op4yPfqsCFrDdWrqE0YZrkBy5jKD6yKortpE7UxM
 2mNfkTh.Aj_7SDYO6n7GLG0JPgOx8lM0ihs.iqFR8A6c.HPBud9l4MEv0D0zgwTw2DqWA7zyk95B
 2WrdNRqRXTrRAzGR67RiHtpwldGrTUDjHqjxjDLvKNunuBGFV5vL0rJrlnYiEpiYTeLrX3pwgipn
 EX1hTNMoSeSuAWjoS5.AsWXZfRFcnZ9XCusxQcG17.XGvgX15nLAEmMIN0KdiA9OFqo5L104zaug
 b3SUShwmfDH5cGsBys7YLbpNo8x3xdxOfMxBOcFDPvuPTDF5Fu_YXvSdSOdBla7C7rRFB_2SGwbG
 FhBwLHvXe5Ocn95dDwFgqA442AU60JSU8YrJsydWJB8oSqGtoRrlO6L69qR.0CUl68r3seicSK0q
 551HIwZuIKeHbRpdUUEapE67qJfHQNxvhQAYoQiaxOg9XVOCswPYeK1dvwEGJL62s0SCmO_bdVfK
 rdtdRBBSzP1VJLcAPjYzeEnFgUPAZFiKPqeoRSfVJu68uFUaaFcjT3odcsQsrmkFXBoJRBoNwqL7
 pp8v_QQpaMY2J_YaVZh.AZOdX17d5HdY0UVgF0LQHnCZFaMsKWmuLM8ygfnhQ106DeV5IjRg0s25
 jl3O58wfc14wmxItkHmVIQVWidVibpQ1mU2j1uurwrV29l9MGXZX5UqLwG3pp5I4KJwa7gHATdOW
 YHKUS9FqHrT8exJfb.W08Uz9nbBP91LG4fq32qf.lVnA2rEWVjb1Iep0629r96Ps6GmKCpN3pStb
 m9V.0.HWbO3nSdRCYKTPbJEAJW0Qjm4MN3wU6SxiREJM5S6eu6ein4vqKv25oPKCEIl4Lg5mLsd2
 eV1.WFVaWsJtcvBTm8APztggUQgTh3GJsxCOgan3RB0uY_tWH01hbzVYUDt940UF2QpS2EyY3qkB
 7i3JLhIN4wDITSmdaehhk4nYn41Ghcp.E5QcH6lF.Lzzgm_.uH368MHdD1kcQ3hK9S09nhxX00_Z
 NRqvnudVNRmzyiywv79jKYdblvr66dOhmd8JWW8htVBA_IkK9NU82nx23_ufLISRZbv7xf2fRPxH
 cuoczENsU4441TmFw0RouqhEC51skIoEAX9VaM7v5bvPoFelYupjaKq5ExPEZyYc_Au4Ae9kjCl4
 TfCYqzd4ZfwFqFAqIArBSRWmsunYDMHoH4YPD9TdWOt0O0TqP33_DiVpCv.cewPk-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 16354778-47a9-4f9d-b183-e2dfb95c32c9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 19 Nov 2024 18:13:20 +0000
Received: by hermes--production-ne1-bfc75c9cd-8mffj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3bbe035affb662dd49e62af0a67f1984;
          Tue, 19 Nov 2024 17:32:50 +0000 (UTC)
Message-ID: <084ce275-34db-4243-85ea-4ef2f6ba670e@yahoo.com>
Date: Tue, 19 Nov 2024 11:17:32 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219513] New: PCIe drivers do not bind
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org
References: <20241119140434.GA2260828@bhelgaas>
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <20241119140434.GA2260828@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo



On 11/19/24 08:04, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2024 at 12:55:36PM +0000, bugzilla-daemon@kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=219513
>>
>>           Hardware: Sparc64
>>           Priority: P3
>>           Reporter: dullfire@yahoo.com
>>         Regression: No
>>
>> Created attachment 307241
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=307241&action=edit
>> debug info (some shell commands to check the PCIe devices and drivers)
>>
>> In linux-next (next-20241118), since
>> commit 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed
>> before the PCI client drivers")
>> PCIe drivers no longer bind (at least on the tested SPARCv9 system).
>>
>> It appears a "supplier" devlink is created, however it is are dormant. see
>> attached "bug-info.txt"
> 
> Thanks for the report.  It sounds like you bisected this to
> 03cfe0e05650?  Can you attach a complete dmesg log to the bugzilla?
Yes, a bisect pointed at 03cfe0e05650. After finding that I tried the patch below
to verify, since a trivial revert wasn't possible on next-20241118, and the PCIe
drivers started binding again, and everything seemed functional.

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index b0e3cfdaa276..6d87773784b9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -404,7 +404,7 @@ void pci_bus_add_device(struct pci_dev *dev)
         * PCI client drivers.
         */
        pdev = of_find_device_by_node(dn);
-       if (pdev) {
+       if (pdev && false) {
                if (!device_link_add(&dev->dev, &pdev->dev,
                                     DL_FLAG_AUTOREMOVE_CONSUMER))
                        pci_err(dev, "failed to add device link between %s and %s\n",

Obviously not a fix, but it did help verify the issue.
> 
> This commit is queued for v6.13, and the merge window is now open, so
> if it's a regression, we need to resolve it or drop it ASAP.

Regards,
Jonathan Currier

