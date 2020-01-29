Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1448A14C46E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 02:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgA2BcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 20:32:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40567 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgA2BcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2020 20:32:20 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so16730938iop.7;
        Tue, 28 Jan 2020 17:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OINYauu/FMq3XOWWth+EZlBMMQYby1FB2lj9pkceckU=;
        b=DAqfA2Q2IZOL2p+2+8mDc/eHucTMeIe195YcmRbXqZPEQ1BUrWJYhTKOc45wFCj9ws
         qbFljs2PdS4QccbtjDeRr/7+YuC89DjKx7uQZF1J2oq7VpqynyNalFg6ZtDfK+7RuS3R
         md1a3GGnY9KMsn7gylymfHEXOE1Ny6CEuhGalSwdeX1bajGEraP7Kl15ewD3IypqbYpA
         epvg5KOjAvhjqPuPbopUTfxjXQCHv6uc2O84Bu3Sh5nxujCgLg21xyUkSJoEjgbWMNLE
         IHTLPOOU7viAze8jUrPhhh6niIsEKPJB8qwKXsqEyqIgAiUdtV70gykK/66fJQVHHmJA
         Yx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OINYauu/FMq3XOWWth+EZlBMMQYby1FB2lj9pkceckU=;
        b=VhPVF/ePIVbfwYR8PzLEXomGgBIqHttNQ0Xk5qjDn2oVxIH9l25rgZH0jDh7taW9P2
         EXzU9OFEn3XJ0EwrkBdNhjbEVEyxTgfzdaRlUdPcp9LPP4WMkSyhIDl/ah1vCwpTF7SW
         BPTKVN0fiiO2Bw0YCKShF/zqVaW24s8rnfvGuGn6oDrFUroNBhQqjj/m0iCy1W77Kuos
         mEf2+40qgXgqL7O3o7jmnzInMbNtRTr1DBEZbpSRg7Re5l9dDDLu2CP9kK6qvhyYZzJd
         u6SSio9Nj/trrWQTFdTVMj1YjH9bvKZAiICcjrExzdZcADY0YiRBtc0t35E9GLbUtkWf
         HMkQ==
X-Gm-Message-State: APjAAAW8dJK5xzpq9WevC3rOty6tvdK4FdI4QRnd0ezWAAx5HK1zJuqN
        jEoNohoIP13CCI+yJCb8c8h4EiJvI8dAJnntFy8=
X-Google-Smtp-Source: APXvYqyjDYSrA853V/qdJsqhISgAYNfOdiEApwa11SxBrKEwiNeyKkuwVJIZChAAe9De33mzBsnHuRnoewo1Vkt9BBY=
X-Received: by 2002:a02:3508:: with SMTP id k8mr15363989jaa.114.1580261539263;
 Tue, 28 Jan 2020 17:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20200124144248.11719-1-yu.c.chen@intel.com> <20200124193142.GA33298@google.com>
In-Reply-To: <20200124193142.GA33298@google.com>
From:   Dan Williams <dan.j.williams.korg@gmail.com>
Date:   Tue, 28 Jan 2020 17:32:07 -0800
Message-ID: <CANTgghm_ZC29PF3m-7u74RWU0LiKOcodf-CqhSzsQPdu05qrJg@mail.gmail.com>
Subject: Re: [PATCH][RFC] PCI: Add "pci=blacklist_dev=" parameter to blacklist
 specific devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 24, 2020 at 1:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jan 24, 2020 at 10:42:48PM +0800, Chen Yu wrote:
> > It was found that on some platforms the bogus pci device might bring
> > troubles to the system. For example, on a MacBookPro the system could
> > not be power off or suspended due to internal pci resource confliction
> > between bogus pci device and [io 0x1804]. Another case is that, once
> > resumed from hibernation on a VM, the pci config space of a pci device
> > is corrupt.
> >
> > To narrow down and benefit future debugging for such kind of issues,
> > introduce the command line blacklist_dev=<vendor:device_id>> to blacklist
> > such pci devices thus they will not be scanned thus not visible after
> > bootup. For example,
> >
> >  pci.blacklist_dev=8086:293e
> >
> > forbid the audio device to be exposed to the OS.
>
> I'm not really a fan of this.  I'd rather see some details about what
> the problem is so we can actually fix it.
>
> Ignoring the device doesn't mean the device is removed or even
> inactive.  It may still be consuming address space that we need to
> avoid.
>
> Can you point us to bug reports about the issues you mentioned?

I'm not sure which issues Chen Yu is referring to, but a proposal like
has come up before [1], and didn't go anywhere.

I think this is useful to people doing new / pre-release hardware
bring up, but it's unlikely that such hardware makes it into a
production to make this feature useful upstream. Hardware bring-up
efforts can just use local hacks to workaround problems, if broken
hardware actually makes it into production it needs precise quirks to
be developed/applied.

[1]: http://lore.kernel.org/r/1506544822-2632-2-git-send-email-jonathan.derrick@intel.com
