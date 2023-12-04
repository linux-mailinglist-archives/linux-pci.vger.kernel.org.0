Return-Path: <linux-pci+bounces-423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85165803608
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 15:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A91B20AEC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892C28694;
	Mon,  4 Dec 2023 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4l4Tl8P"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887183
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701698922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Kb4oTInntwbSX0qj4UGW/Dx8KPLHw46unRh3eh5fbw=;
	b=J4l4Tl8PEA4ISVuhb6xHQrCct244t6BEWWLMbTeum9Jwox2oHEoLJrZ76w9Y4YZjYNC5RB
	c6NUIe9X7SUvM1Yy+16dm0JrSwZRjSiUsa6bAGuODXh6LMAmoefC99H39E8QmdZsegp/+X
	mtDZVK6XefPllftMI4I3mo3kSVbncE8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392--K8OFpuSNimqaWd1DTQleA-1; Mon, 04 Dec 2023 09:08:39 -0500
X-MC-Unique: -K8OFpuSNimqaWd1DTQleA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9b97a391bso44396531fa.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Dec 2023 06:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698915; x=1702303715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kb4oTInntwbSX0qj4UGW/Dx8KPLHw46unRh3eh5fbw=;
        b=OfJvpxFpQrf7q/J8LRe8T32uVTVThCeu2ryFFDModVJIBsx9s7AADufRMEkTlea75a
         piG429+IpV9icTA1RsKYDJOgnWb5GUnU5ed6oyp4U4kysHQSvDdh7kScqzpDhWa/QzKD
         Vpx8YP6u3fw9zIS3WJHgVKMhsw2GoSsdd5BT3RoYTwkDWj9frtHRvx4WzghY032MbfDM
         rYmhXshsl8U83LnvwFrHXvfbJV8bqQBv3bywe9rSa8UFNsAxfmh1xV0opkXHw1v8l1l0
         knEixoH0wmABlmsvq8ka4iCESGcV4MKK/4hBX6bXXD4cXPFpfFuiVytzO/1zGAofrsp6
         idPg==
X-Gm-Message-State: AOJu0YwPchAampfJuWaR4bKtrGj+fmY4Rfnp7ZF+1goFvPurWfnEaQMh
	7+/PUK5Og8Fvb8Dpozmc2mBnGn0fvwuj2bf+DOqiCmy3taAep0r/HpJsvSWj7iXH+saU5RsnSFo
	FDk28eVEWSjtz/PfAP+4L
X-Received: by 2002:a2e:9455:0:b0:2c9:d862:ff1e with SMTP id o21-20020a2e9455000000b002c9d862ff1emr1187151ljh.63.1701698914835;
        Mon, 04 Dec 2023 06:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuDuHVEhq5/ojLzeJsU0hmxb0pvTe47HU9fNdyKYAlhHcsSAPuGmoe6SCFyLBmVdV96WPYNg==
X-Received: by 2002:a2e:9455:0:b0:2c9:d862:ff1e with SMTP id o21-20020a2e9455000000b002c9d862ff1emr1187145ljh.63.1701698914516;
        Mon, 04 Dec 2023 06:08:34 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b009fd50aa6984sm5285299ejs.83.2023.12.04.06.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:08:34 -0800 (PST)
Message-ID: <4f8b7b2d-0f37-420f-adaa-15a88f0f51ea@redhat.com>
Date: Mon, 4 Dec 2023 15:08:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add support for drivers to decide bridge D3 policy
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231203041046.38655-1-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231203041046.38655-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 12/3/23 05:10, Mario Limonciello wrote:
> The policy for whether PCI bridges are allowed to select D3 is dictated
> by empirical results that are enumerated into pci_bridge_d3_possible().
> 
> In Windows this behaves differently in that Windows internal policy is
> not used for devices when a power engine plugin driver provided by the
> SOC vendor is installed.  This driver is used to decide the policy in
> those cases.
> 
> This series implements a system that lets drivers register such a policy
> control as well. It isn't activated for any SOCs by default.
> 
> This is heavily leveraged from the work in [1]
> 
> [1] https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/

As I mentioned in the v1 thread, I expect this entire series to
go upstream through the PCI or ACPI trees, so I'm dropping this
from my queue.

Regards,

Hans



> 
> v1->v2:
>  * Pick up tags
>  * Rebase on v6.7-rc4
> 
> Mario Limonciello (4):
>   PCI: Make d3cold_allowed sysfs attribute read only
>   PCI: Refresh root ports in pci_bridge_d3_update()
>   ACPI: x86: s2idle: Export symbol for fetching constraints for module
>     use
>   platform/x86/amd: pmc: Add support for using constraints to decide D3
>     policy
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  4 +-
>  drivers/acpi/x86/s2idle.c               |  1 +
>  drivers/pci/pci-acpi.c                  |  2 +-
>  drivers/pci/pci-sysfs.c                 | 14 +-----
>  drivers/pci/pci.c                       | 12 ++++--
>  drivers/platform/x86/amd/pmc/pmc.c      | 57 +++++++++++++++++++++++++
>  include/linux/pci.h                     |  1 -
>  7 files changed, 72 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a


