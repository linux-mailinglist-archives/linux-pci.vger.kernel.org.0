Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28C118046
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfEHTKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 May 2019 15:10:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46519 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEHTKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 May 2019 15:10:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so13023417qkb.13
        for <linux-pci@vger.kernel.org>; Wed, 08 May 2019 12:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=vV003PLEaBn/KG12s5VcOX/aojC+TH41Cbg8YZMkcAk=;
        b=XHvZDBVsvnOXc0uhmWCsKzssSbBuZFVKfYYcaE1DdZdWs3Agvw7fSZWBvalG6KFCu+
         YzMUrdgMCnEPLpoCWTHyKM9yTFjbWfwX3CZKWnaJEb8luldbujgpTB+aETYDuUMsdYCc
         6jKM1pnXbk651SBRoXjzXXw0GOQLuWkgwBx5MRJdxMWQyPdqfgfRk8iDXhskMfwVCu4G
         vFYN0JF10TdRyMdQzEKhejNdveXyz+E1n4tMl9qPdIOUNywQowh9mv5FJtx1cg5KrpVQ
         IHCyrYoCfV1aaghkv4I2UloVveqbEdGXLi8Fyj3mytrH7nVhVT1HD9g09EH6rtN6KYId
         C/Og==
X-Gm-Message-State: APjAAAW93z7zcxWTt2CrwxsBEwZhpLssshHYoRjXkA8ISerOnMNMn+TN
        kMkNcZG87ILzgHeaKv8LdqBHksK1ZsUh4Q==
X-Google-Smtp-Source: APXvYqy14RkpbSqH0QpporGNEQqNp01BEXkPh0TIm1hUbOOlmY939xb27+DObgfY6FHEEA1VBD+67w==
X-Received: by 2002:a05:620a:15fb:: with SMTP id p27mr30212701qkm.286.1557342641870;
        Wed, 08 May 2019 12:10:41 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id t55sm12018762qth.59.2019.05.08.12.10.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 12:10:41 -0700 (PDT)
Message-ID: <70bd607ac14d19b023834853a44af40d9dee1942.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] drm: don't set the pci power state if the pci
 subsystem handles the ACPI bits
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Date:   Wed, 08 May 2019 15:10:40 -0400
In-Reply-To: <20190507201245.9295-2-kherbst@redhat.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
         <20190507201245.9295-2-kherbst@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2019-05-07 at 22:12 +0200, Karol Herbst wrote:
