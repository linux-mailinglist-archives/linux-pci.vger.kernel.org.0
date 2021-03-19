Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203B8342152
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCSPys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCSPyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 11:54:37 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF0C06174A;
        Fri, 19 Mar 2021 08:54:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m7so3960958pgj.8;
        Fri, 19 Mar 2021 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XORtYAHbG9JOQiFezkjwFrACKw99bbCHdzV5HKtNWRE=;
        b=SQ1qh19RY1G4ZdM26EVGR603nMlSNM5luT6l8whbU40uPYbKhuTZt4gWFcEG2sg+Rj
         S+JArkF/u2r2Q4DT+0qIQ/W9xHQhjqcJ6QKxUgK4zMd0byFcqoU1f7jfGziohBPmGAxa
         6OY8L9VxFFZc/CsIVGjSws7JfxQoifA6r45MPN5j9216kIk5gD87dQWLQ3BG6YpBsl0i
         iIna5TxEGKGryHwf0+qI6uxJ/aoB3pGmqOTZfjNeVMwVdbKdDKNUJWLyyEQhl+jBfYpp
         0d6AWpJmZACejAtqW1Ci2yTSXz6ZkEFOU6WLVFoVLmqj3pZ88ogJYc3S+1vsByiC2r+Q
         VUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XORtYAHbG9JOQiFezkjwFrACKw99bbCHdzV5HKtNWRE=;
        b=FB8Vi+ZJlf6Al6MKsVO47LuBzRLmFTiGxrXB5GD/o+rJ+swUNBoot8Ta8gNZBV6K0g
         uEikg/F+BKM0LiWGTQi4LyZMfXNm6FECwf02u89xZEZ+6SZRz6IAV2/3U5bS6NhlWa78
         +8RBt3Dwr/3RfDQ/asBKPsauPu9EX23S7XB+fviAfnDqYhOZYGZY4Jd/FU+UVkCl1evp
         /hgwVqBMxusNsD6pcYevIGVDR00XQ3RfhEXF3CkR0QbzN6E0qJO6l7U5U6rzzx3aBwoK
         n7kNYj5K9+suRXc0LjdazAQvHfu8I1DfTad/LJnXzDClbdQKFjjrdihs/SvaMwkDg8dB
         Ru5w==
X-Gm-Message-State: AOAM533EXyJKa4XRFqcHjBfaeteqJDO2WL2qS8d3gS2KbFa71g7e97yY
        ilmwHvT6O8+0od2EG//mMHI=
X-Google-Smtp-Source: ABdhPJzYLBlBKndimmvTRLl+X03Ij0bxB4NCXhesL4NTlngd1Cdz7jp2iPZRPsAPDFlBYrD7VYGhQA==
X-Received: by 2002:a62:8c45:0:b029:207:d29b:b160 with SMTP id m66-20020a628c450000b0290207d29bb160mr9481387pfd.80.1616169276577;
        Fri, 19 Mar 2021 08:54:36 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id y20sm6096888pfo.210.2021.03.19.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:54:36 -0700 (PDT)
Date:   Fri, 19 Mar 2021 21:23:52 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210319155352.b2r6b4apjrmuebbx@archlinux>
References: <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal>
 <20210318174344.yslqpfyct6ziwypd@archlinux>
 <YFShlUgePr1BNnRI@unreal>
 <20210319152317.babevldyslat2gqa@archlinux>
 <YFTFNAeAyovUmQ/W@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFTFNAeAyovUmQ/W@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/19 05:37PM, Leon Romanovsky wrote:
> On Fri, Mar 19, 2021 at 08:53:17PM +0530, Amey Narkhede wrote:
> > On 21/03/19 03:05PM, Leon Romanovsky wrote:
>
> <...>
>
> > > > > It was exactly the reason why I think that VM usecase presented by
> > > > > you is not viable.
> > > > >
> > > > Well I didn't present it as new use case. I just gave existing
> > > > usecase based on existing reset attribute. Nothing new here.
> > > > Nothing really changes wrt that use case.
> > >
> > > Of course it is new, please see Alex's response, he said that vfio uses
> > > in-kernel API and not sysfs.
> > >
> > Still it doesn't change in-kernel API either.
>
> Right, but the issue is with user space part of this proposal and not
> in-kernel API.
Userspace part just inhances existing reset attribute still no
significant changes there.
>
>
> <...>
>
> > > > As mentioned earlier not all vendors care about Linux and not
> > > > all of the population can afford to buy new HW just to run Linux.
> > >
> > > Sorry, but you are not consistent. At the beginning, we talked about new HW
> > > that has bugs but don't have quirks yet. Here we are talking about old HW
> > > that still doesn't have quirks.
> > >
> > > Thanks
> > >
> > Does it really matter whether HW is old or new?
> > If old HW doesn't have quirks yet how can we expect
> > new one to have quirks? What if new HW is made by same vendors
> > who don't have any interest in Linux?
>
> It is pretty clear that this sysfs won't improve quirks situation but
> has all potential to reduce their amount even more.
>
> Let's stop this discussion here.
>
> Thanks
>
IMO it does improve usability of devices which I consider to be more
important than developing quirks which are just bandages in the end
not HW fix. There's no point in using Linux if
I can't use the device in the first place and expecting to wait
for some community member to develop quirk without vendor support
is simply unrealistic.
So let's stop this discussion here.

Thanks,
Amey
