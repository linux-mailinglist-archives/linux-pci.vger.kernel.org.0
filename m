Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02158A4CC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 04:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiHECmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 22:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECmH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 22:42:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC624F21;
        Thu,  4 Aug 2022 19:42:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so235329pjm.3;
        Thu, 04 Aug 2022 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cAnfyTe4YbIMA28amHKuN6if+IaEiolejn/27PV5VqY=;
        b=lUc+4VDVAdsjt6H14ZWSKd1i+qBr7Hb88ZxVLb4IsOin5KUeVWCLgMlwygYepdj1A+
         NuNjgOr38+tVUhkQWwNB9MriD5s90Y+jjIIoIbeikj67CWgzy40BpPuJCrrxAEWl2Of+
         vpN2DMi6xHrX5Lkjfpd8emSfz2nea+vvJhiZ7a7PIcWJM+GU9kU9pdIaMgd1wJC9Os6g
         tPwkiCodcuE0khDkKrPocsRoj1bj6fEeHVHcR1NA3/OVKiOrNhohCjNSvFDvqb5WOGUL
         hdg9AB9RE8L6zXe1vDvdiVrcojsoUBhN2w43IqSk5c/s3FJUcSavDDzGcEhXpWb2SYWz
         PpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cAnfyTe4YbIMA28amHKuN6if+IaEiolejn/27PV5VqY=;
        b=i/xsaQkqzH0XovTZnhKet5mp0A5MGQsXtMxQn30d2cwMxwpuCcGv6RpJFi++GBA1wx
         sO6WoW5ZE5Z0AKonozS2LNoDzbDSl9+Dzl8SaetOUVHHt+LJrg7ZDw+15VxSIrLJBVf5
         RlLSpNCJxv6AABIUEufo+UeayTqC6sFMaslKisbHc6X2F0GVvo61YLcp6V+Cub2jY9LD
         9jf6GtUb2TWf5EQD3gNjyisGtZFzy1DibCR/E9pNzyHMVmPxfXjVGw+TJyViW57p3mQI
         dhRD78mnYI1GQIHmfUcOMqA1h+SQr00FNyEy8IhxT1+XOqVfQkeCFC0N7JAv4TL8UwNZ
         6wJw==
X-Gm-Message-State: ACgBeo3GdIkis0OUhWCUSPqBBx5hLS5TMUaYfCPD12STF8Rqkl+7aUUD
        9zrOPwQC24dqs0Q2aRHZsow=
X-Google-Smtp-Source: AA6agR6y1NDXxAWoYZHxDWmR88V6IAx6+xw5lqqQWQxl15yElLKFhOQfxPZSXCe7ygeQN4x5rENU9Q==
X-Received: by 2002:a17:90b:1bd0:b0:1f5:32a7:2bc8 with SMTP id oa16-20020a17090b1bd000b001f532a72bc8mr5055608pjb.61.1659667324520;
        Thu, 04 Aug 2022 19:42:04 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b0016d150c6c6dsm1695574plb.45.2022.08.04.19.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 19:42:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9E808103824; Fri,  5 Aug 2022 09:41:59 +0700 (WIB)
Date:   Fri, 5 Aug 2022 09:41:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     bhelgaas@google.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, darren@os.amperecomputing.com,
        corbet@lwn.net, yangyicong@hisilicon.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: update the link for aer-inject git tree
Message-ID: <YuyDdtIC8r8k/QDd@debian.me>
References: <20220804103008.1960215-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804103008.1960215-1-shijie@os.amperecomputing.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 04, 2022 at 10:30:08AM +0000, Huang Shijie wrote:
> The aer-inject tree has been moved to:
>     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> This patch updates the links.
> 

What you wrote above is descriptive mood (this does something) instead
of imperative mood (do something). Better say "The aer-inject tree has
been moved to <tree link>. Update the links."

-- 
An old man doll... just what I always wanted! - Clara