> v2: rework detection of if Nouveau calling a DSM method or not
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drm/nouveau/nouveau_acpi.c |  7 ++++++-
>  drm/nouveau/nouveau_acpi.h |  2 ++
>  drm/nouveau/nouveau_drm.c  | 14 +++++++++++---
>  drm/nouveau/nouveau_drv.h  |  2 ++
>  4 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drm/nouveau/nouveau_acpi.c b/drm/nouveau/nouveau_acpi.c
> index ffb19585..92dfc900 100644
> --- a/drm/nouveau/nouveau_acpi.c
> +++ b/drm/nouveau/nouveau_acpi.c
> @@ -358,6 +358,12 @@ void nouveau_register_dsm_handler(void)
>  	vga_switcheroo_register_handler(&nouveau_dsm_handler, 0);
>  }
>  
> +bool nouveau_runpm_calls_dsm(void)
> +{
> +	return nouveau_dsm_priv.optimus_detected &&
> +		!nouveau_dsm_priv.optimus_skip_dsm;
> +}
> +
>  /* Must be called for Optimus models before the card can be turned off */
>  void nouveau_switcheroo_optimus_dsm(void)
>  {
> @@ -371,7 +377,6 @@ void nouveau_switcheroo_optimus_dsm(void)
>  
>  	nouveau_optimus_dsm(nouveau_dsm_priv.dhandle,
> NOUVEAU_DSM_OPTIMUS_CAPS,
>  		NOUVEAU_DSM_OPTIMUS_SET_POWERDOWN, &result);
> -
>  }
>  
>  void nouveau_unregister_dsm_handler(void)
> diff --git a/drm/nouveau/nouveau_acpi.h b/drm/nouveau/nouveau_acpi.h
> index b86294fc..0f5d7aa0 100644
> --- a/drm/nouveau/nouveau_acpi.h
> +++ b/drm/nouveau/nouveau_acpi.h
> @@ -13,6 +13,7 @@ void nouveau_switcheroo_optimus_dsm(void);
>  int nouveau_acpi_get_bios_chunk(uint8_t *bios, int offset, int len);
>  bool nouveau_acpi_rom_supported(struct device *);
>  void *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
> +bool nouveau_runpm_calls_dsm(void);
>  #else
>  static inline bool nouveau_is_optimus(void) { return false; };
>  static inline bool nouveau_is_v1_dsm(void) { return false; };
> @@ -22,6 +23,7 @@ static inline void nouveau_switcheroo_optimus_dsm(void) {}
>  static inline bool nouveau_acpi_rom_supported(struct device *dev) { return
> false; }
>  static inline int nouveau_acpi_get_bios_chunk(uint8_t *bios, int offset,
> int len) { return -EINVAL; }
>  static inline void *nouveau_acpi_edid(struct drm_device *dev, struct
> drm_connector *connector) { return NULL; }
> +static inline bool nouveau_runpm_calls_dsm(void) { return false; }
>  #endif
>  
>  #endif
> diff --git a/drm/nouveau/nouveau_drm.c b/drm/nouveau/nouveau_drm.c
> index 5020265b..09e68e61 100644
> --- a/drm/nouveau/nouveau_drm.c
> +++ b/drm/nouveau/nouveau_drm.c
> @@ -556,6 +556,7 @@ nouveau_drm_device_init(struct drm_device *dev)
>  	nouveau_fbcon_init(dev);
>  	nouveau_led_init(dev);
>  
> +	drm->runpm_dsm = nouveau_runpm_calls_dsm();
>  	if (nouveau_pmops_runtime()) {
>  		pm_runtime_use_autosuspend(dev->dev);
>  		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> @@ -903,6 +904,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct nouveau_drm *drm = nouveau_drm(drm_dev);
>  	int ret;
>  
>  	if (!nouveau_pmops_runtime()) {
> @@ -910,12 +912,15 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> +	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>  	nouveau_switcheroo_optimus_dsm();
>  	ret = nouveau_do_suspend(drm_dev, true);
>  	pci_save_state(pdev);
>  	pci_disable_device(pdev);
>  	pci_ignore_hotplug(pdev);
> -	pci_set_power_state(pdev, PCI_D3cold);
> +	if (drm->runpm_dsm)
> +		pci_set_power_state(pdev, PCI_D3cold);
> +
>  	drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>  	return ret;
>  }
> @@ -925,7 +930,8 @@ nouveau_pmops_runtime_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -	struct nvif_device *device = &nouveau_drm(drm_dev)->client.device;
> +	struct nouveau_drm *drm = nouveau_drm(drm_dev);
> +	struct nvif_device *device = &drm->client.device;
>  	int ret;
>  
>  	if (!nouveau_pmops_runtime()) {
> @@ -933,7 +939,9 @@ nouveau_pmops_runtime_resume(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> -	pci_set_power_state(pdev, PCI_D0);
> +	drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> +	if (drm->runpm_dsm)
> +		pci_set_power_state(pdev, PCI_D0);
>  	pci_restore_state(pdev);
>  	ret = pci_enable_device(pdev);
>  	if (ret)
> diff --git a/drm/nouveau/nouveau_drv.h b/drm/nouveau/nouveau_drv.h
> index da847244..941600e9 100644
> --- a/drm/nouveau/nouveau_drv.h
> +++ b/drm/nouveau/nouveau_drv.h
> @@ -214,6 +214,8 @@ struct nouveau_drm {
>  	struct nouveau_svm *svm;
>  
>  	struct nouveau_dmem *dmem;
> +
> +	bool runpm_dsm;
>  };
>  
>  static inline struct nouveau_drm *
-- 
Cheers,
	Lyude Paul

