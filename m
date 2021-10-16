Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7386430075
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 07:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbhJPGAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 02:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhJPGAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Oct 2021 02:00:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04095C061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 22:58:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so778475ote.6
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Q7FUP+N01v+YLqZsoSXz0aSSuxX3vj0T3Lusi7JvYUM=;
        b=QtCDIa8a38GYTygcyzrGAHO1AukOuIuGaYOshJOw1LDDce/dSzxPlU3bFg6tj/AZmY
         dXir1tm0PvUCzpAwiY273TXuGdTKz12J3719Z5/1a71EcVubzrpnASTdHUerBpcj06ME
         di1X2S9R+gnfxksHSWd/BYX6eVyz1HKZLW2Ot3joYoICMbEx8RAuV6kVj3zX0TX9ypda
         XtsPHCBfbEDR69tksjRsth9wyb0wSfAwJ3kFlj302EQLJ+ObNMcaJAIWeMfWh/EjxgiG
         ZzB+9FI3mdh76WAPhN6o0uFhkl58m8JDAbTV1Ca7/M6gxohiMS8mvdKGi/ZJDRjIcsce
         uYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Q7FUP+N01v+YLqZsoSXz0aSSuxX3vj0T3Lusi7JvYUM=;
        b=PEWdUkUWO/jx4/ghOKp5Dy13cRQJjt8k03V/8BEj1entJhwfhDnSoOsCHbRGQT4pEV
         9phjSLfSNPHfkE4Zkv+cKiyWUvWtPoY+cUuKORHjA8aHY9Nsiqx8sR2DixPNVUiUNxEj
         ssFq59YFyGmSQ/0sl5xkuDghiaTSmVb/vr+90UZ71mH5JTBQW32tmiQLwB/uKfQwChUS
         IH9Uf3+mqB0QtcpY8BvYR861qhz5ou4F8ZJvBQ6pepVE3ShlvPgneUrP4a67p13BEYkv
         HSO2XwlLPkqBpKJ9VsXklNk833XNEevuw5AYekDE6ioRNpRP/7rYY/72K9vC7uhD6E0g
         vcmA==
X-Gm-Message-State: AOAM531U5x6ZGG9FmFoTo61qoZrodHkk4qSICGwN1BzB8UpFkgjvVjcS
        3/aXfrMTlD+RXZPskceokkYAtpm1ieb6HgCKhR6C0gCEQytCiw==
X-Google-Smtp-Source: ABdhPJzhhPes9335wRm9GCuDPQsm3GaZt/d2eYyLCJ3GT0NvRaiteuUtsgHXZb4x+GTn25FpkAJxLAVMv0Q2EelAex4=
X-Received: by 2002:a05:6830:438a:: with SMTP id s10mr11499091otv.173.1634363892845;
 Fri, 15 Oct 2021 22:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8URVjPEGFLHFXk4iS-7FYpg_=ZCVr2f6ufcFkNnZqAUug@mail.gmail.com>
In-Reply-To: <CAHP4M8URVjPEGFLHFXk4iS-7FYpg_=ZCVr2f6ufcFkNnZqAUug@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 16 Oct 2021 11:28:01 +0530
Message-ID: <CAHP4M8XVUwbJ+i8DeH0E5vOFY7zX2QnOsLTC7FGJGO2_aoUJiA@mail.gmail.com>
Subject: Re: Host-PCI-Device mapping
To:     QEMU Developers <qemu-devel@nongnu.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Never mind, found the answers in kvm_set_user_memory :)

On Fri, Oct 15, 2021 at 9:36 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> Hello everyone.
>
> I have a x86_64 L1 guest, running on a x86_64 host, with a
> host-pci-device attached to the guest.
> The host runs with IOMMU enabled, and passthrough enabled.
>
> Following are the addresses of the bar0-region of the pci-device, as
> per the output of lspci -v :
>
> * On host (hpa) => e2c20000
> * On guest (gpa) => fc078000
>
>
> Now, if /proc/<qemu-pid>/maps is dumped on the host, following line of
> interest is seen :
>
> #############################################################################
> 7f0b5c5f4000-7f0b5c5f5000 rw-s e2c20000 00:0e 13653
>   anon_inode:[vfio-device]
> #############################################################################
>
> Above indicates that the hva for the pci-device starts from 0x7f0b5c5f4000.
>
>
> Also, upon attaching gdb to the qemu process, and using a slightly
> modified qemugdb/mtree.py (that prints only the information for
> 0000:0a:00.0 name) to dump the memory-regions, following is obtained :
>
> #############################################################################
> (gdb) source qemu-gdb.py
> (gdb) qemu mtree
>     00000000fc078000-00000000fc07c095 0000:0a:00.0 base BAR 0 (I/O) (@
> 0x56540d8c8da0)
>       00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 (I/O) (@
> 0x56540d8c76b0)
>         00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 mmaps[0]
> (I/O) (@ 0x56540d8c7c30)
> (gdb)
> #############################################################################
>
> Above indicates that the hva for the pci-device starts from 0x56540d8c7c30.
>
> As seen, there is a discrepancy in the two results.
>
>
> What am I missing?
> Looking for pointers, will be grateful.
>
>
> Thanks and Regards,
> Ajay
