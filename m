Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B830F328
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 13:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhBDM3L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 07:29:11 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42596 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbhBDM3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 07:29:10 -0500
Received: by mail-wr1-f46.google.com with SMTP id c4so3249478wru.9
        for <linux-pci@vger.kernel.org>; Thu, 04 Feb 2021 04:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D6jRR3nrse7XqWqPEB4utJ2zxlzNhQl0Q6yGeKKsETo=;
        b=jj4kLhpKkc0nyk8TP48F4vzB3GSwOaDVN2NIXgeOKZljUM/ht/ftVSWg//3Pzvc41g
         N9QWas5MOhMKzS7d19ynjyps7Ztq0lYjp4FMQOrJ0JmV23WarTaejKoV8j8eGbhutaQR
         YHrBebUHq9kLT31n7wDHjmUVKH/oLuaaK9+07a51h8VrS3GpadzRtc1uPzbnRIvez1ql
         qxQ0eVau1ZsuxTzFpemrdtenHXdJBJB+yr5jgKO2f3Njpw0oPR/Kz7NvK4ZLRAzu8S5V
         52sNTHzQZXp6wT7Y8gYJYYPxBhGhKiqohwHaVYRskFaaZ6qryZ5bi9k+AzG85MPUvI1B
         8U1A==
X-Gm-Message-State: AOAM533LTdBRcPeGHaUvxu/lc0fIAXBeK/iSf0B1PK5aCyfI2uH3Fte1
        gVEJk2qLgwInIJWZxJx9By7QWFt3Q/zvF7Xg
X-Google-Smtp-Source: ABdhPJw25vZCC9AiMuItYw02vu182m054o2MPaQGtvQyLcilh585VvgceI8Lah0bydgXKKpStFhRug==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr9430386wrt.164.1612441708677;
        Thu, 04 Feb 2021 04:28:28 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s4sm6366805wme.38.2021.02.04.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 04:28:27 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:28:26 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@openeuler.org
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
Message-ID: <YBvoauS9WagVizdh@rocinante>
References: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yicong,

Thank you for taking care of this!

By the way, did you have some issues with things like pr_debug() and other
things printing debug information not working correctly before?

On 21-02-04 19:30:15, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.
> 
> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 11cc794..d62c4ac 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  obj-y				+= controller/
>  obj-y				+= switch/
>  
> -ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> +subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> -- 
> 2.8.1

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
