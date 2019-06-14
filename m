Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6245690
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNHmT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 03:42:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37419 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 03:42:19 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so3779237iok.4
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2019 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQ8LZODblM+N4Tgxv/Vx/JLYR0QWgL30pjQyU5T9Z7k=;
        b=d61MN0ui4Nr3LdQUczYZoW1GbBfce5WPuW85XJAbQsVc2VzpdChR+riLWW6r11KZxB
         yg3IOLzoh95RaA/8DZkOT+bXMf9kZlI4dMmL8mhTraPZhyaCOF06oX7LCR5uqNAAXgJN
         S6rthT/UKfeR1Xos+QFbt1jAwYeQ4ymyG1CfSpO1D3pEmtBUELkjtZyJh/ZnYR8cwsnN
         6T+4+ZuJWF0yzqyVx0CyNGjYsJ7U5c8mOFmotqs6dNaeKPdnZf+ljIFCT9IldFiDM/ji
         OrHRfJSMC4POv4FnJVYb4b7VS7MuE7dhm1qEwsrenV5IQwMr6YiF253wIy7ku4ikS+Am
         6anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQ8LZODblM+N4Tgxv/Vx/JLYR0QWgL30pjQyU5T9Z7k=;
        b=oB8NWstD+xRu3CyEhSfK7yBI4CpHVjs4uYL/Sm10Wf3/dgDpH45qBcFhXA6krqLouB
         KGlzOzrYdc95EfAqdbylcsBRbVcLar5EJhrJB6pZReRvICGC9No+XrTCSxgKXl2Tf24u
         8nf1AT9PlN2ZN7PtWrQ0kRs3VOY58ZE9M3lh2VIYc+ZDoXPkwk6wlBK3hijpkqY5tFTU
         s+BIc3/E9RndGm5gPDCS7TkTMfM5wJxxwEvIq8130prkNj62sWNZDxyZYoLk3vgIBbze
         aBJKXYlmoBXPkNBPdUL5jdsb7IRDybAqQzaNkPX+ZXw/1l83EEBXmmanGCS9cPNxb2Qi
         hjwQ==
X-Gm-Message-State: APjAAAWDYOrQ3/ArXW6YzMhyBa7DF1qzn/RSIgeODH+UnqNdiH6YdmT9
        0a3xWBVCCTTQ40yDJft6G76WDGVIAiQyv5Ic4EJppw==
X-Google-Smtp-Source: APXvYqx2gVmfLUq9fYnWUdyVXvs8Eyu6IOEDQyJhsEZOOwZ2zQ9n4ZMlIc6F7+6tGOcFj+COvIrNEMx8IxjCIikZX8o=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr6634725ioh.156.1560498138569;
 Fri, 14 Jun 2019 00:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
 <20190613190248.GH13533@google.com> <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
In-Reply-To: <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Jun 2019 09:42:05 +0200
Message-ID: <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 14 Jun 2019 at 01:07, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Thu, 2019-06-13 at 14:02 -0500, Bjorn Helgaas wrote:
> >
> > PCI FW r3.2 says 0 means "the OS must not ignore config done by
> > firmware."  That means we must keep the FW configuration intact.
>
> So I tried implementing what you seem to want and it doesn't make sense
> imho.
>
> I think the wording of the spec is terrible and doesn't convey the
> intent here.
>
> What is it that _DSM #5 is about ? Is it about telling us that the FW
> config shall not be trusted ? That seem to be its original intent based
> on the existing wording and the fact that "1" says "may ignore".
>
> Or was it always intended to be some kind of inverted logic with 0
> meaning that we *must* preserve what FW did ?
>

The original purpose was for firmware running on 64-bit hosts to not
create a PCI resource assignment that was incompatible with the OS
booting in 32-bit mode.

So the expectation was that a 32-bit OS would reuse whatever config
the firmware created, and the 64-bit version would be enlightened to
understand that it could reassign resource assignments to make better
use of the available resource windows, but this required a mechanism
to describe which resources should be left alone by the OS.

So I don't think anybody cares about that use case anymore, and I have
no idea how widespread its use was when people did.

> But preserving what FW did was always the default for x86 and
> Windows... It's just that we happen to do something wrong today on
> Linux/ARM64 which is to always reassign everything.
>
> The way Linux resource assignment works accross platforms has generally
> been based on one of these 3 methods:
>
>  - The standard x86 method, which is to claim what's there when it
> doesn't look completely busted and has been assigned, then assign
> what's left. This allows for FW doing partial assignment, and allows to
> work around a number of BIOS bugs.
>
>  - The "probe only" method. This was created independently on powerpc
> and some other archs afaik. At least for powerpc, the reason for that
> is some interesting virtualization cases where we just cannot touch or
> change or move anything. The effect is to not reassign even what we
> dont like, and not call pci_assign_unassign_resources().
>
>  - The "reassign everything" method. This is used by almost all
> embedded patforms accross archs. All arm32, all arm64 today (but we
> agree that's wrong), all embedded powerpc etc... This is basically
> meant for us not trusting whatever random uboot or other embedded FW,
> if any, and do a full from-scratch assignment. There are issues in how
> that is implemented accross the various platforms/archs, some for
> example still honor existing bus numbers and some don't, but I doubt
> it's intentional etc... but that method is there to stay.
>
> Now, the questions are two fold
>
>   - How do we map _DSM #5 to these, at least on arm64, maybe in the
> long run we can also look at affecting x86, but that's less urgent.
>
>   - How do I ensure the above fixes my Amazon platform ? :-)
>

It would help if you could explain what exactly is wrong with your
Amazon platform :-)

> There's one obvious thing here. If we don't want to break existing
> things, then the absence of _DSM #5 must not change our existing
> behaviour. I think we can all agree on this.
>
> We might explore changing arm64 default behaviour as a second step
> since we all agree it's not doing what it should, but we also know that
> it will probably break some things so we need to be careful, understand
> the issues and work around them. This isn't the scope of the initial
> _DSM #5 patch.
>
> That leaves us with the _DSM #5 present cases.
>
> Now we have two values. What do they mean ? As I already said before,
> the wording with "must not ignore" and "may ignore" is completely
> useless and doesn't tell us a thing about the intention here. We don't
> know why the FW folks may have put a given value here, and what they
> expect us to do about it.
>
> What we do know is that Seattle returns 1 and needs reassignment, and
> we do know that the Amazon platforms return 0 and will want us to not
> touch the existing setup.
>
> However, does 1 means "business as usual" or does it mean "reassign
> everything" ?
>
> Does 0 means "probe only" ? Or do we still do an assignment pass for
> things that the FW may have left unassigned ?
>
> Today in Linux, the "probe only" logic tends to not call
> pci_assign_unassigned_resources for example.
>
> From a pure reading of the spec, there's an argument to be made that
> both 0 and 1 values can lead to the same code that reads what's there
> and reassign what's missing.
>
> So this is a mess, a usual when it comes to specs written by
> committees, but at this stage I'm at a loss as to what you want me to
> do.
>
