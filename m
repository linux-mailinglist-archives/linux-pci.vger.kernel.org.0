Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD540ED9D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbhIPW7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 18:59:19 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34545 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhIPW7T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 18:59:19 -0400
Received: by mail-wr1-f44.google.com with SMTP id t8so4976809wri.1;
        Thu, 16 Sep 2021 15:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hyj6KAsKyBSZt8Igibw1Ppx1/7Phj4Vw+yzte/ZURkc=;
        b=gXuyfZtcY42T3tq6daVdnbcj+l+F/I811wXtXZwqc5xlDH7aAtqAWQ79vRA4pFzkRz
         v65wce9Hyzv9z/1p4YWsY6dDvGfDEmET913Ayw3LUIVgvqyN1GxBqcqQHNDCc6zRAsr9
         U83sCk+pKiooZtGwutQaOnl7QzGR5fdg59rQf2HX45gW+eyciTRW8vvu50IYtD/8PpS/
         gcTUSZsffZvXIBO0d4pfsrvOQOsGe9avCGr2rfu/wI/l3iTVgZwsATqJsNYH8cSvHVVt
         vbFXLj3oeHgqfSeZjkQWDo+qmp4sOMXHxaRiyMJzPqrd3kicPIqwQnOnp9yZVDLFP3g2
         dLMA==
X-Gm-Message-State: AOAM532m0zOFVAOR3S+0bFz5tuDlJG94Di88shFiPomahDazv0GptNap
        bBGuuARb4nBiEpWMiJZRI3k=
X-Google-Smtp-Source: ABdhPJxes/09nq+23bHh9arH1SgvbntGzaNp2OuGvbPo9q+yEmXs/5Syv2nMkZtis3LNGKz2HbI5HA==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr8641203wrm.91.1631833076915;
        Thu, 16 Sep 2021 15:57:56 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b188sm4704115wmd.39.2021.09.16.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:57:56 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:57:55 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Assign a number to each VMD controller
Message-ID: <20210916225755.GA1511623@rocinante>
References: <1631675273-1934-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1631675273-1934-1-git-send-email-brookxu.cn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Xu,

Thank you for sending the patch over!

A small nitpick below, so feel free to ignore it.

[...] 
> @@ -769,28 +773,48 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	unsigned long features = (unsigned long) id->driver_data;
>  	struct vmd_dev *vmd;
> -	int err;
> +	int err = 0;
>  
> -	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
> -		return -ENOMEM;
> +	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20)) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
> -	if (!vmd)
> -		return -ENOMEM;
> +	if (!vmd) {
> +		err = -ENOMEM;
> +		goto out;
> +	}

I assume that you changed the above to use the newly added "out" label to
be consistent given that you also have the other label, but since there is
no clean-up to be done here, do we need this additional label?

>  	vmd->dev = dev;
> +	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
> +	if (vmd->instance < 0) {
> +		err = vmd->instance;
> +		goto out;
> +	}

Similarly to here to the above, no clean-up to be done, and you could just
return immediately here.

What do you think?

Also, I think we might have lost a "Reviewed-by" from Jon Derrick somewhere
along the way.  Given that you only updated the commit log and the subject
like, it probably still applies (unless Jon would like to give his seal of
approval again).

	Krzysztof
