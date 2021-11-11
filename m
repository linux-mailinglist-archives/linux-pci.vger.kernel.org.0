Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F644DD54
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 22:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhKKVyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 16:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhKKVyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 16:54:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B9EC061766;
        Thu, 11 Nov 2021 13:51:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z6so6715796pfe.7;
        Thu, 11 Nov 2021 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7K7MdZ98+kLM0UgbtnX5grxWcLXUyrdZOf5losamR8=;
        b=k/rcSxbTuja+nfRj8kbPAalS7Ja6FRWrkjh8/JWJ3U0OIFnU/R/SL+HgXUCmaSX/MD
         yZBy0+tI3sBmElnLmllX18AIwGLjU2oQ9N+dT/6RHhj5V4UOAhgJTtqGLkYRWxihwO5y
         j9iB3TRYwfEzkjz1HF7I2DL+HYkJavKtsNeAXaUmDXbF2OYPpRriBQ4Pd4+1cw76fYq0
         JDKBjxto2gnpyiWqm1xwipgGCo4SK4FsVRN2XXWgY+JPa6prmjkgY+rVEfWAHTh3Krbi
         M3s//dxGaafcUigKfpRnJaIo7BQUd91BxpevlSRLjLI1+2qtmtHi//MDKK9uK7lP8cWw
         6IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7K7MdZ98+kLM0UgbtnX5grxWcLXUyrdZOf5losamR8=;
        b=eIYxMtOnJqRrv+VT6LNl7kjYpNHWEIeaeBqbv73na72bfektBUTgQrX9rwxXn0hiRy
         ob0JRKq6aNTWesXXXDjJlnc2Infvex7edlxbXp5IomINkDk9mEj3QBBU5i22Z5Om8CFS
         6uCoorFQtSIuomD2RkPWN09WSgsJoWSaqnjV+P5mPS5CLJSBGtu0HvCQbjEmjFLLbHdx
         XE6Ejw4NZ40T2fD8doTDqR34XnKjoE2k66ND7m6NYyrblgYRV/xo+kw9Bzk4jHDsn1wg
         P50/SkR7/2z00Ru+8zfO/UAzSSOakJ9WEOqLPDk4dB9mRNldczu72NH3Em5SBOjY8ZKo
         Jksg==
X-Gm-Message-State: AOAM5335eNgzmLXXRptcRueq7uj5Wf4iDHxjLPM8uoAF78S4ZHsVyTn6
        mzLF2RHOWEgg4mR8/TucKtp6f8e/XK0=
X-Google-Smtp-Source: ABdhPJyrE0aTj9fPnkalcVvbbBApThucSuvu+/csgGx9tTu/LweymXE5fqc9qCSniieOHsIrBznb1A==
X-Received: by 2002:a63:91c8:: with SMTP id l191mr6728990pge.404.1636667482192;
        Thu, 11 Nov 2021 13:51:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s2sm10012008pjs.56.2021.11.11.13.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 13:51:21 -0800 (PST)
Subject: Re: [PATCH v8 4/8] PCI/portdrv: Create pcie_is_port_dev() func from
 existing code
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211110221456.11977-1-jim2101024@gmail.com>
 <20211110221456.11977-5-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <aa040d6e-66b0-5159-2eba-870db74b0e31@gmail.com>
Date:   Thu, 11 Nov 2021 13:51:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110221456.11977-5-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/10/21 2:14 PM, Jim Quinlan wrote:
> The function will be needed elsewhere in a few commits.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/pci.h              |  2 ++
>  drivers/pci/pcie/portdrv_pci.c | 23 ++++++++++++++++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1cce56c2aea0..c2bd1995d3a9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -744,4 +744,6 @@ extern const struct attribute_group aspm_ctrl_attr_group;
>  
>  extern const struct attribute_group pci_dev_reset_method_attr_group;
>  
> +bool pcie_is_port_dev(struct pci_dev *dev);

Looks like you need an inline stub here when CONFIG_PCIEPORTBUS is
disabled to avoid the linking failure reported by the kbuild robot:

static inline bool pcie_is_port_dev(struct pci_dev *dev)
{
	return false;
}

Thanks!
--
Florian
