Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5C30104A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 23:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbhAVWsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 17:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbhAVWsI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 17:48:08 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C6C061788;
        Fri, 22 Jan 2021 14:47:25 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id p5so7783548oif.7;
        Fri, 22 Jan 2021 14:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q724GeiTZ+Om7tqqLffblQ1ndWRdcUnxMTkOY/r9LV0=;
        b=j8K/vK8BkLu/zwpyBR/iOViwsj4WuRlN6z/AFKftqheEoL6P4Hec0aQ9XMV30hxj7T
         AK00ssHVDIbiVsZwNo4+t/9lZ30eoqo5O6yghyYNCulQzZ5NIIqNK2Yep1Ga6PGxZBGp
         yU6BADWYtFbpG+MHdq5syt0nTX9K7SbphvTTI1FkCqpTUb9HSmffNa37rjaTnAJzT0hC
         rN37id4oLFvwR/A35WoLGkDmPS5289wwK8UoyK9M9KKOLyEDoFtmPPMr97c+RGvGjstV
         GMhjpxquN6Io88wzxMTld2CCP6xO+J96dlHCWG7mqGh0Y7okTOo/OumNerE1AsjTPVQr
         P4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q724GeiTZ+Om7tqqLffblQ1ndWRdcUnxMTkOY/r9LV0=;
        b=NvEYBGjHQX1iBxI33gmeGawNm9Lvn0lrqbDlD514X5zXtdhpZc2ETA39kzGgVh+NQr
         mj2/wyasXoTygRuRovMAZMA1IRA7UUc2u9y29/yF4YauN9PO8lre8y4aqCte8Ss/vmAv
         NI+Qmn0nzzugKwq6v1ziXYfA4pCZ6ZdWUolbv9I1ArP2iMPMlPI73hkhrwvz8Vnjsf01
         3805W1o+g5NgfNOVi/5au3y9TMrbbTehShx0jLhO93CKrbYA8mhj1MlldSL45FYTwmiK
         Hp9tfOK+pgyBhKmnvb/SiCYeRCKgVIwdNl0gLC1rrhG608qhz2B4uHgR36IF/OgK2rdx
         1oTw==
X-Gm-Message-State: AOAM532a1M3hkMEKcc2vrz+y62XuGVFW2gE6c8kaiVw1KTIfjL/nBcwX
        P7NisM+E6hDmrD6L1XZhza+cgmdBhWtyh5e7ZT69zsNh0Iw=
X-Google-Smtp-Source: ABdhPJywynaQDmXIEi1I44xi2hpkoAljmwB2nwmkzp9D4mgqsQTo0OHTrvq7nGhnp5LSTv3Yqfemt1FU8t9y9yiJSNA=
X-Received: by 2002:aca:b755:: with SMTP id h82mr4598175oif.5.1611355645094;
 Fri, 22 Jan 2021 14:47:25 -0800 (PST)
MIME-Version: 1.0
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Jan 2021 17:47:14 -0500
Message-ID: <CADnq5_P7HbKxUC7BoVEhjA2F7puTT471bYZgiHHnkfP2UN9fPg@mail.gmail.com>
Subject: Understanding DPM_FLAG_MAY_SKIP_RESUME and DPM_FLAG_SMART_SUSPEND flags
To:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, I'm trying to understand how these flags are supposed to work.
What I'd like to do, is when my pcie device runtime suspends (d3cold),
I would like it to stay off during system suspend and resume and on be
turned on again if the user accesses the device which would cause it
to be runtime resumed.  Runtime pm works fine on the devices, but they
get resumed on system suspend and powered back up on system resume.
The driver provides the following pm callbacks:

static const struct dev_pm_ops amdgpu_pm_ops =3D {
        .suspend =3D amdgpu_pmops_suspend,
     .resume =3D amdgpu_pmops_resume,
    .freeze =3D amdgpu_pmops_freeze,
    .thaw =3D amdgpu_pmops_thaw,
        .poweroff =3D amdgpu_pmops_poweroff,
    .restore =3D amdgpu_pmops_restore,
        .runtime_suspend =3D amdgpu_pmops_runtime_suspend,
        .runtime_resume =3D amdgpu_pmops_runtime_resume,
        .runtime_idle =3D amdgpu_pmops_runtime_idle,
};

I'm having trouble parsing the last few paragraphs in the pm
documentation (https://www.kernel.org/doc/html/latest/driver-api/pm/devices=
.html).
Ideally once the device is runtime suspended, it would not be powered
up again until someone accesses the device and it runtime resumes with
possibly multiple system suspend/resume cycles in between.

"If that function returns true, the driver=E2=80=99s =E2=80=9Cnoirq=E2=80=
=9D and =E2=80=9Cearly=E2=80=9D
resume callbacks should be skipped and the device=E2=80=99s runtime PM stat=
us
will be set to =E2=80=9Csuspended=E2=80=9D by the PM core. Otherwise, if th=
e device
was runtime-suspended during the preceding system-wide suspend
transition and its DPM_FLAG_SMART_SUSPEND is set, its runtime PM
status will be set to =E2=80=9Cactive=E2=80=9D by the PM core. [Hence, the =
drivers
that do not set DPM_FLAG_SMART_SUSPEND should not expect the runtime
PM status of their devices to be changed from =E2=80=9Csuspended=E2=80=9D t=
o =E2=80=9Cactive=E2=80=9D
by the PM core during system-wide resume-type transitions.]"

The last sentence is confusing me.  Why would setting
DPM_FLAG_SMART_SUSPEND change the status to active?  Wouldn't still be
suspended?

"Likewise, if DPM_FLAG_MAY_SKIP_RESUME is set for a device, its
driver=E2=80=99s system-wide =E2=80=9Cnoirq=E2=80=9D and =E2=80=9Cearly=E2=
=80=9D resume callbacks may be
skipped while its =E2=80=9Clate=E2=80=9D and =E2=80=9Cnoirq=E2=80=9D suspen=
d callbacks may have been
executed (in principle, regardless of whether or not
DPM_FLAG_SMART_SUSPEND is set). In that case, the driver needs to be
able to cope with the invocation of its ->runtime_resume callback
back-to-back with its =E2=80=9Clate=E2=80=9D and =E2=80=9Cnoirq=E2=80=9D su=
spend ones. [For instance,
that is not a concern if the driver sets both DPM_FLAG_SMART_SUSPEND
and DPM_FLAG_MAY_SKIP_RESUME and uses the same pair of suspend/resume
callback functions for runtime PM and system-wide suspend/resume.]"

The last sentence here is confusing me again.  I'm not following why
it matters if the callbacks are the same.  Why would the suspend and
resume callbacks be called at all.  Wouldn't it just be the runtime
variants?

It's not clear what happens with the suspend and resume pm callbacks.
The documentation only mentions the early/late and noirq callbacks.
Is the idea that the driver should not use the suspend/resume
callbacks in this case if they want to skip system suspend/resume in
favor of the runtime variant?

Thanks,

Alex
