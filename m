Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC37420B265
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgFZNXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 09:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 09:23:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2495AC03E979;
        Fri, 26 Jun 2020 06:23:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y10so9382104eje.1;
        Fri, 26 Jun 2020 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f/WHbYA2W20EwH5kFJ5YtsYLV87jgfdE0G0OEkksJgM=;
        b=vJr55CPP9ghu7eziCHZ7T8FqTzEPK6kNCG+/QMQ/QYsKeU95+tfbsNnzHDZmJ+ANkk
         +JnKH/aIDEV+s/REmPj9h5TPin7ZpKrfXtyfQa315vyCGTq34ozSCWI/mFAEKDv9+niy
         5YPMt09FQtFsOg96NxvN2jDML0K0NSrFu/QQw3Wf8inRHGlMxuNgT6wPwCSDsXiW9gb1
         9yz0fPHD+KBIxTtv4f6QLJrf0hUvzKlfjPo7asGkHm35Roqc0lZx8/uhn6r9uhSr0Tj8
         dJDgnF0aiGppe9vpSYquk2/jnZImFdx+JwdvFI9/55Mdnivtlou4R3XeXrYwCoDz+Y9o
         yG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f/WHbYA2W20EwH5kFJ5YtsYLV87jgfdE0G0OEkksJgM=;
        b=RDNNRGxpkyFKFUamd8oy5T72GENX47L07l7Oma+/XlYd8/bM8vPM9lmqWJg/Jp1oG3
         8ThR1v+WNk2PVrmdjExG9XpXExs+2pVCSY1iVWt8d/unrlKlTS/aEqWwrxyWi1dkBrLH
         6iS1YcN1X2blN6qTClw0YdMTmWifTirfecpo0YMVLAtvlA9BJ7ZM2pJQt+EIgjP33HfW
         3UZGQtHFZt0uqrYsSVIOxkoA2MbBtFhHictIW32UjO25BTJUACkZaaXJmcVfshwetKLj
         t0wDI/Y7tW41pnyFLxl7pFtsq4yUmwoXOATTaTmVnlcFhc25O+HQMsx0CIWCuBnzl8U0
         uHsA==
X-Gm-Message-State: AOAM531f8MGQMnVwexYQKr/FUJwFyJymOa363jMmpqfygIfFyquImbg9
        ZDzISqoqjTjWEpWjWZVwV6nD1CPewi1XCmHQYdE=
X-Google-Smtp-Source: ABdhPJxVojatbKLe8QlKfMRQhh+xICVhA5Sb/jdiU/z1cc4rSKUWcTe+UzbGgti57gWdElBq2LGEnM4SF/N1Mwf3g+4=
X-Received: by 2002:a17:906:7247:: with SMTP id n7mr2531341ejk.105.1593177778777;
 Fri, 26 Jun 2020 06:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200420164304.28810-1-kwizart@gmail.com> <680b456a-b1ed-45f6-aa38-6ec49783af6d@nvidia.com>
In-Reply-To: <680b456a-b1ed-45f6-aa38-6ec49783af6d@nvidia.com>
From:   Nicolas Chauvet <kwizart@gmail.com>
Date:   Fri, 26 Jun 2020 15:22:47 +0200
Message-ID: <CABr+WT=Gy6vmB-GdCeR_q8ogB4b19LDqQV5mjNh5VvZ0BUJKig@mail.gmail.com>
Subject: Re: [RFC] PCI: tegra: Revert raw_violation_fixup for tegra124
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le lun. 20 avr. 2020 =C3=A0 20:16, Manikanta Maddireddy
<mmaddireddy@nvidia.com> a =C3=A9crit :
>
> Thank you Nicolas for identifying the patch which caused the CmpltTO.
>
> Little background on the fixup,
>  In the internal testing with dGPU on Tegra124, CmplTO is reported by
> dGPU. This happened because FIFO queue in AFI(AXI to PCIe) module
> get full by upstream posted writes. Back to back upstream writes
> interleaved with infrequent reads, triggers RAW violation and CmpltTO.
> This is fixed by reducing the posted write credits and by changing
> updateFC timer frequency. These settings are fixed after stress test.
>
> In the current case, RTL NIC is also reporting CmplTO. These settings
> seems to be aggravating the issue instead of fixing it.

Seems I've lost track of this  issue.

@Manikanta Maddireddy  Do you plan to have some time to work on this ?

If going with the revert I wonder if I need to revert more completely
the original patch ? Since only tegra124 used the raw_violation_fixup,
should I remove this case and the related function completely or leave
the code as is ? (there will be few unused functions maybe). Given
other fixup have been added at a later time, the full revert is less
trivial.

Right now this partial revert is enough to work reliably with the device.

Thanks for your advice.
I will send a non-RFC version then.
