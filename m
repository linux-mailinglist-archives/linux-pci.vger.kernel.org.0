Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCA1879A4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 07:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgCQG0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 02:26:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42253 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgCQG0k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 02:26:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id b21so14602035edy.9;
        Mon, 16 Mar 2020 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=986MFMWS2fuD8X0pwumfKpMeJ4RrueeaFq6IWBfnpKQ=;
        b=njAU8PBN1d16SS/gtsi4wbrJkCXoaegvl4cYtm/v0rkhsXUbCqfYphdn8RZW9YQtfb
         8jh43swsYXeD+m6dNa/JoNK6tfTd99B5GIjltxFreYy586NXcGymCOM39oBfM0Pffsbk
         i3D5A5sQ2Y4WiLsp5CncNRmJ8VKMkh2GCfg0LusBGs1ZtoExnhXfTgNdhTDwnY7v9ysM
         kHDehL0Uxm7xdRkvuVRyvRGiVHPaJ0cf/Dn1ZY3TaAn1OSZybqsrSUmO8PkifjNbNaQl
         mb7qGyIKtOWP8YqTsdgW2pCcyYbRJRXCnizzhADH7bRDKZmupnlmlZUvo1jDiIRhD4/n
         oAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=986MFMWS2fuD8X0pwumfKpMeJ4RrueeaFq6IWBfnpKQ=;
        b=Mgudtaf9qhpomZ0/ihBRxvPEQjpEg4FaPs5TZEQOzxmwtHceLaVFhd2+EC5LeDo7AB
         e9VmzU1f4HDEGUdd2foqu6Z+h7wLbpXDIAWe8378x1QdgFsalXwUK5zfBUzkpdQte0zT
         zY3K3rHcappZfJDgQmxgffymm8wouhurfExl7jWruyyF6Vb2Soxko2iXdV2120gK7MPK
         W0h9ZpJN0HsmG5EZ1zcqDBk3jp9K8fqnaj2kYkIpZlYOnQkAmR4ffjME1nALpZUEJQbA
         fyR1UEJER0S4qAus/00wKuxMWNcLJ6toNdRXCLfxTCwu7CPjK2yHG1rnTwnwPqODYftE
         QbbQ==
X-Gm-Message-State: ANhLgQ00Nw+smQQUAGLrj7ODykjbaB6s3g7i8xw6lAvCB2ZMdbF9we+V
        4nieCsAULqUmQrJvCb36N/AIBM7kWdWmwif5/78=
X-Google-Smtp-Source: ADFU+vs7cgQPcBuHTj0MZoZ9WV2qQ2W0atjicWvrC4cn5YniK+gQ0xfkqI82FlBuNCMRWJypJIxG7MOe0zJpcDwvbVM=
X-Received: by 2002:a05:6402:1bcb:: with SMTP id ch11mr3802069edb.123.1584426396240;
 Mon, 16 Mar 2020 23:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200314194745.GB12510@mail.rc.ru>
In-Reply-To: <20200314194745.GB12510@mail.rc.ru>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 16 Mar 2020 23:26:24 -0700
Message-ID: <CAEdQ38GP8XJpgaWRZKFVpHY1mYGh2oaQnnBPYH86tbCRc=U_Xg@mail.gmail.com>
Subject: Re: [PATCH] alpha: fix nautilus PCI setup
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 12:47 PM Ivan Kokshaysky
<ink@jurassic.park.msu.ru> wrote:
>
> Example (hopefully reasonable) of the new "size_windows" flag usage.
>
> Fixes accidental breakage caused by commit f75b99d5a77d (PCI: Enforce
> bus address limits in resource allocation),
>
> Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> ---
>  arch/alpha/kernel/sys_nautilus.c | 51 ++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
>
> diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
> index cd9a112d67ff..1a1e49f58e66 100644
> --- a/arch/alpha/kernel/sys_nautilus.c
> +++ b/arch/alpha/kernel/sys_nautilus.c
> @@ -187,10 +187,6 @@ nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
>
>  extern void pcibios_claim_one_bus(struct pci_bus *);
>
> -static struct resource irongate_io = {
> -       .name   = "Irongate PCI IO",
> -       .flags  = IORESOURCE_IO,
> -};
>  static struct resource irongate_mem = {
>         .name   = "Irongate PCI MEM",
>         .flags  = IORESOURCE_MEM,
> @@ -211,14 +207,17 @@ nautilus_init_pci(void)
>         struct pci_dev *irongate;

One thing I noticed: this variable is now no longer used.
