Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B61E369B
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 05:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgE0DfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 23:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 23:35:19 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338EC061A0F;
        Tue, 26 May 2020 20:35:18 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h10so24413268iob.10;
        Tue, 26 May 2020 20:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTw88palFD7+SjbmvqrQhtUBYE0y0z+9wugbJffOnsM=;
        b=jgmuK+af4ey5mHa7nJqETfNgp4IoLT/AyXeGzZm+6Oo4QQ10env2fI2sARC4LowYfz
         EMMj3MD1UCuqQVCsCqsR/LkA19r5SyjGgMDUkH8cjy93pFywkzMzKBYcxLNpMp6yoY/X
         4cCif0OIVXqe16dHzhowIdkJ8BTHncYtmeLV87aoEFJR96jX9MfcakeWi13Foz5Ctois
         3fWulGiU0uOkct07PQJ5Nwj9aCoNdMfhe2oZxYlSzACdDOBJ/vSyIr4wj9zDOuY587v+
         9qqs8aOt0CCR8kKKuUrEhpf/UH8r+THMi3oFOohOXchE9p1hzXthqPl/UNg3SkEgKdvA
         mQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTw88palFD7+SjbmvqrQhtUBYE0y0z+9wugbJffOnsM=;
        b=Z8Wp94hA56YIB/NiymCWqcpuULQNXUuhROFVen6WoNWxDq+wBZ76HXsdrExF659C18
         AHopkmxiJpUaXgWr+8rSDCWGysUrNZqiOdElvZqbBlLCBVuMSqTB65gsyfyjxiwf/kjG
         8I5cbDaj4nQRInDDqUfyLlbpyUTx52stjfXZL8BdNogQzvRVCL+dSeHADZP7BZ9km6o8
         B/csP606a4xhnLKIQHTTJLX5q5espFtwvsdJusuwUc86z6dyVBqj8bcmMD7bT1PRsio+
         FXNuJjCW3ZW26xqGMLCZA+JC2y7Hiecd+89sA9ftM3ponuyph+5Ydveqm9inEf2CEgSP
         81jQ==
X-Gm-Message-State: AOAM533gI8ZjZYuqSzQt9YyzsmvTu+jsXGFuVEJ2Q0Tcv27MasMsr3Ej
        KYLkXMs6+d5XIaazhIoOJGRrKhuK3OgDoL0ld74=
X-Google-Smtp-Source: ABdhPJwRcRNaL9Cp/PHFR18M0JUnWOdsEr+fVxAXeWmuUAEkARK2erNRIf/01B7exkDIKFAEduWa1j4r3nZ1QgqKsnw=
X-Received: by 2002:a6b:750c:: with SMTP id l12mr20150950ioh.66.1590550517652;
 Tue, 26 May 2020 20:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <18609.1588812972@famine> <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com> <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
 <8dd2233c-a636-59fa-4c6e-5da08556d09e@hisilicon.com> <d59e5312-9f0b-f6b2-042a-363022989b8f@linux.intel.com>
 <d7a392e0-4be0-1afb-b917-efa03e2ea2fb@hisilicon.com> <f9a46300-ef4b-be19-b8cf-bcb876c75d62@linux.intel.com>
 <CAOSf1CHTUyQ5o_ThkaPUkGjtTSK1UOkxSmKAWY3n3bdrVcjacA@mail.gmail.com> <55b3a469-c306-acf1-f97e-f07f40054974@linux.intel.com>
In-Reply-To: <55b3a469-c306-acf1-f97e-f07f40054974@linux.intel.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 27 May 2020 13:35:06 +1000
Message-ID: <CAOSf1CE00f_3KxWAPvWngsW8z_frw6=qB70H+VmdSULaspHWhQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ashok.raj@intel.com, Sam Bobroff <sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 1:06 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Yes, in case of DPC (Fatal errors) link is already reset. So we
> don't need any special handling. This reset logic is mainly for
> non-fatal errors.

Why? In our experience most fatal errors aren't all that fatal and can
be recovered by resetting the device. The base spec backs that up (see
gen5 base, sec 6.2) too saying the main point of distinction between
fatal and non-fatal errors is whether handling the error requires a
reset or not. For EEH we always try to recover the device and only
mark it as permanently failed once the devices goes over the max error
threshold (5 errors per hour, by default). Doing something similar for
(native) DPC would make sense IMO.
