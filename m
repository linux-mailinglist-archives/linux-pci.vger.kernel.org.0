Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779D01FBF01
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgFPT2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgFPT2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2020 15:28:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B4C06174E
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2020 12:28:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y11so25025107ljm.9
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2020 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+QuAOUfD+yaHMOx7JS6V2Ec/laXvrlFy0R9vzQGqF4=;
        b=QOMab6ZBai8eX39llL4QAiuIVWOQ0kfvL9ywteJNjgzhCzjyOqdlLEs34RuWRfNLLY
         UBmJ+sjmxHSY9KClbzPYRcmHfIbDr3RgcQIUrbh/HgB4x65p5TjwXtES2J8FIy5PzqLb
         qNhgVYP39gDxMPl9bQhhUq4S3zMv9UfF/pmETt8VJF4G41Qcz/1zK2PnlCpJF0fz/S6h
         PxHy+BSAWFuylkqNZeMw7xFvJ8qR/7v1dKWfEPia1fKfpNNvfy691K7fCJ3W9iR5AH/V
         gFeKsPsrdm5Ge3TmLS1y0qxW2m4XjgJOTWFoy9c831CRjVEIM34ATLROHfUGg4Z8jDHa
         f9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+QuAOUfD+yaHMOx7JS6V2Ec/laXvrlFy0R9vzQGqF4=;
        b=a0K5Y+vR1Q6tH5IcTfN6WVZ5Tm2+LHdwyWcZ9blntsfdZ8yONpEx367Ki2f1Y3YyFM
         PoTtouy1aVyo09WqwoGk3DvfUbIhbftA2dT2Gdeztu02SHmB2zEJdMLkxVaVTz6CzQD6
         iXx2uH+dcq1dgxAMbUMzxlT8/amythpTN87EPxDCZa+tlDs9Zh8jtiR7fa/6FEQBhf3Z
         NVKAnHnpOcM6qj68D6DKCIR6g5mlGNDRnnsjxlLIYTo1OhGZOyvIaww8ijGEbBQ53SUW
         D3h+IEHZDpHXQkBgRC1/Q4HHSySj4DJXG2jfqpJQYx7F8145Vnv0ZJielmkrZpDN7IoK
         uSsg==
X-Gm-Message-State: AOAM531uVaG5jSwcYlsWOLoy4Y3oOPAZyKrr9MygqdD3fH2+VrEiLGCu
        UHAx7vOXoFDHT/090N+pSF6zSuPvQhbskgGk9DcZlQ==
X-Google-Smtp-Source: ABdhPJx83rVoJ1GBvQYrxBN8PD8VfhKiX7Lt1xY67EOoosPeSf9MmyLDKhdSIeUD5mQ+yLl+8Gvp2zP5Y6zZkNEG/uk=
X-Received: by 2002:a2e:908f:: with SMTP id l15mr1993656ljg.307.1592335693925;
 Tue, 16 Jun 2020 12:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com> <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
In-Reply-To: <20200616073249.GB30385@infradead.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 16 Jun 2020 12:27:35 -0700
Message-ID: <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 12:32 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jun 15, 2020 at 06:17:42PM -0700, Rajat Jain via iommu wrote:
> > This is needed to allow the userspace to determine when an untrusted
> > device has been added, and thus allowing it to bind the driver manually
> > to it, if it so wishes. This is being done as part of the approach
> > discussed at https://lkml.org/lkml/2020/6/9/1331
>
> Please move the attribute to struct device instead of further
> entrenching it in PCIe.

Need clarification. The flag "untrusted" is currently a part of
pci_dev struct, and is populated within the PCI subsystem.

1) Is your suggestion to move this flag as well as the attribute to
device core (in "struct device")? This would allow other buses to
populate/use this flag if they want. By default it'll be set to 0 for
all devices (PCI subsystem will populate it based on platform info,
like it does today).

OR

2) Are you suggesting to keep the "untrusted" flag within PCI, but
attach the sysfs attribute to the base device? (&pci_dev->dev)?

Thanks,

Rajat

>  I'm starting to grow tired of saying this
> every other week while you guys are all moving into the entirely
> wrong direction.
