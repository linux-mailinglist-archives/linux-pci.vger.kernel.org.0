Return-Path: <linux-pci+bounces-37926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1324BD515B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 322DC5027F0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC530CDB0;
	Mon, 13 Oct 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="HAWh8pZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788C30CDB5
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369944; cv=pass; b=lZ5rghJjn/f4enL2JR50fGTkIjhHUogrvqcVp6l3ffPggsyZKCZB+j1qcPFEnEXq0sdAlDRyjRfWWLnhrGVVT2tokQ8eCoD/ZvPeUeTZyHSvvBHFwAH66Y/g7PE7cSC/1s92xaU3xbjtJWqantMPIyMwRbqwaQlwtR131wMb+7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369944; c=relaxed/simple;
	bh=pZoJ+aXFNmr86DL1Lk0XbQsR1qZreDFe5WSeKJQhZNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=isuRP6xLbM8oJfNhcVCkVp2yTa+g1q4q0Y8cjlLq8y35YvpS5LEbQfQ/g9QuSfM5QhHlRHPRItx4o7901fY0wL27nIFIYW2ZtQ7Qg1+Pr4KHDqlyQT/xRD2lw4uy/Umak2JBPKGuhPkWgnIxV0N6F+YBNeuYg+iIHniqtHjjmqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=HAWh8pZB; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760369913; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sSIQKcycy2lIMDZGvnDXeAvGT3CXj1uS8mXJux6o9ydF5Ef5A/Os+5LLwgDT+BZ5UU
    RSfrHs8b13SETiQtdqVCIdNQ6DS1moIEF5h33Sad1Od7f5sLpiwg4MqrBJeZnwmbgUQA
    3WNiXxJtwiZowZ/FZLg+qhOEKH5Gop2IP2vOaQJdZBWc1M9UhGdQLZaubB2J+KIE7yWe
    MNyMzhBbHxwXIl6dGJPt8z+6ymubfSqVk1LR+9SL8xrdBIoSc/WOjHki7VvZays8EfLH
    iU93kdnvDndFSwayu2C7sgqTCZyd6qvhl9XhgyLBXeJjBoKu7RKVM4FrzXwlYGwLN9SU
    FyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760369913;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LKE/O4y7+1OfjekBVid8dxAxNfUPFbbVDY0FXJfXgIM=;
    b=r2Shdy48+BMtdRA1K0ev8ssncKhUAaZZUPzmfo7vL7OabtgTkGkMYa3x/e1AbM0tFI
    yre9lOY+euIZvS48npfNEZ59OhPUJe6Fnh5atSg1i4MJ7F9aDQXxkQJC2Ngz+Vg6FU/z
    iR80ko7x+VEitF58Bll1PabSmc6dSdwFwu7OK2qI6/R6sYJbh69C1yENuJ+mk3WuJDO4
    8TPm90G1kZy44FFpe8bRW1q5dk0rwIhao2toAxWyf2IIf3M5iM1VMLLyrwDysIDAXt8X
    Yc5IB/yYQGHX5wqZaSUFxTvkH2jIQdpXX4Q7P/hfaYAwKv8GbtXOxeYkxKUPidaQsF6p
    FU6w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760369913;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LKE/O4y7+1OfjekBVid8dxAxNfUPFbbVDY0FXJfXgIM=;
    b=HAWh8pZBUa95i9mg0UgBX+TIZDbJD/RP9zD9tCr1JAB9Yl3N6vXDiXYHwk11F9WaqY
    m+H927qspm5OP98uGt/X6mwMhRAHDmJZx5ZXgRwJlroJ4dOKce503Pc1fI7urJR/Zcfu
    pPORTgKiVSE7RM7yCYG8/NnHM+vlxSZMjTONs7tTSQll5vII3N/AhptGAJiTkBhQ9RQ8
    hylj0atcPC6/VAhLug4KnIS2RSJbXHpZrfgj2aWwYJNImUmHR1x4udybZ8YI/+Ezmd4m
    1obt9EMCjzcrljTh3/LY0UVjxwABETlGtcGVYTSug8qHcQ/h7DAOIaJsuWyo23tDaHLf
    CoVA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+m7hvg"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619DFcWPXQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Oct 2025 17:38:32 +0200 (CEST)
Message-ID: <49e1adf6-3b14-4f14-8c99-9e92c549c8c0@xenosoft.de>
Date: Mon, 13 Oct 2025 17:38:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org
References: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
 <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
 <3fba6283-c8e8-48aa-9f84-0217c4835fb8@xenosoft.de>
 <69dc773c-e059-4a2d-96de-5e2952dc165c@xenosoft.de>
Content-Language: de-DE
In-Reply-To: <69dc773c-e059-4a2d-96de-5e2952dc165c@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13 October 2025 at 05:02 pm, Christian Zigotzky wrote:
> On 13 October 2025 at 04:50 pm, Christian Zigotzky wrote:
>> On 13 October 2025 at 07:23 am, Christian Zigotzky wrote:
>>> Better for testing (All AMD graphics cards):
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 214ed060ca1b..e006b0560b39 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct 
>>> pci_dev *dev)
>>> */
>>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, 
>>> quirk_disable_aspm_l0s_l1);
>>>
>>> +
>>> +static void quirk_disable_aspm_all(struct pci_dev *dev)
>>> +{
>>> +       pci_info(dev, "Disabling ASPM\n");
>>> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
>>> +}
>>> +
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, 
>>> quirk_disable_aspm_all);
>>> +
>>> /*
>>> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe 
>>> Retrain
>>> * Link bit cleared after starting the link retrain process to allow 
>>> this
>> This patch has solved the boot issue but I get the following error 
>> messages again and again:
>>
>> [  186.765644] pcieport 0001:00:00.0: AER: Correctable error message 
>> received from 0001:00:00.0 (no details found
>> [  187.789034] pcieport 0001:00:00.0: AER: Correctable error message 
>> received from 0001:00:00.0
>> [  187.789052] pcieport 0001:00:00.0: PCIe Bus Error: 
>> severity=Correctable, type=Data Link Layer, (Transmitter ID)
>> [  187.789058] pcieport 0001:00:00.0:   device [1957:0451] error 
>> status/mask=00001000/00002000
>> [  187.789066] pcieport 0001:00:00.0:    [12] Timeout
>> [  187.789120] pcieport 0001:00:00.0: AER: Correctable error message 
>> received from 0001:00:00.0 (no details found
>> [  187.789169] pcieport 0001:00:00.0: AER: Correctable error message 
>> received from 0001:00:00.0 (no details found
>> [  187.789218] pcieport 0001:00:00.0: AER: Correctable error message 
>> received from 0001:00:00.0 (no details found
>> [  188.812514] pcieport 0001:00:00.0: AER: Correctable error message 
>> received from 0001:00:00.0
>>
>> I don't get these messages with the revert patch. [1]
>>
>> -- Christian
>>
>> [1] 
>> https://github.com/chzigotzky/kernels/blob/main/patches/e5500/pci.patch
>>
>>
> 0001:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0451 (rev 21)
Solution?

+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FSL, PCI_ANY_ID, 
quirk_disable_aspm_all);



