Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38C252337
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 07:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFYF6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 01:58:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33815 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfFYF6G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 01:58:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so11727386lfa.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2019 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWOu4ltCHSlSabx4lD6vFk/Le+Z+5g63c65ERQbDJC0=;
        b=HXycKuoDBi26gxWlaiAXhYBT/qstKlzdqEVztWJxeShHWhDfIuOV6T59iHYXAMfZ/i
         nqEHG2Dgw9x/i6AT7NHrayc16qvBLIIKdciREANPY3DvuuDsPIMo2hAp17+2SMUR2UKZ
         2p8BshgljA8zTdRYpQu8+wNYWkwzJ+g3cQIkXElBI0zdrEH80SD0suV5lYbgGn9TIBbA
         DavKXhV6B2Uj2t+Vs7Gh/WXhjGuIIg/RvVCSyn4nUqOfqQLYC4GhCFfX0N/lL24NDUL/
         +MjL0Ook/tg+3UFhD5NRkikqMUKmol0Ii/YHbLO+mJw23n1nSzgOvUB3iCPLGYQHQtyj
         AQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWOu4ltCHSlSabx4lD6vFk/Le+Z+5g63c65ERQbDJC0=;
        b=QJZNUIbLh8gG3sxC4jBQOecHKFgzhw63la1258k0X+b8G6ybgDQmK7qYSdTO1qeJSO
         HS75dWmio4/ib7zeossNBdPqhHngLrUq0bMGUSVZfBbeQcLCHkfT7GFhbBnMnJbBfzy8
         QSFD8lF6YECRX0Yo4OHxElaYj/xt06J8ShLT41yno5u9LdUj5USLqKYYO9++HCPUMfAn
         0QZ+3zf/zKUWOIFREUuDjiKW0EwR7SeAUgkcoKw4Oap2iyS97sqtxftDHLq0Vr9DtXM8
         xhhfSnwtZjbfKsJy6MrbFBwClWgtPlHE1m9/p6ArfodEQKvcIG1FbKOTuke0AwEekqvP
         WFsA==
X-Gm-Message-State: APjAAAVTO8y7DeF1TxfLn20oaPyE1rogRC5ADE4/v9sAmxuxbxrltzBa
        RCdBRBbjcPEVLzYtz0CRPo3w/b0pgW3kZL3kznZGtw==
X-Google-Smtp-Source: APXvYqzPDZ57DP5nP6q2os/1ty3qAsTu7ST9qhQom7ugZL4iE8b3W6TB16IAP5ozn9UxmdjrwbqtXxspFegBnloZ04g=
X-Received: by 2002:a19:750b:: with SMTP id y11mr40627421lfe.16.1561442283949;
 Mon, 24 Jun 2019 22:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190613063514.15317-1-drake@endlessm.com> <20190613200344.GI13533@google.com>
In-Reply-To: <20190613200344.GI13533@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 25 Jun 2019 13:57:51 +0800
Message-ID: <CAD8Lp47LM_Z=Y=zg6SYSxMLpGCrWNxHc7i3RDtoTUuLhafK4WQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Expose hidden NVIDIA HDA controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWFydGluIExvcGF0w6HFmQ==?= <lopin@dataplex.cz>,
        zigarrre@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 4:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Is it possible that this works on Windows but not Linux because they
> handle ACPI hotplug slightly differently?
>
> Martin did some nice debug [1] and found that _DSM, _PS0, and _PS3
> functions write the config bit at 0x488.  The dmesg log [2] from
> zigarrre seems to show that _OSC failed (which I *think* means we
> won't use pciehp) and that there's a slot registered by acpiphp.
>
> Maybe this works on Windows via an ACPI hotplug event that runs AML to
> flip the 0x488 bit and rescans the bus?  That would make more sense to
> me than the idea that the Nvidia driver does it.  I could imagine the
> driver flipping the bit, but the bus rescan seems like it would be out
> of the driver's purview.

Oh, I had missed that part of the conversation. I checked on the Acer
Predator G3-572 and I was able to find ACPI code to manipulate the
magic bit, however I can't see any linkage to _DSM methods, and the
code looks like it would only be run on power-up.

I modified the DSDT to avoid the codepaths that tweak the bit, booted
Windows and confirmed that change had taken effect. Then I installed
the nvidia driver and observed that the magic bit was being
manipulated according to HDMI cable status.

So I believe the nvidia Windows driver does not rely on ACPI for this
to work. It presumably does it directly and causes rescans, as evil as
that sounds. I added more details to the bug report.

> The dmesg log also shows some _DSM warnings; are these correlated with
> cable plug/unplug?  Is there some acpiphp debug we can turn on to get
> more visibility into hotplug events and how we handle them?

I scattered a load of debug messages around the ACPI & PCIe hotplug
code but nothing gets hit. I don't think this is architected to be
handled by existing PCI hotplug mechanisms.

I don't have any _DSM warnings on this product, even after connecting
and disconnecting the HDMI cable.

Thanks
Daniel
