Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC0D6E5C73
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDRItG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjDRIsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 04:48:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B76E82;
        Tue, 18 Apr 2023 01:48:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a7ac89b82dso19390701fa.1;
        Tue, 18 Apr 2023 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681807695; x=1684399695;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQTL6gqoekyUKEKfWJahiNXjj1p7JeMbW1pMbRbnCsI=;
        b=Wgny9GWkovXUcuzra15R9Ya8NrBk2HhG1yreAWsLLelZmC6KQTmWQGLFa19EQgHlAI
         y+5p7gteUZus9rYbZAkL3VwapJxpryZupHpMBpWkcGnnc0HjPukMpaX0Z8VGCRGTFY4m
         qNOKE2y4qeJVdHcoezQU2oo/1582oCCLm45uTxa0v4xSs/36V1OLt/oCoIKA/no/8oha
         FriZ837lR607GSF8NAxCXHKd5Z9RIhjuN9aYxi+VEyUVbZ7jlVFh6bZWnj8xQo5oiRq4
         IDC+ZzKC3Tf9KK/M0UcnGJV8LDPZu6jybiTKa50tsKDQzWLPIGN9qxptUduao2CxTGIl
         FdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681807695; x=1684399695;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQTL6gqoekyUKEKfWJahiNXjj1p7JeMbW1pMbRbnCsI=;
        b=IdYGah+gz5s3fimw5QpAId24KzKRxpKSrChre7VqV1jDAXpNPWJjcKsdMhEQOMblwc
         DvK4QfOLrl82LU6cLyAWrynj3FYfJl2PMascHvG1/As85BjHYbwXynDrZygAAGUc5qBw
         Ph70hmc/d1+hdJ+YkaigUwZ0C1f3Qu3ZssIp/WG30acS+PmF6+oDXjVf908g3dR5ZTCy
         aVGjiddWZDSPMYNGZhEKXuczPUpO46inO2pYOtDTse7oEL7FtYgjCpa5Q2xda32UdjBr
         8oCIFCjEbPDF7k7L3esG2lUEGnN63/cqUwUxJvj6A2qRzf2yD+qDl/Ep5v3s1UWG9mOd
         1SvQ==
X-Gm-Message-State: AAQBX9dv7ihOEtHaA9zb7SRo7bLHqJzkc2YhcqMe/X/dKwfRmJx03NTv
        7bDkwC1WQHVk6EON26T5rNc=
X-Google-Smtp-Source: AKy350a+YRhVtMEX2gDL2vy9uqCNxvNfQwxlBOxVZzqQkPi4tiThAj8JZwG9aqOHHyWcZCu3XTUdXw==
X-Received: by 2002:a19:f80a:0:b0:4ea:fa26:2378 with SMTP id a10-20020a19f80a000000b004eafa262378mr2670569lff.23.1681807695312;
        Tue, 18 Apr 2023 01:48:15 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.61])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25594000000b004eacd90e0c7sm2313021lfg.81.2023.04.18.01.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 01:48:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] gpu: Move ASPEED vendor ID definition to pci_ids.h
To:     Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20230418011720.3900090-1-chutzpah@gentoo.org>
 <20230418011720.3900090-2-chutzpah@gentoo.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <c33ce80f-611e-2841-d4bb-dbddd1b34053@gmail.com>
Date:   Tue, 18 Apr 2023 11:48:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230418011720.3900090-2-chutzpah@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/18/23 4:17 AM, Patrick McLean wrote:

> Currently the ASPEED PCI vendor ID is defined in drivers/gpu/drm/ast/ast_drv.c,
> move that to include/linux/pci_ids.h with all the rest of the PCI vendor ID
> definitions. Rename the definition to follow the format that the other
> definitions follow.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
[...]
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

   The vendor IDs in this file are sorted numerically, not
alphabetically...

MBR, Sergey
