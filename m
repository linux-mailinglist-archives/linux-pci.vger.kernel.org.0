Return-Path: <linux-pci+bounces-3079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D538495A2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303211C23107
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51961170E;
	Mon,  5 Feb 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggTFkGeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F011701;
	Mon,  5 Feb 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122927; cv=none; b=pvyvCZImpZH/Lw9JFxpkESyB4nj+7zHnknMKoS0QCwvFtJ7IpnOBtO5SQJ0FJ01d6YqYyfClO3UTmjB317GVqhciNn8mwdbPNgun8K+vR0VkOrXxykqFIVE1tAot6LfuUo4rTP5LAPU8enZvgcMjLptFHNjXJGsPqNDqHApCW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122927; c=relaxed/simple;
	bh=jN9HsR6pkHBGGNfaNQqz0Qo2mPCuk2AwkMIowfmzCxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYXF9lSV7nH1gy8H/cuwc/8z6EsldzJsfUIOBmgQTM9cTNJ7LbfHj9gVzb8TgdEwe2zQluoCTs0uKZbNtmttCdaohDDeMOpq+gas8vy5FRmZvOAxe4u+0AG7XSeS+DaUjAUdw41AZF4QFdZdc3pxcXMRmB7SEHiV0rxKGXGf8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggTFkGeg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5113303e664so4167293e87.0;
        Mon, 05 Feb 2024 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707122924; x=1707727724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ydA0TsnU465lLz9wxK97OfQIetnhQ94qrcei325RlU=;
        b=ggTFkGegNisLCfNo9cF5nHEbdqZAqURqxYPxhbeX1FSU31qrmjK1CzFlxuocuHSbQk
         oYuLOM+tW0b7PChZBwI8ULGxpvESSZ+kP1CVTijbGYKzN+TMIOfUkFweR2lIlD//srQR
         vJ+NhTCVH5ETLwuSmFsy6bDRyutJ6y41SXz7cc7XhVraXu9pV5aN5pQqhMYqkANq7Cx4
         SKuMPa+l4ThEQxFbQANjMsdfg1xvfPb31H5b6rVOov/WK8mswJO9hsdOaYuq8pKJvw/k
         7ItVc0M6O8P1Q0dOsea7dgLypEnxe/KAMDKTjFgCYFdIZhx+YfMkH3MrdfO0nuUt4giL
         nwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707122924; x=1707727724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ydA0TsnU465lLz9wxK97OfQIetnhQ94qrcei325RlU=;
        b=K2oFqM2ft2CWKZ5yq1A/emmwTnzvxtpnsJMfgWUsjLn+OtSbGWYZGPCm5xFbRoD7G8
         1E0S9OxTdfFhu6WnDpBP3pUtuDfsB+mDMzQ44esqn0X3sckXyGdEqZuGZzqdx42iRh8Y
         QQeQEKSC+9w9Pkb5aT/Oc2pVMiqAXV+tvtHm5y942YPDYlf057+O69SWr29m0LM1Ee4b
         4thi4uBtEhwzqHctnZJ4jDXNyIqqr0ifx82AR4Lv8mlwyofJi2d2b8PuD82e5Ri86XOV
         HeM+LfN5WTPNYsQXNcZcMPuUz8jA7jkEcyJ1xUVjTHnSLWigDGTarhHxjfwYBLhtxfRp
         cIfg==
X-Gm-Message-State: AOJu0YxaYOLwJcr5JYA+ZZtBoUa9wpNsa6Tgk2535EfGHsIV2J1TXzsq
	oamRnervyd7cIEOsuyhtaZVYg57eDzliz0pnfw0GGJDIVsQ3MY9F
