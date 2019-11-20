Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2256810399C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfKTMKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 07:10:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbfKTMKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 07:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574251806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knFBJ+jIledi9b7Ia4deKRuiHotpqtnvRJzVLFu8J74=;
        b=d3toQVBw9chDonxLM6i7c3j79isTeEwmRvYBkQA4s+zNcBqg4+7FcrJuz/MjzOxWt8sJSI
        UBHylj8TIKwAz8MrWQ8wusSxE9SAWNLODWHH55mYFYN2tvBz7BtwJipKfsppQFrrcHp4Yy
        hOmTe4jZGIhFKNKXCUTGefLS0a/n4/c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-Q1d5hAXZMDWcdbntg1vEFA-1; Wed, 20 Nov 2019 07:10:03 -0500
Received: by mail-qt1-f197.google.com with SMTP id 22so16904059qtw.10
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2019 04:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7p4rYZMTKBgx0gRU2Y/8e1TMHUDBS8YuAIk55PkbbCM=;
        b=bC0j3B+RL9W6Fzuz/IQKsmFyqPy1BN10Qdoohqiz7W5PHKTedTiLRdre+z+URN0EHS
         BHpl5IGb33m1YNG7l5TDAeGjXee7TN8FifhriDftMhzsy7kwuDNukpyAHQI9nstskYgq
         qVg1DZWvSfp9kaajTZ0feKv/YNMIjD76qnDa21YQv5ux39uQR1gatveMxUmzni4PvfR9
         7IfrbeXFfVoWQxJ/f5epYTtls5/SO86D9jPjKyOQhUOGSk7BgX9F2SAfUIayiWf9XZVC
         JReX9V4KQU/46b3Xt7J2ap/tLYmrRlMbLbCkq0SpOnjPzzfsLTo29F+eseJXwuZc5Ofu
         Y8Ig==
X-Gm-Message-State: APjAAAUxW9wPt6HYn7M2SMo67fVSv1/sNTWvaUza+MNuRQuwxj6IVvBO
        HDLKrOvOeIWXyj4XVB+AXPFHrBfc1iFJQ7rHfb+baOzHQA+qgELHiOYMCn8vk3LI29sDIIuScsp
        Z6OXXkAVxaQCo8r5ya+Jrkp3X2qGXPDzz3iB1
X-Received: by 2002:a37:9083:: with SMTP id s125mr2035562qkd.192.1574251802834;
        Wed, 20 Nov 2019 04:10:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4S4Yg7VICuKWth27RQHwQbnKmUWBvPlof4TRp3+1St7VECDM0n728MYoDSOHL10176AueXActPrjMWKfP+xo=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2035532qkd.192.1574251802589;
 Wed, 20 Nov 2019 04:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com> <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:09:51 +0100
Message-ID: <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: Q1d5hAXZMDWcdbntg1vEFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> =
wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
>
> [cut]
>
> > > > >
> > > > > Oh, so does it look like we are trying to work around AML that tr=
ied
> > > > > to work around some problematic behavior in Linux at one point?
> > > >
> > > > Yes, it looks like so if I read the ASL right.
> > >
> > > OK, so that would call for a DMI-based quirk as the real cause for th=
e
> > > issue seems to be the AML in question, which means a firmware problem=
.
> > >
> >
> > And I disagree as this is a linux specific workaround and windows goes
> > that path and succeeds. This firmware based workaround was added,
> > because it broke on Linux.
>
> Apparently so at the time it was added, but would it still break after
> the kernel changes made since then?
>
> Moreover, has it not become harmful now?  IOW, wouldn't it work after
> removing the "Linux workaround" from the AML?
>
> The only way to verify that I can see would be to run the system with
> custom ACPI tables without the "Linux workaround" in the AML in
> question.
>

the workaround is not enabled by default, because it has to be
explicitly enabled by the user.

