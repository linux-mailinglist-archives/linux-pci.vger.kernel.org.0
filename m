Return-Path: <linux-pci+bounces-13482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB2985228
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A015F1C2108D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C93C14AD19;
	Wed, 25 Sep 2024 05:06:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0691870;
	Wed, 25 Sep 2024 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727240808; cv=none; b=ttdTnTDXNFJyYwuyfU7LOLkn+mnvy6J//2WQcwhoimFlM4JvdNPqkZTkfrdZZhbacyUKloIxOBkKfN5gu9qxTLjbpzuytSb5lX/O94nNJ+sMJp0UaP2m1QtKsLh50dA7Ydg8+dl8LKBd1aAKBwVuC8vQvg/iXnkTMy8yMf+xjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727240808; c=relaxed/simple;
	bh=r/RmplIDQmV5xbPWSMvCLIFp+tSg7DGGQkycwLAJuLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1ftMpitJ7H891HCzqcyaGCzfbqMVPRLzEC2wnm3flPb3MwwmuIsrQ7zKWBGb0dUEvngV2bbY73Dy5rtDySASukzVUNZHlm0caoJsn1YRW5NMiojOoP3TVATQr8Mx73TBVojYE/A4/+RuJb8at7NnRoVKhauS5OVrrnWhA233qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso80258795e9.2;
        Tue, 24 Sep 2024 22:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727240804; x=1727845604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdUrUpIWkXsWteKIjNbcE/Cse4pycMkgruUktjSk1GE=;
        b=ZrwqX0QnTyAGv5KOC8F5QPx/yCWXFqxJLp30nbq5eStszHZkEY3k+s8fHSUIhxOoQo
         89B3gSMW9Rew+kjdiujvCF8rPidqdzVGGGYgHxudC5Fsg34XFR3wSWkAO6jKUzC0zczY
         BhEObuGkZAksHyR0u+fMFousePXBFaL87a1oWZ6GdBW+BkD965Z+/2ZjHvtRS7/MUtja
         PE/3oMoagl8ZWgJHRnjAXHraJFpmiuU4+DBbo/cLN3CqSFx6iQF3iET0/TLbAI/q1cq3
         i0Cfrz9pPWFDleJMrCQROKRpjGlmpgX2sPG1ZZmAIGAU2Kzq0Vq7tuW3RDFVx/a0jPlX
         x5pw==
X-Forwarded-Encrypted: i=1; AJvYcCU2RPMTixafMZQvnWcVTz60sR6yuhzQYwQPnJdrVkK8GbmKxgE5RrSAYcuY+yUskQLqyK0LHOihE9YHjEXA@vger.kernel.org, AJvYcCUYa8qCtm/uck6osiJFSHasKB/6ht7MSkUhL8tqBejA9BnG17eviJ6qpgEn2iYT/1ajN30kKeVmDQEZ@vger.kernel.org, AJvYcCXtgK8MoxzpLTmsysFdGnymBOvGZl6Z1DY+KMLxuvtJ2ok0bSPWiiq+V0cwAMayHtiuoIXhcNSID2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN+FIWCVJh7kUQx7kYDNccZaqUXZB+5SYUTYPfXek4+qWeH0F
	VYHqmfpRE44HeBEJSJ0TtX2K6UH9zVSoxvr30lp8jrYB3p6NhDwz
X-Google-Smtp-Source: AGHT+IFsPUYLR21Fg/gfLbhYvqOXt6zbm4oIOR6fttesmVdQL5QSBFxUDf2siHq6iQ5Ziy0KLUhqfw==
X-Received: by 2002:a5d:6290:0:b0:374:c64d:536a with SMTP id ffacd0b85a97d-37cc2479478mr1219032f8f.27.1727240803971;
        Tue, 24 Sep 2024 22:06:43 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f340c9sm170504066b.13.2024.09.24.22.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 22:06:43 -0700 (PDT)
Message-ID: <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>
Date: Wed, 25 Sep 2024 07:06:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
To: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
 galshalom@nvidia.com, leonro@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
 jonathanh@nvidia.com
