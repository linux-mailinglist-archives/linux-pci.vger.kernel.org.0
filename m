Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2650B66BB7B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjAPKQX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 05:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjAPKQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 05:16:01 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24551C32C
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 02:15:06 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id 200so14421107pfx.7
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 02:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxvo5PRWAMnMhPhKPqi0zZIa8lc5uYeIQUDZrRe/SdA=;
        b=6CkLSjG478MnEZc68CT/vdw/PhY7orMT0R8bL6H4lxbTY0ZoSybb6ZqA9JGE0mPihg
         MJIFT1S1jXXb71U5Onx7qGPQKcnSLwGCy3XhYH+kMhaUw7FITQIoyj9Y1M6A6HkPpOiw
         V2X8cHNbPoRBTxfzrBw/gCfpP80VTu3Q6DgdnhzhTjCDb/kTcmoLWOgwhA8Z5h+hjQSg
         NETfR6yk4PiAcOhwYDtqDpndaUjTH+8NjFpkucaHPS9IQ14wWXyIbugMGSceSgDC/7Q+
         nMyLmDS6T+qA+/yPWDwZmJLLXuBLZ4LS21KyasEF0DnFchb1vRjZatV/mdLTELDm93q+
         tfzg==
X-Gm-Message-State: AFqh2kowkPXBGlzosbhc0DPH9fk4L7HzCJSbaZhfHTNhuYPDDp3EY4v3
        nxH6hfCfgso3K5oxaHTPlX76PT/UWGoo43c=
X-Google-Smtp-Source: AMrXdXvaK+YrEx1rJkEn0Kt/hctAyVGEwhta8q3kVG9rKi8irSny2mygVifsvgQSYwuOPRwCCJn3Ww==
X-Received: by 2002:aa7:910c:0:b0:58a:c289:feb6 with SMTP id 12-20020aa7910c000000b0058ac289feb6mr20479456pfh.17.1673864106314;
        Mon, 16 Jan 2023 02:15:06 -0800 (PST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id 145-20020a621697000000b00588d5c8b633sm13511631pfw.51.2023.01.16.02.15.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:15:05 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id k12so7780038plk.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 02:15:05 -0800 (PST)
X-Received: by 2002:a17:902:a505:b0:192:d553:d3c6 with SMTP id
 s5-20020a170902a50500b00192d553d3c6mr729996plq.103.1673864104630; Mon, 16 Jan
 2023 02:15:04 -0800 (PST)
MIME-Version: 1.0
References: <CAPH51bc1ZoP2ukJJh8nfrNY1FCp1nk7AP0jGGCvoskq2XbmAoA@mail.gmail.com>
 <029045a9-5006-e663-571f-b67344fa3a50@leemhuis.info> <2f866122-6a56-dfc7-9add-5168a4e796b2@leemhuis.info>
In-Reply-To: <2f866122-6a56-dfc7-9add-5168a4e796b2@leemhuis.info>
From:   Peifeng Qiu <linux@qiupf.dev>
Date:   Mon, 16 Jan 2023 19:14:53 +0900
X-Gmail-Original-Message-ID: <CAPH51bdcXFCiHrFPnMYGznsrCTOHDB0fyujFy3y5e8PWWYnnbQ@mail.gmail.com>
Message-ID: <CAPH51bdcXFCiHrFPnMYGznsrCTOHDB0fyujFy3y5e8PWWYnnbQ@mail.gmail.com>
Subject: Re: Missing sriov_numvfs after removal of EfiMemoryMappedIO from E820 map
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 16, 2023 at 12:41 AM Linux kernel regression tracking
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>
> Forget to mention one small detail:
>
> On 15.01.23 15:21, Linux kernel regression tracking (Thorsten Leemhuis)
> wrote:
> > [CCing the regression list, as it should be in the loop for regressions:
> > https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >
> > Hi, this is your Linux kernel regression tracker.
> >
> > On 15.01.23 10:21, Peifeng Qiu wrote:
> >>
> >> I'm using a dual Xeon system with Intel e810 25G network card and make use
> >> of SRIOV feature heavily. I have a script to setup the NIC the first step is
> >> echo $VFS > /sys/class/net/$DEVNAME/device/sriov_numvfs
> >>
> >> After switching from v6.1 to v6.2-rc1 "sriov_numvfs" is no longer present. If I
> >> switch back to v6.1 it's back. Command line parameters are the same so it's
> >> most likely kernel changes. I did git bisect and found the culprit to be
> >> 07eab0901ed(efi/x86: Remove EfiMemoryMappedIO from E820 map)
> >
> > This is not my area of expertise, but there is another report about an
> > issue that was bisected to that particular commit:
> >
> > https://lore.kernel.org/lkml/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com/
> >
> > A fix for that one was posted here:
> >
> > https://lore.kernel.org/lkml/20230110180243.1590045-1-helgaas@kernel.org/
> >
> > You might want to look into the report and if it looks like a possible
> > duplicate give the proposed fix a try.
>
> FWIW, that patch was recently mainlined and thus will be in 6.2-rc4 that
> Linus will likely release in a few hours.
>
> Ciao, Thorsten

I just tested the latest v6.2-rc4 and I can confirm that the issue is
fixed. Thanks!

Best regards,
Peifeng Qiu
