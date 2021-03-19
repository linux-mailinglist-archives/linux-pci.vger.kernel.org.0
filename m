Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC87D3422DC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSRJJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 13:09:09 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41704 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCSRJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 13:09:09 -0400
Received: by mail-wr1-f51.google.com with SMTP id b9so9838136wrt.8
        for <linux-pci@vger.kernel.org>; Fri, 19 Mar 2021 10:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=270tYbgS2GIR1UaYpc6rWQjHmLy0O3OL5iV1XVLyUL4=;
        b=bewQQE3d1s3yvWUy4jxz+A++512cnVifcVOaRQU24OBG8OlF1XEOhRSvvmpZ8Jd+6g
         V/jQOEu1+wyc4ijzVbBICZ/6QPSswo/ViCe1JvZJJUHMpIQyvr/rKbdWBJwM6ZNUaf4z
         6sH1gg7nicsWWrqyMtN+xJhh3l9fbaAPZiLm/Wuo8KTHONi3hiypmSTFaISEui0NR7M+
         UlTtMA0DZg1/VdYvQpOlMQPvodDUiOUyy5neXk0gSADM631b/koAOcglhnxE3diUVhsy
         3a1+oq+vy0aCawRg2fBTmp8uCMFdPx6v5FbPxC/5sDrJjfzPN3soLYnbCGPgbaCo6yEE
         dZ5Q==
X-Gm-Message-State: AOAM530FPsbDTt/SYl0BZcHNcIURcfYRJSUYxyTiIaqBBxWA4Eui1/7z
        ElH4B5iaBv03GEBrtGKjmuY=
X-Google-Smtp-Source: ABdhPJyUInlUjNorPomAmAc3ubI5fDJmpwnDlS8V4IEbjN+ATrBsw8RG4hP9bP6PcmEkKCCb4ZxSyw==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr5395102wrg.180.1616173747853;
        Fri, 19 Mar 2021 10:09:07 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i8sm7058893wmi.6.2021.03.19.10.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:07 -0700 (PDT)
Date:   Fri, 19 Mar 2021 18:09:06 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, prime.zeng@huawei.com,
        linuxarm@huawei.dom, Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v2] PCI: Factor functions of PCI function reset
Message-ID: <YFTaskobyoEzLkeE@rocinante>
References: <1616145918-31356-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616145918-31356-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Amey as he is workingo on a larger refactor of the reset functions]

Hi,

> Previously we used pci_probe_reset_function() to probe whether a function
> can be reset and use __pci_reset_function_locked() to perform a function
> reset. These two functions have lots of common lines.
> 
> Factor the two functions and reduce the redundancy.
[...]

I wanted to bring the following thread to your attention as you are
working on the same code that it's being talked about there in the
on-going conversation, see:

  https://lore.kernel.org/linux-pci/20210312173452.3855-1-ameynarkhede03@gmail.com/

I wonder if there would be some overlap, etc.

Krzysztof
