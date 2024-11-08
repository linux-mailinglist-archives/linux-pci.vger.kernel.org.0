Return-Path: <linux-pci+bounces-16314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DDB9C1998
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BDC1F2443E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EE31E1C3B;
	Fri,  8 Nov 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+EmRHg9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C011CF291
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059853; cv=none; b=CBioC4rn+F/uVIB01VVUgYHG0+8mDXaFvdlqL3V+eJsD0gazpzsNtTvWHWn4Nr+LMnhNW0WwFU9Lr/e7PH8ie+lcGmBikRmYbs3Y18+wrk7pkDUE4KbvQ7wJmWqZGsyQdYiyLHHrNZjgdEdElfdbgEyUDT+zskTBkEKZbPEiTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059853; c=relaxed/simple;
	bh=8fI1kWvz6hGfQzWAO2sB4JOqTLhejAN4OfQdn+uncMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qC7buFD99USQ0UYjEd8+Xn82K/33j2Rw6YPA3PpWVRHgCp14A7bICQGJ02mOuQETmetqk7WK61Ee1BhZnKB0QDh5YxQ1U1I58WlSCAws5B5N02wkgsNNqbYEaaRNG8kI2ULPnrbGBk1fNXHHdWcEwXNVgYhP8u2Yrc6wg/qCo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+EmRHg9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso16092775e9.3
        for <linux-pci@vger.kernel.org>; Fri, 08 Nov 2024 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731059849; x=1731664649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qvSjFgT9QigLmSV7E1Bd8DDsmjWl8PjqBY+cyP/Rbk=;
        b=r+EmRHg9Wio3I2CXfbejiEK7TYa+vBhJNccbX2yRyz5L8tYR8b4YkVDkmJF2rSAGqf
         yeKCEEXSR22yA+MxHXnIm78RcdKuowWxl4t3MjX+EfSlc20OZ64o39uogROjxOGr0Kmf
         jS5vf2OYMNmBmP9hA8owbCs2/R+M4peff78zfaoDuX14zWwruWkV2SnjZlvB8nFSaiB8
         W0S/B/LpgIsEEBgyNN5GHcRUMu92u2yNWaffZYnTezcfGPCbtgAJb5/f/Ziva4/vqOLc
         7+wkQI+cpjUTjXb5Vvr9zSI+oVslva2iTYPsodGIuPguPl1jgEVbl8nj/NKy9PxjsSA+
         qQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731059849; x=1731664649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qvSjFgT9QigLmSV7E1Bd8DDsmjWl8PjqBY+cyP/Rbk=;
        b=Xkc/elzc1ueHBtaZ1BLZrQiaXjq8VCSxHkVf0nl9STP47jY6qAN8aR8wRXAIQUVFDP
         uE13r67hdF8mktvHhkz2iaGvuUJ29g29GtoRur0CW0NTfWjJUoGKYHNnr8gjha8IZ2yl
         xWL/RULCEpMsJG1wpFXGQxNCzDX8xP/6ddu+Jq7Rd/D7tZt2NQCceyzzKmv9PonbQt2A
         52bvJukgLn+HV8dhFpbro2Uy1TG9qwaO0lgTizrRHMy/gpWw7uhm/OfS6NyA7N3fV1H4
         ucQG27/mcdVZC0JUmED/vAnrYZ5RZhXy81hDHVov30AAN9Hdg/gOoYQPqamUMNdDpj8Q
         f4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWLreYILyhJ9COEx3SDxHBrjFlyQ1GDWJcJKWEBS5VvVR++SGsLpJyovf0sI9KBrblg0d2WprAdEmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjqHt3lqwrmVA/LgbDv61cFqvSdE72zbYTCKwDffwWGl65iiuw
	AxWwNJwLQT07U9hJSZ7QqoCE5qefEIVI8VcCDHHVYSopQvaVKN/m5RR5Bca1EjE=
X-Google-Smtp-Source: AGHT+IGSM0YIoIJwn4bQFLUSfQjkco2eSXc7cP/BCeCrt62cX0r5HN3g5uOpTFuxNeCM9lxmmGx4PQ==
X-Received: by 2002:a05:600c:4448:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-432b7509c5fmr17646005e9.17.1731059848755;
        Fri, 08 Nov 2024 01:57:28 -0800 (PST)
