Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8006192C3C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCYPX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 11:23:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45444 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCYPX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2020 11:23:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id t17so2427577qtn.12;
        Wed, 25 Mar 2020 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0JYEoigZWM1yeX7JgpaphNd8KXCrioPAqCpQizqggg=;
        b=autKwVYxtzoLq5oAA+Cci6u6EukRb+k57IlORCbtMZ0TIBF8bAkJ2aWzN09JD3jY4B
         uX9DgK8r+QQPBwITxqt2ZZQoKHUHqBCpkMmvWkA1z0abhtfF8M67nOJz4OuilrmgUScU
         BzGSp7by7/dT7FPbNXuVD9bCLxLI/X4tWQDdx1TCa5Z0iUHvBXBOgZUyNJdDnq+EUYZ6
         gElffKRGxJ2Y26EvL0manWdox2JU8feN/5NnARGCVJluMpYTXuK+jvm7QE3ttRoDbm+J
         RuEvKykfq0Cxxwjg/NKtL50Jtz4PHGJwcH3R8oaV0cyVZGnSagzyIaZks55v3jJK1X3K
         QIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0JYEoigZWM1yeX7JgpaphNd8KXCrioPAqCpQizqggg=;
        b=riy6ytZgkFx8wPL4RbpF3EVlJBzmZf+i9lZ8NkL75qDd/vrgGx8wLIw88TzwCQl/Qv
         FGyUPIuI8LyiClx1WYPdTKnCVwU0IxD3zGvc2EKYhg13U1mxtyD/fhOb3jpCpGnSevrv
         2KyNtV16n7hxcFM/R8q7JGXqLMb1/f0Qwo7kOTfyAKwR8xME9XUaGuzZYw3GDE4yMMYB
         WQHA//A8LQGByT3B92QN/4S5LujQQdyzYXV93YLCFMUZRAVXf9phL8UJj+V1Q+eTxALu
         UKG2Gvu4TT0pAwm/sIDZS+FhT04Rjm7FKDcNF2gEcrILZVHKqrFdA9qNfsfx44InJ84L
         /wuQ==
X-Gm-Message-State: ANhLgQ3b5+lX0+ncVrL63fFD3SnIdadBNHfOmOqoRBDV5xGbxVuej/br
        1hPgdq7uS5jLC7E8tgA1kDkg+WbZFocjTbBL8yY=
X-Google-Smtp-Source: ADFU+vtX1EZKWaDVmE6LIswsBe1CfdqTF6SPmg7IMajB6dCadIJAq80gEr8/yesNu0odN314yF5sUBfDtGnycyv+wqU=
X-Received: by 2002:ac8:38cc:: with SMTP id g12mr3541264qtc.186.1585149833875;
 Wed, 25 Mar 2020 08:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200324234848.8299-1-skunberg.kelsey@gmail.com> <20200325071608.GA2978943@kroah.com>
In-Reply-To: <20200325071608.GA2978943@kroah.com>
From:   Kelsey <skunberg.kelsey@gmail.com>
Date:   Wed, 25 Mar 2020 09:23:42 -0600
Message-ID: <CAFVqi1R7gHCAMSKw5SSns0jq0++60vyoao6w_g_proC6dYD2_Q@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI: sysfs: Change bus_rescan and
 dev_rescan to rescan
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        rbilovol@cisco.com, Don Dutile <ddutile@redhat.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 25, 2020 at 1:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 24, 2020 at 05:48:48PM -0600, Kelsey Skunberg wrote:
> > From: Kelsey Skunberg <kelsey.skunberg@gmail.com>
> >
> > rename device attribute name arguments 'bus_rescan' and 'dev_rescan' to 'rescan'
> > to avoid breaking userspace applications.
> >
> > The attribute argument names were changed in the following commits:
> > 8bdfa145f582 ("PCI: sysfs: Define device attributes with DEVICE_ATTR*()")
> > 4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")
> >
> > Revert the names used for attributes back to the names used before the above
> > patches were applied. This also requires to change DEVICE_ATTR_WO() to
> > DEVICE_ATTR() and __ATTR().
> >
> > Note when using DEVICE_ATTR() the attribute is automatically named
> > dev_attr_<name>.attr. To avoid duplicated names between attributes, use
> > __ATTR() instead of DEVICE_ATTR() to a assign a custom attribute name for
> > dev_rescan.
> >
> > change bus_rescan_store() to dev_bus_rescan_store() to complete matching the
> > names used before the mentioned patches were applied.
> >
> > Signed-off-by: Kelsey Skunberg <kelsey.skunberg@gmail.com>
>
> You should add:
> Fixes: 8bdfa145f582 ("PCI: sysfs: Define device attributes with DEVICE_ATTR*()")
> Fixes: 4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")
>
> to this too, and a
>         Cc: stable <stable@vger.kernel.org>
> to the signed-off-by: area so that it gets properly backported.
>
> Other than that minor thing, looks good to me, thanks for fixing it so
> quickly:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Done! I appreciate the review and help, Greg. :)

link to v2:
https://lore.kernel.org/r/20200325151708.32612-1-skunberg.kelsey@gmail.com

- Kelsey