X-Google-Smtp-Source: AGHT+IGj2EJGaW3ePkdcXnqMICBr00UnLOrY2sn4RNzOXXc74BszNhMhBcvP3UIS16mAc/2cBo9nZg==
X-Received: by 2002:a05:6512:31cb:b0:511:3a70:b954 with SMTP id j11-20020a05651231cb00b005113a70b954mr6520932lfe.18.1707122923640;
        Mon, 05 Feb 2024 00:48:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXCoeSRFEtdkJcbTVUZ54U6K3KuWSeDkOfG2db1WYNHjJg/nRAjfbybs8KpLWSO1Pd6zr/YZ1svqmlZm3as6lC4UXHrL8TY5kWDNRXZcSECchOZt7VOzWEOSZwTxyfdBG5C7Olmv98tvr3AJSpdHITAI4o4A4z9GXYiyuWRN7poAITWXzkE3R6XPIZzZuzXD0GbAVB7ZvDKq8QGk3AJWHP4M8M/vTc9EQbuMiZZ/lbWB7idgBKgmJF2e9TbSZ/UYrwAPfhGUqWy0tPvhlBIXTLmZqXKxuoGfHZIJPBDpEp8Dte+UPe0/0cSTYPWBQswSUjTIr2o6duH2IRJ4ZQifAdzdHstuXQXoPuIEoNilHlJ+tACRHpFcMflp4iXhQYmITMGnspvl5B/crOIO1VlE1TDsjqzHjr26JaJJA87UhBR/oRT1OESDFQR3wsT+hrt572U9hyNVRRPJmfTDnyj07yhzV9tmHz26k0DxnAjbED3HFwVFZvc5Jz7oM6ml7r6csJrkara0EX0K+SpkKEDPk72N8lHRAam64iIulwa+3ApOaXISqm2IbqnMcHOnBtjUQSFe0VRfiDE/iC25pS6mWi+Tl436sPlbsRc/uDAqOcI1vXRFXjXLolBujD2yLQ1AETm27yRExX8o88gC9denL3Qi4GZ9K1lMq3PzMenHfEOVCr5QNP08F7af5epMZMFvTTQ3Ozi8p1fSQc++S64TL4KrhUvtnj2Q3uNCAMx6um8ytlvJZRqIh25Z97b
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b0040e541ddcb1sm7877780wms.33.2024.02.05.00.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:48:43 -0800 (PST)
Message-ID: <fe098f5a-b0b0-4698-ad8f-2d302fa37626@gmail.com>
Date: Mon, 5 Feb 2024 09:48:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: bus: introduce can_remove()
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 James Zhu <James.Zhu@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Iwona Winiarska <iwona.winiarska@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240202222603.141240-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.02.24 um 23:25 schrieb Hamza Mahfooz:
> Currently, drivers have no mechanism to block requests to unbind
> devices. However, this can cause resource leaks and leave the device in
> an inconsistent state, such that rebinding the device may cause a hang
> or otherwise prevent the device from being rebound. So, introduce
> the can_remove() callback to allow drivers to indicate if it isn't
> appropriate to remove a device at the given time.

Well that is nonsense. When you physically remove a device (e.g. unplug 
it) then there is nothing in software you can do to prevent that.

Regards,
Christian.

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>   drivers/base/bus.c         | 4 ++++
>   include/linux/device/bus.h | 2 ++
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index daee55c9b2d9..7c259b01ea99 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -239,6 +239,10 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
>   
>   	dev = bus_find_device_by_name(bus, NULL, buf);
>   	if (dev && dev->driver == drv) {
> +		if (dev->bus && dev->bus->can_remove &&
> +		    !dev->bus->can_remove(dev))
> +			return -EBUSY;
> +
>   		device_driver_detach(dev);
>   		err = count;
>   	}
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 5ef4ec1c36c3..c9d4af0ed3b8 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -46,6 +46,7 @@ struct fwnode_handle;
>    *		be called at late_initcall_sync level. If the device has
>    *		consumers that are never bound to a driver, this function
>    *		will never get called until they do.
> + * @can_remove: Called before attempting to remove a device from this bus.
>    * @remove:	Called when a device removed from this bus.
>    * @shutdown:	Called at shut-down time to quiesce the device.
>    *
> @@ -85,6 +86,7 @@ struct bus_type {
>   	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
>   	int (*probe)(struct device *dev);
>   	void (*sync_state)(struct device *dev);
> +	bool (*can_remove)(struct device *dev);
>   	void (*remove)(struct device *dev);
>   	void (*shutdown)(struct device *dev);
>   


