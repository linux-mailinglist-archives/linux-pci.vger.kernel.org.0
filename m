Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BED18BBB8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCSP5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 11:57:42 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:37446 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCSP5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 11:57:41 -0400
Received: by mail-qk1-f173.google.com with SMTP id z25so3579177qkj.4
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oWfKkmiwPLgberwF0NAMlEnL9L1RjiTTzwBAKuAb0pU=;
        b=YzMhcuqWcvZg3dJ3oW0UkK0y3pOJvrUbTgzlhK/J9hJD7O3BMqVBytP8Y5KGiWyjeH
         alejIxq1at3wodTH7Ai5vP+AAGZ2UCU+Zr2z+CeLxNrYVGp0uD74vtaTPWHlAgYDD78q
         0rGEdiWgvay8p4ABz14iS6Nc/Q8xixvVHgZgQCF7vLeDRYeTryjjH5EQHdbpglwdv1UP
         1jxPGa9iTZCufvMrAdmK9olN52Uz5o0MLaFe1+CV1VimcZdGdkjJZ2SJZgD2snNUjcb5
         6bhG94+X7SP50zv0W3ttmPFEZeWdyXrkKmmjz5TcVrOD4vs+7CUYBcaZHXWfscpdKy4a
         tQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oWfKkmiwPLgberwF0NAMlEnL9L1RjiTTzwBAKuAb0pU=;
        b=euzCjYyH86iF1BLibI/grAfuGiC8cWv5/JMJVHakII9wWR12PCRXOhpSiMRm0SKc3j
         44+iDXmoG5yy8/WzKoBICDa+frKMRjMh1yMBXkK7wSMBZ4jVPr5gnKr3m5rq+FuRlxgO
         72Og59cRniSISg2xvVNBWEOE1WHcBmcM1LlEXth1B9kREw6AeYuiYiDNz/p72/tvaNeU
         7sWMa22og6pefDnh4fYI2TI+U/IJE7lvbJ81Wsxj4+Fu8efPDNOQkg6UBehA9Pnpk1RY
         s7uU7GkBpFWx5BOFwjZG8vV5vujyCeZWAXcoa01hkOjk6cURhbfvQLIaMiEwdyvBgL8n
         OKdw==
X-Gm-Message-State: ANhLgQ2TZHL+JvrFRA9EjIgJ+0dluvG4+XvP8xPjubWQk5DvBnLFtDFT
        PdM9nx/XF1X86vPk0iXj7g1tMsdZ5a34KSTOOtS7Zmt/
X-Google-Smtp-Source: ADFU+vvlEV+Hl9HPvSgjVV+uGWvcklayiZ0q/QiybrKatrW/vf9aw45xINgjmLGKvuq4C2clm8cCQP4cQb1yjDmXvqc=
X-Received: by 2002:ae9:edd2:: with SMTP id c201mr3338779qkg.366.1584633460191;
 Thu, 19 Mar 2020 08:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABGxfO5aN2kJd8YOhbOALw5j7Eq1-rArC_O10RQyFUUhM6YGqw@mail.gmail.com>
 <20200318150432.GA234686@google.com> <CABGxfO5Mrzx0OKpuzzc+3X2J+s1oHbxzbHpCB_FzopPp+hgw=w@mail.gmail.com>
In-Reply-To: <CABGxfO5Mrzx0OKpuzzc+3X2J+s1oHbxzbHpCB_FzopPp+hgw=w@mail.gmail.com>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Date:   Thu, 19 Mar 2020 16:57:26 +0100
Message-ID: <CABGxfO7buXERQa3M3Gf9EeGone2-q00qURGKjEUW0WTygrSHbA@mail.gmail.com>
Subject: Fwd: Linux Kernel Mentorship Summer 2020
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---------- Forwarded message ---------
From: Saheed Bolarinwa <refactormyself@gmail.com>
Date: Thu, Mar 19, 2020 at 4:33 PM
Subject: Re: Linux Kernel Mentorship Summer 2020
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bjorn@helgaas.com>, Shuah Khan
<skhan@linuxfoundation.org>, <linux-pci@vger.kernel.org>


Hello,
Thank you for the detailed explanation.

So please just to clarify, I think it will be better to ONLY set *val
= 0 when returning -EINVAL
In this case, we can just return pci_read_config_word(), then there is
nothing to reset.

Then the remaining tasks will now be to deal with the references to
pcie_capability_read_word().

- Saheed

On Wed, Mar 18, 2020 at 4:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc linux-pci because there are lots of interesting wrinkles in this
> issue -- as background, my idea for this project was to make
> pcie_capability_read_word() return errors  more like
> pci_read_config_word() does.  When a PCI error occurs,
> pci_read_config_word() returns ~0 data, but
> pcie_capability_read_word() return 0 data.]
>
> On Mon, Mar 16, 2020 at 02:03:57PM +0100, Saheed Bolarinwa wrote:
> > I have checked the function the  pcie_capability_read_word() that
> > sets *val = 0  when pci_read_config_word() fails.
> >
> > I am still trying to get familiar to the code, I just wondering why
> > the result of pci_read_config_word()  is not being returned directly
> > since  *val  is passed into it.
>
> pci_read_config_word() needs to return two things:
>
>   1) A success/failure indication.  This is either 0 or an error like
>   PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, etc.  This is
>   the function return value.
>
>   2) A 16-bit value read from PCI config space.  This is what goes in
>   *val.
>
> pcie_capability_read_word() is similar.  The idea of this project is
> to change part 2, the value in *val.
>
> The reason is that sometimes the config read fails on PCI.  This can
> happen because the device has been physically removed, it's been
> electrically isolated, or some other PCI error.  When a config read
> fails, the PCI host bridge generally returns ~0 data to satisfy the
> CPU load instruction.
>
> The PCI core, i.e., pci_read_config_word() can't tell whether ~0 means
> (a) the config read was successful and the register on the PCI card
> happened to contain ~0, or (b) the config read failed because of a PCI
> error.
>
> Only the driver knows whether ~0 is a valid value for a config space
> register, so the driver has to be involved in looking for this error.
>
> My idea for this project is to make this checking more uniform between
> pci_read_config_word() and pcie_capability_read_word().
>
> For example, pci_read_config_word() sets *val = ~0 when it returns
> PCIBIOS_DEVICE_NOT_FOUND.
>
> On the other hand, pcie_capability_read_word() sets *val = 0 when it
> returns -EINVAL, PCIBIOS_DEVICE_NOT_FOUND, etc.
>
> > This is what is done inside pci_read_config_word() when
> > pci_bus_read_config_word() is called. I tried to find the definition
> > of  pci_bus_read_config_word() but I couldn't find it.  I am not
> > sure I need it, though.
>
> pci_bus_read_config_word() and similar functions are defined by the
> PCI_OP_READ() macro in drivers/pci/access.c.  It's sort of annoying
> because grep/cscope/etc don't find those functions very well.  But
> you're right; they aren't really relevant to this project.
>
> > I am also confused with the last statement of the Project
> > description on the Project List
> > <https://wiki.linuxfoundation.org/lkmp/lkmp_project_list> page. It
> > says, "*This will require changes to some callers of
> > pci_read_config_word() that assume the read returns 0 on error.*" I
> > think the callers pcie_capability_read_word() are supposedly being
> > referred to here.
>
> Yes, that's a typo.  The idea is to change pcie_capability_read_*(),
> so we'd probably need to change some callers to match.
