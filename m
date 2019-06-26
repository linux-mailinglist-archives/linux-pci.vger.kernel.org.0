Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CE56E7D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZQOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 12:14:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40820 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZQOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 12:14:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so3081952otl.7
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XK0CaHJOVcsS/u0euQkBQYUAFEHomal+V6KfwmFuG+U=;
        b=l+5kJ6tokPJ98bH2NME9M/AQ27NvFMKuOsXn1/Bb6bOBzelrSngvtDZJXmVwZKzpKi
         qjSD/BPNZzWpZiBQzbopXZ4t+Owe9yGEnJZxcLTPAlrrPvnYO2K7gCbSAaaiJHFcBp4k
         rxUq8p1DHnLMI0fRDu2WCtVRP/OHmPtRFurCHJX0OhgjoUZQUqGECtXD/hiUSR9PPelH
         MnkCXYqaYmm4WKtHJZYWuY7L6Kj9qhni0KNGsJokbTzfJurnEEHErfJ69HKEvmfEeo+E
         N7IwPwAkdbg4plX6eEOz52RHtcXnuvonc5/m143W02YNIvHsz5xJAtpZFJ8Hrcf91kdm
         NShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XK0CaHJOVcsS/u0euQkBQYUAFEHomal+V6KfwmFuG+U=;
        b=bXILIXZVt1NL67onBlgrIyfuAp7fPStjBoG/bcENMnY/MmOfV69RcyrsaJIN/5TGlZ
         MXruzBw5AOryxcC6wbcbt64IevsduEGpJJAbfeolFgvTAz5+Pyat/hTtZTlHgrwg+Ok0
         QpbTzcO3vnG3GR+w3mbUOumJNiSZazL7lcJkT+Tv9y+4pOx6WWtCZGyojvIBQkn8SMoa
         MflYGKurpaC6seAZc/iVjLMiR6j7bP2Ob6unIFt+arXaD/2wMFukIbw8hBuwBhVhM5du
         MNUw+7Gd6Rc9ABqEOSH0LPTXp+odjH3ttJpFG3Fw+JAFWf2Ko/u2LtL0l+KalWoZYGFV
         mhog==
X-Gm-Message-State: APjAAAVU2mF8b8CncSQyJNN2Pcm8Y/Zrx9lriOYzfaMQiO7KwZ82V58V
        Y0Dpk2oDPw1gakUASKrxrLAT4qijd3EyxaiJCyf6ew==
X-Google-Smtp-Source: APXvYqxlK4A4nPLhfNez6panLCe0oG2uZ68rpjoeO+K9OBDO45YdiJCTPi2DLYKpN0RI7gOpjzzUX8DJkFMKIZ4j7YA=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr1155884otn.71.1561565683159;
 Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz> <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de> <20190625150053.GJ11400@dhcp22.suse.cz>
 <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
 <20190625190038.GK11400@dhcp22.suse.cz> <CAPcyv4hU13v7dSQpF0WTQTxQM3L3UsHMUhsFMVz7i4UGLoM89g@mail.gmail.com>
 <20190626054645.GB17798@dhcp22.suse.cz>
In-Reply-To: <20190626054645.GB17798@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jun 2019 09:14:32 -0700
Message-ID: <CAPcyv4jLK2F2UHqbwp4bCEiB7tL8sVsr775egKMmJvfZG+W+NQ@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 10:46 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 25-06-19 12:52:18, Dan Williams wrote:
> [...]
> > > Documentation/process/stable-api-nonsense.rst
> >
> > That document has failed to preclude symbol export fights in the past
> > and there is a reasonable argument to try not to retract functionality
> > that had been previously exported regardless of that document.
>
> Can you point me to any specific example where this would be the case
> for the core kernel symbols please?

The most recent example that comes to mind was the thrash around
__kernel_fpu_{begin,end} [1]. I referenced that when debating _GPL
symbol policy with J=C3=A9r=C3=B4me [2].

[1]: https://lore.kernel.org/lkml/20190522100959.GA15390@kroah.com/
[2]: https://lore.kernel.org/lkml/CAPcyv4gb+r=3D=3DriKFXkVZ7gGdnKe62yBmZ7xO=
a4uBBByhnK9Tzg@mail.gmail.com/
