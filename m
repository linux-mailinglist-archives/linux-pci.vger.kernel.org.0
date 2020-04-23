Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450B51B62DC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgDWSCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbgDWSCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2020 14:02:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1301C09B043
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 11:01:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so7910453wrw.7
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vFvQJ+X9x2fkOsaxQlxkegYOOkfdjHsu+VNUmji7qM=;
        b=vkzbFlKNxWQfoNjGjP0cN0x+tAOzVkVduiUCVecHWhVGJQZl0dbe5CO367tCplapfV
         2kDEkUunHthWlNCDEH5rLiC2cmHULSn3na8remXr6R9gQWZT2A+S+4Rw6HE1+q2/dVI1
         uajUo7ezsZ5ZGHtNDHPxFyhKGJ3vpVRgxRX59H3B1G8ZqB6XgymkQaTcth4blxSISb7N
         1DMmqHEfhZT2k6b9DqCS0CF0tvSICTxhv4+Qy/bWUT+6r7y22TtyVTnW//tsn5CTXhzj
         s8arD2itkmSubXpIclsmY6MVoVNJ3KyrmJnG8C9nTxPhQEpc8Ka1gWZi6I+6iuRIDl2S
         19GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vFvQJ+X9x2fkOsaxQlxkegYOOkfdjHsu+VNUmji7qM=;
        b=lvyiNFNktkS0BYzY4wqN4GRJdRcmYYxpIboZr4QiVKmvDoRjVpnzxbI87OJ19x287D
         YA8ME1qNve2alNvtzLtsggozuQ7ZxfvotSYBgwZZIW2z/MPx1SOrfTQwvFjlmjskmVcz
         dZI57Q4tOBhOo2jZLc1lh4UDblWvw91gxbzqF+jzQz4PaqfjWpBv1Hbj6gDmmcEEukMN
         rS2vIez+mujAxUh+lVXIu/jjT2wtcNCnrxPC0n6DRwRYJ089sL0LX6nppyj+mSoXTOSw
         eZiycqHW+AJ4fmctbIlNx0uax3AeemZNZ/fUqwZQ6I7mPx8Q+qRHIUzppvabKAlHGCLQ
         1S7A==
X-Gm-Message-State: AGi0PuY8QwWPq++jTzGsY0JSEcR9v4vreQhsk1iQKWq+9nxKYnq5n57I
        x4NkrX/tYrJMX9isJNZ0vXVs3036jZieHQSUt4Mhbg==
X-Google-Smtp-Source: APiQypLNbBxoio8j8JZsOio5k0hMyf+7ii06W4qPM4R6vyYszHDENG8QcRNoFv0EP8lb/W8NSXVxoN7S8fkxpy7nVuc=
X-Received: by 2002:a5d:660d:: with SMTP id n13mr6029719wru.369.1587664918339;
 Thu, 23 Apr 2020 11:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <1587387114-38475-1-git-send-email-ani@anisinha.ca> <20200420175734.GA53587@google.com>
In-Reply-To: <20200420175734.GA53587@google.com>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Thu, 23 Apr 2020 23:31:47 +0530
Message-ID: <CAARzgwzjqgqJY4+MdHCYEKOKxxVbt_d3C-fMwKtjSSFOnw+PqQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: remove unused EMI() macro
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ani Sinha <ani@anirban.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 11:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Ani,
>
> On Mon, Apr 20, 2020 at 06:21:41PM +0530, Ani Sinha wrote:
> > EMI() macro seems to be unused. So removing it. Thanks
> > Mika Westerberg <mika.westerberg@linux.intel.com> for
> > pointing it out.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  drivers/pci/hotplug/pciehp.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> > index 5747967..4fd200d 100644
> > --- a/drivers/pci/hotplug/pciehp.h
> > +++ b/drivers/pci/hotplug/pciehp.h
> > @@ -148,7 +148,6 @@ struct controller {
> >  #define MRL_SENS(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
> >  #define ATTN_LED(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
> >  #define PWR_LED(ctrl)                ((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> > -#define EMI(ctrl)            ((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>
> Thanks for the patch!  Can you squash it together with the HP_SUPR_RM
> removal (and also check for any other unused ones at the same time)?
> For trivial things like this, I'd rather merge one patch that removes
> several unused things at once instead of several patches.
>
> I like the subject of this one ("Removed unused ..."), but please
> capitalize it as you did for the HP_SUPR_RM one so it matches previous
> history.

I have sent an updated patch few days back.

ani
