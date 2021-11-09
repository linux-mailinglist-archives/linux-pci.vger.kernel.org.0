Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7E44B3FD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbhKIUdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 15:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbhKIUdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 15:33:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C42C061766;
        Tue,  9 Nov 2021 12:30:31 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so466509otm.10;
        Tue, 09 Nov 2021 12:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rchRn9OrYnb2yD8pBypvKawfQ0k9yhtGNme1+VpaBz4=;
        b=kG3By8vx2GXplW2XjhYaQgTlTGYDklwcr6xXFwnyF5FSlnnb0FimVM/tZBQtMSuGnq
         SyjrBnegpQtPiZgm/CGCSvmjzCAu1FdAmxtdviNwdybkZTEqP3Cutl5DyfPXVpJJ4vUM
         PH8D8+XTGR+xHEcPIZ3zfF0DRVq28n1vPFuBBnlbFJ7eQS7esh93bH5YFKwxTTbyn6uI
         2VxuntgslICNRABQ97rpoqRQpkZobB3PW+/jdQjqLOaDNx/jxdpm72khrg7BosPfQOCJ
         /fHDM7zyltqWWMKN/12nPf9Rq2ju9FKVl3+AvD9WV82fjndOGzf6BQ2VfVNfyHWW5+ik
         j7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rchRn9OrYnb2yD8pBypvKawfQ0k9yhtGNme1+VpaBz4=;
        b=czaqIM9aDJSu61xTQoYrxt9p+2WtmkVXh7PwpUY4+F8JLdPApERb4qt1k6kr1Qu7pa
         FbY/B0Xp/jhsQYisTv57XyTxjMQ4JmAv35ytWMpBOiWOl33GhwXqAjmKo4kT6OxsJe7P
         pE67UjxVzMK/1wMsKpppYuOSwgF81z1oeJOZ6W8CKN2fzTpatlBEz3BEfENI/ql9nkx9
         2ViDUQpnPWJaDVKHXettQrUfSIuCHpX/Ad1dpfuyCumX/JKpvPfebHfL2+G3+ovP6KpI
         yUUXWZEhpTUlibuIENBVVHzE1x3hhXPrao1O2nZK/fq1V0vvwT6KnPpxnZohg76BZstf
         +/Jw==
X-Gm-Message-State: AOAM530f58xSiXlluBDWvUEqqzxfFZ70LXX8fby6uoUIOwcdBHZGgXlb
        dEdglxhsQgi/wWfsBTdIiaM=
X-Google-Smtp-Source: ABdhPJxlccKPsVkkAJVU9fwcIn+S6vqA7FVHTENj5lqD9a78l6v9gIH9h4w8PJRAWZkrN1AbV/97Eg==
X-Received: by 2002:a9d:3af:: with SMTP id f44mr8525618otf.271.1636489831041;
        Tue, 09 Nov 2021 12:30:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm7782581otl.60.2021.11.09.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:30:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Nov 2021 12:30:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Babu Moger <babu.moger@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        clemens@ladisch.de, jdelvare@suse.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (k10temp) Add support for AMD Family 19h
 Models 10h-1Fh and A0h-AFh
Message-ID: <20211109203021.GA3693127@roeck-us.net>
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
 <163640829419.955062.12539219969781039915.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163640829419.955062.12539219969781039915.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 03:51:34PM -0600, Babu Moger wrote:
> Add thermal info support for AMD Family 19h Models 10h-1Fh and A0h-AFh.
> Thermal info is supported via a new PCI device ID at offset 0x300h.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/k10temp.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 662bad7ed0a2..880990fa4795 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -433,7 +433,9 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			data->ccd_offset = 0x154;
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
> +		case 0x10 ... 0x1f:
>  		case 0x40 ... 0x4f:	/* Yellow Carp */
> +		case 0xa0 ... 0xaf:
>  			data->ccd_offset = 0x300;
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
> @@ -477,6 +479,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
