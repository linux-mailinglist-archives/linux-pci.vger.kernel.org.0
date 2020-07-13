Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1673221D75A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgGMNik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:38:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32985 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgGMNik (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:38:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id h13so9538159otr.0;
        Mon, 13 Jul 2020 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKVN/vPe7K4KAMz4mV6RUquQjBtyPJmIcfvA3qAlRAg=;
        b=pa1qalYb4F6H1MEVRALkMOLfFLy8DVj9s7PDLEhmqZO7pYWqJ2N/1XjY1fVaC269V5
         pyZFHcstUwO3EYlie4OX6XeoydOc+NENvMIUk8zETan77aie3D4jgWCwVY+IPU87xif3
         cryrdIY0tEc54nKjeswsDOVkO83BWntEcJ+M7F8iddurbaYhIwjwEAbDETDbki4H7O+a
         Nv991qH30GV7bzQcWZTtK+D7DX9t7lq7dBtFWoV4UyUi7U30XkjIunQSSbf9zzXGr7w/
         tp0swGV68klU6SH2uDZTDdKCLdjSqNm7k2NlgpmFNsbAN8oxRbWN2Fdag0z/5qi2r5JY
         cheQ==
X-Gm-Message-State: AOAM532WtWJSHXaYMEO9DgMHeCk0csOHGY4RQxa5htxb8nzwAF4/D2zn
        pUmCuChRvApauGb/FeRH49/fFTHID2ppYfS3OhQ=
X-Google-Smtp-Source: ABdhPJx5RnHa1Hn3aY+ZT8/nBrdKWD3bRcHrN7T59vVK7NLNelgqWLY78QK/j9BNBSrOKrq6+JIbCsZd5oOldQKXQ90=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr50825589ota.167.1594647519410;
 Mon, 13 Jul 2020 06:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200622120527.690-1-shiju.jose@huawei.com> <20200622120527.690-2-shiju.jose@huawei.com>
 <05c8916f4f85421f871e9cbff112512b@huawei.com> <CAJZ5v0gfpsejvNAOso2ODqLdSBCZFe=mV32BtTr6aZ2-C=X-BA@mail.gmail.com>
 <9a5b81441f7149f8bfc4e65a4309a2c5@huawei.com>
In-Reply-To: <9a5b81441f7149f8bfc4e65a4309a2c5@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jul 2020 15:38:28 +0200
Message-ID: <CAJZ5v0jXV6MCxoYk7h2vVzvraFeyeWUhEarNK2R02Kb9pscodg@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 3:33 PM Shiju Jose <shiju.jose@huawei.com> wrote:
>
> Hi Rafael,
>
> >-----Original Message-----
> >From: Rafael J. Wysocki [mailto:rafael@kernel.org]
> >Sent: 13 July 2020 12:18
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> >kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
> >bp@alien8.de; james.morse@arm.com; lenb@kernel.org;
> >tony.luck@intel.com; dan.carpenter@oracle.com;
> >zhangliguang@linux.alibaba.com; andriy.shevchenko@linux.intel.com;
> >Wangkefeng (OS Kernel Lab) <wangkefeng.wang@huawei.com>;
> >jroedel@suse.de; Linuxarm <linuxarm@huawei.com>; yangyicong
> ><yangyicong@huawei.com>; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
> >Subject: Re: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
> >(vendor) CPER records
> >
> >On Mon, Jul 13, 2020 at 10:35 AM Shiju Jose <shiju.jose@huawei.com>
> >wrote:
> >>
> >> Hi Rafael, Hi James,
> >>
> >> Can you help to merge this patch because I added and tested all the
> >suggestions from James.
> >
> >I could apply the [1/2] in principle, but I need an ACK for the [2/2] from the
> >PCI side.
> >
> >That said, it looks like the [1/2] is a James' patch that you are sending with
> >some changes made by you.
> James added following changes on top of the original patch(V10) by me,
> [ Removed kfifo and ghes_gdata_pool. Expanded commit message ]
> I had confusion how the S-o-b tag to be added for James's changes in the V11 patch posted.

So James should have sent the patch with his S-o-b under it.

You cannot add S-o-b for somebody else to any patches.  You can only
add your S-o-b to somebody else's patch if you have made any changes
on top of the original.

In case you want to make a record of somebody else's contribution to
your patch, you can use the Co-developed-by tag.

Thanks!
