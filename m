Return-Path: <linux-pci+bounces-44718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CDD1D937
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7C3D302A7DC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B156E37F73D;
	Wed, 14 Jan 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DMkdGUrg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45999389450;
	Wed, 14 Jan 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383105; cv=none; b=ovL28jB4jTvt1PxPJjlxuB8UMXVStcZDsramCFxEVuiCgVWKKYBrUYKht97b6d+U6u5c3R9H81TMwVG8v3OYVJ7xGEXBmDzjYhfkwTftQ5GWJwBVq6CoP5sqWQ/Gq0L2ZdO5bEIsuUbgwWbsdCP1pYK8geGJ7LCCw5ZKjHGrt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383105; c=relaxed/simple;
	bh=xtVmQ5119RF4QoCVt4mvjKofrkCpkP5iM7MoSjTlWR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hok0cJHJyLnF1oXBxR3TF+97PJCXloaldwBDcxiiOKIXoJlkYlWtfjg0EBqHzXvoaQ28yzuxRn10WbyC78nepWNueIfESVMCkb3QGb1xh8UBn7eva2NQH9W7WxYgr6GVNmYCqIU6H7X1WV8E/WsmsAOLtQLYyMV1m7fYhJLV5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DMkdGUrg; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768383097;
	bh=6vZsD17BQ123SO/NBb3/c2eUaHuldQjkCdNOqEN6qlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=DMkdGUrgnv8HzSZFtoNVzLZJkX8OHash8QkoXFpouV8uB6zgdk/BHStqlE009ktA2
	 xDk8HHWgRxVEyeDR09wpbfC51rdbw1mWAPUh0uwNGWrepRNRHbaVmo3dV3aLINaw6G
	 ZVAXFpqvu/TA6L1XTTI+BlYzfwEQoko08P1F10oU=
X-QQ-mid: esmtpgz12t1768383087tfae7d71a
X-QQ-Originating-IP: r7xfRQB0UxIMWH08ANZV7p4zzpdps0v409IspuxZ+68=
Received: from [192.168.15.210] ( [223.76.134.64])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 Jan 2026 17:31:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1787296510566603320
EX-QQ-RecipientCnt: 20
Message-ID: <371A5B60F8A4F60B+ba7a4b9b-0f00-48c5-af83-99027b36f81d@uniontech.com>
Date: Wed, 14 Jan 2026 17:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com,
 Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 kernel@uniontech.com, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>,
 Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, stable@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com>
 <vebnovol2s7cqigr3vq5kvapjsy7qiiusbtxqlq6qduxs4xxhk@afsqi4v3ur55>
Content-Language: en-US
From: Ziyao <liziyao@uniontech.com>
In-Reply-To: <vebnovol2s7cqigr3vq5kvapjsy7qiiusbtxqlq6qduxs4xxhk@afsqi4v3ur55>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NLtdpOCCFXReQINCpoH50gUTvNbndUFLeOdiBu0IKKz3HtFMdusNioDL
	R8y5Be3Fnyb2pUqSPX8ZVOEQHxUx1BqyMmcULN/7xUyMGZalpFmOe3qFfFMwTU7RzI2cMIM
	K6aYCA3pCtnsg2CgPEb3wPyiMlN/gtSclCPwJ11iNBXWyZMxT8cjMD33HuBMS5hGSjHPyFL
	s6qEZNhDAMmuqjGDDRvzI5JVFUjZDBJnYpilB4oc2PVc3JP+QxKikJ/j6N5O4EmD2zF46J3
	if2xX4s+HUKQKySQDLP+ac9EU6qpoZN7/lKALO52YekOLmFQTNqxv7pflPZwWALVEd8FjMS
	ATX+EM46qXRMQ4FMvndQXTlP0Te2c1KCDJ3YWH2hbj+0cTOAyiPNz+poYzWPz5ZtpGL105W
	1FSRUKyxik60ML/co7Ziav/JG7lbywhjEMhwVxzGmpUnmw751wnbquasH6tr9qhcfsnK0ow
	w7RMXQsGwL27ntySfLX0T8Z3kRTmIUtPllYhmuRApmHdmFTitm+h/4ovHmB6ivoghociHoO
	EkuBtO7IkG3cc8KFyvplNnNOAwYgmZDo9CIwcyv14znwi55uOTc2uIQdEQ++vqzOU/1mYcM
	3peqxHqxX469WMlPxI1pAWE+tbILUk6QR+csc+4ukMtU0KpFBaNbE0XnIolQwwYXtaBpFkc
	Y7yDxges3oplL+vptRf0C3cUEfYU1UnM5KogxY8mbMbhDj345UT2lPEBXLbzyYVDYJZsKYL
	sYxXy7U1vz2hUxzvdzfNaMZ24VPxMnNQV6sgcnR3wmpxnqThWUnUnSMK9bOP2Kru0faobsk
	tvtFr6Gg1hJFbh+c0LeqhtbcDNvMj7a5MDSsASdHhaYe7A6n/666UjVAxOG9GYZ/DU4FatJ
	8BrNnCowqPm7uRJ9NAbm8jPKk6qigY+A5FEfc34MUdnGr10A4ZaEWsZhhTaprtXPzd4y44c
	Dc7CHrd+/PyCe5hjbhj6ua69TbqPLS+G0HU8i65h1B51dQRIbSN28P7L640eKVa99QkTXrW
	xiJcZ00kZkcEgqTEyB3WQrd7b5lqX3kudy0vc0sIJ7VCGSAZvwQCa4L2f3T4V4iy4D8D5Qc
	hS3299gV5K/qaIWNy0F/RGyzNLnG8fb3DrL/lDwesby4Mv35DlBLybt5htP0N/6rA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0



