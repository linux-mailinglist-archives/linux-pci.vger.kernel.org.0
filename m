Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009034D560
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhC2Qqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhC2Qq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 12:46:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BC5C061574
        for <linux-pci@vger.kernel.org>; Mon, 29 Mar 2021 09:46:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so20478459ejc.10
        for <linux-pci@vger.kernel.org>; Mon, 29 Mar 2021 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgBMGmQCGLl4y6Xk9OO++PqGivhTIXsjSzI0EdEG61Q=;
        b=ywebtNJMhasTzI8DQPJIXLfRgTk6bwco/TQMbndr0OHObnM7O4Y9kwZmHtl5ok9xP0
         XcL279cusq6h6HSkXzoTCy7glcdQwu5mqlM9Whhche7cFxk/LefL5r+5I789+WbABUkL
         FJ3yWGVK1eTB70vLHW8r2spfIOa5lxvZeaFGZ+br9VkfDBRHvGmHcHClJ3TDlztK2ucS
         BvQtl+0wzNI3PqOaFGvsso3W9KsFm9MolKUfy7Cy3pPJ5VhtFOd4eJETkqcPRJgfVzM2
         t2xATKb8hI0+gWjDzCXpHVkBv9yOs++/HvjuymdxdgP+7vqRBHI0AnQvQTuVdDV1Fsw9
         LA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgBMGmQCGLl4y6Xk9OO++PqGivhTIXsjSzI0EdEG61Q=;
        b=Qs5QAszGon6YNmPIRuUZurerk6nUa6tuNStzFpGeYtdHxvnSVFZIccO+cUXGTioaT7
         0GVwxtOT4CsRlZSv2y9PAztYv2LHH06yCkpbuAy/Az/WN6831fkcostAyu/woGUNxt2c
         jyt3xUU3JMuSQjb1yK20zDnyQ9E2yBjIyhKmWTKVp34VfEJB9mnSR5Tc51V/7koVqg2C
         83alXtiaKzuYlDaoaKbANen/jtTGOF/1EUdEi0kflY6YHJvhzIb5XMovBmW/Zutzl8XL
         RvpRjVv2Vmo6ICBzNOrtgDbSRtf7M1mWuTmEx6YIQ/i0Alpj4xWuuVlBeje12E+oMqiw
         SQtw==
X-Gm-Message-State: AOAM531LNwa0F9ML6sLY2OMaSsJ2zG1jThMUq474OXPrT6rgsFOALy2C
        ySffIMWn1zjuTnJcWv01vyC0YKMSUo00ATjo/Cq7kg==
X-Google-Smtp-Source: ABdhPJzM8tKMUpgAHNhszW8yS9QPi/vZay9sCsuzF863VZX/60gCgs+uBmeN2eQ1xy1gyMqOoQvxrR52qchgf1xmAjI=
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr29091143ejc.45.1617036387736;
 Mon, 29 Mar 2021 09:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210326161247.GA819704@bjorn-Precision-5520>
In-Reply-To: <20210326161247.GA819704@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Mar 2021 09:46:15 -0700
Message-ID: <CAPcyv4h_c46tBpemKksciHL4DWu356h7T8A-0eHKUW9H3CZkKw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config regions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 9:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christoph]
>
> On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > configuration cycles. It assumes one initiator at a time is
> > reading/writing the data registers. If userspace reads from the response
> > data payload it may steal data that a kernel driver was expecting to
> > read. If userspace writes to the request payload it may corrupt the
> > request a driver was trying to send.
>
> IIUC the problem we're talking about is that userspace config access,
> e.g., via "lspci" or "setpci" may interfere with kernel usage of DOE.
> I attached what I think are the relevant bits from the spec.
>
> It looks to me like config *reads* should not be a problem: A read of
> Write Data Mailbox always returns 0 and looks innocuous.  A userspace
> read of Read Data Mailbox may return a DW of the data object, but it
> doesn't advance the cursor, so it shouldn't interfere with a kernel
> read.
>
> A write to Write Data Mailbox could obviously corrupt an object being
> written to the device.  A config write to Read Data Mailbox *does*
> advance the cursor, so that would definitely interfere with a kernel
> user.
>
> So I think we're really talking about an issue with "setpci" and I
> don't expect "lspci" to be a problem.  "setpci" is a valuable tool,
> and the fact that it can hose your system is not really news.  I don't
> know how hard we should work to protect against that.

True, the threat is smaller than I was reading, I apologize for that
noise. Temporary blocking over kernel DOE cycles seems sufficient for
now.
