Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7836E844
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhD2J6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 05:58:53 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45706 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2J6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 05:58:52 -0400
Received: by mail-oi1-f177.google.com with SMTP id n184so39938716oia.12;
        Thu, 29 Apr 2021 02:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDU1vjC7awl7J2VdVrVA0TsppuCw6q3A0r6e1Mo7KBM=;
        b=UNliPv+TGN6PqJkZ85UxE6gO5k8Q21f/pMgDUDFGzTTNkXL5j/9NnGe+gVPKTfdJ6e
         I1mUYwx6lVAgxgTrHBr7D0AmFgSC+FHA61lkQjZSVFXL1EvpYl81L7pMvOUYwbahw5i2
         oYg/MoIvruB5yN+twVyYAFS1kavfoT2oX5G8g+WWCc/S74RE3laR1zGwQbqrxmqXHY2K
         239/fU5VaUdhXKc9om6AZ3dXau/ERTxB41e+1EAr9HWxuIuqcN0HuaiSW+LaCmf7bZsp
         HRa0Y+e80CRq/xb9MQx/1H9RnxtfjVHyEyK2hPJlojr/LAQ6lR+kmhW/KUyZeCgE5y70
         wNtQ==
X-Gm-Message-State: AOAM531h1MMCp9iYCmvw3ziAYblJ/Gqt6PkRJzK0lflbhCf13Zs2siB/
        /Xb6J+1N5lQeVJumWicsgGVp9wLMm5z8n4MWFKA=
X-Google-Smtp-Source: ABdhPJxWEbVseQppmpJicDpiqwHMSTnWWvJIlFsvpacjdcnVQHMd38UiTLhkwV5bzRx2vlWJPTgrUnsLeR/b5vqipFI=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr22966501oib.69.1619690284872;
 Thu, 29 Apr 2021 02:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com> <20210424021631.1972022-2-rajatja@google.com>
 <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com> <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
 <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com> <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
 <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com> <0601e45130495b152bec04eee4a50e302db4cfd2.camel@suse.com>
 <CAJZ5v0jEbjRSGPdfwvegawin5_N=m-UoP+Wa99EQ-QmkusiBCg@mail.gmail.com> <5ac7634acbe7569879234ad541879c79918f3e00.camel@suse.com>
In-Reply-To: <5ac7634acbe7569879234ad541879c79918f3e00.camel@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Apr 2021 11:57:52 +0200
Message-ID: <CAJZ5v0jF1M95MJO+gGL2rmk=rmt5u0sYR-DCJW4+Bb5WP+3W7w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     Oliver Neukum <oneukum@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 11:03 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Mittwoch, den 28.04.2021, 14:21 +0200 schrieb Rafael J. Wysocki:
>
> > In principle, in the wake of Thunderbolt every PCI driver handling
> > PCIe devices needs to be able to deal with a device that's gone away
> > without notice, because in principle any PCIe device can be included
> > into a Thunderbolt docking station which may go away as a whole
> > without notice.
>
> Yes, but we are dealing with what we export to user space, don't we?

Right, so it would be good to know why exporting this information to
user space is desired.
