Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E314A53A0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 01:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiBAAAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 19:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiBAAAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 19:00:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B549C06173B
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 16:00:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t32so13721353pgm.7
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2w+PybZGj1Pt9zwKncrlYIefOTBGfgydX9Jj0viB1o=;
        b=wmUftE29XD1cDjU2mgt+TtdTRcVStkpoChebeK06YjxXDFn3MLM97GInA/Gu6+SXYS
         DhG8N7qdCycIXw3pXmtttGD6SZm85zuJ+aN1ueV6yTp+qZJBcFCodkuIPa+8rN6xPVpB
         dPw7rP6k7+X6a5IsGq+5ssrW1VpAHMdmz+PjiCCFaoc5ME42lBpONkSbFVxyYruu94hT
         j7RO5t1DKQ1G8fQhhgWU26Pg/xB584tAzvTNpQG5Zz4Tz1zvd7dHJMaeQvdFrm/j46uw
         mMPe7o/aUCvpdXNIhJnFAANBBS64dYM+b1TnKfkCVLMeFgMEcP78hDZHkk1c1MNj/Wv1
         h0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2w+PybZGj1Pt9zwKncrlYIefOTBGfgydX9Jj0viB1o=;
        b=2mQlqdEKe0hqYRYDQqAuyQsGkOI50EGYxiSk6KfHoLXwUdCpyZMTTxQDOzwTQnQ5LK
         G3iqj9qtgbLU9LkOmvaZHvQwNIn3vvh8xj6MU9U0ylGdzukiHnfNZiNCJbGpgi7nMW5u
         Six02BsN7WkFw9Iahix5AfAIUj+w5orI09A9sNzOrpya3qKBOAhhFrV8o7uPNcBJ8nHm
         9307XGmcGOGW9SvsOHW8DvbZCDL/wOvRH6FIfk8RUR4833SWSdXeEjNCORMhRnFzbkH2
         WRkkUaOWs1+oBEevFGtwqFbx2ByJ22TxOn5BGUYZWLN12VntIfRaadFhlfG5F1spJrDK
         +Q7A==
X-Gm-Message-State: AOAM532BjfzFvKDpiD5A7ezvKw2mHMcLVbv/11GSvD1WSWCuPXUm9qiv
        IpcbDdgqzpLgX/GXduCrTpioGZUDIRiuBkaK2cJSTg==
X-Google-Smtp-Source: ABdhPJwu7flVE67Zd28ydBqsaVlXmqVhbsBjuDcQx7XQgSdNuJ71Ra9vq5CV/TY0xTtPZK8VxEMd4grPCznabbW55PA=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr18413808pgd.437.1643673614974;
 Mon, 31 Jan 2022 16:00:14 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298422510.3018233.14693126572756675563.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131162251.000023fe@Huawei.com>
In-Reply-To: <20220131162251.000023fe@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 16:00:07 -0800
Message-ID: <CAPcyv4hcE+4Vt1KZ4HB74ScSt9rEF4HO_TX+H1KyMN=ew=EOzg@mail.gmail.com>
Subject: Re: [PATCH v3 20/40] cxl/pci: Rename pci.h to cxlpci.h
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 8:35 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:30:25 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Similar to the mem.h rename, if the core wants to reuse definitions from
> > drivers/cxl/pci.h it is unable to use <pci.h> as that collides with
> > archs that have an arch/$arch/include/asm/pci.h, like MIPS.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Does this perhaps want a fixes tag?
>

It doesn't need one because it's not until this set that the
drivers/cxl/core/ reaches out of its own directory to include this.