On 1/14/26 16:12, Manivannan Sadhasivam wrote:
> On Wed, Jan 14, 2026 at 10:05:45AM +0800, Ziyao Li via B4 Relay wrote:
>> From: Ziyao Li <liziyao@uniontech.com>
>>
>> Older steppings of the Loongson-3C6000 series incorrectly report the
>> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
>> as only 2.5 GT/s, despite the upstream bus supporting speeds from
>> 2.5 GT/s up to 16 GT/s.
>>
>> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
>> than one speed is supported"), bwctrl will be disabled if there's only
>> one 2.5 GT/s value in vector `supported_speeds`.
>>
>> Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
>> amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
>> clocks and lanes in power management. We hope this can prevent similar
>> problems in future driver changes (similar checks may be implemented
>> in other GPU, storage controller, NIC, etc. drivers).
>>
>> Manually override the `supported_speeds` field for affected PCIe bridges
>> with those found on the upstream bus to correctly reflect the supported
>> link speeds.
>>
>> This patch was originally found from AOSC OS[1].
>>
>> Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
>> Tested-by: Lain Fearyncess Yang <fsf@live.com>
>> Tested-by: Ayden Meng <aydenmeng@yeah.net>
>> Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>> [Xi Ruoyao: Fix falling through logic and add kernel log output.]
>> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
>> Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
>> [Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
>> Signed-off-by: Ziyao Li <liziyao@uniontech.com>
>> Tested-by: Mingcong Bai <jeffbai@aosc.io>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> Changes in v6:
>> - adjust commit message
>> - Link to v5: https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com
>>
>> Changes in v5:
>> - style adjust
>> - Link to v4: https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com
>>
>> Changes in v4:
>> - rename subject
>> - use 0x3c19/0x3c29 instead of 3c19/3c29
>> - Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com
>>
>> Changes in v3:
>> - Adjust commit message
>> - Make the program flow more intuitive
>> - Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com
>>
>> Changes in v2:
>> - Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
>> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
>> - Fix falling through logic and add kernel log output by Xi Ruoyao
>> ---
>>  drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index bc630ab8a283..a4250d7af1bf 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
>>  }
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
>>  
>> +/*
>> + * Older steppings of the Loongson-3C6000 series incorrectly report the
>> + * supported link speeds on their PCIe bridges (device IDs 0x3c19,
>> + * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
>> + * from 2.5 GT/s up to 16 GT/s.
>> + */
>> +static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
>> +{
>> +	u8 old_supported_speeds = pdev->supported_speeds;
>> +
>> +	switch (pdev->bus->max_bus_speed) {
>> +	case PCIE_SPEED_16_0GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
>> +		fallthrough;
>> +	case PCIE_SPEED_8_0GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
>> +		fallthrough;
>> +	case PCIE_SPEED_5_0GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
>> +		fallthrough;
>> +	case PCIE_SPEED_2_5GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
>> +		break;
>> +	default:
>> +		pci_warn(pdev, "unexpected max bus speed");
> 
> Dumb question: Why can't you just copy the Root Port's 'supported_speeds'
> directly:
> 
> 	pdev->supported_speeds = pdev->bus->self->supported_speeds;
> 
> - Mani
> 

Although just copying pdev->bus->self->supported_speeds would be simpler.
We're concerned that this approach assumes the upstream port reports the
same capabilities as bridge, which may not always be the case in future
silicon revisions.

Our current conservative approach ensures we only enable speeds that are
physically supported by checking the actual max_bus_speed. For example,
if there's a future Loongson-3C7800 where the virtual bridge reports Gen4
support (16 GT/s) but the physical bridge only supports Gen3 (8 GT/s)

In this scenario, directly copying the upstream port's supported_speeds
would incorrectly report Gen4 support for the downstream bridge. The
current patch ensures we only set speed bits up to what the hardware
actually supports, based on the measured max_bus_speed. This seems
safer for future silicon.

Best regards,
Cryolitia PukNgae

>> +
>> +		return;
>> +	}
>> +
>> +	if (pdev->supported_speeds != old_supported_speeds)
>> +		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",
>> +			 old_supported_speeds, pdev->supported_speeds);
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
>> +
>>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>>  {
>>  	struct pci_config_window *cfg;
>>
>> ---
>> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
>> change-id: 20250822-loongson-pci1-4ded0d78f1bb
>>
>> Best regards,
>> -- 
>> Ziyao Li <liziyao@uniontech.com>
>>
>>
> 