Received: from [172.20.143.194] ([89.101.134.25])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432aa70a234sm94913735e9.34.2024.11.08.01.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:57:28 -0800 (PST)
Message-ID: <5bd704c3-88c1-4b6f-82ec-25f9d7a6e92b@linaro.org>
Date: Fri, 8 Nov 2024 09:57:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] sysfs: treewide: constify attribute callback of
 bin_is_visible()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Logan Gunthorpe <logang@deltatee.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
 <20241103-sysfs-const-bin_attr-v2-5-71110628844c@weissschuh.net>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-5-71110628844c@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/11/2024 17:03, Thomas Weißschuh wrote:
> The is_bin_visible() callbacks should not modify the struct
> bin_attribute passed as argument.
> Enforce this by marking the argument as const.
> 
> As there are not many callback implementers perform this change
> throughout the tree at once.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   drivers/cxl/port.c                      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
>   drivers/infiniband/hw/qib/qib_sysfs.c   |  2 +-
>   drivers/mtd/spi-nor/sysfs.c             |  2 +-

thanks for the patch.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org> #nvmem


--srini
>   drivers/nvmem/core.c                    |  3 ++-
>   drivers/pci/pci-sysfs.c                 |  2 +-
>   drivers/pci/vpd.c                       |  2 +-
>   drivers/platform/x86/amd/hsmp.c         |  2 +-
>   drivers/platform/x86/intel/sdsi.c       |  2 +-
>   drivers/scsi/scsi_sysfs.c               |  2 +-
>   drivers/usb/core/sysfs.c                |  2 +-
>   include/linux/sysfs.h                   | 30 +++++++++++++++---------------
>   12 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 9dc394295e1fcd1610813837b2f515b66995eb25..24041cf85cfbe6c54c467ac325e48c775562b938 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -173,7 +173,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
>   static BIN_ATTR_ADMIN_RO(CDAT, 0);
>   
>   static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> -					    struct bin_attribute *attr, int i)
> +					    const struct bin_attribute *attr, int i)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct cxl_port *port = to_cxl_port(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0b28b2cf1517d130da01989df70b9dff6433edc4..c1c329eb920b52af100a93bdf00df450e25608c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3999,7 +3999,7 @@ static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribu
>   }
>   
>   static umode_t amdgpu_bin_flash_attr_is_visible(struct kobject *kobj,
> -						struct bin_attribute *attr,
> +						const struct bin_attribute *attr,
>   						int idx)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
> diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
> index 53ec7510e4ebfb144e79884ca7dd7d0c873bd8a7..ba2cd68b53e6c240f1afc65c64012c75ccf488e0 100644
> --- a/drivers/infiniband/hw/qib/qib_sysfs.c
> +++ b/drivers/infiniband/hw/qib/qib_sysfs.c
> @@ -283,7 +283,7 @@ static struct bin_attribute *port_ccmgta_attributes[] = {
>   };
>   
>   static umode_t qib_ccmgta_is_bin_visible(struct kobject *kobj,
> -				 struct bin_attribute *attr, int n)
> +				 const struct bin_attribute *attr, int n)
>   {
>   	struct qib_pportdata *ppd = qib_get_pportdata_kobj(kobj);
>   
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> index 96064e4babf01f6950c81586764386e7671cbf97..5e9eb268073d18e0a46089000f18a3200b4bf13d 100644
> --- a/drivers/mtd/spi-nor/sysfs.c
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -87,7 +87,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
>   }
>   
>   static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
> -					    struct bin_attribute *attr, int n)
> +					    const struct bin_attribute *attr, int n)
>   {
>   	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
>   	struct spi_mem *spimem = spi_get_drvdata(spi);
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 63370c76394ee9b8d514da074779617cef67c311..73e44d724f90f4cd8fe8cafb9fa0c0fb23078e61 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -298,7 +298,8 @@ static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
>   }
>   
>   static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> -					 struct bin_attribute *attr, int i)
> +					 const struct bin_attribute *attr,
> +					 int i)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct nvmem_device *nvmem = to_nvmem_device(dev);
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 040f01b2b999175e8d98b05851edc078bbabbe0d..13912940ed2bb66c0086e5bea9a3cb6417ac14dd 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1326,7 +1326,7 @@ static struct bin_attribute *pci_dev_rom_attrs[] = {
>   };
>   
>   static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
> -					   struct bin_attribute *a, int n)
> +					   const struct bin_attribute *a, int n)
>   {
>   	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>   
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index e4300f5f304f3ca55a657fd25a1fa5ed919737a7..a469bcbc0da7f7677485c7f999f8dfb58b8ae8a3 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -325,7 +325,7 @@ static struct bin_attribute *vpd_attrs[] = {
>   };
>   
>   static umode_t vpd_attr_is_visible(struct kobject *kobj,
> -				   struct bin_attribute *a, int n)
> +				   const struct bin_attribute *a, int n)
>   {
>   	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>   
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
> index 8fcf38eed7f00ee01aade6e3e55e20402458d5aa..8f00850c139fa8d419bc1c140c1832bf84b2c3bd 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -620,7 +620,7 @@ static int hsmp_get_tbl_dram_base(u16 sock_ind)
>   }
>   
>   static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
> -					 struct bin_attribute *battr, int id)
> +					 const struct bin_attribute *battr, int id)
>   {
>   	if (plat_dev.proto_ver == HSMP_PROTO_VER6)
>   		return battr->attr.mode;
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 9d137621f0e6e7a23be0e0bbc6175c51c403169f..33f33b1070fdc949c1373251c3bca4234d9da119 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -541,7 +541,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
>   };
>   
>   static umode_t
> -sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
> +sdsi_battr_is_visible(struct kobject *kobj, const struct bin_attribute *attr, int n)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct sdsi_priv *priv = dev_get_drvdata(dev);
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 32f94db6d6bf5d2bd289c1a121da7ffc6a7cb2ff..f3a1ecb42128a2b221ca5c362e041eb59dba0f20 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1274,7 +1274,7 @@ static umode_t scsi_sdev_attr_is_visible(struct kobject *kobj,
>   }
>   
>   static umode_t scsi_sdev_bin_attr_is_visible(struct kobject *kobj,
> -					     struct bin_attribute *attr, int i)
> +					     const struct bin_attribute *attr, int i)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct scsi_device *sdev = to_scsi_device(dev);
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index 61b6d978892c799e213018bed22d9fb12a19d429..b4cba23831acd2d7d395b9f7683cd3ee3a8623c8 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -925,7 +925,7 @@ static struct bin_attribute *dev_bin_attrs[] = {
>   };
>   
>   static umode_t dev_bin_attrs_are_visible(struct kobject *kobj,
> -		struct bin_attribute *a, int n)
> +		const struct bin_attribute *a, int n)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct usb_device *udev = to_usb_device(dev);
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 4746cccb95898b24df6f53de9421ea7649b5568f..d1b22d56198b55ee39fe4c4fc994f5b753641992 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -101,7 +101,7 @@ struct attribute_group {
>   	umode_t			(*is_visible)(struct kobject *,
>   					      struct attribute *, int);
>   	umode_t			(*is_bin_visible)(struct kobject *,
> -						  struct bin_attribute *, int);
> +						  const struct bin_attribute *, int);
>   	size_t			(*bin_size)(struct kobject *,
>   					    const struct bin_attribute *,
>   					    int);
> @@ -199,22 +199,22 @@ struct attribute_group {
>    * attributes, the group visibility is determined by the function
>    * specified to is_visible() not is_bin_visible()
>    */
> -#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                             \
> -	static inline umode_t sysfs_group_visible_##name(                \
> -		struct kobject *kobj, struct bin_attribute *attr, int n) \
> -	{                                                                \
> -		if (n == 0 && !name##_group_visible(kobj))               \
> -			return SYSFS_GROUP_INVISIBLE;                    \
> -		return name##_attr_visible(kobj, attr, n);               \
> +#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                                   \
> +	static inline umode_t sysfs_group_visible_##name(                      \
> +		struct kobject *kobj, const struct bin_attribute *attr, int n) \
> +	{                                                                      \
> +		if (n == 0 && !name##_group_visible(kobj))                     \
> +			return SYSFS_GROUP_INVISIBLE;                          \
> +		return name##_attr_visible(kobj, attr, n);                     \
>   	}
>   
> -#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name)                   \
> -	static inline umode_t sysfs_group_visible_##name(             \
> -		struct kobject *kobj, struct bin_attribute *a, int n) \
> -	{                                                             \
> -		if (n == 0 && !name##_group_visible(kobj))            \
> -			return SYSFS_GROUP_INVISIBLE;                 \
> -		return a->mode;                                       \
> +#define DEFINE_SIMPLE_SYSFS_BIN_GROUP_VISIBLE(name)                         \
> +	static inline umode_t sysfs_group_visible_##name(                   \
> +		struct kobject *kobj, const struct bin_attribute *a, int n) \
> +	{                                                                   \
> +		if (n == 0 && !name##_group_visible(kobj))                  \
> +			return SYSFS_GROUP_INVISIBLE;                       \
> +		return a->mode;                                             \
>   	}
>   
>   #define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn
> 

