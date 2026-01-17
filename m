Return-Path: <linux-pci+bounces-45095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A114D38EE0
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 15:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6747130124D1
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60E1940A1;
	Sat, 17 Jan 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbMqGMUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8817993;
	Sat, 17 Jan 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658593; cv=none; b=BZvoxMvoTSp7gRNp/8ELZoEk8C/dvCKdu9SBpviCXs7ER21/+B0aH+TYlFSAFyjuGxJxDeuXwFC6pibiEpc+40L/wL6kkPqKFMZSNJ40BwG1oRoiRH7SNyln14rRad9RMdFwilPsJEYey6zJYyuVpelOrW0PN6NhzWdPAi8by/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658593; c=relaxed/simple;
	bh=o8M5Ux5TLE7XXbDV/3mxjN+nYHb8D1HktVmRJfjUl8U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=g6c8KW1c4SgZhlwDsBhs0kHnqgjb3r9uqY/u/KPkaM9PSKTPS7TsWTy//rp+LmhJDYNVIUxyIfDv2H2yoMutWuAHfhjHynH+tw1ofhThpQ/EBglakekn+z6QGNByStIB7cF0DrzpDi7sJlg6H6zckXblcT/KbEMWwwtwhhv6JJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbMqGMUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8775BC4CEF7;
	Sat, 17 Jan 2026 14:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768658592;
	bh=o8M5Ux5TLE7XXbDV/3mxjN+nYHb8D1HktVmRJfjUl8U=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=gbMqGMUdcSHw0cd2MyJxSW0lxOD4QzHwy1sV1N4zoAHQfe7/1jtCUqymMQpDbPuhi
	 1qO+2OCRRhsQ0DDAZqYQYQCsItJB2Pd3cbDZVyhw4mchCRci6b3lB0BXVpsPwt4rSU
	 MusnAt6zQ4mND8UgZG8d5OXmAqO6TT0Xu+VAZ472N6t5ce/1VtQ2IN0aCcJCA35onv
	 o7f9wfq5+6tCbuuVNDOPxP+7qyCpVgobFF7jwCiJZPP0fjp7IoxoGPrGhTi7hU7Lvw
	 pDkL5Otj6IXptp8oOrFFokFcbTmGhPYywh6mGOj9KgUSB+4jW3LrFW2jHeiiHGJIbW
	 bUlNP1EbZBpYQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 15:03:08 +0100
Message-Id: <DFQX56VQ3FAV.3LIDGP9F41X1U@kernel.org>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/3] driver core: Add NUMA-node awareness to the
 synchronous probe path
Cc: <alexander.h.duyck@linux.intel.com>, <alexanderduyck@fb.com>,
 <bhelgaas@google.com>, <bvanassche@acm.org>, <dan.j.williams@intel.com>,
 <gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>,
 <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
References: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
 <20260107175548.1792-3-guojinhui.liam@bytedance.com>
In-Reply-To: <20260107175548.1792-3-guojinhui.liam@bytedance.com>

On Wed Jan 7, 2026 at 6:55 PM CET, Jinhui Guo wrote:
> @@ -808,6 +894,8 @@ static int __driver_probe_device(const struct device_=
driver *drv, struct device
>  	return ret;
>  }
> =20
> +DEFINE_NUMA_WRAPPER(__driver_probe_device, const struct device_driver *,=
 struct device *)
> +
>  /**
>   * driver_probe_device - attempt to bind device & driver together
>   * @drv: driver to bind a device to
> @@ -844,6 +932,8 @@ static int driver_probe_device(const struct device_dr=
iver *drv, struct device *d
>  	return ret;
>  }
> =20
> +DEFINE_NUMA_WRAPPER(driver_probe_device, const struct device_driver *, s=
truct device *)
> +
>  static inline bool cmdline_requested_async_probing(const char *drv_name)
>  {
>  	bool async_drv;
> @@ -1000,6 +1090,8 @@ static int __device_attach_driver_scan(struct devic=
e_attach_data *data,
>  	return ret;
>  }
> =20
> +DEFINE_NUMA_WRAPPER(__device_attach_driver_scan, struct device_attach_da=
ta *, bool *)

Why define three different wrappers? To me it looks like we should easily g=
et
away with a single wrapper for __driver_probe_device(), which could just be
__driver_probe_device_node().


__device_attach_driver_scan() already has this information (i.e. we can che=
ck if
need_async =3D=3D NULL). Additionally, we can change the signature of
driver_probe_device() to

	static int driver_probe_device(const struct device_driver *drv, struct dev=
ice *dev, bool async)

This reduces complexity a lot, since it gets us rid of DEFINE_NUMA_WRAPPER(=
) and
EXEC_ON_NUMA_NODE() macros.

>  static void __device_attach_async_helper(void *_dev, async_cookie_t cook=
ie)
>  {
>  	struct device *dev =3D _dev;
> @@ -1055,7 +1147,9 @@ static int __device_attach(struct device *dev, bool=
 allow_async)
>  			.want_async =3D false,
>  		};
> =20
> -		ret =3D __device_attach_driver_scan(&data, &async);
> +		ret =3D EXEC_ON_NUMA_NODE(dev_to_node(dev),
> +					__device_attach_driver_scan,
> +					&data, &async);
>  	}
>  out_unlock:
>  	device_unlock(dev);
> @@ -1142,7 +1236,9 @@ int device_driver_attach(const struct device_driver=
 *drv, struct device *dev)
>  	int ret;
> =20
>  	__device_driver_lock(dev, dev->parent);
> -	ret =3D __driver_probe_device(drv, dev);
> +	ret =3D EXEC_ON_NUMA_NODE(dev_to_node(dev),
> +				__driver_probe_device,
> +				drv, dev);
>  	__device_driver_unlock(dev, dev->parent);
> =20
>  	/* also return probe errors as normal negative errnos */
> @@ -1231,7 +1327,9 @@ static int __driver_attach(struct device *dev, void=
 *data)
>  	}
> =20
>  	__device_driver_lock(dev, dev->parent);
> -	driver_probe_device(drv, dev);
> +	EXEC_ON_NUMA_NODE(dev_to_node(dev),
> +			  driver_probe_device,
> +			  drv, dev);
>  	__device_driver_unlock(dev, dev->parent);
> =20
>  	return 0;
> --=20
> 2.20.1


