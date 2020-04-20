Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59C91B0B01
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgDTMxD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729587AbgDTMw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 08:52:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4BC061A0F
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 05:52:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so11972570wrv.10
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9w9a9BtCPltYxmsYrcgvCRZHciAh4PTWSTVRz9kigo=;
        b=b9aWT0PvNBisz/4PQKYiKEVpgRsAxhjfLt1qR2nrfXJi3AAsNyH9myAqavnV7G7Wh3
         ElDYT+3Z6mcCFjzJTkesXuFmF6M4ZvyvqDG6Q16cY/iTg381FhpIurr+Vpt8g4fmjHgF
         tLsG2LYWWzRO/EhwTxPLHSjZVHgzASUL7SBZaZtBRdFwdO3yL2HUwXIWoQWvvfg3NMWb
         QInP5qHaC70IjauzS5k9eC6bVnx9AcrwXuwrWMv9E5W977ELACP09TRyluv/MZFu2EWf
         TmcSmHM7Fd4Qyy4Gy/2sXTcK9Y0SPXZ9mXMf9wDgqO65R19TDZFHLQPi/HAb3e0DrdwS
         3jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9w9a9BtCPltYxmsYrcgvCRZHciAh4PTWSTVRz9kigo=;
        b=bSquE7S1/W9sR5ycOea43MTQEnpdFcak0xLa83FjeKAKbfezhGDiVtEZD3GZSoZNjq
         TI+WKe+BfppBYgRnfBonXMmDzwLC6tcq8YkOLOSVUJylrg6M8xrqmsYtcCvuQwp44BDO
         mYiY9oi62QgL9nl4JThJ7eS1UhFuPj7FdATP074DY6cJJEcJgpEbWBaYcvtexJbfAb4r
         9nQLUw2gC74RBRXg6rs9HMb/GSp2TOJOfPt/ZPu2SV+1FvO5cwiHzSnVqK9d07IeAT9R
         1DyHz6AGxZMzoUrLm8tsHk71A8Em2pfYldsz73TMbv4G2jtjruMOprH7Mu7J2quNvF4n
         uxKg==
X-Gm-Message-State: AGi0PuZNQKp76GbDJHKQ6nnqoZROp4NDmn65xO6wguNjwmKTKaeamTAv
        ugt1mP5cvZdRrb/0rh+hZVRl0Y1IM3RnB7FuqhiY9A==
X-Google-Smtp-Source: APiQypKv8s+5s+Sevqx84IoEmsSamRLTByngbt6QvoW+EFkP1sdpYDQsDL0PBv9J6edYJSBFQPoebLmLgKY71poU3nw=
X-Received: by 2002:a5d:4485:: with SMTP id j5mr17584675wrq.427.1587387177183;
 Mon, 20 Apr 2020 05:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <1587303383-37819-1-git-send-email-ani@anisinha.ca> <20200420090913.GV2586@lahna.fi.intel.com>
In-Reply-To: <20200420090913.GV2586@lahna.fi.intel.com>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Mon, 20 Apr 2020 18:22:46 +0530
Message-ID: <CAARzgwwk+=pRAfhg7bv8Zi8f91m5AMv8gVn9Rwxfgc7-RJ-dxg@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Cleanup unused HP_SUPR_RM macro
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ani Sinha <ani@anirban.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 2:39 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Sun, Apr 19, 2020 at 07:06:20PM +0530, Ani Sinha wrote:
> > We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
> > Consequently HP_SUPR_RM() macro is not used in the kernel source anymore.
> > Let's clean it up.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> BTW, there seem to be other macros like EMI() that is not used anymore
> so maybe worth removing them as well.

Sent a patch.

>
>
> > ---
> >  drivers/pci/hotplug/pciehp.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> > index ae44f46..5747967 100644
> > --- a/drivers/pci/hotplug/pciehp.h
> > +++ b/drivers/pci/hotplug/pciehp.h
> > @@ -148,7 +148,6 @@ struct controller {
> >  #define MRL_SENS(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
> >  #define ATTN_LED(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
> >  #define PWR_LED(ctrl)                ((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> > -#define HP_SUPR_RM(ctrl)     ((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> >  #define EMI(ctrl)            ((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
> >  #define NO_CMD_CMPL(ctrl)    ((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
> >  #define PSN(ctrl)            (((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> > --
> > 2.7.4
