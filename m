Return-Path: <linux-pci+bounces-19480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19984A04D3F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 00:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730B63A11CF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F11E47B0;
	Tue,  7 Jan 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrQYd5d8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFB1E3786;
	Tue,  7 Jan 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291628; cv=none; b=pgQOYJGoCZXUlc68Hyx4fFtT59mObQR0wzI3h3DYVU+TlWLFApoOKUwkVeIJIbLsA8o+9RHsmCqVOFpgRo44f9yiiUyvEQ0mmahLAmDJ4HcER0L5Z3/lxlmGyUg1mvG2cDjsZThVJBXVlVs7MvMJIAhC5yWOkrYCiFw1mgBQaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291628; c=relaxed/simple;
	bh=kiO15MjNdmvpo5LHTynrUdPjW4WLoRsVz8V4vGN/ryk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mToeGqarB528ZpggN3KvPJNtkJe8i6//rV++3yurzZ8jXsM/X8Q1gJapxEGWfeZ0ObWm0SJcL5Vr/VvnvdVE2tVYvHtV1kNiiKyDOA3wJDjBtkSzaDKrtGENPR7cqaGwt1dyNrOjXB1DYbJX37lyIUFd+HDnPeqYZwoVAfACqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrQYd5d8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so111863905e9.3;
        Tue, 07 Jan 2025 15:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736291625; x=1736896425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieNZFDcRUN5obqtb80QT3B4G161KWAAtpdF3UOP1r2s=;
        b=IrQYd5d8w2WcKiuVEfS1lruF3x1ohXaHRO2xJbJQqTElcWBWMaRbttWZ9irmch5h5q
         LcWTkWBBz8u1c6bwz9iBvduSVBWJzkRegcQ+qQXISPdCGMTGUKhMEYwcqrWCNlgBz668
         y1C5k63M7iYO9+Xd3tAW+ALuOZqF4tvDIfBJ1Bisbw2kw3nWVLOqT//zlEQFLYADzSHY
         ynABxu12s/Xs9USNNAfVDLQUP2pwlxKJCCJvsMs3o4nR7UC1+srq+uEqBhwhCsKl0rOK
         IXvNVRaLTtH8Z0tMKBLzE/UnPz4I75DfBa4x1AULNA9MZymEjb2bIHhuez2UZros1DJ5
         e4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291625; x=1736896425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieNZFDcRUN5obqtb80QT3B4G161KWAAtpdF3UOP1r2s=;
        b=cimMLwo8ky/K5r4+OdEnTpi5Fgt6omC7oIeD1gCuTpaXgTAmadO+Nfd14krADPYsu8
         zWThVvL0wObBjztOG2GS6XyK8ctOguPNTlhnDs/M9CLTcpxgM8eDr4dYmUR2R4t1F2jz
         T6YTh5YSOlJP/AOFY+0F15TK1VQboNtJbzeWDPygP70nP1HpF0G4/e6fGr2CpsPcwrjx
         7rNbAigDM04AD2IeaTc6SbkZnbMWzhkdfnRi2v2D804l48om0ooej3VSsMawhev8M+9S
         ADfpc8mxEpjD6rU0brutkEKYrCyxWOpLxukhwNYt64ZIgbXcTA41jjg8Yf/c1kuAiIJ+
         01xw==
X-Forwarded-Encrypted: i=1; AJvYcCVMEYYtwMSh1LSvqxybPKWyzAzlZap2OHMrRxo9qONK0+yo2srBmMAXirstsPBgH/ECjHcetUSDEoPx@vger.kernel.org, AJvYcCVVTTpO9s1DvBn0CMrVAA+RGwtq/RXDSCGpamWAQe7UEZh69iNrWK8bofSZwxyRluOT7lZbnh8d@vger.kernel.org, AJvYcCVvcbXQLydtJAgayUvNk1+Uai7WyhnTj0RYWIbIntfxrMVcwoInUAYnN5/6p7aTbvGxqEFwmP0/gvUpWM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYkV6jP29DB1l7Hm1K0yoLluVXtjHPC0eyjumBPKCnHX22Q7Sd
	PQM2yZR3l5t0xfgeQMd/vanh2TzWThX5kOF57rYKhlA8emxcvzNy
X-Gm-Gg: ASbGncvm+VCy2EBMOV0cgXOfyYCjS8R4LP85ooUyfOUdSJrVlDxXuswyIyfs/v3+cN0
	JBnYTb7R+9UYGrCkM5ERY+GD1W6PiBBwPF4DQ8tPcne8EcpBPuIW43vO7SUlG9WxodV0zkn5eM0
	wiQJlgd6WuJseUruKXySSfxNEwnClA9rnGeWOGr+V26Zn2q7jDZ0kJrLgt5hTFtmm0n55yzpNCe
	pcZ3s8c8prcWb/r1BjEyPpJV/JisVw0XxcQ9XIZqnWWPEl774bXrGSK4g==