Cc: mmoshrefjava@nvidia.com, shahafs@nvidia.com, vsethi@nvidia.com,
 sdonthineni@nvidia.com, jan@nvidia.com, tdave@nvidia.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kthota@nvidia.com, mmaddireddy@nvidia.com,
 sagar.tv@gmail.com
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240625153150.159310-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25. 06. 24, 17:31, Vidya Sagar wrote:
> PCIe ACS settings control the level of isolation and the possible P2P
> paths between devices. With greater isolation the kernel will create
> smaller iommu_groups and with less isolation there is more HW that
> can achieve P2P transfers. From a virtualization perspective all
> devices in the same iommu_group must be assigned to the same VM as
> they lack security isolation.
> 
> There is no way for the kernel to automatically know the correct
> ACS settings for any given system and workload. Existing command line
> options (ex:- disable_acs_redir) allow only for large scale change,
> disabling all isolation, but this is not sufficient for more complex cases.
> 
> Add a kernel command-line option 'config_acs' to directly control all the
> ACS bits for specific devices, which allows the operator to setup the
> right level of isolation to achieve the desired P2P configuration.
> The definition is future proof, when new ACS bits are added to the spec
> the open syntax can be extended.
> 
> ACS needs to be setup early in the kernel boot as the ACS settings
> effect how iommu_groups are formed. iommu_group formation is a one
> time event during initial device discovery, changing ACS bits after
> kernel boot can result in an inaccurate view of the iommu_groups
> compared to the current isolation configuration.
> 
> ACS applies to PCIe Downstream Ports and multi-function devices.
> The default ACS settings are strict and deny any direct traffic
> between two functions. This results in the smallest iommu_group the
> HW can support. Frequently these values result in slow or
> non-working P2PDMA.
> 
> ACS offers a range of security choices controlling how traffic is
> allowed to go directly between two devices. Some popular choices:
>    - Full prevention
>    - Translated requests can be direct, with various options
>    - Asymmetric direct traffic, A can reach B but not the reverse
>    - All traffic can be direct
> Along with some other less common ones for special topologies.
> 
> The intention is that this option would be used with expert knowledge
> of the HW capability and workload to achieve the desired
> configuration.

Hi,

this breaks ACS on some platforms (in 6.11). See:
https://bugzilla.suse.com/show_bug.cgi?id=1229019

When starting a KVM:
> "Error starting domain: internal error: QEMU unexpectedly closed the monitor (vm=‘win10’): qxl_send_events: spice-server bug: guest stopped, ignoring
> 2024-08-08T01:45:51.824474Z qemu-system-x86_64: -device {“driver”:“vfio-pci”,“host”:“0000:0b:00.0”,“id”:“hostdev0”,“bus”:“pci.2”,“addr”:“0x0”}: vfio 0000:0b:00.0: group 83 is not viable
> Please ensure all devices within the iommu_group are bound to their vfio bus driver."



We backported the commit to 6.4, there they see:
> The good kernel 6.4.0-150600.23.14 log has this:
> 
> [    0.618918] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
> [    0.619153] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
> 
> the bad one 6.4.0-150600.23.22 does not.

But the same difference is with 6.10 vs 6.11.

