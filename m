Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488EC366DD9
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhDUOPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhDUOPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 10:15:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7DAC06174A;
        Wed, 21 Apr 2021 07:14:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q136so21935722qka.7;
        Wed, 21 Apr 2021 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=H0xUL+VFdyIa0ji4Th/5YMGTFHYr1jkOK9wBOItrp/Y=;
        b=Htq4AavTUvaIKjrSwYSgfk/9LOhsOQRau62GNNkBD79Sh4VxHePzD2L+B52RENCsHI
         4PL+nqqx70rsT6DneonIWLk2JgIAAKH4RYpwmo9Wn4GDqdmpAlfpjtk7jRllYJmXZiyo
         tnWbbNT+p3igXVTAx/jBF1NGPsOxeu1AmVb87QTHjEKTdSc2O7Jo3LKCuXXR0KpW4+Bg
         RW9awX3klxF+hBslxw/CUl5QEoKtY33EQ/HmP0wx4EJ0xHnjRpqiBjFbzcGxBnN5SQYr
         KgFfi77SLsFAOdNhi6+68ezGqnlxjq1tZBqUtfj/RhDFkEwEa14TQvGCRvorbKiVdznv
         Pi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=H0xUL+VFdyIa0ji4Th/5YMGTFHYr1jkOK9wBOItrp/Y=;
        b=BcCnbKgSX+9JiOELj0lrxdNt7av1PMyExWtdW2rZo89dYSMsVNTvCQjq+fjnknYpaz
         0+oio0U8DoiIoXaQhNylUwR9J7x4zLZwRH+N5RQZ0xjchC+qkhtutQLivuAcJrGxteju
         W+RJfAIQLHGrIPidehikS6wFOQCU2wrsuPYchBVfWSb5QcN0NGqk01OkJ8+EN1uLI7ZE
         llyXQTiHWU3AG+r8Ru+Bm5+k3+3UP8fdCTL1VKDDfrpt2bttZY4SAB2sgx2A0ql+9JeL
         XLSr61FeUYrajZP3BJ9HnyCSiYznZaKMRJqovwkrRkI2h/vp2sIHrsKLG+aS5B56cXWq
         gRMg==
X-Gm-Message-State: AOAM532YjNp+LV96fyjnYWaS1iAaC2FjC9wHGBNeZEQ6zImoLPIxL70P
        PZS2/OBwXmZon3htt+qjtp4=
X-Google-Smtp-Source: ABdhPJw8CLguVFAPzF8l1/1q5ENNtjHkvPtfqw/PekYFKdTDnJWRL0D+IoF3dUIZdep6LDU4L/VqjQ==
X-Received: by 2002:a37:a5d6:: with SMTP id o205mr11119679qke.166.1619014469882;
        Wed, 21 Apr 2021 07:14:29 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id o12sm2150348qkg.36.2021.04.21.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:14:29 -0700 (PDT)
Message-ID: <5da23b1199c897b464c7bf7027ac50057d1cb5b6.camel@gmail.com>
Subject: Re: [PATCH 1/1] of/pci: Add IORESOURCE_MEM_64 to resource flags for
 64-bit memory addresses
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Wed, 21 Apr 2021 11:14:25 -0300
In-Reply-To: <CAL_JsqJXKVUFh9KrJjobn-jE-PFKN0w-V_i3qkfBrpTah4g8Xw@mail.gmail.com>
References: <20210415180050.373791-1-leobras.c@gmail.com>
         <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
         <7b089cd48b90f2445c7cb80da1ce8638607c46fc.camel@gmail.com>
         <CAL_Jsq+m6CkGj_NYGvwxoKwoQ4PkEu6hfGdMTT3i4APoHSkNeg@mail.gmail.com>
         <b875ef1778e17a87ee1f4b71d26f2782831b1d07.camel@gmail.com>
         <CAL_JsqK83MFqZ4yCz+i7sunpXFmi+vvjCSxVmcCh1YG=mOxY9A@mail.gmail.com>
         <b56b8a5c8f02a2afea9554ebf16a423c182a9fc3.camel@gmail.com>
         <CAL_JsqJXKVUFh9KrJjobn-jE-PFKN0w-V_i3qkfBrpTah4g8Xw@mail.gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-04-20 at 17:34 -0500, Rob Herring wrote:
> > [...]
> > I think the point here is bus resources not getting the MEM_64 flag,
> > but device resources getting it correctly. Is that supposed to happen?
> 
> I experimented with this on Arm with qemu and it seems fine there too.
> Looks like the BARs are first read and will have bit 2 set by default
> (or hardwired?). Now I'm just wondering why powerpc needs the code it
> has...
> 
> Anyways, I'll apply the patch.
> 
> Rob

Thanks Rob!


