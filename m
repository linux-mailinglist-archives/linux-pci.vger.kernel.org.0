Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4011633B4D4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 14:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhCONoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCONoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 09:44:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE19C06174A;
        Mon, 15 Mar 2021 06:44:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q5so7825609pgk.5;
        Mon, 15 Mar 2021 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KpMy6R6nRRPAvNrbXy+x0+hRy8BolEopnL9wSPTgiAs=;
        b=u5yv6GnqfSTGi9qkE6HaSLH3abvCE+feFQjEcVsRWv8bYQOWVtXY5XiPMGc+NvURrF
         D4q9NzaK1XIBVznQVlUkaoRI6LJXRVCoN8vB1jc79IlvyiCfPpzKE3I+E/tnxBPOm2T4
         07/lAJAtSL2SC04TnGrnGnhBpz8OqJLfE99GIpNPngAyNgGPqi77MfS/MlwiPESXuSPr
         MSoGawK/I9oGHn4zHmZteigh9ECT4bjX5kIrHybMk7Mf93V1E1y/qoUEHa1LWuiclhJ+
         Z9xgV/W2Cu6u8DOGTWPm4AdtABnZgS2ExnNijxNu/XpJT18hdqA3aWj4KNRLcgnXtCcB
         7/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KpMy6R6nRRPAvNrbXy+x0+hRy8BolEopnL9wSPTgiAs=;
        b=hUagiss2CYri55HJDf6KqXYcoR9UrA08Dz13MkeHNgm4q2LaxgnADdt3X86XLV3jMD
         3ysfnzpNkiJStgtfBESeuYU9uxNkFVAvYqbFM6+lfoLopAaDIIjuP3Up0Nealswia9iD
         /R8FbmT+3VGdmF1DAl7BWRK7SY6XOc6+eXLbqy/rluhsYe9gSNHBq+I6X5i5R3ugkhPw
         wsgy2h2C+j2n448KtEkd7bvsNqckO4AdY/mJCGnzYjTO10NXwaUHBfb3HEmEA63eemJP
         9RmAtN51WeE7yqQUC9OdrTdkmBE2MlJ/JISJODRn3/QIwGPgH+0N1d22xZ5iU26UKVS9
         zgmA==
X-Gm-Message-State: AOAM532McOpql6uDGZAO3cmiXnvJWg/dgxmwY6rPOSJWor0BoK3HIoL1
        fNxNx7Y4YBx+7Mzi+C6/8Bs=
X-Google-Smtp-Source: ABdhPJyq1DQl/RusU93e/V7EfJWOobxs+5IaXtNWdhduqtmjTebHGQs7bGD1rwA5xFlpFTu1hRK/wA==
X-Received: by 2002:a62:8485:0:b029:1fc:823d:2a70 with SMTP id k127-20020a6284850000b02901fc823d2a70mr10508095pfd.18.1615815845002;
        Mon, 15 Mar 2021 06:44:05 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id t17sm14126103pgk.25.2021.03.15.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:44:04 -0700 (PDT)
Date:   Mon, 15 Mar 2021 19:13:23 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     bhelgaas@google.com, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210315134323.llz2o7yhezwgealp@archlinux>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210314235545.girtrazsdxtrqo2q@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/15 12:55AM, Pali Rohár wrote:
> On Friday 12 March 2021 23:04:52 ameynarkhede03@gmail.com wrote:
> > From: Amey Narkhede <ameynarkhede03@gmail.com>
> >
> > Add reset_methods_enabled bitmap to struct pci_dev to
> > keep track of user preferred device reset mechanisms.
> > Add reset_method sysfs attribute to query and set
> > user preferred device reset mechanisms.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> > Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> >
> >  Documentation/ABI/testing/sysfs-bus-pci | 15 ++++++
> >  drivers/pci/pci-sysfs.c                 | 66 +++++++++++++++++++++++--
> >  drivers/pci/pci.c                       |  3 +-
> >  include/linux/pci.h                     |  2 +
> >  4 files changed, 82 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 25c9c3977..ae53ecd2e 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -121,6 +121,21 @@ Description:
> >  		child buses, and re-discover devices removed earlier
> >  		from this part of the device tree.
> >
> > +What:		/sys/bus/pci/devices/.../reset_method
> > +Date:		March 2021
> > +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> > +Description:
> > +		Some devices allow an individual function to be reset
> > +		without affecting other functions in the same slot.
> > +		For devices that have this support, a file named reset_method
> > +		will be present in sysfs. Reading this file will give names
> > +		of the device supported reset methods. Currently used methods
> > +		are enclosed in brackets. Writing the name of any of the device
> > +		supported reset method to this file will set the reset method to
> > +		be used when resetting the device. Writing "none" to this file
> > +		will disable ability to reset the device and writing "default"
> > +		will return to the original value.
> > +
>
> Hello Amey!
>
> I think that this API does not work for PCIe Hot Reset (=PCI secondary
> bus reset) and PCIe Warm Reset.
>
> First reset method is bound to the bus, not device and therefore kernel
> does not have to see any registered device. So there would be no
> "reset_method" sysfs file, and also no "reset" sysfs file. But PCIe Hot
> Reset is in most cases needed when buggy card is not registered on bus,
> to trigger this reset. And with this API this is not possible.
>
> PCIe Warm Reset is done by PERST# signal. When signal is asserted then
> device is in reset state and therefore is not registered. So again
> kernel does not have to see registered device.
>
> Moreover for mPCIe form factor cards, boards can share one PERST# signal
> with more PCIe cards and control this signal via GPIO. So asserting
> PERST# GPIO can trigger Warm reset for more PCIe cards, not just one. It
> depends on board or topology.
>
> So... I do not think that current approach with "reset_method" sysfs
> entry bound to the PCI device does not work for PCI secondary bus reset
> and also cannot be used for implementing PCIe Warm Reset.
>
> I would rather suggest to re-design and prepare a new API which would
> work also with PCIe Hot Reset and PCIe Warm Reset.
>
> This "reset" sysfs file can work only with PCI Function Level Reset or
> some PM or device specific reset. But not with reset types which are
> more like slot or bus orientated.
>
The scope of this patch was to expose current reset methods
to the userspace. Also reset methods are available
for only those devices that allow an individual function to be reset
without affecting other functions in the same device.
So if those conditions are satisfied by the device then it can
use slot reset (pci_dev_reset_slot_function) and secondary bus
reset(pci_parent_bus_reset) which I think are hot reset and
warm reset respectively.

Thanks,
Amey
[...]
