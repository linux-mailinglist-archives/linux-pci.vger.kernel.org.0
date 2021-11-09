Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9434344B3FA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbhKIUcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 15:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbhKIUcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 15:32:32 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C8C061764;
        Tue,  9 Nov 2021 12:29:46 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u2so847876oiu.12;
        Tue, 09 Nov 2021 12:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fu6Efpg1HM1VF7oK8oKNnaQ7ek93tEycWK/pneRESxI=;
        b=mBbW6xujuXL9r3LfLwp1UvmvE0kqthRG3Owuz/CniwMj8myKsmC/wNvOf9/UeIzkD+
         lW8RzmYpzlGl8gjBXM+YV5X35ZoCWGGplTLCgxx4cpdydNUkqIGhyioB1YFnSq4t8ehD
         1EFr7OV6NBNVQdG0y6ybW3xSPPuwy4t7mrR12UO//O1iuMneskAQKnn/xiWYSlBMQdWY
         y7qKjSdZURnPDZOcdZTCtgCx7VLGVw1SuPx/AlUlhNEes1YGR3zLdRLrE8W0Set8uyvD
         EjWoEOP7oALbA9iOqHHsKsVe6q/qS12NAL7dSZND5P+sPY0LZQUQ19lAM1Z1sKhcyBwD
         h6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Fu6Efpg1HM1VF7oK8oKNnaQ7ek93tEycWK/pneRESxI=;
        b=GKG9490tDDubnX2TsAqo5gwiYM10ctnOX2LfPRimHOcfGlT3BL0Da2VGr+jf1/etaC
         lB040GwYt/8Ikm5Cq4f+AWbwwGR+6AB8mLe2Nneh8KJnrn46gOMv1fZjwswEl4dCaxfa
         NjoxCcprgK61jYZoIOB6jngGkuFjeUZ/KY0JqUVdqy5TeWO2RE6ZY9ZtKt21GRV8xBs3
         aRcDIaup3k61eFb5oxFS6VDlxUGpyxbpxV39L6dGff4pPO/B8GLr7DffjaeEbIJQ+Hth
         31WPMq0GDd+/g95f0V7VypQSlDpUz/OgyjfTPfosgi0QAeB7CUKQq423h15qtyojE/kN
         D5/A==
X-Gm-Message-State: AOAM533z49oqOVz8B7fTIsaKSJp9xqKgpIrInIxd5SuSTWYWlMWxY5XK
        yvYlKq5vvkauqKZPlUR2ScI=
X-Google-Smtp-Source: ABdhPJwNzd4uicpYuvVaOtvBtmUUXsKIZqsfs0Xmd/kCcfwHIrJ4/OX1PRWPNT0eCwHbS5b9KdsYbQ==
X-Received: by 2002:aca:5e03:: with SMTP id s3mr8076353oib.27.1636489785471;
        Tue, 09 Nov 2021 12:29:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f25sm5868026oog.44.2021.11.09.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:29:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Nov 2021 12:29:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Babu Moger <babu.moger@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        clemens@ladisch.de, jdelvare@suse.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (k10temp) Remove unused definitions
Message-ID: <20211109202943.GA3693009@roeck-us.net>
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
 <163640828776.955062.15863375803675701204.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163640828776.955062.15863375803675701204.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 03:51:27PM -0600, Babu Moger wrote:
> Usage of these definitions were removed after the commit 0a4e668b5d52
> ("hwmon: (k10temp) Remove support for displaying voltage and current on Zen CPUs").
> So, cleanup them up.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c |   20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 3618a924e78e..662bad7ed0a2 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -76,26 +76,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define ZEN_CUR_TEMP_SHIFT			21
>  #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
>  
> -#define ZEN_SVI_BASE				0x0005A000
> -
> -/* F17h thermal registers through SMN */
> -#define F17H_M01H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0xc)
> -#define F17H_M01H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
> -#define F17H_M31H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0x14)
> -#define F17H_M31H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
> -
> -#define F17H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> -#define F17H_M01H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
> -#define F17H_M31H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> -#define F17H_M31H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
> -
> -/* F19h thermal registers through SMN */
> -#define F19H_M01_SVI_TEL_PLANE0			(ZEN_SVI_BASE + 0x14)
> -#define F19H_M01_SVI_TEL_PLANE1			(ZEN_SVI_BASE + 0x10)
> -
> -#define F19H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
> -#define F19H_M01H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
> -
>  struct k10temp_data {
>  	struct pci_dev *pdev;
>  	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
