Return-Path: <linux-pci+bounces-39784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC27C1F2E7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D9C1885EFA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4202BFC85;
	Thu, 30 Oct 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YopriDsc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="drmB1LGG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YopriDsc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="drmB1LGG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E23375C2
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815107; cv=none; b=T3y15d+r+cg0UTZnLkDf12kkacMJVLIXXKly6p5YlWvsXoeAYZ8C1Kj4RUoqFKbZKrCHpfayE+EHdYYS8DBWHwA/x9Zfb161Wki60KAzvEW27Z5aAGYwWbRIfkANMrcv81Idoi1bnkaIhaEDpIIfkYvciyjbfYuCrxjL3GaHbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815107; c=relaxed/simple;
	bh=7y0f7DM/9Fu681tu7EA5itbeJa5mk7ik9CostNPDHl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPK9AWNuQ8/Ol8XOYiMTHwkEU5hPg2nlMpFV+xml1MubfWSD43hlsR7vgYMOvSVNeMtPEup/ULe5+XgL1Qur2JNK5xBrbxJYVSUlFHMJIQ6JtBxbirZx/626ZBDOUFNZaaioFtRGVM3k+aJsH4j5gyF3TZnJgu0XBJxowmAMkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YopriDsc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=drmB1LGG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YopriDsc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=drmB1LGG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 494E31F8B8;
	Thu, 30 Oct 2025 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761815103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzKO/XeWMBH3INZbM+ZTs291o3A5XJvv3T24IEcIOZQ=;
	b=YopriDsc5qeQCfVYMnRLQQhrsLxUH/KR6tXmcMXSakvRYuBWztgEoXyXPmP6bzgwXokX2A
	LNISEtkogbdLBYZEnxmsdibifkHmhWGWwe5p9ZgQbOWU6Kcq7/+yqsaBLyPanmcvMMyFW8
	1vlbIeQpSvERQbRIv3xPl46R7v+bCh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761815103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzKO/XeWMBH3INZbM+ZTs291o3A5XJvv3T24IEcIOZQ=;
	b=drmB1LGGmgBmQKIEWGXtVXtjQUycADaFpplEwMvR3TEcAMoBpkHWOP/1Sm9nB1sHv7HaBy
	OqxSHwFCRJpnOCCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YopriDsc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=drmB1LGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761815103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzKO/XeWMBH3INZbM+ZTs291o3A5XJvv3T24IEcIOZQ=;
	b=YopriDsc5qeQCfVYMnRLQQhrsLxUH/KR6tXmcMXSakvRYuBWztgEoXyXPmP6bzgwXokX2A
	LNISEtkogbdLBYZEnxmsdibifkHmhWGWwe5p9ZgQbOWU6Kcq7/+yqsaBLyPanmcvMMyFW8
	1vlbIeQpSvERQbRIv3xPl46R7v+bCh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761815103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzKO/XeWMBH3INZbM+ZTs291o3A5XJvv3T24IEcIOZQ=;
	b=drmB1LGGmgBmQKIEWGXtVXtjQUycADaFpplEwMvR3TEcAMoBpkHWOP/1Sm9nB1sHv7HaBy
	OqxSHwFCRJpnOCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C005B13393;
	Thu, 30 Oct 2025 09:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TdU1LD4qA2myWQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 30 Oct 2025 09:05:02 +0000
Message-ID: <74df9e1d-69f4-43e6-89fe-3290b94ab8dd@suse.de>
Date: Thu, 30 Oct 2025 10:04:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] coco/tsm: Introduce a core device for TEE Security
 Managers
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: aik@amd.com, yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 bhelgaas@google.com, gregkh@linuxfoundation.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-2-dan.j.williams@intel.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <20251024020418.1366664-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 494E31F8B8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

Hi,

On 10/24/25 4:04 AM, Dan Williams wrote:
> A "TSM" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. The
> name originates from the PCI specification for platform agent that
> carries out operations for PCIe TDISP (TEE Device Interface Security
> Protocol).
> 
> Instances of this core device are parented by a device representing the
> platform security function like CONFIG_CRYPTO_DEV_CCP or
> CONFIG_INTEL_TDX_HOST.
> 
> This device interface is a frontend to the aspects of a TSM and TEE I/O
> that are cross-architecture common. This includes mechanisms like
> enumerating available platform TEE I/O capabilities and provisioning
> connections between the platform TSM and device DSMs (Device Security
> Manager (TDISP)).
> 
> For now this is just the scaffolding for registering a TSM device sysfs
> interface.
> 
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/virt/coco/Kconfig                 |   3 +
>  drivers/virt/coco/Makefile                |   1 +
>  Documentation/ABI/testing/sysfs-class-tsm |   9 ++
>  include/linux/tsm.h                       |   4 +
>  drivers/virt/coco/tsm-core.c              | 109 ++++++++++++++++++++++
>  MAINTAINERS                               |   2 +-
>  6 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>  create mode 100644 drivers/virt/coco/tsm-core.c
> 
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index 819a97e8ba99..bb0c6d6ddcc8 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -14,3 +14,6 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
>  source "drivers/virt/coco/arm-cca-guest/Kconfig"
>  
>  source "drivers/virt/coco/guest/Kconfig"
> +
> +config TSM
> +	bool
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index f918bbb61737..cb52021912b3 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -7,4 +7,5 @@ obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>  obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> +obj-$(CONFIG_TSM) 		+= tsm-core.o
>  obj-$(CONFIG_TSM_GUEST)		+= guest/
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> new file mode 100644
> index 000000000000..2949468deaf7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -0,0 +1,9 @@
> +What:		/sys/class/tsm/tsmN
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		"tsmN" is a device that represents the generic attributes of a
> +		platform TEE Security Manager.  It is typically a child of a
> +		platform enumerated TSM device. /sys/class/tsm/tsmN/uevent
> +		signals when the PCI layer is able to support establishment of
> +		link encryption and other device-security features coordinated
> +		through a platform tsm.
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 431054810dca..aa906eb67360 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -5,6 +5,7 @@
>  #include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <linux/uuid.h>
> +#include <linux/device.h>
>  
>  #define TSM_REPORT_INBLOB_MAX 64
>  #define TSM_REPORT_OUTBLOB_MAX SZ_32K
> @@ -109,4 +110,7 @@ struct tsm_report_ops {
>  
>  int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>  int tsm_report_unregister(const struct tsm_report_ops *ops);
> +struct tsm_dev;
> +struct tsm_dev *tsm_register(struct device *parent);
> +void tsm_unregister(struct tsm_dev *tsm_dev);
>  #endif /* __TSM_H */
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> new file mode 100644
> index 000000000000..a64b776642cf
> --- /dev/null
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/idr.h>
> +#include <linux/rwsem.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/cleanup.h>
> +
> +static struct class *tsm_class;
> +static DECLARE_RWSEM(tsm_rwsem);
> +static DEFINE_IDR(tsm_idr);

The IDR documentation states it is deprecated and one should use XArray
in its place. Is there any particular reason to use IDR instead in this
patch series?

Best,
Carlos

