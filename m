Return-Path: <linux-pci+bounces-26605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E7A997EF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E1B4A2C1D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B226B09F;
	Wed, 23 Apr 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcgI1gCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1B14900B;
	Wed, 23 Apr 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433085; cv=none; b=qpHLbWiuyATxcpG83f2C3sweGU2Dtakw+rGIHcjicO3G1LyRObNUDR2FQt1QVZnoiIV9BPzE2I5wGmR0U8E3yEza9l2GmdygXxykTOjJa4Lo66dLiNviK2cNyn7I7HeMO7nxJ4PDOsE4Hu7u92lldPfddWIGwge6eatoqRpee98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433085; c=relaxed/simple;
	bh=tJBn0sbdCDEFGfNg120jO88woAsVmT552TfvpbvWXyo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ZUI/gFNLwHxXBHDK0SGl5Pw2r6AEu2K6J6fvgh1ZpUJzoiXL77Ty3inrtrrmSjtx1yJmzI9N1BZKYCk7O/MGlaL+C5GOTP3rGHobm0vnGgQ3OWBvBAnH3ZKOzciHoNrM3nQExOib/xyG6ZGfCSx/kdjgUm2zqAh8HoOSaWcGKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcgI1gCg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so1329542a91.1;
        Wed, 23 Apr 2025 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745433083; x=1746037883; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOpQeKb3vixx81nI9GHXsTk9qiiQQKOXE/nG8kKovQA=;
        b=bcgI1gCgRpEsoG/X2cNMAmoOd6LX9CC7i1NNGugvhJ5d/WyqhZmFJpJ7j50yGv/2UW
         ZOrkthQZXIvgWZBUJt0q3WJTioWXLPUE1ZASz0D+goo9xFGSmZ7d3Ogf3IFnd6VrTwYD
         abcNDTS4If7DugBTFie2yvddfb5DKeiKIsmUYdAYB67JXLFPaYigaQbXBgBukAsVHioZ
         5rjsyJbH2mIXq3l52EwgC2GpVBAzzQI2iO9BqA5mVS1Kd/UWg7ph6e+IqQB9fRruv4ow
         Bp/m6CH0Fo9oKQSY7lktY1MRJPjRQWfJLxo36Wvh/yfWmzif09s63J1jtcakAiuF35vd
         3YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745433083; x=1746037883;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOpQeKb3vixx81nI9GHXsTk9qiiQQKOXE/nG8kKovQA=;
        b=SFbVjwWjb5BhTEkAWw5xt+Fgxy2XKMAfT9o1nzryjRzghOLlfGc26fuIrO8sZ/jlDc
         ByegdsQhbM/HVwVupRTcCnDcz28QyrIuc4GET9aw9D+hcs4MpdzbgkOo7n6jz3WNKRTb
         BxG2LgBG3H/4cwLD2fJeMEQIImyFv0fXHgI+yszNPW2nnVxCrAcW125QcPRXScmK2Q3r
         tLobjM06gzmDdaOhSmLadIvb3FI9L5icb1kbeUeVM5IFeIXPCavHMYMvqnmAAYCIXFmw
         9G/2WZipsq/Z0WQTbguzTf3c+0Ib7LCixFKtWDSoRRyhXnOjKw4FckOac0mB1zSqq9D4
         C7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQWO47ZtJHFByJNyICNqPDKMJYw/4A4OiY0x7zJADfcgm+ZfOaAu9utTpdKJ2nwz8c2xdV0Ji8f8nvpLQ=@vger.kernel.org, AJvYcCV2NPwgNfsN4tJKaa0pjptK5ZiioiOyZVCUSFQq1rhN4G+HBtsoiMCqTGLF7dJiijXJ9vVqMxidW/Iql48=@vger.kernel.org, AJvYcCWFcbvXnR7BfOAUxcj9WK63fzt3K/exnQ6FKWTP6q5lVPCF6yjW0tcBHuX7uKYqLUam/+Q+5F7XUA3ryNQcxfpBoirHbw==@vger.kernel.org, AJvYcCWU6RCNqr6Kh6CuOO14CkSrijPo9g2AqCqoaJu7UJo8YdlJAw9lGiupLsoz5QAEO4D75lYVNV2kRxqK@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnUer6kmvyqV4XFf7hgcwg6QYFht/x5XkIn1Je+DF8BDYbyVr
	jufMbwzagJHmvTRskJONBi6NU3o0y9ZX2xEmnLenHbBYns4d1ghi
X-Gm-Gg: ASbGncuPbUAPL5F+kQJThMpHXAaAKVM4OOBnBwZ4junpqW0opgvD2LFp9NmW9zmLI8S
	CQfPuVJAgtq58aSXxqZKpLtTIT65jZJ3zL8E4wmL43yc16qxTxoQ1+DzlZhK683iQqd1hwUHxRk
	uBgXJ2eySGBwIGv/twERJgXWxqrQAWhZ3BjqHXCmRl8Z+U6YLkxPLX5TPbOCXzBmbYrjlU0mh08
	QNHpRssmxJBv6Ot+sj4eiCayFOHSE5DyyWEiZMQLj7fFWIG/msufIRzLFJ+YyKvtRcomBqnDt6n
	vL9woy/9Itx3/hqhawoogG5mYDzNRa+C37c7AV9z6Wqz
X-Google-Smtp-Source: AGHT+IEHrNiRnTXjVPBRN3km9ezXq9nftJR+dFDQktX4gOLxCfeSk1aB3DWtqmO/wcVrpprP5KJBrA==
X-Received: by 2002:a17:90b:58ed:b0:2fa:2133:bc87 with SMTP id 98e67ed59e1d1-309ec5e69fdmr363341a91.6.1745433083197;
        Wed, 23 Apr 2025 11:31:23 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309e0d06b13sm1984557a91.43.2025.04.23.11.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 15:31:17 -0300
