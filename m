Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B111DE1EA
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 10:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgEVIdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 04:33:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgEVIdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 04:33:31 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N1xZX-1ivw3s247t-012KMI for <linux-pci@vger.kernel.org>; Fri, 22 May 2020
 10:33:29 +0200
Received: by mail-qt1-f170.google.com with SMTP id a23so7725832qto.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 01:33:29 -0700 (PDT)
X-Gm-Message-State: AOAM531l+NR8xbn0pFiA0+JMyftlsyaL8DVnxYrY8R9rs46yUz2MSEwH
        SKIvDO/Zc/mdvmnyoahJw9eitfrK/qy1xoHCGpo=
X-Google-Smtp-Source: ABdhPJxfcs3ZT2aLA7BYRC5mCrGso5P3kWVVcAYg6XubplVJQy3U52DMRyTk03H8OqhPgepbkOY1b85ob2hkAE1uLdY=
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr14598461qtr.7.1590136408350;
 Fri, 22 May 2020 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu> <20200521085211.GA2732409@kroah.com>
 <b966d133-4e1e-f050-f1ca-67aa7eaf0ca7@doth.eu>
In-Reply-To: <b966d133-4e1e-f050-f1ca-67aa7eaf0ca7@doth.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 10:33:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YwMJmTimtj0_KfKaPuPs3SMvUgj4eDow1jp8CY5Ugng@mail.gmail.com>
Message-ID: <CAK8P3a0YwMJmTimtj0_KfKaPuPs3SMvUgj4eDow1jp8CY5Ugng@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Add short delay after exit from ASPM
To:     Klaus Doth <kdlnx@doth.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v3XsL2AU4aAoMWWd3tJybCqF661HyuPqU351EzJslAQ2UtMFhps
 5S/AE2ICBCOUjN0HKX6/iZ5+k7ek+4/xa4BFaTddMAPJ+nkTZ1b8YqJe0fPENnnkLZj2qC5
 oTtdN0YNwQZr1T1M5+fgdCPUxSMSL5rkBdFuugXXAgTmfV8Qo+d2h/gT0/11QT5JH9hrkhe
 KiBIQQvqgpfrnsn1PtydQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gnzmTvXto2I=:q9bs+oQh4UCLvWncBTmvS+
 tA/htghikYjhh85rKWAsptuaKDq53hQ8TON23+xCZcfLbSxKs3iGfw8q8MCcLAf/gXw6gvPJM
 j977Rev5SgFfsGVDDyl/VnL64u5qi8X/1KBDBLoZ/OkXOvLVfiO6EktlRZ1BU77C6elOuSBTS
 0NhoEXtjmnQN/lSmXazIbuxnlWt5Qu9Dn0JBbp/FDGxGjQWAvqLEuG++PqNIUp5OUEDHFW9fu
 qtaLfQ1Hx5yFIx2TLOBrfwmgja3B0c1gEsHl6ysDBlvW5se5CouKvoHF8Lylq6nI1Fzgd7oC0
 zDNEJllxVdHHYB4P+G9Bp3CFeqISk19BD/Q6jqUVOH05piYCHDOLcS1LFPvRXN9e0XaCpqdJg
 6p4ak3wmbHZ342DKFZdZaY+XlQt0VPHcj/eBNF00GcbRPXfDnjjkUlYcbZsP/CDFV1KHz6srS
 Iz4bZUgCzYz+Htlam+9Fan1utw/PRNBndzkXH9L1CXwjhSS0aBcfMf+cijnTQMQPkq9jtQh/x
 +JN2jilTg2wnGZTsQDlnKxmS3jc6N9BFqVfKJw9DEUU9FddpyabnmHWPfubMTb11cXaIXLI5M
 SH0p68JiY1LDPdKW3DsBvOc16lpOI3eRNB8ny2tlrbTLStsInTmnzMAsZ//d39IYsbvAItUH+
 5nBPUKbv1vN2idVz9BuufsjpP8yHHiwK6yK619CjZEqyPRa65l3MgSbTl/DsTp9LgCc4brjQl
 jv/yLJsblI9jJjlKTXQCsfSMvYNjhIyCXzIArhlRutApJzuVKnkp+MmwbgYDWoRKxqUS0Kq3A
 samDfMkeRqUFSQ8ZphNc2b8oOI0a+dYTHiLrc9y3GFGFVYgNI8=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 10:23 AM Klaus Doth <kdlnx@doth.eu> wrote:
>
> From: Klaus Doth <kdlnx@doth.eu>
>
> DMA transfers to and from the SD card stall for 10 seconds and run into
> timeout on RTS5260 card readers after ASPM was enabled.
>
> Adding a short msleep after disabling ASPM fixes the issue on several
> Dell Precision 7530/7540 systems I tested.
>
> This function is only called when waking up after the chip went into
> power-save after not transferring data for a few seconds. The added
> msleep does therefore not change anything in data transfer speed or
> induce any excessive waiting while data transfers are running, or the
> chip is sleeping. Only the transition from sleep to active is affected.
>
> Signed-off-by: Klaus Doth <kdlnx@doth.eu>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> b/drivers/misc/cardreader/rtsx_pcr.c
> index 06038b325b02..8b0799cd88c2 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -141,6 +141,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
>      struct rtsx_cr_option *option = &pcr->option;
>
>      rtsx_disable_aspm(pcr);
> +    msleep(1);

Your patch looks fine to me, but I think you should put a short version
of that the changelog text into a code comment next to the msleep().

       Arnd
