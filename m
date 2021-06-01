Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE193973D9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhFANJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 09:09:58 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34655 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFANJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 09:09:58 -0400
Received: by mail-wm1-f44.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1262431wmc.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Jun 2021 06:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9NHuuiFGViyJ4qvtBgD1WJEDgEC8Ax0IFhiq3JvT9Bw=;
        b=hSBdLcXMbfywraNNA2HyZ1ZQOMWOJVufiBS0SzdZaK4dxg2JiMQrZD9qzZ/CDXYb4a
         /zvWwHeL5HpPYTyKbVNhETthbDGt4a09Z4SmSntQy9hc7Hwng3M5rpK4UIuXU3qZfgTT
         30UIATOWv7jMcx1Ji0PAeMc3TPo/muxSqYFK6jIW2VOKGh4S59ZL7gu6HL01v0OWiHpN
         Jz3D9yfEYOPAAjvcRogR9utXti808s1MVFvDukjBKJNsdn9hTp3CB5Rlux3JkiiZEURv
         eJoMPcGhQxD1NIKIiI4bvZQ/BsIqVrETsWwtwMhgIXYTjMjFeZXW7s+z5my5b4QYrxYg
         VFbQ==
X-Gm-Message-State: AOAM530cm1Rbjrxn4Co9JtrrothdeTIv0nDHWuadG5UuG/S35hNFAvD2
        RPzye4vl3eIea1YpXrv6dqA=
X-Google-Smtp-Source: ABdhPJyYQYxUrC/dpgUc5QK/h+xYrk7iLXsypLvfMcIQFqjVKSWjDlTQnH0qRaIalJ/vcNIqW+j7gA==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr4594187wmg.19.1622552895035;
        Tue, 01 Jun 2021 06:08:15 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b15sm2936648wru.64.2021.06.01.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:08:14 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:08:13 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     linux-pci@vger.kernel.org, Alexander.Deucher@amd.com
Subject: Re: [PATCH] PCI: Add quirk for AMD Navi14 to disable ATS support
Message-ID: <20210601130813.GB195120@rocinante.localdomain>
References: <20210601024835.931947-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601024835.931947-1-evan.quan@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Evan,

Thank you for sending updated version!

[...]
> V2: cosmetic fix for description part(suggested by Krzysztof)

For future reference: as this is v2, then remember to update the subject
link to [PATCH v2] so that everyone looking at incoming patches would be
immediately made aware that this is a new version (also, some of our
automation such as Patchwork uses this when parsing subject lines).

Additionally, the changelog would customary be included under the "---"
lines so that it would automatically be removed alongside commit related
details from Git, see the following as an example:

  https://lore.kernel.org/linux-pci/20210601114301.2685875-1-linus.walleij@linaro.org/

Having said that, I am not sure if this warrants sending v3, as this
could be easily fixed here by either Bjorn or Lorenzo when this patch
will be merged, if they don't mind, of course.

[...]
> @@ -5176,7 +5176,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  {
>  	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
> -	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
> +	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
> +	    (pdev->device == 0x7341 && pdev->revision != 0x00))
[...]
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
