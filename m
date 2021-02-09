Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4616314539
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 02:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBIBEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 20:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBIBEb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 20:04:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56AC061793
        for <linux-pci@vger.kernel.org>; Mon,  8 Feb 2021 17:03:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q2so18355810eds.11
        for <linux-pci@vger.kernel.org>; Mon, 08 Feb 2021 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHdIpxdCQ1PLtC8RCv6m44jQdcXIE1TuMoRRkTZi7uE=;
        b=qwv0t5E5aZrjpce35wVglshp4JBxu39PIdgj4xdUOlLAEakgzg4b3FJbfq2HN/qqou
         9LQfGzniImvjDNMBkBJnrX1ntP72ogrewjQ2gKYoCh1o/le4FRKVGjaJxv3rSN7ZZBGU
         ND29aEvm0jt1j7a3IPInOsXrIfqP/YDjyAHvbHVpAfIfge/RjtSbj3EMVgUml+GLtD8A
         s4+rSINdnXAV0Xh58nVxnqiimSO2mDtGL34UGKW0uyWIrbcD0eh7LweXk4UOOBJfHn1d
         k46kyxjQC6/FOxYghxGOEZpmpCQBxx/22/B4ofVC4Hm3q5GScDOeGmVhJc6rCD4ZEY91
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHdIpxdCQ1PLtC8RCv6m44jQdcXIE1TuMoRRkTZi7uE=;
        b=pHbIe9Qmvr2rhGBBLdbMRB/5iWA+At4Anko3bFsw1ThbPiaGR90z25XrvFLMgjhvJk
         LS4OvoMDBY8pQTTd+ICMBiYr8KBFbWvikH9PJrG1pP63LdG7kLrZ/3zPrycf0pyhMMhj
         7EsLe1/JwtbGNG54pCUrzR7l1SvqHZy5psmYKmWirEf+Uhe8okex+FZGIVTiWmXi/tgX
         I8Gp3ZvSryhds5ujPnC0Yrmm6Fyo4y4kY2ka/kqr6qHXACpRfTR30dQWavcGCkv3SlK6
         WE5vmWL0RDB4PLn7QjY/jSnQ7xetLL6xYAc443GD8N4KXiomkh2kM/CsJTplZ8VOkaYC
         2WOQ==
X-Gm-Message-State: AOAM533r80FV5hPhF/U1qHf1ucRfuo4KrOE2XXM93zOM71k/gSgWtryn
        fEnEirKqenGFtZG9j695Wm1LwsRh/yyND2QiX2Ih8A==
X-Google-Smtp-Source: ABdhPJyHAry8BiQtZNtaMNiR4K/N57s8fu6tcUa4c1BcfO8uaRfbbIzg0j3uT3lLVTnBuEac7Ul2LjuJW6ltpn+onC0=
X-Received: by 2002:aa7:ca13:: with SMTP id y19mr20091433eds.300.1612832617860;
 Mon, 08 Feb 2021 17:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com> <CAPcyv4iPXqO5FL4_bmMQaSvmUm9FVrPv9yPJr3Q4DQWYf4t5hQ@mail.gmail.com>
 <202102081406.CDE33FB8@keescook> <CAPcyv4ix=zmQdb5sFKN-9wOZFnitHN0sSwHZJgQeaEM+=6+W1w@mail.gmail.com>
In-Reply-To: <CAPcyv4ix=zmQdb5sFKN-9wOZFnitHN0sSwHZJgQeaEM+=6+W1w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Feb 2021 17:03:25 -0800
Message-ID: <CAPcyv4hFLnY4b8a7z+rWVeayHka4BLZyXse_ExSeRWuBRxjCwA@mail.gmail.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 8, 2021 at 3:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Feb 8, 2021 at 2:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Feb 08, 2021 at 02:00:33PM -0800, Dan Williams wrote:
> > > [ add Jon Corbet as I'd expect him to be Cc'd on anything that
> > > generically touches Documentation/ like this, and add Kees as the last
> > > person who added a taint (tag you're it) ]
> > >
> > > Jon, Kees, are either of you willing to ack this concept?
> > >
> > > Top-posting to add more context for the below:
> > >
> > > This taint is proposed because it has implications for
> > > CONFIG_LOCK_DOWN_KERNEL among other things. These CXL devices
> > > implement memory like DDR would, but unlike DDR there are
> > > administrative / configuration commands that demand kernel
> > > coordination before they can be sent. The posture taken with this
> > > taint is "guilty until proven innocent" for commands that have yet to
> > > be explicitly allowed by the driver. This is different than NVME for
> > > example where an errant vendor-defined command could destroy data on
> > > the device, but there is no wider threat to system integrity. The
> > > taint allows a pressure release valve for any and all commands to be
> > > sent, but flagged with WARN_TAINT_ONCE if the driver has not
> > > explicitly enabled it on an allowed list of known-good / kernel
> > > coordinated commands.
> > >
> > > On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > For drivers that moderate access to the underlying hardware it is
> > > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > > userspace has done this, the driver can no longer guarantee the sanctity
> > > > of either the OS or the hardware. When in this state, it is helpful for
> > > > kernel developers to be made aware (via this taint flag) of this fact
> > > > for subsequent bug reports.
> > > >
> > > > Example usage:
> > > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > > - quux is convinced they really need the fred command.
> > > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > > >   - kernel gets tainted.
> > > > - turns out fred command is borked, and scribbles over memory.
> > > > - developers laugh while closing quux's subsequent bug report.
> >
> > But a taint flag only lasts for the current boot. If this is a drive, it
> > could still be compromised after reboot. It sounds like this taint is
> > really only for ephemeral things? "vendor shenanigans" is a pretty giant
> > scope ...
> >
>
> That is true. This is more about preventing an ecosystem / cottage
> industry of tooling built around bypassing the kernel. So the kernel
> complains loudly and hopefully prevents vendor tooling from
> propagating and instead directs that development effort back to the
> native tooling. However for the rare "I know what I'm doing" cases,
> this tainted kernel bypass lets some experimentation and debug happen,
> but the kernel is transparent that when the capability ships in
> production it needs to be a native implementation.
>
> So it's less, "the system integrity is compromised" and more like
> "you're bypassing the development process that ensures sanity for CXL
> implementations that may take down a system if implemented
> incorrectly". For example, NVME reset is a non-invent, CXL reset can
> be like surprise removing DDR DIMM.
>
> Should this be more tightly scoped to CXL? I had hoped to use this in
> other places in LIBNVDIMM, but I'm ok to lose some generality for the
> specific concerns that make CXL devices different than other PCI
> endpoints.

As I type this out it strikes me that plain WARN already does
TAINT_WARN and meets the spirit of what is trying to be achieved.

Appreciate the skeptical eye Kees, we'll drop this one.
