Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6930D08C9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJIHuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 03:50:37 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38029 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJIHuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 03:50:37 -0400
Received: by mail-vs1-f66.google.com with SMTP id b123so901602vsb.5
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2019 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YY/YXX/1v3xZummjUGVUE1tjCRSNtX/ieC2OTqXujxM=;
        b=N9S3gVRKVyOg8j/nvdH3wATar8wd4Ukw8WYWmZHPw0TPmdyabqeiZrRPWOXLzhPJ3m
         MJ3eZg1Bkd+//wUbnEoqWmI/tj5xy3Vfks87/FDwmEgiG5D2Pytof87IgSaVFEIDQiYu
         XpN85XPe7LBCn0dyNBsVLX3ZS2smYPcSXe9giVxfWszGCqsNyLg2QXmHGUP27QR0911W
         thRvQG1C8BYHBarOr2dzm1dpHx5PsWU7Rx5qoqujbFZiRCWIBvCCSV+qkv2EUHM9mPvF
         VDfUsLcEJl+q7aYPD445nDFLe3Jbm7oXVHBmtoPDwzCWyyYxxLju+95bKyqFL5DrkAy3
         6Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YY/YXX/1v3xZummjUGVUE1tjCRSNtX/ieC2OTqXujxM=;
        b=VwroibdSkZBoIzNEOq5d0j4TUbb3a7GCke9Yf8iUjPjBamgqWXcLbGXTjvxRjzGweW
         +Zj1Nf/vGo5R1paWF8z73F012+HZOTv01ZHxLE+FQTO+54wU2lQhaQSpC2hKqn2KR1On
         u9uK+26VhDMlauxDT2IjWdtcmGyL3bRf/NxHO8U3I8ODOfasVzsTd5rBp9eby6cHJeep
         uXe1d6XkTVAjph3g3s2mwOoAzlB0iX6EH7SOGIIdA9XnGyvmABv3TZqyVAq8QqA4Amsh
         X+JnJPcPRqxzC0+f91she/9B52jdrkhdCX6+Vlm5vyMFXH2XQUkQDev7KBUYqjBd6Teh
         alGw==
X-Gm-Message-State: APjAAAUDQmaS6VlGXexMIJuIzIZj8jhxdZwY3tvQAqmDhx6dqpZLzAyI
        3Ux4h7+404Njh/FOkai598tsBx/mSWk88MPeOIw=
X-Google-Smtp-Source: APXvYqwszwcY6bwEzSi6tBYnezspogNTriMWbvWgwnarxdoHLP1V2SIVg3tXG7cL1q4Qz3Agha8O6t+3oshl/Id27ws=
X-Received: by 2002:a67:c783:: with SMTP id t3mr1063447vsk.113.1570607436496;
 Wed, 09 Oct 2019 00:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191008164232.GA173643@google.com> <20191009040534.GL2819@lahna.fi.intel.com>
In-Reply-To: <20191009040534.GL2819@lahna.fi.intel.com>
From:   AceLan Kao <acelan@gmail.com>
Date:   Wed, 9 Oct 2019 15:50:25 +0800
Message-ID: <CAMz9Wg_8ZYkw1f3MyqcqNMBajJ_Q+qwojQhg8WqiPTPeUSNXZQ@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 205119] New: It takes
 long time to wake up from s2idle on Dell XPS 7390 2-in-1]
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Right, the issue happens after we backport some ICL thunderbolt
patches to 5.3 kernel.
There is a new BIOS v1.0.13 on dell website, but it requires windows
to upgrade it, I'll try it later.

Mika Westerberg <mika.westerberg@linux.intel.com> =E6=96=BC 2019=E5=B9=B410=
=E6=9C=889=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> Most likely not a regression as Ice Lake support was just added in
> v5.4-rc1.
>
> @AceLan, I've seen similar issue before and that was fixed by a BIOS/FW
> upgrade. Can you check if there is newer BIOS/FW for that system and see
> if it helps?
>
> Let's continue debugging on bugzilla.
>
> On Tue, Oct 08, 2019 at 11:42:32AM -0500, Bjorn Helgaas wrote:
> > AceLan, do you know if this is a regression and if so, when it was
> > introduced?
> >
> > ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> >
> > Date: Tue, 08 Oct 2019 02:56:27 +0000
> > From: bugzilla-daemon@bugzilla.kernel.org
> > To: bjorn@helgaas.com
> > Subject: [Bug 205119] New: It takes long time to wake up from s2idle on=
 Dell
> >       XPS 7390 2-in-1
> > Message-ID: <bug-205119-41252@https.bugzilla.kernel.org/>
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D205119
> >
> >             Bug ID: 205119
> >            Summary: It takes long time to wake up from s2idle on Dell X=
PS
> >                     7390 2-in-1
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 5.4-rc2
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: acelan@gmail.com
> >         Regression: No
> >
> > Created attachment 285395
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=3D285395&action=3De=
dit
> > dmesg log
> >
> > 1. Enter s2idle at 28.39s
> > 2. Press power button at 246.10s
> > 3. The machine stuck until 412.30s and spit out thunderbolt warning mes=
sages
> > 4. thunderbolt port keeps working after s2idle, plug-in Dell WD19TB
> > dock(472.45s), and the "boltctl list" shows the dock info correctly.
> >
> > BTW, I also found that there are 2 tbt ports on the machine, and if I p=
lug in
> > one TBT dock, and the wakeup time could be reduced by 80 seconds. And i=
f I plug
> > in 2 docks in both TBT ports, the machine wakes up from s2idle quick en=
ough as
> > the normal system.
> >
> > I believe the 2 lines are related.
> > [  330.388604] thunderbolt 0000:00:0d.3: failed to send driver ready to=
 ICM
> > [  412.308083] thunderbolt 0000:00:0d.2: failed to send driver ready to=
 ICM
> >
> > --
> > You are receiving this mail because:
> > You are watching the assignee of the bug.
> >
> > ----- End forwarded message -----



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
