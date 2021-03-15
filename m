Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D933BFE9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCOPeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhCOPeW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 11:34:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF57C06174A;
        Mon, 15 Mar 2021 08:34:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d23so12278587plq.2;
        Mon, 15 Mar 2021 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gYbVLatmMXxxm3XlETOvCj+hkAugf9rbLUg+H5BCo3U=;
        b=MF4CRoTe3dDmLPYiOBeMZOx1Sy5eseHTJvatZ+mZ+uFDf4Z5/yso9pMRYDVseq7TDP
         HKzs4D03mAVFFByBMuLtF5t/nLqdWWfsZ1hTd5NdM6x43L12LrpIIHbTMol9b4pZVHip
         zUI3D+FaKjgzZzQEhrIwqw1jo/2CZIqv6JSTXY3sCb7SAY2MgFbRT0CfT1UlkUWKufzF
         3b3MOFym590Mgu91nwWLRVORE/ffCWZ93hD/5tyej1Ckh0rw7kFjSCmvHXseVD471g7R
         BYjVoOUql4vGxU63yczfxdOLy8YQ6t+/KRm5DLaQuMisPOTCeYoMVal1KGC/NfCNsceK
         BDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gYbVLatmMXxxm3XlETOvCj+hkAugf9rbLUg+H5BCo3U=;
        b=QxyzGgBrVsQmuIlq7wOFDOPChzKr0Q/n4k8EAHxfnoA0pE1zg/nu9mEMeAMiBLLoMz
         +XEb2e9vywACoE0zvrl452WlU/YQC9ye1mD98g8OrQytr3ZFOqynQjBjD0ultZgPtzNH
         VCafjEhHMO3Lj48UOFKNH8lEiE3vCi3AXh4IwbGVgMHiNYnt+jP2LSTNCzqcwTmpo/sY
         xHai1oRtKDVgXiVC2aHiS8Ybcw3EKkJ1YC7EP0EBvJRdBbvk7pS4eMVcPet1am+tr3VG
         HF9xLgbQhMzVUyiYABXdozVVbsu3erme8ISiof9a7h09SD4L1DWOMIYhhgOhuU3S3v/L
         LX3g==
X-Gm-Message-State: AOAM532P/u1XXTOaLG6PucYJEChjC01pxgvFQBM+pef2zBewUBI+Yt3X
        wHqncM9Ojf7rmx+2CDM6+fk=
X-Google-Smtp-Source: ABdhPJydMcDOyQiRvk8pT7CZYe4fPeW+E03bNJx47yzQFeHejuDjdTI/aXKoRevhK0j3mQMrMuOvWA==
X-Received: by 2002:a17:902:d893:b029:e6:7a98:6919 with SMTP id b19-20020a170902d893b02900e67a986919mr12138229plz.58.1615822462251;
        Mon, 15 Mar 2021 08:34:22 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id a20sm14731673pfl.97.2021.03.15.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:34:21 -0700 (PDT)
Date:   Mon, 15 Mar 2021 21:03:41 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, raphael.norwitz@nutanix.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210315153341.miip637z35mwv7fv@archlinux>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
 <YE94InPHLWmOaH/b@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YE94InPHLWmOaH/b@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/15 05:07PM, Leon Romanovsky wrote:
> On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> > On Mon, 15 Mar 2021 14:52:26 +0100
> > Pali Rohár <pali@kernel.org> wrote:
> >
> > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > warm reset respectively.
> > >
> > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > type of reset, which is currently implemented only for PCIe hot plug
> > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > kernel and therefore drivers do not export this type of reset via any
> > > kernel function (yet).
> >
> > Warm reset is beyond the scope of this series, but could be implemented
> > in a compatible way to fit within the pci_reset_fn_methods[] array
> > defined here.  Note that with this series the resets available through
> > pci_reset_function() and the per device reset attribute is sysfs remain
> > exactly the same as they are currently.  The bus and slot reset
> > methods used here are limited to devices where only a single function is
> > affected by the reset, therefore it is not like the patch you proposed
> > which performed a reset irrespective of the downstream devices.  This
> > series only enables selection of the existing methods.  Thanks,
>
> Alex,
>
> I asked the patch author here [1], but didn't get any response, maybe
> you can answer me. What is the use case scenario for this functionality?
>
> Thanks
>
> [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal
>
Sorry for not responding immediately. There were some buggy wifi cards
which needed FLR explicitly not sure if that behavior is fixed in
drivers. Also there is use a case at Nutanix but the engineer who
is involved is on PTO that is why I did not respond immediately as
I don't know the details yet.

Thanks,
Amey
