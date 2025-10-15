Return-Path: <linux-pci+bounces-38184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340DBDDB58
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4681C19C11CE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36E331328A;
	Wed, 15 Oct 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UpuWgW52"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731107.qiye.163.com (mail-m19731107.qiye.163.com [220.197.31.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCE1A23B9;
	Wed, 15 Oct 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519817; cv=none; b=WvGwVOkU93JOk5C7xpBwa5mmEilAYnd6o8NYODoUaq0ycDfJTzfuIM7Fhtr1k+qQTFQpzmEC8FXfRfjrdM8B0bXiS7B4cnaVmSdpKhzaWeq2rPr6R0QRakWQvyN+iaxaVutjz6EreGuq+1aAxCEyVS+6GzwBxIgfyMD4A8FClnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519817; c=relaxed/simple;
	bh=zKwKkBX4XV9eaDyOL8PCXy6aURO6hN9vVivVhQGvMeI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qkKnMzbChaC5vSmqC8nbNcolAKBIvOqmMkkXIjNQOWOdbNBdJ5MfxObT6uBoHM0q8Ony1sIqvtGwTUjvSPBO4sHy9Z2lM+u4XQUh3wawgY6B0ryEXnqtoxZM+Bh7nsd5e6P8uiAl6lZCXlFHua1jQuKe9etkL8x018kwHHCXj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UpuWgW52; arc=none smtp.client-ip=220.197.31.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25fe09fd0;
	Wed, 15 Oct 2025 17:11:41 +0800 (GMT+08:00)
Message-ID: <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>
Date: Wed, 15 Oct 2025 17:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
 manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
To: Manivannan Sadhasivam <mani@kernel.org>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
 <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e723b5cb09cckunm9e8b9439648be5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEJJVk4aSRhMQ0saSE8fTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=UpuWgW52aHOlfv7QzqJdgKHIAtosG3wgzwhHN5rqcEzVPZvHuk8MNpCi9eh6jE+nnJUBuhEnDAt+v9PzjTnfkukeb7ou0GZtzBco7DmcUN922PskTdISP4ug3nmn20397LELaoL17SxL71wTEUpDubWJTZc9QWct9sVHaqT2MiQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=tT8mYx9r8D/U1veSLAJ/A6tOtoL3jop8kIG2H0uvwss=;
	h=date:mime-version:subject:message-id:from;

Hi Mani

在 2025/10/15 星期三 15:50, Manivannan Sadhasivam 写道:
> On Wed, Oct 15, 2025 at 04:13:41PM +0900, FUKAUMI Naoki wrote:
>> Hi,
>>
>> On 10/15/25 15:26, Manivannan Sadhasivam wrote:
>>> On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:
>>>> [+cc regressions]
>>>>
>>>> On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
>>>>> Hi Manivannan Sadhasivam,
>>>>>
>>>>> I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
>>>>> Rockchip RK3588(S) SoC.
>>>>>
>>>>> When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
>>>>> freezes or fails to probe M.2 Wi-Fi modules. This happens with several
>>>>> different modules I've tested, including the Realtek RTL8852BE, MediaTek
>>>>> MT7921E, and Intel AX210.
>>>>>
>>>>> I've found that reverting the following commit (i.e., the patch I'm replying
>>>>> to) resolves the problem:
>>>>> commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
>>>>
>>>> Thanks for the report, and sorry for the regression.
>>>>
>>>> Since this affects several devices from different manufacturers and (I
>>>> assume) different drivers, it seems likely that there's some issue
>>>> with the Rockchip end, since ASPM probably works on these devices in
>>>> other systems.  So we should figure out if there's something wrong
>>>> with the way we configure ASPM, which we could potentially fix, or if
>>>> there's a hardware issue and we need some king of quirk to prevent
>>>> usage of ASPM on the affected platforms.
>>>>
>>>
>>> I believe it is the latter. The Root Port is having trouble with ASPM.
>>>
>>> FUKAUMI Naoki, could you please share the 'sudo lspci -vv' output so that we
>>> know what kind of Root Port we are dealing with? You can revert the offending
>>> patch and share the output.
>>
>> Here is dmesg/lspci output on ROCK 5A(RK3588S):
>>   https://gist.github.com/RadxaNaoki/1355a0b4278b6e51a61d89df7a535a5d
>>
> 
> Thanks! Could you please try the below diff with f3ac2ff14834 applied?
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..0069d06c282d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>    */
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> 
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_all);

That's not true from my POV. Rockchip platform supports all ASPM policy
after mass production verification. I also verified current upstream
code this morning with RK3588-EVB and can check L0s/L1/L1ss work fine.

The log and lspci output could be found here:
https://pastebin.com/qizeYED7

Moreover, I disscussed this issue with FUKAUMI today off-list and his
board seems to work when only disable L1ss by patching:

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -813,7 +813,7 @@ static void 
pcie_aspm_override_default_link_state(struct pcie_link_state *link)

         /* For devicetree platforms, enable all ASPM states by default */
         if (of_have_populated_dt()) {
-               link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
+               link->aspm_default = PCIE_LINK_STATE_L0S | 
PCIE_LINK_STATE_L1;
                 override = link->aspm_default & ~link->aspm_enabled;
                 if (override)
                         pci_info(pdev, "ASPM: DT platform,


So, is there a proper way to just disable this feature for spec boards
instead of this Soc?

> +
>   /*
>    * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>    * Link bit cleared after starting the link retrain process to allow this
> 
> 
>  From your previous comment, I believe the Root Port is having the issues with
> ASPM as you seem to have tried connecting different devices to the slot. So I
> disabled ASPM for the Root Port with the above diff.
> 
> - Mani
> 


