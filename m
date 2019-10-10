Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A6D224A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfJJIJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 04:09:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35651 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbfJJIJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 04:09:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so5256676lji.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2019 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chZ6Yc3njJFUucN4RPCdT+xkKIj3l+8CnJMOncb1PSs=;
        b=XTHsYauFBddM80SzhC3hLS9h+chXshuFWuR60ByQSO5/vKsyEB6Z/ZBTxvYUUgJNpR
         UCPIyHxfSEQufFX4GB28z3o/jUDM9piRsYoiKuBmUWX0j4fhGpfIYDJEmGlscetuy6N7
         3ExWwZGCWWNpA1vVWAIg4LTub6MPkrO1e8JZ5547iehKpkZzItSZKzNmBhfxylltNyj5
         9LBNkw7yTs1BuqzNB4jKIfzZKUHITksrc4hTVYYa33RBfxBxvghTld4Bxw0sDFDnnoeb
         xw0ZyOiCZmNYSWaRgpgiQw1QtL0DwPwPjaLBCC/11srfR8LvzELtHKcf7BcvnpL9Dsd2
         Ih9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chZ6Yc3njJFUucN4RPCdT+xkKIj3l+8CnJMOncb1PSs=;
        b=TSn3G69fi9L6xJ3qYk0XJtrr9cXRpSVtATKEbW8che2ab9lOyjhk9JM/PZMjJ8FxAu
         FzlIGL4qAZZl7FM23vDNlb7FSmguEaS2mohnIR+ExWUNIB+LWdP/jf+U4XjdogXK3FYH
         mf7kg+0p4dX4PpV12hODiJfFpnhK8gr4u+ovo8jszXIR8XJNILzClcl+mowqjbZ3ofAy
         yaB+hilV+UA9YKZBxzzki9hBEfGg4TWIXAB7xOGPPnO1BYtNnbMS3Q7WCwtw3zr4Ate4
         MyW5B8+VaGqYCg+i4qQR+A9o9tJBYU1VieFpU8qC7m33ek99m7+d9ceEOaO9CExu7Img
         j7Nw==
X-Gm-Message-State: APjAAAXGr3vsOttXWoirJHyL32QcCgOovYX+B3WSoYcqYHHI6Hxxp/5k
        LjCEGM5CQgvaMrbxFU8OZmbEjuWBgHRVg2Ik1yCs+dOKDu4=
X-Google-Smtp-Source: APXvYqzPtYoeqA3MaEZviybn4GsONQhDSzePzTSaGgrAbLTeVQcagiIBcAS59aV/yBbr4yGLRO/oVhiM1yuZcUNCut0=
X-Received: by 2002:a2e:b053:: with SMTP id d19mr5614060ljl.143.1570694989955;
 Thu, 10 Oct 2019 01:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191008164232.GA173643@google.com> <20191009040534.GL2819@lahna.fi.intel.com>
 <CAMz9Wg_8ZYkw1f3MyqcqNMBajJ_Q+qwojQhg8WqiPTPeUSNXZQ@mail.gmail.com> <20191009075650.GM2819@lahna.fi.intel.com>
In-Reply-To: <20191009075650.GM2819@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Thu, 10 Oct 2019 11:09:33 +0300
Message-ID: <CA+CmpXupMC5Kk_tCX8-TQESM2BQ9RFU196dzXGmpv9TcMgyb4A@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 205119] New: It takes
 long time to wake up from s2idle on Dell XPS 7390 2-in-1]
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     AceLan Kao <acelan@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 9, 2019 at 10:56 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Oct 09, 2019 at 03:50:25PM +0800, AceLan Kao wrote:
>
> > There is a new BIOS v1.0.13 on dell website, but it requires windows
> > to upgrade it, I'll try it later.
>
> OK, thanks.

I'd try to check fwupd if you haven't tried it yet.
Dell FW is usually available there.
