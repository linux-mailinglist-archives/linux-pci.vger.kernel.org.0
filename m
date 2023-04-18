Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC6A6E5C2E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDRIgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDRIgF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 04:36:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4027A83
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 01:35:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f167d0cbb7so5614155e9.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681806953; x=1684398953;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZfMIf6u2tlZmg4ytV/RdzlZiQTZycAHSYhPqTETFDk=;
        b=AtH7SlgZznmpIhtRcbYWvzjRwhwYiDcaGCXHsyrlVtfMKNEUgXd//CR8T7s9VHs9co
         wIIiCpC5EXMXAPVzbvJpBaqlsVvCZExTRXbkJqyC5ff1XFzg1BFz/9bIY8mhYG04fZjD
         1swtlQei9mCVpTXwIEAkAr1HSpnuQ4UhW8i1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806953; x=1684398953;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZfMIf6u2tlZmg4ytV/RdzlZiQTZycAHSYhPqTETFDk=;
        b=BEHvGxA0QCNtg28NoUiG5NaFFLKS+bE39fU7lAUIFMSzcQ5b+xyGJNQ1CGrlryHeMI
         YAx/0dCF3saL8EAk/XoSF+ucN8elWFZbyfqnAg7GrODzhM2Vj4YsCqXHk4Ak1ndtNJ4+
         XiKTX2BYwpybTzOkUULGh48v36F66S5TmLRbnkabukiO1u77/+sAJNevId3Fa5LEyEO2
         yYLdkDxjTJeWrlCvtnqtLtEdM/nczqLsUKtOYDStfc3OLzUq160siahcRPTjcyfFLLbB
         ADTGAtAIIoTVbOSa8iHtDrpaE7Ft59WA2RVTvj/e4WolilUYl0LliWICNAZHsystEZr9
         2r1Q==
X-Gm-Message-State: AAQBX9f8PDGEYj5eWDio9UrtzNmWrIwbSyjc6r9MspuIY3/zK8HJT0mV
        c+UmJt11SV/gBKalB2vbpb/PlA==
X-Google-Smtp-Source: AKy350baNsjdpiDs8wIYqCjrn145jmIxJrw1PWocYcVGuMonwKXArSOSkN30FZe2g02CXjtvgmQoIQ==
X-Received: by 2002:a05:600c:3d18:b0:3f1:7490:e595 with SMTP id bh24-20020a05600c3d1800b003f17490e595mr3714170wmb.2.1681806953655;
        Tue, 18 Apr 2023 01:35:53 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l12-20020a1c790c000000b003f179fc6d8esm1146495wme.44.2023.04.18.01.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:35:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:35:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Patrick McLean <chutzpah@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 1/2] gpu: Move ASPEED vendor ID definition to pci_ids.h
Message-ID: <ZD5WZ+HYGBV3g7SL@phenom.ffwll.local>
Mail-Followup-To: Patrick McLean <chutzpah@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>
References: <20230418011720.3900090-1-chutzpah@gentoo.org>
 <20230418011720.3900090-2-chutzpah@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418011720.3900090-2-chutzpah@gentoo.org>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 17, 2023 at 06:17:19PM -0700, Patrick McLean wrote:
> Currently the ASPEED PCI vendor ID is defined in drivers/gpu/drm/ast/ast_drv.c,
> move that to include/linux/pci_ids.h with all the rest of the PCI vendor ID
> definitions. Rename the definition to follow the format that the other
> definitions follow.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

for merging through whatever tree this series lands through.
-Daniel

> ---
>  drivers/gpu/drm/ast/ast_drv.c | 4 +---
>  include/linux/pci_ids.h       | 2 ++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index d78852c7cf5b..232e797793b6 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -70,12 +70,10 @@ static const struct drm_driver ast_driver = {
>   * PCI driver
>   */
>  
> -#define PCI_VENDOR_ASPEED 0x1a03
> -
>  #define AST_VGA_DEVICE(id, info) {		\
>  	.class = PCI_BASE_CLASS_DISPLAY << 16,	\
>  	.class_mask = 0xff0000,			\
> -	.vendor = PCI_VENDOR_ASPEED,			\
> +	.vendor = PCI_VENDOR_ID_ASPEED,			\
>  	.device = id,				\
>  	.subvendor = PCI_ANY_ID,		\
>  	.subdevice = PCI_ANY_ID,		\
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 45c3d62e616d..6634741aea80 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -815,6 +815,8 @@
>  #define PCI_VENDOR_ID_ASUSTEK		0x1043
>  #define PCI_DEVICE_ID_ASUSTEK_0675	0x0675
>  
> +#define PCI_VENDOR_ID_ASPEED		0x1a03
> +
>  #define PCI_VENDOR_ID_DPT		0x1044
>  #define PCI_DEVICE_ID_DPT		0xa400
>  
> -- 
> 2.40.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