Message-Id: <D9E8DY5E0CTO.2O6K5NWUGKA6Z@gmail.com>
Subject: Re: [PATCH 6/7] platform/x86/dell: alienware-wmi: update sysfs
 visibility macros
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
 <bhelgaas@google.com>, <hdegoede@redhat.com>,
 <ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
 <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
 <sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <dakr@kernel.org>, <dan.j.williams@intel.com>,
 <andriy.shevchenko@linux.intel.com>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-7-david.e.box@linux.intel.com>
In-Reply-To: <20250423175040.784680-7-david.e.box@linux.intel.com>

On Wed Apr 23, 2025 at 2:50 PM -03, David E. Box wrote:
> Replace deprecated visibility macros and align group naming with new API.
>
> In alienware-wmi-base.c, use NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(rgb_zone=
s)
> to define the rgb_zones attribute group concisely. To preserve the existi=
ng
> userspace ABI, rename zone_attr_visible and rgb_zones_attr_visible to
> zone_group_visible and rgb_zones_group_visible, respectively, to reflect =
the
> 'rgb_zones' group.
>
> In alienware-wmi-wmax.c, replace DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() with
> the renamed DEFINE_SYSFS_GROUP_VISIBILITY() macro for the hdmi, amplifier=
,
> and deepsleep attributes to match the updated API.
>
> While here, add missing sysfs.h include and sort headers alphabetically. =
No
> functional changes are intended.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks! I like these new macros.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

Small comment bellow.

> ---
>  .../platform/x86/dell/alienware-wmi-base.c    | 23 ++++++++-----------
>  .../platform/x86/dell/alienware-wmi-wmax.c    |  7 +++---
>  2 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-base.c b/drivers/pla=
tform/x86/dell/alienware-wmi-base.c
> index 64562b92314f..ee41892e562c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-base.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-base.c
> @@ -10,10 +10,11 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/cleanup.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/dmi.h>
>  #include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
>  #include "alienware-wmi.h"
> =20
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> @@ -326,8 +327,8 @@ static ssize_t lighting_control_state_store(struct de=
vice *dev,
> =20
>  static DEVICE_ATTR_RW(lighting_control_state);
> =20
> -static umode_t zone_attr_visible(struct kobject *kobj,
> -				 struct attribute *attr, int n)
> +static umode_t rgb_zones_attr_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
>  {
>  	if (n < alienfx->num_zones + 1)
>  		return attr->mode;
> @@ -335,13 +336,12 @@ static umode_t zone_attr_visible(struct kobject *ko=
bj,
>  	return 0;
>  }
> =20
> -static bool zone_group_visible(struct kobject *kobj)
> +static bool rgb_zones_group_visible(struct kobject *kobj)
>  {
>  	return alienfx->num_zones > 0;
>  }
> -DEFINE_SYSFS_GROUP_VISIBLE(zone);
> =20
> -static struct attribute *zone_attrs[] =3D {
> +static struct attribute *rgb_zones_attrs[] =3D {
>  	&dev_attr_lighting_control_state.attr,
>  	&dev_attr_zone00.attr,
>  	&dev_attr_zone01.attr,
> @@ -349,12 +349,7 @@ static struct attribute *zone_attrs[] =3D {
>  	&dev_attr_zone03.attr,
>  	NULL
>  };
> -
> -static struct attribute_group zone_attribute_group =3D {
> -	.name =3D "rgb_zones",
> -	.is_visible =3D SYSFS_GROUP_VISIBLE(zone),
> -	.attrs =3D zone_attrs,
> -};
> +NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(rgb_zones);
> =20
>  /*
>   * LED Brightness (Global)
> @@ -410,7 +405,7 @@ static int alienfx_probe(struct platform_device *pdev=
)
>  }
> =20
>  static const struct attribute_group *alienfx_groups[] =3D {
> -	&zone_attribute_group,
> +	&rgb_zones_group,
>  	WMAX_DEV_GROUPS
>  	NULL
>  };
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pla=
tform/x86/dell/alienware-wmi-wmax.c
> index 0c3be03385f8..559415849bcc 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -13,6 +13,7 @@
>  #include <linux/dmi.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_profile.h>
> +#include <linux/sysfs.h>

JFYI, this line conflicts with linux-next.

--=20
 ~ Kurt

>  #include <linux/wmi.h>
>  #include "alienware-wmi.h"
> =20
> @@ -356,7 +357,7 @@ static bool hdmi_group_visible(struct kobject *kobj)
>  {
>  	return alienware_interface =3D=3D WMAX && alienfx->hdmi_mux;
>  }
> -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
> +DEFINE_SYSFS_GROUP_VISIBILITY(hdmi);
> =20
>  static struct attribute *hdmi_attrs[] =3D {
>  	&dev_attr_cable.attr,
> @@ -404,7 +405,7 @@ static bool amplifier_group_visible(struct kobject *k=
obj)
>  {
>  	return alienware_interface =3D=3D WMAX && alienfx->amplifier;
>  }
> -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
> +DEFINE_SYSFS_GROUP_VISIBILITY(amplifier);
> =20
>  static struct attribute *amplifier_attrs[] =3D {
>  	&dev_attr_status.attr,
> @@ -475,7 +476,7 @@ static bool deepsleep_group_visible(struct kobject *k=
obj)
>  {
>  	return alienware_interface =3D=3D WMAX && alienfx->deepslp;
>  }
> -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
> +DEFINE_SYSFS_GROUP_VISIBILITY(deepsleep);
> =20
>  static struct attribute *deepsleep_attrs[] =3D {
>  	&dev_attr_deepsleep.attr,


