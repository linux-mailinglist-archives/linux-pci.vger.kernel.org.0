Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F378E333A1D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 11:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhCJKfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 05:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhCJKfn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 05:35:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7058C061760
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 02:35:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i9so6782985wml.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k11X2IaCm7778Ql6a7D/ZiOxFU1ZEqfWNW+eBOH3OF8=;
        b=KqK258d2QHv7GjqtjRSg40t0WuJXZB5TC4pmhS1sfVUud9iiq28hZscR/pYRDHADt0
         3ngif1VVcCFN8W1KFj+FJyByX89v1XlrNRu8Eqb2rPMS+/v8ikJKCriSIsrUyqrR9AAI
         c/GKw6xIW0xrZJG8H2KBpJceqc2IY27Xa6mvV05UpaMYS+AuN396IIJMfNFvOAT9A7Xi
         JeRgMOTNcd5VHfj2Ud3g4Spjf4QtlbhPNy1saLLdxmgNJnvOVfcHj5TKfQ+tbPFQuNh6
         eZLrxAG5qs2Gfx+JWUCGv0at9m45ur7leVzSQBAkzg+Oke4Cftu8w80ZEcURiQOnV1jw
         hJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k11X2IaCm7778Ql6a7D/ZiOxFU1ZEqfWNW+eBOH3OF8=;
        b=iexfHiIpTOlPrPFMe3SBWthhiRMZgWuYOIQyIDoaqxZdJVgxgiRS6C7ZTk89W+iUNv
         jnkSwBTXWBbD1hONMGySxEzg1+FH9/QJW4HYnRY2FlCHZ9dIkbd5vJxv2shRbapGHeiV
         XjgnBZh10rBubYSzzi/Yi36sI/NuFtm9BxKdif4c/pTe+fmGVP9pFdzs/LByHUg8DDZK
         IY1S70rmSEyX1sV2q4oene1YAuIkOy6bDzYMat2DHVjm66fUlAfKHckeefKculMnCicl
         2syKmZ1uHgYb8DdVP4g6eHEK/9Mn2Q9fy/IgdJog2ehCQvclLRM0pUAnWoKXm4+UbbBP
         H9aw==
X-Gm-Message-State: AOAM532i48kDX8kg4dH2MDUGLh94LIWDJgYr2MyGZuUAXydeH48iHHyk
        SXqapo/dVCClbrpnCaB/TDAsLw==
X-Google-Smtp-Source: ABdhPJyLdOIr4E9Qa53UvZvv/KO6KjoXTUQ6/+YP6LjE0pSDSgp7inNcVk00mLbhh5ugPQI+9vacOg==
X-Received: by 2002:a05:600c:47d7:: with SMTP id l23mr2682273wmo.155.1615372541428;
        Wed, 10 Mar 2021 02:35:41 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id s3sm2307358wmd.21.2021.03.10.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 02:35:41 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:35:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.de>,
        Tan Jui Nee <jui.nee.tan@intel.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>, hdegoede@redhat.com,
        henning.schild@siemens.com
Subject: Re: [PATCH v1 5/7] mfd: lpc_ich: Switch to generic pci_p2sb_bar()
Message-ID: <20210310103539.GF701493@dell>
References: <20210308122020.57071-1-andriy.shevchenko@linux.intel.com>
 <20210308122020.57071-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308122020.57071-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 08 Mar 2021, Andy Shevchenko wrote:

> Instead of open coding pci_p2sb_bar() functionality we are going to
> use generic library for that. There one more user of it is coming.
> 
> Besides cleaning up it fixes a potential issue if, by some reason,
> SPI bar is 64-bit.

Probably worth cleaning up the English in both these sections.

 Instead of open coding pci_p2sb_bar() functionality we are going to
 use generic library. There is one more user en route.

 This is more than just a clean-up.  It also fixes a potential issue
 seen when SPI bar is 64-bit.

Also worth briefly describing what that issue is I think.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Kconfig   |  1 +
>  drivers/mfd/lpc_ich.c | 20 ++++++--------------
>  2 files changed, 7 insertions(+), 14 deletions(-)

Code looks fine:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
