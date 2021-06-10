Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64C73A2DE6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJOUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 10:20:40 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:52934 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFJOUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 10:20:40 -0400
Received: by mail-pj1-f50.google.com with SMTP id h16so3745236pjv.2;
        Thu, 10 Jun 2021 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Qr+1IlJcgDNDchkAHw4h++pZkdHdyTM7HD3qP1Vs7HQ=;
        b=qrwcXgGM1x7QALpPDd+KCgaUYfaG3b9bFaQT3jFcf95Xbsk2cqDKXblyVYwGoFg2ty
         256uo970KVHY5Ut8qtlWoyYcREDQI0N2nFSNuFd5uOTTSd+T5Y/Rarm0/20sRHahxTfr
         XGIWs+NAOJllN460pdFynNP5sl0uSaTOi8F6YfQB/liuupsUB5E8wiaK3ISWQrE1ZORc
         AXAIbkG9gO09Fwyp559l73T5kqN1GFeCZ4/reb7MIK70IWVv2nfS5Jc2/5hEIuMHY69v
         MyvoqruWTi/DJAbyXQgDK8vFLfykvUDkA+g3HGTdOjubms8CNNIvjJ8QKTkK296NxomG
         01/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Qr+1IlJcgDNDchkAHw4h++pZkdHdyTM7HD3qP1Vs7HQ=;
        b=sdFUv+hNrJt+OywWP41X5jizc+V+TJUghDzy3tXqLM2OtC1U8FD2VbL7pBbjXMBb1Z
         3w3jM/dknh8pbL32r/FVLyP+eHzalpJDJfvmaKPHVKeinBm1WVonEPeBMjboKQSwqv/w
         pY2lKGLdKPNSynSxIsvkj54J/Jek35md+QOIrca/GjEMlOzFAp5q7NC3ixVziY8PRzJ6
         XpMM+9mh4dLVCyEzKP+8rLJ1AzfUSzctRq2UJ4G0JKo4dp2R0oeV0FIbSIpKNZTrVQV+
         fOAoAcHhpsTs8LUfWrsN2CcCXNmP7sxu0WbmWDkJzfLCgoibM46mBJX7UxzQEWhf2JIU
         FzRw==
X-Gm-Message-State: AOAM533cuEzfQqfwkz0K9D3Z13jUqHHAm4+qRB5A1+PFAoi4dOmOAoWy
        OZKMxANcBSW9gmRgwS/y+XE=
X-Google-Smtp-Source: ABdhPJxervl3oVnLBCHRuQ8kkSIWXHCgBRo0ufvlwRVsg78SmcUvr6ue2xbrVsYa3LDG+S1Mp03vKQ==
X-Received: by 2002:a17:90a:f197:: with SMTP id bv23mr3539616pjb.113.1623334649554;
        Thu, 10 Jun 2021 07:17:29 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 23sm2759820pjw.28.2021.06.10.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:17:28 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     helgaas@kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH v3 0/4] PCI: of: Improvements to handle 64-bit attribute
 for non-prefetchable ranges
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
        <87lf7jqavd.wl-maz@kernel.org>
Date:   Thu, 10 Jun 2021 23:17:26 +0900
In-Reply-To: <87lf7jqavd.wl-maz@kernel.org> (Marc Zyngier's message of "Wed,
        09 Jun 2021 17:08:22 +0100")
Message-ID: <87r1h9kdmx.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Marc Zyngier <maz@kernel.org> writes:

> Hi Punit,
>
> On Mon, 07 Jun 2021 12:28:52 +0100,
> Punit Agrawal <punitagrawal@gmail.com> wrote:
>> 
>> Hi,
>> 
>> This is the third iteration to improve handling of the 64-bit
>> attribute on non-prefetchable host bridge ranges. Previous version can
>> be found at [0][1].
>> 
>> This version is a small update over the previous version - changelog
>> below. If there is no futher feedback on the patches, please consider
>> merging them.
>
> Thanks for this. This brings my test machine back to life:
>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Marc Zyngier <maz@kernel.org>

Thanks for taking the patches for a spin. Based on the comments on Patch
1, there'll at least be another update. I'll copy you when I send that
out.

Thanks,
Punit

[...]