Any ideas? It looks like workarounds are not applied anymore.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v4:
> * Changed commit message (Courtesy: Jason) to provide more details
> 
> v3:
> * Fixed a documentation issue reported by kernel test bot
> 
> v2:
> * Refactored the code as per Jason's suggestion
> 
>   .../admin-guide/kernel-parameters.txt         |  22 +++
>   drivers/pci/pci.c                             | 148 +++++++++++-------
>   2 files changed, 112 insertions(+), 58 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 500cfa776225..42d0f6fd40d0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4619,6 +4619,28 @@
>   				bridges without forcing it upstream. Note:
>   				this removes isolation between devices and
>   				may put more devices in an IOMMU group.
> +		config_acs=
> +				Format:
> +				=<ACS flags>@<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) optionally prepended with flags
> +				and separated by semicolons. The respective
> +				capabilities will be enabled, disabled or unchanged
> +				based on what is specified in flags.
> +				ACS Flags is defined as follows
> +				bit-0 : ACS Source Validation
> +				bit-1 : ACS Translation Blocking
> +				bit-2 : ACS P2P Request Redirect
> +				bit-3 : ACS P2P Completion Redirect
> +				bit-4 : ACS Upstream Forwarding
> +				bit-5 : ACS P2P Egress Control
> +				bit-6 : ACS Direct Translated P2P
> +				Each bit can be marked as
> +				‘0‘ – force disabled
> +				‘1’ – force enabled
> +				‘x’ – unchanged.
> +				Note: this may remove isolation between devices
> +				and may put more devices in an IOMMU group.
>   		force_floating	[S390] Force usage of floating interrupts.
>   		nomio		[S390] Do not use MIO instructions.
>   		norid		[S390] ignore the RID field and force use of
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 55078c70a05b..6661932afe59 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -946,30 +946,67 @@ void pci_request_acs(void)
>   }
>   
>   static const char *disable_acs_redir_param;
> +static const char *config_acs_param;
>   
> -/**
> - * pci_disable_acs_redir - disable ACS redirect capabilities
> - * @dev: the PCI device
> - *
> - * For only devices specified in the disable_acs_redir parameter.
> - */
> -static void pci_disable_acs_redir(struct pci_dev *dev)
> +struct pci_acs {
> +	u16 cap;
> +	u16 ctrl;
> +	u16 fw_ctrl;
> +};
> +
> +static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> +			     const char *p, u16 mask, u16 flags)
>   {
> +	char *delimit;
>   	int ret = 0;
> -	const char *p;
> -	int pos;
> -	u16 ctrl;
>   
> -	if (!disable_acs_redir_param)
> +	if (!p)
>   		return;
>   
> -	p = disable_acs_redir_param;
>   	while (*p) {
> +		if (!mask) {
> +			/* Check for ACS flags */
> +			delimit = strstr(p, "@");
> +			if (delimit) {
> +				int end;
> +				u32 shift = 0;
> +
> +				end = delimit - p - 1;
> +
> +				while (end > -1) {
> +					if (*(p + end) == '0') {
> +						mask |= 1 << shift;
> +						shift++;
> +						end--;
> +					} else if (*(p + end) == '1') {
> +						mask |= 1 << shift;
> +						flags |= 1 << shift;
> +						shift++;
> +						end--;
> +					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
> +						shift++;
> +						end--;
> +					} else {
> +						pci_err(dev, "Invalid ACS flags... Ignoring\n");
> +						return;
> +					}
> +				}
> +				p = delimit + 1;
> +			} else {
> +				pci_err(dev, "ACS Flags missing\n");
> +				return;
> +			}
> +		}
> +
> +		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> +			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
> +			pci_err(dev, "Invalid ACS flags specified\n");
> +			return;
> +		}
> +
>   		ret = pci_dev_str_match(dev, p, &p);
>   		if (ret < 0) {
> -			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> -				     disable_acs_redir_param);
> -
> +			pr_info_once("PCI: Can't parse acs command line parameter\n");
>   			break;
>   		} else if (ret == 1) {
>   			/* Found a match */
> @@ -989,56 +1026,38 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
>   	if (!pci_dev_specific_disable_acs_redir(dev))
>   		return;
>   
> -	pos = dev->acs_cap;
> -	if (!pos) {
> -		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
> -		return;
> -	}
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +	pci_dbg(dev, "ACS mask  = 0x%X\n", mask);
> +	pci_dbg(dev, "ACS flags = 0x%X\n", flags);
>   
> -	/* P2P Request & Completion Redirect */
> -	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> +	/* If mask is 0 then we copy the bit from the firmware setting. */
> +	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> +	caps->ctrl |= flags;
>   
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> -
> -	pci_info(dev, "disabled ACS redirect\n");
> +	pci_info(dev, "Configured ACS to 0x%x\n", caps->ctrl);
>   }
>   
>   /**
>    * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
>    * @dev: the PCI device
> + * @caps: default ACS controls
>    */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> +static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>   {
> -	int pos;
> -	u16 cap;
> -	u16 ctrl;
> -
> -	pos = dev->acs_cap;
> -	if (!pos)
> -		return;
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> -
>   	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> +	caps->ctrl |= (caps->cap & PCI_ACS_SV);
>   
>   	/* P2P Request Redirect */
> -	ctrl |= (cap & PCI_ACS_RR);
> +	caps->ctrl |= (caps->cap & PCI_ACS_RR);
>   
>   	/* P2P Completion Redirect */
> -	ctrl |= (cap & PCI_ACS_CR);
> +	caps->ctrl |= (caps->cap & PCI_ACS_CR);
>   
>   	/* Upstream Forwarding */
> -	ctrl |= (cap & PCI_ACS_UF);
> +	caps->ctrl |= (caps->cap & PCI_ACS_UF);
>   
>   	/* Enable Translation Blocking for external devices and noats */
>   	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> -		ctrl |= (cap & PCI_ACS_TB);
> -
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +		caps->ctrl |= (caps->cap & PCI_ACS_TB);
>   }
>   
>   /**
> @@ -1047,23 +1066,33 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>    */
>   static void pci_enable_acs(struct pci_dev *dev)
>   {
> -	if (!pci_acs_enable)
> -		goto disable_acs_redir;
> +	struct pci_acs caps;
> +	int pos;
> +
> +	pos = dev->acs_cap;
> +	if (!pos)
> +		return;
>   
> -	if (!pci_dev_specific_enable_acs(dev))
> -		goto disable_acs_redir;
> +	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
> +	caps.fw_ctrl = caps.ctrl;
>   
> -	pci_std_enable_acs(dev);
> +	/* If an iommu is present we start with kernel default caps */
> +	if (pci_acs_enable) {
> +		if (pci_dev_specific_enable_acs(dev))
> +			pci_std_enable_acs(dev, &caps);
> +	}
>   
> -disable_acs_redir:
>   	/*
> -	 * Note: pci_disable_acs_redir() must be called even if ACS was not
> -	 * enabled by the kernel because it may have been enabled by
> -	 * platform firmware.  So if we are told to disable it, we should
> -	 * always disable it after setting the kernel's default
> -	 * preferences.
> +	 * Always apply caps from the command line, even if there is no iommu.
> +	 * Trust that the admin has a reason to change the ACS settings.
>   	 */
> -	pci_disable_acs_redir(dev);
> +	__pci_config_acs(dev, &caps, disable_acs_redir_param,
> +			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
> +			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
> +	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
>   }
>   
>   /**
> @@ -6740,6 +6769,8 @@ static int __init pci_setup(char *str)
>   				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>   			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>   				disable_acs_redir_param = str + 18;
> +			} else if (!strncmp(str, "config_acs=", 11)) {
> +				config_acs_param = str + 11;
>   			} else {
>   				pr_err("PCI: Unknown option `%s'\n", str);
>   			}
> @@ -6764,6 +6795,7 @@ static int __init pci_realloc_setup_params(void)
>   	resource_alignment_param = kstrdup(resource_alignment_param,
>   					   GFP_KERNEL);
>   	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
> +	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
>   
>   	return 0;
>   }

-- 
js
suse labs