X-Google-Smtp-Source: AGHT+IG6pPYE22Ub94+RT7zG9KwzGpTHLq2vTV8oQD1H5WBZEZZspzzEcfzH6EOECfDT7PGs7aITDQ==
X-Received: by 2002:a05:600c:3b91:b0:436:46f9:4fc6 with SMTP id 5b1f17b1804b1-436e26928e6mr3400955e9.8.1736291624333;
        Tue, 07 Jan 2025 15:13:44 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm1642425e9.9.2025.01.07.15.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:13:42 -0800 (PST)
Message-ID: <5ec25117-e0c3-477b-96da-dd2adf870408@gmail.com>
Date: Wed, 8 Jan 2025 01:13:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0bf3266a7c6e42e5e19ed2040e6a8feb88202703.1736098238.git.mail@maciej.szmigiero.name>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <0bf3266a7c6e42e5e19ed2040e6a8feb88202703.1736098238.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maciej,

On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
> Currently, the driver is seriously broken with respect to the
> hibernation (S4): after image restore the device is back into
> IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
> full re-launch of the rest of its firmware, but the driver restore
> handler treats the device as merely sleeping and just sends it a
> wake-up command.
> 
> This wake-up command times out but device nodes (/dev/wwan*) remain
> accessible.
> However attempting to use them causes the bootloader to crash and
> enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
> dump is ready").
> 
> It seems that the device cannot be re-initialized from this crashed
> stage without toggling some reset pin (on my test platform that's
> apparently what the device _RST ACPI method does).
> 
> While it would theoretically be possible to rewrite the driver to tear
> down the whole MUX / IPC layers on hibernation (so the bootloader does
> not crash from improper access) and then re-launch the device on
> restore this would require significant refactoring of the driver
> (believe me, I've tried), since there are quite a few assumptions
> hard-coded in the driver about the device never being partially
> de-initialized (like channels other than devlink cannot be closed,
> for example).
> Probably this would also need some programming guide for this hardware.
> 
> Considering that the driver seems orphaned [1] and other people are
> hitting this issue too [2] fix it by simply unbinding the PCI driver
> before hibernation and re-binding it after restore, much like
> USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
> problem.
> 
> Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
> the existing suspend / resume handlers) and S4 (which uses the new code).
> 
> [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
> [2]:
> https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Generally looks good to me. Lets wait for approval from PCI maintainers 
to be sure that there no unexpected side effects.

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

There are few nit pics, please find below.

> ---
> 
> Changes from v1:
> * Un-register the PM-notifier and PCI driver in iosm_ipc_driver_exit()
> in the reverse order of their registration in iosm_ipc_driver_init().
> 
> * CC the PCI supporter and PCI mailing list in case there's some better
> way to fix/implement all of this.
> 
>   drivers/net/wwan/iosm/iosm_ipc_pcie.c | 57 ++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 04517bd3325a..3ca81864a2fd 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -6,6 +6,7 @@
>   #include <linux/acpi.h>
>   #include <linux/bitfield.h>
>   #include <linux/module.h>
> +#include <linux/suspend.h>
>   #include <net/rtnetlink.h>
>   
>   #include "iosm_ipc_imem.h"
> @@ -448,7 +449,61 @@ static struct pci_driver iosm_ipc_driver = {
>   	},
>   	.id_table = iosm_ipc_ids,
>   };
> -module_pci_driver(iosm_ipc_driver);
> +
> +static bool pci_registered;

nit, global variables are usually placed at the beginning of a source 
file to allow effortless access to them in the future code changes. Move 
it next to wwan_acpi_guid please.

> +
> +static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
> +{
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +		if (pci_registered) {
> +			pci_unregister_driver(&iosm_ipc_driver);
> +			pci_registered = false;
> +		}
> +	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
> +		if (!pci_registered) {
> +			int ret;
> +
> +			ret = pci_register_driver(&iosm_ipc_driver);
> +			if (ret) {
> +				pr_err(KBUILD_MODNAME ": unable to re-register PCI driver: %d\n",
> +				       ret);
> +			} else {
> +				pci_registered = true;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct notifier_block pm_notifier = {
> +	.notifier_call = pm_notify,
> +};
> +
> +static int __init iosm_ipc_driver_init(void)
> +{
> +	int ret;
> +
> +	ret = pci_register_driver(&iosm_ipc_driver);
> +	if (ret)
> +		return ret;
> +
> +	pci_registered = true;
> +
> +	register_pm_notifier(&pm_notifier);
> +
> +	return 0;
> +}
> +module_init(iosm_ipc_driver_init);
> +
> +static void __exit iosm_ipc_driver_exit(void)
> +{
> +	unregister_pm_notifier(&pm_notifier);
> +
> +	if (pci_registered)
> +		pci_unregister_driver(&iosm_ipc_driver);
> +}
> +module_exit(iosm_ipc_driver_exit);

Another nit. In opposite to global variables, module initialization and 
deinitialization handlers are usually placed at the end of a source 
file. With the same reason to facilitate access to other entities. 
Nobody calls the module init function, but the module init function 
would like to call something later.

If you do not have a strong reason to keep 
iosm_ipc_driver_init/iosm_ipc_driver_exit here, please move them 
together to the end of the file.

>   int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data,
>   		      size_t size, dma_addr_t *mapping, int direction)

--
Sergey

