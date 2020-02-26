Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC7170CAB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBZXk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 18:40:29 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41767 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgBZXk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2020 18:40:29 -0500
Received: by mail-lj1-f173.google.com with SMTP id h23so1124165ljc.8;
        Wed, 26 Feb 2020 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zvwuQzMVyu/TdqK56I2p7OTWodLcL8mzDknB3/DWOE=;
        b=XI6hYN+NzZh/3ZislvkBSf4E7btI9gXm0ArDRVNuwWX9/kaHdAjXTvgMDWCvhtGUIW
         Dl97JEHdcSjr6tczhNN8zlMURx8PoCZBVEM5BZpjPcJCMzIjMfXPtjqJA2YTIUBrZkDw
         DZ+BxF9ReLYoSoUwIFSO3UI+ScKklW3LmS2vJ5dcX6Wejjcj2nTzCE2K54AK2BZ3bEqL
         84fp3Kw83xfC8r3NMPJAeMqKERf56bxUVoQJhZ2B8BH9bhwSyvjNHYL96+M4mcneKbmr
         VaGDqFWnJ76qFBBjuIJYjzo5nn5MmgJAiSxTwbLCiQT9b268UvcETkSMRDuT04GP8UzU
         ePNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zvwuQzMVyu/TdqK56I2p7OTWodLcL8mzDknB3/DWOE=;
        b=le0m3Yw9pVSfz1yKgddGMFcq6IM5IFgfq2ctnET5UZt2VOy7q9WXVXE+8tZ8e8hp0i
         w6eitWNiC2wy+r9dLjONQAjEu2DAe7FpZ+ZPy2F0ZzXyNv1OfrUE8DpF+AQJMEIWVZEh
         r48BHx2AoftCyPndSK2lWEfq3dQzm1S8Kzi13iTxFRD2sb7l8tOTmhGtqRLr6RwTfq8v
         7UB8PGKAicF8/3foG8ZeHK+cyVhCN56t5PIz2DYo4ZydqKhCbUqVF2Ib8rMRp0triPZS
         fn7mWOASIS+/f9YoPdoki7mJkDA5vt0E69tQsIWaaAEV3x1p6jbJsocEbNt0HikWeq1C
         Ow3A==
X-Gm-Message-State: ANhLgQ27l5klWOfqi/JNXpj5e5WCYsjiv1CPAxbZg7WJHsFVbSknHicr
        HwiWZjRZf8UKZYbHhPkQds9ujSylBLzI0pv22dA=
X-Google-Smtp-Source: ADFU+vt2buvIg9JM2Lv2YYTip1+/nm3zBcKpuSZlqnqJiGj6BZ9KuP7zrxsN00bhWw/8BpqXuFsDhAV2na66RVkh3bY=
X-Received: by 2002:a2e:b78e:: with SMTP id n14mr842381ljo.269.1582760426044;
 Wed, 26 Feb 2020 15:40:26 -0800 (PST)
MIME-Version: 1.0
References: <CAGgoGu5u7WZUUaoVYvVWS5nuNZz25PgR=uHkqvzXV5xFOC7KuA@mail.gmail.com>
In-Reply-To: <CAGgoGu5u7WZUUaoVYvVWS5nuNZz25PgR=uHkqvzXV5xFOC7KuA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Feb 2020 20:40:23 -0300
Message-ID: <CAOMZO5DvPr3srStsJ6KQph_v_=7=YGdcM4GQzi9yK+Km-wFBiQ@mail.gmail.com>
Subject: Re: Help needed in understanding weird PCIe issue on imx6q (PCIe just
 goes bad)
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Fawad,

On Sat, Feb 22, 2020 at 12:26 PM Fawad Lateef <fawadlateef@gmail.com> wrote:
>
> Hello,
>
> I am trying to figure-out an issue on our i.MX6Q platform based design
> where PCIe interface goes bad.
>
> We have a Phytec i.MX6Q eMMC SOM, attached to our custom designed
> board. PCIe root-complex from i.MX6Q is attached to PLX switch
> (PEX8605).
>
> Linux kernel version is 4.19.9x and also 4.14.134 (from phytec's

Does it happen with 5.4 or 5.5 too?

Which dts are you using?

> Then I enable the #PERST pin of PLX switch, everything is still good
> (no rescan on Linux is done yet)
>
> ~ # echo 139 > /sys/class/gpio/export
> ~ # echo out > /sys/class/gpio/gpio139/direction
> ~ # echo 1 > /sys/class/gpio/gpio139/value

Not sure why you toggle the PERST pin from userspace.

You should do it via reset-gpio property in the device tree.
