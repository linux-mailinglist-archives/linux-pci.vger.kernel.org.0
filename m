Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54458F79
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 02:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1A5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 20:57:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45103 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF1A5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 20:57:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so4185544lje.12
        for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2019 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ColG6tAMdXMX0sMcY5uS4eoT6aSf9bBNC0BhjT/Dps=;
        b=FkqymYqSYyzMnl6BeJ+0JA3KpJHYhMUGxyg0//P/F1xTjwGV+Hc9nP0j5AsWIVw5TS
         2hn64vii2DskH08AM9sDw3qiDUv/WCWoxusc5AeMIj95ts7Vv60TMDrhCj/SQjBZtfr+
         p0IShO+mgPJZbNVIMebQ1ETCdkb8Kyosa6OFKhjis+06cUKGrTDtYvoqzQe+hjLHV1W9
         jSa3kCvJq0/ejTtP3/F9KrzdmtDtN3g9dan53g7+QxeK01SpIUQze4Aq5c20BRE7jJlF
         c2L5g9neQT9bl0JIoRrsWpH5jBJ8rXGU6gMlShDZWdhPxmfjynrl7l4nY+37ZO+ZRfVd
         pbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ColG6tAMdXMX0sMcY5uS4eoT6aSf9bBNC0BhjT/Dps=;
        b=PbqQvnokfBmihDfLzX/Sl1ONqprfi4apB+r8468R5N5giFLYwLU5xZHmwJsqNW46FI
         Go1cOzjfcyMr1rJwWz3E7FQabLe9cycKMmyedHeULHusGrk0S2nH8LiIrU5Kwb1DfFBA
         nvezLKJXGy8argGHhL/l3bj94bUGldnJQFi8rvUtQBlnINRo228A8Gh8sgE3alMPSmZN
         7IMhxMKpTJQckBpiVHb270jL7EQc8aQPseko+Ws4iY0x5p38+1mF/0T7QdaphhlkgIPZ
         8v/qMw98yLbH9eYFwMxDJsG1CgL9jhdVwyFAl2owE1Vgijzn3RzEH3B5buex8+m2EeZ+
         LtJg==
X-Gm-Message-State: APjAAAWtD4mEIidHd4w1HPA5xrfTVNc5weNEQp2dkdnydPkLXX0oHjFk
        MPo4XFT5/lRU0xjb8ZcrNprcuJt1JI9HhLXmCWrIbw==
X-Google-Smtp-Source: APXvYqxeqxKlbqEG0X8f8nA8BtDLRCgvi1n29E+p3mzGfmcxCq6PUxPeSNrEkhYQS+uyWX37yf29kbDBHfqvXOKSlIE=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr4294915lje.214.1561683455952;
 Thu, 27 Jun 2019 17:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190621072911.GA21600@kroah.com> <20190621141550.GG82584@google.com>
In-Reply-To: <20190621141550.GG82584@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 27 Jun 2019 17:56:59 -0700
Message-ID: <CACK8Z6FXS3VoaqxmwXCR2vnp-TSE5zGMi6Zt1w_LxskTguMw=Q@mail.gmail.com>
Subject: Re: PCI/AER sysfs files violate the rules of how sysfs works
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 7:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 21, 2019 at 09:29:11AM +0200, Greg KH wrote:
> > Hi,
> >
> > When working on some documentation scripts to show the
> > Documentation/ABI/ files in an automated way, I ran across this "gem" of
> > a sysfs file: Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> >
> > In it you describe how the files
> > /sys/bus/pci/devices/<dev>/aer_dev_correctable and
> > /sys/bus/pci/devices/<dev>/aer_dev_fatal and
> > /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > all display a bunch of text on multiple lines.
> >
> > This violates the "one value per sysfs file" rule, and should never have
> > been merged as-is :(
> >
> > Please fix it up to be a lot of individual files if your really need all
> > of those different values.
>
> Sorry about that.  Do you think we're safe in changing the sysfs ABI
> by removing the original files and replacing them with new, better
> ones?  This is pretty new and hopefully not widely used yet.

Hi Bjorn / Greg,

I'm thinking of having a named group  for AER stats so that all the
individual counter attributes are put under a subdirectory (called
"aer_stats") in the sysfs, instead of cluttering the PCI device
directory. I expect to have the following counters in there:

dev_err_corr_<correctible_error_name>  (Total 8 such files)
dev_err_fatal_<fatal_error_name> (Total 17 Such files)
dev_err_nonfatal_<fatal_error_name> (Total 17 Such files)

dev_total_err_corr (1file)
dev_total_err_fatal (1file)
dev_total_err_nonfatal (1file)

rootport_total_err_corr (1file - only for rootports)
rootport_total_err_fatal (1file - only for rootports)
rootport_total_err_nonfatal (1file - only for rootports)

Please let me know if this sounds ok.

Thanks & Best Regards,

Rajat

>
> Bjorn
