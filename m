Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B443223EC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Feb 2021 02:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhBWB5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 20:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBWB5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 20:57:35 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E075C061574
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 17:56:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q14so61309674ljp.4
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3YTt+OBnZdgY7YTDG9R5B/vNmDOeKHekPCOYy0Yhx0=;
        b=MHcmARE6GXe9GATWNEkX/ppYFvKDMu/Qdj8EquOuKjI/tjKA2KYCQRVSePACbXXz8u
         OG7fWuE61jx12EwVcOlVN244TLyIgWhXresA4yUvIjmoDKkew3ivclzTo+39YiJn/Lbe
         X88LFzYhTu1s6FsdE7T336ZwtI4k6GmRce/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3YTt+OBnZdgY7YTDG9R5B/vNmDOeKHekPCOYy0Yhx0=;
        b=ptjwUPPTaB0r2jcuKGwCLVrCtvZCS4dtuOISt5gqsQ3o+ne6GXcAXzKuFDWUbzeDvA
         lf1i5hBecgP6uopTbUK9v7VIUXeG7LbWmo+C8VamrKdv7I7gTCH4NNhD6THuTTKGZ94w
         Rhb/pfjOJBxxqPz82zaLXwyV59akcXKsej73UtHyF84314RV+NEathxYvPB70IlK7rDE
         kxbQiuxSe6ToeFEoMDDGR4lMvJHP0B9sAKuXqXNUdkx2xA80+Rqaoyn2hYA8i1fvWrMw
         RhyQeYkUvBo9TJYEjBkbTQNFPfweVd6SZAz6LCwkgpdNxBD5VCRogtPLKnl6qX1+EBmS
         TpTQ==
X-Gm-Message-State: AOAM532zFwv92UyDGo/BVLNRQuAV4vGZpmtdzNQHsrSI6ZVEMIGvzl42
        3/Vl9PFqS2RsIUvg1NCvgYfLG3zIC5OkgQ==
X-Google-Smtp-Source: ABdhPJy4ii9u4lvy2/bka4pvd9O6c8iZsEBznUxe5pptYcPd2fSQji0GAfww0LH1fgwhijk+1Eic3w==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr6105594ljg.40.1614045412861;
        Mon, 22 Feb 2021 17:56:52 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u4sm2248937lfs.61.2021.02.22.17.56.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 17:56:52 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id d24so8857532lfs.8
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 17:56:52 -0800 (PST)
X-Received: by 2002:ac2:5184:: with SMTP id u4mr10058742lfi.487.1614045411930;
 Mon, 22 Feb 2021 17:56:51 -0800 (PST)
MIME-Version: 1.0
References: <YDOGERvNuU3+2WWe@phenom.ffwll.local> <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
In-Reply-To: <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 17:56:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi43mDJab1RQz9Sgz5+m=T=nSCyxULywoUHxstEHd2qnQ@mail.gmail.com>
Message-ID: <CAHk-=wi43mDJab1RQz9Sgz5+m=T=nSCyxULywoUHxstEHd2qnQ@mail.gmail.com>
Subject: Re: [PULL] fixes around VM_PFNMAP and follow_pfn for 5.12 merge window
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 22, 2021 at 2:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Cc all the mailing lists ... my usual script crashed and I had to
> hand-roll the email and screwed it up ofc :-/

Oh, and you also didn't get a pr-tracker-bot response for this for the
same reason.

Even your fixed email was ignored by the bot (I think because of the
"Re:" in the subject line).

So consider this your manual pr-tracker-bot replacement.

              Linus
